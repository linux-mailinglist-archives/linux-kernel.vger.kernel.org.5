Return-Path: <linux-kernel+bounces-12513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D095F81F5F3
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 09:31:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00C4F1C227DF
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 08:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA03D63AB;
	Thu, 28 Dec 2023 08:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Hw7o0Lu9"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 778AD15B3;
	Thu, 28 Dec 2023 08:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703752253; x=1735288253;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=gmwumE3/01uRqBfQOKd+iMXqqji8zcxeyXn/0Y92BpM=;
  b=Hw7o0Lu9alP5RghlvoLpOs3mi5EzfMli5AcTXOucf6F2k18e8G0Vnjw4
   cuI/S1v0ubotI2wbO9enQNXhqhBiKAghTLn+FJOcrUZ8nCbE4J2aMbZeH
   654jYbIt4iJC/q+wJ5ilSS6CCZkUdVjMQkBqd43DC/a9NTPTeOjpAoQJq
   5bZ4TvqBnmCjIDtjNcioQxC4ih4R1U4Ei/oPG76i4i9L6IQSgHmERQymP
   pep0jWXf0qCHUAx5dxZ1YbtllrLP68HBEPD/ZGxHOTuKP7utPiHsFi9tK
   oRHrfJfMyEns8oV/Lrp4fUXLf9QxQY2CG0BaYuIOHB3QS4szNywZsmmMK
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10936"; a="376013594"
X-IronPort-AV: E=Sophos;i="6.04,311,1695711600"; 
   d="scan'208";a="376013594"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2023 00:30:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10936"; a="754684483"
X-IronPort-AV: E=Sophos;i="6.04,311,1695711600"; 
   d="scan'208";a="754684483"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Dec 2023 00:30:39 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 28 Dec 2023 00:30:38 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 28 Dec 2023 00:30:38 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 28 Dec 2023 00:30:38 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 28 Dec 2023 00:30:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kHStB4HoKY7pn/sY69D7f3Mw3r8UcNI0z+BSgUzMBnA/TORa8uySvw8DYhrLvKEUCcnV/w+05H5QI2EV/wsj7b1W7U11VAnBSZNsx9qbeVFeonV70QdTtKsHdDkfAo1Bo2wKcw0fe/g19slk2vxc6UPng1NQp15g8BhVfEDRDY9t6Dv2ZsgNOAoe31Gnh3iIT/55koHziujSToBKaY7qjbOx5zpXxPgrFXzCNHC/f9mGf0A73TsC2JqsayjsOyMJn3CjHW88DTI3VqNXJIKZw66I1cV7xJM4OXyGkFvnEzFsFErRIlOfwtZpCpBTPWGCeZg7PkoDq5+6IEKxnjNgIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sq/My6RXglsvfq4z8gnAO2HYZTUwCaUNFoNDJNdu1qo=;
 b=OhoD/w3H38caR5Y+yQwFr7gHaESqg2it8Jsk6mRK8V+s4/XCoWHfVdInEHKdIu2li3MMpun9V/8jcb3g7sGg+jpWqB987bUNyLF2DRLmCYTADoh79HBRkOz5oTHxU3rCgnfY57Dxe0UWOgrIgpRtMMZWaH5Y+FEoAFzqaxvNGolw1DNgTZdAgC1PZKwhHF6pm2OHWaAhWPUBQE4UCwnrFZavnN8Puod96YnvG+ctEj3RVygob3izU+1MEiezdszg8ssMIuhifK1xaiBXcXtbuH53n8UnEPEIaOq27P3dV/SPzsmtqvxdnEBuOcV2K3QhAq26fgihVtrZy4ag0pwT6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL0PR11MB2995.namprd11.prod.outlook.com (2603:10b6:208:7a::28)
 by SN7PR11MB7668.namprd11.prod.outlook.com (2603:10b6:806:341::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.19; Thu, 28 Dec
 2023 08:30:35 +0000
Received: from BL0PR11MB2995.namprd11.prod.outlook.com
 ([fe80::2f1a:e62e:9fff:ae67]) by BL0PR11MB2995.namprd11.prod.outlook.com
 ([fe80::2f1a:e62e:9fff:ae67%5]) with mapi id 15.20.7113.027; Thu, 28 Dec 2023
 08:30:35 +0000
Date: Thu, 28 Dec 2023 16:30:25 +0800
From: kernel test robot <lkp@intel.com>
To: Allen_Lin <allencl_lin@hotmail.com>, <dmitry.torokhov@gmail.com>,
	<robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
	<conor+dt@kernel.org>, <jikos@kernel.org>, <benjamin.tissoires@redhat.com>,
	<linux-input@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <oe-kbuild-all@lists.linux.dev>, Allen_Lin <allencl_lin@hotmail.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: input: Add Himax HX83102J touchscreen
Message-ID: <ZY0yIVHXrQ17GqO3@rli9-mobl>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <SEZPR06MB56080820EE51CBAE9C6B6B3E9E9FA@SEZPR06MB5608.apcprd06.prod.outlook.com>
X-ClientProxiedBy: SG2PR04CA0170.apcprd04.prod.outlook.com (2603:1096:4::32)
 To BL0PR11MB2995.namprd11.prod.outlook.com (2603:10b6:208:7a::28)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR11MB2995:EE_|SN7PR11MB7668:EE_
X-MS-Office365-Filtering-Correlation-Id: a7727e35-ad71-4adb-2f1b-08dc077f4328
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tt8IjM1LjZ57aj8yqi7Abk63dtbgHlasagTepqK3V9MmeXRerPTFJH5/Q2/eyjvBGCJzOQvsjKA8qMs/GLGVLYqPtYj/56VOWMiofpL1QOI6Xz7B9zyaUzKqiXNiYVkp0aFBS/y/YLFgqWU+Hlk7FiMkl3Ng5WqsvEreMG8yYB76ifU6p4ib9ktgJReNRuarT7SE7qaP4w0Gh69cvarxgSN3lkrZ4/w/KMD/nNYt9uRlpG2aWA03LK6DAg8VMoMsCqOmO9Dx4mp0XhPBd5p9HtzyB9eSCSFPfyYtkXmganEcbuvohU0JohTFk1sybP6+xHzXrZWAM9qi1c2upZRCao3P8jkp/g+PYzq7M90uaBnlW/oRm0HYYUglLIMClpw7A6IYUwbiDpvy1nA+TgPBbdcGz/AIE18JCaceGg8BGV/ahxE/NfUqvuK6KlI9RdVNcNnZ+hdCZER6ZwhKk4tYoXJMaA5tqhjd1fesrUdUOroAYPZtL34gip5IXT+VOIPrzdt9abnA1lA1RXTILEGuM/x2gOs+VfF/RmzpQk2ozT8ZyA/j6aKpz8+cb+HK0EuY3GZE/QbFCIArycXuFXgzm6zY+M0Qu5oD6AgsYhmJgExv5VhpvcCx5bOun1tgJjo8iLVWM7xRhMdhuAfboP7szGlHMTmYieUNRmoo8lLtQww=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB2995.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(376002)(39860400002)(346002)(396003)(136003)(230273577357003)(230173577357003)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(921011)(4001150100001)(7416002)(2906002)(82960400001)(5660300002)(38100700002)(33716001)(86362001)(4326008)(8936002)(8676002)(41300700001)(316002)(66476007)(66556008)(66946007)(83380400001)(26005)(966005)(478600001)(6512007)(9686003)(6486002)(6506007)(6666004)(45080400002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?//ZGreE/uFl+9sBpgqkQAGq78YPc6FhZEDHrwIuWUMvKQEzDbLV3wYkWXB9/?=
 =?us-ascii?Q?dcmiMYBeVNzXWsxtvbrJmDm/IHUomnBNdQTp5M5Y+IZdcajh2z1naUNksGm0?=
 =?us-ascii?Q?WCMYnwUge5Xv6VaRUfPRneTt1tmmEK/70biuFP1UFYIoGDSuIdzXe9zOxIXl?=
 =?us-ascii?Q?GnQUN/Pgxf30kdd830Ibi25e6Z5OfosvruK5iu/w8ZYO5BZOiruXdVYKrW05?=
 =?us-ascii?Q?283JCRQneeR+rj2xesWMe2hXHxd7p0MgyGqCG4VkSkrypCYWy1mqrv9i4C9Q?=
 =?us-ascii?Q?SEeCm0vpZ/VHRdzr/IJyE58Ssp4qzFV7+fEUF/hYoiQWEi1AwAW48FrvUoL+?=
 =?us-ascii?Q?x/L4k+YFPITLXnJvL2+6xKxPTMIzsSwzRve/0uMU/kc0l10ogpxWZ3irCFY4?=
 =?us-ascii?Q?GcewtB+2kHv7KUhuZVnAm+BwHKse43BFpkZ2UgqU5j0ptuEcRiJjFD1Fd1dP?=
 =?us-ascii?Q?A7jN6b7/x6CgWMqs3rIhc/7fMstELBKOeuEe/RcqtagPqVVIqxJaqIsMlL2s?=
 =?us-ascii?Q?NTWLCTolRXaHjHydLai2R+zuCDBVmIz7e+SB/GCkPBuwz/wVyIMHFT0dxGQB?=
 =?us-ascii?Q?D3xTaqkA5kGCyDM6gd6MmqZA/ZzLjv3/2tRnehZ/53aiOJZtclVwrIEQgfZA?=
 =?us-ascii?Q?8IJh1lrAN7nph+wLQFsbtDkkHlRIW9Lk80IULUMuhsGzC0Njv8bBB+xfhxJA?=
 =?us-ascii?Q?4fBCqC2vMwHU8sO+6Ry/2++00WOzjDQ64U4v5q/OnLVzuLrhgjkzYjEpyP4u?=
 =?us-ascii?Q?PcKMy2cx5JTJPFQwLdHCipgqvscZsrRBr6R3vbm81QzcrOaochQCNbhffomf?=
 =?us-ascii?Q?ZOip5WGpZlbCtkps6LuQU7U4gFE5zB3xOubgUd6EtenJdCE4FnqvBYMwx4HI?=
 =?us-ascii?Q?qqPUBqCfhV2NUrTFhTDWuC7j7HMY7R6B1yr9Z0v7uuEQ97AfOUszHxukHB2U?=
 =?us-ascii?Q?VtmsPKR3Qit+B0pGXfhNiP/CCrac7HGASyzrbIFOmlyNoj5j3jzFuReVbjDQ?=
 =?us-ascii?Q?QpfkbNN+DFUPA9cgiikfhmYiezHGAwZUIZZEtpoACyp13k/BC4W8A7QajDi2?=
 =?us-ascii?Q?OBIDX3GxzfKocyMzqNL6nfSptf6CVQ++0KLKd42aHmV0yrYsDUqDIoIiINIx?=
 =?us-ascii?Q?01RjB/vSNdX8MzhtIylp2Gx8JEIUTg2dAUllWv67qUuBxwwQ7d2PzughvMj4?=
 =?us-ascii?Q?CfPRvaAtMZzSCiatSM6Yyx6WHiSxnRBqr4ErmgKyWf2Bx8RshMYl0Y39z3Om?=
 =?us-ascii?Q?iz7YWLBm9/hxRLZGh1aeQMkY86P1wn4BiBke0Q23JzmsC8BKPqh7q7KQsYeA?=
 =?us-ascii?Q?liBscKuJOzDhmhbOqMVl7wvauyd7nMnCrtBKWSFCs5tVG5SmuWmaENUhVA4s?=
 =?us-ascii?Q?3O0CnCvZBwGngD7Lz2x0hj/Cvp19d9UBNIgrRHmWMltIOj96lGvhUJRrnhP2?=
 =?us-ascii?Q?PQIBi2Rh/SpSKUFjQBEVk4N1Vm1/fYqzktKZCd8DruhouIDOUUZOJ2vp6eFY?=
 =?us-ascii?Q?1PxPqDf/vnhCYJMdLiD7mGEPv0RLut2U7V8OLZ/yBu+ckFgpl5nMMslPAiL7?=
 =?us-ascii?Q?1pF3J67dCirjSWvxUwPUu4LVrOEVQ4LysPahijWr?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a7727e35-ad71-4adb-2f1b-08dc077f4328
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB2995.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Dec 2023 08:30:35.4288
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OGOvIFiCQjSVwhwxvCqKCaR0ZnlbfdEBXsEUKbCGbvk9YiFGBvScDwGCCdxgM99FVzHxXQug54oMycJdezF07A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7668
X-OriginatorOrg: intel.com

Hi Allen_Lin,

kernel test robot noticed the following build warnings:

[auto build test WARNING on hid/for-next]
[also build test WARNING on dtor-input/next dtor-input/for-linus robh/for-next linus/master v6.7-rc7 next-20231222]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Allen_Lin/Input-Add-Himax-HX83102J-touchscreen-driver/20231227-133817
base:   https://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git for-next
patch link:    https://lore.kernel.org/r/SEZPR06MB56080820EE51CBAE9C6B6B3E9E9FA%40SEZPR06MB5608.apcprd06.prod.outlook.com
patch subject: [PATCH v3 1/2] dt-bindings: input: Add Himax HX83102J touchscreen
:::::: branch date: 19 hours ago
:::::: commit date: 19 hours ago
compiler: loongarch64-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231228/202312280837.b2PFmd9W-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/r/202312280837.b2PFmd9W-lkp@intel.com/

dtcheck warnings: (new ones prefixed by >>)
>> Documentation/devicetree/bindings/input/himax,hx83102j.yaml:1:58: [error] wrong new line character: expected \n (new-lines)

vim +1 Documentation/devicetree/bindings/input/himax,hx83102j.yaml

b6f7a8833439cc Allen_Lin 2023-12-27 @1  # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


