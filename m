Return-Path: <linux-kernel+bounces-89223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D33D86ECEB
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 00:20:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 103402854BE
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 23:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 637AB5EE8E;
	Fri,  1 Mar 2024 23:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O4Q9GAw6"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A9B35915C;
	Fri,  1 Mar 2024 23:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709335245; cv=fail; b=l/FAlbrumlERN3bG5zqZn2qIUXOXDIz1cYazy04mS1dyq/AWgb8g/InHWL+Ll2fOKI+boYTfAo9YROrj2r/0+pT7gX9GVckrNEiD1x1rWAyD0n6WhdBRyCZPrlhusWgQ+3sAKnHSY0odOOIOwAzI35VGY6ZTLZzLh2rtMfKFH+U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709335245; c=relaxed/simple;
	bh=BA9p6s2+gj5LK4vNIVCbJEIHvLHMZazkz/Cce3ibJAU=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uWnzsmIVT2G1BXqPqG0XxpuhO2wD/+cEsbZ9BwPDNSHQ44FrjS0BHRYEl6BRQbGJNEpEEnpFecz5ypQNMkrF/uh0SBI7t4tyLPgFRYmmeOi/RM8Sm3kf8Qy59wZKXBNHWbPvppZo2zSmUvfR0f6u8o/HXDRD1aAUwjzKYXieJ9c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O4Q9GAw6; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709335243; x=1740871243;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=BA9p6s2+gj5LK4vNIVCbJEIHvLHMZazkz/Cce3ibJAU=;
  b=O4Q9GAw63oUglDdIe4rWKmRXVLTsgnJOLOThhE32OG0jxLmRctxAqr6s
   7HRrQiVGJlkSnSiZ055+3k9dENcS39o/jcUQYrUaVBSnsV3tUOBDAnZKV
   KcmM7lW9LvKJKKovFSjG7CLiiPqAbVBb1xAGxcFNGSCHvHtpabq55DYDb
   qSUbWSBryvqHxdhUkgtpQ9U6tmmuhm/iibH3ei7CdpRWYSD5itNPKw6o6
   1bcKGZN3nKB7u8nXVvfHXeWIgsnxZoHwT4upgVmZs59T1lBOJZn3Bk38d
   Fa+8m748u/WZ8cjI+eu+9JEXcsi+Fq8COUZ/b4j7i99NPjEH12wOHY3hv
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11000"; a="3747227"
X-IronPort-AV: E=Sophos;i="6.06,197,1705392000"; 
   d="scan'208";a="3747227"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2024 15:20:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,197,1705392000"; 
   d="scan'208";a="12908116"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Mar 2024 15:20:41 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 1 Mar 2024 15:20:40 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 1 Mar 2024 15:20:40 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 1 Mar 2024 15:20:40 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dgcL9WAP+b/ACWZ2Wt9AAvfrtennalS2Ej852i9ySQQDW3zsBuz1RVMaO0BCdAnSE3Drfa0VfxAXCjcmclJQfyZlhxlZ2GvEM+NSfAQCnZnqVU6WPmEZl7rnqmuwTcKBFIfhJBr/2gmqZz6HxrYDEQnlSx+5SzzP3DcQ08JlR2MKzySOVMIku1EU+PpAFik0ndkkcxuJsvocCEIAFwDAv1/YKQLkm4xf4D6YQivRZGw6y8wzWsy5Clz4iJA5Z6IXQUuANDXy6eRNobQ7bL7Oh2kRYs5jHo3/3OyZ1iz6qjRd3PFINe8fFxiVvZSIQ7aV8s1HP/LJuVPOABgW35j3Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CY1ywFaQCcWBx6BNi0tUXMok3tBPKhjIvK5wJFwL0vs=;
 b=lJE+IQIVF9JJCgNeOlLmCGRGT4+huy8z4ybmVT9+Y0DKFcpjNmlq6pHXw4u1JQI18za4HJPPsaZNfaXfe2AP8R/98tFnCKX29Bl73HeCvIZRVHypkxKtTXAOlh0sWNEwggP+0bdz7/CYS1WjjRXYno4CiJ4bvyWAZms2fiawox/pwk2lZxw3x+UtIL/mBdAlOCNDNJtCDbD2Yao3Y6aK8FW/4DNbFV6p0yWtUVJy+cpMZbclp8zkr69Zo8J0fGCOIjasO4ADfl691MBVW6W2EHw9bzej31h0FbqO3ahwhBEAV/8nAjK06rLB/DcqTKQ1s0LzSR1UeXnCP/Wc6Yxe4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by PH7PR11MB8250.namprd11.prod.outlook.com (2603:10b6:510:1a8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.26; Fri, 1 Mar
 2024 23:20:36 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68%7]) with mapi id 15.20.7339.024; Fri, 1 Mar 2024
 23:20:36 +0000
Message-ID: <c73f444b-83a1-4e9a-95d3-54c5165ee782@intel.com>
Date: Fri, 1 Mar 2024 15:20:32 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/17] x86/resctrl : Support AMD Assignable Bandwidth
 Monitoring Counters (ABMC)
Content-Language: en-US
To: <babu.moger@amd.com>, James Morse <james.morse@arm.com>, <corbet@lwn.net>,
	<fenghua.yu@intel.com>, <tglx@linutronix.de>, <mingo@redhat.com>,
	<bp@alien8.de>, <dave.hansen@linux.intel.com>, Peter Newman
	<peternewman@google.com>
CC: <x86@kernel.org>, <hpa@zytor.com>, <paulmck@kernel.org>,
	<rdunlap@infradead.org>, <tj@kernel.org>, <peterz@infradead.org>,
	<yanjiewtw@gmail.com>, <kim.phillips@amd.com>, <lukas.bulwahn@gmail.com>,
	<seanjc@google.com>, <jmattson@google.com>, <leitao@debian.org>,
	<jpoimboe@kernel.org>, <rick.p.edgecombe@intel.com>,
	<kirill.shutemov@linux.intel.com>, <jithu.joseph@intel.com>,
	<kai.huang@intel.com>, <kan.liang@linux.intel.com>,
	<daniel.sneddon@linux.intel.com>, <pbonzini@redhat.com>,
	<sandipan.das@amd.com>, <ilpo.jarvinen@linux.intel.com>,
	<maciej.wieczor-retman@intel.com>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <eranian@google.com>
References: <20231201005720.235639-1-babu.moger@amd.com>
 <cover.1705688538.git.babu.moger@amd.com>
 <2f373abf-f0c0-4f5d-9e22-1039a40a57f0@arm.com>
 <474ebe02-2d24-4ce3-b26a-46c520efd453@amd.com>
 <b6bb6a59-67c2-47bc-b8d3-04cf8fd21219@intel.com>
 <3fe3f235-d8a6-453b-b69d-6b7f81c07ae1@amd.com>
 <9b94b97e-4a8c-415e-af7a-d3f832592cf9@intel.com>
 <1ae73c9a-cec4-4496-86c6-3ffcef7940d6@amd.com>
 <32a588e2-7b09-4257-b838-4268583a724d@intel.com>
 <088878bd-7533-492d-838c-6b39a93aad4d@amd.com>
 <9b20589b-6220-4ae7-bfc4-4a826b7114b1@intel.com>
 <5ddb7031-a828-4001-bfdf-5477cb85e9ed@amd.com>
 <1738493b-3248-4c9e-82a8-1599a033440d@intel.com>
 <369ab28a-f3fa-4359-8e73-4dcf214c9b6e@amd.com>
 <54687d59-d0e4-4fe7-b25f-dc1fead01ea1@intel.com>
 <11487a31-908e-d474-50c6-65617d417deb@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <11487a31-908e-d474-50c6-65617d417deb@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR02CA0005.namprd02.prod.outlook.com
 (2603:10b6:303:16d::14) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|PH7PR11MB8250:EE_
X-MS-Office365-Filtering-Correlation-Id: f245645d-052f-4636-c4e3-08dc3a46333d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Al/H+gYm9jM9GPUHaZ8nHBnWU3pPN16zF4KYpdLxuzd8OKHKIllhSYb8uEBsCr9kOqbJ3b3YAB71m96zXFxWSb/Mt+Y4/ip71Kq28HCuMtr5K0Z1YYRMLp94pmzkHfN1x/cqV6qLJWLUw6X6njSd1QVDo2KHDdNtFz/JbTxmBopCamBA+nt9aHQ8+jIFsssqSoQLmQ5NXv9hTOVU63YVS0R+ECFqU/PSmLZaOFTR6jNtG2Pv4VdsKRraVJurVr3fIx/ALVy6CLnW8LENb83H3/DZDUJ/zTrrDqQnOQ8mp8YpTS0SFg+ZPRw4iz2wTD3ZA9rNzXHCv8kB6nPpnw9Tl47O5EnybRkpZ5yRVFy92I58X88/y2WyYNdFQnHvYO0fbQzpFV3FnaWX8Egc7PWAQm8MQI+OqH6qMd/Zg2eSPAhrmfLAit4EEG+x+xAyY8SkeL6eYnETaro2KW9bAb8vhKcDQrJlrnorO/TzmE5UzW5CfxIViYe7zUI6OpuqAXpDQvk4Coe3xUoEx1apJ12AZAbpvb/s9l23tPaotrpZsukzl93l70ibo5FQzpiJh2GuzD1OlVzZWcYxhznhJpejPfXPCcL1kmq4pIv3JV9m1XWS4M1QaeB/uHIdbOzr+FgV3NcH/IaLHzoIRlc5ep40Fw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dE9kSXRHa0U2OHUrQksrKzJ2dktXRlZUUDFMb3lFTXRvUUpRWStMbW9ZeDdR?=
 =?utf-8?B?WDUvT3JiWXJJU2lKclpVUDRMelkrTGFMK1l1Q1hRL2VtaG5mOFZIQ1J1WXZQ?=
 =?utf-8?B?QTVpZUxEWXR1SzZ2bXBJZ1B0bzJMNnVhSTU2bmUwMFpIT2V2cEFvWE15THdl?=
 =?utf-8?B?TXh3NFhwTE1xWDFSMXdVT1Fza3lFSkgzYXF6d3dtZHJwRG9wK0FqKzI0ZTl2?=
 =?utf-8?B?L1V3SHNYZklsbFlaVUhoZEN4dTA3QmFNcWFQNHF0ZHZxRWNIdmt6TFhGY2d0?=
 =?utf-8?B?R1M1NG1iUmttODV0QXRxeDJLRlB3eVZFYTlhMDk4Um0wODdoR3crQXlwemZi?=
 =?utf-8?B?a0VMa213RlhKYkRaeVkrTEVUazJLNkY1VnNzRmJkMUF3ZUoyYS9OcThSUXZL?=
 =?utf-8?B?b2dmRFp2R2JtQjhydU5yYi9ZMEFvdEhyK1QzZ2ZaeFNiNC9sUTlLZURRREpV?=
 =?utf-8?B?N1lBYk8zYzdFVWRzdkJKb0VUT3lxKzhmLzI5MVRSOTdsWG1pSmJDWVc3MlYx?=
 =?utf-8?B?a2VNUldPczBwcVB2VUhnbFFrSWsvOHdwdGlUYk9vV0JmM2RkSEZQRHQyZkZT?=
 =?utf-8?B?ckVxRmlNNTE1eU83SUw0SGY0cTlDUkdJWFNEMDNLeE1wajlFR1kzMW9KQ0JI?=
 =?utf-8?B?VGdrRWJXd1BXZjdaVHZnREc5dlc3Q3JxbENTL2hOL2JnZDJoTnF3YXpCSzBz?=
 =?utf-8?B?RDk2YkFRRDB1a25VbkRaWlFpZEhWNFNJNnByNllLd0E5VFgxdU5RTldocCtQ?=
 =?utf-8?B?bVo4VmxCWVlDRG1mRElpNW9iZHRJR0xZWjZTZDRkUDZwZjhTV1lVRUdzU0xr?=
 =?utf-8?B?b2RqVmFqcURaYU1MVEthYXRIdE53YWVyN1U5OU5FVkNvc0V2TEpUVWUwTTB5?=
 =?utf-8?B?Qzh2MGd3eVRJZUJPdE1QRWQvR0lVaFBtUGliN0NHZndjcHZpdSttei9EY3NM?=
 =?utf-8?B?Wmw0SVRpRitaNGdaTzVLVHg3UlExTDhBQTFaKzJiSmU2MVFFZnlUSWRDbE1s?=
 =?utf-8?B?TGNwbjFaa3Jqc2FndnVUektQcUhucnorMVZLREphS2dXUHRIeVVIakp1aTZH?=
 =?utf-8?B?ZHJPVWE2V2haMmo3eTR2dVVjcWF6MzdrVEQ0cEEvRVJGdzNiUVVleVNKckhm?=
 =?utf-8?B?S1dMbWgxUGJXbGRnQXZBcGg3S0V2YWpHT1JMSFZOUTVMdTVYdzZ0d0VsQXA1?=
 =?utf-8?B?UGRsNkhKSk1wd09aRXMwZE5YdlBPQ21vaVNTbmxMZHVyME4zQ3VnazEvVzIr?=
 =?utf-8?B?dWRDbG5HREQveXR3Z1ZsT09vbjk1L1QzaVF6MUJVS1d4UEd0d2hveHhPQ0tj?=
 =?utf-8?B?UVpoekhYYlBaOXJKd0Rxd3JxWElEYkNkbStSTDU4ckdCVXhEWG4xeU1mUzhH?=
 =?utf-8?B?c1E3Y0RPYjd2dFNGS2NkbkRvanBQZ3llUUJnTXYwdmxkMzQ4T2tnVjR2Ti9u?=
 =?utf-8?B?M05sTFRZb2JtWFV2WTZyUzRUT1paRXFXdUJBWWJZMVNNRTdJL2s0U090N1lL?=
 =?utf-8?B?dW1BYjNxUFFzelRzOTVOWjBScDU2RjU5RzRVT0hwbzkyTGtLb1RrTmVCMXlP?=
 =?utf-8?B?Yjl2WDh4aHF2SGllSGowdjNiblpMRGlkdHN1a24wOHJEOU5XZE5oNWxmMkZW?=
 =?utf-8?B?bHFqZlRmdFZrSWRRVU8relJCNE95K3o2VTc5MUt1bTFsUU51d0R3NVJTK21h?=
 =?utf-8?B?V05rTktrUEs4aTV6cVplTmJuQmVpR0VJdGNXeFBkQmQ2aDdrODB3SVlHNUZE?=
 =?utf-8?B?QnRlNGY1anhkYmgxOU5GN1ZaaDF4ck9WVmFoaVB1TEtsOWw4OERJd2JPVm1t?=
 =?utf-8?B?K2k1RG1TdmlyMzd1OXM5cHdNTTZTM3l2VnZDWjViTi9OTm9iOTliZVowSnJz?=
 =?utf-8?B?NVltOEJEb1J0UjNBeURLYkMxejFFSXFEQi9jYmFUNFJDajVodGZ4c3hGdzc5?=
 =?utf-8?B?dGZ5NVcvbEkzMzE1dEtMZk1PWFBUMXluVlA2RkpyY3JxMk5kenhzTTg5alNH?=
 =?utf-8?B?MG5sckNOSHFmUld2bEpnc1lUZ1UwQmc4dndWM1ZGVWU1TGtad2FkWXVPYU5q?=
 =?utf-8?B?M0VkTE54V3luckkvWklPUWpyc0lSSnp5V1hDaDJ4SlkxVzk1MkgrcTdBWkVj?=
 =?utf-8?B?Mkl0ZnBXRzVQdVE5STNBQTdzOEFSZThCb1hYeWpJUUNUcWd5TlA2Rk1DdnF2?=
 =?utf-8?B?YUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f245645d-052f-4636-c4e3-08dc3a46333d
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2024 23:20:36.3782
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gvhje/q1vmrdVybUYAkBGsOuG7hYb33NnYEbAtQXvH5mntxUORz33g2keVkgc/lxdaPApGKKPkWi4LWyMrL4+qLUd+uHvFgJAclYhKmWwh8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8250
X-OriginatorOrg: intel.com

Hi Babu,

On 3/1/2024 12:36 PM, Moger, Babu wrote:
> On 2/29/24 15:50, Reinette Chatre wrote:
>> On 2/29/2024 12:37 PM, Moger, Babu wrote:

..

>>> To make more clear, let me list all the groups here based this.
>>>
>>> When none of the counters assigned:
>>>
>>> $cat /sys/fs/resctrl/info/L3_MON/mbm_assign_control
>>> resctrl/00=none,none;01=none,none (#default control_mon group)
>>> resctrl/mon_a/00=none,none;01=none,none (#mon group)
>>> resctrl/ctrl_a/00=none,none;01=none,none (#control_mon group)
>>> resctrl/ctrl_a/mon_ab/00=none,none;01=none,none (#mon group)
>>
>> I am concerned that inconsistent use of "/" will make parsing hard.
> 
> Do you mean, you don't want to see multiple "/"?

No. I think that having a consistent number of "/" will be easier to
parse. In the above example, there are instances of 1, 2, as well as
three "/" among the lines. That seems complicated to parse.

I was thinking that it will make interpreting and parsing easier if there
consistently are just always two "/".

(You may find things to be different once you work on the parsing code
though.)

In summary:
* for monitoring of default CTRL_MON group: "//<flags>"
* for MON_GROUP inside default CTRL_MON group: "/<MON group>/<flags>"
* for monitoring of non-default CTRL_MON group: "<CTRL_MON group>//flags"
* for MON_GROUP within CTRL_MON group: "<CTRL_MON group>/<MON group>/<flags>"

What do you think?

> 
> resctrl/ctrl_a/mon_ab/
> 
> Change to
> 
> mon_ab/

rather:
ctrl_a/mon_ab/<flags>

> 
>>
>> I find "resctrl" and all the "none" redundant. It is not clear what
>> this improves.
>> Why have:
>> resctrl/00=none,none;01=none,none
>> when this could do:
>> //00=_;01=_
> 
> ok.
> 
> "//" meaning root of resctrl filesystem?

More specifically, monitoring of default control group. It is not intended to
specify a pathname.

>>> When some counters are assigned:
>>>
>>> $echo "resctrl/00=total,local" >
>>> /sys/fs/resctrl/info/L3_MON/mbm_assign_control (#assigning counter to
>>> default group)
>>>
>>> $echo "resctrl/mon_a/00=total;01=total" >
>>> /sys/fs/resctrl/info/L3_MON/mbm_assign_control (#assigning counter to mon
>>> group)
>>>
>>> $echo "resctrl/ctrl_a/00=local;01=local" >
>>> /sys/fs/resctrl/info/L3_MON/mbm_assign_control
>>>
>>> $echo "resctrl/ctrl_a/mon_ab/00=total,local;01=total,local" >
>>> /sys/fs/resctrl/nfo/L3_MON/mbm_assign_control
>>>
>>
>> We could learn some more lessons from dynamic debug (see Documentation/admin-guide/dynamic-debug-howto.rst). For example, "=" can be used to make an assignment while "+"
>> can be used to add a counter and "-" can be used to remove a counter.
>> "=_" can be used to remove counters from all events in that domain.
> 
> Yes. Looked at dynamic debug. I am still learning this interface. Some examples below based on my understanding.
> 
> To assign a counters to default group on domain 0.
> $echo "//00=+lt;01=+lt" > /sys/fs/resctrl/info/L3_MON/mbm_assign_control

It should not be necessary to use both "=" and "+" in the same assignment.
I think of "=" as "assign" and "+" as append ("-" as remove).

An example of this, just focusing on default group.

#hypothetical start state of no counters assigned
$ cat mbm_assign_control 
#control_group/monitor_group/flags
//00=_;01=_

#assign counter to total MBM of both domains
$ echo "//00=t;01=t" > mbm_assign_control 
$ cat mbm_assign_control
#control_group/monitor_group/flags
//00=t;01=t

#add counter to local MBM of both domains without impacting total MBM counters
$echo "//00+l;01+l" > mbm_assign_control
$ cat mbm_assign_control
#control_group/monitor_group/flags
//00=tl;01=tl

#remove local MBM counters without impacting total MBM counters
$echo "//00-l;01-l" > mbm_assign_control
$ cat mbm_assign_control
#control_group/monitor_group/flags
//00=t;01=t

#assign local MBM counters, removing total MBM counters while doing so
$echo "//00=l;01=l" > mbm_assign_control
$ cat mbm_assign_control
#control_group/monitor_group/flags
//00=l;01=l

#remove all counters
$echo "//00=_;01=_" > mbm_assign_control
$ cat mbm_assign_control
#control_group/monitor_group/flags
//00=_;01=_


> 
> To assign a counters to mon group inside the default group.
> $echo "mon_a/00=+t;01=+t" > /sys/fs/resctrl/info/L3_MON/mbm_assign_control

I think it will simplify parsing if number of "/" is consistent:
$echo "/mon_a/00=t;01=t" > ...

> 
> To assign a counters to control mon group inside the default group.

It is not clear to me what you mean with this.

> $echo "ctrl_a/00=+l;01=+l"  > /sys/fs/resctrl/info/L3_MON/mbm_assign_control

this looks similar to previous example, so I think it will be hard for parser
to know whether it is dealing with control group or monitor group.
I am not sure I understand your example, but this may perhaps be:

echo "ctrl_a//00=l;01=l > ...

> 
> To assign a counters to control mon group inside another control group.

I do not know what you mean with "another control group" 

> $echo "mon_ab/00=+lt;01=+lt" > /sys/fs/resctrl/nfo/L3_MON/mbm_assign_contro

How will parser know which control group? I was expecting:
$ echo "<CTRL_MON group>/<MON group>/<flags>"

> 
> To unassign a counters to control mon group inside another control group.
> $echo "mon_ab/00=-lt;01=-lt" > /sys/fs/resctrl/nfo/L3_MON/mbm_assign_control
> 
> To unassign all the counters on a specific group.
> $echo "mon_ab/00=_" > /sys/fs/resctrl/nfo/L3_MON/mbm_assign_control
> 
> It does not matter control group or mon group. We just need to name of the group in this interface.

It matters because users can have monitor groups with the same name within
different control groups.

Reinette

