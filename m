Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 299AA76E2CC
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 10:18:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233967AbjHCISE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 04:18:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233847AbjHCIRN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 04:17:13 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6A243A8C
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 01:12:16 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 7E62621901;
        Thu,  3 Aug 2023 08:12:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1691050335; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jCwNjlEPzwo3RqM6Rt46O7/xaBMXEl5SoX/GHbEUVNk=;
        b=fNh9Zu9fWa+sHYKqVsXEbll0njtoGVPbKKSizO4R4NJyTdEHrv2DnFp6WLrTg4iM1tI/oH
        pxx/HVRZTBrMsUPypbZX+LuFWByULmihI1T7D4frMpouZEjrUmLGkwUGUVGTbnNrIShquT
        Gm1CXoLu6GSdoK+esPWhjmbEOcFNY20=
Received: from suse.cz (pmladek.udp.ovpn2.prg.suse.de [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 1A1AA2C142;
        Thu,  3 Aug 2023 08:12:15 +0000 (UTC)
Date:   Thu, 3 Aug 2023 10:12:12 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kernel test robot <lkp@intel.com>,
        Lecopzer Chen <lecopzer.chen@mediatek.com>,
        Pingfan Liu <kernelfans@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] watchdog/hardlockup: Avoid large stack frames in
 watchdog_hardlockup_check()
Message-ID: <ZMthXBpLzbbysTe5@alley>
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2023-08-02 07:12:29, Doug Anderson wrote:
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
> Putting the memory usage in perspective:

nmi_trigger_cpumask_backtrace() has its own copy of the cpu mask.
What about changing the @exclude_self parameter to @exclude_cpu
and do:

	if (exclude_cpu >= 0)
		cpumask_clear_cpu(exclude_cpu, to_cpumask(backtrace_mask));


It would require changing also arch_trigger_cpumask_backtrace() to

	void arch_trigger_cpumask_backtrace(const struct cpumask *mask,
				    int exclude_cpu);

but it looks doable.


It might theoretically change the behavior because
nmi_trigger_cpumask_backtrace() does

	this_cpu = get_cpu();

I guess that it was used to make sure that smp_processor_id()
the same. But it is too late. It should ignore the callers CPU.
So, this might actually fix a possible race.

Note that get_cpu() also disabled preemption. IMHO, it is not strictly needed.
But it might make sense to keep it because the backtraces are printed
when something goes wrong and it should print backtraces from the current state.

Best Regards,
Petr
