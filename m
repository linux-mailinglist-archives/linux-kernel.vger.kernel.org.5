Return-Path: <linux-kernel+bounces-7989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9279F81B036
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 09:21:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFF111C21E3B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 08:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5B4516427;
	Thu, 21 Dec 2023 08:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WQe0PXsG"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DD0316413
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 08:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703146878; x=1734682878;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=fNLe42ZZ80VoadPoMWze7tQxDvEbRkH3dFj/DT19CfQ=;
  b=WQe0PXsGNNlBLiETe7vszytkDRsS7WsXfmRoTm9Igr9hnpCmtJNtUH1C
   hzV+kAZJGFq9RmPov7pWPeuWxOAcVClA1XyxFVywhFvb7nEeLxDQDdQR5
   AJNLdvYghRbh+0heSfJXa3FYmR32ZFZrWJTq1GswxzJwszAEzFK/7+Dg1
   tY4SzcYUTcSZEDqojIUduVtyGR4/nsAwF5OIMcBEQIgmpP8kzFj8LYPkL
   IUSioDTC07m60eWu7KC+6zGKkjufxHu6XMEXnA78TxFXr/bfsHureG/kE
   A3I0/WpNKYKRKe7Ji/slRlW5Ao/wI7rMbh+AEW1IuP8PR2j2+0AMKmAvT
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="2770540"
X-IronPort-AV: E=Sophos;i="6.04,293,1695711600"; 
   d="scan'208";a="2770540"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2023 00:21:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="847037904"
X-IronPort-AV: E=Sophos;i="6.04,293,1695711600"; 
   d="scan'208";a="847037904"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Dec 2023 00:21:17 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 21 Dec 2023 00:21:16 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 21 Dec 2023 00:21:16 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 21 Dec 2023 00:21:16 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 21 Dec 2023 00:21:16 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TV6gZ9wcHgaQlHc01ZEdeqXXV4PJryEXRKVCvJtBOu8Gzxa2O93WLoB1RBW2xXtRZ+xhItvFpMv/d6DGMPVTsyeUw1KVCNYDPP+Qc/okW+Ub1lxUlSZf9mYqhZrdsviqsVXdMUG450BcCZoN/b8kJ1OjNfLYdVbxezWypC0XltKwF9+qB7eEuxDxAamYsKtvXh11XuQsf9x9XVhhY3V4Q9liQK30gMsB1Sh5pX89tf5n4HPWTuUILlmmj7Y+4n9ZsiRy2KDe/iSjVmDxSue0RgR4BoRmVECGtXXmIIBRtHMKy3bCGWNlybJXpxblMo6In2n+1RXI0Djn/D+rb+9j4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fNLe42ZZ80VoadPoMWze7tQxDvEbRkH3dFj/DT19CfQ=;
 b=Mw/WO58nr3bj1imBQVxWOCZEm/EulOlNe88LQ3DhyOxIaZ2ZOTPqsjupz9k1/WC2dsL0DAeIqBMkcGl3utZpKrhyPrH8gmDKv64BPU4JRTas5jOTTW+P1mlUSLG34M0x9W/iJR5qdLPbtLJDmIODrtIKmSk0ElRHYPd49WyG0kpvF2nB8KurDmC2KgBP/XD5moIKFoUxCVybx0NWu/Nu/EAk8aDJucRiGVtq1lrhjcjynDpya4jYIBVwOx3mtHbC9sLjXIh/Tnfs5TRhDWUA/mMhuV3ygu44AeB11Rx6xt5TMlvv+XKcr52mcK18T3z8xH07NR2QG7xthvIHvVSZaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3062.namprd11.prod.outlook.com (2603:10b6:a03:92::18)
 by PH7PR11MB8454.namprd11.prod.outlook.com (2603:10b6:510:30c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.18; Thu, 21 Dec
 2023 08:21:14 +0000
Received: from BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::24b0:a8e6:19bb:30d3]) by BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::24b0:a8e6:19bb:30d3%4]) with mapi id 15.20.7113.016; Thu, 21 Dec 2023
 08:21:14 +0000
Date: Thu, 21 Dec 2023 16:21:05 +0800
From: Aaron Lu <aaron.lu@intel.com>
To: Vincent Guittot <vincent.guittot@linaro.org>
CC: Imran Khan <imran.f.khan@oracle.com>, <mingo@redhat.com>,
	<peterz@infradead.org>, <juri.lelli@redhat.com>, <dietmar.eggemann@arm.com>,
	<rostedt@goodmis.org>, <bsegall@google.com>, <mgorman@suse.de>,
	<bristot@redhat.com>, <vschneid@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] sched: fair: reset task_group.load_avg when there
 are no running tasks.
Message-ID: <20231221082105.GA600162@ziqianlu-desk2>
References: <20231215052652.917741-1-imran.f.khan@oracle.com>
 <CAKfTPtD85OSem=7RMquLWokVp7gffvDaY3mtwevkxp1mSSVVqQ@mail.gmail.com>
 <d8507f86-2458-4b01-a774-5102473e657e@oracle.com>
 <1c13b0cc-098c-4f75-9f37-a53a66965409@oracle.com>
 <CAKfTPtDqqAYNCFb6US-4Yd=-xvj8mhMuO0PkUhWsqekxp__M4g@mail.gmail.com>
 <a9993f8b-6449-4452-a168-db966d9bae49@oracle.com>
 <CAKfTPtD1Q7R0ySc=a_5Aw9M0McQiom80DWEB6FRv7vYoPRVebg@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAKfTPtD1Q7R0ySc=a_5Aw9M0McQiom80DWEB6FRv7vYoPRVebg@mail.gmail.com>
X-ClientProxiedBy: SG2PR02CA0074.apcprd02.prod.outlook.com
 (2603:1096:4:90::14) To BYAPR11MB3062.namprd11.prod.outlook.com
 (2603:10b6:a03:92::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3062:EE_|PH7PR11MB8454:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f3bcfc5-5053-4497-6076-08dc01fdcbc0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s4is8GeTpd+2DG6WGDhoiXZ0HCJGjmoa3dXukr6nXh8CZAW4OZN3rA2IJZnq6bTUV4x/3j6fhDbU07vWfEthNAyferVVZzEbjlJ3KiG1TUsnkrsBPHEF8Gy4pdDCcVRP0VCdMHZDo2BFA3fzm+t7Fa73ZpyGxA21L+iz1t0ATBOclHR5h1pDSsJsUG+YQpRWrIUdCoedUHaNsXDLBqlVjiTg2HY6UxNKdQKTU00EabQYGq2zXxSND03GxRWzLrLgZ/sByhgxP+bV5MX13capJf33BJc6CSHzbXbcdsZVZSJ0AUEGfDCtceJTTzd8JH5K+QFMMIaLxbZEJ4x2yBgsmGOOKUJKxfonbi9g1zZX6SnSEyTFjIaewMHfxnF1rPHrQPk34Di7G9Qr+VgPxddVDNuq6N9IcrwU/16YSM2/pcpgHYhY9IZuPvt6zmIOANG1iQTszsJkOXHNzo6WRBFT4oEaAzNSVau/phB83tXkZKEvSpE/ilNaMxxwbDHaGpgDGoko4/GuxmQAZHRrGX31FeN6ZuHFpkW8jTsqeePgldrQmt2aIwyK8pCdj5Yx1cQT
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3062.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(39860400002)(366004)(396003)(136003)(346002)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(6512007)(9686003)(41300700001)(4326008)(8936002)(44832011)(478600001)(316002)(66946007)(6916009)(66476007)(6666004)(66556008)(6506007)(6486002)(86362001)(5660300002)(7416002)(33656002)(1076003)(83380400001)(8676002)(4744005)(26005)(2906002)(33716001)(38100700002)(82960400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OJEAGBO3ofkWG7Joz1KKQK6IfyF/1eGS4I/tn8pYdEsUswePY2oCeXbYnLmm?=
 =?us-ascii?Q?yf6WeaYF/psFjFV/HpQYCtrQbpuUNYRHNEalI39mku4qWa8qlTs9DdWrUAHP?=
 =?us-ascii?Q?hyM9zPIvzccDCDjjhwI+ZFNCv8xoWoDuhMvZdeL8hLkTXDLFVFjSYxuUhYF1?=
 =?us-ascii?Q?wv/+YXuePkW5heJ828Va4PMx96eJbI2/DCYjAweD0qu6jRY6mCijYhLIvO1x?=
 =?us-ascii?Q?LjVr6mlqdUQj3BaYiwmYTTai7QU+pUY/A0EBqccakH1h4I4n2ZT7/bRRCpHA?=
 =?us-ascii?Q?4CR93+xrvzmBHO2TpbyysfmUFNaJl8UFmV9wCR37LEKyDVo+NpdwnzIsH88p?=
 =?us-ascii?Q?mVO7JbpXonGDO68EMQRFgsvc4LdH17hKEXio1I0ICdmsHkEppPB6ekT5+XEX?=
 =?us-ascii?Q?y5svHop1v/5rH8JSJC7Wel8Rapcox12WsvHziY9Lu4NP0ttH+YLAl2lZEWIJ?=
 =?us-ascii?Q?Hfr80NDAabB8bhCw/JUtiX2WqFsdaJaregRrxWmKjEbrWd56MfnIMWi2nq15?=
 =?us-ascii?Q?0RcHZ+ayCh75LE3TmyCId+bM7nBdRKgl7LByH4Z6igf3wtr3wSt/Hz+lNX+c?=
 =?us-ascii?Q?AsnXpw8Gc3njF2ixVDhHdOFCT0SjlvlIwsyxEFocSjntwjLghpXuDb/ShSmo?=
 =?us-ascii?Q?q/9ldaTSsCroT2XmzZXNJCIGqpvf4HreGxd4bUKhxWBgF6oB/KdPrFSAUbR7?=
 =?us-ascii?Q?8cr3foMdOb0HW/qxPnM9SyBBfWzYW5Mg+CTzsdTd8yXvG0m63VR0EijdZtme?=
 =?us-ascii?Q?opMtxMl/BVLXpZdSAaLB/HkL2eCYY8CwW/7RQVDeN9WTy+X3nraYhmGhJnOR?=
 =?us-ascii?Q?H+R3rC0c3RJm+ymfuGePygDAayxOdD5ZbgRpgvUwHoDuFbgbBydqiZ5qU69O?=
 =?us-ascii?Q?Fpxr6MWkMrxN7h3zgcbBf0/Yw9yHqKxvZFBR8LaYVXhER5O2FYZjwVNmtsKq?=
 =?us-ascii?Q?GAtbtr0tzY0ybVLVuiDK4OwGddWSu81vPrOzL6QMAxYWSv7636ykrgkoLsQs?=
 =?us-ascii?Q?Dsq28t3NpJFk8z4FVBTyh8cnj+EuYVV6Aj4pqbydqidRvxmr8iqIuFkXdbjW?=
 =?us-ascii?Q?H+OY/iBiGWArmrtjbgyqQWBV+CBEsRZiewg76dOngz+zs2/CVie8OAYonQ53?=
 =?us-ascii?Q?8zFKDzaCa1D4X9sSyJ2O0gAWDuXXwpctDABwleTmgeKPrr16+wfYiRviVQJV?=
 =?us-ascii?Q?k3HYc8yuBE/fY/rWDR7IEngQRSw0bmTmfum8OhhHrGema2PdfzTgYlp1pQKj?=
 =?us-ascii?Q?o9+Lns+JsgcGpSBKa62d25ualLJSmMTo1n3fQz/FVE75ZFX5MmfIMan03weY?=
 =?us-ascii?Q?YK25ZOA3Af4sqsEIjFVPVPSKIjevxrC+wisjO2iBEjfHC1WNLA8SIUfbqGYw?=
 =?us-ascii?Q?+YcGL3vdD8HFNAARmWb+Nh6yHfN/sexZ6NB0mWp5JB+7F7Ehblx6kdzj06yV?=
 =?us-ascii?Q?AFw2OH38o9ZJvsZGKgM2Om2xYz7nru5Bx6Ptro8BzXoxk9Tg5UCs6Yae/84+?=
 =?us-ascii?Q?O/UF+6aImhvUuAVKYqxVutOxM7/NNu8PcNptu3Whx/pDuc1EMeT3LM1JEgT+?=
 =?us-ascii?Q?JlYZu048QPigsDBMB2zLubnNloC64lKFBcjX6+0m?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f3bcfc5-5053-4497-6076-08dc01fdcbc0
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3062.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2023 08:21:14.0291
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qjw/T0alcfAqkMIkOfMpovbJ7NBLRGXdS7zDyD0beE3allzvMrIV0HQ3UlVoNvcmrkAOsGyOvReYCPNZVszlJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8454
X-OriginatorOrg: intel.com

Hi Vincent,

Thanks for the heads up.

On Wed, Dec 20, 2023 at 06:31:08PM +0100, Vincent Guittot wrote:
> Aaron,
> Could you run the tests that you run for testing "Ratelimit update to
> tg->load_avg" and check if this patch impacts your performance ?

I run hackbench/netperf/postgres_sysbench with nr_thread=nr_cpu on a 2
sockets/120cores/240cpus Intel server and didn't notice any performance
change after applying your diff so I think it's not a problem.

Regards,
Aaron

