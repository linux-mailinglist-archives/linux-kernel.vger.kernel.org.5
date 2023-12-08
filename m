Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F0CB8098AF
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 02:42:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232721AbjLHBlv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 20:41:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjLHBls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 20:41:48 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A40661719
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 17:41:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701999714; x=1733535714;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=3QLHbqNH2iAt3ZH3vIGYjYalcojVAsY/ohcLWoQyAto=;
  b=ZS/XdZMu2v8IQVQfI9Uuqrj33fFi9Wbw6PAVP43MCKCn15FOkfuFDRLL
   v3yqBJijgZ/8wtttM41CaxsCPGl2/NmdDBlvK+lOuHvtUDiXqm/ha/lVr
   27UBwS7KqEPkVoAAW64RghraNd4FnFCtOIqluROvr3YCJTL06Y4WfQ3QA
   VZnGeR9xFC8x0seVEUlQwi3ddk2CXgK5rP2rsGxztLeY6wqJYqtlFBsyc
   6xJ2wlSzIYGHvHjVZe9blTfsg637qBvaxpH/eZMfzcLiYy9lTUEWfKipo
   Gi03XlqptszkDxO0J0k1C3SaNNIv1UUi5us12rvrmuN/+oibG/L/fWcE4
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="425477629"
X-IronPort-AV: E=Sophos;i="6.04,259,1695711600"; 
   d="scan'208";a="425477629"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2023 17:41:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,259,1695711600"; 
   d="scan'208";a="13324287"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Dec 2023 17:41:54 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 7 Dec 2023 17:41:52 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 7 Dec 2023 17:41:52 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 7 Dec 2023 17:41:52 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 7 Dec 2023 17:41:52 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JSBZJn5CnR6/+4yxp7Su926tm5BZ+//DkFFBixzFwNXDYLiCX0ukScJKqLF1zCinoNGF834KgP7JhUqp6KEDNLUUgBqWSsJFu8hgvks2zXUSscDXtadVbmLJ7Vr5WqFX1y7FEW8GJGp2jtGq2xdnhCLIwzDwyeQIF44Ru+YPNam4/FNztYQ6S5wEw3aCBWccdGHZWvlwhwvUevGx6ivx46oAbdXrJDpeAcuLx4zHy9N3L5zpbOxKE/YIDoa77I2cuGfu9ET0ydppsvUmGPMrgXwCS2FzO00AcZT7m615c6CaPPK+dy6oIFuU45m6PJwZ5gHP7VkRWkILM7JjcGSNYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tAenzBdsl4o8JQ788ZzLOMV3ajzv6Y5R0+j7llmBds8=;
 b=gz52433L3YcmqXooLbhzyVKn8wQMiGNBtthwHgGNmKOa2mnFqjQf0HcfuqUpVFLAsHcHjdu0uZdsmp/hxWAP/K9YHrkXTggtq8DOEyRcvMTuTZsW97pngxiTSi+UjEoABhXmkPYMBQi456t1Ep3BF1ODULR25+22/3eHCfHWwYH2+ccdSpPhpx1EwjYvdFLAeVpS1fCRUjwgwoYtvu5YIrfYXjKzscOdYni1o/9UbCf7plU/tXN4uUBaCCagbADQl/Vqok4CdzU7SnuAVSnu3RLN9OwiXTB2k7HsoQaDj1PpO3We1Y+VRHS7Na1J19K6n3x8P2mxBTLdRyRh4t3JrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by PH7PR11MB8504.namprd11.prod.outlook.com (2603:10b6:510:2fe::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.25; Fri, 8 Dec
 2023 01:41:48 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::3d83:82ce:9f3b:7e20]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::3d83:82ce:9f3b:7e20%5]) with mapi id 15.20.7068.027; Fri, 8 Dec 2023
 01:41:48 +0000
Message-ID: <2e6b0d17-4731-4c92-ab0d-6f01d1069963@intel.com>
Date:   Fri, 8 Dec 2023 09:41:45 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 09/39] mm/huge_memory: page_add_file_rmap() ->
 folio_add_file_rmap_pmd()
Content-Language: en-US
To:     David Hildenbrand <david@redhat.com>,
        <linux-kernel@vger.kernel.org>
CC:     <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Hugh Dickins <hughd@google.com>,
        Ryan Roberts <ryan.roberts@arm.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <muchun.song@linux.dev>,
        Peter Xu <peterx@redhat.com>
References: <20231204142146.91437-1-david@redhat.com>
 <20231204142146.91437-10-david@redhat.com>
From:   "Yin, Fengwei" <fengwei.yin@intel.com>
In-Reply-To: <20231204142146.91437-10-david@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0001.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::15) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|PH7PR11MB8504:EE_
X-MS-Office365-Filtering-Correlation-Id: e58d852f-cdef-4432-b46e-08dbf78ed7ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LwbCy4iJIAslVCIkbMZ8HfTtfZZIqXH7bnBQMVMKuiUgPSJ3yIINbFwPQXjW3C71R8y3y00Z83jRGjH1dK+uf+oZLrxZ1/Xv/5ayEWWhaf6w72g5J/NG6MaIh7CUJVL/imfQS8XM8A5jqHjqz0rfzqFFkfkMQ4ygkCADHUxfhN4fgbu7CI1yOv0OYP54AFJ1yezAJf86jUKzKsncUdcJ2gFBOyL/abFcXOogTWO51mxniIwBZQe1uvkc0sDd5SgyTYykV0HVh91uiJqDiWlCViRgj+YgH6yZLfVm9YpXTkQl0u3u+Tp1lZog8c0XqeGNLJzc/NarVBeI4f0/Sar03WDozA6osM0/vkLFbtEZM8d87hI/seoDZUsYuR5YDY68CWrwWpHPDm3SvSjZ0ClDKyvOIP3dczLkYKwFTzYgzyjdV+rMl/GJ5/WGlomBfvOIJ4ZUEPo51EUNX1IRMQ+xVmBf3pe7oHxFNF79xdm6AWIZKFI/sMP7IowBS/MQ2i4j6dqFI7ejxjjSBwjbpK2gJ4AkRTBVQZn4PCXCt3VF25I3oEh2uQoV/IAggx1Mt5dWuAfObazPQfkayb0HOjtMS9kWqFTngtKhuT2oK/DVpFb03/F0tkeTBJ4UeLkxsBdhgYJf10z5EcDgAa7xF+pL9iLNfEf11i4QUpsq+FYchoXfcfl8NZYiO+MfdL5mXwVpi3/pV+/9REnsGBW8pAK6BuD2oRGvGTMCh+4NdaBxitw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(346002)(396003)(376002)(366004)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(66946007)(66556008)(5660300002)(66476007)(54906003)(478600001)(6486002)(2906002)(8676002)(4326008)(6666004)(7416002)(316002)(31686004)(8936002)(6506007)(53546011)(6512007)(26005)(2616005)(83380400001)(41300700001)(86362001)(38100700002)(36756003)(31696002)(82960400001)(14583001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TytTYXVWcEtNSjVYZnlpbkt2UzlJUmpsMUF3eVp6cGcrK0VGSU94Y0d3M1p6?=
 =?utf-8?B?VmJodGd3MVd4cWh1WURSZ3VDT1Y2NHhQRXZmWkNlbStXandjMmgxMm40SEZ4?=
 =?utf-8?B?d3NnelpGUFA0NmJNaXRIcUdsNzBFQjl6Tkwzc3UxYVJZRU1YSVVLYW5VbmFT?=
 =?utf-8?B?dkUwRG9talhRZEVPdy91elgvc3NCTHZmSE5BUDVTN1A1UnlVSWRrZm9KMWZp?=
 =?utf-8?B?SWVYWmFBU0twK29ONnAyOGtObFFBNmQ1TlAvZmpaeFhya0taeFFmSlVBMmRO?=
 =?utf-8?B?OXZGcUdDSldKZnJNYUJma2Z5bWpvd1Fhd0Y3Ky9lTVdmNFN5a2UyZzZ2dEZs?=
 =?utf-8?B?azZieGZLQVVta2I3L2ZJMUVMQ2tIQXBoeCtpMDNzeGUzTldNcmtSNE81R0ZP?=
 =?utf-8?B?TTFtSk8wSFJQNENGQXkxakpTV29RZ3dsRm5pa2hCdVU4Vzc2SmNQM3RmK01G?=
 =?utf-8?B?bTJFZGpxZVdQSjFlTklxcGdOZzdnQzd5Y3ZpY243aythcTlHVUNGNnU4RzJ2?=
 =?utf-8?B?UmVCOVlRNHBrS1I0OVFkbStFVGJKWDIwTnFKeC9zbmRUcFFQWG9MSGg4Ri9E?=
 =?utf-8?B?Z0t4WURkSkRSK2VMOU9hUmErcnVkREkrTFdnQXROMmt6ZGJzV2pQMi9Wcnk1?=
 =?utf-8?B?c0dBVWEvMjd4NTErZi92N2t6T2pYOTdnMDBaRDJ6cTE5ZHU1b0s1dUl0anBq?=
 =?utf-8?B?REdCaWFBVUlIS0hJNVg2cTNkditFblllUWtjZkJYaForRmVHbXVOSXlnM1p1?=
 =?utf-8?B?emlXOXBmTmludjRXR0V2aC96dVM4bDVMZjBZbFEwTGpmc1dkMnd6NjNzYlhV?=
 =?utf-8?B?YjgxanFMdXNxd21TcWtsZzhOODMvSTFuQTJwM2VXa2JHM3Z1NzhJUEVzN2xw?=
 =?utf-8?B?UkJXY09FcW1oN2dDdWx5NVo0eDF2bkM4ODJmQVZkN2oxdWhDY2NwOEFTRTJZ?=
 =?utf-8?B?NHNIRWR3eTFPSmxQWnpiYUU0dkI0K1pBcTRGRm1mYnNTenhWemIrL280bTRv?=
 =?utf-8?B?N05lbkVJbnpZMjNkNmFHdThBc1dHakRaWEV6azQrRU1FazhZOGoyMkcyeU56?=
 =?utf-8?B?QnMrNHpvSHBmRXExOW51YlNBS1JWb0Z0SGJ5dFJuazNqeTVCUE83enpnYWp1?=
 =?utf-8?B?bEhzV09XLy9KY1o4aGwveEk5U2k1VU41V0lyVFRkVHVUaDA0SDdRdWNYMjFz?=
 =?utf-8?B?ZVRqWTRnTGtHUGdxMUhRMU9iYkttc0xoWmxSR3cvYUIxeW5iQmMyU1l0UGw1?=
 =?utf-8?B?V0VDRDRpNkpyUWVQelAxYTJhdTFWSnFCNUNEWFdnbko3eXZiOGRwRWN4dzdZ?=
 =?utf-8?B?N3NIcldUSXk1RTFOZUFLRHd4b3lsK0NPM3gycXozOEttY3RJSnlDU1RmNGgw?=
 =?utf-8?B?ei9mSXhGZzNBUC9QNjZTZis0bTF4Mm4zUUkwQ3k2VCtNcGlqVTc1cDZYZERl?=
 =?utf-8?B?V2pSOStwRVVHS3hqdzFOZGp3TlJ2eFZCdkRjaThFMTErbzNPSlJRcWpxMDJv?=
 =?utf-8?B?dEpXR05sYWdFQmthcmxpNlZFZEtGNTRTUS9vcDdSbzNzLzhFenpjenoxd1k3?=
 =?utf-8?B?clE3OWtRRlV6UVd3R0VRQys5Y2xQcmRkdExvS25Gbm5ON0lCMDF2R2lDeStZ?=
 =?utf-8?B?anpTNWFuUWlETC9QL3BXeFRLalB3SlRzajdTRW93aVNoaUFjT2dVL205U2gy?=
 =?utf-8?B?MlFmV2VJR3RJTSszYzdpdGRYOUN5L0R3Kyt1WWlEbUFRM2ZaZEp0WENrWDBR?=
 =?utf-8?B?MFNIWUZSREtEelVwaUpHRVJzT3JuQlN1a3pCbU50dWkyNExFcjlpRUs4K25H?=
 =?utf-8?B?UFNiVmJDcU5qZGMyN2JKMTNaTU9jY2YrR2hrK1lhSHpaaGdmRWsvNUhaWEEv?=
 =?utf-8?B?ZSt5Nk01bFhURWJHYlVGQTM3bmNSYnNEbjU0MFJSOE5oR0QxeWtUNlhNU3k3?=
 =?utf-8?B?NnJreFJPQzI0THBGU3k3RkpZdGNMNXZWSXlHN0pGNzArejJjN1JGM0lMVk1H?=
 =?utf-8?B?ZERURlhIeW83K0VVVmc0cnBHRFI2SmR1L0FVdGZIanVXUmFkbHBPa0pOb0d5?=
 =?utf-8?B?RnlvNU4vcXJnOWcxL20wOVgwRlAyem5PUk52QUtIbWhpNUNYWFhOS1pYZUNl?=
 =?utf-8?Q?72+mgcJiW2PtpGa7MvdmODCwA?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e58d852f-cdef-4432-b46e-08dbf78ed7ff
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2023 01:41:48.7048
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VSyg0jGCwFT7ox3DYvAIXr7EYmP2DuinMf3Jcuyd3XY486XRvfOQMRsnKySKZ10waEkj114c8CJZYBSeo+x4VQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8504
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/4/2023 10:21 PM, David Hildenbrand wrote:
> Let's convert remove_migration_pmd() and while at it, perform some folio
> conversion.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Yin Fengwei <fengwei.yin@intel.com>

> ---
>   mm/huge_memory.c | 11 ++++++-----
>   1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 4f542444a91f2..cb33c6e0404cf 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -3276,6 +3276,7 @@ int set_pmd_migration_entry(struct page_vma_mapped_walk *pvmw,
>   
>   void remove_migration_pmd(struct page_vma_mapped_walk *pvmw, struct page *new)
>   {
> +	struct folio *folio = page_folio(new);
>   	struct vm_area_struct *vma = pvmw->vma;
>   	struct mm_struct *mm = vma->vm_mm;
>   	unsigned long address = pvmw->address;
> @@ -3287,7 +3288,7 @@ void remove_migration_pmd(struct page_vma_mapped_walk *pvmw, struct page *new)
>   		return;
>   
>   	entry = pmd_to_swp_entry(*pvmw->pmd);
> -	get_page(new);
> +	folio_get(folio);
>   	pmde = mk_huge_pmd(new, READ_ONCE(vma->vm_page_prot));
>   	if (pmd_swp_soft_dirty(*pvmw->pmd))
>   		pmde = pmd_mksoft_dirty(pmde);
> @@ -3298,10 +3299,10 @@ void remove_migration_pmd(struct page_vma_mapped_walk *pvmw, struct page *new)
>   	if (!is_migration_entry_young(entry))
>   		pmde = pmd_mkold(pmde);
>   	/* NOTE: this may contain setting soft-dirty on some archs */
> -	if (PageDirty(new) && is_migration_entry_dirty(entry))
> +	if (folio_test_dirty(folio) && is_migration_entry_dirty(entry))
>   		pmde = pmd_mkdirty(pmde);
>   
> -	if (PageAnon(new)) {
> +	if (folio_test_anon(folio)) {
>   		rmap_t rmap_flags = RMAP_COMPOUND;
>   
>   		if (!is_readable_migration_entry(entry))
> @@ -3309,9 +3310,9 @@ void remove_migration_pmd(struct page_vma_mapped_walk *pvmw, struct page *new)
>   
>   		page_add_anon_rmap(new, vma, haddr, rmap_flags);
>   	} else {
> -		page_add_file_rmap(new, vma, true);
> +		folio_add_file_rmap_pmd(folio, new, vma);
>   	}
> -	VM_BUG_ON(pmd_write(pmde) && PageAnon(new) && !PageAnonExclusive(new));
> +	VM_BUG_ON(pmd_write(pmde) && folio_test_anon(folio) && !PageAnonExclusive(new));
>   	set_pmd_at(mm, haddr, pvmw->pmd, pmde);
>   
>   	/* No need to invalidate - it was non-present before */
