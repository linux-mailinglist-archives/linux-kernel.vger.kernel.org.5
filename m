Return-Path: <linux-kernel+bounces-167208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C78448BA5A2
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 05:19:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E45E1F2468C
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 03:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF0561C6BE;
	Fri,  3 May 2024 03:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="m/pVqKpv"
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2080.outbound.protection.outlook.com [40.107.247.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC732033A;
	Fri,  3 May 2024 03:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714706379; cv=fail; b=WLMrBDCFbArWPaFOfw3CXovDCNcntc22cOBps8k1+WcoPHwQIqwWZCAJwmCphM+U6VhIAAq1OaYbFxDmF1zr7RLBqdWlFBNNsd2BUmhdMBJ7I40Mz8iY6NtcrJ+uRrzD/ebJi+1/HSuA+i2GW4TdY33G80RlB7q5C84SvbjdwH8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714706379; c=relaxed/simple;
	bh=k/wwyCzzH27QfaJzldiv4i8Y/R/GRsQj8sCUoW9tG7w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=AOKivTBt7/p6BY6LitO3FzNjIjG+OcW6LvzGpYM+etULsY1/pr6lRFtkpN7B9GARivR1sf1aB7Plx8SOXbE0tuq/C5vMcB7cQ3UQF1cRMJCW+UOj/3VkEGHTkvxXLO6iWbQ/Gb2gPAV73dtpJ6tXAQ4LaMRY/6NGusvmZND76lQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=m/pVqKpv; arc=fail smtp.client-ip=40.107.247.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RdLj7+HWWw/MnRAs5CrOQCGYpzmho3qYIwTO7xnKPC/ZolhIDlSjrqRCdLppdjSWLegVHPGhMjepk38wsEaw/XFjtGIvZwrVfZLL3LhK6i79+8KXx4WYsDwqpgScfRlYjbK6zBR3OGeXsJR7pbLbe3RRyMJ/A32QaQZk8LOLsNBqTibyXBk64DQ43+yXbeIuTdORggKirXE6pNPq3f/rIzJw6X5d11lcNDuPH6V+LQPS4dyBY3hMuPHEIn2qM01+exXJLvitHfbgOBpdWfZhlroBGMhPMksYB/8FF/obUrprThu4lPr88ZML4amrrLUAtl7P9JZtOSMvzdnxqrqRew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9BbSdfMGl9kcq/xXhwjPVfijmOjGn+KAjgVcpbGK79o=;
 b=Y7QB5NdKTNwgq/wYQtkU5193tTV/I+z8PKtKzt4W0z1xgXVDtCncYHUnMeheeQtBrFGmzp0+lXL855fulYE5XV3XmLZoTBm/0MEgqMm9mHaTBzgnpFJZkbp9u6kQGd1DLTl6NaYj8IHf2aeXLY/p5C/A1VU1TAJkG658rehedKFjwaYhUvVdHDjXaAgy+7i2DaDlA2HeqBHZ3jjHUh8jfdTzKb2REiaoh61rKhKf14WRiIVIe7c+SO47RhfscP2h7CTBz4P5FaHW2T1fGVAwSv1J6rB2/0Ctj1EjDEclG5ZLQF9eloVz2cMK/2bZKEIY6DsJhFrsxHzBs8fmGQyYSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9BbSdfMGl9kcq/xXhwjPVfijmOjGn+KAjgVcpbGK79o=;
 b=m/pVqKpv+3ItcqL2xZvW72KfAKMBl/+eZS++BnLJF5LkXOMAyiiqsAJuhNZrUOLRW2qh8Ok7XHaWb1lc2xzPEZ1pinQlVlEmOA6N7Syx60YAdHnjEHa4xzn1kt+g56ZFzKHJxy+M8WMrQFzzyCzXDVJ4Po4WNU6isLcpJGwjl9o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GVXPR04MB10151.eurprd04.prod.outlook.com (2603:10a6:150:1b7::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.29; Fri, 3 May
 2024 03:19:32 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58%7]) with mapi id 15.20.7544.029; Fri, 3 May 2024
 03:19:32 +0000
Date: Thu, 2 May 2024 23:19:23 -0400
From: Frank Li <Frank.li@nxp.com>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH v4 2/3] arm64: dts: freescale: add i.MX95 basic dtsi
Message-ID: <ZjRXu5Oy2cLRtMh8@lizhi-Precision-Tower-5810>
References: <20240503-imx95-dts-v3-v4-0-535ddc2bde73@nxp.com>
 <20240503-imx95-dts-v3-v4-2-535ddc2bde73@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240503-imx95-dts-v3-v4-2-535ddc2bde73@nxp.com>
X-ClientProxiedBy: BYAPR01CA0064.prod.exchangelabs.com (2603:10b6:a03:94::41)
 To PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|GVXPR04MB10151:EE_
X-MS-Office365-Filtering-Correlation-Id: 356e7e26-57cb-4948-d71a-08dc6b1fd9a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|366007|376005|7416005|1800799015|52116005|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?inMpAfpTx4XWPEwemtNJ/DRhhCoFyYsFQZyfhzQVEOBHzdsGdCqoFCixuB/f?=
 =?us-ascii?Q?07Rf4G5jqced0wmyqTlCwWE/PMOaz267Gbx8UIsSnPNZGm4uIe2/a/I5Gv7X?=
 =?us-ascii?Q?iTmEwvZ/bqVTQZI4zYmbgNRt8XgN1RZb+RGDLbLA6u+SDmeQ0/1AMxExT4pn?=
 =?us-ascii?Q?LR4V5u3AKJXECaow1o9gGffta3JE3wEj04f9J97qieCI4Ib6wpZKNOTBbNMY?=
 =?us-ascii?Q?s52SnlBrMlGrTf4/MtSJzU+hQwdeZ9UwvTBO/QhuEHBGZIvmerU8lkxEtqIv?=
 =?us-ascii?Q?0IsHVIYE3gbrEGbRw0GP3zYiWdx8vYFPIqntytFLes4wQ2/vPhbvpsyxPmrn?=
 =?us-ascii?Q?HTxV7GSJDNPLRvgha2+/qK2OqPEoD8c/p71mcwpfFq/TrcMWEGvcIGVLgggH?=
 =?us-ascii?Q?fstTy23887vTRDOK0Ud74zesfnG8CfpNrwmnQtRAj8TFOCkG7vi8pmV4fpQ3?=
 =?us-ascii?Q?PicmHiJO/Td7gghcTo6/4tgVhtVffReYEE5GVDXJHHtZ6IuCNfoknh/C8Qek?=
 =?us-ascii?Q?MhjK7+aFT27Qkb+joDcJNZYAsk0EKzD/u7uTHwNNiHposYGTukyFsE+awsjH?=
 =?us-ascii?Q?3sAmcwe8mW+x31fUn3wuST+dim0D7rjyrcaqSUstqanLU1oe7nbTO/U4Zatc?=
 =?us-ascii?Q?rueT+XGbm9kGWdfsvanCQL71TU6piJAECrzcJNQj7WGLG9CXvtDLHn3lWLcx?=
 =?us-ascii?Q?ThPZkkpsoXuD7EW1JKaJKca5pzJ0h7lriawHiF8ZqRasRbJ40vZGmcjwtubb?=
 =?us-ascii?Q?Q/2A0K+Wuftds6vtkKqQRwO//YBHmuHrx0M0FKFmUhYPH/WNygL6XDJUyvIM?=
 =?us-ascii?Q?Ft35N8rk6038x3x+4qgS8KPgIWJBU0IKw3vHBpqHuKqqs0CoauSsMvjknlZe?=
 =?us-ascii?Q?WcTKJlsRQrYVsU5gfceYyXKSzflfgtg4sb5x7J8dPURFeYLBYLrB3OH9toC3?=
 =?us-ascii?Q?VE/FGBHUK4lru0HG67ESEVv17Ep0Tqx9YZpjQepJ4CzWXyLFqx+Ny7Q73BOb?=
 =?us-ascii?Q?usy2PH4cYz59Vwz3+W5Mr1CgMNQnbi8hKx0OlBQ6Ih2264iPwgfx/0CI++Uv?=
 =?us-ascii?Q?VPwTbWlRZSEpOUuQ4N5R03BY/X5044FEkl9xUCzblLBS4/x0S3zA3t5nSwrg?=
 =?us-ascii?Q?3JBZBJxQM3lBYMTME+LLuj0MKph0fUo9MiCy00F1sTPRW8xdHvF06VJBNtOn?=
 =?us-ascii?Q?UL7ikH32x4nFBtm+M+4tiRfSvrNoeIVKdDIDdRkq5LMTuW+tXJKFbf87f2E7?=
 =?us-ascii?Q?JvvaIS3A99f/ZNtX6VwusKRfIm2wkW3WV72/pu1jfCDDX1gH9da9IAwiey0C?=
 =?us-ascii?Q?7vrTKhYAYw19OXHxjIt3ZTOOL2u8BfqJx+Fbv7NkahKRPQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(7416005)(1800799015)(52116005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AupiKc81MC8pjhnYBM1s9t7r08elolRaW+s+kNaQTvP5U5RfKSy3Y0WVzGcf?=
 =?us-ascii?Q?wcwrYbesyeBrlDIyUU+YzmWV3VD9/wXAmM/lIQdU6lWxQBKQN3sAHo6iqi6J?=
 =?us-ascii?Q?9yXpqCTIbobA01k5/qWSjXH8AFLnHIfABBZRcpZckRh66G+zh6LwiiQ12ad7?=
 =?us-ascii?Q?QehkoUoU/Ye0/gGqPOn2Hg1llY3ravrDyktxtisPxqGrIjGokCTmjpndrF+e?=
 =?us-ascii?Q?9mAvrqF94XmJirjHu1M23cq0iUy9ksqKtLcQNkiymQJavhWSjx5qz14y2zx3?=
 =?us-ascii?Q?1f/DD1n7fp86FO3xWEx+h0ApjJMq18mwJpNqxaArd15M9IzWhxZrVpFDI/LK?=
 =?us-ascii?Q?TEyJ+gnxIJ5jZkNBzZkaZS6YTcV5bHK4omVwFaU29QQEBIb7FDQL92ZLbAQL?=
 =?us-ascii?Q?ZVFTHe6WjkF3Pxx0W2fovey15an3efScSjYJMjeBvk8D+szG7KL4ctQ51fgP?=
 =?us-ascii?Q?4lx92tEKLWDe+EfGVzxwTTjOZvWTbfiEtay/6lsuzmm5PCcPxfCU+Noe5EII?=
 =?us-ascii?Q?xL9fOa/yOqqJrKQMzYohCQRIyUATQiiH+sFX+Gmr+G8iGcJFk30jB6oB1EuJ?=
 =?us-ascii?Q?6P1SnhZFaa1oMbDlHQVkcTSQDpWomy+AUQgROZhPPwWHTkQ9flYFsLMSnZrg?=
 =?us-ascii?Q?f6TwBPKI3Bu/N7UY+WjZ4EFvwVRqBHgC++y1gjFVvStDt6NTfu1vTejhrasN?=
 =?us-ascii?Q?wGGRoMmnkrCnxnZdTmWokFb5NPPeVHPrPLxVNi5CUIJY4xR2lL8Ge21mLnKQ?=
 =?us-ascii?Q?q5cwvZKemMEwEGgGoKSxlD+sPzUU3+FlUdYfHHD3X3Xmb14THDOjfO7xx1MB?=
 =?us-ascii?Q?Qet9IiyiuXURPfCiekx4cSlDVAynm7myLk5u6vA4M2T6o3UKiR50VNX61FWI?=
 =?us-ascii?Q?G6vDgaqubEdjZAZ2q/sVw62hTHlk0mYoRFTuoAB7f+qWqWuDKt2laXX+npvM?=
 =?us-ascii?Q?cOJ19C0bMjGfvyeTyYPARuQjudpwz7/FA/gbNmmzObio4z6U2Hj5yqoZUW/F?=
 =?us-ascii?Q?I2hYvSTYewFkzTQL5ywrFPFDH8t4CwS7Kn5XJhIjGq+cNj6SEGAfuMv4mix7?=
 =?us-ascii?Q?oWErjvNKGCpxFAaqLWH+6YFVCBeiX5E0SDAFlwEHucIUOw0gQH/3P5VdTzs/?=
 =?us-ascii?Q?EE2b5UhmWwUm6KOoaMdNPvgnSjNKyFuU7xcxq+aZku0OYmhFEIQopzeJjQ0E?=
 =?us-ascii?Q?cbJhsdmuWqMWwVXUbZ95NWbdgi3KuGj2/NXcrsPWWCzSIE3S9KeGpY2K8Llk?=
 =?us-ascii?Q?WTqlvB3mdwvyD90iWE7uXusLheFgwF2lBBPJ3h/zjvhnGFHmNWW0aAj1BSef?=
 =?us-ascii?Q?9L3N49TbuBX6ogs5AVPAem+/DLBJjL0QHNEyR5AjULrrMMMPZMVOOTnhxtwv?=
 =?us-ascii?Q?CNDbclprEh32fE0DhING643Y1d3L6T/R3GP3ajEJOAXoLslc60H/f10CokDF?=
 =?us-ascii?Q?8tXKrUYb5uFiGU2yV3eFivOZ9eYR3p4SdCl9R/j9a2NHD0I5asxB/WeUucN1?=
 =?us-ascii?Q?tZpNR4VDkbuQol7qT/dzpU9Seoq8WEs28w/24QMn1xyZydMU/LGZClK+MXyH?=
 =?us-ascii?Q?NpclEzTBsY65kBmknfSsiE8U57UOZNTE44WAYBpW?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 356e7e26-57cb-4948-d71a-08dc6b1fd9a6
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2024 03:19:32.2303
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eJI/l1VI06VE2DwTAN7gmiyeGJw4Iu/FPH72YaCTb+1J7bw3u3E5wWcNkFgrSoVEmXhZQ6hkGWQoqGqMqxoUWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10151

On Fri, May 03, 2024 at 09:37:12AM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> i.MX95 features 6 A55 Cores, ARM Mali GPU, ISP, ML acceleration NPU,
> and Edgelock secure enclave security. This patch is to add a minimal
> dtsi, with cpu cores, coresight, scmi, gic, uart, mu, sdhc, lpi2c added.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/imx95-clock.h |  187 +++++
>  arch/arm64/boot/dts/freescale/imx95-power.h |   55 ++
>  arch/arm64/boot/dts/freescale/imx95.dtsi    | 1049 +++++++++++++++++++++++++++
>  3 files changed, 1291 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx95-clock.h b/arch/arm64/boot/dts/freescale/imx95-clock.h
> new file mode 100644
> index 000000000000..5badaace3148
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/imx95-clock.h
> @@ -0,0 +1,187 @@
> +/* SPDX-License-Identifier: GPL-2.0-only OR MIT */
> +/*
> + * Copyright 2024 NXP
> + */
> +
> +#ifndef __CLOCK_IMX95_H
> +#define __CLOCK_IMX95_H
> +
> +/* The index should match i.MX95 SCMI Firmware */
> +#define IMX95_CLK_32K                       1
> +#define IMX95_CLK_24M                       2
> +#define IMX95_CLK_FRO                       3
> +#define IMX95_CLK_SYSPLL1_VCO               4
> +#define IMX95_CLK_SYSPLL1_PFD0_UNGATED      5
> +#define IMX95_CLK_SYSPLL1_PFD0              6
> +#define IMX95_CLK_SYSPLL1_PFD0_DIV2         7
> +#define IMX95_CLK_SYSPLL1_PFD1_UNGATED      8
> +#define IMX95_CLK_SYSPLL1_PFD1              9
> +#define IMX95_CLK_SYSPLL1_PFD1_DIV2         10
> +#define IMX95_CLK_SYSPLL1_PFD2_UNGATED      11
> +#define IMX95_CLK_SYSPLL1_PFD2              12
> +#define IMX95_CLK_SYSPLL1_PFD2_DIV2         13
> +#define IMX95_CLK_AUDIOPLL1_VCO             14
> +#define IMX95_CLK_AUDIOPLL1                 15
> +#define IMX95_CLK_AUDIOPLL2_VCO             16
> +#define IMX95_CLK_AUDIOPLL2                 17
> +#define IMX95_CLK_VIDEOPLL1_VCO             18
> +#define IMX95_CLK_VIDEOPLL1                 19
> +#define IMX95_CLK_RESERVED20                20
> +#define IMX95_CLK_RESERVED21                21
> +#define IMX95_CLK_RESERVED22                22
> +#define IMX95_CLK_RESERVED23                23
> +#define IMX95_CLK_ARMPLL_VCO                24
> +#define IMX95_CLK_ARMPLL_PFD0_UNGATED       25
> +#define IMX95_CLK_ARMPLL_PFD0               26
> +#define IMX95_CLK_ARMPLL_PFD1_UNGATED       27
> +#define IMX95_CLK_ARMPLL_PFD1               28
> +#define IMX95_CLK_ARMPLL_PFD2_UNGATED       29
> +#define IMX95_CLK_ARMPLL_PFD2               30
> +#define IMX95_CLK_ARMPLL_PFD3_UNGATED       31
> +#define IMX95_CLK_ARMPLL_PFD3               32
> +#define IMX95_CLK_DRAMPLL_VCO               33
> +#define IMX95_CLK_DRAMPLL                   34
> +#define IMX95_CLK_HSIOPLL_VCO               35
> +#define IMX95_CLK_HSIOPLL                   36
> +#define IMX95_CLK_LDBPLL_VCO                37
> +#define IMX95_CLK_LDBPLL                    38
> +#define IMX95_CLK_EXT1                      39
> +#define IMX95_CLK_EXT2                      40
> +
> +#define IMX95_CCM_NUM_CLK_SRC               41
> +
> +#define IMX95_CLK_ADC                      (IMX95_CCM_NUM_CLK_SRC + 0)
> +#define IMX95_CLK_TMU                      (IMX95_CCM_NUM_CLK_SRC + 1)
> +#define IMX95_CLK_BUSAON                   (IMX95_CCM_NUM_CLK_SRC + 2)
> +#define IMX95_CLK_CAN1                     (IMX95_CCM_NUM_CLK_SRC + 3)
> +#define IMX95_CLK_I3C1                     (IMX95_CCM_NUM_CLK_SRC + 4)
> +#define IMX95_CLK_I3C1SLOW                 (IMX95_CCM_NUM_CLK_SRC + 5)
> +#define IMX95_CLK_LPI2C1                   (IMX95_CCM_NUM_CLK_SRC + 6)
> +#define IMX95_CLK_LPI2C2                   (IMX95_CCM_NUM_CLK_SRC + 7)
> +#define IMX95_CLK_LPSPI1                   (IMX95_CCM_NUM_CLK_SRC + 8)
> +#define IMX95_CLK_LPSPI2                   (IMX95_CCM_NUM_CLK_SRC + 9)
> +#define IMX95_CLK_LPTMR1                   (IMX95_CCM_NUM_CLK_SRC + 10)
> +#define IMX95_CLK_LPUART1                  (IMX95_CCM_NUM_CLK_SRC + 11)
> +#define IMX95_CLK_LPUART2                  (IMX95_CCM_NUM_CLK_SRC + 12)
> +#define IMX95_CLK_M33                      (IMX95_CCM_NUM_CLK_SRC + 13)
> +#define IMX95_CLK_M33SYSTICK               (IMX95_CCM_NUM_CLK_SRC + 14)
> +#define IMX95_CLK_MQS1                     (IMX95_CCM_NUM_CLK_SRC + 15)
> +#define IMX95_CLK_PDM                      (IMX95_CCM_NUM_CLK_SRC + 16)
> +#define IMX95_CLK_SAI1                     (IMX95_CCM_NUM_CLK_SRC + 17)
> +#define IMX95_CLK_SENTINEL                 (IMX95_CCM_NUM_CLK_SRC + 18)
> +#define IMX95_CLK_TPM2                     (IMX95_CCM_NUM_CLK_SRC + 19)
> +#define IMX95_CLK_TSTMR1                   (IMX95_CCM_NUM_CLK_SRC + 20)
> +#define IMX95_CLK_CAMAPB                   (IMX95_CCM_NUM_CLK_SRC + 21)
> +#define IMX95_CLK_CAMAXI                   (IMX95_CCM_NUM_CLK_SRC + 22)
> +#define IMX95_CLK_CAMCM0                   (IMX95_CCM_NUM_CLK_SRC + 23)
> +#define IMX95_CLK_CAMISI                   (IMX95_CCM_NUM_CLK_SRC + 24)
> +#define IMX95_CLK_MIPIPHYCFG               (IMX95_CCM_NUM_CLK_SRC + 25)
> +#define IMX95_CLK_MIPIPHYPLLBYPASS         (IMX95_CCM_NUM_CLK_SRC + 26)
> +#define IMX95_CLK_MIPIPHYPLLREF            (IMX95_CCM_NUM_CLK_SRC + 27)
> +#define IMX95_CLK_MIPITESTBYTE             (IMX95_CCM_NUM_CLK_SRC + 28)
> +#define IMX95_CLK_A55                      (IMX95_CCM_NUM_CLK_SRC + 29)
> +#define IMX95_CLK_A55MTRBUS                (IMX95_CCM_NUM_CLK_SRC + 30)
> +#define IMX95_CLK_A55PERIPH                (IMX95_CCM_NUM_CLK_SRC + 31)
> +#define IMX95_CLK_DRAMALT                  (IMX95_CCM_NUM_CLK_SRC + 32)
> +#define IMX95_CLK_DRAMAPB                  (IMX95_CCM_NUM_CLK_SRC + 33)
> +#define IMX95_CLK_DISPAPB                  (IMX95_CCM_NUM_CLK_SRC + 34)
> +#define IMX95_CLK_DISPAXI                  (IMX95_CCM_NUM_CLK_SRC + 35)
> +#define IMX95_CLK_DISPDP                   (IMX95_CCM_NUM_CLK_SRC + 36)
> +#define IMX95_CLK_DISPOCRAM                (IMX95_CCM_NUM_CLK_SRC + 37)
> +#define IMX95_CLK_DISPUSB31                (IMX95_CCM_NUM_CLK_SRC + 38)
> +#define IMX95_CLK_DISP1PIX                 (IMX95_CCM_NUM_CLK_SRC + 39)
> +#define IMX95_CLK_DISP2PIX                 (IMX95_CCM_NUM_CLK_SRC + 40)
> +#define IMX95_CLK_DISP3PIX                 (IMX95_CCM_NUM_CLK_SRC + 41)
> +#define IMX95_CLK_GPUAPB                   (IMX95_CCM_NUM_CLK_SRC + 42)
> +#define IMX95_CLK_GPU                      (IMX95_CCM_NUM_CLK_SRC + 43)
> +#define IMX95_CLK_HSIOACSCAN480M           (IMX95_CCM_NUM_CLK_SRC + 44)
> +#define IMX95_CLK_HSIOACSCAN80M            (IMX95_CCM_NUM_CLK_SRC + 45)
> +#define IMX95_CLK_HSIO                     (IMX95_CCM_NUM_CLK_SRC + 46)
> +#define IMX95_CLK_HSIOPCIEAUX              (IMX95_CCM_NUM_CLK_SRC + 47)
> +#define IMX95_CLK_HSIOPCIETEST160M         (IMX95_CCM_NUM_CLK_SRC + 48)
> +#define IMX95_CLK_HSIOPCIETEST400M         (IMX95_CCM_NUM_CLK_SRC + 49)
> +#define IMX95_CLK_HSIOPCIETEST500M         (IMX95_CCM_NUM_CLK_SRC + 50)
> +#define IMX95_CLK_HSIOUSBTEST50M           (IMX95_CCM_NUM_CLK_SRC + 51)
> +#define IMX95_CLK_HSIOUSBTEST60M           (IMX95_CCM_NUM_CLK_SRC + 52)
> +#define IMX95_CLK_BUSM7                    (IMX95_CCM_NUM_CLK_SRC + 53)
> +#define IMX95_CLK_M7                       (IMX95_CCM_NUM_CLK_SRC + 54)
> +#define IMX95_CLK_M7SYSTICK                (IMX95_CCM_NUM_CLK_SRC + 55)
> +#define IMX95_CLK_BUSNETCMIX               (IMX95_CCM_NUM_CLK_SRC + 56)
> +#define IMX95_CLK_ENET                     (IMX95_CCM_NUM_CLK_SRC + 57)
> +#define IMX95_CLK_ENETPHYTEST200M          (IMX95_CCM_NUM_CLK_SRC + 58)
> +#define IMX95_CLK_ENETPHYTEST500M          (IMX95_CCM_NUM_CLK_SRC + 59)
> +#define IMX95_CLK_ENETPHYTEST667M          (IMX95_CCM_NUM_CLK_SRC + 60)
> +#define IMX95_CLK_ENETREF                  (IMX95_CCM_NUM_CLK_SRC + 61)
> +#define IMX95_CLK_ENETTIMER1               (IMX95_CCM_NUM_CLK_SRC + 62)
> +#define IMX95_CLK_MQS2                     (IMX95_CCM_NUM_CLK_SRC + 63)
> +#define IMX95_CLK_SAI2                     (IMX95_CCM_NUM_CLK_SRC + 64)
> +#define IMX95_CLK_NOCAPB                   (IMX95_CCM_NUM_CLK_SRC + 65)
> +#define IMX95_CLK_NOC                      (IMX95_CCM_NUM_CLK_SRC + 66)
> +#define IMX95_CLK_NPUAPB                   (IMX95_CCM_NUM_CLK_SRC + 67)
> +#define IMX95_CLK_NPU                      (IMX95_CCM_NUM_CLK_SRC + 68)
> +#define IMX95_CLK_CCMCKO1                  (IMX95_CCM_NUM_CLK_SRC + 69)
> +#define IMX95_CLK_CCMCKO2                  (IMX95_CCM_NUM_CLK_SRC + 70)
> +#define IMX95_CLK_CCMCKO3                  (IMX95_CCM_NUM_CLK_SRC + 71)
> +#define IMX95_CLK_CCMCKO4                  (IMX95_CCM_NUM_CLK_SRC + 72)
> +#define IMX95_CLK_VPUAPB                   (IMX95_CCM_NUM_CLK_SRC + 73)
> +#define IMX95_CLK_VPU                      (IMX95_CCM_NUM_CLK_SRC + 74)
> +#define IMX95_CLK_VPUDSP                   (IMX95_CCM_NUM_CLK_SRC + 75)
> +#define IMX95_CLK_VPUJPEG                  (IMX95_CCM_NUM_CLK_SRC + 76)
> +#define IMX95_CLK_AUDIOXCVR                (IMX95_CCM_NUM_CLK_SRC + 77)
> +#define IMX95_CLK_BUSWAKEUP                (IMX95_CCM_NUM_CLK_SRC + 78)
> +#define IMX95_CLK_CAN2                     (IMX95_CCM_NUM_CLK_SRC + 79)
> +#define IMX95_CLK_CAN3                     (IMX95_CCM_NUM_CLK_SRC + 80)
> +#define IMX95_CLK_CAN4                     (IMX95_CCM_NUM_CLK_SRC + 81)
> +#define IMX95_CLK_CAN5                     (IMX95_CCM_NUM_CLK_SRC + 82)
> +#define IMX95_CLK_FLEXIO1                  (IMX95_CCM_NUM_CLK_SRC + 83)
> +#define IMX95_CLK_FLEXIO2                  (IMX95_CCM_NUM_CLK_SRC + 84)
> +#define IMX95_CLK_FLEXSPI1                 (IMX95_CCM_NUM_CLK_SRC + 85)
> +#define IMX95_CLK_I3C2                     (IMX95_CCM_NUM_CLK_SRC + 86)
> +#define IMX95_CLK_I3C2SLOW                 (IMX95_CCM_NUM_CLK_SRC + 87)
> +#define IMX95_CLK_LPI2C3                   (IMX95_CCM_NUM_CLK_SRC + 88)
> +#define IMX95_CLK_LPI2C4                   (IMX95_CCM_NUM_CLK_SRC + 89)
> +#define IMX95_CLK_LPI2C5                   (IMX95_CCM_NUM_CLK_SRC + 90)
> +#define IMX95_CLK_LPI2C6                   (IMX95_CCM_NUM_CLK_SRC + 91)
> +#define IMX95_CLK_LPI2C7                   (IMX95_CCM_NUM_CLK_SRC + 92)
> +#define IMX95_CLK_LPI2C8                   (IMX95_CCM_NUM_CLK_SRC + 93)
> +#define IMX95_CLK_LPSPI3                   (IMX95_CCM_NUM_CLK_SRC + 94)
> +#define IMX95_CLK_LPSPI4                   (IMX95_CCM_NUM_CLK_SRC + 95)
> +#define IMX95_CLK_LPSPI5                   (IMX95_CCM_NUM_CLK_SRC + 96)
> +#define IMX95_CLK_LPSPI6                   (IMX95_CCM_NUM_CLK_SRC + 97)
> +#define IMX95_CLK_LPSPI7                   (IMX95_CCM_NUM_CLK_SRC + 98)
> +#define IMX95_CLK_LPSPI8                   (IMX95_CCM_NUM_CLK_SRC + 99)
> +#define IMX95_CLK_LPTMR2                   (IMX95_CCM_NUM_CLK_SRC + 100)
> +#define IMX95_CLK_LPUART3                  (IMX95_CCM_NUM_CLK_SRC + 101)
> +#define IMX95_CLK_LPUART4                  (IMX95_CCM_NUM_CLK_SRC + 102)
> +#define IMX95_CLK_LPUART5                  (IMX95_CCM_NUM_CLK_SRC + 103)
> +#define IMX95_CLK_LPUART6                  (IMX95_CCM_NUM_CLK_SRC + 104)
> +#define IMX95_CLK_LPUART7                  (IMX95_CCM_NUM_CLK_SRC + 105)
> +#define IMX95_CLK_LPUART8                  (IMX95_CCM_NUM_CLK_SRC + 106)
> +#define IMX95_CLK_SAI3                     (IMX95_CCM_NUM_CLK_SRC + 107)
> +#define IMX95_CLK_SAI4                     (IMX95_CCM_NUM_CLK_SRC + 108)
> +#define IMX95_CLK_SAI5                     (IMX95_CCM_NUM_CLK_SRC + 109)
> +#define IMX95_CLK_SPDIF                    (IMX95_CCM_NUM_CLK_SRC + 110)
> +#define IMX95_CLK_SWOTRACE                 (IMX95_CCM_NUM_CLK_SRC + 111)
> +#define IMX95_CLK_TPM4                     (IMX95_CCM_NUM_CLK_SRC + 112)
> +#define IMX95_CLK_TPM5                     (IMX95_CCM_NUM_CLK_SRC + 113)
> +#define IMX95_CLK_TPM6                     (IMX95_CCM_NUM_CLK_SRC + 114)
> +#define IMX95_CLK_TSTMR2                   (IMX95_CCM_NUM_CLK_SRC + 115)
> +#define IMX95_CLK_USBPHYBURUNIN            (IMX95_CCM_NUM_CLK_SRC + 116)
> +#define IMX95_CLK_USDHC1                   (IMX95_CCM_NUM_CLK_SRC + 117)
> +#define IMX95_CLK_USDHC2                   (IMX95_CCM_NUM_CLK_SRC + 118)
> +#define IMX95_CLK_USDHC3                   (IMX95_CCM_NUM_CLK_SRC + 119)
> +#define IMX95_CLK_V2XPK                    (IMX95_CCM_NUM_CLK_SRC + 120)
> +#define IMX95_CLK_WAKEUPAXI                (IMX95_CCM_NUM_CLK_SRC + 121)
> +#define IMX95_CLK_XSPISLVROOT              (IMX95_CCM_NUM_CLK_SRC + 122)
> +#define IMX95_CLK_SEL_EXT                  (IMX95_CCM_NUM_CLK_SRC + 123 + 0)
> +#define IMX95_CLK_SEL_A55C0                (IMX95_CCM_NUM_CLK_SRC + 123 + 1)
> +#define IMX95_CLK_SEL_A55C1                (IMX95_CCM_NUM_CLK_SRC + 123 + 2)
> +#define IMX95_CLK_SEL_A55C2                (IMX95_CCM_NUM_CLK_SRC + 123 + 3)
> +#define IMX95_CLK_SEL_A55C3                (IMX95_CCM_NUM_CLK_SRC + 123 + 4)
> +#define IMX95_CLK_SEL_A55C4                (IMX95_CCM_NUM_CLK_SRC + 123 + 5)
> +#define IMX95_CLK_SEL_A55C5                (IMX95_CCM_NUM_CLK_SRC + 123 + 6)
> +#define IMX95_CLK_SEL_A55P                 (IMX95_CCM_NUM_CLK_SRC + 123 + 7)
> +#define IMX95_CLK_SEL_DRAM                 (IMX95_CCM_NUM_CLK_SRC + 123 + 8)
> +#define IMX95_CLK_SEL_TEMPSENSE            (IMX95_CCM_NUM_CLK_SRC + 123 + 9)
> +
> +#endif	/* __DT_BINDINGS_CLOCK_IMX95_H */
> diff --git a/arch/arm64/boot/dts/freescale/imx95-power.h b/arch/arm64/boot/dts/freescale/imx95-power.h
> new file mode 100644
> index 000000000000..a43779317fed
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/imx95-power.h
> @@ -0,0 +1,55 @@
> +/* SPDX-License-Identifier: (GPL-2.0-only OR MIT) */
> +/*
> + *  Copyright 2024 NXP
> + */
> +
> +#ifndef __IMX95_POWER_H__
> +#define __IMX95_POWER_H__
> +
> +#define IMX95_PD_ANA		0
> +#define IMX95_PD_AON		1
> +#define IMX95_PD_BBSM		2
> +#define IMX95_PD_CAMERA		3
> +#define IMX95_PD_CCMSRCGPC	4
> +#define IMX95_PD_A55C0		5
> +#define IMX95_PD_A55C1		6
> +#define IMX95_PD_A55C2		7
> +#define IMX95_PD_A55C3		8
> +#define IMX95_PD_A55C4		9
> +#define IMX95_PD_A55C5		10
> +#define IMX95_PD_A55P		11
> +#define IMX95_PD_DDR		12
> +#define IMX95_PD_DISPLAY	13
> +#define IMX95_PD_GPU		14
> +#define IMX95_PD_HSIO_TOP	15
> +#define IMX95_PD_HSIO_WAON	16
> +#define IMX95_PD_M7		17
> +#define IMX95_PD_NETC		18
> +#define IMX95_PD_NOC		19
> +#define IMX95_PD_NPU		20
> +#define IMX95_PD_VPU		21
> +#define IMX95_PD_WAKEUP		22
> +
> +#define IMX95_PERF_ELE		0
> +#define IMX95_PERF_M33		1
> +#define IMX95_PERF_WAKEUP	2
> +#define IMX95_PERF_M7		3
> +#define IMX95_PERF_DRAM		4
> +#define IMX95_PERF_HSIO		5
> +#define IMX95_PERF_NPU		6
> +#define IMX95_PERF_NOC		7
> +#define IMX95_PERF_A55		8
> +#define IMX95_PERF_GPU		9
> +#define IMX95_PERF_VPU		10
> +#define IMX95_PERF_CAM		11
> +#define IMX95_PERF_DISP		12
> +#define IMX95_PERF_A55PER	13
> +#define IMX95_PERF_A55P		14
> +#define IMX95_PERF_A55C0	15
> +#define IMX95_PERF_A55C1	16
> +#define IMX95_PERF_A55C2	17
> +#define IMX95_PERF_A55C3	18
> +#define IMX95_PERF_A55C4	19
> +#define IMX95_PERF_A55C5	20
> +
> +#endif
> diff --git a/arch/arm64/boot/dts/freescale/imx95.dtsi b/arch/arm64/boot/dts/freescale/imx95.dtsi
> new file mode 100644
> index 000000000000..eeb995c39481
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/imx95.dtsi
> @@ -0,0 +1,1049 @@
> +// SPDX-License-Identifier: (GPL-2.0-only OR MIT)
> +/*
> + * Copyright 2024 NXP
> + */
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/input/input.h>
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/thermal/thermal.h>
> +
> +#include "imx95-clock.h"
> +#include "imx95-power.h"
> +
> +/ {
> +	interrupt-parent = <&gic>;
> +	#address-cells = <2>;
> +	#size-cells = <2>;
> +
> +	cpus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		idle-states {
> +			entry-method = "psci";
> +
> +			cpu_pd_wait: cpu-pd-wait {
> +				compatible = "arm,idle-state";
> +				arm,psci-suspend-param = <0x0010033>;
> +				local-timer-stop;
> +				entry-latency-us = <10000>;
> +				exit-latency-us = <7000>;
> +				min-residency-us = <27000>;
> +				wakeup-latency-us = <15000>;
> +				status = "disabled";
> +			};
> +		};
> +
> +		A55_0: cpu@0 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a55";
> +			reg = <0x0>;
> +			enable-method = "psci";
> +			#cooling-cells = <2>;
> +			cpu-idle-states = <&cpu_pd_wait>;
> +			power-domains = <&scmi_devpd IMX95_PERF_A55>;
> +			power-domain-names = "perf";
> +			i-cache-size = <32768>;
> +			i-cache-line-size = <64>;
> +			i-cache-sets = <128>;
> +			d-cache-size = <32768>;
> +			d-cache-line-size = <64>;
> +			d-cache-sets = <128>;
> +			next-level-cache = <&l2_cache_l0>;
> +		};
> +
> +		A55_1: cpu@100 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a55";
> +			reg = <0x100>;
> +			enable-method = "psci";
> +			#cooling-cells = <2>;
> +			cpu-idle-states = <&cpu_pd_wait>;
> +			power-domains = <&scmi_devpd IMX95_PERF_A55>;
> +			power-domain-names = "perf";
> +			i-cache-size = <32768>;
> +			i-cache-line-size = <64>;
> +			i-cache-sets = <128>;
> +			d-cache-size = <32768>;
> +			d-cache-line-size = <64>;
> +			d-cache-sets = <128>;
> +			next-level-cache = <&l2_cache_l1>;
> +		};
> +
> +		A55_2: cpu@200 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a55";
> +			reg = <0x200>;
> +			enable-method = "psci";
> +			#cooling-cells = <2>;
> +			cpu-idle-states = <&cpu_pd_wait>;
> +			power-domains = <&scmi_devpd IMX95_PERF_A55>;
> +			power-domain-names = "perf";
> +			i-cache-size = <32768>;
> +			i-cache-line-size = <64>;
> +			i-cache-sets = <128>;
> +			d-cache-size = <32768>;
> +			d-cache-line-size = <64>;
> +			d-cache-sets = <128>;
> +			next-level-cache = <&l2_cache_l2>;
> +		};
> +
> +		A55_3: cpu@300 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a55";
> +			reg = <0x300>;
> +			enable-method = "psci";
> +			#cooling-cells = <2>;
> +			power-domains = <&scmi_devpd IMX95_PERF_A55>;
> +			power-domain-names = "perf";
> +			i-cache-size = <32768>;
> +			i-cache-line-size = <64>;
> +			i-cache-sets = <128>;
> +			d-cache-size = <32768>;
> +			d-cache-line-size = <64>;
> +			d-cache-sets = <128>;
> +			next-level-cache = <&l2_cache_l3>;
> +		};
> +
> +		A55_4: cpu@400 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a55";
> +			reg = <0x400>;
> +			power-domains = <&scmi_devpd IMX95_PERF_A55>;
> +			power-domain-names = "perf";
> +			enable-method = "psci";
> +			#cooling-cells = <2>;
> +			cpu-idle-states = <&cpu_pd_wait>;
> +			i-cache-size = <32768>;
> +			i-cache-line-size = <64>;
> +			i-cache-sets = <128>;
> +			d-cache-size = <32768>;
> +			d-cache-line-size = <64>;
> +			d-cache-sets = <128>;
> +			next-level-cache = <&l2_cache_l4>;
> +		};
> +
> +		A55_5: cpu@500 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a55";
> +			reg = <0x500>;
> +			power-domains = <&scmi_devpd IMX95_PERF_A55>;
> +			power-domain-names = "perf";
> +			enable-method = "psci";
> +			#cooling-cells = <2>;
> +			cpu-idle-states = <&cpu_pd_wait>;
> +			i-cache-size = <32768>;
> +			i-cache-line-size = <64>;
> +			i-cache-sets = <128>;
> +			d-cache-size = <32768>;
> +			d-cache-line-size = <64>;
> +			d-cache-sets = <128>;
> +			next-level-cache = <&l2_cache_l5>;
> +		};
> +
> +		l2_cache_l0: l2-cache-l0 {
> +			compatible = "cache";
> +			cache-size = <65536>;
> +			cache-line-size = <64>;
> +			cache-sets = <256>;
> +			cache-level = <2>;
> +			cache-unified;
> +			next-level-cache = <&l3_cache>;
> +		};
> +
> +		l2_cache_l1: l2-cache-l1 {
> +			compatible = "cache";
> +			cache-size = <65536>;
> +			cache-line-size = <64>;
> +			cache-sets = <256>;
> +			cache-level = <2>;
> +			cache-unified;
> +			next-level-cache = <&l3_cache>;
> +		};
> +
> +		l2_cache_l2: l2-cache-l2 {
> +			compatible = "cache";
> +			cache-size = <65536>;
> +			cache-line-size = <64>;
> +			cache-sets = <256>;
> +			cache-level = <2>;
> +			cache-unified;
> +			next-level-cache = <&l3_cache>;
> +		};
> +
> +		l2_cache_l3: l2-cache-l3 {
> +			compatible = "cache";
> +			cache-size = <65536>;
> +			cache-line-size = <64>;
> +			cache-sets = <256>;
> +			cache-level = <2>;
> +			cache-unified;
> +			next-level-cache = <&l3_cache>;
> +		};
> +
> +		l2_cache_l4: l2-cache-l4 {
> +			compatible = "cache";
> +			cache-size = <65536>;
> +			cache-line-size = <64>;
> +			cache-sets = <256>;
> +			cache-level = <2>;
> +			cache-unified;
> +			next-level-cache = <&l3_cache>;
> +		};
> +
> +		l2_cache_l5: l2-cache-l5 {
> +			compatible = "cache";
> +			cache-size = <65536>;
> +			cache-line-size = <64>;
> +			cache-sets = <256>;
> +			cache-level = <2>;
> +			cache-unified;
> +			next-level-cache = <&l3_cache>;
> +		};
> +
> +		l3_cache: l3-cache {
> +			compatible = "cache";
> +			cache-size = <524288>;
> +			cache-line-size = <64>;
> +			cache-sets = <1024>;
> +			cache-level = <3>;
> +			cache-unified;
> +		};
> +
> +		cpu-map {
> +			cluster0 {
> +				core0 {
> +					cpu = <&A55_0>;
> +				};
> +
> +				core1 {
> +					cpu = <&A55_1>;
> +				};
> +
> +				core2 {
> +					cpu = <&A55_2>;
> +				};
> +
> +				core3 {
> +					cpu = <&A55_3>;
> +				};
> +
> +				core4 {
> +					cpu = <&A55_4>;
> +				};
> +
> +				core5 {
> +					cpu = <&A55_5>;
> +				};
> +			};
> +		};
> +	};
> +
> +	clk_ext1: clock-ext1 {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <133000000>;
> +		clock-output-names = "clk_ext1";
> +	};
> +
> +	sai1_mclk: sai-mclk1 {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency= <0>;
> +		clock-output-names = "sai1_mclk";
> +	};
> +
> +	sai2_mclk: sai-mclk2 {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency= <0>;
> +		clock-output-names = "sai2_mclk";
> +	};
> +
> +	sai3_mclk: sai-mclk3 {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency= <0>;
> +		clock-output-names = "sai3_mclk";
> +	};
> +
> +	sai4_mclk: sai-mclk4 {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency= <0>;
> +		clock-output-names = "sai4_mclk";
> +	};
> +
> +	sai5_mclk: sai-mclk5 {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency= <0>;
> +		clock-output-names = "sai5_mclk";
> +	};
> +
> +	osc_24m: osc-24m {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <24000000>;
> +		clock-output-names = "osc_24m";
> +	};
> +
> +	sram1: sram@20480000 {
> +		compatible = "mmio-sram";
> +		reg = <0x0 0x204c0000 0x0 0x18000>;
> +		ranges = <0x0 0x0 0x204c0000 0x18000>;
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +	};

looks like it need general node name in
https://github.com/devicetree-org/devicetree-specification/releases/download/v0.4/devicetree-specification-v0.4.pdf
section 2.2.2

look like should be "sram-controller", please also check other node name to
match spec.

Frank

> +
> +	firmware {
> +		scmi {
> +			compatible = "arm,scmi";
> +			mboxes = <&mu2 5 0>, <&mu2 3 0>, <&mu2 3 1>;
> +			shmem = <&scmi_buf0>, <&scmi_buf1>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			scmi_devpd: protocol@11 {
> +				reg = <0x11>;
> +				#power-domain-cells = <1>;
> +			};
> +
> +			scmi_perf: protocol@13 {
> +				reg = <0x13>;
> +				#power-domain-cells = <1>;
> +			};
> +
> +			scmi_clk: protocol@14 {
> +				reg = <0x14>;
> +				#clock-cells = <1>;
> +			};
> +
> +			scmi_sensor: protocol@15 {
> +				reg = <0x15>;
> +				#thermal-sensor-cells = <1>;
> +			};
> +		};
> +	};
> +
> +	pmu {
> +		compatible = "arm,cortex-a55-pmu";
> +		interrupts = <GIC_PPI 7 (GIC_CPU_MASK_SIMPLE(6) | IRQ_TYPE_LEVEL_HIGH)>;
> +	};
> +
> +	thermal-zones {
> +		a55-thermal {
> +			polling-delay-passive = <250>;
> +			polling-delay = <2000>;
> +			thermal-sensors = <&scmi_sensor 1>;
> +
> +			trips {
> +				cpu_alert0: trip0 {
> +					temperature = <85000>;
> +					hysteresis = <2000>;
> +					type = "passive";
> +				};
> +
> +				cpu_crit0: trip1 {
> +					temperature = <95000>;
> +					hysteresis = <2000>;
> +					type = "critical";
> +				};
> +			};
> +
> +			cooling-maps {
> +				map0 {
> +					trip = <&cpu_alert0>;
> +					cooling-device =
> +						<&A55_0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +						<&A55_1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +						<&A55_2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +						<&A55_3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +						<&A55_4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +						<&A55_5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +				};
> +			};
> +		};
> +	};
> +
> +	psci {
> +		compatible = "arm,psci-1.0";
> +		method = "smc";
> +	};
> +
> +	timer {
> +		compatible = "arm,armv8-timer";
> +		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(6) | IRQ_TYPE_LEVEL_LOW)>,
> +			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(6) | IRQ_TYPE_LEVEL_LOW)>,
> +			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(6) | IRQ_TYPE_LEVEL_LOW)>,
> +			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(6) | IRQ_TYPE_LEVEL_LOW)>;
> +		clock-frequency = <24000000>;
> +		arm,no-tick-in-suspend;
> +		interrupt-parent = <&gic>;
> +	};
> +
> +	gic: interrupt-controller@48000000 {
> +		compatible = "arm,gic-v3";
> +		reg = <0 0x48000000 0 0x10000>,
> +		      <0 0x48060000 0 0xc0000>;
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		#interrupt-cells = <3>;
> +		interrupt-controller;
> +		interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
> +		interrupt-parent = <&gic>;
> +		dma-noncoherent;
> +		ranges;
> +
> +		its: msi-controller@48040000 {
> +			compatible = "arm,gic-v3-its";
> +			reg = <0 0x48040000 0 0x20000>;
> +			msi-controller;
> +			#msi-cells = <1>;
> +			dma-noncoherent;
> +		};
> +	};
> +
> +	soc {
> +		compatible = "simple-bus";
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		aips2: bus@42000000 {
> +			compatible = "fsl,aips-bus", "simple-bus";
> +			reg = <0x0 0x42000000 0x0 0x800000>;
> +			ranges = <0x42000000 0x0 0x42000000 0x8000000>,
> +				 <0x28000000 0x0 0x28000000 0x10000000>;
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +
> +			mu7: mailbox@42430000 {
> +				compatible = "fsl,imx95-mu";
> +				reg = <0x42430000 0x10000>;
> +				interrupts = <GIC_SPI 234 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&scmi_clk IMX95_CLK_BUSWAKEUP>;
> +				#mbox-cells = <2>;
> +				status = "disabled";
> +			};
> +
> +			wdog3: watchdog@42490000 {
> +				compatible = "fsl,imx93-wdt";
> +				reg = <0x42490000 0x10000>;
> +				interrupts = <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&scmi_clk IMX95_CLK_BUSWAKEUP>;
> +				timeout-sec = <40>;
> +				status = "disabled";
> +			};
> +
> +			tpm3: pwm@424e0000 {
> +				compatible = "fsl,imx7ulp-pwm";
> +				reg = <0x424e0000 0x1000>;
> +				clocks = <&scmi_clk IMX95_CLK_BUSWAKEUP>;
> +				#pwm-cells = <3>;
> +				status = "disabled";
> +			};
> +
> +			tpm4: pwm@424f0000 {
> +				compatible = "fsl,imx7ulp-pwm";
> +				reg = <0x424f0000 0x1000>;
> +				clocks = <&scmi_clk IMX95_CLK_TPM4>;
> +				#pwm-cells = <3>;
> +				status = "disabled";
> +			};
> +
> +			tpm5: pwm@42500000 {
> +				compatible = "fsl,imx7ulp-pwm";
> +				reg = <0x42500000 0x1000>;
> +				clocks = <&scmi_clk IMX95_CLK_TPM5>;
> +				#pwm-cells = <3>;
> +				status = "disabled";
> +			};
> +
> +			tpm6: pwm@42510000 {
> +				compatible = "fsl,imx7ulp-pwm";
> +				reg = <0x42510000 0x1000>;
> +				clocks = <&scmi_clk IMX95_CLK_TPM6>;
> +				#pwm-cells = <3>;
> +				status = "disabled";
> +			};
> +
> +			lpi2c3: i2c@42530000 {
> +				compatible = "fsl,imx95-lpi2c", "fsl,imx7ulp-lpi2c";
> +				reg = <0x42530000 0x10000>;
> +				interrupts = <GIC_SPI 58 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&scmi_clk IMX95_CLK_LPI2C3>,
> +					 <&scmi_clk IMX95_CLK_BUSWAKEUP>;
> +				clock-names = "per", "ipg";
> +				status = "disabled";
> +			};
> +
> +			lpi2c4: i2c@42540000 {
> +				compatible = "fsl,imx95-lpi2c", "fsl,imx7ulp-lpi2c";
> +				reg = <0x42540000 0x10000>;
> +				interrupts = <GIC_SPI 59 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&scmi_clk IMX95_CLK_LPI2C4>,
> +					 <&scmi_clk IMX95_CLK_BUSWAKEUP>;
> +				clock-names = "per", "ipg";
> +				status = "disabled";
> +			};
> +
> +			lpspi3: spi@42550000 {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				compatible = "fsl,imx95-spi", "fsl,imx7ulp-spi";
> +				reg = <0x42550000 0x10000>;
> +				interrupts = <GIC_SPI 61 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&scmi_clk IMX95_CLK_LPSPI3>,
> +					 <&scmi_clk IMX95_CLK_BUSWAKEUP>;
> +				clock-names = "per", "ipg";
> +				status = "disabled";
> +			};
> +
> +			lpspi4: spi@42560000 {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				compatible = "fsl,imx95-spi", "fsl,imx7ulp-spi";
> +				reg = <0x42560000 0x10000>;
> +				interrupts = <GIC_SPI 62 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&scmi_clk IMX95_CLK_LPSPI4>,
> +					 <&scmi_clk IMX95_CLK_BUSWAKEUP>;
> +				clock-names = "per", "ipg";
> +				status = "disabled";
> +			};
> +
> +			lpuart3: serial@42570000 {
> +				compatible = "fsl,imx95-lpuart", "fsl,imx8ulp-lpuart",
> +					     "fsl,imx7ulp-lpuart";
> +				reg = <0x42570000 0x1000>;
> +				interrupts = <GIC_SPI 64 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&scmi_clk IMX95_CLK_LPUART3>;
> +				clock-names = "ipg";
> +				status = "disabled";
> +			};
> +
> +			lpuart4: serial@42580000 {
> +				compatible = "fsl,imx95-lpuart", "fsl,imx8ulp-lpuart",
> +					     "fsl,imx7ulp-lpuart";
> +				reg = <0x42580000 0x1000>;
> +				interrupts = <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&scmi_clk IMX95_CLK_LPUART4>;
> +				clock-names = "ipg";
> +				status = "disabled";
> +			};
> +
> +			lpuart5: serial@42590000 {
> +				compatible = "fsl,imx95-lpuart", "fsl,imx8ulp-lpuart",
> +					     "fsl,imx7ulp-lpuart";
> +				reg = <0x42590000 0x1000>;
> +				interrupts = <GIC_SPI 66 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&scmi_clk IMX95_CLK_LPUART5>;
> +				clock-names = "ipg";
> +				status = "disabled";
> +			};
> +
> +			lpuart6: serial@425a0000 {
> +				compatible = "fsl,imx95-lpuart", "fsl,imx8ulp-lpuart",
> +					     "fsl,imx7ulp-lpuart";
> +				reg = <0x425a0000 0x1000>;
> +				interrupts = <GIC_SPI 67 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&scmi_clk IMX95_CLK_LPUART6>;
> +				clock-names = "ipg";
> +				status = "disabled";
> +			};
> +
> +			lpuart7: serial@42690000 {
> +				compatible = "fsl,imx95-lpuart", "fsl,imx8ulp-lpuart",
> +					     "fsl,imx7ulp-lpuart";
> +				reg = <0x42690000 0x1000>;
> +				interrupts = <GIC_SPI 68 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&scmi_clk IMX95_CLK_LPUART7>;
> +				clock-names = "ipg";
> +				status = "disabled";
> +			};
> +
> +			lpuart8: serial@426a0000 {
> +				compatible = "fsl,imx95-lpuart", "fsl,imx8ulp-lpuart",
> +					     "fsl,imx7ulp-lpuart";
> +				reg = <0x426a0000 0x1000>;
> +				interrupts = <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&scmi_clk IMX95_CLK_LPUART8>;
> +				clock-names = "ipg";
> +				status = "disabled";
> +			};
> +
> +			lpi2c5: i2c@426b0000 {
> +				compatible = "fsl,imx95-lpi2c", "fsl,imx7ulp-lpi2c";
> +				reg = <0x426b0000 0x10000>;
> +				interrupts = <GIC_SPI 181 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&scmi_clk IMX95_CLK_LPI2C5>,
> +					 <&scmi_clk IMX95_CLK_BUSWAKEUP>;
> +				clock-names = "per", "ipg";
> +				status = "disabled";
> +			};
> +
> +			lpi2c6: i2c@426c0000 {
> +				compatible = "fsl,imx95-lpi2c", "fsl,imx7ulp-lpi2c";
> +				reg = <0x426c0000 0x10000>;
> +				interrupts = <GIC_SPI 182 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&scmi_clk IMX95_CLK_LPI2C6>,
> +					 <&scmi_clk IMX95_CLK_BUSWAKEUP>;
> +				clock-names = "per", "ipg";
> +				status = "disabled";
> +			};
> +
> +			lpi2c7: i2c@426d0000 {
> +				compatible = "fsl,imx95-lpi2c", "fsl,imx7ulp-lpi2c";
> +				reg = <0x426d0000 0x10000>;
> +				interrupts = <GIC_SPI 183 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&scmi_clk IMX95_CLK_LPI2C7>,
> +					 <&scmi_clk IMX95_CLK_BUSWAKEUP>;
> +				clock-names = "per", "ipg";
> +				status = "disabled";
> +			};
> +
> +			lpi2c8: i2c@426e0000 {
> +				compatible = "fsl,imx95-lpi2c", "fsl,imx7ulp-lpi2c";
> +				reg = <0x426e0000 0x10000>;
> +				interrupts = <GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&scmi_clk IMX95_CLK_LPI2C8>,
> +					 <&scmi_clk IMX95_CLK_BUSWAKEUP>;
> +				clock-names = "per", "ipg";
> +				status = "disabled";
> +			};
> +
> +			lpspi5: spi@426f0000 {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				compatible = "fsl,imx95-spi", "fsl,imx7ulp-spi";
> +				reg = <0x426f0000 0x10000>;
> +				interrupts = <GIC_SPI 177 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&scmi_clk IMX95_CLK_LPSPI5>,
> +					 <&scmi_clk IMX95_CLK_BUSWAKEUP>;
> +				clock-names = "per", "ipg";
> +				status = "disabled";
> +			};
> +
> +			lpspi6: spi@42700000 {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				compatible = "fsl,imx95-spi", "fsl,imx7ulp-spi";
> +				reg = <0x42700000 0x10000>;
> +				interrupts = <GIC_SPI 178 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&scmi_clk IMX95_CLK_LPSPI6>,
> +					 <&scmi_clk IMX95_CLK_BUSWAKEUP>;
> +				clock-names = "per", "ipg";
> +				status = "disabled";
> +			};
> +
> +			lpspi7: spi@42710000 {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				compatible = "fsl,imx95-spi", "fsl,imx7ulp-spi";
> +				reg = <0x42710000 0x10000>;
> +				interrupts = <GIC_SPI 179 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&scmi_clk IMX95_CLK_LPSPI7>,
> +					 <&scmi_clk IMX95_CLK_BUSWAKEUP>;
> +				clock-names = "per", "ipg";
> +				status = "disabled";
> +			};
> +
> +			lpspi8: spi@42720000 {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				compatible = "fsl,imx95-spi", "fsl,imx7ulp-spi";
> +				reg = <0x42720000 0x10000>;
> +				interrupts = <GIC_SPI 180 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&scmi_clk IMX95_CLK_LPSPI8>,
> +					 <&scmi_clk IMX95_CLK_BUSWAKEUP>;
> +				clock-names = "per", "ipg";
> +				status = "disabled";
> +			};
> +
> +			mu8: mailbox@42730000 {
> +				compatible = "fsl,imx95-mu";
> +				reg = <0x42730000 0x10000>;
> +				interrupts = <GIC_SPI 235 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&scmi_clk IMX95_CLK_BUSWAKEUP>;
> +				#mbox-cells = <2>;
> +				status = "disabled";
> +			};
> +		};
> +
> +		aips3: bus@42800000 {
> +			compatible = "fsl,aips-bus", "simple-bus";
> +			reg = <0 0x42800000 0 0x800000>;
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ranges = <0x42800000 0x0 0x42800000 0x800000>;
> +
> +			usdhc1: mmc@42850000 {
> +				compatible = "fsl,imx95-usdhc", "fsl,imx8mm-usdhc";
> +				reg = <0x42850000 0x10000>;
> +				interrupts = <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&scmi_clk IMX95_CLK_BUSWAKEUP>,
> +					 <&scmi_clk IMX95_CLK_WAKEUPAXI>,
> +					 <&scmi_clk IMX95_CLK_USDHC1>;
> +				clock-names = "ipg", "ahb", "per";
> +				assigned-clocks = <&scmi_clk IMX95_CLK_USDHC1>;
> +				assigned-clock-parents = <&scmi_clk IMX95_CLK_SYSPLL1_PFD1>;
> +				assigned-clock-rates = <400000000>;
> +				bus-width = <8>;
> +				fsl,tuning-start-tap = <1>;
> +				fsl,tuning-step= <2>;
> +				status = "disabled";
> +			};
> +
> +			usdhc2: mmc@42860000 {
> +				compatible = "fsl,imx95-usdhc", "fsl,imx8mm-usdhc";
> +				reg = <0x42860000 0x10000>;
> +				interrupts = <GIC_SPI 87 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&scmi_clk IMX95_CLK_BUSWAKEUP>,
> +					 <&scmi_clk IMX95_CLK_WAKEUPAXI>,
> +					 <&scmi_clk IMX95_CLK_USDHC2>;
> +				clock-names = "ipg", "ahb", "per";
> +				assigned-clocks = <&scmi_clk IMX95_CLK_USDHC2>;
> +				assigned-clock-parents = <&scmi_clk IMX95_CLK_SYSPLL1_PFD1>;
> +				assigned-clock-rates = <400000000>;
> +				bus-width = <4>;
> +				fsl,tuning-start-tap = <1>;
> +				fsl,tuning-step= <2>;
> +				status = "disabled";
> +			};
> +
> +			usdhc3: mmc@428b0000 {
> +				compatible = "fsl,imx95-usdhc", "fsl,imx8mm-usdhc";
> +				reg = <0x428b0000 0x10000>;
> +				interrupts = <GIC_SPI 191 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&scmi_clk IMX95_CLK_BUSWAKEUP>,
> +					 <&scmi_clk IMX95_CLK_WAKEUPAXI>,
> +					 <&scmi_clk IMX95_CLK_USDHC3>;
> +				clock-names = "ipg", "ahb", "per";
> +				assigned-clock-parents = <&scmi_clk IMX95_CLK_SYSPLL1_PFD1>;
> +				assigned-clock-rates = <400000000>;
> +				bus-width = <4>;
> +				fsl,tuning-start-tap = <1>;
> +				fsl,tuning-step= <2>;
> +				status = "disabled";
> +			};
> +		};
> +
> +		gpio2: gpio@43810000 {
> +			compatible = "fsl,imx95-gpio", "fsl,imx8ulp-gpio";
> +			reg = <0x0 0x43810000 0x0 0x1000>;
> +			gpio-controller;
> +			#gpio-cells = <2>;
> +			interrupts = <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 50 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-controller;
> +			#interrupt-cells = <2>;
> +			clocks = <&scmi_clk IMX95_CLK_BUSWAKEUP>,
> +				 <&scmi_clk IMX95_CLK_BUSWAKEUP>;
> +			clock-names = "gpio", "port";
> +		};
> +
> +		gpio3: gpio@43820000 {
> +			compatible = "fsl,imx95-gpio", "fsl,imx8ulp-gpio";
> +			reg = <0x0 0x43820000 0x0 0x1000>;
> +			gpio-controller;
> +			#gpio-cells = <2>;
> +			interrupts = <GIC_SPI 51 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 52 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-controller;
> +			#interrupt-cells = <2>;
> +			clocks = <&scmi_clk IMX95_CLK_BUSWAKEUP>,
> +				 <&scmi_clk IMX95_CLK_BUSWAKEUP>;
> +			clock-names = "gpio", "port";
> +		};
> +
> +		gpio4: gpio@43840000 {
> +			compatible = "fsl,imx95-gpio", "fsl,imx8ulp-gpio";
> +			reg = <0x0 0x43840000 0x0 0x1000>;
> +			gpio-controller;
> +			#gpio-cells = <2>;
> +			interrupts = <GIC_SPI 53 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 54 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-controller;
> +			#interrupt-cells = <2>;
> +			clocks = <&scmi_clk IMX95_CLK_BUSWAKEUP>,
> +				 <&scmi_clk IMX95_CLK_BUSWAKEUP>;
> +			clock-names = "gpio", "port";
> +		};
> +
> +		gpio5: gpio@43850000 {
> +			compatible = "fsl,imx95-gpio", "fsl,imx8ulp-gpio";
> +			reg = <0x0 0x43850000 0x0 0x1000>;
> +			gpio-controller;
> +			#gpio-cells = <2>;
> +			interrupts = <GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-controller;
> +			#interrupt-cells = <2>;
> +			clocks = <&scmi_clk IMX95_CLK_BUSWAKEUP>,
> +				 <&scmi_clk IMX95_CLK_BUSWAKEUP>;
> +			clock-names = "gpio", "port";
> +		};
> +
> +		aips1: bus@44000000 {
> +			compatible = "fsl,aips-bus", "simple-bus";
> +			reg = <0x0 0x44000000 0x0 0x800000>;
> +			ranges = <0x44000000 0x0 0x44000000 0x800000>;
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +
> +			mu1: mailbox@44220000 {
> +				compatible = "fsl,imx95-mu";
> +				reg = <0x44220000 0x10000>;
> +				interrupts = <GIC_SPI 224 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&scmi_clk IMX95_CLK_BUSAON>;
> +				#mbox-cells = <2>;
> +				status = "disabled";
> +			};
> +
> +			tpm1: pwm@44310000 {
> +				compatible = "fsl,imx7ulp-pwm";
> +				reg = <0x44310000 0x1000>;
> +				clocks = <&scmi_clk IMX95_CLK_BUSAON>;
> +				#pwm-cells = <3>;
> +				status = "disabled";
> +			};
> +
> +			tpm2: pwm@44320000 {
> +				compatible = "fsl,imx7ulp-pwm";
> +				reg = <0x44320000 0x1000>;
> +				clocks = <&scmi_clk IMX95_CLK_TPM2>;
> +				#pwm-cells = <3>;
> +				status = "disabled";
> +			};
> +
> +			lpi2c1: i2c@44340000 {
> +				compatible = "fsl,imx95-lpi2c", "fsl,imx7ulp-lpi2c";
> +				reg = <0x44340000 0x10000>;
> +				interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&scmi_clk IMX95_CLK_LPI2C1>,
> +					 <&scmi_clk IMX95_CLK_BUSAON>;
> +				clock-names = "per", "ipg";
> +				status = "disabled";
> +			};
> +
> +			lpi2c2: i2c@44350000 {
> +				compatible = "fsl,imx95-lpi2c", "fsl,imx7ulp-lpi2c";
> +				reg = <0x44350000 0x10000>;
> +				interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&scmi_clk IMX95_CLK_LPI2C2>,
> +					 <&scmi_clk IMX95_CLK_BUSAON>;
> +				clock-names = "per", "ipg";
> +				status = "disabled";
> +			};
> +
> +			lpspi1: spi@44360000 {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				compatible = "fsl,imx95-spi", "fsl,imx7ulp-spi";
> +				reg = <0x44360000 0x10000>;
> +				interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&scmi_clk IMX95_CLK_LPSPI1>,
> +					 <&scmi_clk IMX95_CLK_BUSAON>;
> +				clock-names = "per", "ipg";
> +				status = "disabled";
> +			};
> +
> +			lpspi2: spi@44370000 {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				compatible = "fsl,imx95-spi", "fsl,imx7ulp-spi";
> +				reg = <0x44370000 0x10000>;
> +				interrupts = <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&scmi_clk IMX95_CLK_LPSPI2>,
> +					 <&scmi_clk IMX95_CLK_BUSAON>;
> +				clock-names = "per", "ipg";
> +				status = "disabled";
> +			};
> +
> +			lpuart1: serial@44380000 {
> +				compatible = "fsl,imx95-lpuart", "fsl,imx8ulp-lpuart",
> +					     "fsl,imx7ulp-lpuart";
> +				reg = <0x44380000 0x1000>;
> +				interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&scmi_clk IMX95_CLK_LPUART1>;
> +				clock-names = "ipg";
> +				status = "disabled";
> +			};
> +
> +			lpuart2: serial@44390000 {
> +				compatible = "fsl,imx95-lpuart", "fsl,imx8ulp-lpuart",
> +					     "fsl,imx7ulp-lpuart";
> +				reg = <0x44390000 0x1000>;
> +				interrupts = <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&scmi_clk IMX95_CLK_LPUART2>;
> +				clock-names = "ipg";
> +				status = "disabled";
> +			};
> +
> +			adc1: adc@44530000 {
> +				compatible = "nxp,imx93-adc";
> +				reg = <0x44530000 0x10000>;
> +				interrupts = <GIC_SPI 199 IRQ_TYPE_LEVEL_HIGH>,
> +					     <GIC_SPI 200 IRQ_TYPE_LEVEL_HIGH>,
> +					     <GIC_SPI 201 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&scmi_clk IMX95_CLK_ADC>;
> +				clock-names = "ipg";
> +				status = "disabled";
> +			};
> +
> +			mu2: mailbox@445b0000 {
> +				compatible = "fsl,imx95-mu";
> +				reg = <0x445b0000 0x1000>;
> +				ranges;
> +				interrupts = <GIC_SPI 226 IRQ_TYPE_LEVEL_HIGH>;
> +				#address-cells = <1>;
> +				#size-cells = <1>;
> +				#mbox-cells = <2>;
> +
> +				sram0: sram@445b1000 {
> +					compatible = "mmio-sram";
> +					reg = <0x445b1000 0x400>;
> +					ranges = <0x0 0x445b1000 0x400>;
> +					#address-cells = <1>;
> +					#size-cells = <1>;
> +
> +					scmi_buf0: scmi-sram-section@0 {
> +						compatible = "arm,scmi-shmem";
> +						reg = <0x0 0x80>;
> +					};
> +
> +					scmi_buf1: scmi-sram-section@80 {
> +						compatible = "arm,scmi-shmem";
> +						reg = <0x80 0x80>;
> +					};
> +				};
> +
> +			};
> +
> +			mu3: mailbox@445d0000 {
> +				compatible = "fsl,imx95-mu";
> +				reg = <0x445d0000 0x10000>;
> +				interrupts = <GIC_SPI 228 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&scmi_clk IMX95_CLK_BUSAON>;
> +				#mbox-cells = <2>;
> +				status = "disabled";
> +			};
> +
> +			mu4: mailbox@445f0000 {
> +				compatible = "fsl,imx95-mu";
> +				reg = <0x445f0000 0x10000>;
> +				interrupts = <GIC_SPI 230 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&scmi_clk IMX95_CLK_BUSAON>;
> +				#mbox-cells = <2>;
> +				status = "disabled";
> +			};
> +
> +			mu6: mailbox@44630000 {
> +				compatible = "fsl,imx95-mu";
> +				reg = <0x44630000 0x10000>;
> +				interrupts = <GIC_SPI 206 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&scmi_clk IMX95_CLK_BUSAON>;
> +				#mbox-cells = <2>;
> +				status = "disabled";
> +			};
> +		};
> +
> +		mailbox@47320000 {
> +			compatible = "fsl,imx95-mu-v2x";
> +			reg = <0x0 0x47320000 0x0 0x10000>;
> +			interrupts = <GIC_SPI 254 IRQ_TYPE_LEVEL_HIGH>;
> +			#mbox-cells = <2>;
> +		};
> +
> +		mailbox@47350000 {
> +			compatible = "fsl,imx95-mu-v2x";
> +			reg = <0x0 0x47350000 0x0 0x10000>;
> +			interrupts = <GIC_SPI 255 IRQ_TYPE_LEVEL_HIGH>;
> +			#mbox-cells = <2>;
> +		};
> +
> +		/* GPIO1 is under exclusive control of System Manager */
> +		gpio1: gpio@47400000 {
> +			compatible = "fsl,imx95-gpio", "fsl,imx8ulp-gpio";
> +			reg = <0x0 0x47400000 0x0 0x1000>;
> +			gpio-controller;
> +			#gpio-cells = <2>;
> +			interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-controller;
> +			#interrupt-cells = <2>;
> +			clocks = <&scmi_clk IMX95_CLK_M33>,
> +				 <&scmi_clk IMX95_CLK_M33>;
> +			clock-names = "gpio", "port";
> +			status = "disabled";
> +		};
> +
> +		elemu0: mailbox@47520000 {
> +			compatible = "fsl,imx95-mu-ele";
> +			reg = <0x0 0x47520000 0x0 0x10000>;
> +			interrupts = <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>;
> +			#mbox-cells = <2>;
> +			status = "disabled";
> +		};
> +
> +		elemu1: mailbox@47530000 {
> +			compatible = "fsl,imx95-mu-ele";
> +			reg = <0x0 0x47530000 0x0 0x10000>;
> +			interrupts = <GIC_SPI 22 IRQ_TYPE_LEVEL_HIGH>;
> +			#mbox-cells = <2>;
> +			status = "disabled";
> +		};
> +
> +		elemu2: mailbox@47540000 {
> +			compatible = "fsl,imx95-mu-ele";
> +			reg = <0x0 0x47540000 0x0 0x10000>;
> +			interrupts = <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>;
> +			#mbox-cells = <2>;
> +			status = "disabled";
> +		};
> +
> +		elemu3: mailbox@47550000 {
> +			compatible = "fsl,imx95-mu-ele";
> +			reg = <0x0 0x47550000 0x0 0x10000>;
> +			interrupts = <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>;
> +			#mbox-cells = <2>;
> +		};
> +
> +		elemu4: mailbox@47560000 {
> +			compatible = "fsl,imx95-mu-ele";
> +			reg = <0x0 0x47560000 0x0 0x10000>;
> +			interrupts = <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
> +			#mbox-cells = <2>;
> +			status = "disabled";
> +		};
> +
> +		elemu5: mailbox@47570000 {
> +			compatible = "fsl,imx95-mu-ele";
> +			reg = <0x0 0x47570000 0x0 0x10000>;
> +			interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
> +			#mbox-cells = <2>;
> +			status = "disabled";
> +		};
> +
> +		aips4: bus@49000000 {
> +			compatible = "fsl,aips-bus", "simple-bus";
> +			reg = <0x0 0x49000000 0x0 0x800000>;
> +			ranges = <0x49000000 0x0 0x49000000 0x800000>;
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +
> +			smmu: iommu@490d0000 {
> +				compatible = "arm,smmu-v3";
> +				reg = <0x490d0000 0x100000>;
> +				interrupts = <GIC_SPI 325 IRQ_TYPE_EDGE_RISING>,
> +					     <GIC_SPI 328 IRQ_TYPE_EDGE_RISING>,
> +					     <GIC_SPI 334 IRQ_TYPE_EDGE_RISING>,
> +					     <GIC_SPI 326 IRQ_TYPE_EDGE_RISING>;
> +				interrupt-names = "eventq", "gerror", "priq", "cmdq-sync";
> +				#iommu-cells = <1>;
> +				status = "disabled";
> +			};
> +		};
> +	};
> +};
> 
> -- 
> 2.37.1
> 

