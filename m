Return-Path: <linux-kernel+bounces-153041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DA3F8AC83D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 11:02:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FE481C20E08
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 09:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F5CA51C5C;
	Mon, 22 Apr 2024 09:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="OLhAufRG"
Received: from IND01-BMX-obe.outbound.protection.outlook.com (mail-bmxind01olkn2032.outbound.protection.outlook.com [40.92.103.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C1092BAEB;
	Mon, 22 Apr 2024 09:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.103.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713776524; cv=fail; b=clHN2rEBHmnIpdpMzjORMLyNHyd6kx6zTFWoQY+yDitZg0klAcc3FBoHjuUchjtTIDhBCd92T5VGQvgSlTSpQuAatqYzcnvN01tGn6XclJJIOa5sQgCL9hZNuDeYz5nGSchkmq/alN8VBplC+3cyNfqStC1tVHsmQN8LFzrCGGQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713776524; c=relaxed/simple;
	bh=lZSB9WW1wsYJwGjeJSmVtPn7R5nEAL8yKBNoKA2dGBU=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qipt/5g00bLuOTSsDpO9W5JWLyZvy/gjcBbdai8E2T/f82GxnlJPndVHYBpfhyWRFQZNG4v6zgRqdPq2erGASOA83EoRoQ9I65H7azVhGZt+OQ1xhvyswIbsI/Me/gkf9u1WMdJeWt8Njx0AIap2k9IjiNDZ5Yq59Q/4z+sn0LI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=OLhAufRG; arc=fail smtp.client-ip=40.92.103.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eOX2mLueHeRNcm2W3gHkUfJ2I62Ov3z67qOXAGQWAgrOLsjUf+G2vzZgbIeKdeeRYuJAp+lPfzrKUWQFdLxFX8woCYpAaR41vjdc5ml2f7xlbDlYYYZ2azZ1+82QmvjyrWtL6RcNhhKgMdM9ThpT1m1O21/mL6V2879Ky/umlnEzAv69Q01KnObAFHg08AwVYlW/NJ894ZYWcgrP9DiwODzW5m+oRvfCuNitkSH/6zhBHkeW4OIffid4GltbzC0NDaI17E+5yFT14JCs/5Lp0odtuZ6lM+z/OK9Ws8LwRfSooSJ6+JMw3ffmGpQJTpHl0HL8f6m3ycFt/PmCPdDwmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pokqtTbS+ZVgajyh+JbR6aYqoJBmafLKoXxLbK6OiDo=;
 b=jFB6LQcA50GIeglwGlTKzQr/TgHkIJoypXLiBf84DdniE3qY4+q91bifci4uvLasrgeult6g892JJkKH3sVWqGyfIkfWPIRHNaO/ZbC5BPazWVepDIssS7rfNfykHNthfGol0lkkfCmlHcHISchllbCPQIPzT/XyuOI921F637nvW54yAgjjvQZDzJO5E8yrI6j61BIZrc62HeTADqPn0WZn+bB1+so+r+4fE+wq92evXDKkYLZ8SVcGGzJ+K7N3l7xcSuuUKl3KogjqN4hPBpRm/SlQWkVUmD2gQLiLIA3P2duEuDerV6pqa15Rdx2/lN/phWzm+PDxq6Xlqp9aJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pokqtTbS+ZVgajyh+JbR6aYqoJBmafLKoXxLbK6OiDo=;
 b=OLhAufRG66yyiwcXayFJTZ4/YlGYTWmIEEcaRS5U4KnQV6rHv0L4bUxUaRiz+nMLpGSiGQWk2oSik42IhdOrcz8hGSbj/ou6gjH0OSqvUr6ZDt61eUGCU11KzHM2nO3jKwaXIJWW6oiMFkRUccs373i86f/oLacFxE/aw7BiSQXmg6PJacIF9XJOcSrQgIvQ6UHkoW7DDjVdIVvzQkoKEGUJvcYFJDzNAL/u4ds4QwHGwVDuvM5N2CuH9myc6/tqCWtJ53oHXDK5fWYL8iT/AatWYQti7CaDVhW9yXTOuvkNhyU8YmpUNGAJEeBo349Lmzv1plqTD4RlF4p3ja5myQ==
Received: from MA0P287MB2822.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:138::5)
 by PN3P287MB0058.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:92::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Mon, 22 Apr
 2024 09:01:55 +0000
Received: from MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 ([fe80::664:2ecc:c36:1f2c]) by MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 ([fe80::664:2ecc:c36:1f2c%3]) with mapi id 15.20.7472.044; Mon, 22 Apr 2024
 09:01:55 +0000
Message-ID:
 <MA0P287MB28226B9C954F3DBD9B5E29A5FE122@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>
Date: Mon, 22 Apr 2024 17:01:49 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/1] mmc: sdhci-of-dwcmshc: enhance framework
To: Chen Wang <unicornxw@gmail.com>, adrian.hunter@intel.com,
 ulf.hansson@linaro.org, linux-mmc@vger.kernel.org,
 linux-kernel@vger.kernel.org, jszhang@kernel.org, dfustini@baylibre.com,
 yifeng.zhao@rock-chips.com, shawn.lin@rock-chips.com, chao.wei@sophgo.com,
 haijiao.liu@sophgo.com, xiaoguang.xing@sophgo.com, tingzhu.wang@sophgo.com,
 guoren@kernel.org, inochiama@outlook.com
References: <cover.1713257181.git.unicorn_wang@outlook.com>
From: Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <cover.1713257181.git.unicorn_wang@outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TMN: [T9VZIN5pAZNK1cBSpDz4a0hEOzVGmoBw]
X-ClientProxiedBy: TY2PR02CA0059.apcprd02.prod.outlook.com
 (2603:1096:404:e2::23) To MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:138::5)
X-Microsoft-Original-Message-ID:
 <9d86721a-8872-4d95-8f91-66237e2cbdb0@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MA0P287MB2822:EE_|PN3P287MB0058:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a93bdde-6dec-4483-08cd-08dc62aadb97
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ruGKVhFNoOidYrsHbZQlJy7sjV9ETYAOGIO3w4aCdAWJjWoywPiQ3f7Hy/z4Ivb4J52mztzq2aw2owk6Y3MvnUs3Ta6My0GJVNJ+sW+JfU0SdiSYV44YjwNW67xU/0g3QI4u9GecZpfpB7qEq4geHWNE/ze509w3xDy8b38MowYMo2dZ/NymyqOorFUKETNVhlIlRrgU2DDD0JCOoPh4ZdkImuYMQYT5gcd3nxvkrrGJ/y3bnzOjOGFYQdL21j0e6U0/Uk/O0YFbbHIhkmX2a94NQeoYmgzt9zlaD0sCQnQaKvE8AIRCEGcFOt0IYajUizyaHTrQiazWsKtsSOvoA1F16P3yRanXFWhlswOpbGZzyb6De8CJfJgBfJuYrqE1Ca8I2DOSwJ3+zaYJk37reyXfTTG5Tws260eb42BkrLMoPpv+qs2Tk8UEM203qn6CLuAsOcznvRkE6Cn4KuB+jp+LgLubOMgjm1+jSC/406AgJcrfKxfp5lJKemMueZgZ/FwoBbCd+nXqUQT8HOKadn1eda31KVuYufIUWCDJGD2tJKXIrsr/B28XwsMKfktGS+EYpg/WfQEORBZoaybF5hij1+T/INnRnZIy4LUCNDN/M93tzT4rqVy1AuU8o57/w/TyJxbr93L3rXJZHZUCUDG1eB3QFpc8OmA4Iy5wj1MrmjuBFmtg9jVmZHjRElws12BDUqz6ANPzXYPHRTp6zA==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d1FvUmFLUktFRjloOGFxZFRLZmlKTjhKeXJKUUdKME5rbjQ1YkZhWG1acGxi?=
 =?utf-8?B?bmxIWGJYUVNIU3JzOW9MR3lkaUJCTzV1RUNLTGtVbFk1N21pamk2YlltakJs?=
 =?utf-8?B?NmhWWU1vSVFWcUV3THU2ZnNHSlZLRHNmK09HeWFRdUtVbFdLamRJcjc5SFpC?=
 =?utf-8?B?Tm1SWDBmdzQvVzhVL3ZqVnY4WUdWMWFNNFZkSHVOeVd3bUhZZmhXRGxUbEM4?=
 =?utf-8?B?QWp1cFE3cVVobkl5dmxoN1J2eXdKWXV3QXc4c0h2UUY0SEdyMnYyYlJ6VnA4?=
 =?utf-8?B?NHl3T3ZZbklQVTdvUjJPRFkvdUg1RXVwVTlzbDNDME5NRU9ZTG1kWC90SmMz?=
 =?utf-8?B?ejhTZitacUh2RWwydlp5YUpWUDVyTythN3FTNEhNY01kWlV5R0RLTHA2WTRX?=
 =?utf-8?B?SVhxNCtsdXVUSGUwUEZSd1FuSDBMYUMwWDlwMUxMYnVrT3pNem1TQW13Vytv?=
 =?utf-8?B?V0xINHpJckNMQ2k5UEprZjhnR21WNVVFRlczdm5nZVptVkdjSzQ0ZXhSZnlq?=
 =?utf-8?B?cjBoR1VyQ2FHaitPc283aFRwdlZ2REYrOUhidmlUUkMxVWlMVGpSNFYrVDhi?=
 =?utf-8?B?V0NnYnZCWHVXeE1xQ01KTUZDUlRTeWJrYUdjZUk1MXFNaTVyckJ3WWZiSS8y?=
 =?utf-8?B?SjJqWjVETHg5S0VuNlEvOGJ0blVqUWZkcjZHTEQwVk9vWW03ZEQ4WHkxN0ll?=
 =?utf-8?B?TTd6TVdTc2dZbkw5TWxwRGFuZ2VQeDZYNTlURks1OE42TUhsdFc3UFVGSFNk?=
 =?utf-8?B?SHljaWIwM2JUbXhPWUZrZkg5K1N0UzZzemtoM3JVbXNHdXhlSXFjL3hBWG5P?=
 =?utf-8?B?Q1JHN3dVVzJ3R3pZVWd2QWtKQzJmTTZabHgwMndiYUYrTDQ0N3ZmTm0vMWpt?=
 =?utf-8?B?NGcza2F4V0l2Nk8vNVkrbGpkNkFYcnNodE5EWkhJczd5VjVpYW05blJsalFy?=
 =?utf-8?B?NVBtNXdOeTFkNFRXeDNDTjArWHhXN3llLytFZllzNVJtR3BRbHJsQ204a2pN?=
 =?utf-8?B?SXM0M3J0dVVlWlMwbURIUFBFMnlUR1JGNlFQazZqWlFRYkl1Z2U1SkM5VlRD?=
 =?utf-8?B?QnhXbXc1eHhjcGRvV21nMGlROWN3NTJNdmFhc25yM3U1aEhTTHRQaFB5U2lC?=
 =?utf-8?B?T0RiMjNsL240SWY3TG9Ka3R1ZkdlamxkRENrWmd0UFBUU044QjM2eHhNRzQ3?=
 =?utf-8?B?SG1qbmsrTk9FUkQ0MnF2RnFPV1lzVmdLTW1TUTV2YUlIeGhXWk1rTE9nMGov?=
 =?utf-8?B?SWJlU0kwT2hVWGM1aHlnWGFhRHFrT084QUR0ZVBFZUhrOUtWbVpLNDR0b21y?=
 =?utf-8?B?L2lic25kYjVpaVQwNWVtNEx6S0pUTlBGbS92MmEzV1Q1WXlPNUZFQVNBUzJY?=
 =?utf-8?B?UTBvQmQ2UjRjQVc5c0FvK05oNkJKZ1FoUUhhUVlvTVdaWHFaRitkRWF0SHow?=
 =?utf-8?B?TGJxUzI1TnRwWXJJcnJFYW5oRW1mbWdWV0tzRGdmekNKenlrb21RanRRYmQ0?=
 =?utf-8?B?R0U5dnl3aE1rbVpJUDBwS1E5eTUraG9Id2dabjRiV0RuZmVqaU5HK3pLYTFJ?=
 =?utf-8?B?RjlMVVZNYUFJSHJYOEcrUk10dnpBd0pZWFNNQng3WUhEc2xaSERlRlEwMHpO?=
 =?utf-8?B?bklyakd4RnliZ0FOQUtkR0MwVVg5ZzQ2d3ExOEk0OGFUOUI2cS9JZEpuZy9l?=
 =?utf-8?Q?9moUgEL2zxxCTCwjBbv1?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a93bdde-6dec-4483-08cd-08dc62aadb97
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2024 09:01:55.1188
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3P287MB0058

hi， any comments on this patch?

Another patch [1] has dependency on this one, so I would hope someone 
can review and comment this one first, thanks.

Link：https://lore.kernel.org/linux-riscv/cover.1713258948.git.unicorn_wang@outlook.com/ 
[1]

On 2024/4/16 17:43, Chen Wang wrote:
> From: Chen Wang <unicorn_wang@outlook.com>
>
> When I tried to add a new soc to sdhci-of-dwcmshc, I found that the
> existing driver code could be optimized to facilitate expansion for
> the new soc.
>
> Thanks,
> Chen
>
> ---
>
> Chen Wang (1):
>    mmc: sdhci-of-dwcmshc: add callback framework for expansion
>
>   drivers/mmc/host/sdhci-of-dwcmshc.c | 185 ++++++++++++++++------------
>   1 file changed, 107 insertions(+), 78 deletions(-)
>
>
> base-commit: 4cece764965020c22cff7665b18a012006359095

