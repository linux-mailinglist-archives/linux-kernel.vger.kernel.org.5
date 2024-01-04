Return-Path: <linux-kernel+bounces-17093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABDDA824829
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 19:29:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 414EF285881
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 18:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6238E28E21;
	Thu,  4 Jan 2024 18:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eadyQGkG"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1777B28E16
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 18:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704392955; x=1735928955;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=eadxHs+rPlhhe7ry/rOwZVUoOOOqIMjdupzaqbHHi4E=;
  b=eadyQGkGsGFA9OrS60MjjgX1utMizvI3MTIjzxV6IyGAHNIPg3FaEmUR
   cP5JYh0zkYzMI/UXv5it2HZqJLxHPdkmz7NqU+IUW1q0rww2A/KwBvSqy
   fO+d9OQK8CEay6NwwYqUvgUgQjfprPfz/sObVcWLTynvVFGDFQaDd0AfG
   qXUBAEpyo2ZMfF0rWEyv6pZ5qThvBuHW8GDlcFmVPXb0LjMKAMb+jIHjU
   veJhKF+/m4GWKRO2e7EFPeAU02byIIhiB3K4SuWW7qBkThOQ8W/REyHNp
   SFKmCPxAzqfw8IBKJuiHXxWFywGY2MwSVmIEBB+hlP9mQG+ItwDaxSCqy
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10943"; a="461632211"
X-IronPort-AV: E=Sophos;i="6.04,331,1695711600"; 
   d="scan'208";a="461632211"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2024 10:29:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,331,1695711600"; 
   d="scan'208";a="14996703"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Jan 2024 10:29:14 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 4 Jan 2024 10:29:13 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 4 Jan 2024 10:29:13 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 4 Jan 2024 10:29:13 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 4 Jan 2024 10:29:13 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lSVMF2dMek7o8vOol8junE2t47qK+2FsHF38VNqFi+ipF7TiRztJ9HFNQ8G7mmTxMkPrc7UkRPplZ++eTLpaSXi430lT8fWX7SyDEuOfRFHx8LO3u122fmlG85G846PVyJsqASntMPaJ7gTD6tR9sOTSqdR29NiEkY++LsiDrQKL9B9p64JA7IZPYRQqUPBZZcU5Mfq73Q/U5oLzmy0vEQUsdU7QBg/YaGAk8g6s+0ibhZe4b6MqOtxrvJ3CSoOGH5loo3pOhgY0mTkdyopOC4Nzvg0cQOmlrQ0NoCVhhNkjn8dDS23fDMn8tzVnrGeZwiOHzOG2MpUNkeP7erM9Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ivfvoMX0U2RHs/CMqqTbNASomV4tUsrXvNob7wtuE0w=;
 b=UIzhpCiHk42yuwfzDOEzCLF99szqlaDx1kOWViyomq1jXOJhZyOoJqF8bPyZXTHrUvp43yAU2wOGWiVxMTvG6ulgEI0lzkvpVY01dNLzU75X5EzD55rE60SyUh0NVWelW9jk9JNN5OEEEHyz5gq1wYhBKeRkgwBu3eoqUj/vi96Z77/vPbsWEmIKj2ftKE7gi4Ev+lsETzW7m6H1f3lVhd5EL+fc2cs070ITQM4M98UautG6vZtIPUplUlwi1226lklhMhdMTcA1JjKg0mWe5lhOzTMcbvodROMNqrP3+gXLbq4LOF/z9KOBH3YE4jJCFLC+O4nEnWxcoGINSTWlhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by MW4PR11MB5773.namprd11.prod.outlook.com (2603:10b6:303:180::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Thu, 4 Jan
 2024 18:29:06 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2%4]) with mapi id 15.20.7159.013; Thu, 4 Jan 2024
 18:29:06 +0000
Date: Thu, 4 Jan 2024 10:29:03 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Lukas Wunner <lukas@wunner.de>, Peter Zijlstra <peterz@infradead.org>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dan Williams
	<dan.j.williams@intel.com>, <linux-coco@lists.linux.dev>, Andrew Morton
	<akpm@linux-foundation.org>, <x86@kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 4/5] mm/slab: Add __free() support for kvfree
Message-ID: <6596f8ef5fafe_8dc682949e@dwillia2-xfh.jf.intel.com.notmuch>
References: <169199898909.1782217.10899362240465838600.stgit@dwillia2-xfh.jf.intel.com>
 <169199901230.1782217.9803098171993981037.stgit@dwillia2-xfh.jf.intel.com>
 <2023081449-blurry-bath-248e@gregkh>
 <20230814161731.GN776869@hirez.programming.kicks-ass.net>
 <20240104065744.GA6055@wunner.de>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240104065744.GA6055@wunner.de>
X-ClientProxiedBy: MW4PR04CA0098.namprd04.prod.outlook.com
 (2603:10b6:303:83::13) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|MW4PR11MB5773:EE_
X-MS-Office365-Filtering-Correlation-Id: d466f859-cf7d-4ba5-4b3c-08dc0d5308d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AuqWN3pKsVLcgYK3gL2U4zw77oe0MGtyP3NriYZ59J+n3iSXpRz07dQbmtgfvdyfNZiiD5rKoFycV+fWRyhyWLwBSLK/Qfhy9pyLAJdqedvYuLE6yFEQRLVUkIdF3qDeTJlP28naH/Mgb0rLXtxz8VWmS5NN5sYYVmDeV00JtwRxsNmDaTMHBhLLf4LQh85s1byER1ZsLDEz7eldfMweGKUpMTT3DEXjbI0esbcmaq4Yh5zZyzhZSTLDyXp8Zk7wGj0eRAO38KX/gqy6Gk0Z4YV0YLHvGbFkf2aXCWKFKRHsC5VmnRP63TxDf1A51KDWYAYP3AmloelGkEdU6xup5NbjQTIIsq0wtUZRN1LUSdVxwl1xHUrlOxcWhQAtAy3UNFq1dPCZPtrqHEJ02yf6ZE3/g0Te7a1RLf95FYxvikmJOhaQw7ZlpBl53N4KkWk+EneHp6OdAwuyUlHd1GoXnxn4nsQdqGX590lVUT00MlSSV8Aef2ML+pc1sc9fGqe2C3yeB3OVrywhokjBF8VgcL6J9NEBtBP4X2DTlrtugekQnGi3T3zrs22Jfm1gpunJ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(376002)(136003)(346002)(39860400002)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(6486002)(9686003)(6506007)(66476007)(66946007)(6666004)(86362001)(6512007)(41300700001)(82960400001)(38100700002)(26005)(83380400001)(2906002)(4326008)(66556008)(5660300002)(478600001)(54906003)(110136005)(8676002)(8936002)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?V+Sa7fZQczkAzlDeiwiyJNryI6EFSuvRvrF1ipWMzda1enRYIu4E5I/sHZY/?=
 =?us-ascii?Q?AaLqyDGMyuFYRsMgooAcctZT7rEnYtmvK+hUcYeMFdHlNIYsDdPjvxvDYFkm?=
 =?us-ascii?Q?EShZjv8xrk/wQSJPxYSvxFyY7oGtj33zW+rEErBlGw9fYRCbJlMdd2FSL0xE?=
 =?us-ascii?Q?BB9xhqJB3E2lFCaXrPPYO13PFv70xxhBTiZ5lNdlmwDri4QGPYJmtou7do53?=
 =?us-ascii?Q?Aus6O2bMwmrfvMW5uJJHANRwcgfeaVZnW94xpYd6QMwpdEmIhctygYH93clz?=
 =?us-ascii?Q?arhWXI6gnTaQfsRR/qrDNZE2pkoeJJukvXaaMY9V0RWa+9a+ejo1T4mXSgz8?=
 =?us-ascii?Q?l8xQgQwRh2FPDN0LarxwPz5dODoFnj7felMFwAHCk2mKgFdWHBy9OI8n6IhM?=
 =?us-ascii?Q?mHGNoGKTsB7T6AB+rizfLem8fkuTWhGjNyzjrehmKXpNIOsrGULnmxuDYHqi?=
 =?us-ascii?Q?W75JsPmHYCU07mahQIdLh0MncHMBSDjgV+k8l3Nxxt3ixeUZa48cB6PkdbhZ?=
 =?us-ascii?Q?MlYCr9+LYwCDTfbg/p8i0jb/LwDzZ9duC03b0w1ZR8N1Jp16rHlKjzEZZD4d?=
 =?us-ascii?Q?ijHaW31SbKa22sQtXjeKo5XTOM2wdNk87h23W7fU9epQ/eEyQ40X3ucFJQSJ?=
 =?us-ascii?Q?4DeaLYxXaRwDpIxEaY9Xsykub4agf8EgrtA9iavyKQLEMJCaJLDy/JpE/vM1?=
 =?us-ascii?Q?ROk6Sy4204OjiYCNNOk7xREJmZ9/V9txZAM2s1V5kJqIUsuYf3TLWqn+il6X?=
 =?us-ascii?Q?EV3HJ6RcFzAp8EKQlQXepbbg3o+yEWJe/HMOKD22l3ird5HXiWVabd4BzbrU?=
 =?us-ascii?Q?dwg8T4r0x2bWwf7id6Fo5XcWk0U5qaDcYW/WO3wU/qdqqLGSV0x7+HW+agK4?=
 =?us-ascii?Q?1/G3A1K0RoB79fXLipBJCH2aFWSc3D/q7L+j8mrMcJKHsYaW+NHADt8DcUrd?=
 =?us-ascii?Q?y4Q24bbh0SF3DfdxktkzKlVttmrrOgwqBBQM+dKeycbd6Nlz9+v18XmueG5S?=
 =?us-ascii?Q?WERcDDLE3L3zRppmU7J9UxEwSDq+T4HzRQOVg3lCMChJL/0YOBrL92Nne2JI?=
 =?us-ascii?Q?WakKlG8Ev/ibb5Q5wMA2G8YL++Ms599Oi1GYoBtwHlHs3Jwtp4yBelrUeErL?=
 =?us-ascii?Q?XFl14KJldWgqmBdJ+fivAJrUOG+FAlQFWofRb3vmjE4Dp7MppvbDPjY9bMYx?=
 =?us-ascii?Q?kB+AOE9AMpr3Ij4UCNGRQIdkAeugBD0bKFoYiHF0dThAFAFxYYdUZtdvxTTE?=
 =?us-ascii?Q?bkwQbx0CrNdjl5DWisWdd+aG8BgIM8+43aOe1ETAO9RodXpcNb7FNZr9dCXp?=
 =?us-ascii?Q?qQr8BGgLW432RYwYnrubPRDneK+3fR2QfUmTbgMN4cJeVsLP/Nq0Q3SDpSOE?=
 =?us-ascii?Q?LdulqY3WaVqV3utHKCCz+EwUwRIecuyeZGn0ScgavSvuni2BnELfDXk4htK4?=
 =?us-ascii?Q?YRQpdXIf11p3fWy0UiiV0CrrguqmnUGR1mlUfJM9y642oWNsqHOhgsxrAh0X?=
 =?us-ascii?Q?JsnacAlerF2CEih5EtBgNogbXW3iiPfJ8wzJZB/N0lS+UIS50UTaeDI3PwLK?=
 =?us-ascii?Q?kqKsyemgOpUgYUSh2Uu8s9ws1uO6k8ypObP4ZO1WEW2TjTzs3qcBO5W2OT8T?=
 =?us-ascii?Q?KQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d466f859-cf7d-4ba5-4b3c-08dc0d5308d4
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2024 18:29:06.2928
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZwKKQ412J5vzNVahjPO28kLQmvXbAktQGnr1ZhswAWV4rO/c/GEWDcKD7+IysDjzrt33WT5K+4TauRjSuJYtBKgfmHkpCLby2Lf5c/zipKU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5773
X-OriginatorOrg: intel.com

Lukas Wunner wrote:
> On Mon, Aug 14, 2023 at 06:17:31PM +0200, Peter Zijlstra wrote:
> > On Mon, Aug 14, 2023 at 05:31:27PM +0200, Greg Kroah-Hartman wrote:
> > > On Mon, Aug 14, 2023 at 12:43:32AM -0700, Dan Williams wrote:
> > > > Allow for the declaration of variables that trigger kvfree() when they
> > > > go out of scope.
> > > > 
> > > > Cc: Andrew Morton <akpm@linux-foundation.org>
> > > > Cc: Peter Zijlstra <peterz@infradead.org>
> > > > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > > > ---
> > > >  include/linux/slab.h |    2 ++
> > > >  1 file changed, 2 insertions(+)
> > > > 
> > > > diff --git a/include/linux/slab.h b/include/linux/slab.h
> > > > index 848c7c82ad5a..241025367943 100644
> > > > --- a/include/linux/slab.h
> > > > +++ b/include/linux/slab.h
> > > > @@ -746,6 +746,8 @@ static inline __alloc_size(1, 2) void *kvcalloc(size_t n, size_t size, gfp_t fla
> > > >  extern void *kvrealloc(const void *p, size_t oldsize, size_t newsize, gfp_t flags)
> > > >  		      __realloc_size(3);
> > > >  extern void kvfree(const void *addr);
> > > > +DEFINE_FREE(kvfree, void *, if (_T) kvfree(_T))
> > > 
> > > No need to check _T before calling this, right (as was also pointed out
> > > earlier).
> > 
> > Well, that does mean you get an unconditional call to kvfree() in the
> > success case. Linus argued against this.
> > 
> > This way the compiler sees:
> > 
> > 	buf = NULL;
> > 	if (buf)
> > 		kvfree(buf);
> > 
> > and goes: 'let me clean that up for you'. And all is well.
> 
> Have you actually verified that assumption in the generated Assembler code?
> 
> The kernel is compiled with -fno-delete-null-pointer-checks since commit
> a3ca86aea507 ("Add '-fno-delete-null-pointer-checks' to gcc CFLAGS").
> 
> So NULL pointer checks are *not* optimized away even if the compiler
> knows that a pointer is NULL.

Interesting, I am not sure how -fno-delete-null-pointer-checks plays
into this, but I can confirm that Peter's expectations are being met in
a routine with:

DEFINE_FREE(pci_dev_put, struct pci_dev *, if (_T) pci_dev_put(_T))

...without that conditional the assembly is:

   0xffffffff819ad129 <+41>:	call   0xffffffff81800840 <pci_get_domain_bus_and_slot>
   0xffffffff819ad12e <+46>:	mov    %rax,%r12
   0xffffffff819ad131 <+49>:	test   %rax,%rax
   0xffffffff819ad134 <+52>:	je     0xffffffff819ad154 <cxl_cper_event_call+84>
   0xffffffff819ad136 <+54>:	mov    %rax,%rdi
   0xffffffff819ad139 <+57>:	call   0xffffffff817f5f10 <pci_dev_lock>
   0xffffffff819ad13e <+62>:	cmpq   $0xffffffff82c681c0,0x80(%r12)
   0xffffffff819ad14a <+74>:	je     0xffffffff819ad160 <cxl_cper_event_call+96>
   0xffffffff819ad14c <+76>:	mov    %r12,%rdi
   0xffffffff819ad14f <+79>:	call   0xffffffff817f5fa0 <pci_dev_unlock>
   0xffffffff819ad154 <+84>:	pop    %rbx
   0xffffffff819ad155 <+85>:	mov    %r12,%rdi
   0xffffffff819ad158 <+88>:	pop    %rbp
   0xffffffff819ad159 <+89>:	pop    %r12
   0xffffffff819ad15b <+91>:	jmp    0xffffffff817fe1e0 <pci_dev_put>

...i.e. the check for NULL at 0xffffffff819ad134 jumps to do an
unnecessary pci_dev_put(). With the conditional in the macro the
sequence is:

   0xffffffff819ad129 <+41>:	call   0xffffffff81800840 <pci_get_domain_bus_and_slot>
   0xffffffff819ad12e <+46>:	test   %rax,%rax
   0xffffffff819ad131 <+49>:	je     0xffffffff819ad18c <cxl_cper_event_call+140>
   0xffffffff819ad133 <+51>:	mov    %rax,%r12
   0xffffffff819ad136 <+54>:	mov    %rax,%rdi
   0xffffffff819ad139 <+57>:	call   0xffffffff817f5f10 <pci_dev_lock>
   0xffffffff819ad13e <+62>:	cmpq   $0xffffffff82c681c0,0x80(%r12)
   0xffffffff819ad14a <+74>:	je     0xffffffff819ad160 <cxl_cper_event_call+96>
   0xffffffff819ad14c <+76>:	mov    %r12,%rdi
   0xffffffff819ad14f <+79>:	call   0xffffffff817f5fa0 <pci_dev_unlock>
   ...
   0xffffffff819ad18c <+140>:	pop    %rbx
   0xffffffff819ad18d <+141>:	pop    %rbp
   0xffffffff819ad18e <+142>:	pop    %r12
   0xffffffff819ad190 <+144>:	jmp    0xffffffff81efc6a0 <__x86_return_thunk>

...i.e. optimize away the pci_dev_put() and return directly when @pdev
is already known to be NULL. So empirically
-fno-delete-null-pointer-checks still allows for redundant NULL checks
to be optimized.

