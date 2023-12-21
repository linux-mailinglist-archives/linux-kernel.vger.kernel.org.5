Return-Path: <linux-kernel+bounces-9134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F82581C11E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 23:34:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6409E1C24931
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 22:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6BF85991E;
	Thu, 21 Dec 2023 22:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Tc3vOoP0"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F1F625
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 22:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703198062; x=1734734062;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=IMY83EOJ5ffbW9SPe04ShgnyLoTdf7PkOCjSaNgeUpw=;
  b=Tc3vOoP0S4M62enpf1zhHmsED80U9QduH11i893StlLObZz30nbgtjA8
   1vFRLTimn5OHEFWc7ynVR3BmipLL7fSOhfedYEZGXS6xwtSP4C5rQAXSX
   uK3mP2dQx+EhFBO+ZyLfZs7wBrvDS/W0nB3uyHIFn7TGu4Os+pWgnpyYE
   2f75qFBrN1Dk92/EokCMUV0EXU9xMiKVcDo8AlYk2Jom/gUs2TIMcc8P1
   IIsEzSoCmJgaQ5crbGStFnZOh3DPkJA0vLBR64NOfphyANLKeji64NG3/
   9U9KBIxsnj/U8AUeG6LMts778IgX5JRiMi2WeEjDKfKCPGRKsmgVrvfqT
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="3290191"
X-IronPort-AV: E=Sophos;i="6.04,294,1695711600"; 
   d="scan'208";a="3290191"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2023 14:34:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="895251477"
X-IronPort-AV: E=Sophos;i="6.04,294,1695711600"; 
   d="scan'208";a="895251477"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Dec 2023 14:34:21 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 21 Dec 2023 14:34:21 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 21 Dec 2023 14:34:20 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 21 Dec 2023 14:34:20 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 21 Dec 2023 14:34:18 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=js78b9VnHoq1iuU9D9hydeeITpJPtfzCfN1VGNNnpH0938czpjusskPsnjzzLWvS+eErxeoRbLB0jSTydmCNxhF5JkEHg/7UwHppQDstiudhkerYE3gi1Egr/gb+FMFMN0PzsRBzR150DRaZ5VuZLoZzKhtZucM8ySKGPMAXI1BavL7RPGS76zAms5dpKiQmFN7gUIYXwLmRzKH8xoZj7K0MoYtfEb5w9NgeUvEILhmezCaFinGiqKGbHERd+4ivNEE2Hd6PA5TVao/J9AjeNHh3eEgWaLSkWjZw1FXQLbNGfRqzQ4KZVWmFuOCIoKuflbU3z+Pl46GVzdzuWrs8hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RfuhomK3kIG7ZpaDUzeXBUR24ZsmdeSNvR6qwYTnOdU=;
 b=FBdddmm7Rqvm0h9Qp9tqhN84Z1tdUUw/P9VVP9OPe6joxiFsKr8yXtvcPJhIYV5JQ0ckpRsVnsEoh898gDGDBYSqOAi1k5emKyTelAatQZZhIIWiXR5lyR8MSha6x10N9Lgkf2ezu4qIN5oR90eux31KaIW15wSefKI+5X7RUT+64gEdvh5ED32rxfcY4m6Y9sztOkxtBU4COqv29OeC6h3QfoNSO3KdDu8vZ/et4LIa+DvpwjmpAUsP8WFNUEk2wDpIZ1jJKYj2YEo8jsUZaphOuoE/HnZYglsrEod7emdTZlBi4Z1cb9//sQsAyozD5wTlG+fpnq1xSyEnNwRiig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by SA1PR11MB8374.namprd11.prod.outlook.com (2603:10b6:806:385::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.19; Thu, 21 Dec
 2023 22:34:17 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::da91:dbe5:857c:fa9c]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::da91:dbe5:857c:fa9c%4]) with mapi id 15.20.7113.016; Thu, 21 Dec 2023
 22:34:17 +0000
Date: Thu, 21 Dec 2023 14:34:14 -0800
From: Ira Weiny <ira.weiny@intel.com>
To: Ira Weiny <ira.weiny@intel.com>, Randy Dunlap <rdunlap@infradead.org>,
	<linux-kernel@vger.kernel.org>
CC: Randy Dunlap <rdunlap@infradead.org>, Dan Williams
	<dan.j.williams@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, "Dave
 Jiang" <dave.jiang@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	<nvdimm@lists.linux.dev>
Subject: Re: [PATCH 2/3] nvdimm/dimm_devs: fix kernel-doc for function params
Message-ID: <6584bd663bd30_576052949c@iweiny-mobl.notmuch>
References: <20231207210545.24056-1-rdunlap@infradead.org>
 <20231207210545.24056-2-rdunlap@infradead.org>
 <6584bc064ea54_5580229435@iweiny-mobl.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <6584bc064ea54_5580229435@iweiny-mobl.notmuch>
X-ClientProxiedBy: BY5PR17CA0045.namprd17.prod.outlook.com
 (2603:10b6:a03:167::22) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|SA1PR11MB8374:EE_
X-MS-Office365-Filtering-Correlation-Id: 772bf655-1ca7-491e-f7c0-08dc0274f763
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LwH8/prghnBMtFThVydZqPpALDovcF6V3hdsNnGBqHGu3d2u7bho4p1RK0oQ07Xr7d8dQvjjERg5mM4JKUPuKcXej/VPvSBVjv3YpIfI0zWGovIY/DoWyIY2d8D03/v/27dtPbYOO6ZkUMDqv9e0fYu+kw+Xor6ApuIJ77gYk/ATuicWD/fcxQvDsdblnHcTIe9g+99GoOygaNrFfEYONAMOciRkVqYpao6A7zTQBjY5RFkl9X27VjXW7wT9vJsD8zSilDxeTWCInPRWqGKkVbYh8zhu4nTPf6BmeSkBz1ONkIRdbDQlOlCGEoeiwNFJigABvnnsuZcVxOYHN1e0Li6BEXOfvXo+Ixwj9cFBDWNe2uK2MWInaQ1CQyhiCtuz0YKLheIvioYcn7+ola0F/2yIAm+kQjXUkuyGG3wWo7aBZHUlRCaGMOp70yfhHOBd5Wgp3IC7vJ79zy970Uvqre5d9B0SpOoKurpFSvuGiTRmxMlP1HKPsv386BzndqW4RvrXOePVKSPENJj4UlbxOHeFnyPq+lBJknWZZExEWbjTrKKmhntQ8jS6xejc8fxB
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(39860400002)(366004)(396003)(136003)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(6506007)(26005)(4326008)(6666004)(4744005)(2906002)(44832011)(8676002)(8936002)(9686003)(6512007)(66556008)(110136005)(38100700002)(316002)(66476007)(54906003)(5660300002)(66946007)(82960400001)(41300700001)(83380400001)(6486002)(478600001)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zioAa2DbsseXnCRla+spplOJn0vrZa0RJsQ6QEnF9/0RZ/wsKKlQY1gYHk3d?=
 =?us-ascii?Q?P2UMbkUbs61Ts1piup5rYrqyzoKN8yhveUAG+XmyRmc5cCiKwY7XOscWBQqb?=
 =?us-ascii?Q?dSFtxcMQkhwi3azoqerf4+l5KZ86QewzFTjUovVGFw/m9R88461h/kTf4+FS?=
 =?us-ascii?Q?rT8r9Jh8gGoVlQiwWrD0URSQzAz3u2Wj9xLIA4oYz12CyLeT1XZRZzz26kfi?=
 =?us-ascii?Q?m+rzmeTaefIc7A4KyDFjzg3HncS/7OHzgdGF/scUv7lNmbG5+On3L38xTxcS?=
 =?us-ascii?Q?NPojpftNpFBs/gpvIC3AGX/pNxleWyCncZzsn/no/PItthTQmb42k2LR80JA?=
 =?us-ascii?Q?YWOPsPvDK7dXAZNci8ytw3x2Ht5lNuhO7wJLJ+j7UDliWM5J/HYOzQLnbkRv?=
 =?us-ascii?Q?JGw3P8cCtnlGjXBvVaUJe1BRVKYRf+8WbqluNlkKoMu6dGCnVpeCOH0Ydsy2?=
 =?us-ascii?Q?9RL6yjdxebPu55pachENTkOyGsGxrD1tNKVClRlKAaGDEBvTLIqtkdqOxHNe?=
 =?us-ascii?Q?76vuoAXp5ulmKhB0quuGajSmlF63ba3lRBZfuQFPuP23SItguohtdA8yzMCo?=
 =?us-ascii?Q?GGkUT66kLQccDq3V1qa1tthBeWFdPoKnjs5sOpi/GcNBeX68DkcFBdzVP9Yi?=
 =?us-ascii?Q?yV2FXVjkH8+abUc31GKcW9gMD1R7ZZmfSwHBTvxridPnYS7kydfrMrkwQDR3?=
 =?us-ascii?Q?ucWTqzAzPgJW+c60vjibQtHEag9a6STE5nDY3oY4y2LvLD5OMmCfEs6KkMJN?=
 =?us-ascii?Q?zjfUGPjoqMN1g+h5/Un20TZan9K34/emj2LVcxvIPiYA8jn04jK97AWry+Cy?=
 =?us-ascii?Q?HFTjKRoupD/wBEWd3EyCpJp3Rq7Qf7Vy656JmHdus9GrzqydIbma8IFtH48a?=
 =?us-ascii?Q?jcHCrOluTHIVjHCdpSxP41Oi2a+/Us9ZHFsRiU0kDtTPTRi4R2q3HpBWyfow?=
 =?us-ascii?Q?I224CETuWz0X/tGr0pq5RsU1swpSlq4iza8i9lTbETXzZWDZT5W6SpK4Zdzy?=
 =?us-ascii?Q?i46g3AZRO+QfrsQsim9uqhNuXeDtjLbovaZSLeQKcs7Ccsz2pEFY2zYwKZqr?=
 =?us-ascii?Q?AYTWwAOHtqwXMbDIDZj2g8H9/DpOGVxncz9VH3uJE/Se+bD4UY1KP+CzgxWp?=
 =?us-ascii?Q?tkMtWkbgz+7CItL4Tb2bx23UilQUe53aFaGvXXP4ypEq7RaVjOxb1lqBtP+V?=
 =?us-ascii?Q?jt5ltSyGqu74JJgQ77DCghX7frMUAX/ej0vQ8foeIDsuhbwlrIsfM1N/AjvS?=
 =?us-ascii?Q?DdK7L0A9vPIOcFX3x9FhPHFqg4HP5jQ5asQChtbYnGvxR567jFjHmFEEJRBt?=
 =?us-ascii?Q?znZE7/e7xSuysOsZF6XrA3S7koLbfEo79iNjrIbDy1vP58OdgpONn8T1UZ1X?=
 =?us-ascii?Q?c5AJANMlYiCc54aV6WBd9LwKVXSatfRAhC68g5Untly4oZeTv3C1k5BMOrNf?=
 =?us-ascii?Q?0gLPRzkPd/0dfQe7LzqmRXcw8iESazPmMNDod1ozDt1KTCUcKf2R+5A5Y+HO?=
 =?us-ascii?Q?mPY6+PsOYB54d96TGqP+WZOWlmo9SdwcmF8jjx7D0OTMm6rsY5yXcXpfjSJr?=
 =?us-ascii?Q?rOQ8UDUQTxT6nQliefQi5AxOa+p+4mwMpwtNn4E4?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 772bf655-1ca7-491e-f7c0-08dc0274f763
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2023 22:34:17.1432
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dtCukw6mZW+LWeH81Gj7Edx8YrR8/vxB2gqnrodcj4pJ9phSQKgVZOCrLfdUEaef0V+6cfPDP5fxjJmCfdi2bQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8374
X-OriginatorOrg: intel.com

Ira Weiny wrote:
> Randy Dunlap wrote:

[snip]

> > diff -- a/drivers/nvdimm/dimm_devs.c b/drivers/nvdimm/dimm_devs.c
> > --- a/drivers/nvdimm/dimm_devs.c
> > +++ b/drivers/nvdimm/dimm_devs.c
> > @@ -53,7 +53,10 @@ static int validate_dimm(struct nvdimm_d
> >  
> >  /**
> >   * nvdimm_init_nsarea - determine the geometry of a dimm's namespace area
> > - * @nvdimm: dimm to initialize
> > + * @ndd: dimm to initialize
> > + *
> > + * Returns: %0 if the area is already valid, -errno on error,
> 
> This is good...
> 
> > ...otherwise an
> > + * ND_CMD_* status code.
> 
> I don't see where any of the ->ndctl() calls return an ND_CMD_* status
> code.  What am I missing?

If you agree that this should be dropped I can clean it up as I'm trying
to prep the nvdimm tree now and was hoping to take this series.

Ira

> 
> The rest looks good,
> Ira

