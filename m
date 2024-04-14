Return-Path: <linux-kernel+bounces-143927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 706EB8A3FBE
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 02:13:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A9962821E0
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 00:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 297BFA21;
	Sun, 14 Apr 2024 00:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="SgjVY1jm"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11olkn2042.outbound.protection.outlook.com [40.92.19.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C9236F;
	Sun, 14 Apr 2024 00:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.19.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713053614; cv=fail; b=D2MDasAeAOrBDraWVgcKDBmmH74vq5TwirEi2Xydhu1gcR3HbNCHdzYHGJY9v+0JL1LZre8Gwa1jczv9K2hByGZk/V4POxkhD3W5iP9nKEKDFwbaWhoKUiIpluN0y7HJuOSjQRPhR5NEfic9WfDHQulle3zbgMf/ugW08fygBxg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713053614; c=relaxed/simple;
	bh=tXNikiBCzCXrbfvYKxDK59aZmZUWZdOYGYOS6SwvHeg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pUO+wKFeu4WmQU5JWJvDBfFemb/K3BOUP/8/cQERcav1mtxOYQA5T2neZDJ6SkmUOtv3/I9fjqHuB6tZIVQcMBukTdQ2ahUFliYMSvzENlZr5K+1eJTG0UK4sUdWzzuuBY8IHa4spFLsqxlPo/yZHFtEIfQngN193NXzb7P7m0w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=SgjVY1jm; arc=fail smtp.client-ip=40.92.19.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J/mcogHDqvfGO7AsLVwLVZVxHH+Om6e5d+lQawRHxv2rWBOJWh720RJEM4+7dBQKfpWFjNttOC1pSKwd6TRDllORMF20nYmbsAaudbi9+DinXfvse/ibdtYN1WEE9u5LNHEGyO1k3pFW0qlv9gVuQvs0/nNm33A0jR5+fEQ4VvPJYG6hM7D/pn+2MOXlytwWknNmTI8USbCYpTF53dbABaW4krdqM3bZBfg/MkNQMr3AW73IHHaZ/N13xA0hAqhu8uMpW0RIvmApEIiB4AurunYONK7bSdWQhEFsaPCPPLMd+TeHxZMF9rbxne31bXr4IprYi3PEVjMZaOoJYNhgeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=75oIoYC8LCfKeIW9ckT1J2WQaU41fnxkqj+XZzLIog8=;
 b=gKZXTTe0l8+m9uXKBaJQft8ka5v/fAeabVLzlSrpmT53GDZHi+VNT+aMGVI7KvXXomhkgyK6YZqpvHwkluwIMjid4sOj07ZOW32RIZB+8CEsGaVvrpDvG+1ceGokaNyt7Af9UKsZJuc2dSkN8iGzJg77An8H1zyYca1xJ7RmH/kE+dUQBZ/KTNl9bqReaEauHyd2kXxRtQ8GAdVInpKzRCYIwEC8xFQx6eMEBj/jKMMIpB9MEWWXhERUa2a5k75+y+cPGRTl+H2//nVmv4u7YqaPZSRUfVNs3S5b7dzSTfqGxIQY3dGuHvskhtW+MzIAA9uo5JrRO5ryDiO8HTOiQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=75oIoYC8LCfKeIW9ckT1J2WQaU41fnxkqj+XZzLIog8=;
 b=SgjVY1jmPoxoYat38iTL1US0Kc1tvIhb8mx2p6oWmPwhlHlQOMjeb997UNewAX38yYgTApcaNt/oA4yzDtMdNSUs/3Vr+yrvBa4FoFdHM5Z36IlfUU3IHPDvuigSGDclCLcbI+xrBCnvX1GMcwPw/TORBOk2eviuTHz1+glMM97dd240HZcinn0crqYIJKziFB+X3eQ4cjBjPwDzt3M2Vf7CBoE/8LZ0ERsBLKaT3HQX0aECzgHIv2TG7IpYcMkSJFlT13uXdDOECFnlVUkZFBZZK3wvu1hDNZPKFnyF4TJ1vCoqr2fSWg5k1gbWJLkEXDt3tvttTyWmAC+nmqPbrQ==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by SA1PR20MB7355.namprd20.prod.outlook.com (2603:10b6:806:3e2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.43; Sun, 14 Apr
 2024 00:13:30 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::182f:841b:6e76:b819]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::182f:841b:6e76:b819%2]) with mapi id 15.20.7409.042; Sun, 14 Apr 2024
 00:13:30 +0000
Date: Sun, 14 Apr 2024 08:13:54 +0800
From: Inochi Amaoto <inochiama@outlook.com>
To: Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Chen Wang <unicorn_wang@outlook.com>, 
	Inochi Amaoto <inochiama@outlook.com>
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] clk: sophgo: Use div64 for fpll rate calculation
Message-ID:
 <IA1PR20MB495303CE6CE7E259382006E5BB0A2@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <IA1PR20MB4953CB4FCCDE82AB25F6880EBB0B2@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <IA1PR20MB4953CB4FCCDE82AB25F6880EBB0B2@IA1PR20MB4953.namprd20.prod.outlook.com>
X-TMN: [8jeJJxTge7gaVlPmO166Yq2K45CBiULIQifbwUsyNtQ=]
X-ClientProxiedBy: PS2PR01CA0007.apcprd01.prod.exchangelabs.com
 (2603:1096:300:2d::19) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <54lwq7heqtx7hjynxux44rs2sraueqdqqicr4pzl6bk64mpn4t@77ewgxvlk6e2>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|SA1PR20MB7355:EE_
X-MS-Office365-Filtering-Correlation-Id: 22e032c1-2fe7-4f38-bee1-08dc5c17b71b
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	iNmKdF252/3KCLbLu1DQppGcPSENh30Pvesk1pyM+LVbigaN5YAGlr2Hx6h3ig/RIMu5qLSh1asjSUP6byqkNTXusyrgRGaJtPEgCsRDB54sny4a5k6IHk9n9cG/6sqCqZeF+YDy1WE3QHozkChkMu6Nk1DRkvzxT9/k3/Lv6m3qnXtjnK+m0A6j0khbbvyJSOKFGl8t+AEftrIHHSJDK7Nbu4IwHsVBrix9Ddnc8Mm3ch54pQbBh4w81RGW6rOHiDvdasXzkyXVEFjblxnQyhbb4WazWNLbY2YKMwgqTZxvamrTpqD2+cpotOVwK1t1j26Gpd0d85IQK8Si5dqll5l8tfS85Hs7EZOxIdZYbuuYf2ZHDYsyrEZRaMqe0XFlsvHwI4VTwCHFqavpVjPrCJZ2yzdD8a6Kz2LXCJhQw0I2o2qoRhpvW7G0LJClXk7JqT3ig0IkkBc59WVVwn6YP6pilayEPeJLwcbs9HZXP7/pzMKpXZ0YWY6ptMJe8d32SaNtdE7Z30UM1p8lBm3YtDkcxQpuUWkqDM/igU0wLvlJaxLBEUVQlq0QjouavlNwI+HVy2UpAJqSdKgUFpi9FjRfNBq+IGsrXoXIuUXeRX1O8wjXWggWL7ie7ed4oFWwwp56QNSDOsarv6pDuoP2apS9VXE3uSGzAlNQSKJpzFwx2dkIuW/1qy27llroIwc2MTTuLx73J9Y0Nunj+KFQFJEBu3DWc1CeIE8S2GckZ/aVuW8ekiGEU9KbNCQk3UxE
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Tbjsg/aFIlPi59u3EYEms2K4bshdbWLe7YR81UtkYIaBDj8lMJNcMy0I0f3C?=
 =?us-ascii?Q?1km7xPfbV3MPT3SuihMH3z9HBD8M9Z6C+64D3AmZx5cBjaZvFftuOPnLQBeo?=
 =?us-ascii?Q?jDeTQpnTWBcpmtK7VAl+7Y26lE0j5yAr0rzhro56A98RqGbqCbRCqcLxvCVZ?=
 =?us-ascii?Q?baJaEP2suhvu1oJIDAZAs6Q8UBNUpIQ7iqnrc6Z2OIldoDS8R8QGxcgwul2z?=
 =?us-ascii?Q?0k+d1Lfh/SQKXoqzgXMuo1kAMqG8NVRqR1Vb7WZBnbl8LvfbSm/vDFWJD7yR?=
 =?us-ascii?Q?y1jszWPvN6n+MUmIW4hlyfN+wwMAEoDMSoHD4WKqC/WpkfCvAvKy57cdx0O/?=
 =?us-ascii?Q?opint6nfkR2BwuS2mB9FP8KwT+brYoSZNSu9UM2//JcMlT9e+tDmOsYEbwiA?=
 =?us-ascii?Q?m66QFDc2qowDpfoiKHKzIeIJ+Dc4Wmzgr3ej3wPO/880VmlH5r3+XwC+Ejms?=
 =?us-ascii?Q?7pmqqtM2y0o81SADXkbSvbKulIGaNauzUSodxpq7NTzjRz7wOVCZCzJIpoj3?=
 =?us-ascii?Q?6FeMGqFHWDAmw1ER80LkxFEYxg1x/lb1d+7DbzYEy9398czV7q8e0h0guThc?=
 =?us-ascii?Q?tQFgWYOzC2aIb+OZBsOFwQxwtMmerHQ/E/asvY3BdZEuG1TgFDNHBg77g665?=
 =?us-ascii?Q?y4LQvN62WDN+R8tJMIqOMrVMVRWV9cLANGb2f+F7Ac9bhxxRBLAKDdHAtlb6?=
 =?us-ascii?Q?59pmxJGkDnBOtI9/7hemzXxEKfa1wdN+Y2tze7V3+4WRz2Xdo75/src66Sq8?=
 =?us-ascii?Q?+cOGtpLjLQrQfhujjZTA/xvHXQdkAn/eep7gd2HCGFYp9l4Q/dT82lQPGO4c?=
 =?us-ascii?Q?O2OpFLqW59cgngSJTiy2SJuKDlSwRiKpP6/HB4JrYhw2nvXhtkh6CwS8Kb0K?=
 =?us-ascii?Q?espM4AQVE4pqMDMf9miViHzkqKynwyOHV37SLQKzmfV91imGTURK1zykYmoY?=
 =?us-ascii?Q?+oGo6pL+EHTYP3ZpS2a3f++97T+KQVvFRSNxFja1z/NubtqZvLpxTILVoS5r?=
 =?us-ascii?Q?1hJ1ljq231i8Dnh1cpK5dmZjdVDAqO0ZCZDKl9hR3swa7e2M9lAiyw+ydSQS?=
 =?us-ascii?Q?AdiYd8iMM22y8ujekkyppiHGtZYxWRXoOTrEDlFHRzMwt0krP6ggSALi2V5x?=
 =?us-ascii?Q?S2PTeAPsKRhfgyiNi5Dl1Kjj5bzH0fJW3OihIfdtGYsRFcahV3o6oIO3f+AQ?=
 =?us-ascii?Q?9NQYcnYh5xNqXCEieF9YuQMEIir9j0lj9mb7LBdHyLcE7F0s1CM7rMCxH6Ke?=
 =?us-ascii?Q?DExSeoz+yBrordWMF5y0?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22e032c1-2fe7-4f38-bee1-08dc5c17b71b
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2024 00:13:30.8190
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR20MB7355

On Sat, Apr 13, 2024 at 08:53:33AM +0800, Inochi Amaoto wrote:
> The CV1800 SoC needs to use 64-bit division for fpll rate
> calculation, which will cause problem on 32-bit system.
> Use div64 series function to avoid this problem.
> 
> Fixes: 80fd61ec4612 ("clk: sophgo: Add clock support for CV1800 SoC")
> Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202404122344.d5pb2N1I-lkp@intel.com/

This patch can also close another report.

Closes: https://lore.kernel.org/oe-kbuild-all/202404140310.QEjZKtTN-lkp@intel.com/

