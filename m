Return-Path: <linux-kernel+bounces-108140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB77D88068C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 22:08:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA52FB2141B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 21:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90C9E3D55B;
	Tue, 19 Mar 2024 21:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D0oa74yD"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE223C485
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 21:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710882513; cv=fail; b=kioQCT2eKtNSoH1WnTEy/b7e3tHlaprqEF+7D79lmZurIHwrAxtie0bDP2dpo/x6CxDijSB4bli+u2o/ugpWbFRn+I3PIWiir4sIPmiwoI1aJMnJ69xSbodL/EhjZpUlyOYZCNsqRaX4E/0yhbEaIZo11F/aUld4Vv0iHoNksm4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710882513; c=relaxed/simple;
	bh=0J4qPDro+uS2ynrV2RS8L0ARfoIp9JzRorydX0+pILE=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KJ5FyKdQt2d77X2Webal6ifPiNyA1T24RGhBVXjZ40jb+717yyRybjMh47RX7+5TAPiIz6/tvdBQqcfmIgSQVcModnuoCSo+kFCiB+N1JIgvyQLZCw0KkxiYADcEshI8D29sX0KqWhHdO5ZiTgaPv96wNka7SWh/w+kMIEc6JxM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D0oa74yD; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710882512; x=1742418512;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0J4qPDro+uS2ynrV2RS8L0ARfoIp9JzRorydX0+pILE=;
  b=D0oa74yDRNN4ZdSA4hNvHgJkGXLDz4XkOhCwsdwBcux/G2/VZzIP61UA
   c/wMg2D9U8Xn//2WcYYDNgRyZ2+MnteIST8OK2AYWbSXIhQ2m6WvT3XXx
   /GFhRgRjPuGN8oFGj03hzkCRqfBgq75LB/dFjIaFERNvSFxETaywSHQic
   X+seLYgLPkEZsB6+48+wcIhMQtpZrI/IQdvMRTYgBEjCEr3NGFkx4mMo1
   ESIbRADKkZtkEQDahtMD3RYLZN6KWjryN3+PS146SAKnYThw3eyJu6Rnk
   UTtZO6G8A05HPtBhus44tbcQHWzY7f9zfgi2+woID94XMfOPUmpCnG/1G
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11018"; a="9552595"
X-IronPort-AV: E=Sophos;i="6.07,138,1708416000"; 
   d="scan'208";a="9552595"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2024 14:08:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,138,1708416000"; 
   d="scan'208";a="13967365"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Mar 2024 14:08:29 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 19 Mar 2024 14:08:29 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 19 Mar 2024 14:08:29 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 19 Mar 2024 14:08:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Oq0cCQwMm3dgZfEN2pwcAeZ3e8TWe1ejUxTKsCAXYw1ClZAnicDZwrI6MjOaXivsXueAEvmWf5hjimKb7swzh214pFfovmvSG8jHVjxofetmQuuX9G3D+58lhw+C2nBw8mftlFtDwfZEezGnt4SdG73rhP/LGN3g1YCOjSdaBPlPurf6Ot1fO6kzxnXBiAn9Vkvjn8xvi9JkXm/4KfuwipB6ZfzYapFEnzueOHGwJWQe/v4UqSLZBu5aRKCpS8cDhKYEjUiR+HC4DAGJ7kE0AQs+cTKGUQDjIYWSBl4YDYdqINuB6RClJqsEtZ+BZKiB/FoL8hJwGHdY5puqGDvSGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k2hQgpbyXVMVi4Ok7pJkBp5mYXN9WNFHDPGy+6XC73Q=;
 b=e53LygHRIu3AEW0A7afUR/RJ+BVV17B5g795phHdDS6hvWFAS9ltMENcJW/XqIBmJ5XCK6xOtTD3uG+OtDVhDXPmptoapSpj4HFDBsLdtSP6yT+FpF9KovlNkM26Z2i4vshWyC71NYDaiXTh7ME2Wy31SOC+UzDAbdeVQ22jDtgWz4OAXky5SpfUcCJ6aQEm2S6A9OKEKFd+TMIQKwqnNy4+NfqKliqmAlEUG+o9HXiIHUNtr3jC1fzdbbQ+SOUe9jmIA1/x6V5v4x75ITGCGhQ2JSkyPqMpCelODLHUn+dxAyURw+KR+nAO/RrkkovhKVyY/5D1GLpO7/UqOeeGYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by IA1PR11MB7174.namprd11.prod.outlook.com (2603:10b6:208:41a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.12; Tue, 19 Mar
 2024 21:08:22 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ef2c:d500:3461:9b92]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ef2c:d500:3461:9b92%4]) with mapi id 15.20.7409.010; Tue, 19 Mar 2024
 21:08:22 +0000
Message-ID: <f4487d93-8207-4d37-b94a-7cb00894a198@intel.com>
Date: Wed, 20 Mar 2024 10:08:09 +1300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] x86/kexec: do unconditional WBINVD in
 relocate_kernel()
To: Borislav Petkov <bp@alien8.de>
CC: <linux-kernel@vger.kernel.org>, <x86@kernel.org>, <dave.hansen@intel.com>,
	<kirill.shutemov@linux.intel.com>, <tglx@linutronix.de>, <mingo@redhat.com>,
	<hpa@zytor.com>, <luto@kernel.org>, <peterz@infradead.org>,
	<rick.p.edgecombe@intel.com>, <thomas.lendacky@amd.com>,
	<ashish.kalra@amd.com>, <chao.gao@intel.com>, <bhe@redhat.com>,
	<nik.borisov@suse.com>, <pbonzini@redhat.com>, <seanjc@google.com>
References: <cover.1710811610.git.kai.huang@intel.com>
 <e1d37efb8951eb1d38493687b10a21b23353e35a.1710811610.git.kai.huang@intel.com>
 <20240319154111.GEZfmyF7IuQ5THG0qO@fat_crate.local>
Content-Language: en-US
From: "Huang, Kai" <kai.huang@intel.com>
In-Reply-To: <20240319154111.GEZfmyF7IuQ5THG0qO@fat_crate.local>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P220CA0006.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::11) To BL1PR11MB5978.namprd11.prod.outlook.com
 (2603:10b6:208:385::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR11MB5978:EE_|IA1PR11MB7174:EE_
X-MS-Office365-Filtering-Correlation-Id: 537a3054-d80a-471a-ace9-08dc4858b56b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RDjgDIEZJ95Wd+Rvs36seeYW+vLyVmoIO1GVyvfn1i5lCqRY4PXT2Hhxa7dS9hASAg3XGXLlYmHRUZySF5Sv1UKcYAVbBimkPmj4DRxWAvuRqoqiZBE4b7RI6tZ5PmHkUAZD0rf4LtrZjqDc7sqhi3SE7YptD/Wkdv31gWKEGFGQkLp8ciyPlOgZA/aOVsBU72EfOhrgTKmZb+OjxF5/2MaxwkeKY3XXeiA9+9IMs7GdLxoInWBmbQsVdX10bvF0HcemGJg9aCSXNgSJdZkN4h6dueF1RbHKu/1RiuPIs1wa/cXJMID1gxl/PAdXH+ZHCe2TlWF6mi1DQmYJwwXxGNJ+9hVXqHflgcvtB4pIa/uIfE1t3WRigt58350901ZRgwcLBeu6yMX0yfEuDbbUR3JTK6ZtjiRZy7neTim+2c97MIflR81OHdashKqQhsxDrs34mQNpHHF5MYUyDvFLdJSFx6roTIr3/RZwxg3rf0nQgR1QIs4ldihZHx/cZL7bPKeFB+jA1K/3v3sPHUv2wJj4TfsJqxkMCg9tMippXcbYtqt4tv5uDtyMUvne8jUDQHeDb/QGJU+mklQrjXtWU27RHP/1pRXVCC4q3zfD6Js2CGbEpWwmJ1BkW4vJcCAJDj3uDzWJeSK9u8PlOBV1K5twzXbWuGS3xI3Kn004k1I=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MFNSVzVhMmlYVm1hZ3VkMGh0YXVtUkljK2F1cTY5eG4zTXBrN2NsVTZocnhv?=
 =?utf-8?B?MHMyemowZktDUFJWWjhjMVBkVVl0Q0Z3M2JvNnJFdDEwYStpK1pacytQVE4v?=
 =?utf-8?B?M3VPK1crMk5mSTVSdC9UZkV3bEZOWU9wb0lnRlRrNkxjWC9yMkRySHh0S3Rm?=
 =?utf-8?B?OHJGVnR4L2pyYUlmS3hCbWJadTJrckZ2ekoreFhkTXRPWUVxVVN5d013eE5J?=
 =?utf-8?B?OEVTcDUwRG1UbTVaVVJlL2V6bG9tZ2FjeVBRTVRvN0ppUGZ5cnQ3ZzRhVFlv?=
 =?utf-8?B?N3hkNEdmT2FYWmY1R1hBQ0xOMDdteWx3YU9DNUM0MlRNRTlpTW1xeU9URmkx?=
 =?utf-8?B?aXQrMWxGbEI2U1Y5SmM3eHAxTE9Cb3NIdmx6bFM5TkpHeXNGR25rbFBoTG1X?=
 =?utf-8?B?dVZZaE1MNHpVaG5udFlDVEtNUnVVbDY5VnErNG9oOFVobEttYXdXcFNMcDht?=
 =?utf-8?B?aHdGYkFwSmlKSVNBOHZWMkxhUFhlS3lGVHNxS2RUZTdTQ2ErdUtYNTdlcE5V?=
 =?utf-8?B?UEt5MXZwYUNuZDR3b2VwOWVIeFcrWlpEaTBtZnF4dk1mcndHa0p5M3VzVmxx?=
 =?utf-8?B?N0xQYlF5bFIrZDEzRUtYS0pDbGZvLzN0bC9LVzlTMlRnWTNId2c5WmxZNW5m?=
 =?utf-8?B?YUFteGdvSWZQZGVjRjlQY1ZtcmU5eFBSK1I4NmtPQ0kvYUMyazgzSXA5Um80?=
 =?utf-8?B?dzduN1QvbkQ3czV4VVoyK0hQVWhyWEFsR2FmY1ZYUEhwY3pERGJpVGVBYXhO?=
 =?utf-8?B?cU83K3V5U3dnUDFocE5iYTE2ZFo3dHlkSUt2S2NFdVJ6ZlViVHBFVHNQNVRF?=
 =?utf-8?B?aWlZMUdKMHJCcmRMMGNmMnAxWGN3NVRTcVFvYWdsRlYxcG1meVdZZ1pqTkNz?=
 =?utf-8?B?QkY0cUtSczFrZmtCVGdvL09rOXE1azF5YjV4ZFg1V0xCNHlFZUNwSWlnSTRL?=
 =?utf-8?B?WXVXR2tuNTNRYkVSTE8vNDRVcUJPRnNxSnU0ZzQvVkx3T3EyWW1yangyak13?=
 =?utf-8?B?MUt0cXhqZGtqdkYvcWtDdmxuM2VEcDVldFdqamZvUlM0M0ZIVDhaL25jSnJ5?=
 =?utf-8?B?dGVVa1FiNHJZcmtpR2xGLzZvdThiN3JKZDA5N2duY3BYYVVPN2NNUGZncHV4?=
 =?utf-8?B?MERoVVA1VWV5T1Q4ZCt4cTBINVJBeEp2a1orTEVSYlN3ZGg1bVR0RE12SnNa?=
 =?utf-8?B?alZzcUkvM2ZqaGZxdVpwbEpnb2hSM0UyUTN4ekY4TzRJbW8xcVpDcjhGSjEv?=
 =?utf-8?B?ZDdlaCtNK1JWY1RVOVNQdXh3KzBNZVBJVEJSTUpvTktlRG16aHB4M2dpbG5K?=
 =?utf-8?B?dHJ4QndJSVFDM1Axck1aM1BoYUlSSzhkVXVveUIxWUR3T1hzV25DaU1DZDdk?=
 =?utf-8?B?dGdzbFhBWkY4TGtSQ0RLa1M2NGhPQXQ0UUNET2pBR00vVkRRODh2Zi9Ba0Qz?=
 =?utf-8?B?dWhyUU1UNXNRUUV5QUNCamhrK002dE8vY0U2M3NMbk1ZVVRvTGFoaW0zR2wr?=
 =?utf-8?B?TUJ0UlY3VWlndjhmRUdqbzhKYzk0bmJaQ1lwMUFBMlpMOHhUUDROQzdPRnpW?=
 =?utf-8?B?OUV5WGYvQVlFbXVSNFE0YmI5RFRWdUw4M0F5QnJEUUhOUXhWeTU3RGxHWm03?=
 =?utf-8?B?aW5UUi9ZTFVkeW9hVUJYSlRTZnBPUW5iVGFPV2cxcFkxSlIwR0IvbHZPcFhl?=
 =?utf-8?B?ZU4xN1lyanoyYUpWYnc5VmxvS2NCK3R0ZW16dFY1d1Rqc3dlK3hhd1ZOYkx2?=
 =?utf-8?B?Y1Z5OVFpWU9xZ0M3WGVsUjJSVHZYLzM3VDg5K1JqU1lLdS9YZDhQaHg4Um0w?=
 =?utf-8?B?UEZjTzczZ2VkSE44WHBMaENPNUdDdGhqUi9FZ1MzR0cxQjhxbW1aVFFaWGNW?=
 =?utf-8?B?QWZLUDMwR0lkM2IrbnVYU09NRTRJSmlFWm5QMUxWdUdHZE1vZmZxWnAvS1pl?=
 =?utf-8?B?blhaZDl6RmVnVXB1WXRVc09ZN25UZzYwUnBvckJHdXpJT0ZJZ0F4cEZSamJ4?=
 =?utf-8?B?cUtvajU1WGpnZTFtdzFqQy9GZ3FhWFhVZ1ozQXVKTkVjdFNmSmp3MTJIbUU5?=
 =?utf-8?B?MDFlSEJuOHZnak1EQTU2RkpCc0s1cnVnUlZqd0FOS2IrRkVuTmFPT3p3cHVW?=
 =?utf-8?Q?ahRuJ9e+Ix1G+GLYmyhILgdzQ?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 537a3054-d80a-471a-ace9-08dc4858b56b
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2024 21:08:21.9814
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w90LyYVp/bRsg5ktAE5rEkuwggwFzT8zmsE9cS/ysMdH9FAKY8t0khWVh2+RjTQgnTLnhBR3sqZbkRotEhTBVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7174
X-OriginatorOrg: intel.com



On 20/03/2024 4:41 am, Borislav Petkov wrote:
> On Tue, Mar 19, 2024 at 01:48:45AM +0000, Kai Huang wrote:
>> Both SME and TDX can leave caches in incoherent state due to memory
>> encryption.  During kexec, the caches must be flushed before jumping to
>> the second kernel to avoid silent memory corruption to the second kernel.
>>
>> During kexec, the WBINVD in stop_this_cpu() flushes caches for all
>> remote cpus when they are being stopped.  For SME, the WBINVD in
>> relocate_kernel() flushes the cache for the last running cpu (which is
>> executing the kexec).
>>
>> Similarly, for TDX after stopping all remote cpus with cache flushed, to
>> support kexec, the kernel needs to flush cache for the last running cpu.
>>
>> Make the WBINVD in the relocate_kernel() unconditional to cover both SME
>> and TDX.
>>
>> Signed-off-by: Kai Huang <kai.huang@intel.com>
>> Suggested-by: Borislav Petkov <bp@alien8.de>
> 
> Well, I suggested what you have in patch 1 but not this.
> 
> You can't just slap tags willy nilly to patches.
> 

Apologize.  Will remove.

