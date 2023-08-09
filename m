Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 752F8776C61
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 00:41:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233288AbjHIWlf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 18:41:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233249AbjHIWlc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 18:41:32 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E296E4B
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 15:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691620891; x=1723156891;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ctuUVrw3wX6rOmxnAzFBsrX+0pu+Veeo1PJZqKaEvNs=;
  b=datUGE5dxFMJvaye2AT5BQVaEJaOeiEMCNrIxEida6wOOs7NtkAKII7S
   tfmzl6HIfIqaKxa5o4sjbvn/cX4GjpGyY6vvaSae3ojzqtRwc/+OEXInD
   gKDNujNV1T4Lw9DWPvcDWerFZhX/NlbkUnKyDjpmU2oJYgkkVKnYqAEuD
   cXTeEimZzdsAQZcXOR8f+wENYcVit6sS9GaCaBsj4zrsdSMEu2wvu+52l
   mkJYkPigJ0f6nFE02+Bu61hDs7fNVfpG5NqvVVSBglCRoOeCEOn0NWbkI
   T3eL/rca5mbUSAPgkzY54zjnjbPFmPOxUUePp2QsCIY8kmu+W7JhOpj0k
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10797"; a="356213532"
X-IronPort-AV: E=Sophos;i="6.01,160,1684825200"; 
   d="scan'208";a="356213532"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2023 15:41:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10797"; a="855702718"
X-IronPort-AV: E=Sophos;i="6.01,160,1684825200"; 
   d="scan'208";a="855702718"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga004.jf.intel.com with ESMTP; 09 Aug 2023 15:41:26 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 9 Aug 2023 15:41:26 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 9 Aug 2023 15:41:25 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 9 Aug 2023 15:41:25 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.40) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 9 Aug 2023 15:41:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TgaMAqsMQMiykayWj9AQq+OeTeEj9Seq4opgsMZfIkTL9GUJltm7JWImKz0ABPtRJPwQ57H7kUM06stIaQfRan1vROsIaSwBaBLvAGfJJFxsoj40YUPiJaTJzFlhEkaCmIGOS1QS803ASEXxb4PKafDdhSM3DqWV4ZZbPTWuRUlC+XUuNhpuEXqa5rPBPugbhMI/ZPCnws/meefcVp7aafoEOOPvHE7m03Mdhwzwx8MwYAwCVj08mMxPSvNe1iTZz8E+bWuyDQjsGAoJgGA9Gc6hIzZJBZaV6kkrAYOyjKEBrw+BKfHRDlQclCEoMKA69Mbt0cNYiD1bVszQ9BjpTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O5m7xKZkVj9oEKkiFimj5+e7wb0lsAQst9NO/6Fv/J8=;
 b=fVrDrOEYpv+HUFUOa+5j0ZZvJQ2Jxro/a22AA76DGijLsYqcjxPPN0bBUJFZWQr0dYeeUZBK3K9zpRNPHFIIP+kx7wVvJb4KG9n7XKLVWi2UkddVhbG1/WW1bAClht73+J/wKlpLv6yfWLtmVJTj4smIbhApVEM9TNGvSWoNhgMncB9v+O/CAPoEPj1qfDdGdlfdGMr+ewnIyOBSgJQtCmpTnuzkcJDl/UQuqS8A7oa1gTVtmbmbjkaOnEgPhA1iglCBcaOya8Dr8oZintXWPNJ5dKkC5dB3RG5UanOBP6qn4BgZmWuX4z2sp+Op9wsSwtZCD8vW2yT0ot4Dh1WzOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by PH7PR11MB7549.namprd11.prod.outlook.com (2603:10b6:510:27b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.25; Wed, 9 Aug
 2023 22:41:05 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::47e:3e1f:bef4:20e0]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::47e:3e1f:bef4:20e0%3]) with mapi id 15.20.6652.028; Wed, 9 Aug 2023
 22:41:05 +0000
Message-ID: <4085f4f3-7a3e-8af8-1ae3-1040ca78f59f@intel.com>
Date:   Wed, 9 Aug 2023 15:41:01 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.14.0
Subject: Re: [PATCH v5 24/24] x86/resctrl: Separate arch and fs resctrl locks
Content-Language: en-US
To:     James Morse <james.morse@arm.com>, <x86@kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Babu Moger <Babu.Moger@amd.com>,
        <shameerali.kolothum.thodi@huawei.com>,
        D Scott Phillips OS <scott@os.amperecomputing.com>,
        <carl@os.amperecomputing.com>, <lcherian@marvell.com>,
        <bobo.shaobowang@huawei.com>, <tan.shaopeng@fujitsu.com>,
        <xingxin.hx@openanolis.org>, <baolin.wang@linux.alibaba.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Xin Hao <xhao@linux.alibaba.com>, <peternewman@google.com>,
        <dfustini@baylibre.com>
References: <20230728164254.27562-1-james.morse@arm.com>
 <20230728164254.27562-25-james.morse@arm.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20230728164254.27562-25-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0316.namprd03.prod.outlook.com
 (2603:10b6:303:dd::21) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|PH7PR11MB7549:EE_
X-MS-Office365-Filtering-Correlation-Id: a6e47375-2fcc-4880-24af-08db9929b76f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Tm8GGyvaGkNKmoqFu+5ccOULn4wBIyWr1Dj0gSm5uxn18JquZTbrlww1MO9GOLNWm0MGjr1yL0dC1TsbaDVC8P/TR3q8qZB1SImiY2JfCNenG1cJB0RE3/K5VGZgv66/xAU2M5AHu5A8WrpX+xXi8REAs7QZ/XcvRZpVkaFgKSSbKEbm6ANvC9qS84Dahv77Q+ug2KPfLCqGgmAlQcEypNutBHo0AtPnHmBiAhxXc6n7AN5e5KP6QP1hlGU03GYxi2fRiDfXhzfMEpECw6dJRLxtWvVlsJTG2smPkaIVUvg5T+Nk9tLeSIxoV2nM/upivYucN4xnlr7aBKSgyPsygw1xXkMxdkLAB7kCKBjwFCITqnY3hJ/3Uo7asyxZzzgltUMhRLeoz6203KSqJY9Mo7VRHmPsQiERip03f8XyznKuxciYTFzb5ukyJSqAekI1lWYgMMnBsvza27bp9TrW03ImCWoQKERSKoDRe9bFLPq9eWzvJqOMTgI99oarUZ8lgbkw17m4+6qEu3MSAPyNTTUCG30CgFUDXmzZrI/t7Fdf/QsZc+Gb2qO0E57L/0YI1q3cbpTvwuBjY/SXV6OMQHaR4I6tHLdS1w0rLUHB+kZ7G0RmfgB/cuMNflMfMDLSCKdPsAdNKr69/yMGn/Tk+w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(396003)(39860400002)(366004)(346002)(376002)(451199021)(186006)(1800799006)(2616005)(53546011)(6506007)(36756003)(6512007)(4326008)(316002)(82960400001)(86362001)(478600001)(38100700002)(66946007)(54906003)(31696002)(66476007)(6666004)(66556008)(6486002)(26005)(66899021)(8936002)(41300700001)(8676002)(2906002)(7416002)(44832011)(83380400001)(31686004)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UnU3R1ZvK1oycGZxQmFHc2xQZXRjUCtTbjVBN003UUtQVllQQUZVNTZYZU1C?=
 =?utf-8?B?S2lIWWVUMEE3R0tod0Rtd1RoMExQbHNlZFpHT0NVaUVLWXM2eGNMZTZFTUl6?=
 =?utf-8?B?bERwQ01pOStBbFE1WE5OVDgrcDZ1cXVjUTQ2RDBNdEtGQ0NOQ1g5L0VxVWk1?=
 =?utf-8?B?MUF6RTRBSVNQUjlmYjNlSWhDVFRSSVFMMWduT0cxUUhHZTNtNlQ4U1dXME12?=
 =?utf-8?B?SXdhQ3AwTU9QWEJjTDJHenN3WTM3SWJCaWJkSHUvcEdDenJmVDNMb25DR05x?=
 =?utf-8?B?aWxJZytGOCtqQngzT0RBcjVUbGk4T2RhdHJWMmFNTUNLOXd1MFNLNDdJUmFK?=
 =?utf-8?B?clh3M1RMUWxrVUFWRkJPYWZkdG1OVWV0L2tUUXJvZk53YWVQamFLdGhDRkRU?=
 =?utf-8?B?TDRPWjN4eGcrZjNKdkYzdHlYRjNDTUNJbXhhNmh3ZWJmZTlFMFVMbVhNUGdQ?=
 =?utf-8?B?cmxPZFA4VS96K2ZPaXdLV0x5T1dKRFZCdEhrWHd6SnpnaDJsT0wyKzFLMzFz?=
 =?utf-8?B?YVYwdGxxbnRZejgwSkMzNXRiZnZ0OUFTVUhaNGE5b3VqZGlCdGtPSWFwM1JY?=
 =?utf-8?B?VXdhOVFSQzVBWnpDSWw1azFzbE84cXdycjRjd0RncjZNMHdoaG1NSENiM1pS?=
 =?utf-8?B?VWRSV2RCbiszbHZsZTdsc3FCclhCNnd1WlVrTjVSejNnSmFiV0dYU084M1R0?=
 =?utf-8?B?WGdIL2lIeUUwZHY1TjgrS2Q1NnBEalJoekUxcm0xQlU3ZzQ5dGg0bzQ4ZTEx?=
 =?utf-8?B?aEVkODF6WURKYmlvbDlDemhKUFVEMmFMNXhoczM3ejhOQnJ2MkE0ZTFRREd1?=
 =?utf-8?B?R0EyQTArc1daa29hZnM0aC9Obkw5bUsrOThsRjJENlc1bWtHWG02OE1JbWtL?=
 =?utf-8?B?bUFaSUdXbVNmRnhPT0o3NGZWamdDNzhHT2h2dTlrOWwzcDJsQkxQZmJBTkt0?=
 =?utf-8?B?d01wRHJER1VzWlN2YW9PYTRKbmRnRTJCVXJEQVZiWjBBSTRuenJKWDhIUmJo?=
 =?utf-8?B?c3FNdUgrRjdtTkg5QWJ5UlhmUENSOWxHOXU1dWcvcjNKYXpJZVNVU1RiV0Rz?=
 =?utf-8?B?cXgvWGcyTjVRWUROV1orY1ZxQmQ3R25DNXY3SEkyMkFnRVcyY0cxOWhFaGsy?=
 =?utf-8?B?VmY5aTBFYjlWSjNid25LR1hrTUtZZ0xycHhpN2h4TmVNaGVYSUd2K1dCc0lN?=
 =?utf-8?B?WmgxS2c1SGdyYmJBN1Y4QllSdGFzM2hBcHdsL1RYeXdoUytUTllkMVNkZ2J2?=
 =?utf-8?B?czZaQjRkNzQzbFBQTFM5WHArelNGVDVZOHpKMlVZOTVBN2FrWmozbC8zb0F5?=
 =?utf-8?B?ZHFUUXVFOVh2N2c4U2piL3hJVnhxbm80QzV1TnpFWkdHNmZIMXF1Wm10cmRP?=
 =?utf-8?B?SUg5UUpwb3VYWjAxZWZGNThWeVYxZ0tNemlMZDJ4K3JQUUJqTjhtVUVrUVI3?=
 =?utf-8?B?cTJ6ZmdBQ0RkRWdZWUliNnJHOEtydFBuaUpaNDRYdy95RUcyaVk4UGFrK242?=
 =?utf-8?B?Nk1IOHd1NktOcnR6RDdhcUZLNGRuZ2pwTUo0cW81d2p1ZlR5S0JYOEw2akRu?=
 =?utf-8?B?bkJvaUkvcHh3UWRHcEZia3EvdmxheHpRTjczYTdkZVJSSzVIcHJTOGdPRTFm?=
 =?utf-8?B?TTloTUdVai9jWDdUU0lVZEZYTFp3QUNrSkw0eW14Unl4UXJnbDZwbkJ2MjZj?=
 =?utf-8?B?ZUVnTDAwRnc1OHpQSHIreWpTZ0NTSFlsWWY4UTRRdS9tV0ZVb2hwSnAwSmdT?=
 =?utf-8?B?dEQvL0N6NlIwNlBJQ1RML1M5R3BGMGFZUTdvdmVUeUFRb2hNaE14c3BRUE1K?=
 =?utf-8?B?c3p2cHdMdTNOWnR0bDl3ak9xN3pCeEpuOUZOWTVzQloyUkdJazRpdi9KQ2o1?=
 =?utf-8?B?UFByTXc1MEFjRE9mTW5VcTk3dFRZWGo2V3JpY3RhdUdKdlVKTjJISWF2WmdF?=
 =?utf-8?B?eCtTQ1V1N2RWdG5ya2JvcUFpRENSVmNMS3I1bVZWU2lpbDZPWVF1RzFUZ3la?=
 =?utf-8?B?Q09jeVJ3K05zcVBjYTRUQmRMVlZGK0RlaGVqQy9saE1EcUtGbjF0Q3k1WVE0?=
 =?utf-8?B?blRna1lEWDNTNWgzclJKS1NSay9IN3Bqa3JJcDdCb3V0enBEM3NIM3FRQlRM?=
 =?utf-8?B?Vm5tOG1vU3o0QlQ5NEhpUmxabU4rS3RFWU9EcExzaU4yY1hWMFpqSXorY0hv?=
 =?utf-8?B?K2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a6e47375-2fcc-4880-24af-08db9929b76f
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2023 22:41:05.5022
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UMnz8pDrH0B1U2OyZkXbc20ALuFL/w/kkyMDUUxMU2dSNe+fv23seIc+M5TEaRbwLEKqC2MLngYHbiGQaoLCC94XJhyojrfh13Ng3p1n88Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7549
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 7/28/2023 9:42 AM, James Morse wrote:
> resctrl has one mutex that is taken by the architecture specific code,
> and the filesystem parts. The two interact via cpuhp, where the
> architecture code updates the domain list. Filesystem handlers that
> walk the domains list should not run concurrently with the cpuhp
> callback modifying the list.
> 
> Exposing a lock from the filesystem code means the interface is not
> cleanly defined, and creates the possibility of cross-architecture
> lock ordering headaches. The interaction only exists so that certain
> filesystem paths are serialised against cpu hotplug. The cpu hotplug

cpu hotplug -> CPU hotplug

> code already has a mechanism to do this using cpus_read_lock().
> 
> MPAM's monitors have an overflow interrupt, so it needs to be possible
> to walk the domains list in irq context. RCU is ideal for this,
> but some paths need to be able to sleep to allocate memory.
> 
> Because resctrl_{on,off}line_cpu() take the rdtgroup_mutex as part
> of a cpuhp callback, cpus_read_lock() must always be taken first.
> rdtgroup_schemata_write() already does this.
> 
> Most of the filesystem code's domain list walkers are currently
> protected by the rdtgroup_mutex taken in rdtgroup_kn_lock_live().
> The exceptions are rdt_bit_usage_show() and the mon_config helpers
> which take the lock directly.
> 
> Make the domain list protected by RCU. An architecture-specific
> lock prevents concurrent writers. rdt_bit_usage_show() can
> walk the domain list under rcu_read_lock(). The mon_config helpers
> send multiple IPIs, take the cpus_read_lock() in these cases.
> 
> The other filesystem list walkers need to be able to sleep.
> Add cpus_read_lock() to rdtgroup_kn_lock_live() so that the
> cpuhp callbacks can't be invoked when file system operations are
> occurring.
> 
> Add lockdep_assert_cpus_held() in the cases where the
> rdtgroup_kn_lock_live() call isn't obvious.
> 
> Resctrl's domain online/offline calls now need to take the
> rdtgroup_mutex themselves.
> 
> Tested-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
> Signed-off-by: James Morse <james.morse@arm.com>

...

> @@ -464,6 +467,9 @@ static void show_doms(struct seq_file *s, struct resctrl_schema *schema, int clo
>  	bool sep = false;
>  	u32 ctrl_val;
>  
> +	/* Walking r->domains, ensure it can't race with cpuhp */
> +	lockdep_assert_cpus_held();
> +
>  	seq_printf(s, "%*s:", max_name_width, schema->name);
>  	list_for_each_entry(dom, &r->domains, list) {
>  		if (sep)
> @@ -534,8 +540,8 @@ void mon_event_read(struct rmid_read *rr, struct rdt_resource *r,
>  {
>  	int cpu;
>  
> -	/* When picking a CPU from cpu_mask, ensure it can't race with cpuhp */
> -	lockdep_assert_held(&rdtgroup_mutex);
> +	/* When picking a cpu from cpu_mask, ensure it can't race with cpuhp */

cpu -> CPU

> +	lockdep_assert_cpus_held();
>  
>  	/*
>  	 * Setup the parameters to pass to mon_event_count() to read the data.

...

> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index a256a96df487..47dcf2cb76ca 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -35,6 +35,10 @@
>  DEFINE_STATIC_KEY_FALSE(rdt_enable_key);
>  DEFINE_STATIC_KEY_FALSE(rdt_mon_enable_key);
>  DEFINE_STATIC_KEY_FALSE(rdt_alloc_enable_key);
> +
> +/* Mutex to protect rdtgroup access. */
> +DEFINE_MUTEX(rdtgroup_mutex);
> +
>  static struct kernfs_root *rdt_root;
>  struct rdtgroup rdtgroup_default;
>  LIST_HEAD(rdt_all_groups);
> @@ -954,7 +958,8 @@ static int rdt_bit_usage_show(struct kernfs_open_file *of,
>  
>  	mutex_lock(&rdtgroup_mutex);
>  	hw_shareable = r->cache.shareable_bits;
> -	list_for_each_entry(dom, &r->domains, list) {
> +	rcu_read_lock();
> +	list_for_each_entry_rcu(dom, &r->domains, list) {
>  		if (sep)
>  			seq_putc(seq, ';');
>  		sw_shareable = 0;

Does rdt_bit_usage_show() really need RCU? It is another filesystem callback and I
do not see a reason why it should access the domain list in a different way. It
can follow the same pattern as all the other resctrl filesystem ops and use
cpus_read_lock().

> @@ -1010,8 +1015,10 @@ static int rdt_bit_usage_show(struct kernfs_open_file *of,
>  		}
>  		sep = true;
>  	}
> +	rcu_read_unlock();
>  	seq_putc(seq, '\n');
>  	mutex_unlock(&rdtgroup_mutex);
> +

Unnecessary empty line.


>  	return 0;
>  }


Reinette
