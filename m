Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5863D7558AC
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 01:52:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230199AbjGPXwS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jul 2023 19:52:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbjGPXwQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jul 2023 19:52:16 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CCA490
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 16:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689551535; x=1721087535;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xghCNv45Nh9377PsUJobenZTvWWvdKPr0wtZt9lBruA=;
  b=HGabILDUqr2UhA0NPRBalsgPkpHeJCgiLIC9/8WWwONqWR4a2gK6Ag3I
   B1xbXS+r04VBeia0CwsiYg6gePE2eOZf7aCdptDlzaZmUi90vKEgtGfB0
   LprJQIfLfkh/AKl60bMtNBlCOkG0WK4+Bteq0OpdicsEv8CoWuszWD3+4
   3DHZ9NddPwB8ayVry0+msISfJGxfd6r5IQ56fXmqj8aK32qzXaxepfCut
   5Q77+EWeBwp+saDS87fFMR22K9AfgdMFv22xZcix4n57I0vrDsUvPU05h
   D/2RInqJcypLh3AZDciS3P/Msxh0jWz0gHAqi58y9Gin7Q4vBlhWTJRia
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10773"; a="369360371"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="369360371"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2023 16:52:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10773"; a="700312143"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="700312143"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga006.jf.intel.com with ESMTP; 16 Jul 2023 16:52:12 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Sun, 16 Jul 2023 16:52:12 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Sun, 16 Jul 2023 16:52:11 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Sun, 16 Jul 2023 16:52:11 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.109)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Sun, 16 Jul 2023 16:52:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OlQpqGaSUhBna2cd1oV+GSQR+uQxjWSVM80Djjfry2SgOTqZ94LLjywgXhhOkyBc39U3/N5XtnUpAOLRGZkWF5m8lKN599Qz+fxQRgbb9G2d9OTdakR6Ssfki8AizvFz+Ua0Ao6CKcE9kbqgHXaHBB1wCf4mxvRGJcdaX4nkZyJFzr8tVqSpwjlgyIk8nkpBIV0R0mx9bYXJr93uK627ZPVq1J3pCd7e58vzvsf4CamSEpPr55YCtQ+CkR0bvNffmVc87Zs0GPD9GwjNahNq99rFp9K85pVjjNtI3lUVIxZoDnuS6nJgZLCGrAqZp/fQ9/2RJLp7yEDujMF+ZxlGSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PPhydMz25ntfWABYkRnJOcQ+nHvdrkyZa8sUI4wGxiQ=;
 b=eEbjMwzTw1KkuagH8DcYjVVQYBfzIJfCBcDTBFYQ7JTCpjiB7Fvw4TzvXexhX+504LJ0BtzYexpWB6cNptrNDO8d8NebO8lrlpx7Mj2GBHxfpbWlZfcel85A/OX4UR6/Kr7F3Wcg7tIQYy3mS6XB3RyMJb8pihIpvJVtgPthx9rPcnAktumoktlDDZGCjGjH1zw7JUX2+J8WTYFEnTALk7fYTtu6HLP8d8bU/dauXKPB9IpKXRnI3pW58oR49tCo7qd8aMR0VvwAbk2tYgEE+lvrIT/umNUjK1j+i1stEqkzSWdAbbOPTIsyU6Iw8YBNhOHNhv0e+8agEojjRPjNEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by IA1PR11MB8099.namprd11.prod.outlook.com (2603:10b6:208:448::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Sun, 16 Jul
 2023 23:52:09 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::f4df:c85c:6300:880e]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::f4df:c85c:6300:880e%5]) with mapi id 15.20.6588.031; Sun, 16 Jul 2023
 23:52:09 +0000
Message-ID: <bbfc02f4-8d3d-bd6f-aeef-5d7bb3ff46f7@intel.com>
Date:   Mon, 17 Jul 2023 07:52:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [RFC PATCH] madvise: make madvise_cold_or_pageout_pte_range()
 support large folio
Content-Language: en-US
To:     Yu Zhao <yuzhao@google.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <akpm@linux-foundation.org>, <willy@infradead.org>,
        <david@redhat.com>, <ryan.roberts@arm.com>, <shy828301@gmail.com>
References: <20230713150558.200545-1-fengwei.yin@intel.com>
 <CAOUHufZBoV-ujMF3v60Sj4bARb5vRg7cpcRsqTiKHB4CKZc_fw@mail.gmail.com>
 <7e09d69e-50a7-04c5-0a40-065e2d6fd658@intel.com>
 <CAOUHufahGsPLm9LWpTJ75MPa6pY11rFvnoqWM7bQgVGWyWEAAw@mail.gmail.com>
From:   "Yin, Fengwei" <fengwei.yin@intel.com>
In-Reply-To: <CAOUHufahGsPLm9LWpTJ75MPa6pY11rFvnoqWM7bQgVGWyWEAAw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0004.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::12) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|IA1PR11MB8099:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ef472a8-3b88-4bff-018d-08db8657ab35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c6RKqaXREF2Plpdrrg1JpIrDCT8SwiwxDzXBpbWmq7UfAx0Qs4d49+k0PKcFX5eP6Hs07XOztatwOd1aK+AeRN4V/55H+yylPJrcghmcRwWzEbLnWZFpy2ngVYITIo/KzNLih6t8C9jRgIkvZV0cnV+jpL9KD5HukxUh3mipOfqgNkUDfF+oTzMOf6UwoIjWZp0gfyIgYvKATJ8mRATEnVgUkpsnPTLkg6iUcsRgIJu2xz3SI/EeMzm3eHwCXnx6T+X1Fe5XI0ooaZLe6bBeuaFXl0kEMFZJqnFxbcvHl9nS3VtBCwRV0tSvfIuUnBXCrlpkhf8aG2ahHtQSthVgcuNSUCGJGEStohpYCV6hnXMDMuD+BB8s0p9FY7R4nK60kvBuxB73eR5iilo7CAhdGun5vP1JRjmeSZMCu2vQkSG4RrYv3oOumadjy7QKeCyrUb6QEoSnd6szM6zcvgKywNxJ42Dz6+RMjGYi5TnMpRZmBADltfDnWVccLvlCzhpiAlZCZRTwv37QxsU3TAgxYPVuVVD+jNk/9xoUMKuZF6ECYDCKrQJg8dtKSX11d9RYSgww59mer2m4QlUfzu3TNqhRrypPLcyIgcHUbSX2cgRfRZq/vJKhqJCEcO+fHf65izFFimkDgDHJzVKG/FwtNQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(346002)(376002)(396003)(136003)(366004)(451199021)(82960400001)(31696002)(6506007)(83380400001)(38100700002)(186003)(26005)(53546011)(478600001)(6512007)(6666004)(6486002)(8676002)(41300700001)(66476007)(8936002)(2906002)(66556008)(6916009)(66946007)(4326008)(316002)(5660300002)(36756003)(2616005)(86362001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Wk1kRTE3SHlOenFPQVluQ3hDQ2ZWRmNMY1BoeTh4aXNubGNVOEJMOTFPb0V6?=
 =?utf-8?B?NG9BeU1uakYrb1dtM3NySVBrbXlpWlVRb0VCdk5lMUpXUFc1UCt4bGc5b2xh?=
 =?utf-8?B?MXFnTXJxVFl0ajFRbWhBQTM1TGRjWXV3bDFNMFNLMFh4amRoS0tBV0ZNSGR1?=
 =?utf-8?B?akxNWDlSVkJxU2IwYXI4UmthWERDc0pGbExrazczS2FRdG5yblhtWFZzMjJK?=
 =?utf-8?B?TktYZmVFYlUrSVFPUTc1dFdvS0t4YnpDZDZvc0crMGJlNWtZWjlXcDRwdFN3?=
 =?utf-8?B?Smk4dEcxanRyN1NUaVNVQnRNYm9wYXVxek9EUUp5Tmg5UVdJYVoycWk0RDVx?=
 =?utf-8?B?TDUram01U2l4dTFnKzdCb045TlBRWk14RlVzQjF3VGE0TUMxL0lMUjhDVVlX?=
 =?utf-8?B?MDNFd2JzN29yNUhMaENuOXBpUlFiaXF3aTg3TUVQMTgrM3V1V2ZMaUQzWUN3?=
 =?utf-8?B?YXdEUFprVXZUaVd0UmtqaXVIQlB2bTVpaVUxam5hTk5Hakk3OE9sWEhjZ2lu?=
 =?utf-8?B?bFNRbG4vaVBLK0s4ejZ5a2hkaFphNXVEY1VHaTBjQmZuZWQxYlFMa2JKSFk3?=
 =?utf-8?B?TzlZLzdyY0hrSmM0OVoxeUdtYWx2VWFMZUhKbDJ4NzJCZHNhZ0FaOXgvT2xP?=
 =?utf-8?B?S0YyMGplY0NyMndtTVU1T0lWTVhBSjFua1hUclp2MEN4V2UxajZIRytXUnlU?=
 =?utf-8?B?QSs1UWQ1VXd3eHNwbml1M0VPd3cvam1LVkVYaHM5a3BJaDV0RGY2YWVFTzJ5?=
 =?utf-8?B?VkRjV0RYUEZQV1dHeWZCR2RiR3NxcmhUYmRuRk5YRTh4ZVFFN2ZEV1V0L29Z?=
 =?utf-8?B?b2x6VXN0NnRWbGYzc2pjZWJPblpqQk9BV0FHS0NvZU00c3BUU01OcmJiWGly?=
 =?utf-8?B?TGU5bWllK3RLRDA1QWI3WkJ3R2VLTVhsc0I0eUt1Q3NONzB4QTk0UG5kY1Iz?=
 =?utf-8?B?R2V6NUVXbmJWcVlyWWtOYlNwSVYxQVRMdXlBaml2Rm85ZU01RnNNc2tEZDFz?=
 =?utf-8?B?bW1XMXFMc2pSODA3cWlzYldNQ3Fra2JWSnVqZENYaDNLMW9xZWVYcHlaTEV3?=
 =?utf-8?B?SVc3SUZVZWx4UThtUDQzR3FPNGt3aWY0ZEJZT2pkUmJxUmNZVTJWcEhrakpZ?=
 =?utf-8?B?bktOeXJleFQzMS9oRWNYL1pUT1lCK3VPbWhTd082NXcyVE1lWnBzT0o2bDk2?=
 =?utf-8?B?MzB3K09mVkJOaXIxTkk4Q2tkS1B1ZUprS0JqV29wbENVR1ZkejlyRHRSclVk?=
 =?utf-8?B?WFlBRUVBaVRZZDFRci9mQ2VzeGtJcVFrUWtjbjhBSTVIRVUzOFZBS0l4ZnZo?=
 =?utf-8?B?a0gvT0hUYWVkeWJPY2ROVTN3Ni9lTkJIUDRmTGNLWjFyWWwvS0c2dHJaYndH?=
 =?utf-8?B?TzZueWZKcWJreS9QRk5hbFI5VllpZ2taZWFyNUg2aDJrbTBMQWd1YWNITTBu?=
 =?utf-8?B?QmdoQU9LSUJCUzd3ZnIreFRmL0p5TzRnT01BVVAyTDlpTWxrQXlZbEwxYzVx?=
 =?utf-8?B?ZUtNWnh4SUFSSGJkUDUrME4rZkhVaXJJVmM3ajBmVlNGb01uemJudWlzNCtQ?=
 =?utf-8?B?RkZlVFpncys0R01aRnY0S1RWWDRtcmFqL0NuQlc4VXNGbHljNUNKdzAzbUZW?=
 =?utf-8?B?WVRNNW9kbjNNZXFqTjJPcE5hK3BPYVpXelJicUdyaTJSbjMxeUNMZU9OeHEy?=
 =?utf-8?B?VW1UYkIrM25hdEE1ZUc2WVFGUXBZNjErSzN5ampsQjQxOWlUWXdyZ1R3emMx?=
 =?utf-8?B?dUptOFQvM1NlRXdPK2RVYTVldWxtbkpzeTN0YjdoTitrbnlGUWhaekNmZS9R?=
 =?utf-8?B?TGtibkczOTBlZERPY2s4akxEbFErc1U1bWQrWUxPeW9zMjJ2VHlEdW9ZbUUw?=
 =?utf-8?B?akxMOFkrTlpJWFdncXdVcERSS0NwMC9VTTdPQVEzTWdqMEVVZW1MWG05TDQ2?=
 =?utf-8?B?SjhYY0hJcVhCZGFFWWFHOVpoZDk4Qjd1MWZTUitJd1RYSEZCS0MxdkJ6RDJN?=
 =?utf-8?B?SEtBUDdUcVg4czlPWW12OVg4YkYrL0VzeEo3L2JlVlJTQS9HUG9icm4veklQ?=
 =?utf-8?B?U1ZVK3kxeGZFWUxVNmxGd2Jya2U0K0Rlc01pOHNFVmJDWEtDVU9wYmhSWG9U?=
 =?utf-8?Q?lbvnWI3NVVWjWC0l4vixaNU5C?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ef472a8-3b88-4bff-018d-08db8657ab35
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2023 23:52:09.6872
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4CowzHr8npbzHcMRlviJBj8cX2Oxq5LAQEiJovhyq6Zk5BlXAlfnkwzQxHxb2dpP3Zukz/pKIwK2R4TM32hN7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8099
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/14/2023 11:41 PM, Yu Zhao wrote:
> On Thu, Jul 13, 2023 at 11:57 PM Yin, Fengwei <fengwei.yin@intel.com> wrote:
>>
>>
>>>> -               if (pageout_anon_only_filter && !folio_test_anon(folio))
>>>> +               /* Do not interfere with other mappings of this folio */
>>>> +               if (folio_mapcount(folio) != 1)
>>>>                         continue;
>>>>
>>>> -               VM_BUG_ON_FOLIO(folio_test_large(folio), folio);
>>>> -
>>>> -               if (pte_young(ptent)) {
>>>> -                       ptent = ptep_get_and_clear_full(mm, addr, pte,
>>>> -                                                       tlb->fullmm);
>>>> -                       ptent = pte_mkold(ptent);
>>>> -                       set_pte_at(mm, addr, pte, ptent);
>>>> -                       tlb_remove_tlb_entry(tlb, pte, addr);
>>>> -               }
>>>> -
>>>> -               /*
>>>> -                * We are deactivating a folio for accelerating reclaiming.
>>>> -                * VM couldn't reclaim the folio unless we clear PG_young.
>>>> -                * As a side effect, it makes confuse idle-page tracking
>>>> -                * because they will miss recent referenced history.
>>>> -                */
>>>> -               folio_clear_referenced(folio);
>>>> -               folio_test_clear_young(folio);
>>>> -               if (folio_test_active(folio))
>>>> -                       folio_set_workingset(folio);
>>>> +pageout_cold_folio:
>>>>                 if (pageout) {
>>>>                         if (folio_isolate_lru(folio)) {
>>>>                                 if (folio_test_unevictable(folio))
>>>> @@ -529,8 +542,30 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
>>>>                 arch_leave_lazy_mmu_mode();
>>>>                 pte_unmap_unlock(start_pte, ptl);
>>>>         }
>>>> -       if (pageout)
>>>> -               reclaim_pages(&folio_list);
>>>> +
>>>> +       if (pageout) {
>>>> +               LIST_HEAD(reclaim_list);
>>>> +
>>>> +               while (!list_empty(&folio_list)) {
>>>> +                       int refs;
>>>> +                       unsigned long flags;
>>>> +                       struct mem_cgroup *memcg = folio_memcg(folio);
>>>> +
>>>> +                       folio = lru_to_folio(&folio_list);
>>>> +                       list_del(&folio->lru);
>>>> +
>>>> +                       refs = folio_referenced(folio, 0, memcg, &flags);
>>>> +
>>>> +                       if ((flags & VM_LOCKED) || (refs == -1)) {
>>>> +                               folio_putback_lru(folio);
>>>> +                               continue;
>>>> +                       }
>>>> +
>>>> +                       folio_test_clear_referenced(folio);
>>>> +                       list_add(&folio->lru, &reclaim_list);
>>>> +               }
>>>> +               reclaim_pages(&reclaim_list);
>>>> +       }
>>>
>>> i overlooked the chunk above -- it's unnecessary: after we split the
>>> large folio (and splice the base folios onto the same LRU list), we
>>> continue at the position of the first base folio because of:
>>>
>>>   pte--;
>>>   addr -= PAGE_SIZE;
>>>   continue;
>>>
>>> And then we do pte_mkold(), which takes care of the A-bit.
>> This patch moves the A-bit clear out of the folio isolation loop. So
>> even the folio is split and loop restarts from the first base folio,
>> the A-bit is not cleared. A-bit is only cleared in reclaim loop.
>>
>> There is one option for A-bit clearing:
>>   - clear A-bit of base 4K page in isolation loop and leave large folio
>>     A-bit clearing to reclaim loop.
>>
>> This patch didn't use it because don't want to introduce A-bit clearing
>> in two places. But I am open about clearing base 4K page A-bit cleared in
>> isolation loop. Thanks.
> 
> Sorry but why are we trying to do multiple things in one patch that I
> assumed is supposed to simply fix madvise() for large anon folios? And
> none of those things seems to have a clear rationale behind it.
> 
> The only patch that makes sense at the moment (or the first patch of a
> series) is what I said before:
> 
> -  if (folio_mapcount(folio) != 1)
> +  if (folio_estimated_sharers(folio) != 1)
Definitely. As I replied to you, I will split the patch to two parts:
  - just bug fixing. Include the filio_mapcount() -> folio_estimated_shares().
    And using ptep_clear_flush_young_notify() to clear the young of PTEs.
  - refactor for large folio.
Let me know if this is OK. Thanks.


Regards
Yin, Fengwei

> 
> And probably clarify (preferrably in the comments above) this is an
> estimate because we think it's a better tradeoff if we do so (less
> code/overhead from checking the mapcounts of the rest of folios within
> the range).
