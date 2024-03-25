Return-Path: <linux-kernel+bounces-116363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CAD8A88980A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:25:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE9971C312C7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14BCE1C2560;
	Mon, 25 Mar 2024 04:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="QDRzDwQJ"
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04olkn2091.outbound.protection.outlook.com [40.92.46.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 127232E358D;
	Mon, 25 Mar 2024 00:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.46.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711328292; cv=fail; b=L/8W+I6v3r3Mmck0m9uvOoBNt0ju9V0t5stIdpd9yYj10h4W5E7ltvqVJnQNKvYQbEOJdA7OazGfW/wehYZNPHm8lanhjw8YGg1n7vFGHFgS3k+FUqSazesbyHksCAAwcThf4IUPKWfOoTLPgT4yK4eHuKp/k9SDGe63Ltm9SS4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711328292; c=relaxed/simple;
	bh=KgaMsnEql/NWkbI8f9glML1qGvZun4KoNxQlf2aKoKo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nN+41bJqSe+++2FxvA2RzkInoMs5P1rfmWEbBmv3riiCqBmvYZWFn8IzRR1xLC862drAnyQ8EEHnkQULxspp2sxfVLhZffhuTfNQ6luWHa8qt9HQPNRm1+9UGNJlopYcqogbyoy8ZY9WJrxSaAYh4X3iNPCUhUhPv0yluQCfm5c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=QDRzDwQJ; arc=fail smtp.client-ip=40.92.46.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JAJpujggKPcLGNlXqrq8YXzp28t+DWG7EHorT9MOCMqXtPKZA7ocA9YavPgEnxbaeKdjBZjPnHvfYEzk0d6/W9qKT45K1T3o8aNqE67GxDBXduZ3EN08XYh597QdeRs1sJkUVkLnVK3KU5mrsaYJxaUDyk7vz6L2NBrpL7A8QXxXxKH+crml5DifOdadJjcrStfox++GrMUZ7czZD9Lmzj9Rq4iYJSnOwN4KvBRcbaUotATNl4fmUcn78EFDPEe8M4ZEV+6nfxUTGIfIR79OaRS/y/VVrmnRYpxrrOeetBWE7pYYIfE+NsaQXCR1Qp2Gx5Gxap40M0goyugzWqBrPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eXV0pNlTngq5NvbpluV+J0UuGpZtvCSejefgeuSl1fU=;
 b=FlD+DG1FX+/iYGPncB2c4aAi3UBFJh3CXsSL13TnLNHdquM3c3ON+fDfVg9prxxK5Zn2SeoZs2FG+wJqRpGnFxdH+J7mbeAwATpfbWJM7tShPK01mRQH+TxwmIz8/iV7T3A9UfPnt2nRuUBZU1Of8Qp1OPFMhrFVR+TfxTuxgq5euHAvsbJDih1vIanqSboCCk1vvt55UNzYlHoj9ylm1zXvDz46K8UyS/MQ4nyfYMSS9RtEXw+BDc7QVUvu9tWagDHqJUu4FQUbZNCmaw+KjGZuOD5WyZfAjtUMTBs0c27osItVIpKs6tKQZCUS58RYiW117M19hKy6k/OIUqZrPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eXV0pNlTngq5NvbpluV+J0UuGpZtvCSejefgeuSl1fU=;
 b=QDRzDwQJwUU6hWV/IPJ1huq18rI8jL0zzRKVMCbZy1rvK6pw19p38FIW+Q1dqrDaQHFGe7lER3MDrboJ75lxu+fkCnMMeyzo6gsLXJM1mI3xTlwXpu5OM0CAPSJuX/9X6R7YYpzagsw8WdXMmUNJYzNxbyqGpSLV6wGZKtw5t2xaEfM+6FgqaHIig5Xs5ZcT9hB78Mk2XQqtxMPOKhmraXp95DXis60oNmpICNYgAiDpakC6kTh45zW989LU2ILEL9BRJAL4B1eGzf5e/E2OPasXxSta2ThQ8Uxcnx9wQ9P8y6oQbJBS4PEYAOduk07ZTNaCVo9op2+8UC2Wdpkf/A==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by SA1PR20MB6145.namprd20.prod.outlook.com (2603:10b6:806:33d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Mon, 25 Mar
 2024 00:58:08 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::182f:841b:6e76:b819]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::182f:841b:6e76:b819%2]) with mapi id 15.20.7409.026; Mon, 25 Mar 2024
 00:58:08 +0000
Date: Mon, 25 Mar 2024 08:58:12 +0800
From: Inochi Amaoto <inochiama@outlook.com>
To: AnnanLiu <annan.liu.xdu@outlook.com>, chao.wei@sophgo.com, 
	unicorn_wang@outlook.com, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, 
	conor+dt@kernel.org
Cc: Inochi Amaoto <inochiama@outlook.com>, paul.walmsley@sifive.com, 
	palmer@dabbelt.com, aou@eecs.berkeley.edu, devicetree@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] riscv: dts: sophgo: add watchdog dt node for CV1800
Message-ID:
 <IA1PR20MB49531613C8AA14C065D1B59EBB362@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <DM6PR20MB2316366FC9ADCBC7B6E9C289AB7A2@DM6PR20MB2316.namprd20.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR20MB2316366FC9ADCBC7B6E9C289AB7A2@DM6PR20MB2316.namprd20.prod.outlook.com>
X-TMN: [3/1V6s7gg22xZ7xD6RMsFPpA5fGOHX6mxwkw1Ck2eEw=]
X-ClientProxiedBy: SG2PR04CA0182.apcprd04.prod.outlook.com
 (2603:1096:4:14::20) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <ycht3yucpeuyobtcyhj2375kmxykjr4exx5a73o7i4e65camog@xum3ichoyl2f>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|SA1PR20MB6145:EE_
X-MS-Office365-Filtering-Correlation-Id: a57d7ef3-138e-4080-65a3-08dc4c66a2f9
X-MS-Exchange-SLBlob-MailProps:
	iS5pQZgsAQAYkKD5rY1lSepUOrCsSWvTIZhPhq8nS3hYH9I//6EoA67cu7mGt40qkHVeEKknwK03O9LPzDMkcUy6J4asXM16MOAQgV5vUzi9KwOQdCBTb/Yck3rsN1IdebhuJWq5M2jb1nXv80S0P379u0/nl1+0oq+tSFy4I3zV0yl+pPLp1cBrF/f3ulR/auY7Hasi010h3Auq1MJUe55reaqGthiFwh3clMJiTnDtnzVzym8HcA21B5NxlrUjMBeWrQNZE9Dg8/YAfPFbT8qlNq0ZdcV7K1iDqwsJMl5bRbCNAQHHwhpaDweB97Lx9LJkuVfNJ5i6MORp8i6yAxQ1tyXILHj9TqHoMrthaompvLnOGmrdLSBKilzWPtbyMIYzO7xI7knidqHEHXCTuRsOxb1HBmEXNxTC7n2Yx+cfqmp5nFeW6r+A+dh6fFOplP0oGXUOwVdLlT9v6g3SdwY17BQt0D+LdbI0k2CGhyn5dviQjHvVt6Ezwimd7Dv6age33XCdtxsZS+7sCbN1URvstG7n6zs54nGbnagPwLSz2ZMR11pldO2laDe97XmIJ5++w7bIxc7OAqxMITEICIESZJtC1KA+wSnCa5nZ/LMKF+JwoHUS7L1gazGo2L86FeVisRR63sTQ63lyC+2hN3T0m+v8L+m4mFQl8ZmZ+dZD2BI5By+THvlsAtAuThSVW7CBYjnYx2Jv9MZIq8MpsmdjOi/ZoSgjPuZySyz20vKV+yW+KI1bq5i6fugtCRUCDIAcr+ddW6KHB/KMgWS2xRH4JpuDiW5CAIIDbBKPKOBNS4Cxzc4J6BFnt+yDlWks
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	NSD06Vq/x79G0ss0ietzQIt8g6ZU3V02J6foUGW4ORSvcgu5LQb9MOvAITllLthP5dIdtEtRgkfExkKp6c836bp70mYN4iE/4M+69r6CQNzV4m9Y5ozUvvLLS8kUWVRnyGyjFeDSWZjNxsW5LpsWgqMhy8xWw6bnH5e1qKBSVvlbZYygJcxmSRMg9HS8VZj+/buw8wb1n6mjLGX1m8/UXGeVvYYuAAFFckTJ1H6i+0RSZpWD8myGb9czx6p0G6v2ETGiEmKFE76SSX835pg8XpIYdd2IYo7qBlDwW/8bjW6FVYeDMlHJA2jWL0Di7SmFOMHl4/Qjqj7Fjp9FNh+aAkqzxS2tNRQFMJPTzo+89d8Eas8R2cBxZ0Ttv0ZliQx+BgT+sxeB/jhQj3eYWh9AG8yXmnyGwLUm9Gx2l9SFFm/4b7mwlpH2S19+DDou6+EOiIMsRPED2jGjVmShC98eXdlUBRD0q7XtrccomGeVkZW2WllChbBOt4b/IsyKiQjIBTKRUli47Uu7SkTr3ikWQhM1lMLcPIhYXxXcfm5B585WSJFSw5IHidXKRVo5/MmH5tTDsol02Eu0OErjiQPdEiy7StGvjOU6UdkTrl/oIQyRw2Qkbjs1Dxw0V6wCGRBytjtHIAtTTK66hHp2Uow6puVKc6/z0x542IGxg8PWLYzHoI7oFvozq9e8DE1RYbdZYaMeqHLZmPFT8xl9Bllx2Q==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CjxR9chanpOgs3H+fwpYI2z3wYy13TCPgMJzMc3XfKCVxg1M7/nXoVzRUS6w?=
 =?us-ascii?Q?IAET+Dp9hsvktbYEllIK2yRhL63kAD+XBl6tdPuzpaJ3pRPUNZ4ePNDP27zs?=
 =?us-ascii?Q?oHjRPwCt68h9+lfRUmCfGvaSZ/0wlC56CjfFMAQI6hifZJyVS8vVigfPXSZj?=
 =?us-ascii?Q?enq4Mu9vbTU9qLan0QHjHNMHg3GE3ZrHtoCnxASz8HKLaFYojEG3KS3r5iv0?=
 =?us-ascii?Q?QL12i3yIiR2mnzXJs66ajQrD5EcbUawlUCnw3LN8BFAMw4ZUO9+oaEgLoLPu?=
 =?us-ascii?Q?sDmB4+EEwV+DfCJozOmFAWIXrf74xb6xpWYCZyD3zh1OBzsXgySV29T2GuBc?=
 =?us-ascii?Q?y5D8WfibK16uS8FxBpr+SvWFLF4x0Lg+/+0tA5LiYklxU67rBkJqq5TJ2vvs?=
 =?us-ascii?Q?uywIgMCMnQG3HgSBS8aVOsJgFnQC1o+9DZG/RpYMprGanLq5SW8WwamSoYXc?=
 =?us-ascii?Q?er5XUXZ2gBLhuiWzDc7SRCrrzysxBBur3154YH0OjctS51ZzQ4/+S84KyNTy?=
 =?us-ascii?Q?ZMkAsglFaLXA0x7+abOo68WekXQ20BYrUNUhcIZSVAJXN/1YB5iPsWPZrOQs?=
 =?us-ascii?Q?TeAz4tM0eVWnSntFGkvwLAYo+EaosOeFAUpyAE+MHopqimZ49IDAN+zZlKjb?=
 =?us-ascii?Q?/ErNpRV8BnhWv9Z66yxVCizeU/wK3obGcpOip0sN4MPemo9YbsgUsfFxBL3k?=
 =?us-ascii?Q?8v0CBN4nsO3DTVRJeSlucI8H1MHg0nxzpKnKZHhUJE1tIBzn04C9xMTbWE98?=
 =?us-ascii?Q?zAtsFiCmgDXIaHBlUDXpuXdjLY8wSlQvdhDGO/1KUG+D2xtu4DhujsQQMLjK?=
 =?us-ascii?Q?sgzXwV/H/yZaVrMERzXX7fRE9EMV+jqg8rMsemrJjTNEUjhThuZOec6Fr1nW?=
 =?us-ascii?Q?WFZMWg46G+Sy6d/sy12bKR/Vb2ppjNFgyrgmnTyKwMvVRpsphzS4DsQYPfOH?=
 =?us-ascii?Q?Qb0zLe9ExOHWs/S+8zChDGkjIhm4SLKCgTN7Y9+a82amHjbe4hZit3IF92mt?=
 =?us-ascii?Q?H4OYU6lT2FJpWhYNavoTupl5X/LePwdhxUFNQH+cTGuPO8p2doj8BAhvrD2B?=
 =?us-ascii?Q?9By5BiEI6H+HnK9OTNrManPhYR9t65HTMYdbJojqLydv/7PQaUKy612rUjIN?=
 =?us-ascii?Q?smmPwqK9w3DJv3xemf5KKY6Mjo/si+W8IgUP45lCW+zdjVoORw/5RSCEAPTw?=
 =?us-ascii?Q?PbIzsVijthCmkBOVPRCpJwAFZ9WlMh8k3b/aPjJten6tGKluD5yEVloDsWcB?=
 =?us-ascii?Q?T2LFi4SKpCcgyY4RP4wL?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a57d7ef3-138e-4080-65a3-08dc4c66a2f9
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2024 00:58:08.7479
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR20MB6145

On Thu, Jan 25, 2024 at 05:46:40PM +0800, AnnanLiu wrote:
> Add the watchdog device tree node to cv1800 SoC.
> 
> Signed-off-by: AnnanLiu <annan.liu.xdu@outlook.com>
> ---
> This patch depends on the clk driver and reset driver.
> Clk driver link:
> https://lore.kernel.org/all/IA1PR20MB49539CDAD9A268CBF6CA184BBB9FA@IA1PR20MB4953.namprd20.prod.outlook.com/
> Reset driver link:
> https://lore.kernel.org/all/20231113005503.2423-1-jszhang@kernel.org/
> 
> Changes since v1:
> - Change the name of the watchdog from watchdog0 to watchdog.
> - Change the status of watchdog.
> v1 link:
> https://lore.kernel.org/all/DM6PR20MB23160B8499CC2BFDAE6FCACDAB9EA@DM6PR20MB2316.namprd20.prod.outlook.com/
> 
> 
>  arch/riscv/boot/dts/sophgo/cv1800b-milkv-duo.dts |  4 ++++
>  arch/riscv/boot/dts/sophgo/cv1800b.dtsi          | 16 ++++++++++++++++
>  2 files changed, 20 insertions(+)
> 
> diff --git a/arch/riscv/boot/dts/sophgo/cv1800b-milkv-duo.dts b/arch/riscv/boot/dts/sophgo/cv1800b-milkv-duo.dts
> index 3af9e34b3bc7..75469161bfff 100644
> --- a/arch/riscv/boot/dts/sophgo/cv1800b-milkv-duo.dts
> +++ b/arch/riscv/boot/dts/sophgo/cv1800b-milkv-duo.dts
> @@ -36,3 +36,7 @@ &osc {
>  &uart0 {
>  	status = "okay";
>  };
> +
> +&watchdog {
> +	status = "okay";
> +};
> diff --git a/arch/riscv/boot/dts/sophgo/cv1800b.dtsi b/arch/riscv/boot/dts/sophgo/cv1800b.dtsi
> index aec6401a467b..03ca32cd37b6 100644
> --- a/arch/riscv/boot/dts/sophgo/cv1800b.dtsi
> +++ b/arch/riscv/boot/dts/sophgo/cv1800b.dtsi
> @@ -1,6 +1,7 @@
>  // SPDX-License-Identifier: (GPL-2.0 OR MIT)
>  /*
>   * Copyright (C) 2023 Jisheng Zhang <jszhang@kernel.org>
> + * Copyright (C) 2024 Annan Liu <annan.liu.xdu@outlook.com>
>   */
>  
>  #include <dt-bindings/interrupt-controller/irq.h>
> @@ -103,6 +104,21 @@ uart4: serial@41c0000 {
>  			status = "disabled";
>  		};
>  
> +		watchdog: watchdog@3010000{
> +			compatible = "snps,dw-wdt";
> +			reg = <0x3010000 0x100>;
> +			interrupts = <58 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&pclk>;
> +			resets = <&rst RST_WDT>;
> +			status = "disabled";
> +		};
> +


> +		pclk: pclk {
> +			#clock-cells = <0>;
> +			compatible = "fixed-clock";
> +			clock-frequency = <25000000>;
> +		};
> +

Remove this stub clock and use osc instead.

Also, please rebase to v6.9-rc1.

>  		plic: interrupt-controller@70000000 {
>  			compatible = "sophgo,cv1800b-plic", "thead,c900-plic";
>  			reg = <0x70000000 0x4000000>;
> -- 
> 2.34.1
> 

