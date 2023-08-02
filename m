Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D875576D344
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 18:05:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235326AbjHBQFK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 12:05:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232818AbjHBQFG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 12:05:06 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A147171B
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 09:05:05 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id ECACC21A3B;
        Wed,  2 Aug 2023 16:05:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1690992303; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Oaf9OiK+Z/3ZKNxgCRAgS8nishHk/qhpHK2g5tj/wZk=;
        b=sO0ovHXL1ZEriALtXGmGukvxHWrXWyA+OU2+lhR+G50C65KNZtabDzTaGhHY6JARXX7YfT
        3NWWklAMLLWhSEmM4XKjVGlSKRzo7cLSncFL3uLejB0x0Msq6LhwZFsBWb3JoTA1Y7eFMx
        9xIJLxC/26VMU44cto9UTLNWIyczShY=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C54EB13909;
        Wed,  2 Aug 2023 16:05:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id aXuCLa9+ymRVQAAAMHmgww
        (envelope-from <mhocko@suse.com>); Wed, 02 Aug 2023 16:05:03 +0000
Date:   Wed, 2 Aug 2023 18:05:02 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>,
        kernel test robot <lkp@intel.com>,
        Lecopzer Chen <lecopzer.chen@mediatek.com>,
        Pingfan Liu <kernelfans@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] watchdog/hardlockup: Avoid large stack frames in
 watchdog_hardlockup_check()
Message-ID: <ZMp+rgDT5jYhi/1p@dhcp22.suse.cz>
References: <20230731091754.1.I501ab68cb926ee33a7c87e063d207abf09b9943c@changeid>
 <ZMkBY7K3Dn04YQ65@dhcp22.suse.cz>
 <CAD=FV=V5hx7Zy-XMB=sPYcD_h-iP5VknmEoJwvw3Akd_1wDnRw@mail.gmail.com>
 <ZMkkNpYcaYPAMj0Z@dhcp22.suse.cz>
 <CAD=FV=Ujmyq-1GAvNJsrp=mj_Vg=9b6fmfMfkHq3+8ZQ5KiaRw@mail.gmail.com>
 <ZMoFWK0uGdneJYVc@dhcp22.suse.cz>
 <CAD=FV=XQMH8sun7XCXJNjOC7tP1yt8=mt1NG3f8Xm9-x5TJFsA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD=FV=XQMH8sun7XCXJNjOC7tP1yt8=mt1NG3f8Xm9-x5TJFsA@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 02-08-23 07:12:29, Doug Anderson wrote:
> Hi,
> 
> On Wed, Aug 2, 2023 at 12:27 AM Michal Hocko <mhocko@suse.com> wrote:
> >
> > On Tue 01-08-23 08:41:49, Doug Anderson wrote:
> > [...]
> > > Ah, I see what you mean. The one issue I have with your solution is
> > > that the ordering of the stack crawls is less ideal in the "dump all"
> > > case when cpu != this_cpu. We really want to see the stack crawl of
> > > the locked up CPU first and _then_ see the stack crawls of other CPUs.
> > > With your solution the locked up CPU will be interspersed with all the
> > > others and will be harder to find in the output (you've got to match
> > > it up with the "Watchdog detected hard LOCKUP on cpu N" message).
> > > While that's probably not a huge deal, it's nicer to make the output
> > > easy to understand for someone trying to parse it...
> >
> > Is it worth to waste memory for this arguably nicer output? Identifying
> > the stack of the locked up CPU is trivial.
> 
> I guess it's debatable, but as someone who has spent time staring at
> trawling through reports generated like this, I'd say "yes", it's
> super helpful in understanding the problem to have the hung CPU first.

Well, I have to admit that most lockdep splats I have dealt with
recently do not come with sysctl_hardlockup_all_cpu_backtrace so I
cannot really judge.

> Putting the memory usage in perspective:
> 
> * On a kernel built with a more normal number of max CPUs, like 256,
> this is only a use of 32 bytes of memory. That's 8 CPU instructions
> worth of memory.

Think of distribution kernels that many people use. E.g SLES kernel uses
8k CONFIG_NR_CPUS

> * Even on a system with the largest number of max CPUs we currently
> allow (8192), this is only a use of 1024 bytes of memory. Sure, that's
> a big chunk, but this is also something on our largest systems.

This is independent on the size of the machine if you are using
pre-built kernels.

> In any case, how about this. We only need the memory allocated if
> `sysctl_hardlockup_all_cpu_backtrace` is non-zero. I can hook in
> whenever that's changed (should be just at bootup) and then kmalloc
> memory then.

this is certainly better than the original proposal

> This really limits the extra memory to just cases when
> it's useful. Presumably on systems that are designed to run massively
> SMP they wouldn't want to turn this knob on anyway since it would spew
> far too much data. If you took a kernel compiled for max SMP, ran it
> on a machine with only a few cores, and wanted this feature turned on
> then at most you'd be chewing up 1K. In the average case this would
> chew up some extra memory (extra CPU instructions to implement the
> function take code space, extra overhead around kmalloc) but it would
> avoid the 1K chunk in most cases.
> 
> Does that sound reasonable?

If the locked up cpu needs to be first is a real requirement (and this
seems debateable) then sure why not. I do not feel strongly to argue one
way or the other, maybe others have an opinion on that.

> I guess my last alternative would be to keep the special case of
> tracing the hung CPU first (this is the most important part IMO) and
> then accept the double trace, AKA:

That sounds wrong.
 
> /* Try to avoid re-dumping the stack on the hung CPU if possible */
> if (cpu == this_cpu))
>   trigger_allbutself_cpu_backtrace();
> else
>   trigger_all_cpu_backtrace();
> 
> -Doug

-- 
Michal Hocko
SUSE Labs
