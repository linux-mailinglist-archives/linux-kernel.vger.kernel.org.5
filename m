Return-Path: <linux-kernel+bounces-14759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EF718221B2
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 20:06:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F3B81C22701
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 19:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 354AB15AEA;
	Tue,  2 Jan 2024 19:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RYqNlRB5"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AA1415ACB;
	Tue,  2 Jan 2024 19:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704222352; x=1735758352;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=mBWA13YDeQ6OvOZULGq30UFb0zF3N6i1j6wr2oPPs54=;
  b=RYqNlRB5A9QYnwOh+nFVHpPaXWDmtbZtAzGKb8hkha5lu864a4H2pe5e
   TMSVey+NzWnvvZxC64Dy8Gi36tSNTpfa9sj3FRJP1HFirPLsvimkZxyOG
   evsc07nOzOTqBCR+agfTMKRKB/UZalP3e4brWxmDTwXwLlcA6AkQZbAGT
   LyT1FmpWchslQqcS41i+hPDISr2DEGvehOyOaX9Bl4I8e2GTscdIBsFoX
   0ClnYL7JK2yEJHpVAyV7iXkUrVtijnUrvi/FnHBfwhxXMJOktrxHAl7/k
   y9XGjr5dkxsPCqHh0JrbGnHGDS5IaVwdxEyQSO8KQqYui592zIfY/caKY
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10941"; a="376400556"
X-IronPort-AV: E=Sophos;i="6.04,325,1695711600"; 
   d="scan'208";a="376400556"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2024 11:05:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10941"; a="923296281"
X-IronPort-AV: E=Sophos;i="6.04,325,1695711600"; 
   d="scan'208";a="923296281"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Jan 2024 11:05:48 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 2 Jan 2024 11:05:48 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 2 Jan 2024 11:05:47 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 2 Jan 2024 11:05:47 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 2 Jan 2024 11:05:47 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VeQdZ04ViakVqSVhB5LxsyZkECT/krYxCR7gMulm/tY78q4OEp6Aa7EcO19FUZMTDb1FZvl3niR10RBqbrrp5XTRJMaTInWjNVjrBFRTWEhMWTIpalZ3tGfutZ68bYS/weLfKPi0xW5HG0qS+HETg3Gg7IsaIFEe53feCtuRjm55plIH9E7FqL+qSy+k+svcMyu09E144HIn2wWUjqMGkNDiV9J+FVgBG2s6g/WIaf+NH+uMIwRZ6X15xzCsbQE8TP8MsRMaUX4wA1ZERcdWoVg3WAZSmCH8bXD4Wm8HXKadr63Vs8uoOklwn2QOGIw1fGcX17/CEQyHZCLH0YKRNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Rc+tC0RBaNvjEMNQLhWkazUaCewvtwatK/SXdYNu9I=;
 b=Z4ErK01GBos2vySBUe4SWmCFfEayUgNZex+tzISnk1EC9Eo5rBFvlYnRFlEhw51CV86ezWq+DMiGMb3SG1omCBX4GD5WtMDUg2phmCD489BwhhX+1sKu3Iksku24jycrsnV0KCgePfl2rL1rzV2fUoNzwsxnKFn06LN0J+noS9ajahD8nyitxAIe8RIu9FyX+clE6MTwjgpwygqAD7OXG7Rtf+XB88iQvbkXgqEyAydvrw1ZybT1rOWa57JGZSo8tN2Yk7GiOFAK/2sKPW80XuDrp3pu3u498JfIYV6WoEPlC9hWH5seA2dU+UAMb3fzCobaiKN6yE5LiUAP/cGPzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DS0PR11MB8687.namprd11.prod.outlook.com (2603:10b6:8:1be::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Tue, 2 Jan
 2024 19:05:45 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2%4]) with mapi id 15.20.7135.023; Tue, 2 Jan 2024
 19:05:45 +0000
Date: Tue, 2 Jan 2024 11:05:41 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Randy Dunlap <rdunlap@infradead.org>, <linux-kernel@vger.kernel.org>
CC: Randy Dunlap <rdunlap@infradead.org>, Fan Ni <fan.ni@samsung.com>,
	Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>, "Alison
 Schofield" <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>
Subject: RE: [PATCH] cxl/region: use %pap format to print resource_size_t
Message-ID: <65945e8583d5e_8dc6829487@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240102173917.19718-1-rdunlap@infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240102173917.19718-1-rdunlap@infradead.org>
X-ClientProxiedBy: MW4PR04CA0288.namprd04.prod.outlook.com
 (2603:10b6:303:89::23) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DS0PR11MB8687:EE_
X-MS-Office365-Filtering-Correlation-Id: 208af6af-f37d-484d-76fd-08dc0bc5d2b7
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fUDvVXjTyKAANqqp3SuNocNXUGnZK3arOo+bjm5hSEe/y6ZJnnJFykA4/7W1+v8tBBQuFnSkBaePGR3IkBsTu0zp2S2EV+cRJvzEP8Rpqnp5ZYJCMIf1i/fhmMGQDlcSZFdD22db69NGO00PblT3HZ3qmZDXPWe4ifM9PM1+MLgPGfVgKk1wYAyg0vlWRlW0aQYDyJ55+M7xCCaX8oWwP/0IB/Zc7sBR/2sic4uoetD7xwXwF8EkQuSxlrZASyunUPMnoRkPiFOpPrhRQXz15kdtke2i0CE5SNLYljnQujV9nEQaHYJ4YSarek48YJJs9PILV4wRzJHAtxRtiStoCQzAgOHmR2yEbaVkbbHyvncFHCgeDNfSDKKpFVpFK9pvEgVPYysq5NrZvCHWHzvioDm1T69i/po8gxMEb8ed7po2A772DteqOBzZ9hwVXRnaz3Vw4FQr5bwFu3ShZbd2Kc+IhdMagPnfCzYc6kz/KvR9wnjARzOik3J8Fpnwq7Y/c6Do2HDpjZe+4jfZMTEayZ9W21/gOOr1+N2EkxiQvBvE6qP9ysTvfpZ/SgBYP4fsub7hjtq/t10ER4sqovxkh3VV/WtZIf5coulHu/dpm9LHiUzPynOc6PQL+46uv0ff
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(346002)(396003)(136003)(39860400002)(230173577357003)(230273577357003)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(478600001)(66556008)(6506007)(9686003)(66476007)(6486002)(6512007)(86362001)(66946007)(82960400001)(38100700002)(26005)(4326008)(2906002)(83380400001)(41300700001)(6666004)(8676002)(316002)(54906003)(5660300002)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8Ffhf91+FOAykFRmspbkKpijs1OKU93uzSopUOPx/Jq/dv5TSU1P/9m9MGQR?=
 =?us-ascii?Q?CGyWVdOohK7rz06gSHfhSv+6lh51hguHqTp2mwBORsESPusnF/uBA1X+voiW?=
 =?us-ascii?Q?F6evhJGuICnItabYRi2rqRK8+dMYxUltLhi/Y4r5+KE8JpGco0JY3MWttzJU?=
 =?us-ascii?Q?UaowIOFpSrQshW3B7C9qmHujBVX1EQS3RoTiRPIXWCB7yBkMtE5A8xyt2HfP?=
 =?us-ascii?Q?IkRe8eu5Qw56lsJ4oYQRMNV/zFVCTrrE0Hj9ge5k2OVAlMHsbqLccPROjCe0?=
 =?us-ascii?Q?cAM7f212Ut59msk3NOQB6zhhbmmjkpo+WRSJLoIxDNFdus8cTMPbt9QHcR87?=
 =?us-ascii?Q?954CYSSn3GW3Ej/C1Ty1Qx/m+6PlN0RmWk46dxpw6Kjy3b2yP/j2NzREbA/p?=
 =?us-ascii?Q?OfrfjIKVl8qivmwSNgKTetTJymwWB8/yamyNXIR21Je79Dx358LrkcqvauO+?=
 =?us-ascii?Q?UK3BKb36ZX4SMpFLzRJT4LyWJYw2DvY9ZNysF5jBpFELzdDLui1hdftWkduv?=
 =?us-ascii?Q?PGmBsEA7Y9cQH4wNrEVXKNaWdnWI+Vzg2mxYJykv5ov9tq8+RP4LzHjJJzhV?=
 =?us-ascii?Q?qO+nfB5AWs589LBsrR3D+op9bngS82J6hzpJFwyEKDBIf0h7hT3KXGytPEiA?=
 =?us-ascii?Q?1D5U6DF79yGCjSFLJcE3vJ8/X6SjRACQXO2iMT8POyBzqb1kxGtdeQDcPvq8?=
 =?us-ascii?Q?d5kgQ97G2hCYO5X0N5E3rhtcf8LbioaE27NWTNLYtMm/UPxFrygjMSfVdBvO?=
 =?us-ascii?Q?1EWF+Cmn2eMukSz4zawinFt8c4KtaH7xzxy5Pk4p6fCpgTS+dEIgNB+7tz5q?=
 =?us-ascii?Q?Vtd6aDq75LuPVMaE4LD7aOURHoJ58e1lSVnwvOMVR9ex4rF7bYNwls9hYQA0?=
 =?us-ascii?Q?Gj+h4/B/b/iDAT5bW8PcBaKisk9uT+LDeAGIeLKBSe+HBOqLLyERMpiIoJmq?=
 =?us-ascii?Q?WxZjxEzjLTrYnC7a2w5lTdpbyqqztrkIt1MPFHUpdfYWwnKiTQma6X1n1dB8?=
 =?us-ascii?Q?ShU39RYn1aKTkymtyzVnYzlGsUnrO0Rsjs3D22XI8CS3W67EvUT+poYWIh3j?=
 =?us-ascii?Q?N5ptEgxxbIL7bDk5ZZArCoM+VOBYww36D4b+d0xZ/AY274al6Q5GYnkQjkQy?=
 =?us-ascii?Q?2N32+Q3rDbyPrsZHY9zx/j4ro1eGsiophOLTxAp3Kt+BAvwLSbWT23JDYH4+?=
 =?us-ascii?Q?+NIEbdG9TtouVfFh4eVLR9LQWuCZ/X2OH8J8/0H2epYe5j/HV3X+aQcyq/SZ?=
 =?us-ascii?Q?Obe+cT2vm9HR4uvDzg/KibOR/8dFHEzPxoyAYHcCFxM5Zc3TDIdQNGvcNlHW?=
 =?us-ascii?Q?ScusJm+et28w3qB+TmfUveaOSXysgLq/hCrv0crZl5oHmcWf5WxdWh8IIsyY?=
 =?us-ascii?Q?yUagqfBsKohraFRQr9sMwAnqsaE9BiFXZIBWuAkGkRgtnkKSBOxERXam/SzS?=
 =?us-ascii?Q?ciuAuFrCqzCd+L0SifcYI3Xdjn/a8m1vqx2lWczR9ONtIvAhvtzM8BnKXNGg?=
 =?us-ascii?Q?qxg0m1Nsl0wCFT0t1uRRBolKrX5hogmeYIr4fI0A3OJiEO/s4LGECcmlP3ej?=
 =?us-ascii?Q?tNHDkF3faIISxKMpWHoRJvSAXNKDec0Pbua9ZL9rbASn4Le5RxhTlaDG7nRp?=
 =?us-ascii?Q?Yg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 208af6af-f37d-484d-76fd-08dc0bc5d2b7
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2024 19:05:45.3721
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rpLqGOXMLrKCzHMo4GNNLwm6ZbU5lX1H5b3xiclxd2lMVtnz1VkRVjyB1E0n+NZP9iUPzlDnX3W3Q2p5UyNpkdx1oFT//1j+es7EreJiHxM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8687
X-OriginatorOrg: intel.com

Randy Dunlap wrote:
> Use "%pap" to print a resource_size_t (phys_addr_t derived type)
> to prevent build warnings on 32-bit arches (seen on i386 and
> riscv-32).
> 
> ../drivers/cxl/core/region.c: In function 'alloc_hpa':
> ../drivers/cxl/core/region.c:556:25: warning: format '%llx' expects argument of type 'long long unsigned int', but argument 5 has type 'resource_size_t' {aka 'unsigned int'} [-Wformat=]
>   556 |                         "HPA allocation error (%ld) for size:%#llx in %s %pr\n",
> 
> Fixes: 7984d22f1315 ("cxl/region: Add dev_dbg() detail on failure to allocate HPA space")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Fan Ni <fan.ni@samsung.com>
> Cc: Davidlohr Bueso <dave@stgolabs.net>
> Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Alison Schofield <alison.schofield@intel.com>
> Cc: Vishal Verma <vishal.l.verma@intel.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: linux-cxl@vger.kernel.org
> ---
>  drivers/cxl/core/region.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied, thanks Randy.

