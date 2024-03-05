Return-Path: <linux-kernel+bounces-91545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C8ED87137D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 03:18:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 931AE1C22082
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 02:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73B081865B;
	Tue,  5 Mar 2024 02:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JO9a6l11"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67F261864C
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 02:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709605081; cv=fail; b=Gi9B0BMISO11mFEnLFcKWWeS5pVnoqrUuGhJrzhD7d4q/5QciQz7BqtwFodMNmf3x0JgEDKrKkAZIu4/UCoRI1K/sLnTzDaqLeTyVPltZ16Kkr0vcztVp/yC6XfEtbBMbBmSPTPFA145mP0nSPA8AH2tTD9WZdDMw3ynCdzg9RE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709605081; c=relaxed/simple;
	bh=ElNTWcjEZ77nGDD1TTWmKnEY6eBKsJP0THqT6S6BXN4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XblqEYf9/WBsfxeA/0BvW3PBxlNtweuxh5KtuGPKG/lTSRQ38W9L29kJZrst/KfXfgxEzbhF9LXBZeDyUiXEMKr5R6PvUPC6XlJ+hwm8gZ//5h6D8abtMY+Ze8qx2YcQUiTkbats+fepHdALpEF2m7/kee/M4ewbcVB+qWrQ1JM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JO9a6l11; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709605078; x=1741141078;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=ElNTWcjEZ77nGDD1TTWmKnEY6eBKsJP0THqT6S6BXN4=;
  b=JO9a6l11oVc7iToDZA0H+KFsxmSVJ+C1oxVGPcCYWcgJOCPwglCH/8Zd
   zRGQrCDa9Y7cn4GzmlKuQ0cLy9s5HWDlnkGNa4pQ6U25IVgtnS+XFbCd3
   f+B6VUBI4q00Qka2V707kw2hOKJV5yAf2Afsl+BGty1UTFg1vbrwcK+Ss
   iAgpR2qQRwgMzST4hZXxrb7DH+QGbc3t/r7jfTJK9FdKEOtQ6VAMgG6NP
   XLPRj5bHeNKRcblsAZM5MVF6ly+DxdRvhM3bQmHxB15ZGB+QV3A2Ze+zC
   XKO9mvawT9tzoREM1td/l45piwSVSUpsi6ZovFN0w6QrfD6KahQnszzHc
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11003"; a="3992741"
X-IronPort-AV: E=Sophos;i="6.06,205,1705392000"; 
   d="scan'208";a="3992741"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 18:17:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,205,1705392000"; 
   d="scan'208";a="40192778"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Mar 2024 18:17:57 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 4 Mar 2024 18:17:56 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 4 Mar 2024 18:17:56 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 4 Mar 2024 18:17:56 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 4 Mar 2024 18:17:55 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TSoBL1Yj73JowGe2W72vaqGf6mo3xr5+KPiY2IeENSJ1sUGbiX1eOjDbCxURaJHEmRoO0pQzfAjbhEY9X4v+Nqv6SSIhj7clOQuNWWXDnt2kyV+wnx/NEX0oVzIYhlXrm9Hou7gVMF0G57ehfJN9Ncx1wC4AVIlpUMfX10NsltNkrwXV9CCd45b2p2v54Kgy40/w3UOx8paLyVK9c16HeCIyfCKTGR3PCRzcXhbKYxCvTIFxNSMYwxSxHuYmMSTYg+YTRd7n6kBbq9FVlXCND3ai9EU00pxvFu84d0oaQxZGfmZjt5kah6IM4MXIy9yAxpUse+3Es5aVPVz+rYBUnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q+glstqNdPS/XDqlbddx6OrddKjaPMBwQPvqJbI1r70=;
 b=dA5YMm750pDcVCMGWDtbBF3djehy2BTVKttDGZWFoFZUrLyjTVmU8mFjxRXiwx53AqC69jGkRl/R7vEaW+XmDhIsWvROBz46MFA+IhxGWg/zafxm7uH30uhQcbAzeGLYfRA3eeSvUxBpma537Znk3uNF0/IZ1DUNvxLYj8GpTMyoJZlud3tT4jjCTZSo0+jdk+9Surf0gdDfkPW4Z5JORSnWt8QYLAf2uHZMgm+9p1dMXdegLkzALbmQIXXqNzNKfNhbC5EYX52wst7J47b9r+2112Fp8gkqEjzKEf3HeMU+HwQ+Uws8W3aH//5m5SC5PbANiCw2kATUhj8EjJgmTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by DS0PR11MB7192.namprd11.prod.outlook.com (2603:10b6:8:13a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.22; Tue, 5 Mar
 2024 02:17:52 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::58dd:99ca:74a6:2e3e]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::58dd:99ca:74a6:2e3e%3]) with mapi id 15.20.7362.019; Tue, 5 Mar 2024
 02:17:52 +0000
Date: Tue, 5 Mar 2024 10:17:43 +0800
From: Oliver Sang <oliver.sang@intel.com>
To: Frederic Weisbecker <frederic@kernel.org>
CC: Anna-Maria Behnsen <anna-maria@linutronix.de>, <oe-lkp@lists.linux.dev>,
	<lkp@intel.com>, <linux-kernel@vger.kernel.org>, <x86@kernel.org>, "Thomas
 Gleixner" <tglx@linutronix.de>, <ying.huang@intel.com>,
	<feng.tang@intel.com>, <fengwei.yin@intel.com>
Subject: Re: [tip:timers/core] [timers]  7ee9887703:  netperf.Throughput_Mbps
 -1.2% regression
Message-ID: <ZeaAx662HfbpMLdg@xsang-OptiPlex-9020>
References: <202403011511.24defbbd-oliver.sang@intel.com>
 <ZeUWreWcp4UWQ081@pavilion.home>
 <ZeUuLPXfLCmB39qq@xsang-OptiPlex-9020>
 <ZeWwYUY56IG0yzzQ@localhost.localdomain>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZeWwYUY56IG0yzzQ@localhost.localdomain>
X-ClientProxiedBy: SGBP274CA0018.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::30)
 To LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|DS0PR11MB7192:EE_
X-MS-Office365-Filtering-Correlation-Id: 57f99e1b-0901-4e33-bc30-08dc3cba75f9
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ufMfGVCe6GmP7jEINRGva9CJx0+gLYyFqs+KVoBYOBUywdjGP0px6ZH1HuJv27ebWEC4hPLyoOMQkHFNAIch/uPI7uEFuEBpk0C3q011JiQ+5AF9hiKI/skQ1YFhIAsgbzI4dPf17YfABlbBCBI4LiSgTOoTFRxVs8rZ+qNyu2Akwr3ymYVUc02whQSo1EuQkBN2k9sueIJbT21m2HLEMUu4tzr2JquCERONeIoC+7MODwi4/8NNNpV0GqgWhEpu2oqOTsbk0yfOkRxNl09rGsITdc8bssX5Q2I+2paU5Up3+aF2ZkM8bRoql5YobrBeBFVNQqg2cPJ+gsmJWM2qBavtrRW+I9eWc4rJqhSOKT5S155nj0aSY3/UrhYnmrI4Qkr3XXKTfQi3xCesiUcak0LMUg662xjEqAHA5GKK0PU4tpDVC/HN54+flwL/epmtMNi1JsPrb8igEk9d2Sod7ISFrmRINtNpENnXqHgHZG4MjNL+WJ6hc/2v77Ojh1VejQwuVA7RCzVYcmPiORRHxlYXKDTsuzZVnl/Y51dDjLIxO4zk9sKgpfpjYI42UA0f2k0ph/T0zear7MpcU/QvhgNgiEHgUyouorNBwd4/k/OVyajp3i706w7yTumubCfu
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?bAiZLQVtJRbTmEgHO+CHT7vrbSn/HtLRlaPZcDtfGsXOKjx76Ei/qoJobf?=
 =?iso-8859-1?Q?0r1xUM2OtmXGKk0jPfry32880Ta/R4/3BLrAeFEzP8oWyAK5tURjSzXmZ8?=
 =?iso-8859-1?Q?BNS8Eia6nKvtIYqmhT3rGXUqPHDMtjBCU5ERFPyJRuSTqQ1wnpdLbSBBaB?=
 =?iso-8859-1?Q?+toXegkrnVBcTWhNd9ew/OPNpWIkKfTLvUYwt9XFDeRMXY7O6JOdlcXS/F?=
 =?iso-8859-1?Q?ZFO027KKoK9lSz+sshDDmlTVvxUo+aW0n/kLqdw3c0xhTHyWopIHs7laeo?=
 =?iso-8859-1?Q?g/QE2feAqi31vPt6YMlxboDAt3woNfkgf7P4Tftg4DcHrD2Pe5FVfSDP4y?=
 =?iso-8859-1?Q?vI7ctpktMjc8SaZF3Tmp2HfP/7OjCzOJ/Ronvgb5qIBmnEqdFyT2IcPmmg?=
 =?iso-8859-1?Q?opPY5nu8f7ZBR1Tx7JPJSMvYVU/yqWNWeU98puvna/54NbLbk8yXf3cDD8?=
 =?iso-8859-1?Q?ONMcj2Tn2Cxrq/QutRo8XZuIlj78L/kHwi7Wj0LNOnubQcrAuVz1erqL2I?=
 =?iso-8859-1?Q?HQGJZQ2dI6WBJ5FnsHLJQO4SKfuLafm/V04DBRGXZqhEJCZQpRjq5sCy8Q?=
 =?iso-8859-1?Q?2pNaYtRW4kTbmOfhfozwvqWnpt4B1H/YdwDGSqjcpeZleMP6XmhbYuaatS?=
 =?iso-8859-1?Q?qvFwUupWIoSwBRZtg3asERrY9eKl383Qq8rqEhlT7HkJIisfLlSESoUuBH?=
 =?iso-8859-1?Q?3YkftPx5DpFiodBshewg48iSEnY2xE3D+ZRlHyiJUGoqhzIgKFVNalLhax?=
 =?iso-8859-1?Q?BJpRpRY93yV0t6JfbfeIw1WLmmsXbdbk4Xj760Y1sEB6gZ6SF3pkLRJz42?=
 =?iso-8859-1?Q?kxhg4Wo/Nv4Tlpw4nK/gyGZoOIPdhaqBO8MUaCReI3V/CH3003+Fd4Z0rL?=
 =?iso-8859-1?Q?7H9MIXT5ORRymSCVgzVguteNLoNLxIBYoCmpmMgYv7/zWnw8f6gs+SEGgU?=
 =?iso-8859-1?Q?8/bYrIKTULy5fhsfoL4yLNguDFCudjWEa98QdOOdGatr+S7DViM42Q+60A?=
 =?iso-8859-1?Q?SAmnta/E2VsMnzIk6ak55tg4lqA0Lp368r0L8avduW+ZOYRZUmcrOUbbwj?=
 =?iso-8859-1?Q?jeBvcvxDJYJNHQ9LAKM9V7Lt1ZbbdnFL0GZCcN+KpkOmFxkUTnZ5lZEBuT?=
 =?iso-8859-1?Q?0/QkM4ePf8k4zX4ED07AJtKUUqRQOOrxXHst1jET1g1mB3CwjQMA7j/lhk?=
 =?iso-8859-1?Q?XBhMsgaA6O760RVDy1hgbHVqCIyCcuRFsnpinl/YKINC5Jv+0kbcq/4Hld?=
 =?iso-8859-1?Q?bSLfl4Mb/vMNly1HCB+X/0DAd0XBFAj+bM8IjGCwn10b/HrB0uUzQY4WIa?=
 =?iso-8859-1?Q?q2I4ba4KcC080qM5GIODMbIn6O4XemwWhai/6TcMUO7YOuXyqbqOnwlO2O?=
 =?iso-8859-1?Q?MRGu7iLXB1juzGv6malXcgfTsUEBDagw8HAb4SGiliXbfY/jgYzm2+ju26?=
 =?iso-8859-1?Q?EtW9tU3oKfmfiaO6WFL+3v+fRNRoOGlk3sd7PPY5XO1g245wAGVOZbAPwu?=
 =?iso-8859-1?Q?vqtoG78oZqD0kGcZP8OeASg2RDYPNrazZTc3imQSe8JznkkeCUbnZDfuBr?=
 =?iso-8859-1?Q?h0JSuTNfT8atfxoSWis4ocNywi18NSx5z4okHdTYVLJURYj3Jc+VH8gcQs?=
 =?iso-8859-1?Q?uAdYe9E/vZKihBSapV/p3/OhLr8mvvnE5o12hP1qf8+ARuPimd3XBx4Q?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 57f99e1b-0901-4e33-bc30-08dc3cba75f9
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2024 02:17:52.6539
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lnKhJBiUoax7g6JkLqctpXrS6cRQTEpItpfCC9HrPahol8+QVkdClzDAowG9IKnOyYXZWs9vAoIvfARYq/06OA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7192
X-OriginatorOrg: intel.com

hi, Frederic Weisbecker,

On Mon, Mar 04, 2024 at 12:28:33PM +0100, Frederic Weisbecker wrote:
> Le Mon, Mar 04, 2024 at 10:13:00AM +0800, Oliver Sang a écrit :
> > On Mon, Mar 04, 2024 at 01:32:45AM +0100, Frederic Weisbecker wrote:
> > > Le Fri, Mar 01, 2024 at 04:09:24PM +0800, kernel test robot a écrit :
> > > > commit: 
> > > >   57e95a5c41 ("timers: Introduce function to check timer base is_idle flag")
> > > >   7ee9887703 ("timers: Implement the hierarchical pull model")
> > > 
> > > Is this something that is observed also with the commits that follow in this
> > > branch?
> > 
> > when this bisect done, we also tested the tip of timers/core branch at that time
> > 8b3843ae3634b vdso/datapage: Quick fix - use asm/page-def.h for ARM64
> > 
> > the regression still exists on it:
> > 
> > 57e95a5c4117dc6a 7ee988770326fca440472200c3e 8b3843ae3634b472530fb69c386
> > ---------------- --------------------------- ---------------------------
> >          %stddev     %change         %stddev     %change         %stddev
> >              \          |                \          |                \
> >       4.10            -1.2%       4.05            -1.2%       4.05        netperf.ThroughputBoth_Mbps
> >       1049            -1.2%       1037            -1.2%       1036        netperf.ThroughputBoth_total_Mbps
> >       4.10            -1.2%       4.05            -1.2%       4.05        netperf.Throughput_Mbps
> >       1049            -1.2%       1037            -1.2%       1036        netperf.Throughput_total_Mbps
> 
> Oh, I see... :-/
> 
> > > Ie: would it be possible to compare instead:
> > > 
> > >     57e95a5c4117 (timers: Introduce function to check timer base is_idle flag)
> > > VS
> > >     b2cf7507e186 (timers: Always queue timers on the local CPU)
> > > 
> > > Because the improvements introduced by 7ee9887703 are mostly relevant after
> > > b2cf7507e186.
> > 
> > got it. will test.
> > 
> > at the same time, we noticed current tip of timers/core is
> > a184d9835a0a6 (tip/timers/core) tick/sched: Fix build failure for
> > CONFIG_NO_HZ_COMMON=n
> 
> Shouldn't be a problem as it fixes an issue introduced after:
> 
> 	  b2cf7507e186 (timers: Always queue timers on the local CPU)
> 
> > 
> > though it seems irelevant, we will still get data for it.
> 
> Thanks a lot, this will be very helpful. Especially with all the perf diff
> details like in the initial email report.

the regression still exists on b2cf7507e186 and current tip of the branch:

=========================================================================================
cluster/compiler/cpufreq_governor/ip/kconfig/nr_threads/rootfs/runtime/tbox_group/test/testcase:
  cs-localhost/gcc-12/performance/ipv4/x86_64-rhel-8.3/200%/debian-12-x86_64-20240206.cgz/300s/lkp-icl-2sp2/SCTP_STREAM/netperf

commit:
  57e95a5c4117 (timers: Introduce function to check timer base is_idle flag)
  b2cf7507e186 (timers: Always queue timers on the local CPU)
  a184d9835a0a (tick/sched: Fix build failure for CONFIG_NO_HZ_COMMON=n)
  
  a184d9835a0a689261ea6a4a8dbc18173a031b77

57e95a5c4117dc6a b2cf7507e18649a30512515ec0c a184d9835a0a689261ea6a4a8db
---------------- --------------------------- ---------------------------
         %stddev     %change         %stddev     %change         %stddev
             \          |                \          |                \
      4.10            -1.4%       4.04            -1.5%       4.04        netperf.ThroughputBoth_Mbps
      1049            -1.4%       1034            -1.5%       1033        netperf.ThroughputBoth_total_Mbps
      4.10            -1.4%       4.04            -1.5%       4.04        netperf.Throughput_Mbps
      1049            -1.4%       1034            -1.5%       1033        netperf.Throughput_total_Mbps

details are in below [1]

> Because I'm having some troubles
> running those lkp tests. How is it working BTW? I've seen it downloading
> two kernel trees but I haven't noticed a kernel build.

you need build 7ee9887703 and its parent kernel with config in
https://download.01.org/0day-ci/archive/20240301/202403011511.24defbbd-oliver.sang@intel.com
then boot into kernel.

after that, you could run netperf in each kernel by following
https://download.01.org/0day-ci/archive/20240301/202403011511.24defbbd-oliver.sang@intel.com/reproduce
to get data.

the results will store in different path according the kernel commit, then you
could compare the results from both kernels.

what's your OS BTW? we cannot support all distributions so far...

> Are the two compared
> instances running through kvm?

we run performance tests on bare mental. for netperf, we just test on one
machine so the test is really upon local net.

> 
> Thanks.
> 
> > 
> > > 
> > > Thanks.
> 

[1]

=========================================================================================
cluster/compiler/cpufreq_governor/ip/kconfig/nr_threads/rootfs/runtime/tbox_group/test/testcase:
  cs-localhost/gcc-12/performance/ipv4/x86_64-rhel-8.3/200%/debian-12-x86_64-20240206.cgz/300s/lkp-icl-2sp2/SCTP_STREAM/netperf

commit:
  57e95a5c4117 (timers: Introduce function to check timer base is_idle flag)
  b2cf7507e186 (timers: Always queue timers on the local CPU)
  a184d9835a0a (tick/sched: Fix build failure for CONFIG_NO_HZ_COMMON=n)
  
  a184d9835a0a689261ea6a4a8dbc18173a031b77

57e95a5c4117dc6a b2cf7507e18649a30512515ec0c a184d9835a0a689261ea6a4a8db
---------------- --------------------------- ---------------------------
         %stddev     %change         %stddev     %change         %stddev
             \          |                \          |                \
   1364607           +11.8%    1525991           +10.3%    1504946        cpuidle..usage
     45.86 ±  4%      +8.4%      49.70 ±  5%      +3.5%      47.46 ±  6%  boot-time.boot
      5430 ±  5%      +9.0%       5921 ±  5%      +3.8%       5636 ±  6%  boot-time.idle
      0.03            +0.0        0.04            +0.0        0.04        mpstat.cpu.all.soft%
      0.04            +0.0        0.08            +0.0        0.08 ±  2%  mpstat.cpu.all.sys%
      4.14            -8.9%       3.77 ±  2%      -8.3%       3.79 ±  2%  mpstat.max_utilization_pct
     20726 ± 63%    +246.1%      71744 ± 53%     +68.2%      34867 ± 72%  numa-numastat.node0.other_node
   1431327 ±  7%     +13.9%    1630876 ±  3%     +14.8%    1643375 ±  7%  numa-numastat.node1.numa_hit
     37532 ± 35%     +62.1%      60841 ± 63%    +160.8%      97891 ± 25%  numa-numastat.node1.other_node
    201.33 ±  3%     -28.5%     144.00 ±  8%     -26.8%     147.40 ± 11%  perf-c2c.DRAM.remote
    187.83 ±  3%     -21.4%     147.67 ±  6%     -37.0%     118.40 ± 11%  perf-c2c.HITM.local
     40.67 ±  7%     -54.5%      18.50 ± 19%     -59.7%      16.40 ± 11%  perf-c2c.HITM.remote
      1.36 ±  4%     +10.7%       1.51 ±  3%     +12.7%       1.53 ±  5%  vmstat.procs.r
      5654            -1.9%       5549            -2.8%       5497        vmstat.system.cs
      5232           +10.7%       5790            +8.8%       5690        vmstat.system.in
     15247 ±  6%      -5.0%      14490 ±  9%      -8.8%      13903 ±  5%  numa-meminfo.node0.PageTables
     12499 ±  6%    +115.6%      26951 ±  3%    +118.3%      27288 ±  2%  numa-meminfo.node1.Active
     12489 ±  6%    +115.7%      26940 ±  3%    +118.2%      27249 ±  2%  numa-meminfo.node1.Active(anon)
     12488 ±  6%    +114.2%      26754 ±  3%    +118.2%      27255 ±  2%  numa-meminfo.node1.Shmem
    102.17 ±  8%    +906.2%       1028 ±  5%    +910.1%       1032 ±  5%  time.involuntary_context_switches
      2.07 ±  3%    +388.3%      10.12          +391.0%      10.17 ±  2%  time.system_time
      8.02           -74.1%       2.08 ±  3%     -74.1%       2.08 ±  3%  time.user_time
    186981            -1.2%     184713            -1.4%     184450        time.voluntary_context_switches
     16672 ±  2%     +86.5%      31090           +87.5%      31255 ±  2%  meminfo.Active
     16611 ±  2%     +86.8%      31026           +87.8%      31191 ±  2%  meminfo.Active(anon)
    183431 ± 28%     +10.7%     203091 ± 25%     +36.3%     249972        meminfo.AnonHugePages
     29722           +10.5%      32854           +11.0%      32990        meminfo.Mapped
     19919           +72.9%      34441           +73.8%      34613        meminfo.Shmem
      4.10            -1.4%       4.04            -1.5%       4.04        netperf.ThroughputBoth_Mbps
      1049            -1.4%       1034            -1.5%       1033        netperf.ThroughputBoth_total_Mbps
      4.10            -1.4%       4.04            -1.5%       4.04        netperf.Throughput_Mbps
      1049            -1.4%       1034            -1.5%       1033        netperf.Throughput_total_Mbps
    102.17 ±  8%    +906.2%       1028 ±  5%    +910.1%       1032 ±  5%  netperf.time.involuntary_context_switches
      2.07 ±  3%    +388.3%      10.12          +391.0%      10.17 ±  2%  netperf.time.system_time
    186981            -1.2%     184713            -1.4%     184450        netperf.time.voluntary_context_switches
      3820 ±  6%      -5.1%       3624 ±  9%      -8.9%       3481 ±  5%  numa-vmstat.node0.nr_page_table_pages
     20726 ± 63%    +246.1%      71744 ± 53%     +68.2%      34867 ± 72%  numa-vmstat.node0.numa_other
      3103 ±  6%    +116.4%       6718 ±  3%    +118.7%       6786 ±  2%  numa-vmstat.node1.nr_active_anon
      3103 ±  6%    +115.0%       6672 ±  3%    +118.7%       6788 ±  2%  numa-vmstat.node1.nr_shmem
      3103 ±  6%    +116.4%       6718 ±  3%    +118.7%       6786 ±  2%  numa-vmstat.node1.nr_zone_active_anon
   1429007 ±  7%     +14.0%    1628956 ±  3%     +14.8%    1640988 ±  7%  numa-vmstat.node1.numa_hit
     37530 ± 35%     +62.1%      60838 ± 63%    +160.8%      97889 ± 25%  numa-vmstat.node1.numa_other
    256.26 ± 33%     +65.6%     424.24 ± 16%     +96.5%     503.61 ± 17%  sched_debug.cfs_rq:/.avg_vruntime.min
    256.26 ± 33%     +65.6%     424.24 ± 16%     +96.5%     503.61 ± 17%  sched_debug.cfs_rq:/.min_vruntime.min
    965754            -9.5%     874314            -9.7%     872201        sched_debug.cpu.avg_idle.avg
    101797 ± 12%     +41.8%     144325 ±  5%     +45.3%     147947        sched_debug.cpu.avg_idle.stddev
    129.98 ±  6%      -4.0%     124.77 ±  8%      -8.9%     118.35 ±  7%  sched_debug.cpu.curr->pid.avg
      0.00 ± 22%     -43.6%       0.00 ±  5%     -37.0%       0.00 ± 11%  sched_debug.cpu.next_balance.stddev
      0.03 ±  6%      -8.6%       0.03 ±  7%     -14.7%       0.03 ± 10%  sched_debug.cpu.nr_running.avg
     39842 ± 27%     -32.4%      26922 ± 11%     -30.4%      27714 ±  9%  sched_debug.cpu.nr_switches.max
    886.06 ± 18%    +347.6%       3965 ±  4%    +366.2%       4130 ±  4%  sched_debug.cpu.nr_switches.min
      5474 ± 12%     -32.0%       3724 ±  8%     -32.9%       3672 ±  3%  sched_debug.cpu.nr_switches.stddev
      4178 ±  2%     +86.3%       7784           +87.3%       7826 ±  2%  proc-vmstat.nr_active_anon
      7649           +10.3%       8436           +10.7%       8469        proc-vmstat.nr_mapped
      4984           +72.9%       8620           +73.8%       8663        proc-vmstat.nr_shmem
     28495            +1.7%      28987            +1.8%      29014        proc-vmstat.nr_slab_reclaimable
    100999            +4.5%     105530            +4.6%     105612        proc-vmstat.nr_slab_unreclaimable
      4178 ±  2%     +86.3%       7784           +87.3%       7826 ±  2%  proc-vmstat.nr_zone_active_anon
   3064698            +4.4%    3200938            +4.2%    3193539        proc-vmstat.numa_hit
   3006439            +2.1%    3068397            +1.8%    3060785        proc-vmstat.numa_local
     58258          +127.6%     132587          +127.9%     132758        proc-vmstat.numa_other
      8114 ±  2%     +63.2%      13244 ±  4%     +62.6%      13190 ±  2%  proc-vmstat.pgactivate
    986600            +1.2%     998606            +0.9%     995307        proc-vmstat.pgfault
     20.00         +1905.0%     401.00 ± 79%   +2050.0%     430.00 ± 79%  proc-vmstat.unevictable_pgs_culled
     15.14           +17.0%      17.72           +17.4%      17.77        perf-stat.i.MPKI
 1.702e+08            +3.5%  1.762e+08            +3.3%  1.758e+08        perf-stat.i.branch-instructions
      1.68            +0.1        1.80            +0.1        1.81        perf-stat.i.branch-miss-rate%
   7174339            +1.2%    7262760            +1.4%    7276699        perf-stat.i.branch-misses
     18.46            +3.4       21.86            +3.4       21.87        perf-stat.i.cache-miss-rate%
   4047319           +20.6%    4880009           +20.4%    4874638        perf-stat.i.cache-misses
  22007366            +2.6%   22586331            +2.5%   22565036        perf-stat.i.cache-references
      5620            -1.6%       5532            -2.5%       5482        perf-stat.i.context-switches
      1.84           +17.0%       2.15           +16.5%       2.14        perf-stat.i.cpi
 9.159e+08           +12.8%  1.033e+09           +12.4%   1.03e+09        perf-stat.i.cpu-cycles
    161.08          +193.1%     472.19 ±  2%    +192.1%     470.47 ±  4%  perf-stat.i.cpu-migrations
 8.434e+08            +3.1%  8.692e+08            +2.9%  8.677e+08        perf-stat.i.instructions
      0.61            -8.5%       0.56            -8.2%       0.56        perf-stat.i.ipc
      4.79           +17.0%       5.60           +17.2%       5.61        perf-stat.overall.MPKI
      4.21            -0.1        4.12            -0.1        4.14        perf-stat.overall.branch-miss-rate%
     18.39            +3.2       21.60            +3.2       21.59        perf-stat.overall.cache-miss-rate%
      1.09            +9.4%       1.19            +9.3%       1.19        perf-stat.overall.cpi
    227.07            -6.6%     212.18            -6.7%     211.77        perf-stat.overall.cycles-between-cache-misses
      0.92            -8.6%       0.84            -8.5%       0.84        perf-stat.overall.ipc
   1379820            +4.4%    1440927            +4.4%    1440267        perf-stat.overall.path-length
 1.702e+08            +3.4%   1.76e+08            +3.1%  1.755e+08        perf-stat.ps.branch-instructions
   7172548            +1.2%    7256062            +1.3%    7264905        perf-stat.ps.branch-misses
   4035389           +20.5%    4864355           +20.4%    4858306        perf-stat.ps.cache-misses
  21948285            +2.6%   22521305            +2.5%   22497443        perf-stat.ps.cache-references
      5603            -1.6%       5514            -2.5%       5463        perf-stat.ps.context-switches
 9.163e+08           +12.6%  1.032e+09           +12.3%  1.029e+09        perf-stat.ps.cpu-cycles
    160.61          +193.0%     470.58 ±  2%    +191.9%     468.79 ±  4%  perf-stat.ps.cpu-migrations
 8.433e+08            +3.0%  8.685e+08            +2.7%  8.665e+08        perf-stat.ps.instructions
 2.551e+11            +3.3%  2.636e+11            +3.1%  2.631e+11        perf-stat.total.instructions
     31.82 ±  3%     -13.0       18.83 ± 12%     -13.2       18.65 ±  6%  perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.acpi_safe_halt.acpi_idle_enter.cpuidle_enter_state.cpuidle_enter
     36.90 ±  2%     -12.6       24.32 ± 10%     -12.3       24.62 ±  5%  perf-profile.calltrace.cycles-pp.acpi_idle_enter.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
     27.61 ±  3%     -12.5       15.09 ± 14%     -12.4       15.24 ±  5%  perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.acpi_safe_halt.acpi_idle_enter.cpuidle_enter_state
     31.75 ±  2%     -12.0       19.79 ± 12%     -11.6       20.11 ±  5%  perf-profile.calltrace.cycles-pp.acpi_safe_halt.acpi_idle_enter.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call
     24.39 ±  3%     -10.7       13.65 ± 15%     -10.4       13.94 ±  5%  perf-profile.calltrace.cycles-pp.irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.acpi_safe_halt.acpi_idle_enter
     24.33 ±  3%     -10.7       13.60 ± 15%     -10.4       13.92 ±  5%  perf-profile.calltrace.cycles-pp.__do_softirq.irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.acpi_safe_halt
     21.00 ±  3%      -9.8       11.23 ± 16%      -9.6       11.40 ±  4%  perf-profile.calltrace.cycles-pp.net_rx_action.__do_softirq.irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
     20.97 ±  3%      -9.7       11.23 ± 16%      -9.6       11.40 ±  4%  perf-profile.calltrace.cycles-pp.__napi_poll.net_rx_action.__do_softirq.irq_exit_rcu.sysvec_apic_timer_interrupt
     20.97 ±  3%      -9.7       11.23 ± 16%      -9.6       11.39 ±  4%  perf-profile.calltrace.cycles-pp.process_backlog.__napi_poll.net_rx_action.__do_softirq.irq_exit_rcu
      4.92 ± 10%      -4.3        0.64 ± 17%      -4.2        0.71 ± 10%  perf-profile.calltrace.cycles-pp._nohz_idle_balance.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     24.46 ±  3%      -3.2       21.26 ±  9%      -2.6       21.84 ±  6%  perf-profile.calltrace.cycles-pp.sctp_rcv.ip_protocol_deliver_rcu.ip_local_deliver_finish.__netif_receive_skb_one_core.process_backlog
     24.91 ±  3%      -3.2       21.73 ±  8%      -2.6       22.28 ±  6%  perf-profile.calltrace.cycles-pp.__netif_receive_skb_one_core.process_backlog.__napi_poll.net_rx_action.__do_softirq
     24.57 ±  3%      -3.2       21.42 ±  8%      -2.6       21.93 ±  6%  perf-profile.calltrace.cycles-pp.ip_local_deliver_finish.__netif_receive_skb_one_core.process_backlog.__napi_poll.net_rx_action
     24.55 ±  3%      -3.1       21.41 ±  8%      -2.6       21.91 ±  6%  perf-profile.calltrace.cycles-pp.ip_protocol_deliver_rcu.ip_local_deliver_finish.__netif_receive_skb_one_core.process_backlog.__napi_poll
     21.78 ±  3%      -2.7       19.06 ±  8%      -2.4       19.42 ±  7%  perf-profile.calltrace.cycles-pp.sctp_cmd_interpreter.sctp_do_sm.sctp_assoc_bh_rcv.sctp_rcv.ip_protocol_deliver_rcu
     22.48 ±  3%      -2.6       19.90 ±  9%      -2.2       20.33 ±  8%  perf-profile.calltrace.cycles-pp.sctp_assoc_bh_rcv.sctp_rcv.ip_protocol_deliver_rcu.ip_local_deliver_finish.__netif_receive_skb_one_core
     21.92 ±  3%      -2.6       19.35 ±  8%      -2.1       19.85 ±  8%  perf-profile.calltrace.cycles-pp.sctp_do_sm.sctp_assoc_bh_rcv.sctp_rcv.ip_protocol_deliver_rcu.ip_local_deliver_finish
      9.76 ±  7%      -2.3        7.48 ±  9%      -2.1        7.71 ±  7%  perf-profile.calltrace.cycles-pp.sctp_outq_flush.sctp_cmd_interpreter.sctp_do_sm.sctp_assoc_bh_rcv.sctp_rcv
      5.08 ±  7%      -1.7        3.36 ±  9%      -1.7        3.39 ±  9%  perf-profile.calltrace.cycles-pp.sctp_outq_flush_data.sctp_outq_flush.sctp_cmd_interpreter.sctp_do_sm.sctp_assoc_bh_rcv
     10.73 ±  3%      -1.6        9.09 ±  7%      -1.2        9.56 ±  6%  perf-profile.calltrace.cycles-pp._copy_from_iter.sctp_user_addto_chunk.sctp_datamsg_from_user.sctp_sendmsg_to_asoc.sctp_sendmsg
     10.86 ±  3%      -1.6        9.29 ±  7%      -1.1        9.71 ±  6%  perf-profile.calltrace.cycles-pp.sctp_user_addto_chunk.sctp_datamsg_from_user.sctp_sendmsg_to_asoc.sctp_sendmsg.____sys_sendmsg
     12.22 ±  3%      -1.2       11.01 ±  6%      -0.7       11.55 ± 10%  perf-profile.calltrace.cycles-pp.sctp_datamsg_from_user.sctp_sendmsg_to_asoc.sctp_sendmsg.____sys_sendmsg.___sys_sendmsg
      3.42 ±  9%      -0.7        2.75 ±  7%      -0.5        2.94 ± 10%  perf-profile.calltrace.cycles-pp.sctp_packet_transmit.sctp_packet_transmit_chunk.sctp_outq_flush_data.sctp_outq_flush.sctp_cmd_interpreter
      3.09 ± 10%      -0.7        2.43 ±  7%      -0.5        2.61 ±  9%  perf-profile.calltrace.cycles-pp.sctp_packet_pack.sctp_packet_transmit.sctp_packet_transmit_chunk.sctp_outq_flush_data.sctp_outq_flush
      3.05 ± 11%      -0.7        2.39 ±  7%      -0.5        2.57 ± 10%  perf-profile.calltrace.cycles-pp.__memcpy.sctp_packet_pack.sctp_packet_transmit.sctp_packet_transmit_chunk.sctp_outq_flush_data
      3.44 ±  9%      -0.7        2.79 ±  8%      -0.4        3.00 ±  9%  perf-profile.calltrace.cycles-pp.sctp_packet_transmit_chunk.sctp_outq_flush_data.sctp_outq_flush.sctp_cmd_interpreter.sctp_do_sm
      1.05 ±  9%      -0.6        0.41 ± 72%      -0.5        0.59 ±  9%  perf-profile.calltrace.cycles-pp.sctp_cmd_interpreter.sctp_do_sm.sctp_generate_timeout_event.call_timer_fn.__run_timers
      1.58 ±  5%      -0.5        1.04 ± 33%      -0.6        0.97 ± 27%  perf-profile.calltrace.cycles-pp.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.acpi_safe_halt
      1.66 ±  7%      -0.5        1.12 ± 34%      -0.6        1.01 ± 28%  perf-profile.calltrace.cycles-pp.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.acpi_safe_halt.acpi_idle_enter
      0.71 ± 11%      -0.5        0.20 ±144%      -0.3        0.37 ± 82%  perf-profile.calltrace.cycles-pp.setlocale
      0.95 ± 14%      -0.5        0.50 ± 76%      -0.6        0.38 ± 84%  perf-profile.calltrace.cycles-pp.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      2.49 ±  7%      -0.4        2.10 ± 14%      -0.4        2.08 ±  9%  perf-profile.calltrace.cycles-pp.__memcpy.skb_copy_bits.skb_copy.sctp_make_reassembled_event.sctp_ulpq_partial_delivery
      2.49 ±  7%      -0.4        2.10 ± 14%      -0.4        2.12 ±  9%  perf-profile.calltrace.cycles-pp.skb_copy_bits.skb_copy.sctp_make_reassembled_event.sctp_ulpq_partial_delivery.sctp_cmd_interpreter
      0.90 ± 14%      -0.4        0.52 ± 45%      -0.5        0.37 ± 86%  perf-profile.calltrace.cycles-pp.__schedule.schedule.smpboot_thread_fn.kthread.ret_from_fork
      2.40 ±  8%      -0.4        2.04 ± 11%      -0.4        2.04 ±  9%  perf-profile.calltrace.cycles-pp.sctp_outq_sack.sctp_cmd_interpreter.sctp_do_sm.sctp_assoc_bh_rcv.sctp_rcv
      1.62 ±  4%      -0.3        1.28 ± 16%      -0.3        1.35 ± 12%  perf-profile.calltrace.cycles-pp.read
      1.70 ± 11%      -0.3        1.36 ± 16%      -0.4        1.29 ± 13%  perf-profile.calltrace.cycles-pp.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      1.53 ±  4%      -0.3        1.19 ± 15%      -0.3        1.27 ± 10%  perf-profile.calltrace.cycles-pp.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
      2.81 ±  5%      -0.3        2.48 ± 13%      -0.3        2.49 ± 11%  perf-profile.calltrace.cycles-pp.sctp_make_reassembled_event.sctp_ulpq_partial_delivery.sctp_cmd_interpreter.sctp_do_sm.sctp_assoc_bh_rcv
      1.53 ±  4%      -0.3        1.20 ± 16%      -0.3        1.27 ± 10%  perf-profile.calltrace.cycles-pp.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
      2.74 ±  6%      -0.3        2.42 ± 13%      -0.3        2.43 ± 10%  perf-profile.calltrace.cycles-pp.skb_copy.sctp_make_reassembled_event.sctp_ulpq_partial_delivery.sctp_cmd_interpreter.sctp_do_sm
      1.57 ±  5%      -0.3        1.24 ± 16%      -0.3        1.30 ± 11%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
      1.57 ±  5%      -0.3        1.25 ± 16%      -0.3        1.30 ± 11%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.read
      0.90 ± 14%      -0.3        0.62 ±  9%      -0.5        0.37 ± 86%  perf-profile.calltrace.cycles-pp.schedule.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      1.76 ±  8%      -0.3        1.47 ±  8%      -0.3        1.50 ±  6%  perf-profile.calltrace.cycles-pp.do_execveat_common.__x64_sys_execve.do_syscall_64.entry_SYSCALL_64_after_hwframe.execve
      1.77 ±  7%      -0.3        1.48 ±  9%      -0.3        1.50 ±  6%  perf-profile.calltrace.cycles-pp.__x64_sys_execve.do_syscall_64.entry_SYSCALL_64_after_hwframe.execve
      1.77 ±  7%      -0.3        1.48 ±  9%      -0.3        1.50 ±  6%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.execve
      1.77 ±  7%      -0.3        1.48 ±  9%      -0.3        1.50 ±  6%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.execve
      1.77 ±  7%      -0.3        1.48 ±  9%      -0.3        1.51 ±  6%  perf-profile.calltrace.cycles-pp.execve
      1.07 ± 14%      -0.3        0.80 ± 20%      -0.2        0.83 ± 14%  perf-profile.calltrace.cycles-pp.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      0.96 ±  8%      -0.2        0.71 ± 18%      -0.2        0.79 ± 17%  perf-profile.calltrace.cycles-pp.__x64_sys_exit_group.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.96 ±  8%      -0.2        0.71 ± 18%      -0.2        0.79 ± 17%  perf-profile.calltrace.cycles-pp.do_group_exit.__x64_sys_exit_group.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.96 ±  8%      -0.2        0.71 ± 18%      -0.2        0.79 ± 17%  perf-profile.calltrace.cycles-pp.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.03 ± 11%      -0.2        0.79 ±  8%      -0.2        0.81 ±  5%  perf-profile.calltrace.cycles-pp.load_elf_binary.search_binary_handler.exec_binprm.bprm_execve.do_execveat_common
      1.06 ±  9%      -0.2        0.83 ±  6%      -0.2        0.83 ±  6%  perf-profile.calltrace.cycles-pp.search_binary_handler.exec_binprm.bprm_execve.do_execveat_common.__x64_sys_execve
      1.06 ±  9%      -0.2        0.83 ±  6%      -0.2        0.84 ±  5%  perf-profile.calltrace.cycles-pp.exec_binprm.bprm_execve.do_execveat_common.__x64_sys_execve.do_syscall_64
      1.24 ±  9%      -0.2        1.00 ± 10%      -0.1        1.16 ± 15%  perf-profile.calltrace.cycles-pp.read_counters.process_interval.dispatch_events.cmd_stat.run_builtin
      1.12 ±  9%      -0.2        0.89 ± 13%      -0.2        0.87 ± 11%  perf-profile.calltrace.cycles-pp.sched_ttwu_pending.__flush_smp_call_function_queue.__sysvec_call_function_single.sysvec_call_function_single.asm_sysvec_call_function_single
      1.38 ±  6%      -0.2        1.16 ± 12%      -0.2        1.14 ± 10%  perf-profile.calltrace.cycles-pp.__sysvec_call_function_single.sysvec_call_function_single.asm_sysvec_call_function_single.acpi_safe_halt.acpi_idle_enter
      1.31 ±  7%      -0.2        1.09 ± 14%      -0.2        1.09 ±  9%  perf-profile.calltrace.cycles-pp.__flush_smp_call_function_queue.__sysvec_call_function_single.sysvec_call_function_single.asm_sysvec_call_function_single.acpi_safe_halt
      1.14 ± 10%      -0.2        0.95 ±  5%      -0.2        0.95 ±  3%  perf-profile.calltrace.cycles-pp.bprm_execve.do_execveat_common.__x64_sys_execve.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.25 ±  9%      -0.1        1.10 ±  7%      -0.3        0.95 ±  4%  perf-profile.calltrace.cycles-pp.tick_nohz_idle_stop_tick.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
      1.23 ±  8%      -0.1        1.09 ±  7%      -0.3        0.94 ±  4%  perf-profile.calltrace.cycles-pp.tick_nohz_stop_tick.tick_nohz_idle_stop_tick.cpuidle_idle_call.do_idle.cpu_startup_entry
      0.85 ±  8%      -0.1        0.75 ± 14%      -0.1        0.74 ± 14%  perf-profile.calltrace.cycles-pp.ttwu_do_activate.sched_ttwu_pending.__flush_smp_call_function_queue.__sysvec_call_function_single.sysvec_call_function_single
      0.85 ± 17%      +0.2        1.02 ± 10%      +0.3        1.18 ± 14%  perf-profile.calltrace.cycles-pp.kfree_skb_reason.sctp_recvmsg.inet_recvmsg.sock_recvmsg.____sys_recvmsg
      1.04 ±  5%      +0.2        1.28 ±  7%      +0.1        1.15 ± 10%  perf-profile.calltrace.cycles-pp.__alloc_skb._sctp_make_chunk.sctp_make_datafrag_empty.sctp_datamsg_from_user.sctp_sendmsg_to_asoc
      1.16 ±  5%      +0.3        1.42 ±  7%      +0.4        1.57 ± 39%  perf-profile.calltrace.cycles-pp._sctp_make_chunk.sctp_make_datafrag_empty.sctp_datamsg_from_user.sctp_sendmsg_to_asoc.sctp_sendmsg
      0.92 ±  8%      +0.3        1.19 ±  7%      +0.1        1.05 ± 10%  perf-profile.calltrace.cycles-pp.__kmalloc_large_node.__kmalloc_node_track_caller.kmalloc_reserve.__alloc_skb._sctp_make_chunk
      0.92 ±  7%      +0.3        1.20 ±  7%      +0.1        1.06 ± 10%  perf-profile.calltrace.cycles-pp.__kmalloc_node_track_caller.kmalloc_reserve.__alloc_skb._sctp_make_chunk.sctp_make_datafrag_empty
      0.93 ±  7%      +0.3        1.22 ±  8%      +0.1        1.08 ± 10%  perf-profile.calltrace.cycles-pp.kmalloc_reserve.__alloc_skb._sctp_make_chunk.sctp_make_datafrag_empty.sctp_datamsg_from_user
      1.21 ±  7%      +0.3        1.52 ±  7%      +0.4        1.65 ± 36%  perf-profile.calltrace.cycles-pp.sctp_make_datafrag_empty.sctp_datamsg_from_user.sctp_sendmsg_to_asoc.sctp_sendmsg.____sys_sendmsg
      0.84 ± 13%      +0.3        1.17 ±  2%      +0.5        1.38 ±  7%  perf-profile.calltrace.cycles-pp.sctp_wait_for_sndbuf.sctp_sendmsg_to_asoc.sctp_sendmsg.____sys_sendmsg.___sys_sendmsg
      1.14 ± 21%      +0.4        1.50 ± 19%      +0.4        1.55 ± 10%  perf-profile.calltrace.cycles-pp.sctp_chunk_put.sctp_ulpevent_free.sctp_recvmsg.inet_recvmsg.sock_recvmsg
      0.45 ± 72%      +0.4        0.82 ± 12%      +0.5        0.97 ± 11%  perf-profile.calltrace.cycles-pp.skb_release_data.kfree_skb_reason.sctp_recvmsg.inet_recvmsg.sock_recvmsg
      0.00            +0.4        0.42 ± 71%      +0.6        0.60 ±  7%  perf-profile.calltrace.cycles-pp.sctp_do_sm.sctp_generate_timeout_event.call_timer_fn.__run_timers.timer_expire_remote
      0.82 ± 45%      +0.4        1.26 ± 22%      +0.5        1.31 ± 10%  perf-profile.calltrace.cycles-pp.consume_skb.sctp_chunk_put.sctp_ulpevent_free.sctp_recvmsg.inet_recvmsg
      0.75 ± 46%      +0.4        1.18 ± 22%      +0.5        1.22 ± 11%  perf-profile.calltrace.cycles-pp.skb_release_data.consume_skb.sctp_chunk_put.sctp_ulpevent_free.sctp_recvmsg
      0.09 ±223%      +0.5        0.55 ± 62%      +0.7        0.74 ± 30%  perf-profile.calltrace.cycles-pp.update_sg_lb_stats.update_sd_lb_stats.find_busiest_group.load_balance.rebalance_domains
      0.50 ± 45%      +0.5        0.98 ± 33%      +0.6        1.07 ± 25%  perf-profile.calltrace.cycles-pp.rebalance_domains._nohz_idle_balance.__do_softirq.irq_exit_rcu.sysvec_call_function_single
      0.30 ±101%      +0.6        0.86 ± 25%      +0.6        0.93 ± 19%  perf-profile.calltrace.cycles-pp.__free_pages_ok.skb_release_data.consume_skb.sctp_chunk_put.sctp_ulpevent_free
      2.88 ±  8%      +0.6        3.45 ± 16%      +0.7        3.60 ± 12%  perf-profile.calltrace.cycles-pp.sysvec_call_function_single.asm_sysvec_call_function_single.acpi_safe_halt.acpi_idle_enter.cpuidle_enter_state
      0.08 ±223%      +0.6        0.67 ±  6%      +0.7        0.81 ± 21%  perf-profile.calltrace.cycles-pp.schedule.schedule_timeout.sctp_wait_for_sndbuf.sctp_sendmsg_to_asoc.sctp_sendmsg
      0.00            +0.6        0.62 ± 12%      +0.4        0.35 ± 82%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.rmqueue.get_page_from_freelist.__alloc_pages.__kmalloc_large_node
      1.08 ± 12%      +0.6        1.70 ± 21%      +0.8        1.91 ± 15%  perf-profile.calltrace.cycles-pp.irq_exit_rcu.sysvec_call_function_single.asm_sysvec_call_function_single.acpi_safe_halt.acpi_idle_enter
      1.08 ± 12%      +0.6        1.70 ± 21%      +0.8        1.89 ± 15%  perf-profile.calltrace.cycles-pp._nohz_idle_balance.__do_softirq.irq_exit_rcu.sysvec_call_function_single.asm_sysvec_call_function_single
      0.00            +0.6        0.63 ± 60%      +0.8        0.84 ± 26%  perf-profile.calltrace.cycles-pp.update_sd_lb_stats.find_busiest_group.load_balance.rebalance_domains._nohz_idle_balance
      1.08 ± 12%      +0.6        1.70 ± 21%      +0.8        1.91 ± 15%  perf-profile.calltrace.cycles-pp.__do_softirq.irq_exit_rcu.sysvec_call_function_single.asm_sysvec_call_function_single.acpi_safe_halt
      0.00            +0.6        0.64 ± 16%      +0.7        0.67 ±  4%  perf-profile.calltrace.cycles-pp.sctp_generate_timeout_event.call_timer_fn.__run_timers.timer_expire_remote.tmigr_handle_remote_cpu
      0.00            +0.6        0.64 ±  8%      +0.8        0.78 ± 20%  perf-profile.calltrace.cycles-pp.__schedule.schedule.schedule_timeout.sctp_wait_for_sndbuf.sctp_sendmsg_to_asoc
      0.00            +0.6        0.64 ± 61%      +0.9        0.86 ± 26%  perf-profile.calltrace.cycles-pp.find_busiest_group.load_balance.rebalance_domains._nohz_idle_balance.__do_softirq
      3.03 ±  7%      +0.6        3.67 ± 16%      +0.7        3.70 ±  8%  perf-profile.calltrace.cycles-pp.sctp_outq_flush.sctp_cmd_interpreter.sctp_do_sm.sctp_primitive_SEND.sctp_sendmsg_to_asoc
      2.81 ±  7%      +0.6        3.45 ± 17%      +0.6        3.43 ±  9%  perf-profile.calltrace.cycles-pp.sctp_packet_transmit.sctp_outq_flush.sctp_cmd_interpreter.sctp_do_sm.sctp_primitive_SEND
      2.71 ±  8%      +0.7        3.36 ± 16%      +0.6        3.34 ±  6%  perf-profile.calltrace.cycles-pp.sctp_do_sm.sctp_primitive_SEND.sctp_sendmsg_to_asoc.sctp_sendmsg.____sys_sendmsg
      3.12 ±  7%      +0.7        3.77 ± 16%      +0.7        3.85 ±  7%  perf-profile.calltrace.cycles-pp.sctp_primitive_SEND.sctp_sendmsg_to_asoc.sctp_sendmsg.____sys_sendmsg.___sys_sendmsg
      0.00            +0.7        0.66 ± 12%      +0.6        0.57 ± 53%  perf-profile.calltrace.cycles-pp.__free_pages_ok.skb_release_data.consume_skb.sctp_chunk_put.sctp_datamsg_put
      2.79 ±  7%      +0.7        3.47 ± 16%      +0.7        3.48 ±  6%  perf-profile.calltrace.cycles-pp.sctp_cmd_interpreter.sctp_do_sm.sctp_primitive_SEND.sctp_sendmsg_to_asoc.sctp_sendmsg
      0.00            +0.7        0.70 ±  6%      +0.8        0.83 ± 18%  perf-profile.calltrace.cycles-pp.schedule_timeout.sctp_wait_for_sndbuf.sctp_sendmsg_to_asoc.sctp_sendmsg.____sys_sendmsg
      0.00            +0.7        0.71 ± 17%      +0.7        0.73 ±  6%  perf-profile.calltrace.cycles-pp.call_timer_fn.__run_timers.timer_expire_remote.tmigr_handle_remote_cpu.tmigr_handle_remote_up
      0.18 ±141%      +0.7        0.90 ± 37%      +0.8        0.98 ± 25%  perf-profile.calltrace.cycles-pp.load_balance.rebalance_domains._nohz_idle_balance.__do_softirq.irq_exit_rcu
      3.45 ± 14%      +0.7        4.18 ±  8%      +1.1        4.55 ± 10%  perf-profile.calltrace.cycles-pp.__memcpy.skb_copy_bits.skb_copy.sctp_make_reassembled_event.sctp_ulpq_tail_data
      0.00            +0.7        0.74 ± 18%      +0.8        0.76 ±  8%  perf-profile.calltrace.cycles-pp.__run_timers.timer_expire_remote.tmigr_handle_remote_cpu.tmigr_handle_remote_up.tmigr_handle_remote
      3.46 ± 14%      +0.7        4.21 ±  8%      +1.1        4.56 ± 10%  perf-profile.calltrace.cycles-pp.skb_copy_bits.skb_copy.sctp_make_reassembled_event.sctp_ulpq_tail_data.sctp_cmd_interpreter
      0.00            +0.8        0.75 ± 18%      +0.8        0.77 ±  8%  perf-profile.calltrace.cycles-pp.timer_expire_remote.tmigr_handle_remote_cpu.tmigr_handle_remote_up.tmigr_handle_remote.__do_softirq
      0.77 ±  6%      +0.8        1.53 ± 46%      +0.1        0.91 ±  9%  perf-profile.calltrace.cycles-pp.get_page_from_freelist.__alloc_pages.__kmalloc_large_node.__kmalloc_node_track_caller.kmalloc_reserve
      0.80 ±  8%      +0.8        1.57 ± 44%      +0.2        0.96 ±  8%  perf-profile.calltrace.cycles-pp.__alloc_pages.__kmalloc_large_node.__kmalloc_node_track_caller.kmalloc_reserve.__alloc_skb
      4.44 ± 14%      +0.8        5.24 ±  8%      +1.1        5.54 ±  9%  perf-profile.calltrace.cycles-pp.sctp_make_reassembled_event.sctp_ulpq_tail_data.sctp_cmd_interpreter.sctp_do_sm.sctp_assoc_bh_rcv
      4.33 ± 14%      +0.8        5.14 ±  8%      +1.1        5.46 ±  9%  perf-profile.calltrace.cycles-pp.skb_copy.sctp_make_reassembled_event.sctp_ulpq_tail_data.sctp_cmd_interpreter.sctp_do_sm
      0.00            +0.8        0.82 ± 10%      +0.8        0.79 ± 19%  perf-profile.calltrace.cycles-pp.skb_release_data.consume_skb.sctp_chunk_put.sctp_datamsg_put.sctp_chunk_free
      2.34 ± 10%      +1.0        3.30 ± 12%      +1.1        3.44 ±  7%  perf-profile.calltrace.cycles-pp.__napi_poll.net_rx_action.__do_softirq.do_softirq.__local_bh_enable_ip
      2.34 ±  9%      +1.0        3.30 ± 12%      +1.1        3.44 ±  7%  perf-profile.calltrace.cycles-pp.process_backlog.__napi_poll.net_rx_action.__do_softirq.do_softirq
      2.56 ±  8%      +1.0        3.52 ± 12%      +1.2        3.77 ±  5%  perf-profile.calltrace.cycles-pp.__dev_queue_xmit.ip_finish_output2.__ip_queue_xmit.sctp_packet_transmit.sctp_outq_flush
      2.41 ±  9%      +1.0        3.38 ± 12%      +1.1        3.55 ±  5%  perf-profile.calltrace.cycles-pp.__do_softirq.do_softirq.__local_bh_enable_ip.__dev_queue_xmit.ip_finish_output2
      2.42 ±  9%      +1.0        3.39 ± 12%      +1.1        3.56 ±  5%  perf-profile.calltrace.cycles-pp.do_softirq.__local_bh_enable_ip.__dev_queue_xmit.ip_finish_output2.__ip_queue_xmit
      1.76 ± 14%      +1.0        2.74 ± 12%      +1.1        2.87 ±  3%  perf-profile.calltrace.cycles-pp.__ip_queue_xmit.sctp_packet_transmit.sctp_outq_flush.sctp_assoc_rwnd_increase.sctp_ulpevent_free
      2.34 ± 10%      +1.0        3.32 ± 11%      +1.1        3.47 ±  6%  perf-profile.calltrace.cycles-pp.net_rx_action.__do_softirq.do_softirq.__local_bh_enable_ip.__dev_queue_xmit
      2.42 ±  9%      +1.0        3.40 ± 12%      +1.2        3.58 ±  5%  perf-profile.calltrace.cycles-pp.__local_bh_enable_ip.__dev_queue_xmit.ip_finish_output2.__ip_queue_xmit.sctp_packet_transmit
      1.72 ± 15%      +1.0        2.70 ± 12%      +1.1        2.81 ±  3%  perf-profile.calltrace.cycles-pp.ip_finish_output2.__ip_queue_xmit.sctp_packet_transmit.sctp_outq_flush.sctp_assoc_rwnd_increase
      0.09 ±223%      +1.0        1.10 ± 51%      +0.6        0.65 ± 13%  perf-profile.calltrace.cycles-pp.rmqueue.get_page_from_freelist.__alloc_pages.__kmalloc_large_node.__kmalloc_node_track_caller
      1.88 ± 13%      +1.0        2.90 ± 12%      +1.2        3.03 ±  4%  perf-profile.calltrace.cycles-pp.sctp_packet_transmit.sctp_outq_flush.sctp_assoc_rwnd_increase.sctp_ulpevent_free.sctp_recvmsg
      2.23 ± 10%      +1.0        3.26 ± 13%      +1.2        3.46 ±  6%  perf-profile.calltrace.cycles-pp.sctp_assoc_rwnd_increase.sctp_ulpevent_free.sctp_recvmsg.inet_recvmsg.sock_recvmsg
      1.98 ± 13%      +1.0        3.02 ± 12%      +1.2        3.16 ±  5%  perf-profile.calltrace.cycles-pp.sctp_outq_flush.sctp_assoc_rwnd_increase.sctp_ulpevent_free.sctp_recvmsg.inet_recvmsg
      0.00            +1.2        1.17 ± 17%      +1.1        1.13 ± 16%  perf-profile.calltrace.cycles-pp.tmigr_handle_remote_cpu.tmigr_handle_remote_up.tmigr_handle_remote.__do_softirq.irq_exit_rcu
      0.00            +1.3        1.32 ± 16%      +1.4        1.41 ± 19%  perf-profile.calltrace.cycles-pp.tmigr_handle_remote_up.tmigr_handle_remote.__do_softirq.irq_exit_rcu.sysvec_apic_timer_interrupt
      0.00            +1.3        1.34 ± 17%      +1.4        1.42 ± 19%  perf-profile.calltrace.cycles-pp.tmigr_handle_remote.__do_softirq.irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      3.52 ±  7%      +1.4        4.90 ± 15%      +1.6        5.11 ±  4%  perf-profile.calltrace.cycles-pp.sctp_ulpevent_free.sctp_recvmsg.inet_recvmsg.sock_recvmsg.____sys_recvmsg
     15.56 ±  7%      +2.0       17.52 ±  8%      +2.7       18.21 ±  7%  perf-profile.calltrace.cycles-pp.____sys_recvmsg.___sys_recvmsg.__sys_recvmsg.do_syscall_64.entry_SYSCALL_64_after_hwframe
     15.19 ±  7%      +2.0       17.18 ±  8%      +2.7       17.90 ±  7%  perf-profile.calltrace.cycles-pp.inet_recvmsg.sock_recvmsg.____sys_recvmsg.___sys_recvmsg.__sys_recvmsg
     15.70 ±  6%      +2.0       17.71 ±  7%      +2.6       18.35 ±  7%  perf-profile.calltrace.cycles-pp.___sys_recvmsg.__sys_recvmsg.do_syscall_64.entry_SYSCALL_64_after_hwframe.recvmsg
     15.14 ±  7%      +2.0       17.15 ±  8%      +2.7       17.88 ±  7%  perf-profile.calltrace.cycles-pp.sctp_recvmsg.inet_recvmsg.sock_recvmsg.____sys_recvmsg.___sys_recvmsg
     15.29 ±  7%      +2.0       17.31 ±  8%      +2.7       18.02 ±  7%  perf-profile.calltrace.cycles-pp.sock_recvmsg.____sys_recvmsg.___sys_recvmsg.__sys_recvmsg.do_syscall_64
     15.87 ±  6%      +2.0       17.89 ±  7%      +2.7       18.55 ±  7%  perf-profile.calltrace.cycles-pp.__sys_recvmsg.do_syscall_64.entry_SYSCALL_64_after_hwframe.recvmsg
     16.56 ±  6%      +2.1       18.68 ±  7%      +2.7       19.26 ±  7%  perf-profile.calltrace.cycles-pp.recvmsg
     16.24 ±  6%      +2.2       18.40 ±  7%      +2.8       19.00 ±  7%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.recvmsg
     16.22 ±  6%      +2.2       18.39 ±  7%      +2.8       18.99 ±  7%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.recvmsg
      4.94 ±  5%      +5.0        9.93 ±  9%      +5.2       10.09 ± 13%  perf-profile.calltrace.cycles-pp.kthread.ret_from_fork.ret_from_fork_asm
      4.94 ±  5%      +5.0        9.93 ±  9%      +5.2       10.09 ± 13%  perf-profile.calltrace.cycles-pp.ret_from_fork.ret_from_fork_asm
      4.94 ±  5%      +5.0        9.93 ±  9%      +5.2       10.09 ± 13%  perf-profile.calltrace.cycles-pp.ret_from_fork_asm
      2.83 ±  9%      +5.3        8.09 ± 13%      +5.4        8.24 ± 15%  perf-profile.calltrace.cycles-pp.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      1.70 ± 12%      +5.6        7.28 ± 14%      +5.8        7.54 ± 15%  perf-profile.calltrace.cycles-pp.net_rx_action.__do_softirq.run_ksoftirqd.smpboot_thread_fn.kthread
      1.70 ± 13%      +5.6        7.28 ± 14%      +5.8        7.54 ± 15%  perf-profile.calltrace.cycles-pp.__napi_poll.net_rx_action.__do_softirq.run_ksoftirqd.smpboot_thread_fn
      1.70 ± 13%      +5.6        7.28 ± 14%      +5.8        7.54 ± 15%  perf-profile.calltrace.cycles-pp.process_backlog.__napi_poll.net_rx_action.__do_softirq.run_ksoftirqd
      1.73 ± 12%      +5.6        7.31 ± 14%      +5.8        7.57 ± 15%  perf-profile.calltrace.cycles-pp.run_ksoftirqd.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      1.73 ± 12%      +5.6        7.31 ± 14%      +5.8        7.57 ± 15%  perf-profile.calltrace.cycles-pp.__do_softirq.run_ksoftirqd.smpboot_thread_fn.kthread.ret_from_fork
      0.00           +13.2       13.15 ± 49%     +11.3       11.25 ± 55%  perf-profile.calltrace.cycles-pp.poll_idle.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
     36.91 ±  2%     -12.6       24.32 ± 10%     -12.3       24.63 ±  5%  perf-profile.children.cycles-pp.acpi_idle_enter
     36.80 ±  2%     -12.5       24.31 ± 10%     -12.2       24.58 ±  5%  perf-profile.children.cycles-pp.acpi_safe_halt
     29.95 ±  3%     -12.1       17.81 ± 11%     -12.0       17.96 ±  5%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
     27.78 ±  3%     -12.0       15.78 ± 13%     -11.7       16.06 ±  5%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
     25.75 ±  2%      -9.7       16.02 ± 13%      -9.2       16.53 ±  5%  perf-profile.children.cycles-pp.irq_exit_rcu
      6.04 ±  8%      -3.5        2.52 ± 16%      -3.3        2.72 ± 13%  perf-profile.children.cycles-pp._nohz_idle_balance
      5.07 ±  3%      -3.5        1.60 ± 18%      -3.4        1.63 ± 11%  perf-profile.children.cycles-pp._raw_spin_lock
     29.77 ±  2%      -3.0       26.73 ±  8%      -2.0       27.76 ±  7%  perf-profile.children.cycles-pp.__do_softirq
     25.22 ±  3%      -2.9       22.31 ±  8%      -2.2       23.01 ±  6%  perf-profile.children.cycles-pp.net_rx_action
     25.18 ±  3%      -2.9       22.28 ±  8%      -2.2       22.98 ±  6%  perf-profile.children.cycles-pp.__napi_poll
     25.14 ±  3%      -2.9       22.26 ±  8%      -2.2       22.96 ±  6%  perf-profile.children.cycles-pp.process_backlog
     24.71 ±  3%      -2.9       21.86 ±  8%      -2.2       22.47 ±  7%  perf-profile.children.cycles-pp.ip_protocol_deliver_rcu
     25.04 ±  3%      -2.9       22.19 ±  8%      -2.2       22.87 ±  6%  perf-profile.children.cycles-pp.__netif_receive_skb_one_core
     24.72 ±  3%      -2.9       21.86 ±  8%      -2.2       22.49 ±  7%  perf-profile.children.cycles-pp.ip_local_deliver_finish
     24.62 ±  3%      -2.8       21.80 ±  8%      -2.2       22.42 ±  7%  perf-profile.children.cycles-pp.sctp_rcv
     23.24 ±  3%      -2.6       20.63 ±  8%      -2.0       21.20 ±  7%  perf-profile.children.cycles-pp.sctp_assoc_bh_rcv
      2.80 ±  6%      -2.4        0.45 ± 33%      -2.4        0.44 ± 18%  perf-profile.children.cycles-pp.raw_spin_rq_lock_nested
     26.58 ±  2%      -2.2       24.38 ±  8%      -1.6       25.02 ±  7%  perf-profile.children.cycles-pp.sctp_do_sm
      5.62 ±  5%      -1.9        3.71 ± 10%      -1.8        3.80 ±  8%  perf-profile.children.cycles-pp.sctp_outq_flush_data
     10.75 ±  3%      -1.6        9.14 ±  7%      -1.1        9.63 ±  6%  perf-profile.children.cycles-pp._copy_from_iter
     10.86 ±  3%      -1.6        9.29 ±  7%      -1.1        9.71 ±  6%  perf-profile.children.cycles-pp.sctp_user_addto_chunk
      1.77 ± 11%      -1.5        0.25 ± 25%      -1.5        0.22 ± 24%  perf-profile.children.cycles-pp.__mod_timer
      1.83 ± 13%      -1.4        0.45 ± 16%      -1.3        0.49 ± 12%  perf-profile.children.cycles-pp.run_timer_softirq
      1.46 ± 11%      -1.3        0.12 ± 31%      -1.4        0.09 ± 66%  perf-profile.children.cycles-pp.sctp_transport_reset_t3_rtx
     12.22 ±  3%      -1.2       11.02 ±  6%      -0.7       11.55 ± 10%  perf-profile.children.cycles-pp.sctp_datamsg_from_user
      1.40 ± 13%      -1.0        0.35 ± 16%      -1.0        0.40 ± 24%  perf-profile.children.cycles-pp.tick_irq_enter
      1.44 ± 13%      -1.0        0.40 ± 11%      -1.0        0.47 ± 13%  perf-profile.children.cycles-pp.irq_enter_rcu
      0.97 ± 15%      -0.9        0.10 ± 52%      -0.9        0.07 ± 52%  perf-profile.children.cycles-pp.tick_do_update_jiffies64
      1.53 ±  7%      -0.8        0.69 ± 28%      -0.7        0.83 ± 32%  perf-profile.children.cycles-pp.update_blocked_averages
      3.73 ±  8%      -0.7        3.01 ±  8%      -0.6        3.15 ±  8%  perf-profile.children.cycles-pp.sctp_packet_transmit_chunk
      1.00 ± 27%      -0.6        0.43 ± 18%      -0.6        0.39 ± 15%  perf-profile.children.cycles-pp.update_rq_clock_task
      2.33 ± 11%      -0.5        1.79 ± 12%      -0.6        1.77 ±  7%  perf-profile.children.cycles-pp.asm_exc_page_fault
      1.74 ± 12%      -0.5        1.20 ± 12%      -0.5        1.29 ±  5%  perf-profile.children.cycles-pp.__run_timers
      1.61 ±  9%      -0.5        1.12 ± 12%      -0.4        1.23 ±  4%  perf-profile.children.cycles-pp.call_timer_fn
      3.33 ±  3%      -0.4        2.89 ± 11%      -0.4        2.89 ± 10%  perf-profile.children.cycles-pp.sctp_ulpq_partial_delivery
      1.94 ±  6%      -0.4        1.52 ± 11%      -0.3        1.63 ±  7%  perf-profile.children.cycles-pp.vfs_read
      1.88 ± 10%      -0.4        1.46 ± 11%      -0.4        1.50 ±  7%  perf-profile.children.cycles-pp.handle_mm_fault
      1.65 ±  5%      -0.4        1.24 ± 25%      -0.4        1.22 ± 17%  perf-profile.children.cycles-pp.hrtimer_interrupt
      1.73 ±  7%      -0.4        1.32 ± 26%      -0.5        1.27 ± 18%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      2.13 ±  5%      -0.4        1.75 ± 13%      -0.3        1.86 ±  8%  perf-profile.children.cycles-pp.read
      0.60 ± 19%      -0.4        0.23 ± 22%      -0.3        0.34 ± 75%  perf-profile.children.cycles-pp._find_next_and_bit
      1.98 ±  5%      -0.4        1.62 ± 13%      -0.2        1.75 ±  6%  perf-profile.children.cycles-pp.ksys_read
      0.66 ± 12%      -0.4        0.31 ± 15%      -0.3        0.33 ± 21%  perf-profile.children.cycles-pp.update_rq_clock
      1.70 ± 11%      -0.3        1.36 ± 16%      -0.4        1.29 ± 13%  perf-profile.children.cycles-pp.worker_thread
      1.16 ± 10%      -0.3        0.83 ± 10%      -0.2        0.92 ±  2%  perf-profile.children.cycles-pp.sctp_generate_timeout_event
      0.92 ± 14%      -0.3        0.62 ± 24%      -0.2        0.73 ± 14%  perf-profile.children.cycles-pp.exit_mmap
      0.93 ± 15%      -0.3        0.63 ± 24%      -0.2        0.74 ± 13%  perf-profile.children.cycles-pp.__mmput
      1.77 ±  7%      -0.3        1.48 ±  9%      -0.3        1.51 ±  6%  perf-profile.children.cycles-pp.execve
      0.34 ± 17%      -0.3        0.06 ± 75%      -0.3        0.09 ± 21%  perf-profile.children.cycles-pp.run_rebalance_domains
      1.77 ±  8%      -0.3        1.48 ±  8%      -0.3        1.51 ±  6%  perf-profile.children.cycles-pp.do_execveat_common
      1.78 ±  8%      -0.3        1.50 ±  8%      -0.3        1.51 ±  6%  perf-profile.children.cycles-pp.__x64_sys_execve
      0.52 ± 21%      -0.3        0.24 ± 29%      -0.3        0.25 ±  6%  perf-profile.children.cycles-pp.__update_blocked_fair
      1.03 ± 11%      -0.2        0.79 ±  8%      -0.2        0.81 ±  5%  perf-profile.children.cycles-pp.load_elf_binary
      1.06 ± 10%      -0.2        0.83 ±  6%      -0.2        0.83 ±  6%  perf-profile.children.cycles-pp.search_binary_handler
      0.73 ± 11%      -0.2        0.50 ± 23%      -0.1        0.62 ± 14%  perf-profile.children.cycles-pp.exit_mm
      1.24 ±  9%      -0.2        1.01 ± 10%      -0.1        1.16 ± 15%  perf-profile.children.cycles-pp.read_counters
      1.06 ± 10%      -0.2        0.83 ±  6%      -0.2        0.84 ±  5%  perf-profile.children.cycles-pp.exec_binprm
      0.79 ± 14%      -0.2        0.56 ± 18%      -0.1        0.71 ± 25%  perf-profile.children.cycles-pp.sched_setaffinity
      0.87 ± 13%      -0.2        0.65 ± 14%      -0.2        0.63 ± 13%  perf-profile.children.cycles-pp.enqueue_task_fair
      0.35 ± 25%      -0.2        0.13 ± 19%      -0.2        0.11 ± 60%  perf-profile.children.cycles-pp.release_sock
      1.50 ±  3%      -0.2        1.28 ±  9%      -0.3        1.18 ± 19%  perf-profile.children.cycles-pp.kmem_cache_free
      0.71 ± 11%      -0.2        0.49 ± 22%      -0.2        0.55 ± 16%  perf-profile.children.cycles-pp.setlocale
      1.09 ±  5%      -0.2        0.87 ± 14%      -0.2        0.91 ±  8%  perf-profile.children.cycles-pp.seq_read_iter
      1.36 ±  6%      -0.2        1.14 ± 15%      -0.2        1.16 ±  7%  perf-profile.children.cycles-pp.__flush_smp_call_function_queue
      1.15 ±  9%      -0.2        0.93 ± 14%      -0.2        0.91 ± 10%  perf-profile.children.cycles-pp.sched_ttwu_pending
      1.02 ± 12%      -0.2        0.81 ± 18%      -0.2        0.78 ± 13%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      0.75 ± 13%      -0.2        0.55 ± 11%      -0.2        0.56 ± 12%  perf-profile.children.cycles-pp.enqueue_entity
      0.53 ± 13%      -0.2        0.33 ± 23%      -0.2        0.28 ± 18%  perf-profile.children.cycles-pp.refresh_cpu_vm_stats
      0.28 ± 23%      -0.2        0.09 ± 10%      -0.2        0.08 ± 68%  perf-profile.children.cycles-pp.__release_sock
      0.24 ± 32%      -0.2        0.05 ± 74%      -0.2        0.06 ± 54%  perf-profile.children.cycles-pp.hrtimer_try_to_cancel
      0.25 ± 28%      -0.2        0.06 ± 53%      -0.2        0.06 ± 54%  perf-profile.children.cycles-pp.hrtimer_cancel
      0.26 ± 26%      -0.2        0.08 ± 16%      -0.2        0.08 ± 68%  perf-profile.children.cycles-pp.sctp_backlog_rcv
      1.00 ±  8%      -0.2        0.82 ± 14%      -0.1        0.87 ± 14%  perf-profile.children.cycles-pp.ttwu_do_activate
      0.39 ± 19%      -0.2        0.21 ± 23%      -0.1        0.24 ± 22%  perf-profile.children.cycles-pp.__memcg_slab_free_hook
      0.30 ± 16%      -0.2        0.13 ± 29%      -0.2        0.09 ± 49%  perf-profile.children.cycles-pp.ktime_get_update_offsets_now
      0.46 ± 10%      -0.1        0.32 ± 28%      -0.1        0.32 ± 23%  perf-profile.children.cycles-pp.sched_clock_cpu
      0.40 ± 18%      -0.1        0.26 ± 26%      -0.1        0.30 ± 24%  perf-profile.children.cycles-pp.sched_clock
      0.56 ± 12%      -0.1        0.42 ± 12%      -0.0        0.51 ± 28%  perf-profile.children.cycles-pp.evlist_cpu_iterator__next
      1.24 ±  9%      -0.1        1.11 ±  7%      -0.3        0.95 ±  4%  perf-profile.children.cycles-pp.tick_nohz_stop_tick
      1.25 ± 10%      -0.1        1.12 ±  7%      -0.3        0.95 ±  4%  perf-profile.children.cycles-pp.tick_nohz_idle_stop_tick
      0.80 ± 12%      -0.1        0.68 ± 17%      -0.2        0.65 ±  3%  perf-profile.children.cycles-pp.do_read_fault
      0.31 ± 21%      -0.1        0.19 ± 28%      -0.1        0.25 ± 31%  perf-profile.children.cycles-pp.read_tsc
      0.13 ± 34%      -0.1        0.01 ±223%      -0.1        0.03 ± 82%  perf-profile.children.cycles-pp.sctp_generate_heartbeat_event
      0.32 ± 23%      -0.1        0.20 ± 25%      -0.2        0.15 ± 20%  perf-profile.children.cycles-pp.need_update
      0.39 ± 18%      -0.1        0.28 ± 14%      -0.1        0.25 ± 23%  perf-profile.children.cycles-pp.sctp_inq_pop
      0.35 ± 19%      -0.1        0.24 ± 26%      -0.0        0.31 ± 26%  perf-profile.children.cycles-pp.__x64_sys_sched_setaffinity
      0.24 ± 20%      -0.1        0.12 ± 63%      -0.1        0.13 ± 22%  perf-profile.children.cycles-pp.free_pgtables
      0.32 ± 25%      -0.1        0.21 ± 25%      -0.2        0.16 ± 19%  perf-profile.children.cycles-pp.quiet_vmstat
      0.16 ± 33%      -0.1        0.05 ± 72%      -0.1        0.06 ± 60%  perf-profile.children.cycles-pp.call_cpuidle
      0.54 ±  7%      -0.1        0.44 ± 21%      -0.0        0.50 ±  5%  perf-profile.children.cycles-pp.update_load_avg
      0.37 ± 18%      -0.1        0.26 ± 15%      -0.1        0.24 ±  5%  perf-profile.children.cycles-pp.mem_cgroup_charge_skmem
      0.23 ± 23%      -0.1        0.13 ± 36%      -0.0        0.22 ± 27%  perf-profile.children.cycles-pp.__set_cpus_allowed_ptr
      0.23 ± 31%      -0.1        0.13 ± 19%      -0.1        0.11 ± 16%  perf-profile.children.cycles-pp.timekeeping_advance
      0.23 ± 31%      -0.1        0.13 ± 19%      -0.1        0.11 ± 16%  perf-profile.children.cycles-pp.update_wall_time
      0.26 ± 20%      -0.1        0.16 ± 22%      -0.1        0.16 ± 34%  perf-profile.children.cycles-pp.tlb_finish_mmu
      0.20 ± 38%      -0.1        0.10 ± 22%      -0.1        0.10 ± 33%  perf-profile.children.cycles-pp.__smp_call_single_queue
      0.13 ± 26%      -0.1        0.04 ±104%      -0.1        0.08 ± 17%  perf-profile.children.cycles-pp.open_last_lookups
      0.40 ± 16%      -0.1        0.31 ± 15%      -0.1        0.26 ±  8%  perf-profile.children.cycles-pp.__sk_mem_schedule
      0.27 ±  7%      -0.1        0.18 ± 15%      -0.1        0.17 ± 38%  perf-profile.children.cycles-pp.update_curr
      0.38 ± 24%      -0.1        0.29 ± 18%      -0.1        0.27 ± 11%  perf-profile.children.cycles-pp.lapic_next_deadline
      0.14 ± 31%      -0.1        0.05 ± 77%      -0.0        0.09 ± 64%  perf-profile.children.cycles-pp.irqentry_exit
      0.25 ± 15%      -0.1        0.17 ± 26%      -0.1        0.16 ± 45%  perf-profile.children.cycles-pp._find_next_bit
      0.21 ± 13%      -0.1        0.14 ± 17%      -0.1        0.11 ± 41%  perf-profile.children.cycles-pp.lookup_fast
      0.34 ± 23%      -0.1        0.27 ± 17%      -0.1        0.23 ± 33%  perf-profile.children.cycles-pp.rcu_core
      0.54 ± 11%      -0.1        0.48 ± 16%      -0.2        0.38 ± 32%  perf-profile.children.cycles-pp.balance_fair
      0.14 ± 34%      -0.1        0.08 ± 72%      -0.1        0.05 ± 90%  perf-profile.children.cycles-pp.vma_prepare
      0.31 ± 22%      -0.1        0.24 ± 35%      -0.1        0.19 ± 19%  perf-profile.children.cycles-pp.begin_new_exec
      0.15 ± 36%      -0.1        0.08 ± 52%      -0.1        0.08 ± 24%  perf-profile.children.cycles-pp.set_next_entity
      0.12 ± 32%      -0.1        0.06 ± 50%      -0.0        0.08 ± 82%  perf-profile.children.cycles-pp.setup_arg_pages
      0.25 ± 37%      -0.1        0.19 ± 42%      -0.1        0.14 ± 19%  perf-profile.children.cycles-pp.irqentry_enter
      0.50 ± 14%      -0.1        0.45 ± 30%      -0.1        0.37 ± 11%  perf-profile.children.cycles-pp.do_vmi_align_munmap
      0.19 ± 19%      -0.1        0.14 ± 37%      -0.1        0.11 ± 23%  perf-profile.children.cycles-pp.__vm_munmap
      0.08 ± 13%      -0.1        0.03 ±103%      -0.1        0.01 ±200%  perf-profile.children.cycles-pp.__call_rcu_common
      0.22 ±  8%      -0.0        0.17 ± 15%      -0.1        0.17 ± 13%  perf-profile.children.cycles-pp.diskstats_show
      0.10 ± 26%      -0.0        0.05 ± 45%      -0.0        0.07 ± 82%  perf-profile.children.cycles-pp.shift_arg_pages
      0.15 ± 17%      -0.0        0.10 ± 53%      -0.1        0.05 ± 86%  perf-profile.children.cycles-pp.__x64_sys_munmap
      0.22 ± 17%      -0.0        0.19 ± 38%      -0.1        0.12 ± 34%  perf-profile.children.cycles-pp.should_we_balance
      0.13 ±  7%      -0.0        0.11 ±  8%      -0.0        0.10 ±  9%  perf-profile.children.cycles-pp.perf_mmap__push
      0.13 ±  7%      -0.0        0.11 ±  8%      -0.0        0.10 ±  9%  perf-profile.children.cycles-pp.record__mmap_read_evlist
      0.10 ± 22%      -0.0        0.09 ± 38%      -0.0        0.06 ± 57%  perf-profile.children.cycles-pp.down_write
      0.00            +0.0        0.00            +0.7        0.67 ± 13%  perf-profile.children.cycles-pp.tick_nohz_handler
      0.02 ±141%      +0.1        0.07 ± 62%      +0.1        0.07 ± 32%  perf-profile.children.cycles-pp.rb_erase
      0.06 ±106%      +0.1        0.11 ± 26%      +0.1        0.18 ± 36%  perf-profile.children.cycles-pp.timerqueue_add
      0.01 ±223%      +0.1        0.08 ± 68%      +0.1        0.10 ± 25%  perf-profile.children.cycles-pp.sched_mm_cid_migrate_to
      0.07 ± 52%      +0.1        0.15 ± 33%      +0.1        0.16 ± 38%  perf-profile.children.cycles-pp.local_clock_noinstr
      0.16 ± 29%      +0.1        0.25 ± 21%      +0.1        0.25 ± 31%  perf-profile.children.cycles-pp.select_task_rq
      0.25 ± 25%      +0.1        0.37 ± 23%      +0.1        0.36 ± 17%  perf-profile.children.cycles-pp.select_task_rq_fair
      0.00            +0.1        0.12 ± 39%      +0.1        0.12 ± 38%  perf-profile.children.cycles-pp.__tmigr_cpu_activate
      0.00            +0.2        0.16 ± 41%      +0.2        0.16 ± 19%  perf-profile.children.cycles-pp.tmigr_cpu_activate
      0.00            +0.2        0.18 ± 22%      +0.2        0.19 ± 38%  perf-profile.children.cycles-pp.tmigr_inactive_up
      0.00            +0.2        0.21 ± 49%      +0.2        0.22 ± 29%  perf-profile.children.cycles-pp.task_mm_cid_work
      1.38 ±  5%      +0.2        1.60 ±  3%      +0.4        1.77 ± 34%  perf-profile.children.cycles-pp._sctp_make_chunk
      0.00            +0.2        0.22 ± 18%      +0.2        0.19 ± 38%  perf-profile.children.cycles-pp.tmigr_cpu_deactivate
      0.06 ± 23%      +0.2        0.29 ± 30%      +0.2        0.25 ± 25%  perf-profile.children.cycles-pp.task_work_run
      1.21 ±  7%      +0.3        1.52 ±  7%      +0.4        1.66 ± 36%  perf-profile.children.cycles-pp.sctp_make_datafrag_empty
      0.84 ± 13%      +0.3        1.18 ±  2%      +0.5        1.38 ±  7%  perf-profile.children.cycles-pp.sctp_wait_for_sndbuf
      0.07 ± 24%      +0.4        0.47 ±  9%      +0.4        0.42 ±  9%  perf-profile.children.cycles-pp.__get_next_timer_interrupt
      0.00            +0.5        0.49 ± 18%      +0.5        0.49 ± 35%  perf-profile.children.cycles-pp.tmigr_update_events
      2.73 ±  8%      +0.5        3.26 ± 14%      +0.5        3.24 ±  7%  perf-profile.children.cycles-pp.consume_skb
      2.91 ±  8%      +0.6        3.49 ± 16%      +0.7        3.63 ± 12%  perf-profile.children.cycles-pp.sysvec_call_function_single
      3.12 ±  7%      +0.7        3.77 ± 16%      +0.7        3.85 ±  7%  perf-profile.children.cycles-pp.sctp_primitive_SEND
      1.48 ± 14%      +0.7        2.18 ± 15%      +0.9        2.35 ± 15%  perf-profile.children.cycles-pp.__free_pages_ok
      0.58 ± 29%      +0.8        1.34 ± 12%      +0.8        1.39 ± 19%  perf-profile.children.cycles-pp.free_one_page
      2.46 ± 11%      +0.8        3.23 ± 12%      +0.9        3.35 ±  9%  perf-profile.children.cycles-pp.skb_release_data
      0.00            +0.8        0.78 ± 17%      +0.8        0.81 ±  9%  perf-profile.children.cycles-pp.timer_expire_remote
      3.32 ±  5%      +0.8        4.14 ± 11%      +1.1        4.42 ±  6%  perf-profile.children.cycles-pp.__ip_queue_xmit
      2.44 ±  4%      +0.8        3.27 ± 19%      +0.7        3.10 ±  9%  perf-profile.children.cycles-pp.kmalloc_reserve
      2.86 ±  5%      +0.8        3.70 ± 17%      +0.6        3.48 ±  8%  perf-profile.children.cycles-pp.__alloc_skb
      3.00 ±  6%      +0.8        3.84 ± 11%      +1.1        4.09 ±  6%  perf-profile.children.cycles-pp.ip_finish_output2
      2.88 ±  6%      +0.9        3.73 ± 11%      +1.1        3.97 ±  6%  perf-profile.children.cycles-pp.__dev_queue_xmit
      2.26 ±  9%      +0.9        3.12 ± 19%      +0.6        2.90 ± 10%  perf-profile.children.cycles-pp.__alloc_pages
      2.32 ±  4%      +0.9        3.19 ± 20%      +0.7        3.01 ±  8%  perf-profile.children.cycles-pp.__kmalloc_node_track_caller
      2.29 ±  4%      +0.9        3.18 ± 19%      +0.7        2.98 ±  8%  perf-profile.children.cycles-pp.__kmalloc_large_node
      2.09 ±  8%      +0.9        2.97 ± 20%      +0.6        2.67 ±  9%  perf-profile.children.cycles-pp.get_page_from_freelist
      1.25 ± 10%      +0.9        2.20 ± 24%      +0.7        1.92 ± 10%  perf-profile.children.cycles-pp.rmqueue
      2.23 ± 10%      +1.0        3.27 ± 13%      +1.2        3.46 ±  6%  perf-profile.children.cycles-pp.sctp_assoc_rwnd_increase
      2.43 ±  9%      +1.1        3.52 ± 11%      +1.3        3.75 ±  8%  perf-profile.children.cycles-pp.do_softirq
      2.46 ±  9%      +1.1        3.56 ± 11%      +1.3        3.76 ±  7%  perf-profile.children.cycles-pp.__local_bh_enable_ip
      0.00            +1.2        1.20 ± 16%      +1.2        1.18 ± 16%  perf-profile.children.cycles-pp.tmigr_handle_remote_cpu
      0.00            +1.4        1.36 ± 15%      +1.5        1.47 ± 19%  perf-profile.children.cycles-pp.tmigr_handle_remote_up
      3.53 ±  7%      +1.4        4.91 ± 15%      +1.6        5.12 ±  4%  perf-profile.children.cycles-pp.sctp_ulpevent_free
      0.00            +1.4        1.38 ± 16%      +1.5        1.48 ± 19%  perf-profile.children.cycles-pp.tmigr_handle_remote
      2.16 ±  9%      +1.4        3.56 ±  9%      +1.4        3.53 ±  9%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
     15.32 ±  7%      +2.0       17.29 ±  8%      +2.7       18.03 ±  7%  perf-profile.children.cycles-pp.sctp_recvmsg
     15.56 ±  7%      +2.0       17.53 ±  8%      +2.7       18.21 ±  7%  perf-profile.children.cycles-pp.____sys_recvmsg
     15.19 ±  7%      +2.0       17.18 ±  8%      +2.7       17.90 ±  7%  perf-profile.children.cycles-pp.inet_recvmsg
     15.70 ±  6%      +2.0       17.72 ±  7%      +2.7       18.36 ±  7%  perf-profile.children.cycles-pp.___sys_recvmsg
     15.29 ±  7%      +2.0       17.31 ±  8%      +2.7       18.02 ±  7%  perf-profile.children.cycles-pp.sock_recvmsg
     15.87 ±  6%      +2.0       17.89 ±  7%      +2.7       18.55 ±  7%  perf-profile.children.cycles-pp.__sys_recvmsg
     16.60 ±  6%      +2.1       18.70 ±  8%      +2.7       19.29 ±  7%  perf-profile.children.cycles-pp.recvmsg
      5.02 ±  5%      +5.0        9.99 ±  9%      +5.1       10.16 ± 13%  perf-profile.children.cycles-pp.ret_from_fork_asm
      5.00 ±  4%      +5.0        9.97 ±  9%      +5.2       10.16 ± 13%  perf-profile.children.cycles-pp.ret_from_fork
      4.94 ±  5%      +5.0        9.93 ±  9%      +5.2       10.09 ± 13%  perf-profile.children.cycles-pp.kthread
      2.83 ±  9%      +5.3        8.09 ± 13%      +5.4        8.24 ± 15%  perf-profile.children.cycles-pp.smpboot_thread_fn
      1.73 ± 12%      +5.6        7.31 ± 14%      +5.8        7.57 ± 15%  perf-profile.children.cycles-pp.run_ksoftirqd
      0.02 ±141%     +13.2       13.22 ± 49%     +11.3       11.35 ± 54%  perf-profile.children.cycles-pp.poll_idle
     10.64 ±  4%      -1.6        9.04 ±  7%      -1.2        9.43 ±  6%  perf-profile.self.cycles-pp._copy_from_iter
      2.41 ±  5%      -1.2        1.18 ± 19%      -1.3        1.12 ± 10%  perf-profile.self.cycles-pp._raw_spin_lock
      0.65 ± 23%      -0.6        0.07 ± 81%      -0.5        0.17 ± 11%  perf-profile.self.cycles-pp._nohz_idle_balance
      0.84 ± 28%      -0.5        0.34 ± 19%      -0.5        0.32 ± 22%  perf-profile.self.cycles-pp.update_rq_clock_task
      0.46 ± 27%      -0.2        0.22 ± 18%      -0.3        0.20 ± 47%  perf-profile.self.cycles-pp._find_next_and_bit
      0.43 ±  9%      -0.2        0.20 ± 19%      -0.2        0.21 ± 22%  perf-profile.self.cycles-pp.update_rq_clock
      0.52 ± 19%      -0.2        0.33 ± 33%      -0.2        0.36 ± 26%  perf-profile.self.cycles-pp.idle_cpu
      0.29 ± 16%      -0.2        0.11 ± 28%      -0.2        0.08 ± 71%  perf-profile.self.cycles-pp.ktime_get_update_offsets_now
      0.33 ± 32%      -0.2        0.15 ± 24%      -0.2        0.15 ± 24%  perf-profile.self.cycles-pp.__update_blocked_fair
      0.35 ± 17%      -0.2        0.20 ± 48%      -0.2        0.20 ± 13%  perf-profile.self.cycles-pp.refresh_cpu_vm_stats
      0.25 ± 28%      -0.1        0.12 ± 74%      -0.1        0.13 ± 31%  perf-profile.self.cycles-pp.__memcg_slab_free_hook
      0.16 ± 34%      -0.1        0.04 ±156%      -0.1        0.06 ± 81%  perf-profile.self.cycles-pp.need_update
      0.16 ± 32%      -0.1        0.04 ±100%      -0.1        0.06 ± 56%  perf-profile.self.cycles-pp.call_cpuidle
      0.30 ± 21%      -0.1        0.19 ± 26%      -0.0        0.25 ± 31%  perf-profile.self.cycles-pp.read_tsc
      0.20 ± 21%      -0.1        0.09 ± 50%      -0.1        0.13 ± 38%  perf-profile.self.cycles-pp._raw_spin_lock_bh
      0.38 ± 24%      -0.1        0.29 ± 18%      -0.1        0.27 ± 11%  perf-profile.self.cycles-pp.lapic_next_deadline
      0.12 ± 19%      -0.1        0.04 ±116%      -0.1        0.04 ± 83%  perf-profile.self.cycles-pp.sctp_inq_pop
      0.19 ± 14%      -0.1        0.12 ± 15%      -0.0        0.16 ± 25%  perf-profile.self.cycles-pp.filemap_map_pages
      0.12 ± 21%      -0.1        0.06 ± 48%      -0.1        0.07 ± 74%  perf-profile.self.cycles-pp.rebalance_domains
      0.10 ± 29%      -0.0        0.06 ± 50%      -0.1        0.05 ± 88%  perf-profile.self.cycles-pp.release_pages
      0.01 ±223%      +0.1        0.08 ± 68%      +0.1        0.10 ± 25%  perf-profile.self.cycles-pp.sched_mm_cid_migrate_to
      0.00            +0.2        0.18 ± 48%      +0.2        0.19 ± 24%  perf-profile.self.cycles-pp.task_mm_cid_work
      0.02 ±141%     +13.0       13.04 ± 49%     +11.1       11.11 ± 54%  perf-profile.self.cycles-pp.poll_idle



