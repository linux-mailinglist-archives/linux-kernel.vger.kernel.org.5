Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B89D7D4BCB
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 11:20:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233952AbjJXJUG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 05:20:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbjJXJT7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 05:19:59 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2040.outbound.protection.outlook.com [40.107.20.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B155C12C
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 02:19:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QeX0+Eq89ZLojoyLCp8sqOOyc/GT9+2S2WN8xcUZ+AKolbQ0jtGQtSBABiaSrc7rcjkX+0vmF9ujRnZy/AACQcW+AKeRjL/o/TxpepEtxnh/wbPZOtbMXf4ifsgZc2NV/Oug2DZlz4NqBTMH2Oz2UmSphkmIDyxczR4rT0251v24Maqd8M1qr+PKVGUu5TBO7j05oiFEogpKmvWMmKMens61KA0A9vAAcp6eQRVNe2f+dd6FO4xHMp/2svphUS4m8UfvHj9hPuPopI7vvTb057y3A6Wm9q6CZ9cD5aoJSycT05taOkw6dDCDRwX6lgdS15IpckQodkbv/oVXHCZWnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x7wtrfbsKc8bs4rkzklPVNLCZo+WJAaOa1RF7VzaRmk=;
 b=SvMotMwVSrcOVppHdnNM0Yud6s5XaoB8RGerhmKHj3m/zZJ70dz1kyzQguMjbVBJymy9NxZFwgotDEfCwa7tU1phivuTiB7FqoLNOxWfsopZJiFxihkbKrz+1kxCgKD13RcnIqlBEvgRjr2qHWnWhmjrDclIp87+B5ZJHMmbYNaiZWHl2EhRdnUOh1r4hKiF4AmwjnJ84q/TdQRaKmZqM2t2uj/Mxov/8DjXAt7LIG6hImnIQwIuSjarvJ0uXLGY8qdJbhc8W8prB6ikP3mf0NNo8208OwEwGyoUuvcg2sWdF3G/tzWAMsmtO+m0Vw+MY7P7vGSrM/qpOO8AO77UzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x7wtrfbsKc8bs4rkzklPVNLCZo+WJAaOa1RF7VzaRmk=;
 b=DTuoXhF+kXaWFyTRnoWxPa4OepNNWaVJ0G9D8UPJOdaUYg9AxKnp8MccnuTnZ9+IC0SeORrWdesMTQFgUvZKBgpjF/0tJQNpepsdZ/oAPZ3V/rSD9sh1gut92zowpdhcW0M+tLykmtA87YLC1lRu9z6D+12jPHl8BBCkXCE66nk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by DB9PR04MB9554.eurprd04.prod.outlook.com (2603:10a6:10:302::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.10; Tue, 24 Oct
 2023 09:19:54 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::7bdc:2d79:d746:11d2]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::7bdc:2d79:d746:11d2%2]) with mapi id 15.20.6933.011; Tue, 24 Oct 2023
 09:19:53 +0000
Date:   Tue, 24 Oct 2023 12:19:49 +0300
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] irqchip/ls-scfg-msi: Use device_get_match_data()
Message-ID: <20231024091949.jqtlrieo3otbpyvp@skbuf>
References: <20231020130255.2954415-3-robh@kernel.org>
 <20231020130255.2954415-3-robh@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231020130255.2954415-3-robh@kernel.org>
 <20231020130255.2954415-3-robh@kernel.org>
X-ClientProxiedBy: FR0P281CA0076.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1e::6) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|DB9PR04MB9554:EE_
X-MS-Office365-Filtering-Correlation-Id: 91c74f18-3e59-4be7-bca3-08dbd47261c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bKWdkTbaQDenOZw6vypOJdkCHYY7XxTHp/BdLU9QyQHGSV9fcDxwbTVwLYldEgCuLhg6IOMOTdu3Rb298NaSYfpAZRlsfHeqjKnpnuIR52YNKqHsXA20URDH8JvM8nCA3uRKMflSLJS3txbwonel4WYazxFf/HcCBMnMSRY/MWAGb1F63YGCrIrY5sCRnfP49hc7e/sk5bdEEBFFfAL50HZHL70O7oGbgi4ERkgbjPB6D1XuWFAQBsZRE4UcQdI6lHldmStOZ9dsJFBWj0NXEbYIUacaHT4FCyu0A3ibbi3kbiwP/vxkTuyXiPQ4GVf/oW31x4KeWDzT11y4OreLeonnSLADJlTv8bI1AE1HyZkicCZpwRf+fFAsNidSRwycBa3TiCSaVMIzkvEXynhQPl5juUkMZGiU50E1WZFV85LfIcZ/K0G2CDGWwHcBPED+pDMWEPsIpdNyKXxCDIae3iqttWQrEb1tWcUYCBEifSeP2BahWxIwiC8ll7bvPeisjq5dSSEI40R469Sr0wj5WXWPW9svJh5E0rsSwD/ld5gGHYUyUhOwWt62A0D2qr+6
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(39860400002)(366004)(136003)(396003)(346002)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(26005)(86362001)(1076003)(83380400001)(44832011)(9686003)(41300700001)(38100700002)(2906002)(6506007)(33716001)(6666004)(5660300002)(6486002)(478600001)(8676002)(8936002)(6512007)(66946007)(4326008)(66556008)(66476007)(6916009)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?17YRBpntPyb3LZRXPa1nGBNZxpHeLp6IMRLmK4hey0Z9kGI+wsMS0x7OOn6K?=
 =?us-ascii?Q?DQvNQLaz7wB6f36AvFTRXWVAYFvEKZ5SADETW57N2IMsT2uEWcSnb/4IQev3?=
 =?us-ascii?Q?bzoLt2f0gl0XmrYdvt7k9+cYsmvUPha5wq8dsr+xGMuUVvg8PmnnLRRVJS6a?=
 =?us-ascii?Q?hmYsAwmZDydXY2WNum4Sw+AG88ka/OkfwOFPhjWmnolQM/tbNWgGQ/AQlnYV?=
 =?us-ascii?Q?e7ApWxqBY1UxOn+LIwnFIepODri42vYAP3EpFcyT6TYWspp6sRcGwpyzsq/y?=
 =?us-ascii?Q?0Je9mwFkjpsZN4P4U9lbyOGkOCEAigSHwgJow8WuGWUDBTgt6VgzTj/ed4ac?=
 =?us-ascii?Q?x4Ou99UCZ/EKB1QcL6W3hmij/EZnHn9S2WmVV0ySQFNMQLtmRog4aVJaa78X?=
 =?us-ascii?Q?P3HCSBb7qPK3GbnRl+Qcv1jgpfT6XmdytOqD2ea0R73gWTlqoR7DHE9CEKoN?=
 =?us-ascii?Q?jawlIvV0OKZsJZC00V0oXPRfL4f8CmmNjhWwkXGtIRU8oRUIiC39LzJh7evL?=
 =?us-ascii?Q?wnRKUlk73knpQNUHnJTe/WmYRxC9YtWU8x/Ql0k3UzhDkxh/hsBngbaMeKTN?=
 =?us-ascii?Q?ExgIeouWYfKCNoaH4wxOGBpvq684rJjXQfE99pZQpPDGCx27qeRH5EcY40px?=
 =?us-ascii?Q?MzUI9l6b+m8382wxk9mLEfM55XbCat/Rtl0ZktSSFoS+ZtgR166UQh3jlQ1i?=
 =?us-ascii?Q?ILJpQobHP1quoOS/KeMqYa7AfMA5EGbuwblMAz5XSoGyz3Erhe1/UCbvZZku?=
 =?us-ascii?Q?uM93XQavPz9ll8opyfT+QrdNAfDqnq4IY1Gm0eMOhzZ0yqpC+Q9xgkZmNTIt?=
 =?us-ascii?Q?to09fO/41/7gVTGby6igSglpFR6LtoAFfCIeY3LzcMf+5Hj0/8MAAqcLUy5s?=
 =?us-ascii?Q?kALIGjZWVgNDqKZgaSaC7Kg7HNFe0P2XY6Xr8xmGli4j9gF5PXWQHD3GsllY?=
 =?us-ascii?Q?EM2T2OTCHQk8Y+wBCsCTpgXaN2hXJjwpdu+KM6Qw8jAZ2pAHE4LlMcsLxAUu?=
 =?us-ascii?Q?ASuvw6GYi7yuSjAPAf9H3LmQdP+imx1GJ8O8J7YURN4PCbvyTcvNFitlayQp?=
 =?us-ascii?Q?fH6Jkan89gKOD1v7ALmP6/j+Xdo/uENilEg09OLke4VsKVxS6V88D35uTnUR?=
 =?us-ascii?Q?orU++W8z9ReTWmqfKe6MxwbwNDrVckdvDFvUdGvmzb+y2rd9jslT7dZz+xOs?=
 =?us-ascii?Q?j4suL/PDAQ9VOoig//wU7vi/6B4YVkikBUMvbwWuswSNAIRvVJwCBA2Ein62?=
 =?us-ascii?Q?9cZlTY57jywwEOi/oa3ncAMnG8nKi7tVuZRxU2RXlIgzsh3Uy7t9+KRluw5y?=
 =?us-ascii?Q?pAtrfL13nivQ/tSpFpxLars2PL71MRo+8rDEkwZSzQT6WBbrUqghi8fMt12j?=
 =?us-ascii?Q?gw+Rpucuu0ze+VCcqZ2T92PSr/GmkrDERM+IphCXlBf7ihZwGad7dINDHCCi?=
 =?us-ascii?Q?4ReXT3aKTKzs1oPwyXaU3FXUey6We2SWbAfn2VdzT+45jn0XnuOHqhUrWPdb?=
 =?us-ascii?Q?C2/eskDTCXTYxJHTq815amzYDPUcvD+Yo9dbUKx5pe798T+CbDTn3pyksW/u?=
 =?us-ascii?Q?b/L9vkrKyyM02/ByZwd82V4UTBPLsPPM63zPHZVmD7fH5jzCGMo7XD5h1XtC?=
 =?us-ascii?Q?uQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91c74f18-3e59-4be7-bca3-08dbd47261c1
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2023 09:19:53.9015
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dZIIgqPGzuWvcEjyFvVb/8BTzPPrPaycQ6FTtMrHIbdlQGCD7FTx1WkSDAhWLhGtA4SjEKKJR5e+PexrF70Mmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9554
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 20, 2023 at 08:02:56AM -0500, Rob Herring wrote:
> Use preferred device_get_match_data() instead of of_match_device() to
> get the driver match data in a single step without the unnecessary
> intermediate match pointer. With this, adjust the includes to
> explicitly include the correct headers. That also serves as
> preparation to remove implicit includes within the DT headers.
> of_platform.h currently includes platform_device.h among others.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---

Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Tested-by: Vladimir Oltean <vladimir.oltean@nxp.com>

> v2:
>  - Expand commit message
> ---
>  drivers/irqchip/irq-ls-scfg-msi.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-ls-scfg-msi.c b/drivers/irqchip/irq-ls-scfg-msi.c
> index f31a262fe438..15cf80b46322 100644
> --- a/drivers/irqchip/irq-ls-scfg-msi.c
> +++ b/drivers/irqchip/irq-ls-scfg-msi.c
> @@ -17,7 +17,8 @@
>  #include <linux/irqdomain.h>
>  #include <linux/of_irq.h>
>  #include <linux/of_pci.h>
> -#include <linux/of_platform.h>
> +#include <linux/platform_device.h>
> +#include <linux/property.h>
>  #include <linux/spinlock.h>
>  
>  #define MSI_IRQS_PER_MSIR	32
> @@ -334,20 +335,17 @@ MODULE_DEVICE_TABLE(of, ls_scfg_msi_id);
>  
>  static int ls_scfg_msi_probe(struct platform_device *pdev)
>  {
> -	const struct of_device_id *match;
>  	struct ls_scfg_msi *msi_data;
>  	struct resource *res;
>  	int i, ret;
>  
> -	match = of_match_device(ls_scfg_msi_id, &pdev->dev);
> -	if (!match)
> -		return -ENODEV;
> -
>  	msi_data = devm_kzalloc(&pdev->dev, sizeof(*msi_data), GFP_KERNEL);
>  	if (!msi_data)
>  		return -ENOMEM;
>  
> -	msi_data->cfg = (struct ls_scfg_msi_cfg *) match->data;
> +	msi_data->cfg = (struct ls_scfg_msi_cfg *)device_get_match_data(&pdev->dev);

I wanted to suggest to drop the unnecessary cast of the void pointer.
But the driver keeps msi_data->cfg as a non-const pointer, and that
causes a warning that is otherwise suppressed by this cast. So eliminating
the type cast and keeping "cfg" as const is definitely a separate change.

> +	if (!msi_data->cfg)
> +		return -ENODEV;
>  
>  	msi_data->regs = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
>  	if (IS_ERR(msi_data->regs)) {
> -- 
> 2.42.0
>
