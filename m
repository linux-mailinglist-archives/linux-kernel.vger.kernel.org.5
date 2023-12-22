Return-Path: <linux-kernel+bounces-9483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 02FEB81C650
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 09:14:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 709631F2293E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 08:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13409C8CF;
	Fri, 22 Dec 2023 08:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RiR/w/iG"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5792FC8CA
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 08:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703232836; x=1734768836;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=DEWq8MKvLoFbVOy52/JeSSpJjy4WamNIRCoCy5tcjTs=;
  b=RiR/w/iGtbFmCBwNMor855eo9p6OMSaBqhdBOJUe0fhQe5WkrMc05afn
   1Aq/ol4sGBmAAGuU4vY/knAqkS+9ABaHASWTv8aBcgVhaiz7y7hZy4mcz
   0i7QlczJ+tdTu8RwD49AMyS0vW5j1dE37wyHJHzULzJkwKfi+3YkLyhVP
   wbalAXr+vfBTi/mCcjvr5PaARYkrfSp2RPqg546xMYvy2hbkd30KZ0R4j
   RzU6sAYcw+Qv7R43sN4twoJ0zN0bzINmAW38HYeZ4Cg7SLqqm/g+PY3qN
   OjAJG1gmltNJkjQa1F9iQ0VRSy/caN34aIQvN3rFipsBwcAwSWAHxcA5q
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="14773045"
X-IronPort-AV: E=Sophos;i="6.04,294,1695711600"; 
   d="scan'208";a="14773045"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2023 00:13:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="770223602"
X-IronPort-AV: E=Sophos;i="6.04,294,1695711600"; 
   d="scan'208";a="770223602"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Dec 2023 00:13:54 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 22 Dec 2023 00:13:54 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 22 Dec 2023 00:13:53 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 22 Dec 2023 00:13:53 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 22 Dec 2023 00:13:52 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=blpnDzyMuQn1ikEymMpYFwa68XlW9+CxlHiCbWvQFFZ0A0mSpv+Tmg32nTXWiiGCx4U4slYLojE/zzmpxtsdUV3hohSrP0SqKKQxjh2yhuSmdtR49zGMt0F0bYkX1kVTqJb+1sRHxJYhHWrweRNHAq/C4Dk6NCVstuqFhD5zqvpllAq+11HxD+uV7fY/x409sXdPkZDiv3G1qq1grPkt/nsmGjbwIKXJe4ApOGQoKg5D00IQ5eqYrFkd/NaxCmKqMbWp0pju+8CmBFvDXx6lBQeOkPcG4PtTT2GcfviqqGy2LNR1sWlg+u/EG6qO796THAiZGWqEwH01HVLO345JOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GlP2R90jozN6LOL3/F730OvpXx4gf6escRueXwRIR8A=;
 b=oNl69nZWCjKGWq3w+8uRbm9dzp8f4Ej5ZN+nnEpk3LGXtPbBHC4dfylOf4wAXEAupuu6Dn5WkJYtPTUg+gbaSQ/5OaTQq1nNRRzD/9i61JNsLGlRCKhzbKexGNXsDIeJtKY9MJVjU/WZ95Q5EOsBigaX8nh6pNvayAr3ozGUA3x+T+Od6d5OZyTpvgJl6CALfCQHawtLYojkv70CAYMagX5rqicL30d4MYBIq21BCdTiLpFXVmXdR9e+IzqdeMuyNRrQrvi6Cg34NOee9xF9WAbTav/H7bIIPTi5IqZiECHLMGBl/LTY9ydMWXTM9cNfur2Ww1KWWv1E/L4vFwh+KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SN7PR11MB6703.namprd11.prod.outlook.com (2603:10b6:806:268::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.18; Fri, 22 Dec
 2023 08:13:50 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::1236:9a2e:5acd:a7f]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::1236:9a2e:5acd:a7f%3]) with mapi id 15.20.7113.019; Fri, 22 Dec 2023
 08:13:50 +0000
Date: Fri, 22 Dec 2023 16:13:42 +0800
From: Oliver Sang <oliver.sang@intel.com>
To: David Hildenbrand <david@redhat.com>
CC: Andrew Morton <akpm@linux-foundation.org>, Matthew Wilcox
	<willy@infradead.org>, <oe-lkp@lists.linux.dev>, <lkp@intel.com>, "Linux
 Memory Management List" <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: Re: [linux-next:master] [mm] bbcbf2a3f0: kernel_BUG_at_mm/memory.c
Message-ID: <ZYVFNvyG9uX2Q9do@xsang-OptiPlex-9020>
References: <202312192319.fa8f5709-oliver.sang@intel.com>
 <20231220141135.cb4241442b657104f0aeae34@linux-foundation.org>
 <ZYQgGmYNfF8j4JqL@xsang-OptiPlex-9020>
 <e0e7d631-0af4-46fc-b606-78de07ebb88a@redhat.com>
 <20231221135833.92b8b2a97b28ad0545977f6c@linux-foundation.org>
 <6a8f2110-fa91-4c10-9eae-88315309a6e3@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <6a8f2110-fa91-4c10-9eae-88315309a6e3@redhat.com>
X-ClientProxiedBy: SI1PR02CA0048.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::11) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SN7PR11MB6703:EE_
X-MS-Office365-Filtering-Correlation-Id: 945b15b6-0283-46db-16d3-08dc02c5ee07
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 70RXtBbfTHhUWeD70eOOUAyBK2b++REY3/ZrzBEbmMrPrdF/SvA5NV9HLyxO+ls5DYTR3pxNyVDsx4eztMvkCK3tTzFCg5cVJpD8rTjCqKVyx1BtFVkY1fzofksNOnWMtQl1RszVOGUGZEl9SOLfY7zM4dmjH/Y9/VAKRsdXp4YyAyR8WJ8kYxsrkITskd47wqvgv0rk9qndn9x4X6liYmMk2Yt8CiVMOncbEYmA2fKlygwm3ri3sgWf7Not4wJcUk0jy7u0OftRva2ur9bxTuvpZRPeuNvNheCO3zFaXcSBsEtNTxKyAI4E0fwXoVDJ2hQ5SrwgY6uCIOPzZFagjCLMqEVLryTYyFDlU2isfDt9sGf9NQ2Kn8oMw+tGZr0118Ot8OwbdGqhdAHvIdjOh7prs37LQNdXqwmVgKxt3ejVkc57pppJEIzX1Hkaxa0Dj78fKiXw6bWVB0CCyy/xOqO0KXR4jHeztJ5ymt3VLHp+RbS+1fs8XwMifP0MviXeDEX1sS6IrYmHYS+HTmt6BU7aAdGvXEOnInHBznHZM9Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(136003)(366004)(376002)(346002)(396003)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(8936002)(8676002)(82960400001)(5660300002)(66946007)(66476007)(66556008)(54906003)(6916009)(316002)(9686003)(107886003)(26005)(83380400001)(6486002)(38100700002)(966005)(478600001)(4326008)(44832011)(33716001)(2906002)(6506007)(6512007)(53546011)(6666004)(41300700001)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8dewVbaUFxCXMNi2IPvV8hv+ghBB0p1tSaBxkAxT78wfawWb0KzDwu9mUT8C?=
 =?us-ascii?Q?VX/dC5K+o0W6MW7sE6dQVa/e7Vln1FU6zZLdi8tMaRbLA+9U10hQveRjJljA?=
 =?us-ascii?Q?OByyZ/nUFulTk6fJzKSsMQxtqAd6BrJkJhU5Ykq3AtDV9PMSkUT+eylDQVjo?=
 =?us-ascii?Q?Gmr3wwivTce4/0Miys9ZWeW1J+ftqD+6Xz/09CDaU+ElwN4n2I9ASveDwIY/?=
 =?us-ascii?Q?bryOqZ8u/cniuR8o439FLS0EsvFvJ18zPIvPNErzxEwaN4AqMgolg/ClSnLc?=
 =?us-ascii?Q?+t3tw8NjtutswiKtURGVWspmWOWDVAK/hccjgBAznkSUv/mwjhQPWW2BTZZp?=
 =?us-ascii?Q?953HSGxdEwrPCxIZzhxEL7Jf8DdNGhcBqECvrZkQODl3D5/2n8KnYLGuWb1w?=
 =?us-ascii?Q?dnBzTAlifwC73pYpxcqh3rnIl7IFosag4NLku6d/8kU39G407Px8qePlGfzC?=
 =?us-ascii?Q?atrZCd2YWD0uIJBRMi9fqtsJf21qs3HBDsUPHlbRVhUgQkpreuvtMHZ/c33B?=
 =?us-ascii?Q?6QLOaXOenQTj/CxeTLudqdQ7EwA63W+2B1BiC28mLvQ9nEmmFjGKmWjluIOV?=
 =?us-ascii?Q?WC+qew2wkFg3fb60gfY1CJzOzSrM0zZHoqxCdMSFRc54bDjSpItpAJbtjWs8?=
 =?us-ascii?Q?SqPgKIOVv4Q/MEPyklLzi+/NXWY6M09o2OUXMSE+JpgX6I1Ad5yrUdiwSx3m?=
 =?us-ascii?Q?Ysxa4CrLeQKWArNJ2e068faxCNykXYwcXS/KwkYRBqA02ki4FIE9bxfJ2mNZ?=
 =?us-ascii?Q?3CP/K3GT3DOLgIx9c03SG3Xxkuda7oSEAIf1SfpZC9G0UBPXeGy40LSiuxXZ?=
 =?us-ascii?Q?JgGhCejDUr+wOS5EsvZXluGECWhhFCcs1H5SKejgkHsvc3srnEE285p/yWyH?=
 =?us-ascii?Q?OOqXgymlOGScfc3jZaHsEa/kenGHIq7DX9ccQyxp5UIIX9l6O7mY2xWjj6f1?=
 =?us-ascii?Q?OV7z4Gp6+3t49mlUZ7XfC1gn51IBkzd7ND57gzwVgBEQ1aSyU7QN5w8jth98?=
 =?us-ascii?Q?C60+g1bjIZsl30q721WZfulh7tYaj4+sy+oNm1xhbUq/Ng+JvaiW1uPyvBTp?=
 =?us-ascii?Q?JdWUC+Dl7FYVU+G9++gldn0UOq+5WBhxLqvlVPx/7HE1EstWO3T75a9uXhTQ?=
 =?us-ascii?Q?f/hK7xxWgqlwzBXGry60uZuHW0MCEdE/FBNdKsjKtFncEQmH7lzAt4CL+eae?=
 =?us-ascii?Q?31WMLO8RBETvWme1fgnStmfUvOLgNtEnIvhy1ZKBIWEdAyokAj7Cr+AiIVYy?=
 =?us-ascii?Q?YNU3H8Y1YROy6K32+0hQmL+3QGQeSxihcmWAIH5LU1RCnvsP8PKQ8G+E+ia/?=
 =?us-ascii?Q?+A+Ew9d8fHXSV+i1OdGtNJy6GfqajUCoC0yKYBMZpjEm292iw0LP+CKjJu5W?=
 =?us-ascii?Q?9NaGU7WXvw8e6yX8eGvAMTNOnCP0JuCyLi4DG7IBr1wlyo6KZAoJgmkQP02J?=
 =?us-ascii?Q?isr10nJA83c8hk+uVEGPxKB+9X8tX8jTBPY7VXY7uP+4tOZnAll7iwWzMC5l?=
 =?us-ascii?Q?sCFGVMvL/JTGsClE/fVTLwdgjJnSqc41h4jjR8M4R4JZVIia6PGUHriqqtls?=
 =?us-ascii?Q?kVi7uVVQ/jPU2WBePQhAk2Tql5Mb6gvIPjCDdb3hC0Qx0Q1b9DoWu+LRp667?=
 =?us-ascii?Q?uw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 945b15b6-0283-46db-16d3-08dc02c5ee07
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Dec 2023 08:13:50.6299
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fkqmldEUBsyuwkXBXY7ddc1BeTSa895r0dkVIK7bbq/FNEQXsHH57f87/yfQvZZCl8YVTcqTfRWcSk2/pl07Dw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6703
X-OriginatorOrg: intel.com

hi, David,

On Thu, Dec 21, 2023 at 11:07:21PM +0100, David Hildenbrand wrote:
> On 21.12.23 22:58, Andrew Morton wrote:
> > On Thu, 21 Dec 2023 12:32:04 +0100 David Hildenbrand <david@redhat.com> wrote:
> > 
> > > On 21.12.23 12:23, Oliver Sang wrote:
> > > > hi, Andrew Morton,
> > > > 
> > > > On Wed, Dec 20, 2023 at 02:11:35PM -0800, Andrew Morton wrote:
> > > > > On Tue, 19 Dec 2023 23:46:50 +0800 kernel test robot <oliver.sang@intel.com> wrote:
> > > > > 
> > > > > > 
> > > > > > 
> > > > > > Hello,
> > > > > > 
> > > > > > kernel test robot noticed "kernel_BUG_at_mm/memory.c" on:
> > > > > > 
> > > > > > commit: bbcbf2a3f05f74f9d268eab57abbdce6a65a94ad ("mm: convert ksm_might_need_to_copy() to work on folios")
> > > > > 
> > > > > I assume this is a bisection result, so it's quite repeatable?
> > > > 
> > > > yes, we bisect to this commit, it's quite repeatable:
> > > > 
> > > > ddd06bb63d9793ce bbcbf2a3f05f74f9d268eab57ab
> > > > ---------------- ---------------------------
> > > >          fail:runs  %reproduction    fail:runs
> > > >              |             |             |
> > > >              :6          100%           6:6     dmesg.Kernel_panic-not_syncing:Fatal_exception
> > > >              :6          100%           6:6     dmesg.RIP:do_swap_page
> > > >              :6          100%           6:6     dmesg.invalid_opcode:#[##]
> > > >              :6          100%           6:6     dmesg.kernel_BUG_at_mm/memory.c
> > > > 
> > > > 
> > > 
> > > Can you try with the snipped I sent? Please let me know if you need a
> > > full patch for testing purposes.
> > 
> > I think a full patch would be better, please.
> > 

we cannot reproduce the issue reported previously after applying below patch.
Thanks

> 
> From b82e309096abde6c0f24bba50a281e8d3855c132 Mon Sep 17 00:00:00 2001
> From: David Hildenbrand <david@redhat.com>
> Date: Thu, 21 Dec 2023 23:04:30 +0100
> Subject: [PATCH] Fixup: mm: convert ksm_might_need_to_copy() to work on folios
> 
> We must only adjust the page if the folio changed. Otherwise, if we
> had a large folio in the swapcache and the folio didn't change, we'd
> suddenly change the page to-be-mapped.
> 
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: https://lore.kernel.org/oe-lkp/202312192319.fa8f5709-oliver.sang@intel.com
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  mm/memory.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/memory.c b/mm/memory.c
> index 149f779910fd5..2f9668d357f5c 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -3952,7 +3952,8 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>  			folio = swapcache;
>  			goto out_page;
>  		}
> -		page = folio_page(folio, 0);
> +		if (folio != swapcache)
> +			page = folio_page(folio, 0);
>  		/*
>  		 * If we want to map a page that's in the swapcache writable, we
> -- 
> 2.43.0
> 
> 
> -- 
> Cheers,
> 
> David / dhildenb
> 

