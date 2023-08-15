Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 036CB77D65C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 00:46:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240469AbjHOWqF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 18:46:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240472AbjHOWpf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 18:45:35 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06BA41BD4;
        Tue, 15 Aug 2023 15:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692139534; x=1723675534;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=3ooGdszcPT5xDq07PqNUQforZWEiARdVGmFEgoCY868=;
  b=egqKa/zHGLTSBGBQ25sGViTU2FnJEEOM2fdNQBcoShYrtZCROB8risti
   70fy2wkZ9gM26vSKYVZSN7/dRQm8Kpebl4R55MtRWm/3v6OIUOmRp+KO5
   5Ol0hYvz2Lfy0Kit3NPs3ptAGi8PbHM2YaNaUwIZXF5k69wiRbQt80mQ5
   OG7brBjMy6eaSzb1yyTxKmNx878+Sb5/syXdYQkJQSP0L86yACIMrDZhV
   j5KhCrrhr0NlvXJroEhaJu7A0ojQADCa9XSVG+557Ajr0JkmiwGAAlxWp
   8Fbos2yBKhQVL/P0yiZUCyfBCYcCWlfuQhQ6ZajrgaomLyzlqMDFomgHR
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="357372708"
X-IronPort-AV: E=Sophos;i="6.01,175,1684825200"; 
   d="scan'208";a="357372708"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2023 15:45:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="803983181"
X-IronPort-AV: E=Sophos;i="6.01,175,1684825200"; 
   d="scan'208";a="803983181"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga004.fm.intel.com with ESMTP; 15 Aug 2023 15:45:32 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 15 Aug 2023 15:45:31 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 15 Aug 2023 15:45:31 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 15 Aug 2023 15:45:31 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 15 Aug 2023 15:45:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RIRYl8VL6OjUOaKI1P9hCCFKeth96XV6jiw0k7SjplX50jDl42GMEeJBEgP/5HkzlYWrGhRCIWMiE9ffZvZNS1O0LXI7rth7wjnecvTi3lHJiL53NDBtnsaiLtVVHhNqCon0SO/Mx+RFCB8zrLjyvrvV2Ab4o2YSFDvjxnG1WUlFGKvWGTUdwGiXBtA0e19uJPpFs/bp4kOPSKphNRiKBOJ6TrqUiPsNO6iaoXacuA3A6CPi+dDLH/d/udxeEKddyDpAhjkuPMAcNywuHW0BqpAoruMHe+ZukFdYMlJ2oz+z95AsH4gnnAJePogdyCfiqSWBg+YgfCCOR6jwoHcOpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9qrv9YzW0Z7UuYJJIZnbelmwmobS/WRz610Tp5P3nsg=;
 b=ZsujbxOcTztM08G8/umB0Wqa8shWsGkZMxDV0JRqPaqu1RPLaPLX1i9DP/4/sbboQnXwNs/LEgwNO1df+oRItHtTB0afyTxHdJkWHXAmg6er1ZEx0a+U6j/jqEWuhNM9z+vLZvrGy5YPeTrRZ48Ldp89aSbOglSr0Ci6nN20ISO6QzoG68Fimc8zJV3kyKRyuZCqKmirwZWRuga7YLDSdPQsx3INvwIIDuq1yQl2eS8sJiYWhdlE+wazBT4snni6SyxmfUKjdOLu59ZE4DxUFfJJ979LJKZcS3sDwX4Fd1HKrqVnAYEUB0zrZHfKK8eqlhRMJkZYHCT36wX2zzXcDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by IA1PR11MB6124.namprd11.prod.outlook.com (2603:10b6:208:3ec::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Tue, 15 Aug
 2023 22:45:28 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::47e:3e1f:bef4:20e0]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::47e:3e1f:bef4:20e0%3]) with mapi id 15.20.6678.025; Tue, 15 Aug 2023
 22:45:28 +0000
Message-ID: <37986ad0-4519-0f16-c09b-86fcf2f8a763@intel.com>
Date:   Tue, 15 Aug 2023 15:45:24 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.14.0
Subject: Re: [PATCH v7 4/8] x86/resctrl: Add comments on RFTYPE flags
 hierarchy
Content-Language: en-US
To:     Babu Moger <babu.moger@amd.com>, <corbet@lwn.net>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>
CC:     <fenghua.yu@intel.com>, <dave.hansen@linux.intel.com>,
        <x86@kernel.org>, <hpa@zytor.com>, <paulmck@kernel.org>,
        <akpm@linux-foundation.org>, <quic_neeraju@quicinc.com>,
        <rdunlap@infradead.org>, <damien.lemoal@opensource.wdc.com>,
        <songmuchun@bytedance.com>, <peterz@infradead.org>,
        <jpoimboe@kernel.org>, <pbonzini@redhat.com>,
        <chang.seok.bae@intel.com>, <pawan.kumar.gupta@linux.intel.com>,
        <jmattson@google.com>, <daniel.sneddon@linux.intel.com>,
        <sandipan.das@amd.com>, <tony.luck@intel.com>,
        <james.morse@arm.com>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <bagasdotme@gmail.com>,
        <eranian@google.com>, <christophe.leroy@csgroup.eu>,
        <jarkko@kernel.org>, <adrian.hunter@intel.com>,
        <quic_jiles@quicinc.com>, <peternewman@google.com>
References: <169178429591.1147205.4030367096506551808.stgit@bmoger-ubuntu>
 <169178458575.1147205.16331131496340363561.stgit@bmoger-ubuntu>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <169178458575.1147205.16331131496340363561.stgit@bmoger-ubuntu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P223CA0023.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:303:80::28) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|IA1PR11MB6124:EE_
X-MS-Office365-Filtering-Correlation-Id: f443d155-31e0-4d30-9aff-08db9de15256
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4w/hxi5aN++pIAfjCc116CyokSvOgTdYReSZk3VMrjJoiOfInb90rDrVEldKuWloU2YTey4Y34cqxQfISj+foZ+Xe7JSx4hRrGrcdOts0FBTAmnVOuGO0ysBWLHiwY1pxM7U2VzE5+BGDL+ZTZLudY370oW2VxJPqiPX2AwXw1kCoLlYceCIQNdXfjRZl0tl/IJ8V2TIRkBuEEiPTZGsOQB5t9L9ET9Crp8J9nvpu4kUaE9LW0pv9aWx5NRe3UKWwimZzP7xbxV5GdQ9SUkIMQnn07xnm8lbeSoacpjkOG6JdX/nBlzj0SCqEQZTCvlYwQWIJUIh9c4eu0q1tWlQMKLcYxfkL0qW8Twj9ZfN4SLyUTE4UHJe98F8yEoUSsTJLhx4uAfWMEdzPzrlEWZX5iWV/GFMcMjYCWf1oYiA0FuAlUk4YLuVRN6eBTCWykXEXOxIL/R0cYHfxUNIO18pL2IT/x8p51LZ3KjQBWCRalhVPwkNG0pE26ZZ+c0l35kbPR0Ia1rWgnRrqee9LA+HRzmdkTIvdgOMk+MLcn1lxnHUEHWlNomkSRu/JFkSivRjKQ1wi5E9nfQTBy1XmuL+kQHVtsIAganBg1OGUqn/P4xEWAEQ/a2aKppQhk75iQAI3uyJQGxOh2ybcTq8h/GrSg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(136003)(396003)(346002)(39860400002)(451199024)(186009)(1800799009)(26005)(6486002)(31686004)(6666004)(38100700002)(53546011)(7406005)(6506007)(31696002)(86362001)(36756003)(316002)(66946007)(5660300002)(44832011)(478600001)(82960400001)(8936002)(4326008)(8676002)(83380400001)(7416002)(41300700001)(66476007)(2906002)(66556008)(6512007)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bDdKVWxHZ1VPYTd3NVIyWWJWUUdjSnA1YlQ0R25KNEJNdTY4QUEwY1V3WTQv?=
 =?utf-8?B?WFZzU21WbzZ0NHBiQ050UjFMYUE1bVo4bDNoZkVqMU9BQnBVWWwxbEl4cnpQ?=
 =?utf-8?B?UWlKY09wMzBHK2VKYWFQMEhUYzV6NjRKNWZvYmppM2RlYWpreDJBTTEyajhh?=
 =?utf-8?B?ZVBtSG9hT3Z5ZGZwUDg2N1hwK2g0QVk2b0x6Z1E2QWkyMlkrMUVVdHFLdWlC?=
 =?utf-8?B?N0tIcTRjdlhEVVlSbGxBUG1DNHFxckZSckYxUmVEazViTmNCSkZiSWJtbGRC?=
 =?utf-8?B?Vk1od1puazRrYmFJTUc3ZCtGZVBNUlBDV2pZTjJWUjlZUEdBYURyNTY1NlRK?=
 =?utf-8?B?MmloVUFGUmdodHRCT2pmZmNWMkxyTHRoWXowMDh5bjRRN1hub1M4cFFXdDNs?=
 =?utf-8?B?YXVGbDVmc2JQSzNid01ENWxkdSs1R3Y0RktxWFFMcldiM2JoWnlPOFU0NWVV?=
 =?utf-8?B?ang4YWhaRUtkZjhKcEg5TFhGNVh4T0lrN1paNythY2JiemZCM2VmQjB0c3pS?=
 =?utf-8?B?TTJsNGJnNlNDQ2J4bktXaWRLbzZScTZsRzhBWjZ5UWpsRjhZeGV3MU5CVTlJ?=
 =?utf-8?B?Z3dvMkRJbyt0RHZYME11T0JNTHJ0eTU1c2paNUI5SFBOcWxMTlBwMlFEanhR?=
 =?utf-8?B?NGk5bUgwSDk5SitCVDVvdzA2RVFMWVpkVStlMDB5YmlPQTR2dEVVTWN3L05t?=
 =?utf-8?B?YStlMkNTWU8xVjlvOWhIVGFiQzIyTGFML2J3TE80S045U1lKVEI0Skhmd051?=
 =?utf-8?B?MnZFNnpUUTFza0RTcnViWWtHclRFREZoK3NBUWpLK0k2eXRWMEZ4SDhESTE5?=
 =?utf-8?B?U3lYaStDQXJ1RHhEQ2N5NlRibjlmTGJCYmFDWTB2b3g2VG1SOTJZU2RROUFC?=
 =?utf-8?B?MktjenorUytqZnYvY21FU0M4Z0JkenowRmVkY285NXdJRW44N2k1amtmVnA2?=
 =?utf-8?B?WlVUc3RwT1FHUTMrS215V0Q0REJmMUtXZ3VCaTBjd2tjdzV5MVZhUlFwRGR3?=
 =?utf-8?B?dSt6elNwdWhzMUROdTlKRzVTUVVuVGRtMzRLNys1SlFiY2k4SnpyTWJ3UjRG?=
 =?utf-8?B?aDZtRHdwM0drcTVPeFAyK1pYWlRsaHUyWEF6d1B4WHFiM1ZHQkpwRm1JUW5M?=
 =?utf-8?B?M0cwdHZnOHdQR1hwNmpzdERsOUw3azJIbkppZlN0azRvUGdQN0hlamg5QktN?=
 =?utf-8?B?TXd0YW0vcExuRG92THpGVlJVMk1vSXZoSTM2dW83TnV6R2x3dGlQTVVRUWtu?=
 =?utf-8?B?d3pBNmtFblUyOVhQVVlDYkQyZENrcHVPREp1L2dQWE82Qkc4REdFeHh4RENY?=
 =?utf-8?B?ZTZqS1pXTTgzVHBCWTlURFpUVEZId3diNlhsOXQvYXlKdFQvc2N5aEtEWFVO?=
 =?utf-8?B?YnU2dDcrTmhYak81S3lpS2F0VFlJRlA3Q3BiRGRaV0MxNUZQMVVtS1NmRytx?=
 =?utf-8?B?RXlucmxzbEdoN1JBeXcraEJMTE1wNnVrREJESS9ic0NHcWZESm51YVUyTzRR?=
 =?utf-8?B?Y29hbzk5M242c0pJQ09kMXZJWWpJemdPTnMySHhNMTdWckpqbFhIZERWUTZr?=
 =?utf-8?B?SVV6YW1WMHFwN2ZzM2FOb0RhUUNnTFkvY0NveUFBOEVQRDYvQ09MNXY5Y1Ez?=
 =?utf-8?B?Uk1JYnNYM1lSTmNZSU1WZjZmNWtleHU4T0pRN1FrWEx5TzZIdHcyeGdlbmND?=
 =?utf-8?B?WjhkME04bWxMdnJxQkduVEJSMXAyY21iaFpBYUk4YUM2S3FyYnp4WC9GVGl3?=
 =?utf-8?B?eVNTSjRlSmJXdU1HZlVDbFU0Ni9JaURydWRqU3pGT0lQczFickw3Zzd4dTY3?=
 =?utf-8?B?TjYwUVdGVU1UV0tHcStHNkxUZEppWmdjS2t1UkQzVU1GVnpnNGpNRkZTZ09F?=
 =?utf-8?B?MkplcklqWEQ0RW5IeHE4eWduR0tkczlabTcvS3VycmV4bTFYTENSOGdnN3Y3?=
 =?utf-8?B?R0dIWVJiWEtvRjZlb0VMQy9QYmZLN3YzcmlkM2k0TXptMzJGSFdxcVV6Nnk2?=
 =?utf-8?B?MjdYZFlPd2NQR1IvM05WUVVidnc0Nm1SZXVxUm5JUExNZmp5eE5NR0dndUxv?=
 =?utf-8?B?dDdLaEUwT3l5cGZ6UUVweUlpWjl3YUp2NmFpdDZzNFZOL1kycUd3NW9ZNTda?=
 =?utf-8?B?TmppeFZMS2FDczdPazdRSitLNWdBaVVyMk9LUjNQdE9ERVpKRlBUbjZBekNY?=
 =?utf-8?B?RlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f443d155-31e0-4d30-9aff-08db9de15256
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2023 22:45:27.9741
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wGTnyBxpzt7UvaGxud5o9QRwoyuKqHD/FmFospC4pqc9R68An4gMOBRIwmqH3c/2LyGAnPRHddjAW00qReAWX/uftv6BPx02bF3LyDFJrvo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6124
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Babu,

On 8/11/2023 1:09 PM, Babu Moger wrote:
> resctrl uses RFTYPE flags for creating resctrl directory structure.
> 
> Definitions and directory structures are not documented. Add
> comments to improve the readability and help future additions.
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
>  arch/x86/kernel/cpu/resctrl/internal.h |   49 ++++++++++++++++++++++++++++++++
>  1 file changed, 49 insertions(+)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
> index 2051179a3b91..37800724e002 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -240,6 +240,55 @@ struct rdtgroup {
>  
>  /*
>   * Define the file type flags for base and info directories.
> + *
> + * RESCTRL filesystem has two main components
> + *	a. info
> + *	b. base
> + *
> + * /sys/fs/resctrl/
> + *	|
> + *	--> info (Top level directory named "info". Contains files that
> + *	|	  provide details on control and monitoring resources.)
> + *	|
> + *	--> base (Root directory associated with default resource group
> + *		  as well as directories created by user for MON and CTRL
> + *		  groups. Contains files to interact with MON and CTRL
> + *		  groups.)
> + *
> + *	info directory structure
> + *	------------------------------------------------------------------
> + *	--> RFTYPE_INFO
> + *	--> <info> directory
> + *		--> RFTYPE_TOP_INFO
> + *		    Files: last_cmd_status
> + *
> + *		--> RFTYPE_MON_INFO
> + *		--> <L3_MON> directory
> + *		    Files: max_threshold_occupancy, mon_features,
> + *			   num_rmids, mbm_total_bytes_config,
> + *			   mbm_local_bytes_config
> + *

I think the monitor files need the same split as what you did for
control files in this version. That is, there are some files
that depend on RFTYPE_MON_INFO and others that depend on
RFTYPE_MON_INFO | RFTYPE_RES_CACHE. In above it appears that
all files depend on RFTYPE_MON_INFO only.

> + *		--> RFTYPE_CTRL_INFO
> + *		    Files: num_closids
> + *

Looking at this closer I can see some potential confusion about where these
files appear. A note saying that these files appear in all sub-directories
may be helpful because at this point it appears that this file is at the
same level as the directories.

> + *			--> RFTYPE_RES_CACHE
> + *			--> <L2,L3> directories
> + *			    Files: bit_usage, cbm_mask, min_cbm_bits,
> + *				   shareable_bits
> + *
> + *			--> RFTYPE_RES_MB
> + *			--> <MB,SMBA> directories
> + *			    Files: bandwidth_gran, delay_linear,
> + *				   min_bandwidth, thread_throttle_mode
> + *
> + *	base directory structure
> + *	------------------------------------------------------------------
> + *	--> RFTYPE_BASE (Files common for both MON and CTRL groups)
> + *	    Files: cpus, cpus_list, tasks
> + *
> + *	--> RFTYPE_CTRL_BASE (Files only for CTRL group)
> + *	    Files: mode, schemata, size
> + *
>   */
>  #define RFTYPE_INFO			BIT(0)
>  #define RFTYPE_BASE			BIT(1)
> 
> 

Reinette
