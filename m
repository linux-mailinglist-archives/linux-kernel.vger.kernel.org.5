Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9D86808485
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 10:23:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378513AbjLGJXf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 04:23:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378534AbjLGJXH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 04:23:07 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2D2592113;
        Thu,  7 Dec 2023 01:22:09 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D895A12FC;
        Thu,  7 Dec 2023 01:22:54 -0800 (PST)
Received: from localhost (ionvoi01-desktop.cambridge.arm.com [10.2.78.69])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 744783F6C4;
        Thu,  7 Dec 2023 01:22:08 -0800 (PST)
Date:   Thu, 7 Dec 2023 09:22:06 +0000
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     Sumit Gupta <sumitg@nvidia.com>
Cc:     Beata Michalska <beata.michalska@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, sudeep.holla@arm.covm, will@kernel.org,
        catalin.marinas@arm.com, viresh.kumar@linaro.org,
        rafael@kernel.org, yang@os.amperecomputing.com,
        linux-tegra@vger.kernel.org
Subject: Re: [PATCH v2 2/2] cpufreq: Wire-up arch-flavored freq info into
 cpufreq_verify_current_freq
Message-ID: <ZXGOvsE4mKOsdoLp@arm.com>
References: <20231127160838.1403404-1-beata.michalska@arm.com>
 <20231127160838.1403404-3-beata.michalska@arm.com>
 <ZWXy0h/fFfQh+Rhy@arm.com>
 <3e6077bb-907c-057f-0896-d0a5814a4229@nvidia.com>
 <ZW8D5TfSwuJfdYeD@arm.com>
 <c8b4d391-681e-f4a6-2839-e5951429f043@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c8b4d391-681e-f4a6-2839-e5951429f043@nvidia.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 06 Dec 2023 at 18:58:17 (+0530), Sumit Gupta wrote:
> 
> 
> On 05/12/23 16:35, Ionela Voinescu wrote:
> > External email: Use caution opening links or attachments
> > 
> > 
> > Hi Sumit,
> > 
> > On Friday 01 Dec 2023 at 18:32:10 (+0530), Sumit Gupta wrote:
> > > Hi Ionela,
> > > 
> > > > > --- a/drivers/cpufreq/cpufreq.c
> > > > > +++ b/drivers/cpufreq/cpufreq.c
> > > > > @@ -1756,7 +1756,8 @@ static unsigned int cpufreq_verify_current_freq(struct cpufreq_policy *policy, b
> > > > >    {
> > > > >         unsigned int new_freq;
> > > > > 
> > > > > -     new_freq = cpufreq_driver->get(policy->cpu);
> > > > > +     new_freq = arch_freq_get_on_cpu(policy->cpu);
> > > > > +     new_freq = new_freq ?: cpufreq_driver->get(policy->cpu);
> > > > 
> > > > Given that arch_freq_get_on_cpu() is an average frequency, it does not
> > > > seem right to me to trigger the sync & update process of
> > > > cpufreq_verify_current_freq() based on it.
> > > > 
> > > > cpufreq_verify_current_freq() will at least modify the internal state of
> > > > the policy and send PRE and POST notifications, if not do a full frequency
> > > > update, based on this average frequency, which is likely different from
> > > > the current frequency, even beyond the 1MHz threshold.
> > > > 
> > > > While I believe it's okay to return this average frequency in
> > > > cpuinfo_cur_freq, I don't think it should be used as an indication of
> > > > an accurate current frequency, which is what
> > > > cpufreq_verify_current_freq() expects.
> > > > 
> > > > Sumit, can you give more details on the issue at [1] and why this change
> > > > fixes it?
> > > > 
> > > > [1] https://lore.kernel.org/lkml/6a5710f6-bfbb-5dfd-11cd-0cd02220cee7@nvidia.com/
> > > > 
> > > > Thank you,
> > > > Ionela.
> > > > 
> > > cpufreq_verify_current_freq() also updates 'policy->cur' in POST
> > > notification if the frequency from hardware has more delta (out of sync).
> > > 
> > > As the value from 'cpufreq_driver->get()' is not reliable due to [1],
> > > calling the 'get' hook can update the 'policy->cur' with a wrong value when
> > > governor starts in cpufreq_start_governor().
> > > And if the frequency is never changed after the governor starts during
> > > boot e.g. when performance governor is set as default, then
> > > 'scaling_cur_freq' always returns wrong value.
> > > 
> > > Instead, the arch_freq_get_on_cpu() API updates 'policy->cur' with a more
> > > stable freq value.
> > > 
> > > [1] https://lore.kernel.org/lkml/20230418113459.12860-7-sumitg@nvidia.com/
> > 
> > Got it, many thanks!
> > 
> > As the code is right now in v2, arch_freq_get_on_cpu() is called on
> > show_scaling_cur_freq(), so the problem you describe would not show up.
> > policy->cur would still be incorrect, but 'scaling_cur_freq' would
> > return the value from arch_freq_get_on_cpu().
> > 
> > Would it be enough if arch_freq_get_on_cpu() gets also called from
> > show_cpuinfo_cur_freq() instead of cpufreq_verify_current_freq()?
> > 
> > Thanks,
> > Ionela.
> > 
> 
> Yes.
> I am not sure if making both the nodes 'scaling_cur_freq' and
> 'cpuinfo_cur_freq' same is fine?

That would happen anyway if arch_freq_get_on_cpu() is called from
cpufreq_verify_current_freq().

In principle, according to [1], it would be correct to use it for
'cpuinfo_cur_freq' and not 'scaling_cur_freq'. But the call from
show_scaling_cur_freq() is already there before these patches,
introduced a long time ago for x86.

The topic was discussed at [2] and the agreement so far was that it
would be best to keep the behaviour the same for both x86 and arm.

I don't like going against the user-guide, but these patches don't
actually go against the user-guide. The old call to
arch_freq_get_on_cpu() from show_scaling_cur_freq() goes against it.
But I agree that's something necessary to keep, as legacy for x86.
Additionally, you also mentioned that you'd prefer to have a more
accurate frequency returned for 'scaling_cur_freq'.

[1] https://www.kernel.org/doc/Documentation/cpu-freq/user-guide.txt
[2] https://lore.kernel.org/lkml/20230609043922.eyyqutbwlofqaddz@vireshk-i7/

Thanks,
Ionela.

> 
> Best Regards,
> Sumit Gupta
