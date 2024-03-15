Return-Path: <linux-kernel+bounces-104170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 296B987CA14
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 09:41:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9B2F283B34
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 08:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1384A1757A;
	Fri, 15 Mar 2024 08:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FheUzRzs"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 595861798A;
	Fri, 15 Mar 2024 08:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710492064; cv=fail; b=XyFbNpHL31AFvxu4NkR+UCt37hoe23WNVDMp3LAHDmlT49Ym3jhfUtOybxrYT0vHl31qGftkp0MMM4yWO7YBspOMMJ5YppwbQfQ05WPr6JkmO4/tEHihIVJYxhqKfClIdV6z3ct282J/Nl0ZLBnQvijUF8q1XL7vbtaS17z2K9Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710492064; c=relaxed/simple;
	bh=lnugR9rb4tuXERgzN6O6b8kdzR7MiR8pHyhFZoC5FHQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UlVOcu+BcYNqQqBCefKk2SRpdv87Ig4rQg5G3yrJIwdMwb5Mr9QatmurpgJUNUv0d+faYbmIxjg36Bx+b/6x1VX2KH+i3nF3gd1e9kD3/J8tslMli2z4G6+huZTYODPSwhL0W7pJMeWgBhpo8vvO9zNXQqf/QyABiimRh3fMJKI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FheUzRzs; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710492062; x=1742028062;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=lnugR9rb4tuXERgzN6O6b8kdzR7MiR8pHyhFZoC5FHQ=;
  b=FheUzRzsSwhtUNZGplTKEeD4XfKmWK8RW4S//GXCsTWPuEQ2jp1Nzxzr
   Hbx0x6Enpx/nTV1RiUqsZtPoGdF/vIuUs+tei9OE4qvOLwCs6+OGaos9R
   YC/qwL1TyLqfDgnZ0FtFTrQt0K7HNFViwQ4SCJuqc3c7AddapUheXxWSl
   fnba522H1MfCAs0RRHighaht2ZwTqQbvtaYTSyCCDWma5fieyhuL5+Iw0
   8gsQRHFocRi+3kPrSjYRkOU0KLEjsPoqt+GlB2nxGN1AyDpprWhCe5Q8v
   MCF1L5cNra6Bl8YSz5JbKLXGWernjzqOiwAMc567cde+6dROpq/yXiNl+
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11013"; a="22811837"
X-IronPort-AV: E=Sophos;i="6.07,128,1708416000"; 
   d="scan'208";a="22811837"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2024 01:41:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,128,1708416000"; 
   d="scan'208";a="17187660"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Mar 2024 01:41:00 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 15 Mar 2024 01:40:59 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 15 Mar 2024 01:40:59 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 15 Mar 2024 01:40:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SngyV5FVmK+AK1t27ZSestnyl5+h7YlfWL2Wx7HFYJA9aer967M2Ivtq0UdZkFEQjlRSjizk6oUGqibchF+nh5TbMhxsCATHvMCMgzGLAkGQf9vbqhs6e4nj2+CrN35gitarS8fZvHAcy5m9Bgj/EzmiNfmxsYTPZ5C/S5p0+Kp8EUfyD8YJ32KtjtxCEGHXHMjFDxeNaCHCkDNj9tb9xwYZDadh90T3a4ShYIGEMG1WV9q8XksirMNwwiM5PNFUhJ28sw57JU+09o6cHw1e2z7GggjmGLtU75ufF7Ddeiz1MHsRl5TkYbT8m7DXp2+vdG/Ap9jIHPRtOK4ze0I2qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=84uEKy7RoZ38jeMgfnmVd2uyfketsOt01KsNQpAIiOs=;
 b=VTgmJ7h9YjSx+hdX2ByRBRnPBEVq3qv1xJxzgOEXfV0bDYWKvkmAdyXpHsYAM2PGiGj5++5QyHeULyYQ5H/C//YLajQQod7TNKfgDit39DQR9GS2UEkGP/5sULcT9MYxDidUuIP861oquXLTEd7nebiq3RLMwmdkA3gs+5u8va/1wowj87LMj6Pzg4xyBmkW5JazQ2G1Y9v42g1nOJfNxGAQviStBmG/Zqcwb9hpjNYG/zzNix1db/kEUlSekoraDQUdoTftSUf+YVZ/Nnzd2qg39sXKznwP27KMIUuxhs9zhnZ9EqXE3tgGTeJ3LZ69/b4t+Uv/E9mmKVZlbUAGEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7200.namprd11.prod.outlook.com (2603:10b6:208:42f::11)
 by CH0PR11MB5299.namprd11.prod.outlook.com (2603:10b6:610:be::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.19; Fri, 15 Mar
 2024 08:40:57 +0000
Received: from IA1PR11MB7200.namprd11.prod.outlook.com
 ([fe80::c990:5065:ed39:c165]) by IA1PR11MB7200.namprd11.prod.outlook.com
 ([fe80::c990:5065:ed39:c165%6]) with mapi id 15.20.7386.017; Fri, 15 Mar 2024
 08:40:55 +0000
Message-ID: <16ab732d-a009-45ee-a438-3faf048c7acd@intel.com>
Date: Fri, 15 Mar 2024 16:40:47 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/6] Add support for root port RAS error handling
To: Dan Williams <dan.j.williams@intel.com>, <rrichter@amd.com>,
	<terry.bowman@amd.com>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240313083602.239201-1-ming4.li@intel.com>
 <65f3a842988d6_a9b4294f7@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Content-Language: en-US
From: "Li, Ming" <ming4.li@intel.com>
Organization: Intel
In-Reply-To: <65f3a842988d6_a9b4294f7@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2P153CA0035.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::14) To IA1PR11MB7200.namprd11.prod.outlook.com
 (2603:10b6:208:42f::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7200:EE_|CH0PR11MB5299:EE_
X-MS-Office365-Filtering-Correlation-Id: 0cd8a890-17b4-4f01-1a7a-08dc44cba120
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UU8jHzHHEx4MxtFMqLDjl1OIJg861Tt2LnuyIFfq2XCG5TYT9YF4IvZ/fF1Q5nfRpxfifEmoAuZU81XASguKSmG7U4u7oZkdp2+UvilXTJzM3rBKK/bxkO91ZkrMbjIi2tjn0HhFSCnSlpvq5F+J96KuNzcrhS+qIWMlvjANXcoH6bYd0cvcfGSSn+MyO9s7x/EPNpXwsI37KQ9UK94j32zjFEF7vTDFm74NXJ7Dzss8CSRSEb3Ikx5zlvKMriukg/kBDu0OviycJ5QegZ5nDqLhFBfS4EhmFerubY0RYu/yluSxtRTNumyS5PDdKo9dV8StD/uifvRWpSRS6v2c8Y2IKvZ7LGG5pmaRwY5Y/dZOngF4Kp1+M6bBUJ6GZJ01wfk8B9Mo0vDes+dnIEncO5+8+bzYzTH+yHaLafoudSF0YnjSt+9SdviqpU16P5Bqlcew0Q1FvnzZYk1QPBInnh5dF+ezmGjfO8BB/UI3v2ktkB4Ju0SBEJ0aeYnahH0lvPFA9Eb1n1KDD7JFM7Hy2Ck9IYu4r7EmBUUb6jFZ/zrUKBfHrzAVi268OqnzvA43zlfGgJnLHGhv4Pry8TuWeLA8RLdVwH/bY5dIT2DZYDfU4BDOSecQQWWlvPlXKmgZsGfJ0HbO7Cb6UXHSQXQE5UY8GVDI12v1A7wOKu9OSUM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7200.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UXVNZVZrR0hQRFRzYlhKbENldm93R2R3R1BnSkdjVUxqaDNISldtclFtL3lM?=
 =?utf-8?B?aDRUMWkzSnQrbS96dDVSczErZkJXSktoeGFHYklhYTlOTFZlSEQ2anNZNkxq?=
 =?utf-8?B?VWpyT2tqTVNEdlVNSFZPUjVNWjRKcFR4U3Y5Mkt4Y2tSSWovS0QrTVlBQXpp?=
 =?utf-8?B?Q3BRaXhub25YbkVKTHVPeDc3WUVBeHNZMjVkSDRTZzZ0WWJtbjNMditxMHIr?=
 =?utf-8?B?clBPOTlJd1k2Y0VmdXlEYk5DV21RbFplNTFBWkVrRWZIZEV4eFFHTXRoVWRt?=
 =?utf-8?B?OHNJVnBMTGxsb0p2UHM3RitwcHZiN2h3cFJTZVBINnllOXNlVGhMYkxHYzgr?=
 =?utf-8?B?bEo5UTRML2Z5L00wbVgwU3MwT1ZYOElNbnI4Nm5Sbkoyc1lQSmE1MnpYNzMx?=
 =?utf-8?B?T2EzYW5FNUwzR0VlcEl2RGVsK0xlbWZNMjNsRC9vVjdlV0JSMlNZbGYyMFJi?=
 =?utf-8?B?bitUaUcydlpYODVPbU44N043TVBzRXRpZEZndlg5aTRYNHZNdjJXZDQzSC9n?=
 =?utf-8?B?dU52c1RaM04vMDkxeXFibzUvR0EyN3pxZyt4c2JEY0RVUGZ1YlBsZ0x2Y2oy?=
 =?utf-8?B?M2pudDZaSmpxYUpyOHV4WjVTdDNOYkJNa05jZm9mWS9JTzdaL3dPVnlBZndn?=
 =?utf-8?B?SVR4Rms4dUE2emlXN2RGUnJaZzJZRUF3eWFrYnhod051YnIraHV5L0VlcTh2?=
 =?utf-8?B?OTdpWkpaa0xkenM5MFVBQUtVRDJ6cGtZcmRXYTUvVWtMUDRyeW94MHpzOHdp?=
 =?utf-8?B?VHRycnVhNFljWTJVUEQrK2FZbG55SWFMMXlDQzJlWFc4dTZaNHdjeENSKy92?=
 =?utf-8?B?UHMrdVU4Q1FzTm80MkFkcWR5bkVOVldwdnF4Q3pkRE50K3kyN3BQbHcrYzl2?=
 =?utf-8?B?d2dtNmRocSt4ZGd0N1Q5OWgydVd1RjgxaFZpY3JFOVpCSmFUb2hhTGZzK3dE?=
 =?utf-8?B?a3ZiNWFMUE9iSlRyNnVCWmdMZ2NrMVJ6WmtwVXl4Yi8yekdXOGt4THhSZFVl?=
 =?utf-8?B?Rm1GRTBBdVdTWlZ6RGxWQ1dxSWFDME80bzViNGQ4OGdtdjRpMzRMWFhjciti?=
 =?utf-8?B?UlNCQjVmVWN2c3d6WjkyVFUxTjRiZVpkL2xodmVpeExyK2dua3R4c1V0UitI?=
 =?utf-8?B?VGhBNXFzdkd4VE41c2FvRW9sZTRzSHFONGE3VTloR0JoUmxibjRheDBTbG4r?=
 =?utf-8?B?VXh5VVdYK2J4aUQwR2hLR0hxZWNBdXRBbmg3RzJKQXJWdUVBTy9XV3FlUHZs?=
 =?utf-8?B?UEFxL3Z5WkxoVG50SFBEVmR3U0t2NHk3YlFLam5SQk1VYjdId0x4bEkrRDh0?=
 =?utf-8?B?ak5oRXJ6UUdJU0VPT2lTbTJnSTFFcFBDQ2lyYVRRdng4MFQ4YW1aODNYbnVF?=
 =?utf-8?B?RkxuWHZnR0wwYUZIdkx4dFVPYTNxRUg0dzFMN2FHWUNXTGd0WG5YdXZsajNE?=
 =?utf-8?B?QkJIWVo0STdxU3JFbGF2OWhYV2JJL0J4NlhzQllTTVp0NDE3elpVb3k3dlhu?=
 =?utf-8?B?dzhFeUpjQmQ4V1ZTOEpUTWpnSjR3SjhOczJ6aFo1ZjlCTUw2aWgwUVY1SThq?=
 =?utf-8?B?c3dndzZIYXpSL1BtMUpmdUZKd1NyNy9uVmRhK0RvZnZoRS9Wd0d6ZnFoRmxn?=
 =?utf-8?B?UkFRT2RDZmdocXVGaEdCV0NiRDQ4MWI0YnpWekQ0bitWbXBycEJ4dWx6NHBT?=
 =?utf-8?B?aEsxN3cxaWJtbFM5a2VQTzkwYzBibkRJL2JrbjZlTlNSUFh2N0x6d2pFN3Rs?=
 =?utf-8?B?dzh5THgxRG8zVER2S2Q2NEYzVS9MeWdoeWplUDVQQjA3UjkwMWpWRjRpbzZP?=
 =?utf-8?B?bEEvNGFiNk5CWUFpTUFwODN3MFdmMDRmNkNFWmN0aEZGblg3Y3k2K1YzYURy?=
 =?utf-8?B?c2pWd1ZtSytLTDNPUmFacjhZVnZkMUxQSnBMNVhHeng3ZUc3Y1MzYXFwWS9B?=
 =?utf-8?B?anZPVXJwSmpVRVUyb2VTUStBUzdHVFI5aVByWDVFTis3MU9NSWtRcmd3eCsr?=
 =?utf-8?B?dldiWlc5T2tLYUNYQlh6ZFc1WEliTVc3ek5VOHZFZ1JGWUZ3VVNCSkM4V1U0?=
 =?utf-8?B?TkVuYmlRUWJxeFdIdFUwR05vdTMvaFJlajg0clBTRUxXaHExWW1jay9uSUxy?=
 =?utf-8?Q?+v6hNkTOACEbWjo555/kMlg0Y?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cd8a890-17b4-4f01-1a7a-08dc44cba120
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7200.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2024 08:40:55.5674
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4+R4PTyx+ipmbuDEhgNJFrbVG3ZAGuOUfcfHNdVnNqFsUJYzXdCWWvIMEFLsyQ9n0G4YlTZllcQt0tYZo2SiGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5299
X-OriginatorOrg: intel.com

On 3/15/2024 9:45 AM, Dan Williams wrote:
> Li Ming wrote:
>> Protocol errors signaled to a CXL root port may be captured by a Root
>> Complex Event Collector(RCEC). If those errors are not cleared and
>> reported the system owner loses forensic information for system failure
>> analysis.
>>
>> Per CXL r3.1 section 9.18.1.5, the recommendation for this case from CXL
>> specification is the 'Else' statement in 'IMPLEMENTATION NODE' under
>> 'Table 9-24 RDPAS Structure':
>>
>> 	"Probe all CXL Downstream Ports and determine whether they have logged an
>> 	error in the CXL.io or CXL.cachemem status registers."
>>
>> The CXL subsystem already supports RCH RAS Error handling that has a
>> dependency on the RCEC. Reuse and extend that RCH topoogy support to
>> handle reported errors in the VH topology case. The implementation is
>> composed of:
>> * Provide a new interface from RCEC side to support walk all devices
>>   under RCEC and RCEC associated bus range. PCIe AER core uses this
>>   interface to walk all CXL endpoints and all CXL root ports under the
>>   bus ranges.
>> * Update the PCIe AER core to enable Uncorrectable Internal Errors and
>>   Correctable Internal Errors report for root ports.
> 
> Thanks for the above background.
> 
>> * Invoke the cxl_pci error handler for RCEC reported errors.
> 
> So what do you expect happens when a switch is involved? In the RCH case
> it knows that the only thing that can fire RCEC is a root complex
> integrated endpoint implementation driven by cxl_pci. In the VH case it
> could be a switch.
> 
>> * Handle root-port errors in the cxl_pci handler when the device is
>>   direct attached.
> 
> I do expect direct-attach to be a predominant use case, but I want to
> make sure that the implementation at least does not make the switch port
> error handling case more difficult to implement.

Hi Dan,

Currently, A rough idea I have is that:
If a CXL switch connected to the CXL RP, there should be two cases,
1. no CXL memory device connected to the switch, in this case, I'm not sure whether CXL.cachemem protocol errors is still possibly happened between RP and switch without CXL memory device. If not, maybe we don't need to consider such case?

2. a CXL memory device connected to the switch. I think cxl_pci error handler could also help to handle CXL.cachemem protocol errors happened in switch USP/DSP.







