Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02A327EF176
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 12:14:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230513AbjKQLOe convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 17 Nov 2023 06:14:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjKQLOb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 06:14:31 -0500
Received: from mail.astralinux.ru (mail.astralinux.ru [217.74.38.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D04311F;
        Fri, 17 Nov 2023 03:14:25 -0800 (PST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.astralinux.ru (Postfix) with ESMTP id 4136F1864DDA;
        Fri, 17 Nov 2023 14:14:22 +0300 (MSK)
Received: from mail.astralinux.ru ([127.0.0.1])
        by localhost (rbta-msk-vsrv-mail01.astralinux.ru [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id dJQkUJDBA1fT; Fri, 17 Nov 2023 14:14:21 +0300 (MSK)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.astralinux.ru (Postfix) with ESMTP id E0BA01866239;
        Fri, 17 Nov 2023 14:14:21 +0300 (MSK)
X-Virus-Scanned: amavisd-new at astralinux.ru
Received: from mail.astralinux.ru ([127.0.0.1])
        by localhost (rbta-msk-vsrv-mail01.astralinux.ru [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id fWXtdPalOdLf; Fri, 17 Nov 2023 14:14:21 +0300 (MSK)
Received: from new-mail.astralinux.ru (unknown [10.177.185.103])
        by mail.astralinux.ru (Postfix) with ESMTPS id 76A4918658FC;
        Fri, 17 Nov 2023 14:14:21 +0300 (MSK)
Received: from [10.177.232.129] (unknown [10.177.232.129])
        by new-mail.astralinux.ru (Postfix) with ESMTPA id 4SWvRw6K5nzhXb7;
        Fri, 17 Nov 2023 14:14:20 +0300 (MSK)
Message-ID: <fe85f03b-1c2a-3a99-c62b-abdf7e1eccb4@astralinux.ru>
Date:   Fri, 17 Nov 2023 14:14:13 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH] cpufreq: scmi: process the result of
 devm_of_clk_add_hw_provider()
Content-Language: en-US
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Cristian Marussi <cristian.marussi@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
References: <20231117074911.14427-1-adiupina@astralinux.ru>
From:   =?UTF-8?B?0JDQu9C10LrRgdCw0L3QtNGA0LAg0JTRjtC/0LjQvdCw?= 
        <adiupina@astralinux.ru>
In-Reply-To: <20231117074911.14427-1-adiupina@astralinux.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm sorry, I forgot to add "return ret;" after
calling the dev_err() function. Before I post
the second version of the patch, please let me
know what you think about this fix, keeping in
mind what I wanted to add "return ret;"

17.11.2023 10:49, Alexandra Diupina пишет:
> devm_of_clk_add_hw_provider() may return an errno, so
> add a return value check
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: 8410e7f3b31e ("cpufreq: scmi: Fix OPP addition failure with a dummy clock provider")
> Signed-off-by: Alexandra Diupina <adiupina@astralinux.ru>
> ---
>   drivers/cpufreq/scmi-cpufreq.c | 9 +++++++--
>   1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/scmi-cpufreq.c b/drivers/cpufreq/scmi-cpufreq.c
> index c8a7ccc42c16..4037945663bf 100644
> --- a/drivers/cpufreq/scmi-cpufreq.c
> +++ b/drivers/cpufreq/scmi-cpufreq.c
> @@ -334,8 +334,13 @@ static int scmi_cpufreq_probe(struct scmi_device *sdev)
>   
>   #ifdef CONFIG_COMMON_CLK
>   	/* dummy clock provider as needed by OPP if clocks property is used */
> -	if (of_property_present(dev->of_node, "#clock-cells"))
> -		devm_of_clk_add_hw_provider(dev, of_clk_hw_simple_get, NULL);
> +	if (of_property_present(dev->of_node, "#clock-cells")) {
> +		ret = devm_of_clk_add_hw_provider(dev, of_clk_hw_simple_get, NULL);
> +		if (ret) {
> +			dev_err(dev, "%s: registering clock provider failed, err: %d\n",
> +				__func__, ret);
> +		}
> +	}
>   #endif
>   
>   	ret = cpufreq_register_driver(&scmi_cpufreq_driver);


Regards,

Alexandra Diupina
