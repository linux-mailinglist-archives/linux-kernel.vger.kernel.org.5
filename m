Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9198D759A54
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 17:59:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231552AbjGSP72 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 11:59:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbjGSP70 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 11:59:26 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5DA2010B;
        Wed, 19 Jul 2023 08:59:25 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1D4F42F4;
        Wed, 19 Jul 2023 09:00:08 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 231A13F67D;
        Wed, 19 Jul 2023 08:59:23 -0700 (PDT)
Date:   Wed, 19 Jul 2023 16:59:20 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Cristian Marussi <cristian.marussi@arm.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Nikunj Kela <nkela@quicinc.com>,
        Prasad Sodagudi <psodagud@quicinc.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 10/11] firmware: arm_scmi: Add the SCMI performance
 domain
Message-ID: <20230719155920.iuu2ue2co535dfkx@bogus>
References: <20230713141738.23970-1-ulf.hansson@linaro.org>
 <20230713141738.23970-11-ulf.hansson@linaro.org>
 <ZLf4c7ejFBJLH7iN@e120937-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZLf4c7ejFBJLH7iN@e120937-lin>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 19, 2023 at 03:51:45PM +0100, Cristian Marussi wrote:
> On Thu, Jul 13, 2023 at 04:17:37PM +0200, Ulf Hansson wrote:

[...]

> > +	scmi_pd_data = devm_kzalloc(dev, sizeof(*scmi_pd_data), GFP_KERNEL);
> > +	if (!scmi_pd_data)
> > +		return -ENOMEM;
> > +
> > +	domains = devm_kcalloc(dev, num_domains, sizeof(*domains), GFP_KERNEL);
> > +	if (!domains)
> > +		return -ENOMEM;
> > +
> > +	for (i = 0; i < num_domains; i++, scmi_pd++) {
> > +		scmi_pd->info = perf_ops->domain_info_get(ph, i);
>
> So here you are grabbing all the performance domains exposed by the
> platform via PERF protocol and then a few lines down below you are
> registering them with pm_genpd_init(), but the list of domains obtained
> from the platform will contain NOT only devices but also CPUs possibly,
> already managed by the SCMI CPUFreq driver.
>

Agreed, I pointed out briefly in the previous patch I think. I am not sure
how will that work if the performance and power domains are not 1-1 mapping
or if they are CPUs then this might confusing ? Not sure but looks like
we might be creating a spaghetti here :(.

> In fact the SCMI CPUFreq driver, on his side, takes care to pick only
> domains that are bound in the DT to a CPU (via scmi_cpu_domain_id DT
> parsing) but here you are registering all domains with GenPD upfront.
>

+1

> Is it not possible that, once registered, GenPD can decide, at some point
> in the future, to try act on some of these domains associated with a CPU ?

IIRC, all unused genpd are turned off right. It may not impact here but still
super confusing as we will be creating power domains for the set of domains
actually advertised as power domains by the firmware. This will add another
set.

> (like Clock framework does at the end of boot trying to disable unused
>  clocks...not familiar with internals of GenPD, though)
>

Ah, I am reading too much serialised. Just agreed and wrote the same above.

> > +		scmi_pd->domain_id = i;
> > +		scmi_pd->perf_ops = perf_ops;
> > +		scmi_pd->ph = ph;
> > +		scmi_pd->genpd.name = scmi_pd->info->name;
> > +		scmi_pd->genpd.flags = GENPD_FLAG_OPP_TABLE_FW;
> > +		scmi_pd->genpd.set_performance_state = scmi_pd_set_perf_state;
> > +
> > +		ret = perf_ops->level_get(ph, i, &perf_level, false);
> > +		if (ret) {
> > +			dev_dbg(dev, "Failed to get perf level for %s",
> > +				 scmi_pd->genpd.name);
> > +			perf_level = 0;
> > +		}
> > +
> > +		/* Let the perf level indicate the power-state too. */
> > +		ret = pm_genpd_init(&scmi_pd->genpd, NULL, perf_level == 0);
>
> In SCMI world PERF levels should have nothing to do with the Power
> state of a domain: you have the POWER protocol for that, so you should
> not assume that perf level 0 means OFF, but you can use the POWER protocol
> operation .state_get() to lookup the power state. (and you can grab both
> perf and power ops from the same driver)
>
> The tricky part would be to match the PERF domain at hand with the
> related POWER domain to query the state for, I suppose.
>

I wanted to ask the same. E.g. on juno, GPU has perf domain 2 and power domain
9. It would be good if we can how it would work there ? What is expected
from the gpu driver in terms of managing perf and power ? Does it need
to specify 2 power domains now and specify which is perf and which power in
its bindings ?

> Indeed, recently, while looking at SCMI v3.2 PERF evolutions, I was
> tempted to just start rejecting any level_set() or set_freq() request
> for ZERO since they really can be abused to power off a domain. (if the
> platform complies...)
>

Good point I need to dig the spec before I can comment on this.

--
Regards,
Sudeep
