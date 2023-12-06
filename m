Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8457C8075EA
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 18:00:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbjLFQ7v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 11:59:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjLFQ7t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 11:59:49 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09F13C9
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 08:59:56 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62A39C433C8;
        Wed,  6 Dec 2023 16:59:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701881995;
        bh=xdGLbLZlKz6hqDzxxH4MqX0sG3ItG6KAFGtCvH4gnsg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=MJOLyo52HSa1ezkiZilGDaJk8L3Ol+4TVWOFf2jN/7JZLdwsFDlmL2DvKVIonkRdi
         3fh5GT7VbTejQ/xnXDT4CHQXfs6JwDdajAVQGRpWv+BrPWR7T16yt2bI4sh8QmVU/U
         NEO/F5c0EVGAgGrAcr3sMeLNty1noQR5qil2W0V/kYk4ci4M97mv8ecRo/e3l1V5zV
         qQ3TqEMfeJaGNX2XEBnCPKj/J36uThgLrbIM6SOC3ilUXEAdNQ0LdOvybK/ykg4Dw2
         rC8p+XzXdMWcPRwjqqjvFnFbWkbQLhfKpf7lnFWNAdDNZK7wI9Ib3eWTm5C1dlEzeU
         1tWiAKmXvvduw==
Date:   Wed, 6 Dec 2023 10:59:53 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Frank Li <Frank.li@nxp.com>
Cc:     imx@lists.linux.dev, Richard Zhu <hongxing.zhu@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        "open list:PCI DRIVER FOR IMX6" <linux-pci@vger.kernel.org>,
        "moderated list:PCI DRIVER FOR IMX6" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/9] PCI: imx6: Using "linux,pci-domain" as slot ID
Message-ID: <20231206165953.GA717921@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZXCmSOwTWR6AVpGB@lizhi-Precision-Tower-5810>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 06, 2023 at 11:50:16AM -0500, Frank Li wrote:
> On Wed, Dec 06, 2023 at 10:36:56AM -0600, Bjorn Helgaas wrote:
> > In subject, maybe you mean "Use 'linux,pci-domain' as slot ID"?
> > "Using" is the wrong verb form here.
> > 
> > On Wed, Dec 06, 2023 at 10:58:58AM -0500, Frank Li wrote:
> > > Avoid use get slot id by compared with register physical address. If there
> > > are more than 2 slots, compared logic will become complex.
> > 
> > But this doesn't say anything about "linux,pci-domain", and I don't
> > see anything about a register physical address in the patch.
> > 
> > Maybe this commit log was meant for a different patch?  I'm confused.
> > 
> > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > ---
> > >  drivers/pci/controller/dwc/pci-imx6.c | 6 ++++++
> > >  1 file changed, 6 insertions(+)
> > > 
> > > diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> > > index 62d77fabd82a..239ef439ba70 100644
> > > --- a/drivers/pci/controller/dwc/pci-imx6.c
> > > +++ b/drivers/pci/controller/dwc/pci-imx6.c
> > > @@ -33,6 +33,7 @@
> > >  #include <linux/pm_domain.h>
> > >  #include <linux/pm_runtime.h>
> > >  
> > > +#include "../../pci.h"
> > >  #include "pcie-designware.h"
> > >  
> > >  #define IMX8MQ_GPR_PCIE_REF_USE_PAD		BIT(9)
> > > @@ -1333,6 +1334,11 @@ static int imx6_pcie_probe(struct platform_device *pdev)
> > >  					     "Failed to get PCIEPHY reset control\n");
> > >  	}
> > >  
> > > +	/* Using linux,pci-domain as PCI slot id */
> > > +	imx6_pcie->controller_id = of_get_pci_domain_nr(node);
> > > +	if (imx6_pcie->controller_id)
> > > +		imx6_pcie->controller_id = 0;
> > 
> > I don't understand what this is doing.  It looks the same as just:
> 
> Good capture. It should be 
> if (imx6_pcie->controller_id < 0)
> 	imx6_pcie->controller_id = 0;
> 
> for only one PCI controller case. I just tested first one slot before send
> patch, so not met problem.
> 
> Previously, we use below logic
> 	if (dbi_base->start == IMX8MQ_PCIE2_BASE_ADDR)
> 		imx6_pcie->controller_id = 1;
> 
> It is not good to depend on register's base address. If there are 3
> controllers, check logic will becomoe ugly.

Makes sense.  If the previous code depended on the base address, this
patch would make more sense if it contained both the addition of the
of_get_pci_domain_nr() call and the removal of the base address code.

> > Maybe this is a typo?  As written, it doesn't look like there's any
> > point in calling of_get_pci_domain_nr().
> > 
> > >  	switch (imx6_pcie->drvdata->variant) {
> > >  	case IMX7D:
> > >  		if (dbi_base->start == IMX8MQ_PCIE2_BASE_ADDR)
> > > -- 
> > > 2.34.1
> > > 
