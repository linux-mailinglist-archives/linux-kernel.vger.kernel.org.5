Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAA627FEDBD
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 12:24:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345133AbjK3LYq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 06:24:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345030AbjK3LYo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 06:24:44 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2a07:de40:b251:101:10:150:64:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DA6810E3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 03:24:50 -0800 (PST)
Received: from relay2.suse.de (unknown [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 86D9F1FCEC;
        Thu, 30 Nov 2023 11:24:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1701343486; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4oVFW8h9423xjdPRuYYMsptzD2IYJVHqtzkS8w8luKs=;
        b=i0AVw4PmZIQZO1Gj1YqhvD0h2uT3/xIpPannzn8HIjgb/dXpd5zT2bRZPurjj+cLDe4LCG
        f1oPemKCBrb17MmJfooOe6os4BblMf78PZuPKSOVpJ1LWNgH9gaGJvUHGMmdMYGVsNsqZh
        uGRVJ9t9fiFMFuEQEWSVuDjazx80pdY=
Received: from suse.cz (pmladek.tcp.ovpn2.prg.suse.de [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id C95982C142;
        Thu, 30 Nov 2023 11:24:45 +0000 (UTC)
Date:   Thu, 30 Nov 2023 12:24:45 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Kent Overstreet <kent.overstreet@linux.dev>
Cc:     linux-kernel@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>,
        Mike Christie <michael.christie@oracle.com>,
        Zqiang <qiang1.zhang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] kthread: kthread_should_stop() checks if we're a kthread
Message-ID: <ZWhw_Q6T26e0pedm@alley>
References: <20231120221503.3378095-1-kent.overstreet@linux.dev>
 <ZWWzSZeyRuPDwBHZ@alley>
 <20231128174012.bfno4f3matn3d7cw@moria.home.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231128174012.bfno4f3matn3d7cw@moria.home.lan>
X-Spamd-Bar: +++++++++++++++++++
Authentication-Results: smtp-out2.suse.de;
        dkim=none;
        dmarc=fail reason="No valid SPF, No valid DKIM" header.from=suse.com (policy=quarantine);
        spf=fail (smtp-out2.suse.de: domain of pmladek@suse.com does not designate 149.44.160.134 as permitted sender) smtp.mailfrom=pmladek@suse.com
X-Rspamd-Server: rspamd2
X-Spamd-Result: default: False [19.00 / 50.00];
         RDNS_NONE(1.00)[];
         TO_DN_SOME(0.00)[];
         RWL_MAILSPIKE_GOOD(-1.00)[149.44.160.134:from];
         HFILTER_HELO_IP_A(1.00)[relay2.suse.de];
         HFILTER_HELO_NORES_A_OR_MX(0.30)[relay2.suse.de];
         RCPT_COUNT_FIVE(0.00)[6];
         MX_GOOD(-0.01)[];
         RCVD_NO_TLS_LAST(0.10)[];
         FROM_EQ_ENVFROM(0.00)[];
         R_DKIM_NA(2.20)[];
         MIME_TRACE(0.00)[0:+];
         BAYES_HAM(-3.00)[100.00%];
         RDNS_DNSFAIL(0.00)[];
         ARC_NA(0.00)[];
         R_SPF_FAIL(1.00)[-all];
         FROM_HAS_DN(0.00)[];
         DMARC_POLICY_QUARANTINE(1.50)[suse.com : No valid SPF, No valid DKIM,quarantine];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         FREEMAIL_ENVRCPT(0.00)[gmail.com];
         MIME_GOOD(-0.10)[text/plain];
         DKIM_SIGNED(0.00)[suse.com:s=susede1];
         VIOLATED_DIRECT_SPF(3.50)[];
         NEURAL_SPAM_LONG(3.50)[1.000];
         FUZZY_BLOCKED(0.00)[rspamd.com];
         MID_RHS_NOT_FQDN(0.50)[];
         FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,oracle.com,intel.com,linux-foundation.org];
         RCVD_IN_DNSWL_HI(-0.50)[149.44.160.134:from];
         HFILTER_HOSTNAME_UNKNOWN(2.50)[];
         RCVD_COUNT_TWO(0.00)[2]
X-Spam-Score: 19.00
X-Rspamd-Queue-Id: 86D9F1FCEC
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2023-11-28 12:40:12, Kent Overstreet wrote:
> On Tue, Nov 28, 2023 at 10:30:49AM +0100, Petr Mladek wrote:
> > Adding Andrew into Cc. He usually takes changes in kernel/kthread.c.
> > 
> > On Mon 2023-11-20 17:15:03, Kent Overstreet wrote:
> > > bcachefs has a fair amount of code that may or may not be running from a
> > > kthread (it may instead be called by a userspace ioctl); having
> > > kthread_should_stop() check if we're a kthread enables a fair bit of
> > > cleanup and makes it safer to use.
> > > 
> > > Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
> > > ---
> > >  kernel/kthread.c | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/kernel/kthread.c b/kernel/kthread.c
> > > index 1eea53050bab..fe6090ddf414 100644
> > > --- a/kernel/kthread.c
> > > +++ b/kernel/kthread.c
> > > @@ -155,7 +155,8 @@ void free_kthread_struct(struct task_struct *k)
> > >   */
> > >  bool kthread_should_stop(void)
> > >  {
> > > -	return test_bit(KTHREAD_SHOULD_STOP, &to_kthread(current)->flags);
> > > +	return (current->flags & PF_KTHREAD) &&
> > > +		test_bit(KTHREAD_SHOULD_STOP, &to_kthread(current)->flags);
> > >  }
> > >  EXPORT_SYMBOL(kthread_should_stop);
> > 
> > I agree that it makes the API more safe because &to_kthread(current)
> > is NULL when the process is not a kthread.
> > 
> > Well, I do not like the idea of quietly ignoring a misuse of
> > the kthread_*() API. I would personally prefer to do:
> 
> It's only a misuse in the most pedantic sense, IMO.
> 
> Is it ever possible that with this change calling kthread_should_stop()
> from a non-kthread could cause a problem?

Of course, calling the updated kthread_should_stop() won't
cause problems in non-kthread context.

But it would make it more complicated to check for misuse
in the future.

Q: Why is a check for misuse important?
A: It partly depends on the personal opinion. But in general, it
   prevents other problems.

Q: Is it worth it in this case?
A: I do not have strong opinion.


I have basically two concerns:

1. Consistent behavior:

   For example, kthread_use_mm() and kthread_unuse_mm() already
   warn about a misuse.


2. Understanding the code

   Unconditional use of kthread_should_stop() makes the feeling
   that the code is intended for kthread context. People, not
   familiar with the code might miss that it might run also
   in userspace process.

   And indeed, I have looked how kthread_should_stop() is
   used in bcachefs code. For example, bch2_move_ratelimit()
   seems to handle only the kthread context:

int bch2_move_ratelimit(struct moving_context *ctxt)
{
[...]
	if (ctxt->wait_on_copygc && !c->copygc_running) {
		bch2_trans_unlock_long(ctxt->trans);
		wait_event_killable(c->copygc_running_wq,
				    !c->copygc_running ||
				    kthread_should_stop());
	}


    Yes, wait_event_killable() is primary for userspace
    process. AFAIK, signals are not delivered to kthreads
    by default, see sig_task_ignored().

    But the code does not check return value so that
    it does not detect when usespace process calling
    this function was killed.


	do {
		delay = ctxt->rate ? bch2_ratelimit_delay(ctxt->rate) : 0;
[...]
		if (delay) {
[...]
			set_current_state(TASK_INTERRUPTIBLE);
		}
[...]
		if ((current->flags & PF_KTHREAD) && kthread_should_stop()) {
			__set_current_state(TASK_RUNNING);
			return 1;
		}

		if (delay)
			schedule_timeout(delay);
[...]
		} while (delay);

   Here, the do-while cycle returns early when the kthread gets
   stopped. But it does not check whether there is a pending
   signal when called from userspace process.

   IMHO, it would be better to make it clear that the function might
   be called from both kthread and userspace processes. Otherwise,
   someone could later replace wait_event_killable() to wait_event()
   because kthreads do not react to signals by default.

   Also it would be worth to make it more clear what code is for
   the kthread context and what is for the userspace context.
   And the following would make it more obvious:

	if (in_kthread) {
		// handle kthread_should_stop
	} else {
		// handle signal_pending()
	}

   IMPORTANT: If the function could return early because of signal
	then it might make sense to make the kthread call path
	more robust. The kthread should not return before another
	process called kthread_stop().

	I vaguely remember that it might cause some problems.
	I am not sure how big problems. Either the kthread would stay in
	a limbo state because nobody would read the exit
	code. Or the eventual kthread_stop() caller could
	blow up or something like this.


BTW: kthread_should_stop() is called in wait_event_killable()
     without PF_KTHREAD check so that it could probably blow up.


My experience says that it is far from trivial to handle kthread_stop(),
freezer, and signals correctly. IMHO, doing some implicit
NOPs do not help to get the right picture.

BTW: try_to_freeze() might cause a deadlock when a kthread_stop()
     caller waits for the kthread() return but the kthread()
     is blocked in __refrigerator().

     At least this is my understanding of the commit 8a32c441c1609f80e
     ("freezer: implement and use kthread_freezable_should_stop()").

     Maybe, __refrigerator() should check kthread_should_stop()
     for all kthreads. But maybe, it might break something else.


> > // define this in include/linux/kthread.h
> > static inline bool in_kthread(void)
> > {
> > 	return current->flags & PF_KTHREAD
> > }
> > 
> > // add WARN() into kthread_should_stop()
> > bool kthread_should_stop(void)
> > {
> > 	if (WARN_ON_ONCE(!in_kthread))
> > 		return false;
> > 
> > 	return test_bit(KTHREAD_SHOULD_STOP, &to_kthread(current)->flags);
> > }
> > EXPORT_SYMBOL(kthread_should_stop);

I like this solution because the warning is printed even when
KTHREAD_SHOULD_STOP is not set. It means that misuse might
be caught easily.

Anyway, I am going to let Andrew to do a final decision.

Best Regards,
Petr
