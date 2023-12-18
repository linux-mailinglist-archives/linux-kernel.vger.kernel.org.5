Return-Path: <linux-kernel+bounces-2973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC8BC816567
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 04:34:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E20D1C2218D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 03:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C16A63A8;
	Mon, 18 Dec 2023 03:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lp5/r6M9"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4CC963A3
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 03:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702870460; x=1734406460;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=+xL5KFWuQSuJaJSW+rGlG2GYMlvyz7OrOTfHERTQWAU=;
  b=lp5/r6M9UWOmgpZR9Qwj4mCypwWZPcFzYiTOCEmaR++/nzE8EXbDsVmM
   WkUhiU4XDSarIGrc/oW1UGIRgBs3EviqUKTV5Cp8P5VMbgeMq0jffM34W
   zGzDLonEZobE6TtHWCq+Lt6KGqVc1S91aW9ylmolEtVpQi5IKkpbgvArL
   pf+3qpGEAKWeWM1XdvHTJO4mVW6AxnmDCnnrq5KZRkujyH3fiJPlBgJ84
   wQjvfiUoO6tkTZvYIAUxG7x5Iw4V62DtxFdbb03h+iCa0nq1+ny4bSumA
   57nbF8uYokCyoJp7SnDBrFkCJr2KynYS2KMmGL7gnqEZqcI05SWer25dV
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10927"; a="459775956"
X-IronPort-AV: E=Sophos;i="6.04,284,1695711600"; 
   d="scan'208";a="459775956"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2023 19:34:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10927"; a="893660840"
X-IronPort-AV: E=Sophos;i="6.04,284,1695711600"; 
   d="scan'208";a="893660840"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Dec 2023 19:34:19 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 17 Dec 2023 19:34:19 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 17 Dec 2023 19:34:19 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sun, 17 Dec 2023 19:34:19 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.40) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 17 Dec 2023 19:34:18 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l01gUNCOSUSahI4+wMZxHtjSnJNIrmyWB3oa3z39FpDJFPOdV/NqnG5n03SsyDtv6/5m2z+GdnzTAjkhse+HS7Yo+mWlNlb7ur5PA90JEe53aiOoGuTzoESsqoCxI7CvY8Vza0uPUlWntSW7fJFaVZouIzP2hgf3SMNL/DUvsauSErk9FoODp3hlb7Iy/fczlZDG/9Pc+4iNI8KVYDxunWwSEnFzTm1y3VQVuY1G2GhZSozpnYJ5JgvYryPSdK3uNQm7GTBrMNHITE8HiE9rtP8jhOm3SxTLH2+ic5/8vTb3H8o++qj5/XWnW4/2p7UI5uwNEj1F4/xJGuhxxFbImQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8N5QgYWjcdeF/5OP0Ek8tFEj1/Qujaz+vqldDZNgAxs=;
 b=lOHt96SXg/8PWrhoJuOTweGwyX1/suDzaucbNVUJNr2WEDhby7D+KnxuPDbm6RKfV0y6c1X2inNZOxW4t2zhQ8IJYXOuN3ymSZyblFa5QEKu5Xg5q2n6tyf5hl34LzEDhlXvu0f6gcHFRjzyJiAxeGntS3jeBUX1YdCQsfn+cWeAmV0LU0BB+1a5lMcpIs27e6jQEXpYFeMXBI7EulouktC8hwfKUumruZvSQDrQSgozZxuBoQNQIqrmFs6/lDhcGxOqbdd7wO6gWUu035zDJDRnY+76btIHRnJUb6OF8RjnlOTDnsNqStTuquUf0D7R01VgOVzQFR7x6YyG+Wk4BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by CY5PR11MB6368.namprd11.prod.outlook.com (2603:10b6:930:38::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Mon, 18 Dec
 2023 03:34:16 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::da91:dbe5:857c:fa9c]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::da91:dbe5:857c:fa9c%4]) with mapi id 15.20.7091.034; Mon, 18 Dec 2023
 03:34:16 +0000
Date: Sun, 17 Dec 2023 19:34:13 -0800
From: Ira Weiny <ira.weiny@intel.com>
To: "Fabio M. De Francesco" <fabio.maria.de.francesco@linux.intel.com>, Andrew
 Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>
CC: "Fabio M. De Francesco" <fabio.maria.de.francesco@linux.intel.com>, "Ira
 Weiny" <ira.weiny@intel.com>
Subject: Re: [PATCH] mm/memory: Replace kmap() with kmap_local_page()
Message-ID: <657fbdb5db945_126a129483@iweiny-mobl.notmuch>
References: <20231215084417.2002370-1-fabio.maria.de.francesco@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231215084417.2002370-1-fabio.maria.de.francesco@linux.intel.com>
X-ClientProxiedBy: BYAPR06CA0071.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::48) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|CY5PR11MB6368:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f0516dd-ffc8-4552-c08f-08dbff7a363f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bf1/i+Vfc8yzLz/EDYqjJajZlqnEn+YVfi4M7kqNpuZVH2b/48idzABEak5fm5k3xFTTB9AzDyTyIaU89Ukg5amMF8LRqE/0EITTa3oT1LjO5zzigB8kZdXczgrYLA69LzVsXXntnVJZ1u65XQfd5uUfg7i0DOPndd+I0RxT6lwXcMwrM3Z7Zmj3caUV0Tw1JI6KZaoNlzFQVzRyqs9Hzn/HoWnXC2qUka9CxlOizhx22PMUbC/dGZUYJv0rwDYy2J1915TtOSzOdTDsY3c34Via2kYq8UzomeHk7lKraaJZROfMnTQoDLrNthj6vozZ1JMKENLzkCnWk9oufnLCS8B5w8wmFhAM/btdkVfeX2K8XtpNc6GlenwWqnPVWxvbDrDUx54uaz5bApgeUdEeRNtjheyuQ33d2RxAW8soIcGu6CaXS0mxCoI8ZL1YkFQxG3CfnH7xoXXgVFahP3P3dKEYwFn5rB2aqYzNKyu0UGTV0EZI6JKVLXkdkc1vxWddRRYTpjRDnb5GiUU8R1KI0oz3YzlAvU3XJagGy6E5xj+iGUkKEC4NKFAAK1hW0aOy
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(376002)(136003)(366004)(346002)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(2906002)(4744005)(5660300002)(41300700001)(86362001)(38100700002)(82960400001)(9686003)(6506007)(110136005)(26005)(66946007)(66556008)(316002)(54906003)(83380400001)(6512007)(66476007)(6486002)(8676002)(6666004)(478600001)(4326008)(8936002)(44832011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tkw2iOrtzQn5Fz578T5S5/z2wGRUPiAhYDv5EFNLtmPKePMR4VQjYhjSM9/+?=
 =?us-ascii?Q?TK3wS5zB0bun12k2eFFB3tUYvoXRyDWK2Nv5sr8gxhsjfinjtrYySt/WKk7k?=
 =?us-ascii?Q?m9m7Y9mOaDC3+KtKVfg6P3JFhHK7GL3g67mmRbpwUISS5gqsT+2bFiYayN+K?=
 =?us-ascii?Q?/OWonRsl3AJJwIDiWFO1aOQgDKAarIr9LkKVQxaxgdNALJFisFxqHFOdQXwl?=
 =?us-ascii?Q?kmhsg+IfwcNEqhrLmA6tHs8Py8NZIZn6FcpIhqRfsUMe66D1yVeBYnRZeYG7?=
 =?us-ascii?Q?N4rxSQTe05Cn0gxR9AVgRwqmddkae313rVqMy+GUhSv7q606NicM/YIadH9j?=
 =?us-ascii?Q?6cs5EpX3QnJVNQ+uZ2+Zvo0/a7wc9kcOwXDHe2xKGtEFhA8MnVX2kmVlrmrv?=
 =?us-ascii?Q?IT8Zg0N4D+BfCe0YkiCszWgY2YvZq7rtdDS7GcqYyUSEfhbyTJV7nXPRDpVH?=
 =?us-ascii?Q?kTAz0gYwbmCKRcviDaOS6xqggUZ9khHHUF0d+ipDXy67PK/JejVUvx2ZirYI?=
 =?us-ascii?Q?4OXDO3rUeuy/IgvxIsJ31wj//qON0YboIoMT2AOUJsE4YjV8OlwuVEIi2DRB?=
 =?us-ascii?Q?8xlYfKS4njYLbABVlek2ZY+BN3jU469lv4oXFg/plpqTmxBi3XP7p8pylvOn?=
 =?us-ascii?Q?ouVo01LIPlEbkguZFxxZS21Gu4ZOvFT6kdadDccA73VOH1NOwEfUGGS1Z8wK?=
 =?us-ascii?Q?rIuRXjrdlQ1aqAFLfEXpILzcq2jewNL4CMPdANH3sMrWgg7Ot/h94wcypnl9?=
 =?us-ascii?Q?dtna+v+AwGLrnkooMzBsg5h5pkukVhupx5mw4+3JV6M/jWVnJWowCGp+kihU?=
 =?us-ascii?Q?CDtP+nzaVf7mrTz6ELG8pdXFyGoYH6ru6ebF7paEfF5DKPhMlt9629ZikQjW?=
 =?us-ascii?Q?3ADt/ivrx6yVTIdnl2VgdmBofn92GdatGMu5GW8/4EkK3yEeshPBBPsr3r8g?=
 =?us-ascii?Q?o2BJrgLCc4N4SPFaTnnSnFGmyhoCkQLPt7ZnhI3SK/GJxjJ26efDngS/N2Id?=
 =?us-ascii?Q?VoyK+dURQNUJG9FuVJ5c1hUCTnXLDohB/VGrbZvNEHgMCSFmrmOyoVHBhqLy?=
 =?us-ascii?Q?4xK3MviTVtrPHd+uSL1pGUpRLZZZgjieFpzF9Brp+MrJMzW1DhKFwOsCpjAH?=
 =?us-ascii?Q?AfA8oTTfV+DChzjWKEqzHj+iH4Jfl1itSeD+N/VnPkjB/x/KaILZBpXrY4bB?=
 =?us-ascii?Q?5n4LswJXT9jqXiJKkfjcO53Jb9Qcp/2K4IqyHg0XurCEXvtSskGxuI2BHDWM?=
 =?us-ascii?Q?GZSdPBYJ9ngwHAxpAs5/6d78LMFMh+1RmpVcWsOMTGFSQAQHlaQuQ+MVqYO/?=
 =?us-ascii?Q?P2zxENjP8sHJFa188B6NMB00vg/rRBNMoz31sqhou1yIyYEijVQRojtzDbpB?=
 =?us-ascii?Q?flYDESXZscqhukbtnRjNoHIlqoURvQn5du3orlzOqbaoOPk8j6v8YSs9Di6y?=
 =?us-ascii?Q?GixqEua8vomiHZ+8NqQijHwtBuMD+UZkqcuVVzXFjxY6XmcuQb+D0aM+kA6b?=
 =?us-ascii?Q?xwIG4K3Llutk33jczo0XK45JbgkbqQBGvA3TNkoY02htE3y+c702prJlSTqj?=
 =?us-ascii?Q?E1FBetP7ZS4ISMWtEB0sCjpSLv5Ep/manzC8Boi6?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f0516dd-ffc8-4552-c08f-08dbff7a363f
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2023 03:34:16.5535
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kt7M9pB4p0OD5xj4RE+vlS54QD6yRn1sLCmei5crj1l0UbzhU5mapSqPbbB7x46M8JKYHI3feavlf6Eqv9g76w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6368
X-OriginatorOrg: intel.com

Fabio M. De Francesco wrote:

[snip]

> 
> Cc: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Fabio M. De Francesco <fabio.maria.de.francesco@linux.intel.com>
> ---
>  mm/memory.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/memory.c b/mm/memory.c
> index 7d9f6b685032..88377a107fbe 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -5852,7 +5852,7 @@ static int __access_remote_vm(struct mm_struct *mm, unsigned long addr,
>  			if (bytes > PAGE_SIZE-offset)
>  				bytes = PAGE_SIZE-offset;
>  
> -			maddr = kmap(page);
> +			maddr = kmap_local_page(page);
>  			if (write) {
>  				copy_to_user_page(vma, page, addr,
>  						  maddr + offset, buf, bytes);
> @@ -5861,8 +5861,7 @@ static int __access_remote_vm(struct mm_struct *mm, unsigned long addr,
>  				copy_from_user_page(vma, page, addr,
>  						    buf, maddr + offset, bytes);
>  			}
> -			kunmap(page);
> -			put_page(page);
> +			unmap_and_put_page(page, maddr);

Does this really have the same functionality?

Ira

