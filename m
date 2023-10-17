Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 365217CC1B9
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 13:27:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234599AbjJQL1t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 07:27:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232134AbjJQL1r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 07:27:47 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F2B6B6
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 04:27:45 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 93A3E21C7B;
        Tue, 17 Oct 2023 11:27:43 +0000 (UTC)
Received: from suse.cz (dhcp108.suse.cz [10.100.51.108])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id EE5D62C5D6;
        Tue, 17 Oct 2023 11:27:42 +0000 (UTC)
Date:   Tue, 17 Oct 2023 13:27:42 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v2 3/4] printk: Skip unfinalized records in panic
Message-ID: <ZS5vrte2OZXcIc9L@alley>
References: <20231013204340.1112036-1-john.ogness@linutronix.de>
 <20231013204340.1112036-4-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231013204340.1112036-4-john.ogness@linutronix.de>
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
         RCPT_COUNT_FIVE(0.00)[5];
         DMARC_POLICY_QUARANTINE(1.50)[suse.com : No valid SPF, No valid DKIM,quarantine];
         VIOLATED_DIRECT_SPF(3.50)[];
         MX_GOOD(-0.01)[];
         NEURAL_HAM_SHORT(-1.00)[-1.000];
         RCVD_NO_TLS_LAST(0.10)[];
         FROM_EQ_ENVFROM(0.00)[];
         MID_RHS_NOT_FQDN(0.50)[];
         R_DKIM_NA(0.20)[];
         RCVD_COUNT_TWO(0.00)[2];
         MIME_TRACE(0.00)[0:+];
         BAYES_HAM(-3.00)[100.00%]
X-Spam-Score: 15.00
X-Rspamd-Queue-Id: 93A3E21C7B
X-Spam: Yes
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2023-10-13 22:49:39, John Ogness wrote:
> Normally a reader will stop once reaching an unfinalized record.
> However, when a panic happens, writers from other CPUs (or an
> interrupted context on the panic CPU) may have been writing a
> record and were unable to finalize it. The panic CPU will
> reserve/commit/finalize its panic records, but these will be
> located after the unfinalized records. This results in panic()
> not flushing the panic messages.
> 
> Add a special case to printk_get_next_message() to allow
> skipping over unfinalized records if on the panic CPU.
> 
> Also refine the documentation of the ringbuffer reading
> functions to clarify that failure may also be due to an
> unfinalized record.

Great catch!

It took me some time to think about various possible scenarios.
As a result, I suggest to update some comments, see below.

> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -2813,8 +2813,19 @@ static bool printk_get_next_message(struct printk_message *pmsg, u64 seq,
>  	else
>  		prb_rec_init_rd(&r, &info, outbuf, outbuf_sz);
>  
> -	if (!prb_read_valid(prb, seq, &r))
> -		return false;
> +	while (!prb_read_valid(prb, seq, &r)) {
> +		if (this_cpu_in_panic() && seq < prb_next_seq(prb)) {
> +			/*
> +			 * The record @seq is not finalized and there may be

"may be" is a bit misleading. If I count it correctly then there
"are" more records when seq < prb_next_seq().

> +			 * more records in the ringbuffer. Since this is the
> +			 * panic CPU, skip over the unfinalized record and
> +			 * try to read a finalized record that may follow.
> +			 */

It took me quite some time to understand whether this is right or not.
It is partly because the comment describes what the code does but it
does not describe the motivation and why it is safe. I wonder
if the following is better:

			/*
			 * Skip non-finalized records when emitting messages
			 * from panic CPU. They might never get finalized.
			 * Note that new messages printed on panic CPU
			 * are finalized when we are here.
			 */

But wait. Are the messages printed in panic context always finalized?
What about messages without the trailing newline printed?

Aha, they actually are finalized because prb_next_seq() would return sequence
number of the record in "desc_committed" state when there is
a message without newline and we skip only seq < prb_next_seq().
So I would update the comment, something like:

			/*
			 * Skip non-finalized records when emitting messages
			 * from panic CPU. They might never get	finalized.
			 *
			 * Note that new messages printed on panic CPU are
			 * finalized when we are here. The only exception
			 * might be the last message without trailing newline.
			 * But it would have the sequence number returned
			 * by prb_next_seq().
			 */

Sigh, it is long. But this is a quite tricky situation.

> +			seq++;
> +		} else {
> +			return false;
> +		}
> +	}
>  
>  	pmsg->seq = r.info->seq;
>  	pmsg->dropped = r.info->seq - seq;
> diff --git a/kernel/printk/printk_ringbuffer.c b/kernel/printk/printk_ringbuffer.c
> index 2dc4d5a1f1ff..1bbc008109ef 100644
> --- a/kernel/printk/printk_ringbuffer.c
> +++ b/kernel/printk/printk_ringbuffer.c
> @@ -1876,8 +1876,9 @@ static u64 prb_first_seq(struct printk_ringbuffer *rb)
>  }
>  
>  /*
> - * Non-blocking read of a record. Updates @seq to the last finalized record
> - * (which may have no data available).
> + * Non-blocking read of a record. Updates @seq to the record that was read
> + * (which may have no data available) or was attempted to be read (in case
> + * it was unfinalized or non-existent).

I am confused. Well, even the original message was confusing.
I think about describing it the following way.

  * On input, @seq defines the record which should be read. It might
  * be updated to a higher value when the requested record has already
  * been overwritten or when the record had empty data.
  *
  * On return, @seq value depends on the situation. It is:
  *
  *	- sequence number of the read record on success.
  *     - sequence number of the first found to-be-finalized record
  *	  when the input seq number was lower or equal to prb_next_seq().
  *	- the original value when @seq was invalid, bigger then prb_next_seq().

Sigh, the comment is hairy. Maybe you would find a more elegant way
to describe the variants.


BTW: The support for data-less records were added by the commit
     ("printk: ringbuffer: support dataless records"). It was
     needed to handle empty lines: printk("\n"). It is strange
     that we skip them instead of printing the empty line.

     It looks like a small bug. I might look a it if you agree
     that it looks like a bug.

>   *
>   * See the description of prb_read_valid() and prb_read_valid_info()
>   * for details.


Also I would update the above prb_next_seq():

--- a/kernel/printk/printk_ringbuffer.c
+++ b/kernel/printk/printk_ringbuffer.c
@@ -2012,8 +2012,8 @@ u64 prb_first_valid_seq(struct printk_ringbuffer *rb)
  * available records should be skipped.
  *
  * Context: Any context.
- * Return: The sequence number of the next newest (not yet available) record
- *         for readers.
+ * Return: The sequence number of the next newest (not yet finalized or
+ *	   non-existing) record for readers.
  */
 u64 prb_next_seq(struct printk_ringbuffer *rb)
 {

