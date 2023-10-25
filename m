Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CB287D709A
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 17:16:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234948AbjJYPQR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 11:16:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232469AbjJYPQO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 11:16:14 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 153479C
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 08:16:11 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 367B521DEB;
        Wed, 25 Oct 2023 15:16:09 +0000 (UTC)
Received: from suse.cz (pmladek.udp.ovpn2.prg.suse.de [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 719012D3AC;
        Wed, 25 Oct 2023 15:16:08 +0000 (UTC)
Date:   Wed, 25 Oct 2023 17:16:08 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Mukesh Ojha <quic_mojha@quicinc.com>,
        Chunlei Wang <chunlei.wang@mediatek.com>
Subject: Re: [RFC PATCH printk v1] printk: ringbuffer: Do not skip
 non-finalized with prb_next_seq()
Message-ID: <ZTkxOJbDLPy12n41@alley>
References: <20231019132545.1190490-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231019132545.1190490-1-john.ogness@linutronix.de>
X-Spamd-Bar: +++++++++++++++
Authentication-Results: smtp-out1.suse.de;
        dkim=none;
        dmarc=fail reason="No valid SPF, No valid DKIM" header.from=suse.com (policy=quarantine);
        spf=fail (smtp-out1.suse.de: domain of pmladek@suse.com does not designate 149.44.160.134 as permitted sender) smtp.mailfrom=pmladek@suse.com
X-Rspamd-Server: rspamd2
X-Spamd-Result: default: False [15.00 / 50.00];
         ARC_NA(0.00)[];
         R_SPF_FAIL(1.00)[-all];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         NEURAL_HAM_LONG(-3.00)[-1.000];
         MIME_GOOD(-0.10)[text/plain];
         RWL_MAILSPIKE_GOOD(0.00)[149.44.160.134:from];
         DMARC_POLICY_QUARANTINE(1.50)[suse.com : No valid SPF, No valid DKIM,quarantine];
         VIOLATED_DIRECT_SPF(3.50)[];
         MX_GOOD(-0.01)[];
         NEURAL_HAM_SHORT(-1.00)[-1.000];
         RCPT_COUNT_SEVEN(0.00)[7];
         RCVD_NO_TLS_LAST(0.10)[];
         FROM_EQ_ENVFROM(0.00)[];
         R_DKIM_NA(0.20)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_COUNT_TWO(0.00)[2];
         MID_RHS_NOT_FQDN(0.50)[];
         BAYES_HAM(-3.00)[100.00%]
X-Spam-Score: 15.00
X-Rspamd-Queue-Id: 367B521DEB
X-Spam: Yes
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

there seems to be missing word in the subject:

    s/non-finalized/non-finalized records/

On Thu 2023-10-19 15:31:45, John Ogness wrote:
> Commit f244b4dc53e5 ("printk: ringbuffer: Improve prb_next_seq()
> performance") introduced an optimization for prb_next_seq() by
> using best-effort to track recently finalized records. However,
> the order of finalization does not necessarily match the order
> of the records. This can lead to prb_next_seq() returning
> higher than desired sequence numbers, which results in the
> reader skipping over records that are not yet finalized. From
> the reader's perspective it results in messages never being
> seen.

IMHO, "messages never being seen" is too strong. Also it seems
to be more tricky than it might look.

I have found only one (or two) scenarios where the messages might
really get lost.

1. It might happen when real console is replacing a boot console.
   The real console is initialized with the value returned
   by prb_next_seq(). And the boot console might not be able
   to flush earlier non-finalized records.

   But it is more complicated because console_unlock() tries
   hard to flush the early console before it is removed.

   So it might happen only when console_init_seq() sees higher
   prb_next_seq() and console_unlock() sees lower prb_next_seq().


2. The other scenario is based on the fact that console_unlock()
   or pr_flush() might see lower prb_next_seq() than the last
   reserved record. It means that they might not flush all
   pending records.

   In this case, the messages will be lost forever only when
   the system dies before doing another flush later.

   But wait! This is actually the opposite case. pr_flush()
   and console_unlock() might miss the messages when
   they see too low prb_next_seq().

   Important: This problem existed since introducing
	      the lockless ring buffer!

   The question is. Should pr_flush() and console_unlock()
   wait until all registered messages get finalized?

   It would need to ignore only the last record when it
   is not finalized because it might be a continuous line.


My opinion:

I would do the change proposed by this patch for now. With some
changes suggested below.

The commit message should say that it restores the prb_next_seq() behavior
before the commit f244b4dc53e5 ("printk: ringbuffer: Improve prb_next_seq()
performance").

In particular, prb_next_seq() will guarantee that all records
with a lower sequence number have been finalized. They can be
read except for the already overwritten ones.

Regarding, the flushing behavior. For now, I would rather keep
the historic behavior where only messages with seq < prb_next_seq()
are handled and do not wait on the reserved ones.

Waiting for reserved but not-yet-finalized records might be tricky
and might even cause livelocks or deadlocks. We might always
improve the situation when there are problems in the real life.

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

I would add some details about what expect from this value. Something
like:

 * @last_finalized_seq value guarantees that all records up to this
 * sequence number are finalized and might be read. The only exception
 * are too old records which have already been overwritten.
 *
 * Also it is guaranteed that the value can only grow.
 *
 * But it is just a best effort. There is _no_ synchronization between
 * writers finalizing records and @last_finalized_seq updates. The result
 * might be a lower value because updaters might not see finalized
 * records from other CPUs.
 *
 * There is _no_ easy way to serialize these two operations. It would
 * require to remember two values which might be called handled in:
 *
 *   @last_finalized_id in desc_make_final()
 *   @last_readable_seq in desc_update_last_readable_seq()
 *
 * and these two values would need to be updated atomically together
 * so that only the last updater of the @id part would be allowed
 * to update the @seq part. Also it would require a barrier so
 * that each writer would see the finalized state from other
 * writers whom updated the @id part earlier.
 *
 * Summary:
 *
 * This value might be used by readers only to check the last
 * readable seq number at the given time. They must count with
 * the fact that new records might appear at any time.
 *
 * Beware that this value is not increased with every finalized
 * record. It stays the same when there are not-yet-finalized
 * records with lower sequence number.
 *
 * In particular, it does not guarantee that readers woken
 * via wake_up_klogd would be able to flush all messages
 * up to the one just stored by vprintk_store(). For example,
 * it does not guarantee that console_unlock() would flush
 * all pending messages.
 */

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
> +		if (atomic_long_try_cmpxchg_relaxed(&desc_ring->last_finalized_seq,
> +						    &oldval, newval)) {
> +			prev_seq = seq;
> +		} else {
> +			prev_seq = __ulseq_to_u64seq(oldval);
> +		}
> +
> +		seq = prev_seq + 1;
> +	}

I agree that this might be optimized. I think about reducing the
number of cmpxchg even more, something like:

static void desc_update_last_finalized(struct prb_desc_ring *desc_ring)
{
	struct prb_desc_ring *desc_ring = &rb->desc_ring;
	u64 prev_seq = desc_last_finalized_seq(desc_ring);
	u64 seq = prev_seq;

try_again:
	while (_prb_read_valid(rb, &seq, NULL, NULL))
		seq++;

	if (seq == prev_seq)
		return;

	oldval = __u64seq_to_ulseq(prev_seq);
	newval = __u64seq_to_ulseq(seq);

	if (!atomic_long_try_cmpxchg_relaxed(&desc_ring->last_finalized_seq,
					     &oldval, newval)) {
		prev_seq = seq;
		goto try_again;
	}
}


> +}
> +
>  /*
>   * Attempt to finalize a specified descriptor. If this fails, the descriptor
>   * is either already final or it will finalize itself when the writer commits.
>   */
> -static void desc_make_final(struct prb_desc_ring *desc_ring, unsigned long id)
> +static void desc_make_final(struct printk_ringbuffer *rb, unsigned long id)

It looks to me that we could keep passing desc_ring as the parameter.
I guess that passing "rb" was needed only by some iteration of the patch.

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

I feel that we need a read barrier here. It should be between the above

	atomic_long_read(&desc_ring->last_finalized_seq))

and the below

	while (_prb_read_valid(rb, &seq, NULL, NULL))
		seq++;

It should make sure that the _prb_read_valid() will see all messages
finalized which were seen finalized by the CPU updating
desc_ring->last_finalized_seq.

Hmm, I am not sure about the counter part. I tried many variants when I
was discovering the races described above. And I have got lost a bit.
And I feel quite tired to be more confident with any proposal.

My best guess is that we should replace:

   atomic_long_try_cmpxchg_relaxed(&desc_ring->last_finalized_seq,
				     &oldval, newval))


with

   atomic_long_try_cmpxchg(&desc_ring->last_finalized_seq,
			   &oldval, newval))

so that it would work as the full barrier.


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

Best Regards,
Petr
