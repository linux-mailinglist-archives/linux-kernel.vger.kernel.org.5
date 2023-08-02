Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51F4876CD96
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 14:52:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232288AbjHBMwm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 08:52:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234772AbjHBMwX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 08:52:23 -0400
Received: from mgamail.intel.com (unknown [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 241633C17
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 05:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690980724; x=1722516724;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=Bgxl+8g548Ai2ZIlTxdcJ+1PUDVkN1OmzzK5MHg8Tu4=;
  b=XxWpozIN4U61EahfY19wlwz7+enjl/DHo+ez9YI+pJwE1CoFbfOSuCkp
   /TPh9qsIhJkdQY06AAfSyuCk/A4YrlmfpFXmumrO3o57jOBpEsmvaIUYe
   Wo7+qgfgYM/N3Brr1FUjVpQpx+6CGRoP6LLMeqJhTwajj/9CJDtEqkELl
   Dw6/3KdwRIuVpCyxeSkVq38w66ZGuheQFeb8WfeXbRaMV+S8EXRilqEhy
   qyFiSD/dcX9s05Iom0DJRTx65cmlLGbvhyPUYw3Lp1QNbLE7432CzAt46
   S2HdyTW4gcv7jQowULg8ap6Fs+0vAazUn00e2VYea7NwVil213r83VJDT
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="373215068"
X-IronPort-AV: E=Sophos;i="6.01,249,1684825200"; 
   d="scan'208";a="373215068"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2023 05:50:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="764211221"
X-IronPort-AV: E=Sophos;i="6.01,249,1684825200"; 
   d="scan'208";a="764211221"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga001.jf.intel.com with ESMTP; 02 Aug 2023 05:50:49 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 2 Aug 2023 05:50:48 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 2 Aug 2023 05:50:48 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 2 Aug 2023 05:50:48 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 2 Aug 2023 05:50:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lXNp1mk6YY9RYwdA/L9+YMJehHQvpjQxPBHB2rmoKHSfkEc/+4kIZuXjWunOwEEfpE/VyZjcXgX+oAAos6+jjBFuXEaHhuz/qajev3gixcxKniOxxChlNEp0ita+qtyljW5Fyca/1aliuV3D/56qsDohtZ0o6/SUrfk2NFJ/l0Mv7wpfk2Cv00Hpq03uPpK/s+ZfxhUxdEetl5Qch5gfK/bTDhhUI3xy8IZtbHu4dBzU1D7D5KSXgts4pnNMwxVqPTkIgLBKbAgEe4QxzD8eg3gglaQcUFlJYyD6+QwuWm8JCq5lqhnpiZI1zASg4+Twyv/S8XlKUNkxOGecsXuggA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=15EYqmk9+z2dMCBTvYkoF5Dl3bu4e3qhVgK+NqNBZRY=;
 b=YJ5V/zVxLVLJxmzIVqkJRLPcb3yU8kYPik5ZDmeMVeEdxmn3HM4vocChCudeeQzhLmYc4Hv3ICbm7TMTe1iIZmGA4G8vRx4Ob9HwVeQh7AhS4C8078oaONXQvIA1af7rQpdb6owsSxVba2NBv0t0kJzEWAj2zyHaOojXOn8yUw6ctrh32pCh6lWIYydYDNwqX39hRwiJL95igbhwGAPSvmMpRN3LT43+T4ckL7X+ZquTVRZM/YitypL7waGpz8vS6bYTGKc/ww2pr6pkV7GRvGtpQIMp2H2QdgA6ED3VWizf43pr7b4JRhPJLSe3JOAzj75yWKF2k6OoISwCeDwBQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by SN7PR11MB8065.namprd11.prod.outlook.com (2603:10b6:806:2de::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45; Wed, 2 Aug
 2023 12:50:46 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::221b:d422:710b:c9e6]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::221b:d422:710b:c9e6%3]) with mapi id 15.20.6631.045; Wed, 2 Aug 2023
 12:50:46 +0000
Message-ID: <eb50a427-3738-c1bb-b8cd-8636902deffb@intel.com>
Date:   Wed, 2 Aug 2023 20:50:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [PATCH 1/3] mm: add functions folio_in_range() and
 folio_within_vma()
Content-Language: en-US
To:     Ryan Roberts <ryan.roberts@arm.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <akpm@linux-foundation.org>,
        <yuzhao@google.com>, <willy@infradead.org>, <david@redhat.com>,
        <shy828301@gmail.com>, <hughd@google.com>
References: <20230728070929.2487065-1-fengwei.yin@intel.com>
 <20230728070929.2487065-2-fengwei.yin@intel.com>
 <55c9e3f7-099d-6f57-32da-1f318a9688a0@arm.com>
From:   "Yin, Fengwei" <fengwei.yin@intel.com>
In-Reply-To: <55c9e3f7-099d-6f57-32da-1f318a9688a0@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR01CA0185.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::19) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|SN7PR11MB8065:EE_
X-MS-Office365-Filtering-Correlation-Id: 504d8433-35f2-4c48-5e5c-08db935716f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ztWGto1fpcpSwBauZw356mI2tH9tiE+HthwBmws+gZld3oWk6WXzkcR/lrkkfOzcYOCF4p90N6tUBuDU1A/F55fxKcdjekBfPGXaLF5HdU6ojUcSzi2kyz/G18zn0gAV4c+hdKdgXOdibyJoOFyIYUva8lr8czSVCS1HKHDcYljAjGgsYiwK2rJFiEbibUGAAuyqJjhwNWDW9j9UQ8WGNNwfZrG71Na0oHdqUaYl4+Qz8Yzm5nLQ8Rjrn/zBvLiEiOzecuTs0vY0OtSJ9qefwVYU0CTNg8i6KtYSHe1X5+IYkSa2xiO7fq9tz3MEqTm25K+2Ng2jrXF0NlFg+gqpVZyWILiu38AJocmJJLb8E0O7lICS61rHPHvUxKWKAoGVNybkCSgfWnTkMRukGgO599sqlCzCPJCMH1zWS99GVDS4ChY04T0YOgp8863qkqhBc38RbFiFy0ED0Zf3+3Fj/dPygPJdyw1kn+Rxl4AQljyEVEgU9cmx0GzalRgJ0C8umOnXBjD8sOqzOvBq2Gun+efeopypNXgqwvUe6RrEKV/B95XXuiv5gEc2yxwrP6veyFPuRveB+hMSa1Y9WqRXvHgbTn5a8uGPHyWUswTLqLsZJebJ+fDbXK5XQvcyB/+n8SrVLPkevBFx0jKtScnHLQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(396003)(136003)(366004)(376002)(39860400002)(451199021)(8676002)(8936002)(5660300002)(26005)(41300700001)(2906002)(31686004)(83380400001)(186003)(2616005)(478600001)(38100700002)(316002)(86362001)(53546011)(6506007)(6486002)(66946007)(66556008)(6666004)(66476007)(82960400001)(31696002)(6512007)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ak5XWTZyaXFPekVKV21WWVMwa3VoZXhZd0pnNmdHSjZOS0prazJtL3lZMTBG?=
 =?utf-8?B?KzlialZUbzc2Z21pM1ZJb0NSblVBTEp5aTRvMTkwbVVkRzJqdXovSXdETlFI?=
 =?utf-8?B?ZHdyalc4a1ZZWjgveG9tOTJHajJJSk1WOUJyVW5hZ3ZmUVRaZVlqaWRWOXZO?=
 =?utf-8?B?d1dCamRSZDVQV2FQSHlpVHlPZFhSYTY0eXd3eVpuWVhvU3BhMlhHZHVvNmww?=
 =?utf-8?B?L0pvNTJERVhnY0J0RGdRWmdqY3ZnQmFTZlpYVG0xcUgzcDRJSDhRWEVDUFNv?=
 =?utf-8?B?bTVqdmh0ejBzWU9nY1JLc0JzaTM3WnlIY0JVc2dTeGFLYkhFaFhXblRPQUZN?=
 =?utf-8?B?dEdIYXN1SVRMSUh5bDdXRDdjdHJGLzFrR05jQzBBVGEvOWNNMHNjSEZVb1dB?=
 =?utf-8?B?Tm1KWGdZdE1rUURmOGFKcTBrczFSUC9XOFJPUHhCWWl5NlRKYmxFSzFLNlZM?=
 =?utf-8?B?b0xwSWZCc2F3ZThUUWk3akNTa1dVWmFKWXpGV1UyTUlTWlZ0TjNJZkM1d05u?=
 =?utf-8?B?QjBIZlFTTU1Eb0k5Snpib3pUOWlHTzJMN1F2ZVpoT0FPd21vVjdWdjRURWpO?=
 =?utf-8?B?RDFJTXVKSkUzV0hWUXhUVDd5dWFLTkxYenhnTUI0R0hzR0tkSENRSHBBSUZ1?=
 =?utf-8?B?c3VDOC9mWWlTOE96aUV6dGNlRnNZQ1NvQW14YmNocGVWU05zZjJoNzZHRnM1?=
 =?utf-8?B?dkllWEVETk45TG1Kd2YzQkpNUDl1TElFVXVnVExTeHdqVVNOL290dXpaa1FE?=
 =?utf-8?B?cWdSZGwybzRqcFdnekhyRXpCa1dsbXZac2JDYkVqQXRhUzFJbnNnNTczY2ll?=
 =?utf-8?B?b1VBcUF4eVYzRStNVnJhY09CVVZsTCtPK3FWMHZRYmlMaTZ1aFVjSEpxSWc1?=
 =?utf-8?B?Mkh4NHNITEVvdUhldmMrZkhEbmorY2JmWmpSYzBBSGdSSTZ3NzZuc1FpRUlO?=
 =?utf-8?B?a3J3RUpzOUNhNWFlZExpeDNQWlhjcCtOVE5HVm1rdDljRU1yak9qTnBaUmZl?=
 =?utf-8?B?aXRkaWd4ckJKWDNGYktRdWtSNysxbmJJL2ROWXJiNGpYanBWQUQ5SVlBdkty?=
 =?utf-8?B?MkF6OUJobWhRby94NzZlVDhmYXNDU2U2QjFDSjV3aHJRVHRHYStkWkNoL1Ru?=
 =?utf-8?B?bmRLVDlraWlPbTdRT0xFVHlHSGNEWk9maG1TaFhuZ3pCQ2Z1RTF3aTJnWHcx?=
 =?utf-8?B?Z0NCUVFMOWk3TDlxT0hXUC9XaVlGZktuK3JOd2JNTkZ1LzZPSHZaSy8rOXVk?=
 =?utf-8?B?RzJ6TE5DVHdObC96ajVaa3F3V2UyeEpFNTlLaW5iR1YxRTd5bEFHcVM4U25R?=
 =?utf-8?B?M0NidlB0eWtqNkRCUGZxVXR4eVR5QzR3bjFHL2RLdGFwa3hQOERKT0hlSkVG?=
 =?utf-8?B?MFpyTXpBQkJRY2xnZDZJdjVPU2VsYkFZK05vQXRtQ2VZVWRDdGFhUWNVY3ZY?=
 =?utf-8?B?eVZmN3VEelc3VDRMdU1odW9uOWpHMmROTW16dFN0UCtFVUtIVnVKWm1FeVNw?=
 =?utf-8?B?akpGTnZNSnFCdWxxZm5JQlBxVHJXd1FINS9uOEhTdUlUd1FaQ1JSQVN3Zko1?=
 =?utf-8?B?QzlseFlEYXd1K1R4SHBvYkdhRWNzb2tzb0ZWajdkQnNjTlVmQlo5R3NNUzlH?=
 =?utf-8?B?QzJZdkVJZDdIZk9CV25oYnZHVXVDaDUwQkFVQTN3eHB0M0REd09NVUVuREtE?=
 =?utf-8?B?TWNaL1hhSE9hMWVydFpIeDB4bTJCZUR0VlhsZXgzUGxPWnhnSUZkeGcvUlZC?=
 =?utf-8?B?bWNFMkNlL2VBbEkrVXE3K3djSVRXVkt4TGV3ZUlYODBNTFVlRy96QkhyR29v?=
 =?utf-8?B?b3FjOXVFb2VRSk9LaXZDejlFYkZkQndjMG9sRWI3akRkNnZXWTVxYWFtSnhk?=
 =?utf-8?B?ODlLYy8xNVl6Y3hlNWdDRWdUMnhDYUpnVjg1ZkJQOUdocnVNd1JldkpSWlBS?=
 =?utf-8?B?emN3eklDOGN3dHlPNGpKS2s2a3RiWVJqakViYVhvZ0tZUW5Lcldadjg3clBj?=
 =?utf-8?B?WGFVZEhVVVUwaGJ0dmIrTW9EaVlIVS90anZmeDdPSUVrUTF1Vy96aEhjUkpH?=
 =?utf-8?B?S2x2S3F3ZE15ek52WTJPNVNUdkcwL2ZxaE1uMk9DN2ZoYm5RTDB0SmJ3a3lm?=
 =?utf-8?Q?uu8n23o9WeWyJA/0+GSWyjzhO?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 504d8433-35f2-4c48-5e5c-08db935716f9
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2023 12:50:46.2400
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Oc1nPNapNMrM+LGkGNS8a4ag0tgjWdvOa+1plyCSYM35uZbOXFfWR7hH+D30O4SB6HRmlSKuGIemLK9N148y1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB8065
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/2/2023 7:14 PM, Ryan Roberts wrote:
> On 28/07/2023 08:09, Yin Fengwei wrote:
>> It will be used to check whether the folio is mapped to specific
>> VMA and whether the mapping address of folio is in the range.
>>
>> Also a helper function folio_within_vma() to check whether folio
>> is in the range of vma based on folio_in_range().
>>
>> Signed-off-by: Yin Fengwei <fengwei.yin@intel.com>
>> ---
>>  mm/internal.h | 69 +++++++++++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 69 insertions(+)
>>
>> diff --git a/mm/internal.h b/mm/internal.h
>> index 5a03bc4782a2..63de32154a48 100644
>> --- a/mm/internal.h
>> +++ b/mm/internal.h
>> @@ -585,6 +585,75 @@ extern long faultin_vma_page_range(struct vm_area_struct *vma,
>>  				   bool write, int *locked);
>>  extern bool mlock_future_ok(struct mm_struct *mm, unsigned long flags,
>>  			       unsigned long bytes);
>> +
>> +/*
>> + * Check whether the folio is in specific range
>> + *
>> + * First, check whether the folio is in the range of vma.
>> + * Then, check whether the folio is mapped to the range of [start, end].
>> + * In the end, check whether the folio is fully mapped to the range.
>> + *
>> + * @pte page table pointer will be checked whether the large folio
>> + *      is fully mapped to. Currently, if mremap in the middle of
>> + *      large folio, the large folio could be mapped to to different
>> + *      VMA and address check can't identify this situation.
>> + */
>> +static inline bool
>> +folio_in_range(struct folio *folio, struct vm_area_struct *vma,
>> +		unsigned long start, unsigned long end, pte_t *pte)
> 
> This api seems a bit redundant to me. Wouldn't it be better to remove the vma
> parameter and instead fix up the start/end addresses in folio_within_vma()?
My understanding is it's necessary. As for madvise, we need to check whether
the folio is both in the range of VMA and also in the range of [start, end).

> 
>> +{
>> +	pte_t ptent;
>> +	unsigned long i, nr = folio_nr_pages(folio);
>> +	pgoff_t pgoff, addr;
>> +	unsigned long vma_pglen = (vma->vm_end - vma->vm_start) >> PAGE_SHIFT;
>> +
>> +	VM_WARN_ON_FOLIO(folio_test_ksm(folio), folio);
>> +
>> +	if (start < vma->vm_start)
>> +		start = vma->vm_start;
>> +	if (end > vma->vm_end)
>> +		end = vma->vm_end;
>> +
>> +	pgoff = folio_pgoff(folio);
>> +	/* if folio start address is not in vma range */
>> +	if (pgoff < vma->vm_pgoff || pgoff > vma->vm_pgoff + vma_pglen)
>> +		return false;
>> +
>> +	addr = vma->vm_start + ((pgoff - vma->vm_pgoff) << PAGE_SHIFT);
>> +	if (addr < start || end - addr < folio_size(folio))
>> +		return false;
>> +
>> +	/* not necessary to check pte for none large folio */
>> +	if (!folio_test_large(folio))
>> +		return true;
>> +
>> +	if (!pte)
>> +		return false;
>> +
>> +	/* check whether parameter pte is associated with folio */
>> +	ptent = ptep_get(pte);
>> +	if (pte_none(ptent) || !pte_present(ptent) ||
>> +			pte_pfn(ptent) - folio_pfn(folio) >= nr)
>> +		return false;
>> +
>> +	pte -= pte_pfn(ptent) - folio_pfn(folio);
>> +	for (i = 0; i < nr; i++, pte++) {
>> +		ptent = ptep_get(pte);
>> +
>> +		if (pte_none(ptent) || !pte_present(ptent) ||
>> +				pte_pfn(ptent) - folio_pfn(folio) >= nr)
>> +			return false;
>> +	}
> 
> I don't think I see anything to ensure you don't wander off the end (or start)
> of the pgtable? If the folio is mremapped so that it straddles multiple tables
> (or is bigger than a single table?) then I think pte can become invalid? Perhaps
> you intended start/end to always be within the same pgtable, but that is not
> guarranteed in the case that folio_within_vma() is making the call.
If pte is invalid for any reason (pass wrong parameter, not fully mapped etc), this
function just return false in page table entry check phase.

> 
> Also I want to check that this function is definitely always called under the
> PTL for the table that pte belongs to?
Yes. I should spell it out. Thanks.


Regards
Yin, Fengwei

> 
>> +
>> +	return true;
>> +}
>> +
>> +static inline bool
>> +folio_within_vma(struct folio *folio, struct vm_area_struct *vma, pte_t *pte)
>> +{
>> +	return folio_in_range(folio, vma, vma->vm_start, vma->vm_end, pte);
>> +}
>> +
>>  /*
>>   * mlock_vma_folio() and munlock_vma_folio():
>>   * should be called with vma's mmap_lock held for read or write,
> 
