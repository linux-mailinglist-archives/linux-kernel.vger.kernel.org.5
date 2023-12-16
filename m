Return-Path: <linux-kernel+bounces-2096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4093F8157D1
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 06:40:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9187A1F25E70
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 05:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA42E125B7;
	Sat, 16 Dec 2023 05:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IB7oeaNQ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F71D10A1B
	for <linux-kernel@vger.kernel.org>; Sat, 16 Dec 2023 05:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702705238; x=1734241238;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=mUIMVDaBoVZYfgSguB3hRcjBMYZLMem1CgwudJP3WpU=;
  b=IB7oeaNQSDKJ9pxk+iurBlLjeoF29f6QwpBm+9VSrN7MkvHnS2/7sQex
   uNc6CuxHw8vwDN1i64dkQufFZUavtSLJ2fL7BvTZxiSp2Hr+gF4Kx7m/k
   lizTOK3b5V/EnuxQHXvIN+QbphXog/AgMhweqxC4fCZOv5LFlJxYOJEpR
   f4a3rCGhOQncayuKsvRv4uCWpquTXqTHsb9qvFkz+QgPuPUiU9GWYgvJl
   W7vujFK7NsLnYuOax4NPY7h3k4i4TxZOj2OmUaGiuAG9cG+8cg5rnDZ6P
   NXvZ+J4fgZTBlus+vUYc5JDJ05V5DlCLGTXVzyyP+iESvR+rjtWPQhpcR
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10925"; a="398146702"
X-IronPort-AV: E=Sophos;i="6.04,280,1695711600"; 
   d="scan'208";a="398146702"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2023 21:40:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,280,1695711600"; 
   d="scan'208";a="16535726"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Dec 2023 21:40:38 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 15 Dec 2023 21:40:36 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 15 Dec 2023 21:40:36 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 15 Dec 2023 21:40:36 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 15 Dec 2023 21:40:36 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZNFOWUK/ARXGBF7VGAI4WynxhxQzRhjamP156FGx67x/+d2EEI7caHgiZd+8WTz5aBNPMd6dxTq+lMz1bC/NcwfXmUVp0c4T8VYg0bi50wF6NKxwGCQw1Sjn8KmJ9+aL01Yc3ViLvuB3n+mxUetmLWoTFQIGeeUAESmKUc19XTzfHjV4XKMs59B3JbP3YqGBG/FSKhhlZTMhj1IxJa7C1/6Gi53BwSuDI1v6MXw1jzxAvxcfK0Mlg2ay4dF34GKcLJ/kYg+RBetN4yd4Qou3bR7e5qlv13bXPvoT9CL6k2PysLMua7/MDIgbYe7+Cr8A71y+Qx3sfp6zL9Y9+CHqcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K5Ysf0gP7dVtch84eBWpsnTgzvbWeryXcwrb764TTuQ=;
 b=Ee+fCkqZzJzYppSthZ28qfO0tFHHy5M+AqGil9BYs7ps9Gy3WMazqAwsEO6NZ4jT1owhkPhecO+L0Vg5iyeM4kVUYHDru4OHqFZeGaqifRLQdArV0XJoIkMIHpp5u2oVcYKacrBXsNhEBkARX+2BT1ZIehBWqmICkyqtbDOpRJ7e31RFDthu71LfVx4MI/sBqGY4pFrMdcgNn/LULEEgibRK81nDqsYx9htxbfv0vf15ElHauDaVPXWky5Pi3wbr8HgS06w2IHCeA1G6ZT1u6LgW92wp3cRSXzAp7QmcFpHVh76UUUzmyI2GTM5OJ94i+M6ZijnUnpQ44cZRiW2AFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL0PR11MB2995.namprd11.prod.outlook.com (2603:10b6:208:7a::28)
 by CO6PR11MB5633.namprd11.prod.outlook.com (2603:10b6:303:13c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.32; Sat, 16 Dec
 2023 05:40:34 +0000
Received: from BL0PR11MB2995.namprd11.prod.outlook.com
 ([fe80::2f1a:e62e:9fff:ae67]) by BL0PR11MB2995.namprd11.prod.outlook.com
 ([fe80::2f1a:e62e:9fff:ae67%5]) with mapi id 15.20.7091.030; Sat, 16 Dec 2023
 05:40:33 +0000
Date: Sat, 16 Dec 2023 13:40:24 +0800
From: Philip Li <philip.li@intel.com>
To: kernel test robot <lkp@intel.com>
CC: Kees Cook <keescook@chromium.org>, <llvm@lists.linux.dev>,
	<oe-kbuild-all@lists.linux.dev>, <linux-kernel@vger.kernel.org>, "Miquel
 Raynal" <miquel.raynal@bootlin.com>, "Gustavo A. R. Silva"
	<gustavoars@kernel.org>
Subject: Re: scripts/kernel-doc: drivers/mtd/nand/raw/marvell_nand.c:352:
 warning: Excess struct member 'sels' description in 'marvell_nand_chip'
Message-ID: <ZX04SC/YF4c45QGS@rli9-mobl>
References: <202312160703.nnQfaSja-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <202312160703.nnQfaSja-lkp@intel.com>
X-ClientProxiedBy: SG2PR04CA0165.apcprd04.prod.outlook.com (2603:1096:4::27)
 To BL0PR11MB2995.namprd11.prod.outlook.com (2603:10b6:208:7a::28)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR11MB2995:EE_|CO6PR11MB5633:EE_
X-MS-Office365-Filtering-Correlation-Id: 67397a9d-857a-4cfc-4d88-08dbfdf984d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Hjo2lDUnoJndTLwKTVQESlpQI9VtGkZuHGqMl9d3LFmB+4qz577ki3H0/b7KKGOkvbLgepi4sFrGpqapyVfsng0YgRw8nS+9DjRpMyqaF/HznnUZ4e76d25QvO8PkIxQM592WB6UopXTVWg/4oHRYRcL+e3A+E4mLnKd+NlVyDeLdHZz2oKDQl2hV5FbfAJtVLdSljwqVo7nzFYNlaCnj/Kn5KMD8ldDT712etRo/Mnp3rzOasZ48XyRYxdWF2wBRdMP2+c+5GODTKie2C6rrzDhbQfM9ZSYldXuIZMfp8ru72Tq0foRCcWbFDAyqXLbbJcvDAKtrfQD3G+dZxJuWsoMNqIplyS98ZfZbM5q/r0LeXy7JjE0m7wrlSSm2V6qDaaSHuQ1akwdeR90QAKM7kJv37O7qnIt9qoeJZT/HZ+nj4D4dpzBK2h9DeV741+r03kElzcm5FPDRxFjWs3ymUuGN4Zbdlb8ogPX0q8Dp7qGT/JCCCFpfNGBqRGc27TSSDUQnebhpKWq+Xaoz49MmA7SBP7cnM7Sf85iPuTbCI4GJ/c3q+4s7XZ8eKEp5cbjuGazT6Amh3yf8hBnelkeD9B1fAn6RNYeyVJmU03qbZVY86wpbUkfnXlZN2y2p1jcK/15sZofqCSDHazzsNw6tG5726h2dAI67RkEHhEoejY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB2995.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(136003)(346002)(376002)(366004)(396003)(230173577357003)(230273577357003)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(33716001)(82960400001)(2906002)(5660300002)(6666004)(6506007)(38100700002)(26005)(9686003)(83380400001)(6512007)(4326008)(478600001)(41300700001)(54906003)(66476007)(66556008)(66946007)(6486002)(966005)(6862004)(8676002)(8936002)(86362001)(316002)(6636002)(44832011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zhc7OaXmIBLzGHlLmq2BK1E4fjOe9nSka4rVvm+x0wBZl3E9MmQhaze41+Nj?=
 =?us-ascii?Q?RM4l1/laMdGcfnhdB3ihplSl0hrRhHspmcAedb5binATV0nrRA4Ms7hrXJm3?=
 =?us-ascii?Q?2w6cRZkZ9641b9QSEIfWwbwOaF6uV3ZnxgrIeSRmYVKwKA44ZdKJXM9Se50A?=
 =?us-ascii?Q?QjRPD/LtOrVfwL3IZbb4nI0eWJt5uUByESFi28YvW1VlBfSFNTMItL90nifG?=
 =?us-ascii?Q?OqDIU6OVbfjvgg+NNK5X/bUmLO0Bjsbf8+BFVJ27T9AUsvZjSgrwxlJKpjlC?=
 =?us-ascii?Q?W3QNnY6zU5wdKXU2zr0rU8iJ5P0lS14oyD7TjGD/zrsY9tjkp1/9BVAvWApR?=
 =?us-ascii?Q?SLDKPWBbtbA7Tv3ReZwgZCbiPsON69PbW/M0XxPv8nq0l7Hb2I2NOCE4UM2t?=
 =?us-ascii?Q?uVVEqao1bUnIiVlnj44+2Ru3cpAmVW4MtCVBm3FdEja6tEKra8eiWGFD3z/q?=
 =?us-ascii?Q?qcOEfXp3Ka3JPOdOi9jiVZOUrRAR5XfUYRE/LNjwn9mGgt5HXC7tObEGiXN7?=
 =?us-ascii?Q?C8vrZ2zxJ+0qBorjS3a/H7FbH+nUX+IFbfLNxWj70TwCq2In3JkpJPbF5VR1?=
 =?us-ascii?Q?FwSMYhD1jGAGCTAzALOMNlngK3eczCK9c7a1s95FIQViX8FNC7IYopb89zXd?=
 =?us-ascii?Q?CUEfL22Pq0lzt9n1kh1lQA3onvKCXKNO9W+bznNtDwSjOprm4MrX+4ObG5S5?=
 =?us-ascii?Q?YdEev189zJMM/ts7a2ibudwRsoD+rOw4PA64ssvUvkVonqFOfmwgNTurdO2b?=
 =?us-ascii?Q?ufDgv0TxU3YBhey1Z92oAol6dRxFOsR6KJSPp0sMnVQYP9vNiULfW+1l9a/S?=
 =?us-ascii?Q?dQTnNSi9pv2KWL2GmXwOC8esBC0XhcZFzNS5+NWor8VB3hMI47Z3pgq9bAFw?=
 =?us-ascii?Q?hEzGrHrt8T9lZxQR4p2vrnS3NSrjqLq2g2Ku8rkJjsOVnPieDPBsOxrL3yz5?=
 =?us-ascii?Q?81QE69MJjxSBOYnJRXtqqVkD/JEAnp1+yyGHwoisBXrnVK7aFfIIyQ98Z20F?=
 =?us-ascii?Q?MMXxzl5hY+OeoTwfT7V1uYlFSmmYHEaCZTlK0ZHAzap8yBg6MHWrQW0OQt2t?=
 =?us-ascii?Q?B3mlxkz1KhTdY5AgSQtzfgVcBZxI9xgd5dKJmnvIcoxmKS6xNwzpH+bvgKhV?=
 =?us-ascii?Q?Q2W969nPqhqLiEWDdJBSZaJZS2SWNJ5YELhtZNFEU828G5jXXQTehtOBRWsD?=
 =?us-ascii?Q?/oRgzUzomJjuBaUu6+9hUwfWgNSIHQZ5h6hehYh2ktNCEOSIRJFIY7loDCNq?=
 =?us-ascii?Q?RV6DmZIpKzCxXwZLU4VDU6oZSYN5QMqe4u4UpUEzzr8AQtPf4PW1EX5cRnmx?=
 =?us-ascii?Q?I6vl/OkUEKmg/eKQWA+ujobVR0Wc5nZay0tyC0ZqJFMZv1hdgzKEiY8GgFju?=
 =?us-ascii?Q?H1Vo20biMFgcVFPkIPjTBXslhA2vFoMWU2ne/WJjF+3Jp18gHvh+0WveVZDi?=
 =?us-ascii?Q?S49PG0ybk2f0A9FRHQie9K0af+VQ0R3x+LxU9bW5r0/S4giLLWn+Esyt4pcS?=
 =?us-ascii?Q?XSMrH73bzNyCN8uDZA5gEnc0TNdfcpG7/sHPxv4voHdOcrbIJ40GGSDFZqys?=
 =?us-ascii?Q?wJ1gRU9yRSBh3raEaJzElWmPnByQUmNUiHCsjXq1?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 67397a9d-857a-4cfc-4d88-08dbfdf984d6
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB2995.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2023 05:40:32.3682
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: peZlX+chA0AVq/zntUwNp9LDCWvTW5E2e8zsDoEmDkNj0vMO3DxRF4qRyhYJiJMp5s1LrJ8FruAg6JKRHYgkaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR11MB5633
X-OriginatorOrg: intel.com

On Sat, Dec 16, 2023 at 07:39:43AM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   3bd7d748816927202268cb335921f7f68b3ca723
> commit: a8eaf3ef549980719c5fcca257d5b220ac0f3f1b mtd: rawnand: marvell: Annotate struct marvell_nand_chip with __counted_by
> date:   3 months ago
> config: arm-randconfig-002-20231215 (https://download.01.org/0day-ci/archive/20231216/202312160703.nnQfaSja-lkp@intel.com/config)
> compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231216/202312160703.nnQfaSja-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of

Kindly ignore this report and others that are related to __counted_by annotation.
We will look for a way to avoid such reports which are duplicated with same cause.

> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202312160703.nnQfaSja-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
> >> scripts/kernel-doc: drivers/mtd/nand/raw/marvell_nand.c:352: warning: Excess struct member 'sels' description in 'marvell_nand_chip'
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
> 

