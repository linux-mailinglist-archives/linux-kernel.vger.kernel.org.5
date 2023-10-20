Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C14947D0740
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 06:05:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376257AbjJTEEU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 00:04:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233460AbjJTEET (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 00:04:19 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 692E0C9
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 21:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697774657; x=1729310657;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Lwh24Up9+8pfJ7YlgFbDuxgORu3zH5dTFneptebspCA=;
  b=Wi9Yu3rCTJHgv4WBqKJYg5FLdbE0ejQ0fDSbwz/vSf2G7420J13Kn2tm
   +tu2dchB6t8/fXP/twcmipdc+PxENB+fr7GcmkJC3fORuOGUzzhTIasAA
   95HIwGiYTr9yHnYqO4SVYfcAub9J85xw6daeV1y9jlN3e55hivSMegl9x
   05Em7PEXwp26rvfsfVdd8ezpxdGtM6Ulp/o+zVAuILzXc9kP7dk9NhL4S
   EyDybrEA0l5Y07po8WKQDhuZMxkDs100hEgMoefc2Hf/l4kokAklNyUs2
   uttkzpeJhcaVXke068RxacG/r9FimYhWWbK2bMY6Crnt6uypi5Dsr20nG
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="371496277"
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="371496277"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2023 21:04:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="4984451"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Oct 2023 21:03:06 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 19 Oct 2023 21:04:16 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 19 Oct 2023 21:04:15 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 19 Oct 2023 21:04:15 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.41) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 19 Oct 2023 21:04:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RfTKaUOcPc2D19rHP7A5dFf4Lej0bYTibDj/DU3F2UBvCaY9lPmFM8FqWi9wmfmMdYjRZoy5iW9x7fgr4sdmkERNKmuWZEJeh1e9TWlgtm8G/8o1dlFGb/ghKk0b4U98mjZ9bzYnsEToe9VaZs8vqLAVy9FH/qMQwPT75oAemePux8zsB/2K1BAIWbxWr4fD7MdlT3gso5pTEsljM/lpnfASGgIZRTBjOsAvCMzHopElbpgACGmuabY4+swyTKAKLgMK5mFnryi8QW7xnbZSs34nAEfDOTOENVoJzbEBfs9ial0U/FMU0y5oNSrW0cvGXuQzA1LGR7Hi1d+BfLzZPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yo3oVEXdORNo/v5seFSBBvU84YhEXnmRDPedhIqB1cs=;
 b=J8LJMTfD6+uk0Si/2Ywd5C40doohUKFKabkTORh/oVBuK2j5at3cmFUSA/fEIyVcNMC1GW8VkhA5w8h+QjwQslNIGHVQEHIM1j09VgE7lgo9CCIMDKRsfdfz61neHftaBqNl665lMlO8sV8ASrwo0BfDtues98GyuLwo7PEsxtRIwL01uK+njSGnM1jXOAIP0unYIIjYgi/2UEK5bG2gGi85KGsef7SLR7iaKdM3i/hyq32hBOVyc04AqdnktIJfdch6h1np6zpXvb0tzXEVUFmGpan68MfHCcnpGscqudu51OsyIbuO/ApFbvZ5KzEuUykhSxWQI44bMV80d55ySA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by PH8PR11MB7968.namprd11.prod.outlook.com (2603:10b6:510:25f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.21; Fri, 20 Oct
 2023 04:04:13 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::d108:2976:a361:da49]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::d108:2976:a361:da49%6]) with mapi id 15.20.6907.022; Fri, 20 Oct 2023
 04:04:13 +0000
Message-ID: <3a14bd9e-0b90-4a89-90b3-4e571ab1a51d@intel.com>
Date:   Fri, 20 Oct 2023 12:04:07 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: migrate: record the mlocked page status to remove
 unnecessary lru drain
Content-Language: en-US
To:     Yosry Ahmed <yosryahmed@google.com>
CC:     Baolin Wang <baolin.wang@linux.alibaba.com>,
        "Huang, Ying" <ying.huang@intel.com>, Zi Yan <ziy@nvidia.com>,
        <akpm@linux-foundation.org>, <mgorman@techsingularity.net>,
        <hughd@google.com>, <vbabka@suse.cz>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
References: <64899ad0bb78cde88b52abed1a5a5abbc9919998.1697632761.git.baolin.wang@linux.alibaba.com>
 <1F80D8DA-8BB5-4C7E-BC2F-030BF52931F7@nvidia.com>
 <87il73uos1.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <2ad721be-b81e-d279-0055-f995a8cfe180@linux.alibaba.com>
 <27f40fc2-806a-52a9-3697-4ed9cd7081d4@intel.com>
 <e8099116-6f78-cb4a-5036-1d7e38b63e52@linux.alibaba.com>
 <fd389af5-d949-43dc-9a35-d53112fe4a60@intel.com>
 <05d596f3-c59c-76c3-495e-09f8573cf438@linux.alibaba.com>
 <b9042fcb-05df-460f-87b8-4d7a04d3bd5e@intel.com>
 <e84f8c2d-6264-f2a3-3737-17d48a0251f8@linux.alibaba.com>
 <93abbbfb-27fb-4f65-883c-a6aa38c61fa0@intel.com>
 <0aaf6bf4-a327-9582-569e-2a634ce74af4@linux.alibaba.com>
 <CAJD7tkbA0Ofvw8wQM0017DKWC3SXOT71rCnUhGkoPgQ4wOfLOA@mail.gmail.com>
 <fb225c52-0d46-4a67-a897-f39b5c1b5554@intel.com>
 <CAJD7tkYNLERnUKLu_Jsr7YAxqWNmJk7AXvOFRGSxN=1k+uq=UQ@mail.gmail.com>
From:   "Yin, Fengwei" <fengwei.yin@intel.com>
In-Reply-To: <CAJD7tkYNLERnUKLu_Jsr7YAxqWNmJk7AXvOFRGSxN=1k+uq=UQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR01CA0198.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::7) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|PH8PR11MB7968:EE_
X-MS-Office365-Filtering-Correlation-Id: 129ef9e9-d25e-44aa-93ed-08dbd1219f0d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Qr4dlbhLSUXQU+eh0qnFoaJ/cTc5n1BSHE1JA0ZtzqTLndO1d2SzdV3ug/5C/FLEdslSZWCkHq7+nf9iWAqfB60gSG+6m7VXykRW10OFfrpfl9TA26M/ZDkRfgBdpLzBGHFJ+IvNXSU56M7DjCR8OA9EWQWaPrAZq1fFOYpm6p6Kjv7vUjJNayWwqz5adLFJacPIcwS4Y2aQk+LhcKRKxStAwc9Xt5Uu7q/qMqAy1Jo7V8H1VlKm1MP7R9ocuxVqLN8ndsDVNIVA6E00HGrhOv2vQ9bQ0R5P0Pp/mpWVdp20D/XMIxscMjHAOlQUrtgJt0PYGmDMyKfyopui6jSjuOxQ/ppMRyXPB92Mqy0hVClnDbRnpW6UUMy8y4Me5A24zOlqdJv45DiIQ0iasNCogx5Agut2J356ykM3fMFTz18GjyAG9xRKzJkMqxlC440JnDkjDcBgFm/xHKsi++dSdGyVxMXjXTd1COMH1vL8EJhA19BwVZ3eFZbICXXH2zhNC4VcUsXkreSz9CE+3hrpdaAN7u2qXttEhw2asjEwAEqYn//iVpd1Fai5dlqJO8afbt0WC03mnhQZu0OaPFc5hR/kuYMzLgn+QKqWRpZ4Ph58YOj1D1UGpShza78b2qMUBIL6sEL8Au8OTGrbvMsRXHu7sqRwOYYVs1+5BCUE69lgP0u33B40rX0Dfpzlq+No
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(366004)(346002)(136003)(376002)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(2906002)(6512007)(8936002)(4326008)(8676002)(5660300002)(41300700001)(6666004)(316002)(54906003)(6916009)(66556008)(66476007)(66946007)(36756003)(966005)(6486002)(478600001)(31686004)(53546011)(38100700002)(83380400001)(31696002)(2616005)(6506007)(26005)(82960400001)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aU9ob0gwalZpYkJuQVdOcVpuOUxUMi82MHpKSi9BbkswQXcyNDFLNGtaT0Zy?=
 =?utf-8?B?WXM2WjZ3Zmk0WTVpWnFqbzAwa1ZBYlF2MW5rSTBvL3VxaVVXV3J2V3RScFVh?=
 =?utf-8?B?OWd5emZTZWtwUGk2aURRUUlQZHY2RWV0a2pzMm84NnZlUFU1cnJaZVRQdXY5?=
 =?utf-8?B?SS9ySE1FczFHVWQrMk5YKytydUFKeFI1Zk5RbytveFRmRGlwM1hrMlZGWGM5?=
 =?utf-8?B?ZytKT1NqMVVMQzlYd1NFdzl1eEpScFh3dWRKVElGbXV5ckdzZElHKzBWd1dz?=
 =?utf-8?B?WkYzVzF0VVRNL2FlbDRkMDl1MkMxdnh0SnhmUzlsSVJ4U0ZiUzdZZVB3bzRP?=
 =?utf-8?B?WVg3WWVnZWV0NG0rVUZtcVM4NDYweDl0Mm5LQ0tsSEd0a0ZUdlRCaXRZYTJm?=
 =?utf-8?B?alh6dlQyaDE4RGlYaWtSVlkxektwVWJsTU44dXVmWERjR3hYNzIxamNTeGtN?=
 =?utf-8?B?WXpXb3BwQTBqaXhBclU5NGhkTCs5RDFNRGcvV2FxSmdxYXNoak44VVRJMmM3?=
 =?utf-8?B?TFJOQTVZMC9KVjY2Q2dFalp3ZHM4dkZ5VWVZcHMxRkJ6NTl4bUdYMUxmWDV0?=
 =?utf-8?B?clFVYXpHSWoySTI0MHpBNm9FNFJERmhvYkc5Y1FIV1RrZ2ZIVjZRQzUvaEVZ?=
 =?utf-8?B?MlgxaFpnZGkxKzRONDhCVG9nTThzU1lCd2RuT1laUWdWTU1VU05zMTlIdjRT?=
 =?utf-8?B?OXlLamZvUFNaY3d1VWFROXdoTXJIaHRrS2lxbnc1RXNFSWVRWFZ6SG5iMU94?=
 =?utf-8?B?d1RxbnRFTm1mSitQSFRTQVhCNEpwMTkyZlBVM0hMWWtmcDIydURnYjhvSW9u?=
 =?utf-8?B?d1NIREoxaXc5NmdHcHlYUlRwV05wdjlzVmxnb1d1K1IvSVM2ZUlkcVg0TjJI?=
 =?utf-8?B?cm9RdXJWSU1VUmVQRzMwbFhML3FDTHJFVjQ1QlNIOGMzY3hTYzkySUNhcSt0?=
 =?utf-8?B?OFY1cTl0eTQzVWZ2aEVxUk1DYXVUdUp5L1I0RTk2WVlkVE1leFBJdFkyaXhF?=
 =?utf-8?B?SFFNVHZISVpBMnRLWElxZmhPWURCQzU2MXNYcjN2Y1FzdVpxUHZYcmVuaklR?=
 =?utf-8?B?UDJIY1Q4bTlUVWpodVE3b3hXaWJNaU5pRFNYaEhqNEtEVDg5YmdiWG1zc2ov?=
 =?utf-8?B?aHBESEthUzcwTzRFZnRLcTZpL0pscUpTNUtIOXYvd2tEeDc2S1ZPeUg0c3Vm?=
 =?utf-8?B?Ui95V1VMSFRia1RXcTVwT2ltc3JYTUd6Z1NaK2wzUTVObktTVEJHK0dZL0Q2?=
 =?utf-8?B?SFJIMDFjdU5KcVhyZVlUbE9FOHNsREdvNGlLY05GQU9vbGUzaDdieGxVaEZI?=
 =?utf-8?B?UUlWOGR3bHpmSmE4ZG00WnU1bGI4NTRWNkpud3VGMTIzNEYra0RoTlR6aFdP?=
 =?utf-8?B?UnYrdFZzUmxacTR1cjJRZWZ6UjNLNmJ3Umh3TitoNm9wMFRWQ0lzMU00SVR0?=
 =?utf-8?B?aGRkMVJkeWY1YUZpaHREOHoybmRXeGhXRWFYOUVBZkczZXU5QmJlOFU3ZjRv?=
 =?utf-8?B?b3A1LzdRZTRZeitPWTlhZGJCRmFBSkh4Ulo2UnN6K2ZwTk43dFJ4VU1oWkI3?=
 =?utf-8?B?R2dFbXluSDVCK0twaTNYUGdrbkY1UGxzUFlFZEFsTEw2eWdQdVl3WWlVUGlO?=
 =?utf-8?B?U2pTK3Fkd0huZkdNOWRWTlozbkZUN2VVY1cwSFlpSWVkZXpqWnMydFRrdjJj?=
 =?utf-8?B?dHp4MzB2Ny9yUkxBTXpTbjRlSFBORGRGaExqTnRQL1ZzNk5QVnZTQ0kyK0Nl?=
 =?utf-8?B?YmlaaU5IZ1dUUHVUMmRqeDgyOWJmaEVRVVAvbGduYnlLaXdtcE50Q0hoM3NY?=
 =?utf-8?B?SDR2N29CT3lxSS91Y3BHQnBHWXVqTncyajkzdGRZQzIxWG1pUm8zSXRBVG1n?=
 =?utf-8?B?WVgzbVF2UCtFeW1IWnIxcXIyRjQyNVJ6NXlEY05WdlplZ1B3UmkvZWE0QWFS?=
 =?utf-8?B?WEI0YUNHdUZwZERPcHkwTjFOd3pTazA4RlM0bXFQNHRnTHl1Zk9HTkwzUDFT?=
 =?utf-8?B?dnc1VU0zZEN0dEdRYzVMMFNMWkNHM0F2OWhEdk92Y2NOUHE4K3gwWGg4YUoz?=
 =?utf-8?B?NlNkZWNnaVJEWHAwMVd6YzNMRUs1ck5sdURrZ3JCZnhxTTFUbExEd0JuRzZy?=
 =?utf-8?B?WFZXVVFuZW9SWW5qOFhPblJqbjZPbldia1Mva2pVd3pqOTM4bTA0M1BjMXg0?=
 =?utf-8?B?bEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 129ef9e9-d25e-44aa-93ed-08dbd1219f0d
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2023 04:04:13.8226
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xsWtNSPZlzDafCFW8nEngVbOA0nU8n+wy9uVRPsVnuG/kpraZBX48g44cZNeCF0jUfiS5PgMWKMCDefo7A4JfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7968
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/20/2023 12:02 PM, Yosry Ahmed wrote:
> On Thu, Oct 19, 2023 at 8:52 PM Yin, Fengwei <fengwei.yin@intel.com> wrote:
>>
>>
>>
>> On 10/20/2023 11:45 AM, Yosry Ahmed wrote:
>>>>>>
>>>>>> IMHO, that seems too hacky to me. I still prefer to rely on the migration process of the mlcock pages.
>>>>>
>>>>> BTW, Yosry tried to address the overlap of field lru and mlock_count:
>>>>> https://lore.kernel.org/lkml/20230618065719.1363271-1-yosryahmed@google.com/
>>>>> But the lore doesn't group all the patches.
>>>>
>>>> Thanks for the information. I'd like to review and test if this work can
>>>> continue.
>>>
>>> The motivation for this work was reviving the unevictable LRU for the
>>> memcg recharging RFC series [1]. However, that series was heavily
>>> criticized. I was not intending on following up on it.
>>>
>>> If reworking the mlock_count is beneficial for other reasons, I am
>>> happy to respin it if the work needed to make it mergeable is minimal.
>>> Otherwise, I don't think I have the time to revisit (but feel free to
>>> pick up the patches if you'd like).
>>>
>>> [1]https://lore.kernel.org/lkml/20230720070825.992023-1-yosryahmed@google.com/
>>
>> I believe reworking the mlock_count is focus here. If there is no overlap
>> between lru and mlock_count, the whole logic of lru_add_drain() can be
>> removed here.
> 
> All patches except patch 4 are for reworking the mlock_count. Once the
> mlock count is reworked, reviving the unevictable LRU is actually very
> simple and removes more code than it adds (see patch 4 below).
> 
>>
>> And I noticed the link:
>> https://lore.kernel.org/lkml/20230618065719.1363271-1-yosryahmed@google.com/
>> only has cover letter and the patches didn't grouped.
> 
> That's weird, here are the patches (in order):
> https://lore.kernel.org/lkml/20230618065744.1363948-1-yosryahmed@google.com/
> https://lore.kernel.org/lkml/20230618065756.1364399-1-yosryahmed@google.com/
> https://lore.kernel.org/lkml/20230618065809.1364900-1-yosryahmed@google.com/
> https://lore.kernel.org/lkml/20230618065816.1365301-1-yosryahmed@google.com/
> https://lore.kernel.org/lkml/20230618065824.1365750-1-yosryahmed@google.com/
Thanks a lot.

Regards
Yin, Fengwei

> 
>>
>>
>> Regards
>> Yin, Fengwei
>>
