Return-Path: <linux-kernel+bounces-153924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BCB3E8AD4F3
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 21:37:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3477C1F21434
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 19:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC583155337;
	Mon, 22 Apr 2024 19:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kz9Pw1bu"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2089.outbound.protection.outlook.com [40.107.244.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4034F1552E8
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 19:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713814632; cv=fail; b=kiAp7gVd5sfQsRLWx3BXll+WMzjnww2CmsW+n4kaquoFh5uPQz3vDGEFqSs2qJuQyBWj7bYIYrQelRB5JGMcAYnP4kFwWR6jUvSCDLPu5GXjYgBJIkOvY1hALLlBcsFOIob8Y2xi2d9UfibBytJsJYdghIowmEE1XfcNR3hJcxQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713814632; c=relaxed/simple;
	bh=NFwZf7LJdaiUgN4v0pM0Hs16rIrbCxVZp1xXG2joOwk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Gh59qgX+3vcpiS5To9AV8bhw8p8eK8levdCyPcaYtqsQ6vNsmG+OC9YelPGMaGcRL4KleFMub6VxSXJDFewQbrHILQDh/pfhV4DU1qms6KCPJ14MezNMjwKVawQiooggrMy4TGcwHkyjj0sIQ+73bDUrUPoqUy9TXw/uHKdc2lY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kz9Pw1bu; arc=fail smtp.client-ip=40.107.244.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Icg7VgJG2GQ80I1sASrrBFzrxIxQEGTIZWRk/hBO56n1kITY5IcYQBKV+GYEnCJFQB5l/Yyo2monmi8ciowoR8SFQ5vLNatEyOscqIqNAbNB/V+vdQm/5qa8mAXFBunLPkNzrN8UOK9JqVgoiPc59nvTAzRQKikVKg+HO1AAqvSl4W0fTFox0ddJJ72oQ/Vx45RYw949ycOHAvpavp5w1SJgTt2rNqEZAuHKgwYoktn4Qzc6FcMklqdwRKHgtDEoXBiNN4mWwCdt55J51A4CMAVFeh+p+ER+RDkiCJhwpl98o6G/s+pRyBf/AU5jmW0XRE2IcQBEmFm87NIqR5OJVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gCVrGyl3RgGGWU75Nqez2drmljWl/D1HbopVItdqpq0=;
 b=DoMCZ4vNAOrQpahI9ihiPlIL1tWAFsiHcEO12ag9770+iIJiwFuiNJj2LmrgD2OTCWYl2u33Vvi7+yBmxjwRIYuQR7HzhFdHJHfYNSkxrBmUu8P9LcdeR4jdsq/JUpCKhqPvr5NL1KTWDBKVexPHzUchUb7v/Rzqvdi0HpBGlb1h7SGpVpG6xYWBwnsNAyB72W31sQb1wFr2arMEF3+MOtQHqNzgMr/gKvNgYCjoLuTd46gkcdmfjMGrLMn83/qADqyKErXT6YUcvDqDqE7vU+AnrOybrfAfC5si8IVopPFMFuanMYchN/uMv2CBHAod6br6zh3+Erpp713eQSmeKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gCVrGyl3RgGGWU75Nqez2drmljWl/D1HbopVItdqpq0=;
 b=kz9Pw1bu52QtGqeeMcx+O7/tp0MMUi45kZqanrV86UyZTAGHybmhIP7oF4G8Kf8cXjttyCHtJs885NjcCypiGFTSfcfkrSpQ3R6dmDUmIdGiP6u1d0+9zO8n/UWJ/yauvP6rw3S89SOXM9B8FeoFw3qQCgxleTJvbmas2V+MJnN90Av+15CK67noEdOIz8UnO8U68E2m/lDvws04Zfur75JJoY74/tCCo33sgg9GNW8RZcXYzyujUs5/ikrDvd1JcvDIrTNjVuDb4CvYZN3LTkLXGIt0SzOQywhQ4n1WCNTk4PKYR/LQjap0BdGCsy/7PeidCoybeqQlBoT9V3CdSw==
Received: from SJ0PR13CA0186.namprd13.prod.outlook.com (2603:10b6:a03:2c3::11)
 by PH7PR12MB8016.namprd12.prod.outlook.com (2603:10b6:510:26b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Mon, 22 Apr
 2024 19:37:08 +0000
Received: from CO1PEPF000044F3.namprd05.prod.outlook.com
 (2603:10b6:a03:2c3:cafe::8e) by SJ0PR13CA0186.outlook.office365.com
 (2603:10b6:a03:2c3::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.20 via Frontend
 Transport; Mon, 22 Apr 2024 19:37:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000044F3.mail.protection.outlook.com (10.167.241.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7519.19 via Frontend Transport; Mon, 22 Apr 2024 19:37:07 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 22 Apr
 2024 12:36:48 -0700
Received: from [10.110.48.28] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 22 Apr
 2024 12:36:47 -0700
Message-ID: <da582eb3-1682-4eb5-869d-f984a484e385@nvidia.com>
Date: Mon, 22 Apr 2024 12:36:47 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] mm/huge_memory: improve
 split_huge_page_to_list_to_order() return value documentation
To: David Hildenbrand <david@redhat.com>, <linux-kernel@vger.kernel.org>
CC: <linux-mm@kvack.org>, Zi Yan <ziy@nvidia.com>, Matthew Wilcox
	<willy@infradead.org>, Andrew Morton <akpm@linux-foundation.org>
References: <20240418151834.216557-1-david@redhat.com>
 <18faa967-4fbc-4694-a7f7-02c3887ee6f3@nvidia.com>
 <d97f8fdc-eb38-485e-81e2-51f748089939@redhat.com>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <d97f8fdc-eb38-485e-81e2-51f748089939@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F3:EE_|PH7PR12MB8016:EE_
X-MS-Office365-Filtering-Correlation-Id: 70d47d83-3fd3-4d8d-f16f-08dc630398b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bVJTdHpuVndnbGMrT0pDenJTdmFMeEZod3V5S1dwSTZaVWg1OXJlbDBUYzFO?=
 =?utf-8?B?azlCQVdjWDdPOWVnVlpyNVMrZEFmSlg5WmtENGN1Y3BJblRsM0JHVDVPRVBK?=
 =?utf-8?B?dXdVdU5xdlV6K29oWDZFQ1phb1lTZllhaVF4dW02bW1WalI0VTNsM1FMY0ZT?=
 =?utf-8?B?eGRtUkxFbTlDU1NXZDVkYkg1MlVScnZ6SEdQTjM4b2lJall5eXZVeS9mWlJF?=
 =?utf-8?B?VWdIejErNHVmS3FiMDR1M25LT1Mrd2s1NzVJa3JiZ3BqM295KzBFaTNid291?=
 =?utf-8?B?SS9rdlpKT2JuUFNJMkRJOG5EMm4zaU95ajhMZHJjamdMdCtKZjk3d0hYbG9U?=
 =?utf-8?B?UTFoTFlBOHRINGltUzljNFd0cHVxem15OUdaRi8yd2FlWUlTaHEzUDIxT0R1?=
 =?utf-8?B?cXFWOGhwd2hkYlpqVUZaZ3ZjZmZ1Z01RK2h2dWZYNTM2VEdPSEhHN2dlZElh?=
 =?utf-8?B?R29zeDRuUTVKWFIrM1hTcXBkaEdpNk9yYUZQZXd3NXgzVzRGSDdpYVpmVFkx?=
 =?utf-8?B?SDFRKzVwUExMRnVldmFnbXBUTzE3RUpGMSt5YjBXZHdWOTZzNDIvbUNhUGcx?=
 =?utf-8?B?MkI0RmI2VnA2YmpyQVZUQ2ExVlJCbXNFYmd2Ump1am91R2poY3pDSE9jTmRw?=
 =?utf-8?B?WFkvNElCM1QydFIva2d0MHVpbVhQRmNRdUlINDFUa3Q3Y2NiUzVVV2VZZEE4?=
 =?utf-8?B?VVg5QkNYWCtVclVtVWkwNXE0MXlGT2k0OGVmaG8rdmgvckVuZmtFeUhmRUtW?=
 =?utf-8?B?WVNja2FzdkFoRnFZdVg0QlBLVnJSODhIZDZDZllCSDdLcGJEaDhEaUhOOS85?=
 =?utf-8?B?em4yaDlZdEYycEtHaUw5T0dETWVrMXpHR0NIVGs5UmpzQjNYQmt2R2ZFUnlq?=
 =?utf-8?B?NGhNb1pFRi9FOWpVWGhoeG1lNHhBcy9VNGIyZEJzVTJTSTdtKzZkVisrMmZj?=
 =?utf-8?B?eUJkNnVuWmRHNXZidUhmZmRHU21hNWJQSjJKd0VGalRMNWdHT09zOTFrMzhE?=
 =?utf-8?B?djNoZjRoTk8yczY1ODRUaEJXeUsrZDMxaXRJRVl5K2RYZFJHT0dkZkxId2xV?=
 =?utf-8?B?V1JaWmkvOHd1Zm5LU1J1eWtxZHhGUnBoaFJUVUYrTWY3RHRZZndOMmxFZ2h2?=
 =?utf-8?B?MGRWNE9ZZlIyK1dkMVRKT3hMUVE0VTF6VS9JU2FFaDdJYW9jeUFDZTJ0aGpR?=
 =?utf-8?B?b3VzZjlzek9mYlUzRDBUUlhlUlZTZVJDMm8wQ3BqWnFMZU1LRzRHaWxrSGFh?=
 =?utf-8?B?dzFBYXZpY2lDOFUyVXZrMGU5ZkJUa0pMeVkyUjBjZkFtbzlicGZGOUFLMTht?=
 =?utf-8?B?TC9CaUNTdnRIZTJ0aHY4bWxRUjJ6S3VMWmkvNVNubTJEOUs1QmZtdUk4bjd3?=
 =?utf-8?B?TSsxam9EbEpITSt6M2picUNUNktMMm1YeEdudGs2cWhiMHNwZCtIVzRuVXh1?=
 =?utf-8?B?eklsaUpVbXBkNjB2TzlCL1N3YmNwUVhmeTR5OHNFS2Vxd08xWU9qTTNlcE01?=
 =?utf-8?B?cUtkdjJvamV3NjA1em9CeEZRTnpDN0ZRYUFSTDdTWkR4RGc5Q2R3OGNKM2pL?=
 =?utf-8?B?WTJBZEtPYXZEaFVuTjlTNG44cGNVeHBUOUJtRVd5eEdXS1RWdUFQelJ3dHJB?=
 =?utf-8?B?Sjh2M2FuaFJteHlrOUgxelBPeXZ2dlByNUFLWWN4eGVrVFprU0JtZFIvbUll?=
 =?utf-8?B?YTFGNHE0U25PRHYvM04vRUJvQTJpdCt1elJGYXJZQm9ueVFRdVhRNmZHOU5j?=
 =?utf-8?B?b0dwMTZLemwzZ1ovWEpsZGxDdWUvTmMxUXVvTklLMjZwWHc3N3dIdFVlUk53?=
 =?utf-8?Q?r6PgRjZwOENzwxx6tKnOCxN6qVbXvV1DL4dc4=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(376005)(82310400014)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2024 19:37:07.6121
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 70d47d83-3fd3-4d8d-f16f-08dc630398b2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8016

On 4/22/24 12:31 PM, David Hildenbrand wrote:
> On 19.04.24 02:15, John Hubbard wrote:
>> On 4/18/24 8:18 AM, David Hildenbrand wrote:
..
>>>     *
>>>     * Returns 0 if the huge page was split successfully.
>>>     *
>>> - * Returns -EBUSY if @page's folio is pinned, or if the anon_vma disappeared
>>> - * from under us.
>>> + * Returns -EAGAIN if the folio has unexpected reference (e.g., GUP).
>>
>> ...or if the folio was removed from the page cache before this routine
>> got a chance to lock it, right? (See the "fail:" path.)
> 
> Right, that is sneaky. Let me extend to cover that case as well.
> 
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 824eff9211db8..a7406267323ed 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -2975,7 +2975,8 @@ bool can_split_folio(struct folio *folio, int *pextra_pins)
>    *
>    * Returns 0 if the huge page was split successfully.
>    *
> - * Returns -EAGAIN if the folio has unexpected reference (e.g., GUP).
> + * Returns -EAGAIN if the folio has unexpected reference (e.g., GUP) or if
> + * the folio was concurrently removed from the page cache.

Looks good,

Reviewed-by: John Hubbard <jhubbard@nvidia.com>

thanks,
-- 
John Hubbard
NVIDIA


