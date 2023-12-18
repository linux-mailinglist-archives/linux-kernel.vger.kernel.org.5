Return-Path: <linux-kernel+bounces-4395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C8F7817C70
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 22:08:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D48E2B23C9C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 21:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC29E7409F;
	Mon, 18 Dec 2023 21:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QXYyKORc"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D896873498;
	Mon, 18 Dec 2023 21:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702933703; x=1734469703;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=H/lR8o3qxAOTEJOd2ZWBwLzwgDAJtbwCexCUd8ScV6k=;
  b=QXYyKORcLmC+sFZQP5R0hA7qUKHSKt8MHvsy7XHqHzRGBlEqZgjipJ54
   BmlshP1udMguD1l+BdL8cTZKEO6EUQL7cRUvg7riYjge/bp2GoKiMal1n
   GIjNc3l5ZSGNDypcD2CDGlvpincTVzaiP8Qcxlph3P6WAknsBpKcGieQA
   knBQNrgMInlk2gjo/YYDrbvzEw31m/wvMyM5OfDlfh5Z8phGLM7fW0DCT
   5C3/LyU2AYwsuJdqa39/sU3rKrIcWcPOK1Fs3zm+YVk5JPJHq3xMlOSEm
   s2BtfgV4wqkGWZ19OGa6qmpxwxzqN6NgWf9LuWKS4O3Ubce5SyLjQFtHN
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="2418541"
X-IronPort-AV: E=Sophos;i="6.04,286,1695711600"; 
   d="scan'208";a="2418541"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2023 13:08:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,286,1695711600"; 
   d="scan'208";a="23925813"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Dec 2023 13:08:22 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 18 Dec 2023 13:08:21 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 18 Dec 2023 13:08:21 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 18 Dec 2023 13:08:21 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 18 Dec 2023 13:08:20 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U69Oy/+YYLjUmUp2LJvsuat+5UoWmGTkCAL/ck2YyYJbbq9UzttB8wXtntPENqcaFVU/4RlL66+Us0EAZVUyhtZ88PrLl+La/mfvhoMGmBMybqkMCT8DqqKswAIuqJRYaUBYSmby9lfxzgSF6F31ZB/x+EtRq3Ch7oeQdfKZDCVFPJOih3S1L/7QKyrf+H+s2/m0P6Nx6Jth8SclisIvcNeBsCJcsgoS0SHVTVkT7BCRmWTvgUI0+kUVKWtDx2ANZub1MiTeeGT8Hil2KoN1gh2Q3VKSV/dQ1QQq8rWSewUh7SyEpAWj1WIyxnfR6Db4uAwQqUlAIvQyNewmGPk9cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WsjVn66BVAP2OIZDknE1gkClIQHQM3+ByYvuvCjys4o=;
 b=IPtWC4+VKENBdihu2Q3gZrqVcoYn247yia49QnCnTrh9kkGAO5zc7mau0CYHJn/guNsASPI5HJWapU/Ec01VHKwWXJC/9UccwU9wYgIMe+d2OTdvt1ND0EuFdbzzV5g3t54JYqMG34tItTh4kQx+OeDBM1Xi/f3Bs6L0fUGcZJ0ykde5bK1aqt+4LgTYeuI4rR3fktyuasp0sD4pGW59M1eU5OoKawkKulqJCkPmdKXUG6zKvbzXSkdqW79ZdwZjXtOvTMaQIKsvXkJ3MPYFFIrqx/D4JYXjiNVdJmRwQZVeZGWq4X7aecdADduiPEhfM0vlU5OC9l9MTEDnS2ZPOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by DS0PR11MB7531.namprd11.prod.outlook.com (2603:10b6:8:14a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.36; Mon, 18 Dec
 2023 21:08:17 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::dbee:4787:6eeb:57f5]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::dbee:4787:6eeb:57f5%4]) with mapi id 15.20.7091.034; Mon, 18 Dec 2023
 21:08:17 +0000
Message-ID: <ada94c85-7898-405f-8aa5-54da801109dc@intel.com>
Date: Mon, 18 Dec 2023 13:08:16 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [net PATCH v2] i40e: fix use-after-free in i40e_aqc_add_filters()
Content-Language: en-US
To: Ke Xiao <xiaoke@sangfor.com.cn>, <jesse.brandeburg@intel.com>,
	<anthony.l.nguyen@intel.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>
CC: <dinghui@sangfor.com.cn>, <zhudi2@huawei.com>, <zhangrui182@huawei.com>,
	<shannon.nelson@amd.com>, <jan.sokolowski@intel.com>, <horms@kernel.org>,
	<intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20231218070850.15870-1-xiaoke@sangfor.com.cn>
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20231218070850.15870-1-xiaoke@sangfor.com.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0232.namprd04.prod.outlook.com
 (2603:10b6:303:87::27) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|DS0PR11MB7531:EE_
X-MS-Office365-Filtering-Correlation-Id: 6666db1f-ed64-4de4-043e-08dc000d74ad
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1x82YYfDj+FzLJJIu5N3dl/8sZOvU+ZqWVAEFU0wfR50LmhrJUejcxsdC1D6zExtgQ5zgznVMnjqlL3z0O6zZgXhQDdf6oGj4kXa1daopGwydyxP0rnhrlXIR+9+Jyok9dTrmcSaulN4Cv2YVfN1XSXd5GPjlSdq/2rFyPuTmhlW85NlQ/7blSoqM2+n7Gf7w9ECIEjIgfNhmYi0kZpmoidxpKFiH9P+ig1JwJ1p4ePoSlrXLx8hbUVNk6phpbnSYFcDYIGsy7/XngrgHaXYdPHixfa890nWFTRnz2AXtp0boGH1+k3TkDnKxKuYv9x8asaD+Ed4kYMv6xd6EkDZGET9khaiNz2NeUIgOupck/HoDJmrStXYwgKD8iUWjeXlg8SoZTPdRXpIoJqadcwzYbkVUs/gd0n+oq8uBaCdkT03LA/U3zYmLALP0RoLGAbye22aptLv3TaEBLtXQBxp2rBmD/2JIf/k2RK3RxNriWdDbvMwMsGBc3w0mVkpKUJoQCqjzHzzc4AAjB5TqrIhwR71SmNMRV1HgX6cnmcnP0Pcko5d6oqcglflu0JD3SVmH/rp+kEitdZTKZvjPPluVdLl3Qgb1V8V0aFWPxlRQ/BUTnhuCAZzqA25QgAX77vpzlhpLPu3LU9JA3CZCntdsA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(346002)(136003)(366004)(39860400002)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(66556008)(66946007)(83380400001)(316002)(478600001)(66476007)(38100700002)(2616005)(6486002)(26005)(4326008)(8936002)(8676002)(6506007)(53546011)(31686004)(6512007)(7416002)(5660300002)(2906002)(86362001)(82960400001)(36756003)(41300700001)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SnAyS1poNzNQYkE0d1l0ZlVvelhtUVlxQU1KZHNQNngra09lSk5DY1ZtaE93?=
 =?utf-8?B?Ym42T2kvdi93UmxXUmNMaHNOdEFZcHNYYVN6Zk15ZFVLSEtEclhnNnlwOWI4?=
 =?utf-8?B?NkwvNy91UW92d0tkT0dKTzNtRFdUOHFWcndjaVVRRFNDU3hvSXIyVjBhWmRD?=
 =?utf-8?B?cW9OekU4a3ErcUdkQU9wNFdra3NzWjFiam8vaDBkcVQ2OS9TNFZKTGFVSWlR?=
 =?utf-8?B?WTdoc0s4TThpZ2hBK3J0S3FhK2dKcllHa0dOQis1OHg0MCtYVVNjUHB2RHc5?=
 =?utf-8?B?WDg1VTV4YjMwZnVYMmRzT1Z2WkErMVZ5V3lpbHpFWjhtN1hkV243N0dac2lm?=
 =?utf-8?B?aFRGTXFhRHVYUGQ4WWJJRWF1MlBmTTlYMjFIeGs4Wk1kRFZaWTQ4TDdGcVJJ?=
 =?utf-8?B?UUZkM1hPUDZzSjhPZS9HbS9lWFZjVGN3aTk4bXZjMXZGcm5aRVpKaE9oMlVx?=
 =?utf-8?B?NCtjc1lPckVqKzZoL2k1SmZPQjZ1Rmh4SlZEaDFzendTUFRZbnVnWmIxTmd4?=
 =?utf-8?B?MmJqUHk2UjNGV3pqa2NhUHUrUXBNOFNMTFRRZDlzVUI1dnZNKzUyUzFBT1U3?=
 =?utf-8?B?WWpjZTNHY0k4dEt0MlVjNXlzQ29oaEFKcWkrKzZlRGQyS290WUc3QnJkdEY0?=
 =?utf-8?B?eXlwM2treEx1Ym5ONXErdmNwNzRVSkxFRnd0Qjk4RjQ2SEUxMWFiK2J5NFZ2?=
 =?utf-8?B?MHduOWlaZWx0cW9nemJCaUFzSEVJRE5TQ1JOaHVXUVRZVDNqYVhWNFBNRXd1?=
 =?utf-8?B?S25VZ3hYR0JNbXRGZlp1Ym1lTXhOSXplV2QvT0tsaTIxa1BrOFFMSlJFWEVq?=
 =?utf-8?B?NDZzbzF0L0VHSm41bVM0M0JialJwYnFwZDlSa0JTMDJnU0pnR3pPZ0MzZ1F3?=
 =?utf-8?B?bjA2TEpBMjdxQ0pQb0NXNkFJQjg3cktzTTBCd0pYQXN3UWo0OFlNL21ZR0py?=
 =?utf-8?B?cVVMd3ZZYmhCb0liS0t4MUpQdGlkaU1vRTIxNlQ4cTJUUFNZOVBPU3JnOWJI?=
 =?utf-8?B?MkQ3MW0yaDE3a3JQazIvVDlKRjVYL0tQWndBYmZIVktUTExlTUl3ZDFOMWpw?=
 =?utf-8?B?N2s2NWhnWDNWdW1BM2c3NXdNbllFREJkaXNCaUtXeTJLMzJRTndkWUsxSkU1?=
 =?utf-8?B?SHVyYWExVnk2VWxMRlRESDBPc1ZhNktncHdKSWoyZGx3U0FoS1ZtU1JVdTZN?=
 =?utf-8?B?TUxmVHM4L2xRRFZRZU4vTXVsS0hVZ2FZd0JxaDlPRHBXSU9tT1I5RVVmZFNC?=
 =?utf-8?B?Y0o4QWlJTlcvb1VScDFXVmQyZWhILzhCNzEvbjJuMDdhYkpON21WSVJHdDhU?=
 =?utf-8?B?SWdwSGxJMnhwTlA5MGw0NmZCVlBZcCtJNVdXcldrWDg4aGkzVU9vTWtVdlFG?=
 =?utf-8?B?TEZpdGprS016b2YzaGR5enlNanNNdkdMRklmY2NrWjBHcTdDM29Ub3ZQUG42?=
 =?utf-8?B?dDc3SmgveW1BZ2ZYNXlUaXVzbC9qMjV3ZkMrcCt3QVBDUkdVQzNJeFhnT015?=
 =?utf-8?B?emFEeVdjYkRGRGZvNmd0NTJMMXVTeXoxM1VZY1BLQnQrRHQ1UDZHWGJUQTlw?=
 =?utf-8?B?MlRVRXh3TDA3U3hpQTVUakthQS9adkxFN3RSWi85MTBMOFZnMkExQlEvcmh0?=
 =?utf-8?B?SGRrVitJV1p3amVNT0lxZGVNcFV4R3E0WjlBYks3Zmgrd2ZGRWtVWStCd1Fz?=
 =?utf-8?B?cG12M001U2l5cTBhZld2eWxaTk1NWGZTUld4c3o1czJ4SHRncmptOVl5WU11?=
 =?utf-8?B?YzltZ09Ca2RyRlZaY1BNejdNWGFjS3FrQ0tyOUc4dUc2VkNtaFNpVEtSWUZm?=
 =?utf-8?B?ME4xVVhXWlEwQ3BrSThEakw2NmpUOVlSN3NPb1VFS3Rtajk5d1phcW5lMHRr?=
 =?utf-8?B?WnVRYWFWeGRMZ0Qrdlh1ZU9GV3Q3Umk0TU5ETnVsSE1nRXFpSFFMbDZOckRZ?=
 =?utf-8?B?cVpIa2tZdnN5L1J4VmNnNXk3Q2lZZUxDNE1zdlAzMUlIRTF4b29HZEhsVFpQ?=
 =?utf-8?B?anA2UEtRVnc0bkhjcVlFNk1HdTIzcDRYSU9EZGZQOUlLd0tLWkdpK0NBMHpM?=
 =?utf-8?B?Ti84ZUVqK0RoeGR1MkVkRkN1K3F6bjQ4aDA3RlkxM1NjR2NqanYrTUxrSnZG?=
 =?utf-8?B?bkFWaXgvdXpSeTE5Q1M5azhyMldRSmpHM1ZKM0pxQ3grcjEyNlc4ZEtRV3J1?=
 =?utf-8?B?Y0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6666db1f-ed64-4de4-043e-08dc000d74ad
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2023 21:08:17.2956
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lUT/T4vooFfMcMmYaxNnWPgqnYwlNXYbF88e6z7/UGEPVed1ec05txNdbhaXOhhEPHTWsTLU0YmLIclQhNdLsyyNsWNCYhyIyTQL/2iAqY4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7531
X-OriginatorOrg: intel.com



On 12/17/2023 11:08 PM, Ke Xiao wrote:
> Commit 3116f59c12bd ("i40e: fix use-after-free in
> i40e_sync_filters_subtask()") avoided use-after-free issues,
> by increasing refcount during update the VSI filter list to
> the HW. However, it missed the unicast situation.
> 
> When deleting an unicast FDB entry, the i40e driver will release
> the mac_filter, and i40e_service_task will concurrently request
> firmware to add the mac_filter, which will lead to the following
> use-after-free issue.
> 
> Fix again for both netdev->uc and netdev->mc.
> 

Thanks for fixing this!

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

> BUG: KASAN: use-after-free in i40e_aqc_add_filters+0x55c/0x5b0 [i40e]
> Read of size 2 at addr ffff888eb3452d60 by task kworker/8:7/6379
> 
> CPU: 8 PID: 6379 Comm: kworker/8:7 Kdump: loaded Tainted: G
> Workqueue: i40e i40e_service_task [i40e]
> Call Trace:
>  dump_stack+0x71/0xab
>  print_address_description+0x6b/0x290
>  kasan_report+0x14a/0x2b0
>  i40e_aqc_add_filters+0x55c/0x5b0 [i40e]
>  i40e_sync_vsi_filters+0x1676/0x39c0 [i40e]
>  i40e_service_task+0x1397/0x2bb0 [i40e]
>  process_one_work+0x56a/0x11f0
>  worker_thread+0x8f/0xf40
>  kthread+0x2a0/0x390
>  ret_from_fork+0x1f/0x40
> 
> Allocated by task 21948:
>  kasan_kmalloc+0xa6/0xd0
>  kmem_cache_alloc_trace+0xdb/0x1c0
>  i40e_add_filter+0x11e/0x520 [i40e]
>  i40e_addr_sync+0x37/0x60 [i40e]
>  __hw_addr_sync_dev+0x1f5/0x2f0
>  i40e_set_rx_mode+0x61/0x1e0 [i40e]
>  dev_uc_add_excl+0x137/0x190
>  i40e_ndo_fdb_add+0x161/0x260 [i40e]
>  rtnl_fdb_add+0x567/0x950
>  rtnetlink_rcv_msg+0x5db/0x880
>  netlink_rcv_skb+0x254/0x380
>  netlink_unicast+0x454/0x610
>  netlink_sendmsg+0x747/0xb00
>  sock_sendmsg+0xe2/0x120
>  __sys_sendto+0x1ae/0x290
>  __x64_sys_sendto+0xdd/0x1b0
>  do_syscall_64+0xa0/0x370
>  entry_SYSCALL_64_after_hwframe+0x65/0xca
> 
> Freed by task 21948:
>  __kasan_slab_free+0x137/0x190
>  kfree+0x8b/0x1b0
>  __i40e_del_filter+0x116/0x1e0 [i40e]
>  i40e_del_mac_filter+0x16c/0x300 [i40e]
>  i40e_addr_unsync+0x134/0x1b0 [i40e]
>  __hw_addr_sync_dev+0xff/0x2f0
>  i40e_set_rx_mode+0x61/0x1e0 [i40e]
>  dev_uc_del+0x77/0x90
>  rtnl_fdb_del+0x6a5/0x860
>  rtnetlink_rcv_msg+0x5db/0x880
>  netlink_rcv_skb+0x254/0x380
>  netlink_unicast+0x454/0x610
>  netlink_sendmsg+0x747/0xb00
>  sock_sendmsg+0xe2/0x120
>  __sys_sendto+0x1ae/0x290
>  __x64_sys_sendto+0xdd/0x1b0
>  do_syscall_64+0xa0/0x370
>  entry_SYSCALL_64_after_hwframe+0x65/0xca
> 
> Fixes: 3116f59c12bd ("i40e: fix use-after-free in i40e_sync_filters_subtask()")
> Fixes: 41c445ff0f48 ("i40e: main driver core")
> Signed-off-by: Ke Xiao <xiaoke@sangfor.com.cn>
> Signed-off-by: Ding Hui <dinghui@sangfor.com.cn>
> Cc: Di Zhu <zhudi2@huawei.com>
> Reviewed-by: Jan Sokolowski <jan.sokolowski@intel.com>
> Reviewed-by: Simon Horman <horms@kernel.org>
> ---
> v2:
> - Order local variable declarations in Reverse Christmas Tree (RCT)
> 
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
> index 1ab8dbe2d880..d5633a440cca 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_main.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
> @@ -107,12 +107,18 @@ static struct workqueue_struct *i40e_wq;
>  static void netdev_hw_addr_refcnt(struct i40e_mac_filter *f,
>  				  struct net_device *netdev, int delta)
>  {
> +	struct netdev_hw_addr_list *ha_list;
>  	struct netdev_hw_addr *ha;
>  
>  	if (!f || !netdev)
>  		return;
>  
> -	netdev_for_each_mc_addr(ha, netdev) {
> +	if (is_unicast_ether_addr(f->macaddr) || is_link_local_ether_addr(f->macaddr))
> +		ha_list = &netdev->uc;
> +	else
> +		ha_list = &netdev->mc;
> +
> +	netdev_hw_addr_list_for_each(ha, ha_list) {
>  		if (ether_addr_equal(ha->addr, f->macaddr)) {
>  			ha->refcount += delta;
>  			if (ha->refcount <= 0)

