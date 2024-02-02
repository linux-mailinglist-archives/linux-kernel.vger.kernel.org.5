Return-Path: <linux-kernel+bounces-50649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3644847C14
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 23:10:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A99B282B60
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 22:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 212AB83A1E;
	Fri,  2 Feb 2024 22:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TYoRYbUY"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 189D283A10
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 22:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706911774; cv=fail; b=E65wdcDmwyjb/s+Fzoe6vqTt7hJ5TFUF+cOdAG2Xz/kksSY+jJhXt+r0gEkIEfuhtIPSFAG+1kNsmgcbpz8IiFGqIyz8wHPB2nOHIP8hZHuyA+jWq+zQkJrn63DVNpBQcN0CvwmW0f8Suzl7Gk3wFTrz6WIuE86/WJfpxAQ1j+c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706911774; c=relaxed/simple;
	bh=XvHaGkZZGKPAjAQITZENrhhp+DKeBF2RLl8PNm0AibA=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NCquP8KKtwtln+IRwwYwmMQUftbNCEl28jy3Lv37upiKiLXhDrEs29gNqcX75ds/Bew6R5eDiBUz1+QAFefmsQZpf9e0DypwUu7vGJjcPKxwaBC7VUqjgHUldP7bo2HpTtYnP1jnqsbPzWLtmg9R0qW5KGpRFeOoioEKMki8knI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TYoRYbUY; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706911772; x=1738447772;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=XvHaGkZZGKPAjAQITZENrhhp+DKeBF2RLl8PNm0AibA=;
  b=TYoRYbUY/ZGBCmQmDhHPFD+g2Z3E84nznunKw+SVlT6sHuYNkyV6M1WR
   71rLEnBmS6wjK6mnZl8WRPSBmjLJTk6v3jPCdyXdrewk4YuOO39Ua85Yg
   B3ENT2CPgYkOqlI1Spzbqsp+fOx8KNOKZLStJY4eCVjaB7dfBI6ncowhu
   s2TzP56b7HX6bTEmzvx4tRKuRUKWEJa1Rb4TvbWDpyEtb3G6zgDGLD2Wy
   hgn/6d/3B6wjzEfYgzLDDzUJO0nzYzr0lNzdTEbsHluVJkqpGj9sATcxl
   67H7/GeDIEAUAjhRaQ3fjnrxZSGfmHq2fcAM3anS4meIX+FI2gexngZP9
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10971"; a="11616624"
X-IronPort-AV: E=Sophos;i="6.05,238,1701158400"; 
   d="scan'208";a="11616624"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2024 14:09:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,238,1701158400"; 
   d="scan'208";a="193840"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Feb 2024 14:09:31 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 2 Feb 2024 14:09:29 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 2 Feb 2024 14:09:29 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 2 Feb 2024 14:09:29 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mneoEjJuAtCgWIv3FGcgmJRhV9RepG3SdFEUC9jX0i6PJ01Hpt/pQAm9WAsir6CLpIudq+Ewg5rqfzgnrhn+4eHY+8uhKodj/YZtTESiKgfLBwX1V7jeZ1Ct6NXkbaN9ziZ5x3XIQ9B1mrOLMO8HzokY21uqV9LX/elmoRJsu9oV27vql/zoirnczdoN7LcGpqDn/gVFt8yYMx2WmF4P0CdRB2NmH32yew+gK+PpxmkJkvY0mqsC99vnaLLduz0+LTEMkoZTvzYMAL9KNqibHKtLKETd/Cyg/+r8tbbXsHEzSipeMrI87VoQH/B8w/HsN2wD2tf14egLJw/71z2UZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u/o4rsjnG66CpjnJP9IHAfn9tgbcHVydTVSpb0TvMlE=;
 b=Xq3B9axCiuffNbJ1Qq25BLBMO/hX7b/bzDluvg4D/Vh4OJzTFvbWChVfCNcXhLS5ohtRrxn4kFcANUTZrCBEKvsTVa/d4PaP7BO1JvIoANKGvB64u+V3o5sJcCt6JFeTA2o4QnTwuLQf+c3qsMfeRv/orG+K3dvE3geOknfeiZ9qlPSplFDdGPomCWdD92dHZeZ6xvvEa6Gj3WNksrG5mYp8ZJ0i/GqLTn7Qpjrai7BmrUAhL+WzL0+FsBGp2AHj0r9u5whqIwiqghLioFzbOz7+yAYbRbW6HfmjaigW4BmWQjP40mj0LTzwjnSNLtLAWDYWjFePXq9KqgjAVXGXeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6139.namprd11.prod.outlook.com (2603:10b6:930:29::17)
 by SJ0PR11MB5166.namprd11.prod.outlook.com (2603:10b6:a03:2d8::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.30; Fri, 2 Feb
 2024 22:09:21 +0000
Received: from CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::9f32:ce50:1914:e954]) by CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::9f32:ce50:1914:e954%7]) with mapi id 15.20.7249.025; Fri, 2 Feb 2024
 22:09:21 +0000
Date: Fri, 2 Feb 2024 16:09:18 -0600
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: Arnd Bergmann <arnd@kernel.org>
CC: Oded Gabbay <ogabbay@kernel.org>, Thomas =?utf-8?Q?Hellstr=C3=B6m?=
	<thomas.hellstrom@linux.intel.com>, Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>, Matthew Brost <matthew.brost@intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>, Arnd Bergmann <arnd@arndb.de>,
	<linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>, Matt Roper
	<matthew.d.roper@intel.com>, <intel-xe@lists.freedesktop.org>
Subject: Re: [PATCH] drm/xe: circumvent bogus stringop-overflow warning
Message-ID: <sbbfz5zzdjj7hjcmyqvof3roe6zb43kflgmweopfu65hllxdep@m4pxjiuqxood>
References: <20240103114819.2913937-1-arnd@kernel.org>
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Disposition: inline
In-Reply-To: <20240103114819.2913937-1-arnd@kernel.org>
X-ClientProxiedBy: BY5PR17CA0014.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::27) To CY5PR11MB6139.namprd11.prod.outlook.com
 (2603:10b6:930:29::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6139:EE_|SJ0PR11MB5166:EE_
X-MS-Office365-Filtering-Correlation-Id: fba9ed87-60e6-4036-98fe-08dc243b9b7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f/jVuzxwilFeP9lfjdd/k4UBVriNyN0jiWWcnjPTWNgHNNo2i9Zv8jqXxE0UiYaeSm3+iAjhLze0ZCwdX2xNKMll5WUcYGa0Y7M3Yu5su+ElHgHu38uXCNmOEfKexll7Or+cI9EixCishdlrqZrQ1bOssSx75smo6OEyRNrxMcpRtigtxHo3FIlVKJDgtiOo+8suAprD870PckYU0l/KqetDDCjAAAUK3EKs3QXl1EKU+z/HG0Aj8MTXiU7MLES9CxrQCAOCrvhgKSAC/G4gNW51YxfGF67Baq6/A/GvuFgemhP1uSKidTfAmdfLzf1tJmadZMWqxIZHh+YrakEL+Fe1YfEL13WMMitjq+YDhs3godgr5W7O5+r6uIsK7FK3Bd5Nu83gltar3Fg7k/Qi0Zy+rPt9Tgw50j4BPE7QH529F9d3mHYnKNi2QBxuMEhpe0DnFYn6CJ53eSDI3dD78Miy+JVsHBr5h8EiRZ76wbwMfdJpp8DVDMdp3PUYX0a7hFHf3elYlHQ4/Ndx28GVYx1Zm9pH/Talu7/fKucUA/4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6139.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(396003)(39860400002)(136003)(346002)(366004)(230273577357003)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(7416002)(9686003)(6512007)(4326008)(26005)(6486002)(966005)(33716001)(41300700001)(478600001)(316002)(6916009)(8676002)(8936002)(54906003)(86362001)(5660300002)(66476007)(66946007)(66556008)(6666004)(2906002)(82960400001)(6506007)(83380400001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MjVvvisK52O/VFzNp3UnP8kke8KJZ8kDNJC8/oD7imzSdwrgQsgGizpwSGUt?=
 =?us-ascii?Q?qryE0X/j/QeyNHz7E69tuOaWe4RzNXTXVxJ6ctHFzRjujdihjceDz3lkTkN5?=
 =?us-ascii?Q?FvB4xlyv7q7DUxVHJdCcF5wV3kteD6L6DqXGCu0EO67hoero/2Po5RDYpLuI?=
 =?us-ascii?Q?mLKtd7126+0T5QLasjLC6EqdkxCyXISXc/dh6KXmQlbHqhMpHFuEsVOvdBRT?=
 =?us-ascii?Q?NWMh6tg9G6jf9vNJ7v8hAj1LvKslw1rAkRKW9OYP/oU/KpkkY5YKVH8UFG5w?=
 =?us-ascii?Q?EBqJOeUTPSs/lbCINE1gg7dusWl0YJI9RLKJObd75bbQ5lFFyVM93VdHabFS?=
 =?us-ascii?Q?BAwngYrUb6DECeZcuC3tHWANoaDXx+JQ93qQQXqGjlLPde9X58q5p4o0XZHG?=
 =?us-ascii?Q?0HE65RdmMcNPMF4LITgujiH5OfYJ43NOONkQQFl9+wn6vHEsxL9qwPRkQo/h?=
 =?us-ascii?Q?aSB8j7i5ss7FJmyhYNsDvs13Q70+uxcdHPmU8dvEqwj2xiFFrtLRcT4VbqAn?=
 =?us-ascii?Q?9ynS0vQVrtM4ORVM1FStyzyWYdyhvOnIVCnXF8TYuffEL6K3NSk5x8ve1Sam?=
 =?us-ascii?Q?IatbPTtwT4wMOkMPYobrikLzQMlCGZkFhoNvxuj+Zuz/odYE+gTNMp0AQumB?=
 =?us-ascii?Q?5yygGSHq4hCaquAbC9+Ko71A6K2d7J2tQS/S8Me4LGBtsuV4p/qCieE5MtTR?=
 =?us-ascii?Q?ojcSt1gswRQ70RyO+BfMNPWjacSF9uhw8qg0yXNyqNZNwidOF5e/rGA/wDvL?=
 =?us-ascii?Q?bSrK2bB+wq+G5zTIj0jZ4XJECHqQPDS/tHuQbJG2raxi7/VfkmuijVwsKcfM?=
 =?us-ascii?Q?ySDNxyC4ZEyCMFMxU5IFPI7oKg+It5QudW7nBQQsrMZ22f/7/El81k60T4P+?=
 =?us-ascii?Q?2LlUDtRxWUc3Et+hFUe+kAL5peCCKw5aBMxH8rizJeNTRdPMX+cPakVDO36h?=
 =?us-ascii?Q?8yB9XOSLdR0Aia4fVO72b0KynOEABn/0UOEdFq+tY6JNHdJo6OqfHf2H0712?=
 =?us-ascii?Q?FC/+i0cCrCRFUnDYz07691IG2pxvfEfSEbpK8LuXzOtQkuJTY1HSX9HpPsaZ?=
 =?us-ascii?Q?6ILpNrY2NNaxpjhJJ1EhHLfIIltcBygtcVyFS02/7f2Q9SXaJ2NDhdWBp6Xg?=
 =?us-ascii?Q?XAF5580RIkKgxohT2TZ6oPxpJKeAaA1n+7/qG8wA4Er3n/EGZQxoLm1XOyUN?=
 =?us-ascii?Q?ncSRL8oAImXD0nJtjR8xOIhrEV82X2kKfgi9jiq7aYulZxLq1sg/EOaJ+wsD?=
 =?us-ascii?Q?XS+KKmXk2+I9Mv4pWPFh3GqdifDAEIqgce84UPOFVKvHLvkyVVA3fBgrQF6U?=
 =?us-ascii?Q?7NITeJvpRiGIogdcoAKwfOL14P4TAQj6ah5bRnr2Yfv3J7WoxKJQlnUMoRUY?=
 =?us-ascii?Q?l9lFLtnum6/8jR9fDp82PfR5dHb/hejXoWrn+zs9c42oemnEEKhwu+fLhMzV?=
 =?us-ascii?Q?2e7Yn88UXnZ8VYjKc+g9+KZ0tx9bSgglzEGjPnp3pia9yqgJobq+tz8DRFz5?=
 =?us-ascii?Q?djlZ5hpOjpMWjHaAEql6zImZa1D7O6FxbUIpYzOKa0jMTQo3LlYOwJWCwf0M?=
 =?us-ascii?Q?DJrWkvJ4IPTUiMQfW7cFJetlxj+c8CmnaSWbtShqs45egXv8NQlkg/HlwGsh?=
 =?us-ascii?Q?kA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fba9ed87-60e6-4036-98fe-08dc243b9b7f
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6139.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2024 22:09:21.2030
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BfG4ulFlgsFPmabaK8eDaExe27EXi8y070q4S/BlaDBVL895lF4NMXJaKOCi8MM9kMFX+wd7ABab5EWIZwn9ywLjLtGYBdqMwE6dg6nXBb0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5166
X-OriginatorOrg: intel.com

On Wed, Jan 03, 2024 at 12:48:02PM +0100, Arnd Bergmann wrote:
>From: Arnd Bergmann <arnd@arndb.de>
>
>gcc-13 warns about an array overflow that it sees but that is
>prevented by the "asid % NUM_PF_QUEUE" calculation:
>
>drivers/gpu/drm/xe/xe_gt_pagefault.c: In function 'xe_guc_pagefault_handler':
>include/linux/fortify-string.h:57:33: error: writing 16 bytes into a region of size 0 [-Werror=stringop-overflow=]
>include/linux/fortify-string.h:689:26: note: in expansion of macro '__fortify_memcpy_chk'
>  689 | #define memcpy(p, q, s)  __fortify_memcpy_chk(p, q, s,                  \
>      |                          ^~~~~~~~~~~~~~~~~~~~
>drivers/gpu/drm/xe/xe_gt_pagefault.c:341:17: note: in expansion of macro 'memcpy'
>  341 |                 memcpy(pf_queue->data + pf_queue->tail, msg, len * sizeof(u32));
>      |                 ^~~~~~

ugh... I missed that this was for gcc 13 rather than the broken gcc 11
that we workarounded by excluding gcc 11.

>drivers/gpu/drm/xe/xe_gt_types.h:102:25: note: at offset [1144, 265324] into destination object 'tile' of size 8
>
>I found that rewriting the assignment using pointer addition rather than the
>equivalent array index calculation prevents the warning, so use that instead.
>
>I sent a bug report against gcc for the false positive warning.
>
>Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel GPUs")
>Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=113214
>Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>---
> drivers/gpu/drm/xe/xe_gt_pagefault.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/drivers/gpu/drm/xe/xe_gt_pagefault.c b/drivers/gpu/drm/xe/xe_gt_pagefault.c
>index 59a70d2e0a7a..78dc08cc2bfe 100644
>--- a/drivers/gpu/drm/xe/xe_gt_pagefault.c
>+++ b/drivers/gpu/drm/xe/xe_gt_pagefault.c
>@@ -332,7 +332,7 @@ int xe_guc_pagefault_handler(struct xe_guc *guc, u32 *msg, u32 len)
> 		return -EPROTO;
>
> 	asid = FIELD_GET(PFD_ASID, msg[1]);
>-	pf_queue = &gt->usm.pf_queue[asid % NUM_PF_QUEUE];
>+	pf_queue = gt->usm.pf_queue + (asid % NUM_PF_QUEUE);

surprising that it fixed it, but looks fine to get in.

Applied to drm-xe-next, thanks.

Lucas De Marchi


>
> 	spin_lock_irqsave(&pf_queue->lock, flags);
> 	full = pf_queue_full(pf_queue);
>-- 
>2.39.2
>

