Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFECF78C0DB
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 10:58:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233541AbjH2I6N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 04:58:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230049AbjH2I5j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 04:57:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15120B5;
        Tue, 29 Aug 2023 01:57:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A7B87619E4;
        Tue, 29 Aug 2023 08:57:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A1FFC433C7;
        Tue, 29 Aug 2023 08:57:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693299455;
        bh=POiaetWJIw2E25wAzGlZpcureDv/K8WidUnmHju4Vco=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fB/DT2z6Vn6gaZOPP3h5NBnREEXQumCBcSK9l9gupevFHCA0zscJKIq+Nv/nkXXp+
         mClatvfPCUD5m/TnGv9upycykPCNMBnWgaQVh1PIAJCPFbArtL6mOQxTS0OgBG54Gx
         C9UNg3CveiBBG5p6l9utcBaKefKWX63uR6O7Fd68=
Date:   Tue, 29 Aug 2023 10:57:32 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Keyon Jie <yang.jie@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Doug Smythies <dsmythies@telus.net>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] cpufreq: intel_pstate: set stale CPU frequency to
 minimum
Message-ID: <2023082901-moonscape-album-b7cc@gregkh>
References: <001d01d9d3a7$71736f50$545a4df0$@telus.net>
 <CAJZ5v0g=TEY0+dL9AGh1cYNnwQ=L6G8CRxXVD0AyWsaK5aDsdA@mail.gmail.com>
 <9665af79-d439-e05a-5333-62f71a2ac55c@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9665af79-d439-e05a-5333-62f71a2ac55c@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,LOTS_OF_MONEY,
        MONEY_NOHTML,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 28, 2023 at 04:35:13PM -0700, Keyon Jie wrote:
> 
> 
> On 8/22/23 04:46, Rafael J. Wysocki wrote:
> > On Sun, Aug 20, 2023 at 10:46 PM Doug Smythies <dsmythies@telus.net> wrote:
> > > 
> > > The intel_pstate CPU frequency scaling driver does not
> > > use policy->cur and it is 0.
> > > When the CPU frequency is outdated arch_freq_get_on_cpu()
> > > will default to the nominal clock frequency when its call to
> > > cpufreq_quick_getpolicy_cur returns the never updated 0.
> > > Thus, the listed frequency might be outside of currently
> > > set limits. Some users are complaining about the high
> > > reported frequency, albeit stale, when their system is
> > > idle and/or it is above the reduced maximum they have set.
> > > 
> > > This patch will maintain policy_cur for the intel_pstate
> > > driver at the current minimum CPU frequency.
> > > 
> > > Reported-by: Yang Jie <yang.jie@linux.intel.com>
> > > Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217597
> > > Signed-off-by: Doug Smythies <dsmythies@telus.net>
> > > ---
> > > 
> > > v1 -> v2:
> > >     * v1 was a completely different approach, programming around
> > >       the issue rather than fixing it at the source.
> > >       reference:
> > >       https://patchwork.kernel.org/project/linux-pm/patch/006901d9be8c$f4439930$dccacb90$@telus.net/
> > >     * v2 does not fix an issue with the intel_cpufreq CPU scaling
> > >       driver (A.K.A. the intel_pstate driver in passive mode) and
> > >       the schedutil CPU frequency scaling governor when HWP is enabled
> > >       where limit changes are not reflected in the stale listed frequencies.
> > >       A fix for that will be some future patch.
> > > 
> > > ---
> > >   drivers/cpufreq/intel_pstate.c | 5 +++++
> > >   1 file changed, 5 insertions(+)
> > > 
> > > diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> > > index 8ca2bce4341a..08284dee583a 100644
> > > --- a/drivers/cpufreq/intel_pstate.c
> > > +++ b/drivers/cpufreq/intel_pstate.c
> > > @@ -2609,6 +2609,11 @@ static int intel_pstate_set_policy(struct cpufreq_policy *policy)
> > >                          intel_pstate_clear_update_util_hook(policy->cpu);
> > >                  intel_pstate_hwp_set(policy->cpu);
> > >          }
> > > +       /* policy current is never updated with the intel_pstate driver
> > > +        * but it is used as a stale frequency value. So, keep it within
> > > +        * limits.
> > > +        */
> > > +       policy->cur = policy->min;
> > > 
> > >          mutex_unlock(&intel_pstate_limits_lock);
> > > 
> > > --
> > 
> > Applied as 6.6 material, with some mailer-induced white space damage
> > fixed and the new comment adjusted to the kernel coding style.
> > 
> > Thanks!
> 
> Hi Doug and Rafael,
> 
> Thank you for making the fix happen.
> 
> Hi Greg,
> 
> Will this be picked to the stable linux-6.1.y and linux-6.4.y kernel, it
> could benefit to users there.

Sure, when it hits Linus's tree, please follow the instructions in:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to get it merged.

thanks,

greg k-h
