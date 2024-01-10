Return-Path: <linux-kernel+bounces-21642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 141B9829234
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 02:37:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FDDB1F26883
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 01:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D6783C37;
	Wed, 10 Jan 2024 01:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jXwVxJnH"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F193C0A
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 01:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704850604; x=1736386604;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=nzkqQ5RoIJir0KiYo+RgbSOJOCkTBB/1/ufMy3Yt5oI=;
  b=jXwVxJnHPBsP0ZT0T4lLoa5i+l7CRVXkjTw7+fjAYAlaIcF37vXPzGDy
   cYlRikrkgau64MKnHaQfDV5+yaE/4OMX3OGyx1ehX0Z3jgrhq5dYS003Z
   enhCr22k9PvZLG8HbxXPdQdKmGnEYq3TfLdXZqkjMQV965IM02UF/+5q2
   jgulI0xTzlYJbGBOokiIwjCTjhdgthciK0pC/7RLmOFD+GWvk/70buPOR
   Ad83CDd1sJC1H+j6VTZUVOIK81WYKO3xC6xRx2/dn2N7r3Qbi9Eh1kvYM
   p57x2Z6y5DeThECnw8Q2s09rj2FJv7WlvhpeKuPbEc44qoprmgarWDBUT
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="397228679"
X-IronPort-AV: E=Sophos;i="6.04,184,1695711600"; 
   d="scan'208";a="397228679"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2024 17:36:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,184,1695711600"; 
   d="scan'208";a="30403645"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Jan 2024 17:36:35 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 9 Jan 2024 17:36:34 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 9 Jan 2024 17:36:34 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 9 Jan 2024 17:36:34 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cuLZt9RuyBS6AlW1D2d1BMJsEyjA5eZ14KIrbfVO6sAs/yuVyvPnhT2kuFdbWTlQlWN0/SAI9jmHcRYt6K5Nu55HZC3YpbZtOx4cinP6PyhHKHPhHJPIZOWUhiqi4u6jYXgmgloQU/UXHaWhJUm98Id4drJRWtRyce9kxzOvUtRdYKkVIPvm3U62xQLAXlBwTCCpeYVb37ye7m5not9MxlYTuNz9vXsWxWZ6xzwjhZhawU9Qiv8dUrKfwZr/1x5P6u0Zv2zh40RWpbEFPvzGkL4oOS8PZrNr4tpvS8lWYMj0iIFdRcpQPP9BAXWtradS7a7wTg3EjYfbZYP5ucH2uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g3NApsXkb/evSTUHs3bKuJhV5Nfad0gHKmL+LS++41U=;
 b=PfmhHQ8eoxbmXo28ER86Q95hpSTKXGnDdL+WMgoP7koCfhGXnYAhEiD8/f6TChCxrGDdeHY/7r5+nPGob5EP62MoxvpVl/wuu2ufT39V8cpKQErBXu8lp/7Mz7Tq6PZo8z1zKVQ7oHaVXgRMZiRB6sWO9+y3AKVUmY8ixFzK/MeaORcZcXT5wqg7KUdsZJBO4jgnoqRLHbgJbrLaMfXgYj/8ly/sZlIdOrJtFAyYiOvJCIr5/B2XZLo4GpIogP3nXzfkIR2TFAZ+xafAULk55GgHPLXaZc2XYJ5drVVO5vwurgVWxES25JpZStz6xO04oEOme+lWTU5TVCRBgU3XXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by SJ2PR11MB8471.namprd11.prod.outlook.com (2603:10b6:a03:578::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.17; Wed, 10 Jan
 2024 01:36:32 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::3d83:82ce:9f3b:7e20]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::3d83:82ce:9f3b:7e20%5]) with mapi id 15.20.7181.015; Wed, 10 Jan 2024
 01:36:32 +0000
Message-ID: <7433e325-9af7-4b8c-888e-07a0debf8e46@intel.com>
Date: Wed, 10 Jan 2024 09:36:20 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] mm: mmap: map MAP_STACK to VM_NOHUGEPAGE
Content-Language: en-US
To: Yang Shi <shy828301@gmail.com>, <oliver.sang@intel.com>,
	<riel@surriel.com>, <willy@infradead.org>, <cl@linux.com>,
	<ying.huang@intel.com>, <akpm@linux-foundation.org>
CC: <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
References: <20231221065943.2803551-1-shy828301@gmail.com>
 <20231221065943.2803551-2-shy828301@gmail.com>
From: Yin Fengwei <fengwei.yin@intel.com>
In-Reply-To: <20231221065943.2803551-2-shy828301@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SGBP274CA0001.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::13)
 To CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|SJ2PR11MB8471:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a3422fb-2f7d-42cb-65f9-08dc117c933c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0BCwj1/fNGv60aSGZTivWKq27G8DQXHoashjVOYFKN34q4/jZn6iayAQI2UQp6RCI3j0FZOQ2jUxvhu1sYPtcHfccIZo6RcpKjXQdrq6BXTSyxUo5qw5GxOfpbYeXO8stDs7z3EV27mbmI8kPCRGFuk3NSKoEUBT4cGBYJT70tNdzZFZgyHRIKWyKp+63C1XeCNqlEVag4mSCpwpS8Z+qRTY2pjyv9FlbzItCTtfk365Sm+GgOS0TFL6q/n3PjvxLGDXhXtqTgXwAjvbXKe5mFOOACmdi+EAPMtyvClT8Pn4oi9uzF2GBnUcW/GrFOg2HDtiVS52urXtI1zgxERWgFz5byvSfi7Kk1Ps/9zWge5s5CC/IYhBfR/Wq6TQxxlPoPD/f6JZuih9OSUIbpm1aPsp6S3TGygpCwnDQyzd3CgAbn3yi4mfPfgytTJAviCPF5HjoxVsJ8Zj+xWUsdsdYxsS8uzN4kgdXUO7wLgOi3OB+7DWX0B0h/u7vF43+Mw+D+rjMaCbA6JPei3RJj31VHXo5DIj9VlFRMHIBvs6CFzPyDC74M9zLuBDHYnJ66+1xZnhPotMKDiZcucOUIOlggN98Xoes2r/1Oeym1uAMZGJkKJ+6g1tzQ/3PBnLlMLLtda+T6jTV+4zQZZwMTGKqQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(376002)(346002)(396003)(136003)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(31686004)(5660300002)(966005)(478600001)(4326008)(6512007)(53546011)(66476007)(66556008)(8936002)(6506007)(6666004)(6486002)(83380400001)(8676002)(66946007)(2616005)(26005)(38100700002)(82960400001)(316002)(86362001)(31696002)(36756003)(41300700001)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dU9XdVlNamRHOWV0MVZMUVF1bGtlWTMzN0g4UTZDQS82ZjFrZUJVRHR3T2VS?=
 =?utf-8?B?S1phNW5OZ2pqZGdxT296aFBva0RKUVFuOU9naVA4L0VtaEg0bXRPMFhyYUFh?=
 =?utf-8?B?RVVtUWIzcktsRkUzUWsxamJNQlNNRjIydjZmZ0htN1h0cW5ZVU1XTHF4a0sx?=
 =?utf-8?B?ZjRQSzJqWnZhdHBjRmgxaUdEdmVINXU5dWZHMExQOUhxcFErMHplOTd1TFNX?=
 =?utf-8?B?TzkwUXBHbk44ay9xdXRIcVllMnhBeXlyb1B5V01LUVJjQlFiYUFEanM4K29F?=
 =?utf-8?B?TjZSbS8wNm9ESVY5R3hCM05XL1FKYlFPZ1VweGE0eHBVVWN1UEpDNytmNDRU?=
 =?utf-8?B?YmxNanRlaFNUb1AxTm5ML01BQUVJZ1RHTkZrT3NwSFEvRW9La1MyNXBYTDYw?=
 =?utf-8?B?RGZQdEtlL0tWS3Nidk56WHA5NURkZm43OU1mMHB2VFR0anEzOG5zOTMxZVE1?=
 =?utf-8?B?aE5qU3daOENqNXY0RFRGRlJRYmVabzlNZlhIcTNqZnB1SC9vclJ0UU9WaE5j?=
 =?utf-8?B?NkFIc3ROUXpJRk1ucExVTWIwWFBjdjN5QXRMV3d3RmNiM3F3SFQyUTFBei9r?=
 =?utf-8?B?QTVzR3BBWWJqTjZUMzBrZ1VoWDRHbGt5SFlhejFQcVcxUzJSZXRKWldmWnNC?=
 =?utf-8?B?VDFVMjFSd2FqRlRoVDh3WjRpSEZ1dllmVG1uU0U0a2pydWFzSmpqK21LYWZH?=
 =?utf-8?B?M3NSaXJSZ05Pdi9iVE1MZDVFTHJqckpXcjhycFhEdTlDaE9sYTB1ZXordmtW?=
 =?utf-8?B?QWhyVEJTcGhNN0RuNU10c3U1N0R5bGZjanplOEFybnlDN0k3TGh0blR5bksv?=
 =?utf-8?B?MDdySWd5N2U1UWc4dTNkODloTDlIR01KQWhjenVzRjBXS1hDdEl1WllpM2hC?=
 =?utf-8?B?dm5URUgzd294Sjc5NTMzNkoyOG1uN3RSblJESTRkcW11WFE5WGFUOS9qNzBG?=
 =?utf-8?B?ZkoyaXVWNE9kTEpBTHVYbHRFV1M5eU9CWUYxeDhhdDBuajl1SFNrK1YzbXJv?=
 =?utf-8?B?R3U0VlVUamhuVUViV0dlRXdWWjZHNmhsU0hkbllPV0llc1BtWWs5bkowUmhx?=
 =?utf-8?B?Y2UwYk4vN012SW9wb0hLYUp6dmJRUmQwRDNSSHNkK1NxZ0I0eGFpcU5MRC91?=
 =?utf-8?B?ZUdCWHdlOGc5NWpDNC9oQW82N3dMa2JPL1BVV3krVWhNQ1dhQ2ppQ0FTVTZQ?=
 =?utf-8?B?cHVtNkd3RlhpUUVoVCtCYWZRb2tIM3BOK1VDWVU2aDVQRGwwVnYzMmljUnJk?=
 =?utf-8?B?alQ1Z0hBZnNKb01DWTliVzBOQmswaCtqV1RtemYyWVlMSTFIcWhUZ2xWQXJi?=
 =?utf-8?B?K210am5oelFHbjZTaHdpQzBxS1RCTlJMdnJ2VFc0bWFsU2ZjaGJHUmdzZDJq?=
 =?utf-8?B?RlpkUTZSNDI2Rjd3T0JHeXNZTWRNcFhweHhRZFJyRWFxVnNKQjAxUnFPNU5u?=
 =?utf-8?B?Slg2MVkvcE1KL2ZHN3k0YlFuNEpTVlF1dXBHckI3c21zc3NXMFM3ZmdQSkM4?=
 =?utf-8?B?R0MxSkJyVEZ6VC9UcjAxMHJTMThNa0lnMnMwMzE0Z3lyOXQ0eXhud1NlWEd5?=
 =?utf-8?B?SVk1RnNvdjBlZkZuaVphUmRaZzhEK004dXI0c2tIczJKejd0TVd0d1hDWEFv?=
 =?utf-8?B?cTJOcU9GWkNoSzBCWUF0ODZXU1JIVDVXYUxwZFBNc1RyTjFBcHlraTlZM1Vz?=
 =?utf-8?B?dzAyYVNsUGJuNHJKeXRQbGlFSGtMV2xCMnpyQUdNdEE4MnU2bFVMeVMyQ0xQ?=
 =?utf-8?B?SXY2ZnM3bWpETGpnN2V2QU02TDFveWR3NGpSdHEzNDE5dGV2MFNURmd5S25x?=
 =?utf-8?B?Nmp0cldJK3lXY2JQbG9qeHdGaktZamdURkZlN3NpNmdIV3FERjRYN3VOTzZN?=
 =?utf-8?B?dHFacE00Nzc2S003cVdJclJUWEE4ZDcwY0I2MHJYTEl2eWhRb3hXK3FiSUVD?=
 =?utf-8?B?cDdyWFVzNUxvL0tDUDZQbHJ0KyttcGlhMmtNaTFqZVNHNFZUYzJ5cUNCdDZk?=
 =?utf-8?B?TUxRbHNsL0JUT2RjS2M5V3pkK0hHZTFaM1plVU5POWpYcVlQODJucG41Z1ds?=
 =?utf-8?B?UUJRdW1SMUVYNXR5S001bUlpS1VwYlI3MU9iaXEvOEpIUUVlaWk1T1pmNEVV?=
 =?utf-8?B?ejZHckpkeWRKL0VkclZxYlhXMTJHOU5xWFJCSzB4bjFPclhiWDByYkJTZXRH?=
 =?utf-8?B?c3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a3422fb-2f7d-42cb-65f9-08dc117c933c
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2024 01:36:32.4654
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 76eBJtv0+BYUH/2XwhMWH0YWJXV7J5PPDGelpyI2ILAR8QtsziJ9CuJZUaURGHGDKLhySUt1hfgXPq5bSVROjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8471
X-OriginatorOrg: intel.com



On 2023/12/21 14:59, Yang Shi wrote:
> From: Yang Shi <yang@os.amperecomputing.com>
> 
> The commit efa7df3e3bb5 ("mm: align larger anonymous mappings on THP
> boundaries") incured regression for stress-ng pthread benchmark [1].
> It is because THP get allocated to pthread's stack area much more possible
> than before.  Pthread's stack area is allocated by mmap without VM_GROWSDOWN
> or VM_GROWSUP flag, so kernel can't tell whether it is a stack area or not.
> 
> The MAP_STACK flag is used to mark the stack area, but it is a no-op on
> Linux.  Mapping MAP_STACK to VM_NOHUGEPAGE to prevent from allocating
> THP for such stack area.
> 
> With this change the stack area looks like:
> 
> fffd18e10000-fffd19610000 rw-p 00000000 00:00 0
> Size:               8192 kB
> KernelPageSize:        4 kB
> MMUPageSize:           4 kB
> Rss:                  12 kB
> Pss:                  12 kB
> Pss_Dirty:            12 kB
> Shared_Clean:          0 kB
> Shared_Dirty:          0 kB
> Private_Clean:         0 kB
> Private_Dirty:        12 kB
> Referenced:           12 kB
> Anonymous:            12 kB
> KSM:                   0 kB
> LazyFree:              0 kB
> AnonHugePages:         0 kB
> ShmemPmdMapped:        0 kB
> FilePmdMapped:         0 kB
> Shared_Hugetlb:        0 kB
> Private_Hugetlb:       0 kB
> Swap:                  0 kB
> SwapPss:               0 kB
> Locked:                0 kB
> THPeligible:           0
> VmFlags: rd wr mr mw me ac nh
> 
> The "nh" flag is set.
> 
> [1] https://lore.kernel.org/linux-mm/202312192310.56367035-oliver.sang@intel.com/
> 
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Tested-by: Oliver Sang <oliver.sang@intel.com>
> Cc: Yin Fengwei <fengwei.yin@intel.com>
> Cc: Rik van Riel <riel@surriel.com>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Christopher Lameter <cl@linux.com>
> Cc: Huang, Ying <ying.huang@intel.com>
> Signed-off-by: Yang Shi <yang@os.amperecomputing.com>

Reviewed-by: Yin Fengwei <fengwei.yin@intel.com>

> ---
>   include/linux/mman.h | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/include/linux/mman.h b/include/linux/mman.h
> index 40d94411d492..dc7048824be8 100644
> --- a/include/linux/mman.h
> +++ b/include/linux/mman.h
> @@ -156,6 +156,7 @@ calc_vm_flag_bits(unsigned long flags)
>   	return _calc_vm_trans(flags, MAP_GROWSDOWN,  VM_GROWSDOWN ) |
>   	       _calc_vm_trans(flags, MAP_LOCKED,     VM_LOCKED    ) |
>   	       _calc_vm_trans(flags, MAP_SYNC,	     VM_SYNC      ) |
> +	       _calc_vm_trans(flags, MAP_STACK,	     VM_NOHUGEPAGE) |
>   	       arch_calc_vm_flag_bits(flags);
>   }
>   

