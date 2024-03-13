Return-Path: <linux-kernel+bounces-101439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 064A287A71A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 12:29:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3CC16B22959
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 11:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEBA23F9C3;
	Wed, 13 Mar 2024 11:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l3N8xdpJ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C3D83F8C7;
	Wed, 13 Mar 2024 11:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710329347; cv=fail; b=dN6Nh8cON8+AbP/WJdrMhU6aTbY4ucDp3poQjulw7N7QMUwkjZYkVfPUfk/KVXgDYEDWaXeCvGWbbvX+cmUbRR2xrYnYsiC6MlHgg/SFbjYv+m1CPf74JGlZRGhqwlcDfDNm2v6xBKqiODJewHnt4eKDihu2s8yTvo7QSL9+3as=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710329347; c=relaxed/simple;
	bh=KDpVAvEVgfKwPZGUmlWzI4jecyJyiLzCj7cSel2ZB1s=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qu6ZKTXHb0u4CvHldltCk3WwBKbVkkBcyzYLUM3ux3NTIhnfQy3v0emceQLf8/kEatwUu1ikaTTSFO1fvdPRDn1pjY7TlfLleod8/LHheMdQY4D2+I/a7BH+vO+bcFVQZe7mn1sqOpSK4MvkGDoef1mH1G6t2biVzwSwCrQCj3k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l3N8xdpJ; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710329346; x=1741865346;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=KDpVAvEVgfKwPZGUmlWzI4jecyJyiLzCj7cSel2ZB1s=;
  b=l3N8xdpJOeytjlsa89vQng6FMDEjhmS2VXv4aN3qHX54b5BeByTyVdgO
   z0CNHTxkkE3o8NIrtFcVIohkb0B4AUFsV9OjTT8IazEfi2TyzCQMuwHom
   QTqUYf7T7jZpkaXxAZz09c41W9FvaamMRDs/bEVnjgFJ9CeoG+EhPitZQ
   84US7cToP0ym4g9RaynR4gDA76JtZnSrn6jxBGrVrdmqpjg0gtAupmUlQ
   3kmt5dxZU6qEq2l6jYuLkfILb+uk5YmUrMsepA62ytH3NEVlqYfSqLVuQ
   CmOA0qVXFGU9TUICYECR72Tz5h9RNn73QE9v8EmCsY8/Pv+qmhYdsNsrN
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11011"; a="5016831"
X-IronPort-AV: E=Sophos;i="6.07,122,1708416000"; 
   d="scan'208";a="5016831"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2024 04:29:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,122,1708416000"; 
   d="scan'208";a="16545004"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Mar 2024 04:29:05 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 13 Mar 2024 04:29:04 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 13 Mar 2024 04:29:03 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 13 Mar 2024 04:29:03 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 13 Mar 2024 04:29:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jYSKFiZ4mdl4beXzX8VE93706r48esVSV435ryAUN87WL6ChZL/N4W7rqXvtqAEmZtgvvcm5C6Ht45wj7PEqOBI09ONifpOYdg2GqIPgPnNKxxcGm2+xgXjyPjmzz+g2pFvwGYc7KFJgEMYygFJLgX2zUzsJRXi4JYJsr5khAbZ5n0ibrLn3xj17wAdHLe2o4IDfbcOSlVdg+W696XGzxVoOEnzy3Tf5j8in3mjZ8xm98uP//jDDXZIvoIZ+rCxj02u3DgFzsxZ2IgjlDhmED7TeYkSyJK+mBAdPDeMg4u1FW/R8SSEduC3XJSdcMvB3tdlfKas7hxgvotEAIkStXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2zRLQi2IFyde4U/nv/r4x1WzDBxYFpQ6UTbYzoVoINQ=;
 b=L68FgAdV6fQwKnOVvchHFKUd5DlSqJdpDltwjLKH+FCn1+I9ZR316qEBQEQHiXvt1l79StAFXjcdMKlx28ZVYuC6O5pwIzF0c6GowQcioy/g3hogMD77tIlb8+FQo/0dr9EFrIHplP78ftAkyWp8fY7PYp8aDRPZnAudzW93p6cs0iytHdbSNg3k6/Fzxi5H4C2oWCYlSOPNrxDazYfuUINyujEb7A1HKJL1ecqMoYflyMr7T+NRjab9RUC8XEk0rxw8P6RorqW/XgRlXy/+KN2ESbh7AVgHihRZqgL44zpImVufZ2VkGqCWuKPgwndf7FgKU3Am2SJ37TofAKZ57w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5782.namprd11.prod.outlook.com (2603:10b6:510:147::11)
 by IA0PR11MB7401.namprd11.prod.outlook.com (2603:10b6:208:433::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.18; Wed, 13 Mar
 2024 11:28:55 +0000
Received: from PH0PR11MB5782.namprd11.prod.outlook.com
 ([fe80::d48a:df79:97ac:9630]) by PH0PR11MB5782.namprd11.prod.outlook.com
 ([fe80::d48a:df79:97ac:9630%4]) with mapi id 15.20.7386.017; Wed, 13 Mar 2024
 11:28:55 +0000
Date: Wed, 13 Mar 2024 12:28:41 +0100
From: Michal Kubiak <michal.kubiak@intel.com>
To: Ignat Korchagin <ignat@cloudflare.com>
CC: "David S . Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <kernel-team@cloudflare.com>
Subject: Re: [PATCH net v2 2/2] selftests: net: veth: test the ability to
 independently manipulate GRO and XDP
Message-ID: <ZfGN6RTBCbEm6uSO@localhost.localdomain>
References: <20240312160551.73184-1-ignat@cloudflare.com>
 <20240312160551.73184-3-ignat@cloudflare.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240312160551.73184-3-ignat@cloudflare.com>
X-ClientProxiedBy: DU2PR04CA0226.eurprd04.prod.outlook.com
 (2603:10a6:10:2b1::21) To PH0PR11MB5782.namprd11.prod.outlook.com
 (2603:10b6:510:147::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5782:EE_|IA0PR11MB7401:EE_
X-MS-Office365-Filtering-Correlation-Id: 5650e9b6-5959-4773-f79f-08dc4350c46a
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Lm+kKiOyd0uXPnegOZHHTyi0234Pjyhp1R39IfEp97mj97eSx74Cf5R4OcQfXs7ZMJR0ItKQRxVZsfWRHU2u3pD2xvCDzFhPUUk75IUBb60y6x7LZsd6hx+U9De1HSy2hRYKmVmYfbnAcSM+ABMRNb6UGFK/4ySxeVj4ZPpndPSwAh/jPrqpJti5BWYhJYDk9fsVQ8cfi2O4r7bplR9/7ZxJxOj3nvwLmBv9Jcq59suCEcp0lwwPHWwd3nC7nuaMW0MPR1PWBkGF6DSyWPXIBVkGgDRYBYDlz+H5HWL7h7hVA65WmhdEFEUx6DHNVb4fGsRkiUNDTvVpxx7kWOozkfF+/rkbJsqwCc5gOsv/Fjdq8V6LgGtvAgb33tTNuNaeO4SlaX6xg2Ww3QmZmzq63IBDSyjGuxNeb8Thtls2Hva/AFiGM21FuoulCq1SUgkvf4pIFhOKl7usg+oqtOT6xyooagHO1utPiCtyBFCBs7lgn7lfoY517+qGeNZzFZ5z4dt0COa2G6QZeujzG01fTqgC6kkAjTZC+9sux9xX1WzF8xsqv9TI6OyEB/H2bSkMUxIgut+lb8ZTOkzoDNSylMKJq6cB4+K+GtSyzZuFs6kguxWM7XQjEXhJD3zkesrJz0l54lC/6pe+oD10ZsupCi4/c6CcMZIFwvix+ENm9GI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5782.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Y+SvTG1NSVYH5hotwSi9huVRX5CSGs6G0FELYNL1cuSxLuZazFwYMqOa0n+p?=
 =?us-ascii?Q?YTkAi5YiNF50Cwhoqz5QtG7Gzkcjmf9FCpwtEOy4U9wxxx/wekcXGXe7bBYr?=
 =?us-ascii?Q?Qp3U4HCCcOji/izzUxKTUisbttbYveSQkqQMVox3Em/N+UngrfmDy7oPZsdL?=
 =?us-ascii?Q?aKHo8aAHPf/QG7ei+T8f3FhjRITgVVmMTyDx+1v/ZXzHxc946aeIv4fifnHH?=
 =?us-ascii?Q?ZDvegC5QvjRWccAjdrA6Bgb2YrRyyOFYhc0nL1gl8mOPX1RI29ZvIaac3ov9?=
 =?us-ascii?Q?MebQU6FJc9F7i40f/TYMP7nOVt5NeVA7m1XmALKDMrPUG5VFEmqcW1IkY+aq?=
 =?us-ascii?Q?/7oXZergB8taJUFLPrlU2EKIVTwK/hUgVqi3zDkT9yWo7l16AUZ9SmfkSpGl?=
 =?us-ascii?Q?2AOPslLM/lBgZ7urY1jdR7VblE/fmzPoCGtgZevjETuF7UyMuTFKcLNTNPLA?=
 =?us-ascii?Q?tOmW8W37GXChBufBlH2c5wPqxZ+FNDw3x25UxRJymbgRb/65kNrQ3rpqvVXj?=
 =?us-ascii?Q?a1tQF2jIt3UutAtkKQ3r0hDGDveUC3n2D8ckNUv097krVCXZCM9NfnOErbWI?=
 =?us-ascii?Q?uNXiX8rLuvnBi9JfxKPsX5Q0wSfN7I0q39/QFnb6tAzOgQouqFVbr1DwktEU?=
 =?us-ascii?Q?Otr4dd1LiDZJfh4qMeHYg0u37rDOiCryJWWYQ+z/VmRE1upmxtYCL5f0RXuY?=
 =?us-ascii?Q?gS5mPeeDjiNEF+VbSoGlNFT3+jfqUepU09Cpd3N4OEuBemyfZpbr3XRBrn4G?=
 =?us-ascii?Q?lEk6/GoNXHt1LW1DWyQrAx1UPvJ2b9UvaDG611WZ/eDFI8N6jJcE6JlKaIfB?=
 =?us-ascii?Q?2Qpr2JHJiPRArnGNMWFkDmUIdWH90JeorKdcESWGgvH7VKC/foDj3fQ08GA4?=
 =?us-ascii?Q?Snp14Q6aEcLFkeBg1AECJHVuXJnqJ6JPKZs8JEGW6cjnp7IEq+vPShXNzCIZ?=
 =?us-ascii?Q?DZE2QBESW4Du0fOTkLAN+zJyZa3mYlZY7HulhBxiDJPa0v0lRj8dSol1azZB?=
 =?us-ascii?Q?RYQfe8eIUu1FnmYLs7TSaSAJgiVTFjmM/VxC9fvgKCbM1VZHATO/375I0wl3?=
 =?us-ascii?Q?O/YTmgcoQcOdhcBREzHmbpW5/Mlal4TwJu557xfAQZnSutmIPQ1q2lz87+32?=
 =?us-ascii?Q?LZeGqJZSulRiYoE7JSlQXnS4rovQ1mCmnCJqT3RqL8iAUFU19/JlwUxwyQMB?=
 =?us-ascii?Q?4k8SfQoZV27Ybalm0QNPeze9SuO7I2ZwMqneNKgVbs2qo9F1uDjqym6YVKwp?=
 =?us-ascii?Q?1rrKzG+IT1W+tu/91LUfYf+i32NNOIuKTLVzV89I9Mo7gh0fkPbV4SNDKBc8?=
 =?us-ascii?Q?5VVP3I2aJOB0j1B7GDeJhK6ZgZ0Hr3CowYl2+rPAI50FAxZZSLK0aPvhIgqu?=
 =?us-ascii?Q?8C9pG03Kc65fQHqZyQ/S6/Gp6S/BtmQGayMJlS5lyNcHltc5I6ofUQoXG8lL?=
 =?us-ascii?Q?wf0YyALNHQROum37MEiyGRNEfkAcIS6FTGm2XY155csCQ7gFnXnyJeZf6iCS?=
 =?us-ascii?Q?s7HIWZH3njW2CcCQXRyn60WwxS2UJQwo4OPBBO+9sDyq4UKckfIzLquJtT24?=
 =?us-ascii?Q?Ky1MAsnnTuilCs7AlSu4vmcrllNCUCb/90wH1qw50gVZimPbK22d7QcqONY+?=
 =?us-ascii?Q?gA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5650e9b6-5959-4773-f79f-08dc4350c46a
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5782.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2024 11:28:55.2940
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7hkMqTv+uHhVtd71URS+SajN3FQ5suxUakasbkUyHxbB5mWF0clI+tmSlVbN3U4b7K3jzT9OP7cetRDILYM4Tw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7401
X-OriginatorOrg: intel.com

On Tue, Mar 12, 2024 at 04:05:52PM +0000, Ignat Korchagin wrote:
> We should be able to independently flip either XDP or GRO states and toggling
> one should not affect the other.
> 
> Signed-off-by: Ignat Korchagin <ignat@cloudflare.com>

Missing "Fixes" tag for the patch targeted to the "net" tree.

Thanks,
Michal


