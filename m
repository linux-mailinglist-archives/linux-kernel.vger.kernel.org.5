Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FCB57D0601
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 03:06:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346786AbjJTBCU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 21:02:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233033AbjJTBCT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 21:02:19 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76A6F115;
        Thu, 19 Oct 2023 18:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697763737; x=1729299737;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=bNpSSDXa3EwDxQPBSMGa12YTqc7iFFFXJzqV5gFGHRM=;
  b=WPhYa8slNKgn3ENMHr85+5/qeBuc38Q/ltG/8SuePKcHHiXHJO6NETk/
   TOsAf+w5KF4zhgjp1izWVAV0pyxf/BLa1+QyIntNYDXtiZvfYpCjQpsNX
   i/+67q/bGng9fD0FEsly9xfGWYzm0/4qNeWwKSyHdwjAiqBRTHjk6mkpV
   JSeRAq4Y4f6PNUGZeAHg5EyKCGkU91D2SBPMjJpg6D7jcA6EHKvI43d6j
   B3uEDGA6GkC9BK8rAdPgOqLLGIcdjW2GC96UWpBBQiiz/10oUkHzKAZKe
   fc3mGuW4l36C+u8XvZ5hSh0HSsxrv8Zdsz58qWE3RQR2BMivt2RUkrQUO
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="450632906"
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="450632906"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2023 18:02:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="1088569693"
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="1088569693"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Oct 2023 18:02:16 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 19 Oct 2023 18:02:16 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 19 Oct 2023 18:02:15 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 19 Oct 2023 18:02:15 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 19 Oct 2023 18:02:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KaQx9MW6wUxoSv0vTK/VvgplgGMDTwz2Gh1T1csIxELZ9ylAcHSz8GgHfJX5CWB13ruWj25Iw4xOi48ZjRcXwHs3NtMSFamc5VQfuD6+6iz0cjofrstmEfzHosOkGU3nGH5ZY5VN7ivlVgGa1L1Yn9BPGf1yFqvtsbhIPE2ojpevdEUjUYfKv9Mp+1VV9kRHmAeCAgKmAsOqyamQmYtBQ9OrAxmnWhQH+GhvEIlKNSvjXMll/iRyTiI0/CPsGN0lRW/TVhW7BtyAAVOdZ5jf0QvhfZHiE/NKa5vu6XtJXqUSYFeK53om739zFdXTsxLEChanXWaBR8zxFUpNY0E5vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mb5YNoK/txITsvfP+h/AIcesm3VXCfEFOTgC7Z13WOs=;
 b=XnXPlrKaBca89FZfoRw05iqSS3K3N0bjomMjKQY1i9U9VHO5wK2h3H/wnY/llALDESizJZvW/g6cTRUL3zmtWO0PtPy97STYDvgB7xg2hTT353+uzSUvPtdEXWW51ofBI+NyJH4C0WioRkzL13KiIm4Q6bIrCJ/rXkM9LFcMDSRSSTqivGsqtwByZJFNngUSG/5PQ3NSXvitq1MRYOzUKvTLrc73vBieUXRenElQKfKA5j1iEnbDmB2cbIDNRs8StcP7DLIf2WG+IwjRRwR8yjGx3s6WhB7TmWnzyjsQmAgGKKHP+Y3n2Y78UXY9B+NrqNUCW6NEwWhke+joxBmVsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DM4PR11MB6263.namprd11.prod.outlook.com (2603:10b6:8:a6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.21; Fri, 20 Oct
 2023 01:02:09 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::7978:1ba5:6ed0:717d]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::7978:1ba5:6ed0:717d%4]) with mapi id 15.20.6886.034; Fri, 20 Oct 2023
 01:02:09 +0000
Date:   Thu, 19 Oct 2023 18:02:06 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     "Wilczynski, Michal" <michal.wilczynski@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        <nvdimm@lists.linux.dev>, <linux-acpi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>
Subject: Re: [PATCH v1 1/1] ACPI: NFIT: Switch to use
 acpi_evaluate_dsm_typed()
Message-ID: <6531d18eb13c4_7258329435@dwillia2-xfh.jf.intel.com.notmuch>
References: <20231002135458.2603293-1-andriy.shevchenko@linux.intel.com>
 <ec5029b0-553c-4a6c-b2a9-ef9943e553dc@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ec5029b0-553c-4a6c-b2a9-ef9943e553dc@intel.com>
X-ClientProxiedBy: MW4PR03CA0226.namprd03.prod.outlook.com
 (2603:10b6:303:b9::21) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DM4PR11MB6263:EE_
X-MS-Office365-Filtering-Correlation-Id: 75f29c64-1d6f-4676-6113-08dbd1082f5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QBUcYi2dPf2bdcA5KIQuvrAyykihYPxaFdBhe8Xn6dUFYbu/pFHQcvRTRU2gjxptZDRPrtPcLQS7Rb1uIuCanIA5Sjhn3lpRHMM4DsfL6iF05H0Jf6EPXLr5k5juMNWmz/StmJNxirXo+W7iBP9wZxEiEaWr2OyBGYzcW6Mb/BBKpnkT6Sqnf3XMrn/FEvJsF6cFPZdxDrXjR+uLqU5HkbftFTE8I6cBhAgHNI2qNtVr1xj+UYGNwegt6nGLkrn1NbdVUwXk6/M+BQUofMsVtQzCEV3tELjZptlKSUleFunL5eB62BDFGG6QQWpo1C0Y7KRJ7CenquQWhvDefsWYWJ0Xzd08TKcrk4XiaRHNEFro8LnMKyfDMu+JUQOOXjXRs17i+voDfrQIlBCWw2NdXMsFzlSc+S+zWPFYqA6HN5zx++Vp3oIQFkT4vuybzurfFZ4SYnzL89jXUEcb+Oc7ruuIisrjsSED1hxcGu8iEigYMG0eNTCfGzTaV/S94TCh1cFrnziPko8lbuZmGva3WgBSjF4gKoYK0h9qe8NehvojVFITqcF7uM4tArfHq035
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(136003)(346002)(396003)(39860400002)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(4326008)(26005)(316002)(66946007)(66476007)(8936002)(54906003)(110136005)(6666004)(9686003)(53546011)(66556008)(41300700001)(38100700002)(6512007)(2906002)(6506007)(82960400001)(83380400001)(8676002)(478600001)(86362001)(5660300002)(6486002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Xn4mfQGSA6anxwzX0usu33onnMDYA8R/ClGh3rWb/2vebZQsaEDic5g6R6ny?=
 =?us-ascii?Q?Rvqvx8uCxbfCXRSf+WrXUb7HgTcYPQw4RoUCRbOtBRb2BLgYPB6cLwW9PMG6?=
 =?us-ascii?Q?5dIohQ8BFexrT0FPQ07iZ/ncYkmkkbWCBqOSKGej3uXhI+0Oz5TtG7VysSyg?=
 =?us-ascii?Q?EXgqnrkMhM1LZ74NwSisDXXyfVmCHQ2YEtNXIkj/fXJo7MgVFyuMJRwjnU+9?=
 =?us-ascii?Q?Q4JktaSwXDlcR0/R8o1r0m24FT3TjRnOZUAuHedRTIQtd1WhNNPWn8p/iBrA?=
 =?us-ascii?Q?+Efh9Vz50bHmN/p5L5RwHRYzoLZkoygKHCmI/VNfAPvydW3PgBhNk1N0A/PA?=
 =?us-ascii?Q?Bq4aNCmK/dAtXBC1ILyi6T5SskgxeGw/BxJETxF1q6vkaU228XdM8xVG3E7r?=
 =?us-ascii?Q?OJDVtRRjHDyTXyQ3iHv/AF1dGBtxFh4t4mlg3WoZMyzVZMWgopUiB0dJMS4p?=
 =?us-ascii?Q?X77E5sv2n+JKk4JNgF7aZEA/rK90B5IG3Sv9l5BFn28n5Ij8blNKvC0bQzkU?=
 =?us-ascii?Q?mAGrLkfxNx7tDYcc29V0vnP+ILpjYqXSOqFGSqGg8aGxfzHxVwpnzbQV+Rcq?=
 =?us-ascii?Q?Qmiu88JKOB7OOzbQ3XEycJUEfAkTCOu4khr99CrMgoTntaGDhKVa/xCcSQaS?=
 =?us-ascii?Q?TdPImOohOrLmayGR0V9VM3Lo0SGZhp6RnT8BlSGI3EO8ilE72aDNsENbpWXx?=
 =?us-ascii?Q?hyiHUioeq5Z0UlZuR3sqnfzOLLyHMg4csskRBwoZODaXULiCWRTBAgF1iu6Q?=
 =?us-ascii?Q?MAKIQxH3c3KdF2Xi4LQNE3SktkCQPH7ZgEsGgw7Q7DDW2Hjh4hqJsl3hnUCL?=
 =?us-ascii?Q?f7HmznbovcDtS7eG/f0Qzm32IbBZBcqMV+yiqhc06c2gYv5/BDy8ehH/PpqV?=
 =?us-ascii?Q?Azdt3VV7qyPjrFasYcxemW5MKC1pdmr4qg74hKf5GDcxP33PhJaCJvDlEuO+?=
 =?us-ascii?Q?ygksvtD+jgIby0C2+AL723955QiA2oZ8C+SlFX1aK7HUZ/CUtz7rWxFKVQM4?=
 =?us-ascii?Q?ePHdifCsFoFb4k/YGuW2bCIqcCJ8m7X3hJ301Bp4ZGOE5Qd0slq88a7lZs6R?=
 =?us-ascii?Q?kW+WbSniBt3J9zR1nh3JpLGd2E9YcB0NG2+UCsdwsyfH7ByxqiEBMFqb/shf?=
 =?us-ascii?Q?HVx4McL3gRV/49cXlIho4QD4fz7TndGPm/MyLQm7Ph4MeqTye0N+rtQ11Azk?=
 =?us-ascii?Q?YGscGsk8fzXp26j54z/z/jH+vN/Kwql8NSzeR/tx55YZtg+88hdqzArzWgj9?=
 =?us-ascii?Q?4fDqDJQbfXdD6V1tjuejeQeNMjMY+3EL2k7GB3Ae52QuVDawa2D3etGxfQJR?=
 =?us-ascii?Q?ivDSwzK7u7HdjS1BeRoeU1Kj/rDpRvPuFKTRjCxQDs57iTmf2h2DfPXjsTsL?=
 =?us-ascii?Q?SwJS//WZzes2GSBP47h2cwU2JAEBwq3KMiQYvUZlH5h05Nmt1WyfpUi4UFdZ?=
 =?us-ascii?Q?I/EFYO6JchOZ455K6VzzUw8mdjl3u4na/jD/UUtdR270kG5Gl9RYBdzT9RFI?=
 =?us-ascii?Q?JV+Ju5lNBAWRa/1SUCpcQWYo69oVS5zfLgbbOcHo6woYNv5NBrWJFyxCC6tz?=
 =?us-ascii?Q?74Rhd2sTCKOwoiUgEKLVDqETFADvriL1U296c/Q7KQjkIwnwQl1/qwKx9Ok9?=
 =?us-ascii?Q?dg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 75f29c64-1d6f-4676-6113-08dbd1082f5b
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2023 01:02:08.9753
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m2Nxs8+yMVWABzHfVAy0Z66eCGmiEsx+HdQGt3o9TdTb1OL/RW9SeqvPxz04Z9ihItJpCSdBUgsDMsRZ58td4k3o01Djgdw3Jn55VxOova0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6263
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wilczynski, Michal wrote:
> 
> 
> On 10/2/2023 3:54 PM, Andy Shevchenko wrote:
> > The acpi_evaluate_dsm_typed() provides a way to check the type of the
> > object evaluated by _DSM call. Use it instead of open coded variant.
> >
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > ---
> >  drivers/acpi/nfit/core.c | 5 ++---
> >  1 file changed, 2 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
> > index f96bf32cd368..280da408c02c 100644
> > --- a/drivers/acpi/nfit/core.c
> > +++ b/drivers/acpi/nfit/core.c
> > @@ -1737,9 +1737,8 @@ __weak void nfit_intel_shutdown_status(struct nfit_mem *nfit_mem)
> >  	if ((nfit_mem->dsm_mask & (1 << func)) == 0)
> >  		return;
> >  
> > -	out_obj = acpi_evaluate_dsm(handle, guid, revid, func, &in_obj);
> > -	if (!out_obj || out_obj->type != ACPI_TYPE_BUFFER
> > -			|| out_obj->buffer.length < sizeof(smart)) {
> > +	out_obj = acpi_evaluate_dsm_typed(handle, guid, revid, func, &in_obj, ACPI_TYPE_BUFFER);
> 
> This line is 90 characters long, wouldn't it be better to split it ?

100 characters is allowed these days.

> > +	if (!out_obj || out_obj->buffer.length < sizeof(smart)) {
> >  		dev_dbg(dev->parent, "%s: failed to retrieve initial health\n",
> >  				dev_name(dev));
> 
> While at it maybe fix alignment ? :-)

Life is too short to fiddle with indentation. For old code leave it
alone, for new code just use clang-format.
