Return-Path: <linux-kernel+bounces-17263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 334BA824A8E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 22:58:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9B0E286A48
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 21:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9383F2C85F;
	Thu,  4 Jan 2024 21:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eIFD4c63"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BADF2C850;
	Thu,  4 Jan 2024 21:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704405518; x=1735941518;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=+aREsD0+Xd0JjLDlGcXtpr9ykJSPl7fKisEK9gyn33E=;
  b=eIFD4c63Fy1kmmcL38GD4fugLe23Ba3I8DcslJn8aYZuEPt3ABBJYkhE
   8+9ZmQGSkug32SsqujY81bjffg3Ib7/dndPLtM3Ev8u967CPFt+G6GJhP
   mMM33jpWsqOjr8y2D7eiF7NWcUiPpW5b5b8swciNnyjYoMflW5ewfU6tk
   wFMQDRWxm4Jm3UqsMwU7jnjrCFuBA57vExgoStNGYVSevhXyYpEBbzmaY
   AE9FXiDUR/8dEpSP2AZITZaHDwoPGUibYlZ7UDVZ3ttbAZh+ZnNDNtYF8
   cByCirBbwVLrNcq2JAtyeP2pM3LZ3Rn195Ed/BOe1WcjtGg+dui8Oqtf8
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10943"; a="401157344"
X-IronPort-AV: E=Sophos;i="6.04,331,1695711600"; 
   d="scan'208";a="401157344"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2024 13:58:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10943"; a="809375777"
X-IronPort-AV: E=Sophos;i="6.04,331,1695711600"; 
   d="scan'208";a="809375777"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Jan 2024 13:58:17 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 4 Jan 2024 13:58:17 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 4 Jan 2024 13:58:16 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 4 Jan 2024 13:58:16 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 4 Jan 2024 13:58:16 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iLKAvpyhi76vfCy3SWUwnsY7Bpukv57Pb5OrPrabI8RHWgbuv1+rv+ih/U5kj5Zff1zkZtwyzdRBVHcwV8JQ/Tq+3ODUzbqn3h3kr4TgXorgGO39k7FWENMuHzj0c6765ojwPmg5B7n/Y6Zl84UR3GWi6puHe9rtRNHTGR1m948ha3HzPsYT+Z+pQ6AHATYRdu9k6WvZBfu6wM1+L7t+hGf+itRhvcx5ZNDazlQaKkfou0hjf/5t5EpyBJAYVXp7Y+pynRC16AhHI/H+7uaStpAsLdsVudyAo4qWG6G3gXjQiGz2+4P37cGeOW4H66F8cdM804P7X/edzDCD1N3EsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uYBSMfzCISye8pXaUTe7NIu9AXZLT0/vVD6PKMuZFtU=;
 b=Tww4Tqhy9ddyajjQoaRcnOFfqsDlkzQOOAIK2HK0c/VNY2RnxFsTTfcuQg27wUsnRN9NPcCfEiNhFSTflZkXs3429IaHsVvmRCDuF+qotHCqm8+qCsx0asDGLn0OUlfrFsBfS4Evpn8CX+G8jwxdpFAhPnOXBeCK9A4AupxCKuuTEBivS49e0ME3YVu6xm+4pBeuCy15ah+0zbL8J2ETJFT+wMTf1pvFas/4V8vjmhk+LSudN2+EE5eqAaM12dDbBfwvJmJ8NRcsZfNq/nFxKDSc8bodSdwElnZ/vUHLrdM176i+JJpM9WVmyuRTa5YIvxfPyhhXnz9MNmJ6FD4yjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DS0PR11MB7408.namprd11.prod.outlook.com (2603:10b6:8:136::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.16; Thu, 4 Jan
 2024 21:58:08 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2%4]) with mapi id 15.20.7159.013; Thu, 4 Jan 2024
 21:58:08 +0000
Date: Thu, 4 Jan 2024 13:58:06 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>, Dan Williams
	<dan.j.williams@intel.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Linux Next
 Mailing List" <linux-next@vger.kernel.org>
Subject: Re: linux-next: duplicate patches in the cxl-fixes tree
Message-ID: <659729ee7673a_8dc682941d@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240102023218.3cd3e4ea@canb.auug.org.au>
 <20240105085306.60979082@canb.auug.org.au>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240105085306.60979082@canb.auug.org.au>
X-ClientProxiedBy: MW4PR04CA0330.namprd04.prod.outlook.com
 (2603:10b6:303:82::35) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DS0PR11MB7408:EE_
X-MS-Office365-Filtering-Correlation-Id: cabe16f4-1646-420e-a364-08dc0d703cbf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3aerT3bpXb81YQewOi9tTU5mhMLXz9/dqfbGopK99Jb+6sQcYSBYKm6Z9uWkiiaVEUSoLcpKI7bHqzrX8GObgBxlVUd0lMdiL9IloCA4NFvPm90ig4v5XG16EuT29FOdmWCC2DYvf5HjsiXxd5VjpPr3S6eZOAP69V221AFcEE3tiVU9Sdny8I3S3dkv9S/1Z4AVMLaxMNmzTKdx70Y6akRngDMSU9pLy7rZ2IyZ8D35uaYvJaylt0nRFxu70sFYZqA4KD/f9m/g9DYPQ5SUOjBInUvTjHEioZ5UWoxWvpqbhGLQIrIFScCWgxC7wvWbJcUdyZHP+JwM5ArY8aXqv4vBLVnij9XFLTrG5ZWfPvy7BNkGAZzUlTaDjMFy9TGFoHTs71MVCxSESkAjEvr+YKjJi7rDZv8MEEU8tMEEc5A6BWoj3QEntFAGPjnc/lQwcrCtRScLdKVCVtmtc5RCEoolw6aZzn7y/TuguOnIw6F2zVuT3nhY91P/zB9gbQui/pjgqxUDuawF9lwcDMWORY6X2yuosZeQ+wVjogSotGBhikLWMAsBCEdu08n3tbHA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(136003)(376002)(396003)(366004)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(38100700002)(82960400001)(86362001)(26005)(9686003)(6512007)(316002)(6506007)(66556008)(66946007)(66476007)(54906003)(6486002)(8936002)(110136005)(478600001)(4326008)(8676002)(41300700001)(5660300002)(2906002)(4744005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?u86e00kiDGVwjvJhdapVoCE4spuuDk1lhRtsN+P5BRmaS2tSdsJGmOtV+VTQ?=
 =?us-ascii?Q?wnGR3pkqKlHtxqXNR7u6VglOr79r1XcxRENdu+hrhH1iziduIqLItbXNOMf1?=
 =?us-ascii?Q?SDhTxA5DL9GNtHxJCRDokZPxFZiG1oYyY0g6O3JOVo459rKTjAIiu5ukYT/I?=
 =?us-ascii?Q?QeDcM2DM9gLEJseFuOA3qEbfjpBz/CiFLCoy/P7izCGAu9lPUSKFgjqf0Ixu?=
 =?us-ascii?Q?M2rslVq4M2rwhgh9S93zBMCl+hmCPcMVS4p1OHrjbixBmnX5XNwjPiSpMnSk?=
 =?us-ascii?Q?6F2/pfFYj3fZa5julisIPFkkYyIOLsK4sFGIjP6E13sZTnzQJEaHzTu7sYZ0?=
 =?us-ascii?Q?s8m2PLi4TSNC1x1QEqDol/3UvdFMDdHHeihL+pbRONzl05grBf/vzYKLQn0t?=
 =?us-ascii?Q?frBqQx8Y3jDBGwY4PSUDNIjBV44cC02p1W/My2EadE3gh2AsLSDopOmRG7q5?=
 =?us-ascii?Q?InotIDFhS6m9ulXyiW99fvmixkkkLn/urBgcXHiz8hAYGdA8PoiAANvTjLU3?=
 =?us-ascii?Q?Rovv7ARHKDi3Eh9VuXpHCmyxXm9pWMfg2CQkcH4IvPY2K6/r022raJSKH233?=
 =?us-ascii?Q?Oi1XQ+gt+O1FDkcsgFB2ZSel6MnUl2BnmRRiuR0pdGIOUdhu1Eohuzist1r0?=
 =?us-ascii?Q?k3KNkLh6vpgOtA6uKHffY8ySgz+mxG5MMdOy9TH0sgaU16mW1+nX9KJbjzGy?=
 =?us-ascii?Q?7rSWqv7HSHNvpqJdXkv/EvfsbVaJyq6hK20K44I8+uI9aS2/ZVD+1OrtomvW?=
 =?us-ascii?Q?dPErKd4Thu2FV8rCMhEHYlF9QUGXZWvvFD67RRyK+eNJF89rc6qKYAW7bC7G?=
 =?us-ascii?Q?q2RWoQmlLrBQX8vHopjePnDnN75t5jRSHkQpoLCNT9z6xLdgR+/UkruXQeSl?=
 =?us-ascii?Q?VGx4iHDjZesbTg1rvh6c3NtNd+TMlc5KuSKjDdTi5/9hGdoqmj4YQtTlixpD?=
 =?us-ascii?Q?a7D7p6NDSNlu6h4D12GDlX1CrkhiV8pBUu4Y0ZM0Nvbq8HS6HLcVflXc9fBD?=
 =?us-ascii?Q?E//NJhGT1UNfyC8ZZOG4WfVpysAznAq5+hNTKRQSgTbPW5kidK/FF97GBg9z?=
 =?us-ascii?Q?7TyLuBpja07364JIP0DJBrn14831ll2A3jF63hdLi8rg69nfwSUOIwesmZSo?=
 =?us-ascii?Q?Uqf9I8fwAeXTJE3yEqyKgOtGcYFKZapB2ZlNQ+NI33IW2ucCKICG20IkkZ0p?=
 =?us-ascii?Q?CEjdtPCLcdn68WN6++uYsIuqmAGNoLtZcUReTIfia/Htm1/p3AtTqoMk9BGh?=
 =?us-ascii?Q?zC1dUZHetVNy+rdIzCcbtmH+kSkJ/oDFQ2D+dlotTNK9s9fHr0WnB8dwqG53?=
 =?us-ascii?Q?AVoswMXMWvnTHr8WbNOBjl2hk4GnG8Tw7qyx1HYrdzVaSuWYjOuj8jEaxV2q?=
 =?us-ascii?Q?JOOsYgLwlKmKk6C3FgiWVAvgssbzFyYWTsz1VqdzHCslNgpLyy8YJD0QHFln?=
 =?us-ascii?Q?3FIhbis6uTCYs7xltewTDtgtJIWwuVO36fnNJ8jPVl4i5l2gozEyGhLV5rkh?=
 =?us-ascii?Q?vGeJON0Z6osyEF4vRE9rzKLUkh0S8XKnw5aa39QXL3BjFOJeX86Oh6A5IkMm?=
 =?us-ascii?Q?4xNwii00P7kpikxtfjsmyPt6cznOHfy5iFlhrXn+mG4kVFqNhR7sCRbq4Q4Q?=
 =?us-ascii?Q?yQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cabe16f4-1646-420e-a364-08dc0d703cbf
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2024 21:58:08.7855
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jAtmP9hLGYznXMgZL4qhnwYVmQFtAtz1Dq6PhVToy89qsnfMml3VhAtxe30XkWNSV04sTqeNKqMgaQjZ+sm2AHOTzhKxkkBEsDAboFF9yIw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7408
X-OriginatorOrg: intel.com

Stephen Rothwell wrote:
> Hi Dan,
> 
> On Tue, 2 Jan 2024 02:32:18 +1100 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> >
> > A large number of commits in the cxl-fixes tree are also in Linus
> > Torvalds' tree as different commits (but the same patches).
> > 
> > A bad rebase onto v6.7-rc6 has been done.  I cannot use this tree as
> > it is.
> 
> Can this be fixed up, please?
> 
> $ git rebase --onto v6.7-rc6 251c56533a2c
> 
> should do it

Yes, will do that promptly. I am trying to figure out how this happend.

