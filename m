Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7761D806AEE
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 10:42:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377200AbjLFJmj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 04:42:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbjLFJmg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 04:42:36 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2a07:de40:b251:101:10:150:64:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB81DB9
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 01:42:42 -0800 (PST)
Received: from relay2.suse.de (unknown [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 8692121ECC;
        Wed,  6 Dec 2023 09:42:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1701855756; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=O1QvXJzrYPxwf/jH/dMEoBbUwymUHFJ9jHtCqg5uIqo=;
        b=Xz3fQ3HaTVchPQaxJ5uQVf8AtNeJJ7BDbinSE4auHPap4FApReCjkwLHZxRoorx1NSlBna
        MOt72hAjgqljqkuoQskwOCIfdALQpB+v5SYZCYv/YsNKOnpRlrDH25svyG65i6ucAo6mR/
        bGMkEXbONVyH2BcCWtJ/zgMkejGRuik=
Received: from suse.cz (unknown [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 3A8A22C153;
        Wed,  6 Dec 2023 09:42:31 +0000 (UTC)
Date:   Wed, 6 Dec 2023 10:42:31 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Hillf Danton <hdanton@sina.com>,
        syzbot <syzbot+186b55175d8360728234@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        John Ogness <john.ogness@linutronix.de>,
        Waiman Long <longman@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [kernel?] possible deadlock in stack_depot_put
Message-ID: <ZXBCB2Gv1O-1-T6f@alley>
References: <000000000000784b1c060b0074a2@google.com>
 <20231205113107.1324-1-hdanton@sina.com>
 <317e077b-71a7-4112-a7d0-5c49efce4f39@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <317e077b-71a7-4112-a7d0-5c49efce4f39@I-love.SAKURA.ne.jp>
X-Spam-Score: 27.14
X-Spamd-Result: default: False [27.14 / 50.00];
         RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[149.44.160.134:from];
         RDNS_NONE(1.00)[];
         TO_DN_SOME(0.00)[];
         RWL_MAILSPIKE_GOOD(0.00)[149.44.160.134:from];
         HFILTER_HELO_IP_A(1.00)[relay2.suse.de];
         HFILTER_HELO_NORES_A_OR_MX(0.30)[relay2.suse.de];
         MX_GOOD(-0.01)[];
         RCPT_COUNT_SEVEN(0.00)[9];
         RCVD_NO_TLS_LAST(0.10)[];
         FROM_EQ_ENVFROM(0.00)[];
         R_DKIM_NA(0.00)[];
         MIME_TRACE(0.00)[0:+];
         SUBJECT_HAS_QUESTION(0.00)[];
         RDNS_DNSFAIL(0.00)[];
         ARC_NA(0.00)[];
         R_SPF_FAIL(1.00)[-all];
         FROM_HAS_DN(0.00)[];
         DMARC_POLICY_QUARANTINE(1.50)[suse.com : No valid SPF, No valid DKIM,quarantine];
         FREEMAIL_ENVRCPT(0.00)[sina.com];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         TAGGED_RCPT(0.00)[186b55175d8360728234];
         MIME_GOOD(-0.10)[text/plain];
         NEURAL_SPAM_SHORT(2.86)[0.952];
         DKIM_SIGNED(0.00)[suse.com:s=susede1];
         VIOLATED_DIRECT_SPF(3.50)[];
         NEURAL_SPAM_LONG(3.48)[0.996];
         DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:url];
         FUZZY_BLOCKED(0.00)[rspamd.com];
         MID_RHS_NOT_FQDN(0.50)[];
         FREEMAIL_CC(0.00)[sina.com,syzkaller.appspotmail.com,vger.kernel.org,infradead.org,linutronix.de,redhat.com,linux-foundation.org,googlegroups.com];
         HFILTER_HOSTNAME_UNKNOWN(2.50)[];
         SUSPICIOUS_RECIPS(1.50)[];
         RCVD_COUNT_TWO(0.00)[2]
X-Spamd-Bar: +++++++++++++++++++++++++++
X-Rspamd-Server: rspamd1
Authentication-Results: smtp-out1.suse.de;
        dkim=none;
        dmarc=fail reason="No valid SPF, No valid DKIM" header.from=suse.com (policy=quarantine);
        spf=fail (smtp-out1.suse.de: domain of pmladek@suse.com does not designate 149.44.160.134 as permitted sender) smtp.mailfrom=pmladek@suse.com
X-Rspamd-Queue-Id: 8692121ECC
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2023-12-05 21:00:46, Tetsuo Handa wrote:
> On 2023/12/05 20:31, Hillf Danton wrote:
> > Unlike down_trylock(), mutex_trylock() is unable to trigger any lockdep
> > warning, so why is a binary semaphore prefered over mutex?
> 
> The mutex has limitations which makes it impossible to use for console lock.
> 
> https://elixir.bootlin.com/linux/v6.7-rc4/source/kernel/locking/mutex.c#L537

In particular, mutexes can't be acquired in an interrupt context not even
via mutex_trylock().

> By the way, this is a KASAN bug saying "refcount_t: underflow; use-after-free.".
> Possibly a candidate for printk_deferred_enter() user?

In practice, it would mean adding

	printk_deferred_enter()
	printk_deferred_exit()

around the KASAN/stackdepot code which might be called in any context
and might print a message. For example, see show_one_worker_pool().

It should be used only when really needed because it reduces the
chance to see the messages.

But honestly, I do not see a better solution. printk_deferred() is
used on many locations inside the scheduler to avoid these deadlocks
between console_sem and rq->lock.

It should be solved by the printk rework introducing per-console
locks. It might eventually allow to get rid of console_sem
completely. But it might be a long ride until all console
drivers get converted.

Best Regards,
Petr
