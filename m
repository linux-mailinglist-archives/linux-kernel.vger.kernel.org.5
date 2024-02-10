Return-Path: <linux-kernel+bounces-60389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E929850451
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 12:54:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5E611C21EA8
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 11:54:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41A013D554;
	Sat, 10 Feb 2024 11:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="goN7QKRz"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A1DD1D684
	for <linux-kernel@vger.kernel.org>; Sat, 10 Feb 2024 11:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707566076; cv=fail; b=q5DF57TSRvSVGs4PrlzvEA5LY1CNWA31F3UFB7+ux5dPEhoLJINkEFgKUcK+inE4qgd8yHaYyGJPtclMHRUbmAOb2kgmYrE38FL+Pit9LeJz0KB2VGe7yz919Ygm1jfHzSUVB8GOygfkTNBmJ0ULKGT/a6gzFBtr3XzlpU7JRgg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707566076; c=relaxed/simple;
	bh=7ozdvGA7cB5oubzBFANgnTEL+ZfkObEpwWx0zI4qQs0=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=j6/fY3ApWApGbxFbr6JCWpmADhSE7eumcZaHxz6rXGYoeIg5th56jLD27xyMIMIA7LUH+IJJavJX94lQQGMk4FX5FHjP5txaddyKHw6TFI/7JVzScx+EgxNFk84vEWvyLKPd/IfMHSOepuR8x8+4uw9qaxeGljnT2saTNGAL1YI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=goN7QKRz; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707566072; x=1739102072;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=7ozdvGA7cB5oubzBFANgnTEL+ZfkObEpwWx0zI4qQs0=;
  b=goN7QKRzGWUzwLBbwliQB6NcHLM1Xj0wHnu5N4pBUk9t4VNsPVMEx0ST
   XcZyrhKhcCiyVrA4uRC6w3wqLC5pWJIlUjX2ImkLP6ZUBbL2tesTZSKvj
   QflX3SrDxLzYdsM2wfmFkeYSPH9P1rn0oYREDmyiozBuieHYsufSy5tro
   M927DPeaWYbIe9F/N18CGpkHriqBLEZl0cGzNa6q/BswTCOYzXqtIodvp
   8qz28YxjMGjunQMMlkvuGsnCWDK3QOmwsjF1WrVhiZWfSeDSt6Ub4hBMs
   vKMHOAV29e5HKpE01ylauQyzPrk0SIBrQqz6PkJHS4QGVQZhOqnImFXzq
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10979"; a="1700638"
X-IronPort-AV: E=Sophos;i="6.05,259,1701158400"; 
   d="scan'208";a="1700638"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2024 03:54:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,259,1701158400"; 
   d="scan'208";a="39601827"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Feb 2024 03:54:32 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sat, 10 Feb 2024 03:54:32 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sat, 10 Feb 2024 03:54:32 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sat, 10 Feb 2024 03:54:31 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fdchwH+YNSzMak8i0rfS/3VK7oQs5ytePbvCm4PcMoT6eqTt6IWR132byAuI1D+vNPtxGEXE6cCbQQvqS5K+MoLAN2JHKWezNrblDuJbgnztlik3+FpipySw2h8z2DZfR5zqXLOhboINlljqDGszUq2Bs9+miCipwU1KFhIvjO4Jhlu9u2tIxFFZGSD0fk2CQQXoHO2QNQAbhNIr7pDEH4qfRiX+o60yaPyfTkLaIFqv+7KpCDN/1jqNHZJMwpV9j5rggNV5QJgXCkiImdMdNwLyXWnttJWNvROoTHMByXqFvz8NurajBa+GLRG1/C6ddsRN0rWgowQ0l+CXSlG8HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rP6DukFOCplskx42YW+R6BLq84jBqkfFSjpVrLE2RyE=;
 b=gZcIDsGouqFsqySG+fsASXDZVR2rtTKAPglou/kebsAW2cJwWbdqP4+4PHYCQ5lSM/Aso1261yh2VabxHI1lFyFi7Mossejhezdqe005SzHULHcNRb6NsVtPSg/0S6O2HkQswEZOyGMsrd6JZ7F8Ief2ymYdmnapgYxaad5O4MlBh9L0eIdjGGG1gYXBvncRO1KerQd2IRv9fzEISi1paRxmJQP3VGogAHaaS8VQIB7MF8ILJMsKTYzK02FoTmR1Ze60/FuHeuaHgycUQKc/CS4aTIokS08bYeODiJLCOQD/J6gq+8vj1vUU+R+ymb08fiVlupvGLQ87lP//1ueTZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB8414.namprd11.prod.outlook.com (2603:10b6:610:17e::19)
 by MW3PR11MB4553.namprd11.prod.outlook.com (2603:10b6:303:2c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.27; Sat, 10 Feb
 2024 11:54:29 +0000
Received: from CH3PR11MB8414.namprd11.prod.outlook.com
 ([fe80::ed34:4cf2:df58:f708]) by CH3PR11MB8414.namprd11.prod.outlook.com
 ([fe80::ed34:4cf2:df58:f708%4]) with mapi id 15.20.7270.033; Sat, 10 Feb 2024
 11:54:29 +0000
Date: Sat, 10 Feb 2024 19:54:21 +0800
From: kernel test robot <lkp@intel.com>
To: Herve Codina <herve.codina@bootlin.com>
CC: <oe-kbuild-all@lists.linux.dev>, <linux-kernel@vger.kernel.org>, "Mark
 Brown" <broonie@kernel.org>
Subject: drivers/soc/fsl/qe/qmc.c:1342:9: sparse: sparse: incorrect type in
 argument 1 (different address spaces)
Message-ID: <202402101716.yt6Z87ty-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SG2PR04CA0172.apcprd04.prod.outlook.com (2603:1096:4::34)
 To CH3PR11MB8414.namprd11.prod.outlook.com (2603:10b6:610:17e::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8414:EE_|MW3PR11MB4553:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a048bcd-876b-4190-c44a-08dc2a2f08fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2PGFg34aZPoG3511MUNF72R3frV4DwPX7kNdmcfJT0duYpowINLXUB+X+jrJGdgXxpX1OMuCuU1ihq9pByQjdqpJHeeTD3tj6j1xA+V+jQVn24x2mOyQXHKE7ssYMtsw+a3XBzM+9dWnHAuv+qhrhGQUO12Vv+5ZuVLthqKIdpa+rBj6Q7K+Hr/50iq2R+Qvn/KSfL3MIb4kQyy3UbopOcX7tZh9WHJA2eLLaqOBq/s/otS0IHe/OK7A7ejoSRQqe9isCGVH3fT7hJCna8fOidC2GUTgnaBFKJ5h6e0ZoUKKNaKXozeIZ2XLoEy3V1xg2bJLB+a+xznHJVRks5zeKdGL3CPLLEhEXWs6R3En9uwFk2Dj160/nyWsGPik6yLeZybbN8fPKORJ3dA1ZFe37CUSoHmlzo2WjoS5Z+PaPITIQ32X/ljdp6GWFUNldF0RmUCdqOUKhnOV8QhVVYYPTk+5iLZAasf1MPhy9GO16Ayl1wCLOeFSF0li3DN6Vk8nmGcjweOzsfT/HKQwJzHRQvYZqPIy8im3vKxE9QcCsm6/zoczDqED/9d3tJOMgU4B5ZN6pTdyTa+li1dFMWuBKg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8414.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(366004)(346002)(396003)(39860400002)(230922051799003)(230273577357003)(186009)(64100799003)(451199024)(1800799012)(966005)(6486002)(6512007)(1076003)(83380400001)(478600001)(41300700001)(2616005)(26005)(30864003)(6506007)(4326008)(316002)(6666004)(66946007)(66476007)(66556008)(8936002)(8676002)(2906002)(6916009)(36756003)(5660300002)(38100700002)(82960400001)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xfW/15MYym+ZyCrDsOau7MjvxNff8SWudNyPBYgTbW+E4c/kKKC+bxySkZUl?=
 =?us-ascii?Q?sk3prjqc5fhug6W2T6/Meg4PKbFZTXdHujm8pnH3L3/yD1K3IDc7fZ5ZNsNk?=
 =?us-ascii?Q?9tJUA2i3te7Ak5f0nYIBLn5M/fQQ2fvX8lVKNYBPoIL0OvDjOjVUYA+XLST7?=
 =?us-ascii?Q?7SjItDkV/fQw8dyF3Z8PFYD/f1qS/V/KEn2D1yBFw1rZzrJ8Lp5UnnqvAJgw?=
 =?us-ascii?Q?geWNfi5wEukELRPTTMnbr2XpmsCo1/mNWSYpcWLu3I9owmCq6mwgNDVlFSz/?=
 =?us-ascii?Q?ocv6Dv3JpNUFHuTdn5dUth0GVvmF6H13goLsAVaJxRsk7ziJcSqbFAcjrCf0?=
 =?us-ascii?Q?spBJR3h1G7u4jhfgg5h1cp6I9cOjH5P95t5lrkRzjyX4wSVwzGi0IQj1p8bJ?=
 =?us-ascii?Q?abrD9QnJW/YIMQp/43k9IczSYqFppT5ThuiDoh1ujSZ9LNIjoFJg/OyYtNAc?=
 =?us-ascii?Q?J/iS20KIEAaNNbAon4Kj785gTur0yWdUUIFH4XdwIpm8F4merLCJ03uUcRjb?=
 =?us-ascii?Q?PkVFFWcPnjsuRsb5AOU+OFIWZ2i5MjqXqd2j4uPwMs44UrvegLMR6p70AuXP?=
 =?us-ascii?Q?mN3deAFmkuImwSaoIxU84JfU9D07xT16+xvkQPf2n5p15UT4wtxd1J6AiN6J?=
 =?us-ascii?Q?wg7NV23VdcUeFB35+4TTYNAFkAXIUFWijb0Qkq5Js/FhcoIw1gdKztsBkDJR?=
 =?us-ascii?Q?tteZscTNf41tXVaiOvjx/1yDGqczjsaG6BFc9OYgD+PpLJoEHhb/fJJ1mvD2?=
 =?us-ascii?Q?9TFat0Dv9oYkLYgDSWKWuKfdqkcXpE+4yw1hXaJsDXaamH6V/dnmVgIfTrJi?=
 =?us-ascii?Q?IponWkjZQFcxup0ILH5j0IDQpdjcS/WeTwjBitpnyw9MgHqG5udiF9IXKPp8?=
 =?us-ascii?Q?yEegLVy1JZvK6DMYZO6sQawOk83JP9hQaWATfHnaKEwoI92n/XRqHDYVkc7+?=
 =?us-ascii?Q?mFau5wJJRgTr42xSX26arYCy3+iSJGi8mn+409rvdtZz5uAfxpYBY5T4YB8v?=
 =?us-ascii?Q?mDsFry6ghBSGL7zs8MMfpvkQlKz1hDKuSyCc+RliMDDr0bGj3WDhsX/1xEyp?=
 =?us-ascii?Q?2gmjYjN5xdimM9SUxM3MYy+cfXmeGXJU+rMLehH1Sc4/CUc1uOZBDMTo3mbC?=
 =?us-ascii?Q?vHn3LuY+I5G9MjTC+2m8FouW5unC5SqaTeKirWN3YMkG5Y/hMheIlCDm969o?=
 =?us-ascii?Q?l+s9m2K10rc+tMFJBwK+t6u0nfyDUVkNxzL1aSvZvPcYHO0Xl3kv/MFolDLu?=
 =?us-ascii?Q?WsesayhKSc+FBIj6aBTi9mbBpwbR/KiS44a8qQ7rQa0cOQNvTy1/x9ODMyCG?=
 =?us-ascii?Q?cT8ix6uMMx00egDKmMNDBqDc/KCjX8nX4YC4VI96u4HXFEOEtPAR9/pbELzh?=
 =?us-ascii?Q?4BPEUDTpVL6L8Hjq+vbxgx4WcKoHdaMx/VZabK+m5WW/ohBTJcNGKYEgujKz?=
 =?us-ascii?Q?IuqDPp09tX63brQiTGM87yZWC0Q/8dxagPS6WXlbOJEjZLZcsBGHg+VY6kzn?=
 =?us-ascii?Q?w3GsnQ2hHYba8cz67qS4vpQMXYG1OyY8KAuAn/CNFzrC+psX3dm1G19gfMpI?=
 =?us-ascii?Q?ztYpKUePew+DhrWUPaJtP8VO+pt8zUPgYtKyZitXs8uzXp9VDC3VrANVpZSq?=
 =?us-ascii?Q?ww=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a048bcd-876b-4190-c44a-08dc2a2f08fd
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8414.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2024 11:54:29.1924
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0Ga7zR10p29LDzMYlRl8EB4DqthxIfP1XwhNjSQmX+QhbV33xhjo11PleloHbbCuvjqXfpT1BzMqj2qO+lQiLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4553
X-OriginatorOrg: intel.com

Hi Herve,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   4a7bbe7519b6a5d189feeba1d417c8ce9f7e852b
commit: 6ffa0da5c63f8408101d01075709981005eb66ec soc: fsl: cpm1: qmc: Fix test dependency
date:   11 months ago
:::::: branch date: 8 hours ago
:::::: commit date: 11 months ago
config: powerpc-randconfig-r122-20240208 (https://download.01.org/0day-ci/archive/20240210/202402101716.yt6Z87ty-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project.git f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce: (https://download.01.org/0day-ci/archive/20240210/202402101716.yt6Z87ty-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/r/202402101716.yt6Z87ty-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   drivers/soc/fsl/qe/qmc.c:334:12: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct cpm_buf_desc [usertype] *[noderef] __iomem bd @@     got struct cpm_buf_desc [noderef] [usertype] __iomem *txbd_free @@
   drivers/soc/fsl/qe/qmc.c:334:12: sparse:     expected struct cpm_buf_desc [usertype] *[noderef] __iomem bd
   drivers/soc/fsl/qe/qmc.c:334:12: sparse:     got struct cpm_buf_desc [noderef] [usertype] __iomem *txbd_free
   drivers/soc/fsl/qe/qmc.c:346:39: sparse: sparse: subtraction of different types can't work (different address spaces)
   drivers/soc/fsl/qe/qmc.c:389:12: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct cpm_buf_desc [usertype] *[noderef] __iomem bd @@     got struct cpm_buf_desc [noderef] [usertype] __iomem *txbd_done @@
   drivers/soc/fsl/qe/qmc.c:389:12: sparse:     expected struct cpm_buf_desc [usertype] *[noderef] __iomem bd
   drivers/soc/fsl/qe/qmc.c:389:12: sparse:     got struct cpm_buf_desc [noderef] [usertype] __iomem *txbd_done
   drivers/soc/fsl/qe/qmc.c:396:47: sparse: sparse: subtraction of different types can't work (different address spaces)
   drivers/soc/fsl/qe/qmc.c:441:12: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct cpm_buf_desc [usertype] *[noderef] __iomem bd @@     got struct cpm_buf_desc [noderef] [usertype] __iomem *rxbd_free @@
   drivers/soc/fsl/qe/qmc.c:453:39: sparse: sparse: subtraction of different types can't work (different address spaces)
   drivers/soc/fsl/qe/qmc.c:505:12: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct cpm_buf_desc [usertype] *[noderef] __iomem bd @@     got struct cpm_buf_desc [noderef] [usertype] __iomem *rxbd_done @@
   drivers/soc/fsl/qe/qmc.c:505:12: sparse:     expected struct cpm_buf_desc [usertype] *[noderef] __iomem bd
   drivers/soc/fsl/qe/qmc.c:505:12: sparse:     got struct cpm_buf_desc [noderef] [usertype] __iomem *rxbd_done
   drivers/soc/fsl/qe/qmc.c:512:47: sparse: sparse: subtraction of different types can't work (different address spaces)
   drivers/soc/fsl/qe/qmc.c:670:12: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct cpm_buf_desc [usertype] *[noderef] __iomem bd @@     got struct cpm_buf_desc [noderef] [usertype] __iomem *rxbds @@
   drivers/soc/fsl/qe/qmc.c:675:47: sparse: sparse: subtraction of different types can't work (different address spaces)
   drivers/soc/fsl/qe/qmc.c:705:12: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct cpm_buf_desc [usertype] *[noderef] __iomem bd @@     got struct cpm_buf_desc [noderef] [usertype] __iomem *txbds @@
   drivers/soc/fsl/qe/qmc.c:705:12: sparse:     expected struct cpm_buf_desc [usertype] *[noderef] __iomem bd
   drivers/soc/fsl/qe/qmc.c:705:12: sparse:     got struct cpm_buf_desc [noderef] [usertype] __iomem *txbds
   drivers/soc/fsl/qe/qmc.c:710:47: sparse: sparse: subtraction of different types can't work (different address spaces)
   drivers/soc/fsl/qe/qmc.c:1108:30: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *[noderef] __iomem addr @@     got unsigned short [noderef] __iomem * @@
   drivers/soc/fsl/qe/qmc.c:1108:30: sparse:     expected void *[noderef] __iomem addr
   drivers/soc/fsl/qe/qmc.c:1108:30: sparse:     got unsigned short [noderef] __iomem *
   drivers/soc/fsl/qe/qmc.c:1111:22: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *[noderef] __iomem addr @@     got unsigned short [noderef] __iomem * @@
   drivers/soc/fsl/qe/qmc.c:1111:22: sparse:     expected void *[noderef] __iomem addr
   drivers/soc/fsl/qe/qmc.c:1111:22: sparse:     got unsigned short [noderef] __iomem *
   drivers/soc/fsl/qe/qmc.c:1120:30: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *[noderef] __iomem addr @@     got unsigned short [noderef] __iomem * @@
   drivers/soc/fsl/qe/qmc.c:1120:30: sparse:     expected void *[noderef] __iomem addr
   drivers/soc/fsl/qe/qmc.c:1120:30: sparse:     got unsigned short [noderef] __iomem *
   drivers/soc/fsl/qe/qmc.c:1123:22: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *[noderef] __iomem addr @@     got unsigned short [noderef] __iomem * @@
   drivers/soc/fsl/qe/qmc.c:1123:22: sparse:     expected void *[noderef] __iomem addr
   drivers/soc/fsl/qe/qmc.c:1123:22: sparse:     got unsigned short [noderef] __iomem *
   drivers/soc/fsl/qe/qmc.c:1176:44: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *[noderef] __iomem addr @@     got unsigned short [noderef] [usertype] __iomem * @@
   drivers/soc/fsl/qe/qmc.c:1176:44: sparse:     expected void *[noderef] __iomem addr
   drivers/soc/fsl/qe/qmc.c:1176:44: sparse:     got unsigned short [noderef] [usertype] __iomem *
   drivers/soc/fsl/qe/qmc.c:1181:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *[noderef] __iomem addr @@     got unsigned short [noderef] [usertype] __iomem *[assigned] last @@
   drivers/soc/fsl/qe/qmc.c:1181:29: sparse:     expected void *[noderef] __iomem addr
   drivers/soc/fsl/qe/qmc.c:1181:29: sparse:     got unsigned short [noderef] [usertype] __iomem *[assigned] last
   drivers/soc/fsl/qe/qmc.c:1194:35: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *[noderef] __iomem addr @@     got unsigned short [noderef] [usertype] __iomem *int_curr @@
   drivers/soc/fsl/qe/qmc.c:1194:35: sparse:     expected void *[noderef] __iomem addr
   drivers/soc/fsl/qe/qmc.c:1194:35: sparse:     got unsigned short [noderef] [usertype] __iomem *int_curr
   drivers/soc/fsl/qe/qmc.c:1197:32: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *[noderef] __iomem addr @@     got unsigned short [noderef] [usertype] __iomem *int_curr @@
   drivers/soc/fsl/qe/qmc.c:1197:32: sparse:     expected void *[noderef] __iomem addr
   drivers/soc/fsl/qe/qmc.c:1197:32: sparse:     got unsigned short [noderef] [usertype] __iomem *int_curr
   drivers/soc/fsl/qe/qmc.c:1242:43: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *[noderef] __iomem addr @@     got unsigned short [noderef] [usertype] __iomem *int_curr @@
   drivers/soc/fsl/qe/qmc.c:1242:43: sparse:     expected void *[noderef] __iomem addr
   drivers/soc/fsl/qe/qmc.c:1242:43: sparse:     got unsigned short [noderef] [usertype] __iomem *int_curr
   drivers/soc/fsl/qe/qmc.c:1286:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *[noderef] scc_regs @@     got void [noderef] __iomem * @@
   drivers/soc/fsl/qe/qmc.c:1286:23: sparse:     expected void *[noderef] scc_regs
   drivers/soc/fsl/qe/qmc.c:1286:23: sparse:     got void [noderef] __iomem *
   drivers/soc/fsl/qe/qmc.c:1295:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *[noderef] scc_pram @@     got void [noderef] __iomem * @@
   drivers/soc/fsl/qe/qmc.c:1295:23: sparse:     expected void *[noderef] scc_pram
   drivers/soc/fsl/qe/qmc.c:1295:23: sparse:     got void [noderef] __iomem *
   drivers/soc/fsl/qe/qmc.c:1299:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *[noderef] dpram @@     got void [noderef] __iomem * @@
   drivers/soc/fsl/qe/qmc.c:1299:21: sparse:     expected void *[noderef] dpram
   drivers/soc/fsl/qe/qmc.c:1299:21: sparse:     got void [noderef] __iomem *
   drivers/soc/fsl/qe/qmc.c:1335:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct cpm_buf_desc [noderef] [usertype] __iomem *bd_table @@     got void * @@
   drivers/soc/fsl/qe/qmc.c:1335:23: sparse:     expected struct cpm_buf_desc [noderef] [usertype] __iomem *bd_table
   drivers/soc/fsl/qe/qmc.c:1335:23: sparse:     got void *
>> drivers/soc/fsl/qe/qmc.c:1342:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *s @@     got struct cpm_buf_desc [noderef] [usertype] __iomem *bd_table @@
   drivers/soc/fsl/qe/qmc.c:1342:9: sparse:     expected void *s
   drivers/soc/fsl/qe/qmc.c:1342:9: sparse:     got struct cpm_buf_desc [noderef] [usertype] __iomem *bd_table
   drivers/soc/fsl/qe/qmc.c:1348:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned short [noderef] [usertype] __iomem *int_table @@     got void * @@
   drivers/soc/fsl/qe/qmc.c:1348:24: sparse:     expected unsigned short [noderef] [usertype] __iomem *int_table
   drivers/soc/fsl/qe/qmc.c:1348:24: sparse:     got void *
>> drivers/soc/fsl/qe/qmc.c:1355:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *s @@     got unsigned short [noderef] [usertype] __iomem *int_table @@
   drivers/soc/fsl/qe/qmc.c:1355:9: sparse:     expected void *s
   drivers/soc/fsl/qe/qmc.c:1355:9: sparse:     got unsigned short [noderef] [usertype] __iomem *int_table
   drivers/soc/fsl/qe/qmc.c:290:33: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *[noderef] __iomem addr @@
   drivers/soc/fsl/qe/qmc.c:223:26: sparse:     expected void [noderef] __iomem *addr
   drivers/soc/fsl/qe/qmc.c:223:26: sparse:     got void *[noderef] __iomem addr
   drivers/soc/fsl/qe/qmc.c:290:33: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:292:29: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *[noderef] __iomem addr @@
   drivers/soc/fsl/qe/qmc.c:223:26: sparse:     expected void [noderef] __iomem *addr
   drivers/soc/fsl/qe/qmc.c:223:26: sparse:     got void *[noderef] __iomem addr
   drivers/soc/fsl/qe/qmc.c:292:29: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:295:39: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:295:39: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:233:21: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:233:38: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:228:27: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got void *[noderef] __iomem addr @@
   drivers/soc/fsl/qe/qmc.c:228:27: sparse:     expected void const [noderef] __iomem *addr
   drivers/soc/fsl/qe/qmc.c:228:27: sparse:     got void *[noderef] __iomem addr
   drivers/soc/fsl/qe/qmc.c:233:38: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:228:27: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:228:27: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *[noderef] __iomem addr @@
   drivers/soc/fsl/qe/qmc.c:223:26: sparse:     expected void [noderef] __iomem *addr
   drivers/soc/fsl/qe/qmc.c:223:26: sparse:     got void *[noderef] __iomem addr
   drivers/soc/fsl/qe/qmc.c:233:21: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:233:38: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:228:27: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:298:39: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:298:39: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:238:21: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:238:38: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:228:27: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got void *[noderef] __iomem addr @@
   drivers/soc/fsl/qe/qmc.c:228:27: sparse:     expected void const [noderef] __iomem *addr
   drivers/soc/fsl/qe/qmc.c:228:27: sparse:     got void *[noderef] __iomem addr
   drivers/soc/fsl/qe/qmc.c:238:38: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:228:27: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:228:27: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *[noderef] __iomem addr @@
   drivers/soc/fsl/qe/qmc.c:223:26: sparse:     expected void [noderef] __iomem *addr
   drivers/soc/fsl/qe/qmc.c:223:26: sparse:     got void *[noderef] __iomem addr
   drivers/soc/fsl/qe/qmc.c:238:21: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:238:38: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:228:27: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:304:29: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *[noderef] __iomem addr @@
   drivers/soc/fsl/qe/qmc.c:223:26: sparse:     expected void [noderef] __iomem *addr
   drivers/soc/fsl/qe/qmc.c:223:26: sparse:     got void *[noderef] __iomem addr
   drivers/soc/fsl/qe/qmc.c:304:29: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:336:28: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:228:27: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got void *[noderef] __iomem addr @@
   drivers/soc/fsl/qe/qmc.c:228:27: sparse:     expected void const [noderef] __iomem *addr
   drivers/soc/fsl/qe/qmc.c:228:27: sparse:     got void *[noderef] __iomem addr
   drivers/soc/fsl/qe/qmc.c:336:28: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:228:27: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:228:27: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:343:22: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *[noderef] __iomem addr @@
   drivers/soc/fsl/qe/qmc.c:223:26: sparse:     expected void [noderef] __iomem *addr
   drivers/soc/fsl/qe/qmc.c:223:26: sparse:     got void *[noderef] __iomem addr
   drivers/soc/fsl/qe/qmc.c:343:22: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:344:22: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:243:26: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *[noderef] __iomem addr @@
   drivers/soc/fsl/qe/qmc.c:243:26: sparse:     expected void [noderef] __iomem *addr
   drivers/soc/fsl/qe/qmc.c:243:26: sparse:     got void *[noderef] __iomem addr
   drivers/soc/fsl/qe/qmc.c:344:22: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:243:26: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:243:26: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:346:36: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:353:22: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *[noderef] __iomem addr @@
   drivers/soc/fsl/qe/qmc.c:223:26: sparse:     expected void [noderef] __iomem *addr
   drivers/soc/fsl/qe/qmc.c:223:26: sparse:     got void *[noderef] __iomem addr
   drivers/soc/fsl/qe/qmc.c:353:22: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:356:31: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:356:31: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:233:21: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:233:38: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:228:27: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got void *[noderef] __iomem addr @@
   drivers/soc/fsl/qe/qmc.c:228:27: sparse:     expected void const [noderef] __iomem *addr
   drivers/soc/fsl/qe/qmc.c:228:27: sparse:     got void *[noderef] __iomem addr
   drivers/soc/fsl/qe/qmc.c:233:38: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:228:27: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:228:27: sparse: sparse: dereference of noderef expression
   drivers/soc/fsl/qe/qmc.c:223:26: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *[noderef] __iomem addr @@
   drivers/soc/fsl/qe/qmc.c:223:26: sparse:     expected void [noderef] __iomem *addr

vim +1342 drivers/soc/fsl/qe/qmc.c

3178d58e0b9772 Herve Codina 2023-02-17  1269  
3178d58e0b9772 Herve Codina 2023-02-17  1270  static int qmc_probe(struct platform_device *pdev)
3178d58e0b9772 Herve Codina 2023-02-17  1271  {
3178d58e0b9772 Herve Codina 2023-02-17  1272  	struct device_node *np = pdev->dev.of_node;
3178d58e0b9772 Herve Codina 2023-02-17  1273  	unsigned int nb_chans;
3178d58e0b9772 Herve Codina 2023-02-17  1274  	struct resource *res;
3178d58e0b9772 Herve Codina 2023-02-17  1275  	struct qmc *qmc;
3178d58e0b9772 Herve Codina 2023-02-17  1276  	int irq;
3178d58e0b9772 Herve Codina 2023-02-17  1277  	int ret;
3178d58e0b9772 Herve Codina 2023-02-17  1278  
3178d58e0b9772 Herve Codina 2023-02-17  1279  	qmc = devm_kzalloc(&pdev->dev, sizeof(*qmc), GFP_KERNEL);
3178d58e0b9772 Herve Codina 2023-02-17  1280  	if (!qmc)
3178d58e0b9772 Herve Codina 2023-02-17  1281  		return -ENOMEM;
3178d58e0b9772 Herve Codina 2023-02-17  1282  
3178d58e0b9772 Herve Codina 2023-02-17  1283  	qmc->dev = &pdev->dev;
3178d58e0b9772 Herve Codina 2023-02-17  1284  	INIT_LIST_HEAD(&qmc->chan_head);
3178d58e0b9772 Herve Codina 2023-02-17  1285  
3178d58e0b9772 Herve Codina 2023-02-17  1286  	qmc->scc_regs = devm_platform_ioremap_resource_byname(pdev, "scc_regs");
3178d58e0b9772 Herve Codina 2023-02-17  1287  	if (IS_ERR(qmc->scc_regs))
3178d58e0b9772 Herve Codina 2023-02-17  1288  		return PTR_ERR(qmc->scc_regs);
3178d58e0b9772 Herve Codina 2023-02-17  1289  
3178d58e0b9772 Herve Codina 2023-02-17  1290  
3178d58e0b9772 Herve Codina 2023-02-17  1291  	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "scc_pram");
3178d58e0b9772 Herve Codina 2023-02-17  1292  	if (!res)
3178d58e0b9772 Herve Codina 2023-02-17  1293  		return -EINVAL;
3178d58e0b9772 Herve Codina 2023-02-17  1294  	qmc->scc_pram_offset = res->start - get_immrbase();
3178d58e0b9772 Herve Codina 2023-02-17 @1295  	qmc->scc_pram = devm_ioremap_resource(qmc->dev, res);
3178d58e0b9772 Herve Codina 2023-02-17  1296  	if (IS_ERR(qmc->scc_pram))
3178d58e0b9772 Herve Codina 2023-02-17  1297  		return PTR_ERR(qmc->scc_pram);
3178d58e0b9772 Herve Codina 2023-02-17  1298  
3178d58e0b9772 Herve Codina 2023-02-17  1299  	qmc->dpram  = devm_platform_ioremap_resource_byname(pdev, "dpram");
3178d58e0b9772 Herve Codina 2023-02-17  1300  	if (IS_ERR(qmc->dpram))
3178d58e0b9772 Herve Codina 2023-02-17  1301  		return PTR_ERR(qmc->dpram);
3178d58e0b9772 Herve Codina 2023-02-17  1302  
3178d58e0b9772 Herve Codina 2023-02-17  1303  	qmc->tsa_serial = devm_tsa_serial_get_byphandle(qmc->dev, np, "fsl,tsa-serial");
3178d58e0b9772 Herve Codina 2023-02-17  1304  	if (IS_ERR(qmc->tsa_serial)) {
3178d58e0b9772 Herve Codina 2023-02-17  1305  		return dev_err_probe(qmc->dev, PTR_ERR(qmc->tsa_serial),
3178d58e0b9772 Herve Codina 2023-02-17  1306  				     "Failed to get TSA serial\n");
3178d58e0b9772 Herve Codina 2023-02-17  1307  	}
3178d58e0b9772 Herve Codina 2023-02-17  1308  
3178d58e0b9772 Herve Codina 2023-02-17  1309  	/* Connect the serial (SCC) to TSA */
3178d58e0b9772 Herve Codina 2023-02-17  1310  	ret = tsa_serial_connect(qmc->tsa_serial);
3178d58e0b9772 Herve Codina 2023-02-17  1311  	if (ret) {
3178d58e0b9772 Herve Codina 2023-02-17  1312  		dev_err(qmc->dev, "Failed to connect TSA serial\n");
3178d58e0b9772 Herve Codina 2023-02-17  1313  		return ret;
3178d58e0b9772 Herve Codina 2023-02-17  1314  	}
3178d58e0b9772 Herve Codina 2023-02-17  1315  
3178d58e0b9772 Herve Codina 2023-02-17  1316  	/* Parse channels informationss */
3178d58e0b9772 Herve Codina 2023-02-17  1317  	ret = qmc_of_parse_chans(qmc, np);
3178d58e0b9772 Herve Codina 2023-02-17  1318  	if (ret)
3178d58e0b9772 Herve Codina 2023-02-17  1319  		goto err_tsa_serial_disconnect;
3178d58e0b9772 Herve Codina 2023-02-17  1320  
3178d58e0b9772 Herve Codina 2023-02-17  1321  	nb_chans = qmc_nb_chans(qmc);
3178d58e0b9772 Herve Codina 2023-02-17  1322  
3178d58e0b9772 Herve Codina 2023-02-17  1323  	/* Init GMSR_H and GMSR_L registers */
3178d58e0b9772 Herve Codina 2023-02-17  1324  	qmc_write32(qmc->scc_regs + SCC_GSMRH,
3178d58e0b9772 Herve Codina 2023-02-17  1325  		    SCC_GSMRH_CDS | SCC_GSMRH_CTSS | SCC_GSMRH_CDP | SCC_GSMRH_CTSP);
3178d58e0b9772 Herve Codina 2023-02-17  1326  
3178d58e0b9772 Herve Codina 2023-02-17  1327  	/* enable QMC mode */
3178d58e0b9772 Herve Codina 2023-02-17  1328  	qmc_write32(qmc->scc_regs + SCC_GSMRL, SCC_GSMRL_MODE_QMC);
3178d58e0b9772 Herve Codina 2023-02-17  1329  
3178d58e0b9772 Herve Codina 2023-02-17  1330  	/*
3178d58e0b9772 Herve Codina 2023-02-17  1331  	 * Allocate the buffer descriptor table
3178d58e0b9772 Herve Codina 2023-02-17  1332  	 * 8 rx and 8 tx descriptors per channel
3178d58e0b9772 Herve Codina 2023-02-17  1333  	 */
3178d58e0b9772 Herve Codina 2023-02-17  1334  	qmc->bd_size = (nb_chans * (QMC_NB_TXBDS + QMC_NB_RXBDS)) * sizeof(cbd_t);
3178d58e0b9772 Herve Codina 2023-02-17 @1335  	qmc->bd_table = dmam_alloc_coherent(qmc->dev, qmc->bd_size,
3178d58e0b9772 Herve Codina 2023-02-17  1336  		&qmc->bd_dma_addr, GFP_KERNEL);
3178d58e0b9772 Herve Codina 2023-02-17  1337  	if (!qmc->bd_table) {
3178d58e0b9772 Herve Codina 2023-02-17  1338  		dev_err(qmc->dev, "Failed to allocate bd table\n");
3178d58e0b9772 Herve Codina 2023-02-17  1339  		ret = -ENOMEM;
3178d58e0b9772 Herve Codina 2023-02-17  1340  		goto err_tsa_serial_disconnect;
3178d58e0b9772 Herve Codina 2023-02-17  1341  	}
3178d58e0b9772 Herve Codina 2023-02-17 @1342  	memset(qmc->bd_table, 0, qmc->bd_size);
3178d58e0b9772 Herve Codina 2023-02-17  1343  
3178d58e0b9772 Herve Codina 2023-02-17  1344  	qmc_write32(qmc->scc_pram + QMC_GBL_MCBASE, qmc->bd_dma_addr);
3178d58e0b9772 Herve Codina 2023-02-17  1345  
3178d58e0b9772 Herve Codina 2023-02-17  1346  	/* Allocate the interrupt table */
3178d58e0b9772 Herve Codina 2023-02-17  1347  	qmc->int_size = QMC_NB_INTS * sizeof(u16);
3178d58e0b9772 Herve Codina 2023-02-17  1348  	qmc->int_table = dmam_alloc_coherent(qmc->dev, qmc->int_size,
3178d58e0b9772 Herve Codina 2023-02-17  1349  		&qmc->int_dma_addr, GFP_KERNEL);
3178d58e0b9772 Herve Codina 2023-02-17  1350  	if (!qmc->int_table) {
3178d58e0b9772 Herve Codina 2023-02-17  1351  		dev_err(qmc->dev, "Failed to allocate interrupt table\n");
3178d58e0b9772 Herve Codina 2023-02-17  1352  		ret = -ENOMEM;
3178d58e0b9772 Herve Codina 2023-02-17  1353  		goto err_tsa_serial_disconnect;
3178d58e0b9772 Herve Codina 2023-02-17  1354  	}
3178d58e0b9772 Herve Codina 2023-02-17 @1355  	memset(qmc->int_table, 0, qmc->int_size);
3178d58e0b9772 Herve Codina 2023-02-17  1356  
3178d58e0b9772 Herve Codina 2023-02-17  1357  	qmc->int_curr = qmc->int_table;
3178d58e0b9772 Herve Codina 2023-02-17  1358  	qmc_write32(qmc->scc_pram + QMC_GBL_INTBASE, qmc->int_dma_addr);
3178d58e0b9772 Herve Codina 2023-02-17  1359  	qmc_write32(qmc->scc_pram + QMC_GBL_INTPTR, qmc->int_dma_addr);
3178d58e0b9772 Herve Codina 2023-02-17  1360  
3178d58e0b9772 Herve Codina 2023-02-17  1361  	/* Set MRBLR (valid for HDLC only) max MRU + max CRC */
3178d58e0b9772 Herve Codina 2023-02-17  1362  	qmc_write16(qmc->scc_pram + QMC_GBL_MRBLR, HDLC_MAX_MRU + 4);
3178d58e0b9772 Herve Codina 2023-02-17  1363  
3178d58e0b9772 Herve Codina 2023-02-17  1364  	qmc_write16(qmc->scc_pram + QMC_GBL_GRFTHR, 1);
3178d58e0b9772 Herve Codina 2023-02-17  1365  	qmc_write16(qmc->scc_pram + QMC_GBL_GRFCNT, 1);
3178d58e0b9772 Herve Codina 2023-02-17  1366  
3178d58e0b9772 Herve Codina 2023-02-17  1367  	qmc_write32(qmc->scc_pram + QMC_GBL_C_MASK32, 0xDEBB20E3);
3178d58e0b9772 Herve Codina 2023-02-17  1368  	qmc_write16(qmc->scc_pram + QMC_GBL_C_MASK16, 0xF0B8);
3178d58e0b9772 Herve Codina 2023-02-17  1369  
3178d58e0b9772 Herve Codina 2023-02-17  1370  	ret = qmc_setup_tsa(qmc);
3178d58e0b9772 Herve Codina 2023-02-17  1371  	if (ret)
3178d58e0b9772 Herve Codina 2023-02-17  1372  		goto err_tsa_serial_disconnect;
3178d58e0b9772 Herve Codina 2023-02-17  1373  
3178d58e0b9772 Herve Codina 2023-02-17  1374  	qmc_write16(qmc->scc_pram + QMC_GBL_QMCSTATE, 0x8000);
3178d58e0b9772 Herve Codina 2023-02-17  1375  
3178d58e0b9772 Herve Codina 2023-02-17  1376  	ret = qmc_setup_chans(qmc);
3178d58e0b9772 Herve Codina 2023-02-17  1377  	if (ret)
3178d58e0b9772 Herve Codina 2023-02-17  1378  		goto err_tsa_serial_disconnect;
3178d58e0b9772 Herve Codina 2023-02-17  1379  
3178d58e0b9772 Herve Codina 2023-02-17  1380  	/* Init interrupts table */
3178d58e0b9772 Herve Codina 2023-02-17  1381  	ret = qmc_setup_ints(qmc);
3178d58e0b9772 Herve Codina 2023-02-17  1382  	if (ret)
3178d58e0b9772 Herve Codina 2023-02-17  1383  		goto err_tsa_serial_disconnect;
3178d58e0b9772 Herve Codina 2023-02-17  1384  
3178d58e0b9772 Herve Codina 2023-02-17  1385  	/* Disable and clear interrupts,  set the irq handler */
3178d58e0b9772 Herve Codina 2023-02-17  1386  	qmc_write16(qmc->scc_regs + SCC_SCCM, 0x0000);
3178d58e0b9772 Herve Codina 2023-02-17  1387  	qmc_write16(qmc->scc_regs + SCC_SCCE, 0x000F);
3178d58e0b9772 Herve Codina 2023-02-17  1388  	irq = platform_get_irq(pdev, 0);
3178d58e0b9772 Herve Codina 2023-02-17  1389  	if (irq < 0)
3178d58e0b9772 Herve Codina 2023-02-17  1390  		goto err_tsa_serial_disconnect;
3178d58e0b9772 Herve Codina 2023-02-17  1391  	ret = devm_request_irq(qmc->dev, irq, qmc_irq_handler, 0, "qmc", qmc);
3178d58e0b9772 Herve Codina 2023-02-17  1392  	if (ret < 0)
3178d58e0b9772 Herve Codina 2023-02-17  1393  		goto err_tsa_serial_disconnect;
3178d58e0b9772 Herve Codina 2023-02-17  1394  
3178d58e0b9772 Herve Codina 2023-02-17  1395  	/* Enable interrupts */
3178d58e0b9772 Herve Codina 2023-02-17  1396  	qmc_write16(qmc->scc_regs + SCC_SCCM,
3178d58e0b9772 Herve Codina 2023-02-17  1397  		SCC_SCCE_IQOV | SCC_SCCE_GINT | SCC_SCCE_GUN | SCC_SCCE_GOV);
3178d58e0b9772 Herve Codina 2023-02-17  1398  
3178d58e0b9772 Herve Codina 2023-02-17  1399  	ret = qmc_finalize_chans(qmc);
3178d58e0b9772 Herve Codina 2023-02-17  1400  	if (ret < 0)
3178d58e0b9772 Herve Codina 2023-02-17  1401  		goto err_disable_intr;
3178d58e0b9772 Herve Codina 2023-02-17  1402  
3178d58e0b9772 Herve Codina 2023-02-17  1403  	/* Enable transmiter and receiver */
3178d58e0b9772 Herve Codina 2023-02-17  1404  	qmc_setbits32(qmc->scc_regs + SCC_GSMRL, SCC_GSMRL_ENR | SCC_GSMRL_ENT);
3178d58e0b9772 Herve Codina 2023-02-17  1405  
3178d58e0b9772 Herve Codina 2023-02-17  1406  	platform_set_drvdata(pdev, qmc);
3178d58e0b9772 Herve Codina 2023-02-17  1407  
3178d58e0b9772 Herve Codina 2023-02-17  1408  	return 0;
3178d58e0b9772 Herve Codina 2023-02-17  1409  
3178d58e0b9772 Herve Codina 2023-02-17  1410  err_disable_intr:
3178d58e0b9772 Herve Codina 2023-02-17  1411  	qmc_write16(qmc->scc_regs + SCC_SCCM, 0);
3178d58e0b9772 Herve Codina 2023-02-17  1412  
3178d58e0b9772 Herve Codina 2023-02-17  1413  err_tsa_serial_disconnect:
3178d58e0b9772 Herve Codina 2023-02-17  1414  	tsa_serial_disconnect(qmc->tsa_serial);
3178d58e0b9772 Herve Codina 2023-02-17  1415  	return ret;
3178d58e0b9772 Herve Codina 2023-02-17  1416  }
3178d58e0b9772 Herve Codina 2023-02-17  1417  

:::::: The code at line 1342 was first introduced by commit
:::::: 3178d58e0b9772d690456c0bdf8c9f5e191d45f1 soc: fsl: cpm1: Add support for QMC

:::::: TO: Herve Codina <herve.codina@bootlin.com>
:::::: CC: Mark Brown <broonie@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


