Return-Path: <linux-kernel+bounces-4493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76950817E2B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 00:31:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03B331F2260A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 23:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 036D479951;
	Mon, 18 Dec 2023 23:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nIuRhlpp"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BCB4768F1;
	Mon, 18 Dec 2023 23:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702942222; x=1734478222;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=5XrCKWsmVc8m9qYQ4TLW8aSZFhesHdF71pb1hK9HZD0=;
  b=nIuRhlppdX2dcS4qETfbbxhbUoDFSCectf+nzA9NorBpVFNQRsW7Udwh
   loDdtSSrDjVUwAsB7P2LT0pC01nwPjyXVdMjkd+Wz1iPpi1aWOtbY19pt
   r+qZ91GSTihs/9w0sbbaiWQFMnWuz4U4IDT/Cd9yAbn2qKlTKtoC/sKru
   7pWRO3XJ8fwjMkWPiDEXDuZoxGAa0PZgbYp1q6PHu/+M1/6G5k7OUi/KX
   q1MfkY/sYWEN+O1kJa4Exx3b+b7kMwTI6mNWGqBrKhmmWL2IAcakijfU+
   fiSs1rUQN8BJ9pRyYoLR3h05fcK5vTGFESdGavb6oRvF0mIyq0Nld/DFz
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="17136923"
X-IronPort-AV: E=Sophos;i="6.04,286,1695711600"; 
   d="scan'208";a="17136923"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2023 15:30:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="1107135427"
X-IronPort-AV: E=Sophos;i="6.04,286,1695711600"; 
   d="scan'208";a="1107135427"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Dec 2023 15:30:20 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 18 Dec 2023 15:30:20 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 18 Dec 2023 15:30:20 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 18 Dec 2023 15:30:19 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V9RIS9BgXbPXS3x8Lud7Fr+nOhvIkDBvI/Kmv0HVbO0sNYEoyagejO6l2fNju392hPUHBA8RVIZNZlyyYGqobdMi/dl8BNyPzm6vF8UEuGPnaq0Fm/M599GGlBYSb/+ZcWIgCFeOr8ii0rVhag3ZJx7uBofZ7S8L5qKaRdafyFs2W33+R3SAMdEbhGV2wcxHWDjHoOzQf1RfIkX044v0xnxNpCOWFJ30k2PdtvwxuAV2932F5CMDn/Nn66wOiLv4YBKsyGZi4Oe2J/8w+E4H4/aclWCrs+R39xJ86MXT5ZgVBWvEgJYJnakORyFtasn/OuotBYvy17vSHgR6AOvp1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qso8TZiGRn8YqSXcsVDQUBk/iSvPfvc89Ub5F5G2XNk=;
 b=MTihklOb+p+IsOb/1J7nsrwv61Fez4UNOvXtkfB0zkKSQPtk3EYeIHcTZeq8b2tHJKFuxEfY9eeO8fGlJvbmNNJIfN3xZ9QuTXRIOI1WTnutRF5aGeO+dq3XczK/zQeoZ70UTg9CfzYitkPLJ/9harwtSEaruMe4hM+G8dEFkZIH+j5hqdae6CdWK0VjhwqsTX0CTubG7DIGRKNqz74bbUpIrUl/jz/Gcv5QitKYlAsxCDBbB7wKFylwf3D8HudlOrVS5BQEo2sCf8Qm3dJ/mlZ8K8dKEONkWZeD1sxQtuL3A85ZboqdZELj04cX4W5XJKq03VxGbsaDyn1DpdnFOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by BL3PR11MB6531.namprd11.prod.outlook.com (2603:10b6:208:38e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.37; Mon, 18 Dec
 2023 23:30:17 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6362:763e:f84b:4169]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6362:763e:f84b:4169%5]) with mapi id 15.20.7091.034; Mon, 18 Dec 2023
 23:30:17 +0000
Date: Mon, 18 Dec 2023 15:30:14 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Ira Weiny <ira.weiny@intel.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>
CC: Fan Ni <nifan.cxl@gmail.com>, Dave Jiang <dave.jiang@intel.com>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Huai-Cheng Kuo
	<hchkuo@avery-design.com.tw>
Subject: Re: [PATCH v2 2/2] cxl/cdat: Fix header sum value in CDAT checksum
Message-ID: <6580d606467d1_715492946@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20231117-fix-cdat-cs-v2-0-715399976d4d@intel.com>
 <20231117-fix-cdat-cs-v2-2-715399976d4d@intel.com>
 <20231218123339.000024fc@Huawei.com>
 <6580d26a74294_1bbb129489@iweiny-mobl.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <6580d26a74294_1bbb129489@iweiny-mobl.notmuch>
X-ClientProxiedBy: MW4PR03CA0250.namprd03.prod.outlook.com
 (2603:10b6:303:b4::15) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|BL3PR11MB6531:EE_
X-MS-Office365-Filtering-Correlation-Id: 533ed1e2-ddce-44a0-169f-08dc00214af2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dSem/ce934DS0M9vvYdMwsz6o0qKjtmxfYY6jhFzFD1GLXarScLYyxzYq4kyhnPI85GVnFVhMSWfPoKllohxUVCBQ7g0MnUdpke4Tlf9lP+m5Nq1Itn//byuXkhd+hInK3bb4kYgsnCDCFq2fZTqXCEn6lXaGaRw928zti4OFP2Bx2fip78GFuDSHTALytvuTZEhn2Iv/sVY+kUW0BpLabCaJK6xSB2kvhPrnlMRShtiiimkKn6QSrPqV/U5f94ULWYct26hjsKPUjMeJUavnD6AMoZmaa1EpzaMkIuYxguRDVzrvaRo+TVXJg4tGEvDFKwafjMGTwZXh1Q1Lv9vNz5qkV2GHannTGLFwFa8wxBahBnjAOWyRePTxTvW6M5wO/XKuSYVnZdPlii3swK8IWvnpo1VEXhfTjEvjxFKq5oY/2VMEi2LKI6wln0NFYxTTm/j6t4SC2z0eksrP6p3QHDyZ581DCJPdn6jmzCYY42NNng/oj/C0XRtUGb0H4Ex+sD3H62UjFRUdSQQtSLmcZZddPPxND4V+BTnclM2K/G0nCQ0K4QoMa/d6yEqZCNp6/JK60zgQ9hFr0Aznhxc5+oJeosYcFkaC8zvVtWsXYc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(346002)(136003)(366004)(376002)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(26005)(66946007)(41300700001)(4326008)(38100700002)(966005)(316002)(8936002)(5660300002)(8676002)(66556008)(478600001)(9686003)(6486002)(66476007)(6666004)(6512007)(2906002)(6506007)(54906003)(110136005)(86362001)(82960400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?z6WzPPdDywrCT51SNpYquEfD7m2ndHCbBzj/fIu1yPCUL5wenwTXfMnnH80z?=
 =?us-ascii?Q?jU8SKW3OR2jFpcXUhGtJFYjA14cgaymJzTleK6UIgGJ3pCQvCEaECaLq8uaR?=
 =?us-ascii?Q?3JT+NTzTbivFIWrJgjF6EA1UTyiPj8umwt6W62Ic8OKDF9mddXq7hyAV6PBG?=
 =?us-ascii?Q?Pghfa54KYjV97eAZnlw+CV8H2ImPMYZHx410nQHpt/5zcZ3jJofbFr6rvxya?=
 =?us-ascii?Q?6grEy/58y1AJ8OQmQtRCDQ9HuUFEGmItDEyKYkaRb/JBoTpGWvkPrP8/h+Xk?=
 =?us-ascii?Q?0aF/yr/aaJ4C+I4Xvx29xDOGwcsw/NrzejXgrgIBqXRa1ov4kALXsb8YB0De?=
 =?us-ascii?Q?m072H0bPwzcpKLJObw5DdWFQMIlGKWya+ZOM0iLJU9Vo6Bs8KG0RY3N4+xHH?=
 =?us-ascii?Q?3PHE0e6yWB15cvQf7b+grOai7STqnvxE6JfmgEdwBiNPK8qfdUWU0kuBwdLD?=
 =?us-ascii?Q?x+uyrU0viP7GjcBqKghvrTX1a0dbORrARr3Vo8rc1c0bIHTsXqfrZ1DTp9au?=
 =?us-ascii?Q?8e9kEukvO0rVSDe8mLCGSDO7GsZ7r0f05R+NaL7suMD5AsXu6BKZxz7GvEW7?=
 =?us-ascii?Q?nBHjba9mxD8JeW/clJZxcsFZz2xZ8+Hk08C2gQwxxRlPiHWaJWUhzxgYrnYe?=
 =?us-ascii?Q?M0JoLNLcre9qYFsgmr+b2bDnpBqB8XWj50xBfCn6KSZ9aiVZCY3jA3sMOrcU?=
 =?us-ascii?Q?Ytwgaq+2zy2UCKEfrWVymV3YPYByf+Ae2+O0T6VDCdxOhdx+TPyIl4BF/84g?=
 =?us-ascii?Q?HfgNRnqv/WtlwQJVysQkr7No+T2SUtonP5DXhHn4yqr30S4MhzUR35CDWYd9?=
 =?us-ascii?Q?OeFyGvlderG7GwV75g2iESOblP/jTox+4JFshxLfdJ4zsKlF8LbqVHkcW0kz?=
 =?us-ascii?Q?/8AAyR6C0aCWWUhmR8FgfJ91jIrXueE4NHPltgriVY3ihT6Ix6UEiDirZzdm?=
 =?us-ascii?Q?3909NxVir1l5ebmS5iwZfXrhJo4Ca3soFV/HAwW72Y048fnt9txBzLfL3Y8d?=
 =?us-ascii?Q?7G3hA0v62VO1XtoZOfpVXEGdDUOI2o0k9GMXk14iEPaBv7gHgzyQIsgzKFSd?=
 =?us-ascii?Q?T7wqSeOQ7TLc7iRaPlB/OEQoeQe3OC1hnsE7qbw+NHLf+eYEC67TG/UVAjQb?=
 =?us-ascii?Q?j1HiLeDomVfcRPijiB2GXaDP24TSEPEjcjI+xABCIagG0gdxSJGVS2Z+B1m0?=
 =?us-ascii?Q?hwStKIEkYuJOkX7jXMG4MwIZz/4mjLSpHWvuIEa8CuQlEHdw9ntc1GCW6oi1?=
 =?us-ascii?Q?ZExwI/7NtweFhDL0RB/lxphjCxWGotsROOEO5SIjO/CXZy2sFKjvHsezHPsG?=
 =?us-ascii?Q?He9xfhb4J0Gn/XxRQKaQNqiwMYDIwVrM81MeOobr5Y5JE7tE6TBP9TH2M8Up?=
 =?us-ascii?Q?vYY7COSBTy24F9B6maDyiI+BBfd6DLAj5QwDhEfJTszfjl+5Y4lzzODtD9zI?=
 =?us-ascii?Q?zmDDlvjGbztEqtG1BRpTrQWDbKzga5m31Rads6WVw//zTnwGJJ6JbYbzBQMf?=
 =?us-ascii?Q?mo/OdLQJbK2WQr3+cgACTrtk7C3FfvhAzggnAdbWdtlnPRpKXA0BiKHbOYGA?=
 =?us-ascii?Q?nt0yR7LBgEYvLyODCPtWzGakuEMnRR1/nHpUg/GYbf1YXKqaZr85GdNiZc+x?=
 =?us-ascii?Q?Jg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 533ed1e2-ddce-44a0-169f-08dc00214af2
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2023 23:30:17.2710
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HqmoaKy/ufZvDG1wcFUy/P0reO+hOgXFyKOu7oXXuo4a1dlXv1UyD03BH6Fx2d4aQIHev7XMqV42G5zaNhWUwkYAmM47bft7+2a1fb4+MZg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6531
X-OriginatorOrg: intel.com

Ira Weiny wrote:
> Jonathan Cameron wrote:
> > On Wed, 29 Nov 2023 17:33:04 -0800
> > Ira Weiny <ira.weiny@intel.com> wrote:
> > 
> 
> [snip]
> 
> > > [1] https://lore.kernel.org/all/20231116-fix-cdat-devm-free-v1-1-b148b40707d7@intel.com/
> > > 
> > > Fixes: aba578bdace5 ("hw/cxl/cdat: CXL CDAT Data Object Exchange implementation")
> > > Cc: Huai-Cheng Kuo <hchkuo@avery-design.com.tw>
> > > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > 
> > This only becomes a problem with the addition of DCDs so I'm not going to rush it in.
> 
> That makes sense.
> 
> > Btw cc qemu-devel on qemu patches!
> > 
> 
> Ah...  yea my bad.

Might I also ask for a more prominent way to quickly identify kernel vs
qemu patches, like a "[QEMU PATCH]" prefix? I tend to look for "hw/" in
the diff path names, but the kernel vs qemu question is ambiguous when
looking at the linux-cxl Patchwork queue.

@Jonathan, what do you think of having the kernel patchwork-bot watch
your tree for updating patch state (if it is not happening already).

