Return-Path: <linux-kernel+bounces-341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2453F813FB5
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 03:27:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8EAC8B219D9
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 02:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70AB9808;
	Fri, 15 Dec 2023 02:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XyhgpmLS"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5C4C7FC
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 02:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702607208; x=1734143208;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/WmTdAIb39ZVYCbeiPsxIh+/ex/sEtDmbiKv1d/gmQ8=;
  b=XyhgpmLSMHcUpJCCijF6E+sx/7bpl+P1fbvcb6/kykcOECzDVb2NFbGS
   iRu43So3uD2yNbU3+QJOacr0POa+NptV+AK4JqkhIVYw5VtUTr/AVbzhf
   LbMb+Yr7lzSnpAyX+A1T4MbWVU1HLaUXsj8mmXA9ftCY5xjeVQ34ahL28
   CqZEL9BuwnEcQjCLbFC5Mbgonuo22UHgp6WF6VDnfkohp6H0dVJnDvbG2
   qt5q1DHZCNQnmkSnsNOQcOcK9uo6OyV7EI+dbGdD2YVoRHNjyS/hWZmeo
   5wCpToPd2Q1IfiUx51jwFT/thfsDoxkEA+Qr3umAadGANQaKs1O1hAOC0
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="380213863"
X-IronPort-AV: E=Sophos;i="6.04,277,1695711600"; 
   d="scan'208";a="380213863"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2023 18:26:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="897977671"
X-IronPort-AV: E=Sophos;i="6.04,277,1695711600"; 
   d="scan'208";a="897977671"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Dec 2023 18:26:47 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 14 Dec 2023 18:26:47 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 14 Dec 2023 18:26:46 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 14 Dec 2023 18:26:46 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 14 Dec 2023 18:26:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C6E9YkIXmiZQDUhXJlRUrk1iIn+loI07ddwx8gypiULlg+gicVJbGRwnQHbE3AFNXxxlC37ImTQidTGJbRQqokInDRRSV0Nqd26jbRuw1PA9JyahSMTlggNX1CGhLk60w+6d8gmNsmBI3f1nKYZsexOhQHhl7VvYH8QUlYNmPTiAyo2OheJdm1GEDFz0U6AiADcQBTpx7U1psiyh4MjwKyofueAH99NUC/TkGj6VZkZF7JktSRVVvwMsBuUlBNTrSqRdIKktQV87PQfx6L7vyekudvr9G1qGcYzaOmS8bcxdetBLLM+dh08AESLbQOqQNlOrP8wH5sQDxKucOBjG5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pf9qUs/sZq2h8atqgeOEBIrAWzLx5lIM1TUJ8VCrhdo=;
 b=i/oStkvZtoYLA52bzW04K+AaMSX6JFnztll7tB3T0MqRgC0fqlgeMowD4jFyDil6GN84KjXI6++b7PKo1jc6w9tYOtRnvhN6vWTlhUWuYEAV/zLVIyncwsqKAytgKwmzr+VK/DKbrJDm5/IL7JeocSjbX+0T8gJKFqItq6FyYNEX6TfRm+pDmXwXhEcDkxeUG38aEV9ddPCd5tVhe4V3sdG+qFU5XYhXmde3AcRxthh+zULU5O6mV/SbCe8N+UGm4R706IuL74O4hfneHYfel6Oj6O/FUN2otvrLOq1Lrh8OWA63z/LJOay11WmdjBKa8PmnS/fdYGy+9e/6AgtS9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by SN7PR11MB7017.namprd11.prod.outlook.com (2603:10b6:806:2ac::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Fri, 15 Dec
 2023 02:26:41 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::3d83:82ce:9f3b:7e20]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::3d83:82ce:9f3b:7e20%5]) with mapi id 15.20.7091.028; Fri, 15 Dec 2023
 02:26:40 +0000
Message-ID: <941c2269-98f0-43a7-a516-cb5b4909ae7f@intel.com>
Date: Fri, 15 Dec 2023 10:26:32 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 14/39] mm/rmap: introduce
 folio_add_anon_rmap_[pte|ptes|pmd]()
Content-Language: en-US
To: David Hildenbrand <david@redhat.com>, <linux-kernel@vger.kernel.org>
CC: <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>, "Matthew
 Wilcox (Oracle)" <willy@infradead.org>, Hugh Dickins <hughd@google.com>, Ryan
 Roberts <ryan.roberts@arm.com>, Mike Kravetz <mike.kravetz@oracle.com>,
	Muchun Song <muchun.song@linux.dev>, Peter Xu <peterx@redhat.com>
References: <20231211155652.131054-1-david@redhat.com>
 <20231211155652.131054-15-david@redhat.com>
From: "Yin, Fengwei" <fengwei.yin@intel.com>
In-Reply-To: <20231211155652.131054-15-david@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0043.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::19) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|SN7PR11MB7017:EE_
X-MS-Office365-Filtering-Correlation-Id: b4962e36-91fc-4862-99a4-08dbfd154566
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mxFxsEKH0BDknwnX+0iIzZOJsygJdWveO7BXEhepiu48t9kfieqQxSu0TNqSQQRcY+2I/0aOpfrZD26Ou8X6qHHpe3kDbGo4FhqhV7PQuemndz88Hg7Zrm+evZGb7BIocFyFT7XeKQ9YIM/7fb2CNQXqOIYREyu3U8nAmjlO4BQSUkBhTsLGNQUkApy1jcWJO+IfDz1f8BBB3IOB1jthlOov2/NL9OyIfRQbcGWT00o0whPDsuUi5YLbMfMDxgG8wnBwryvTG8K4lelV4MFb7DJGjP3GESekxHiyMlLKPsaVUD9qtl6USoQTmARnTGEQgtIm9V9m2kDKomgg9x2mzLBgnt2PtcGbJQqe2O9IOT2LD71VP/t4aAYCoZ49H81EMpGM+YUlSKHqi3vbbpIiPsGupdk1jFIhbZociBT+PWWPjuK2oum/KbR5h21gZCih/Aas1S6eNBKQAdJzypVQJBCiZz/S5x3iEqAf6KL4ruSUFjJGQVXv0PPx+AnY0kEQQxmtd+zc2u3eBuLWYDPsw82yHVaHMJz7sWh17Cp/Tf1kx5vUulyG+E+4fG6l2XiNwwOD/Z7cfXmw1joDXSzPG4VsdIHT6DneFuSXDIZi/B4QosPfRdf/MmwJD44kkG/UEdewm1YZEGdxQo+NYy6M2A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(136003)(396003)(346002)(376002)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(54906003)(478600001)(6486002)(6506007)(7416002)(5660300002)(2616005)(26005)(66946007)(66476007)(66556008)(6512007)(6666004)(31686004)(53546011)(316002)(83380400001)(8676002)(8936002)(4326008)(2906002)(86362001)(31696002)(41300700001)(82960400001)(38100700002)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QWxnMWdEVTQyNS9PL3JjN3UvU3J6MENuQWh2QTNzS2pqT25qZC9pOU9oYWVB?=
 =?utf-8?B?L2Z0VC9jcTFBbC9MVDBHSHhSbGJNWTR2S1FQZjVpclVFQXhkZ2ZKNWxWdzJ4?=
 =?utf-8?B?WXBhY0lQYXRJbHhVT2RNdis3TEJzaXhrejVMTm0vTGtpU01NSGpVOWlLUDY5?=
 =?utf-8?B?VWRUbWJZcHlSdTZITlhtVzFTcTJUZ3hOVmxMZWRsU0FUU0FET09adWZOSEpu?=
 =?utf-8?B?d0FENXNydHl5ZnFXTGV4N0xRS0VTTFRTOEV4anRTUWNLOXZWWjFjclE0MHV3?=
 =?utf-8?B?anFTUW1YTEZsSFEvMEVxbUluMEpYUHkxcWJ1SlZEa0JjdktEZU9oQVJTVStZ?=
 =?utf-8?B?eUtxLzBHcjNPNzhkK1FsTnJLK0xtc3lFbTJiQ0FGZDZwMjFzYTg2ZDBUaG5R?=
 =?utf-8?B?UnB4YzZVbVJKd1BBRFV5ckQrcDRHU0h2OU02MEFVWWpMTG0rR1BLanpwOUJu?=
 =?utf-8?B?ZVF5WHhMVHdCd1JUUE1MVmZNWnR1TmJpalNESE15ckZCMElFK3A0a2xMWHNw?=
 =?utf-8?B?SVN4OGw0d1RKeDZBZHZPWS9tSlM1ZUNzd2NjQnQ2MllWYXBHeGc4OG1saHVF?=
 =?utf-8?B?UVBRU0M0Q1diRTEwaTRCaFRHYmhqU1VjWXpYMGhSNEd1ZXR3QVdIYi9TUDJM?=
 =?utf-8?B?SHRmWWxNcVROY1ZBY3FLRlEwRWEzaTAxbUxDaVZpWjNhN3RFV0MwbzBwczhj?=
 =?utf-8?B?T091Q3Y4T2FtRVlpQVVlWS9oeVZxWWxGNDlINFRINjJETS9pVjZiOHFOdWRZ?=
 =?utf-8?B?ZnFrblVZTWFibzJsc09IWHl1MDhNZHNyVmFqZ0YzNERFUVNjNllROS9UbnU1?=
 =?utf-8?B?TFcxODJGUWt2aDNLYjJvY1NVL0hFT2NzSkgvVURQRFk5M2xkcmFpWXJWTEZ1?=
 =?utf-8?B?M0JiRldLVkh2NVNNV25xZUR6UEhPbU9JR3BZdlVsMCsyL1NFRmdJQWRHb2h6?=
 =?utf-8?B?Y24vWld4UkNwWlY4NUlnVEdnT3pHeG5PNTVLVnpQdHVVQ2hkN0Z1WEFOVkdE?=
 =?utf-8?B?YVdJVWYwOXBuemRhS1B0RGNSOVgwWE5xdVZ4bHZRVXl6bVRZUmx6QVNhTHlq?=
 =?utf-8?B?eUlmZks0RU5kUTAxMkg4ZWI3azJldk1WeEJmRGVsQWJrSWZGRWNYYmF3NjZQ?=
 =?utf-8?B?OVdCVWlML0l0cWRoWUE4UE5KT2J0azFnTjRMN1dzOWxWUTFlR3YyRFNod0to?=
 =?utf-8?B?RW54dE1MVW12V0JuQ0xKTXlNTVVqOHNpakduVVhHVU0yQ1ZHbGpzZG1FVXds?=
 =?utf-8?B?Ukh6UFljSWQwN3AraEFlWUNSSUE0bjZxKzJQanY3TVB2ZmFYSE5Hb3NPRU9U?=
 =?utf-8?B?RzJ5Rm1QVkJpSjk3YnhubFpXMVNPOXV5UklCSDgzOU1rYm81ZDI2WjVlZVpR?=
 =?utf-8?B?TkZtUnJCNEZLUTkzQmMzcm1pVHYwdGl3ejN2WmpYQWFoYjRNVXdEalFOaHdi?=
 =?utf-8?B?TnpSRHNMYW9ZcE5CS21ia2d3ZzRUTVUxZVY3S3BkMXlCbFFBNHRUSWtrMGNC?=
 =?utf-8?B?bU9WVTUxbG9HMjV6eHpjeHB5cGt5a2RDYmF2bEJPZFJxUHMrYjREZXIwYnFa?=
 =?utf-8?B?aTFJL1RXRHBLZDBpbUlhbnEvdkxSM3BBSzlyZUErS3JzbU1ZRXEwOXh0OEVw?=
 =?utf-8?B?ck01aFRaMTE5dFhCamM5TmEvZGwrWUpCa2JzL1MwOGtJWHF5REJSQTN2UGZW?=
 =?utf-8?B?MHlhdlkzRXpjUlJXZ0FITldzUVVBcE50VDBudU0vS3QxQmlMTVlObFlHdG1p?=
 =?utf-8?B?VGlLNE43Z3cyMmhhNmk2b3dYaG9yNGZKOU1rSER5SVRaOGh5QVVaRjdsSHFU?=
 =?utf-8?B?Y0ZGK1Rxd0NhTDQ4bDhVdzNEenNlazF5TEtkNk5UcVQvQVZHcXorZzJaY2JU?=
 =?utf-8?B?Tjl1T3JObXJrNmFaeHpqN3RQemo1WmdvZ2pqZ043OTVhdkV6OTFFYUVqbnFr?=
 =?utf-8?B?OVBoSmFDZ2E2UnRzWERPcnpZVEk0TzJ1RnoyVDhwUVFndC9HZHRVMk01V0ZW?=
 =?utf-8?B?NzkwaUREems4eWNBS09Nekp6Sm1oQmQ4TFhQMjRLRmRJTWkrREwzSElWRFkr?=
 =?utf-8?B?a2QvRTZNaHJqSkwzK1RkOUpDWXhEYUt4YStpcWFCdFdXUDhzcnlGNnFFNDQy?=
 =?utf-8?Q?sN/eBFB0LSNIxlHp/oGuydqbH?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b4962e36-91fc-4862-99a4-08dbfd154566
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2023 02:26:40.8408
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D4CavTFsPOvrE/V7yzFuFtU7FXIT1nXq9Ola7RjWjOayezTWweAv5dYOvRuiLjRXFy0zaZZO/3Cb37xUPPtS9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7017
X-OriginatorOrg: intel.com



On 12/11/2023 11:56 PM, David Hildenbrand wrote:
> Let's mimic what we did with folio_add_file_rmap_*() so we can similarly
> replace page_add_anon_rmap() next.
> 
> Make the compiler always special-case on the granularity by using
> __always_inline.
> 
> Note that the new functions ignore the RMAP_COMPOUND flag, which we will
> remove as soon as page_add_anon_rmap() is gone.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Yin Fengwei <fengwei.yin@intel.com>

With a small question below.

> ---
>   include/linux/rmap.h |   6 +++
>   mm/rmap.c            | 118 ++++++++++++++++++++++++++++++-------------
>   2 files changed, 88 insertions(+), 36 deletions(-)
> 
> diff --git a/include/linux/rmap.h b/include/linux/rmap.h
> index 7198905dc8be..3b5357cb1c09 100644
> --- a/include/linux/rmap.h
> +++ b/include/linux/rmap.h
> @@ -234,6 +234,12 @@ static inline void __folio_rmap_sanity_checks(struct folio *folio,
>    * rmap interfaces called when adding or removing pte of page
>    */
>   void folio_move_anon_rmap(struct folio *, struct vm_area_struct *);
> +void folio_add_anon_rmap_ptes(struct folio *, struct page *, int nr_pages,
> +		struct vm_area_struct *, unsigned long address, rmap_t flags);
> +#define folio_add_anon_rmap_pte(folio, page, vma, address, flags) \
> +	folio_add_anon_rmap_ptes(folio, page, 1, vma, address, flags)
> +void folio_add_anon_rmap_pmd(struct folio *, struct page *,
> +		struct vm_area_struct *, unsigned long address, rmap_t flags);
>   void page_add_anon_rmap(struct page *, struct vm_area_struct *,
>   		unsigned long address, rmap_t flags);
>   void page_add_new_anon_rmap(struct page *, struct vm_area_struct *,
> diff --git a/mm/rmap.c b/mm/rmap.c
> index c5761986a411..7787499fa2ad 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -1300,38 +1300,20 @@ void page_add_anon_rmap(struct page *page, struct vm_area_struct *vma,
>   		unsigned long address, rmap_t flags)
>   {
>   	struct folio *folio = page_folio(page);
> -	atomic_t *mapped = &folio->_nr_pages_mapped;
> -	int nr = 0, nr_pmdmapped = 0;
> -	bool compound = flags & RMAP_COMPOUND;
> -	bool first;
>   
> -	/* Is page being mapped by PTE? Is this its first map to be added? */
> -	if (likely(!compound)) {
> -		first = atomic_inc_and_test(&page->_mapcount);
> -		nr = first;
> -		if (first && folio_test_large(folio)) {
> -			nr = atomic_inc_return_relaxed(mapped);
> -			nr = (nr < COMPOUND_MAPPED);
> -		}
> -	} else if (folio_test_pmd_mappable(folio)) {
> -		/* That test is redundant: it's for safety or to optimize out */
> +	if (likely(!(flags & RMAP_COMPOUND)))
> +		folio_add_anon_rmap_pte(folio, page, vma, address, flags);
> +	else
> +		folio_add_anon_rmap_pmd(folio, page, vma, address, flags);
> +}
>   
> -		first = atomic_inc_and_test(&folio->_entire_mapcount);
> -		if (first) {
> -			nr = atomic_add_return_relaxed(COMPOUND_MAPPED, mapped);
> -			if (likely(nr < COMPOUND_MAPPED + COMPOUND_MAPPED)) {
> -				nr_pmdmapped = folio_nr_pages(folio);
> -				nr = nr_pmdmapped - (nr & FOLIO_PAGES_MAPPED);
> -				/* Raced ahead of a remove and another add? */
> -				if (unlikely(nr < 0))
> -					nr = 0;
> -			} else {
> -				/* Raced ahead of a remove of COMPOUND_MAPPED */
> -				nr = 0;
> -			}
> -		}
> -	}
> +static __always_inline void __folio_add_anon_rmap(struct folio *folio,
> +		struct page *page, int nr_pages, struct vm_area_struct *vma,
> +		unsigned long address, rmap_t flags, enum rmap_mode mode)
> +{
> +	unsigned int i, nr, nr_pmdmapped = 0;
>   
> +	nr = __folio_add_rmap(folio, page, nr_pages, mode, &nr_pmdmapped);
>   	if (nr_pmdmapped)
>   		__lruvec_stat_mod_folio(folio, NR_ANON_THPS, nr_pmdmapped);
>   	if (nr)
> @@ -1345,18 +1327,34 @@ void page_add_anon_rmap(struct page *page, struct vm_area_struct *vma,
>   		 * folio->index right when not given the address of the head
>   		 * page.
>   		 */
> -		VM_WARN_ON_FOLIO(folio_test_large(folio) && !compound, folio);
> +		VM_WARN_ON_FOLIO(folio_test_large(folio) &&
> +				 mode != RMAP_MODE_PMD, folio);
>   		__folio_set_anon(folio, vma, address,
>   				 !!(flags & RMAP_EXCLUSIVE));
>   	} else if (likely(!folio_test_ksm(folio))) {
>   		__page_check_anon_rmap(folio, page, vma, address);
>   	}
> -	if (flags & RMAP_EXCLUSIVE)
> -		SetPageAnonExclusive(page);
> -	/* While PTE-mapping a THP we have a PMD and a PTE mapping. */
> -	VM_WARN_ON_FOLIO((atomic_read(&page->_mapcount) > 0 ||
> -			  (folio_test_large(folio) && folio_entire_mapcount(folio) > 1)) &&
> -			 PageAnonExclusive(page), folio);
> +
> +	if (flags & RMAP_EXCLUSIVE) {
> +		switch (mode) {
> +		case RMAP_MODE_PTE:
> +			for (i = 0; i < nr_pages; i++)
> +				SetPageAnonExclusive(page + i);
> +			break;
> +		case RMAP_MODE_PMD:
> +			SetPageAnonExclusive(page);
> +			break;
> +		}
> +	}
> +	for (i = 0; i < nr_pages; i++) {
> +		struct page *cur_page = page + i;
> +
> +		/* While PTE-mapping a THP we have a PMD and a PTE mapping. */
> +		VM_WARN_ON_FOLIO((atomic_read(&cur_page->_mapcount) > 0 ||
> +				  (folio_test_large(folio) &&
> +				   folio_entire_mapcount(folio) > 1)) &&
> +				 PageAnonExclusive(cur_page), folio);
> +	}
This change will iterate all pages for PMD case. The original behavior
didn't check all pages. Is this change by purpose? Thanks.

>   
>   	/*
>   	 * For large folio, only mlock it if it's fully mapped to VMA. It's
> @@ -1368,6 +1366,54 @@ void page_add_anon_rmap(struct page *page, struct vm_area_struct *vma,
>   		mlock_vma_folio(folio, vma);
>   }
>   
> +/**
> + * folio_add_anon_rmap_ptes - add PTE mappings to a page range of an anon folio
> + * @folio:	The folio to add the mappings to
> + * @page:	The first page to add
> + * @nr_pages:	The number of pages which will be mapped
> + * @vma:	The vm area in which the mappings are added
> + * @address:	The user virtual address of the first page to map
> + * @flags:	The rmap flags
> + *
> + * The page range of folio is defined by [first_page, first_page + nr_pages)
> + *
> + * The caller needs to hold the page table lock, and the page must be locked in
> + * the anon_vma case: to serialize mapping,index checking after setting,
> + * and to ensure that an anon folio is not being upgraded racily to a KSM folio
> + * (but KSM folios are never downgraded).
> + */
> +void folio_add_anon_rmap_ptes(struct folio *folio, struct page *page,
> +		int nr_pages, struct vm_area_struct *vma, unsigned long address,
> +		rmap_t flags)
> +{
> +	__folio_add_anon_rmap(folio, page, nr_pages, vma, address, flags,
> +			      RMAP_MODE_PTE);
> +}
> +
> +/**
> + * folio_add_anon_rmap_pmd - add a PMD mapping to a page range of an anon folio
> + * @folio:	The folio to add the mapping to
> + * @page:	The first page to add
> + * @vma:	The vm area in which the mapping is added
> + * @address:	The user virtual address of the first page to map
> + * @flags:	The rmap flags
> + *
> + * The page range of folio is defined by [first_page, first_page + HPAGE_PMD_NR)
> + *
> + * The caller needs to hold the page table lock, and the page must be locked in
> + * the anon_vma case: to serialize mapping,index checking after setting.
> + */
> +void folio_add_anon_rmap_pmd(struct folio *folio, struct page *page,
> +		struct vm_area_struct *vma, unsigned long address, rmap_t flags)
> +{
> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> +	__folio_add_anon_rmap(folio, page, HPAGE_PMD_NR, vma, address, flags,
> +			      RMAP_MODE_PMD);
> +#else
> +	WARN_ON_ONCE(true);
> +#endif
> +}
> +
>   /**
>    * folio_add_new_anon_rmap - Add mapping to a new anonymous folio.
>    * @folio:	The folio to add the mapping to.

