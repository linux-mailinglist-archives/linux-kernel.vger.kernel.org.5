Return-Path: <linux-kernel+bounces-139508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DDA8F8A03CD
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 00:59:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9447D284FC1
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 22:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB45828FD;
	Wed, 10 Apr 2024 22:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KKw1QMiU"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C69E2138E
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 22:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712789759; cv=fail; b=tZWGh87hLscLBhJd37QSmCyL5wz0/AyUT/QPryx+WT0uDU7vuCJyfAsLujNfsarTRfiac/Co86vci5ok3Prs1HCgtttjtLpdXciyobHijz7dVMOnookWSH3BzASR4D/OpjGLmjn4JSnzorxWJl7vwFkw/JnjN4+qK4P4aJywanY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712789759; c=relaxed/simple;
	bh=U3lXmpvYrKqGrdHFtnbegm7FK6wIXGz5tubb9cOchCI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XTKJOHuupuBm9P3drptuMOrIrXOXkQusPrQS2GwGOXQYXt4gLKIM5XzTj4W5mXUk9221N+93Hx6boPcRpc/HJbhNGVNgBH5thuGlYIVQ9AdeRqH9Zr9xOtI1AfrbqM6xmc2FI8Vve2pd/1DU/8zlV9d2Bw3aZBNphGxY1DkCCC0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KKw1QMiU; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712789758; x=1744325758;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=U3lXmpvYrKqGrdHFtnbegm7FK6wIXGz5tubb9cOchCI=;
  b=KKw1QMiUC0qiCqSpKE3Aw3dCRgKP0k/+h0mJ8I6t/YsD3WOrYsVqzc9C
   +ePZSRv0eZUobMrgryMm6WIrWJeIkWvLAGLZgu9FkttoRuU6htySHgVnJ
   x4dG5kiWiNOnyzUqv3FjgFuU4R4kkqh5+8jpyRvUElu7T9y2rH4IKeeRA
   2nJBIPCd5JCIb0k4geUERwQOb9vzQQAWXLPdVgaMQTsNKjOLYf6lmmkZW
   uO7HyH1QEdLaa+NTXDcZspnnFlAv9vAvtPHSZpU5ha82Gh9krFN+GXsSb
   u6QhGd17ahVSxRQYpO5kXKFijJlxZ/wM9o+1gMcEU5px5X9sHloxIiFpe
   A==;
X-CSE-ConnectionGUID: vCPv3sJ1RQmhmLtbdtq5vg==
X-CSE-MsgGUID: fMBFVg/wRwaFhw0ggPfZwQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="8288492"
X-IronPort-AV: E=Sophos;i="6.07,191,1708416000"; 
   d="scan'208";a="8288492"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 15:55:57 -0700
X-CSE-ConnectionGUID: NhxIblO9SXObzF6kx5IC1w==
X-CSE-MsgGUID: Hxb+LPnVTG2nx/y2rfTTpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,191,1708416000"; 
   d="scan'208";a="58134867"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Apr 2024 15:55:57 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 10 Apr 2024 15:55:56 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 10 Apr 2024 15:55:56 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 10 Apr 2024 15:55:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V1dbb56KbBGmQzCLDxg1H3Lmq72tfabAn7EN+tKneOuAxrzoYNHeGmJ+PuRhgyd4bPa25d/nlV8rOgv1lc1McVfuRYC2YbjH0mHdDWj5e5Bwl/ir8d/3s9qnPCmxtyeeUO9EEFbCNA+0Lxaicfpho54L+Xwk4BfehzRi/pcgpX/vkQ5yxU6tXSEhCe/JfBKXpD3LaoIAjXtuGevQ7yAhK12AMLq2XB588q9c65xoAKbD1f7b6HKqv3Lr5Un7UUob7eQo9imT1JdhgE3yvgEq3e3sJljiYXFNA3D6aXrIbN4x9GDHJmgMMr6HnDofe+8hG7ysVXtuSmbLCoGXuLMdxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fbQYGhickllTkjnjKaNJhfxERVmhNBWOZDjy9YSnSg8=;
 b=mlPPJxYWS9DOOb7xA2GvHPRxoMZ+kfj1vILTdfsvWe70gllUuZEdbcyWoE2BkaZE7O1D3uzjmznnCP75lFwJDy6X3vc30UfW+M8OWUP4wXZhOqviucQZ0EdFyVB3GILbGu1Kxp1jo5+SbLTwSCI730n3+KdFZRXWJCRTOP8BW3D71/z9jKbxj4hlin5diRMsxgi4qZ719OrDlZDDLlcHTXMB8xEWOacx0iHQbITxln46KmaqdSb3uicFiHg5g8PRGZe2+1cVUogXv4OjrAcCiOETJ0RpSoAiiiXxVjvUJr7e9L08wwqqTIWUF5IDMyHW3jKFo3WENdNoPOH7+eDAXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by SA0PR11MB4591.namprd11.prod.outlook.com (2603:10b6:806:9c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.26; Wed, 10 Apr
 2024 22:55:53 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ef2c:d500:3461:9b92]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ef2c:d500:3461:9b92%4]) with mapi id 15.20.7452.019; Wed, 10 Apr 2024
 22:55:53 +0000
Message-ID: <a5948fe2-afbb-4b8c-a83c-0be55a823c53@intel.com>
Date: Thu, 11 Apr 2024 10:55:41 +1200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/5] x86/kexec: do unconditional WBINVD for bare-metal
 in relocate_kernel()
To: Tom Lendacky <thomas.lendacky@amd.com>, <linux-kernel@vger.kernel.org>
CC: <x86@kernel.org>, <dave.hansen@intel.com>, <bp@alien8.de>,
	<kirill.shutemov@linux.intel.com>, <tglx@linutronix.de>, <mingo@redhat.com>,
	<hpa@zytor.com>, <luto@kernel.org>, <peterz@infradead.org>,
	<rick.p.edgecombe@intel.com>, <ashish.kalra@amd.com>, <chao.gao@intel.com>,
	<bhe@redhat.com>, <nik.borisov@suse.com>, <pbonzini@redhat.com>,
	<seanjc@google.com>
References: <cover.1712493366.git.kai.huang@intel.com>
 <5aca124fe0ca1c97bf4a2e925b3905485bf5b255.1712493366.git.kai.huang@intel.com>
 <f361d574-11d6-3730-c77f-f3aabe111454@amd.com>
Content-Language: en-US
From: "Huang, Kai" <kai.huang@intel.com>
In-Reply-To: <f361d574-11d6-3730-c77f-f3aabe111454@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0117.namprd03.prod.outlook.com
 (2603:10b6:303:b7::32) To BL1PR11MB5978.namprd11.prod.outlook.com
 (2603:10b6:208:385::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR11MB5978:EE_|SA0PR11MB4591:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U66b6eDUsyyo/A4G54kDu3A6mTWxPO1hQk3Vtl3ulh/dBKblKWyEPtmlNAZXFhg+ZSRDOIULdxn8663WRuBh5Y1V8vQCYzAIwhjkaCHrJXQLgVoizheExtUbVTuksXCsKz6ZdK1MQfQhoSpliM8EfR01t64EJj0MoFSZLWBiKyni9FFzW9+rGSxsFkc/1POcHWoNft/aJUc9tNR7ak0az+G4uuJ7dHf8HpXXUeoFnMMCSIBJERDSHFHKetyEevH/tUs76p48pGmbR6BxU1M43cy6K8BbhsDt/Y25TYT6y0jHxXIh5n2lVR0dXW5cz+h7Xj2H/yjoEWfHKvulpYbQIZ5zCsecXxu1AFd5PGM0V4MlwYxoDGUWSGhlZNMTH/Kr+Dsh2WHDwcv3DcFbL1JQV8LuR2qlsVpY81ikUszrmsLCYZT/hMBh2OHSFM0xjYwNb4ZiuQS0n/68sgTmg4UobkmdW6pi4Gj32jmQK9R5oGkAIrXF06BZNsHo0PFv/gmMPUVO/LKi/7fuQTH+z2jr4seOUMpQKZdlRAVNuMPDpIchzLG0J+KlrdjsHbnu/dLv/BV6NK+k9d7SL02cajhZZAZv0Vlwfv8IODkPfDmNapCayF2OIfBpfIB6eVnmU/ygZ0bIoVu+GLfs74vqYZTloglhkxfLvn90/3+fpF8VxzU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(7416005)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SlhtalU0RmNTdUlSb09oNEJ2ZVhMVDZDVnpBRERrRFFoaWdwL202LzBSWCsx?=
 =?utf-8?B?RlZyRCtDYU1PbThqYzVSSkQrdU1iMTVYQStQTzJBVDlBQ09yK2dRV2IrVDJq?=
 =?utf-8?B?TTc5REpEN1ZxWDUxU0VJL0dkZVlRQzRnNklVaVFWMjdjK0RMdk9YVWdqbGEr?=
 =?utf-8?B?YllaN3lpdGo0NWEreDJWUmozalkrTlpScGNUNWhSbytDdW9MTXBZQndNakU1?=
 =?utf-8?B?Z3ZNN3hwTGJNSXpCQWJScVBLdkt6cnlNZkhpb0l3ZG9sMDQ0TDdMM0FkclJk?=
 =?utf-8?B?UkR4ZXFlaGNnS2YzSnM5MkhlU1RsNjZwUHB6YTNOdGoyZmJBMkROQWF0UGph?=
 =?utf-8?B?dzJGc0h4MTZsWjVJejNTSThyUVo2WWh4eTVhZ1dkN1NkTnBDeFBMNmZ6K3J4?=
 =?utf-8?B?WmRobWxIR29xR2VqRXBmZmhiU20zd0NKTVVFdWM5bzlJcWl5UENvdmh0Zk11?=
 =?utf-8?B?OFJrcDZaVklnOGhkeDRqK09IekZRLzdvN0ZtMmQ5K1lZWndZSnM0U2hmZGh6?=
 =?utf-8?B?a3BmRzNYSlhwU2hxYXpaNk9GUFo0b28xaGt5d3ozQ0ZiU1FMWDhXN05iUzZ0?=
 =?utf-8?B?STAyeVJRRWRBV09KWThHa0ZYRmhtdGFEQ05xZ0d5SHM0UmRHVFFEaThkWEEy?=
 =?utf-8?B?S0ZUcGE0TmIrdTZadkhucnBuQlk2czNMOHBlaWpUQURnR3JYYVFYRENzTTRH?=
 =?utf-8?B?QVRXaXV6Q05tMlMrR0xlTkFtOHFBYWsxNGx0KzI5N05JUmwyYXZ6cXkyZUNO?=
 =?utf-8?B?Y0Q3NTZFUVZmSUdMcXUxT29Ba3A0ZUJzWXdMMWtnb2R5TVB4RDZ5OG0xcW1X?=
 =?utf-8?B?dUcxTk0ydWJPZ0ZldGxmTmR2TkphQUEwaXM4ck04MWdBWjNpamlzcG5sZllm?=
 =?utf-8?B?N042QTVHQ2hMS2pPSndSOFE4bHRqMHRIRWRqYjhEaElraDh2NmZEQ2ZxcDhm?=
 =?utf-8?B?TjVpa25nWFVWQ2VoeE1HdzFzQitlN2FYVS9pTjdXYjBISWdGbkV1ekZpODhF?=
 =?utf-8?B?U0pja3c3aXd3YU5hZXNva3dEdklRTFlsNVg4QlRqcUorQStQZHNpb3VSM2E0?=
 =?utf-8?B?c3ZQOFlHUHF5dlduOFF4RU5hanNkaUtHZUF3Y0Z0ZUVnelF5SnlIU0I3cW1o?=
 =?utf-8?B?U1BFY0R0VCtCemdnMlM3MFNaTkFsbUd0Zzhka2tXLzdDajdwS3NlT2dLRHVK?=
 =?utf-8?B?ZnVHYmNObXJjZGZ5Mjkwc1JtcjZvVEJ2K1NLS2kwdUJ6VGdJaFdEeDJ0RGpm?=
 =?utf-8?B?RG52SmdhcCtqTXF3c1gwcFplVGU2K2ZDdXhhVFRJbC81VmRmc1pjOXUyRENx?=
 =?utf-8?B?T25DSHdUdFVLN3loNjF1TXNqUlBEYUlTRkJNeXNlOFE0Zy9PYWZ0UjU3TVBp?=
 =?utf-8?B?ejErU0FHVkd4OG5ITGx6NkUwcThGcno2RnV5N0pMQ3BhWGk1dkFuN2NZSTdk?=
 =?utf-8?B?TlAzOEZuZno0VTJLdzlnWmZYRkFUSWVsYm1KRUQxcTZ4Z2d1T2ZJUkNPTHlt?=
 =?utf-8?B?bkk0WVhrTmlvQjBVcDZ0cUNBMm0zbFZPOVgzdzZkZnJ6Tk5nMXhPUG1reHFn?=
 =?utf-8?B?WVZmRGlEQUhWU0RaTVdBTzVVVE1mUEliMFAzWTgrUlp4ZEQrM3l0OFdrSVpB?=
 =?utf-8?B?WFA2SW1jMHAwWll1Szc4UmV2NkJhV0hJK3hybHNFcGdnM0FYVEZ0WXpxMmVB?=
 =?utf-8?B?QnhneXJyMElybkFyWXpyOFlQZnhYYk9HRytuNXdHLzk4RUVLY0RJQ1lURUJp?=
 =?utf-8?B?MVN0cFRZRHNkZjlGUld0NU5Yb0gveVZreHRJU1NUQ1ZQOU9QVjJ5V1hvdmVE?=
 =?utf-8?B?aW94TXlBNHJEbE01a0xHVWJ5R251UkpYdWZoZmdoc2twRzZLeE80eG1JNXhQ?=
 =?utf-8?B?M1JPTWsxN1Q3QmVjY0hERU5CUjZMMTlPM1oyNnhUd1NRS3EwQXNvRmlVZlJ2?=
 =?utf-8?B?ZkVlbjFtNnI1Y3pmVTVoN3hUV09oK09jS0tVdUhLRWxOSlo5WWhBcjBoVndu?=
 =?utf-8?B?NUl1aWpSSmxBREU0SUlCVkNGRk9JMWpLMHNFZUwxcXBvaGF5QXRCUkdiY2ti?=
 =?utf-8?B?a0Y1N1A4OVFZaHI0WXBCZFpvdGlFSDJzNnlWV1dSa0lsRlUxV1k4MVlqSFpS?=
 =?utf-8?Q?WfOIT9Ygq/dx2RtXf1VM5g5mI?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 99974fa2-4298-4613-09dc-08dc59b15fbd
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2024 22:55:53.1637
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dXERo5p0hyyc74iQc1zSkE91LW2+F5WpBDZp7raSdRz5c8DJyWmUFrAfNIcWQM2s2akPM2vQ6N82dokIms4+iQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4591
X-OriginatorOrg: intel.com



On 11/04/2024 4:21 am, Tom Lendacky wrote:
> On 4/7/24 07:44, Kai Huang wrote:
>> Both SME and TDX can leave caches in incoherent state due to memory
>> encryption.  During kexec, the caches must be flushed before jumping to
>> the second kernel to avoid silent memory corruption to the second kernel.
>>
>> During kexec, the WBINVD in stop_this_cpu() flushes caches for all
>> remote cpus when they are being stopped.  For SME, the WBINVD in
>> relocate_kernel() flushes the cache for the last running cpu (which is
>> executing the kexec).
>>
>> Similarly, to support kexec for TDX host, after stopping all remote cpus
>> with cache flushed, the kernel needs to flush cache for the last running
>> cpu.
>>
>> Use the existing WBINVD in relocate_kernel() to cover TDX host as well.
>>
>> However, instead of sprinkling around vendor-specific checks, just do
>> unconditional WBINVD to cover both SME and TDX.  Kexec is not a fast path
>> so having one additional WBINVD for platforms w/o SME/TDX is acceptable.
>>
>> But only do WBINVD for bare-metal because TDX guests and SEV-ES/SEV-SNP
>> guests will get unexpected (and yet unnecessary) #VE which the kernel is
> 
> s/#VE/#VE or #VC/

Will do "exception (#VE or #VC)".

> 
>> unable to handle at this stage.
>>
>> Signed-off-by: Kai Huang <kai.huang@intel.com>
>> Cc: Tom Lendacky <thomas.lendacky@amd.com>
>> Cc: Dave Young <dyoung@redhat.com>
>> ---
>>
>> v2 -> v3:
>>   - Change to only do WBINVD for bare metal
>>
>> ---
>>   arch/x86/include/asm/kexec.h         |  2 +-
>>   arch/x86/kernel/machine_kexec_64.c   |  2 +-
>>   arch/x86/kernel/relocate_kernel_64.S | 14 +++++++++-----
>>   3 files changed, 11 insertions(+), 7 deletions(-)
>>
>> diff --git a/arch/x86/include/asm/kexec.h b/arch/x86/include/asm/kexec.h
>> index 91ca9a9ee3a2..455f8a6c66a9 100644
>> --- a/arch/x86/include/asm/kexec.h
>> +++ b/arch/x86/include/asm/kexec.h
>> @@ -128,7 +128,7 @@ relocate_kernel(unsigned long indirection_page,
>>           unsigned long page_list,
>>           unsigned long start_address,
>>           unsigned int preserve_context,
>> -        unsigned int host_mem_enc_active);
>> +        unsigned int bare_metal);
>>   #endif
>>   #define ARCH_HAS_KIMAGE_ARCH
>> diff --git a/arch/x86/kernel/machine_kexec_64.c 
>> b/arch/x86/kernel/machine_kexec_64.c
>> index b180d8e497c3..a454477b7b4c 100644
>> --- a/arch/x86/kernel/machine_kexec_64.c
>> +++ b/arch/x86/kernel/machine_kexec_64.c
>> @@ -358,7 +358,7 @@ void machine_kexec(struct kimage *image)
>>                          (unsigned long)page_list,
>>                          image->start,
>>                          image->preserve_context,
>> -                       cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT));
>> +                       !boot_cpu_has(X86_FEATURE_HYPERVISOR));
>>   #ifdef CONFIG_KEXEC_JUMP
>>       if (image->preserve_context)
>> diff --git a/arch/x86/kernel/relocate_kernel_64.S 
>> b/arch/x86/kernel/relocate_kernel_64.S
>> index 56cab1bb25f5..3e04c5e5687f 100644
>> --- a/arch/x86/kernel/relocate_kernel_64.S
>> +++ b/arch/x86/kernel/relocate_kernel_64.S
>> @@ -50,7 +50,7 @@ SYM_CODE_START_NOALIGN(relocate_kernel)
>>        * %rsi page_list
>>        * %rdx start address
>>        * %rcx preserve_context
>> -     * %r8  host_mem_enc_active
>> +     * %r8  bare_metal
>>        */
>>       /* Save the CPU context, used for jumping back */
>> @@ -78,7 +78,7 @@ SYM_CODE_START_NOALIGN(relocate_kernel)
>>       pushq $0
>>       popfq
>> -    /* Save SME active flag */
>> +    /* Save the bare_metal */
> 
> Either "Save bare_metal" or "Save the bare_metal flag"

Will use the latter.  Thanks.

> 
>>       movq    %r8, %r12
>>       /*
>> @@ -160,9 +160,13 @@ SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
>>       movq    %r9, %cr3
>>       /*
>> -     * If SME is active, there could be old encrypted cache line
>> -     * entries that will conflict with the now unencrypted memory
>> -     * used by kexec. Flush the caches before copying the kernel.
>> +     * The kernel could leave caches in incoherent state on SME/TDX
>> +     * capable platforms.  Just do unconditional WBINVD to avoid
>> +     * silent memory corruption to the new kernel for these platforms.
>> +     *
>> +     * But only do WBINVD for bare-metal because TDX guests and
>> +     * SEV-ES/SEV-SNP guests will get #VE which the kernel is unable
>> +     * to handle at this stage.
> 
> Similar comment here about doing an unconditional WBINVD, but then 
> qualifying that as only on guests. This is where talking about how 
> exception handling has been torn down would be good.
> 

OK.

Thinking again, also it might be a good idea to not lose the existing 
comment for SME, because it somehow justifies why we do WBINVD _HERE_ I 
suppose?

How about below?

     /*
      * The kernel could leave caches in incoherent state on SME/TDX
      * capable platforms.  Flush cache to avoid silent memory
      * corruption for these platforms.
      *
      * For SME, need to flush cache here before copying the kernel.
      * When it is active, there could be old encrypted cache line
      * entries that will conflict with the now unencrypted memory
      * used by kexec.
      *
      * Do WBINVD for bare-metal to cover both SME and TDX, as it's
      * not safe to do WBINVD for TDX and SEV-ES/SEV-SNP guests.
      * WBINVD results in exception (#VE or #VC) for these guests, and
      * at this stage kernel is not able to handle such exception any
      * more because the kernel has torn down IDT.
      */

