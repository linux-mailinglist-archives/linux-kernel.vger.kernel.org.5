Return-Path: <linux-kernel+bounces-90250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0545C86FC6F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 09:55:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A0B61C2116A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 08:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5135237706;
	Mon,  4 Mar 2024 08:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h8UUb8rv"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA90376F3
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 08:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709542192; cv=fail; b=OECI0N3Xift/r5uCSu5s7sq6cC5PdjZ/hjr772wCERBbG4r4FkZXEjUqgnfM8bWhQbGpvDoXa4iFUhlMTLChKz+WGZWzxq5XtLULmYA7YySJmokGjmxYdoGwmBHnpzb9zvDibiX71iN2Qrf9MbRtqxzfTHz4J0EvElTpXX7T9P8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709542192; c=relaxed/simple;
	bh=uN/rqHkTjUmS6snCiPZXDsNLDRCdRIxQocEHOPsAF6c=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IDUlrdhI6hmjUHoLEvFt89kc4qzOLFpqQlqJiYTKqad1I2PXzTZdtdy+7MwfY+jB7SdzlVG4SONQd4w1SxVBg88zf/coVWsQsRGh7joN1fouUO4/SdjD0+6e+wifDQMvDXfHFAkxGAKJt65ylzs3kDoJcz95fEDxqGz03bfghx4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h8UUb8rv; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709542191; x=1741078191;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=uN/rqHkTjUmS6snCiPZXDsNLDRCdRIxQocEHOPsAF6c=;
  b=h8UUb8rv/ztrTPFGF4ifxUzR/N/GrwYHWaHH1wSsZDzpqBeKg81vdBQ5
   bwtVTQZMBRv1O6B817ygEONY2C0T57alqLkltCMLydDIn6/NZWbjpXvg3
   PLRr9IKvQx9rCwvVWMYTC67G4jdhW4Fh3KpHjEuQl0wu5Q3Mrf1Sh4sMP
   IR9VYpvuGAxPNFPIBVR8OAa6CkmphTen0x9EuPR4wf7dODiHadvb1diqC
   zBu47Q0d87bfJzD0KjVTtdomuWDdJYYSp+kpG3wrNK4GM2W6fKYjHggnw
   68xx4uJqSDLZ3DektrF5YTSQePc4lYShU6VSnVTrPVxrYy3rlsMXDJEba
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11002"; a="14601276"
X-IronPort-AV: E=Sophos;i="6.06,203,1705392000"; 
   d="scan'208";a="14601276"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 00:49:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,203,1705392000"; 
   d="scan'208";a="13426288"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Mar 2024 00:49:48 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 4 Mar 2024 00:49:48 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 4 Mar 2024 00:49:47 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 4 Mar 2024 00:49:47 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 4 Mar 2024 00:49:47 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W4/v2+xGnFvExN/Fy5n5h13uIEAyK9uS55VvJ+P/DCMcomfj00PpCjp5CUXQ9gZ6bN5HqaThJ7hLnXfN91892PzlQILL7VeN6KLZ9Oxcp82oAo+wZqdDuCDUiGsGs/8fnB8gzFDrVJuT1cbsjeUC0e6umL8cUobl6N41/pn8MkI/axu79XzlWdWZPpFZXHyu7DMBKcARw2NThcDKFBEedUDmOEbvQ6wwoOorloQ9gnxAAjVkT5f1G93Wv+SJ7fOvhp+lCy54qtaNjxg/f+upNJ8gnRkAgWdVPvdUY+FDyP7ZJuTluXE2l+kYdIUiHv6pcCUKmte8XQGax8PwdF1qWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZXcypMIXm/1b1C0vzUjo3DSl8azp/StMnkpOE9ib3x0=;
 b=hy3mSndfp+dvCQi/N6n5Y2bR1dEoHgzID2NPTW789dF3MjK6qtudvU1omGn4L9L8TPcc9qhlkSGX871lMixDW1zlPk8iPvFibmnJxKFnFoLxzJnkSmyOSSU74ens9yDt2zhcQusem8R25kpXk39JzqOlPIo9CK8XSvE0Y+8dIn23KAa3pRL8faWc/nvvGWQAR98o2e2nMSlBGLxZ/3aQCVGZFSf+fzjlVfxrHlyxa+oU80UQ3TZ13sAHHWYIy/oOCTbEBDzufHIbFS/ccpq6qJyp9mxMzLjTqXkCiyXb7yvFDJi3oW95NuXxK9kOFLKv2PlNgtr32vGHlHiPG8MhMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB5469.namprd11.prod.outlook.com (2603:10b6:5:399::13)
 by DS7PR11MB7835.namprd11.prod.outlook.com (2603:10b6:8:db::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.23; Mon, 4 Mar
 2024 08:49:45 +0000
Received: from DM4PR11MB5469.namprd11.prod.outlook.com
 ([fe80::f2:3082:c15c:929]) by DM4PR11MB5469.namprd11.prod.outlook.com
 ([fe80::f2:3082:c15c:929%5]) with mapi id 15.20.7362.019; Mon, 4 Mar 2024
 08:49:45 +0000
Message-ID: <5a9d5ce2-605d-4c67-a409-f97d0da5829f@intel.com>
Date: Mon, 4 Mar 2024 16:49:32 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PACTH v3] Documentation: iommu/vt-d: Add the document for Intel
 IOMMU debugfs
Content-Language: en-US
To: Baolu Lu <baolu.lu@linux.intel.com>, <iommu@lists.linux.dev>, Tian Kevin
	<kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon
	<will@kernel.org>, Robin Murphy <robin.murphy@arm.com>
CC: <linux-kernel@vger.kernel.org>
References: <20240207090742.23857-1-Jingqi.liu@intel.com>
 <0b30b737-65b3-415e-a3a6-d18393873e22@linux.intel.com>
From: "Liu, Jingqi" <jingqi.liu@intel.com>
In-Reply-To: <0b30b737-65b3-415e-a3a6-d18393873e22@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2P153CA0008.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::19) To DM4PR11MB5469.namprd11.prod.outlook.com
 (2603:10b6:5:399::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB5469:EE_|DS7PR11MB7835:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b7c3c68-8f8a-4459-33a1-08dc3c280a42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6zhwYmMJP2RHF8evaig5Kj2yl87XE8tClZa55oKnaB+PpS2qeFuQDx4XZ+K/ebbmKnPdXnGIiefVm5N5d7DS9sv3DUrwJ9sv6VRoZCWGjBnDnhomRZi7QbW+gEHlHp6Ihho732/jOiVMJa+3I5NS7S/cTgXKoNtmXhlFBMLje4NSuLduyd5gOM18uDo3LlUQOd3h0VMDD17V2G+FF4bvdiQmSi7DG1Ik7wl9BfjQiWI12aFcG5DpVbKHLh8XVKdsUQETZxyKK7Nt/E3hXfj7Mw9xcL9ZD7eE0yWqRp3+tZpWQm9QAW25z3ozfvxyqdRWhAv6p8fKwZNVjIBnTVg23kWkO2sLhibIOKC2YdnKKNNRPigUkJeRhijvtGhkNwD1iriQxrugfW4fIT7LmbdM6153Pq02uvV0wtx6jM56cUfcfSWJ2MRYjbg5banR9BggZ8E8feYLyAdur6qvdzqw+JRlKs3569JXkBlO5KYhw6Ul/Sp9qDWskOV1IRqJAb0HJZyFWOvCi7/LapNWbja0ehieIDJ58XxopBSkI9I0tI0HRzNheQKRg9cN/waVC7hMzz2yTiB/3JK/jo3E5El6Qgl2tWEfQXL4ho3BqL55ebqdJGI5vFFio8LL3B7Q5r26
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5469.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YjFWa2RkdmRjaTJEeE83dytZK2VzNlRWQjVGOFZZZ2FwY1JkZHhQRktWK2RN?=
 =?utf-8?B?UHdnZGUwZzk1NjgvSnRVdjJJKzdyVk1rSzFSaDZRcUxVZTQrYzVoMGJyMjRH?=
 =?utf-8?B?ak9FUGRmZEtNS0FVUXhPNlpxd1ZYM3BVVnBlc3dkdzcrRmZmV0xMSEE5NEd3?=
 =?utf-8?B?RVpZcGhWMDA1NzVkNnJBSm5zWkZWZUZ6NkdVaWpzYkV3alplMk5TYVA0RC83?=
 =?utf-8?B?TDFkSU5aVFpNYllkenIxeWxVL2QxNHZISURwQWE1NlZ5eXltNHVoOXVHVkNW?=
 =?utf-8?B?TjEvaytsRzRnYngvbWo3Rk1CL2NsaFJIYjJBNzkyTU12elBkcFhUMjU2SWMx?=
 =?utf-8?B?cExTZ2FoU2QyNUkwaWFYUEFyS2c2cWhmOXAxL3NidCsxMDBGNXpSWFB2Y1NS?=
 =?utf-8?B?V3A1Sk92QzJabHZ1dXZlOXQ1eFdESGF1U2N2a1FmZWNnWVFVSy9kUjJmVWlk?=
 =?utf-8?B?NWFOZzdTWVBvZldGcFdFa2Zrb0N4YkxrYW5iTDQ5c2pscTk5WWd0SHV0bjZs?=
 =?utf-8?B?S0svYlJWQ1VSci9FeE9IVXdERk5hTU40M2c1UFVNWmppbUlVb2FUck5IVVo3?=
 =?utf-8?B?M2dlVElOKzI3dXNXUWoxK3loMnk0THJzMW9PZnBNL0p0TEo3RmE0bWF2Rk1D?=
 =?utf-8?B?dDBzOXI1ZUxrYWpQY0pSL2plcEN2S3JtejNwbm4wWHh5L1Q0MEFLVlhiWHVk?=
 =?utf-8?B?V0pLc1BMamJvbXVrV0NhWEUraThzL1RhMFNXOTlveEZIa3F3TXVmMDBpQ1BJ?=
 =?utf-8?B?dVAwS25aaVNYbW9NVGMxdUZRMnl2Q0MwdVNYdWUrdWRZQ3ZZV1Z6RGNVcUJU?=
 =?utf-8?B?cktwSEp1WVg5dHZVOHNxOHYvcitVM2VYelJqeEtWM0JTS3NLejJrR1ZoU293?=
 =?utf-8?B?dldITGNoZDIrc21uOEU3MTZ4d0RMekRSSis4SmJVSFROTUZ4V2pSa25nRGVt?=
 =?utf-8?B?MDVDWk1wMng4enhtTHVQT2xpUk9FWHFlbTBuaXZoNUJmU001OUJ1U1hWclo5?=
 =?utf-8?B?VGw0UWlWTWpLR3FFdkhoQUh0MUFBTjY0dllZSnlxVExVTm9GcWw5YlVoVUo2?=
 =?utf-8?B?UVlVSjNSVjE2NFllWVBOQ3E4SEdlTUdIMFR3ekNYZjNvR1k0dUtzMW5PTTNF?=
 =?utf-8?B?ZmgvZkRvcWV4b3pJRnFrUm1aQnBweXltSHFHQXZqZnhTbHVTYy9uK09jWkh2?=
 =?utf-8?B?TVdSTTBNQ1UwQXFWTkg0WGVqRGNmckhSRVpkaUVCQ3JqWUJpZkVkUlk3c1hR?=
 =?utf-8?B?RGFrSTZBcW5pT3pDbUVJZzZremV1OGQzVWhLSGhRN01Db0l1d3pTblRpNDJR?=
 =?utf-8?B?cjdCNHYrSFpXYU15RUg4MkQyUWZWV1B1bndvYmQ1MmwvUnI1WXBFRGVNeVg5?=
 =?utf-8?B?MDMzcm9PYTRoVzZyNTBRUU5Gb3IvQ2Q0QXpkMHBqMEZHTkQzcFE0eHdpVHBG?=
 =?utf-8?B?cm9ndUNIWXdxVDhhTnVEOVA1TUwzQmlIdXFUSTdVVi9vaDJiaTlITFl4MmpB?=
 =?utf-8?B?ZkRveEQxbHFHSDVFcWVUS1kvdzZ1VXBMVldXODV5Ymx6UThncVBONFlPaWk1?=
 =?utf-8?B?SXh1c2ZQN2FFSjNvYWQ4ZC9xVlV5WVE1TUhER1pJY3VhQnlVT1N4V3VTZzNn?=
 =?utf-8?B?UVI1T2dCZW90djU0ck02cythZEIrVHByUDU0VzdnN1BQUEFjaG1vMmNhaXdP?=
 =?utf-8?B?Mm9tMUQydE9EWkhCak44VXcyRlVTY0V6YXc3TXF0UXNZd2VJeVEweWtIenpQ?=
 =?utf-8?B?bUlSV1lyUU84WEgzUVYwQVNmcDlXVmN6NjcvdHE2bHUzUzNFV3FwR0JpU2oz?=
 =?utf-8?B?eFpmV0hSVURqMGdXU2lCL1VhZE5FbTVJdXhQRzZPeURqWkZsdXJnWG50OGxZ?=
 =?utf-8?B?ZnlwdEl2UG5Tb29BbnN6a1RuK2xYMU9oR3JWS0pvSS9jWGozbkFaUWFxUHRu?=
 =?utf-8?B?NTU3K0M1M3NDRHEraG0rZ01pN2tXakI0TVNwK2NIRFEwRllVc1ZCdlhVWlls?=
 =?utf-8?B?RGowS0RNYUhhTFJZVnFsenZ0RUZrRXovSTRKTDU2a3Nub085c0pnRWMwai9x?=
 =?utf-8?B?akRpZVdJV1dJQi8wWGdRbStrTlZOTzNYSmdyY3ptRFg2SUpYcWh3WFRuSFg2?=
 =?utf-8?Q?lnQczkpjevP69Qptr+rk0zZXG?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b7c3c68-8f8a-4459-33a1-08dc3c280a42
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5469.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2024 08:49:45.1177
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v/ThcsyYU3tdkuNRedUJxpyB36GQbaucWTJwOhC12Mt1g/zXoBLaSRZ9znZ5uYWV2cOKXu8Ugw4VZs86PDL6UQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7835
X-OriginatorOrg: intel.com

On 2/26/2024 2:10 PM, Baolu Lu wrote:
> On 2/7/24 5:07 PM, Jingqi Liu wrote:
>> This document guides users to dump the Intel IOMMU internals by debugfs.
>>
>> Signed-off-by: Jingqi Liu<Jingqi.liu@intel.com>
>> ---
>> Change log:
>>   v3:
>>    - Add this change log per Baolu's comments.
>>   
>> v2:http://lore.kernel.org/lkml/20240126064704.14292-1-Jingqi.liu@intel.com
>>    - Remove the use of private data field according to VT-d specification
>>      changes in v4.0.
>>   
>> v1:http://lore.kernel.org/lkml/20231220132519.11077-1-Jingqi.liu@intel.com
>> ---
>>   Documentation/ABI/testing/debugfs-intel-iommu | 276 ++++++++++++++++++
>>   1 file changed, 276 insertions(+)
>>   create mode 100644 Documentation/ABI/testing/debugfs-intel-iommu
> 
> I have queued this patch for v6.9.
It's great!
Thanks for your review.

Thanks,
Jingqi

