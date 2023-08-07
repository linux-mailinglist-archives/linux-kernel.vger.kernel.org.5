Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB3517724F2
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 15:06:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233826AbjHGNGe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 09:06:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233791AbjHGNG2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 09:06:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C424D1701;
        Mon,  7 Aug 2023 06:06:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 586DA619CC;
        Mon,  7 Aug 2023 13:06:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37D0FC433C7;
        Mon,  7 Aug 2023 13:06:23 +0000 (UTC)
Message-ID: <0b361e6c-d141-4758-edc2-c75b6f0efbe3@xs4all.nl>
Date:   Mon, 7 Aug 2023 15:06:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 3/3] media: exynos4-is: fimc-is: replace duplicate pmu
 node with phandle
Content-Language: en-US, nl
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230722115441.139628-1-krzysztof.kozlowski@linaro.org>
 <20230722115441.139628-3-krzysztof.kozlowski@linaro.org>
From:   Hans Verkuil <hverkuil@xs4all.nl>
In-Reply-To: <20230722115441.139628-3-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On 22/07/2023 13:54, Krzysztof Kozlowski wrote:
> Devicetree for the FIMC IS camera included duplicated PMU node as its
> child like:
> 
>   soc@0 {
>     system-controller@10020000 { ... }; // Real PMU
> 
>     camera@11800000 {
>       fimc-is@12000000 {
>         // FIMC IS camera node
>         pmu@10020000 {
>           reg = <0x10020000 0x3000>; // Fake PMU node
>         };
>       };
>     };
>   };
> 
> This is not a correct representation of the hardware.  Mapping the PMU
> (Power Management Unit) IO memory should be via syscon-like phandle
> (samsung,pmu-syscon, already used for other drivers), not by duplicating
> "pmu" Devicetree node inside the FIMC IS.  Backward compatibility is
> preserved.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../platform/samsung/exynos4-is/fimc-is.c     | 33 ++++++++++++++-----
>  1 file changed, 24 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/media/platform/samsung/exynos4-is/fimc-is.c b/drivers/media/platform/samsung/exynos4-is/fimc-is.c
> index 530a148fe4d3..c4c191771093 100644
> --- a/drivers/media/platform/samsung/exynos4-is/fimc-is.c
> +++ b/drivers/media/platform/samsung/exynos4-is/fimc-is.c
> @@ -767,12 +767,32 @@ static void fimc_is_debugfs_create(struct fimc_is *is)
>  static int fimc_is_runtime_resume(struct device *dev);
>  static int fimc_is_runtime_suspend(struct device *dev);
>  
> +static void __iomem *fimc_is_get_pmu_regs(struct device *dev)
> +{
> +	struct device_node *node;
> +	void __iomem *regs;
> +
> +	node = of_parse_phandle(dev->of_node, "samsung,pmu-syscon", 0);
> +	if (!node) {
> +		dev_warn(dev, "Finding PMU node via deprecated method, update your DTB\n");
> +		node = of_get_child_by_name(dev->of_node, "pmu");
> +		if (!node)
> +			return ERR_PTR(-ENODEV);
> +	}
> +
> +	regs = of_iomap(node, 0);
> +	of_node_put(node);
> +	if (!regs)
> +		return ERR_PTR(-ENOMEM);

sparse gives me these warnings for these ERR_PTR returns:

drivers/media/platform/samsung/exynos4-is/fimc-is.c:780:39: warning: incorrect type in return expression (different address spaces)
drivers/media/platform/samsung/exynos4-is/fimc-is.c:780:39:    expected void [noderef] __iomem *
drivers/media/platform/samsung/exynos4-is/fimc-is.c:780:39:    got void *
drivers/media/platform/samsung/exynos4-is/fimc-is.c:786:31: warning: incorrect type in return expression (different address spaces)
drivers/media/platform/samsung/exynos4-is/fimc-is.c:786:31:    expected void [noderef] __iomem *
drivers/media/platform/samsung/exynos4-is/fimc-is.c:786:31:    got void *

Regards,

	Hans

> +
> +	return regs;
> +}
> +
>  static int fimc_is_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
>  	struct fimc_is *is;
>  	struct resource res;
> -	struct device_node *node;
>  	int ret;
>  
>  	is = devm_kzalloc(&pdev->dev, sizeof(*is), GFP_KERNEL);
> @@ -794,14 +814,9 @@ static int fimc_is_probe(struct platform_device *pdev)
>  	if (IS_ERR(is->regs))
>  		return PTR_ERR(is->regs);
>  
> -	node = of_get_child_by_name(dev->of_node, "pmu");
> -	if (!node)
> -		return -ENODEV;
> -
> -	is->pmu_regs = of_iomap(node, 0);
> -	of_node_put(node);
> -	if (!is->pmu_regs)
> -		return -ENOMEM;
> +	is->pmu_regs = fimc_is_get_pmu_regs(dev);
> +	if (IS_ERR(is->pmu_regs))
> +		return PTR_ERR(is->pmu_regs);
>  
>  	is->irq = irq_of_parse_and_map(dev->of_node, 0);
>  	if (!is->irq) {

