Return-Path: <linux-kernel+bounces-44733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FC308426AC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 15:10:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2559A28D9C1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 14:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE4DF6D1D7;
	Tue, 30 Jan 2024 14:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Nqlsg4UU"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2FDF6DD03
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 14:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706623795; cv=fail; b=lHbrisMpUmX9a9Ab7jvLnFr4wvsxG6FnAvG/YT/EAWsmjhvaqax/DcSCIJg/pOzyrw+TwXZVeZvcSZ7e2ScxJmt+wTivDgGP26HEtQCHFMEbVaVqMEt12YB16mYsI94fN6JlRnoDzfrdPpQvHhVmGb/m/xn8LNxaaVdTvUIsYck=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706623795; c=relaxed/simple;
	bh=H3acP0x24MWLkdgZeNqGL+S1QSl2sVZ4u9QP3b3fC5E=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bg9XHjH7HNH63biC9qXnFCOt02IZGBpTwFiRE55FC8yd9UV6W/hM112MmUZ7thHWHqGX/fIW3pgU/EUPzoJ2+CYUsvOBTMlCW1b9CSjd/G0+6YYXYutl5AYNLthsUI+cNjl6aM023C+sk8qc5m2GjgcxfO3Xpu+VLJ2WNj/kHpA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Nqlsg4UU; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706623794; x=1738159794;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=H3acP0x24MWLkdgZeNqGL+S1QSl2sVZ4u9QP3b3fC5E=;
  b=Nqlsg4UUuw78VD1jMbPwtaTOpPUqxusFQIgy2zeSgTBxxukEtXlzSVUD
   eYX++DsBY1FQb1+93Su3vzUwx70IeX3Mwolo+cTlt5MnC5b2TaW5sCABP
   RL0Dj4zcemmkcnoZ9f3EKYTfDpJpZzI7RbMH6Eni5swBzk3vne+DgfxC7
   tVTqcHdPAB+WPqqKPK2ze+MULBBrGSW2zgRRShPwSbyU3TcVl9gB1rzOu
   Hi9wsOYrTbte8eltfqBn6KQWbtGIo4VppWFLC6GA9XsgYyWooLtAJ3wWf
   uD+eYubuEytr9WA9BI9bqQjwKYeJwR63UJZ2zXF2nfkMzg2bJZyHJoSU9
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="2224596"
X-IronPort-AV: E=Sophos;i="6.05,707,1701158400"; 
   d="scan'208";a="2224596"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2024 06:09:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="858500331"
X-IronPort-AV: E=Sophos;i="6.05,707,1701158400"; 
   d="scan'208";a="858500331"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Jan 2024 06:09:51 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 30 Jan 2024 06:09:50 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 30 Jan 2024 06:09:50 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 30 Jan 2024 06:09:50 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 30 Jan 2024 06:09:49 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E6WMGXNdsISAQrJAhpiTZJ00IEqiuVweQlAQKhNcYinFM3aWvIxAaDcyHTh3+GZPc3hpvefTg44kwBT6ULe03U90Rbsm3g1uKO0JdWcNq8jzKgXKJxedRhzPSsy2jEYMzvPo/fGSvopsxwTeY2BH8qZBuwjlxXOb8YNuxLG114qsQf47OyxJrTW5KWLfS8eU1uuODw61J8eBTQcxdLO0lbE3qyv+miYH9HPjnjRbEb6xkS065WA6UPTK6zXMXUiiubkftJdAEafgD6g6xBC4vMke4k06KMB9JPTMFPUArTOWIoLtFs8iihjxYRSNFyyDzLtlz3cF0kcwK+A+fqjOKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OSxtzNsw5q7WtgfIfdi093tTk++fsPYouny3VGZrpVg=;
 b=MgLeqPlrWnNngC1R1MpMmh+niPirxM4jgw9iZCxFhYPP8nkx8nJtbBCrnKeNiM/LrvQ/7O3AzNRvArSPwnBhoMNNobrMn5EAYnysEraiHtNW0LheG26Ds0UF5mWkJgMvkxJszG77WSZoKVkF9JWLtYxHjOKxpdjfbv8M62nBGNQ6aYlEL9JydREPKdKMQjv2mapXCjjcExrrUlrSnZkEBnIMk7DMgbFW4+3T5WVV2SfK1o4bqjZaEDhZnTsfyohSJw+wdSY2vC1UMrN7c2ISAjyegmyjMdQmmzJw2MblL/2FN8oytQ7iIgKnzOO+9CC7ut90evANvAPEwbGBLj8fBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by PH0PR11MB5658.namprd11.prod.outlook.com (2603:10b6:510:e2::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Tue, 30 Jan
 2024 14:09:46 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::a026:574d:dab0:dc8e]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::a026:574d:dab0:dc8e%3]) with mapi id 15.20.7228.029; Tue, 30 Jan 2024
 14:09:46 +0000
Date: Tue, 30 Jan 2024 22:09:38 +0800
From: Oliver Sang <oliver.sang@intel.com>
To: Abel Wu <wuyun.abel@bytedance.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Peter Zijlstra <peterz@infradead.org>, <aubrey.li@linux.intel.com>,
	<yu.c.chen@intel.com>, Tiwei Bie <tiwei.btw@antgroup.com>,
	<oliver.sang@intel.com>
Subject: Re: [linus:master] [sched/eevdf] 2227a957e1:
 BUG:kernel_NULL_pointer_dereference,address
Message-ID: <ZbkDIlIR7qzPt7Vk@xsang-OptiPlex-9020>
References: <202401301012.2ed95df0-oliver.sang@intel.com>
 <23cbb613-c8a2-4f07-b83b-fa3104bef642@bytedance.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <23cbb613-c8a2-4f07-b83b-fa3104bef642@bytedance.com>
X-ClientProxiedBy: SG2PR02CA0050.apcprd02.prod.outlook.com
 (2603:1096:4:54::14) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|PH0PR11MB5658:EE_
X-MS-Office365-Filtering-Correlation-Id: b521b9bf-e860-48d5-8f75-08dc219d1d48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MCmeEKujfYe2SoldCujjjbMaJNZTP1h5Behg+pNCa6CI123k5P8Uy6s5tX568nKnjQVe9s2z8Wiz8ApCtSBWLlIRbBxvvLntq2JpBO0ptG0mptuOHd/4ZQ9H9/MIx6Ei8wnuU3lJvAWt8VDgrNNm7T2yG6QScNnNAAJtSrV4bzSWfntAUCjB4XSqzdyC5Rg3aq/FMbOqejp1TNulLXfxipuP5sb7UJO6j69PZ9nys4CxhyjWbIevG86EgCaMjPOdre8q8h63pqXwghd/I0tFJLaCku6EF0PGrOlkSuj7+1MyeHX/vcd+x1tMF1bWUDAAKSal4MLeO9NbMRi3VPSl3XifiIYZ01pIuz2j6dJsNEkIqP4WCj3lL31VJaFil27+TJh2FrHelOEtv/b20c8dHYSY68BMoBI6XMYJGUoIjgbV0vwbaZUvoohjO4L0QrekuviXr8ziuGEn3rYCwtRrzP4ZF9ohH6kTAwimv0EGb/fbkAwjFra1deTuniMalgE6DeiZfNS8onUcHjrDJlPK+f93iEQ07bvDpAseeTKnTbdRYIqYc9sOCXN3gxJcUh5u5IkQ/JyqwNiN9XmVrKMRnwvK8hFGVhQLfrH9QMuhIEgj2bUQ4ba48AB0a1rSx4EO
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(136003)(39860400002)(376002)(346002)(366004)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(26005)(966005)(6486002)(6512007)(83380400001)(478600001)(6916009)(66946007)(54906003)(66556008)(66476007)(316002)(6506007)(6666004)(33716001)(9686003)(8676002)(8936002)(4326008)(44832011)(86362001)(5660300002)(38100700002)(82960400001)(2906002)(41300700001)(505234007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jxPaBkLJo74LRnPUA07eurzqXG7Jiu4YW+gCD7xuc4hfm31dU7npfMKKRAY0?=
 =?us-ascii?Q?kHXU2crXeJWsajqWCToLY4QfclkIPY3m3oBWdyXGFGF++1hHiEtkHp9eoKOe?=
 =?us-ascii?Q?W8jmDM386+8E95qMqMHFXxf2/a5m5i4L1QJUYXCSIYlvZQ3HZMd6ZGvVQ/XC?=
 =?us-ascii?Q?YZL5pZ1A6FdM4eWw0IYrePwjlzzhu6cBz/vONwDt/k7EA+k8V53qPgekTluC?=
 =?us-ascii?Q?GLoCe9OnpnQ5YyEI2D6FyOLTrl0aMRWiXhi3uF+WepOoyIVccPLGNn0vUAaY?=
 =?us-ascii?Q?Ku0vDnv2GyF0ZBzRdMWN0wUwE9V6jOjvWK3mtsAL8D3yt0Nj2DDivpB1/OGj?=
 =?us-ascii?Q?v3m46dH0hYEdVQ/li8TfFiPPp/IZvHqxLOs+JFzzYB28l0GAbe7i0GKuEOq4?=
 =?us-ascii?Q?fcJAd1f3jS+z0h6pEQKbK9bYIo8AhO+v1ainRoWxRuq2cBifzbyEF0faeyZH?=
 =?us-ascii?Q?EpBM7r4cRDt52ko3g5Fr2BT3305IP5VCjrx+/4Y13lwyNVkrxDsmG7CoYgF6?=
 =?us-ascii?Q?df0TWoTC61uk1zOYTYjRILxlXmvUZCQRppPDSHSsatpWGGlOUUaxWLLUm/LG?=
 =?us-ascii?Q?wTRRRF8mW8vyCCyS7AIAs43o0hQOk0dl2EvK5lM5P6ijN01jXSOUPE9IwjOx?=
 =?us-ascii?Q?fSkAqSzBevEVA/dHujvxpNJ6Js5Tdj6YNfBN0+Rqc837Re5tSb3ZgUhuL6r6?=
 =?us-ascii?Q?/fucb1GhkkeEEMabJL4kricy7NemIpNOmvgJ6ooADASUGv7EbG2wjrBdLweB?=
 =?us-ascii?Q?2zKY2FPs0VjsUkBGVcO0Oec70DmpxP1Kd8KNwQWJaRs9m069RSD+uuLylvtA?=
 =?us-ascii?Q?e78beEkh4fIGR1uqmRpJgAOtzQ0uxII22A6g1LT8eRabkN9pnhK9zRjG0kS5?=
 =?us-ascii?Q?Y7h44WgLf3id6+lQFqcs6QvTFIWSNJS+QNQn5hNUgcsuFZNdNa3vJ3lQpUpT?=
 =?us-ascii?Q?hQxxVEx/QUt6f8yrd5toZaE1z9w2WqlTvpL+kYhcV5818+hPyyWwtozrneu0?=
 =?us-ascii?Q?BZ2TOiQFGjopZU2B39qjDgSFQ890F/d58D6hZK7h5BgxWIrH1KPPMKqWFWA/?=
 =?us-ascii?Q?GLXxPLueJ3k6udKOKiHiajqSqi0jJASHCK9fmDVTjNbb4ZuVoA3UHluVDmnX?=
 =?us-ascii?Q?dM0accDx2a6iu7J5CtGd32gkyyPkp90i2bI9CQVCE0Oe4gxFFUmTsw2ag9wA?=
 =?us-ascii?Q?BzNQV4rMZt92ynD35DAGIHwZd8tU5I/QXJOCnjwoo1wCycx7E4pHBs+p0qdj?=
 =?us-ascii?Q?x4dws40/ozGaODKF/NiPIvrZqMyWSJnfgIX3QIk6Upd0oZoB5v4ZEFXt6PM4?=
 =?us-ascii?Q?tCr6/KhppWOAioUIJwNdeG8NDsbi4k1XVbV2KdF+OaDATucyo8fwrhOSW0V0?=
 =?us-ascii?Q?uGNc+dwFGcBOlZhPrmYRacqCioU/flXt4uwo8W/+6Ifr0PdRa5dvuRlvb/rG?=
 =?us-ascii?Q?kDFzPNcGFwTzCQ3yCOSWLCNEcyA0SeHYrNGCTywxwFkcXDG9bWFqFJmWy+cM?=
 =?us-ascii?Q?O+GuXRq/vSvV2cqdccK1eWHP44DOhsmZ8zhFTwZV6XGnx3a6GinRYneUI4I/?=
 =?us-ascii?Q?PJW8CX8BmRCKlXtVkKQpEbU3ibiKkHHXsI0Sdo6Q7oa4TQxhJrawSD3UYzUX?=
 =?us-ascii?Q?zA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b521b9bf-e860-48d5-8f75-08dc219d1d48
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2024 14:09:46.7898
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E5cpOZP783Q7d0xmbBaJ8YDBsfuRk3d73LgoKF2omjgZ0dNtsOQeuCV3iXhdpDBgDewPSNaHt+WDxiHC7+1kiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5658
X-OriginatorOrg: intel.com

hi, Abel,

On Tue, Jan 30, 2024 at 06:13:32PM +0800, Abel Wu wrote:
> On 1/30/24 3:24 PM, kernel test robot Wrote:
> > 
> > 
> > Hello,
> > 
> > (besides a previous performance report),
> > kernel test robot noticed "BUG:kernel_NULL_pointer_dereference,address" on:
> > 
> > commit: 2227a957e1d5b1941be4e4207879ec74f4bb37f8 ("sched/eevdf: Sort the rbtree by virtual deadline")
> > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> > 
> > [test failed on linus/master 3a5879d495b226d0404098e3564462d5f1daa33b]
> > [test failed on linux-next/master 01af33cc9894b4489fb68fa35c40e9fe85df63dc]
> > 
> > in testcase: trinity
> > version: trinity-i386-abe9de86-1_20230429
> > with following parameters:
> > 
> > 	runtime: 300s
> > 	group: group-03
> > 	nr_groups: 5
> > 
> > test-description: Trinity is a linux system call fuzz tester.
> > test-url: http://codemonkey.org.uk/projects/trinity/
> > 
> > 
> > compiler: clang-17
> > test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G
> > 
> > (please refer to attached dmesg/kmsg for entire log/backtrace)
> > 
> > 
> > 
> > we found this issue happens in very random way (23 out of 999 runs).
> > but keeps clean on parent.
> 
> Thanks for reporting, I will try to reproduce the issue. Does the 'parent'
> mean the same code branch without this commit?


it just means the parent in git log.

xsang@inn:/c/repo/linux$ git log --oneline --graph 2227a957e1
* 2227a957e1d5b sched/eevdf: Sort the rbtree by virtual deadline
* 84db47ca7146d sched/numa: Fix mm numa_scan_seq based unconditional scan  <-- parent


> 
> > 
> > 84db47ca7146d7bd 2227a957e1d5b1941be4e420787
> > ---------------- ---------------------------
> >         fail:runs  %reproduction    fail:runs
> >             |             |             |
> >             :999          2%          23:999   dmesg.BUG:kernel_NULL_pointer_dereference,address
> >             :999          2%          23:999   dmesg.Kernel_panic-not_syncing:Fatal_exception
> >             :999          2%          23:999   dmesg.Oops:#[##]
> > 
> > 
> > 
> > 
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <oliver.sang@intel.com>
> > | Closes: https://lore.kernel.org/oe-lkp/202401301012.2ed95df0-oliver.sang@intel.com
> > 
> > 
> > sorry for below parse failure which caused no real line numbers.
> > we will follow further. the orgial dmesg could be fetch from below link.
> > 
> > 
> > [  512.079810][ T8305] BUG: kernel NULL pointer dereference, address: 0000002c
> > [  512.080897][ T8305] #PF: supervisor read access in kernel mode
> > [  512.081636][ T8305] #PF: error_code(0x0000) - not-present page
> > [  512.082337][ T8305] *pde = 00000000
> > [  512.082829][ T8305] Oops: 0000 [#1] PREEMPT SMP
> > [  512.083407][ T8305] CPU: 1 PID: 8305 Comm: watchdog Tainted: G        W        N 6.7.0-rc1-00006-g2227a957e1d5 #1 819e6d1a8b887f5f97adb4aed77d98b15504c836
> > [  512.084986][ T8305] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
> > [ 512.086203][ T8305] EIP: set_next_entity (fair.c:?)
> 
> There was actually a NULL-test in pick_eevdf() before this commit,
> but I removed it by intent as I found it impossible to be NULL after
> examining 'all' the cases.
> 
> Also cc Tiwei who once proposed to add this check back.
> https://lore.kernel.org/all/20231208112100.18141-1-tiwei.btw@antgroup.com/
> 
> Thanks,
> 	Abel
> 
> > [ 512.086881][ T8305] Code: 89 d6 89 cf 85 d2 74 22 39 77 58 75 1d 89 f0 90 90 90 90 90 8b 48 70 39 41 58 75 0e c7 41 58 00 00 00 00 8b 40 6c 85 c0 75 ea <83> 7e 2c 00 74 28 3e 8d 74 26 00 89 f9 89 f2 e8 36 59 00 00 89 f9
> > All code
> > ========
> >     0:	89 d6                	mov    %edx,%esi
> >     2:	89 cf                	mov    %ecx,%edi
> >     4:	85 d2                	test   %edx,%edx
> >     6:	74 22                	je     0x2a
> >     8:	39 77 58             	cmp    %esi,0x58(%rdi)
> >     b:	75 1d                	jne    0x2a
> >     d:	89 f0                	mov    %esi,%eax
> >     f:	90                   	nop
> >    10:	90                   	nop
> >    11:	90                   	nop
> >    12:	90                   	nop
> >    13:	90                   	nop
> >    14:	8b 48 70             	mov    0x70(%rax),%ecx
> >    17:	39 41 58             	cmp    %eax,0x58(%rcx)
> >    1a:	75 0e                	jne    0x2a
> >    1c:	c7 41 58 00 00 00 00 	movl   $0x0,0x58(%rcx)
> >    23:	8b 40 6c             	mov    0x6c(%rax),%eax
> >    26:	85 c0                	test   %eax,%eax
> >    28:	75 ea                	jne    0x14
> >    2a:*	83 7e 2c 00          	cmpl   $0x0,0x2c(%rsi)		<-- trapping instruction
> >    2e:	74 28                	je     0x58
> >    30:	3e 8d 74 26 00       	lea    %ds:0x0(%rsi,%riz,1),%esi
> >    35:	89 f9                	mov    %edi,%ecx
> >    37:	89 f2                	mov    %esi,%edx
> >    39:	e8 36 59 00 00       	callq  0x5974
> >    3e:	89 f9                	mov    %edi,%ecx
> > 
> > Code starting with the faulting instruction
> > ===========================================
> >     0:	83 7e 2c 00          	cmpl   $0x0,0x2c(%rsi)
> >     4:	74 28                	je     0x2e
> >     6:	3e 8d 74 26 00       	lea    %ds:0x0(%rsi,%riz,1),%esi
> >     b:	89 f9                	mov    %edi,%ecx
> >     d:	89 f2                	mov    %esi,%edx
> >     f:	e8 36 59 00 00       	callq  0x594a
> >    14:	89 f9                	mov    %edi,%ecx
> > [  512.089261][ T8305] EAX: 00000000 EBX: e75ff100 ECX: e75ff100 EDX: 00000000
> > [  512.090180][ T8305] ESI: 00000000 EDI: e75ff100 EBP: ed229dd0 ESP: ed229dc0
> > [  512.091097][ T8305] DS: 007b ES: 007b FS: 00d8 GS: 0033 SS: 0068 EFLAGS: 00010046
> > [  512.092138][ T8305] CR0: 80050033 CR2: 0000002c CR3: 0a508000 CR4: 000406d0
> > [  512.093076][ T8305] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
> > [  512.094004][ T8305] DR6: fffe0ff0 DR7: 00000400
> > [  512.094643][ T8305] Call Trace:
> > [ 512.095145][ T8305] ? __die_body (dumpstack.c:?)
> > [ 512.095755][ T8305] ? __die (??:?)
> > [ 512.096309][ T8305] ? page_fault_oops (fault.c:?)
> > [ 512.096994][ T8305] ? __lock_acquire (lockdep.c:?)
> > [ 512.097677][ T8305] ? kmemleak_alloc (??:?)
> > [ 512.098343][ T8305] ? kernelmode_fixup_or_oops (fault.c:?)
> > [ 512.099085][ T8305] ? __bad_area_nosemaphore (fault.c:?)
> > [ 512.099839][ T8305] ? bad_area_nosemaphore (fault.c:?)
> > [ 512.100579][ T8305] ? do_user_addr_fault (fault.c:?)
> > [ 512.101325][ T8305] ? exc_page_fault (??:?)
> > [ 512.101992][ T8305] ? pvclock_clocksource_read_nowd (??:?)
> > [ 512.102799][ T8305] ? handle_exception (init_task.c:?)
> > [ 512.103492][ T8305] ? yield_to_task_fair (fair.c:?)
> > [ 512.104166][ T8305] ? pvclock_clocksource_read_nowd (??:?)
> > [ 512.104975][ T8305] ? set_next_entity (fair.c:?)
> > [ 512.105655][ T8305] ? pvclock_clocksource_read_nowd (??:?)
> > [ 512.106447][ T8305] ? set_next_entity (fair.c:?)
> > [ 512.107106][ T8305] pick_next_task_fair (??:?)
> > [ 512.107788][ T8305] ? put_prev_task_rt (build_policy.c:?)
> > [ 512.108460][ T8305] __pick_next_task_fair (fair.c:?)
> > [ 512.109162][ T8305] __schedule (core.c:?)
> > [ 512.109753][ T8305] schedule (??:?)
> > [ 512.110284][ T8305] do_nanosleep (hrtimer.c:?)
> > [ 512.110900][ T8305] hrtimer_nanosleep (??:?)
> > [ 512.111581][ T8305] ? __remove_hrtimer (hrtimer.c:?)
> > [ 512.112264][ T8305] common_nsleep (posix-timers.c:?)
> > [ 512.112891][ T8305] __ia32_sys_clock_nanosleep (??:?)
> > [ 512.113657][ T8305] ? syscall_enter_from_user_mode_work (??:?)
> > [ 512.114486][ T8305] __do_fast_syscall_32 (common.c:?)
> > [ 512.115180][ T8305] ? irqentry_exit_to_user_mode (??:?)
> > [ 512.115936][ T8305] ? irqentry_exit_to_user_mode (??:?)
> > [ 512.116690][ T8305] do_fast_syscall_32 (??:?)
> > [ 512.117386][ T8305] do_SYSENTER_32 (??:?)
> > [ 512.118022][ T8305] entry_SYSENTER_32 (??:?)
> > [  512.118645][ T8305] EIP: 0xb7edf539
> > [ 512.119172][ T8305] Code: 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 0f 1f 00 58 b8 77 00 00 00 cd 80 90 0f 1f
> > All code
> > ========
> >     0:	03 74 b4 01          	add    0x1(%rsp,%rsi,4),%esi
> >     4:	10 07                	adc    %al,(%rdi)
> >     6:	03 74 b0 01          	add    0x1(%rax,%rsi,4),%esi
> >     a:	10 08                	adc    %cl,(%rax)
> >     c:	03 74 d8 01          	add    0x1(%rax,%rbx,8),%esi
> > 	...
> >    20:	00 51 52             	add    %dl,0x52(%rcx)
> >    23:	55                   	push   %rbp
> >    24:*	89 e5                	mov    %esp,%ebp		<-- trapping instruction
> >    26:	0f 34                	sysenter
> >    28:	cd 80                	int    $0x80
> >    2a:	5d                   	pop    %rbp
> >    2b:	5a                   	pop    %rdx
> >    2c:	59                   	pop    %rcx
> >    2d:	c3                   	retq
> >    2e:	90                   	nop
> >    2f:	90                   	nop
> >    30:	90                   	nop
> >    31:	90                   	nop
> >    32:	0f 1f 00             	nopl   (%rax)
> >    35:	58                   	pop    %rax
> >    36:	b8 77 00 00 00       	mov    $0x77,%eax
> >    3b:	cd 80                	int    $0x80
> >    3d:	90                   	nop
> >    3e:	0f                   	.byte 0xf
> >    3f:	1f                   	(bad)
> > 
> > Code starting with the faulting instruction
> > ===========================================
> >     0:	5d                   	pop    %rbp
> >     1:	5a                   	pop    %rdx
> >     2:	59                   	pop    %rcx
> >     3:	c3                   	retq
> >     4:	90                   	nop
> >     5:	90                   	nop
> >     6:	90                   	nop
> >     7:	90                   	nop
> >     8:	0f 1f 00             	nopl   (%rax)
> >     b:	58                   	pop    %rax
> >     c:	b8 77 00 00 00       	mov    $0x77,%eax
> >    11:	cd 80                	int    $0x80
> >    13:	90                   	nop
> >    14:	0f                   	.byte 0xf
> >    15:	1f                   	(bad)
> > 
> > 
> > The kernel config and materials to reproduce are available at:
> > https://download.01.org/0day-ci/archive/20240130/202401301012.2ed95df0-oliver.sang@intel.com
> > 
> > 
> > 

