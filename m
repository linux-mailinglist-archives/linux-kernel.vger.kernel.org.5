Return-Path: <linux-kernel+bounces-148375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C146B8A81AF
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 13:08:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 795702852EA
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 11:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02D7D13C825;
	Wed, 17 Apr 2024 11:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="d9C245uu"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12olkn2047.outbound.protection.outlook.com [40.92.22.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA82136674;
	Wed, 17 Apr 2024 11:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.22.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713352117; cv=fail; b=nKHYKfNVBu6vNXf0Aory6jBO6HqlTCCPjstSDjRK3BGxUJMsBNyu+DBRI4SVvGyhW578r2VrELHuz5VSKvppIyf6Mpw0qoVX5rLqZX+JHd84ocomvgPBCuuelxnAt+GkhwRhTvGPwPVNewaGMztCWs4wkFdP6q3/w0TBPuwEl44=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713352117; c=relaxed/simple;
	bh=YEUWibLhDbGGPkLk3Z/YxGeHz3iBwlaMSS7wWJQzDZ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GqbBNYkrxOIUrcdwvVqDVEI5YCPKCE6CAe3TOrPnOCY1oWuEBCG48F/6oFxQcqvfHyEhjFTXw1C8WXHWWyG5sKdXhH5sm6dx4a7BPmUh8KzI9dt5Txb6Bl3nWjHZcnXNbxIMjvQdofuxFodwrEOG+wo4kpnWlFrssJhEbyrmr34=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=d9C245uu; arc=fail smtp.client-ip=40.92.22.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZSz7/x+ku8bBKuWlyQCfBwZergmWabZc+hQWIl2NixtB1/7Lr580nAQgeaBlPToiPs+5NVfS8eDgZTP4LIkkJL9Def1wlwmgLVlPNQet7+b94jtKnh69/KEdeWLEQLa6XV1PxpaCrOPt0sOG/ajisXUqpXcJbgWa4heQIcu0WxSRm3SH719ELeNRE/sFcSOizmfheQsnKHFn8aKnwWiqihVoIrN7O6UvuTRoAZ9+6dUOc6jgAuD9I8Co9kk3ehP2nAKmvCq8BpVfmGDPLwxyPwrNzCJNl1fHs7tzC3adcJLi4xqpOXtHIfqs0LGvK2PCCRnlk4pT1WFRVAI7Ftdgog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d5FU2Qia2+5UmOKZzKKmJmNRk+Yy/B8tP2pCjEfZaK4=;
 b=B4ts8EoRCIHR8IQeM++Q7a7mDveGBImZwKcvc/pAwuXAjwrdl48IH/vKKvvGsoLNKqNDFldJavmCi8VO0565IloPIEO/fS8GKL2Mw2wNNamaZUI/5BgypFa10Tq8Wpg6jAox9pRxUqVbaWUXS3DS3QIOdl6kiRzgi2C4xE5dG5o9CBv1qcp1+JHsB2z9aF8/nRuiXUlbWUtXYqypqc/1A5QBjULECzrvMdBwVYfTPzrIpLF5E1ydMiEymq6qkKXAL8YNLewn86KmCR35URH5RRQqP+MF3WkydNfPWEVVJdqetzYHg9VJHQA+90ihBC5SrbLWAHd4vWVA1l8/Bns15g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d5FU2Qia2+5UmOKZzKKmJmNRk+Yy/B8tP2pCjEfZaK4=;
 b=d9C245uuniGzzidfnDgeXxSkI5ez9a1wV3LvS41g7qjFSYtRi5ymMlGLJK4zA1MrLzXWeTbjTea5ktaxOKnTKrc7+AhKYFV6obWecG0dzHgipgzkc8ZvBAyZoxfErQDxHSfztMo4dmXm0etEzX5S90aLR1tDgwEVTl/XdHPsgjMLI0z6Xrt6Fvs6OoeFKFhAWXD+AGZ/EA7lNjADWlSC2ZpQCfV/SOmw4N2q83KwEeE8oMP+zal1SHm1Ixt0ssCYQBNzvY6Jv2c/rumDGPa5PAWuKFVwr6pFW9kDDeNt0dKDN/02xZKOxcgHqp+W7Ds6xK8UT/+R8fDdPUP1wFAU5A==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by PH8PR20MB5266.namprd20.prod.outlook.com (2603:10b6:510:1c9::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.43; Wed, 17 Apr
 2024 11:08:32 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::182f:841b:6e76:b819]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::182f:841b:6e76:b819%2]) with mapi id 15.20.7452.049; Wed, 17 Apr 2024
 11:08:32 +0000
Date: Wed, 17 Apr 2024 19:08:56 +0800
From: Inochi Amaoto <inochiama@outlook.com>
To: Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Chen Wang <unicorn_wang@outlook.com>, 
	Inochi Amaoto <inochiama@outlook.com>, Arnd Bergmann <arnd@kernel.org>
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] clk: sophgo: Use div64 for fpll rate calculation
Message-ID:
 <IA1PR20MB4953B3CD2B78DFC0A23F79B3BB0F2@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <IA1PR20MB4953CB4FCCDE82AB25F6880EBB0B2@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <IA1PR20MB4953CB4FCCDE82AB25F6880EBB0B2@IA1PR20MB4953.namprd20.prod.outlook.com>
X-TMN: [v021Wlj8v8PVn3hDQVr2AQ5S71U17y4Oz+pR1jwM27A=]
X-ClientProxiedBy: TY2PR02CA0002.apcprd02.prod.outlook.com
 (2603:1096:404:56::14) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <knjxnyffbrcx3jskersxjlm75mmrwcfth2ydgivxtda2b6tjpy@jescr35qmkjt>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|PH8PR20MB5266:EE_
X-MS-Office365-Filtering-Correlation-Id: 640e1c20-0575-4a67-f0a0-08dc5eceb825
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	TCiou9I79nEsCVM9nEbqupYW/liNdRLODapRX6PD55TINWtZLNGBthGUZW6gTqH8sHt1NXLgFn6OHFVXEo3uSW8SUP7KE8LVBKfL2BG5siImADA2rIkR63BZyjitIAKA6JvvbMY3pbuZ8EWnD/x2HW4sbvNemMcMqUieWXu+QXQsbX7dalhsmjpVnDaKu93tjJbqbIp/40VJUqQ9lxF+yAwWZ6oGA9mntnIkka5P5Npx9CFxNnl/D8TRDCqMIa4hvwR+1AhPiyHj6c/aK5FOllTa4d+GMfdbiYXSLIM63bg+/yp9W07ip+6/EqxWSzpoRqRnhdiyl33gMaRwlVEupObxBsek8b1l/pgVSduWH/+vWdqsIhbqui6/gfrt1T1lp7ZB+ZHQ02lfhHUlr9CNN1Wwpa1bP0rVYftOITaQu+9EHL0UIZ2KaX/FZlcYz0KpPZaeln8T/EGx5JYj1Zv4c0ZP2kzQcupBLwDkgxOc9J3UjU7RuZxAdi2NBw7FHNOogYLtEcinzWiMv+lIKyFZOd5lPe6n6YiJuypjzOxJryqOH48ryxfBT39cw2tPSmaIaT6bVmFzuSQccbchGZBi9zBRB24SdqBFZY7hFJQsWPorwkeodgwSZV3WWXmfFFhbY55/vSIjV4TNZcG7zs1r0hQnq9hr+FHKadChVTyVIbumWyOV+Kf9j4X+eIHENB5Gaq6WBVBy+IlUcL8LIDXmxQzBoIG6fq0jTDgN3LJtu10Oj8MknoiB+JmJ0p1LtEYV
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CqnHoDRwM0SdtfY8JYNv1cH6+Pz1PyRBRXKBkA0dvSuUH0to0WkUOQaDyZNT?=
 =?us-ascii?Q?GXeyjuEzYYB8A9X+ksjEIUGz/XffBGs3j+/J2rrBeUzOHyuNXY8BO654QJ2J?=
 =?us-ascii?Q?YO2U/lYKsr++b4nw0B39UqToCDw3jRXevWk/NGK2Eu3tpezycf2YbLEqqaqz?=
 =?us-ascii?Q?B5feN+iHALXw2VEwNTVrBdEJRquUCOPHW/ECZ9uhaoPgnji+KpeyaZXi7Dgb?=
 =?us-ascii?Q?G6lIHsnCEuWJ1LxvvdhPOTUGgpFsUQDykhwa6pUeFP7ED5YIIJ5QpkkGDFbx?=
 =?us-ascii?Q?P/a5jVBZiZRA6ZcqxQu+YV+v3pjfmxy5ul6mynbwjhP60EG1I89H8EoVH5EM?=
 =?us-ascii?Q?e9ZJr+kO8x4WAxHFt/VsLo0CQELxl6rZdwDrfVDUo0xXnXJ413hi1EIy3k70?=
 =?us-ascii?Q?MHk/Dq3Ah8jU2LKznQaYF+221GWpnPI0r+PZykM+xCYNJ+yTPebKzWp7+RYT?=
 =?us-ascii?Q?IaWSbMX+t8qlztzBstrhcUFKEbpmssPIuC7yndN2BthXeZCUYSZGfBN6P1UM?=
 =?us-ascii?Q?Z34h53+cTEqycHhDCVx8UfxqOM9Nc3vie6wrLyN2avrDKjbnCAgRuPxmnrb3?=
 =?us-ascii?Q?JIBQbLJCYNECsGouWIucQFl1zeS+hoih7dkcAHyZf0A7r/04goYB8lbuBpg8?=
 =?us-ascii?Q?KNw4Agicq0VzXgyozU3Fg87S9qGVXQKROICcc5crURPzAG68OdBr6t1AKi/z?=
 =?us-ascii?Q?E2zfeAq4wlFYIeB+7LGq7LwdwwiFi9SW2F6fgaLBQiC/EWb+YM3FKA5XSbsL?=
 =?us-ascii?Q?LFTJlAVZigB71FE4WuZjw5MMzfmm4gYCsWixWR4S03cxv2TifCwJotFTKV6G?=
 =?us-ascii?Q?INiBWwvgMmyDt4wpM4cmR+Z3QQzXXC1R7ogVPi9CvI5zQ7livRdTE3QgmU/K?=
 =?us-ascii?Q?H4DaK73UkXfePa6aKiQjRv0jDGjT2VetSvQ9Oy2QzFCbPcbhLJeS3AZLUULX?=
 =?us-ascii?Q?tA5NlrJ3j78cYP30jzA7laNKdWLmyt58W0oWInBU0LLiQrcHZtHA8ZtG3gRI?=
 =?us-ascii?Q?+ymfKvQDw/XcaExd8k0S7+m9Hbwa3l8uo1BbRG/Nooo/gVT1WRmNM+lN64dE?=
 =?us-ascii?Q?WAzI1tS1HkZ+1FLOFPcy9AbF2+gd06h5q8HSWVfRjmooMJltPkl/DfZ+QTTX?=
 =?us-ascii?Q?ncakmSibRH+rpvKZDRfX+xfZz6B6+Aip7ZH+TMFwciEyKP1JcgDHR+q3b1UW?=
 =?us-ascii?Q?U+B6h2L9vCUbGxEZmrPnviNbLWuoIyL2pmXsI5dmT7hHkiR/Ja009ylSfNMO?=
 =?us-ascii?Q?FtTSaeHkBS+bpZdCPCK0?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 640e1c20-0575-4a67-f0a0-08dc5eceb825
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2024 11:08:32.7512
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR20MB5266

On Sat, Apr 13, 2024 at 08:53:33AM GMT, Inochi Amaoto wrote:
> The CV1800 SoC needs to use 64-bit division for fpll rate
> calculation, which will cause problem on 32-bit system.
> Use div64 series function to avoid this problem.
> 
> Fixes: 80fd61ec4612 ("clk: sophgo: Add clock support for CV1800 SoC")
> Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202404122344.d5pb2N1I-lkp@intel.com/

Close this patch as favor the patch from Arnd, which is simpler.
https://lore.kernel.org/all/20240415134532.3467817-1-arnd@kernel.org/

