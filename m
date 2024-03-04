Return-Path: <linux-kernel+bounces-91196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 79980870B13
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 20:58:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C14D1C20F08
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 19:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C79287A738;
	Mon,  4 Mar 2024 19:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Vfc2uvqk"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF9979DD2;
	Mon,  4 Mar 2024 19:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709582301; cv=fail; b=PY83qENVMiR6+GAGvOynAiF1qtgVVZKSZy4rgzBjMZ69Q4FjMpHjqutr7Kx4/fPqgbxotRAmVjgCjInYnouvMKqvV2e4LO9wtEzWWr/eobQmkmQOCzoGMybm50uHIqAwDcLmYW8EhnnWH6PtYr/L1hNzA/bJdxiWGW1QfqFYKJ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709582301; c=relaxed/simple;
	bh=zXjfAGNem7wsw5lB+e/A4iOtg96laK5qpKS+5NLCmfg=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PaAZVX6Eqj5bY4S9vso4K3jZSf4GKv4Y43msT5usny6CNq1s+7d7LLR/tj9yYNrD3dUpn6Rjz0bD4SYRThJ51XhiWAxjNiM4SDP/qqmh7qE+Xad9CwAPUlDRft7ShSEyZXNzlf4lhmBiZY/QUcfYNMZJeDP75FTUItbZTLXiA88=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Vfc2uvqk; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709582299; x=1741118299;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=zXjfAGNem7wsw5lB+e/A4iOtg96laK5qpKS+5NLCmfg=;
  b=Vfc2uvqkUFkU2++KO+QGfYvpz5pHVUy7fMTRWmet3prnKBAtDBemU/F8
   nfYEOWKk2NPvK82C4UnPZXrWjxQddwIpD+VG/7shc5ASO5zj+5jy8xEsi
   iXTDmscY2HCC24lS8agfbn/OACDhgGLtdof1qsOF880k4f9Rke8xWu8kb
   0nwKBFQul36WJwu/g7Ta+XLZJiVXX4WJodS6HZzXJDLHkyps3vXkDkptD
   UFboYU7lTHZuf0bzS/JNAkYRm9JGe1CPkywTYjB1evtDUuwXpN306HI6Q
   iqFEuGMY37wgrt9qnFbzWO+tMbAY3N052yMPj2JKeiw2L88PU6l1YmQUP
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11003"; a="7908609"
X-IronPort-AV: E=Sophos;i="6.06,204,1705392000"; 
   d="scan'208";a="7908609"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 11:58:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,204,1705392000"; 
   d="scan'208";a="13779690"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Mar 2024 11:58:19 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 4 Mar 2024 11:58:17 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 4 Mar 2024 11:58:17 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 4 Mar 2024 11:58:17 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.40) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 4 Mar 2024 11:58:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CZJh6E6nViKiLlFQAmHWC/QNghPdFTUltJnKpkYRBbNFo627EA1g0GinyfYrG7TGhkkRJpVsKT1Lk6WKAJipVoe/mhIunqaRZdjXouCqPf9a3gBbbIUimQVvekvAshT2gHsYCNDyLdnmSdZAVZhFIK33x2oLTbyslqTyrzrXkKO6g4qfAY4HuB/JBte0bDYUQ99p0zFk2XR3lkzXYUgH9soU6XAxzbjzCCvI4f6qNdzZXOYHtSSmz26zzHmo7AVzEugUcK08jZsTqcTFN203sgkTD6iQDPcAVY9ZN05eZiQk5UBn00m9urAV+GOCzmULdVHyyr29gvJ6mYfFLebcXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/6J3Xbu9qxg+3YBenoMHQyrNdyyu9SNpAn8dNZ3xTiU=;
 b=howVyMC/rsHBho13eR8nAICmP7Nm17E18zdbrDksTllO2J4Qz9wSFa/o8yI7Pca1xxnZFwepjU6JyubNeN282NkuOlMkLwxCtgpt9lSQ3onV+KFTVRGR4iPokGDHp+foumkUm/DvlYE9mogjC/9SahZ4xRkWCzIfDa4IV160aFW7d1Rq57CHHjKaeUhNHtMBDO085juz9hnVCbIDu2DC8MyrKuNJRsxnz21GAXAtqPXson20+dU7U/Dx6cOU2HvNnXlQXhYGSuEQucmy4lE8Mvg3nIsaABR49UfDcWcs0DCSTW1A0n5xFn+5DEoWHC1Xzm2MXCcE5aC9aLtramtltg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by LV2PR11MB6069.namprd11.prod.outlook.com (2603:10b6:408:17a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.22; Mon, 4 Mar
 2024 19:58:14 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68%7]) with mapi id 15.20.7362.019; Mon, 4 Mar 2024
 19:58:14 +0000
Message-ID: <1f366890-d9ff-4ac4-9af9-1ea3128a87fc@intel.com>
Date: Mon, 4 Mar 2024 11:58:10 -0800
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
 <c73f444b-83a1-4e9a-95d3-54c5165ee782@intel.com>
 <55b545fd-2851-0d0f-ac37-ec59838fb4b4@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <55b545fd-2851-0d0f-ac37-ec59838fb4b4@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0221.namprd03.prod.outlook.com
 (2603:10b6:303:b9::16) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|LV2PR11MB6069:EE_
X-MS-Office365-Filtering-Correlation-Id: b9302833-5c9b-405a-0ceb-08dc3c856d21
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t4z06UsJRMz/WGd2YeUDRbG2ua3jFxOtc+MKAmUPJQclBNHZJMkohthLYyPAFMxOIv1c7idv9/LR3pw1Yy/chM5HVX+SIbBpSHu4PM6hqj30rZuRf3/Axk0o2A5KQzuCdCxw+B9UtUaxf6m/xUudcroTWrmlxhefXPEXQpeX1vKeb/DR/fBauFgHqp76fJdji8BZOaT+SUMbgnvOqNGt/fwKYGRr/RuvYoQ23b9iiwQk3AJPEqHsDtUr6sXxRtipg5KSDBNvufTIxA3rsHgHgCu/z8VRMw/YX8Az6/aExzXnS3pjd9G84mi6sOYHm/3pTKwwJgaW4N9Vm2lCsMLrCxKoDS1EKe1Lm9n5ES4mdZVbX0wKU1MCDXGR9HbVHSJfJ20uSqyCyiJ9Pkzzu47JeaCU8Nfvv29gTlMPOlDDUaIDyU1GaTWIXtCztU9vDQ14ShWvwOde/JXHJPWoMV9uf9vE1H3cQvpMT37mwDdpj8GPJpPoGr2I4xbpviNZozr7clD7tA7X9TyBRcfLEbD1X0gjnlxojnEtGeds7JDNW3LsNl+osBcCVkyA7gJZ7FO5gO2yBldYt4aC9fhQ6t7b+bReemsOwL0N5QwqCQb4njRDNdnrHCtrh+53Lfl4f/Lge4QVfhDfB6W8dUKFMg+AqpDGzIwXnazi2/nV07Zovpw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Ukp3b0p0NE9JSkJyeklBYklUellid0xVQ21tZmxPcWFUTkprSTVxMkVnL0lF?=
 =?utf-8?B?dllPcHdXN25Gc0trb1lQLzBVN2QzUXlKUjcxYVVJekY1K3ZrOXdZVHVmQkVK?=
 =?utf-8?B?R2Z4Y3ZGVnU3WWtLdzZ4NEo2R1JVTDFkTy9NS1cvdVFWeStjMnZGRkxtVGl6?=
 =?utf-8?B?bjR4aHVpUVZycjlzalI5Z1FCY2NrUmRiYXFNQyt1UlRpTGZybTVBaFNIK0g0?=
 =?utf-8?B?TCt6TlY4eEk1VTlmdUhFbVYyeUdHUXBIWXk2VUNxUmRxVmRRc0dOMExkaWFQ?=
 =?utf-8?B?TlR2QURrSHdmR2cvSzdtM24xUkpvcWdaY1lXbFhZV0dXWlF3dng0eXF3NmlE?=
 =?utf-8?B?Ni9YanY4UG1GeXV5OWR4YmZCazZzK3VmOWNBemVOVHdtM0wraXVZdEJDdTlo?=
 =?utf-8?B?dEhpaG9ma1Q2QThHRUx5T1NtVWVBcUtnR3VNWUkxRHkremI2V2lmc0tiYldu?=
 =?utf-8?B?cERibCtLQ2tVSFpDNWZkNkNGN0kvdTNNUVZmckNSMVh0MTdSVjdNOTRRWEdx?=
 =?utf-8?B?ejVJMERHanVKb2FDM2VWRUFFb25TOUFGSGU5aHFRZWI4cWtDeno2WFUySkpm?=
 =?utf-8?B?TFo3UU80S3A4TkJMOUl2M1RtalpRSkozL2xzZ3BDTVJCeTEzL3o3cmsrYVBq?=
 =?utf-8?B?c0xYTU1yT1dVdzgzK3ZmR0tpUGp4QnJWM3c2eVVYYmhQbUorNFFPOUFjZUNF?=
 =?utf-8?B?dXBteTFLZHh3TndnL0JEZUEwSHJVb1VVVGxmbmlub0tQUlZoa1Y0aE9ab2c1?=
 =?utf-8?B?TkVYQ2tmVktTOTd3YXBqV1ZHSTlNZ1pqVTlyUFJvTmdRaS8rTUpLb1gwMzFS?=
 =?utf-8?B?cHFDYmRPL0FZZk9hSXovZmNFRitBTDlpL3NsRzBNdmhWVVBnS1JEcmorOHc5?=
 =?utf-8?B?bjIyQlU1cDM4bnVLbTBGZGsxOTlaVW5FaVM2dXU5WW1XaEdGTHIva1N6NW9l?=
 =?utf-8?B?ZlBqazdacVBtcFJNeXJmMkxnN0RHaGFmUWNYa3ZhVmhZUnFSRzgxTitDNEI0?=
 =?utf-8?B?dTdGQjhCRGJJUTJHOFpTZjRiU21OUExGazFkSjIwRmNCWGcxMVF1RVdrcHVh?=
 =?utf-8?B?dkh5R24wM0o5ZlczSFBZODBkNVJ0WnllclpvZXRNeEMxRDhvTzFOUHFwV3Aw?=
 =?utf-8?B?TVhOY1hKNWtsZGEraHVFRzJLYThFbCtHV0hGdHRtSFovYytHV2tDUFN0RXhE?=
 =?utf-8?B?Vnp4dzJ4a3VUL282K1c3SEt6RUtwQ0ZuZy9ZTGNieGxyQ3FGOURqZUtTZjNX?=
 =?utf-8?B?K1hIdjRjaWUrM3dBbWlxUktWOENSd3NpYS91KzhSK3VkTHE5Uk9iendNcW9l?=
 =?utf-8?B?YVJJMlR1cXBBenkzZVViUGtqelFRcy81UzdRdndHZ1ZtcjRBZDVUUk9yS0JJ?=
 =?utf-8?B?MzN1ZERaQTdyYit1MTdaSjVqV28zSDhIZWgrMkIrWEwzNFVCRGFCRTNja0pG?=
 =?utf-8?B?UzFHYWM4a0k1SUFWUVRua3NLSlY0cDF1c04rVVpublY3ZTVyam9qUnVFUWlT?=
 =?utf-8?B?ZndZK1JZWmVmdGI1a0tKMWM0a2V3MDRQWVhzUzFvTVdKNW9sWFNnRjFvYkly?=
 =?utf-8?B?RHNnTzlRRUFlR1JJdTdJZFcxbkMrVDVXd1Vac3JOcHpBbE0xK01xdGtqYjdJ?=
 =?utf-8?B?aGx3Y0xmbVVsZW1DZWZlbU1JbHpKNTVGbUdDcEx6Vlk4Zkd5TzFlLzR2eFlx?=
 =?utf-8?B?QzkybFQ4WWZPT1VMYlBoUFVsV0htSkF4ekJ2b2ZZNU5IZ1NhTHdjZ2ZkM0RQ?=
 =?utf-8?B?TktWcng2VXIyVGtrR0ZrNXBWNkE1M3ZDNXVWOWE3V3VxRyszUy9mczdoOVN1?=
 =?utf-8?B?ZzBwLzVmK2pGZm5yQ2RMUWNzSE9Ta2FZeWJYUUFrcVg3bVBsaktUYkdKYXBE?=
 =?utf-8?B?NVNHdFpzbVNkWlBuZ0ZEV25UeGZ4amkrUHpKYlRlTE9ITXhDbEUrM2htU3Fz?=
 =?utf-8?B?RVJpdExwTkdBYnhvZURkSGVvY0tjcUxGazJienk5ejllcXJpTnJGQ0ZGc1FC?=
 =?utf-8?B?WDFueGllN05zZzdraEVJSVdJbi9FRkZ2Ymh2TjZndnIvZ2VDWDJZR1d1aEF0?=
 =?utf-8?B?dyszSHhOeC9RQUU0N2E3dnkzbmVKM1VXWE0xV2IxOEZoMWYydHUraUZocXNT?=
 =?utf-8?B?M2EyOG5pY0J1VlJVVVBrM1owYVQrS1Q4L1hER3NSa2NsSGdHVmxOTzdNbjVu?=
 =?utf-8?B?amc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b9302833-5c9b-405a-0ceb-08dc3c856d21
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2024 19:58:14.0343
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f6p0pjdEiZ9PPClE8EprVF9ME6F/Fgo6QMBvIFb2qpoEUhJcyopbnA+SsyXrrcfFljOXQdEXdVSUKfLiQAidahF7hJqlqwR0n6WzL9iI4SU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB6069
X-OriginatorOrg: intel.com

Hi Babu,

On 3/4/2024 11:34 AM, Moger, Babu wrote:
> On 3/1/2024 5:20 PM, Reinette Chatre wrote:
>> On 3/1/2024 12:36 PM, Moger, Babu wrote:
>>> On 2/29/24 15:50, Reinette Chatre wrote:
>>>> On 2/29/2024 12:37 PM, Moger, Babu wrote:
>> 

>>> To assign a counters to default group on domain 0.
>>> $echo "//00=+lt;01=+lt" > /sys/fs/resctrl/info/L3_MON/mbm_assign_control
>> It should not be necessary to use both "=" and "+" in the same assignment.
>> I think of "=" as "assign" and "+" as append ("-" as remove).
> Here are our options.
> 
> a. assign one event (+)

I prefer that we use consistent interface with what users may be used to 
in other kernel interfaces, like dynamic debug.
Considering that, "+" will not be "assign one event" but instead
(let me copy text from dynamic debug to help):
"+    add the given flags"

So + will add (append) the provided flags to the matching domain, it
can be multiple flags and does not impact existing flags.

> 
> b. unassign one event (-)

"-    remove the given flags" - it can be multiple flags that should be
removed from domain.

> 
> c. assign both (++ may be?)

No. Please do not constrain the interface with what needs to be supported
for ABMC. We may want to add other flags in the future, do not limit it to
two flags.

> 
> d. unassign both (_)

"=_" will unassign all flags without consideration of which flags
are set. User can also use "-l" to just unassign local MBM, "-t" to
unassign total MBM, or "-lt" to unassign local and total MBM specifically.

> 
> I think append ( "=") is not required while assigning.  It is confusing.

"=" is not append. It is assign:

" =    set the flags to the given flags"

> 
> Assign or Add both involve same action.
> 
> How about this? This might be easy to parse. May be space (" ") after the domain id.

Why a space?

> 
> <group>/<domain id> <action><event>; <domain id> <action><event>
> 

<control group>/<monitor group/<domain id><action><flags or _>;<domain id><action><flags or _>

Reinette


