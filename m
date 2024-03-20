Return-Path: <linux-kernel+bounces-109449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C3C3881952
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 22:58:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A3E51C20DC2
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 21:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67B7385C51;
	Wed, 20 Mar 2024 21:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mT7A7U9n"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D6C4F8B2
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 21:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710971901; cv=fail; b=PcKwXN6TgUf682vzg7iDnp5qcBqanxhpArI/ubGR/yYE2SFLx6bdJ+ABKWgU3fWOmnxFno2wnQIEkD/Cx51M/yUDsyOgeV6dQg0laGTMuc7FET3I9VRQXQ/FtJR9Pg1E2RQbVY06NhaBy7/Fb32HAA8Ty3XWA8z8ZGDWdJ7fa/I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710971901; c=relaxed/simple;
	bh=V9QAF4nub/0he3HPY4U2N2GhpwOd+uFp+iAG+9g8+HU=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KvR3TmlPgyotaXVaczSSo3/yRVmf1KjB1bRecmn46I6eOZAeP8crxWvKV7k/ezxh1EOiV9xQ6hp0zgpYS1p3JhrTTVHgJ5RpLb8SNMJ/cKlca9wmdckfKATSZDDyYvYm8H41MOWC11l2n++DAnDel94yb5IYk5cyBcP3Q3jFuWA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mT7A7U9n; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710971900; x=1742507900;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=V9QAF4nub/0he3HPY4U2N2GhpwOd+uFp+iAG+9g8+HU=;
  b=mT7A7U9nHWqqXuCgh/08ANBMQ2rfOeTWjyUbe/wusAUbz/u/3+k9JzSK
   hgjoOI8fqgL/2vI5Sp7fxAe9vPFd3OAZ5RTHtN6srSXFSIlw7wv0yeDSW
   7JhX60TA3tmXcD/iEr8eWLc0SZ8S0v/3YmjKF1W3DGP9oQkV64BGzW/nI
   9m01YghoULU1Am93a7pivl8AQFBrD072SiIsUG0x6oiCrB8f9OkAVnTAf
   sDj1EqVhMsOIevqxh6KhUAJmIH+UeU92KQhi040/KCgZgXKiTdZs+qa7R
   a8OHf3Hpguw7st29GD7lO4l2vqyvvpaGT8MR1k7/MPVjTNC2DKK6/BeC+
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11019"; a="17383196"
X-IronPort-AV: E=Sophos;i="6.07,141,1708416000"; 
   d="scan'208";a="17383196"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2024 14:58:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,141,1708416000"; 
   d="scan'208";a="18766699"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Mar 2024 14:58:18 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 20 Mar 2024 14:58:17 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 20 Mar 2024 14:58:17 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 20 Mar 2024 14:58:17 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 20 Mar 2024 14:58:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f3HYFFAmUhyjcJL2BSN5U5A4Kv9nzhbr3sge3myh395KxVV0mXUyL+DFD81h/09s17PVDusRyRUzQt2HrwMXaar3ne8dMHsObhhmYsWLKBrQTtskxdoSQwzSBoOX1yKdDjElsLPVqsd2LAkK/lAIyZSycW98wBb/dUhB8Ok4nj8tC4c7a3VHdYZbCCXr3KLSySiY6CNZQOjH6ETvye8bVikT9zEMZzd4PnNySv+GNKc3X2AASvXid8MMja4Kp4ydyrsMW01/kzpISML5ZwPBOR9Tbpj29qR/LMQMcfTdyfqVCGT3lAT3sDYoJPeRmdAGu6vEVOT4PXWqXYRvapatxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u6AxB/j8OZRB1LOUG6AulWgwzK82nUPWVx3Y/0qwkPs=;
 b=WmhvrfnegplDKzE24piqKBNpAewtXpkKiUEbS2KWvlpaAx+URFvnZcM8H/RPdv/+ZWbk7vOtSRH+1MxpNTaKecIvClGpS0iSMMMry9TdL/qASjEhlQLEOQvQVlZxKpcOo72JimP6YsLygR2bc/Pw/HGaMHX8RAkbjpRDdlQbCb/Q9FNVsNq25Yvdb8lUJo0lR6zALNW2W1nv/KfE5fYgNkJraPWaDaJWs3Jflux6jRpg5f0iDL94W1JGmPHrZqTGWouE8G4qNMH0RUflC5PYeMrDleLjSnfwAVyLaT0tchu4sVmhRYD5qbEAuVg6PbcPqXuY/jLSWkDNAwQM1YxnxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by MW5PR11MB5930.namprd11.prod.outlook.com (2603:10b6:303:1a1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.11; Wed, 20 Mar
 2024 21:58:14 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ef2c:d500:3461:9b92]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ef2c:d500:3461:9b92%4]) with mapi id 15.20.7409.010; Wed, 20 Mar 2024
 21:58:14 +0000
Message-ID: <3bdcf7c2-16dc-4bae-8595-9a4e6f2518a1@intel.com>
Date: Thu, 21 Mar 2024 10:58:08 +1300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] x86/kexec: do unconditional WBINVD in
 relocate_kernel()
Content-Language: en-US
To: Tom Lendacky <thomas.lendacky@amd.com>, "Kirill A. Shutemov"
	<kirill.shutemov@linux.intel.com>
CC: <linux-kernel@vger.kernel.org>, <x86@kernel.org>, <dave.hansen@intel.com>,
	<bp@alien8.de>, <tglx@linutronix.de>, <mingo@redhat.com>, <hpa@zytor.com>,
	<luto@kernel.org>, <peterz@infradead.org>, <rick.p.edgecombe@intel.com>,
	<ashish.kalra@amd.com>, <chao.gao@intel.com>, <bhe@redhat.com>,
	<nik.borisov@suse.com>, <pbonzini@redhat.com>, <seanjc@google.com>
References: <cover.1710811610.git.kai.huang@intel.com>
 <e1d37efb8951eb1d38493687b10a21b23353e35a.1710811610.git.kai.huang@intel.com>
 <tvembdwwh4immxytlfzlhpvd42dlfsz7sddb7msk23kdduhu3t@ogpc66hklorv>
 <38fca2fa-11b2-4eb7-9e59-dc5d524d172e@amd.com>
 <689bbd29-aaf0-452e-a97f-41b8e3aa6224@intel.com>
 <5a2441a3-4d7e-4fee-bfa7-65b53376b0ab@amd.com>
 <e677ab03-8b25-46cd-90ac-cacae6ba5027@intel.com>
 <af42b662-1183-4968-807c-96b37166d316@amd.com>
From: "Huang, Kai" <kai.huang@intel.com>
In-Reply-To: <af42b662-1183-4968-807c-96b37166d316@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0180.namprd04.prod.outlook.com
 (2603:10b6:303:85::35) To BL1PR11MB5978.namprd11.prod.outlook.com
 (2603:10b6:208:385::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR11MB5978:EE_|MW5PR11MB5930:EE_
X-MS-Office365-Filtering-Correlation-Id: bd5be842-5510-408a-2249-08dc4928d780
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qUkElSXud551KeQOPChdDuDhLT67rZBogcc+MojGEmMEmkhrTKtYmG3a+hs69K8CttbZyKMCXUQ+/Xeclbifi+b+iEOI0kDaNC58a0WDLJh/i03zQkH3UG023GLf0deKJIRQyV1QGaAWVO+pfgZXlvRz8UVNREXV+PcOsGFx9uUZcDDAyDrAYMICXw6hvNZNfeSDkHw0cG61GqJmOwFV4/NhQHXVcnlsk/S8ti6C9ICdL5LVnR4JtXKPhGHF8DCFHVgGKtKOelIhmDFY73c1wqXhdHZF372UrcXHVA8X3fppTM0iba/z/vHXcroSQxRfzzsNUka1owFqkXDNjsjqc1jgyttMTQ4hkdRx06l/gn0N8W9Bsunqe2wn2Lp9mFmCoT+8DV5IWmQRX3PEEKRUdhjAbm+r5mxvZpDsp8TYWh99mXptwNrHMRB3iUih5Oe9MFL2TpOg8LRVMgjhVWA3FaQnXiA+ogpXyV9z7pu/wkYf9B8TEVQGcLYJgOQfgmvFbMoVKgZFeIjbCAbxfkSexknk74h1L5sn3BvOQ6Ax2vwEszI+cvFJ8wJ863cfQN+3IupjasEwKrxDIWxApkuKCF+HbckHYrk5OCIGECtbbpr4Ws/An5Wr1QRNxXiecFejzA6AZf1jbLb3yndXf4rWusF8XiDw3iFdAEesg4eII0g=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?alQzb2xLUk90Ky9jMDJSR1hFWkZheHJyang3SGlNL0JZNzRCSnlBeWNBYTdv?=
 =?utf-8?B?Qzdrd1lnQXM5ckNLQXhXaDhUYlMwRjdOVVhiZ09nK2hXeFNtanlwTzE0OTl3?=
 =?utf-8?B?MXFOMHMzbGtLcEFIZW83ZTRqVDVaTWhiSU04bHNZekMzbXlBblRBelNUQXdW?=
 =?utf-8?B?ODdaMXBqdHdGOWh5WmdiOHhjd1A1aHh5K1E3ZUhPcDNva3hlQit1Q2pUUjha?=
 =?utf-8?B?RGhCRnZycjgyNGRsZkowWEI2ZlF0eFVZU0N2TkRrUzFvcGFndWpURTBQTURE?=
 =?utf-8?B?eFFxNktwSTZoWU1mYzUyRDJESjRia3FzaDZsZ2kvVkFBNm9hRTJqaE82eWtS?=
 =?utf-8?B?RWxBeUdPdHJMcVpEbjFTYXpNUll4VWJFWG9aN1lsZ292RHUrWjZUdmV6cm5C?=
 =?utf-8?B?MFhUTzBVdmJ4LzI0K3F0QmkrMmE3YVdMNmlud2VycThYSklPZWJaYW9XSDdh?=
 =?utf-8?B?NlJwaDRWMmhXaGJxSjk2Q1pjK1F1NTd1c3VGbktXRVZ5VFQrczErNkdhSUl0?=
 =?utf-8?B?Rlp5R1JLZnJ2K3FNa012aFhpWWFXVE5TWGM3QVVDL1hUUVFtaTZ1TnVRZXQ2?=
 =?utf-8?B?a05DSi8vdG85UG92U3Z6alB4djB3b2lkMzdhMDVTeU0ybVhpMkU1V21IaVJm?=
 =?utf-8?B?dU9TVWNmT3FHMG1EMkp0RFoyeEt1QXBlU0ZwUnZwMW9Ca09ScldMaTNQSHFQ?=
 =?utf-8?B?QUhqMVhqaVlMcGMxMVBXR1VkbU9IbzErQWdHdDF2djUrcTd3UUgvOUN0aWlD?=
 =?utf-8?B?NTRrSlhzV1BNUitkbXNhWW9LTzdpUUxDbmZraXVFRURLWnlXbXBxZ293c2tU?=
 =?utf-8?B?QVduSTZiOXFzUVp4TFFhVXJ4Wk04bEJGRnRhdnpSVi80bnI1cytRWG5PU2l0?=
 =?utf-8?B?VXQxdk4yTjEvTzlCTWhINC95QVJzUk5tTkJVZGpjWFcyMVArWXVaSkRjZHo3?=
 =?utf-8?B?cVRBcnVDclQ5amw0ZkRsZHlnbWcyZkZQa3Avak9YVWpjS3I4SE1nKzVEaGw3?=
 =?utf-8?B?a3VpUHNsZ0ExZFpROE1NenpGNmZHbWt6L3ZHZjdZVENnSU9vdWw5L1BPVFc5?=
 =?utf-8?B?U3NveUpBMDlTNStUSEFORFdqUlN4RzR0bjNWVld5SzdBdmtYZXMvVnRRbjVS?=
 =?utf-8?B?SmZoVVVXd0krdnF5K0RiZmExMFl4NUFvZDE4S1JEVUdQYlVnOTI5NVNWeXVV?=
 =?utf-8?B?WW5GZE9aZjhMcXlrSXIyOVV5d09EMTREdTNKakxTQTRGYkxCK0hGdGxIZFdH?=
 =?utf-8?B?VGJheXdlYXk1NVBaR0NONWIyN0FIaFp0OW4vTE1uYkp6bGhKWFM5REVqU3Q2?=
 =?utf-8?B?Y3hHNmVQSTI1bWUxcms5T3JMWmQrNklXVkVTaXJQOHBYYzMzV2FpZGdjN0hV?=
 =?utf-8?B?MmFaVzBwaFIxM0c4Zy9MS2ZOVk9tc3hEVWFPQ2M4NmtPbFNtY1B6QXNuZ2hz?=
 =?utf-8?B?VUFlWmR4YUNGNzRCQWNocUs3SHJ5R0tTdmNyVWxYN3RvS2JzZWlIZUhCUGQz?=
 =?utf-8?B?Z2xlUFVvR2xDS3ZMZkxVaWZJMGQyRGE5SUVreW0zODlqcTVhRWVQQVRHREcx?=
 =?utf-8?B?S2N3ZVNaNTZkRjMzWjc2VnVMMTdmUlhxTyt4QTkydDJKalZkUEpvVDMrL0pQ?=
 =?utf-8?B?aEZ5ZWJlN2FTNnRlK1JCVVovTEhzbE1HTlRFZm82dWg1Snd5cVpvYk1pd0Uz?=
 =?utf-8?B?OXdBMktmZnpONjgvd3FVSy9xblU1ZVptWXRaVmxYMzRiUG1EQkNTTDlrMEZ6?=
 =?utf-8?B?cTF1UGpzdTZPVkR3b3R5UXNCMkp2TUxZMFE2Q1VZNjNuOW11U3dUSEdpbG95?=
 =?utf-8?B?STBEQ3FmNWUyQXJvdFk2d0ZaYlJTTzY0QVVCZkFGdnRpU3Azd2hUWnhlV2RD?=
 =?utf-8?B?cHpmYnJRRlYwZDY1NVB4dW8rYlIzWkR3enhhTXJqbVpVU3RoemhmMDc3WjQw?=
 =?utf-8?B?dzc1VjFUbTBSbUd6NmRIOHQ2Zmo5NFBRRHJNOE5NcGdvcDdhMUdiRENQR2dV?=
 =?utf-8?B?U281Q1BtQUlnQVo4M0xCc2VkcEF2Tzh0UkpwOWQ5dkJaOVdISmN1cU1KM2dY?=
 =?utf-8?B?VVZpMjg3dUJicGYvZzh5WTVTaGNSZTduT2dRR3ZJZ1o0WUppMzdqUUQweG9w?=
 =?utf-8?Q?CyIM/loWjxjkfAQY0ahdcMv5H?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bd5be842-5510-408a-2249-08dc4928d780
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2024 21:58:14.3816
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GgqQ3MynHxNHqQcpYMpeGJxR0H4sRNCoS37znU4hSnOgCzzpBQF0r69XWcrDsiTkfwJJDX5jrrx+BggNwPRxEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5930
X-OriginatorOrg: intel.com



On 21/03/2024 10:06 am, Tom Lendacky wrote:
> On 3/20/24 15:48, Huang, Kai wrote:
>>
>>>> Hi Tom,
>>>>
>>>> I am not aware of kexec() support status for SEV-ES/SEV-SNP guests. 
>>>> Does patch 1 break them?
>>>
>>> SNP guests can kexec with some patches that are currently in process 
>>> around shared to private memory conversions. ES guests can only kexec 
>>> with a single vCPU. There was a recent patch series to add support 
>>> for multiple vCPUs.
>>>
>>> Patch #1 doesn't break either ES or SNP because we still have an IDT 
>>> and traditional kernel addressing in place, so the #VC can be handled.
>>
>> How about plain SEV guest?
> 
> A plain SEV guest is fine, since WBINVD is intercepted and would just 
> exit to the hypervisor (#VC doesn't happen with plain SEV).
> 
> Thanks,
> Tom
> 

Thanks for the info.


