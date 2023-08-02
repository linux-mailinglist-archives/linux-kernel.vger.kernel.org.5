Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 671EE76CCC9
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 14:35:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234456AbjHBMfs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 08:35:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbjHBMfq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 08:35:46 -0400
Received: from mgamail.intel.com (unknown [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DF999B;
        Wed,  2 Aug 2023 05:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690979743; x=1722515743;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=6aNuxisl33I5SFzqGpgc3TsvA5S+CwvZ9JvXIRKavBs=;
  b=MCt7ow0wl0ND6dKszhzY3+kZmNzQ99sZLCLK5YMJTqkAw9ngES3XU/0z
   MGdLu3ytx5AiEMvew92XgU4doHi46hcDH9YkLIv3OycMsiUkzL62wi3VU
   zM1OO1+mZIOPPYx/g9a0pLxQwpkl5vDc7T3iQElmIz8hhRutJ7fCIH+FK
   WDSi+LBgyZrl/VCefuMSFr0xA+Tplbhn5BZjKR82EVjP32XPfy/mJ55Ib
   97XxP76S5JKK53AbH7O4R4EZzMwkVk4TkygLxYCfZyGD1RCExDe/ZWVux
   MSWqIZTIHFgWRjf1xH5wY0Ybd2iTphiIKqS/CFj2TVqNgFUIQprvUSIu6
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="433404939"
X-IronPort-AV: E=Sophos;i="6.01,249,1684825200"; 
   d="scan'208";a="433404939"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2023 05:35:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="1059803850"
X-IronPort-AV: E=Sophos;i="6.01,249,1684825200"; 
   d="scan'208";a="1059803850"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga005.fm.intel.com with ESMTP; 02 Aug 2023 05:35:42 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 2 Aug 2023 05:35:42 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 2 Aug 2023 05:35:41 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 2 Aug 2023 05:35:41 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.173)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 2 Aug 2023 05:35:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dugOnqnKPkppIGwOI6/+nLJvLPxzvIBSWW8Sig5WjUvOemQUR08n8Ls9xwPab65UM/s+2vECYN2OqvKFy5BlP6qu5drIvVHKZ1blHa8TG8UAGjuI2byUBf8yVXClxYzcNymEfkBwIAJ/e3HGp0jHfFrlFid8nXecg/I93Twk9qHgNKtHAGoNvTdeHVaGEFsOKNejNrQiqMggvNDxG63oEVnvyilMhcf5aXkZHRKf3ZIcx9U+vgqEpxymFG2IPG1UXP30AXM01G+kWcr/UoD/q8l2+WSP3Yc6ecgsi8Wmsirhc3KYrIE4UzhZ0cx7jOaYIR72j8/qRZoF9l4rbwrueg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=POXNxnpKhKGNsWz7gFGjkt4tNkOH78qrEL/5tk3dmvg=;
 b=Mf6qDXvaJH0dX9Hza5ZdUpygvs65LA4Of+SnfqkM4n0cViT4aDmT2aUfV0MaUfNoG4SsbV6m1momqJKyMRHXWIU4Wlrzk9L99KPTXvdzmJHkqRygbALQ6jEOgiZg8HArGVCQ56YBe2B/aWv6kQRSWwbczUpIE5yy+Q9hDTWDc6eGwALkkgxEdgLL4qRfwJ2LQxjzAumfSdfxVuAQLWZXpsu+2iyqqe10Qcaelwp+359VADmuCTpFVDahqTclE+mZ5WTB4SBLLg15fzW0KSBzztPMH77NEMMXWWuBJ94Nw/uo0Q21t1HZg+JJKj3P2kvPAcAigBR5PsSmnijkPkp7xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by PH0PR11MB7564.namprd11.prod.outlook.com (2603:10b6:510:288::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45; Wed, 2 Aug
 2023 12:35:31 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::221b:d422:710b:c9e6]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::221b:d422:710b:c9e6%3]) with mapi id 15.20.6631.045; Wed, 2 Aug 2023
 12:35:31 +0000
Message-ID: <56c8f4f9-b54b-b0bb-250c-ec8643accfc7@intel.com>
Date:   Wed, 2 Aug 2023 20:35:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [PATCH 0/2] don't use mapcount() to check large folio sharing
To:     Ryan Roberts <ryan.roberts@arm.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>,
        <akpm@linux-foundation.org>, <willy@infradead.org>,
        <vishal.moola@gmail.com>, <wangkefeng.wang@huawei.com>,
        <minchan@kernel.org>, <yuzhao@google.com>, <david@redhat.com>,
        <shy828301@gmail.com>
References: <20230728161356.1784568-1-fengwei.yin@intel.com>
 <3bbfde16-ced1-dca8-6a3f-da893e045bc5@arm.com>
Content-Language: en-US
From:   "Yin, Fengwei" <fengwei.yin@intel.com>
In-Reply-To: <3bbfde16-ced1-dca8-6a3f-da893e045bc5@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0053.apcprd02.prod.outlook.com
 (2603:1096:4:196::16) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|PH0PR11MB7564:EE_
X-MS-Office365-Filtering-Correlation-Id: ede8682e-5f1f-4138-bc24-08db9354f5ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GPjiPUV5z/RJSbsBNCjhysJWwZS7Fwf3Lj0Qn/Iu3bGKMGQgSqRQ/wb3I0Zll9adtGLAvARM444pOzl8KpMvIWHPhvqZDrke84Gs57++1CFas2x0kkoXQKVcQB6dxqiHmVzXz6fGeoSFMvNWFDxdvf+a9tS1CGQKT4BzDiXqjcKG3l+8HpZmi3uwLiFBoJmaClVbfohhUf00jYQ266QakFemLve9EQgyPI17yCn9q+csgIiNhvB2Bym1UeO3IHo62FuqjypkDWe9s00qG63s6/tJp5sD+E/ha+wlRjocbVrNClprYvqwXzyMSwXurFBEcTMnJA5X/wiZB5/f/I0KgS89kinQWOZYViza1bIpFbGUwtharyYTMwWqxUkGmnVP5E0ejlPqby1VWgGlsgtDAwYsDjW+uVBaPmwOItsxqtFEsTZNDpBOTifY28YbEPn7wavmujlbTiHertxp/dJ3qWJ7QCqbBHYvlDv4EyHs0i3jvvOmXlyRAuSCEZ+tfWZG/7XZppYAOYiiCQ6OlYZ8jdq/yKFouZU5IHrULDt1vO/JoCKPItSkn3s7NoUmX9JHT2ffq+2lYlgz8yXk5tyavZOi/UiArsL/1CRToVoCJ2WqJinJWWVSjH0wKXh5zheqHHQY+5U9BnQViWaAr+ci0wszzPOsgYQ0zHRP/QEVego=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(396003)(136003)(366004)(376002)(39860400002)(451199021)(5660300002)(83380400001)(36756003)(6506007)(53546011)(8676002)(8936002)(31686004)(7416002)(38100700002)(6512007)(2616005)(2906002)(66476007)(66556008)(6666004)(66946007)(82960400001)(478600001)(31696002)(6486002)(86362001)(921005)(316002)(186003)(26005)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UUxYQVUxV1pOcU5jTHBPeXQ2MjZkRjZydGowaHJiSkFCZjhrc2xLeExJRGxV?=
 =?utf-8?B?NG80M0M1NHA3ODNScGxlN0ZUWG1iUENBT2tOTUJCRXF2T2RnQjJScXhBNEd2?=
 =?utf-8?B?MGZacSt4MW1Nd3JsUDkrNHNrcXBrN0NLK2p5YTBVbzY5dms3aWZZVXRPNmk0?=
 =?utf-8?B?cWlkMzgrYmkwK0YwSXE3SzhkMHdlcDBkUjFtSGZTTmMvWk0xTTdvZFhJUWox?=
 =?utf-8?B?ZGVVaU9OdjF5dlQzaFExbG5vd2FlaUdyUy9PV3ZTWmt5ZG5KYnJPZ1RQQVd5?=
 =?utf-8?B?MVFvcWo1ZndWVDliTVgwU1pEUGJDY0d4cDBsQUx2dncyL1lZZHVSUUJVaEZL?=
 =?utf-8?B?TksrSXFhZkVTejlBTTg4UnZtcnNSbGtHQXV1Ry85a0g4TCtPSEVKYU1Ta0cr?=
 =?utf-8?B?enI3WTBmcWlQaWFqV0dMS2dJaGM5cU9abXdXM1p1TW9rcmVPMTVvR2ZVVkww?=
 =?utf-8?B?UGNSd3prdlVXU0dHeUZ6WWVsc2ZIUDllcXA3eEJzdXp4OFNwZEJaUW8xNDY3?=
 =?utf-8?B?WGJ2Ym9jYzJEZlE2MExOc0M5Y3A3TC9zOGpZY3RVelgzZkptS3Z1VVRtbmt0?=
 =?utf-8?B?TnF6UHgxcnA4Ni9qTCtBQWhyeTVBd3lFZmkxK0l1WHF1ZktzNnN4UnpyeUxt?=
 =?utf-8?B?VTI1L1UyTWdzaUltZFJtUzliK3NoZGpBandwK1pKN2NPckdYZlY2Y3BDY0xv?=
 =?utf-8?B?aGs2S0RUV09jN3N0QjlVd2hRZWtadTZvRFZpa253UVhFaG00QW1kOXhpVWlh?=
 =?utf-8?B?N0VXeUc1S3pmV0dtcjBvYytZbGUxQXZHREFyQ0QwREZZYWtTMUs2bXh1cXhD?=
 =?utf-8?B?SnlBbkJsOEJjb2thaytnZW1HUlFVSVBvOWpmb0N2cnFYK1piRWFPdmdwWFVP?=
 =?utf-8?B?V0NJOFZ2S2J5WHhpaXprTUpic0ZTYlI5N0VaMlpFTnhOT3hKaTlheVN3ZW1z?=
 =?utf-8?B?bTZMVzhNanRYUklVdHFzTmJiOWF4QmE0N0UyWnFnbEtkUlZSRHMyM1Z6K1R3?=
 =?utf-8?B?MmJ3VFQxRmVBSjN2SXJxUUFKTTRmUXFnU1hmam1FdklEVnZJOFhnYVFDV1I3?=
 =?utf-8?B?UW5PMEFhWkhkR3VsRnA3M21GdzhjTHVTeU9hRHFJNTlpWjd5WnNzY3BJRGJQ?=
 =?utf-8?B?amdwcjdxZlFoM0tRZmFxZHN0anhxK3BRdnZoYVVpU2ozb2dYMExodEdxek5T?=
 =?utf-8?B?WTYrVEpqczN3UFY1RjgvblhwTCtGRk90L3RkSTZqQ1pPcS9lZ1JLLzZGR3Mx?=
 =?utf-8?B?dlB2ZnhxOGp6dStqMk1sS1FxZ0JSaDRaVndIaGxqa1FLa25CTEhrL1orNGZK?=
 =?utf-8?B?NTNGKzhCUFVVWXVUNElBMCtQSkJCUnZuU3lmTDFHZjhST3Zmb2E4OXpzVE5N?=
 =?utf-8?B?ZHhJMDBYb0taU25PRGQraHlrVkZpZHIxUGQvcnQrQ1Zna28xL1crVmRrOWFL?=
 =?utf-8?B?N1N0bDlIQnB5S0oxd1pCMXpOSGVEQis0RkZkSzgvRml0eXdZSzJ6V2xqOGl5?=
 =?utf-8?B?Rm9WeFVyZndQa0Y1eCsxbG5xNmMxTzlRaTlFcnl4Z29wMjVhby91UW8yVGdR?=
 =?utf-8?B?d0pGWEpidnhxSGZ0czBJNXFQK1c4KzlYTFQwQnlzQ0xmUXJaREliam5tRE95?=
 =?utf-8?B?MWNRdDlONWJrRVJkNWRHQXU1YUgzMG01R2FlSEo0allSbmIzYTR5eVRtVm1U?=
 =?utf-8?B?d2dXS1haVys5NklYYnlKejB3RWttSEg5RVNSSThCZjF5OGVTeExxc3FuZHgr?=
 =?utf-8?B?aU8yK0NNbGZVb2pZbVJ5RmU1TXdsYjdFWGdrd0pIQUVJRFdUMTNvMkRleGkw?=
 =?utf-8?B?YU9WaUtrd0ZlOTJrdnJMSEg4ZWVEVnhYdFkyQ0NjeC80KzhZN05OK0d2Slh4?=
 =?utf-8?B?Z0tZV0ZiY1NOdkJFQjVWcnlNVFB5TGxGMjFuRG5RNkpEMk0zZm9heXJNV3Nz?=
 =?utf-8?B?WmZjN0w5YUlEaEliaTVoNUc1RVU0bXRpUFRBa2d4VEVMVTlIdzVHdHRhR3lU?=
 =?utf-8?B?eFpoQThYaU52ZXlYc011eFVQcTB0T0Q0OHBVeXZGN3dlUG5aYTduazhIYisy?=
 =?utf-8?B?OWVnRlpsb3VyRnRxcTYzUkt6SnkwT25hV2pGNWxtNWNscWhLYnFqYkMyTTFi?=
 =?utf-8?Q?kw61INXyfbagfHS4dclIDCgQ8?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ede8682e-5f1f-4138-bc24-08db9354f5ea
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2023 12:35:31.6946
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LhkEWCIwJ8BOtQMM3csKlpRRD3hSI2nXlc3EjQR51sT2tdHgr1qmTqQsjAklHB0Bcb0oKnU3AvJAHKoR/aMRRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7564
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



On 8/2/2023 6:27 PM, Ryan Roberts wrote:
> On 28/07/2023 17:13, Yin Fengwei wrote:
>> In madvise_cold_or_pageout_pte_range() and madvise_free_pte_range(),
>> folio_mapcount() is used to check whether the folio is shared. But it's
>> not correct as folio_mapcount() returns total mapcount of large folio.
>>
>> Use folio_estimated_sharers() here as the estimated number is enough.
>>
>> Yin Fengwei (2):
>>   madvise: don't use mapcount() against large folio for sharing check
>>   madvise: don't use mapcount() against large folio for sharing check
>>
>>  mm/huge_memory.c | 2 +-
>>  mm/madvise.c     | 6 +++---
>>  2 files changed, 4 insertions(+), 4 deletions(-)
>>
> 
> As a set of fixes, I agree this is definitely an improvement, so:
> 
> Reviewed-By: Ryan Roberts
Thanks.

> 
> 
> But I have a couple of comments around further improvements;
> 
> Once we have the scheme that David is working on to be able to provide precise
> exclusive vs shared info, we will probably want to move to that. Although that
> scheme will need access to the mm_struct of a process known to be mapping the
> folio. We have that info, but its not passed to folio_estimated_sharers() so we
> can't just reimplement folio_estimated_sharers() - we will need to rework these
> call sites again.
Yes. This could be extra work. Maybe should delay till David's work is done.

> 
> Given the aspiration for most of the memory to be large folios going forwards,
> wouldn't it be better to avoid splitting the large folio where the large folio
> is mapped entirely within the range of the madvise operation? Sorry if this has
> already been discussed and decided against - I didn't follow the RFC too
> closely. Or perhaps you plan to do this as a follow up?
Yes. We are on same page. RFC patchset did that. But there are some other opens
on the RFC. So I tried to submit this part of change which is bug fix. The other
thing left in RFC is optimization (avoid split large folio if we can).


Regards
Yin, Fengwei

> 
> Thanks,
> Ryan
> 
