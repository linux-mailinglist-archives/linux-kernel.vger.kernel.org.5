Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2DAF7FF67B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 17:43:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231919AbjK3Qna (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 11:43:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjK3Qn2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 11:43:28 -0500
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 720FF1A4
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 08:43:34 -0800 (PST)
Received: by mail-qk1-x736.google.com with SMTP id af79cd13be357-77dce4d41d5so53167285a.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 08:43:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701362613; x=1701967413; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RR929/inZVg6ya67dtiU9fWfLeIFrIte2BBVvFM3wXQ=;
        b=HmxIyeJNVIfhI91z4I4taCKSgVTQAnVmw5/WZSg6X+OrUih1amauSkEyKTklWSn2vA
         bRK95k8lXbk5fH6Cq8s81QRkZxuWP/81lq8aGrehCtld72wBsyYLcgq/8OnDlG1S13Up
         FFzP0DFlgMped4sHRADVsGciyRGDzsGCRW0DdwXiXyih1m4JcLJ+ZDql8p+1LyGnx1ET
         1LI4TQvT+1Sobs3dfKYJb9Yyzls4FUC63lSCgQpWCJU5JOuYFGDRK0KLTddcv4B4JBUd
         qVzHakvPQNJfKGfJgT7qG3WPWY6srlppdWbeQkdaqgeWowI7/9tuHYRIISpWMS8ftTfw
         N1HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701362613; x=1701967413;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RR929/inZVg6ya67dtiU9fWfLeIFrIte2BBVvFM3wXQ=;
        b=ZWq4Ln2Je1/ipH9otrdLmiUEMKJjsFugIeSMzkrLmiWdO+aOYSic9GWHaJ8RTf8/zS
         RaYLOzcsbBFDJDvLKJzkfLwFYbFW+d+00kEkJCN4cYc2sugG8bnyghHE4fVgOuBnlsu2
         3DYgL5RnJm32yXA94Jt9K4cwXDn7fvZwPe9Vm4+CWPu1HUO0IPnnLch2QST0ZJCRpFHJ
         Bsjh93h6Xs2ZRmYeDCLgwK8uGQIHOvcYx8VCYkDfhnYLNsXtcddwttUkddRsTZxADOUI
         UCWbZfc0Dvo0M1lp/bANrbzOJTPQqviQ9Zd+LykpIUUlUxYt4Ub/qDZ5nn3WBxCbtDjy
         LNaQ==
X-Gm-Message-State: AOJu0YyonMI5dSK6/34GIBv0HmnVCMpUur79Ew+EQCFRzsiLnNbvX1IC
        qONo8zV/+9qcdA4evCpCNkaO
X-Google-Smtp-Source: AGHT+IH4fdEjtTxeNLnBTzLGisqbKQLWEsMOBV/mouxbIc6qh43GktT+t9VymOEMBtx9xmzDq1qiMw==
X-Received: by 2002:a05:620a:269d:b0:77d:9dc9:cd05 with SMTP id c29-20020a05620a269d00b0077d9dc9cd05mr16628267qkp.11.1701362613426;
        Thu, 30 Nov 2023 08:43:33 -0800 (PST)
Received: from thinkpad ([117.213.102.92])
        by smtp.gmail.com with ESMTPSA id bm27-20020a05620a199b00b0077da0832d6csm639505qkb.22.2023.11.30.08.43.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 08:43:32 -0800 (PST)
Date:   Thu, 30 Nov 2023 22:13:23 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Frank Li <Frank.Li@nxp.com>
Cc:     bhelgaas@google.com, imx@lists.linux.dev, kw@linux.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        lpieralisi@kernel.org, minghuan.Lian@nxp.com, mingkai.hu@nxp.com,
        robh@kernel.org, roy.zang@nxp.com
Subject: Re: [PATCH v4 2/4] PCI: layerscape: Add suspend/resume for ls1021a
Message-ID: <20231130164323.GT3043@thinkpad>
References: <20231129214412.327633-1-Frank.Li@nxp.com>
 <20231129214412.327633-3-Frank.Li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231129214412.327633-3-Frank.Li@nxp.com>
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 29, 2023 at 04:44:10PM -0500, Frank Li wrote:
> ls1021a add suspend/resume support.
> 

"Add suspend/resume support for Layerscape LS1021a"

> In the suspend path, PME_Turn_Off message is sent to the endpoint to
> transition the link to L2/L3_Ready state. In this SoC, there is no way to
> check if the controller has received the PME_To_Ack from the endpoint or
> not. So to be on the safer side, the driver just waits for
> PCIE_PME_TO_L2_TIMEOUT_US before asserting the SoC specific PMXMTTURNOFF
> bit to complete the PME_Turn_Off handshake. This link would then enter

"Then the link would enter L2/L3 state depending on the VAUX supply."

> L2/L3 state depending on the VAUX supply.
> 
> In the resume path, the link is brought back from L2 to L0 by doing a
> software reset.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Couple of comments below. But the patch is looking good now. Thanks for the
update.

> ---
> 
> Notes:
>     Change from v3 to v4
>     - update commit message.
>     - it is reset a glue logic part for PCI controller.
>     - use regmap_write_bits() to reduce code change.
>     
>     Change from v2 to v3
>     - update according to mani's feedback
>     change from v1 to v2
>     - change subject 'a' to 'A'
> 
>  drivers/pci/controller/dwc/pci-layerscape.c | 83 ++++++++++++++++++++-
>  1 file changed, 82 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-layerscape.c b/drivers/pci/controller/dwc/pci-layerscape.c
> index aea89926bcc4f..42bca2c3b5c3e 100644
> --- a/drivers/pci/controller/dwc/pci-layerscape.c
> +++ b/drivers/pci/controller/dwc/pci-layerscape.c
> @@ -35,11 +35,19 @@
>  #define PF_MCR_PTOMR		BIT(0)
>  #define PF_MCR_EXL2S		BIT(1)
>  
> +/* LS1021A PEXn PM Write Control Register */
> +#define SCFG_PEXPMWRCR(idx)	(0x5c + (idx) * 0x64)
> +#define PMXMTTURNOFF		BIT(31)
> +#define SCFG_PEXSFTRSTCR	0x190
> +#define PEXSR(idx)		BIT(idx)
> +
>  #define PCIE_IATU_NUM		6
>  
>  struct ls_pcie_drvdata {
>  	const u32 pf_off;
> +	const struct dw_pcie_host_ops *ops;
>  	int (*exit_from_l2)(struct dw_pcie_rp *pp);
> +	bool scfg_support;
>  	bool pm_support;
>  };
>  
> @@ -47,6 +55,8 @@ struct ls_pcie {
>  	struct dw_pcie *pci;
>  	const struct ls_pcie_drvdata *drvdata;
>  	void __iomem *pf_base;
> +	struct regmap *scfg;
> +	int index;
>  	bool big_endian;
>  };
>  
> @@ -171,13 +181,65 @@ static int ls_pcie_host_init(struct dw_pcie_rp *pp)
>  	return 0;
>  }
>  
> +static void scfg_pcie_send_turnoff_msg(struct regmap *scfg, u32 reg, u32 mask)
> +{
> +	/* Send PME_Turn_Off message */
> +	regmap_write_bits(scfg, reg, mask, mask);
> +
> +	/*
> +	 * There is no specific register to check for PME_To_Ack from endpoint.
> +	 * So on the safe side, wait for PCIE_PME_TO_L2_TIMEOUT_US.
> +	 */
> +	mdelay(PCIE_PME_TO_L2_TIMEOUT_US/1000);
> +
> +	/*
> +	 * Layerscape hardware reference manual recommends clearing the PMXMTTURNOFF bit
> +	 * to complete the PME_Turn_Off handshake.
> +	 */
> +	regmap_write_bits(scfg, reg, mask, 0);
> +}
> +
> +static void ls1021a_pcie_send_turnoff_msg(struct dw_pcie_rp *pp)
> +{
> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> +	struct ls_pcie *pcie = to_ls_pcie(pci);
> +
> +	scfg_pcie_send_turnoff_msg(pcie->scfg, SCFG_PEXPMWRCR(pcie->index), PMXMTTURNOFF);
> +}
> +
> +static int scfg_pcie_exit_from_l2(struct regmap *scfg, u32 reg, u32 mask)
> +{
> +	/* Only way exit from l2 is that do software reset */

"Only way exit from L2 is by doing a software reset of the controller"

I really hope that the reset is not a global controller reset i.e., not
resetting all CSRs.

> +	regmap_write_bits(scfg, reg, mask, mask);
> +

No need of a newline.

> +	regmap_write_bits(scfg, reg, mask, 0);
> +
> +	return 0;
> +}
> +
> +static int ls1021a_pcie_exit_from_l2(struct dw_pcie_rp *pp)
> +{
> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> +	struct ls_pcie *pcie = to_ls_pcie(pci);
> +
> +	return scfg_pcie_exit_from_l2(pcie->scfg, SCFG_PEXSFTRSTCR, PEXSR(pcie->index));
> +}
> +
>  static const struct dw_pcie_host_ops ls_pcie_host_ops = {
>  	.host_init = ls_pcie_host_init,
>  	.pme_turn_off = ls_pcie_send_turnoff_msg,
>  };
>  
> +static const struct dw_pcie_host_ops ls1021a_pcie_host_ops = {
> +	.host_init = ls_pcie_host_init,
> +	.pme_turn_off = ls1021a_pcie_send_turnoff_msg,
> +};
> +
>  static const struct ls_pcie_drvdata ls1021a_drvdata = {
> -	.pm_support = false,
> +	.pm_support = true,
> +	.scfg_support = true,
> +	.ops = &ls1021a_pcie_host_ops,
> +	.exit_from_l2 = ls1021a_pcie_exit_from_l2,
>  };
>  
>  static const struct ls_pcie_drvdata layerscape_drvdata = {
> @@ -205,6 +267,8 @@ static int ls_pcie_probe(struct platform_device *pdev)
>  	struct dw_pcie *pci;
>  	struct ls_pcie *pcie;
>  	struct resource *dbi_base;
> +	u32 index[2];
> +	int ret;
>  
>  	pcie = devm_kzalloc(dev, sizeof(*pcie), GFP_KERNEL);
>  	if (!pcie)
> @@ -220,6 +284,7 @@ static int ls_pcie_probe(struct platform_device *pdev)
>  	pci->pp.ops = &ls_pcie_host_ops;
>  
>  	pcie->pci = pci;
> +	pci->pp.ops = pcie->drvdata->ops ? pcie->drvdata->ops : &ls_pcie_host_ops;

pp.ops is already assigned to &ls_pcie_host_ops above. But I think for
consistency, you should pass ls_pcie_host_ops to the "ops" member of
layerscape_drvdata and just use:

	pci->pp.ops = pcie->drvdata->ops;

It looks a lot cleaner.

>  
>  	dbi_base = platform_get_resource_byname(pdev, IORESOURCE_MEM, "regs");
>  	pci->dbi_base = devm_pci_remap_cfg_resource(dev, dbi_base);
> @@ -230,6 +295,22 @@ static int ls_pcie_probe(struct platform_device *pdev)
>  
>  	pcie->pf_base = pci->dbi_base + pcie->drvdata->pf_off;
>  
> +	if (pcie->drvdata->scfg_support) {
> +		pcie->scfg = syscon_regmap_lookup_by_phandle(dev->of_node, "fsl,pcie-scfg");
> +		if (IS_ERR(pcie->scfg)) {
> +			dev_err(dev, "No syscfg phandle specified\n");
> +			return PTR_ERR(pcie->scfg);
> +		}
> +
> +		ret = of_property_read_u32_array(dev->of_node, "fsl,pcie-scfg", index, 2);
> +		if (ret) {
> +			pcie->scfg = NULL;

No need to set it to NULL in the case of probe failure.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
