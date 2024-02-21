Return-Path: <linux-kernel+bounces-75436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D382C85E8A6
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 21:02:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 899E01F29884
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 20:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E44F86625;
	Wed, 21 Feb 2024 19:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NufHx0Ob"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B19A186141;
	Wed, 21 Feb 2024 19:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708545474; cv=fail; b=QOeofdC4ieCpk+FfVuxUXF7xDgCAgQr9zkNh/j1mbg+fFv6enQ/Y8IFchds/F4k8oEbvrxiy16nOXzRHKr2jCE8wvVP6tRB1A6gpyVVXkVEGcJezgskI5ePCaAXfogN76fqR/bFZpbgGtXi4v2XXPWlf343WxFXgLZ6GaG0uUn0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708545474; c=relaxed/simple;
	bh=uUJjIiKuqulnEiT1FiKMpAhsNhZ3tIQ2uJe9PsCwFew=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WIQhfCZGZ2bFUtCqTYwDwwobO79pzG1kiCgVB+2CsEepjEDwRd7EdEcqiWOJxjt/QmcxjIXyNUIXg9seFG5X08wqn4gbtXHrQ95zilcvV2jQfRD3d795v3o+b8BfLXr6mFpIgRNkr2dfzsCYdKCun50gw7Jxwnbz7vR5FzNuLIQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NufHx0Ob; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708545472; x=1740081472;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=uUJjIiKuqulnEiT1FiKMpAhsNhZ3tIQ2uJe9PsCwFew=;
  b=NufHx0ObYVhY2MNiV/gE82/Kw7mv4R+HdnmpaLKQUn0uRD6NCU9cQvZa
   wRgH1wsgz89MhcuOLKR/ixIiPRqCLm+L/bKoFA69VGxATyoNiV/lOlWF7
   RDmmleAK8ctkMwrOIjUEYEspS9s7O6iZjS4ni3HH0OYspQv36rhYccNrl
   w+OZPzuiCY+4Kj7nNxct2rEHzOKUDYWI5UfmyFa16wBkENyBLtA8LRNnx
   BiehRu/06X8SC5Z7gTcGMcXeIu1ju2R72cXHOBs/+ugtQw0QoY86+Wreh
   ftN3Ilw6hlr2rPcuch94jcO9QgG/DPvskydZKMO4mOjpkIM8mlpAQMG4G
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10991"; a="2603751"
X-IronPort-AV: E=Sophos;i="6.06,176,1705392000"; 
   d="scan'208";a="2603751"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2024 11:57:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,176,1705392000"; 
   d="scan'208";a="9948694"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Feb 2024 11:57:52 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 21 Feb 2024 11:57:50 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 21 Feb 2024 11:57:50 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 21 Feb 2024 11:57:50 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B9oFJ3HAVKkGSa4SXTflJvCOaS0A6l2wMXglbxlij7ZGUdYH1Pc/fMRtqq1uf0TD6DevPFdpZccnQRsOzSDrXAAKl9nc1dWZuPZbuaeAuwxeY9ChdNIaYWNH+5XpKA/uIJeJgoZ8I41WLu+8abrAtY4U8Pq3lsRyLEhWXJKKNkLBugQKtcwd9mW4/dKrRidGYv1emqYskGEHdohE4LH6VI2Ij/+gR6Cj7v4U4eO/OmMlw0ENQntuPeraYhogR5YzhOXaOpe5JTYIoW6QA9lmGYrbRr0OLYZG0ptVMr0TCHOgWLxl6M0jQM04WRQY82Z71kzdmr/1qVGgEnfmSaK93g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aTiLFFwiynOvP9tGLu/XwgA3wTA3zLHZ6sU4kV+JwdE=;
 b=D9OGSvuvoWS4qWiu5IkqaH4yGGyWH1yShkNijW9XDEmo0eiZlPP/U9/0OgqK1xBfdPqw3UawfZepNEiq9xGqZEPHvU6cU1hK2+TrrK8J7YjKSNd/NN/HuhNArB0ruqWMnqNYCjVcX/xMdeshbYqTpB7qrLY3il/6c2daGTNofxauTlrRbrKZyiTBT8Vu5JF9J870VGrGEBG6X0PLKKIr3n+c8GABMLjU7hdE00iDfvBgUW00/onlGtr/6sL26mupAZLz6VomLhxY838iVOVqx7ZWcX3CeU0mVwWBNJUsZausKefwBHsJdP/ZGkDXgd0bJu3mfn3kX7UCTJ7DGqf8Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by MN2PR11MB4759.namprd11.prod.outlook.com (2603:10b6:208:26a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39; Wed, 21 Feb
 2024 19:57:47 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::da43:97f6:814c:4dc]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::da43:97f6:814c:4dc%7]) with mapi id 15.20.7316.018; Wed, 21 Feb 2024
 19:57:47 +0000
Date: Wed, 21 Feb 2024 11:57:44 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Ira Weiny <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, Smita Koralahalli
	<Smita.KoralahalliChannabasappa@amd.com>
CC: <linux-acpi@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Dan Carpenter <dan.carpenter@linaro.org>,
	"Ira Weiny" <ira.weiny@intel.com>
Subject: RE: [PATCH v2] acpi/ghes: Prevent sleeping with spinlock held
Message-ID: <65d655b8a098d_5c76294ac@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20240206-cxl-cper-smatch-v2-1-84ed07563c31@intel.com>
 <65d111eb87115_6c745294ac@dwillia2-xfh.jf.intel.com.notmuch>
 <65d5832090c5b_1ada2029473@iweiny-mobl.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <65d5832090c5b_1ada2029473@iweiny-mobl.notmuch>
X-ClientProxiedBy: MW4PR04CA0247.namprd04.prod.outlook.com
 (2603:10b6:303:88::12) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|MN2PR11MB4759:EE_
X-MS-Office365-Filtering-Correlation-Id: f41029bd-fd99-4ea4-f428-08dc33176054
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z4iz7dprPvACOjvnY548jWT7vc4WK4sPURbBlDOs175th0kgGv8E4oUO8kQJnuTl/E0AgyK31/IBnDt6pJiOuaw/kHxM2tVEy1daSmlmiYFHGz96qX5FbrVQ4fUWvozjf/IiahayPqfhBFv5ooLQNuVCLZ7f/y+kJjk3K13Dk12yIhiT96iAUYqqQcpnqn6K7OfSElr0k3yD/uQoAfbRLLgHYDRp6emGUCDwYyXz/orjRxwjDBAQirmQwyjmVQ+TWFdTw0pE7PQB/FOQuy2r79Ih86p1n0oDWMmbG8YuGzpT5DO4HeL3Wr1dXPyat9EnZ36B/GN9v6H+xPmj614I4xpjUiW3uMrcJxQPK7AiQGawl6w4Q/BYyabeo4S9m4RL2plLGxSJUGLUzxQ9BNFrDYa6ftWrxGdq/aZnQekRuelYjMsKMT1Bw75gsKbu73z7Sj9UnAXvosHBQPeBpTbQoa/bgW5BENU9DzA76uk18UouLrrETyzshSx5VyHiI0z6nlLuoU/yeVXgIOpKPFC+/q+5fCE5SsJf5OIuTbj0R0Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FIlOPGCehoXyZq/KP9Pk1H0wHAKnkpr2voPKWfhQHfmZJmFdB5BIT0yWlaYJ?=
 =?us-ascii?Q?fAPMpts8I5dmTibiuyFIl9FhVR0J3WBuH+LMtNzihG7jLwB6gY7EP8fi6fas?=
 =?us-ascii?Q?Z3fLNWhtCwcDifYYwjZy76mCQQk3oQ/pGaPKRy6/FPJ78cydX0M3zrHpz593?=
 =?us-ascii?Q?XAxTaA01oEbxEtTPhp7wY3hNb6BJ2mqmp/f3ZB3hMpLem5QSiVLoyOxBMsMM?=
 =?us-ascii?Q?qngbddiO5ZhdqeopKThG7vhLUDs0Yr5RIe8vKyOb37/emCT7aeJXUYOpc2DR?=
 =?us-ascii?Q?4Iocra7cIuKrk32SJQMlUPb8uO8dvw6kbfAFlYv5/tdKqph5pnDS4ronnJb5?=
 =?us-ascii?Q?5wRSnnpJxyuxyz7cVklYA8HuBmYVmJSXTfBQEI7sqbUNM/K303Uo/FQe9FuZ?=
 =?us-ascii?Q?HEKJmiutu9/6yS8l4dSAVegaGsGLbSt7ZKCeLFt3ImzQs9oFL2PKfT/3Su1+?=
 =?us-ascii?Q?xh/NNYpdiTom81Z4f1r8guFj6mC0bkf+KoLnYWjrIWGEBxgg+RxowQeqKNW2?=
 =?us-ascii?Q?vl8Tz12bjR8kOcZZDo2If+4edHx5Ynn158zEO4FPGl1JNkalzst+LarAY9SJ?=
 =?us-ascii?Q?kq/oiE2JlicVpOIIRmScUkxOU51v/uaSEmLnZkU+slEc7xKrwZJMkAWZIyQZ?=
 =?us-ascii?Q?lCLK1AzAJCC5MGkZFPTu8GJuD4W0WFO4Fgsfhx2nHWQKFH2+sgYuqJNVLLuo?=
 =?us-ascii?Q?Y587an14qHlWvVRyR7p6ZTOf1/OHeQio4hLlPW/DaA58cyJcl6afFQetMKuz?=
 =?us-ascii?Q?AGUSZ44O2sIzCzDNFDwDUXJjFxAjFNobMQyl6RdVYEZUmtj8iYBTDPX8RGb3?=
 =?us-ascii?Q?96K7GqgCTjZ/7vZD2p8Zd1KjPlzx3JxHYV1Had82pR8AzM8Yfs2DpAf7yB5+?=
 =?us-ascii?Q?4QPzC9VyZWJpFOTE7S4i6EgRcLjccGIJg3ya+dciamiJbcWkFK2iBM7wfIAv?=
 =?us-ascii?Q?Fbpqy7RLMP/pl4SqWzG1WPUP1R/BsOORxQA/6jhF+ov683Ek8JPTfBUoR7wt?=
 =?us-ascii?Q?Qk1ENSOa0u2bPEFX+m3c+61MtdkD8lfvVsMAtZWu3TexkBgGS+2IUNZ+CE40?=
 =?us-ascii?Q?Enzx2LdpUwXJwaREAq6dd04TaL5/Jy8CMo+dKLzdTfyzXYe+9AVdISHZy27c?=
 =?us-ascii?Q?NiUdS2XZGZLyi+KCen/++lSS5ykotGX2genb9FD9rxopQ051FyquAvDMGT3V?=
 =?us-ascii?Q?gAaD7mlItmDk3UotjJnqDGepZ20lywTlXwZyB5GmFilXo6BLBjhh+luayhI2?=
 =?us-ascii?Q?1DBxJ2Gn2TZ4/WBNAU7sCLavEloLwYLsFbt/syMncqG7YfkFNodaIsyKvXxs?=
 =?us-ascii?Q?Qw1a9weqpRpBpTGnLIak3IXwY6Q+7fFyGqhREQodW+WovPHtt1r8SdogY5FY?=
 =?us-ascii?Q?0qiz1OscLjE9txaU5eyZ8V+2xzDXW/gVw2HtGyE9SFUBm5Nx1m2H609L11bC?=
 =?us-ascii?Q?sxqys6u3FkiSvNf+zqzVwKEmePu2dlKHCB3a8IXjfsC1RPK3+KQM9i9P6iHo?=
 =?us-ascii?Q?RFrpDxsEJ5PZgy+0cgzneRXT0TvpfhMA08f0VpBShKrfQSLT1K5tZ4UNMwqH?=
 =?us-ascii?Q?kr6ip35JVshfxOXofs19T523KiRpGPB83to0V3Z8EB6C8UBOQTgpkVFOFaDD?=
 =?us-ascii?Q?gA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f41029bd-fd99-4ea4-f428-08dc33176054
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2024 19:57:47.4989
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pudQNGE+hLj75oC8SAb1z1KftM5qDbXaDYypHYvdUuzPAwt37+/LSjdnhcNY0ZhoeQMiLC1Go+yyuKZFjw3pofpeDkhXzFRvthfeR7nAs1o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4759
X-OriginatorOrg: intel.com

Ira Weiny wrote:
> Dan Williams wrote:
> > Ira Weiny wrote:
> 
> [snip]
> 
> > >  
> > > -	guard(rwsem_read)(&cxl_cper_rw_sem);
> > > -	if (cper_callback)
> > > -		cper_callback(event_type, rec);
> > 
> > Given a work function can be set atomically there is no need to create /
> > manage a registration lock. Set a 'struct work' instance to a CXL
> > provided routine on cxl_pci module load and restore it to a nop function
> > + cancel_work_sync() on cxl_pci module exit.
> 
> Ok I'll look into this.
> 
> > 
> > > +	wi = kmalloc(sizeof(*wi), GFP_ATOMIC);
> > 
> > The system is already under distress trying to report an error it should
> > not dip into emergency memory reserves to report errors. Use a kfifo()
> > similar to how memory_failure_queue() avoids memory allocation in the
> > error reporting path.
> 
> I have a question on ghes_proc() [ghes_do_proc()].  Can they be called by
> 2 threads at the same time?  It seems like there could be multiple
> platform devices which end up queueing into the single kfifo.

Yes, that is already the case for memory_failure_queue() and
aer_recover_queue().

> there needs to be a kfifo per device or synchronization with multiple
> writers.

Yes, follow the other _queue() examples. kfifo_in_spinlocked() looks
useful for this purpose.

I expect no lock needed on the read side since the reader is only the
single workqueue context.

