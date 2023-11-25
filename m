Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 770B27F8A8B
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 13:07:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232075AbjKYMH0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 07:07:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232047AbjKYMHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 07:07:01 -0500
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2AA619B1;
        Sat, 25 Nov 2023 04:07:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=z3ntu;
        t=1700914026; bh=ghC3Lj4juPjhri9NNx8UZDzafbVL+7tJBOKiMXB0qU0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=hqu9RjBrkBOvlin79eOVfWRmNUYjkGfyASjVkmOTNQ5teANZtKW5NQaoVNu2zdbqu
         ZY1+iUwwPL2hb4/yHDS80lE/2qySSKxznoJ4Y6BAz21ogG0QNoCl9ic6z5sMU+/1e3
         RozXMWP3bBdtcta8lnIKQvBT8666X0CBrURQlUVk=
From:   Luca Weiss <luca@z3ntu.xyz>
To:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Rob Clark <robdclark@gmail.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>
Cc:     iommu@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Vladimir Lypak <vladimir.lypak@gmail.com>
Subject: Re: [PATCH] iommu/qcom: restore IOMMU state if needed
Date:   Sat, 25 Nov 2023 13:07:05 +0100
Message-ID: <4525320.LvFx2qVVIh@z3ntu.xyz>
In-Reply-To: <20231011-msm8953-iommu-restore-v1-1-48a0c93809a2@z3ntu.xyz>
References: <20231011-msm8953-iommu-restore-v1-1-48a0c93809a2@z3ntu.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mittwoch, 11. Oktober 2023 19:57:26 CET Luca Weiss wrote:
> From: Vladimir Lypak <vladimir.lypak@gmail.com>
> 
> If the IOMMU has a power domain then some state will be lost in
> qcom_iommu_suspend and TZ will reset device if we don't call
> qcom_scm_restore_sec_cfg before accessing it again.
> 
> Signed-off-by: Vladimir Lypak <vladimir.lypak@gmail.com>
> [luca@z3ntu.xyz: reword commit message a bit]
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> ---
> This patch is required for MSM8953 GPU IOMMU.
> 
> See also downstream sources:
> https://git.codelinaro.org/clo/la/kernel/msm-4.9/-/commit/f8464885dafc5b780b
> 85de29d92a08c692d3a4d0
> https://git.codelinaro.org/clo/la/kernel/msm-4.9/-/blob/LA.UM.10.6.2.r1-025
> 00-89xx.0/drivers/iommu/arm-smmu.c#L4221-4225
> 
> Since the compatibles provided by this driver (qcom,msm-iommu-v*) is
> only used on msm8916, msm8939 and msm8953, and both 8916 and 8939 don't
> have a power domain on the IOMMU, I also don't expect anything to break
> there.

Hi all,

Any feedback on this patch?

Regards
Luca

> ---
>  drivers/iommu/arm/arm-smmu/qcom_iommu.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu/qcom_iommu.c
> b/drivers/iommu/arm/arm-smmu/qcom_iommu.c index 97b2122032b2..67abeb02cf53
> 100644
> --- a/drivers/iommu/arm/arm-smmu/qcom_iommu.c
> +++ b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
> @@ -900,8 +900,16 @@ static void qcom_iommu_device_remove(struct
> platform_device *pdev) static int __maybe_unused qcom_iommu_resume(struct
> device *dev)
>  {
>  	struct qcom_iommu_dev *qcom_iommu = dev_get_drvdata(dev);
> +	int ret;
> +
> +	ret = clk_bulk_prepare_enable(CLK_NUM, qcom_iommu->clks);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (dev->pm_domain)
> +		return qcom_scm_restore_sec_cfg(qcom_iommu->sec_id, 0);
> 
> -	return clk_bulk_prepare_enable(CLK_NUM, qcom_iommu->clks);
> +	return ret;
>  }
> 
>  static int __maybe_unused qcom_iommu_suspend(struct device *dev)
> 
> ---
> base-commit: 2933a1156742d8c47550493a77af8e2d81cf3c84
> change-id: 20231011-msm8953-iommu-restore-fabc2e31fee7
> 
> Best regards,




