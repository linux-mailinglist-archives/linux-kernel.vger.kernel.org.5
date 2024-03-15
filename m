Return-Path: <linux-kernel+bounces-104040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D9BA87C836
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 05:05:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77133B21917
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 04:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8D0DDDA5;
	Fri, 15 Mar 2024 04:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Tj9ZcU/W"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A00DF5C;
	Fri, 15 Mar 2024 04:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710475542; cv=fail; b=tKMvq8Frc1C2X2Sx57/D3+hplk7GHCxgBQOS2fTcy3NhpaAZH9Pzm8DKAoxyOOQX/QRfTtObCz7Nyw+jFm9TjBIPelh8u3WuPQPwXmOn0AeV/6K6gnG/trDknlcWyHeg9oPYW1jCPNuPhY9eQiTys2paUeuTvBCyQwIsymBcVpk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710475542; c=relaxed/simple;
	bh=BauXWoFtB+pAtGdYhvlKVe0lUvXPUN2j2/1ckRpNZsU=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HAUDD4i/1yjfEq+Fe5EytYhLjA2S5mGN+gn6V/VAGTgmH78wPxEMoZ3KeQESGM+AzkY2mW06n3leWqmH4aU6ULPt9yMz8sqxNHNnuvcC7Sn310IIc+OFcU6rhXTlNYdAzJ+lHo9HmQhULN/kFzeY/Ll1jLy5eogcNc51xpzaTV0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Tj9ZcU/W; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710475540; x=1742011540;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=BauXWoFtB+pAtGdYhvlKVe0lUvXPUN2j2/1ckRpNZsU=;
  b=Tj9ZcU/Wso2pvll/smC8DaU1EC42EL/BerMyUka+xbClopNCocX9apwE
   wGMcCtAGgdjS42nd74evriIP4KgzqjQyT3rPQ6V/+mMMb35pAqxfppd0e
   U0OI7/cQ8q+DGMJAxjEzQn+TcRMQi8zPv8lzl4LOojV+wGw5bvm05/spg
   UV9ZMApeY09Yjn98zEUovaPU5ojKu8GqfamBQmxhuqAVIDjnwXRZsfPrV
   EY5E0kdq1LltgWknFRM8uEWmqgNVsB65wkzvySl+JFd6DfjZgkBx4U+Hg
   iv304tm2RalSdaLxszMMHT5qJ4RVjRyvnVK0FP6zAiOuzTnpe7/HPydEd
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11013"; a="9143974"
X-IronPort-AV: E=Sophos;i="6.07,127,1708416000"; 
   d="scan'208";a="9143974"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2024 21:05:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,127,1708416000"; 
   d="scan'208";a="17198433"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Mar 2024 21:05:39 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 14 Mar 2024 21:05:39 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 14 Mar 2024 21:05:39 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 14 Mar 2024 21:05:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WZlLJmSNkS98dKUYxdN/icgGuYbzeugzV1I09y+Ljdvow5yBlK1QKqhHh9dHiQLbRUKv/yWV8V24C72Q9Mu7Q3HkJKcP8Cg2qK6HufkpLR3s9MdoL4lVcZe1xzLN2l4UUtUOO4V2e7NwgojwHHVdRYUEfZO9IjUiUQ8RI47yT2N2AYTeGmWDhra/aV4tCbh2xGEQS91UUdvI/FZfhky6TsBh4tsrRqluR2D/6R6/DmcHACmR7oID4PMs33r7Ea3IU8dyaA726C3VGSbegsQosrW5+IXAFZcxTU9BMZ0GHUdipb4vUxsn1qx6aalr+6RGo+6H5WZeXtOvDJI7RrKMGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3aVCgf/+x6hdGaD/JRfho/hDyWz/gkOQXJ3jojhhvi0=;
 b=ajY1T6KD9qKRFxKpOnfGul9q4shK/g+1PfSVB6RwLhQR+qBVXZ+AmG5pT6o/CTGTWyneiMgkTI4wwy+Pba17lWE26Mjml5hf0/08Kk0nJ5esQ6rm2MZbrcIGWNBesaxx7k4cluvBJr+mYb7syjCoOOpgr7Zg02AjT6NxFR2sVKz6hsUEmiZnFnwzvjlxYMKVJ0agoAjOe1R3/viSz54TBgN+AeyH8EBoGBfd/9U/XO7x+5opBT9N4dEX1pxQ9sqOe6kmEuXFiqX2dH8UGjdcsgLUDz/ESalO3RSr3q3BJWHb9rme7YMNMxJrGb1KhoEUap4Rk2UAsegMuUmq51v6+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7200.namprd11.prod.outlook.com (2603:10b6:208:42f::11)
 by LV8PR11MB8678.namprd11.prod.outlook.com (2603:10b6:408:20b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.19; Fri, 15 Mar
 2024 04:05:32 +0000
Received: from IA1PR11MB7200.namprd11.prod.outlook.com
 ([fe80::c990:5065:ed39:c165]) by IA1PR11MB7200.namprd11.prod.outlook.com
 ([fe80::c990:5065:ed39:c165%6]) with mapi id 15.20.7386.017; Fri, 15 Mar 2024
 04:05:32 +0000
Message-ID: <b15f966b-1ffd-43e0-9483-0b1fa9c90ac3@intel.com>
Date: Fri, 15 Mar 2024 12:05:24 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 5/6] cxl: Use __free() for cxl_pci/mem_find_port() to
 drop put_device()
Content-Language: en-US
To: Dan Williams <dan.j.williams@intel.com>, <rrichter@amd.com>,
	<terry.bowman@amd.com>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240313083602.239201-1-ming4.li@intel.com>
 <20240313083602.239201-6-ming4.li@intel.com>
 <65f3b158b9674_aa222947@dwillia2-mobl3.amr.corp.intel.com.notmuch>
From: "Li, Ming" <ming4.li@intel.com>
Organization: Intel
In-Reply-To: <65f3b158b9674_aa222947@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0028.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::6) To IA1PR11MB7200.namprd11.prod.outlook.com
 (2603:10b6:208:42f::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7200:EE_|LV8PR11MB8678:EE_
X-MS-Office365-Filtering-Correlation-Id: 71865814-d076-4af9-69f9-08dc44a5286a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4niZQLLVI8eJ5es9h0HDnQni2Jd8PDEtYpCVUng4CQLVu6xOPSXQ7bt/v5RxTSs1PJa8jaeKt6uDAJ89l73H46EhjBJ1EaJZ/xr0tV/+PkvrVZm9O70aD/hRQvsFB5aQq+NAn0+r9GxAAzG51JY5QOmvrVag7TVlwBO5hS8aCm3jiU3ukrsR+LNtSxXfizczDG58Wp9/L+uiCRejisU61DeIGQsMmZniLWKE+gpqcjOeCaJAkmwLIDTZiYkK6Is/sI5KJkTK5JZzADSP+vPSIO6ZQPyf/UdgsjSApt99E358OWM5lXzo6fgg+47ygl8cOpqgZkLYt4h3kZpLjldtemmL39doxvUgJ7aWH7gX+GCytd/sOhNsvd/+iRss09YK70a65fm5g+VD9Pwx28XRmOVBUq7CeuLykccH9WHPRfcQ9g+Wc3+8Nc1o8HKKKKFhPzYiG8OWGly/NbA3POWW01fOuVkmZexjej+RUDWO+eJKrrl9SBKkxvbryx1DeqJlDPL+q0FEyqYmPhknh8BJgROOQcpYFSM/Be0gV6Jhs+yBbbA+t5w3WUiY4upTZ7ySZPuu/TBB8RnwmHADWTfEdbcZB40Y9dHvC4OS6gtkMAh1g8S2NPhThg6REUwm9b5DhbQGbwnlTQu4jTsePb5S2luQ6dOsnOV4pw2bLbagW9I=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7200.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VUtGa2w5Ykcvb01RVktWYktwNzF6MTZaeHo4azNQbHUrbmZWU0RXNGlhR0dz?=
 =?utf-8?B?UFRPZDYwOXEvL2tIckp5V1FmdEd6Yi9DUllrRVQyK2hMb0ZPRnpJUHFvRkg0?=
 =?utf-8?B?ZW1ja3JzbE5uTnlCdW15UVpHMVdOMVpkUkZ3ek5teGs4ZXREaUFxR1lNQVJM?=
 =?utf-8?B?Y3oyQjdMMGZqdk1nb3JGYkYrVEtOZHdnVkVrMUdyRE9yOUhQWk9tcVFsSUo2?=
 =?utf-8?B?TnpXWXhuK2pMMEJzeStHSSs2aWY0c21BaWZQQzZ5UGxBUlZVV0xJNFRjZnFK?=
 =?utf-8?B?ZEdaZFR1R0tSWU5aclBrYWZwLy8rYlJkUTBISGUwdVpXSWR5eGM4SEJkV2FL?=
 =?utf-8?B?cGloT2pPMnJ4eE1Kc3V0UDJjcDQ1Nk5mZUhYZ1E0NEpMS0JOTWY4Q2RjL3lX?=
 =?utf-8?B?MjlpdlJMelBobkVoWmVFYjN0MElsK2trNDlVVkh6OS8rTXZuVjRFOE1XbFhm?=
 =?utf-8?B?R3BhQWdaMENPWDNsNXZDYVkyM0RrRk5McmR0S2xWMHl4djQ5MDl2NGRKeU5D?=
 =?utf-8?B?TzhkZnBxVFhYOUNlbFpJdlNiZ2Jwamg2Q3V2bEl3OUpNT2hZYXhoQWZwc1Bn?=
 =?utf-8?B?RFhVVk1Rb0NOVzRKSnpuOUZBdDhaTys5UEV3a3B6dVZNZUZ6M0kwV0hUaTJY?=
 =?utf-8?B?eE1aWmpKOGkyZCtqNjlzRm1XSlM2ZiszSmZwRnBiSnlrdlp0UGtBQ25tUStT?=
 =?utf-8?B?SGRLVFpSMmMzRmhrd2JEN1gra2EvM2o1MXRyYnF3V1haTUtGRThVWjQwYjFz?=
 =?utf-8?B?SXMyeUFXWFBnUngrWGZXSzV6M1doNFFTQ2paRlB1NkZpREttR3FGYWtUZ1lG?=
 =?utf-8?B?N3FRNEtoVWpRblMrMVJobFZSY2xBYXdkVlJnYkFzMUZqRmJWVEZla3FzSVFW?=
 =?utf-8?B?NUNPWUJqbVlwRnVLVDhvUWNsMXk3Y1c3Uld6cHN2a3NTRFp6d291VFNnNDFD?=
 =?utf-8?B?Q0NaY1BRa1cvMWF2TExBVVlJQkV5V1M4ZTdGMHlPTHlhWjZTbk9pS2dRQVAr?=
 =?utf-8?B?ZGpUOUJGZjVuaXFoamNtc0VlUExGYjRFNkJPMHFLTGhqcTBUU0cycWpBc3pu?=
 =?utf-8?B?d0kvMkcwRVNzNE1EYldnYjB6VkNsWjI5QkM1dk9iZ1BjOVdkT281bmRSTyt3?=
 =?utf-8?B?U09TUW1IUmo2a05nWmYzQVBZZVJESC9QTmlVQlN0a2cxQnlIWFRrN3MzZEgr?=
 =?utf-8?B?dFJiR3o1V3BzbnZzeWwyWkRjQkxmQTZKMXpMM1pqTmpNQ3o3QXlyS3ptNGho?=
 =?utf-8?B?UjZDaXdUczlNbVJMaitacnZleWxKdGNhc2xCSFcvaFNlZk1UWFRGdStNQnZh?=
 =?utf-8?B?eXl2a1g4ZzBTYWhFekJ3bHR5djNMeEtDTFJ6a0QwbUNUOStqU2tZbUNJMm5U?=
 =?utf-8?B?Vkxqb3NhTll5SW1MOG1EQUtseFBqVW00enJ2dGNLS1l1SGducm5MaG01SXJ2?=
 =?utf-8?B?TkdMeEZTbTF5cVBSaEM0UFgzdDVBejNYejUxWkdyUVVOZXlSM29WaFlFMmhw?=
 =?utf-8?B?YjRLbWRWOFZnVzhtclJWLzVZSWxTOVAvR1NFOFdOY0Zyek1ITXJQalExMTFu?=
 =?utf-8?B?VXVuNlRQV29CVldtMmtTcFRZS0ZSTytMYi9FWWw2c2htMHI2ckNEYWRpVlRG?=
 =?utf-8?B?SFpma1FCMGg5QkFwMjNRZU11bk8wZGcvYnI2cFZYdmx0ME9oOFRtSFBya2NI?=
 =?utf-8?B?dXlrQnJmUkRDd01qMk44QzZmZDJHNGpMaURtMGlvSkRGNFpPMVlFYW9xQkZm?=
 =?utf-8?B?aU1zczNnSG9qSWpHVUVNZlFJYVBER0Ixa01Vd3BieWxRc3BtSW9OakxzQVRl?=
 =?utf-8?B?VWh5Y1Z5eHgzb3lBSmhPaHdyUkRxazFwODFMWTllem1jWDl0MkpIcE5qT3F6?=
 =?utf-8?B?SmpTaHppVUFIMzc5aU9iWVppWVljUGNrU25UWFJhREc3TU0vT0ZBQ2lmQUk2?=
 =?utf-8?B?WnBMWWtXdnoydHVlQWxTRlFKWm5zWS8ydFVyNzdFdTkyUUtNWE1na1Riem5s?=
 =?utf-8?B?ck9lWGhTRHJhRm0rZjhyUXFBNzJaLzJjeTNwS0k4VTg5RzJCeWNVcStkS0hT?=
 =?utf-8?B?RjNaVlJsSG0wQ3Zla1lBV3RjRXBYSitwdFN1QWlZbEdhQng5SHRXcWNnRXVQ?=
 =?utf-8?Q?3Am/NTUFjNZXae1l9rjnQHLIn?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 71865814-d076-4af9-69f9-08dc44a5286a
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7200.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2024 04:05:32.1097
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y+ubC6MB2GINrhHer9El7NK9qA7n1RiIHmDBrcX+NZhlGJRGWzHAV9C5xlnSVuI6N6aWCdC/LNfStTxzzP7jdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8678
X-OriginatorOrg: intel.com

On 3/15/2024 10:24 AM, Dan Williams wrote:
> Li Ming wrote:
>> Introduce a new helper function called put_cxl_port() to instead of the
>> put_device() in order to release the device reference of struct cxl_port
>> got via get_device() in cxl_pci/mem_find_port().
>>
>> Besides, use scope-based resource management __free() to drop the open
>> coded put_device() for each cxl_pci/mem_find_port().
>>
>> Suggested-by: Dan Williams <dan.j.williams@intel.com>
>> Signed-off-by: Li Ming <ming4.li@intel.com>
>> ---
>>  drivers/cxl/core/pci.c  |  6 ++----
>>  drivers/cxl/core/port.c |  9 +++++++++
>>  drivers/cxl/cxl.h       |  2 ++
>>  drivers/cxl/mem.c       |  5 ++---
>>  drivers/cxl/pci.c       | 12 +++++-------
>>  5 files changed, 20 insertions(+), 14 deletions(-)
>>
>> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
>> index 6c9c8d92f8f7..7254484330d2 100644
>> --- a/drivers/cxl/core/pci.c
>> +++ b/drivers/cxl/core/pci.c
>> @@ -902,15 +902,13 @@ static void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds)
>>  	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
>>  	struct aer_capability_regs aer_regs;
>>  	struct cxl_dport *dport;
>> -	struct cxl_port *port;
>>  	int severity;
>> +	struct cxl_port *port __free(put_cxl_port) =
>> +		cxl_pci_find_port(pdev, &dport);
>>  
>> -	port = cxl_pci_find_port(pdev, &dport);
>>  	if (!port)
> 
> Keep the declaration separated from the rest of the variable
> declarations like this:
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 0df09bd79408..2d1ef35fe99c 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -916,12 +916,11 @@ static void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds)
>         struct cxl_port *port;
>         int severity;
>  
> -       port = cxl_pci_find_port(pdev, &dport);
> +       struct cxl_port *port __free(put_cxl_port) =
> +               cxl_pci_find_port(pdev, &dport);
>         if (!port)
>                 return;
>  
> -       put_device(&port->dev);
> -
>         if (!cxl_rch_get_aer_info(dport->regs.dport_aer, &aer_regs))
>                 return;
>  
>>  		return;
>>  
>> -	put_device(&port->dev);
>> -
>>  	if (!cxl_rch_get_aer_info(dport->regs.dport_aer, &aer_regs))
>>  		return;
>>  
>> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
>> index e59d9d37aa65..6e2fc2fce7c9 100644
>> --- a/drivers/cxl/core/port.c
>> +++ b/drivers/cxl/core/port.c
>> @@ -1671,6 +1671,15 @@ struct cxl_port *cxl_mem_find_port(struct cxl_memdev *cxlmd,
>>  }
>>  EXPORT_SYMBOL_NS_GPL(cxl_mem_find_port, CXL);
>>  
>> +void put_cxl_port(struct cxl_port *port)
>> +{
>> +	if (!port)
>> +		return;
>> +
>> +	put_device(&port->dev);
>> +}
>> +EXPORT_SYMBOL_NS_GPL(put_cxl_port, CXL);
>> +
>>  static int decoder_populate_targets(struct cxl_switch_decoder *cxlsd,
>>  				    struct cxl_port *port, int *target_map)
>>  {
>> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
>> index b6017c0c57b4..476158782e3e 100644
>> --- a/drivers/cxl/cxl.h
>> +++ b/drivers/cxl/cxl.h
>> @@ -743,6 +743,8 @@ struct cxl_port *cxl_pci_find_port(struct pci_dev *pdev,
>>  				   struct cxl_dport **dport);
>>  struct cxl_port *cxl_mem_find_port(struct cxl_memdev *cxlmd,
>>  				   struct cxl_dport **dport);
>> +void put_cxl_port(struct cxl_port *port);
>> +DEFINE_FREE(put_cxl_port, struct cxl_port *, if (_T) put_cxl_port(_T))
>>  bool schedule_cxl_memdev_detach(struct cxl_memdev *cxlmd);
>>  
>>  struct cxl_dport *devm_cxl_add_dport(struct cxl_port *port,
>> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
>> index c5c9d8e0d88d..5aaa8ee2a46d 100644
>> --- a/drivers/cxl/mem.c
>> +++ b/drivers/cxl/mem.c
>> @@ -109,7 +109,6 @@ static int cxl_mem_probe(struct device *dev)
>>  	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
>>  	struct cxl_dev_state *cxlds = cxlmd->cxlds;
>>  	struct device *endpoint_parent;
>> -	struct cxl_port *parent_port;
>>  	struct cxl_dport *dport;
>>  	struct dentry *dentry;
>>  	int rc;
>> @@ -146,7 +145,8 @@ static int cxl_mem_probe(struct device *dev)
>>  	if (rc)
>>  		return rc;
>>  
>> -	parent_port = cxl_mem_find_port(cxlmd, &dport);
>> +	struct cxl_port *parent_port __free(put_cxl_port) =
>> +		cxl_mem_find_port(cxlmd, &dport);
>>  	if (!parent_port) {
>>  		dev_err(dev, "CXL port topology not found\n");
>>  		return -ENXIO;
>> @@ -170,7 +170,6 @@ static int cxl_mem_probe(struct device *dev)
>>  	rc = devm_cxl_add_endpoint(endpoint_parent, cxlmd, dport);
>>  unlock:
>>  	device_unlock(endpoint_parent);
>> -	put_device(&parent_port->dev);
>>  	if (rc)
>>  		return rc;
> 
> When converting a function to use cleanup helpers, it should try to
> remove all gotos, something like:
> 
> @@ -159,21 +159,18 @@ static int cxl_mem_probe(struct device *dev)
>  
>         cxl_setup_parent_dport(dev, dport);
>  
> -       device_lock(endpoint_parent);
> -       if (!endpoint_parent->driver) {
> -               dev_err(dev, "CXL port topology %s not enabled\n",
> -                       dev_name(endpoint_parent));
> -               rc = -ENXIO;
> -               goto unlock;
> +       scoped_guard(device, endpoint_parent) {
> +               if (!endpoint_parent->driver) {
> +                       dev_err(dev, "CXL port topology %s not enabled\n",
> +                               dev_name(endpoint_parent));
> +                       return -ENXIO;
> +               }
> +
> +               rc = devm_cxl_add_endpoint(endpoint_parent, cxlmd, dport);
> +               if (rc)
> +                       return rc;
>         }
>  
> -       rc = devm_cxl_add_endpoint(endpoint_parent, cxlmd, dport);
> -unlock:
> -       device_unlock(endpoint_parent);
> -       put_device(&parent_port->dev);
> -       if (rc)
> -               return rc;
> -
>         if (resource_size(&cxlds->pmem_res) && IS_ENABLED(CONFIG_CXL_PMEM)) {
>                 rc = devm_cxl_add_nvdimm(cxlmd);
>                 if (rc == -ENODEV)
> 
> 
>>  
>> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
>> index 4fd1f207c84e..d0ec8c5b1e99 100644
>> --- a/drivers/cxl/pci.c
>> +++ b/drivers/cxl/pci.c
>> @@ -473,23 +473,21 @@ static bool is_cxl_restricted(struct pci_dev *pdev)
>>  static int cxl_rcrb_get_comp_regs(struct pci_dev *pdev,
>>  				  struct cxl_register_map *map)
>>  {
>> -	struct cxl_port *port;
>>  	struct cxl_dport *dport;
>>  	resource_size_t component_reg_phys;
>> +	struct cxl_port *port __free(put_cxl_port) =
>> +		cxl_pci_find_port(pdev, &dport);
>> +
>> +	if (!port)
>> +		return -EPROBE_DEFER;
>>  
>>  	*map = (struct cxl_register_map) {
>>  		.host = &pdev->dev,
>>  		.resource = CXL_RESOURCE_NONE,
>>  	};
>>  
>> -	port = cxl_pci_find_port(pdev, &dport);
>> -	if (!port)
>> -		return -EPROBE_DEFER;
>> -
> 
> Here again don't move the cxl_pci_find_port() earlier in the function,
> keep it after the assignment of @map.

Thanks, I will do that.

