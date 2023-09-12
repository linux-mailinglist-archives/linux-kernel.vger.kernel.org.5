Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3C0979D60F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 18:18:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236545AbjILQSP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 12:18:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230017AbjILQSN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 12:18:13 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C19810D
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 09:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694535490; x=1726071490;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=FH6BM0oA32G42Pm+vr/fyHAP5ZqqAmbliHj3eQifqOU=;
  b=XcIYXCVSD6NcyQOjKKLaNk5VEt1ZUguagllfHoHTvg3ypRA7WTj0uXXW
   JiTlTJJk048fYPquFM8Vx11NMQGf7JnbBXOqnaAS3MtogaiPRa3IJFDn2
   HhsaYYfTAWahYYVSRPIJhZ3HW7fIy+WigdOBwAqwNrOWTEQiKiwVJlO66
   BL0g4aP5+U8G/1y5xeXE/EUJcmWWX1lXrNr6XEXrZkI6xJGO2QbZvIROu
   oPs1gW6b76MSGh+iVx9ACFcWZmVQ4M7YCzPKokucUIDeGddPc+lLt9SzG
   jSCKAcjkV/lkJQ1aFd9V7RH1bklXOoKLlZja+8Fn3gge4X5jpkzzSYGSu
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="358700363"
X-IronPort-AV: E=Sophos;i="6.02,139,1688454000"; 
   d="scan'208";a="358700363"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 09:13:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="720478653"
X-IronPort-AV: E=Sophos;i="6.02,139,1688454000"; 
   d="scan'208";a="720478653"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Sep 2023 09:13:51 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 12 Sep 2023 09:13:51 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 12 Sep 2023 09:13:50 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 12 Sep 2023 09:13:50 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 12 Sep 2023 09:13:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ev2Ra8kSitrNu+r1vteUV4gzp82b32bvkwoS/VXrka+Ej62wYjrEXLoaA+9y3ilYb75iOR51hQzoqpNsC42nTLeQrVGQmuo1EXIH3y8zGHznprhFbh73323lRhVDaUnx/LeSMGJL/5IWyv0yaum9TAtCEo1keYdgZKIcX2UsdaHn9cDPU4omQ4CmMn3nRsQnPeOCjb34pEeHzhunTzXQCh2a8tdOXNLHaWIdk2nSCP3wutBMab1Xq7QBJeBu/0Kw9y69f1WSsflw7u5BIOGOJiGGatMlfbsgaHtKrzjmANNGKUjyoKX/b8OQN9JVZOk1dt8XT/GriOTJkA5pE57dVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wqmJ8Tu06NhZSarbP0Yhg3UUfV6/yKCANqgMkiiBbKE=;
 b=BhEzRZHTNm+DCJGUYpcRdIPd3/4gtnQcowbwztTa3sm+Rgbn/qtXBgmROMah/QdcqLiMx/42pV4yMm1ZNT2sKIsNnmBnGP3ubONeHQBoPkHsTxBWhi+RARdo1z9FBfZWia2k0bBJdSA80yPSiRKpCfciTOhzjvsyAO+pZYmoe0WFpnQ/vgcegYn9Qj0zRUcXyIS5fjgbQXSgI8fCOZEDPewQkk8L0bLJ9b2v7ZKkdyfY6qfjy4l09SeawuY1//QtIw4Z9e4tG4IpriYmAMNNDxjcXMDl980wzs05oeG+rTkPMKcf/9m4AznjChwfSKVQmaNK+1QPXtukxsa3e9weEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by BL1PR11MB5527.namprd11.prod.outlook.com (2603:10b6:208:317::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.19; Tue, 12 Sep
 2023 16:13:48 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::afd6:ce92:6244:7203]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::afd6:ce92:6244:7203%5]) with mapi id 15.20.6768.029; Tue, 12 Sep 2023
 16:13:48 +0000
Message-ID: <7b73c07a-c229-9d95-7069-7d80df465ffb@intel.com>
Date:   Tue, 12 Sep 2023 09:13:45 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.15.0
Subject: Re: [PATCH 1/3] x86/resctrl: Enable non-contiguous bits in Intel CAT
Content-Language: en-US
To:     =?UTF-8?Q?Maciej_Wiecz=c3=b3r-Retman?= 
        <maciej.wieczor-retman@intel.com>
CC:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, <linux-kernel@vger.kernel.org>
References: <cover.1693557919.git.maciej.wieczor-retman@intel.com>
 <1bd3aab725a4e2948530095eb48b11bcc4028f8e.1693557919.git.maciej.wieczor-retman@intel.com>
 <4c89d09f-c5a9-892a-4c7d-bdef0204547a@intel.com>
 <ob4e7sb4pfitjn7arlt7f6be3hvdoyp5yecb4o5ub3i36u2qhv@4s6vzu5nk342>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <ob4e7sb4pfitjn7arlt7f6be3hvdoyp5yecb4o5ub3i36u2qhv@4s6vzu5nk342>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW3PR06CA0015.namprd06.prod.outlook.com
 (2603:10b6:303:2a::20) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|BL1PR11MB5527:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ccc93d1-8b93-48e9-c954-08dbb3ab3f1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tLv1yqLj/0iygxFqxqMs1w7TQr5iAP+CxkcfbuI0NxYK4Izyog3JBUR85TFAc5KSk3Xs0NjNbANjt7kOdPIm5K/XfxsA3yNijcW9cd/5l01k4ciEFxrI96EdAs082MGrkTDT0Va7P4qa37ecNbRGJsIr+Kmlzxu/FicJ2n6XuLGoAPUHLeb5tFbx2xymjtrRRVZlS2diyiYIjZCfYOKh+5v/WnvfJ2YXadgPuf5ghmBVbZPVlZH1ZAZfpaYZEZ5UBTfR/CCx1UCrVVSN1/kJYVfTWBraGExCthVfhHugmhs/A+ZzWWMGP/eV0QjsgLclAv9j1pV0T+UDLYfUz6IQNsqQe+5BUctiw4MP4vFbJHrGHEGePBmnEARMajIXcOQqMy++8/8BhfHuN16rLxa97YhDxMoz4C28hI23rYi71CorTUgCbER+5TfgCX71UXVmHJ1CopVYLuRYFIId7Q6H2UawfJ7O31aV+87WWoS92ti/ZKt43IK5G400UZgslLyczmp+3kwg9XR0UD+znp5RIhrqwF862AlBOiX3e6SL+nkYGI04SsadQb0+85VoSMhScVltI9o83ERWshzAZUIHwpjDpPZ0XOBzr2HJGWv52zWVIUk3bXIOc7Su1aGFM8TTA2GdQ628Ld0ox7NEgECIFg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(396003)(136003)(366004)(39860400002)(451199024)(1800799009)(186009)(316002)(37006003)(54906003)(66476007)(66556008)(6636002)(478600001)(82960400001)(66946007)(2906002)(38100700002)(31696002)(86362001)(8936002)(8676002)(6862004)(4326008)(41300700001)(44832011)(5660300002)(83380400001)(2616005)(6512007)(6666004)(6486002)(6506007)(53546011)(66574015)(36756003)(31686004)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NTdkYWwxVzkvNFFUS0MrK0VBSitLc01IQ3JaeHpWWW53ZGlYRFpxN0JUb1hw?=
 =?utf-8?B?d1pvcVZMQ2t5R1MwODdONm1vdUtmbnc3Q2dsQTJJaW1wSEI4N01tWGFRWUtW?=
 =?utf-8?B?N092eEJ5TVdpK01OWFM5clBwQXJvbzlBZlJhOEs3eWZERkZTUHg1TVNIZnpU?=
 =?utf-8?B?cmE1SjBlNFRkeHlESzEyeTlKU01GSFQrUlhHbUhua1Bta1BOMjVwYkJEWDFh?=
 =?utf-8?B?MWRPUjF5QkRVT0haTDU0R3JHRnhaSnBrQzlHY0dWTmhUY3Q0WnE5NS9BZ2E4?=
 =?utf-8?B?aEc5ampacDRoWkhlRHFFZ2lDdDJ1VWMvYjlyaTg0cjcvL1pBeWNJMVJyUWgr?=
 =?utf-8?B?dlgxUGthc0dXSTZGNllhNmdHczdGZzNzc1BScWxkMDRUY2NYMzZCaE8xeEFk?=
 =?utf-8?B?Q0JBWGJNSHNiWW80bFBJSnBETk1oWC9ML05PeTNPWVZOK0dsYVNEMG84ZVZK?=
 =?utf-8?B?a2xPRUI1eWMvZUxCNVpmdUF6SU4yRU5jbU5KZW5NUmZpL0NqdnlJZy9uRjFj?=
 =?utf-8?B?Q2FRQ0RLcUxZZnpsVWVPMTF1ekVqS1M2djFTWldQQmtRUkJkaG5xSHBGN01O?=
 =?utf-8?B?UEsyM1Q1ckhIaHBSQzRxQXJRRHRaTGdFYksyeWpHRVpoeGh1VG9yZEhTMnRi?=
 =?utf-8?B?aDVLcUR3RkJEQUdQdlZpL3lRTEVvWEhkMFZiOTBwcWhZbWxjejBFKytMU2RM?=
 =?utf-8?B?RGY2U3l5NmxTQW1rNXlJYVM4NmZYMTFaTnNKYnFnMFppWTFlZlhJWnVOSlV3?=
 =?utf-8?B?TkNMMWtjQVBjQWdmSTh6aThxdW5wRnJOWUhHV2xySDdKY2Jja1hYY252RVgx?=
 =?utf-8?B?bi9qQnUweldPaFZ4ZUx1M1RmUXZUTGM5MkJEcTZMMFV0MUx1VXMzb2V5cUVS?=
 =?utf-8?B?OSt2enI1TXdJWGlFRHd4T1RseU9sODVvQ2drdksrQUEwNk15WDI4MWthR2hi?=
 =?utf-8?B?dHcrR1BTU2F2MzcrUHB2Y2hPeDR2M3Rkak1INnJxazdFZmZyaFlpUUV2ckJz?=
 =?utf-8?B?cVEydEZTUS8vQUoyZEYvWG5rb2c2cGRUYk5oZU9mZVNQRUlsL24zVVl4YjZP?=
 =?utf-8?B?a0hLb0tKbmRDYzIrUERyMVBpdFp0NmRQampORXRQdE0vOVN6UTZtalYvUjUw?=
 =?utf-8?B?ZWZDbnMza0J5b2ZmU1d2ZUJMMGh3dUo2ZFNDQU9hK2wzYURWV01Ib21EZnhK?=
 =?utf-8?B?MGV3S09uMHZ3TlVqWlVidytqV2RaQVZJLzRObEtEWHFYSUx2Qm0yWXM0cXls?=
 =?utf-8?B?SVQwNlFtYStEREowS1N0c0ZLR3Rra1V6ZEwrbmU0Q2hlWmY3Z2gxVTJoNG5B?=
 =?utf-8?B?WTdsSlFsN0hBOVNVbjU2NURGRGlVQVpXUFhqQ21pVG5hekZWMGlBTzRBVDVJ?=
 =?utf-8?B?MlIxTGlhd1l5RWdjejhrNSs3dXhLR2lLakVvZ3lmTE04Yk5WYkNKbzBJNGs1?=
 =?utf-8?B?dk15YUF0a3ZreFdKN1BQdk0xTjJoT3RtUFlSMmM5QUJuK2FSb0FMWUtPRVE1?=
 =?utf-8?B?K3pWTTFVNHh4RGdabFQyZFFobUpkZy9KSi91Z3VCOU44YnJscllLN1ZxOFZO?=
 =?utf-8?B?R29GcUhRdnNHZFI0T1crc2gwUEtWajI2WThnRUhiSHFsaGRuU3Q4Q2dRWFVU?=
 =?utf-8?B?VVU1VHlBVkRlYkR5MWx0SHdwb3JTd1lZMjNxUmxIclRJSVIxRkVDUkZ6UU81?=
 =?utf-8?B?ejFFR09HN1gxUkw3NzVsY21TTjJDYU9LQTFWT3YranJaeEJHOVdlbndYd0hh?=
 =?utf-8?B?QkpLMEtoZHdVdnhOL0loUmdrSUxESklPWUkzV2FuQXNMM3A4a2xwNHF1YU5G?=
 =?utf-8?B?VTVYU3I3S20wN0t0VWVzdTEvd0duRG9kbnJiZXBCUkNqd25ub3UwN1lxd3hK?=
 =?utf-8?B?NlFWdlF2MkU3cjd6alNBUjRXYzhlMFRhNStCYUxTU3R1VWJsSkl2TG1zMUUx?=
 =?utf-8?B?dU5pNHNpb0R3Tnc5SHFRbFd1eTBBSkZBNlZRNUdnSXM4SW5rUnlUeGFxTkJk?=
 =?utf-8?B?SElCamQ2b2kxYTNOMWdvdzgwVXl1cGUvelpzMTFNcGprNkNjUmp6Zm9YRjdG?=
 =?utf-8?B?ZGRXVU5ERG45QjYwbTVwL3FUbkdNa3V2RmdOUm1Wb1RCWlFoNi92N1NzQzYy?=
 =?utf-8?B?aEVQc3B1aFh6ZFhjM2FZQUowbHllZFkrU3N2RER5RjhoMUdIb1BkUXg3SGtJ?=
 =?utf-8?B?dkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ccc93d1-8b93-48e9-c954-08dbb3ab3f1e
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2023 16:13:48.4341
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fM5Fr4Zs+6cjnpImP9IUdGtC5zlWB4YFFoKOMu91DllRTSl6zSwmbKvrMixdq3i09HpZe4i+BEnBB6JKYalW87hRvNUarW76+Ex1B6v5c/o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5527
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maciej,

On 9/11/2023 11:53 PM, Maciej Wieczór-Retman wrote:
> On 2023-09-11 at 13:05:16 -0700, Reinette Chatre wrote:
>> Hi Maciej,
>>> diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
>>> index b44c487727d4..782e2700290b 100644
>>> --- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
>>> +++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
>>> @@ -87,10 +87,13 @@ int parse_bw(struct rdt_parse_data *data, struct resctrl_schema *s,
>>>  
>>>  /*
>>>   * Check whether a cache bit mask is valid.
>>> - * For Intel the SDM says:
>>> - *	Please note that all (and only) contiguous '1' combinations
>>> - *	are allowed (e.g. FFFFH, 0FF0H, 003CH, etc.).
>>> - * Additionally Haswell requires at least two bits set.
>>> + * On Intel CPUs, non-contiguous 1s value support is indicated by CPUID:
>>> + *   - CPUID.0x10.1:ECX[3]: L3 non-contiguous 1s value supported if 1
>>> + *   - CPUID.0x10.2:ECX[3]: L2 non-contiguous 1s value supported if 1
>>> + *
>>> + * Additionally Haswell requires at least two bits set. Since it does not
>>> + * have CPUID enumeration support for Cache allocation the non-contiguous 1s
>>> + * value support is disabled.
>>
>> The second sentence can be misinterpreted. non-contiguous 1s value support is
>> disabled on Haswell because Haswell does not support non-contiguous 1s value,
>> not because it does not have CPUID enumeration for RDT.
> 
> Would phrasing it like this:
> 
> + * Additionally Haswell requires at least two bits set. Since it does not
> + * allow the non-contiguous 1s for cache allocation the support is
> + * hardcoded to disabled.
> 
> be more sensible?
> 

I think the above would be sensible as a comment of cache_alloc_hsw_probe()
where the support is hardcoded but here the comment is just used to summarize
what the hardware supports.
Maybe just something like:
	Haswell does not support a non-contiguous 1s value and additionally
	requires at least two bits set.

Reinette
