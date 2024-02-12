Return-Path: <linux-kernel+bounces-61521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF6D0851330
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 13:12:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5F4F285DB5
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 12:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6C373EA73;
	Mon, 12 Feb 2024 12:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fNEs7VKf"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D253EA68;
	Mon, 12 Feb 2024 12:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707739637; cv=fail; b=PXRH9YU4rAjkUlC+n0s9oTuViCINV1JRV0fWKH2lHw/Ew5kV9K/aZlV89zi6lvjipbBVmveDS1EZOgDaBL4eNBH4HckNJk/gAdzx07Ez5zDX+3ONHEujLZM0FaHVsqBqIWGuNBSr++6oZsK1AOOy0TylOe0m5u2HNCi+YVTeNuc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707739637; c=relaxed/simple;
	bh=Mq7g6ETgf8RmZvRbrT0tTK+FDqyI+vfdIw9QDNtCV90=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ICMFU0NiGVJFx+cBqU0zoZbfAnft2hnoPSfkKS1U3SpLqZuhsADfeu2Gjaq1mPG212IAPvrUMFhLdI2IgLuf4b3dqb/eZBPOAPxQUD29qSo0cH/qnBxm1y01eaADsEtvfR5/8wE5Rfd+swhHiSS1ztarOXcbCRtWaCIKT2iArLA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fNEs7VKf; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707739635; x=1739275635;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=Mq7g6ETgf8RmZvRbrT0tTK+FDqyI+vfdIw9QDNtCV90=;
  b=fNEs7VKfU7rkyO1eYg2Ioma4UrmNXlK+9kL0nZe+FJoor68BEQtOVhNU
   +U10c4O541dVyqdUtPOOLTi3Ut24bWlsL+yAuBY89GOJHFNWGjgCCsRTL
   OP8LGZKjbRlS7dy+zIRRGIoICzBixaVnuwxJ3QrzulV7ACqvrmbnGzbIj
   K6r+0O2hIlU1en0wOsIv9HeIzXuj/qwHIu4etJgtlvjmNMrW+880dFDaA
   etNYHmaIpQXGsMl5iLMWE6MiXau8hH8oyru0hE77eqW+JloIH7fCTCbcg
   BrFichyWcQKTSN3cWyMLJPChLnSDOV5HeXpDGEQxf68YMFYm2mdlQkcL7
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10981"; a="1590248"
X-IronPort-AV: E=Sophos;i="6.06,263,1705392000"; 
   d="scan'208";a="1590248"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 04:07:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,263,1705392000"; 
   d="scan'208";a="2870489"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Feb 2024 04:07:14 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 12 Feb 2024 04:07:13 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 12 Feb 2024 04:07:13 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 12 Feb 2024 04:07:13 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 12 Feb 2024 04:06:18 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XzEIxr9s8HJ4nu+xY/LR32hW2gP1BGhNmIlMirC3Cs0h1ChqW4sizzKnY6jpz0jaFJo30qXCww1Cwt1RBdYqA0oTr8+RAkQMtbFPbPfKSEyXyQz+Uj8gWMNBbEz9tfeUlC8pDOSwi2AwK3CYF81EHA4PHk8UYbImtu1UAGBZi5ustgpuZKbf6X+nlQ9IE4TBg/bxwuDliEtNDjKyNLN2kmT2XbWhINyC09a6uW9XBKwDgkY8Tdj0qNqAA40Quxv1XCMuEBNPTevRO7ae8qDuBjy0uceviqdmUKb7FDrS1aGaZ51c8wPIpNMqbboB3AZ+wwzKOm5boxfqwOcp4vyFjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gflPAGqk2qHONdDDqEUHI+8m+VeNwYL+lLCI6FldUEk=;
 b=l9NrRC3VvRmO4YOa4nO6EgxWxx/yB1Agib1SvIReAz/45R/tW3vojgv5Zoyz+epnQePpZr0iZIDG9hxHvIcRS2qcthpczUAgaYBZe8U3h1GUA2L2GyYXsui8PQlIxUJaAjsFWsgeUYW91TS5Zz2otYWJrRlbRmf5QpXYgwSpZS+KtxGrELyyfVExxsSepgdz05Z3atgdhmOMkK8e1eT/ye7NLFiZ0NOggWf/1YPyhLw4M7I4AkDX3fX1Af02nXN0POJdT4gHp80Gkoecb+xTVBOJhS21m0jBE0cOZUsTOM6hyURmdAEZ795huqmEqp2ypQr8fMzsN2TJ0xsnvJ3j0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB8414.namprd11.prod.outlook.com (2603:10b6:610:17e::19)
 by SA0PR11MB4687.namprd11.prod.outlook.com (2603:10b6:806:96::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.35; Mon, 12 Feb
 2024 12:06:15 +0000
Received: from CH3PR11MB8414.namprd11.prod.outlook.com
 ([fe80::ed34:4cf2:df58:f708]) by CH3PR11MB8414.namprd11.prod.outlook.com
 ([fe80::ed34:4cf2:df58:f708%4]) with mapi id 15.20.7270.033; Mon, 12 Feb 2024
 12:06:15 +0000
Date: Mon, 12 Feb 2024 20:06:03 +0800
From: kernel test robot <lkp@intel.com>
To: Andrew Davis <afd@ti.com>, Sebastian Reichel <sre@kernel.org>, "Manivannan
 Sadhasivam" <manivannan.sadhasivam@linaro.org>, Cristian Ciocaltea
	<cristian.ciocaltea@gmail.com>, Florian Fainelli
	<florian.fainelli@broadcom.com>, Ray Jui <rjui@broadcom.com>, Scott Branden
	<sbranden@broadcom.com>, Bjorn Andersson <andersson@kernel.org>, "Konrad
 Dybcio" <konrad.dybcio@linaro.org>, Sean Wang <sean.wang@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
CC: <oe-kbuild-all@lists.linux.dev>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-actions@lists.infradead.org>,
	<linux-arm-msm@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>, Andrew Davis <afd@ti.com>
Subject: Re: [PATCH v3 13/19] power: reset: msm-poweroff: Use
 devm_register_sys_off_handler(RESTART)
Message-ID: <ZcoJq8o/ZeJEQjis@rli9-mobl>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240208170410.67975-14-afd@ti.com>
X-ClientProxiedBy: SG2PR04CA0165.apcprd04.prod.outlook.com (2603:1096:4::27)
 To CH3PR11MB8414.namprd11.prod.outlook.com (2603:10b6:610:17e::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8414:EE_|SA0PR11MB4687:EE_
X-MS-Office365-Filtering-Correlation-Id: fa08c101-2c65-40fa-2bf8-08dc2bc30358
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D8+SWQr+jgp1rNf2Uni/XnrL5AmYEljBOm4lM8u/akuBaUZMYl2Uuxym8K7FsqSCkBFEG/gyiOKEOGc+3nHhOWVvhZPxC7k9neW/fXOkcbpLZnVxD1420S6BZ/znWVOwfCG2+H9++XafpZciXsFbDr5o5WJs+zh/h0FV58TVh9FZ9csM/Tc8gfcULEEdqRRUo+v+Ehzw7c543mnGVHEAM9cZluAlsXcFWTbUuo/CtdF9PeROjwZYuQ5hi2wchIXWwog9qpBOxhQfWpScPWkKcLp3Tjze/p0IFmghlwtijCYn7g2UkzIJC7aRU6mc+12snwj215iW0paIN38UobSef6bJKEzJna5ZvouDSrn9KQ66/J7QJmyuhDOCDTGiCr0+xhIwbZ3NSXIb3jFUKNC0S00VrGYEN8Xz9OTW5uJM9jDpTo5kWCDOIPJ4QPZQage9duvA9qZZ1J8UaEeqBYBsOmrxQ2fPmw+XkdyAH6le7JOOmJuDjaoUKSFssG2gxIQHLov5oEviMqz5AnVZ7ZS4MVV8hq8SO0N7PgKpMiC8fIPyc2ile2hfS/4WgNwshS2+yaHiegy4UiJzyL4IIh/UZzBVlAx94VOlANhPPqvmMjvFU4bcEcwoqcOmj0a+koIn
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8414.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(136003)(396003)(346002)(376002)(366004)(230273577357003)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(9686003)(478600001)(6512007)(6486002)(966005)(41300700001)(33716001)(7416002)(8936002)(4326008)(8676002)(2906002)(5660300002)(110136005)(66476007)(6506007)(6666004)(316002)(66946007)(66556008)(83380400001)(86362001)(921011)(82960400001)(26005)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5HPLLbewf0+f8bm9/rmfa+nUGm6T6xl0/yaV0U4xJY8vxgSdcFPQ84tusyMQ?=
 =?us-ascii?Q?n8J1iHrtgy0FpD64255Q1J1VH74ZCACad2c9MF7kYpsmGPAsot5xYfoOAws7?=
 =?us-ascii?Q?hwYTubDUuRIQzRIdv8pu8nYp3TXUujIuBk8PAbmbsKpLo4SgQQCx1NSpZWYm?=
 =?us-ascii?Q?+UyVML90czB7Vid6g6DmoHQMVn/v3+RnX5F+TygeViWFn5uQFwz7cMu9sida?=
 =?us-ascii?Q?T3FH1lxIe7yNnKZEEaolhZRjMTY2BtIOD81v+DqIjjQ2pTGCaEkYU3YdsM3d?=
 =?us-ascii?Q?UQNvkr7tPXji6Om22LN0CbEpYRrJknbPzn5os+ozoBtpz//jPHLyNMkEBuJW?=
 =?us-ascii?Q?Rh6P1zhdoSvEnVvs2DAOoD6ZMXaP3/s6C0iHacqLb495oRB8e60xyOEFvIaL?=
 =?us-ascii?Q?pzZ85hKFnG08rMglgi801TbiVp3o4gOaWEuXKXJrEmINij5PvS9Yg4XGgQpv?=
 =?us-ascii?Q?RV2tsxEqMnvysDY0xV3Lgem8tcKY4kK5lg+Bxh/Cg2wgsA4iTeYNBiTIUrlO?=
 =?us-ascii?Q?HOliCRPgJL5LQESeWSZ94x10TPcjLnJJr+Xe1zXxLzdDP2Zt4vwSd7bSrC+d?=
 =?us-ascii?Q?Kkp5TsGf4oPm17DFmfZdXKc4gnGzImsvAguU+inlk2G0xbh3cSEhbjBbFkZV?=
 =?us-ascii?Q?M9zNotqmZRoWcENr8BFpt8FspHJPrghtl5BUTOaqlFPCwIyH3Xwiujf7n0Wm?=
 =?us-ascii?Q?11yKN/+MLAa6iVVI6hPHaNLt5xJthGiXRV7PGXaEwN+8hBHWecsrVwd/wQBj?=
 =?us-ascii?Q?uDyG3QSU93EHEdYIZwTwzqWUQWlm3c4qi0lBB8CqdK8PqOq1iy/fj3JW+snc?=
 =?us-ascii?Q?irfkpocxexDYdy6sDX/UZ0mB4EEjKKu4xL4TK4RWgBpM4p7eJkrFr4+OSTQK?=
 =?us-ascii?Q?U/DU0Yx/Ob+avW3ntXk0B245rzD3RluZlO6Rg8gQEm6wOgXjodvmCg7BCY7C?=
 =?us-ascii?Q?7ZIcNFuCUAC2v5BPeILlpa2hbShEt+90f1bnACDKdhzXocHQhJHr1kN4LVE3?=
 =?us-ascii?Q?p9WGR2xBtyMX0EJgxISgjzSSyf3A+4RKiowuryG2fssFh7wofwWhD9TGrmi4?=
 =?us-ascii?Q?Jghl0hZiivngx71TobCq5bCGTStPk6KM3nA1cxtodHKED2tiQ4EkmmhFGLcz?=
 =?us-ascii?Q?SjPmr4/s4V7vhX8bNAUWMvXo0qZ841fpjXQ6bbEwp/PcrMdXKk+UcmsifLKv?=
 =?us-ascii?Q?vzLq4664c4Qp70+AWe/QLATumKe2uyHuCv3g7ICoy6s5Gv4pcFsjoV2uig/b?=
 =?us-ascii?Q?MQTO2zRxCXtKBjqLnhSfTuGitscOelZ60VQzjlaIBWfu12zP/ft85GkYzGvJ?=
 =?us-ascii?Q?YdGbmP1zSOjJ9f9GJVNlF3Kj/Tyh4RAM8074kDRTt2BE3ZqT+UyGnrtXl0j4?=
 =?us-ascii?Q?9unrF/Oxlvr8LAa/A2EEVGjCysIFLfpFriyKam1XS8q/bZS9hKU4SuB9rgYK?=
 =?us-ascii?Q?9WUDOzESBDYHnqGkSsrgenxj5IhahivYTX/BOIFIWELK1GE+EHcd8+AXqAXb?=
 =?us-ascii?Q?X2e4uyquhn3WPWu5j4VYt0Bw3YNB9JUs8736VBYqAwp+Ku0HCBOIfp0tbduO?=
 =?us-ascii?Q?ueQEmOXYoEeW7pKyQZ6L8jE5nJhnNJpZVENT6pCp2y8IRD5KZdB9OiUnFPCx?=
 =?us-ascii?Q?tA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fa08c101-2c65-40fa-2bf8-08dc2bc30358
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8414.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2024 12:06:15.7388
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t9XLQe7DQk3fK/y0FayohSI2NjwPKBF2kqDCKbZ9HiHvSE8X5pZM/bElkVKo+yLCS2KFedRRCXZ2E9fmlBxU7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4687
X-OriginatorOrg: intel.com

Hi Andrew,

kernel test robot noticed the following build warnings:

[auto build test WARNING on sre-power-supply/for-next]
[also build test WARNING on mani-mhi/mhi-next soc/for-next linus/master v6.8-rc4 next-20240209]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Andrew-Davis/power-reset-atc260x-poweroff-Use-devm_register_sys_off_handler-RESTART/20240209-011655
base:   https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git for-next
patch link:    https://lore.kernel.org/r/20240208170410.67975-14-afd%40ti.com
patch subject: [PATCH v3 13/19] power: reset: msm-poweroff: Use devm_register_sys_off_handler(RESTART)
:::::: branch date: 4 days ago
:::::: commit date: 4 days ago
config: arm64-randconfig-r131-20240211 (https://download.01.org/0day-ci/archive/20240212/202402121342.7WgNqBu9-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20240212/202402121342.7WgNqBu9-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/r/202402121342.7WgNqBu9-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/power/reset/msm-poweroff.c:18:41: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void [noderef] __iomem *msm_ps_hold @@     got void *cb_data @@
   drivers/power/reset/msm-poweroff.c:18:41: sparse:     expected void [noderef] __iomem *msm_ps_hold
   drivers/power/reset/msm-poweroff.c:18:41: sparse:     got void *cb_data
>> drivers/power/reset/msm-poweroff.c:33:61: sparse: sparse: incorrect type in argument 5 (different address spaces) @@     expected void *cb_data @@     got void [noderef] __iomem *msm_ps_hold @@
   drivers/power/reset/msm-poweroff.c:33:61: sparse:     expected void *cb_data
   drivers/power/reset/msm-poweroff.c:33:61: sparse:     got void [noderef] __iomem *msm_ps_hold
   drivers/power/reset/msm-poweroff.c:37:39: sparse: sparse: incorrect type in argument 5 (different address spaces) @@     expected void *cb_data @@     got void [noderef] __iomem *msm_ps_hold @@
   drivers/power/reset/msm-poweroff.c:37:39: sparse:     expected void *cb_data
   drivers/power/reset/msm-poweroff.c:37:39: sparse:     got void [noderef] __iomem *msm_ps_hold

vim +18 drivers/power/reset/msm-poweroff.c

78be3176c4335b Abhimanyu Kapur 2013-07-30  15  
bc460fab0b719d Andrew Davis    2024-02-08  16  static int do_msm_poweroff(struct sys_off_data *data)
78be3176c4335b Abhimanyu Kapur 2013-07-30  17  {
bc460fab0b719d Andrew Davis    2024-02-08 @18  	void __iomem *msm_ps_hold = data->cb_data;
bc460fab0b719d Andrew Davis    2024-02-08  19  
78be3176c4335b Abhimanyu Kapur 2013-07-30  20  	writel(0, msm_ps_hold);
78be3176c4335b Abhimanyu Kapur 2013-07-30  21  	mdelay(10000);
18a702e0de9879 Pramod Gurav    2014-09-25  22  
18a702e0de9879 Pramod Gurav    2014-09-25  23  	return NOTIFY_DONE;
78be3176c4335b Abhimanyu Kapur 2013-07-30  24  }
78be3176c4335b Abhimanyu Kapur 2013-07-30  25  
78be3176c4335b Abhimanyu Kapur 2013-07-30  26  static int msm_restart_probe(struct platform_device *pdev)
78be3176c4335b Abhimanyu Kapur 2013-07-30  27  {
bc460fab0b719d Andrew Davis    2024-02-08  28  	void __iomem *msm_ps_hold = devm_platform_ioremap_resource(pdev, 0);
78be3176c4335b Abhimanyu Kapur 2013-07-30  29  	if (IS_ERR(msm_ps_hold))
78be3176c4335b Abhimanyu Kapur 2013-07-30  30  		return PTR_ERR(msm_ps_hold);
78be3176c4335b Abhimanyu Kapur 2013-07-30  31  
bc460fab0b719d Andrew Davis    2024-02-08  32  	devm_register_sys_off_handler(&pdev->dev, SYS_OFF_MODE_RESTART,
bc460fab0b719d Andrew Davis    2024-02-08 @33  				      128, do_msm_poweroff, msm_ps_hold);
18a702e0de9879 Pramod Gurav    2014-09-25  34  
521ef776c49589 Andrew Davis    2024-02-08  35  	devm_register_sys_off_handler(&pdev->dev, SYS_OFF_MODE_POWER_OFF,
521ef776c49589 Andrew Davis    2024-02-08  36  				      SYS_OFF_PRIO_DEFAULT, do_msm_poweroff,
521ef776c49589 Andrew Davis    2024-02-08  37  				      msm_ps_hold);
18a702e0de9879 Pramod Gurav    2014-09-25  38  
78be3176c4335b Abhimanyu Kapur 2013-07-30  39  	return 0;
78be3176c4335b Abhimanyu Kapur 2013-07-30  40  }
78be3176c4335b Abhimanyu Kapur 2013-07-30  41  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


