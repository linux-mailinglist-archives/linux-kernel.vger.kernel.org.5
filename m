Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7892808BAE
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 16:21:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443501AbjLGPVj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 10:21:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443499AbjLGPVY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 10:21:24 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71E07172C
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 07:21:25 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 666D2C433C7;
        Thu,  7 Dec 2023 15:21:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701962485;
        bh=45oamiijKSCLo/ORgchi/hZLvxifeiPsd9EiBfcYapY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nl4nnvV1kl1BSDZ7fxNw0ZxUEEQYqDk2GC8ePLDfhpOLnqk232ExGKGTZoHR2iu2h
         mUi+1APpDklkWy0hnjB/CTAvWErmWSE2onSCMeK9zOf6OhRwhA/Miyne1hpAFX9d9l
         YoYGddItHTDhWd/0amtZyrjGEPsGq1UDXtlln7FSZKyEJdIJ8zrrrARM+D4RAdD3/0
         VMeUBzSvycUy3PSEACzl01++jkbxDockEjjiUKA0h+pmI8/bNRYF3v/9X0goDdX7jx
         5LPmKCZFRgFpEImh9n1cbasp+zD/xwN6bGv9oQzLNz7ZWSMJDn2cL3A648N5OvtYxN
         7JldAj5D9w5sg==
Date:   Thu, 7 Dec 2023 07:24:43 -0800
From:   Bjorn Andersson <andersson@kernel.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] soc: qcom: stats: fix 64-bit division
Message-ID: <57aatyq7y62uocvm76hucgr7zbwu2q573iq5miuua7n4rd4wjm@6fbsuryxo55s>
References: <20231206123717.524009-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231206123717.524009-1-arnd@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 06, 2023 at 01:37:06PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Unguarded 64-bit division is not allowed on 32-bit kernels because this
> is very slow. The result of trying anyway is a link failure:
> 
> arm-linux-gnueabi-ld: drivers/soc/qcom/qcom_stats.o: in function `qcom_ddr_stats_show':
> qcom_stats.c:(.text+0x334): undefined reference to `__aeabi_uldivmod'
> 
> As this function is only used for debugging and not performance critical,
> rewrite it to use div_u64() instead. ARCH_TIMER_FREQ is a multiple of
> MSEC_PER_SEC anyway, so there is no loss in precisison.
> 
> Fixes: e84e61bdb97c ("soc: qcom: stats: Add DDR sleep stats")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

I had [1] lined up already, but hadn't pushed the branch out out... Like
your version better, so dropping mine.

[1] https://lore.kernel.org/all/20231205-qcom_stats-aeabi_uldivmod-fix-v1-1-f94ecec5e894@quicinc.com/

Thanks,
Bjorn

> ---
>  drivers/soc/qcom/qcom_stats.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/soc/qcom/qcom_stats.c b/drivers/soc/qcom/qcom_stats.c
> index 4763d62a8cb0..5ec8a754b22b 100644
> --- a/drivers/soc/qcom/qcom_stats.c
> +++ b/drivers/soc/qcom/qcom_stats.c
> @@ -221,7 +221,7 @@ static int qcom_ddr_stats_show(struct seq_file *s, void *unused)
>  
>  	for (i = 0; i < ddr.entry_count; i++) {
>  		/* Convert the period to ms */
> -		entry[i].dur = mult_frac(MSEC_PER_SEC, entry[i].dur, ARCH_TIMER_FREQ);
> +		entry[i].dur = div_u64(entry[i].dur, ARCH_TIMER_FREQ / MSEC_PER_SEC);
>  	}
>  
>  	for (i = 0; i < ddr.entry_count; i++)
> -- 
> 2.39.2
> 
