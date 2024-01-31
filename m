Return-Path: <linux-kernel+bounces-46363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A57C5843E98
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 12:39:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 73FDEB2F8B9
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 11:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9B626D1BA;
	Wed, 31 Jan 2024 11:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Ckom5FKj"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA65E69E08
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 11:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706700978; cv=none; b=b0Qt2gHjxqSnpxaRzeHUUQnkhC3s92FZ35MljUmGwv4N6YAKiosgahO/G5Wj+bwkNvq3TtxN2viTAglhDzJfwLLcCAcXVcUa7u1GLxLnK8JNqfQQWht2siH4r2VOOfotsmMm1ZmDGunH0aCZVaop0DMiaz7JnasZlHvEIRTk7PM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706700978; c=relaxed/simple;
	bh=m5bL0KC8TvCh2kJXM6YwLLKVOxfwdwnlcnUSqi+6FaE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bneIuupMe6Mrz7l0ruYSPjKhPD5rHGYQlRY2Mh5veRyvvgt3xoUdcefil5ojArm37TbXqpiM8DAb1A6zw4AvTKMk9mZ7eW0o+rxdA3mrOeDGrVOnheqdjZYmCZ6M24CXKIFszvu9o6yl7wPvxbMbUZavRohcZP/TDZzIZPDAdyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Ckom5FKj; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2d0600551ebso16378931fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 03:36:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1706700974; x=1707305774; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7XdbiS1c20Gn5X+4te6mRJw+r6hSLX/Dkvt91s0vGVc=;
        b=Ckom5FKje76yMgszKSEyIWfyH+AzOBpedDAK4chEho6+7DsW/1gZbbk071QYTGgbu7
         UsI7TlYksnxSnPV4Mno5gI/qH5zcXGSR4jPtsbVhjDhJvNJibRsz8vteLAvipcKr3Sj2
         XA7L9VhHaJhDqqUpfx7uBCpLYUU6de0Ok819Zl2VYZoIBK9cBJ/4KpqVrxG2vh4DKSgQ
         ta7fBj5nrc1k/f66ISZ4MjB8qExIAIXqX9OjHU+EYfodrc7X3vr4jNlLvIoTbJdXwT93
         oUoxhFRi2y3DxgB/YGaM3HOE6hqhsTuxcAy0hughFsE+P4AtLG+gOW6upPYAygnxsCuU
         jlAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706700974; x=1707305774;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7XdbiS1c20Gn5X+4te6mRJw+r6hSLX/Dkvt91s0vGVc=;
        b=AnwRDFsiwAhVBcU5fCVBi4XsBunICZjCsCJ27CvWXVWfVrObcldjqpAcok/esKMUcA
         vdOzcqeg1HlpAd+Jxvv3ooD/lsu1XyfBINCUZbshixRtHNdK3AgBdmzL/L9/uOF3H4XD
         qrwUNSDzOXMlATh+yLYvIeaen0PKHVOtH4qwJV0CAZYuEG2X1CYotm86jONrtsG7bvon
         X/vR32MjQw3i1LT64rzHZauYuVv4XFJOvd/ttJzVC+fkhff9KG8KodJ2KJL4BCWVv+X1
         WvdM3kcZ2AM+dh2Pqhpv4hq4Gv/jGgPgohVXGxyGIMBHFr/KhGx8p1xTwbkGsl/jPjBH
         ecLA==
X-Gm-Message-State: AOJu0YyU5NA0fN+f15U1uGlXYU0lbek/ZrKEbpX1WaUOw3pr3YRVjy3y
	1QkbHP5H1TlF/ljmOdeHmlBq3eDi+DZf3BKP/jitC2GSgHvsIhDvloZUdWUqHFdwteKNCAekR5t
	z
X-Google-Smtp-Source: AGHT+IH/WuG7yzwS5SM82xascfsBmEMFb/0n03U5SJThE8yXefUFPdkaWdA7woBUopvFZdYvDC2OUg==
X-Received: by 2002:a2e:9b8b:0:b0:2cf:657e:7767 with SMTP id z11-20020a2e9b8b000000b002cf657e7767mr848888lji.50.1706700973695;
        Wed, 31 Jan 2024 03:36:13 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXTZl2/hImrhAup/BdwwOFVVJvNl1Dnekl4ZBumR1tZjTdVcZAdYEU9roxhxlLFkQVYAgQx57lcQz92vDIjRQIngQgCBUy/i4919TeApfYRQGl5mMT6Opbv6O94e9Z9IA1vRAAr4vSWLBMNh3pOf9mC1KS/oRg=
Received: from alley ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id di11-20020a056402318b00b0055ef0105f2fsm3504453edb.80.2024.01.31.03.36.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 03:36:13 -0800 (PST)
Date: Wed, 31 Jan 2024 12:36:11 +0100
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v3 09/14] printk: Wait for all reserved records
 with pr_flush()
Message-ID: <ZbowlkOVWiSgCxNX@alley>
References: <20231214214201.499426-1-john.ogness@linutronix.de>
 <20231214214201.499426-10-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231214214201.499426-10-john.ogness@linutronix.de>

On Thu 2023-12-14 22:47:56, John Ogness wrote:
> Currently pr_flush() will only wait for records that were
> available to readers at the time of the call (using
> prb_next_seq()). But there may be more records (non-finalized)
> that have following finalized records. pr_flush() should wait
> for these to print as well. Particularly because any trailing
> finalized records may be the messages that the calling context
> wants to ensure are printed.
> 
> Add a new ringbuffer function prb_next_reserve_seq() to return
> the sequence number following the most recently reserved record.
> This guarantees that pr_flush() will wait until all current
> printk() messages (completed or in progress) have been printed.
> 
> --- a/kernel/printk/printk_ringbuffer.c
> +++ b/kernel/printk/printk_ringbuffer.c
> @@ -1986,6 +1986,119 @@ u64 prb_first_seq(struct printk_ringbuffer *rb)
>  	return seq;
>  }
>  
> +/**
> + * prb_next_reserve_seq() - Get the sequence number after the most recently
> + *                  reserved record.
> + *
> + * @rb:  The ringbuffer to get the sequence number from.
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
> +	last_finalized_seq = desc_last_finalized_seq(rb);
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

Huh, it must have been a huge effort to pull all the pieces together.
It took me long time to check and understand it. And it looks right
to me.

The most tricky part is desc_reserve:D. It is a supper complicated
barrier which guarantees many things. But I think that there are
many more write barriers before the allocated descriptor reaches
finalized state. So that it should be easier to prove the correctness
here by other easier barriers.

To make it clear. I am all for keeping the above precise description
as is. I just think about adding one more human friendly note which
might help future generations to understand the correctness an easier way.
Something like:

	* Note: The above description might be hard to follow because
	*	desc_reserve:D is a multi-purpose barrier. But this is
	*	just the first barrier which makes sure that @head_id
	*	is updated before the reserved descriptor gets finalized
	*	and updates @last_finalized_seq.
	*
	*	There are more release barriers in between, especially,
	*	desc_reserve:F and desc_update_last_finalized:A. Also these make
	*	sure that the desc_last_finalized_seq:A acquire barrier allows
	*	to read @head_id related to @last_finalized_seq or newer.

In fact, the desc_update_last_finalized:A release and
desc_last_finalized_seq:A acquire barriers are enough to prove
that we read here @head_id related to @last_finalized_seq or newer.

Or maybe it is exactly what you described and my "human friendly"
description is too naive. I am still not completely familiar
with the "Memory barrier involvement:" and "Relies on:"
format.

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
> +			 * off the id value corresponding to seq=0).
> +			 */
> +
> +			/*
> +			 * Because of hack#2 of the bootstrapping phase, the
> +			 * @head_id initial value must be handled separately.
> +			 */
> +			if (head_id == DESC0_ID(desc_ring->count_bits))
> +				return 0;
> +
> +			/*
> +			 * The @head_id is initialized such that the first
> +			 * increment will yield the first record (seq=0).
> +			 * Therefore use the initial value +1 as the base to
> +			 * subtract from @head_id.
> +			 */
> +			last_finalized_id = DESC0_ID(desc_ring->count_bits) + 1;

It took me long time to understand the above code and comments. I
wonder if the following looks easier even for you:

	if (err == -EINVAL) {
		if (last_finalized_seq == 0) {
			/*
			 * No record has been finalized or even	reserved yet.
			 *
			 * The @head_id is initialized such that the first
			 * increment will yield the first record (seq=0).
			 * Handle it separately to avoid a negative @diff below.
			 */
			if (head_id == DESC0_ID(desc_ring->count_bits))
				return 0;

			/* One or more descriptors are already reserved. Use
			 * the descriptor ID of the first one (@seq=0) for
			 * the @diff below.
			 */
			last_finalized_id = DESC0_ID(desc_ring->count_bits) + 1;


> +		} else {
> +			/* Record must have been overwritten. Try again. */
> +			goto try_again;
> +		}
> +	}
> +
> +	/*
> +	 * @diff is the number of records beyond the last record available
> +	 * to readers.
> +	 */

This is kind of obvious from the code. Also it is not true when the
first record has not been finalized yet. The following might
be more useful:

	/* Diff of known descriptor IDs to compure releted sequence nubmers. */

> +	diff = head_id - last_finalized_id;
> +
> +	/*
> +	 * @head_id points to the most recently reserved record, but this
> +	 * function returns the sequence number that will be assigned to the
> +	 * next (not yet reserved) record. Thus +1 is needed.
> +	 */
> +	return (last_finalized_seq + diff + 1);
> +}
> +
>  /*
>   * Non-blocking read of a record.
>   *

BTW: It came to my mind whether the logic might be more straightforward
     if we store desc_ring->next_finalized_seq instead of @last_finalized_seq.

     Even the initial value vould be valid. Also the value is
     used only in prb_next_reserve_seq() and prb_next_seq() where
     we need to start with this value anyway.

     Note that prb_next_seq() actually does not need to try _prb_read_valid()
     for @last_finalized_seq. It should always be valid unless
     the record has been already overwritten. In which case,
     there should be a newer readable record.

     Well, it is just an idea. I am not completely sure that it
     would make the logic easier to follow. The current code is perfectly fine.


The patch is correct. Feel free to add:

Reviewed-by: Petr Mladek <pmladek@suse.com>

Well, it would be nice to update the comments if you liked the proposals.

Best Regards,
Petr

