Return-Path: <linux-kernel+bounces-51409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F087D848AE6
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 04:36:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 799861F22FCE
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 03:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD1C14430;
	Sun,  4 Feb 2024 03:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b="O5Mym+bd"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2123.outbound.protection.outlook.com [40.107.255.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2AF11878
	for <linux-kernel@vger.kernel.org>; Sun,  4 Feb 2024 03:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707017755; cv=fail; b=Gu4ZdsII5Rz/0jFSTj/gOIl70knNko8Ce/Q1PA+bWMPLcWvhZ92Y7XwBQF0QLrzyv1XrmLMl4boQ4rslzsq/UsaOOpemEX/wvOrW3GeM3U0aYjQe8hgeXHCPc23WvIyTTEBqa5OdQInxmReBex4QlWiCdfGu8GtrjozTMKXFvpg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707017755; c=relaxed/simple;
	bh=3ypTnCq+4NKR6BIWEpBMVVJ0X/APEVeGb4tRLuRaKa4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=F//wEcpMHNjSLwB0/Fp1ax4CFA1BXcAza4yX42AianNITuabPJ7cl1BXKy69YtmDI3G4EzfGqFTjmMfiPlo9lTgTCODaUs3Y3A4Do0iWZ7lPp4lk/mUM1UAz7EK0dntwZCLkNT9aT7vpceR+uypMQko8ivMm1MBI1GFxDhdpNQU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com; spf=pass smtp.mailfrom=oppo.com; dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b=O5Mym+bd; arc=fail smtp.client-ip=40.107.255.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oppo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BNwj8kj48rOR5aNsOwjUF+XpIXqpRr6+9qwtZpgsRsNQen3YrcRibku+H3QErTxWYYw4MxBEl8rPqlAZ+I1aUTjxwZft7rueWJMPpZtARg1ea0Vi8genb8BbgX7NjYrf3FaHz4mhg1PZv3a/pMcwXE/LQ3wWETGz3GGj/llAfFHbNYMg4e97GFFI9QSWsRtimNk4/EuizhnVPh6OqNPeX04k3sR0rTOCkWSz0JKZNOVXh7lbzwJVX5ZBdWovNzDCOqgoR9S6/BtJ8kTkE87crcAkZXVk7QH7vJxqdBgbKO7D8xlO14T+1px5YxIPiwr1xYUbpd3fAaAvT3TIpIVGxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2ALOFvIP/ZydO4BnG6xiCEGvjUtrqwcdwFcWZfrg9TA=;
 b=V8ATcbKIkO0zul+0RJpejWEXyFRG7wY/iNE8iwA/YVt3VVjuCaJD7SVIVn4FST4BtoI45bvVBrGdVwQl3l+uFTlRxavrdERTE5U4OwZdnY44VgaUKxwWEixWk7fJKT69cfABdi1rwf3LLEJYoN+RO186TvVAa8GNzooZC0X6T2PEgDKGUg95nhLVlVCjErUpRU2CcjDjfuEjWUw2yUYu5rRSUomUsE1pEpCxZgP53gVhp1iWbIxmB2hAnLC7ttKuBQQ/2o1e7bAM+uZ+jLtB8sDNYFRpeE+jjOfZMVWo78ybstdfIXVqgjyvBNwehy6eQwwPBDysve+OFUVbY+wnQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2ALOFvIP/ZydO4BnG6xiCEGvjUtrqwcdwFcWZfrg9TA=;
 b=O5Mym+bdI72Rvc7QmQKU1BHOEUuxXP7HZPxbF086lsrhPYBcI5whoJLdZUFh+6B7rjVzVKjur3+3UWLc01Hg/VH5SZelZKjT0QOW2HuRx3B7BqgLlU2q5bVJuG4N0Q32P27CCyYqSAlnN7FTfLPZhsG+9jxxDrFazbxFY0yujlU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oppo.com;
Received: from SI2PR02MB4730.apcprd02.prod.outlook.com (2603:1096:4:12a::11)
 by TYZPR02MB7411.apcprd02.prod.outlook.com (2603:1096:405:4a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.33; Sun, 4 Feb
 2024 03:35:48 +0000
Received: from SI2PR02MB4730.apcprd02.prod.outlook.com
 ([fe80::4868:549f:f355:f4fb]) by SI2PR02MB4730.apcprd02.prod.outlook.com
 ([fe80::4868:549f:f355:f4fb%4]) with mapi id 15.20.7249.032; Sun, 4 Feb 2024
 03:35:47 +0000
Message-ID: <8c51d0d8-ae3d-418c-b6ac-5a164b40a8c5@oppo.com>
Date: Sun, 4 Feb 2024 11:35:45 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] f2fs: fix zoned block device information
 initialization
Content-Language: en-US
To: Wenjie Qi <qwjhust@gmail.com>, jaegeuk@kernel.org, chao@kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Cc: hustqwj@hust.edu.cn
References: <20240204031022.1189-1-qwjhust@gmail.com>
From: Yongpeng Yang <yangyongpeng1@oppo.com>
In-Reply-To: <20240204031022.1189-1-qwjhust@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0018.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::7) To SI2PR02MB4730.apcprd02.prod.outlook.com
 (2603:1096:4:12a::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR02MB4730:EE_|TYZPR02MB7411:EE_
X-MS-Office365-Filtering-Correlation-Id: c84e6913-cef3-4073-9593-08dc2532607a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	rFhSaKc676NCqsgl9GUFkecYVTy4nyfkos/Nfur1JIYAQ7Lx19ZSoSjtXk3ChOMKfsAHRHt6JG+OKOoGkb4UJAmF6vjkWa+/Xhf24c+oCadoAdL5xuGpzunViHORQeyr1tgUzrmW7aaRufuI1BmOQORzUc1hzGSKMVAfuE1JXPyeRu5heMZ9wTk26eFb2w9nUezXDB4+FSF8aekdivgHlVB//YD6gyMsZM1/ssGVRIdWCnq4VhbuqAQssHbRNuSocug89XWIdHmtgeFa4wTb2K0HxLHBYfXsR4z/X+ItiQhUYCLYPvpekQlsUsb6IYqCSNLhWHX+Q1dKzKUJqFy8/ZuhIYLzNf+/HilbiAUODRhL0tf7S7MaRsOOBfS4DIZwbvx0/3NUi/MWaV1NzVK9YX1UqJuYFFzUTtZCb2NsZ0/xLnV2mGv7DDfcI/46rwnCifKXsS2xIddlVJ2XJ+PAckx1M+0pjeZS2ydtBeWyYd1O+t9kTk3EUjeoNwqOTaONQj+8g9TNjbEIwDpNEuGHnad0h+89eWo719uSF0DZRPDAxYrLj9sAPt2CW+h5y3jXa/bhodTqzUotLfbO61uln4KDjMhsBIU1KDimBuQju0yNx8rA1dY7uUXBuzuWwH/bke1iqj84nPL7C+3CdYefSg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR02MB4730.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(346002)(39860400002)(366004)(136003)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(2616005)(53546011)(36756003)(6512007)(6506007)(86362001)(26005)(31696002)(38100700002)(41300700001)(478600001)(6486002)(4326008)(8676002)(8936002)(2906002)(31686004)(5660300002)(4744005)(66556008)(66476007)(66946007)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UVZOaFlVdjRDVUliOUJTNmVWTW1iYVJMb21JYlQ4MFprSFphYjJLYVhyWEJI?=
 =?utf-8?B?VTNTMHhVVW5peEJHdEE5ZjQ0b05Bc0lsTktnNVFQaXRCbndnUFUyVmt0QlJY?=
 =?utf-8?B?WkdkT2FSOGJ0eXdGeDhiMFprZzEvUExaTVIvZUJYN001WERWZzJWdWRDZjlw?=
 =?utf-8?B?OUdJc3g0VkNPZWN0VmI1QkcyTXR6aHZsL2xhY3Z0UkY0Nmh1TThXZXpsbHlr?=
 =?utf-8?B?YmVmcGRiR3M5dzJWTDM4QkhUWG1XYlB6UGphaDlnbU9kYUJaMVN4bmd1MHlm?=
 =?utf-8?B?dlhncVVYUlQ5ckt0RjBTQ0UwV2pqV04vWnUxc3U1bHdkYjNqbjk3ZGloRmlM?=
 =?utf-8?B?Z3Frd2E1WmhYcmx1d0IxSFpZSnc0bzVrSkEvWTJvRUNGbWFsWFR3VHBHUk45?=
 =?utf-8?B?clM1N01xdVlBNk9heG9kWk9SMXJueGJvZFBoejhjeE42Znpla0ZZdjk5Z09N?=
 =?utf-8?B?dEVQSURib0VOY0FabkVJWHBzZmxQcGJEN2F1M0hrcjZGR0ZoamVCcHFYelpj?=
 =?utf-8?B?dXhZNXN1OVVoMnE3MUoxRGtBZDkxYVpwWGlOWFZHc09sa0QvTHhBa0VHTGlj?=
 =?utf-8?B?UFd3WjhYOWNMWTdVZTdjSlhET01lcmJXVjdHU1pnR05ad0VKNnB3NlRON3Ix?=
 =?utf-8?B?TXpiTmoyNmV5S3JpczFQWVRVa25iQ0thSU1wSmJ6T2dqOVZOY0NRajRzZ0ZP?=
 =?utf-8?B?eXN2MzlpTW9FbU4rYURzWVI5QzhaM3ZVRXpReDQ4MlR5aDc4MS9CNGZtVU9T?=
 =?utf-8?B?WFB4c1JTdlZDaU9MeTUzelB0Z2FsekdPeFNvL1A2TlhQWmRrT2pCWG9NWndz?=
 =?utf-8?B?a2ljWGRveTNEZ0JGT2JtalNnWlh0MzNMWmhDeG9Cd3F5U3NmQVRudlNVWWJJ?=
 =?utf-8?B?d1J3am9aMGdzV0VOVGN1ZkE2d2F5Smd2ZmlTM3B0ZVR1bFpuUlkwQ1lVeE56?=
 =?utf-8?B?M1krSC9hRUQ5TGVydGw4MVAzT0czT1Z2M0RnZzE5NWRETmw5Y09zald1dFJB?=
 =?utf-8?B?WkJ0KzVCY3dIbk1VSnVYZVJMVmE0ZUloZFRWSUlabStvSVNvRUwyUW12R2ZS?=
 =?utf-8?B?WUxmbWlrdmcrSThOWXZ1TnRvcWJIVlNXYi9qQmhRZWtYZGphdmovSkk3Yzdk?=
 =?utf-8?B?UnRrbDJCRmZyL1dlLzExVHhiZDQzdmJQNXJtOWk4L2UwRVNkdGEvdnVrbG83?=
 =?utf-8?B?TFNpNmtWSlJpVUkyUU5xcG85M2hwWm9ZaUJ4V0RFSXlUeGwzZ3ZvSGxab0c0?=
 =?utf-8?B?c0l5dXdJdmtpb0J5WFkyeEFUMWtuTytiblVxK3NxMFI0ZVh1YkpMY3haNy91?=
 =?utf-8?B?VUxrSGVlUEkwUHJwZW9QYjVwZ3dxRFFsMmwwM1k3YkQvcEFnY3hsUXFDRjFu?=
 =?utf-8?B?bFJCcytRWEhjVWE5c25aVXdyMENrRndsSXdKcVU4aUY4TS81UXZLRDBCWHZE?=
 =?utf-8?B?MmM2ZHN5RkJwV0Nla0Q4Q21YRmZWZlpKQlJyMW53aHVYZ0QxNGJtYUNSR2VS?=
 =?utf-8?B?OVEzdFc5dzBUSWxPbUVNWUpodVNPNGlNY3ZuSXpzRVZYOXVUVndNODRIMXlq?=
 =?utf-8?B?V3FUYkpVdzE2dlZVT1Rta0FnRDVhKzFzcjhoaHhTNkthT1lFZjBCOHVrcUcr?=
 =?utf-8?B?VGloMUxIYkVPeTd6dkgxZklhVzA0U0U2ZS91SzF1USs5UTQxMERaK1hQQ3BN?=
 =?utf-8?B?b2k1YWxQMnBGTVBXQ1YzdFVSVld6N3YwVTlyc1h6eUwwejBwMlR3U1hKVDd0?=
 =?utf-8?B?SUdDT3QwOU01RldiOUNlQ3VBenVjVkx6WVZBczBDZVM0V20zbkozaUp1elE2?=
 =?utf-8?B?YStTNTBra2JqNjBlKy9QOUtsa0Eyek8vem41dzcxVUI5aTJoMW1GdEFpR2pJ?=
 =?utf-8?B?T1hYSW5nK3p3NTlRaVFhUlIyU3ZwTWczTHloQTlyVXJTWVZPd2JrZXQ0blV0?=
 =?utf-8?B?QlpCT3pOQ25QdllYN1JBbTdveWN4NENHclJmUDN4eWs0SVE1bXByZ3hNVEhn?=
 =?utf-8?B?L2dwSEgrQW5nRzNpZVdVOW1hQWJNd0h2bFE2bmpiZy8vU0JBdDFQSmpLZTF0?=
 =?utf-8?B?SGlNREd0aDY1Yk9Ga1dRdUIwN1I4V1FWem1KWi96eWJia2Z5Q29uZ1lIYjBG?=
 =?utf-8?B?cFJzV3QxYnd5cXduTzVoV2hhMG8zTGprQkcxK1k1NHlPUnUva3d6aEJVTXlZ?=
 =?utf-8?B?YUE9PQ==?=
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c84e6913-cef3-4073-9593-08dc2532607a
X-MS-Exchange-CrossTenant-AuthSource: SI2PR02MB4730.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2024 03:35:47.7945
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U/3N5BiKXN4Qj3BOYUaHWi7QmLQH00GlTnESrlOa1Gh96hFOj9gI8YDQkexSHkw+WARDcRq0st4ZSfS/9u/bkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR02MB7411

Hi Wenjie,
"max_open_zones < sbi->max_open_zones" seems meaningless, this condition 
is false only if "max_open_zones == UINT_MAX"(rarely happen). Although 
it doesn't affect the correctness, I think less jmp instruction is better.

On 2/4/2024 11:10 AM, Wenjie Qi wrote:
> max_open_zones < sbi->max_open_zones

