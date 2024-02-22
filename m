Return-Path: <linux-kernel+bounces-75729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51B1985EE18
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 01:35:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7511F1C216AB
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 00:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED88910795;
	Thu, 22 Feb 2024 00:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="mIXfz4e/"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12olkn2075.outbound.protection.outlook.com [40.92.23.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5778613FF1;
	Thu, 22 Feb 2024 00:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.23.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708562112; cv=fail; b=uiXZklVQm9SIuomya4ShvCHvHfKuRej+KYxyxzlXzug3nACFZ6gN0dtTIGcBSgalZHGUxz62aM2bEvyFMOhYz6WizCXlT2F7nxFoHNBTHdHacBmZ1P6TZxafxrCkxesSARmoehpxJsq75vHdAFImLtQ7h2LUqmfg+lhyzjwAsN4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708562112; c=relaxed/simple;
	bh=eXXrfluxY6Q+P9CUqVDBct0MAqdp6uj6gaiwPicEgaI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=W8CFzIalK/geEK3Gw9lTnLqp8kxk2H+H9GhVrJ3HkiTpNt0sXcmT9upIH3Cm6aRuvWz3Xc7ddue2dtfhKV6Fpn01NLa097XKlSgDkUqGCdFMpUIfQYoQ7/I9X5R1mod7+uGzl5rboNesjea0AwOBsD8oi8Zb4emJBFD0xSU22tM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=mIXfz4e/; arc=fail smtp.client-ip=40.92.23.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YZhZ+YA2Vo2nWhMvuz22PFNxZ5P3ZQz11spSBvrD2dVrzunHYPvut+C7frB4OBI2Pf8yveEFbM1HBCnM0+spYaeC8FroETxq0QO0OCwStAhZy2M+Zf73G0yAERgxHoLpWa8moiy6h41ofNtlIS5WYHuG/l46VA+f2tThNvtx5yikxoqJdwO7ywnUR8CMdkiyXpvGp1j3DEuQ/ZhfdICJ+Q4z9EkYkwzdnDd7G/CvXkCqDdxKfh1LoAXtraK9DKttSQAQzR0gdmDVtacL8uohcxXwSpliGXCOGa0bD6WjQxip8rMNvCgr1iVivXgrF9Z0mMn+HX0yBhGL2JZd4F4W+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dWDDekQEJV684nc0ZTl8i8Hp2zBf39zJvPD93w9V0fo=;
 b=TEYJDU4elBzFrbbneFrkRFPzmiGvxySK/KDUlitw9zwXyc4Giwx71LpR+8AKek1FcLImtx8hJS05wZOrTZRFHo+PmRMBuVaWG3mh5mrpPW7S6vU9A1hcih29DC8ZqN+FzZ35B3UpFVjPz/dzkGU+pmJSvF8scwr6/Qg72kFVZoOm9/u4DWoUckX5J+GD26y5UQRN22H/dP5J9hKPIWapYqPmJBNBRTdcPguFZ9UymJENCQyiO0UPUFlH3YeRhJmhrXaJAb94OsfeoHwAahp5YLMTZEZ895DQ1I1Dej3vbjxPVwWn1gvnJI/SnA5INmbbkMnCXNyVHtXYZNqV2+0o7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dWDDekQEJV684nc0ZTl8i8Hp2zBf39zJvPD93w9V0fo=;
 b=mIXfz4e/zolkZsEcFV7+vYTjbTBvi2wvEbxTcxxepArCs+FEaUr8AZJfjdPACCVByk/FgefITud21rLRrRwqHrO1+gn6EPB0drMpGzaFNo+LjhTbJsqdZ8NAKn3lDy7NxawPxBM6PIWqZN2nE9Er0iE+P6YM2N2iiaNjVfNOINWHLDbFIRGhoHtLZwbB6yfJsdLxPZSiSPgz3KTnC46sBcXhZ+BfkLHgmas7hrrJv0GdNxaj/uef6BMnrZL5AXmPZaaGdZNrZ7NWCY7wqxWWF5RBil+EeYvCZB0tTOYAxur9c1gV3GYsOydLWN2uqHLiuWL7F3ybY0NX0QJMSBd7Iw==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by LV8PR20MB7362.namprd20.prod.outlook.com (2603:10b6:408:231::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.21; Thu, 22 Feb
 2024 00:35:07 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::8615:efe2:7c8e:2041]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::8615:efe2:7c8e:2041%3]) with mapi id 15.20.7316.018; Thu, 22 Feb 2024
 00:35:07 +0000
Date: Thu, 22 Feb 2024 08:35:14 +0800
From: Inochi Amaoto <inochiama@outlook.com>
To: Chen Wang <unicornxw@gmail.com>, aou@eecs.berkeley.edu, 
	chao.wei@sophgo.com, conor@kernel.org, krzysztof.kozlowski+dt@linaro.org, 
	palmer@dabbelt.com, paul.walmsley@sifive.com, p.zabel@pengutronix.de, 
	robh+dt@kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, haijiao.liu@sophgo.com, xiaoguang.xing@sophgo.com, 
	guoren@kernel.org, jszhang@kernel.org
Cc: Chen Wang <unicorn_wang@outlook.com>, 
	Inochi Amaoto <inochiama@outlook.com>
Subject: Re: [PATCH v3 4/4] riscv: dts: add resets property for uart node
Message-ID:
 <IA1PR20MB495398760802EC53FF4F7EEFBB562@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <cover.1706577450.git.unicorn_wang@outlook.com>
 <807f75e433a0f900da40ebb6a448349c98580072.1706577450.git.unicorn_wang@outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <807f75e433a0f900da40ebb6a448349c98580072.1706577450.git.unicorn_wang@outlook.com>
X-TMN: [i8JBX8/3XrzS/fEoi8mwWMx0UH3Xc4+zKeGH7RR0V40=]
X-ClientProxiedBy: PU1PR01CA0044.apcprd01.prod.exchangelabs.com
 (2603:1096:803:16::32) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <ntff3xdu2jjhxexhe5zfh6wo6sbnh6x7t75azu4z4fd3vzv3hf@p4cubsgfxx3m>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|LV8PR20MB7362:EE_
X-MS-Office365-Filtering-Correlation-Id: 170be070-ca80-4575-fbd6-08dc333e1e93
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	2lNT+mKQ23WVjD9hkBXfMQoR7jwfVpTJuW9HTZFlZWLRVkVmr2kHCqRCj7CVEmgEc+pBokSSBgNFe13HM5odR0J5cYW1jC1TkAeACS8i25Qs9JLIqSpZ6vyiTaGoKYB9A7t6cDSCuNLHSwO8BIiMs+Q95PW8ZSeXNXdALQ84s/c/bKWnJWq5voGx/MIW2NlBuC6kVwpthyCg1R0nRf1LL/tzPIdDwRI0v/23EnOrw0iHbx6JfUN/rOvpA7oz6aveU8IMZxRIp0dyr5Z3b0AdHA01Ye+iZwEUp9XiDu9ieE6QJOgKbqwxV3+Y52nuzwwyoMho9FXTgNLeC8YT2TN1+cn+DMVN785cp/oflKbzmhTJeglytgV4OQf2gCFe4YmaNbgnOAjQ5TeFj7JRBh1TIyxw0KQc3g/NpLzHFeYjNTO6J7cnJQOF27oKsCtrX/O5+mVG8o1OG5jM6Df+/EtoP5x9itYJ7EllmTzI4mGDlz0JQV560N6O3dqKGpgfEaYmU5D9NA5IRxglwD3bJX1zvtA28QiHM5wkLj0v8sK3OlqEdV4yVAwvm58WV/j79ojwsucN6GL7Iv9lqVsBTKcKGvkf/raYdDdKMPPd/zec1J4=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eUm03l1Dn/3rfalrgZ96ehWzsEJKuZpugTLiatPPBEtv7LT3m0cI6wWVa4fe?=
 =?us-ascii?Q?UKAjiDJsH8Xd4CLUWg69Q8Ylk6d5jDBi1ER8c//MfmRI5GxKMzCFWBoztjDx?=
 =?us-ascii?Q?xpW2Ssi7wQzlgz3/aAXeQRBudDIXu6cYD95rrfRRza+kDvgv8GNGbbsPTV5i?=
 =?us-ascii?Q?kkpADVS065bS38l+sWtMn7mQpP7YFk7AHwhvmDvnXNeCf6B4JiVLMWTEKd62?=
 =?us-ascii?Q?YiWYA2PASgTwoy7huElaE520+5U14ljgw3LIa8qrTeiPBFooFiBbY/Z24SNz?=
 =?us-ascii?Q?rQVGJhicxpPvFJk4Dqxoy809U/bLJg1WIrIGy7ecKHKB8t6lxQp2DIxQknyi?=
 =?us-ascii?Q?vbHqej/Z3Syo9XyiyiURStX8KHHifUFx+taztKw3yh4ebNNilcPXBjN1iPDO?=
 =?us-ascii?Q?m+WcFVPXk6NRmcDrICItSrDXhCm4hCkYZkAlJV+zrgwY/sLEuf2ekk62/pPL?=
 =?us-ascii?Q?RD8lyztotVRFpy7Es7KA6iM5SrecFeuUIL4bGjIAH7d20x40SD28PAYFYLUD?=
 =?us-ascii?Q?UvTFFVcHMH0VSks0BrDW6nOWxQIIykk3kpZlXUcNGJdJhrZbIU3FReCAUnMx?=
 =?us-ascii?Q?NrXmO2wAwxAIw6onFStibktSTXwsPNF2PnelGw5bYScyAAp17bSeE88/+n9i?=
 =?us-ascii?Q?uK8BYwVzp3wfCI+A6dFnEyUAMF+X6JypoO6V0d6r3FqgO/Ra4hN7eyy8RKzz?=
 =?us-ascii?Q?Yi8M97ta2X9v3a5gpE79DCiUtTKB9K5HlCFjNyI5nN6T/hy7yaExHTgYi9RO?=
 =?us-ascii?Q?9PpqDbLPKx/Vkt57ficTlseyVTerSCCdv0Yh59ZtbFsgpB8O9xgpntRpdJFs?=
 =?us-ascii?Q?oejCPXt92RqNLa7IYVm4i7T5Wi5ayVTlizZRETQyrfwHmlt9FioINOR2giK5?=
 =?us-ascii?Q?JdXeVzRUKPzTA/7vxMXK6UL1EZnzTScYk3xYUdk4I/M39a8ruf2PXPp3Y6QX?=
 =?us-ascii?Q?eb0FcV0bMwlZEiMs4SWhB5enxvT3v5MdX5KiS6/696s3EIDIFwYU6TGdsDJj?=
 =?us-ascii?Q?zSY0sUK4bUZ31wPw6GMxr5nlIhkLtYLqcngAPClvLxAwxe/DwXdqJlBBctIV?=
 =?us-ascii?Q?yt2IgjqpVvE7AWB+GcGe4Bo/GtwSrnTssB8bBV9Qopigp/3zxjEPrjeOosTp?=
 =?us-ascii?Q?Kg/NclX+o5K/IKBKCYCg8tZwm5JFHQBJO9SWfL/4P4Bbf1qhFM5FHorQF9Co?=
 =?us-ascii?Q?LqWafBRSfWLu2yn1o2Q0uZXpZqGmdMgzSsY0z+zdNRPaR4lfB9ExLfWqmF3M?=
 =?us-ascii?Q?pvaG0rIq0FzKQnjgEEld?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 170be070-ca80-4575-fbd6-08dc333e1e93
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2024 00:35:07.5964
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR20MB7362

LGTM

Reviewed-by: Inochi Amaoto <inochiama@outlook.com>

On Tue, Jan 30, 2024 at 09:50:51AM +0800, Chen Wang wrote:
> From: Chen Wang <unicorn_wang@outlook.com>
> 
> Add resets property for uart0 for completeness, although it is
> deasserted by default.
> 
> Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
> ---
>  arch/riscv/boot/dts/sophgo/sg2042.dtsi | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/riscv/boot/dts/sophgo/sg2042.dtsi b/arch/riscv/boot/dts/sophgo/sg2042.dtsi
> index eeb341e16bfd..81fda312f988 100644
> --- a/arch/riscv/boot/dts/sophgo/sg2042.dtsi
> +++ b/arch/riscv/boot/dts/sophgo/sg2042.dtsi
> @@ -343,6 +343,7 @@ uart0: serial@7040000000 {
>  			clock-frequency = <500000000>;
>  			reg-shift = <2>;
>  			reg-io-width = <4>;
> +			resets = <&rstgen RST_UART0>;
>  			status = "disabled";
>  		};
>  	};
> -- 
> 2.25.1
> 

