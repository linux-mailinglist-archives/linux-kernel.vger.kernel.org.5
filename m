Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFC2E7B7321
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 23:14:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241157AbjJCVNw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 17:13:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241146AbjJCVNv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 17:13:51 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9541AC
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 14:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696367626; x=1727903626;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=1+u0MUhFfoIbZ28Hn2yWsSs1+IrCkEQeZCMqh1KG8/I=;
  b=gtDOQHOr2I4nsy0glF+DBV+7l2G2jIimU00Qa+xdRqCQFa4am36GzjLs
   j8uxdjxl0QRqkxL8TVlYFWAnbLSW8e0qMEiHIR49zKjbFf9Nf4/lebDRM
   /8Aljp4oHp1Pw7OaqV6K+jnSBikcza2E2LK2YsyEJvcOegXqZsWoSA2Tg
   7D2hbDbzUgV8i9rEOpUYwoE/XBAejZc1Ooc7SnVLWGhUFfWHBF7dJbUOl
   RWmrz3phnTc6iLnIzCTvYQkccXWRJlVaQYeC6lqkY+4JUpFxEQmAGXxg9
   Rczwe6bjMOVanS9+hVc6Pg3idN3DmYQPi8Yf80MJBuL5RHhAHw6y0ODQe
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="385798806"
X-IronPort-AV: E=Sophos;i="6.03,198,1694761200"; 
   d="scan'208";a="385798806"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2023 14:13:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="998182167"
X-IronPort-AV: E=Sophos;i="6.03,198,1694761200"; 
   d="scan'208";a="998182167"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Oct 2023 14:13:45 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 3 Oct 2023 14:13:45 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 3 Oct 2023 14:13:44 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 3 Oct 2023 14:13:44 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 3 Oct 2023 14:12:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IVGTNSNsPRJKMAzUEmKNtqMJgsPkIvUao2oTvhNjPGAMhnKeqbfouqQI6ZDmciWlBR/m1Q4i9/ixX8Tz16f034kiSJ0YE1Xtj0wRZvUownEImRd/gbdvhncEiUY9S6s8DJxOlnK6BETK2Fk1hV7M94+PtQUPk/Hb1XN3E+cpSFc6Ca/7vbNUuxdSci1AH887WLGxd/um39ZjOvoVHEJwYakcLjr/4Bdx2BB/fxCDgbo1ZeniIr8OZo/L9j6QDOQkBecqFsjJUI/Qxo1erBVzyo7oNT1x8Q7Bb7Jc1MK0hNvMI9EIarTXtUO3XcusBKLADWa5I+VM6P0DU021svlzQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6E+CxixMMppthUttmFA3aZMYkJoceroE+ZO1z5sufM0=;
 b=Mo2Zp5jn/wMqzoG6JsKc+jnK8RUUqd7ynvogdQ38y31y+xojH7S1bYF0PXEeiqfcj3uA0Mb/nxQ6u4JoWrBE02P0jclaAYJIcRI3lFet0lRdwPriSsgmqIEMAuuqOYSiAARYLPlThalrSX5AKjBtEaqr6+BG1Qvfiec4GN/qEqKBnB3Xto3l/StHBe+8DKaZ/7pyzAGgCD19AzfA+oZnqk4mgj035ttc+9IsK5Lig7sr7ucEk3nbnXynehU/LTqoWgEqMWb8LcWCjZ4vxCUoqzCT/BxJ5YiM8Ed1cwgQp40N9kAXhflsW6231/aHHb2R+OfScOyUJf748WNqRLiSeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DS0PR11MB7577.namprd11.prod.outlook.com (2603:10b6:8:142::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.27; Tue, 3 Oct
 2023 21:12:53 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bd70:f215:4a97:c84e]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bd70:f215:4a97:c84e%6]) with mapi id 15.20.6838.033; Tue, 3 Oct 2023
 21:12:53 +0000
Message-ID: <3b83dea1-7d99-5300-7b3f-f6311c6a2a6b@intel.com>
Date:   Tue, 3 Oct 2023 14:12:49 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.15.1
Subject: Re: [PATCH v6 07/24] x86/resctrl: Allow RMID allocation to be scoped
 by CLOSID
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
        <dfustini@baylibre.com>, <amitsinght@marvell.com>
References: <20230914172138.11977-1-james.morse@arm.com>
 <20230914172138.11977-8-james.morse@arm.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20230914172138.11977-8-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0317.namprd04.prod.outlook.com
 (2603:10b6:303:82::22) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DS0PR11MB7577:EE_
X-MS-Office365-Filtering-Correlation-Id: 18d8944d-cbaa-497b-aa7a-08dbc4558198
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vz+wU3RgseBCnv46Zhw9vGvv8GEfBxlvSec7b0gu3Ytqx1SNlNGuTCbxUV84owCd3hv27d91ma+f2TT6wzfIhc3aqQFwNrAo0+7XP6fEr9uqghP1J/Yioh2CVpWtPweYMc1qbNDSjt8eXTAHO572jjf7b8UjgLqpCikTPO+dqQfBrfMI2atngnDeRpFwlL5DKzJXzFSk6OOsdcJmU9lQDg7jsIXjeyZ4AVHWBiJQWBZptyq4FE6gU7GPd7YjoU9GhUUt6efcF56jHZY3OYX9B5v1p1+2fBWkdFAxuAwivObRoFSC7PB/CvJYHOOaNTrzKvn9RwaASl5tib3vBzsQ7iIrblSXVoDreuAQGo9u+1cOAz0GG7toGSZezNvH/jjE9nH2GCr/fSdOGB4DlOGy/OXzFlCJFPBzNDBugh5odgfNKc/P1SJzj2KE+Q3hoJnXFMMaSyM9Hyf0rdZW3z7T+pwYVUwdP8n/aITBiYA8SiXtBXHo3TSsYaXx5FjvMb56Q3oCfU4vX0kyZs+IpIyWNALMfZ0VjGzGw+6glJJjZG4+yAI62IUSzPbF7WI4rjWyQ0EU8h+JCU4VztaVoou1oPWjhJzON9YaFuOUcT/SoszmYl2d4eokmrOjNyJWaYjyxfJvQZYOpnrQhLT1Uy/2nQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(346002)(366004)(396003)(376002)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(66476007)(66556008)(6486002)(66946007)(54906003)(2616005)(8676002)(41300700001)(8936002)(4326008)(26005)(36756003)(478600001)(6666004)(86362001)(83380400001)(38100700002)(31696002)(6506007)(82960400001)(6512007)(316002)(53546011)(2906002)(7416002)(31686004)(5660300002)(44832011)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dzFtbFlYdDdLZS8yM3BiQy9OQzByWU9FbFRuWEJXaTZtSytmN3g0ZTNiZktn?=
 =?utf-8?B?czJkSHA2dW9IK2kvb1dsblBwdHYxNkNpNXFybm9YNzA1SHBlMTBKOHF1NlVn?=
 =?utf-8?B?V3I3a1BiRUNMbW14ZGpSWFdrNnBxZ2diTHhVa1hNakt3UXV3c3lGdTVZeHdN?=
 =?utf-8?B?Z1I4RHc4YnVUaXBEWW9md1dkSmptUEk5TjFFTEE3SDdPa2RubENmcy9xenlX?=
 =?utf-8?B?Vm1sWFR0TGF1NE9KVk5OL1p4U3FwUjZtNUVmaGs5ZzFhc1FNdDJWK3JqUU1J?=
 =?utf-8?B?RUlIbWQxZmphMGx4NmxxT3dibGZ5Nk1NK1g2RlpFTjF3TkJNRjFneTFTdWxj?=
 =?utf-8?B?MXRnWDBHbzhuMEl2bDJYazRKS0lVbjlHc0NDUGcyeVpyY3MwY2htT3JlS2JM?=
 =?utf-8?B?bi9PZG9ZUGZEcmhXcWlGRWI3NGVRV29aMit2UE9JZjgxcmErOUVBOHlZWjhn?=
 =?utf-8?B?T1NZblFxRjd3alRNbGNVTXVXei91L1hvZXZzZVVINVl2V2xHTUNJazNkalFq?=
 =?utf-8?B?MmxmZzFITUhOQkh3K2d5cVRqY1Z4T0NQNUZ1Vk5VLzgxMmJVbXR2dFVIeDdE?=
 =?utf-8?B?VjlCWWtWUmZ1NEdGVGs3Tm5iV0QyMC8vek9SdW5iQUtwZzlKaTdSUTU0MXl4?=
 =?utf-8?B?eWhpNG5mQnFIRVpxa1dqcWs3WVE0TGw3ZENZeVhWQUZLcHBhd1JnZ3BCU1BQ?=
 =?utf-8?B?SEYrbzNYSE52NnRSWjRlLzY3aVZRQWVrekJWTm8rN1RLdmJnUmEwcWNmZWRO?=
 =?utf-8?B?ZFVaK2V1VGp4ZU9ZVDBMV05ia2NpSVBRL3NuVmdLQzRJdFhwSzBzNmMvdDh1?=
 =?utf-8?B?ajZRbzdCVlNIRFpJeGpLaXd5WmtOSjhKVkUwR2VHZFh2MVNFY1N3TFMwdmpS?=
 =?utf-8?B?SjlyZWtjR08rbXZUOFVOWUE3NHo0cEJhYzMzY0dlM2pXUVdva1lOS2JTOWdX?=
 =?utf-8?B?MTRxbllpUDY1QkJONmp2ZkxnQU12QjhTTmZQUzV5dW00anhUM3dEM3gzTFll?=
 =?utf-8?B?SUtmZ2lsd3AyRGJHbVFKcDVQQ0p6YzZlRW9mcUllU1YybklUc0k5clZWL3J1?=
 =?utf-8?B?UUpuMU50SkJvaWNhc1F2RE80bjJ1dUw1TDNOOGlZOXA4REZSNHFQSVJhUXNI?=
 =?utf-8?B?RkVSN0lZeGlmR1pKdDV3WHVGaXJ6dlZUQUJmMkk2aElzelZxZWQrNmdBeU1V?=
 =?utf-8?B?ZkZpenVDUDdyUDV1OVBFT1AwSWF4THM2RGowQi9YZUR4bHRwcmZ6ZXRkR1cx?=
 =?utf-8?B?b2hHQU43b3l6bkYwQzc5Q2orbXR6VEpBT3hiaXprNnIyT1FqM3JuSGZEY1l6?=
 =?utf-8?B?S3ZZWVpWbHErT3RqckVudFptK0FLb05NbWVRcG1IQ3pJbFFqQlNQa1FXRFVR?=
 =?utf-8?B?NXhkQncwNDh6QjFBUlExZWQ2U1RFRTVhQjREbnpVZU15Q2JzbGFkaGhxMEJq?=
 =?utf-8?B?WHZpOUNLMGdGUjlneVp2VHVkRWRBNE92MngyS2lnMmVhcnFVZnErL24zall0?=
 =?utf-8?B?MHVrVlE2SDJRRGp1ak9lU25McmNLc2p6TG80V0daVU5rM2R1N21wbWg4SUEz?=
 =?utf-8?B?bDhuMVVUQlhrdnlUbDVzVTRuY21NcXd5Q3NmeVcxVng4SnVPWG5BZ0tVSlB5?=
 =?utf-8?B?UU9MNUtmSVJ6S05VTklNaGVBeWhkYjdORnR6TjA4dmtPMURTN2E1Y0RvcTV1?=
 =?utf-8?B?UlY3V0Q3SkN5VkVlM1k4c1p1MEs0d3M4ZnhWVUlhVlBqT0dNUlNzQlBldEhD?=
 =?utf-8?B?T0pZWkNGakhmYW5QZUV6QzBDbWY2N0xwOWNDNXpXZFJ6NkQ0WVF3d3lJVmRV?=
 =?utf-8?B?UktOWkdTa1NrMGhLOXliRHlHYWtjZUZLVE1ueDJZNVNEU2JZOFIydmp0a2Zs?=
 =?utf-8?B?bXRqcHdGVURkclNZZU9OZldXN2tIMXRORkt1eldHOUNPN0pRMHh5bXhPdUo0?=
 =?utf-8?B?RGo5RlBvN1ByeFZyMFA4YjkvbXFSbENnZjMvUFI0enkxM2tlU0licTFRYklh?=
 =?utf-8?B?Mm51dFk3RVRab2xlZ2Vla1djNnBHV1R2N0VmQmp2NzNZQTZRdEVieU9vZUFh?=
 =?utf-8?B?MWVIcFV0SjdXNzRQRnRDenY0SVBqVVFNSElQNzV2MjlnMFdSMkVTd0lWSG9D?=
 =?utf-8?B?TEVORDY5NkFleCtHdnZaM3VoSkkyUDZMd0VremhkeUlqbWFXR3lYa0l6Sngx?=
 =?utf-8?B?R2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 18d8944d-cbaa-497b-aa7a-08dbc4558198
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2023 21:12:52.9990
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cFDxMGqr+2pi7JPAr9yEeP40rgb+5uYNSF+lij0sEDneKpBuySv7orZbrTyCrUrBN498kkUXfBdO5/jiLJsckmyFYlLH8OXRPNJfLbFrn7I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7577
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 9/14/2023 10:21 AM, James Morse wrote:

...

> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
> index be0b7cb6e1f5..d286aba1ee63 100644
> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
> @@ -345,24 +345,50 @@ bool has_busy_rmid(struct rdt_domain *d)
>  	return find_first_bit(d->rmid_busy_llc, idx_limit) != idx_limit;
>  }
>  
> -/*
> - * As of now the RMIDs allocation is global.
> - * However we keep track of which packages the RMIDs
> - * are used to optimize the limbo list management.
> - */
> -int alloc_rmid(void)
> +static struct rmid_entry *resctrl_find_free_rmid(u32 closid)
>  {
> -	struct rmid_entry *entry;
> -
> -	lockdep_assert_held(&rdtgroup_mutex);
> +	struct rmid_entry *itr;
> +	u32 itr_idx, cmp_idx;
>  
>  	if (list_empty(&rmid_free_lru))
> -		return rmid_limbo_count ? -EBUSY : -ENOSPC;
> +		return rmid_limbo_count ? ERR_PTR(-EBUSY) : ERR_PTR(-ENOSPC);
> +
> +	list_for_each_entry(itr, &rmid_free_lru, list) {
> +		/*
> +		 * Get the index of this free RMID, and the index it would need
> +		 * to be if it were used with this CLOSID.
> +		 * If the CLOSID is irrelevant on this architecture, the two
> +		 * index values are always same on every entry and thus the

"are always same" -> "are always the same"?

> +		 * very first entry will be returned.
> +

Stray empty line.

> +		 */
> +		itr_idx = resctrl_arch_rmid_idx_encode(itr->closid, itr->rmid);
> +		cmp_idx = resctrl_arch_rmid_idx_encode(closid, itr->rmid);
> +
> +		if (itr_idx == cmp_idx)
> +			return itr;
> +	}
> +
> +	return ERR_PTR(-ENOSPC);
> +}
> +
> +/*

Rest of the patch looks good.

Reinette

