Return-Path: <linux-kernel+bounces-11313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 760E581E472
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 02:42:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51DFEB218DF
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 01:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BD3DED8;
	Tue, 26 Dec 2023 01:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EZk02Vqq"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E53A29;
	Tue, 26 Dec 2023 01:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703554944; x=1735090944;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=fZJquMZWhE8dHUccrYjOp2FTDDIkPnCt6yVOj4NDnLs=;
  b=EZk02VqqbW20B4/eiQ03/8B891sHwCTRFgVmWz9PCnIIi/XIEMv1rAFS
   kNfVVml5jdRCnSpj6sm8eJaaLVGzrmqthhG3wVipq2+e31Hf5A4UALl8g
   DbQR4fIP0xO+zJ6gWiFEhMGCU69MG1Znkx98oDC3UO7+dwLCaLLo3s2/F
   hNBA54Va+bZlwxHnnU5pTKLEcOTnu3+5uO/FK5Lkqm+0ry8V9b9Kf03Yt
   g2bvRXJLyWV0cbvHy8SF9CAF8opFKaoybxkEd7OFS26rUlHe+xogD9Xwf
   Wtx39WuyYlbWD+/QRSrzWWfjPisv+eJfI4SpE0kN7mdZEXrv+p921+GUj
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10934"; a="482489363"
X-IronPort-AV: E=Sophos;i="6.04,304,1695711600"; 
   d="scan'208";a="482489363"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Dec 2023 17:42:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10934"; a="812137111"
X-IronPort-AV: E=Sophos;i="6.04,304,1695711600"; 
   d="scan'208";a="812137111"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Dec 2023 17:42:22 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 25 Dec 2023 17:42:22 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 25 Dec 2023 17:42:22 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.41) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 25 Dec 2023 17:42:22 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hkORJOY0Bu5KVUsQjnXeb3XgR+yHHTip3IWqmdb7yHRisn+0xyUvEDIFm4W0ektFtHSIqln86fHtAD8GDo/UxKxW724mFE/nR2yf0aoQXB9Ogs7X+UIbWclPV44xHDw9yqMHkvVN5yC1NTVhk/uqieAJeOVUiTqi7U0S0ttvbrFCEyVt6ZZjf4hFlrLT+NvZUvDbOc/UOwASEZ5HFUgJ8xRj3HeHPPzzA+vYdiF3eMSeeCG1HNbbTmPdJSn3MWYgOvmoCODCDn/SJcv0fGQGxUFd/CDaFEEYqGYW5W7zTuq607LPPg5w7eMQ+IogBspORTzJw4fwLd042TyAOVwPKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g1hBvu+FyIanwD3BzgV/nNCDTksu046bjS+E5CLWBTI=;
 b=dEs20l6cv6pkHSjXXJyzakZazhem6MXc6BVYcR2TMC+OIKFVszYH/+9zjPtmI8rlLCpXrt3c5+o76mxZ2ElDCr1nI+ojsUyVzzQ770UTecLQsXn3Nou1znpYqw7AUO+zZVJBx9GFLX3Q6+Y/qwT5BrAiOtbkxC6KfhJhXpVlFs4iLUezzPbpylzBqJQrDALSElyiKHNVJ9OOHa+2+koD4tR/DrbFbrPP3PvLNxcB8QdVGtzM5sWB+RPwdAefFtHfbP+OIV7YCKysspkGA1QGrWKctBA/iDuMtf4FcBHfb9lBvRb06I5v5sE3jMi8iOhwAEKEaG6ILrGTp6Z6GEnkZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6392.namprd11.prod.outlook.com (2603:10b6:930:37::15)
 by CY8PR11MB7395.namprd11.prod.outlook.com (2603:10b6:930:86::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.27; Tue, 26 Dec
 2023 01:42:20 +0000
Received: from CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::15d3:7425:a09e:1c86]) by CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::15d3:7425:a09e:1c86%4]) with mapi id 15.20.7113.027; Tue, 26 Dec 2023
 01:42:20 +0000
Date: Tue, 26 Dec 2023 09:37:52 +0800
From: kernel test robot <yujie.liu@intel.com>
To: <baneric926@gmail.com>, <jdelvare@suse.com>, <linux@roeck-us.net>,
	<robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
	<conor+dt@kernel.org>, <corbet@lwn.net>
CC: <oe-kbuild-all@lists.linux.dev>, <linux-hwmon@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <openbmc@lists.ozlabs.org>, <kwliu@nuvoton.com>,
	<kcfeng0@nuvoton.com>, <DELPHINE_CHIU@wiwynn.com>, <Bonnie_Lo@wiwynn.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: hwmon: Add NCT7363Y documentation
Message-ID: <202312200129.7EYVeOyc-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231219080021.2048889-2-kcfeng0@nuvoton.com>
X-ClientProxiedBy: SG2PR02CA0100.apcprd02.prod.outlook.com
 (2603:1096:4:92::16) To CY5PR11MB6392.namprd11.prod.outlook.com
 (2603:10b6:930:37::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6392:EE_|CY8PR11MB7395:EE_
X-MS-Office365-Filtering-Correlation-Id: d038ce4d-9d45-4222-8ae9-08dc05b3e61c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WSkdvX08atHj1p5Q4eRkaHCE/K6h967keyYj346uO/5Ese57wA/h3YpT3V/vbx62WO/oTJWY+9katVbtBMcsIQf4b/FPr8RohpSbMN2dFhkk/Chxg6WAawuvY2BuoN7dtiPUW7snqntnVelQLC2wf+0CNPFAcwcIuIQuHn1NetKQiTOM0DSlThEM1JUqbuzCXwbQiFiCOoEsBCta0qBSnzFSsB/OxCPUoJ8O53yikUsGRFJ/dQYbHgX0zWnr4Z4bdMubN5drhZu42gbT3fVQI+wUjxA4tiMR+g0j/+DCUJhYKBfPvr/fReAB1LYAyiMb/AXzZFbOcAObkfzz7qCQ3ju/W2VXJVsADbDIYWJWnsiLjK1HsT6X+cJs3IOfVfFMc+qTihtJuBW/hgKv58HNFhcMAb8fztRkdmLsuK6CHuXCGpeEJZa/bFDGKOvuAa26YPmoqTfVnn8x69fnXQCN20pWkNO+7dJh11Lu2RSJw5B4Vyw7sjbRVIyO9Z6Ic6IsPh12b34/cc7zK+PP4Wett1doYrQjpuZ68gI5++/gVOScwspgKUMeK3/WXF9oo60CB8zbf3wh5zCWt1dHnckrMcPSf/d7XNCrSrqV9TqQPrIVNHkTwOkURhulfjogTZ05BrfXNIPAuZFDla/FeG1qr78cDancxj1ofV+xZJoWgys=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(39860400002)(366004)(346002)(396003)(230273577357003)(230173577357003)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(316002)(8936002)(8676002)(6666004)(6486002)(478600001)(36756003)(86362001)(1076003)(2616005)(6506007)(6512007)(966005)(26005)(82960400001)(38100700002)(83380400001)(41300700001)(66556008)(66946007)(66476007)(5660300002)(2906002)(7416002)(4326008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GvIMDTT4V+LmqT6eIHEdLx/cRgaOAB91+EntJqzuGpMyyXBXtweYZJgMlF3Y?=
 =?us-ascii?Q?Zq6vII5DSSOu/79fHEr8uQgtpre5IqwgjA2ZVxe2WLxE4FU845Ck+ABZJlCz?=
 =?us-ascii?Q?DdJJQ9MBW1z8RF2qDgwcn4OPU9/UlnaG2sH0LThMqbXGS8b0tpAAtZy/uPPF?=
 =?us-ascii?Q?JsAWX0VSFYSo0dOsEK76Wt6ZKUws7LU+ItVPfspAuDeOib950q7ddIrFo0Zf?=
 =?us-ascii?Q?r0UA946UshDAUtfY/x193la4zo+SECWO+y+d82kZUGw6T5NAPBaeo32elVjY?=
 =?us-ascii?Q?TVooBYCFhWmG9edOrplvz5b4YcsWQDkc1aDLnomApVYOvYuAXsh4Xw61pvad?=
 =?us-ascii?Q?MWPdTn7f5/qP8LLGXWqYD/07RagHN6S+Epq/jo9rBlR8ByK3uQT+8yELF+SA?=
 =?us-ascii?Q?Q/cpmQ5QJw2BV+zWhkQU48FgCKtoJVC31qsjhM4+44SVDOFJOoumVwpadDSq?=
 =?us-ascii?Q?PB70H6P96//gba03qlRVOcSCoYKGDCj+tQ0uTw71WTRoJXagDrNOKDphlFjd?=
 =?us-ascii?Q?suqJElNSv+urHWf75edXRzW9Sy8IdrxWelnAMVTCIUqWmgulX/SilLqJKhIQ?=
 =?us-ascii?Q?4hPPTq2lLoxjp6V2mQgxC8aeetRCbd/AwoJCV8NqNv3KT+Z0DYcajctxzmAY?=
 =?us-ascii?Q?d9PeVUyOfN0lSRMo2yXPEitheLR/Ax+9qRAe78BsIDc30xiWOwBuld1CgaIk?=
 =?us-ascii?Q?TfCebSJPkJCxK7ulrRBBCUZuwvqKhJTbYs+CFsYGIw46mHGAY1sBjwEoHoL4?=
 =?us-ascii?Q?m7svI+mWKuTySQaNBHTSohOFfm36p2uozU8QZG6CPsqOy91R1nnuogVQt3KZ?=
 =?us-ascii?Q?0WOgSCFcIv02EY0GBn20NMj6fzd2taLUrhvxgsSiJTOorpfBCZwc6MiKXJce?=
 =?us-ascii?Q?rh9KohQe6+Fc3j8568ZVN76oMTkOmCFawGwr80tT72kcR+3oVMklUclG/7xY?=
 =?us-ascii?Q?X698Qc0I+V5Wr8+iLEVYeIt+UcH3hzwfFIlVGdzBabSPo7rdGUjidIFi5bwj?=
 =?us-ascii?Q?N0h2k2+Ge1i00Kd/2QYFRMF5goKOk7Eo2z2cjjnrw3gHTnk1WOSj3qo/shHI?=
 =?us-ascii?Q?5411dfHxboCV8a+zcia+rlnptih4SLDFi+ZIrboQ3XO7gFa1+NNiFWpMqO4o?=
 =?us-ascii?Q?s+MlziN5QBdAPuEBjlbDbAI21II/jOBWzexhBsc8tWuWSfSoGBksKr5trPxB?=
 =?us-ascii?Q?SzXZPKwgFEJiLCKjODrJLzNpMGL/IL+MHKxB71ry7wm3kOXhT/TiluZw95ns?=
 =?us-ascii?Q?u6CPTj5/lNrGDp77FCaQBS1uKnX+yAhI3px0iZcxbIRTReX6w4tTfPvZ3LOC?=
 =?us-ascii?Q?sBDrWUUWV3iO0y8H6R8ABq5Y1NleEOP/XIDudaNLvXSVLg2FH9ErcKj3Hrtp?=
 =?us-ascii?Q?e2andiNVfB96NRpDpFTiqKbaG3s8lxXRJwO+oSZH6PghLYPpyabxCi6A9/Mj?=
 =?us-ascii?Q?GThF5xTh6miY3apXHM10hkwPy/aTqWhjzB9fyUGuN7gqaPgYPXmKGR0khMpg?=
 =?us-ascii?Q?nzHt9dZaF7Kw9dj8SROtaSN4n09qzwXZjQcz3Tl5GpPuukVGu4K+JVW7sBRz?=
 =?us-ascii?Q?+VWK2jUrg+heNE45oTLsqa0xcfzYPL8FLlPLtDZC?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d038ce4d-9d45-4222-8ae9-08dc05b3e61c
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Dec 2023 01:42:20.0293
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8V6rhBzk3mwJd54778ZWqlK6s2xpB5fjZ7QZRLuC59haPrqii5ThLyNNSIeZe0jMDeWr9tHykexzeqA1AwK/Gg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7395
X-OriginatorOrg: intel.com

Hi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.7-rc6 next-20231219]
[cannot apply to groeck-staging/hwmon-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/baneric926-gmail-com/dt-bindings-hwmon-Add-NCT7363Y-documentation/20231219-160534
base:   linus/master
patch link:    https://lore.kernel.org/r/20231219080021.2048889-2-kcfeng0%40nuvoton.com
patch subject: [PATCH v2 1/2] dt-bindings: hwmon: Add NCT7363Y documentation
compiler: loongarch64-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231220/202312200129.7EYVeOyc-lkp@intel.com/reproduce)

dtcheck warnings: (new ones prefixed by >>)
>> Documentation/devicetree/bindings/hwmon/nuvoton,nct7363.yaml:
   Error in referenced schema matching $id: http://devicetree.org/schemas/hwmon/fan-common.yaml

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


