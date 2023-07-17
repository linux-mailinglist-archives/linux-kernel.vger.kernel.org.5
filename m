Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C0C17565BA
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 16:04:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231929AbjGQOEL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 10:04:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjGQOEJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 10:04:09 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2077.outbound.protection.outlook.com [40.107.104.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDFCDBD;
        Mon, 17 Jul 2023 07:04:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k+CAtboDvHE20SJA4YoXEhSt+vmOgkp6GjH2N6y+YsX7l4L3K+GKSL0TyqUzMsVOkNuX28iUEBJG2Oz8+2XMljUGM/FXlmWsPOfxfMiMShbzDhcPZ6djxBplaP/LsKz2Ds0xvasw7tcLPGqHPDuGpIlW74ysiD1suOH9MROBhcdQVZzQELjlt6syFzVEgEyoFGkUpclYhnn06vfnzegIn3OMqpNRscyfuLwUNjXnFo17xm18B/qnuE4z0oXU4fI+WQqSL0yGo4k1U2XBNPxDv4RO3vT14h4djwFKPd0to4rkIT99OwVKN+yBt+eTsdcMs9YVroJsYfgkY4JhQyWgcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mkoGyVKFdFviGLewY+xFT3Ty6gaSA6LjQMbPZLTn1fU=;
 b=b6I1zPh2eqXkx3SRa4lOoAUQNzRqw2eDyx4xDVniORHr/sQEIw38n9YSt/34aiJwH0XskyCYPzWIZjcjd8CZB+Mn+id206LAAMp96FTS/aP9L3Zg9TTPqBR4Mv+gr4/umoF5e9TMidg+CwquBVeT54rCQ1Jo2Q+NzJtZMJvTgBcbF8oXBJ7zMS2TbN4Vl2deaxySCn3gt9/KSwNulqI8iLFwcZcTizTjapuVxUeO4L91SOFrpFNQtjv9CxWwjvIppwUOvK7j3Oh7AHGFSKQzaPqJPYUElSXmPQJ/3o/hR7T6jvfJBbJd6kReJI870FlWhs7Po+++G8GzHHbc60aJtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mkoGyVKFdFviGLewY+xFT3Ty6gaSA6LjQMbPZLTn1fU=;
 b=Xu5mkt5OS5pN4wL8/1txJxc6mbhSyRMuQwEcrUoRG86ZdBvXI+XVhzpYKwEupf6Bzaq/1pItLGaMIsJbuBIl4q/P7CwRpdYiacXdBJQ+AcJy/m46MVin/kTOa+B9WwpH/pzZrcKB7huUkVWMcaKGRxfudC/jDOzUxrBV/W8QE2w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AS8PR04MB7736.eurprd04.prod.outlook.com (2603:10a6:20b:2af::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Mon, 17 Jul
 2023 14:04:05 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::6cc2:14b2:ca51:6c0]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::6cc2:14b2:ca51:6c0%4]) with mapi id 15.20.6588.031; Mon, 17 Jul 2023
 14:04:05 +0000
Date:   Mon, 17 Jul 2023 10:03:52 -0400
From:   Frank Li <Frank.li@nxp.com>
To:     mani@kernel.org, Minghuan Lian <minghuan.Lian@nxp.com>,
        Mingkai Hu <mingkai.hu@nxp.com>, Roy Zang <roy.zang@nxp.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "open list:PCI DRIVER FOR FREESCALE LAYERSCAPE" 
        <linuxppc-dev@lists.ozlabs.org>,
        "open list:PCI DRIVER FOR FREESCALE LAYERSCAPE" 
        <linux-pci@vger.kernel.org>,
        "moderated list:PCI DRIVER FOR FREESCALE LAYERSCAPE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] PCI: layerscape: Add the workaround for lost link
 capablities during reset
Message-ID: <ZLVKSKUkDQO+MlKp@lizhi-Precision-Tower-5810>
References: <20230615164113.2270698-1-Frank.Li@nxp.com>
 <20230615164113.2270698-2-Frank.Li@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230615164113.2270698-2-Frank.Li@nxp.com>
X-ClientProxiedBy: BYAPR01CA0003.prod.exchangelabs.com (2603:10b6:a02:80::16)
 To AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|AS8PR04MB7736:EE_
X-MS-Office365-Filtering-Correlation-Id: b34384ad-964e-43df-bcc5-08db86ceaead
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eyR7Iuesww0PnWR1Xqezuo18NYUTKXpNwnAQ27MvIQqmqPCWq32qGFmogmzb8gUlda3wPHw1AUy8l4UEoOwTjYCFVyx0gp1kRXmuzEu7iL3SNEQy67pH58+96bmjpXtYTYu1szyF0avmFwuyIdBpoSehuO4ODY7D2qfqOnLJZLRHSMiCuup15zytN7YvTPbh5XzSrXE8+64Dxe789qVsAos58O8gcix8YyL9Qq6ZcPyG3FBWaNZ7c6WPAhr4QtoGLmltsS6SS8h3KS24QFfin3SVxCrk2vK3ebKvh/LynmyAH97XwFIQg3w1PNx15+HAona1n8uSSQYbLNlyMsnI+bH6vGXvqcB0l++EmhgGffV/aQ+kEzPSML0S2gKBYtzGSp+BOVvdQIOy3saQxmn5uUAKQ6/8Z7ApMtNoSqfdahZxl8epXwajOQl+HUMorBnaTTOBhxm/0xqNFSAwKxj6E9/d5BBdfYT0z4KW6xRPHDVh56roeHA7D2TjOhNcztcn5gdaV+amXr7Dv0EjjzTGlTHzPhuR6aACKCGJIzJ9+K4/pvD2mrFYbeBOhcmghb3VjSOS3pZk6I5A9uAKGl7dResTvN4G/VltGLJdpi/EwK4HrY1JQWho/HkGpQBjrRK2PL0InfTHMDsxymMs7t/6TdYi0MyLk1oXJE5dXtMl7PU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(7916004)(376002)(136003)(39860400002)(396003)(366004)(346002)(451199021)(9686003)(6512007)(26005)(6506007)(921005)(66476007)(8676002)(8936002)(5660300002)(33716001)(316002)(110136005)(41300700001)(66556008)(66946007)(38100700002)(38350700002)(6666004)(2906002)(52116002)(478600001)(86362001)(6486002)(186003)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DwlRIizdUKu/rhonofVIF20Q2lXWNc0Q3wcRjCbdwwad7kFH89OjFzEFwB0I?=
 =?us-ascii?Q?thlsFtjhw4RcZs2n6bVKC9miLINPwcZlxJGN5HRP8fPTEPdqfQWKOdT1o9o1?=
 =?us-ascii?Q?2htflbk3GUyp6Sz3+9T2NVeTsAVkr31+AITA0fQwEF9WXtWmcGq4xngH++VA?=
 =?us-ascii?Q?YouHfhdYP0qdJwu6nJJu24N8IOBw8fPDh50GoaiKrQ8tR7CJY0HtsaXaIl7y?=
 =?us-ascii?Q?fXo+3gaIwzGW8iQ4fSm4VDfidpP9vlrjI2ch3GPOXnUACO24TykOYXjzhla9?=
 =?us-ascii?Q?fMS7ji2nGTrIeIF47z4QCDVovMenKHX7Cg66Uxj+vu2+QvBfPYGngS+BzMIB?=
 =?us-ascii?Q?+YiL7wCHjWTZHssu6NM3kfQ79bsjhzREPObXBLn0MnyrnWn3n11Z4+mom9SX?=
 =?us-ascii?Q?FsT/L7tdRZN2ZrR1aNDuybxOMvEzWPWZIOMSAF84XeSUH4GNrJ1dU+eRP0+i?=
 =?us-ascii?Q?mpahmZ9QH4qynyBJQ0MPzm2i6SGzdE4smjNlM+jO075SpMWYUlVbnYJtbgrQ?=
 =?us-ascii?Q?zxChfxGscI4rKe3pOOJ7Ll0DGJ0sf1wyJSLeTN2ZboHMkYevrqh/1BDf2T/D?=
 =?us-ascii?Q?Mlvle5udfD29DWT0+wIzeIfp1t3qVE4Aen3R6IYEjB9pHP2p+4yajH5M7SUH?=
 =?us-ascii?Q?vY9e46Q3h+gBxbgcQSq1BbJ6LBH6q+7D2tU2DG32JRsGdYrm1KqX8QSXXd9U?=
 =?us-ascii?Q?etFzfSaDWBVbPLC+aZdwCgcD/HUyCc6CB8rg1hlt8Tk4JaEdaeYNweVhvHo9?=
 =?us-ascii?Q?+NW81EQlMPHYFt3nECNxp0I1eujKYAsSLkmTEj43NVncysxEvmIa2a1Nrmsd?=
 =?us-ascii?Q?6cllDVNUYmCzV9BnMOMFFNg49DosgEnjzSygPD13RmKInZ9xDzK1MPJBxoMx?=
 =?us-ascii?Q?xiq+5rglCEOzrEyoBaQuM5naUcAp9xB6M+Pcx4xpLKHc0x5kFbbzL7DGw8Ze?=
 =?us-ascii?Q?M0EqHqciIrh7eQOZ7+K92exEEJOkCsoWsiOP/jOWdkJ2WtMRc/JDH9wkzPLR?=
 =?us-ascii?Q?fvZYYz85TifGYswR7U+ywMLt3oqH1EMjDk9ibmKrTz60OzUk/ocRJ/h36U/u?=
 =?us-ascii?Q?OBq2exy2yCZH/JOiv6K51aEhsXEkkgQ36QPpc4FrtTBNLbaPCMn7gjPZ9sLm?=
 =?us-ascii?Q?HW87gBG8Lj9K+uV2bZejpR3v3Byey2U9MF3yqv3IMXrfEy+whyfy+8cAoqkt?=
 =?us-ascii?Q?cgxE/Uj3gJFlxoRikg/lkqckxQQizn0mQQltpkJ4QRcZYJeYElgAEXIaree3?=
 =?us-ascii?Q?WMsUiWn7ePZo/AqSlPmtjMJjiON/nRNK+mFRIC76RpHEiWCnM+lGr+WIJLQp?=
 =?us-ascii?Q?dtDsb8j0fXZp8wTZ+uFSFS+A5/H74+qDLCaVqtgS63spZA+wRQyVbC9xVAff?=
 =?us-ascii?Q?l7JG0Xd3BCbzs9unkNMyqQ4xnaXRNEonaQMG+f0+NJNb8vLLACS5DOtrW2rJ?=
 =?us-ascii?Q?1Rfl2ScQbQ+aW/UeItRsZO1SBrBV68oKfoTg5NtPbP5fMuT2LAGRIZQMBgSo?=
 =?us-ascii?Q?am6IvNdNvRqMt7F2cjTRaF7qxkh/OQzh8asuEaKn51dOxLKpAs7ov7553+SB?=
 =?us-ascii?Q?3F/SN7YmTbxGw0NKHSe/MtYybIexYdy2ExWlq9Wk?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b34384ad-964e-43df-bcc5-08db86ceaead
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2023 14:04:05.6294
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B5dNs5MyC0jaBDnaUBb0F75C+QRPrFe2QckZxo3hbG7861DMAUalSWiRTHcPm7e1NrqGDZn6mL+GBVYOSt7d2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7736
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 15, 2023 at 12:41:12PM -0400, Frank Li wrote:
> From: Xiaowei Bao <xiaowei.bao@nxp.com>
> 
> A workaround for the issue where the PCI Express Endpoint (EP) controller
> loses the values of the Maximum Link Width and Supported Link Speed from
> the Link Capabilities Register, which initially configured by the Reset
> Configuration Word (RCW) during a link-down or hot reset event.
> 
> Signed-off-by: Xiaowei Bao <xiaowei.bao@nxp.com>
> Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---

@lorenzo:
	It is only for layerscape and workaround a small errata.
	Could you please pick this up?

Frank

>  drivers/pci/controller/dwc/pci-layerscape-ep.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pci-layerscape-ep.c b/drivers/pci/controller/dwc/pci-layerscape-ep.c
> index 4e4fdd1dfea7..2ef02d827eeb 100644
> --- a/drivers/pci/controller/dwc/pci-layerscape-ep.c
> +++ b/drivers/pci/controller/dwc/pci-layerscape-ep.c
> @@ -45,6 +45,7 @@ struct ls_pcie_ep {
>  	struct pci_epc_features		*ls_epc;
>  	const struct ls_pcie_ep_drvdata *drvdata;
>  	int				irq;
> +	u32				lnkcap;
>  	bool				big_endian;
>  };
>  
> @@ -73,6 +74,7 @@ static irqreturn_t ls_pcie_ep_event_handler(int irq, void *dev_id)
>  	struct ls_pcie_ep *pcie = dev_id;
>  	struct dw_pcie *pci = pcie->pci;
>  	u32 val, cfg;
> +	u8 offset;
>  
>  	val = ls_lut_readl(pcie, PEX_PF0_PME_MES_DR);
>  	ls_lut_writel(pcie, PEX_PF0_PME_MES_DR, val);
> @@ -81,6 +83,13 @@ static irqreturn_t ls_pcie_ep_event_handler(int irq, void *dev_id)
>  		return IRQ_NONE;
>  
>  	if (val & PEX_PF0_PME_MES_DR_LUD) {
> +
> +		offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
> +
> +		dw_pcie_dbi_ro_wr_en(pci);
> +		dw_pcie_writew_dbi(pci, offset + PCI_EXP_LNKCAP, pcie->lnkcap);
> +		dw_pcie_dbi_ro_wr_dis(pci);
> +
>  		cfg = ls_lut_readl(pcie, PEX_PF0_CONFIG);
>  		cfg |= PEX_PF0_CFG_READY;
>  		ls_lut_writel(pcie, PEX_PF0_CONFIG, cfg);
> @@ -216,6 +225,7 @@ static int __init ls_pcie_ep_probe(struct platform_device *pdev)
>  	struct ls_pcie_ep *pcie;
>  	struct pci_epc_features *ls_epc;
>  	struct resource *dbi_base;
> +	u8 offset;
>  	int ret;
>  
>  	pcie = devm_kzalloc(dev, sizeof(*pcie), GFP_KERNEL);
> @@ -252,6 +262,9 @@ static int __init ls_pcie_ep_probe(struct platform_device *pdev)
>  
>  	platform_set_drvdata(pdev, pcie);
>  
> +	offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
> +	pcie->lnkcap = dw_pcie_readl_dbi(pci, offset + PCI_EXP_LNKCAP);
> +
>  	ret = dw_pcie_ep_init(&pci->ep);
>  	if (ret)
>  		return ret;
> -- 
> 2.34.1
> 
