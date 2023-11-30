Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C61CB7FE897
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 06:23:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231688AbjK3FV0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 00:21:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjK3FVY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 00:21:24 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DA78D7F
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 21:21:30 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F4E4C433C8;
        Thu, 30 Nov 2023 05:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701321689;
        bh=SO7acnA+VBGiPPDRPjeZV0L8lWsY1H783sV0wpnMOCU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NfwJ87uKmQi0TjpEJJbc7uduVpBnZVRjYsbqNfzn7Ia4vqX6P5Szj69chlJbr71rt
         T7F/4We3/8qz7OeKwcKbcACPT9Z2KT+w82AY97DOx64vJKQnB4JR/bfNHr2hwPWVsv
         4p6d74/B+u39ZasqQ4QdbOgMbzaw+DueKKuXemlALO8HakEtfJ7avdNhU+0249Jwk5
         19Jhp8eEaXtg/U3ICZMY35kyutXWNJP0NmrOtV6SjnMmJWxOXkv8NRopv3wSZ8+4sb
         o/TWHtwlOfpYNUxuuU+BqQ0lcX1GHdKcsgqWsgzKoz74QLB7vi78xFjzwLfy+3ag/w
         3EQYo0DhUNjPw==
Date:   Thu, 30 Nov 2023 10:51:16 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Mrinmay Sarkar <quic_msarkar@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        konrad.dybcio@linaro.org, mani@kernel.org, robh+dt@kernel.org,
        quic_shazhuss@quicinc.com, quic_nitegupt@quicinc.com,
        quic_ramkri@quicinc.com, quic_nayiluri@quicinc.com,
        dmitry.baryshkov@linaro.org, robh@kernel.org,
        quic_krichai@quicinc.com, quic_vbadigan@quicinc.com,
        quic_parass@quicinc.com, quic_schintav@quicinc.com,
        quic_shijjose@quicinc.com,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v4 1/3] PCI: qcom: Enable cache coherency for SA8775P RC
Message-ID: <20231130052116.GA3043@thinkpad>
References: <1700577493-18538-1-git-send-email-quic_msarkar@quicinc.com>
 <1700577493-18538-2-git-send-email-quic_msarkar@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1700577493-18538-2-git-send-email-quic_msarkar@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 21, 2023 at 08:08:11PM +0530, Mrinmay Sarkar wrote:
> In a multiprocessor system cache snooping maintains the consistency
> of caches. Snooping logic is disabled from HW on this platform.
> Cache coherency doesn’t work without enabling this logic.
> 
> 8775 has IP version 1.34.0 so intruduce a new cfg(cfg_1_34_0) for this
> platform. Assign no_snoop_override flag into struct qcom_pcie_cfg and
> set it true in cfg_1_34_0 and enable cache snooping if this particular
> flag is true.
> 

I just happen to check the internal register details of other platforms and I
see this PCIE_PARF_NO_SNOOP_OVERIDE register with the reset value of 0x0. So
going by the logic of this patch, this register needs to be configured for other
platforms as well to enable cache coherency, but it seems like not the case as
we never did and all are working fine (so far no issues reported).

So this gives me an impression that this patch is wrong or needs modification.
So,

Nacked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> Signed-off-by: Mrinmay Sarkar <quic_msarkar@quicinc.com>
> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 20 +++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index 6902e97..76f03fc 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -51,6 +51,7 @@
>  #define PARF_SID_OFFSET				0x234
>  #define PARF_BDF_TRANSLATE_CFG			0x24c
>  #define PARF_SLV_ADDR_SPACE_SIZE		0x358
> +#define PCIE_PARF_NO_SNOOP_OVERIDE		0x3d4
>  #define PARF_DEVICE_TYPE			0x1000
>  #define PARF_BDF_TO_SID_TABLE_N			0x2000
>  
> @@ -117,6 +118,10 @@
>  /* PARF_LTSSM register fields */
>  #define LTSSM_EN				BIT(8)
>  
> +/* PARF_NO_SNOOP_OVERIDE register fields */
> +#define WR_NO_SNOOP_OVERIDE_EN			BIT(1)
> +#define RD_NO_SNOOP_OVERIDE_EN			BIT(3)
> +
>  /* PARF_DEVICE_TYPE register fields */
>  #define DEVICE_TYPE_RC				0x4
>  
> @@ -229,6 +234,7 @@ struct qcom_pcie_ops {
>  
>  struct qcom_pcie_cfg {
>  	const struct qcom_pcie_ops *ops;
> +	bool no_snoop_overide;

I'd suggest to name variables after their usecase and not the register. Like,

bool enable_cache_snoop;

>  };
>  
>  struct qcom_pcie {
> @@ -961,6 +967,13 @@ static int qcom_pcie_init_2_7_0(struct qcom_pcie *pcie)
>  
>  static int qcom_pcie_post_init_2_7_0(struct qcom_pcie *pcie)
>  {
> +	const struct qcom_pcie_cfg *pcie_cfg = pcie->cfg;
> +
> +	/* Enable cache snooping for SA8775P */

This comment doesn't belong here. It can be added while setting the flag in cfg.

> +	if (pcie_cfg->no_snoop_overide)
> +		writel(WR_NO_SNOOP_OVERIDE_EN | RD_NO_SNOOP_OVERIDE_EN,
> +				pcie->parf + PCIE_PARF_NO_SNOOP_OVERIDE);
> +
>  	qcom_pcie_clear_hpc(pcie->pci);
>  
>  	return 0;
> @@ -1331,6 +1344,11 @@ static const struct qcom_pcie_cfg cfg_1_9_0 = {
>  	.ops = &ops_1_9_0,
>  };
>  
> +static const struct qcom_pcie_cfg cfg_1_34_0 = {
> +	.ops = &ops_1_9_0,
> +	.no_snoop_overide = true,
> +};
> +
>  static const struct qcom_pcie_cfg cfg_2_1_0 = {
>  	.ops = &ops_2_1_0,
>  };
> @@ -1627,7 +1645,7 @@ static const struct of_device_id qcom_pcie_match[] = {
>  	{ .compatible = "qcom,pcie-msm8996", .data = &cfg_2_3_2 },
>  	{ .compatible = "qcom,pcie-qcs404", .data = &cfg_2_4_0 },
>  	{ .compatible = "qcom,pcie-sa8540p", .data = &cfg_1_9_0 },
> -	{ .compatible = "qcom,pcie-sa8775p", .data = &cfg_1_9_0},
> +	{ .compatible = "qcom,pcie-sa8775p", .data = &cfg_1_34_0},
>  	{ .compatible = "qcom,pcie-sc7280", .data = &cfg_1_9_0 },
>  	{ .compatible = "qcom,pcie-sc8180x", .data = &cfg_1_9_0 },
>  	{ .compatible = "qcom,pcie-sc8280xp", .data = &cfg_1_9_0 },
> -- 
> 2.7.4
> 
> 

-- 
மணிவண்ணன் சதாசிவம்
