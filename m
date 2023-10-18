Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 119A97CDC5B
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 14:54:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230454AbjJRMye (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 08:54:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230355AbjJRMyc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 08:54:32 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4340A11F
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 05:54:29 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id DA0AC21862;
        Wed, 18 Oct 2023 12:54:27 +0000 (UTC)
Received: from suse.cz (pmladek.udp.ovpn2.prg.suse.de [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 778832C1DE;
        Wed, 18 Oct 2023 12:54:27 +0000 (UTC)
Date:   Wed, 18 Oct 2023 14:54:27 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v2 3/4] printk: Skip unfinalized records in panic
Message-ID: <ZS_Vg4vvT29LxWSD@alley>
References: <20231013204340.1112036-1-john.ogness@linutronix.de>
 <20231013204340.1112036-4-john.ogness@linutronix.de>
 <ZS5vrte2OZXcIc9L@alley>
 <87mswh6iwq.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87mswh6iwq.fsf@jogness.linutronix.de>
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
        none
X-Rspamd-Server: rspamd2
X-Spamd-Result: default: False [-4.00 / 50.00];
         REPLY(-4.00)[]
X-Spam-Score: -4.00
X-Rspamd-Queue-Id: DA0AC21862
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2023-10-17 23:31:25, John Ogness wrote:
> On 2023-10-17, Petr Mladek <pmladek@suse.com> wrote:
> >> --- a/kernel/printk/printk_ringbuffer.c
> >> +++ b/kernel/printk/printk_ringbuffer.c
> >> @@ -1876,8 +1876,9 @@ static u64 prb_first_seq(struct printk_ringbuffer *rb)
> >>  }
> >>  
> >>  /*
> >> - * Non-blocking read of a record. Updates @seq to the last finalized record
> >> - * (which may have no data available).
> >> + * Non-blocking read of a record. Updates @seq to the record that was read
> >> + * (which may have no data available) or was attempted to be read (in case
> >> + * it was unfinalized or non-existent).
> >
> > I am confused. Well, even the original message was confusing.
> > I think about describing it the following way.
> >
> >   * On input, @seq defines the record which should be read. It might
> >   * be updated to a higher value when the requested record has already
> >   * been overwritten or when the record had empty data.
> >   *
> >   * On return, @seq value depends on the situation. It is:
> >   *
> >   *	- sequence number of the read record on success.
> >   *     - sequence number of the first found to-be-finalized record
> >   *	  when the input seq number was lower or equal to prb_next_seq().
> >   *	- the original value when @seq was invalid, bigger then prb_next_seq().
> >
> > Sigh, the comment is hairy. Maybe you would find a more elegant way
> > to describe the variants.
> 
> Be careful. prb_next_seq() is only loosely related to
> _prb_read_valid(). I would not mention prb_next_seq() when describing
> _prb_read_valid(). There are situations where _prb_read_valid() could
> successfully read a record with a higher sequence number than
> prb_next_seq() would return. This is because prb_next_seq() is only best
> effort.

I see. I misunderstood the meaning of prb_next_seq().

Well, I would not say that "prb_next_seq() is only the best effort".
It has well defined meaning. It returns the sequence number
if the first not yet finalized record.

You are right, there might be many reserved records which are newer.
Some of these reserved records might get finalized before older ones.
This is why _prb_read_valid() might actually return the higher number
when anyone attempts to read records above prb_next_seq().

Wait! This means that your patch actually does not work. Here is the diff:

--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2815,8 +2815,19 @@ static bool printk_get_next_message(struct printk_message *pmsg, u64 seq,
 	else
 		prb_rec_init_rd(&r, &info, outbuf, outbuf_sz);
 
-	if (!prb_read_valid(prb, seq, &r))
-		return false;
+	while (!prb_read_valid(prb, seq, &r)) {
+		if (this_cpu_in_panic() && seq < prb_next_seq(prb)) {
+			/*
+			 * The record @seq is not finalized and there may be
+			 * more records in the ringbuffer. Since this is the
+			 * panic CPU, skip over the unfinalized record and
+			 * try to read a finalized record that may follow.
+			 */
+			seq++;
+		} else {
+			return false;
+		}
+	}
 
 	pmsg->seq = r.info->seq;
 	pmsg->dropped = r.info->seq - seq;

It skips the invalid reads only when seq < prb_next_seq(). But
prb_next_seq(prb) points to the 1st non-finalized record. And
all records with seq < prb_next_seq() must be finalized!


> For panic it is sufficient because panic() will commit finalized records
> after having stopped all other CPUs, so it will definitely update
> @prb->desc_ring.last_finalized_id and allow prb_next_seq() to point to
> the end of the panic messages. But for non-panic that is not the case.
> 
> I do not have a problem understanding my version of the comments.

Maybe, "hairy" is not the right word. Well, from my POV, the comment
is not clear enough. It says that it updates "seq" but it does not say
when and how.

And it is even wrong. I still believe that dataless records are
quietly skipped. Here is the code:

static bool _prb_read_valid(struct printk_ringbuffer *rb, u64 *seq,
			    struct printk_record *r, unsigned int *line_count)
{
	while ((err = prb_read(rb, *seq, r, line_count))) {
[...]
		} else if (err == -ENOENT) {
			/* Record exists, but no data available. Skip. */
			(*seq)++;

		} else {
	}
[...]
}

Note that "seq" is incremented and the cycle continues. It means
that it tries to read the next record. It does _not_ return
"true" when seeing dataless record, definitely.

  => it might modify "seq" and still return "false" when
     the original "seq" pointed to finalized dataless record.


> that it is just a brief internal comment. It also says:
> 
>  * See the description of prb_read_valid() and prb_read_valid_info()
>  * for details.

This does not help because these two functions do not describe
how the seq is modified. And there are clearly three possibilities
when it returns false:

    1. The record for the given seq number has not been finalized
       yet. In this case, it keeps "seq" as it was.

    2. The record for the given seq has been dataless. In this case
      it would try to advance seq until it finds a record with
      the data or not-yet-finalized one.

    3. The given seq number has been invalid, above the head.
       In this case, it keeps "seq" intact. So same as 1st case.

Note that "seq" was not updated in the 1st and 3rd case. But the
current comment suggests that it is updated.

Well, it might be updated in all situations when then given
seq pointed to an already overwritten record (below tail).


> And if you look at the kerneldoc of either of those functions you see:
> 
>  * On success, the reader must check r->info.seq to see which record was
>  * actually read. This allows the reader to detect dropped records.
>  *
>  * Failure means @seq refers to a not yet finalized or non-existing record.
> 
> Also note that @seq is never passed by reference from the external
> caller. It is only passed by reference to the helper function
> _prb_read_valid().
> 
> > BTW: The support for data-less records were added by the commit
> >      ("printk: ringbuffer: support dataless records"). It was
> >      needed to handle empty lines: printk("\n"). It is strange
> >      that we skip them instead of printing the empty line.
> 
> We do not skip them. That was the whole point of adding support for
> data-less records. ;-)
> 
> get_data() returns "" and @data_size=0
> 
> copy_data() returns true (but does not copy any data)
> 
> prb_read() returns true (we are assuming it is finalized)
> 
> _prb_read_valid() returns true

This is not true if I read the code correctly.

> prb_read_valid() return true
> 
> record_print_text() creates a string with prefix and adds "\n"
> 
> printk_get_next_message() returns something to print

Best Regards,
Petr

PS: Sigh, I know that my comments looked like nitpicking. I had big inner
    fight whether it was worth it or I was just burning my and others
    time. But it seems that it helped for find many subtle problems
    in the end. Or am I still missing something?

