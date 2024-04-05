Return-Path: <linux-kernel+bounces-133685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F3C2289A756
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 00:34:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80CBC1F2284E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 22:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9906E22F0E;
	Fri,  5 Apr 2024 22:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="dWXAKlPB"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2095.outbound.protection.outlook.com [40.107.102.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E94CA28377
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 22:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712356450; cv=fail; b=RylZBBJ36pCI2Js9pL01Q6PoHJt2GfVeRmfLlN2FRZhFjTqIyAuG8YGSdarLbKY6fRnwOvu3YIfca80N8ePDVd9qzwyZl7GxlZ/iEeUKU2DXVgTdOyyeBrarsV+MkekVDZz0YFYqL0vlRNfDRDA7P2j5f3Bxnby5oNSo6u6SK9o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712356450; c=relaxed/simple;
	bh=Ms2f8hrkQbzgb6V6GopMK0p+0Jujl8Ar4uvd7ItlYYc=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 Content-Type:MIME-Version; b=pan5K9ZiZ62pyYdTa7H53vfRRECzdLbGPmjuVvzaoXyHEkC+bzL7z92hObGOpSLpJhzyamn0nUUJxfyK/eIyM0A8YvUebdScUIJInpHWApf3shFLadb15PCgipRGHH3CnBWb7yrVkwCw0nBbQlAEXwNgjZ5JcmEvu6iCmzJkgJI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=dWXAKlPB; arc=fail smtp.client-ip=40.107.102.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kk6UeMQueJ1uke65TfDq+4VUZ8gOcUxVQOQSlmP16qh9pJfWEZSLIySygXjX9Ikr+8uMhcPJBHd6uBgiKTqHr1hYUdJE1mJ/eZWxdrYD9sRc6ZpQkR5JNTd+Hh5yo3po/VIkx8BoBEoHIvOxiGSFqvX7JsjEnYL65QTwfYc6gATRoiEeZ0l+kAiFBpwIPPgHEStAJBkILQYqeG2Pk26HlFtayP03fq9vzA6xXOXWQM3SNUg0SBIrrisOxuQL/mUq+YFPmkJ9dXGHoMbh+n3THb5D6LMI7H76r+Y8uD6YBJUERwdJCvFZfYUr6RbcB3DGJzBVEgX3sLvnQB+tiy9WmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ri7Bjm5Ak7rZzmqwYXHOaYFPiCfQpIpp8bKycjpYpbs=;
 b=jURXflVNRJ2SSpspIENWeqGf5whdVtYaEvgw4ga+d9lQIgb/OoxSKCA6UZzv53Sqjj9MM0amzlSPCthKVRvQap7B+TDbOr4ol/ZHEKb2VGqHFvzl5TGDRzE5BvVQTDij4/DxxpjkgzQGxD4KKbQW9ycwe0IIaqgJofW06sfgEb2w2iXvuqWhTWIon91oV3lUHcad3/yutPJko/Q0W7qe58tnNz7UHfFRyXpans06n9Ui6JiNWYf9HR0N7phJYV3hdMbW3j5xIiHu/ypEezijLdBs9U6ozmygXiiZRKA+n7HbYDt6Bpk13SrwYN7xcU6XCkrpbnu7nP+XQi+nZEPJ5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ri7Bjm5Ak7rZzmqwYXHOaYFPiCfQpIpp8bKycjpYpbs=;
 b=dWXAKlPBhWDc3zPnoZyqK4oVc8kZNDtFIyd6mReMeDdmeb2oATJsxes7ggrJZ2dh+wXuBpxvWmZO3apkRlQY0XK3WN0hj/PbACszJotMOWlpAs7M5DIZj/v3qI/jvvejWU1xxrbv7jfsllv+dmjulF6MSy6ucOueL10MuqbbHdE=
Received: from BL0PR01MB4226.prod.exchangelabs.com (2603:10b6:208:49::30) by
 SA1PR01MB8592.prod.exchangelabs.com (2603:10b6:806:383::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.46; Fri, 5 Apr 2024 22:34:05 +0000
Received: from BL0PR01MB4226.prod.exchangelabs.com
 ([fe80::12be:916:b914:8b26]) by BL0PR01MB4226.prod.exchangelabs.com
 ([fe80::12be:916:b914:8b26%7]) with mapi id 15.20.7409.042; Fri, 5 Apr 2024
 22:34:05 +0000
Date: Fri, 5 Apr 2024 15:33:47 -0700 (PDT)
From: Ilkka Koskinen <ilkka@os.amperecomputing.com>
To: Robin Murphy <robin.murphy@arm.com>
cc: Ilkka Koskinen <ilkka@os.amperecomputing.com>, 
    Besar Wicaksono <bwicaksono@nvidia.com>, 
    Suzuki K Poulose <suzuki.poulose@arm.com>, Will Deacon <will@kernel.org>, 
    Mark Rutland <mark.rutland@arm.com>, Raag Jadav <raag.jadav@intel.com>, 
    linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf: arm_cspmu: Don't touch interrupt registers if no
 interrupt was assigned
In-Reply-To: <042bbb32-481e-40d8-a46a-472b724ec33f@arm.com>
Message-ID: <89d7ff41-ce2a-fd95-ebfc-4df914efd4c8@os.amperecomputing.com>
References: <20240307193104.58302-1-ilkka@os.amperecomputing.com> <042bbb32-481e-40d8-a46a-472b724ec33f@arm.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-ClientProxiedBy: CH2PR17CA0017.namprd17.prod.outlook.com
 (2603:10b6:610:53::27) To BL0PR01MB4226.prod.exchangelabs.com
 (2603:10b6:208:49::30)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR01MB4226:EE_|SA1PR01MB8592:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	xj3kaBSGB+VfZbbgeJ4kQb4cpbez0sA7Hgf+m9odcDFY7XoxdbEHTWi/rAzQxabYQGQV1jyJ06C47OT6Bf1/YYvJrhGVs7o+Tf4PL+HnIpCgOz72mzBL7BxqLdVZMpGRWnxNtoFmyB0NmKppyWJQn7S9w3JrIZxnwAkimX3jUV1nZL1zn5hcyTpimUFRQDibwsOhAsaVR5MCSCSTJ5T8n5CtC+yxVel6ROJOcw4SeM0ua3xi2uUZe7+OTMugrU1xSAtOaHyUHgjUbYr0odii9/NLvHxVp6B8V9Yb2pSDfZkr11Bw4HW8v9V/ezY5W6X5cMCdQCqtAOiZUMIvxh9Q3eZLuj2boUFWpHedncNVpuP0IqCy8lH1WN9Xkz7zPxWgpzV61tAHXdmZ/P9iiP4T828qOI/JeyVarNneuHScrk6bAYxmFU5zgQoBa85DBD2MRCCdn+KSo5ok4gNBVNIIytnr4dHssKMFq7l7iVOMxXpzNGn6pMk10b8Y6sNPf0D6GtmRg5Fa/2s7QSJSljKXNXtpJfFWfG7z4tDZ6DxIy9BeLJGKaP0oLJwG78/wE5PVBivcgKr6h7Uw7ULGNbWO3CUhINJlknS/eByOm50BUVyVG1hlqXPXhlffD5b4BtOUs5mUy+yc9kkvQQzet4Cc/mEZP+uRF6Q7xYUUMB1E3h99qb7FTbQwsxIrZolcLEAqc6Ijgp0aqimBnJ6Skfyyl/W3jKFoM5LlXvrZKRpoW3I=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR01MB4226.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(52116005)(376005)(366007)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?y6Iy+G2K+Amii6CzjZau9KTv96WLPUvnwPJYEG1L8bAl3LBwoAjZRbsrp7Ph?=
 =?us-ascii?Q?47XQNHvgk7qmvUBmP/MMgImzFcTQNGe1uPo/vtjWHWU1GTRacN10e+XUPHOs?=
 =?us-ascii?Q?UWOf9SUVVWD3kMTs7Aqqwy7KqPhGi69mKXQg37oXZVR1/s8LADE3dFHwSRhs?=
 =?us-ascii?Q?bMK8LnSdgkYSXanvB9xoMFJWE6DedR1vuqG/dSOv4SrHsH59ajpe/jZlOweO?=
 =?us-ascii?Q?i0lYX1RAQKWiLjRv34LQrPQWNGogbcw0uv9yxDbqmpBcTHlYn3B5/xzK+f3M?=
 =?us-ascii?Q?X6kC9IDabrbaaqUKMkgm4CB77+/uIGyEAB/7Q9VPifayiBk9gJMXtWTAribI?=
 =?us-ascii?Q?2K8zU/YHBNEJJIyMbofUtfVtZvEJ2VipeMrXkNe6pojBHJ+mbCVg9peETuVq?=
 =?us-ascii?Q?o5UKcYo3N854d7PIVe5fhwM8Wz/jcxm0rK/RvMb/ynJsxW2ZPGVx9oZeLXx1?=
 =?us-ascii?Q?7KnfhbL5JZQrM3XXTW2qO/Iw51A4TEa4cd/r8GFIZa6yDzUHtLmCDpISzjbC?=
 =?us-ascii?Q?tY/zM84nY5qpaKkOqnA7/d8/EA5fNaoR8wxAoIAM6PBcLe+3F9WeUjWO4K5v?=
 =?us-ascii?Q?vsCfndRr6eQTm3mUJ6hof373axz/R86aIm1xuk7LZmLm+v2ZzLyANBmnDmHC?=
 =?us-ascii?Q?GW1LkvnF3r1xXIZHL01lmLH1sPG0UncPObJB3d3eX3Hz3EtXtKCz7ovScyyv?=
 =?us-ascii?Q?7T/K4s39fdoN/hmlVlleOauF+C57/f3JigpAQTISz5d4GeTTslkCiKSG+VEc?=
 =?us-ascii?Q?PdzADgHlo4VtWYoFTc0LKo3eG6nxexFyEIom6aRP7MYyx3ODRcRDFzqR38Uo?=
 =?us-ascii?Q?HotW0FjBeORVpY2MsYtZIb9Mj7lKMqxwMQ9UcjEEYxXG7veAB8ynW2olAEZD?=
 =?us-ascii?Q?ifWKeXsemFCtL+0BVKxvPgItxlLCz8m5QaDS99rj46TNhI38zfo05pXgNYSX?=
 =?us-ascii?Q?GfV9T2OIEFZXrws6lRr+8Ydmjcz4sZyunoXtAR93SMQzdkY7p2TjL0wb8XJI?=
 =?us-ascii?Q?8cZmPqLAniycvKFnWgMpAJHoNgtEjsRW9Cpr0QCF4I8rKcwDmqegJobZ2SsM?=
 =?us-ascii?Q?Zb+m3OHIIz5fZS1Pj17leLr1gbwhAmLKEXruBjvEUk4eLowSqskc7tPvzUUp?=
 =?us-ascii?Q?R09q16W4W76mGQ6qTWBV/QgFC9TXIzT8gWaxicakfaCQl8AvKEwoeV73VIki?=
 =?us-ascii?Q?NaJEc4FUCqtUHZxkOC+pGoTu5Eo3h+rLmj6T0DpqV33rVFEw1n5WpQy9zpcR?=
 =?us-ascii?Q?uIFxMYC8g2XKeDqAg2PuY9EoamJzlIsrrLwPhhg0fssgRJfFZP0G8s6ryiWc?=
 =?us-ascii?Q?Hela4N4G29MYoeRfJZomIHwIfrwEWJttpJcC5JwO/9dmZYkiTWqH6i//82h3?=
 =?us-ascii?Q?S3wE8ThSUJL4G7tNsEX9W8MLBPHZYX0p8Jf9mSmmxk5I7jMYjocqVmGYVFu8?=
 =?us-ascii?Q?79S4XFbNt/eLMMm57vickajLCmRTG/5a1hxCFLKjNxJE/8e2TEeVsqnuPlB4?=
 =?us-ascii?Q?SUMGbvHI8jnKR2kSofrqf/8SbMpHk931lNJA5J+kLteRjEYuL8ABZDg3cdR9?=
 =?us-ascii?Q?AJ28yz15GrxEdG19LJL83aaiOpfzhrLBQ+GMaUp6dA1UMZrVk3pBUJgFcPmh?=
 =?us-ascii?Q?sVBNWg2IJrgAxeYSPAPjs80=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6279d660-4014-48c3-7141-08dc55c0802c
X-MS-Exchange-CrossTenant-AuthSource: BL0PR01MB4226.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2024 22:34:05.4450
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8cQ47uSaL8S2wmJw/B39N4qUgR4DYbNzTPlO0XW/V02a/qRAN1445Sh5YS8SksdMrIL9Ytj8EI9cEaXPDvTLo6r2MF0oFYMtEietMB/ElVNqhnrBB+5ZW30ke5lYfZcK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR01MB8592


On Fri, 5 Apr 2024, Robin Murphy wrote:
> On 2024-03-07 7:31 pm, Ilkka Koskinen wrote:
>> The driver enabled and disabled interrupts even if no interrupt was
>> assigned to the device.
>
> Why's that a concern - if the interrupt isn't routed anywhere, surely it 
> makes no difference what happens at the source end?

The issue is that we have two PMUs attached to the same interrupt line.
Unfortunately, I just don't seem to find time to add support for shared 
interrupts to the cspmu driver. Meanwhile, I assigned the interrupt 
to one of the PMUs while the other one has zero in the APMT table. Without 
the patch, I can trigger "ghost interrupt" in the latter PMU.

Cheers, Ilkka

>
> Thanks,
> Robin.
>
>> Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
>> ---
>>   drivers/perf/arm_cspmu/arm_cspmu.c | 6 ++++--
>>   1 file changed, 4 insertions(+), 2 deletions(-)
>> 
>> diff --git a/drivers/perf/arm_cspmu/arm_cspmu.c 
>> b/drivers/perf/arm_cspmu/arm_cspmu.c
>> index 50b89b989ce7..2cbdb5dcb6ff 100644
>> --- a/drivers/perf/arm_cspmu/arm_cspmu.c
>> +++ b/drivers/perf/arm_cspmu/arm_cspmu.c
>> @@ -795,7 +795,8 @@ static void arm_cspmu_enable_counter(struct arm_cspmu 
>> *cspmu, int idx)
>>   	inten_off = PMINTENSET + (4 * reg_id);
>>   	cnten_off = PMCNTENSET + (4 * reg_id);
>>   -	writel(BIT(reg_bit), cspmu->base0 + inten_off);
>> +	if (cspmu->irq)
>> +		writel(BIT(reg_bit), cspmu->base0 + inten_off);
>>   	writel(BIT(reg_bit), cspmu->base0 + cnten_off);
>>   }
>>   @@ -810,7 +811,8 @@ static void arm_cspmu_disable_counter(struct 
>> arm_cspmu *cspmu, int idx)
>>   	cnten_off = PMCNTENCLR + (4 * reg_id);
>>     	writel(BIT(reg_bit), cspmu->base0 + cnten_off);
>> -	writel(BIT(reg_bit), cspmu->base0 + inten_off);
>> +	if (cspmu->irq)
>> +		writel(BIT(reg_bit), cspmu->base0 + inten_off);
>>   }
>>     static void arm_cspmu_event_update(struct perf_event *event)
>

