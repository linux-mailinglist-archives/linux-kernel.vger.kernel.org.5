Return-Path: <linux-kernel+bounces-144480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8595A8A46D6
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 04:16:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A738E1C20CA1
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 02:16:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17E09134A5;
	Mon, 15 Apr 2024 02:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="NCxAY8NV"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11olkn2096.outbound.protection.outlook.com [40.92.20.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 830D41C02;
	Mon, 15 Apr 2024 02:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.20.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713147409; cv=fail; b=R9/4XexEiweMlvQfmgn9VX01yjh0Gjo9Kp0wS29iN3ZhftINYe+LGzuty/q2vJiNfDFaSRcKncz8g5OLYeoKeg+FxjX35LBL1j+98VmEa/u4dj80nRs97ZnAY0rDeFyw2Nzy71YVAShCDVkyftK4e5ER3nawYf4KJjh/LmjcBHo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713147409; c=relaxed/simple;
	bh=tXqo5g8/qyT9tAf/wuUJTPF1IzTPXxjNRulmJQwY38Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MS+qUEZvq6jUkdvEX7E/5YmV2/ZJix4NbCCwMGAvO5JCFwLrxkBIL193Rn9XOdD/VBdcP8eGxlSYoCVK3P7pUYgcEMNhyaPqdKOWKagWeMsWdmhvQ9UD/Juvgo1w2UeEf9OVYTQfdePGtEuJZkD7rAobVsAGa8e0cUtksRMLKyE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=NCxAY8NV; arc=fail smtp.client-ip=40.92.20.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XHH9jrfR+gweBNIHsI3M6WBQCwOsNLHRzlNlC63DH/QNepMQGawqU2XbYaStAPJP5mZYPU4IxuMNI5Zqp2dPndeBhbKQVJVynaouKIgIV41p5lZkpugTyu5ceMwWyyK7J5aEFJ3jspFHlLS51XZ0CPasWFcjR8HFLtD8bG5LOMQof6VZTxpKKhkBjiHER7I1UB/gZQWN1tK/ZQ+1ztgR72nwKhuifG2aQnfRqibbmoUVhE2cuw/hgNl8sy8dROMvR+InyMK0MzH180rC6O439H/XNH9FvDeaIlEXV7baAWLUbD4/+pjqJeKa1X6p3lCha4ORAOIp676l3tosFmPfuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d9O+4O39afhCYPJQ/Do5fQX0e4O1n1aiB+g+lH+2Ung=;
 b=PBAb/gdGl5uURgbwt3dplRAtpRuD6ebhGduCR4nVECirwepu6kfh2M6pAPQZzRvV1x5FROB6Esjw+8CT0SRyzyko0svfaPYrFrj5H0PfcAZPngyxA8WVmDtyUYEvC/pr4yhj5TsMi1QRYKZM2ihqvNP8W3H20zNOyP4OnhSie2mTEzSJA3+JEJEUKq7+49Mu8zTA3zkgn9wxPzvbMWqL14K2YLKiI29Fr7xJbyPwY1F8+L7o/sg1oiiWbCesbNh2iFMA2K/gSzBrMAX2jqqxpnyiw5rWrqEkeJDYga170gYTog69QvPo9tR5oOUKFdONAfK5nMb12tDenT5rwhEduQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d9O+4O39afhCYPJQ/Do5fQX0e4O1n1aiB+g+lH+2Ung=;
 b=NCxAY8NVHzOEvctAfFS+FjpVBiAUy+f8CXE7Z8p5VvqnP0VaGbRQ4GA2qfvSaT4b0zRZsFE/7NQ/oE17kR0aGt5YV+faHphwECW9FZv1fBhrF1DvlOnAqYJX+MTC5P05JLV+GynxZBLieRV55Pso8UTieArlP6zI1Q0UcFg4ZFdAXKS8HFN5PalFgPGwVrs7LSwwy7xNw45QLGcWZsCnSkCu73VT92UUaLedaPke0mWsH5LQ1qPGEsACEsqnGiOiSpUAZuDqnuoyK20EUeVm91jRp4uPzdsWE3ZsG33Y72T0VeeJZd5t7wBLmdHzES6Lf82+D+fC/WVQSKSuqrA7zg==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by BL1PR20MB4635.namprd20.prod.outlook.com (2603:10b6:208:392::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Mon, 15 Apr
 2024 02:16:44 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::182f:841b:6e76:b819]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::182f:841b:6e76:b819%2]) with mapi id 15.20.7452.046; Mon, 15 Apr 2024
 02:16:43 +0000
Date: Mon, 15 Apr 2024 10:17:03 +0800
From: Inochi Amaoto <inochiama@outlook.com>
To: Vinod Koul <vkoul@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Chen Wang <unicorn_wang@outlook.com>, Inochi Amaoto <inochiama@outlook.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>
Cc: Jisheng Zhang <jszhang@kernel.org>, Liu Gui <kenneth.liu@sophgo.com>, 
	Jingbao Qiu <qiujingbao.dlmu@gmail.com>, dlan@gentoo.org, linux-phy@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH 0/2] riscv: sophgo: add USB phy support for CV18XX series
Message-ID:
 <IA1PR20MB4953BBD9F2D6DF4D4AC793D7BB092@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <IA1PR20MB4953780F4617823F7173B6D6BB042@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <IA1PR20MB4953780F4617823F7173B6D6BB042@IA1PR20MB4953.namprd20.prod.outlook.com>
X-TMN: [8S8otwRQE3pEji3qN07gvBd6dptOSydpeVFZW0aPTCM=]
X-ClientProxiedBy: TYAPR01CA0158.jpnprd01.prod.outlook.com
 (2603:1096:404:7e::26) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <qchtya3hmtircseu2cwnrn6rdjlvnai63ztyqhofhvso3e4imt@mjjdfb6kiqpg>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|BL1PR20MB4635:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ec6c4b1-5b9a-4b59-63e9-08dc5cf21800
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	NWK/bFyTLmWD+YOhVoTmf8O5FHuGjRyCcBf66XP4G1foH8ZSq/RyRzGFyRVFBPxGJNpRntxNc6TN4uJjebgPvWCUrPvy3N8g0bLO7nE/S/K9+Ru35Y3Jo5bGBnzqLZU8pW+ihkbukMqvCIflFW4pwU5G4JiyvWey/jhtr7uVeeG0c2faHQJcQOf7iYQBnd4jXizzEaLlWAsKVUauO/lvHmSlP7tm4PVex4hi48VtYq36boAbpOnqp7xaH7x8PogUvV0D6m1Zm29pKw8OaBBbX46Glwu49oBsY8NCiBbWmW6Gp+Q26g5RpsFKjHAaH+3kf/UW8IC5Ikqo1wp4CWzgTZm/RbbtQFKlVA0Jwre60wskMb4PTZGzW3hOG6DEwNCLGxm4aaxye0XMf2Akny8JPENimGv8cD6/+5hXqXwAioIKExnfDDeu4tQD+tT9shhHJAWAt9XiluRvM1vW6TphZzuiMRQn/E7FN1XMH3bEG8Z4tCWeKzP2alq6FdTPx3JDCQSyYFZelEahtXv/02qh6mp2dEDqvW6TyldNGfNyoRGTk+sYbXCZMbAPR0OZ3b3xkkyht6Si4JAo5lOkK/CEckKLAZWTCQL4vMaKpvuBsH5lllz4cQjPWuZFpFK0uuDu59qiM4wj2ItaC61X4N/AHiJFzyb/MMlz0hThuF4oU14OC4kxfbtVQu+2m7vI6L79k9QN3n0Z1M9rfU5uO/wh5RV4LJW4q6iX19FXdp4UH6z0VRzrnnBEZmHFLFdx8sQ6
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?84LNmvLQPdSSo69cFj1mHfedLb88drzy7OhxV4oAwa7dE/oe2pXNRVz+hQ4b?=
 =?us-ascii?Q?+RRggVDfz5hW7b+6YLe0lUibuh4Beuj/qUYzsRQb8ILeVvVaIOieb+9ERFjs?=
 =?us-ascii?Q?vLbHf5kw/JxR7lDChLwUEA5EucBb0pPsCJMyE43py6ByJMonAMceTtMlHq1J?=
 =?us-ascii?Q?OE7htJNJyft+U1xGcpxS9ug31ZMnbDE0uhkhmWJysLflBzbvqNP22qloEzJG?=
 =?us-ascii?Q?hy7609pmppW4XWZ4m5n1j7UTqsWReHA+DVRaTEnWTABUsfn6w+G+2uEJqX6M?=
 =?us-ascii?Q?WPg8fFnPNfBu7uLSE8TjO+FGiD8Bp8Jvx2HP2oRUVznGkj1m9yRdmTwcZzdV?=
 =?us-ascii?Q?wJsZv+j0Trloqa5oe8ir7kcEJx3IOKRMoPU0b5l3491UDI7fodm8z2VvSOIS?=
 =?us-ascii?Q?q08E+JQu1grERcVy+jqF948AM1JhfIza8kaxru0j2ywNxjbPReLENwfRcvtn?=
 =?us-ascii?Q?rKVzCT4pSR/4GpBfaT0K5sPAU1Uyrq9XPOjO6+Pdm4t3sFOHEB0maZnoI+lA?=
 =?us-ascii?Q?QGoX0Z1nEvoumLbjTIkyYsHP1oBoIlkPcoZc9V1BD3nH5lLdRrBbdp56/0tT?=
 =?us-ascii?Q?9iztkuAIl1nnDsMvVfHhcfNpLfkGg7vCX1DDfCbqLAx5kKsJWTbLVzwnSNdy?=
 =?us-ascii?Q?yhJizC6clMRFNgztAtdCJRjSO/75UT9bydKOr11df+T6YhYFI4hLzQ3bOa66?=
 =?us-ascii?Q?HN366ZYdRh9a3z1UNqcYhyXP/EfvQILzGg9mdAkUHKhvarKN6+8QUxSD2rHw?=
 =?us-ascii?Q?QTwIPpMvu1Kmdve4RcyNC4TLlDYg2OXnNxOk8qCfeXqWJGFuRCJ5auLkmeYC?=
 =?us-ascii?Q?LtyGeOwuawYD5CVhqAs2AM2OaD2PR3Sj8k0XgG5q8X6oWQX402orx2QaOS5z?=
 =?us-ascii?Q?1GI7BKt+P5jd4OIOeAsiitfNf5opcRFD9Bk+4m6+cOWZHctlrDqqv83XaU/s?=
 =?us-ascii?Q?kZhRNyXZUt3SdRT4qHskXom2EQElVeMufO2tTT9YBH1xnUV2hmuu9kp5cd7+?=
 =?us-ascii?Q?sKvs4yJFSG9N4zIy7F5qh6vhEqvQ6VLymasQkBxlKgBmb8tPoUvKGAPrxPOi?=
 =?us-ascii?Q?sffwo2IzHPT0mTiSNbyl+ANJfA979DkYEuYZIdBD94rX9AEfu/RZTQdhoWEt?=
 =?us-ascii?Q?iNz5W0MS6+YebJaRjPW+tLmSLVUtHT+oGhlP6pE3QF0dKUz6FtYFATtSdVs7?=
 =?us-ascii?Q?nvICsdUj/jJW+p/Me7QPXF7Qg3ZrRq/iPSCuO35M6x9tictlTxDkAj1KSR5I?=
 =?us-ascii?Q?+x3eLjmM+E4V1v9pnnzj?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ec6c4b1-5b9a-4b59-63e9-08dc5cf21800
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2024 02:16:43.7317
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR20MB4635

On Fri, Apr 12, 2024 at 03:21:26PM +0800, Inochi Amaoto wrote:
> Add USB PHY support for CV18XX/SG200X series
> 
> Inochi Amaoto (2):
>   dt-bindings: phy: Add Sophgo CV1800 USB phy
>   phy: sophgo: Add USB 2.0 PHY driver for Sophgo CV18XX/SG200X
> 

I forgot to mention this patch 2 depends a header from
the following patch:
https://lore.kernel.org/all/IA1PR20MB4953BAA0F8E06CB202C5C2FBBB062@IA1PR20MB4953.namprd20.prod.outlook.com/

