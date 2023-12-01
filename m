Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A18FB800220
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 04:30:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377187AbjLADak (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 22:30:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjLADai (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 22:30:38 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3C1D12F
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 19:30:43 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C257C433C8;
        Fri,  1 Dec 2023 03:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701401443;
        bh=jwirEr5+4F46Zwbe3mG+0Zko/WcIUe6i503ufifelCI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gEiIdmJx6RpA3BgACWuH5mjB1eR6z1TE5ZvGWVgUfWCu5Cv/1bI41+d3lG1zndu0y
         tp3wUkGLIhwRyl1f8LDjlvIRDNB355AUK3MTrphTYbiVdzjcdk9wvQ2my895PufIK9
         vNdr0+SY0XUWDzzxMLbW3fFyUz5dAGidrJmeHvdGN2fnnscUdVrbKJuufnQKEa9+ki
         JoFMbXRXjF+MfPUwhp4y0ZtKpOZ20cMWGvYz7l9B5NurX9Wh93pX9lVnt3+oolra7+
         EykL0gJEEaRgPCB3d/IsGJLnlLfLzgggDJmJiU/+ZVMJ2YSo7oUNMKxcqTLOtahqxj
         qqK6rzmN4I5Wg==
Date:   Fri, 1 Dec 2023 09:00:28 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Frank Li <Frank.li@nxp.com>
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        bhelgaas@google.com, imx@lists.linux.dev, kw@linux.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        lpieralisi@kernel.org, minghuan.Lian@nxp.com, mingkai.hu@nxp.com,
        robh@kernel.org, roy.zang@nxp.com
Subject: Re: [PATCH v4 4/4] PCI: layerscape: Add suspend/resume for ls1043a
Message-ID: <20231201033028.GB2898@thinkpad>
References: <20231129214412.327633-1-Frank.Li@nxp.com>
 <20231129214412.327633-5-Frank.Li@nxp.com>
 <20231130165100.GV3043@thinkpad>
 <ZWjt412xtyZWVjdL@lizhi-Precision-Tower-5810>
 <ZWju9s/HBS7jNTYX@lizhi-Precision-Tower-5810>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZWju9s/HBS7jNTYX@lizhi-Precision-Tower-5810>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2023 at 03:22:14PM -0500, Frank Li wrote:
> On Thu, Nov 30, 2023 at 03:17:39PM -0500, Frank Li wrote:
> > On Thu, Nov 30, 2023 at 10:21:00PM +0530, Manivannan Sadhasivam wrote:
> > > On Wed, Nov 29, 2023 at 04:44:12PM -0500, Frank Li wrote:
> > > > In the suspend path, PME_Turn_Off message is sent to the endpoint to
> > > > transition the link to L2/L3_Ready state. In this SoC, there is no way to
> > > > check if the controller has received the PME_To_Ack from the endpoint or
> > > > not. So to be on the safer side, the driver just waits for
> > > > PCIE_PME_TO_L2_TIMEOUT_US before asserting the SoC specific PMXMTTURNOFF
> > > > bit to complete the PME_Turn_Off handshake. This link would then enter
> > > > L2/L3 state depending on the VAUX supply.
> > > > 
> > > > In the resume path, the link is brought back from L2 to L0 by doing a
> > > > software reset.
> > > > 
> > > 
> > > Same comment on the patch description as on patch 2/4.
> > > 
> > > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > > ---
> > > > 
> > > > Notes:
> > > >     Change from v3 to v4
> > > >     - Call scfg_pcie_send_turnoff_msg() shared with ls1021a
> > > >     - update commit message
> > > >     
> > > >     Change from v2 to v3
> > > >     - Remove ls_pcie_lut_readl(writel) function
> > > >     
> > > >     Change from v1 to v2
> > > >     - Update subject 'a' to 'A'
> > > > 
> > > >  drivers/pci/controller/dwc/pci-layerscape.c | 63 ++++++++++++++++++++-
> > > >  1 file changed, 62 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/drivers/pci/controller/dwc/pci-layerscape.c b/drivers/pci/controller/dwc/pci-layerscape.c
> > > > index 590e07bb27002..d39700b3afaaa 100644
> > > > --- a/drivers/pci/controller/dwc/pci-layerscape.c
> > > > +++ b/drivers/pci/controller/dwc/pci-layerscape.c
> > > > @@ -41,6 +41,15 @@
> > > >  #define SCFG_PEXSFTRSTCR	0x190
> > > >  #define PEXSR(idx)		BIT(idx)
> > > >  
> > > > +/* LS1043A PEX PME control register */
> > > > +#define SCFG_PEXPMECR		0x144
> > > > +#define PEXPME(idx)		BIT(31 - (idx) * 4)
> > > > +
> > > > +/* LS1043A PEX LUT debug register */
> > > > +#define LS_PCIE_LDBG	0x7fc
> > > > +#define LDBG_SR		BIT(30)
> > > > +#define LDBG_WE		BIT(31)
> > > > +
> > > >  #define PCIE_IATU_NUM		6
> > > >  
> > > >  struct ls_pcie_drvdata {
> > > > @@ -225,6 +234,45 @@ static int ls1021a_pcie_exit_from_l2(struct dw_pcie_rp *pp)
> > > >  	return scfg_pcie_exit_from_l2(pcie->scfg, SCFG_PEXSFTRSTCR, PEXSR(pcie->index));
> > > >  }
> > > >  
> > > > +static void ls1043a_pcie_send_turnoff_msg(struct dw_pcie_rp *pp)
> > > > +{
> > > > +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> > > > +	struct ls_pcie *pcie = to_ls_pcie(pci);
> > > > +
> > > > +	scfg_pcie_send_turnoff_msg(pcie->scfg, SCFG_PEXPMECR, PEXPME(pcie->index));
> > > > +}
> > > > +
> > > > +static int ls1043a_pcie_exit_from_l2(struct dw_pcie_rp *pp)
> > > > +{
> > > > +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> > > > +	struct ls_pcie *pcie = to_ls_pcie(pci);
> > > > +	u32 val;
> > > > +
> > > > +	/*
> > > > +	 * Only way let PEX module exit L2 is do a software reset.
> > > 
> > > Can you expand PEX? What is it used for?
> > > 
> > > Also if the reset is only for the PEX module, please use the same comment in
> > > both patches 2 and 4. Patch 2 doesn't mention PEX in the comment.
> > 
> > After read spec again, I think PEX is pci express. So it should software
> > reset controller. I don't know what exactly did in the chip. But without
> > below code, PCIe can't exit L2/L3.
> > 
> > Any harmful if dwc controller reset? Anyway these code works well with
> > intel network card.
> 
> Sorry, sent too quick. It is PCIe express wrapper
> 
> Copy from spec: 
> 
> "PEXLDBG[SR]. Once set the
> PEXLDBG[SR] will enable the soft reset to the PEX wrapper."
> 

Okay. Please use the below comment in both patches 2 and 4:

/* Reset the PEX wrapper to bring the link out of L2 */

- Mani

> Frank
> 
> > 
> > Frank
> > 
> > > 
> > > - Mani
> > > 
> > > > +	 * LDBG_WE: allows the user to have write access to the PEXDBG[SR] for both setting and
> > > > +	 *	    clearing the soft reset on the PEX module.
> > > > +	 * LDBG_SR: When SR is set to 1, the PEX module enters soft reset.
> > > > +	 */
> > > > +	val = ls_pcie_pf_lut_readl(pcie, LS_PCIE_LDBG);
> > > > +	val |= LDBG_WE;
> > > > +	ls_pcie_pf_lut_writel(pcie, LS_PCIE_LDBG, val);
> > > > +
> > > > +	val = ls_pcie_pf_lut_readl(pcie, LS_PCIE_LDBG);
> > > > +	val |= LDBG_SR;
> > > > +	ls_pcie_pf_lut_writel(pcie, LS_PCIE_LDBG, val);
> > > > +
> > > > +	val = ls_pcie_pf_lut_readl(pcie, LS_PCIE_LDBG);
> > > > +	val &= ~LDBG_SR;
> > > > +	ls_pcie_pf_lut_writel(pcie, LS_PCIE_LDBG, val);
> > > > +
> > > > +	val = ls_pcie_pf_lut_readl(pcie, LS_PCIE_LDBG);
> > > > +	val &= ~LDBG_WE;
> > > > +	ls_pcie_pf_lut_writel(pcie, LS_PCIE_LDBG, val);
> > > > +
> > > > +	return 0;
> > > > +}
> > > > +
> > > >  static const struct dw_pcie_host_ops ls_pcie_host_ops = {
> > > >  	.host_init = ls_pcie_host_init,
> > > >  	.pme_turn_off = ls_pcie_send_turnoff_msg,
> > > > @@ -242,6 +290,19 @@ static const struct ls_pcie_drvdata ls1021a_drvdata = {
> > > >  	.exit_from_l2 = ls1021a_pcie_exit_from_l2,
> > > >  };
> > > >  
> > > > +static const struct dw_pcie_host_ops ls1043a_pcie_host_ops = {
> > > > +	.host_init = ls_pcie_host_init,
> > > > +	.pme_turn_off = ls1043a_pcie_send_turnoff_msg,
> > > > +};
> > > > +
> > > > +static const struct ls_pcie_drvdata ls1043a_drvdata = {
> > > > +	.pf_lut_off = 0x10000,
> > > > +	.pm_support = true,
> > > > +	.scfg_support = true,
> > > > +	.ops = &ls1043a_pcie_host_ops,
> > > > +	.exit_from_l2 = ls1043a_pcie_exit_from_l2,
> > > > +};
> > > > +
> > > >  static const struct ls_pcie_drvdata layerscape_drvdata = {
> > > >  	.pf_lut_off = 0xc0000,
> > > >  	.pm_support = true,
> > > > @@ -252,7 +313,7 @@ static const struct of_device_id ls_pcie_of_match[] = {
> > > >  	{ .compatible = "fsl,ls1012a-pcie", .data = &layerscape_drvdata },
> > > >  	{ .compatible = "fsl,ls1021a-pcie", .data = &ls1021a_drvdata },
> > > >  	{ .compatible = "fsl,ls1028a-pcie", .data = &layerscape_drvdata },
> > > > -	{ .compatible = "fsl,ls1043a-pcie", .data = &ls1021a_drvdata },
> > > > +	{ .compatible = "fsl,ls1043a-pcie", .data = &ls1043a_drvdata },
> > > >  	{ .compatible = "fsl,ls1046a-pcie", .data = &layerscape_drvdata },
> > > >  	{ .compatible = "fsl,ls2080a-pcie", .data = &layerscape_drvdata },
> > > >  	{ .compatible = "fsl,ls2085a-pcie", .data = &layerscape_drvdata },
> > > > -- 
> > > > 2.34.1
> > > > 
> > > 
> > > -- 
> > > மணிவண்ணன் சதாசிவம்

-- 
மணிவண்ணன் சதாசிவம்
