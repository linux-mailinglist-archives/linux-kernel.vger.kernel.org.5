Return-Path: <linux-kernel+bounces-148870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D687B8A885F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 18:02:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 022AA1C22415
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 16:02:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F36161487ED;
	Wed, 17 Apr 2024 16:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="SD98HTn8"
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2072.outbound.protection.outlook.com [40.107.15.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21841482E8;
	Wed, 17 Apr 2024 16:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.15.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713369720; cv=fail; b=StKe6qFLYXPdiizRrrE3dX/bwixkjTKUjOh2U+H05qfRbSX6GA7F8DE/B/ynVBhtYEILcsb5XF7/MIDmO6qGzPO1ZyG2G5RwaaxqtGbbKJ+liQorfvmXooFymxUdKawu63ubBInR6CkY7BVpFgrqmamywHtat1MQs27J66sXD8o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713369720; c=relaxed/simple;
	bh=iTfBi1ljdO/gVEn3bxqOmNp83KWzlvqLJNiIkIS70nM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=r+h60G/u1weYkMquhuyT23chudh3NG2HD1HD1w8AU5iY3OijGUqZgsep2BPdjbW+xt+GWBfN6AbErsIWBvhOOzGb2m1L8wIuSu7s0GaH+WhNy23UzZo4CsyXlCXIZq7USaVrebdPi/pxNJMbez5azh2oLKnW9qyW5B8Tn0UgR94=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=SD98HTn8; arc=fail smtp.client-ip=40.107.15.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L+UeIVW7ugVgt2lxhAxFDUTgBJYFjXnYY3vPsEsuHDi3weMuCOG41+wWiww+X5UUPaKEP3YjJMXzLLtZNfECLEMG2z8a63qZ9sNt1peCbX10p5lcF8Y4QMyuKwRTR0HwKIDrENOusdxaRy8VXI1I0fQ83WWfM8GhPebaBEM2kfXx9LWf8zILkHrv0Z2L8iMKVUDegXik/HRDkdBbl7hKxB1W9lpMYs0Zil08F0Fkn02SOzaGMakCM8nfWNW9ZJVpZ8uU6cg+rqqONW0H827zbAfskvuIWl3JyJ2il87BKk4tsZ8V5uH7EGERaSQ1i1szp+7KPIpHGF5aAYLjg6PKAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L6yxTkerBBPNqp9ym01CloHnWWo865BtD6cTqMLl57g=;
 b=irwAZ1v2Sj+sTjH5pAEkcgu/xCzZaV/C7GMmqY1vFCjfZkccgKZipjAqtBqzqL0d1KvefMOOKMHuU5UIItf1iE4dTdTmoULC/E8MREnC3f6MaX8cZGDC0UIUQe/Rh4ZyNSzLNi74l9xB2k2JLr1G3IhFPhzis2msZ4vpJzYZGU073drgrt82y9sBzBVShpIbgZp9I2H4xF1Y04rJ/WocVayagYeFDagVzxkIwC/IalF+lY2t+vLzXMenq6bqCznWHpiyfmliE5pnjK141fdRZaNELSYQZGbvwkXq7j76zQZU/Cyr3wGJPQHa8CfLv5DolooSP6vcyh77RBL7XyWbtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L6yxTkerBBPNqp9ym01CloHnWWo865BtD6cTqMLl57g=;
 b=SD98HTn8iqHUOL/YTo7fx5Q74QxPVv3+mlMuCGtrCPt4K3mYGILsUVs5UpM4u0apZE6CGG+eoj+ot+9OY18Rm4ag8moPnJXxWtAdqpqRkpDlcGdW4H5gO8pSwa6ByJV528NgUxJBlwNhkcfFaWd3wO9eXmPUGQ/KQixnso05CA8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI1PR04MB10002.eurprd04.prod.outlook.com (2603:10a6:800:1d7::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Wed, 17 Apr
 2024 16:01:51 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58%7]) with mapi id 15.20.7452.049; Wed, 17 Apr 2024
 16:01:51 +0000
Date: Wed, 17 Apr 2024 12:01:43 -0400
From: Frank Li <Frank.li@nxp.com>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/10] arm64: dts: imx8qm-ss-audio: add audio nodes
Message-ID: <Zh/yZ2HyF+G8bty7@lizhi-Precision-Tower-5810>
References: <20240415-dts_8qm_audio-v1-0-2976c35a0c52@nxp.com>
 <20240415-dts_8qm_audio-v1-2-2976c35a0c52@nxp.com>
 <20240416065026.GA4165@francesco-nb>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240416065026.GA4165@francesco-nb>
X-ClientProxiedBy: BYAPR06CA0010.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::23) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI1PR04MB10002:EE_
X-MS-Office365-Filtering-Correlation-Id: e43ab70e-28aa-436f-2410-08dc5ef7b1fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	VN8Urjq6mf7TMGnIcO31lbpaB/e8oEB6v/8mCEIuEmS+zTx/Wbz3Juv8xBWa7JXwx4x3URxnAPn7h4O3+8q1DCV7Lbj0vUFekQ+DmPoudRy4fFb3jKE6DfkfyaptyA4Wo+AiG51prl7wE7pv0RSnfySunl5qrgwQrrhxqUwNpwe7B6/oeuWkRmaHfefC+Qo6OwD6Pv15EGrp8K/S0TRHnRk+dLaiUL5kW8mUsJWhl8RsSrY7TS1TaxCNylSFplonM7nNW3nWJau94i5aFKhdY02jUzhy+UUdxX7Fbke8sRY1tSsLWpNhbaqcoezW/cOcb3jwCMVFrAJDUyBo91t3hKxarB4fW6ioLRBw5hi2reACMRLFP0yFDOuheZ/S0MUFaMoJ1kVYFxYmW753bJKv3ZWi7zJPj2nhMHc7gTabgUomFSFFv8+15rU2k/dULImeOVcbObSD9fw4dVZauX2noBYhltYR2yoVX/JY1umWqaKHUFytQccj+Ddg9P1Rnsl4LscCw8CSGgM8iPrjKEAl9cVgHfF3pzxD3ZPJHhKbao6smcDDy9Zd1ALJQkNcWh8N9M0oh9Y0wwI4siSi7Y79FBD1d/c1iVbA8OhbAHPbyNUnB4yZKT7Itvyvmqrmvl1YTuMqFk8YBmH3j3xyxK+9iwD/x/9HJKv4raMAWrbLgz7g6tkxqerD2vFhFlFLt0Fer94qKO2L4XwzwuirxnmR+Z5bQrSmUhdUIblZeFWPhO4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(7416005)(1800799015)(52116005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?klBhC4Ycp1JEJEYExKvZ6WjTNxUuxWQCv1XdsXKjXI5q0WjCBoEIvuJtI72D?=
 =?us-ascii?Q?QVysUbSRgCPbjiNnnsrsY8qRAwWY+lyfe8FoR77ykJWac2hjlqXnkuma/xhr?=
 =?us-ascii?Q?dv8oH5zNHeMK401quP4d6VmWT+9AxseFpCcWJcbsii87NLeGUivUBrT+HN6A?=
 =?us-ascii?Q?a2aYcR39BWtqHc4SDzEmu8FtG1Cb7CE9m94FzJ67L1mGQVs2pgew4p4wgjF/?=
 =?us-ascii?Q?EP3q/ZXlTEd4BYeMMi9s9UbpWMnC+eU8yZYpQaF6FjvVYelR0HYxUforWJCA?=
 =?us-ascii?Q?PnYHu0G52k+MqbFF0+VnHnm0IWqHUzB1WXsZfRzsmf8RoP/99dD2MkAnygk2?=
 =?us-ascii?Q?oEaF/5FJKQ1xcK9gtlg/VipzlDGRYWkHd3DxPMj3lf52nO22wz3e5vq9Iw3m?=
 =?us-ascii?Q?bxm/70HjVLpik8bJgSqLxK8udnt67vSi/MdVr1XzWIfxrHrJZ0n+oEv1cycR?=
 =?us-ascii?Q?NciVTNh3rYuJWdmxw2GE6QaQ54uO8eNvci1bhDtRKTBUGXjLNmraO3atrDoe?=
 =?us-ascii?Q?jGGjl9UKQr5UIO3d+p2kjTCoFRhiJPX31FKFlu9RryiIDjWHmFqrXapSxPAS?=
 =?us-ascii?Q?rAVZI1grRHeSYrwXd6ENHBQRJW8FBTix3RY7tGK+91kp51l4Xchn/8N8SoAW?=
 =?us-ascii?Q?4jxsCSr0E6vlqfnhY/hituk8ORaaO6BDZpVugjX/T4IGewK8bELxquWq6LAQ?=
 =?us-ascii?Q?EoBe4XbcMuvYH/ciTpeZuYNMNqXozzoCtyncZIziOuOM7itobqpYS/dukhb3?=
 =?us-ascii?Q?C2Zz0LmPnUnJZR3EQyut5OeJpx3MFjKLO+cSISBheNXWIKoJ5poSaGn17Hpv?=
 =?us-ascii?Q?35jl/wU/2Lsw2+qJDm96IB2kE8JZXDeIsbXYZv9pWhFEeYSJERLUJz7s51dG?=
 =?us-ascii?Q?AH1T8GG20yPWd+qnlY3IsUx8q+mwrihKaODTELEt9pbwGEkgCzkyF4PAyon4?=
 =?us-ascii?Q?9r4UB70Kb/1FwC5CdS/ZdaGQgUGL5Rv9gvDu5F33fsq+q2VC8uqU+MG/T0EM?=
 =?us-ascii?Q?SVY+AGty4ehYE7YfkmbtyYDd6GPU+WKL2uEkgGaVC7tDH/i5Wi65lhY/vgUo?=
 =?us-ascii?Q?SroibiOdO+q3HMKklnwi7MWL8rWj743FB42H3FqmEqK3ExbcORZ5D6H0FO+o?=
 =?us-ascii?Q?lg5XI+dn3wOnmW61WynO5T4XJS+QL8PJyWZOuU2+oeMp5y0/k0SWGUwxsamr?=
 =?us-ascii?Q?aqPKoDwvoqGTBmVl1C3h/KoqNq4gf2VfMzAerEAbK1ibcaY4OvipWCTDHq9u?=
 =?us-ascii?Q?YZbaRy6lr/aOyXpuqFzz0NE/FPK47onRrakaq5SVWnwLNnM3oo/QP8E5+L3g?=
 =?us-ascii?Q?G2IljawymOuhZCjn+OQaDw9Xd3AaG38iECHbdKMmKypwnaTOs7zlynbEdKXA?=
 =?us-ascii?Q?ER3rq7q8vREeMFbHoBxKmB2FZrBvE3pnZ956gLCCXz1RJM1E/6+AwCnlH9ki?=
 =?us-ascii?Q?onh5e8NzBdwUw8YKUHecqKbHxY5a7T/eVteiEfe6BGZZP7rNbbACPdLcltqD?=
 =?us-ascii?Q?SAAIo3fvBKtC3IIGyWIhxT/cY4TzKbF/R3zw9fPGP8vEpOLXzf101y4aQ6Uy?=
 =?us-ascii?Q?WlItD3kf2NAsiN5YHIP4RTPE97Hg6ejQHutBIZhZ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e43ab70e-28aa-436f-2410-08dc5ef7b1fb
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2024 16:01:51.6771
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MmHcYIdxyfmo/tsSJkz5t7MZMUJfk5bOKZ44liUPnNcT/YgjrRzfBqCf6Pw7c3tHz1GSn2x+5TWJTrPx/sCOtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB10002

On Tue, Apr 16, 2024 at 08:50:26AM +0200, Francesco Dolcini wrote:
> Hello Frank,
> 
> On Mon, Apr 15, 2024 at 03:46:38PM -0400, Frank Li wrote:
> > Add i.MX8QM audio related nodes and update eDMA[0,1]'s information.
> > 
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> >  arch/arm64/boot/dts/freescale/imx8qm-ss-audio.dtsi | 473 +++++++++++++++++++++
> >  arch/arm64/boot/dts/freescale/imx8qm.dtsi          |  86 ++++
> >  2 files changed, 559 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/freescale/imx8qm-ss-audio.dtsi b/arch/arm64/boot/dts/freescale/imx8qm-ss-audio.dtsi
> > new file mode 100644
> > index 0000000000000..ed5a1b4af1d76
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/freescale/imx8qm-ss-audio.dtsi
> > @@ -0,0 +1,473 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> 
> OR MIT?

All other qm related dtsi is only license GPLv2. If add Or MIT, it need
re-license whole include tree files, which out of scope of this patch. I
feel like to keep consistent with other files.

> 
> Normally for device tree files having both is preferred.
> 
> > +/*
> > + * Copyright 2024 NXP
> > + *	Dong Aisheng <aisheng.dong@nxp.com>
> > + */
> > +
> > +/delete-node/ &acm;
> > +/delete-node/ &sai4;
> > +/delete-node/ &sai5;
> > +/delete-node/ &sai4_lpcg;
> > +/delete-node/ &sai5_lpcg;
> 
> Can you explain these delete-node ? This is something that I would
> expect when a dtsi is previously included, not in this case.

We want to avoid some property inherent from parent dtsi file because it is
big difference with common one.

This node will be rewrite totally in this files.

> 
> Francesco
> 

