Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A4EF7F7009
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 10:37:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232798AbjKXJhX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 04:37:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbjKXJhU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 04:37:20 -0500
X-Greylist: delayed 397 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 24 Nov 2023 01:37:26 PST
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2a07:de40:b251:101:10:150:64:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F34F8EA
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 01:37:26 -0800 (PST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id EF9371FB67;
        Fri, 24 Nov 2023 09:30:45 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C798713A98;
        Fri, 24 Nov 2023 09:30:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
        by imap1.dmz-prg2.suse.org with ESMTPSA
        id E3/PLEVtYGXOZgAAD6G6ig
        (envelope-from <mhocko@suse.com>); Fri, 24 Nov 2023 09:30:45 +0000
Date:   Fri, 24 Nov 2023 10:30:44 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        gaoxu <gaoxu2@hihonor.com>
Cc:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        yipengxiang <yipengxiang@hihonor.com>
Subject: Re: =?utf-8?B?5Zue5aSNOiBbUEFUQ0hdIG1tLG9v?=
 =?utf-8?B?bV9yZWFwZXI6?= avoid run queue_oom_reaper if task is not oom
Message-ID: <ZWBtRGCXbz49UeXa@tiehlicka>
References: <400d13bddb524ef6af37cb2220808c75@hihonor.com>
 <ZV8SenfRYnkKwqu6@tiehlicka>
 <242025e9a8c84f6b96ba3f180ea01be9@hihonor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <242025e9a8c84f6b96ba3f180ea01be9@hihonor.com>
Authentication-Results: smtp-out2.suse.de;
        none
X-Rspamd-Server: rspamd1
X-Spam-Level: 
X-Rspamd-Queue-Id: EF9371FB67
X-Spam-Score: -4.00
X-Spamd-Result: default: False [-4.00 / 50.00];
         REPLY(-4.00)[]
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 24-11-23 03:15:46, gaoxu wrote:
[...]
> >> [3701:11_see]Unable to handle kernel NULL pointer dereference at 
> >> virtual address 0000000000000328 [3701:11_see]user pgtable: 4k pages, 
> >> 39-bit VAs, pgdp=00000000821de000 [3701:11_see][0000000000000328] 
> >> pgd=0000000000000000,
> >> p4d=0000000000000000,pud=0000000000000000
> >> [3701:11_see]tracing off
> >> [3701:11_see]Internal error: Oops: 96000005 [#1] PREEMPT SMP 
> >> [3701:11_see]Call trace:
> >> [3701:11_see] queue_oom_reaper+0x30/0x170
> >
> > Could you resolve this offset into the code line please?
> Due to the additional code we added for log purposes, the line numbers may not correspond to the original Linux code.
> 
> static void queue_oom_reaper(struct task_struct *tsk)
> {
> 	/* mm is already queued? */
> 	if (test_and_set_bit(MMF_OOM_REAP_QUEUED, &tsk->signal->oom_mm->flags)) //a null pointer exception occurred
> 		return;

Did you manage to narrow it down to which of the dereference this
corresponds to? Is it tsk->signal == NULL or signal->oom_mm == NULL.
The faulting address doesn't match neither with my configs.

[...]

> >> --- a/mm/oom_kill.c
> >> +++ b/mm/oom_kill.c
> >> @@ -984,7 +984,7 @@ static void __oom_kill_process(struct task_struct *victim, const char *message)
> >>  	}
> >>  	rcu_read_unlock();
> >>  
> >> -	if (can_oom_reap)
> >> +	if (can_oom_reap && tsk_is_oom_victim(victim))
> >>  		queue_oom_reaper(victim);
> >
> > I do not understand. We always do send SIGKILL and call mark_oom_victim(victim); on victim task when reaching out here. How can tsk_is_oom_victim can ever be false?
> This is a low-probability issue, as it only occurred once during the monkey testing.
> I haven't been able to find the root cause either.

OK, was there any non-standard code running during this test?
In any case I do not see how this patch could be correct. If, for some
reason we managed to release the signal structure or something else then
we need to understand whether this is a locking or reference counting
issue. I do not really see how this would be possible. But this check
right here doesn't really make sense.

Andrew please drop the patch from your tree.
-- 
Michal Hocko
SUSE Labs
