Return-Path: <linux-kernel+bounces-75723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14ABD85EE02
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 01:28:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F8921F23376
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 00:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57D18C2E3;
	Thu, 22 Feb 2024 00:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="on+VAhT3"
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02olkn2070.outbound.protection.outlook.com [40.92.43.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C88BA935;
	Thu, 22 Feb 2024 00:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.43.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708561676; cv=fail; b=brYP5Nl/hh9RCIhC7oY9OKvKa/z3vuYsZwO7Z1ZnQqoBgum8dremFdpfZKoYih+2GsJEgJe6scyy9HaZ5NvrNaH+jTfz4HTlfiAKKl+JR2MeswufPn483RtabVWVGo6YXIZ4QidVwq5FR1FZ0fubviAVDRky++IEtkqzlGRWl58=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708561676; c=relaxed/simple;
	bh=Nv0K2dttDUnY6+PZDnF3XCwNaNRNLAceu16YoO6Wb1U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LfDiaJQJzPtGgkY738v8U5HzMpS0PNT6X3aSAYTmUFIvUtGGTf9Wr/Cp3h3njk1AwjAc31L3YYaC8exl76GFZ4vMLAoRxGDraR15PF8wKPraGsWYPHMHWW/9BDAzIa1EwQ8Oo1GN+XhCG4b1jP5waSbi0byXHHVkSWoTAFjtWh0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=on+VAhT3; arc=fail smtp.client-ip=40.92.43.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a1VfRJC9ByPMqiZYTdBYA2/KgSZLpunEal5HAsVOu1zKBGv1YWkxLi7fq++AMHgrPHEk6G5C9mUGRLieYDIKuZhi1FjEMkxeM0i18hR5mpNVBrZIw9IdSqOG7pGM924R+nvIcWBVcYfbqcs+IgwtcXxEcezsjNF93g/ZAcTn56ORT2rtP4iU8vHnOcSQWnQA8xx7lwjNY3Xxyk1K/v8Fp6trZyMecEAFeGmk2zHB/D4Q8AhDVkNEvx9u8ANR4X85Ofm4zVSYsRXdhxJSR1OTK1au48878siHAQqGVJqTZQxYrjo1DHZcPbGGCA3YHgFwXBpx/+KE34x8Xf1TXds3Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LUZNmy6/jkchcP9jkCbhH77kEkiBzT8gWXjBE9cD0fc=;
 b=Zdp3HReE9/4AKcVGrQjg7sSI79Bctd28+jCt0dTAiMrqPWu3blEwZDphOUUENaApxq8y14CAaNfMfrRF6gyeJPYzi76tl5/Ph9FuuMsidvlQh+2ox7miWqGzmR+VU1LAYhf/yvmS5u4Y8PUIoLT9VoYcU1EjgiVjI2TRKtQf3+OcEfIq+YVcZ7toJEXGqWd101T3v/vUOwBSHoHOuiMD9UJPnmlqjse+4LC7U1OdP5+N0QLXaYT7MM3GljFz1vzzfALoo8hNFnoK6dJ+j1j94ceHx/p8dwmtTJlR91sgrhWDn6uM7vZ9sOOZuVIhArvgm4zn1SL+ZohcrcHhgCWwaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LUZNmy6/jkchcP9jkCbhH77kEkiBzT8gWXjBE9cD0fc=;
 b=on+VAhT3CWUlRxdPNxakszNvNMhHU2U/CJqx1lIbRjW+4vytOf2Xh1iidLo+4Xl+705vR3+cQY8JkQbBca9A2oq/Nl+lTIVCWiNgNX1Wb7prsX/8tpnPOwDrGy+/Q5y/WlkhQ2AMIdUFE3THEgetAgov7CaRVmxsUb1yA3K7yyqHYOY2rmSLqp7UZWtwGt/byelAYu1dG7hl+oAvH+H1SMBqoTtCm/AMOKBnp9SgiMTixGT2l8nA/k1rYT3JrPZk07UCRE/Suj/Vck7TC9R3+JGgQW6xQcyXfw4hvVjYRlt3J1TfGirj6+sJ05tY+k59BtjpzbMHqBcKqhlIizdQHQ==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by CH3PR20MB5627.namprd20.prod.outlook.com (2603:10b6:610:147::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39; Thu, 22 Feb
 2024 00:27:52 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::8615:efe2:7c8e:2041]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::8615:efe2:7c8e:2041%3]) with mapi id 15.20.7316.018; Thu, 22 Feb 2024
 00:27:52 +0000
Date: Thu, 22 Feb 2024 08:28:00 +0800
From: Inochi Amaoto <inochiama@outlook.com>
To: Chen Wang <unicornxw@gmail.com>
Cc: aou@eecs.berkeley.edu, chao.wei@sophgo.com, conor@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, palmer@dabbelt.com, paul.walmsley@sifive.com, 
	p.zabel@pengutronix.de, robh+dt@kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, haijiao.liu@sophgo.com, 
	xiaoguang.xing@sophgo.com, guoren@kernel.org, jszhang@kernel.org, 
	Chen Wang <unicorn_wang@outlook.com>
Subject: Re: [PATCH v3 3/4] riscv: dts: add reset generator for Sophgo SG2042
 SoC
Message-ID:
 <IA1PR20MB4953D0DF7E89CF234A7C571DBB562@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <cover.1706577450.git.unicorn_wang@outlook.com>
 <b2f5d7cd2d3fccfc00cf4563d2dd7363b0fa2fca.1706577450.git.unicorn_wang@outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b2f5d7cd2d3fccfc00cf4563d2dd7363b0fa2fca.1706577450.git.unicorn_wang@outlook.com>
X-TMN: [aNq4GR5kWQUTjyZ1i23YcvTvy9bLzdlc3PKtEb846l0=]
X-ClientProxiedBy: TYCP286CA0341.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:38e::9) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <stp5fkkfubszqjnne7wdgzvlwvfhc3sb5ncj57r4nuansqdr6p@hvjj44tlzc3n>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|CH3PR20MB5627:EE_
X-MS-Office365-Filtering-Correlation-Id: fafe54c4-a507-4faf-365c-08dc333d1b29
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	zb01evmVclUMb9/ktBeIQT2Gn1no71zXiy/tfxxf5p2EjipctS8g4bVkGSKjuYgxd0bScJ4xuO06uYa9HcwFiTJvfAz329ahnLgimMQaZuZeH3ZPYkkW5yjApm6U79hIUdjdVkfmbO2AFyB1hASWK3Qc1w6LnQNG9mjuHKlwBy65z8jYDNXXpyYf6yRyLnHtifK6cu3Ltu5uDGU3orfiSwIKpBUSOpsqJxcMKsCvKwaA9RxKmdhr32vsLH3bKtQFbuCowysGjOASiTXABQJg74jc36wV3TJDnd9H9C955ujip4D/1ggQUlc2hKvpnRsFI7Q31zeq92PEwj44B5tN9M9e5Gyhr6uAyOVllFffv8o75mOchtJ3gyNEg/DiMRKesuoL20h8QbhtOpomPMlrQUFVqmUsFXH8CBBh26rdMFeRTkA69Sbf4bwhGKIVh1JWOtuAB8kFSWtHXOdgsZuAqxbMYfMWO3l2iW5zjNW1tmDQlTI1FN1nkeHhjEVoHnLp+87DHY71ZUnlPNosYJ6gOMTQNt5u2dPpVJ7gRC3nc6YqSG/if8LvlesJrtBHoK5R
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KR+IvEn74OIzFultDCH306vatysS6thcVowABwET1ntL1nbTStBd5C5MN3Hl?=
 =?us-ascii?Q?3c6H5QOu23M3R3RMIIePhEQ4LgH3Y+r26YlD+tNAM2mcPS7hSa0sZNEtM2ih?=
 =?us-ascii?Q?A8q1N+7EYg1BJNP08OhhyWRjfvX7sJoN0UCXIW8rH+tqdY9jMVt5PF2wHtyT?=
 =?us-ascii?Q?ZG5RtaRv9N7GfCJToRVroEvzMSOSaM2O3AOYOqKUIc8e/BbcKab1yTj/0Xh6?=
 =?us-ascii?Q?Zvcg0rH9RJkG1nQTgVSAYMRaqLa7U5xePJ1ab5w1AARYmSjBQwp3087CT5CV?=
 =?us-ascii?Q?VbZYh8sVIwjI088WIdvgY1StL/YM3mxB1i0bgT4cnE0RodZyZbXUXQgrWDdC?=
 =?us-ascii?Q?AveJEJqKnugfbtYM5QeceJeHP+FQvedMtMH+IA44sqoxMtFhNnkz5XOHWUSk?=
 =?us-ascii?Q?Bq0hIHDDmXdjq8Eu8aj4WC/KT9AEGwrgmrWVP12J52TVedTs5ULeSNIy5maR?=
 =?us-ascii?Q?+YX2HGS1Sager/cAV9Ynj/eKBrKHQPd4Xe5g/XD/xyrU+Nj3dkopG1KU8Wye?=
 =?us-ascii?Q?HzdbBzQ8zxR5T1OLVBKxPYrPGHwq4wG3Kfsfyt8sStVluoCRr9BTQH6Urvpm?=
 =?us-ascii?Q?wtXj9XL7D3rNy4t8MQMJJBOX5WIX4WQbxlBorXbAJyVCsQvVEZ6oeVKJEn4v?=
 =?us-ascii?Q?byVvEbp6S1WAafrFsrNMQ5kwOez0f3U5m9pks+KIjONEXziIOZCKEWz8LwMm?=
 =?us-ascii?Q?wsqLHIipCZ93gEgF8CnTYq1RrxrnXWNQKkZ46FM4yDvJf6AShnKdyfm8/bJH?=
 =?us-ascii?Q?rJJtV3YoyHiTQjMfCroF/If7AWNm1KFtK4Chkg7SUq35bVGqY4hqTy1SAttQ?=
 =?us-ascii?Q?916s86DLtKKJRKaWXYZ8egkg1sdjGklRsnJ89eWeFYtrBiS9X5h5SJ7r0ucK?=
 =?us-ascii?Q?RxSonYw0es7iWm4DdGR5a6qXFKNVZXhIJgkLft3fskospMtUOZiHU5KwwepX?=
 =?us-ascii?Q?1i11ZaQZBBjXKdrF0fGXS4ycJWUcKzd0kiMw393K9ZODqcq7a+LELiPbRZIh?=
 =?us-ascii?Q?3kg7Ieux5h2N3fSc3yDaQ4wXZDapR7gFjVAfGCUi0+Q1tlwcug9jgh0aiwni?=
 =?us-ascii?Q?lmOHTAVzPz/HPhR1XCfdty9a6rK8jhmgFnwIIhQocVhllPkxCGmIec57c7Vn?=
 =?us-ascii?Q?9SgkJvxWs7OUWqnR4k/D6xdww3nN7EW7ue9KLSKniTgs/wAoauHqhwob15EO?=
 =?us-ascii?Q?6sRRDVT/QVojNa2E+RqzqFsJ0kV4sZhypViEh0NnDHgpCx8SpxRmJGsFABZg?=
 =?us-ascii?Q?dA2RLd6/qxh1pF3wuOP1?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fafe54c4-a507-4faf-365c-08dc333d1b29
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2024 00:27:52.4049
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR20MB5627

LGTM

Reviewed-by: Inochi Amaoto <inochiama@outlook.com>

On Tue, Jan 30, 2024 at 09:50:32AM +0800, Chen Wang wrote:
> From: Chen Wang <unicorn_wang@outlook.com>
> 
> Add reset generator node to device tree for SG2042.
> 
> Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
> ---
>  arch/riscv/boot/dts/sophgo/sg2042.dtsi | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/riscv/boot/dts/sophgo/sg2042.dtsi b/arch/riscv/boot/dts/sophgo/sg2042.dtsi
> index ead1cc35d88b..eeb341e16bfd 100644
> --- a/arch/riscv/boot/dts/sophgo/sg2042.dtsi
> +++ b/arch/riscv/boot/dts/sophgo/sg2042.dtsi
> @@ -6,6 +6,8 @@
>  /dts-v1/;
>  #include <dt-bindings/interrupt-controller/irq.h>
>  
> +#include <dt-bindings/reset/sophgo,sg2042-reset.h>
> +
>  #include "sg2042-cpus.dtsi"
>  
>  / {
> @@ -327,6 +329,12 @@ intc: interrupt-controller@7090000000 {
>  			riscv,ndev = <224>;
>  		};
>  
> +		rstgen: reset-controller@7030013000 {
> +			compatible = "sophgo,sg2042-reset";
> +			reg = <0x00000070 0x30013000 0x00000000 0x0000000c>;
> +			#reset-cells = <1>;
> +		};
> +
>  		uart0: serial@7040000000 {
>  			compatible = "snps,dw-apb-uart";
>  			reg = <0x00000070 0x40000000 0x00000000 0x00001000>;
> -- 
> 2.25.1
> 

