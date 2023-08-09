Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62AEE776C54
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 00:38:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233106AbjHIWiW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 18:38:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232937AbjHIWiM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 18:38:12 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 473E6E45
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 15:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691620691; x=1723156691;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=zOU5TeC08n7i8Zqz3JK//J4Qg95VfhaxzprDBPhLjLQ=;
  b=dQZTRxd/zZihWloWc1v90x44HDUxaYXynU2pdxwuS9uADPbDI95ifIZk
   OtAjRQkFluOv8sFPpcspnz3eb/llmetQsUo1PhVjYr7+cmGVc/2lSUF8i
   jflm4BzMOqXxZhg4y2DvRcYRn5FWpBezfXyzvAgnss09zdmU5LqlNo3KC
   6X8sWdhmeYZ6Aqs11b+YFWh2kbpcqPy7a61CUSoq2pt/S/rTN/SiY9sgB
   PzTOrB4AF/LVT+ceqSVZiZL+i+EXl3Mcza86rF11M+mKkjmh6wSiqpPVn
   5ybRdbTMdh0V0KA7crqj7ZgA+yVrMjCflbV9gdL/Mvxv/ykE5yfvNWLr+
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10797"; a="374961851"
X-IronPort-AV: E=Sophos;i="6.01,160,1684825200"; 
   d="scan'208";a="374961851"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2023 15:38:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="875461828"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga001.fm.intel.com with ESMTP; 09 Aug 2023 15:38:13 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 9 Aug 2023 15:38:09 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 9 Aug 2023 15:38:09 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 9 Aug 2023 15:38:09 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.108)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 9 Aug 2023 15:38:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=emiJKwjTv+CaPenOGMHhKoXKcx+oJSMIsa5Utz2l2yKaVv6DXA3mkRtpnIgl0ZlMnOIVXZF22FP3sam1M+9vxQ9vzaNbRCzCW71COW/CyA8tR0x9WKhRRwdt/8moHxFCio9ORTJCIfs+DxKVQyMl+NNJdUmsFSx2fSJSHSzZ8JynDQBNpF7HKzahAEjiWgj9FinVES+t/Xcopxph/rTDXqe11kqFZdR+f726fXiw8vZWFsAG8sqQlIdQdqLWj1A7ML4i/RXYfOAupmoSCzacDHeoYYCHRb0xNmSeCde9J+d4lOxGYKM/rzq+PpiVmBVFtoq9d5/Jog1HHr98gCDM8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BcjKROJ914Xu9k0vFJFLImfQkf9ZAb+ZAESpxX7WouI=;
 b=Yffjz2NQZFTONCLXvpUWsNioF36j5pk4yK3WBiP57wNaJ+pE6WKyY7RXLA+UyXpVUEEzXMaFfPr752PWUIx06xH8fxSp9mivvjyLP+g5ZYLOy5uO7e0NdjlDjFHMCUiqTATk//mgfANWDAKllaOfpVJWY+XL1587j7GWdHg08UJW/1xsfU7SeYVpazoPQp0WBZe9/ZAY3OqJdQptIwJ8Kvx4QJnp4J5MF2aVyjyL0F6eYOgFkeQBknQdGYAkSSaDkX6RGwrbCefIdSww21Sj/8+4qaLCXtorhTAEHAh6rZIU76NS/MBuJ4T/OUURhpc6meNgEcXQ2H+bU7F4KSrlrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by PH7PR11MB7549.namprd11.prod.outlook.com (2603:10b6:510:27b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.25; Wed, 9 Aug
 2023 22:38:07 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::47e:3e1f:bef4:20e0]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::47e:3e1f:bef4:20e0%3]) with mapi id 15.20.6652.028; Wed, 9 Aug 2023
 22:38:07 +0000
Message-ID: <1250e10a-63b8-5192-493b-df4213c8e563@intel.com>
Date:   Wed, 9 Aug 2023 15:38:04 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.14.0
Subject: Re: [PATCH v5 20/24] x86/resctrl: Add cpu online callback for resctrl
 work
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
 <20230728164254.27562-21-james.morse@arm.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20230728164254.27562-21-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0096.namprd04.prod.outlook.com
 (2603:10b6:303:83::11) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|PH7PR11MB7549:EE_
X-MS-Office365-Filtering-Correlation-Id: 87e08982-0b88-4765-2131-08db99294d33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VEcXGiLVX1y0z8sDk1bccjmWe6/zlDhkXk7Z4wcwWMKLHigu01EFIGc1jp6pChR30uCPurh3kRQ0fDXmByAWqzTg/HKpp28BFOOosroMryF4p370I+Ewqrr6OXYc9ehmG1owsoOREBPzLeHfvjxlKyh+HpRILmHZX2GXm1/JV4fKhi5zV9lWZ1WxFLeD6X6GH/bgN4xZKJf8DgHBE3CA9G5bo6n0Z5QkUzHDZ7FhuYll5ffwzbK8d8BXhtXVXJXd/F0K/k/5fWtK8jRy0Ex8DQvSqGkwlX0VWgZISB4CvX/d4whOxoBX2Oc8dwnxACdh82MlUwx//3CY9JSN85F/DZtiVzd6Se7EFS/QXU0H64rnCOKcZPh4xT7xfcVxAC/hnW+VNRN+2hQEF79YreR2hoBSlwx50rEt3DAanesJp99cMLJlH0S7128o6KHmyJablGbgbobfXy7xpaIiM2yV1TDRneaI7UhjLQZjJVTkO38r7g/RYh1ax96ugQqQK1JgjnzykdH3t+sosgRLRTlDgf/ztBm8JkJEI8tMJK6pM6oB/Yc2P03Cu4QVVIyqxN1bjgRPrAeH2pgrP0Li+HmwitlkdOp0PQtMwxz+IEl0tf0RwIulTGJX+akaBVQR60iifsw4gnUKtL7gDZCyhw/t+g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(396003)(39860400002)(366004)(346002)(376002)(451199021)(186006)(1800799006)(2616005)(53546011)(6506007)(36756003)(6512007)(4326008)(316002)(82960400001)(86362001)(478600001)(38100700002)(66946007)(54906003)(31696002)(66476007)(6666004)(66556008)(6486002)(26005)(8936002)(41300700001)(8676002)(2906002)(7416002)(44832011)(83380400001)(31686004)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dTFrbndDWFgvVUpieDg1MUpnSXQ1S3Jhb2oyeWYrdXBLR2QrK3gzYVh2OEt3?=
 =?utf-8?B?V1I5cEo2UFRkRFc3d1g5bWY4ZWw3cGhsMm9PT0M3VCs1ZzM3VVBDY1RsdmRI?=
 =?utf-8?B?aU1RYjFHVDdqQTJYWnpBRWEyS3hGQzBtMjcxTnVpOU9vblA3VHlwQmdDL2FI?=
 =?utf-8?B?RE9oeFBRbWpWY1hUYTF0NDJBN3pHbWRMb2hrcUdjM1NNMWtLdktxa0hGd0xt?=
 =?utf-8?B?cStVYjZkK1B6NGFiTnp3YTRpUno2czZIZ1NJdmpXMjBRU1JhcDBTUG4xUE9C?=
 =?utf-8?B?Nm5TcnVjMm1uU2RSVHRlZmoxQ0NyajgrNzU3WWFtWWowOUFraXB4SWJCcTIw?=
 =?utf-8?B?K0dPUy9LY0FnYW1wdkV3QjFEbEJMM1BPd2wrbTJORTd4VjMzcER0bDl3VE85?=
 =?utf-8?B?U08wWVJOQTVsRVRDMmk4R3h0WFV2WG5rZHZNanBjNnZKNnAvVGtDYit5TTd4?=
 =?utf-8?B?eHZNcFBNdDBybG9jb1JKWm9laTRiU0NSK3hKVW9VTWZscjN4MmpQUTUyVUdu?=
 =?utf-8?B?azNYOTFUdnNjcllKWlgzV0RtV1VZR2s0K2xZOGhVbkwxQ2M3VGk5ZGRaYkd3?=
 =?utf-8?B?UjRaZkZ0SmFjTVpPcFdSWFZvcnZqYW9NRlVzL2xZdHU3VWlHRGU0UmZ6ZXJz?=
 =?utf-8?B?QjRmT2pwOVk0L0dVeThlOVNLSjZmTFpQNVpyZThCSXBMb2hZZk5NNmVtbjll?=
 =?utf-8?B?T2RCcllvWGl0Tm9GdUxtajZrelVnMGJoQnhrdlM3OE4wN2RkYUZXaGxpK1RK?=
 =?utf-8?B?c2Y2R2ZRY3Z3OVpiS2FIUEplR21HeEVHa0VZZWNvVXlPQXh0VVU4c0tVT1B5?=
 =?utf-8?B?V2VUTHRZQjNPVFlXR3BQVzF5cGR6T1NiWVNDOG9JUWIxMWpuRkg4N3JKd2lD?=
 =?utf-8?B?ekdvc3BEbzdvVnlaaFhxODRLajRvMnB6ZzllN05MSERheUNKTmw1OTBscStL?=
 =?utf-8?B?UkR5OHY1ZldFMFBuZmhQaXlsT1F6R2x6Q2wvWW0reWRKOXFtVy9ySUxBbnlu?=
 =?utf-8?B?MSt3TDVhaEVWME9EU3ZxOHZpZVM1Q3VNMkxxMzVCVGNTR01QdEY2K0NKT1hE?=
 =?utf-8?B?dW4xRHB4ekdNWEpDMlNUSEhaNWtLT2U1ajk3WWQrQURqNlBaL2kzL2lBV0Mv?=
 =?utf-8?B?dWhkOGlIbnNKTCtCZXAzbGdnYTloWmRldHJUcTFvVmY5UVg5UjZsaWVjVVlj?=
 =?utf-8?B?T2hZNjJaMjJ5K0xJMzQrYkdpdDdhZEduZ2x5eDBkbDR6cjBYVWxDU2NSaVZJ?=
 =?utf-8?B?eEhIRktIMGJuY2srcjF5R3BKNDV4SFhFN1psTW5tNzJQazdtdXp6NFZqL1BY?=
 =?utf-8?B?aHBjZWhXVi81OTNCYXBBMUhpaUUyUUZocmJzcURGZUd6N2VnN3FpUi8vcUFU?=
 =?utf-8?B?RVhNQk9WeDBJMnJ0MFNrZ0E2Y2JvOXN3R2liUmtqQVJkQllHNWxHdXlsUXhW?=
 =?utf-8?B?NkxsL0ZwdFBzZm1HNkVRNnZuZ0t2cEtKN2RqUTR3cXJSV2E2UlBOeGdTNGZF?=
 =?utf-8?B?SndpWVJLaEYzd211a1hyMXVvMVo3cUp3WjJ4SFZOZVhXSTBhbE51SllwZFBT?=
 =?utf-8?B?NWRtWnJOSG4wOXBqNUxhaTUzZllCWjlKUlFyYko1NVJDLzhXZTVrTTJFc0ZZ?=
 =?utf-8?B?QUhrSkp1bGlMSkVUQTMwNFcvZ2psRmE3c1B1clplaHZvVmJSVEJrb201V3R1?=
 =?utf-8?B?Uk1wMzdnd0FidXZQVlBJVFArR0ZNQml2bldmSkVtdXY3dW1STW5kVXFPMHps?=
 =?utf-8?B?Ty9JU0h0akluVjZsU3VpRE1xaC9iOVoxNmZxVjNrL05jcmc5dVJ0QlMrbita?=
 =?utf-8?B?SWVzSmw1cVd3a3FiMmlmQmhkWGlvUzNsYnhzQXRBVVlFbjR5MTdWWkRvVk5W?=
 =?utf-8?B?VjRwVmFmbUlJNk1ORXUxVG5PTlVDVVFkcyt1cytVdVk2TmUzQXlMaHFLU3JG?=
 =?utf-8?B?ZmR2dEpjNUpSTzF3cHhkVEdWWlBEaUhjdEFsS0lNNlkxM2IvWXJseTM1UkJw?=
 =?utf-8?B?Ukl4b1BVczRqalRyVXh0WkFLT1A0aFVtYk1Id2c2anBrYUp5N21ESGlibzRQ?=
 =?utf-8?B?RGVSNmRPdVZjY3I4UWdUVjlWTm5qcWZnU21KWFVYa1BBWUtwSzBaSUtkMi9w?=
 =?utf-8?B?Q1B5Nm55NVRzcHVuU3JiVGJ5cFB0RlRtWXVYZUJseTU3MjZyZWR1TFJ3RHhR?=
 =?utf-8?B?MVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 87e08982-0b88-4765-2131-08db99294d33
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2023 22:38:07.2615
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tFY6P+UMaok20sJ7u02Z6/2Fv9kYQjeBvc1rdRGsRoaKUhBboTww+vOlL3l5/l3ldqXgF3fc80xQALQmdQL2JRRzHxK54esiXMUSjM5x1gk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7549
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

(please also check subject lines for CPU instead of cpu)

On 7/28/2023 9:42 AM, James Morse wrote:
> The resctrl architecture specific code may need to create a domain when
> a CPU comes online, it also needs to reset the CPUs PQR_ASSOC register.
> The resctrl filesystem code needs to update the rdtgroup_default CPU
> mask when CPUs are brought online.
> 
> Currently this is all done in one function, resctrl_online_cpu().
> This will need to be split into architecture and filesystem parts
> before resctrl can be moved to /fs/.
> 
> Pull the rdtgroup_default update work out as a filesystem specific
> cpu_online helper. resctrl_online_cpu() is the obvious name for this,
> which means the version in core.c needs renaming.
> 
> resctrl_online_cpu() is called by the arch code once it has done the
> work to add the new CPU to any domains.
> 
> In future patches, resctrl_online_cpu() will take the rdtgroup_mutex
> itself.
> 
> Tested-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
> Changes since v3:
>  * Renamed err to ret
> 
> Changes since v4:
>  * Changes in capitalisation.
> ---
>  arch/x86/kernel/cpu/resctrl/core.c     | 11 ++++++-----
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c | 10 ++++++++++
>  include/linux/resctrl.h                |  1 +
>  3 files changed, 17 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
> index 8dfede01b0c9..a694563d3929 100644
> --- a/arch/x86/kernel/cpu/resctrl/core.c
> +++ b/arch/x86/kernel/cpu/resctrl/core.c
> @@ -603,19 +603,20 @@ static void clear_closid_rmid(int cpu)
>  	wrmsr(MSR_IA32_PQR_ASSOC, 0, RESCTRL_RESERVED_CLOSID);
>  }
>  
> -static int resctrl_online_cpu(unsigned int cpu)
> +static int resctrl_arch_online_cpu(unsigned int cpu)
>  {
>  	struct rdt_resource *r;
> +	int ret;
>  
>  	mutex_lock(&rdtgroup_mutex);
>  	for_each_capable_rdt_resource(r)
>  		domain_add_cpu(cpu, r);
> -	/* The cpu is set in default rdtgroup after online. */
> -	cpumask_set_cpu(cpu, &rdtgroup_default.cpu_mask);
>  	clear_closid_rmid(cpu);
> +
> +	ret = resctrl_online_cpu(cpu);
>  	mutex_unlock(&rdtgroup_mutex);
>  
> -	return 0;
> +	return ret;
>  }

This is unexpected that resctrl_online_cpu() returns an error ... and
then the caller exits with failure without error handling or unwinding
the previous work. Is this error return needed? The function just
always returns zero so it looks like it could just be void.

>  
>  static void clear_childcpus(struct rdtgroup *r, unsigned int cpu)
> @@ -965,7 +966,7 @@ static int __init resctrl_late_init(void)
>  
>  	state = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN,
>  				  "x86/resctrl/cat:online:",
> -				  resctrl_online_cpu, resctrl_offline_cpu);
> +				  resctrl_arch_online_cpu, resctrl_offline_cpu);
>  	if (state < 0)
>  		return state;
>  
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index fef78a3dc632..7bd3a3dc0f44 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -3868,6 +3868,16 @@ int resctrl_online_domain(struct rdt_resource *r, struct rdt_domain *d)
>  	return 0;
>  }
>  
> +int resctrl_online_cpu(unsigned int cpu)
> +{
> +	lockdep_assert_held(&rdtgroup_mutex);
> +
> +	/* The CPU is set in default rdtgroup after online. */
> +	cpumask_set_cpu(cpu, &rdtgroup_default.cpu_mask);
> +
> +	return 0;
> +}
> +
>  /*
>   * rdtgroup_init - rdtgroup initialization
>   *
> diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
> index 5e4b4df9610b..35d3c97df212 100644
> --- a/include/linux/resctrl.h
> +++ b/include/linux/resctrl.h
> @@ -223,6 +223,7 @@ u32 resctrl_arch_get_config(struct rdt_resource *r, struct rdt_domain *d,
>  			    u32 closid, enum resctrl_conf_type type);
>  int resctrl_online_domain(struct rdt_resource *r, struct rdt_domain *d);
>  void resctrl_offline_domain(struct rdt_resource *r, struct rdt_domain *d);
> +int resctrl_online_cpu(unsigned int cpu);
>  
>  /**
>   * resctrl_arch_rmid_read() - Read the eventid counter corresponding to rmid


Reinette
