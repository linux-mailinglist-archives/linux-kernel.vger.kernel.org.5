Return-Path: <linux-kernel+bounces-118049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D580F88B2F4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 22:39:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 056941C3B7F1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 21:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4E9A6D1A3;
	Mon, 25 Mar 2024 21:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3WKlwkGC"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2100.outbound.protection.outlook.com [40.107.93.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6051533995;
	Mon, 25 Mar 2024 21:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711402791; cv=fail; b=g0Ztq4BgeDKzohiDHmNZoLPK90cIaOPJ2dkyaPQlC/jY2q1UaOwbwIs4qjSBsJ/sSbftSkLvYzRUvVZM7BSWllKFpsJ1AUTLr4xoZvZAwFeJID94kuilw0ldCiF26lvMA249yGh5mQxZgW6ZK4wrJTJLKISIg3Z6DmS13VbNuBc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711402791; c=relaxed/simple;
	bh=UOyN2XCphWrltgCcsw6aLVdqps9kZDNvWXjr1W295wE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SUGkCNDEC8uLdYka2EMpQDAlbAZP79uQDXZyLHCmrFDDfKB28FgnucR/RAAcGgsY3O6vdVuyeQduxuOwRF4P0dj3pQ0ziLQ0jdurBeZFBeumwscG+8RNBNI1ppjEtsWiS3GN2RRUo6eJ1+RbhhqdBrmpQzV7jT3/8u59UCVrwZo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3WKlwkGC; arc=fail smtp.client-ip=40.107.93.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fy9H8ACHbLiEj9UQ8rp0OMqs2JLGxg0bWZctNsGvYKou1E213vhMHBraR1OJ6i4ghZMRYCWM1IV5v+R+7GOEvoGInImytXXAgjbXsnUtnwHN1d7P0U0KqdvrokNbRhV24/vA+zlNF0bKYs9m9n70p/pletCUQ/jTI7Y6z0ICNI5YpKnBqn00QR2ACLffCmYaLVWzPJpTJUF+Qm5Ku0O3gXrMLqZV2W3ColbdxJ0/Y4H39RQk4Trd/J8OQ+/BqB42MN9cTpqa/F4aWbQdSa8hhPZWdtxzFSlwhCHp/y0ICgYIvZR+oxp8VhUIhMCWBBdaxu+oA9ZMAHcOMF3VJcejjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ez3tCYahYG/cfMJVPjht51UrHX6gc07hbGEnocM1QhE=;
 b=Hjo0McWhTmujs+JQgVZTVuQmSRcpT1cByqamZTy0wDOom9F87pemTUn9YjEq90gbAHwtDGfn3s8OfTyXesHh7t7EeRUsXXfo4Tm7Az5/vd2sAsGA2n76pDWDvooWkkn2DoxKrqnEJwG91ihaRrDDR/WDvmOnGEElyDFd+D9kzjNJwSD5IbK4PIZ24wLsYi1fPINU/+hP4cbhw82reS8Bgt1RghLv7KESv5lwokyiaHN5anopYF8g8w2hrFA8zxY7E8xPovQdOjmISlbTcSAQJNEG5KlSkvxssqW3nAU0CsPwCKK2Vh8yQeB9OqLoStJ3p4FCrcfAHTZx0eTKaae2Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ez3tCYahYG/cfMJVPjht51UrHX6gc07hbGEnocM1QhE=;
 b=3WKlwkGCx3SrmapOystaCqENBTHUNxG8rq8qVZsexkcdBtldrgWXgGA5ep1Gbs0mZd+rXzWQRdD5bqnw80cYu8VGMAnQmfWxd71KMdBlswjC8t/DKsCUfzMhYxOk9MHCPUf0xq4vXfm75pbUReUJ1rOvX3+Wmsd5NS4p5j4+iPs=
Received: from CH3PR12MB8403.namprd12.prod.outlook.com (2603:10b6:610:133::14)
 by BY5PR12MB4244.namprd12.prod.outlook.com (2603:10b6:a03:204::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Mon, 25 Mar
 2024 21:39:47 +0000
Received: from CH3PR12MB8403.namprd12.prod.outlook.com
 ([fe80::aaa1:af99:e0e5:7f14]) by CH3PR12MB8403.namprd12.prod.outlook.com
 ([fe80::aaa1:af99:e0e5:7f14%5]) with mapi id 15.20.7409.028; Mon, 25 Mar 2024
 21:39:47 +0000
Message-ID: <16cfde5f-c198-4dc5-8e67-fa7f4af7e2cc@amd.com>
Date: Mon, 25 Mar 2024 16:39:45 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] Update mce_record tracepoint
Content-Language: en-US
To: Borislav Petkov <bp@alien8.de>
Cc: linux-trace-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
 tony.luck@intel.com, x86@kernel.org, linux-kernel@vger.kernel.org,
 yazen.ghannam@amd.com, Steven Rostedt <rostedt@goodmis.org>,
 Avadhut Naik <avadhut.naik@amd.com>
References: <20240126075800.1174583-1-avadhut.naik@amd.com>
 <20240208121013.1946ef7f@rorschach.local.home>
 <9e68a369-2667-4dd4-b715-ca1e13948a8f@amd.com>
 <20240325203147.GIZgHfM6yqPbK2YLOl@fat_crate.local>
From: "Naik, Avadhut" <avadnaik@amd.com>
In-Reply-To: <20240325203147.GIZgHfM6yqPbK2YLOl@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7P220CA0022.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:806:123::27) To CH3PR12MB8403.namprd12.prod.outlook.com
 (2603:10b6:610:133::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8403:EE_|BY5PR12MB4244:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ZPZX5vLkJvI9m7oV8m0ze7Eq6oY8+6ZMvlrTVNfEwvPTf5WlZ1nVibB2vSx2xhlQ2ZVvXR4OyMTLWmQ8IjWQOMu8tniG83y4A9zl3vZs+3SCHSOXBkOGgbERmgLUZge6VTBWjwGg5fINd92R7fDDdENLrM4dEgNPlfAMq2gWKcjvfmMO3X+ca8lT5sKA7LozmiMjbHwDkgUAwHQF6v0p4E8e7md5eHe7AhtypNoF71XTDKze87rYZM+PsFmUgvUEBZyjJm5D6+tnq97NWFovb0hKMvOL6DTN6/Vr6EY3Oq8EKDpmRe8XIhiM8YGGVLfSKfkhfHYxJaFXUhbhTx9eZjoLtVPcoSKvKilVBNmwuWj0kSLDmuwg0AH3wRyepGOhkaGQPkrC38jUSr6mORiA72uoMFipGouGfJoUrcJ4cDvawv7U8xnbAbWXnhKj/wIb2xGEB26U4ircbE07XV+KftBt3NA9FFzF+Bjk3rz1CRnsgCAdo7T53hFNRNiAFu284aNORTVEvweXo1ru/WaCjHn3UP3SpmOMzI5ALyv2n4H3LUPEhpuYZbUupuiMK0HJMmJmOFx6zhmCQdXKBK0mSVzV8wJyU0jRi17Y7co3+4FXWglEYNBVwf5wlSHEkUNwLm3PHYuL5Pw1fFLZksp8HXiTwTmreNJzfpHZRUV0Ef8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8403.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?THpNWmFoYTdtOUVtWkxnYTBUNWNrSi92Y1pUdlMwSkhOMkF5M0R1V2dodXJk?=
 =?utf-8?B?TmV3bzFzcDlwbjd2RWd0RTRCU0s5N2xZUVluQXBLMkJGQVRETXdQWmhkQ09O?=
 =?utf-8?B?T04xTzRVRUlRK28rZkpXMWRQT3V2OGxuODhOc1c4ckJzWW1ETnZ4UkRMQnpB?=
 =?utf-8?B?ZVkyZ1N5a0Q5cGU1RWgvRG5YNGwzTWV1YXo0QnNxRzY3cGZFSWdxWWh4cG5Z?=
 =?utf-8?B?NGUrUmlwK2d1M1ZNbkNyYm5kZGxaYjV6c3BiVTl4R1B4NVBlVStFd2Y1WUZX?=
 =?utf-8?B?MEFvMU9TWVJoMkpPNCtNb0s1b0l6UzJoM0RORHp4cXBiRlNlWXZ4a0dqVTFC?=
 =?utf-8?B?c25qdzNsL210VWwxUDJIQU0xcjRhT3N3N2pJU1BVUG5neFFvUnptc3gvcS9t?=
 =?utf-8?B?ZHQ2a2NMaTN1OHRkZDVKWXlsTVEzOGU0UU84Snk5MEpSV0NBM0dVeW8yNk8z?=
 =?utf-8?B?a0V5cjd0RWdHZEhBcDRjUDVJbGNwNEtURjE2QlRSZ2tmSXgzQzQ3N1pNd0hH?=
 =?utf-8?B?UTZ4QlpGa1FCMU5sdFZPd2V4eTI5eVNvQWNscU1wS2E3M0VCR1hMMzhWaENi?=
 =?utf-8?B?NnByTzJxU3pxQXZnWkpwazAwOHE0eHVPWExlS2EvdFk2ZzhLNEZyMSt1NTdJ?=
 =?utf-8?B?OUYxRUNqa3RlM25pQ0N2M0JuM01IRHlTSitWNVE4R0JEdGp1WnhVTEFNa2Nz?=
 =?utf-8?B?Z1FKMzBkR1IrZy96YlRGbnVINDVPZ3ZDcnE5UmRJTTBvcFhXNDBzS3diVlk4?=
 =?utf-8?B?aHJYN2JMRkl6dEdhYU1ldEUyUUxNSnhlOFJhWUpwbWgybHQwdkxmTkVoWlY1?=
 =?utf-8?B?UnR1RGNrT1lWYVFLcnl1cEE5VDJvQU54bCtoK3VFQ0NJQ0x0UGZFOTlCUWFK?=
 =?utf-8?B?M3hRME1EcGREL0FCcVVTdzNiWlhpeU1ueXdRRWl6czBXRXA1MGFJZGsranl2?=
 =?utf-8?B?N25DMXVVRkkwaUJGOEUrYkR6elc4NmxTWm9xTERuci9Wd0xtb0RzMW5MQUZl?=
 =?utf-8?B?N08vbm9QeGVRb1ZPcG1JZk5sNlk3MExzcDUvcUM3RWpxdHlINXRIWkJVV2Vn?=
 =?utf-8?B?YlFUaXhxSTYvOGVqWWRIVE5ma203aUNKM0VKTnRVY2FCYm5ZWHFjRFl0a0po?=
 =?utf-8?B?bzEwSUY4RUVnNVpSTGdidncyNzYxMENXL2VpSDJ6WWpJNEVHTTRvYTYrQ1Vw?=
 =?utf-8?B?ZFAwY3hFdUEreTg2YmgzeVFVb2lHbEpaU2pKbGFzK3EvTmRUZ1FwRHBNSXJD?=
 =?utf-8?B?RUhFNERCNXdmN2lGRGorRnpzVzRMT1NKWXZMYWUwaTJwY3A0QVdPQlM2eXRZ?=
 =?utf-8?B?WkY2dlFhRDBJNXg1NVRmaExTSjdONFVGZVJreFhuT1NCN3hKOGZVY1Zhbm1k?=
 =?utf-8?B?V3NNeW93SnVGakxGZ3M5MTBUZ2EvN3JXMGNDQzliQXNYNTNDSkhNSFA5bldj?=
 =?utf-8?B?Vlh3dTZ1eXV4MkJ0bzBCOW1xbUNielpQQWoxUHVRVDdoVFk4UFVmdyt0K0lB?=
 =?utf-8?B?aXo0a0lSa0RaeGpTckxCeDNkT3BIbUZaWXJCdlFoamFZaGJxOHRtNWpPTSts?=
 =?utf-8?B?MkFXNWlvQVZrOFdjSnpuWTZhc09pTWttRXNBWGRwaEh3Z2ZUN0tjNGYxVEcv?=
 =?utf-8?B?SW1iZG9iWUdnaExTRCtXZ3JodDhHSEdHcGJEZUc5NmNzOUY0OVdXbnlRdXE0?=
 =?utf-8?B?OHJNcmZlWm13bUFsZk5CS2ZoclNhT2xQVVAxUm9pVkNDUkhqYWtNSGJHeE82?=
 =?utf-8?B?dkplMFJrNUI4aExzMkV2aDdhTkZ1MHI0YktTSzVRNk5ZMEZPa01RNE50Vyt3?=
 =?utf-8?B?dksvY0F1ZVAzc09HcngxS0ZaWjAyWld1Z0NtZjNnSFViNkhteUZzZ3R6SVJt?=
 =?utf-8?B?bkR1MGFQRy84KytGOHVPT0ZzUVhKSjJTejdhbkRXNlJYT1g3Q3doOG96TGZH?=
 =?utf-8?B?UE0wRWkwVXNGa2M3UmFOcEVZWDFNcmE0QXZONU9rWGdORHFXRTQ2Z0t4U3VI?=
 =?utf-8?B?bmxlekhuOGtyRkVXZkdYOXdMUWh2aEVKV3hZVHpndktsQ0pXQW1uNGJCTHY3?=
 =?utf-8?B?RGIxaWJLMjh2WXJSMTJYQ29uYmIrbUJyWWE4d3ROaGkxY2lSRmFLR01Da1hh?=
 =?utf-8?Q?rtfAOp5A9Zjp+AgmzEutc6qbO?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c573af1d-fd59-4df6-8203-08dc4d1417d3
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8403.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2024 21:39:47.5721
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hH/B7k+mOzZi2KMK9TXoJoMxOtLSc0C8UWO+7DZKVDbwLBaI2Xcm2tRGCXMQS4NTug0uIITRCSBDj8im89vXfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4244



On 3/25/2024 15:31, Borislav Petkov wrote:
> On Mon, Mar 25, 2024 at 03:12:14PM -0500, Naik, Avadhut wrote:
>> Can this patchset be merged in? Or would you prefer me sending out
>> another revision with Steven's "Reviewed-by:" tag?
> 
> First of all, please do not top-post.
>
Apologies for that!
 
> Then, you were on Cc on the previous thread. Please summarize from it
> and put in the commit message *why* it is good to have each field added.
> 
> And then, above the tracepoint, I'd like you to add a rule which
> states what information can and should be added to the tracepoint. And
> no, "just because" is not good enough. The previous thread has hints.
> 

Thanks for the clarification! Will update accordingly.

> Thx.
> 

-- 
Thanks,
Avadhut Naik

