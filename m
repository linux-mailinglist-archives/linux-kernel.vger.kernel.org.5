Return-Path: <linux-kernel+bounces-32528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F271835CB3
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 09:33:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E53301F23856
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 08:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6BDA2A1D3;
	Mon, 22 Jan 2024 08:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JZE+7jiG"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 479172135A
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 08:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.55.52.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705912387; cv=fail; b=h6wekc1CY4NeZMc+89vkTt0ovvS3T9iaY8/uB7iXwG7uom0alQpYDAdZHg2OwkSfop8qFMtyT29oHJHMpDwLyI5FuXcqZHTiZrI2PXJG1XC4Pd6sPeUrEz2Q6fCzC7I3+YKIZ9rOy7mxY6PrS5Lvx6VPybI86Jn9QNPVbN7E83s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705912387; c=relaxed/simple;
	bh=q/w1nIShFVW8GPi6DOI+xg8xfc56RrFsb8p06Mf7KUc=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=qVl8sruh/BVXOEkrhQJ1QedFpwxsBbAEwf1orTsqdRiUYzh/1ixky5y4i3VZR87BZMeq+Qe/IKZ9z2ZfLT/yOib49wVWz6KHOJ1NsG93iE+yu9r5dRG7u/J4t4nT5+gNwx4XtQ1EGTDdYbPJ//2mBdnqebiCrpvMeBaa6c836AM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JZE+7jiG; arc=fail smtp.client-ip=192.55.52.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705912386; x=1737448386;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=q/w1nIShFVW8GPi6DOI+xg8xfc56RrFsb8p06Mf7KUc=;
  b=JZE+7jiG6Vn8fHapU7ifSleak7l6BoJvM2hp2IHLDL2z0kzuQxBFctRC
   vgSEKvA/LPMRTAFH9p0wSJug4fMod14k7KNy4cM9r8353OafpRwJ+DOxZ
   ZpGd6I4LzxG7vOBcHDcYmQiIJTzKVZUZ0vjEkjj+/dbhCgBeAEzKR+rqy
   iQ5BL6Mefpl34B2ylpV55RcWaySRx0o6AtZs+QeE0hoIKm7IQFEJenN+c
   fPd81NTVMV62Qnp1g2C6dceQMGt5kFwVl94QjthBe2AePVX3iSp1taq+m
   Zl9tmn2JPltNvt/y76flPTDDIklqYoEAJDQNchLhnL3FwmXCF0tNnZvuv
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10960"; a="487280545"
X-IronPort-AV: E=Sophos;i="6.05,211,1701158400"; 
   d="scan'208";a="487280545"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2024 00:33:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10960"; a="904774452"
X-IronPort-AV: E=Sophos;i="6.05,211,1701158400"; 
   d="scan'208";a="904774452"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Jan 2024 00:33:05 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 22 Jan 2024 00:33:04 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 22 Jan 2024 00:33:04 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 22 Jan 2024 00:33:04 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NOMsIAVp7XOCvdyRewpyZ0Cju2nqZIWjZjYVmuZHCyY93VOH4DX2D23snkc26zAjGvFrg1whMQujZSTFbOz5Qos6PFJzd7qyAMdk3zlotw8Svb2fq8nVRRfIBW65VZqh5NYl075lhLybqCR4YysWS1i1Lbk76BlKj9mLk2+ED+OqULPhUQMCEeLz3ovW6E/o3e+BI2IiIqvAU+5kl758+FU5zvgxwi+70PqwqtFiK0O6AdaJNqBhyd3FWJSY1GzS5PHqpl+5zF6F2H8C6mht3dNuJmUHGNIPjZAMDw/msLNm1ty3IalMZ0Y/avfDbsa+zADMt64IXbsYrNErvEz+GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MJ1Q/9E+C8F9Qb1gPIcgWJHQG9/oOiIy5bofhOd6DA4=;
 b=kGnOZKdRBeCjSjiavWxAe3ZcRKJcgYwbJhLLWJhuJedihQeeP4D0cL8XEZm7XBAPAStOEfEfLdmfAbc4Mm/JxxTIZfDeAoRfSe/NxgUNBxeRsNxuThtVAEzX3tMCD+Gs6Iag1tOlB0qiYzpDmR+nYUTAqq30vkfw0y41X6N8n4Txz/E51PxTu4W2A8Rm7hszxhI6JRYWe0X/8nVhXHDCjeQ9Q58dy0hJvjk7GBFWO1dvIt9/PJnv2xRBoZnEDJ7p9ZR1BoEU6NB8TMpM3t7XX2C+QEfC2dzEsjXvI98fTcvApGbm4ZkR7sCB6Durxt9pUQyLMh+C4rwItLYTKRHpCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB8414.namprd11.prod.outlook.com (2603:10b6:610:17e::19)
 by SJ1PR11MB6084.namprd11.prod.outlook.com (2603:10b6:a03:489::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.31; Mon, 22 Jan
 2024 08:33:02 +0000
Received: from CH3PR11MB8414.namprd11.prod.outlook.com
 ([fe80::ed34:4cf2:df58:f708]) by CH3PR11MB8414.namprd11.prod.outlook.com
 ([fe80::ed34:4cf2:df58:f708%4]) with mapi id 15.20.7202.034; Mon, 22 Jan 2024
 08:33:02 +0000
Date: Mon, 22 Jan 2024 16:32:55 +0800
From: kernel test robot <lkp@intel.com>
To: Samuel Holland <samuel@sholland.org>
CC: <oe-kbuild-all@lists.linux.dev>, <linux-kernel@vger.kernel.org>, "Jernej
 Skrabec" <jernej.skrabec@gmail.com>, Guo Ren <guoren@kernel.org>, "Heiko
 Stuebner" <heiko@sntech.de>
Subject: drivers/clk/sunxi/clk-a20-gmac.c:43: warning: expecting prototype
 for sun7i_a20_gmac_clk_setup(). Prototype was for SUN7I_A20_GMAC_GPIT()
 instead
Message-ID: <Za4oN9MBgdI3jTGz@rli9-mobl>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SG2PR04CA0163.apcprd04.prod.outlook.com (2603:1096:4::25)
 To CH3PR11MB8414.namprd11.prod.outlook.com (2603:10b6:610:17e::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8414:EE_|SJ1PR11MB6084:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d940815-92fc-401c-6d0a-08dc1b24bf2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vnZs9TtKQp6ri1mv5PfN9aYCZiLM2vrs7hYm6Tc4jrJvF9ngQloUVCYiKwmD3yHKIUR/wKSZ/4UuwRF0VjJBGoyLmPz4HWsGPOfNd4kyouszCnqWIApjYztwclEPgM1bvRTITyyo6bO2fEz5SaSZ8p+DbtnNYVf1Gn8cQK4jcFzVfhpWs0nrktskz6EmTLWFvxhCAKpSJ6dOv55MbUS9DsN5AkuY/Hm3EvHfpSXgX+snI0gWvyHvSONbubNscl22HV8PQHBcK5wubbvnLK2jXrK2UKK0AT2D73V+ZzX4Zbo5BSrCyPieN2ORwyVlZXL77N71bTJ4HX8/C+w6DcLmNa3EYiQjdnOTH1vTWITUNQl0AeESqPnU3ipf2snKwG6RGttrZC1LBZWku50wzlhezUuGrsF/IwV8lBIi+t2kRzQzub4uD0jsJfCj1GiI7TRp4fk+I0tFcZ4e+9mkR+HGbD1Un0KiJ47Y0Dd7BuHfsaBj/RT623+j/HVcmx+KDzIZ2CHLSSsbuFVNnMNSrD2vqLdDk8Vy5sIgKfxNdeVJAY0pmEYOGveyZR1rolVYqEi1WDaXfadiiSez8CehERTdVLPmTPSZ3tUk0dXBXQF64y86P+t5LxYWcwOa5XSu02Q2yFYHS8MlipS0aqzLT/9+0dTuPb0EKD++QSDKghgWrkk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8414.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(39860400002)(376002)(136003)(396003)(366004)(230173577357003)(230922051799003)(230273577357003)(1800799012)(451199024)(186009)(64100799003)(6506007)(9686003)(26005)(6666004)(6512007)(966005)(83380400001)(5660300002)(6486002)(4326008)(2906002)(8936002)(33716001)(41300700001)(316002)(478600001)(6916009)(54906003)(66946007)(66476007)(66556008)(8676002)(82960400001)(86362001)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qT9htfHWWpyuXN0+eijcOBgbmGQ1tSAKbcjgfVG9Y/UOlK4bM1F+KbuYEH02?=
 =?us-ascii?Q?STYsNEZDBVa0IKnkyiP412aT412fUCczV39S1LfvTSWSvQ7YDor2RnnwJ8Uu?=
 =?us-ascii?Q?XljeFbKM0r2v2FEHxWBX+8oaao5RFf9X+9ecno+V5gQznl97QPm7rXkxrg+p?=
 =?us-ascii?Q?okVHm8qBZEyu6/SsyXw042eQQeR4C+38vXnviTJm27HIKoa8mNsFe4NfHBrb?=
 =?us-ascii?Q?gMrwYeamKrNi9fkUn5EKXRw5iBzkkmm61nHhNpRMTr8cifAJ6zUNAW/tUUcw?=
 =?us-ascii?Q?dRA08hFwCXA2wD/LjEMlWFNap1HyI1RTX/7A+fcEmSx1Xe+D82KIqcChiX+q?=
 =?us-ascii?Q?+tMoAjWHYtj0fbo3Frx/+SfY+RPJ8LT4P4jiw1+u1lw9AU33rhSG3rGaUyiH?=
 =?us-ascii?Q?60nvbpzsNkvqyBqhPZuvpr51RPOoZmQXFbkHn9Tm0XC1xLXxez1trWunhII6?=
 =?us-ascii?Q?2trCT88FMaLZ5S17cBgn+vOdG8Afe6ux65r9am5zXcKNhNTFPO43h1KwEnGO?=
 =?us-ascii?Q?x5ItkmMTAI+jeeo0CC073DBprCM+FKGMGQVBDCRQqaaOYEQi6XGQVq4LMBg1?=
 =?us-ascii?Q?qsWdnwKarwmOLC02KY1IdAvcKHP+MavjSgDoIXe30Myz/rv0fJdcy1R+TIoV?=
 =?us-ascii?Q?kknumO+pt3xNh+rkDIWUouPTpoNkvbuzyGJYDU9BP72aViObV/7O6/yu5Q6s?=
 =?us-ascii?Q?4xXMlmuX1Z+zaQh1BDMZeIxzqX5QaHaNJaeduS0tR7f5vUA9dwvM+ZRZyjwg?=
 =?us-ascii?Q?5ebQhkuCq0KvMGV1BAsWcP5xhUf4jAB0B0/Np6HllQHw4nEiDb5uA4RqoK6t?=
 =?us-ascii?Q?Cqst789xJXyKzVUxppjsgg3es/cpuemAE77sSspoPJOCKAAr5jXlXJBjq0SV?=
 =?us-ascii?Q?1GFMaDgKT90vRKiEGkpm13NWwVS+EihHMzkkh4qlQMb2jY/BtLYKnGfo4zzJ?=
 =?us-ascii?Q?sXAWsCCN8I4j5ZtNVBwsrBOxQJqrqg5mOi/G8KtGcUWMR/mywbMfL3tB/81a?=
 =?us-ascii?Q?yWVqVeaVMoH7fbd4gL3/Wuo4qYS6TdIFuwym3KdjP0ICFMGGJUG0uNZ3hPop?=
 =?us-ascii?Q?UNdAYYMcbCH/u6jTaR8jqJxBvHEleJGL9sq1wkAMjKCRPaz0MF/trf2MB4jW?=
 =?us-ascii?Q?ZI9xfXh9yvAOqE1UhlGFXwLNkXs1OBewGW/OdJUOc51wzP3kVQumgcBIdI8O?=
 =?us-ascii?Q?QO4gdO1n3cslR9cjr4iu5PY4aVxvSSYoln52og130CWvtN09wzOizuG6Wxok?=
 =?us-ascii?Q?fqXAVMdbXMzNRYFDrAzBxlcVeS2oeztcLx1G2AVcPgHnwK5X3OVvlISRW+Pd?=
 =?us-ascii?Q?8sgXS9KaT/FTfNRVULFoA+i6DPiULtEvfD8JY6GcUufYjYKD+QUMDMmjA90N?=
 =?us-ascii?Q?6gdQoh/mXTvoKEd3LeJm8vLaxeYLUWPsdoQJNn+m/1LlHoqqXiD1doCe/IjA?=
 =?us-ascii?Q?ERzbdZ/NfsF0cGD9WaPgl3gheMVyFFMWFfbqU9hO2jXkmyszW8WNEsypX6Vf?=
 =?us-ascii?Q?ZHWTEpB1MM0vHmxN25Xa7GQ42TW3W79lV6fWh02U97EzthPRZovPiMRNRDCJ?=
 =?us-ascii?Q?mGmT/paM5ddMRZXxqNHFTSEclq/IbRn5iFzO6OT3JE1k/UPcavhbY16gLjNg?=
 =?us-ascii?Q?4A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d940815-92fc-401c-6d0a-08dc1b24bf2c
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8414.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2024 08:33:02.2695
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GuRyAwyf5ouqw+zAOE7OwpmWYJEIstpPq+G7z/VUX53F2n4mlZoLd+r3XH5lF7fm7MUVqKRM0a+KHDwFy5AK5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6084
X-OriginatorOrg: intel.com

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   0cb552aa97843f24549ce808883494138471c16b
commit: 6f5178acf63614f2ee27450b2ab4d4980a698161 riscv: Add the Allwinner SoC family Kconfig option
date:   12 months ago
:::::: branch date: 3 hours ago
:::::: commit date: 12 months ago
config: riscv-randconfig-r042-20230805 (https://download.01.org/0day-ci/archive/20240111/202401110628.T2xYEQhh-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20240111/202401110628.T2xYEQhh-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/r/202401110628.T2xYEQhh-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/clk/sunxi/clk-a20-gmac.c:43: warning: expecting prototype for sun7i_a20_gmac_clk_setup(). Prototype was for SUN7I_A20_GMAC_GPIT() instead
--
>> drivers/clk/sunxi/clk-usb.c:80: warning: expecting prototype for sunxi_usb_clk_setup(). Prototype was for SUNXI_USB_MAX_SIZE() instead
--
>> drivers/clk/sunxi/clk-sun9i-cpus.c:25: warning: expecting prototype for sun9i_a80_cpus_clk_setup(). Prototype was for SUN9I_CPUS_MAX_PARENTS() instead


vim +43 drivers/clk/sunxi/clk-a20-gmac.c

59cb10e32a6053 Maxime Ripard 2014-05-09  17  
59cb10e32a6053 Maxime Ripard 2014-05-09  18  /**
59cb10e32a6053 Maxime Ripard 2014-05-09  19   * sun7i_a20_gmac_clk_setup - Setup function for A20/A31 GMAC clock module
59cb10e32a6053 Maxime Ripard 2014-05-09  20   *
59cb10e32a6053 Maxime Ripard 2014-05-09  21   * This clock looks something like this
59cb10e32a6053 Maxime Ripard 2014-05-09  22   *                               ________________________
59cb10e32a6053 Maxime Ripard 2014-05-09  23   *  MII TX clock from PHY >-----|___________    _________|----> to GMAC core
59cb10e32a6053 Maxime Ripard 2014-05-09  24   *  GMAC Int. RGMII TX clk >----|___________\__/__gate---|----> to PHY
59cb10e32a6053 Maxime Ripard 2014-05-09  25   *  Ext. 125MHz RGMII TX clk >--|__divider__/            |
59cb10e32a6053 Maxime Ripard 2014-05-09  26   *                              |________________________|
59cb10e32a6053 Maxime Ripard 2014-05-09  27   *
59cb10e32a6053 Maxime Ripard 2014-05-09  28   * The external 125 MHz reference is optional, i.e. GMAC can use its
59cb10e32a6053 Maxime Ripard 2014-05-09  29   * internal TX clock just fine. The A31 GMAC clock module does not have
59cb10e32a6053 Maxime Ripard 2014-05-09  30   * the divider controls for the external reference.
59cb10e32a6053 Maxime Ripard 2014-05-09  31   *
59cb10e32a6053 Maxime Ripard 2014-05-09  32   * To keep it simple, let the GMAC use either the MII TX clock for MII mode,
59cb10e32a6053 Maxime Ripard 2014-05-09  33   * and its internal TX clock for GMII and RGMII modes. The GMAC driver should
59cb10e32a6053 Maxime Ripard 2014-05-09  34   * select the appropriate source and gate/ungate the output to the PHY.
59cb10e32a6053 Maxime Ripard 2014-05-09  35   *
59cb10e32a6053 Maxime Ripard 2014-05-09  36   * Only the GMAC should use this clock. Altering the clock so that it doesn't
59cb10e32a6053 Maxime Ripard 2014-05-09  37   * match the GMAC's operation parameters will result in the GMAC not being
59cb10e32a6053 Maxime Ripard 2014-05-09  38   * able to send traffic out. The GMAC driver should set the clock rate and
59cb10e32a6053 Maxime Ripard 2014-05-09  39   * enable/disable this clock to configure the required state. The clock
59cb10e32a6053 Maxime Ripard 2014-05-09  40   * driver then responds by auto-reparenting the clock.
59cb10e32a6053 Maxime Ripard 2014-05-09  41   */
59cb10e32a6053 Maxime Ripard 2014-05-09  42  
59cb10e32a6053 Maxime Ripard 2014-05-09 @43  #define SUN7I_A20_GMAC_GPIT	2
59cb10e32a6053 Maxime Ripard 2014-05-09  44  #define SUN7I_A20_GMAC_MASK	0x3
59cb10e32a6053 Maxime Ripard 2014-05-09  45  #define SUN7I_A20_GMAC_PARENTS	2
59cb10e32a6053 Maxime Ripard 2014-05-09  46  

:::::: The code at line 43 was first introduced by commit
:::::: 59cb10e32a60533865e26dc9a8303306ba972a70 clk: sunxi: Move the GMAC clock to a file of its own

:::::: TO: Maxime Ripard <maxime.ripard@free-electrons.com>
:::::: CC: Maxime Ripard <maxime.ripard@free-electrons.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


