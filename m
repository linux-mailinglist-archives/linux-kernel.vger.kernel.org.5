Return-Path: <linux-kernel+bounces-93981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B63C38737C3
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 14:33:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40F031F24983
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 13:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B09EF130E5A;
	Wed,  6 Mar 2024 13:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n7Z6dnmM"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14BAC7E776;
	Wed,  6 Mar 2024 13:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709732016; cv=fail; b=IQQkLx0/T89SJ7g9VTr2nFgz5hqqPqPqGuVsDnVezLUm67AG6kuRze5+G2MFr/3vCsTl/tps0zOXZfn57o+x2juob0/33q3kapEO4x7aGQbyo1mNuaBOO8YcgYzBheo7/DpiZWDr7P5UM+Ligm64ni8swt3w9NkApEuL+ZQ+Bs0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709732016; c=relaxed/simple;
	bh=w8A1D26Dxo5GPuYuUA0PuqI/z2d5qnwjkY/MDqVGS9I=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=q2g/odh+Mo0iWCqedEF3CKhMQq4GaDx8KptBP6pDuOn+Y6IdNm2rzEduGqo5WkjAJAIc6ZiCtEMgQpzdy4fFKEAb/7wCajJtCOeuhW8woXdbsNTLcDy+ab++0tNNw0vOpVLmO+93m1kvheUMhtgwiF7Xk1onqxcXLjFDRfxAKB0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n7Z6dnmM; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709732013; x=1741268013;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=w8A1D26Dxo5GPuYuUA0PuqI/z2d5qnwjkY/MDqVGS9I=;
  b=n7Z6dnmM14g6SpCV4mu/Fra5HdwxEyQSVO03YxCucvc5PeikU5TSi/Do
   VKwHc+w7uEVXu5/zwFe4dJiPYVBxtE1I256u3ZiVljoGqM3PbyHBnXqS3
   2s+q+WJdiCl9b0ABR7sEqH3o75yviX61eWotbgKeGBqHqJKGaxxIWlBik
   PwbiupRUEQlW+eM1XnSh/BTEGf5wfFuF8ajxMinfWGsgJgvnN6KjVqfk8
   LDSSQ5EW4ptoWyiQn7hAZxrhvbuMen4MYcTfGagWYxBglMBBP9gCZfYMt
   5ARVWHmFHjn8aj9wkb61BZDgAIpeqLpOvFMY8pNXPP1q8f2pM1WnHCNSu
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11004"; a="26811814"
X-IronPort-AV: E=Sophos;i="6.06,208,1705392000"; 
   d="scan'208";a="26811814"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2024 05:33:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,208,1705392000"; 
   d="scan'208";a="9725859"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Mar 2024 05:33:32 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 6 Mar 2024 05:33:31 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 6 Mar 2024 05:33:31 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 6 Mar 2024 05:33:31 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 6 Mar 2024 05:33:30 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sqt3WOjN1pT6mpFH7ldIamVeLRt9Jql4QOp8Q0QzFsNYNsNuRX68jgbDco8659PCVidq7DnPjc/ncBFdvutn45dwxJbNRB2Ir5Oi5FME5SVEweJlDKCM5U1Me+3iVJHUnO7ATXuxwGqtKBWC/aJgh0g1nL8sRx1+Z92rLxp+1lDT22eKpRo/PslrCfJI3bZXAvGFg9PbAHG1W28ulDsiiRI7X2umEjxYgiu2UmFsxDMcQIlSQCZWzxGitxzYerghMmghAFJ3LHC+IcrBkmii6nquDqUTQHRGXgov95vm7ltCfHeIaUNRoeN1kPJe9rBhsRJRbrLTr++PS9Keu6OzIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S4SU8gSwdOumCLHCXrknZFP0iJYok4ue732xawVwqBo=;
 b=A7csnW4/uheXFcSvAWNyt+ghWvQxQVRe4ZxgnPSm6LLajN2NHp029EviO1mxudsjEPvvyv3uhXp2E2HnqPFEDMOdAaP1gK+d0oDEfQzFTNrz/5si+fNZ97laAzHtZC3PT77Rvw59nhcRoq2nljzvUXnnfdrhVILkuYV3lhOFWmAp5zBTn+eP/UwBRjrGpPYMo3AP3g3u4+RgPjoo59mfFxy4JqfvYtFQymdPJXY/OIPCE9ThCgq47xXMaB0O3V+WAbPqfKQ3QblxTwYnGtx/sN/eO/dJnX/W/gzXw4mXgEWehzYHfZcFieLN9Z7rK9bZR2ESnV3gW9Al788hwjE0oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB5776.namprd11.prod.outlook.com (2603:10b6:303:183::9)
 by CH0PR11MB8168.namprd11.prod.outlook.com (2603:10b6:610:186::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.6; Wed, 6 Mar
 2024 13:33:27 +0000
Received: from MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::8079:6172:11ca:5fe9]) by MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::8079:6172:11ca:5fe9%3]) with mapi id 15.20.7362.019; Wed, 6 Mar 2024
 13:33:27 +0000
Message-ID: <35e76d1c-aa03-4527-9071-5ecb6604b1bd@intel.com>
Date: Wed, 6 Mar 2024 14:33:19 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: hsr: Provide RedBox support
Content-Language: en-US
To: Lukasz Majewski <lukma@denx.de>, <netdev@vger.kernel.org>
CC: Andrew Lunn <andrew@lunn.ch>, Eric Dumazet <edumazet@google.com>, "Florian
 Fainelli" <f.fainelli@gmail.com>, Vladimir Oltean <olteanv@gmail.com>, "David
 S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, "Oleksij
 Rempel" <o.rempel@pengutronix.de>, <Tristram.Ha@microchip.com>, "Sebastian
 Andrzej Siewior" <bigeasy@linutronix.de>, Paolo Abeni <pabeni@redhat.com>,
	Ravi Gunasekaran <r-gunasekaran@ti.com>, Simon Horman <horms@kernel.org>,
	Nikita Zhandarovich <n.zhandarovich@fintech.ru>, Murali Karicheri
	<m-karicheri2@ti.com>, Dan Carpenter <dan.carpenter@linaro.org>, Ziyang Xuan
	<william.xuanziyang@huawei.com>, Kristian Overskeid <koverskeid@gmail.com>,
	Matthieu Baerts <matttbe@kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240306123826.235109-1-lukma@denx.de>
From: Wojciech Drewek <wojciech.drewek@intel.com>
In-Reply-To: <20240306123826.235109-1-lukma@denx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0022.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1e::24) To MW4PR11MB5776.namprd11.prod.outlook.com
 (2603:10b6:303:183::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5776:EE_|CH0PR11MB8168:EE_
X-MS-Office365-Filtering-Correlation-Id: f80d63d2-efbd-437a-287b-08dc3de20137
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1+0P/kyJgZPpiPuXGqZYOF8Y6XktDlosBWQ3S/uev1bgAFZLKXhJeDlbUUTUoiUmQpkKYoz4dZVcGyYrDUEoa7SOXJfp3F/s55GM/2Awh7vmEipJJcYDKH1RI8l+7FYR0WJDTdkfvN8wMwZmq5xItGeIc/EIq0aJVWjGPSYIrSMzg6d/xw76yo01brPKplCl+FcL/RNXjAZh097/WPjj/Cz2pW0VTT+H2tCn4zECDKzikxpAqFqTO9XXWLJbzXt15YB2n2Kktzb1uEsQE7yyklKonvqwjykz3J6maLTVpkTd0U3wlSVLNMUp3AsjTBhXfNn7X6yt2IqfGMsyngn2Xdun0zHH16m8rwoh7ZlLz/rySLtJCD1nZqNluqciYKbCYAWAAC1KHyjxPJ8VfiwfpYS6V3jTXXrWEAHCSFt+gODzU6HjrvjcEE6x2uZuKtYkenfX9WP49ZmnXal8n9RJ+af2jnJ99gbXuUveuuHsoMDjkk6XeNyOfu9WIHwFYLSNmShuaBLeoXYsbqbfdiFg5dPACJgH20kBBLaodfkUbr1Gtt6cN9yL5ea/r8wqdV0CN7ACDHULssyLkjFgH122db5AcNv9wnFj7tXtjyc9TOE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5776.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SXR5aG1tRzN5R0dGVk8zdU10YXMwUnZPb0NFYTBQRVpyODJVbFVHTHpCeEJZ?=
 =?utf-8?B?SVM0M1JuVzdrbmNpbWNxYit3N0xGQjhabGhLaGNUMGJDS3phN3hhMHhCR3lE?=
 =?utf-8?B?Y1loVStpNXNVdXR5QUh6cEl1N0tjNG9Edk9uMkI3RDc1NVl4Sjd2dUx2TmZO?=
 =?utf-8?B?NGZ3ellMeUpkazlOalFOOFp2Skp5VFphTGhudXY0SXpoMnlWWTM1MHpPWHdC?=
 =?utf-8?B?dWVyTlpscXk5d1R3bWpIR0hEVEZRZFc4WWxWQklUTVBjNmJkZnNBNThnSkoy?=
 =?utf-8?B?aTVRTXlOMTFvc1hqRG9kNWxma1FlcXFaY1BpcTBIT3ZCVHFDbG54OU9YU3hz?=
 =?utf-8?B?ajdmTmJGYmV4SXIrQzFNT1h0K1ZUdStQNVNnekhVcTJETmZmR3NVVlI5TitE?=
 =?utf-8?B?aHVOWUpTTXhTRXpIQThrQ08wZXdwWHBINTFLTXZzNkExaTROMmcwdzgyS0tJ?=
 =?utf-8?B?YW9MdHlNUjY0cnpFN1VlRHVLd09Yb1JYM2xJc283L1M1eVd2eU4vcm5pU3F1?=
 =?utf-8?B?SUh4TEUyRi9WVHNKY2cyVXo3SVpmYlBVQW9XZWo5RzMydzNTdTNBQWZmUjlG?=
 =?utf-8?B?b2pyd0RmZHNzVmhxdUJ6Rk1UeW1LalEvOE9wS1NMY3hwanNSQ281Y09aVnBq?=
 =?utf-8?B?Z25OV080RC9VZXRpS056VWJKMWFKYWxCMW5jZnJGSDluRVhDcDc3UzZXVFk0?=
 =?utf-8?B?L3Q0OGVpaG5LTEQ0VVZaOGdzSWt1Q1A3UGhsbmpTMG5KQkFHMjk2ZjFiTnJ1?=
 =?utf-8?B?TXdEREI3QTZWeDI1Q1RTakNscUZVVWJtbndKRUpING9wOGs4RWZXT2hmbXlT?=
 =?utf-8?B?L1RrdTRZd1l6S3B5L2RjVHJOTnVlZFFhUUNsRHhLTjJDU1NiYkI2NkpiMVFP?=
 =?utf-8?B?Q3NEYzFmbEthVXN0RFJFTVVVWFgvdC9JQXh3RXRjL2ExVERIQVFaQVRJQkxC?=
 =?utf-8?B?a1BkTTJqajNCWDJGMUZ3NGt1VWFxZW5GaWJjL3JRKzBudzJTUjRJdmcrWkE4?=
 =?utf-8?B?QTd4UEVTa1BkSDlTUElJeEdiR2lWQUxhYmhYT2lodGhkQ2NISjVURnk2Ympt?=
 =?utf-8?B?czFIMEdCSTJGWFVVL1pkUHhpd1JVdDdYSEhDKy81UEZHUUlCeGJJVXc4SjZy?=
 =?utf-8?B?S25ERGdzbWNnajYrbWhnNVdPNE1ES1JHSXk1UC9PbkQ4YzJ3YklxcmQrcUdl?=
 =?utf-8?B?N3FTb1RDYTJzeDdxbGhPcEwyZlZ5aDJ2b0JENS9jdUFiMVBhRVNiNG5UYUQz?=
 =?utf-8?B?ekVlMzc5YW42VnFvMUlNZGVnZHZONDVoOFpPQlVwZ3RJZHlOK1Qza3pwK2lT?=
 =?utf-8?B?M0pydlYxTWdWYzhXWkQ2L1IxUXpwV1NRN3Znanl4QnViYTU3anZMNGYvdmdO?=
 =?utf-8?B?NFF3cDJ4RVVzelI2c0UySE5VWENBS0podk05SGlaWmk2RVk1cnJsVmhjNW9p?=
 =?utf-8?B?MnhsRVoycFpvZ2NuelBORWJMRkRuQWk0dXdjSm9VbU54MkJ5Y215eEpHWUxk?=
 =?utf-8?B?cXE5SEJGV29nSUMrbk1RcUtSci9rQ0U0K3hIRjZmdHp3eVNJTFdQbStwTDNW?=
 =?utf-8?B?Wnp3V0daUlhnak1aV1hkdTZMZm1DS3FpSHE4ZVZrZHpmWlpCM1ByMTV4QkhT?=
 =?utf-8?B?dDBlQ1h1aG44QU1IZEM4UnFsenlERERRdnNwc3lQMXFzOUJxMHYwM2p4dmNq?=
 =?utf-8?B?ekc5K3dsL0FxcnZ6d3lVSXFqTXpnaTdoRjJ0eTZCejVIaTJRQlpEZkhTaDM4?=
 =?utf-8?B?LzRRS3FzTEVPTFJOVllzRWJkbHZ0TS9JanNwL2JmV2pDRnR1NWNDS3JwcnhI?=
 =?utf-8?B?Vlh2NjFMZWdpcXBDY2tKMHlKSENnK0FWTlhvWXJGR0NVc2k0Wmh0Rzl6RDBV?=
 =?utf-8?B?a0IvS1hCUGdUY1p2MjlZYiszdldIOVo2UmpLUUI2dVpNbWhYZmZhL2paSG4y?=
 =?utf-8?B?MUtvTmVuVDYxdW1mcDVHY2REdHFVNHEzdEVtWnRId0FmeUhvellTWlJkdFpa?=
 =?utf-8?B?a0hYODhrZWU5b2NjU29adm5aa2xsNTVJTi95ZC96V2JRMU9UVFNxUDdSOW9G?=
 =?utf-8?B?bWZ2c2FoRllrdE9hTVMvNDIvSUFpaEcrMkRGT1Zkcld5KzdJNUtmUFF6UEtR?=
 =?utf-8?B?Q2UzekdXbHBFak00ZjFTZ3hRTGxpMEMrOGxwZ1FqbC9zYjgrL042V0UyRXp0?=
 =?utf-8?B?bVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f80d63d2-efbd-437a-287b-08dc3de20137
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5776.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2024 13:33:27.3275
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6deBH0SvfOmLn2M49pmZmSSMeJx74qMcZyKh2gJZt9mnjp6y2/vLbMa9p1VE1+376xVRtGhZRMLkuC2TCK8EmdpASvipBXwExkt6TiOw2fg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB8168
X-OriginatorOrg: intel.com



On 06.03.2024 13:38, Lukasz Majewski wrote:
> This patch provides RedBox support (HSR-SAN to be more precise) for HSR
> networks. It implements the 'Mode U' without optimizations for traffic

I'd suggest to use imperative mode e.g:
"Introduce RedBox support ..."
"Implement the 'Mode U' ..."

> reduction (only supports preventing sending HSR supervisory frames to
> Port C and not forwarding to HSR ring frames addressed to Port C).
> 
> The corresponding patch to modify iptable2 sources has already been sent:
> https://lore.kernel.org/netdev/20240226124110.37892211@hermes.local/T/
> 
> 
> Testing procedure:
> ------------------
> The EVB-KSZ9477 has been used for testing on net-next branch
> (SHA1: 709776ea8562).
> 
> Ports 4/5 were used for SW managed HSR (hsr1) as first hsr0 for ports 1/2
> (with HW offloading for ksz9477) was created. Port 3 has been used as
> interlink port (USB-ETH dongle).
> 
> Configuration - RedBox (EVB-KSZ9477):
> ifconfig lan1 down;ifconfig lan2 down
> ip link add name hsr0 type hsr slave1 lan1 slave2 lan2 supervision 45 version 1
> ip link add name hsr1 type hsr slave1 lan4 slave2 lan5 interlink lan3 supervision 45 version 1
> ifconfig lan4 up;ifconfig lan5 up
> ifconfig lan3 up
> ifconfig hsr1 192.168.0.11 up
> 
> Configuration - DAN-H (EVB-KSZ9477):
> 
> ifconfig lan1 down;ifconfig lan2 down
> ip link add name hsr0 type hsr slave1 lan1 slave2 lan2 supervision 45 version 1
> ip link add name hsr1 type hsr slave1 lan4 slave2 lan5 supervision 45 version 1
> ifconfig lan4 up;ifconfig lan5 up
> ifconfig hsr1 192.168.0.12 up
> 
> This approach uses only SW based HSR devices (hsr1).
> 
> Signed-off-by: Lukasz Majewski <lukma@denx.de>
> ---
>  include/uapi/linux/if_link.h |  1 +
>  net/hsr/hsr_device.c         | 32 +++++++++++++++--
>  net/hsr/hsr_device.h         |  4 +--
>  net/hsr/hsr_forward.c        | 66 +++++++++++++++++++++++++++++++-----
>  net/hsr/hsr_framereg.c       | 55 ++++++++++++++++++++++++++++++
>  net/hsr/hsr_framereg.h       |  6 ++++
>  net/hsr/hsr_main.h           |  7 ++++
>  net/hsr/hsr_netlink.c        | 29 ++++++++++++++--
>  net/hsr/hsr_slave.c          |  1 +
>  9 files changed, 185 insertions(+), 16 deletions(-)
> 
> diff --git a/include/uapi/linux/if_link.h b/include/uapi/linux/if_link.h
> index ab9bcff96e4d..b93a3acdd83f 100644
> --- a/include/uapi/linux/if_link.h
> +++ b/include/uapi/linux/if_link.h
> @@ -1770,6 +1770,7 @@ enum {
>  	IFLA_HSR_PROTOCOL,		/* Indicate different protocol than
>  					 * HSR. For example PRP.
>  					 */
> +	IFLA_HSR_INTERLINK,		/* HSR interlink network device */
>  	__IFLA_HSR_MAX,
>  };
>  
> diff --git a/net/hsr/hsr_device.c b/net/hsr/hsr_device.c
> index 904cd8f8f830..4288d2b74472 100644
> --- a/net/hsr/hsr_device.c
> +++ b/net/hsr/hsr_device.c
> @@ -156,6 +156,9 @@ static int hsr_dev_open(struct net_device *dev)
>  		case HSR_PT_SLAVE_B:
>  			designation = "Slave B";
>  			break;
> +		case HSR_PT_INTERLINK:
> +			designation = "Interlink";
> +			break;
>  		default:
>  			designation = "Unknown";
>  		}
> @@ -295,6 +298,7 @@ static void send_hsr_supervision_frame(struct hsr_port *master,
>  	struct hsr_priv *hsr = master->hsr;
>  	__u8 type = HSR_TLV_LIFE_CHECK;
>  	struct hsr_sup_payload *hsr_sp;
> +	struct hsr_sup_tlv *hsr_stlv;
>  	struct hsr_sup_tag *hsr_stag;
>  	struct sk_buff *skb;
>  
> @@ -334,6 +338,16 @@ static void send_hsr_supervision_frame(struct hsr_port *master,
>  	hsr_sp = skb_put(skb, sizeof(struct hsr_sup_payload));
>  	ether_addr_copy(hsr_sp->macaddress_A, master->dev->dev_addr);
>  
> +	if (hsr->redbox) {
> +		hsr_stlv = skb_put(skb, sizeof(struct hsr_sup_tlv));
> +		hsr_stlv->HSR_TLV_type = PRP_TLV_REDBOX_MAC;
> +		hsr_stlv->HSR_TLV_length = sizeof(struct hsr_sup_payload);
> +
> +		/* Payload: MacAddressRedBox */
> +		hsr_sp = skb_put(skb, sizeof(struct hsr_sup_payload));
> +		ether_addr_copy(hsr_sp->macaddress_A, hsr->macaddress_redbox);
> +	}
> +
>  	if (skb_put_padto(skb, ETH_ZLEN)) {
>  		spin_unlock_bh(&hsr->seqnr_lock);
>  		return;
> @@ -544,8 +558,8 @@ static const unsigned char def_multicast_addr[ETH_ALEN] __aligned(2) = {
>  };
>  
>  int hsr_dev_finalize(struct net_device *hsr_dev, struct net_device *slave[2],
> -		     unsigned char multicast_spec, u8 protocol_version,
> -		     struct netlink_ext_ack *extack)
> +		     struct net_device *interlink, unsigned char multicast_spec,
> +		     u8 protocol_version, struct netlink_ext_ack *extack)
>  {
>  	bool unregister = false;
>  	struct hsr_priv *hsr;
> @@ -554,6 +568,7 @@ int hsr_dev_finalize(struct net_device *hsr_dev, struct net_device *slave[2],
>  	hsr = netdev_priv(hsr_dev);
>  	INIT_LIST_HEAD(&hsr->ports);
>  	INIT_LIST_HEAD(&hsr->node_db);
> +	INIT_LIST_HEAD(&hsr->proxy_node_db);
>  	spin_lock_init(&hsr->list_lock);
>  
>  	eth_hw_addr_set(hsr_dev, slave[0]->dev_addr);
> @@ -579,6 +594,7 @@ int hsr_dev_finalize(struct net_device *hsr_dev, struct net_device *slave[2],
>  	/* Overflow soon to find bugs easier: */
>  	hsr->sequence_nr = HSR_SEQNR_START;
>  	hsr->sup_sequence_nr = HSR_SUP_SEQNR_START;
> +	hsr->interlink_sequence_nr = HSR_SEQNR_START;
>  
>  	timer_setup(&hsr->announce_timer, hsr_announce, 0);
>  	timer_setup(&hsr->prune_timer, hsr_prune_nodes, 0);
> @@ -614,6 +630,18 @@ int hsr_dev_finalize(struct net_device *hsr_dev, struct net_device *slave[2],
>  	if (res)
>  		goto err_unregister;
>  
> +	if (interlink) {
> +		res = hsr_add_port(hsr, interlink, HSR_PT_INTERLINK, extack);
> +		if (res)
> +			goto err_unregister;

As Dan pointed out you should delete HSR_PT_INTERLINK port in hsr_del_ports

> +
> +		hsr->redbox = true;
> +		ether_addr_copy(hsr->macaddress_redbox, interlink->dev_addr);
> +		timer_setup(&hsr->prune_proxy_timer, hsr_prune_proxy_nodes, 0);
> +		mod_timer(&hsr->prune_proxy_timer,
> +			  jiffies + msecs_to_jiffies(PRUNE_PROXY_PERIOD));
> +	}
> +
>  	hsr_debugfs_init(hsr, hsr_dev);
>  	mod_timer(&hsr->prune_timer, jiffies + msecs_to_jiffies(PRUNE_PERIOD));
>  
> diff --git a/net/hsr/hsr_device.h b/net/hsr/hsr_device.h
> index 9060c92168f9..655284095b78 100644
> --- a/net/hsr/hsr_device.h
> +++ b/net/hsr/hsr_device.h
> @@ -16,8 +16,8 @@
>  void hsr_del_ports(struct hsr_priv *hsr);
>  void hsr_dev_setup(struct net_device *dev);
>  int hsr_dev_finalize(struct net_device *hsr_dev, struct net_device *slave[2],
> -		     unsigned char multicast_spec, u8 protocol_version,
> -		     struct netlink_ext_ack *extack);
> +		     struct net_device *interlink, unsigned char multicast_spec,
> +		     u8 protocol_version, struct netlink_ext_ack *extack);
>  void hsr_check_carrier_and_operstate(struct hsr_priv *hsr);
>  int hsr_get_max_mtu(struct hsr_priv *hsr);
>  #endif /* __HSR_DEVICE_H */
> diff --git a/net/hsr/hsr_forward.c b/net/hsr/hsr_forward.c
> index 5d68cb181695..8ae7066846e2 100644
> --- a/net/hsr/hsr_forward.c
> +++ b/net/hsr/hsr_forward.c
> @@ -390,9 +390,29 @@ bool prp_drop_frame(struct hsr_frame_info *frame, struct hsr_port *port)
>  
>  bool hsr_drop_frame(struct hsr_frame_info *frame, struct hsr_port *port)
>  {
> +	struct sk_buff *skb;
> +
>  	if (port->dev->features & NETIF_F_HW_HSR_FWD)
>  		return prp_drop_frame(frame, port);
>  
> +	/* RedBox specific frames dropping policies
> +	 *
> +	 * Do not send HSR supervisory frames to SAN devices
> +	 */
> +	if (frame->is_supervision && port->type == HSR_PT_INTERLINK)
> +		return true;
> +
> +	/* Do not forward to other HSR port (A or B) unicast frames which
> +	 * are addressed to interlink port (and are in the ProxyNodeTable).
> +	 */
> +	skb = frame->skb_hsr;
> +	if (skb && prp_drop_frame(frame, port) &&
> +	    is_unicast_ether_addr(eth_hdr(skb)->h_dest) &&
> +	    hsr_is_node_in_db(&port->hsr->proxy_node_db,
> +			      eth_hdr(skb)->h_dest)) {
> +		return true;
> +	}
> +
>  	return false;
>  }
>  
> @@ -448,13 +468,14 @@ static void hsr_forward_do(struct hsr_frame_info *frame)
>  		}
>  
>  		/* Check if frame is to be dropped. Eg. for PRP no forward
> -		 * between ports.
> +		 * between ports, or sending HSR supervision to RedBox.
>  		 */
>  		if (hsr->proto_ops->drop_frame &&
>  		    hsr->proto_ops->drop_frame(frame, port))
>  			continue;
>  
> -		if (port->type != HSR_PT_MASTER)
> +		if (port->type == HSR_PT_SLAVE_A ||
> +		    port->type == HSR_PT_SLAVE_B)
>  			skb = hsr->proto_ops->create_tagged_frame(frame, port);
>  		else
>  			skb = hsr->proto_ops->get_untagged_frame(frame, port);
> @@ -469,7 +490,9 @@ static void hsr_forward_do(struct hsr_frame_info *frame)
>  			hsr_deliver_master(skb, port->dev, frame->node_src);
>  		} else {
>  			if (!hsr_xmit(skb, port, frame))
> -				sent = true;
> +				if (port->type == HSR_PT_SLAVE_A ||
> +				    port->type == HSR_PT_SLAVE_B)
> +					sent = true;
>  		}
>  	}
>  }
> @@ -503,13 +526,23 @@ static void handle_std_frame(struct sk_buff *skb,
>  	frame->skb_prp = NULL;
>  	frame->skb_std = skb;
>  
> -	if (port->type != HSR_PT_MASTER) {
> -		frame->is_from_san = true;
> -	} else {
> +	switch (port->type) {
> +	case HSR_PT_MASTER:
>  		/* Sequence nr for the master node */
>  		lockdep_assert_held(&hsr->seqnr_lock);
>  		frame->sequence_nr = hsr->sequence_nr;
>  		hsr->sequence_nr++;
> +		break;
> +
> +	case HSR_PT_INTERLINK:
> +		frame->is_from_san = true;
> +		lockdep_assert_held(&hsr->seqnr_lock);
> +		frame->sequence_nr = hsr->sequence_nr;
> +		hsr->sequence_nr++;

Everything except setting is_from_san flag is the same as in HSR_PT_MASTER case.
Looks like a helper function could be used here.

> +		break;
> +
> +	default:
> +		pr_err("Standard frame from wrong port type!");
>  	}
>  }
>  
> @@ -564,6 +597,7 @@ static int fill_frame_info(struct hsr_frame_info *frame,
>  {
>  	struct hsr_priv *hsr = port->hsr;
>  	struct hsr_vlan_ethhdr *vlan_hdr;
> +	struct list_head *n_db;
>  	struct ethhdr *ethhdr;
>  	__be16 proto;
>  	int ret;
> @@ -574,9 +608,23 @@ static int fill_frame_info(struct hsr_frame_info *frame,
>  
>  	memset(frame, 0, sizeof(*frame));
>  	frame->is_supervision = is_supervision_frame(port->hsr, skb);
> -	frame->node_src = hsr_get_node(port, &hsr->node_db, skb,
> -				       frame->is_supervision,
> -				       port->type);
> +
> +	n_db = &hsr->node_db;
> +
> +	if (port->type == HSR_PT_INTERLINK)
> +		n_db = &hsr->proxy_node_db;
> +
> +	if (port->type == HSR_PT_SLAVE_A || port->type == HSR_PT_SLAVE_B)
> +		/* If for frame received from HSR ring the node is
> +		 * not present in NodeTable, look for destination one
> +		 * in the ProxyNodeTable.
> +		 */
> +		if (hsr_is_node_in_db(&hsr->proxy_node_db,
> +				      eth_hdr(skb)->h_dest))
> +			n_db = &hsr->proxy_node_db;
> +
> +	frame->node_src = hsr_get_node(port, n_db, skb,
> +				       frame->is_supervision, port->type);
>  	if (!frame->node_src)
>  		return -1; /* Unknown node and !is_supervision, or no mem */
>  
> diff --git a/net/hsr/hsr_framereg.c b/net/hsr/hsr_framereg.c
> index 6d14d935ee82..d7188b16ad04 100644
> --- a/net/hsr/hsr_framereg.c
> +++ b/net/hsr/hsr_framereg.c
> @@ -71,6 +71,14 @@ static struct hsr_node *find_node_by_addr_A(struct list_head *node_db,
>  	return NULL;
>  }
>  
> +/* Check if node for a given MAC address is already present in data base
> + */
> +bool hsr_is_node_in_db(struct list_head *node_db,
> +		       const unsigned char addr[ETH_ALEN])
> +{
> +	return !!find_node_by_addr_A(node_db, addr);
> +}
> +
>  /* Helper for device init; the self_node is used in hsr_rcv() to recognize
>   * frames from self that's been looped over the HSR ring.
>   */
> @@ -223,6 +231,15 @@ struct hsr_node *hsr_get_node(struct hsr_port *port, struct list_head *node_db,
>  		}
>  	}
>  
> +	/* Check if required node is not in proxy nodes table */
> +	list_for_each_entry_rcu(node, &hsr->proxy_node_db, mac_list) {
> +		if (ether_addr_equal(node->macaddress_A, ethhdr->h_source)) {
> +			if (hsr->proto_ops->update_san_info)
> +				hsr->proto_ops->update_san_info(node, is_sup);
> +			return node;
> +		}
> +	}
> +
>  	/* Everyone may create a node entry, connected node to a HSR/PRP
>  	 * device.
>  	 */
> @@ -414,6 +431,10 @@ void hsr_addr_subst_dest(struct hsr_node *node_src, struct sk_buff *skb,
>  
>  	node_dst = find_node_by_addr_A(&port->hsr->node_db,
>  				       eth_hdr(skb)->h_dest);
> +	if (!node_dst && port->hsr->redbox)
> +		node_dst = find_node_by_addr_A(&port->hsr->proxy_node_db,
> +					       eth_hdr(skb)->h_dest);
> +
>  	if (!node_dst) {
>  		if (port->hsr->prot_version != PRP_V1 && net_ratelimit())
>  			netdev_err(skb->dev, "%s: Unknown node\n", __func__);
> @@ -557,6 +578,40 @@ void hsr_prune_nodes(struct timer_list *t)
>  		  jiffies + msecs_to_jiffies(PRUNE_PERIOD));
>  }
>  
> +void hsr_prune_proxy_nodes(struct timer_list *t)
> +{
> +	struct hsr_priv *hsr = from_timer(hsr, t, prune_proxy_timer);
> +	struct hsr_node *node;
> +	struct hsr_node *tmp;
> +	unsigned long timestamp;

RCT

> +
> +	spin_lock_bh(&hsr->list_lock);
> +	list_for_each_entry_safe(node, tmp, &hsr->proxy_node_db, mac_list) {
> +		timestamp = node->time_in[HSR_PT_INTERLINK];
> +		/* Check for timestamps old enough to risk wrap-around */
> +		if (time_after(jiffies, timestamp + MAX_JIFFY_OFFSET / 2))
> +			node->time_in_stale[HSR_PT_INTERLINK] = true;
> +
> +		/* Prune old entries */
> +		if (time_is_before_jiffies(timestamp +
> +				msecs_to_jiffies(HSR_PROXY_NODE_FORGET_TIME))) {
> +			hsr_nl_nodedown(hsr, node->macaddress_A);
> +			if (!node->removed) {
> +				list_del_rcu(&node->mac_list);
> +				node->removed = true;
> +				/* Note that we need to free this entry later: */
> +				kfree_rcu(node, rcu_head);
> +			}
> +		}
> +	}
> +
> +	spin_unlock_bh(&hsr->list_lock);
> +
> +	/* Restart timer */
> +	mod_timer(&hsr->prune_proxy_timer,
> +		  jiffies + msecs_to_jiffies(PRUNE_PROXY_PERIOD));
> +}
> +
>  void *hsr_get_next_node(struct hsr_priv *hsr, void *_pos,
>  			unsigned char addr[ETH_ALEN])
>  {
> diff --git a/net/hsr/hsr_framereg.h b/net/hsr/hsr_framereg.h
> index b23556251d62..67456a75d8fe 100644
> --- a/net/hsr/hsr_framereg.h
> +++ b/net/hsr/hsr_framereg.h
> @@ -46,6 +46,7 @@ int hsr_register_frame_out(struct hsr_port *port, struct hsr_node *node,
>  			   u16 sequence_nr);
>  
>  void hsr_prune_nodes(struct timer_list *t);
> +void hsr_prune_proxy_nodes(struct timer_list *t);
>  
>  int hsr_create_self_node(struct hsr_priv *hsr,
>  			 const unsigned char addr_a[ETH_ALEN],
> @@ -63,10 +64,15 @@ int hsr_get_node_data(struct hsr_priv *hsr,
>  		      int *if2_age,
>  		      u16 *if2_seq);
>  
> +void hsr_handle_san_frame(bool san, enum hsr_port_type port,
> +			  struct hsr_node *node);
>  void prp_handle_san_frame(bool san, enum hsr_port_type port,
>  			  struct hsr_node *node);
>  void prp_update_san_info(struct hsr_node *node, bool is_sup);
>  
> +bool hsr_is_node_in_db(struct list_head *node_db,
> +		       const unsigned char addr[ETH_ALEN]);
> +
>  struct hsr_node {
>  	struct list_head	mac_list;
>  	/* Protect R/W access to seq_out */
> diff --git a/net/hsr/hsr_main.h b/net/hsr/hsr_main.h
> index 18e01791ad79..23850b16d1ea 100644
> --- a/net/hsr/hsr_main.h
> +++ b/net/hsr/hsr_main.h
> @@ -21,6 +21,7 @@
>   */
>  #define HSR_LIFE_CHECK_INTERVAL		 2000 /* ms */
>  #define HSR_NODE_FORGET_TIME		60000 /* ms */
> +#define HSR_PROXY_NODE_FORGET_TIME	60000 /* ms */
>  #define HSR_ANNOUNCE_INTERVAL		  100 /* ms */
>  #define HSR_ENTRY_FORGET_TIME		  400 /* ms */
>  
> @@ -35,6 +36,7 @@
>   * HSR_NODE_FORGET_TIME?
>   */
>  #define PRUNE_PERIOD			 3000 /* ms */
> +#define PRUNE_PROXY_PERIOD		 3000 /* ms */
>  #define HSR_TLV_EOT				   0  /* End of TLVs */
>  #define HSR_TLV_ANNOUNCE		   22
>  #define HSR_TLV_LIFE_CHECK		   23
> @@ -192,11 +194,14 @@ struct hsr_priv {
>  	struct rcu_head		rcu_head;
>  	struct list_head	ports;
>  	struct list_head	node_db;	/* Known HSR nodes */
> +	struct list_head	proxy_node_db;	/* RedBox HSR proxy nodes */
>  	struct hsr_self_node	__rcu *self_node;	/* MACs of slaves */
>  	struct timer_list	announce_timer;	/* Supervision frame dispatch */
>  	struct timer_list	prune_timer;
> +	struct timer_list	prune_proxy_timer;
>  	int announce_count;
>  	u16 sequence_nr;
> +	u16 interlink_sequence_nr; /* Interlink port seq_nr */
>  	u16 sup_sequence_nr;	/* For HSRv1 separate seq_nr for supervision */
>  	enum hsr_version prot_version;	/* Indicate if HSRv0, HSRv1 or PRPv1 */
>  	spinlock_t seqnr_lock;	/* locking for sequence_nr */
> @@ -209,6 +214,8 @@ struct hsr_priv {
>  				 * of lan_id
>  				 */
>  	bool fwd_offloaded;	/* Forwarding offloaded to HW */
> +	bool redbox;            /* Device supports HSR RedBox */
> +	unsigned char		macaddress_redbox[ETH_ALEN];
>  	unsigned char		sup_multicast_addr[ETH_ALEN] __aligned(sizeof(u16));
>  				/* Align to u16 boundary to avoid unaligned access
>  				 * in ether_addr_equal
> diff --git a/net/hsr/hsr_netlink.c b/net/hsr/hsr_netlink.c
> index 78fe40eb9f01..86eae49009cb 100644
> --- a/net/hsr/hsr_netlink.c
> +++ b/net/hsr/hsr_netlink.c
> @@ -23,6 +23,7 @@ static const struct nla_policy hsr_policy[IFLA_HSR_MAX + 1] = {
>  	[IFLA_HSR_SUPERVISION_ADDR]	= { .len = ETH_ALEN },
>  	[IFLA_HSR_SEQ_NR]		= { .type = NLA_U16 },
>  	[IFLA_HSR_PROTOCOL]		= { .type = NLA_U8 },
> +	[IFLA_HSR_INTERLINK]		= { .type = NLA_U32 },
>  };
>  
>  /* Here, it seems a netdevice has already been allocated for us, and the
> @@ -35,8 +36,8 @@ static int hsr_newlink(struct net *src_net, struct net_device *dev,
>  	enum hsr_version proto_version;
>  	unsigned char multicast_spec;
>  	u8 proto = HSR_PROTOCOL_HSR;
> -	struct net_device *link[2];
>  
> +	struct net_device *link[2], *interlink = NULL;
>  	if (!data) {
>  		NL_SET_ERR_MSG_MOD(extack, "No slave devices specified");
>  		return -EINVAL;
> @@ -67,6 +68,20 @@ static int hsr_newlink(struct net *src_net, struct net_device *dev,
>  		return -EINVAL;
>  	}
>  
> +	if (data[IFLA_HSR_INTERLINK])
> +		interlink = __dev_get_by_index(src_net,
> +					       nla_get_u32(data[IFLA_HSR_INTERLINK]));
> +
> +	if (interlink && interlink == link[0]) {
> +		NL_SET_ERR_MSG_MOD(extack, "Interlink and Slave1 are the same");
> +		return -EINVAL;
> +	}
> +
> +	if (interlink && interlink == link[1]) {
> +		NL_SET_ERR_MSG_MOD(extack, "Interlink and Slave2 are the same");
> +		return -EINVAL;
> +	}
> +
>  	if (!data[IFLA_HSR_MULTICAST_SPEC])
>  		multicast_spec = 0;
>  	else
> @@ -96,10 +111,17 @@ static int hsr_newlink(struct net *src_net, struct net_device *dev,
>  		}
>  	}
>  
> -	if (proto == HSR_PROTOCOL_PRP)
> +	if (proto == HSR_PROTOCOL_PRP) {
>  		proto_version = PRP_V1;
> +		if (interlink) {
> +			NL_SET_ERR_MSG_MOD(extack,
> +					   "Interlink only works with HSR");
> +			return -EINVAL;
> +		}
> +	}
>  
> -	return hsr_dev_finalize(dev, link, multicast_spec, proto_version, extack);
> +	return hsr_dev_finalize(dev, link, interlink, multicast_spec,
> +				proto_version, extack);
>  }
>  
>  static void hsr_dellink(struct net_device *dev, struct list_head *head)
> @@ -114,6 +136,7 @@ static void hsr_dellink(struct net_device *dev, struct list_head *head)
>  
>  	hsr_del_self_node(hsr);
>  	hsr_del_nodes(&hsr->node_db);
> +	hsr_del_nodes(&hsr->proxy_node_db);
>  
>  	unregister_netdevice_queue(dev, head);
>  }
> diff --git a/net/hsr/hsr_slave.c b/net/hsr/hsr_slave.c
> index e5742f2a2d52..136e3917f477 100644
> --- a/net/hsr/hsr_slave.c
> +++ b/net/hsr/hsr_slave.c
> @@ -55,6 +55,7 @@ static rx_handler_result_t hsr_handle_frame(struct sk_buff **pskb)
>  	protocol = eth_hdr(skb)->h_proto;
>  
>  	if (!(port->dev->features & NETIF_F_HW_HSR_TAG_RM) &&
> +	    port->type != HSR_PT_INTERLINK &&
>  	    hsr->proto_ops->invalid_dan_ingress_frame &&
>  	    hsr->proto_ops->invalid_dan_ingress_frame(protocol))
>  		goto finish_pass;

