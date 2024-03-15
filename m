Return-Path: <linux-kernel+bounces-104033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C8EB87C811
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 04:43:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E76081F21762
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 03:43:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E67FD53F;
	Fri, 15 Mar 2024 03:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aiiyTCT+"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0E9B11C85;
	Fri, 15 Mar 2024 03:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710474201; cv=fail; b=I+IGVu5X6qshjTkFBOgpFTk8OgpcnBNVQPA8tm0pqigOY9Ez82vpz+6U+Dj4IQ2CCeFBTQPlBjTOYS7+a+R2K0V0JJelVfiuy2Tjoq9NcM1S8w+gx6v/VejRqxOVvwVw5yXc86dNcJ1A3rK/jAHpB9RZ3PkGGo3XAorgGk2HS58=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710474201; c=relaxed/simple;
	bh=JesDqGN42LvMmR/xA3+NRRWwWVUgwp8puTSK08BigdQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=raS6l+d8ozz7IUWoUFp/NZDkdLSb+QCYt+xN2L9XKdEySjG6uayfWmblcgTp+bmjCJMVSza7sAW8N4yXQW6dLscVXXzxTyw6EV0Wi9ltzlxfij2ie+Hf8CqesbUE7OZmht9/bdf+IYgqVeir2Zj+tI1qIkTvZqXKueNtDeAMkjA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aiiyTCT+; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710474200; x=1742010200;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=JesDqGN42LvMmR/xA3+NRRWwWVUgwp8puTSK08BigdQ=;
  b=aiiyTCT+Q7aOY60R+1ldLALCk65kf4tH03pCS3LAFId3L5z9J1lsj06z
   Yng4bcKWkuZ6YdCmjgNEyo8ShEhKbR5U1/fWp7+Sllvim2pHTBMu6MLdO
   jEUEr3yy6pv8Vo0MukIy6LgS7WDi79ZEIRTU5NkSe2g4tdQvLPIeWEYQZ
   0/0tTJVvfaPO2ZPHQ78dBl6JkVz+MmFulFdsbbvGDhmjx2UrwWjZitgsP
   7AoB6vRHPJthlP1PPM0rLZSCyNJ+P5E+MdrmAoOL+nqcmOwmq2I+iObTB
   Kmof55Bsu91todvnGl8PMNExfX+99otuQraYRdz+YXaKSQQ8eBzRg/BPs
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11013"; a="5532917"
X-IronPort-AV: E=Sophos;i="6.07,127,1708416000"; 
   d="scan'208";a="5532917"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2024 20:43:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,127,1708416000"; 
   d="scan'208";a="13140483"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Mar 2024 20:43:13 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 14 Mar 2024 20:43:12 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 14 Mar 2024 20:43:12 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.41) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 14 Mar 2024 20:43:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BYgRACTBYIuBe9GHeY76Rph1QJZeK6QTG7agzgdq/7nHWmetkfEn64zEV2Bi/L9xUUCp/RlfYSW/3kXWZZ2or/1Bczo5Zfk1VUYH492ovNSiz1razuF+lZ2HATR6eeJpCu1v7Y3wVKtP1KvjMOEg3uq4xUTvnjdl0GrGknlcvsdFIr4JNHlVPqfF/wV0MkiD7c8KPRLi9VnYlbH58YFNZFgJbcVUdyePwIPW3vb4evWapSXrIo2DvNpivRQcskUtpDRHOGxJJ8XFvTcm2O70oF94wAKxisc1vAGbDjIpvTQWn16F9coBZJP8D6YtPOLwEDSptQmrI1ivYJvrEfbbrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AIbNw19qE+X563MmOZEIvm3+UMuh3yZZS7L3VvliA0w=;
 b=CkUNcc5CD9Q2stT+VAu8p0XpIcFzVwzvs3UI0ISB5WlKLzy1wdY6lVAVwIFIoWXPrBAi2CnLbCvULlZGq4L9OSn52Uj/tKKAPTlhKjPfy4mClsAjOixQAzcj7KAdKYFCPXp/w00zG7C3mUESzRUH6oaL4E4LC7aO8HTOHnqBOvrZ2kxntSZJvt9SVAVzefe19NZFsRqvFvWTXZA4kW/pONiEaRDljcNiuqeHvsBOlpE7iaiqD5+/WuEn9KZp57vrMHAdcWY4Wjoz7e85nDn7fUNglAtay4qHv66tvm4GEzHQbsh1wsqljb/YsbBAFEFdYhIF+YgO5We/d0o45xQ73w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7200.namprd11.prod.outlook.com (2603:10b6:208:42f::11)
 by CY8PR11MB7778.namprd11.prod.outlook.com (2603:10b6:930:76::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.17; Fri, 15 Mar
 2024 03:43:09 +0000
Received: from IA1PR11MB7200.namprd11.prod.outlook.com
 ([fe80::c990:5065:ed39:c165]) by IA1PR11MB7200.namprd11.prod.outlook.com
 ([fe80::c990:5065:ed39:c165%6]) with mapi id 15.20.7386.017; Fri, 15 Mar 2024
 03:43:09 +0000
Message-ID: <f2dd9f36-5e69-4c6e-9640-7140a694086c@intel.com>
Date: Fri, 15 Mar 2024 11:43:01 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 4/6] PCI/AER: Extend RCH RAS error handling to support
 VH topology case
To: Dan Williams <dan.j.williams@intel.com>, <rrichter@amd.com>,
	<terry.bowman@amd.com>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240313083602.239201-1-ming4.li@intel.com>
 <20240313083602.239201-5-ming4.li@intel.com>
 <65f3b2b29cfe9_aa22294e8@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Content-Language: en-US
From: "Li, Ming" <ming4.li@intel.com>
Organization: Intel
In-Reply-To: <65f3b2b29cfe9_aa22294e8@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0019.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::15) To IA1PR11MB7200.namprd11.prod.outlook.com
 (2603:10b6:208:42f::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7200:EE_|CY8PR11MB7778:EE_
X-MS-Office365-Filtering-Correlation-Id: a39af957-3bf8-4a1b-e8a1-08dc44a207e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 35t2gVX3iLsR4hCm+8+2b4cWgFkZGiY6PSlKSXTQZUwlVht80cHQRUNEFlpZJWrQ5sINPkIm4mf6oHQOkb9pPrInriAjBJCagkVzhemBYQ2OiOMxfNW4scJdRLATdlxf9giSjKdizuqONEZNiG5IqpQmJNzw6kJ9twxoR8Mf6BDIdAeiqEYCFZ2XIyP71HEPJWNzGCgWZCSIqpaEmQH1cCNB0QbshHoSNXXvlpjZzIYlM4xFVgoPmv0ywUqpYwqe/hy1MZVecZYM+/WKQXsJky+Rw3WQTuFrWhIzoJz2jJHvtcwQb43Z84dRfzVMA6uXKDszHcdCG8T3VgsdoVCObTNxO1Ikgu/POH35H1UXkwZSq85tj3SoFN+arVB0A1UpPPHXxPmWUra666nXcnrP0jdxPMVnuzRtn4kwxs5Jg0UW8C0XZbAMASbSV5u2ZBcX+B37V0XEP+Z0UgLTujZFwvXNP/iT56l6/1bHy/oZOjXzYo0dUeIMgSi/9W3gjpfO3vIssEf04MTQrwpBt3PlgXXveXwfE2LdX+1vrVKzSGQDhLmC1EFq7fnfvOj6caUP2pB+NEmLzSsDCNfbbDAl8O5EBm3KbMBgejRZr6tYlt9EdEh6dW1d9YzQLVGn52kRyTykeM41rBxdHAejG/iv17SvrqVFPtvSdhuxKhui2Tw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7200.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V3dhaTdpakVhUDU5UnZJSVRuYnloTmpaY2hUY0Z4VWhuelRyNVBGT1VoVll0?=
 =?utf-8?B?aUNtSVZTbmRYejFWWFh0am1qWVBJZlEvS0dGNFp2Y1g1T0JhaHJaQnF4Q0Zs?=
 =?utf-8?B?S1I1c2NwUVlLdURLdndEdFprTElkclpqaWZBZGorc1ZjSTJxNHE0cXIvZjVG?=
 =?utf-8?B?TWhVWFp6UnRMdmQ2L1I0dWdCT2pxeEE5cEFPS0EzZEVFU091T1VtMUpmTGVx?=
 =?utf-8?B?cFJEYTQrMWxrZXBzS0VLQmY4dk14YVpScnRRYm5rYUZURmlPYlM0YlY1UWla?=
 =?utf-8?B?dXVtdUR5bUhwdmFhcjJOcGVPVzlQbFZsaFdYRElxbDEvYVFIdTRzeEZXZDNF?=
 =?utf-8?B?aTNsb3hhT2lrVlZSbFNtZEh5N3NGMmF5QVV3N1V5RElsYUhOMVM3aG9WeHN3?=
 =?utf-8?B?blZxU2JLOHhFdXlvaHVCN05kMktncVR3YTJFSjhueWdXNDkvenBZNG42QUd5?=
 =?utf-8?B?WlZkRS8veXowaGMrUDNQSExNQlRjRTc4RlBXSFJLZGQrY0lNcmxvZHE1M0NQ?=
 =?utf-8?B?cmE1cHQreTRsQzk2UE1JWitQakxVZS8xOHQzMXZ1UFlDTmI3N3pDS0sxT2VR?=
 =?utf-8?B?SzNkR2x6c01oNGkyMGIxSmltM2pBMURsWll6YkRvZzlzVGgwWFRaWmI3R3l1?=
 =?utf-8?B?RE01Qis2UUQybmtPMldTR0t3empMejRtcjBGaXFBbllOWFptdk9YcjVQNWZV?=
 =?utf-8?B?SlJ2MkVTNW5aaC84SVRKcVZ1MzBXc1Y0QTZVL1NidC82RVZRTmgzcTFCRy9n?=
 =?utf-8?B?YTJkbTBFVHJuaEZ4QlIrTzhZb1FXcEhYZTBjNVA2UVdSWXJCTXhwVjdudWlL?=
 =?utf-8?B?cFB2U1hRMjNBLytaYnVCNHd0b3c3Q3d3dkRDVjZ5M25ab2JrNTNOeGFKNUsy?=
 =?utf-8?B?RDl4WGpZamg5SVV6R0lkWHZOS3NjQTZwS3dDRDNkdUJGSFNJbVRYV0UwVzdl?=
 =?utf-8?B?TjgxN3FIeEFUVUVzNnBYaHJwNVlOMjJSVE5xOEtobnRqN3o1a1QwVFJqbm4v?=
 =?utf-8?B?OW5wSEZIdFBzeGQ2SHlpN2l6OU5TZVVXWG9ONVBZQWd1b0IvSllPQWEzVDJq?=
 =?utf-8?B?dk1JUGc2QW51ZnZDVzUyRmc5UkFTVEFWaThLa05qUktrdFZYMmgrTXk0eHhm?=
 =?utf-8?B?cnpJdDdBeEJHZHJyc3dmaC9vdG5sWlRvNDBoMHVMcjJPa0wwcEU4TldBVExj?=
 =?utf-8?B?UStxVXhvVmJWdERkWkZ6bE8yRml5M08vdnZOVTJzVC9EY3dTMTIxUlA3bHZn?=
 =?utf-8?B?OC90bE5VYVA0UWh2a0RBT1dPemR6OEFtUE9PUS80V1pFVHlCZVpwVU14SHNa?=
 =?utf-8?B?a2h3em5qZThrQkN2WDBnTGdhL1JROEE3M3hMVkEvUzY0UkFNVGZSc2YvWXZa?=
 =?utf-8?B?ai9jQStrN0xadXZWVTNvQ3AyNkJlRFNTVjNtWmxVclRLVjlGOGhnemxKZm1r?=
 =?utf-8?B?YVk5VWJ1QWhpY1lYelNoVUxqdzFBMGt3ZXQzbCtSL1RvaEpMVmF5YUdRK2dW?=
 =?utf-8?B?MUhUVDRQMnlqSGRTV2VGRE1Gc1VnNnEwclRjQnpMZ2lnT2tXaEIyR1gvdzVW?=
 =?utf-8?B?VTk3cmFURjV5WHRCbWJraHhQQ2Q0YzJZZ0IwSW05bTRRZm4vUjNQK0JicG51?=
 =?utf-8?B?L05TTG4wakFBNlNjMUsra3NaOWpHS1ZMb21kQjU5VXdVYWFmTzgzZTlLSDAy?=
 =?utf-8?B?ZkY5UkU1RHNuNEpTNmF5bVJDVXZ4clVRUTd4SHVoZVBpV1VKejllNHJVS1ZP?=
 =?utf-8?B?V1l3SUNuS1I2OVVTb0dDYUpPcHlZWUdPdjU4bDFCbTgzanMrNEI4ZVRnQTVa?=
 =?utf-8?B?MHBtaStJL2taZW1GM2dReEZGc1BxalRhSDBKMEZtOG5oZFcyanVkbWp0S29s?=
 =?utf-8?B?SG9RYUhvNitOY2I5Q0JyaGZZZXRSck9vc2N4OGpkV3BtZS9QRmxjUjMwdjY1?=
 =?utf-8?B?eVM0Z2xIQWNDV09WdzlTRmM0L3l5TjQySkdGVSs0UnNzWnpkbjRnMzhpc1RC?=
 =?utf-8?B?VnJWVkRuRWJBR0ZuNXR4a05WeVlVUUZoeitJUkdsMjZadnVLNzNsSE16NVph?=
 =?utf-8?B?dGlkb05vcVZWVnhad08wL3VNZ1Fya2JlUE1jREl3c09XUkhQdnRwN3EyVkYr?=
 =?utf-8?Q?f0R1tOLk6zZz9NNFQZnWrPe9I?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a39af957-3bf8-4a1b-e8a1-08dc44a207e2
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7200.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2024 03:43:09.0625
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j1DXsWZOkaOxh8J0gH9gn9Bv1AzHnjUZpqZd4q83Q7XOORSIppZ+DPG5vrxGGCuzr2GF4K+BJ4IW/TLA9ycHmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7778
X-OriginatorOrg: intel.com

On 3/15/2024 10:30 AM, Dan Williams wrote:
> Li Ming wrote:
>> When RCEC captures CXL.cachemem protocol errors detected by CXL root
>> port, the recommendation from CXL r3.1 9.18.1.5 is :
>>
>> 	"Probe all CXL Downstream Ports and determine whether they have logged an
>> 	error in the CXL.io or CXL.cachemem status registers."
>>
>> The flow is similar with RCH RAS error handling, so reuse it to support
>> above case.
>>
>> Signed-off-by: Li Ming <ming4.li@intel.com>
>> ---
>>  drivers/pci/pcie/aer.c | 20 ++++++++++++--------
>>  1 file changed, 12 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
>> index 364c74e47273..79bfa5fb78f4 100644
>> --- a/drivers/pci/pcie/aer.c
>> +++ b/drivers/pci/pcie/aer.c
>> @@ -996,11 +996,15 @@ static bool is_internal_error(struct aer_err_info *info)
>>  	return info->status & PCI_ERR_UNC_INTN;
>>  }
>>  
>> -static int cxl_rch_handle_error_iter(struct pci_dev *dev, void *data)
>> +static int cxl_handle_error_iter(struct pci_dev *dev, void *data)
>>  {
>>  	struct aer_err_info *info = (struct aer_err_info *)data;
>>  	const struct pci_error_handlers *err_handler;
>>  
>> +	/* Skip the RCiEP devices not associating with RCEC */
>> +	if ((pci_pcie_type(dev) == PCI_EXP_TYPE_RC_END) &&
>> +	    !dev->rcec)
>> +		return 0;
>>  	if (!is_cxl_mem_dev(dev) || !cxl_error_is_native(dev))
>>  		return 0;
> 
> is_cxl_mem_dev(dev) will always be false in the VH case, so how does
> this change help the VH case?

Hi Dan,

I think it won't be false if the CXL memory device is an endpoint.
pcie_walk_rcec_all() will walk all pci_dev in RCEC assocaited bus ranges. So these two checkings can help us to filter:
1. CXL memory device is an RCiEP associated with RCEC in the RCH case
2. CXL memory device is not an RCiEP, so it should be an endpoint in the VH case.



