Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B28D7DC1DC
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 22:23:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbjJ3VXO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 17:23:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbjJ3VXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 17:23:12 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71A32ED;
        Mon, 30 Oct 2023 14:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698700989; x=1730236989;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=70Ad2yyFqFf/oO5RLeGtsd8Lo6cTpvGQ7DgGwf/zDFo=;
  b=DKyut1kJpmdIJLmZZmHW332EkH0csXXeMUvLHHBcGT8DRLCCjU+DrU3q
   F46vV1cP2+vp+MOb2kRdWOUiS/Hz72ixwpqbrwfaN2ECjzxHNVwHoVpeh
   0IJBprd7hKm1lYN5W4QztfsxhN4js/kJL/QxvMljh9iyYiNQCQgsOn3OB
   xjxLoIdVcD6cPstxRs5n7iUF5ZgNtvfTj274dJe25oChTj1OmJRATDaoI
   Kz7ipxKHUoBZKvyrkz3O0ZL18N/ZPjKK7tuTIcCsK2QvGd0W7Lql6KU+T
   ++uXkIZ7+U/dI2YrTL/JoNlgSzol5PrMPrGCMiGC5Bxfh/ycf67edxvnZ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10879"; a="378552753"
X-IronPort-AV: E=Sophos;i="6.03,264,1694761200"; 
   d="scan'208";a="378552753"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2023 14:23:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,264,1694761200"; 
   d="scan'208";a="8492101"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Oct 2023 14:23:08 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 30 Oct 2023 14:23:07 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 30 Oct 2023 14:23:06 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 30 Oct 2023 14:23:06 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 30 Oct 2023 14:23:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=drByU6mmCugzoBwvgo21KTy2c1vraNEcMJuJAdXB5IW9XBL1GprX95my+N0t9FGsN7ZJLXzpsVgadd9QHuJbPKHZI+S8g7zcCCO0YyEumABBmj8hBXzgkRxNUc9VrCgGY8TO1XAa0+G4VH8YyUq7sRbQbuWsKsygBQORIF1llLJnUG2rwLpZKUEMNFRlOUTrXP8gqfKpSXc4KexbqemLT0tIqpJNYIwSoXjxweVEoyOXZjLZHZr1l/xXjH+IhQXeqZltoQwRmZRq7Fg4B4rU/MpOAzfANsnMTsFieBQ0ka9SS/Y/wWsPEgBXdNTWSUkWjWsdSPWecMUP5kvwUhDZaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mM5wefn1npuT6h/hVhBvgB7HbMBgOistZC4XXBBuEBQ=;
 b=ETn3YC516U5THCJT78gOi25kMkNm1V512PDv6aJTN8+7Up+NTWQXxn+Br7Pzl/VDl3PpHV6YRYv0XDDybRAvCoB4+4eNSoAKmuzw4/dv69wXGyGwAuVtM/RorpwrzZJHrqn7zalvDItKAm63alNvKmtz3jU3eepD/paxWfXfA+8abooiHgqDnMoMfafv6FJ7xB6ytY8P+ZxoiImJZ5CgL0TodTtLpRDsDX22rfQiCirDVk/64BrOpE+wCFDpH8ie9FgIpncW+x1EgcGTf+JUHH1inPg+gS0G7eufg2L924nWvlUzemgnheEQmXbAZT9WMwOqoe3atrM9CB6ahzBb5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by CY8PR11MB7921.namprd11.prod.outlook.com (2603:10b6:930:7d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.28; Mon, 30 Oct
 2023 21:23:04 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5%5]) with mapi id 15.20.6933.028; Mon, 30 Oct 2023
 21:23:04 +0000
Message-ID: <2d736f74-c692-4e06-8e61-8a068e333db8@intel.com>
Date:   Mon, 30 Oct 2023 14:23:03 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 7/8] x86/resctrl: Sub NUMA Cluster detection and enable
Content-Language: en-US
To:     Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        "Peter Newman" <peternewman@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "Shuah Khan" <skhan@linuxfoundation.org>, <x86@kernel.org>
CC:     Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        James Morse <james.morse@arm.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Babu Moger <babu.moger@amd.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <patches@lists.linux.dev>
References: <20231003213043.13565-1-tony.luck@intel.com>
 <20231020213100.123598-1-tony.luck@intel.com>
 <20231020213100.123598-8-tony.luck@intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20231020213100.123598-8-tony.luck@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0277.namprd04.prod.outlook.com
 (2603:10b6:303:89::12) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|CY8PR11MB7921:EE_
X-MS-Office365-Filtering-Correlation-Id: a195bc8e-4230-4e6d-b77c-08dbd98e6773
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gEIjn/AQONVrpB2YNdg9PB70JCf5ffuCgC1FA6nNRGJJ5sBNLDWV7cnVymkvH6glxX82UHOBGora0wUUML0sD4Nv8Ficqyiti8UrFnshd40iqGKysvO7k3OoCySt/NXsWNLopQqXa72XSRKa91y/vfoZ5OZyJ+Fi25XnGuNXSovJ4wzM6YzYfkHiWIxlyOMqT8tvsqyioZgBtFCTYPeZFNKrakZUNtyGS0mOzpSqkBB4xkbbabHgxGZOCv6xG7if2FK3AooaiDuw655+io4U2pD6sKTWYVapjNsYmoZwvJcCnaspSrYXFkIpMGgS74qNUluwStLzR7/QYMSAnlEJEPPvn2Arl2+V3olWPefAH1jhEhlpGMUyQE1LM7g9wbqPhudrKa1dOX/fg8FUHH7DpSl6XVWHbuXGA00EebsoVAK7oa+B0OSGAHOzkdb/+MsC6gYDmfMYFOrpE6yisgOz0BGjyHdHbKJ1UbEkqz3EOCXQoBgA7uvf9yBKrRw59VpQvUuzToWe3scjihmv8D7nv+6fr+v6M0g6BkzZh67kMx6HKICt4SnG8bwqWqbZ10yq3L88EEprbV8s5gJJlbjAVhYj5W91VhHiA4+pULVOQl6AhpZen5cwYGjo5p3FNOrtHmyJ/ZMArSWAfUgQ9l+e2Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(346002)(136003)(39860400002)(396003)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(31686004)(26005)(6512007)(38100700002)(31696002)(86362001)(36756003)(82960400001)(7416002)(83380400001)(2906002)(478600001)(6506007)(53546011)(8936002)(8676002)(66476007)(6486002)(54906003)(316002)(5660300002)(4326008)(41300700001)(44832011)(110136005)(66946007)(2616005)(66556008)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RGhGbFc2cnZUeTFkU0QwRTQ2SVkvdHJqNWVWSFdmdml4TXNpR0htdWlvRWpp?=
 =?utf-8?B?TFhMcVMyZFNnLzZlQk1zVE03M0hiUzg3RytPaVVxOGs0a1RkRGo1aU13eTdw?=
 =?utf-8?B?SU5tVExTbDNhdTFjRG9KSzl3WWZNS3k0enBweUtEMGNsL0l6U1FlK2JEWXRI?=
 =?utf-8?B?RDIzYjJzYkZ0RlgycWNEaUlJZ25PSDkySUxoYUxneGh2SU0wNkR4Nm1CUmt1?=
 =?utf-8?B?NldXd0g0RWhyL0w3bkk5TUZ6RzRTZWVIUGlFRnRxS2gvS0tMQk9xYzFTeENW?=
 =?utf-8?B?R3BvTm5RVzYyMFRobHYrRm9oZ0F1aW1CdnNGV3N3NkxmSjkzQWdxck92VUxU?=
 =?utf-8?B?NTU5L1I4UE5LSXVuejhGL3EwRU5xQSszWGlVTW1hTHFVM0RTbVdHbThqczZq?=
 =?utf-8?B?OE1pQXNScmRIUkpTdlpxaVYyZk9qekNGT2s5S0QwVmh6MG9DQnJtVW80UXVB?=
 =?utf-8?B?SmxOWXdGSVVnOWNQemQwWFZ1NGxiRU9kVWxjazlya2crZmRGZlphQlBHZm10?=
 =?utf-8?B?bzV2OFUzTGJnc2ZkU2RPMXlGbEVUZ2JlMWJDZ0NzcUIyOGQzSEtKTlJ3RytI?=
 =?utf-8?B?MXE1MXFRenFxZU13NlpkS2wwM1JXN2ZGZUo3Tzh6SmF2SWdKVHVvZjdRall0?=
 =?utf-8?B?U3A0dzRDMzZ4ZTA2ZE9Xa0NkTGsxT0dzQjFyaVFDZlhTZmxPaHBKaWUyRmI1?=
 =?utf-8?B?ckRMT3dNRm1oTW9IYjVpZjcvaFpTQ0FlRDdkRnNzM3BXM1BXanBhRitjT0dx?=
 =?utf-8?B?bUI4TForeitmcVM3Njc5azhFeS82ZitIYzR1VGxqKzBLTGM4Q2FnTUIxY0Zn?=
 =?utf-8?B?YU16WVl1WjhyUUhmOUJyUTdMUDZFcjBLTG5NR1B3OXFST3JMQzNmK0JDRlhW?=
 =?utf-8?B?cDVaMEV2NzhQWXJjcHhJZXlsTzc0UCtoNEJxMDhBS1B0S0VTYndJTXhLblVT?=
 =?utf-8?B?TmMvWHh3T0w5TWdvZTVPN3JWZ093K0Y3bHdTaWwyb2QxNGtiVVNRRGQyc1pt?=
 =?utf-8?B?T1ZBYTZiVjNKbDdzMFJTSVBsWGVRVG9qb3ZXYXpMcjRTMnFUeXk4b08rWTJk?=
 =?utf-8?B?bUhjWFYvdCswR2ZSK0FKM01TWUZGZTAwQlNhZ2lPLzdHQm1vekZTbmkxZlg3?=
 =?utf-8?B?WXV4SUZmdmxjQmFIYmpNaFhqUHVUSGhTbmtHeW9UcCswVEkxYkFkRWE3RXlr?=
 =?utf-8?B?YXpSSVNkeVVITjRWaFJ4KzEwSzlSRWZDdzU0L0ErekhvbUVvM1pPSVlmRUxw?=
 =?utf-8?B?bmpza2lMd09jclVuS0lGT0E3YVRYS050UlFLM0ExeXdxQ0VJYXJ0WkVLL3h3?=
 =?utf-8?B?ZnFjNlBSTnNWTHpMQ2owc3N3NkhQMC9DK095Y0JEZ1BnQk04VFd5bTlsOTZy?=
 =?utf-8?B?RnVHR0JpMzFrVUFUalU3MElqOU5YdXZUZGFsTURGSTBDMWdzcGhtdzFKMXRP?=
 =?utf-8?B?eEpoZzAyaGN0UmFObjkyVlNSOGkrWTNkMmFEWVIrOVJLTXFUT3MyWi9kYWdx?=
 =?utf-8?B?dWpHZlRuelMrV1dhaTNmZE9kRlZnNG9wRnR5SUFMR1haL1BhbjFDZ2ZUVEpu?=
 =?utf-8?B?RnVYQWNUa0xvdFM1NFA5YktWeFE2UzBBSkVYWjhFMzdCanhCc2VJUFUvUjhY?=
 =?utf-8?B?Q1NmTDY4RlljYTgrYjd0T2JQYWdqUFlkMnUySkRhdEx5NHZiYzVZY0RocWVE?=
 =?utf-8?B?SWJMaE52QmpFU1dOSjcvUWR2dStFZVdzbGhjS2dvZTNRN2o1ZWZoZG5QZGQx?=
 =?utf-8?B?dWZCYXZOWmU1WnlGNzdDZU0xU1BRTkZYRE41WXBzVGl3dlRYY1BKSnNOM0Yr?=
 =?utf-8?B?K3E0NE15VFJqdjJCZEw2c25HWDkrVCtmYzZBQUNKN3VXc0JCcUhzTThwQm5y?=
 =?utf-8?B?ajlwelpPMW4rOTFXekVkczdTcFJMWU95a0tRNHZBVHBrQk5BRHRpZENFRjNQ?=
 =?utf-8?B?VlBYa3ZTR25sQzB1N0NVN3J6OTdxY2k0T0RyK2N2cGhTRjRnSHNHMjlxL3A1?=
 =?utf-8?B?LzJaeVZpTWptdXFPQU95aG94eWV5VVprZnAreGpqbHJwMkUvUGw3aDZZN2xS?=
 =?utf-8?B?L0xqbHJrdGRQaWxrWURaaUh6d2hwaExvNEh2cFJvOVBjSVNoQmhOWE1BOUZm?=
 =?utf-8?B?K3BYRzIwUlZ3cnRvb1JJdklpVkY5ZHdhQzBVYmhaQkhIRk5iWDk3ckVINm5H?=
 =?utf-8?B?S0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a195bc8e-4230-4e6d-b77c-08dbd98e6773
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2023 21:23:04.8438
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0+Km+dc+c3o1ipc3K5WV8ODEIRAR5TkZ32HU9N0ZE2GS2v/i3xYP9vNO5/VR5D/1QkmNpA5/l2DuT8o9w8ry7FOXFjbjTnKzM3yi7B52/0M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7921
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tony,

On 10/20/2023 2:30 PM, Tony Luck wrote:
> There isn't a simple h/w bit that indicates whether a CPU is

"h/w" -> hardware

> running in Sub NUMA Cluster (SNC) mode. Infer the state by comparing
> the ratio of NUMA nodes to L3 cache instances.
> 
> When SNC mode is detected, reconfigure the RMID counters by updating
> the MSR_RMID_SNC_CONFIG MSR on each socket as CPUs are seen.
> 
> Clearing bit zero of the MSR divides the RMIDs and renumbers the ones
> on the second SNC node to start from zero. An earlier commit includes

Please drop the "earlier commit" reference.

> all the required changes in Linux to operate in this reconfigured mode.
> 
> Reviewed-by: Peter Newman <peternewman@google.com>
> Signed-off-by: Tony Luck <tony.luck@intel.com>
> ---
> Changes since v6:
> 
> Moved kfree(node_caches); earlier, to the earliest point where it
> is no longer needed.
> 
> Added Granite Rapids to list of CPU models that support SNC mode.
> 
> Added Peter's review tag
> 
>  arch/x86/include/asm/msr-index.h   |  1 +
>  arch/x86/kernel/cpu/resctrl/core.c | 92 ++++++++++++++++++++++++++++++
>  2 files changed, 93 insertions(+)
> 
> diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
> index e3fa9cecd599..4285a5ee81fe 100644
> --- a/arch/x86/include/asm/msr-index.h
> +++ b/arch/x86/include/asm/msr-index.h
> @@ -1109,6 +1109,7 @@
>  #define MSR_IA32_QM_CTR			0xc8e
>  #define MSR_IA32_PQR_ASSOC		0xc8f
>  #define MSR_IA32_L3_CBM_BASE		0xc90
> +#define MSR_RMID_SNC_CONFIG		0xca0
>  #define MSR_IA32_L2_CBM_BASE		0xd10
>  #define MSR_IA32_MBA_THRTL_BASE		0xd50
>  
> diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
> index 0e418dd14070..ac187eb0440f 100644
> --- a/arch/x86/kernel/cpu/resctrl/core.c
> +++ b/arch/x86/kernel/cpu/resctrl/core.c
> @@ -16,11 +16,14 @@
>  
>  #define pr_fmt(fmt)	"resctrl: " fmt
>  
> +#include <linux/cpu.h>
>  #include <linux/slab.h>
>  #include <linux/err.h>
>  #include <linux/cacheinfo.h>
>  #include <linux/cpuhotplug.h>
> +#include <linux/mod_devicetable.h>
>  
> +#include <asm/cpu_device_id.h>
>  #include <asm/intel-family.h>
>  #include <asm/resctrl.h>
>  #include "internal.h"
> @@ -755,11 +758,42 @@ static void clear_closid_rmid(int cpu)
>  	wrmsr(MSR_IA32_PQR_ASSOC, 0, 0);
>  }
>  
> +/*
> + * The power-on reset value of MSR_RMID_SNC_CONFIG is 0x1
> + * which indicates that RMIDs are configured in legacy mode.
> + * This mode is incompatible with Linux resctrl semantics
> + * as RMIDs are partitioned between SNC nodes, which requires
> + * a user to know which RMID is allocated to a task.
> + * Clearing bit 0 reconfigures the RMID counters for use
> + * in Sub NUMA Cluster mode. This mode is better for Linux.
> + * The RMID space is divided between all SNC nodes with the
> + * RMIDs renumbered to start from zero in each node when
> + * couning operations from tasks. Code to read the counters
> + * must adjust RMID counnter numbers based on SNC node. See

counnter -> counter

> + * __rmid_read() for code that does this.
> + */
> +static void snc_remap_rmids(int cpu)
> +{
> +	u64 val;
> +
> +	/* Only need to enable once per package. */
> +	if (cpumask_first(topology_core_cpumask(cpu)) != cpu)
> +		return;
> +
> +	rdmsrl(MSR_RMID_SNC_CONFIG, val);
> +	val &= ~BIT_ULL(0);
> +	wrmsrl(MSR_RMID_SNC_CONFIG, val);
> +}
> +
>  static int resctrl_online_cpu(unsigned int cpu)
>  {
>  	struct rdt_resource *r;
>  
>  	mutex_lock(&rdtgroup_mutex);
> +
> +	if (snc_nodes_per_l3_cache > 1)
> +		snc_remap_rmids(cpu);
> +
>  	for_each_capable_rdt_resource(r)
>  		domain_add_cpu(cpu, r);
>  	/* The cpu is set in default rdtgroup after online. */
> @@ -1014,11 +1048,69 @@ static __init bool get_rdt_resources(void)
>  	return (rdt_mon_capable || rdt_alloc_capable);
>  }
>  
> +/* CPU models that support MSR_RMID_SNC_CONFIG */
> +static const struct x86_cpu_id snc_cpu_ids[] __initconst = {
> +	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_X, 0),
> +	X86_MATCH_INTEL_FAM6_MODEL(SAPPHIRERAPIDS_X, 0),
> +	X86_MATCH_INTEL_FAM6_MODEL(EMERALDRAPIDS_X, 0),
> +	X86_MATCH_INTEL_FAM6_MODEL(GRANITERAPIDS_X, 0),
> +	{}
> +};
> +
> +/*
> + * There isn't a simple h/w bit that indicates whether a CPU is running

h/w -> hardware

> + * in Sub NUMA Cluster (SNC) mode. Infer the state by comparing the
> + * ratio of NUMA nodes to L3 cache instances.
> + * It is not possible to accurately determine SNC state if the system is
> + * booted with a maxcpus=N parameter. That distorts the ratio of SNC nodes

Can the user be warned when SNC state cannot be determined accurately? 

> + * to L3 caches. It will be OK if system is booted with hyperthreading
> + * disabled (since this doesn't affect the ratio).
> + */
> +static __init int snc_get_config(void)
> +{
> +	unsigned long *node_caches;
> +	int mem_only_nodes = 0;
> +	int cpu, node, ret;
> +	int num_l3_caches;
> +
> +	if (!x86_match_cpu(snc_cpu_ids))
> +		return 1;
> +
> +	node_caches = bitmap_zalloc(nr_node_ids, GFP_KERNEL);
> +	if (!node_caches)
> +		return 1;
> +
> +	cpus_read_lock();
> +	for_each_node(node) {
> +		cpu = cpumask_first(cpumask_of_node(node));
> +		if (cpu < nr_cpu_ids)
> +			set_bit(get_cpu_cacheinfo_id(cpu, 3), node_caches);
> +		else
> +			mem_only_nodes++;
> +	}
> +	cpus_read_unlock();
> +
> +	num_l3_caches = bitmap_weight(node_caches, nr_node_ids);
> +	kfree(node_caches);
> +
> +	if (!num_l3_caches)
> +		return 1;
> +
> +	ret = (nr_node_ids - mem_only_nodes) / num_l3_caches;
> +
> +	if (ret > 1)
> +		rdt_resources_all[RDT_RESOURCE_L3].r_resctrl.mon_scope = RESCTRL_NODE;
> +
> +	return ret;
> +}
> +
>  static __init void rdt_init_res_defs_intel(void)
>  {
>  	struct rdt_hw_resource *hw_res;
>  	struct rdt_resource *r;
>  
> +	snc_nodes_per_l3_cache = snc_get_config();
> +
>  	for_each_rdt_resource(r) {
>  		hw_res = resctrl_to_arch_res(r);
>  

Reinette
