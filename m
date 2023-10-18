Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F317B7CE127
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 17:27:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231792AbjJRP1b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 11:27:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230444AbjJRP13 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 11:27:29 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 742EAF7
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 08:27:27 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 199AC1FD7C;
        Wed, 18 Oct 2023 15:27:26 +0000 (UTC)
Received: from suse.cz (pmladek.tcp.ovpn2.prg.suse.de [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id AF8FE2C23A;
        Wed, 18 Oct 2023 15:27:25 +0000 (UTC)
Date:   Wed, 18 Oct 2023 17:27:25 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v2 3/4] printk: Skip unfinalized records in panic
Message-ID: <ZS_5Xd7zPWvSHuqq@alley>
References: <20231013204340.1112036-1-john.ogness@linutronix.de>
 <20231013204340.1112036-4-john.ogness@linutronix.de>
 <ZS5vrte2OZXcIc9L@alley>
 <87mswh6iwq.fsf@jogness.linutronix.de>
 <ZS_Vg4vvT29LxWSD@alley>
 <874jio6o2y.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874jio6o2y.fsf@jogness.linutronix.de>
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
        none
X-Rspamd-Server: rspamd2
X-Spamd-Result: default: False [-4.00 / 50.00];
         REPLY(-4.00)[]
X-Spam-Score: -4.00
X-Rspamd-Queue-Id: 199AC1FD7C
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2023-10-18 15:51:57, John Ogness wrote:
> On 2023-10-18, Petr Mladek <pmladek@suse.com> wrote:
> > Wait! This means that your patch actually does not work. Here is the diff:
> >
> > --- a/kernel/printk/printk.c
> > +++ b/kernel/printk/printk.c
> > @@ -2815,8 +2815,19 @@ static bool printk_get_next_message(struct printk_message *pmsg, u64 seq,
> >  	else
> >  		prb_rec_init_rd(&r, &info, outbuf, outbuf_sz);
> >  
> > -	if (!prb_read_valid(prb, seq, &r))
> > -		return false;
> > +	while (!prb_read_valid(prb, seq, &r)) {
> > +		if (this_cpu_in_panic() && seq < prb_next_seq(prb)) {
> > +			/*
> > +			 * The record @seq is not finalized and there may be
> > +			 * more records in the ringbuffer. Since this is the
> > +			 * panic CPU, skip over the unfinalized record and
> > +			 * try to read a finalized record that may follow.
> > +			 */
> > +			seq++;
> > +		} else {
> > +			return false;
> > +		}
> > +	}
> >  
> >  	pmsg->seq = r.info->seq;
> >  	pmsg->dropped = r.info->seq - seq;
> >
> > It skips the invalid reads only when seq < prb_next_seq(). But
> > prb_next_seq(prb) points to the 1st non-finalized record. And
> > all records with seq < prb_next_seq() must be finalized!
> 
> Please take a look at prb_next_seq(). It _starts_ its search from:
> 
>     id = atomic_long_read(&desc_ring->last_finalized_id);

I see. And this this set in

static void desc_make_final(struct prb_desc_ring *desc_ring, unsigned long id)
{
[...]

	/* Best effort to remember the last finalized @id. */
	atomic_long_set(&desc_ring->last_finalized_id, id);
}

So it is the _last_ finalized id from the timing POV. If there are
more CPUs storing and finalizing the messages in parallel then
it might change forth and back. There might be earlier non-finalized
records and newer finalized ones.

It means that prb_next_seq() really is the best effort and
the description is not valid:

/**
 * prb_next_seq() - Get the sequence number after the last available record.
 *
 * @rb:  The ringbuffer to get the sequence number from.
 *
 * This is the public function available to readers to see what the next
 * newest sequence number available to readers will be.
 *
 * This provides readers a sequence number to jump to if all currently
 * available records should be skipped.

It is not guaranteed that it will be the last available record
because there might be newer already finalized records with
some non-finalized records in between.

Also it is not guaranteed that it will be the next record available
to readers because readers should stop on the 1st non-yet-finalized
record and prb_next_seq() might be behind.

It would be great to document these subtle details especially when
we are going to depend on them.

> For console_flush_on_panic(), @last_finalized_id will _always_ be set to
> the last finalized message of the panic messages, being higher than any
> non-finalized records that may exist. There are no other CPUs running
> except the panic CPU.

It is not guaranteed. It might be lower when some still running CPU
manages to finalize an earlier record and there are later
non-finalized records.

But you are right, there is a very high chance that it will point
behind the last message from panic() context sooner or later,
especially after CPUs get stopped.

Well, note that only NMI guarantees that CPUs get stopped. There
are still architectures which stop CPUs using normal interrupts.

> Unfortunately you are not reading the code correctly. (Or rather, you
> are being misled by comments because you incorrectly associate "not
> available to reader" to mean "valid record with an empty string".

You are right. Well, it is really hard to put all the pieces together
just by reading the code. And the unclear comments make it even worse.

Best Regards,
Petr
