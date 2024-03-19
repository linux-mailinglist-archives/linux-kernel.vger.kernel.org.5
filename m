Return-Path: <linux-kernel+bounces-107678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A4D387FFF7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 15:54:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0185A281C95
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 14:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC7D06519D;
	Tue, 19 Mar 2024 14:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="CokfzMWl"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2113.outbound.protection.outlook.com [40.107.93.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7921E1F608;
	Tue, 19 Mar 2024 14:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.113
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710860069; cv=fail; b=c/oopKlCWePhZnlsWgevdN+Lu//5CP6VnywxKuemARMZSL2bZAipKLYyYQZ0tR0QkZM1rOpiBj0BNe0g6FyKNAI9x6C+L+Ze4Kod/J0lACTgkGgdYnYa/3fQPtMSHdj980gru+6yuV7zyFRIBaL8KlU/BUf6NrNSqCebLpdju/Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710860069; c=relaxed/simple;
	bh=LEGHRBc1x31SCTNslE3f5c8b10M6h7Gwl/vlYLf1qIQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CRjJna/DLanoFH+UZTMQhFcQ/LuWMpWOzEnztKkcfWCFd+S7W9hJ8h9ZxPgdDYV3zYcFFQnM22FJkDIcHpksqIuidge6zgCjpWM5oup4M0CxPAJ1cwYF+H7iMB78gI7jWIz6B+Qyt1jURc9ZM/G0Z6LtKapMBwSOHqxhNScbyNo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=CokfzMWl; arc=fail smtp.client-ip=40.107.93.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hmSTEZFAfREPUlRDwz+7d2ym9komCFOqZ1QvGN7U1tnZs/IB6wo2J8yBiE11/hbZTs+F5ulKy+LL08C/5HRG8CamBKoutdzNSOb37eufPYh22y8CcVtXTeHJoKiv2bWN5zmAQeD8czRfoaoaUMiAhIBLG0e3aMGP51tDQQhzLAZsUSEpVmfeuO95TWW38McoDmGIUuTF250pT6FtRzX1jLko5tUo4jw4gveqCqGPxUcKiyrykbgiNFsMGK5Pwi5iGPDDVaxLSfBUK8eTZxh6LHXVLvPWbtzY8ss255CY1WMbMgZ4zWlxucKncwo5/O1K3X6QV1ry8yvTLVtfQWyU6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2nisB9bKJWVy0DVODthEHHAP4pym85K41o+lvCFCOto=;
 b=QirY4RU5uOhoQW5Eg9ZBPmbHuzjZOFx/J5jFXsoWsaPQAzytJc3sf8dGoB6HD2Ux3CD3XvKQGQiFQ2kPo0NaLLwvY9ZXdDFVGE10+hquv8x9gGOo9u55Qw8tPk8ze1lR3nnSdefMOQhmsyDAEVsvYhQCB0I+/VCgw5tk2Znri6Nm6HRpT5UZ+WgBgbtN1JhstekGWVupf+iGpUMmA3jxR/eGx5c5+QgBrFfZ7cnMkZUHHsA8df0PSl2nIztzlyhnyUzSwiW3qBeqBdL1HtcBVYJXm1IG6GItoHd4+BI7vsA6GRvN7Wd9MgqI0bYY+6dYPPQqlyAzek7F04MXob52XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2nisB9bKJWVy0DVODthEHHAP4pym85K41o+lvCFCOto=;
 b=CokfzMWlWkIoUvXWbVH5OeFIcts33Y5s2QDGuq6/GNGc8BGSkgM2IMVRFwgSbikHCqT9gxB7P8ruoysH1OMf5AvKuOJ5Cv2mAYpDlWdGQpsCEBFysMmY/V5TFC+r5vaEpDGXpOXwXnfPvUv9ToCSypoQZBVc2RZIm2UvwpJIz/4=
Received: from BL1PR12MB5874.namprd12.prod.outlook.com (2603:10b6:208:396::17)
 by SA1PR12MB7365.namprd12.prod.outlook.com (2603:10b6:806:2ba::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26; Tue, 19 Mar
 2024 14:54:24 +0000
Received: from BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::8b3e:57e8:d574:309a]) by BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::8b3e:57e8:d574:309a%4]) with mapi id 15.20.7386.025; Tue, 19 Mar 2024
 14:54:24 +0000
Message-ID: <927c02e6-70cc-4af1-8e46-c4816583a3e7@amd.com>
Date: Tue, 19 Mar 2024 09:54:21 -0500
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v13 2/4] dt-bindings: remoteproc: add Tightly Coupled
 Memory (TCM) bindings
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 andersson@kernel.org, mathieu.poirier@linaro.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 michal.simek@amd.com, ben.levinsky@amd.com
Cc: linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
References: <20240311175926.1625180-1-tanmay.shah@amd.com>
 <20240311175926.1625180-3-tanmay.shah@amd.com>
 <84923a4e-6c8e-45b7-b7a8-1a4deeb72347@linaro.org>
Content-Language: en-US
From: Tanmay Shah <tanmay.shah@amd.com>
In-Reply-To: <84923a4e-6c8e-45b7-b7a8-1a4deeb72347@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0501CA0061.namprd05.prod.outlook.com
 (2603:10b6:803:41::38) To BL1PR12MB5874.namprd12.prod.outlook.com
 (2603:10b6:208:396::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5874:EE_|SA1PR12MB7365:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	7tlKVuoTyHIkF9wj5vSoebcxjwJ0kI5urX2k3xdpwMJ2mRhwxMJRKNB/RQUignwnGog4PuIyhPisqKNkK8BUm/SV7ZY8Tv+/4g1L7eq5SZ3W6sNRd74ySSgBnS+3XRihc0w5aJUtCDq7VLUDkvECOZQdqiqhvWcNAyFqQgMoP7wz2U02yL7LIU17wyfjDqSbMZH5UXmG/YmNKrETZ/tbfTvCAkpes7xbswja/kyij5wgsarDeG3u9/zGetpBntX6Ou+uunWNhsFVvB4dUruhtaEzPa1aiG29B6ZC5Mvp/WToa9vfGWT/A6cqPDoSOunjr37sLcdUkn81qP8+kdjfscBj2Gfqc6HyvKEkZpiCzaS5LQS5NKDCEb8weS/b2L6RkjZ9F1cydvvcc8s2nJ0kgGI4LUVWwWQURKhw0HYuEawHoqtTH55ZGanMbj9zttXvrMJ7/8iz2uar2XuGg02OCWl1gi+faKz4cM2/KZ7NZlWkpgcSS3pTCLA3wo/TzDro6WIpnlZpyyL47qwCxLC6QaX0KHoz/Nf7F4NCrbsmLyHSnI24BkQ8hFULuQ5zFR0DYQ6ntXNoHW2HzKpKSCl9Grk6zYhftsMetJDsUK/m3CTmXfAzW40XbrBWfHHu769bLHpxNxeyFTlPMIZjDB84Ew==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5874.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(7416005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YkVaUjFLd0hVRkorb3lWZWYzK0xqUDdaM2MxVzVGczdselpBUFNRVnNISFJQ?=
 =?utf-8?B?TnFkSXozT0JxRVZIait2dTJBeUdLQWNtV1lkSjVMOWFtM3FOK2hoMStweE1F?=
 =?utf-8?B?cVVCaUVVa3Z0U1kyVmpQcXRjWEY1RWIvM1FaUUlBc1ZyL3Y4YU5oVGVRelJQ?=
 =?utf-8?B?dE5YR0tFRWJNQmxsSmliNUh4NEFndnhDblpVR1cwMklQM0hTNXRJUTdNVytT?=
 =?utf-8?B?cFQxWlJSTDkxcEI0QTRXYUVOYVNQOUJ5RDNaUWVGMjJqbkNHUmlQbWR1Y1k0?=
 =?utf-8?B?dG16cGdQM0ZwdDhVYnc3Q283K3VMRjUwc0RMbStNcmxWMDNKOUltb2hLNEx3?=
 =?utf-8?B?S2FNZmRyWFlzQ0NiOTJZenR5VVpxUFpiZEdYSUErQk5GTTZ2ek1jaFh0RkY0?=
 =?utf-8?B?aFlYcHZRMTJ2T2I3dDI0MTRPVnlJMHAzM2FhcldLaVc5L29qWlhWNkNIaUZ5?=
 =?utf-8?B?RlVPSFRhcWZVY1ZOc2ZBUVRzQjU2RGJmMmVkM09QSWRoU2dvVk9HYjZNb0tB?=
 =?utf-8?B?cFlPTHBTM2pob0plc2dzb1QyNHhPUHZidlFyMEFWN2pBWlgwUm03OTZuOWZw?=
 =?utf-8?B?QkNwUDVyUFR4dUNMRWl4OUs5RW96Vkcxa3ZVOUNIR250NjN1SlM1WWhSZ1Vw?=
 =?utf-8?B?bWZuNEVYSzFrZHdWeWZEM1ZORWd5SUtzSlMwc00waERBVUFkak1uY1VLcC9Y?=
 =?utf-8?B?cCtpTGkvcG04TlVmc0NOQnF1V1ZjaGloV1dGeVBjamsvYk1uRzRxRjZXY2hR?=
 =?utf-8?B?ak9zTm96Tk5rU2U1MGQ1RFlmWHVnTXk4bnQ0aGs2SGJveGVKbW93dDVsNUw5?=
 =?utf-8?B?UTNUbURRcm0xOEkybmdob2lzdVY0UkpzN0pkSFE5Y1d2WHZtMHJ3a281RVFs?=
 =?utf-8?B?K01iQjFvUlRzK01pWVJRSVd2eWRqbTlnWXdjS0liWjB3NHdHTXVqWFlhRHYy?=
 =?utf-8?B?Zll1RWM5WmxKbzZ3N2FFdEtuZUFKRmYvclVwK0pTaGFiVjlNQWFrelE1U1hM?=
 =?utf-8?B?bHIxOG5haDh4NzB0RThaSzB3N01JVXM4dmJNejkwanpRVDIyWGhHSnFYVFdO?=
 =?utf-8?B?MUY5ZndRemVpdFRVbFl3dnhEUno0Ym1OWWprS3RrSnBBblNHazJCcXhGUi9t?=
 =?utf-8?B?QUhHTXdPL0lXMHFmbTdhL1poTTFTaE9OeDBteXpZb1dQRjVnMC9PNGM1anVh?=
 =?utf-8?B?cjllZXFHRzZnazNySG9WWXc0cjk4TmNMZjZlckdNUHJmWVJhREtsaWg5VXFQ?=
 =?utf-8?B?bVAvc2pySTBySDlQWVozTHkra1lHekdaeXliV2lUcEp0eXV5dklMQmNUYUV4?=
 =?utf-8?B?Nm8zWUFEd2lRazZZS3hsR05yVzNnR0tKdmlXUHRsWDI1dmtleVY3N0ZNZHpx?=
 =?utf-8?B?RTJFVzduK1NpL1Ezd1Y3UWlSc0w1Z1hOVUZGUGluRCtheExkUE5FWFlZMWZD?=
 =?utf-8?B?aFFuNXFCdUJpVGZVUVdVMFNkajIvZlBkOVppaitnR3pGb3BNNlhRbUFpdFFE?=
 =?utf-8?B?V3ZQaTRNYk1zbE5zcFFVSUJWOHhOck1aOVp4NUg3OTNCYzZDQkJrbFppTGNS?=
 =?utf-8?B?Q3hnaHdKUlZOcFoyZDdQRUFUdnRnQjRESFI2NVlrQkQrTkRTbVVSVlU1dnFP?=
 =?utf-8?B?ZzJsSS8wVU1RaGlmcGJlcGR5TmZqTWY0NnVodVBFd0JkVXZ3cldnQlFkb0w0?=
 =?utf-8?B?SC9tZDUwV0dWcS9JODNxM2hUVEkyOW9DOTU4U01lb2VpVjlPUHVDNHcyTzAz?=
 =?utf-8?B?NUwrWTBHMS83SkFqVEFKMjhSa1R5a2dETDlJNGVpendQVG1kZXFLMDN5RnNS?=
 =?utf-8?B?SjlSSVd2RTJMNC9SVVM1eUtEOWxRdGJtNy9ibU9oK3c4dXRHSzhQMFVkVFo5?=
 =?utf-8?B?SEdYYUY0T3paYUt6Nmg0VDBmbHZVTHZHdVhyM2RGS0YwOWdOWktJSEV3MFh6?=
 =?utf-8?B?bCtnTEtwNVN6SE9DYTFXUHFRVlpqRFN3YjZjbzFXKzQvSHhkdkJpT1p0TExa?=
 =?utf-8?B?ZHhXV1hzUnhPeVljR3NCSkdBUFQwOTF4bDF3dUJxZVYwMFlON1UvcjlQQUxu?=
 =?utf-8?B?VXZab25UNGRPejZlT092QWtKa2U3UE1WWWNCRGc3S1FXejFpajNUMlJ0RHhO?=
 =?utf-8?Q?Un7Fiyd2hIDm1pYg1bhPQx4Lo?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5031c4ef-22ce-48b0-4a9f-08dc482477cb
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5874.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2024 14:54:24.6884
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yUV0QoYmr+bJXvlAQe79MlEvGmnD+kBnyjfpYzFvtS63vU0eGqIex7rLBP36Uork
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7365



On 3/19/24 12:29 AM, Krzysztof Kozlowski wrote:
> On 11/03/2024 18:59, Tanmay Shah wrote:
>> From: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
>> 
>> Introduce bindings for TCM memory address space on AMD-xilinx Zynq
>> UltraScale+ platform. It will help in defining TCM in device-tree
>> and make it's access platform agnostic and data-driven.
>> 
>> Tightly-coupled memories(TCMs) are low-latency memory that provides
>> predictable instruction execution and predictable data load/store
>> timing. Each Cortex-R5F processor contains two 64-bit wide 64 KB memory
>> banks on the ATCM and BTCM ports, for a total of 128 KB of memory.
>> 
>> The TCM resources(reg, reg-names and power-domain) are documented for
>> each TCM in the R5 node. The reg and reg-names are made as required
>> properties as we don't want to hardcode TCM addresses for future
>> platforms and for zu+ legacy implementation will ensure that the
>> old dts w/o reg/reg-names works and stable ABI is maintained.
>> 
>> It also extends the examples for TCM split and lockstep modes.
>> 
>> Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
>> Signed-off-by: Tanmay Shah <tanmay.shah@amd.com>
>> ---
> 
> I responded under my reviewed-tag, but to be clear, also here:
> 
> This patch has is not ready. Please do not merge.
> 

Glad we could catch this before merging this.
I will wait for your reply on other thread for refactoring.

> Best regards,
> Krzysztof
> 


