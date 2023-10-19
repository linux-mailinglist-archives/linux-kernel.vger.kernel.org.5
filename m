Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DEB67CFB51
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 15:39:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346044AbjJSNjI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 09:39:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345991AbjJSNjG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 09:39:06 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E628D124
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 06:39:03 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1697722742;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LeXdmUaym8oLSyJY6ptmmoOg3CJyGh3RytEUJSMW1kU=;
        b=ySkj4UNZCiKRuipE6XIJlINtQQfdLDhe6jEfIZePuZBfCvQJJaWRpRCnunKzMipDIv1U+0
        isvC6OWVDN5iNZyPOxwTzG1/KP3GO+M2944G3k0ycVmpgICRWAYqS3VmNa4pPYQocpr6u7
        BoGJBAPtW5OXKTCXavsZ1hSWC1/tkdHECXzQyl7E2rsIRmXSAnEJLGpX7LtvmlLDeJ1bXS
        CwXv4qDGOVuijDDgUIEEjuOlMY5lLqSP1Im9c40YmNpY/CLwycsVjcZD2PtVGrSSw+z2L6
        Kq4MBQiYpQRWDGucZopnTeviN6XCg/T4wKhMwjIJbqEcGrpjTA5kFpEYFZtNJQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1697722742;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LeXdmUaym8oLSyJY6ptmmoOg3CJyGh3RytEUJSMW1kU=;
        b=ETce3lNOqLrPz+9iFChTrQ2j7wuXjb4KMs+PRLQrsOjeYAljucYAefaVQEdp9skcdDyS2w
        C8ZKVyRb+0xFuXDw==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Mukesh Ojha <quic_mojha@quicinc.com>,
        Chunlei Wang <chunlei.wang@mediatek.com>
Subject: Re: [RFC PATCH printk v1] printk: ringbuffer: Do not skip
 non-finalized with prb_next_seq()
In-Reply-To: <20231019132545.1190490-1-john.ogness@linutronix.de>
References: <20231019132545.1190490-1-john.ogness@linutronix.de>
Date:   Thu, 19 Oct 2023 15:45:00 +0206
Message-ID: <87mswe20ln.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INVALID_DATE_TZ_ABSURD,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some suggested changes.

On 2023-10-19, John Ogness <john.ogness@linutronix.de> wrote:
> diff --git a/kernel/printk/printk_ringbuffer.c b/kernel/printk/printk_ringbuffer.c
> index fde338606ce8..f9fbfa21c5b2 100644
> --- a/kernel/printk/printk_ringbuffer.c
> +++ b/kernel/printk/printk_ringbuffer.c
> @@ -1441,20 +1441,83 @@ bool prb_reserve_in_last(struct prb_reserved_entry *e, struct printk_ringbuffer
>  	return false;
>  }
>  
> +#ifdef CONFIG_64BIT
> +
> +#define __u64seq_to_ulseq(u64seq) (u64seq)
> +#define __ulseq_to_u64seq(ulseq) (ulseq)
> +
> +#else /* CONFIG_64BIT */
> +
> +static u64 prb_first_seq(struct printk_ringbuffer *rb);
> +
> +#define __u64seq_to_ulseq(u64seq) ((u32)u64seq)
> +static inline u64 __ulseq_to_u64seq(u32 ulseq)
> +{
> +	u64 rb_first_seq = prb_first_seq(prb);
> +	u64 seq;
> +
> +	/*
> +	 * The provided sequence is only the lower 32 bits of the ringbuffer
> +	 * sequence. It needs to be expanded to 64bit. Get the first sequence
> +	 * number from the ringbuffer and fold it.
> +	 */
> +	seq = rb_first_seq - ((u32)rb_first_seq - ulseq);
> +
> +	return seq;
> +}
> +
> +#endif /* CONFIG_64BIT */
> +
> +static u64 desc_last_finalized_seq(struct prb_desc_ring *desc_ring)
> +{
> +	unsigned long ulseq = atomic_long_read(&desc_ring->last_finalized_seq);
> +
> +	return __ulseq_to_u64seq(ulseq);
> +}
> +
> +static bool _prb_read_valid(struct printk_ringbuffer *rb, u64 *seq,
> +			    struct printk_record *r, unsigned int *line_count);
> +
> +/*
> + * Check if there are records directly following @last_finalized_seq that are
> + * finalized. If so, update @last_finalized_seq to the latest of these
> + * records. It is not allowed to skip over records that are not yet finalized.
> + */
> +static void desc_update_last_finalized(struct printk_ringbuffer *rb)
> +{
> +	struct prb_desc_ring *desc_ring = &rb->desc_ring;
> +	u64 prev_seq = desc_last_finalized_seq(desc_ring);
> +	u64 seq = prev_seq;
> +
> +	while (_prb_read_valid(rb, &seq, NULL, NULL)) {
> +		unsigned long oldval = __u64seq_to_ulseq(prev_seq);
> +		unsigned long newval = __u64seq_to_ulseq(seq);
> +

Generally there are not multiple CPUs racing to finalize records. So I
would add an extra check for the first loop (where seq == prev_seq) to
avoid the extra cmpxchg.

+		if (prev_seq == seq) {
+			; /* NOP */
+		} else

> +		if (atomic_long_try_cmpxchg_relaxed(&desc_ring->last_finalized_seq,
> +						    &oldval, newval)) {
> +			prev_seq = seq;
> +		} else {
> +			prev_seq = __ulseq_to_u64seq(oldval);
> +		}
> +
> +		seq = prev_seq + 1;
> +	}
> +}
> +
>  /*
>   * Attempt to finalize a specified descriptor. If this fails, the descriptor
>   * is either already final or it will finalize itself when the writer commits.
>   */
> -static void desc_make_final(struct prb_desc_ring *desc_ring, unsigned long id)
> +static void desc_make_final(struct printk_ringbuffer *rb, unsigned long id)
>  {
> +	struct prb_desc_ring *desc_ring = &rb->desc_ring;
>  	unsigned long prev_state_val = DESC_SV(id, desc_committed);
>  	struct prb_desc *d = to_desc(desc_ring, id);
>  
>  	atomic_long_cmpxchg_relaxed(&d->state_var, prev_state_val,
>  			DESC_SV(id, desc_finalized)); /* LMM(desc_make_final:A) */
>  
> -	/* Best effort to remember the last finalized @id. */
> -	atomic_long_set(&desc_ring->last_finalized_id, id);
> +	desc_update_last_finalized(rb);
>  }
>  
>  /**
> @@ -1550,7 +1613,7 @@ bool prb_reserve(struct prb_reserved_entry *e, struct printk_ringbuffer *rb,
>  	 * readers. (For seq==0 there is no previous descriptor.)
>  	 */
>  	if (info->seq > 0)
> -		desc_make_final(desc_ring, DESC_ID(id - 1));
> +		desc_make_final(rb, DESC_ID(id - 1));
>  
>  	r->text_buf = data_alloc(rb, r->text_buf_size, &d->text_blk_lpos, id);
>  	/* If text data allocation fails, a data-less record is committed. */
> @@ -1643,7 +1706,7 @@ void prb_commit(struct prb_reserved_entry *e)
>  	 */
>  	head_id = atomic_long_read(&desc_ring->head_id); /* LMM(prb_commit:A) */
>  	if (head_id != e->id)
> -		desc_make_final(desc_ring, e->id);
> +		desc_make_final(e->rb, e->id);
>  }
>  
>  /**
> @@ -1663,12 +1726,9 @@ void prb_commit(struct prb_reserved_entry *e)
>   */
>  void prb_final_commit(struct prb_reserved_entry *e)
>  {
> -	struct prb_desc_ring *desc_ring = &e->rb->desc_ring;
> -
>  	_prb_commit(e, desc_finalized);
>  
> -	/* Best effort to remember the last finalized @id. */
> -	atomic_long_set(&desc_ring->last_finalized_id, e->id);
> +	desc_update_last_finalized(e->rb);
>  }
>  
>  /*
> @@ -2017,33 +2077,19 @@ u64 prb_first_valid_seq(struct printk_ringbuffer *rb)
>  u64 prb_next_seq(struct printk_ringbuffer *rb)
>  {
>  	struct prb_desc_ring *desc_ring = &rb->desc_ring;
> -	enum desc_state d_state;
> -	unsigned long id;
>  	u64 seq;
>  
> -	/* Check if the cached @id still points to a valid @seq. */
> -	id = atomic_long_read(&desc_ring->last_finalized_id);
> -	d_state = desc_read(desc_ring, id, NULL, &seq, NULL);
> +	seq = __ulseq_to_u64seq(atomic_long_read(&desc_ring->last_finalized_seq));

There is now a function for this. No need to open code it.

+	seq = desc_last_finalized_seq(desc_ring);

>  
> -	if (d_state == desc_finalized || d_state == desc_reusable) {
> -		/*
> -		 * Begin searching after the last finalized record.
> -		 *
> -		 * On 0, the search must begin at 0 because of hack#2
> -		 * of the bootstrapping phase it is not known if a
> -		 * record at index 0 exists.
> -		 */
> -		if (seq != 0)
> -			seq++;
> -	} else {
> -		/*
> -		 * The information about the last finalized sequence number
> -		 * has gone. It should happen only when there is a flood of
> -		 * new messages and the ringbuffer is rapidly recycled.
> -		 * Give up and start from the beginning.
> -		 */
> -		seq = 0;
> -	}
> +	/*
> +	 * Begin searching after the last finalized record.
> +	 *
> +	 * On 0, the search must begin at 0 because of hack#2
> +	 * of the bootstrapping phase it is not known if a
> +	 * record at index 0 exists.
> +	 */
> +	if (seq != 0)
> +		seq++;
>  
>  	/*
>  	 * The information about the last finalized @seq might be inaccurate.
> @@ -2085,7 +2131,7 @@ void prb_init(struct printk_ringbuffer *rb,
>  	rb->desc_ring.infos = infos;
>  	atomic_long_set(&rb->desc_ring.head_id, DESC0_ID(descbits));
>  	atomic_long_set(&rb->desc_ring.tail_id, DESC0_ID(descbits));
> -	atomic_long_set(&rb->desc_ring.last_finalized_id, DESC0_ID(descbits));
> +	atomic_long_set(&rb->desc_ring.last_finalized_seq, 0);
>  
>  	rb->text_data_ring.size_bits = textbits;
>  	rb->text_data_ring.data = text_buf;
> diff --git a/kernel/printk/printk_ringbuffer.h b/kernel/printk/printk_ringbuffer.h
> index 18cd25e489b8..3374a5a3303e 100644
> --- a/kernel/printk/printk_ringbuffer.h
> +++ b/kernel/printk/printk_ringbuffer.h
> @@ -75,7 +75,7 @@ struct prb_desc_ring {
>  	struct printk_info	*infos;
>  	atomic_long_t		head_id;
>  	atomic_long_t		tail_id;
> -	atomic_long_t		last_finalized_id;
> +	atomic_long_t		last_finalized_seq;
>  };
>  
>  /*
> @@ -259,7 +259,7 @@ static struct printk_ringbuffer name = {							\
>  		.infos		= &_##name##_infos[0],						\
>  		.head_id	= ATOMIC_INIT(DESC0_ID(descbits)),				\
>  		.tail_id	= ATOMIC_INIT(DESC0_ID(descbits)),				\
> -		.last_finalized_id = ATOMIC_INIT(DESC0_ID(descbits)),				\
> +		.last_finalized_seq = ATOMIC_INIT(0),						\
>  	},											\
>  	.text_data_ring = {									\
>  		.size_bits	= (avgtextbits) + (descbits),					\
>
> base-commit: a26f18f291f6c2eac6dac9faa12cc68fd1da5865
> -- 
> 2.39.2

John
