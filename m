Return-Path: <linux-kernel+bounces-73688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90EE185C5F9
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 21:39:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C0E8B2286E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 20:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 092B814F9D6;
	Tue, 20 Feb 2024 20:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SgXKsohy"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44754446C9;
	Tue, 20 Feb 2024 20:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708461582; cv=fail; b=ag3E+qhKfXiVms70cgHyOmrGAg1/MStrEdZbu6/KOdT9FmEv1disgDjbe1mH0kmKwgIyRZ3p8jTj5hBDjAmcsrYoAIlQawKjW8KO9SPTgMlAEoPV7OYe0M3d9/xE9/uybWx7uiNHKKUbBCsYOA1OU+cULywO//illbRJt4hMKnA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708461582; c=relaxed/simple;
	bh=91d+z8z2dTJJedFGMhpUaykojpFmQ6Sjgx5C5bw6myY=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cIwDPRQv2wuRNKa55CrRC15uGUgCqU0arlsvmD4HCTnXWtGJeol19PX6VoHPt4HZJxAoKJQaMaiv5CBRUUZA2rmBojodDSiD10fIzn9EiVRUMNZvd27whJR5l2oZjwSRNjuQczFGYh+Ax16kHHEm8GgW5BTTwRfuZimJjHvZ0mA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SgXKsohy; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708461580; x=1739997580;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=91d+z8z2dTJJedFGMhpUaykojpFmQ6Sjgx5C5bw6myY=;
  b=SgXKsohyD2Uibxow2/nRHXPNFW1Us4foXV+a6TTCkA7XPkjDbwtEmlu9
   xBJmh6ee5jIpnVLQuct4jYIj7SQ4fhj4drS6KtKtN7NLtCyo+vLXAoby5
   o5VdjRC7OTBOynCHOhdctlE2Zi237VOp15rpDNx8yqjT/DfCy4BVvHfIs
   85UbIWsrOa9B/gGBkxKHYGKXXcJuIxqktUqoGEZK3VqSzHEbxWvemsreZ
   borXqCzL6cbRnW75Mflb2f1sINILnBWbVfQEUChzbS3g/w+b0AfTbeiYB
   Ztpx9CVrVZxndNqhZbm1tWwhJC09UNYBJKZbWdaNoF9/7KVUTeLdG7vTB
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10990"; a="28035277"
X-IronPort-AV: E=Sophos;i="6.06,174,1705392000"; 
   d="scan'208";a="28035277"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 12:39:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,174,1705392000"; 
   d="scan'208";a="42380012"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Feb 2024 12:39:39 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 20 Feb 2024 12:39:38 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 20 Feb 2024 12:39:37 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 20 Feb 2024 12:39:37 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 20 Feb 2024 12:39:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NaTSWn0xs1B9T0vWO6bnAIqbprw99gA3RDfxnAqKJiD/6ilUEZFa6LFHRsBFtpSyQjIx83kA34d+Rfb4iaYbcl+El8ep/qZ4+ACquiBdpauA+K/agSs8TaEWhFDpVNqS+YSDyRc5E4jsswvASyDDg5HvSgbSO+zd5Ai/Tz5TtIhrJtXPGuxHhx0w+3Be/V9jSjae+35XalEdRZJuCR7re+2XJDOt2BZWMcizYaalRx5rHYbCh8JytuE8FigWxa11TRLJfEORW6yG6kJYiXduKdzVLgYBkCgN6RxOwqBF85s2CGIVHWu8BoRONKnrNk+KCmb2D3yPdpYRl9sYix+yXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HJRKqnop2iCAd28qQ0ARTJn33FzlaaeIMiGKRZJOZjw=;
 b=OC78VlXPSG7QITbwc2SMrzjroQsMyq60WpDy2qYNJ1iJhIJFw6q8eaqQ8DmpMyJvHMpDx0HhXso1T4ecaMei+DkC3vFWFqfbFfNOg5GCMLqf9kavkyXoXR/z0JThqcn+ZRVtmQKVHhjvlyaVjkYnEoBRe1xpl/zc3CFaEDcA0qgS3cJIa687jPaQJwYqA3QrV+H/PzaGGcHrb6fQB8YmqOczll4kvXlaXpddE8ZQ59Iz/jLIR4CCXpDg8cbPc416XLmZZw9JrT5btwy4wu9af82ik9EyRDu/XQHynUa+YXZT7SpOpEP4Ap9tFM5sMNXX39idwQysdkOiiY+InMdxCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6139.namprd11.prod.outlook.com (2603:10b6:930:29::17)
 by PH8PR11MB7989.namprd11.prod.outlook.com (2603:10b6:510:258::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39; Tue, 20 Feb
 2024 20:39:35 +0000
Received: from CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::9f32:ce50:1914:e954]) by CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::9f32:ce50:1914:e954%7]) with mapi id 15.20.7316.018; Tue, 20 Feb 2024
 20:39:34 +0000
Date: Tue, 20 Feb 2024 14:39:31 -0600
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
CC: Oded Gabbay <ogabbay@kernel.org>, Thomas =?utf-8?Q?Hellstr=C3=B6m?=
	<thomas.hellstrom@linux.intel.com>, Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>, <kernel-janitors@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
	<intel-xe@lists.freedesktop.org>
Subject: Re: Re: [PATCH] drm/xe/guc: Remove usage of the deprecated
 ida_simple_xx() API
Message-ID: <fzpptocruoesi4qdksksygpfbiarnatt75p4p7t4l4emjxunw3@xesto7hczmyx>
References: <d6a9ec9dc426fca372eaa1423a83632bd743c5d9.1705244938.git.christophe.jaillet@wanadoo.fr>
 <pshjojhgguhevgor6p724fs4pnw4a5nyclwfqnk4pfbommxyrh@jfha3y5whlei>
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Disposition: inline
In-Reply-To: <pshjojhgguhevgor6p724fs4pnw4a5nyclwfqnk4pfbommxyrh@jfha3y5whlei>
X-ClientProxiedBy: SJ0PR05CA0091.namprd05.prod.outlook.com
 (2603:10b6:a03:334::6) To CY5PR11MB6139.namprd11.prod.outlook.com
 (2603:10b6:930:29::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6139:EE_|PH8PR11MB7989:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d260b9c-f055-48da-c263-08dc32540c52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f8UlFFb0OjKabvMEmBBH7LRLcapBT0n4phzXqBVhtF5v57KEFXZA6rj6F2COGn90aD0ZNdl+tspbkIPXi5BSWcnl23EdcFMrVQQbcI3JoSevS7o4BlyLRUBRQFgMxrzKSl2ewc+pqEGrvBOLkCh8qEExuIGHvAIn+dkINcKOiIojOCFu5Q65p8VDprXXewQhcHhNDivqBAlREgYSTsa5IbZ8SUWfe1fUPz1P7+7iRk/unSUYuAzh3i5Lp5NL4GzrCs/NNLPw6+0lx9p+pm/WPXAtClvCxRtXQOtxW2oFkGCUmVYEjsnWu7Is5FrQJy9346e5SipQCTt7tAg3glzkBFXAx/J0dpj9nyr0JLGuyiPCIdXXQl76jppRLi31yL4ZkrSGtC0cSIknKWgAwPrXb8O+npS7k44IwoQGJz/dlyWH+rpKx+4Vtb7Ph3wGlIviui71tREYEecuTZXLi3V88ayCuJqgO7/BKjlHIPUsuXB3gHMAEbYMkMR12Wuj2E+vO2EEJJEh0fi3PAza98dqZzoQe4PfdnYgWgyg3tUnZ54=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6139.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?h/HPCUK+aaVuyyYkoOdBqGfvg0Ql1uuiyCo7QVC+O8+ZaAVtug0qQ4Kku/Vl?=
 =?us-ascii?Q?6tXabDtnHL9iAEK0tdj0fs58Bdxv2UcUIJVM9+rpuhvPsYmWZ+BhGaxIiFoo?=
 =?us-ascii?Q?LKmP8XCcjbOcRKbYF1kR7OUoJpWP2APdVPWi0GZSkJg+bK2ntzNHyXYUXsqa?=
 =?us-ascii?Q?wZ6AeDTGM1mgmmMVlUM5zyrDoeQyXuO7tXNWdjGojdbUEx8F/NuVnan1wzmi?=
 =?us-ascii?Q?K7rgGVPbE3PTAbHrX0vwdNQY7pfXMb2ltwR5FExb5SJ2tptAOrxkFb2p5Ziu?=
 =?us-ascii?Q?2HrCnxfRaTddIDau9zEVpDurNlodeWcJHApaYPXJ3pFK17oppC/QgUPAXbr9?=
 =?us-ascii?Q?pRSW8HZZannCbzJnhU0DRHzlEUaZR6+SvSPyHv3qzO7cxy7bvm6evFIYzW0X?=
 =?us-ascii?Q?k030Cnp6T3KLLdFL2IDquPpT4TBFZHqA//e8jaWEUCJ6gPdZOpFm24+IgG1G?=
 =?us-ascii?Q?QGxWgw3LyCZaa76G48/hLFbaCF4TYzImVOBtWMKVa3EplHv6pAHbwrftGg/s?=
 =?us-ascii?Q?5Vd5Oy68O7EPQN4MpT82xq2Kubytn7rS99owK4S7VFxbO6gcQvu3thE+gThk?=
 =?us-ascii?Q?UJWsEI9S+Z46Fs4xXFsIZR5Y3LlGHGlURMWiUmNta4ouuPStOhJufc1kF7NP?=
 =?us-ascii?Q?IXDulXQ9+m+a188hCBcohfcunccqDzGd7YCArVnYQabWpY3ibRLgpwBiPOVs?=
 =?us-ascii?Q?Fzxyr0oLxg0yH69DaXOUOGHJT1uzI+jiHDv+ECSnBahiVD/EMq6Dz/4fWOdt?=
 =?us-ascii?Q?ETtAcaPfK2BjCADn0MxoLYYcEr9nqNwXDXTfePzuMSnZd5f+qYkj/vzLLeAf?=
 =?us-ascii?Q?C4veA20AeXLezzjTnN089sx/tdFGAyxKMzJc8VzUuDFDDttOYIhav2tSYNjo?=
 =?us-ascii?Q?ReedpXH7MyDkxYYE6QJut9H6PljKUvKE50zUhG/yXoUk9WuPt5Elbsr1g0Ww?=
 =?us-ascii?Q?4ZebRG+zFimShsaKPRpqJPrpgABmExYrVm+4lArkBnL6FdSn7kH9YhMIVpVy?=
 =?us-ascii?Q?tLZxHxGCLYfzqmefc1+HEPuoQInfj7f6ts/MSX0ojo/489Er86HIkqxTtDuB?=
 =?us-ascii?Q?jxQk/96kSbpwkGUK97UUyHJ+yDig+yB+2ssBQ/op6mJpg9fcXJkV0qE9jPFv?=
 =?us-ascii?Q?w+hCndVK13UUTlxwL+zh7dsWNVA98UDYx8AvKPTp9XfdQhesOmeqcCwy4CUB?=
 =?us-ascii?Q?R+UoDwjHcP+kTLfsSFe6dfQvA99zDTVuNA5KC69T9sbDrzWDLpRZ3sNZMqdx?=
 =?us-ascii?Q?H44/6b/0Ne8VJNzxnJ47JL4rzVKjtMFwKnsbdH00O4V0+Ba1KEaWTnrcVxJU?=
 =?us-ascii?Q?z7J/WBIhPHbQcN8wbF/R1kAZnz1HDL+OwmuHcy4IU3HU2QO2SK2/pyNUf9uH?=
 =?us-ascii?Q?rkOqCJriUMphge6emD/xtCtQ+hIeX1gFZjIF0k6qxEA3hdsAt0yO3tBVVDPg?=
 =?us-ascii?Q?Wj7mXMwRfxQYJCFXKVTNPDkywT1BpI3MYXTYpl281PF9z+4+B7f5YSrx0W5d?=
 =?us-ascii?Q?2CsLUxUczyxjK/EBmIO55itUVWFLjX0SK6TSDh72Opr5q35B8IfowozjrpOk?=
 =?us-ascii?Q?B+qt1E+NN6cqTTdta236sphUZBUMIuiHK9evwRDqDoz88H1hOhIFPxus5SPL?=
 =?us-ascii?Q?yQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d260b9c-f055-48da-c263-08dc32540c52
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6139.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2024 20:39:34.6598
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2p2J7KlsmFWOW+BY0S26O2tlCXdB1yJ+BTNraaqk2Gf6vzzcAOHvwXlyQyOSP7rBn6m3HlVjHIFaKrAJ33qjMGAE6Cnlt5gAMhG5DoenaXs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7989
X-OriginatorOrg: intel.com

On Tue, Feb 20, 2024 at 02:34:53PM -0600, Lucas De Marchi wrote:
>On Sun, Jan 14, 2024 at 04:09:16PM +0100, Christophe JAILLET wrote:
>>ida_alloc() and ida_free() should be preferred to the deprecated
>>ida_simple_get() and ida_simple_remove().
>>
>>Note that the upper limit of ida_simple_get() is exclusive, but the one of
>>ida_alloc_max() is inclusive. So a -1 has been added when needed.
>>
>>Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>
>
>Reviewed-by: Lucas De Marchi <lucas.demarchi@intel.com>

just noticed we already have CI results for this. Applied to
drm-xe-next, thanks.

Lucas De Marchi

>
>Lucas De Marchi
>
>>---
>>drivers/gpu/drm/xe/xe_guc_submit.c | 6 +++---
>>1 file changed, 3 insertions(+), 3 deletions(-)
>>
>>diff --git a/drivers/gpu/drm/xe/xe_guc_submit.c b/drivers/gpu/drm/xe/xe_guc_submit.c
>>index 21ac68e3246f..11ffacd1dd58 100644
>>--- a/drivers/gpu/drm/xe/xe_guc_submit.c
>>+++ b/drivers/gpu/drm/xe/xe_guc_submit.c
>>@@ -311,7 +311,7 @@ static void __release_guc_id(struct xe_guc *guc, struct xe_exec_queue *q, u32 xa
>>				      q->guc->id - GUC_ID_START_MLRC,
>>				      order_base_2(q->width));
>>	else
>>-		ida_simple_remove(&guc->submission_state.guc_ids, q->guc->id);
>>+		ida_free(&guc->submission_state.guc_ids, q->guc->id);
>>}
>>
>>static int alloc_guc_id(struct xe_guc *guc, struct xe_exec_queue *q)
>>@@ -335,8 +335,8 @@ static int alloc_guc_id(struct xe_guc *guc, struct xe_exec_queue *q)
>>		ret = bitmap_find_free_region(bitmap, GUC_ID_NUMBER_MLRC,
>>					      order_base_2(q->width));
>>	} else {
>>-		ret = ida_simple_get(&guc->submission_state.guc_ids, 0,
>>-				     GUC_ID_NUMBER_SLRC, GFP_NOWAIT);
>>+		ret = ida_alloc_max(&guc->submission_state.guc_ids,
>>+				    GUC_ID_NUMBER_SLRC - 1, GFP_NOWAIT);
>>	}
>>	if (ret < 0)
>>		return ret;
>>-- 
>>2.43.0
>>

