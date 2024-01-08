Return-Path: <linux-kernel+bounces-19313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F36E826B48
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 11:01:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AFF44B21A69
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 10:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 798FE1429C;
	Mon,  8 Jan 2024 10:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MQlN9YuO"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 345611428E
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 10:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704708044; x=1736244044;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=iWpSe0+WfT5CYlcinPsE0nq60rZgZg2wsO2FiDb2w9k=;
  b=MQlN9YuOJCCDVy0LwOGTW1RVLZBCYJ9FKgKbTTstOQWeFDTcjax5n92E
   QuFIAjZb/bC+DTSY61hA1JwqEjN2fLk/z/Jws4rtAh7xWXJKJIHlysSKR
   EigY8PqRvzSMcLE95VaW9xDAZwyMoRDsrg/WUwqTErOs4TN1Es/2zMj17
   QHDYTsn9VTCPWWKI9f3Y/KT68g7r77sHr8sD2X3rkxQtH+Ee//8HOeimd
   Qn5po5jYyawmmZAS840IaRdPR7dR/Mey+6aYh3LKuGFznTnlkXZSjy1YJ
   jhNMcHjam+JaGihWbx6NTyT+W5UOVK+s8bpyw4bUNIJ01hWwwyTv/awbz
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10946"; a="4918841"
X-IronPort-AV: E=Sophos;i="6.04,340,1695711600"; 
   d="scan'208";a="4918841"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2024 02:00:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,340,1695711600"; 
   d="scan'208";a="15872558"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Jan 2024 02:00:43 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 8 Jan 2024 02:00:42 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 8 Jan 2024 02:00:42 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 8 Jan 2024 02:00:42 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 8 Jan 2024 02:00:42 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Thck3B+/EjSfVqav6i7ADNwp1AGNX8HfGZgqGlXwfb6vpXvrSBaUHuFA/J9g6JjKftnnCxwRaW//jCNkQucd3pGTMCL/8d+Bo+Tl6vBI9HyjcNrOkjEUoP8SMvY5NFoYiEni/tHl6KJLfBpoOVUljV3mHv3eJaCsQnpEt/S6anDnWTHQwXsalOTnNZ97tZpzqyfDk8indbRJ5Uop+CaFc1x17uRTxkiwuCyHOn3Ei/Aet+wSwBEBuMoHJVsXhhI6kEqnEDTnVzizi09ciEwu56NBkwHk5Y3f41zU1HvWp8iw82BLhOZm/mhmWKtAaEmx+4ZkJX18GIeUChCBv4AxwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cyNmBfGm4w0hqaf/q0V9JcAzScJYifLe/cmD5zu7/9U=;
 b=UGDJ9rb2iKiaWI2tBpf6A7ebH30VGfFKTLZdy6ObYXKa9FlZuNLtMxqbe745SinUJHexWzX9cF+zTCBlbZNd+mqjXo9AJeYgS91iRRVreux4g1v85DWehFXoYg9j1A+3UQeyDOg61bn+k/BvNUpAjo3CNs7KyihjcCEdDZ9ce7wmFoDB0T1uY0BfW6SNwWFM69d2pV7Sg7fgIm9jO5amyEABj2P/r+7//+V/eblqDZBaLnFZ920icup36A5m3rHZV+17qifdewUpeAnJw2xy4Rzq1zojaCpadI6VEr0E5g/IjHZ8z2OuqCDlkXbxTvfHQSCoRAAgFfbTuvAW1VusMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6392.namprd11.prod.outlook.com (2603:10b6:930:37::15)
 by SA2PR11MB5004.namprd11.prod.outlook.com (2603:10b6:806:112::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Mon, 8 Jan
 2024 10:00:40 +0000
Received: from CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::b99c:f603:f176:aca]) by CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::b99c:f603:f176:aca%5]) with mapi id 15.20.7159.020; Mon, 8 Jan 2024
 10:00:40 +0000
Date: Mon, 8 Jan 2024 17:56:22 +0800
From: Yujie Liu <yujie.liu@intel.com>
To: Linus Walleij <linus.walleij@linaro.org>
CC: kernel test robot <lkp@intel.com>, Arnd Bergmann <arnd@arndb.de>,
	<oe-kbuild-all@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: Re: arch/alpha/include/asm/core_t2.h:587:23: warning: no previous
 prototype for 't2_ioread64'
Message-ID: <ZZvGxhON7wNBgyg5@yujie-X299>
References: <202401061736.yM5FZ2oV-lkp@intel.com>
 <CACRpkdbx=qgdy1JRyxzFGW+8Ojj+g2tLKU4dD8oWX9V0xH2-JQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACRpkdbx=qgdy1JRyxzFGW+8Ojj+g2tLKU4dD8oWX9V0xH2-JQ@mail.gmail.com>
X-ClientProxiedBy: SG2PR06CA0236.apcprd06.prod.outlook.com
 (2603:1096:4:ac::20) To CY5PR11MB6392.namprd11.prod.outlook.com
 (2603:10b6:930:37::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6392:EE_|SA2PR11MB5004:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a04892c-562e-4c41-2006-08dc1030abcb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wd8Tsi7pC6AfssXNgAlcc4K5iWcMS0zeMG4bpRRwszlr44Wkq4/KHRAtV0J39HW41EtwmxIoLSkawj2dN+9E539p4Jc11rGzOw2sa7b6wfjrs7W8abpRc/wt73CwNEbYgF2EI965yKCrpfBYxKfnLef8cI5PNLe/sunKeOt+IpM3os7Utb8kJzT9RXPghP9rrdpCJIe9wuXAGTeSqTeArQxqhq2dvVITKa17FG+X3amrPCSucyExIuUsS/PCWZzmgfIZPji84MMcKYZJe8aE6rFSm2CLQFeQpbNWV61NoEzkotdKMrO0Y7qXaj8iPeP+xM5XT67ie22V6VfvSVcUhG2Jw4QXr6e1QXM5/n3MuW0/1x4Cgs4yuzSSOmUldT28KRaTuP2rumeUpy5NwsoeBfquJch+rECiIJTvxJdeFRGb8iOicCyOItB54qlNA39FWIR+Hqz/j7aGnqb+sNbEwmwFb4ZO/WI4hep82WMYp5UrWE30Bu+kK3G/Ch9kpn5y6+lWQDI19DqpstvHv4im3Zmzbx4FyFCnYy76g/r3BwB1M7UnXhOm83w0F8wyHFkE8/CsvnHc5FHcB3AYi8ln+o9s+jCvSn0ullFR5bJMcYbEaLFzovgVhkTMF5nSnabP
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(376002)(396003)(346002)(136003)(39860400002)(230922051799003)(230273577357003)(230173577357003)(64100799003)(451199024)(186009)(1800799012)(26005)(53546011)(9686003)(6666004)(6512007)(6506007)(478600001)(6486002)(966005)(38100700002)(86362001)(82960400001)(4744005)(2906002)(5660300002)(33716001)(41300700001)(83380400001)(66946007)(6916009)(8676002)(66556008)(66476007)(316002)(54906003)(4326008)(8936002)(44832011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dTY1ZlZDZmVnK01DMnRka3R6YmdpS0ZnL3RScDEycjdBVlB6aFZvS0cvTTdO?=
 =?utf-8?B?Z1k3ZzVBSnV5TFBQaWRNcTdCbStxc0FlcmpvSFZHSVo3OFNVdy9NWDJQNDhC?=
 =?utf-8?B?WVlYeXE0MzRRZDltRW1keEhUdlRPVGRqc252RjB1MnhaQS9UQUYyR2ttYzhZ?=
 =?utf-8?B?VnNOMElEamNOZWVyN2ljYUpCcG40U25aK0xrZVZwb0luRWJJQ2ZJemExeGdL?=
 =?utf-8?B?czl2ckFXUXVIblByVWNJOXlONnNueGtHZ25NbmhQNk9mU05Ock1tU09EeHZP?=
 =?utf-8?B?NlBVRTFzWG9mOU1CYjRIeWpDUTZ4WUU5dlFsWHVsQW93cG1VdE42SytVNUJZ?=
 =?utf-8?B?eFQySUtQTTR1d2liU2tvZmFVY2hVZzdEMFBRZUE2ZjYyeTE4dCtvS2pnUFkr?=
 =?utf-8?B?eGIwRysxdHl1czZJRTFoQ2EzNVVGeHRuVHNEclVPQkxGc3NZNzkvQWxERC90?=
 =?utf-8?B?dU5sK0xVQkZicmMxMDFFL09ib2wxYmpDNG5hcDQxeDVOS3ptYzhTRm53dVZ2?=
 =?utf-8?B?V0U5TXg3VW1neXNFajl5cGl1ZXdZOHVzY0laNW8zbWZoem1wSXNxRlI0ei9G?=
 =?utf-8?B?SVVhTWkyNGdCbUx3REs5YU9WRCtOU0VJMW83WHd4Tmx4eWxGUmIyRUc3VWpj?=
 =?utf-8?B?S09JYlVlelZpYXQwaHFNd0F1WlBua1AxeWFMVnJBRDR3SEI0Ykx2MWNjL1Vl?=
 =?utf-8?B?OFgzY3BOcWZIZGZ1SHpTWm80QWFKZTJyRzRPZklPRVgzU09JMzllZUI5QWpm?=
 =?utf-8?B?S2FZK01rVWJ3U0ZMUjREaUtJTXU0YWhqK2JwQmhWWHpxZ3JmSy80WFdZMUY1?=
 =?utf-8?B?K0NBN0ZIMW1iVVVRVmNzdjVudGtlZ1RoOGkrNCtiN2FMRjFvNkFvUHZjZVZq?=
 =?utf-8?B?OSt0L0lCM204T3daem1XUTRwREpoL2xVN0pKTGlYTzZaNS9HSXdXRUVldDQv?=
 =?utf-8?B?OU44ZkxvU3h5d2xUWHhCZmlTVGtYWk9odEJSbmFmNEtsZUdiWWYwS0VWVEZU?=
 =?utf-8?B?RFo5M290NDBIcDlwTzRHT0xoZkQrcms1UFpUQ2FJMW53NlFWbkF0L3ZkNUV6?=
 =?utf-8?B?c1N5K0N6dUM4UVZHbnN3eTl2UG5tQndXRnFWYy9XUHMxcXZHTVd5SmtTN1o1?=
 =?utf-8?B?SHpJRVFyL0xWZ0NVT0s1RFB3Mi9mWTBqVEJUQzd3eXZnTUsvc2xDQ2dwcVVC?=
 =?utf-8?B?Wmt4TWNIWTluN1lJMFhFQmdVOExUbGZGYWYyS2VaTFhpN3JuQUJGcms5eTlm?=
 =?utf-8?B?bFR3bVZsczVEbmlNVkhVS0Rla2NERi80YS9hNDNpQWNrRTZLUVVSVjJnMnA0?=
 =?utf-8?B?TThBdXJpczVJcXBmSGN1Vi9UQm5DVXI5WFNkb1h2aGVSTy9GSE54WjM1QVo0?=
 =?utf-8?B?dHNiV0Q2YmJreUoycklYbWdHVFMyTHB0SC85YXNoeEdsTXhHQlZUTGUrcnNK?=
 =?utf-8?B?a2QzTUN4dmZKK2NyaWxzS0pTbXpGVWJDVzZneG1WR0MzMko5MTgxa2luSkc4?=
 =?utf-8?B?eHg4ZE5zTHBOYzAwdHZzdi80T0RPRCs0OVQ1RkZKMTJVLzhTWVVxbnpON3oz?=
 =?utf-8?B?Q01iS292SmNVRDU2ZU05K29PTXZjYXpJSEYza1VJMWxwcXZlNStGaFRQdlpV?=
 =?utf-8?B?YUdXSFlTWlJHdmhuanYzTTc2cTcrZzZjbkQyNk1KZWFyOVlXaTVEQnJ2MW5T?=
 =?utf-8?B?MkxhYUg5MjFDNkZIb1pXQ29pWHMrdTVEWWRpaHo1SmhVZ0RBYTZWczR1elM3?=
 =?utf-8?B?bEIweTZMcDFpRW1CV1J4eHpwWUtla2xobThCTldDMUlMWWxXbXk0RFpwMnFH?=
 =?utf-8?B?WTRxTXRkK3FtQStQajhBWkh4akk3QUhGYm11V0pZOWlKNWdaWmh3TXpOM1p3?=
 =?utf-8?B?NDM3N3gyQ2pQaGJmSDYzODJDZEdCOGYreURnRUpvWVJZVXVXMW0rTUJQWGdi?=
 =?utf-8?B?Z2VsNElEWHZwQ0pXNkhYSkJYSmlIQ0l1M1FaaHFxSDZWQmFKQm9BM3JaN2Zo?=
 =?utf-8?B?ZENyTTU0ejlVY2ZKekdOTitscmplNzZKSHRvQ2IwT0tJUE05bDRiQyttRlhE?=
 =?utf-8?B?amV0VXNyUU1JdExOWGQxVVQ0anpvR0J3QUJ2dkxrZVZYU2trTkRTNi9UeSta?=
 =?utf-8?Q?m94c/ggKhSI/dhpaAUr2UxUl2?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a04892c-562e-4c41-2006-08dc1030abcb
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2024 10:00:40.7679
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YmKDMwEaHqHqHGX9xKBw5r8QMZcI9gTvzTurPtHNE5nCMIkh6cWkspu6D94xbleJDp2MbrtMp+9CpoVWq7uQ0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5004
X-OriginatorOrg: intel.com

Hi Linus Walleij,

On Sun, Jan 07, 2024 at 09:09:21PM +0100, Linus Walleij wrote:
> Hi robot,
> 
> On Sat, Jan 6, 2024 at 10:40 AM kernel test robot <lkp@intel.com> wrote:
> 
> 
> > Hi Arnd,
> >
> > FYI, the error/warning still remains.
> 
> FYI I have already said I can't reproduce this at all. Not using
> allnoconfig, not using the .config attached to the report.
> 
> I have no idea what this is.

We double checked this, and looks like it needs to be reproduced by
"make W=1". Could you please recheck with W=1?

The following link has some hints of handling W=1 warnings:

https://github.com/intel/lkp-tests/wiki/LKP-FAQ#how-is-one-meant-to-act-on-w1-reports-like--wmissing-prototypes

Please kindly let us know if you'd like to ignore these W=1 warnings,
and we will configure the bot for you to avoid further bothering.

Thanks,
Yujie

