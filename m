Return-Path: <linux-kernel+bounces-108915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D96E8811DF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 13:48:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 79835B235AE
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 12:48:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B95A1405CD;
	Wed, 20 Mar 2024 12:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Rri0GN6n"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E2E13BBEA;
	Wed, 20 Mar 2024 12:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710938902; cv=fail; b=Z2p6yxS0iHN0g4UgscGi2GglIS+kpN0+sC95q6bLpJTGdNtDlvQb37H+ph1FdrKNo+FK7itSUOP3P6tzVRosX0T0wLRzmnn4x6q0RRxrQBnsLzDcSWW3iqVQEtYfsD+WcVQARRy6UrJb24wBYWr+oiFNAFKjmQu0mX5FRS5mWfs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710938902; c=relaxed/simple;
	bh=IzY7ogDjt3+uNQVo7vshdLVYIuMHH50lte8XEcady4k=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qdCS+BevAazXmrq3Zjl83sP+DoMlDAncaikbSyKb/FzQrSa1uFFtRg1w/t/c2kkt43r7S1nCZoP6LsaL9V6JfOe+jO7GfXsDdyqkarQjqXCE+SExeM+UL1G0weB67rMJ2/lmiWH20knXDlDOj0FD8JK2I0zXvPtOryfgeiYhBOg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Rri0GN6n; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710938901; x=1742474901;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=IzY7ogDjt3+uNQVo7vshdLVYIuMHH50lte8XEcady4k=;
  b=Rri0GN6nvH5yWWHChSBNn395N2uzyWHS3aJuffzlRThG7mDMV78DP2oC
   1v3APqIUOVANR3IizXD3Ubtm7Z64AAOzBRGisisv2TOqApV87ht8cJ09b
   IcihosVXCzuzDOdAoDabrtFTuyL+F5mpCatmxk16lglbN43m18trR7Fx2
   jU+VU2EppaXd9554L81hFt0qQn4oMu0JGIPfaggoFHwXi7xbmCZj/F5WM
   nKNVIqaEjzThhOfw+IK8N79s8sHA2reQ3FBdnI82YHcZYB6HLynb23LA7
   rNpXao+ji/v2bhq3qSEQdOlBdeLbTdvd7bMp7COuXdj12q0fnWZnwtCND
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11018"; a="23360820"
X-IronPort-AV: E=Sophos;i="6.07,140,1708416000"; 
   d="scan'208";a="23360820"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2024 05:48:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,140,1708416000"; 
   d="scan'208";a="14027092"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Mar 2024 05:48:20 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 20 Mar 2024 05:48:19 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 20 Mar 2024 05:48:19 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 20 Mar 2024 05:48:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W8Lo53wvdPLhDCVHGsqWKewNJCZCgbeaBtdbah30GxJ33x8885fKoi2j195dz/dSktJzLajMhnhNzeFNlUDZtxvpxoD5uu2iUAedVle15n7hseZ/bGJWFeBdF5deEM6BJLlhDbuRConmJvMkbdVGhJ8yyWNzah4HjzF71fyofz72aZUXTKitV4JkOblP0u8FBFgDGhAXR6HpjlMxUHGmXyEcf0gDRM1ajWYBspecWXbVGYER2ZGmwqkAQE+arFvpbJWrVSKmkz+8ZlWCQxBHMajv5oGbx/DtxVBxJxN3065F/cTamKQfBQwajOfJJmPKYKquuWAwEkBkf6ocILPS4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u4UT+PO5OCStZrxxENPtQ1lfkwlmHvJ5t/4zs3AJuuY=;
 b=RsU3CnGgwx0sW18t4MQ7L8wbVgJa3/wMMOYegF69p+iVnYNjPzjS/7PGIrT4myfxmeIiWfBetYk/xSZyNI9+/5gUJKbIBywyJraP2lSlvSNRhO4xb8gHH9wJcWFNDKQ3FtllDbSqvXqBjRDgAmERZDzU28bOENB+ElZj8lsmpMcIveblcYacGuVCqJuLCZhsoGMpNCkbekjTDbe2S9uVgHAw1OYN3wKbvRo3YdF9LixOJvMnGqs9cLzAdwV6cpQyeRF3P2zeYFeXUfDN73CBpn8IaSAVOyy4trQmZpBUmrvtwLeMUD5CdZzphW6DF2KmUQa9lO+ls6OAmN2UqD1ZJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7200.namprd11.prod.outlook.com (2603:10b6:208:42f::11)
 by DS0PR11MB6351.namprd11.prod.outlook.com (2603:10b6:8:cc::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.11; Wed, 20 Mar
 2024 12:48:17 +0000
Received: from IA1PR11MB7200.namprd11.prod.outlook.com
 ([fe80::c990:5065:ed39:c165]) by IA1PR11MB7200.namprd11.prod.outlook.com
 ([fe80::c990:5065:ed39:c165%6]) with mapi id 15.20.7409.010; Wed, 20 Mar 2024
 12:48:17 +0000
Message-ID: <9c4b275e-45cf-42ee-b356-d858a2fd3755@intel.com>
Date: Wed, 20 Mar 2024 20:48:09 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/6] Add support for root port RAS error handling
Content-Language: en-US
To: Dan Williams <dan.j.williams@intel.com>, <rrichter@amd.com>,
	<terry.bowman@amd.com>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240313083602.239201-1-ming4.li@intel.com>
 <65f3a842988d6_a9b4294f7@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <16ab732d-a009-45ee-a438-3faf048c7acd@intel.com>
 <65f491b64f15a_aa2229497@dwillia2-mobl3.amr.corp.intel.com.notmuch>
From: "Li, Ming" <ming4.li@intel.com>
Organization: Intel
In-Reply-To: <65f491b64f15a_aa2229497@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR06CA0226.apcprd06.prod.outlook.com
 (2603:1096:4:68::34) To IA1PR11MB7200.namprd11.prod.outlook.com
 (2603:10b6:208:42f::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7200:EE_|DS0PR11MB6351:EE_
X-MS-Office365-Filtering-Correlation-Id: b8bbaac2-5589-42e7-e53b-08dc48dc03a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rVhvzd1OUxhvhi0QQd4ZIClCu3+2h6ePSPhB7wpYeoBp7MES/3wh0SHMYzWnNd6pBcRWE7rHh628gAt6xMPBHk35y8NHLBMjN9GaKZRm+np5Zh0XbwJ0R5Ge8cIFmWdtX218XdI+O3Y3XcFms3wySqlTQ46hJukSjRYlQWpQJwIg9nKeSMP1zlzFwoxnpMf47QlDsHJwUzUxZpfxszf/pxQjqcGR7f8d0cdoJp6ZNiiQR5bA0TA8YgRZMMKEsYTwMQoF7TkyozJkUT37dFfMgl/poMAcw4euvOv/3zYEdDvD558++k5DSlx3G8ZwPneQSdqMM24bROFlMfHgETtrNtfeMsZzqwQl2d2+2rsC9C1IdKxUB6+f+b7whjjOCNqhJNGH8WV418tkHTO0+FXP88c9yC+P5JzJmzBDtGS13mzQOlTnpNZRVIECt1K0PoJsM5aQ+xcWDGlFQumFAbauzE2ILOL4ZXw0ae+Vd0aNdbrY/idnXx/t7bzjsA3vIn0Ga0IrE0Bx+y65LVvKFqgX65wggAE/LfUIPLqRN0LIiC8cmCFW3HrQPcVOhW9eDFB4N4rEwr37uWUX8QT8xn+enliusGjwTUQ6o3GyXqlNTaobyYlfQsowvtfDYiP7g7dSrisgRaKX+gYEReS1ROOnxhpZxpZOLeBFXFbUCLOOb04=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7200.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QTFLTWx2UjYybmRBS3F5MnFKOGFKd0F4bllJWTBSd1R6Z2lQWHhsUnZES0VS?=
 =?utf-8?B?TlhIeEZsU0pxeGxmMkwxa1QvVVY5RzdVbTdmU1lZUGlHdWxob2xEaVRETk1Q?=
 =?utf-8?B?SUVSMmJHRHM1bCtDd3BDSnYzSmlWQUxKU0ovUjhoWWk4ajFkUHFaTVJuVWQv?=
 =?utf-8?B?cUFWL3oxSjhSampZNmViS3M0ZElwc3Z1VUxBSWYwK2orc3lZNWZKVzZMTTFN?=
 =?utf-8?B?KzlPREJqSnlkOFhvcHpyaEpDMDFWMC9qdDRRY0Z6bit4KzhyeFhBd1hNMkt0?=
 =?utf-8?B?MDBrMTlLR29POVBQOUNycTFkOHY4elBnMjFEQXU1ZC8yRHNsQklteU5CeWFH?=
 =?utf-8?B?UnMxaEw1K0NTam5jMUZ0LzN4MFZRUGF5T2ZQcGFVdjBVc1duL0o4VXU5N3Zm?=
 =?utf-8?B?dXRpeTMrem52YzV3QlZjNEk3bjh4T3Y4Y3E5dk9QcmJRZWxZb2FPYkREWE0x?=
 =?utf-8?B?MWI1aC9BZlhQT2NTZXgxZzI2VFJQOHRkbWVkUEkzaEZoTGN0T2ZONk1Wc0Nr?=
 =?utf-8?B?dnhobWRWQXZCVkRLT1ZwVkxTTW5YaWtVdkZOM3hza2J3SkppOG1YQlVmNmFj?=
 =?utf-8?B?U1EvYUxtRzRCd0ZuVTNBS2NoZ0NrcG1TK01pd0xkZks0MWZuQUcrRk83cW55?=
 =?utf-8?B?MFhaYmZ6SmsxV3FOdytmMlBwdzVrdTlDdmlpMnIwbCtRU1g1RjByWVlqYWNP?=
 =?utf-8?B?clVVYmlETVJncGRDc0VyUlhZVkVqUVpjUjhiY3FaWTJrT2xMTm1YOHdlVDAy?=
 =?utf-8?B?VFhXMFVEYUhpWEp4d3RaM0hxaUV1TUZDUndaaW1ENWNNdE5Pdm5VaUxmWGFl?=
 =?utf-8?B?cXhaNCtmaTR3L0svTjVnekJCaGsxcG5VYVRtRUpUMGdHUjB5SWtIVUp2V2ta?=
 =?utf-8?B?bzUrVENqOGJRL004RzRyUE4vRXJxd3ozcEZUOEozWlY5RHdSZWhJVFpTaUlX?=
 =?utf-8?B?QU9scUJyWjZ6aWEvbjhqK0UrZ1I4L1RBUUJvM1dlUndVL0trYk9KUmNuQjgy?=
 =?utf-8?B?K1VmSWZ3RGtuZCtJM0l5UjA4U3N1cG4ydDNyL2wyTHE4TEhNV3EzNDVRdFRV?=
 =?utf-8?B?dGhVREttMWYxSTlleGI5QTRaUWZsZUJ3NnBWelY5WEpxK3RtVjU4c1VLdFNI?=
 =?utf-8?B?b0lzYkh0WDJyUUVnR2FYOFlPSE15R3VjcHlhbHlZNzlBQ2dNbUtneHhuVXU4?=
 =?utf-8?B?NzNQZytVQXlTNXJIV2RzOERMWkJ4alFkcytvMm1RSU1hc3MrYTZYa2pDV3dX?=
 =?utf-8?B?ZHZ1QzJ0VWNsZ2I1OTJBdUp4QUpwY1BsT20rMkt3c3o2S1A5ZGxmbGRLSWZH?=
 =?utf-8?B?d3I2bFpQVDhSSTZCOEV0VWJDdEw5LzhwOHVIV0grQVpjZW9rT0VjOThIUllH?=
 =?utf-8?B?N0lTSnRMVVhSSGRhQkk0V3B4WitSVUI5Yi8rNWNtTGQ1MzFSOUNNc05JbkVI?=
 =?utf-8?B?QmNtRWNJMzI5M0pOa1RoTzFFZmE3clhYeUF4azZmRHNsM1g0eDhSTWZJU0p0?=
 =?utf-8?B?UTIvT1Y3ZjhqOHNnWDdqOXp5SFJtb29RZ2Y5bVpsK2N6RDhJU1J5N3d1SEFR?=
 =?utf-8?B?MUFET1lTdEJTYXQ3K3dySkhnRVNtTkh3eWMvL1A3eTd5ZzBCZzZ6OHRmWVhq?=
 =?utf-8?B?M1VEZk45L1RMdE9FSjJlMkw0b2tlNjRkUHl1RUsyKy8yYkI0d0FmbnpTVCtT?=
 =?utf-8?B?OFcyMm0wUUUrR2NNa01nMWxGZUVhRDUrcUJIM0VZQXlDZlZ3K2pCN3BQSExn?=
 =?utf-8?B?UDJSUFlYcGpaSjFMUi9HTTJyN3VuVkVVVXBidmlWVWlTbVZVOTZTZWtUQkZ2?=
 =?utf-8?B?VTVtL2RRczczdEdDZW51a2JKUU05amxkRy81cFhjZnkzMDlNdG8wQmZUc0M2?=
 =?utf-8?B?L3hPdXZVTVBoN3IwZzNUVlVrRDVsNysxTnVnalpMbTdSRlViNjkwT2JZYjhr?=
 =?utf-8?B?d1NVeFZSYXY0OVg4MVBSOXZvTEw3NlpnajllaXc0YmlkdVl1Wm9IOUFkcVBl?=
 =?utf-8?B?eCtER1FUdE9WVnlpV0Z4ODJVUnpwc0hYRkM1SjJMd0tXWnBVNWE1a1UvcjBZ?=
 =?utf-8?B?U0RZdE44Z01ZcWxGLzRneHBjYmZnT1NXeTVsdWZjYndlVjFaSGZDMUN3cnlq?=
 =?utf-8?Q?v1wirq6FnqbjJ+LNx6UA4m2zv?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b8bbaac2-5589-42e7-e53b-08dc48dc03a3
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7200.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2024 12:48:17.4172
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ak4Wksgvl27vQYFGJIT1TP7xQEX5O1By05YsBlhCd2umfcFD89NRD5uXwd+wHQhhnsVG4Txr9Yu8Nh2gBIzztw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6351
X-OriginatorOrg: intel.com

On 3/16/2024 2:21 AM, Dan Williams wrote:
> Li, Ming wrote:
> [..]
>>> I do expect direct-attach to be a predominant use case, but I want to
>>> make sure that the implementation at least does not make the switch port
>>> error handling case more difficult to implement.
>>
>> Hi Dan,
>>
>> Currently, A rough idea I have is that:
>> If a CXL switch connected to the CXL RP, there should be two cases,
>> 1. no CXL memory device connected to the switch, in this case, I'm not
>> sure whether CXL.cachemem protocol errors is still possibly happened
>> between RP and switch without CXL memory device. If not, maybe we
>> don't need to consider such case?
> 
> Protocol errors can happen between any 2 ports, just like PCI protocol
> errors.

Seems like if we want to handle CXL protocol error for such case on CXL driver side, we need some changes for CXL switch port/dport enumeration, I remembered that switch USP and DSP are enumerated only when a CXL memory device attached.

> 
>> 2. a CXL memory device connected to the switch. I think cxl_pci error
>> handler could also help to handle CXL.cachemem protocol errors
>> happened in switch USP/DSP.
> 
> No, for 2 reasons:
> 
> * The cxl_pci driver is only for general CXL type-3 memory
>   expanders. Even though no CXL.cache devices have upstream drivers they
>   do exist and they would experience protocol errors that the PCI core
>   needs to consider.
> 
> * When a switch is present it is possible to have a protocol error
>   between the switch upstream port and the root port, and not between
>   the switch downstream port and the endpoint.
> 
> The more I think about it I do not think it is appropriate for cxl_pci
> to be involved in clearing root port errors in the VH case, it only
> works the RCH case because of the way the device and the root-port get
> combined.

Thank you for your explanation. 

I think I need some time to consider a appropriate proposal. maybe we can register a CXL error handler into struct pci_driver during CXL port/dport enumeration for root port and switch cases, PCIe AER driver will invoke this registered CXL error handler to handle errors on CXL subsystem side. But I think this solution also meets above issue(current CXL subsystem won't enumerate CXL switch port/dport without CXL mem device).




