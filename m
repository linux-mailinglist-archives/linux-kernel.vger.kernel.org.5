Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 656D07E54BB
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 12:09:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344259AbjKHLJE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 06:09:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjKHLJC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 06:09:02 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29A0D186
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 03:09:00 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1699441737;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/9frZEkbYti4SPFm3gs1C2FC6vGu6r4Wj0LGB/iG23k=;
        b=kA99J7Nib6NUh+FF88jn21BkhUxV/zXwDNst5UWwj53gPsH1tii35i1Q5RkPvka/ABUPDA
        rgL1h8XyU/sLfHSZwguKTZTUnVJDVGQZUZ3jZUrN4Ltwn5UZg69ciJjIMQOwylA1ILoAEI
        sdhP900BJg4DbuINiFq/xVgAv7ySBJ+TMVGdRwuRu1upoLeXsqKMwrNCaSq1Ln/4YUDFgx
        jzclIwUsfH2I0HKqtRlR7BD4FLlfyy3WGqjFAB1Qo5WjISt2YYQBrVr9bFZhNRFIW4rk2H
        a9QrvfRby//LbZThOg/JvAJrWwIjZkKUsAZ81V2LZwFRUeUynF5dugMg/iEi8Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1699441737;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/9frZEkbYti4SPFm3gs1C2FC6vGu6r4Wj0LGB/iG23k=;
        b=tEkh049got+CEe2byYBEngXapEwMqmX5Wl/92bvP9DHeZmMUX/k3RZE9t3cxR7VLFySjyx
        OBPVEyfZX6NgiCAg==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v2 6/9] printk: Wait for all reserved records
 with pr_flush()
In-Reply-To: <20231106210730.115192-7-john.ogness@linutronix.de>
References: <20231106210730.115192-1-john.ogness@linutronix.de>
 <20231106210730.115192-7-john.ogness@linutronix.de>
Date:   Wed, 08 Nov 2023 12:14:54 +0106
Message-ID: <87h6lwcxix.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-11-06, John Ogness <john.ogness@linutronix.de> wrote:
> diff --git a/kernel/printk/printk_ringbuffer.c b/kernel/printk/printk_ringbuffer.c
> index 7c121fd68330..dc83569d3a3a 100644
> --- a/kernel/printk/printk_ringbuffer.c
> +++ b/kernel/printk/printk_ringbuffer.c
> @@ -2012,6 +2012,102 @@ static u64 prb_first_seq(struct printk_ringbuffer *rb)
>  	return seq;
>  }
>  
> +/**
> + * prb_next_reserve_seq() - Get the sequence number after the most recently
> + *                  reserved record.
> + *
> + * @rb: The ringbuffer to get the sequence number from.
> + *
> + * This is the public function available to readers to see what sequence
> + * number will be assigned to the next reserved record.
> + *
> + * Note that depending on the situation, this value can be equal to or
> + * higher than the sequence number returned by prb_next_seq().
> + *
> + * Context: Any context.
> + * Return: The sequence number that will be assigned to the next record
> + *         reserved.
> + */
> +u64 prb_next_reserve_seq(struct printk_ringbuffer *rb)
> +{
> +	struct prb_desc_ring *desc_ring = &rb->desc_ring;
> +	unsigned long last_finalized_id;
> +	atomic_long_t *state_var;
> +	u64 last_finalized_seq;
> +	unsigned long head_id;
> +	struct prb_desc desc;
> +	unsigned long diff;
> +	struct prb_desc *d;
> +	int err;
> +
> +	/*
> +	 * It may not be possible to read a sequence number for @head_id.
> +	 * So the ID of @last_finailzed_seq is used to calculate what the
> +	 * sequence number of @head_id will be.
> +	 */
> +
> +try_again:
> +	last_finalized_seq = desc_last_finalized_seq(desc_ring);
> +
> +	/*
> +	 * @head_id is loaded after @last_finalized_seq to ensure that it is
> +	 * at or beyond @last_finalized_seq.
> +	 *
> +	 * Memory barrier involvement:
> +	 *
> +	 * If desc_last_finalized_seq:A reads from
> +	 * desc_update_last_finalized:A, then
> +	 * prb_next_reserve_seq:A reads from desc_reserve:D.
> +	 *
> +	 * Relies on:
> +	 *
> +	 * RELEASE from desc_reserve:D to desc_update_last_finalized:A
> +	 *    matching
> +	 * ACQUIRE from desc_last_finalized_seq:A to prb_next_reserve_seq:A
> +	 *
> +	 * Note: desc_reserve:D and desc_update_last_finalized:A can be
> +	 *       different CPUs. However, the desc_update_last_finalized:A CPU
> +	 *       (which performs the release) must have previously seen
> +	 *       desc_read:C, which implies desc_reserve:D can be seen.
> +	 */
> +	head_id = atomic_long_read(&desc_ring->head_id); /* LMM(prb_next_reserve_seq:A) */
> +
> +	d = to_desc(desc_ring, last_finalized_seq);
> +	state_var = &d->state_var;
> +
> +	/* Extract the ID, used to specify the descriptor to read. */
> +	last_finalized_id = DESC_ID(atomic_long_read(state_var));
> +
> +	/* Ensure @last_finalized_id is correct. */
> +	err = desc_read_finalized_seq(desc_ring, last_finalized_id, last_finalized_seq, &desc);
> +
> +	if (err == -EINVAL) {
> +		if (last_finalized_seq == 0) {
> +			/*
> +			 * @last_finalized_seq still contains its initial
> +			 * value. Probably no record has been finalized yet.
> +			 * This means the ringbuffer is not yet full and the
> +			 * @head_id value can be used directly (subtracting
> +			 * off its initial value).
> +			 *
> +			 * Because of hack#2 of the bootstrapping phase, the
> +			 * @head_id initial value must be handled separately.
> +			 */
> +			if (head_id == DESC0_ID(desc_ring->count_bits))
> +				return 0;
> +
> +			last_finalized_id = DESC0_ID(desc_ring->count_bits) + 1;
> +		} else {
> +			/* Record must have been overwritten. Try again. */
> +			goto try_again;
> +		}
> +	}
> +
> +	diff = head_id - last_finalized_id;
> +
> +	return (last_finalized_seq + diff);

This needs to be:

	return (last_finalized_seq + diff + 1);

because @last_finalized_seq and @head_id refer to existing records, but
this function should return the following (not yet existing) record.

John Ogness
