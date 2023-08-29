Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EC1178CD5B
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 22:11:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239958AbjH2UK4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 16:10:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237052AbjH2UKf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 16:10:35 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F09FDB;
        Tue, 29 Aug 2023 13:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693339832; x=1724875832;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=fakHxPvma5v1OZEh7egi14ddfP1VSYy8uslLlEY7uQU=;
  b=Pwlr0V8L9gCugpPx85b1O2DlujIIAlg8VhyOGRJqYJrk9Lcm6Etw+azd
   VvrgS+a7pRPJUdpWxnF0uLTY9eB1m7WOXLNj2FnGQo3vlCBFnXYOlj1gh
   WXzSP6FYNibAwO1/jkUs3pUbncZBUYqfentOUvw8BO/9OqVZ2hf03Ia1i
   57aS3FOeaq4fBy0JrJqFCEixXS2utEe1UBn1VEze4UcwtTyd40QhFN4Ah
   UZe6+LEV+z6dIoWGthewslEk7ud7XmA0Iw9aoN2F9IxYKJ6ykuqpu9uBO
   AgBIOhbB+uj+ni06thioYFHyqcskqR7NxGXUUVa6f+BF2Lxt2bSmmF2V0
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="461842979"
X-IronPort-AV: E=Sophos;i="6.02,211,1688454000"; 
   d="scan'208";a="461842979"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2023 13:10:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="853421480"
X-IronPort-AV: E=Sophos;i="6.02,211,1688454000"; 
   d="scan'208";a="853421480"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga002.fm.intel.com with ESMTP; 29 Aug 2023 13:10:30 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 29 Aug 2023 13:10:30 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 29 Aug 2023 13:10:29 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 29 Aug 2023 13:10:29 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 29 Aug 2023 13:10:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UR17145qrlY8hLVEz+UpxMCJQOsKrXuzRyOo+GVNlPTyyDMM2tolmtnN0kV2AAtV7nmTri+5lCyAQqKH/Jbr9oSpVAwXbM13JszhhGYfVy6vbRHJSEaY7pVZWX9HawwfGRVOMzj8z+bU3eD4mxQm+66Ajry765/bsbRmkNNRvf3auy4NXonHnGEhHl8DWdIJYwM6/82LM/LRyxOj6/IQBI4rNuCpWkzhP/k5AHwcBg2blgKWQQE5OQ+ki8ZlfQIGWy7W5ytvFgQvz79N841dBZvT0dEKDGm9+IIM3McpjoRpgjmnN8rUARrB90Yb5bQ+7qDMXbnzUEwnvfl1GESuVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6vwFKOlCl6G7nn5O3Y87b9mvtRkFqvMTI+4DgpEtPa8=;
 b=bR5WgxPTBJpuUXnjBuVPFHWJx7R1Zj2QUsLG9iIQRLZjGC45Jo5J93AyabC/WOem+C4i+pTAOJk/E/Opnk+vlMhe1lQOqWD2fkDt1W4YwC54KthJac+i6EJbayrJ6r2A3WMJru3ifM0VfoV8V7muhI+izMOBEwfv9oHzxWeMhbcDBbw+6BllOY4HufPHc5Cb+NmDZFoJ0c/VYB0X4/+DXBrfwG3fhtGHJGtbDcTO/FqMwm0IleLtuysD3N+R0OANtxggYdlgJ+GncLxKLzn+49APaO1HWL4WVmC2kjAQ/CsZ6PJGeYoWOQ7vvJAWXKDHnih3R8yFjjm1Stbb7mayBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DS0PR11MB8081.namprd11.prod.outlook.com (2603:10b6:8:15c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Tue, 29 Aug
 2023 20:10:27 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::47e:3e1f:bef4:20e0]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::47e:3e1f:bef4:20e0%3]) with mapi id 15.20.6699.034; Tue, 29 Aug 2023
 20:10:27 +0000
Message-ID: <343d12e8-9934-9194-cadd-7d133567396c@intel.com>
Date:   Tue, 29 Aug 2023 13:10:23 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.14.0
Subject: Re: [PATCH v8 5/8] x86/resctrl: Unwind the errors inside
 rdt_enable_ctx()
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
References: <20230821233048.434531-1-babu.moger@amd.com>
 <20230821233048.434531-6-babu.moger@amd.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20230821233048.434531-6-babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P222CA0017.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::22) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DS0PR11MB8081:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ec9c3e2-751c-4638-db19-08dba8cbfc7e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K80mNmkdkUPxxY4u5RYwRH9H3bb/6Ge54v9QigB6KL72+QJFa1VgtebOtaeoHh2f0Om/yMtVtHpJnWOhjpjCdKZalV2utw2OrOR5XVmFObreql5PdwjTL4E3EYWE3gsHslNZSuasaSpsBmZ29WHGpGcvWykghtY58yMmjXvzJet91ux7sm6RaAw8+0rQ8GptR2f10ptimLh4k6P4dnp2AnVbL+nGlqi8L0KRpm8b0r0/G5mdrW3UqYNxsbY82+MOfnlqFTG1COgfC2AJ6I/tKhFo3PmdGogfA6v6FUKMghIPJvehmBdCua5Rc8172X5gNrSE47TYuZyUjra9yzWg2aPqYETQNFFQILkSoWgsOC0KMjVMF/8xEz/Mro8ZLIC3lcNAaAYJzNacft5gauKJDkI1Uv8gltHog6+u1KewwUUhgoW9qtyWX3W8Pc5APOhldksYmn04Fc8q586d+KSRsAI+0RF3Lx0QMi6RJVqWhGUBxJM869iKr9nhLOnSNCrV9gfkM391CdUI/BiIEQA5FspCQXfxNLe/iGPoIRvyXTo3tICB19lNLJrFe0Rf7TcmqHcT8LEX9bkoYFGQlW0nYO3GGyBJkcMkUN5KLfGrF8yaviNUdTqZeKTMKg3YWDMoNHKJsUfx5zGQYSGXS6D0OQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(136003)(346002)(396003)(376002)(451199024)(1800799009)(186009)(26005)(6512007)(38100700002)(316002)(41300700001)(82960400001)(4326008)(7406005)(7416002)(2906002)(31696002)(2616005)(86362001)(36756003)(8676002)(44832011)(5660300002)(8936002)(6666004)(6506007)(6486002)(66476007)(66556008)(53546011)(478600001)(66946007)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZXR0NkdOb1Q0ekpRN0doVVJZZHk2VzhCNGVUdGpDV2JYYlhFdUFlOExmbGly?=
 =?utf-8?B?a0t2UFIrbkx2MHlTOEpUbkpickI0VmdwYkwzc2tobTNYU1NoMEtZb2o3Y0h0?=
 =?utf-8?B?clZ4cEJ4WDRrZHBmYm9HYTBhMGcxR255ZmY2THVrbjhhbmhnekllL2RHMUFC?=
 =?utf-8?B?amNIWmVxTTIwaE1CN09ya09MTmlVL0lsV09EdGJ5UDBmVWUxRmVCZ1RqMUxl?=
 =?utf-8?B?YTJ3djM0eTBOdFBxNDVqNzFwSlVCT0J3M2JWMjJmR01GcnhManJseDAzZGMx?=
 =?utf-8?B?ZUZ4OTAweGpCWG5hZWlRNFFYbWxrNGxUTGJYeDRQL2ROSXBRR2tlTUR6MTZR?=
 =?utf-8?B?ajA3SjNzdC9WWDRMekF3MWZrWnZZZGg2eUw2Tm16aTdMN1VQSHlZRlJnUjla?=
 =?utf-8?B?bDNsbXI4cnBUeURlU0N6RnE4OUZwelFQeGQyR0s1Szk0aFVmc1l4Yk5SUXBi?=
 =?utf-8?B?SlFteHQvakZ1c1JTN1lMcmM0ak5iK3hEbVRqNjVGNFJ5TWRHTkdBdmVJWXVP?=
 =?utf-8?B?dHM1NkRMTVRYRFJXQStVU0FVK0VRQUw0OFJWTGNyWWt0NE5WNWhPN1d5Mkxw?=
 =?utf-8?B?d2hmdmZBWEJWc1pjNGpWWFlqK0pPTHEwaS9nTW14b1Z5V20rRTJvT3JWR0Qv?=
 =?utf-8?B?bVYxbjNLMVFHck5Nb0JzekhvQ1VkdVREc0t5N0hzUEVHSHdtYnZ3RytQVTBu?=
 =?utf-8?B?bnl3L2MwbVFiQTdNY2FYWmlyMk4wN2RLazhMT3RkNWlNd2lmQjRneE4wZjlk?=
 =?utf-8?B?bE5tWCtJZW9tSDV3QXJ2ZGhNZGtpQ3ViOW5pSmRWeFZCbSt3N1dZZmM3bVMr?=
 =?utf-8?B?eFM0Ty9Pc1lTaUg4aFFYWXpLTzFPTVdocklnTjlibWRSWkxXOGtLUjd4cUN6?=
 =?utf-8?B?MGMwMkhHeTN5TWowQnZSaFd0aUREejZOMnMxK3h0YUNBQmFtd21Yb3JtbDhV?=
 =?utf-8?B?MFREMFdsQnNiNjZveFNpbEtXZzF0eGdzMUlEVkJNcVNTak5MaU1KRWZJNk92?=
 =?utf-8?B?NUVSaHNrcTRXR0t1Mm1DZXFDSE1RNWQ0MlAyNTZTdWs5Zm94aWhIUWV6dFpG?=
 =?utf-8?B?M0V2dGVsWWlYMXJlOTBkekVnNGdUeUVUOE5YaGtaeFRpd2hDYnl6c21UUjdt?=
 =?utf-8?B?NEN5MmxhdFFYeDFwdUZDUXFCNkRkVnVQLzdwbk54NWZZU0swamtPV3BQWEpV?=
 =?utf-8?B?QmFtSjZjeEFJalI5akwzU1ZlRjZlYXBYdjdETlpWaEkyNTZVRFJ4S0MvRUs5?=
 =?utf-8?B?cDN6MUdMcEtnQXlTTzVnY0x6bkpZb3dqUmRLSzZJKzdjWFR3aWRjNEZ3RThO?=
 =?utf-8?B?aW1GRzQzQWNCeGNySWFGWWsxekZCVEdlWEl3STlkUktXR3o0dDE5RmhGRTB0?=
 =?utf-8?B?ckJNSThiVTNTUlU2MzhreENmdTg5OGRnVk92OVFhUWpnZkt5ZlVGT2pLeGdp?=
 =?utf-8?B?UlpmVXdBbHFSTG5ibTB3K2FYMlErblU4NllzV2NFejNnVDd2S3J4SGZFUTZN?=
 =?utf-8?B?M2ZTeXpONmZ5Wno2UXhhcmJwQmpTdWNjeG5EVVY5VVdOZUtGK1Z1WnVRN2FR?=
 =?utf-8?B?VzhlOG8rOUJBMng4TmQyV2hHbDMrdWpYcEVFMm1qRWYyZjRhbTVjZVN3aC96?=
 =?utf-8?B?NnFEZUQ0a2lERHVaOGtBUnpxSE9BMDNzaE9UZ1U4aWZ5V05rSU5KWnA3R0ZR?=
 =?utf-8?B?OWw3UTVSOTBIQ3AwMk9CNGZVQ2d4bTBTOVUxdUc0VzA1b3kxd3pwKy9DYmp0?=
 =?utf-8?B?Zm0vN3dGdmtZdWV1YzhSa2NReERkMitvd1FSdkNZU3BGdWRWRjU1d3FLSmFs?=
 =?utf-8?B?Y2VCeVNsbWkySjI3a253RXJnVUk4L1gwU0p4d04zeEcrY0RTeTZ0NGlWWTJk?=
 =?utf-8?B?dlN5cVNaS3ZUTTYyZDQrOFI3SzJ1N1pVNmw2ZUE3VmdkUTZidjFySGFScXBW?=
 =?utf-8?B?TUZhQk1DQXByTVpnajREaTVMWkNNdWhLNVYzbjFZNkFGTVhNTm54UVVZV1VJ?=
 =?utf-8?B?VHhMazMrOGVzUDIxbXIxdXpLUll0b0lYWXdsaTQxNFptU1NBbFQrdXRwVVJl?=
 =?utf-8?B?em1abnp1RFNMemVZazZFWitxQXdLWDR5Q1RRb2JkemlRbXRyK0JXWjQ4a1Jy?=
 =?utf-8?B?QzV6MFArbjF6dFVWWVd1WWJTWFRhUExvVHpmNng3NGhkREplU1pJbzZYMUhD?=
 =?utf-8?B?SHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ec9c3e2-751c-4638-db19-08dba8cbfc7e
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2023 20:10:27.3467
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xPIS7ccweSDGVCMnF2kzfZ/HRXbn1siSHylr+p1oQYIDJt++4YfFcaVaSdRZQWgYwaGfgGQ52BM8K+KnZIL0ejLUtvzjlzg8qJxJLDPac8o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8081
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Babu,

On 8/21/2023 4:30 PM, Babu Moger wrote:
>  static int rdt_enable_ctx(struct rdt_fs_context *ctx)
>  {
>  	int ret = 0;
>  
> -	if (ctx->enable_cdpl2)
> +	if (ctx->enable_cdpl2) {
>  		ret = resctrl_arch_set_cdp_enabled(RDT_RESOURCE_L2, true);
> +		if (ret)
> +			goto out_done;
> +	}
>  
> -	if (!ret && ctx->enable_cdpl3)
> +	if (ctx->enable_cdpl3) {
>  		ret = resctrl_arch_set_cdp_enabled(RDT_RESOURCE_L3, true);
> +		if (ret)
> +			goto out_cdpl2;
> +	}
>  
> -	if (!ret && ctx->enable_mba_mbps)
> +	if (ctx->enable_mba_mbps) {
>  		ret = set_mba_sc(true);
> +		if (ret)
> +			goto out_cdpl3;

An error may be encountered here without CDP ever enabled or just
enabled for L2 or L3. I think that the error unwinding should
take care to not unwind an action that was not done. Considering
the information available I think checking either ctx->enable_...
or the checks used in rdt_disable_ctx() would be ok but for consistency
the resctrl_arch_get_cdp_enabled() checks may be most appropriate.

> +	}
> +
> +	return 0;
>  
> +out_cdpl3:

So here I think there should be a check. 
	if (resctrl_arch_get_cdp_enabled(RDT_RESOURCE_L3))

> +	resctrl_arch_set_cdp_enabled(RDT_RESOURCE_L3, false);
> +out_cdpl2:

... and here a check:
	if (resctrl_arch_get_cdp_enabled(RDT_RESOURCE_L2))

> +	resctrl_arch_set_cdp_enabled(RDT_RESOURCE_L2, false);
> +out_done:
>  	return ret;
>  }
>  

Reinette
