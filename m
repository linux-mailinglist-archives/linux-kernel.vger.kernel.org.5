Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0027876E332
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 10:34:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234464AbjHCIeE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 04:34:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234395AbjHCIdl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 04:33:41 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE9CF6A64
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 01:30:04 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 04292219A8;
        Thu,  3 Aug 2023 08:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1691051402; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+A3S/t0eENT61stOMbzhe8kTGnHpYs6gn53RtTgGqxw=;
        b=WDPCL1KB+i9DJq0kWI350SXRaubwMyrE9JA1gqDdYyQdJl970afGMrX5fJjO2up0EncdaY
        Z+Y4mC//lJqxFLVE0+Fso8+DPHDblCWF3EsVIMp89yIPfzSz8bI6nWJHNaMBBl0moZrjGi
        5Wc9B7iqBRKITGEAlkuXqeTmP/RL1CE=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D8B0A134B0;
        Thu,  3 Aug 2023 08:30:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id AO6QMolly2TrUwAAMHmgww
        (envelope-from <mhocko@suse.com>); Thu, 03 Aug 2023 08:30:01 +0000
Date:   Thu, 3 Aug 2023 10:30:01 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Doug Anderson <dianders@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        kernel test robot <lkp@intel.com>,
        Lecopzer Chen <lecopzer.chen@mediatek.com>,
        Pingfan Liu <kernelfans@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] watchdog/hardlockup: Avoid large stack frames in
 watchdog_hardlockup_check()
Message-ID: <ZMtliXUFGptYKEra@dhcp22.suse.cz>
References: <20230731091754.1.I501ab68cb926ee33a7c87e063d207abf09b9943c@changeid>
 <ZMkBY7K3Dn04YQ65@dhcp22.suse.cz>
 <CAD=FV=V5hx7Zy-XMB=sPYcD_h-iP5VknmEoJwvw3Akd_1wDnRw@mail.gmail.com>
 <ZMkkNpYcaYPAMj0Z@dhcp22.suse.cz>
 <CAD=FV=Ujmyq-1GAvNJsrp=mj_Vg=9b6fmfMfkHq3+8ZQ5KiaRw@mail.gmail.com>
 <ZMoFWK0uGdneJYVc@dhcp22.suse.cz>
 <CAD=FV=XQMH8sun7XCXJNjOC7tP1yt8=mt1NG3f8Xm9-x5TJFsA@mail.gmail.com>
 <ZMthXBpLzbbysTe5@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZMthXBpLzbbysTe5@alley>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 03-08-23 10:12:12, Petr Mladek wrote:
> On Wed 2023-08-02 07:12:29, Doug Anderson wrote:
> > Hi,
> > 
> > On Wed, Aug 2, 2023 at 12:27 AM Michal Hocko <mhocko@suse.com> wrote:
> > >
> > > On Tue 01-08-23 08:41:49, Doug Anderson wrote:
> > > [...]
> > > > Ah, I see what you mean. The one issue I have with your solution is
> > > > that the ordering of the stack crawls is less ideal in the "dump all"
> > > > case when cpu != this_cpu. We really want to see the stack crawl of
> > > > the locked up CPU first and _then_ see the stack crawls of other CPUs.
> > > > With your solution the locked up CPU will be interspersed with all the
> > > > others and will be harder to find in the output (you've got to match
> > > > it up with the "Watchdog detected hard LOCKUP on cpu N" message).
> > > > While that's probably not a huge deal, it's nicer to make the output
> > > > easy to understand for someone trying to parse it...
> > >
> > > Is it worth to waste memory for this arguably nicer output? Identifying
> > > the stack of the locked up CPU is trivial.
> > 
> > I guess it's debatable, but as someone who has spent time staring at
> > trawling through reports generated like this, I'd say "yes", it's
> > super helpful in understanding the problem to have the hung CPU first.
> > Putting the memory usage in perspective:
> 
> nmi_trigger_cpumask_backtrace() has its own copy of the cpu mask.
> What about changing the @exclude_self parameter to @exclude_cpu
> and do:
> 
> 	if (exclude_cpu >= 0)
> 		cpumask_clear_cpu(exclude_cpu, to_cpumask(backtrace_mask));
> 
> 
> It would require changing also arch_trigger_cpumask_backtrace() to
> 
> 	void arch_trigger_cpumask_backtrace(const struct cpumask *mask,
> 				    int exclude_cpu);
> 
> but it looks doable.

Yes, but sparc is doing its own thing so it would require changing that
as well. But this looks reasonable as well.

-- 
Michal Hocko
SUSE Labs
