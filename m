Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A1457599CC
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 17:32:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231324AbjGSPcs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 11:32:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbjGSPcq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 11:32:46 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3E0B3BE;
        Wed, 19 Jul 2023 08:32:45 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 433EB2F4;
        Wed, 19 Jul 2023 08:33:28 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 671393F6C4;
        Wed, 19 Jul 2023 08:32:43 -0700 (PDT)
Date:   Wed, 19 Jul 2023 16:32:40 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Cristian Marussi <cristian.marussi@arm.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Nikunj Kela <nkela@quicinc.com>,
        Prasad Sodagudi <psodagud@quicinc.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 11/11] cpufreq: scmi: Drop redundant ifdef in
 scmi_cpufreq_probe()
Message-ID: <20230719153240.khiuqehl2r2dd6l7@bogus>
References: <20230713141738.23970-1-ulf.hansson@linaro.org>
 <20230713141738.23970-12-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230713141738.23970-12-ulf.hansson@linaro.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 13, 2023 at 04:17:38PM +0200, Ulf Hansson wrote:
> We have stubs for devm_of_clk_add_hw_provider(), so there should be no need
> to protect this with the '#ifdef CONFIG_COMMON_CLK'. Let's drop it to clean
> up the code a bit.
> 
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
> 
> Changes in v2:
> 	- New patch.
> 
> ---
> 
>  drivers/cpufreq/scmi-cpufreq.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/scmi-cpufreq.c b/drivers/cpufreq/scmi-cpufreq.c
> index b42f43d9bd89..ab967e520355 100644
> --- a/drivers/cpufreq/scmi-cpufreq.c
> +++ b/drivers/cpufreq/scmi-cpufreq.c
> @@ -326,11 +326,9 @@ static int scmi_cpufreq_probe(struct scmi_device *sdev)
>  	if (IS_ERR(perf_ops))
>  		return PTR_ERR(perf_ops);
>  
> -#ifdef CONFIG_COMMON_CLK

I am not sure if it is no longer possible but at the time of addition of this
it was possible to build with CONFIG_COMMON_CLK=n and any error was reported[1]
I didn't want to add Kconfig dependency as this driver doesn't use any other
clock apis and this was added to meet some OPP(?) requirement IIRC. We can
drop the call to devm_of_clk_add_hw_provider if that is not the case. I need
to check it again as I can't recall all the details right now.

--
Regards,
Sudeep

[1] https://www.uwsg.indiana.edu/hypermail/linux/kernel/2012.0/04953.html
