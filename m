Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36E697598D2
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 16:52:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbjGSOvy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 10:51:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbjGSOvv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 10:51:51 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DAC9B11B;
        Wed, 19 Jul 2023 07:51:49 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C26162F4;
        Wed, 19 Jul 2023 07:52:32 -0700 (PDT)
Received: from e120937-lin (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E5C0E3F6C4;
        Wed, 19 Jul 2023 07:51:47 -0700 (PDT)
Date:   Wed, 19 Jul 2023 15:51:45 +0100
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Nikunj Kela <nkela@quicinc.com>,
        Prasad Sodagudi <psodagud@quicinc.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 10/11] firmware: arm_scmi: Add the SCMI performance
 domain
Message-ID: <ZLf4c7ejFBJLH7iN@e120937-lin>
References: <20230713141738.23970-1-ulf.hansson@linaro.org>
 <20230713141738.23970-11-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230713141738.23970-11-ulf.hansson@linaro.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 13, 2023 at 04:17:37PM +0200, Ulf Hansson wrote:
> To enable support for performance scaling (DVFS) for generic devices with
> the SCMI performance protocol, let's add an SCMI performance domain. This
> is being modelled as a genpd provider, with support for performance scaling
> through genpd's ->set_performance_state() callback.
> 
> Note that, this adds the initial support that allows consumer drivers for
> attached devices, to vote for a new performance state via calling the
> dev_pm_genpd_set_performance_state(). However, this should be avoided as
> it's in most cases preferred to use the OPP library to vote for a new OPP
> instead. The support using the OPP library isn't part of this change, but
> needs to be implemented from subsequent changes.
> 

Hi Ulf,

a couple of remarks down below.

> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
> 
> Changes in v2:
> 	- Converted to use the new ->domain_info_get() callback.
> 
> ---
>  drivers/firmware/arm_scmi/Kconfig            |  12 ++
>  drivers/firmware/arm_scmi/Makefile           |   1 +
>  drivers/firmware/arm_scmi/scmi_perf_domain.c | 155 +++++++++++++++++++
>  3 files changed, 168 insertions(+)
>  create mode 100644 drivers/firmware/arm_scmi/scmi_perf_domain.c 

[snip]

> +static int scmi_perf_domain_probe(struct scmi_device *sdev)
> +{
> +	struct device *dev = &sdev->dev;
> +	const struct scmi_handle *handle = sdev->handle;
> +	const struct scmi_perf_proto_ops *perf_ops;
> +	struct scmi_protocol_handle *ph;
> +	struct scmi_perf_domain *scmi_pd;
> +	struct genpd_onecell_data *scmi_pd_data;
> +	struct generic_pm_domain **domains;
> +	int num_domains, i, ret = 0;
> +	u32 perf_level;
> +
> +	if (!handle)
> +		return -ENODEV;
> +
> +	/* The OF node must specify us as a power-domain provider. */
> +	if (!of_find_property(dev->of_node, "#power-domain-cells", NULL))
> +		return 0;
> +
> +	perf_ops = handle->devm_protocol_get(sdev, SCMI_PROTOCOL_PERF, &ph);
> +	if (IS_ERR(perf_ops))
> +		return PTR_ERR(perf_ops);
> +
> +	num_domains = perf_ops->num_domains_get(ph);
> +	if (num_domains < 0) {
> +		dev_warn(dev, "Failed with %d when getting num perf domains\n",
> +			 num_domains);
> +		return num_domains;
> +	} else if (!num_domains) {
> +		return 0;
> +	}
> +
> +	scmi_pd = devm_kcalloc(dev, num_domains, sizeof(*scmi_pd), GFP_KERNEL);
> +	if (!scmi_pd)
> +		return -ENOMEM;
> +
> +	scmi_pd_data = devm_kzalloc(dev, sizeof(*scmi_pd_data), GFP_KERNEL);
> +	if (!scmi_pd_data)
> +		return -ENOMEM;
> +
> +	domains = devm_kcalloc(dev, num_domains, sizeof(*domains), GFP_KERNEL);
> +	if (!domains)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < num_domains; i++, scmi_pd++) {
> +		scmi_pd->info = perf_ops->domain_info_get(ph, i);
 
So here you are grabbing all the performance domains exposed by the
platform via PERF protocol and then a few lines down below you are
registering them with pm_genpd_init(), but the list of domains obtained
from the platform will contain NOT only devices but also CPUs possibly,
already managed by the SCMI CPUFreq driver.

In fact the SCMI CPUFreq driver, on his side, takes care to pick only
domains that are bound in the DT to a CPU (via scmi_cpu_domain_id DT
parsing) but here you are registering all domains with GenPD upfront.

Is it not possible that, once registered, GenPD can decide, at some point
in the future, to try act on some of these domains associated with a CPU ?
(like Clock framework does at the end of boot trying to disable unused
 clocks...not familiar with internals of GenPD, though)

> +		scmi_pd->domain_id = i;
> +		scmi_pd->perf_ops = perf_ops;
> +		scmi_pd->ph = ph;
> +		scmi_pd->genpd.name = scmi_pd->info->name;
> +		scmi_pd->genpd.flags = GENPD_FLAG_OPP_TABLE_FW;
> +		scmi_pd->genpd.set_performance_state = scmi_pd_set_perf_state;
> +
> +		ret = perf_ops->level_get(ph, i, &perf_level, false);
> +		if (ret) {
> +			dev_dbg(dev, "Failed to get perf level for %s",
> +				 scmi_pd->genpd.name);
> +			perf_level = 0;
> +		}
> +
> +		/* Let the perf level indicate the power-state too. */
> +		ret = pm_genpd_init(&scmi_pd->genpd, NULL, perf_level == 0);

In SCMI world PERF levels should have nothing to do with the Power
state of a domain: you have the POWER protocol for that, so you should
not assume that perf level 0 means OFF, but you can use the POWER protocol
operation .state_get() to lookup the power state. (and you can grab both
perf and power ops from the same driver)

The tricky part would be to match the PERF domain at hand with the
related POWER domain to query the state for, I suppose.

Indeed, recently, while looking at SCMI v3.2 PERF evolutions, I was
tempted to just start rejecting any level_set() or set_freq() request
for ZERO since they really can be abused to power off a domain. (if the
platform complies...)

Apologize if I missed something about how GenPD behaviour...

Thanks,
Cristian
