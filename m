Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CC0B78B5E5
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 19:06:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231488AbjH1RF7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 13:05:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232796AbjH1RFo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 13:05:44 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7B58188;
        Mon, 28 Aug 2023 10:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693242339; x=1724778339;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=FaflZWWp07gCDiWm/sbwVriit4kfQtwFcJQ+eYOXzNE=;
  b=SMAJPddSpQJI8BqchX+HTCgqZG28Tfj6hQxhOJ8hWJOL7SAY3njELMIM
   402ypytGma2PxPJGRdWnvi/WAe4CoNpPhnUfGxd79neJaZK3vRFPgv1DN
   ChAwDxJB/ZMgECNBtfFwhaJS7lF0tZaLbrAk1gqPBLvCzu5+L6BMhbTiH
   ToCRva4BE6vzxc8ppzlVrPnyUD7wqaNwwqIa5hjYjErgpVHBl9b1a9GmO
   e6oswicOhyw8awERimLyRi234Ow9jBCIhXt3l9YeUPo/bU4znHx6uFVWV
   i2IXtl2nteFpGT9u3UYUB4jxLpBIAXoHURYPAL5K7NQ7/q8MsZTefhJaQ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10816"; a="441501928"
X-IronPort-AV: E=Sophos;i="6.02,208,1688454000"; 
   d="scan'208";a="441501928"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2023 10:05:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="881993350"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga001.fm.intel.com with ESMTP; 28 Aug 2023 10:05:44 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 28 Aug 2023 10:05:38 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 28 Aug 2023 10:05:37 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 28 Aug 2023 10:05:37 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.45) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 28 Aug 2023 10:05:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NZvr+Rng7WIcRy1FkccXZa0pUfn4zmN9a1nSKnEEh0G0+apJXtFoePVqMZxUbflNNMDfNxtOH1tCBNowCaSecw+D+InUogQe6yf8wqgSNYbevv2sUeYnrnnymZLKb/pwqhGnxoHjmmAHzAg5eD0LVulnR6XUW2W0kQ2SwXja3JG1R6MY8jiSkc71nz23A5k2COls2NulsZZXxbhvUs+OcOAOTOjDv7OKxbCnykDchkqU3wL/l0Iru94EMgfhZu3t86wYi1z2yT80F0ULD1a36rBuOtC9YsNdrVOY8ggmikgwCa5/rkgLrr59m1hrVIbUUmdPhJ0L3QgsKmAaYtwr7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OY9+8PdYsZw8GOx8tOphWu1gsU2IdulXAEtTE8JTvNI=;
 b=J2XNgNra7KGy4GEzUkiu85kd5fMK3Cr4MLm7nG8OTQBpM6wqO8ZlliUX3isuPeOwyfXRrVX5hkxOnhVwfhXpdYPwW+c79gv7yQKy0461CtTyqbCaFgpGUuGvDebeElDHDaOwYvTGMsK9JghekQfUGDq1rNNgTj3SA19tp2Ghy2x6a99ULY3e25tuqi5FIoBfmcEG2vIDwAUxac7bIeadEeh06pyOzhxIrzApzSlQfKq5XPAZJ9+/eHFJ0qRcI/esKuF8ZAsqTPT6hku1cm7Gk8CKYJDlryHSC8rdyzj0KtyxIwG0o2LsPqoz2uT6OHX3QOVvVeXwgNaQKkf+zy7RrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SA0PR11MB4750.namprd11.prod.outlook.com (2603:10b6:806:9d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.35; Mon, 28 Aug
 2023 17:05:35 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::47e:3e1f:bef4:20e0]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::47e:3e1f:bef4:20e0%3]) with mapi id 15.20.6699.034; Mon, 28 Aug 2023
 17:05:35 +0000
Message-ID: <da2c0e45-56d0-e04d-774d-4292d156e1d0@intel.com>
Date:   Mon, 28 Aug 2023 10:05:31 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.14.0
Subject: Re: [PATCH v4 1/7] x86/resctrl: Create separate domains for control
 and monitoring
Content-Language: en-US
To:     Tony Luck <tony.luck@intel.com>
CC:     Fenghua Yu <fenghua.yu@intel.com>,
        Peter Newman <peternewman@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>, <x86@kernel.org>,
        Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        James Morse <james.morse@arm.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Babu Moger <babu.moger@amd.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <patches@lists.linux.dev>
References: <20230713163207.219710-1-tony.luck@intel.com>
 <20230722190740.326190-1-tony.luck@intel.com>
 <20230722190740.326190-2-tony.luck@intel.com>
 <cc1a144f-6667-18fb-7fe7-cd15ebfedd08@intel.com>
 <ZOjfPx8iwTULTqdg@agluck-desk3>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <ZOjfPx8iwTULTqdg@agluck-desk3>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0300.namprd04.prod.outlook.com
 (2603:10b6:303:89::35) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SA0PR11MB4750:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f744774-40a7-4cb1-5f7d-08dba7e8fe8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +h8fd0C4/1xzC380MLD36cJnFc1yXyBxwF5zVXIHg+znFXHNeDv8+/fbBQh1quU7xNuYOvfyc6uOI6wX1uvYRW1tQ8/bgBCHdJBVPn14czf/617/kujOqiLUMrt1BsbSTeQUUUH57c4j+LuPCUHhfXnMpcQ1kh88T4UN0u2BmOoOdOGLYgmn+4FnuQZavpwtjvu7Pt9vOH+FLWoE198NQTIZu0nhqiCoYqoroOhpbt9tUzX+81gQweXCuh0+GjDMu/vxAhQBsWxwJz9i+Ykgl9QFOSRk80IxLexbo06YiFWrC2T0wKUMRUjFJmzeXB+CzAGkXCF3Cs3g+dpmAWx4wCcOoBbhfHmhqZv0eWxcXXrtF6DvwJBw5c2aes5LBC2Mu0CDliJ+0VxAZ3UaUyqe6ymOyJ/JyNn2O67ZwGcQ/ShtU/XVUPupYq4DsohHJ7OJYIKBgEioDqn3H4rbcr20AiyoiQa5SX1/gjpYUrl7/ltbg/l6iyOd40YVZDplX7X09DeqoZlqwHmrOAvyJisiuJeZL7toGVzuwAPIOe4EbJWhxrkWTTCrwsg633LKFDYaLjA/03AO7xzsH3EXEuq+Y6hIjnSMiPGZopgm43/QcGL70lu9CDfR5QQihrSWo9NM4E3mz5Q9998guvNbUFd6DQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(376002)(366004)(346002)(39860400002)(1800799009)(186009)(451199024)(31686004)(6506007)(6486002)(6512007)(6666004)(36756003)(86362001)(82960400001)(38100700002)(31696002)(83380400001)(2906002)(26005)(53546011)(478600001)(66476007)(66556008)(66946007)(41300700001)(8936002)(8676002)(4326008)(6862004)(44832011)(5660300002)(2616005)(7416002)(6636002)(54906003)(316002)(37006003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bDdHRi9MNnpJSjZCRzBOdlhyZHZ4eWVKc2lLME9XejBFMVBDbzVFWTIzemJr?=
 =?utf-8?B?bEtKZWVlY201TmFVVDRhY1FreFlQSnI3US8rUmJaR1VXQmJzWE1wSytZS2o2?=
 =?utf-8?B?eG9ZenhhSlMzU1JCeWRIbDQ4UDhTdkdEcWpmdFNQWDlsL0lFTTNxWFJtZHN6?=
 =?utf-8?B?TlhxTjR2UktpbnNvRTlWRUhESDl6SUVUWVM4cVVZR1RvL1JyeDdDdVQ0OWlj?=
 =?utf-8?B?RlEzMjVVbzl3NWNYcXg5Sy91L25RUUZWVWVjeUQxTWQxYXdwRHRwQ0hmWUp5?=
 =?utf-8?B?cXpuTDVMYlU1VTZMeXcyL2U3VVlNRElyZDV0NXQrTW1kS092OVpETWxWVVFL?=
 =?utf-8?B?KzZRN2FtejMvaHI4QTg1WmFHU0lpbFowRjlpU2NtNU5vVThqTzZEZEw3azRD?=
 =?utf-8?B?UHJGNmRPWWw2UmxneUhIaUV3OGgzakRYcXNKN0tHbS9RYVZIajUycGdsWHFO?=
 =?utf-8?B?SnRNUXJlS0tERkxDNUhPT2FQN1NvcjVsNUpZdkxuM3NvMVBMREZzbWJQTUtC?=
 =?utf-8?B?WTlZWmJIZU5DdVJiUXZDRGY5NVFlK0grMm1lSmhFOVdrMElBYXMvQ3RSQVZS?=
 =?utf-8?B?L2VjN2owRjY3a29ma2QwTXQvcWJZbmQ4aGlpa0M5UjFmeVp4Z1l4Wm80VXpW?=
 =?utf-8?B?SW04bzVXcVN6ZTQxY2RiM2xEZ3JGWENoWlFlZDJPWHZYNEpsY2xEcnRpRjI2?=
 =?utf-8?B?N3I3NmtNQTFIUkpXZ210YU9RVDBSdTAzekZRTEkyOGFxSUhId2cwOHJ3ak9X?=
 =?utf-8?B?ZmhObWJJb3FaYTVsbHZHNEZjaGw1Sk8zL1pncFJxWm1Oc0xRSkdxTWtxQTZY?=
 =?utf-8?B?a0RQdnJZdFBHMjdPVUxabWhJL25VR0VDTTRNdW9ERnlycUlyUVVQV3FGYnk3?=
 =?utf-8?B?Rk9GN0IyTjU0ZGxBdnhvczhZMjk3ck1Wb3VGcUJNOE43Y0twS01wUDVnV2NQ?=
 =?utf-8?B?MEpoUkN5cTM2YkFPZlZmazlvWHRxMGRxMGZEYU1RTWNQUU9qaXRLNm9HNndV?=
 =?utf-8?B?RkVSdTNYZHlaeGhqVnNsekp3Y042VXB5Vm1LZENWTERiYTNqem5vRm8zT3hU?=
 =?utf-8?B?cHdsRi9GYkhxOE5NY1RGQkg4QUxyNEtHTnpNbk50U3ZRY0hTYUJEa3JGMUFm?=
 =?utf-8?B?S3VGMjgwS0twMkV6bXF0U0VKSllrRXJPbDA5RzhGaHhNTnZCZ2Z2RWtYVFhW?=
 =?utf-8?B?V1pGTGs3THJoayswaDlMbnE3NmppYTJZalhIc3JobGVoUnYva1NFeDFVcG1m?=
 =?utf-8?B?b2FSWXVNL0dTQXRmMGZMV3RlR0FBTG9seGtRakJrU2FRZ0tEMG5MTFdEMy9H?=
 =?utf-8?B?RllLNlljYlYyVEJvL0hUeTlxcWszNkhobnE2UG1ibnU5dFN3My92TGh0SUdK?=
 =?utf-8?B?ak5SR29kTHJjcy9SMzlwd1QzL2pLdlJjcGROV282akNGa3RxNEMra09WM0tn?=
 =?utf-8?B?SktsLzFDVytOWUV0NXN4QWNWelRCV3lTaEJVZXRaYXRtdkZvMTJ3Wk9KdWcw?=
 =?utf-8?B?M3dqMU9uOTNkZENSblo3UE9LY2RWNU1YdTBUZ0h1amkxQzJ4bWZnZndmdTl3?=
 =?utf-8?B?N2EzY1MzaE5Fb2pOK2VPRGpFMkxhRkxFK3JyYTNuME4zaFM0enJHOWo0R091?=
 =?utf-8?B?MXk2S1ZjRjQ2Qis5QVlDZWc4WlMyWmEzWTRVTlFDeWhzbnoyNDFPVGNQVjVk?=
 =?utf-8?B?MGlzb3BMRzZqQTNEYlRzdUUwYWlhQTJ0bVFpVzVtQjZpNmVReVlmeUlYQW9y?=
 =?utf-8?B?czF4UjIvYTZkaHF0TXZuM2JzV0d5LzNkUWxVM0dNMWRWcFVjY1FuUG9kL3FH?=
 =?utf-8?B?bUlhN1ltT1FGVS9FSzdxY25HdE5ROG5uUFkyeEcrTU05TUt4ekFMMHV5N0NH?=
 =?utf-8?B?bkgrR24yMHMzQlVKc09wdzF2MHozZnpnRmw5NHRBOWZBSG1EbnNCOFpNRTVU?=
 =?utf-8?B?UjFSVUpBcWxWR2V4dkVBU3lyWit3b0kxeGN4MEYxUk5WMWRvSXdpR2JBcnFE?=
 =?utf-8?B?SjE4N3VLbE5POTllU1dBeE9DNDQ1L0hXS0ZGckV2aCtsTFVPV09OcGNoK2pr?=
 =?utf-8?B?eW9tNElPbGt1TkV2K0I5WTMyU1FuYjNwdEczam4rdzFKTkk3ZGFCcHpjZklp?=
 =?utf-8?B?THFBLzRvK25OSFZzeEhZV01pVU9Va0MxaDFSR3NuaHlYZGhrK2NGdkk5WEpj?=
 =?utf-8?B?aEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f744774-40a7-4cb1-5f7d-08dba7e8fe8b
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2023 17:05:34.9872
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vu+71i1L1bBahtz+qwWjH8Rv5BkHFO/Jxdxi00TABZypkKUdJ7f1W6BpId+P+z7QS6vGh19lxdF7z4hNeWIuHxCJDiA0btQxnB5NHCKRKq0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4750
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-6.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tony,

On 8/25/2023 10:05 AM, Tony Luck wrote:
> On Fri, Aug 11, 2023 at 10:29:25AM -0700, Reinette Chatre wrote:
>> On 7/22/2023 12:07 PM, Tony Luck wrote:

>>> Change all places where monitoring functions walk the list of
>>> domains to use the new "mondomains" list instead of the old
>>> "domains" list.
>>
>> I would not refer to it as "the old domains list" as it creates
>> impression that this is being replaced. The changelog makes
>> no mention that domains list will remain and be dedicated to
>> control domains. I think this is important to include in description
>> of this change.
> 
> I've rewritten the entire commit message incorporating your suggestions.
> V6 will be posted soon (after I get some time on an SNC SPR to check
> that it all works!)

I seem to have missed v5.

> 
>>
>>>
>>> Signed-off-by: Tony Luck <tony.luck@intel.com>
>>> ---
>>>  include/linux/resctrl.h                   |  10 +-
>>>  arch/x86/kernel/cpu/resctrl/internal.h    |   2 +-
>>>  arch/x86/kernel/cpu/resctrl/core.c        | 195 +++++++++++++++-------
>>>  arch/x86/kernel/cpu/resctrl/ctrlmondata.c |   2 +-
>>>  arch/x86/kernel/cpu/resctrl/monitor.c     |   2 +-
>>>  arch/x86/kernel/cpu/resctrl/rdtgroup.c    |  30 ++--
>>>  6 files changed, 167 insertions(+), 74 deletions(-)
>>>
>>> diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
>>> index 8334eeacfec5..1267d56f9e76 100644
>>> --- a/include/linux/resctrl.h
>>> +++ b/include/linux/resctrl.h
>>> @@ -151,9 +151,11 @@ struct resctrl_schema;
>>>   * @mon_capable:	Is monitor feature available on this machine
>>>   * @num_rmid:		Number of RMIDs available
>>>   * @cache_level:	Which cache level defines scope of this resource
>>> + * @mon_scope:		Scope of this resource if different from cache_level
>>
>> I think this addition should be deferred. As it is here it the "if different
>> from cache_level" also creates many questions (when will it be different?
>> how will it be determined that the scope is different in order to know that
>> mon_scope should be used?)
> 
> I've gone in a different direction. V6 renames "cache_level" to
> "ctrl_scope". I think this makes intent clear from step #1.
>

This change is not clear to me. Previously you changed this name
but kept using it in code specific to cache levels. It is not clear
to me how this time's rename would be different.
 
...

>>> @@ -502,61 +593,19 @@ static int arch_domain_mbm_alloc(u32 num_rmid, struct rdt_hw_domain *hw_dom)
>>>   */
>>>  static void domain_add_cpu(int cpu, struct rdt_resource *r)
>>>  {
>>> -	int id = get_cpu_cacheinfo_id(cpu, r->cache_level);
>>> -	struct list_head *add_pos = NULL;
>>> -	struct rdt_hw_domain *hw_dom;
>>> -	struct rdt_domain *d;
>>> -	int err;
>>> -
>>> -	d = rdt_find_domain(r, id, &add_pos);
>>> -	if (IS_ERR(d)) {
>>> -		pr_warn("Couldn't find cache id for CPU %d\n", cpu);
>>> -		return;
>>> -	}
>>> -
>>> -	if (d) {
>>> -		cpumask_set_cpu(cpu, &d->cpu_mask);
>>> -		if (r->cache.arch_has_per_cpu_cfg)
>>> -			rdt_domain_reconfigure_cdp(r);
>>> -		return;
>>> -	}
>>> -
>>> -	hw_dom = kzalloc_node(sizeof(*hw_dom), GFP_KERNEL, cpu_to_node(cpu));
>>> -	if (!hw_dom)
>>> -		return;
>>> -
>>> -	d = &hw_dom->d_resctrl;
>>> -	d->id = id;
>>> -	cpumask_set_cpu(cpu, &d->cpu_mask);
>>> -
>>> -	rdt_domain_reconfigure_cdp(r);
>>> -
>>> -	if (r->alloc_capable && domain_setup_ctrlval(r, d)) {
>>> -		domain_free(hw_dom);
>>> -		return;
>>> -	}
>>> -
>>> -	if (r->mon_capable && arch_domain_mbm_alloc(r->num_rmid, hw_dom)) {
>>> -		domain_free(hw_dom);
>>> -		return;
>>> -	}
>>> -
>>> -	list_add_tail(&d->list, add_pos);
>>> -
>>> -	err = resctrl_online_domain(r, d);
>>> -	if (err) {
>>> -		list_del(&d->list);
>>> -		domain_free(hw_dom);
>>> -	}
>>> +	if (r->alloc_capable)
>>> +		domain_add_cpu_ctrl(cpu, r);
>>> +	if (r->mon_capable)
>>> +		domain_add_cpu_mon(cpu, r);
>>>  }
>>
>> A resource could be both alloc and mon capable ... both
>> domain_add_cpu_ctrl() and domain_add_cpu_mon() can fail.
>> Should domain_add_cpu_mon() still be run for a CPU if
>> domain_add_cpu_ctrl() failed? 
>>
>> Looking ahead the CPU should probably also not be added
>> to the default groups mask if a failure occurred.
> 
> Existing code doesn't do anything for the case where a CPU
> can't be added to a domain (probably the only real error case
> is failure to allocate memory for the domain structure).

Is my statement about CPU being added to default group mask
incorrect? Seems like a potential issue related to domain's
CPU mask also.

Please see my earlier question. Existing code does not proceed
with monitor initialization if control initialization fails and
undoes control initialization if monitor initialization fails. 

> May be something to tackle in a future series if anyone
> thinks this is a serious problem and has suggestions on
> what to do. It seems like a catastrophic problem to not
> have some CPUs in some/all domains of some resources.
> Maybe this should disable mounting resctrl filesystem
> completely?

It is not clear to me how this is catastrophic but I
do not think resctrl should claim support for a resource
on a CPU if it was not able to complete initialization

Reinette
