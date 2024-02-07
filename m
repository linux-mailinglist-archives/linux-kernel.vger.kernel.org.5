Return-Path: <linux-kernel+bounces-55883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F77E84C2F4
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 04:16:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A75671C2173B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 03:16:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01865F9E0;
	Wed,  7 Feb 2024 03:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SGrHyh5z"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1CFA14A82
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 03:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707275805; cv=fail; b=W6M0PTAzlSCvPthbOhh5uKdZYbuPxWsjKmmDPPZzyWk4ZwU+cxBMGtgOQoVmZ+EgBi11qq5kV0xvo7Dcwk0h3vVBqLfcy4sPDHTlksUprA+z5Kz1BtsWf5sCI/pDlsMixjXmoHhAqsuYyiViKSQVOM+2bODtjAFP/6JHKySj+/E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707275805; c=relaxed/simple;
	bh=bxGfaVdQ4NFYx4cJFhfjtC0fanSo4gVymYe/vHSqukQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FVuCh8r887HNpymGK+WfJjlgxVmxWYTZFqQ1HAstOTSBoruTSyzpLzTxzPdPUQgL/isQpJKAdXmCyYUFwqi109FHPgT5nAH3DWhp6kmYVZRF4tu34Myy8rrzM/yS79VwqIZlMi7GkoFEiXclZYq7AN3rho+MiEsdT+W2EoE4h5A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SGrHyh5z; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707275803; x=1738811803;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=bxGfaVdQ4NFYx4cJFhfjtC0fanSo4gVymYe/vHSqukQ=;
  b=SGrHyh5zcFIakSPnrtPVmtlNEc/ikZh7KHE7F+pfQ+zCD9EdaSTygluM
   veQBP6NOzWVTgt0rEo40OWg4uBBXTj2mdih8GTrvkvAshCVCyFqTMwXth
   2LgmP7KAh6t2ya4IIDeCzQpWc0TMo9JSiiXnb3nwYo33VdvKNBubVaLQI
   JbSkzR5EnTMlid+oubYSm5PoUsWKrU4I5mWxHutdlSXgJe93PW7hrnSMj
   qE9cP/fQlmZ6bG2fc+qL0wAyjY7w+wZbrwpiTLoOOR2qMackTSVHKv/KZ
   fINufz4HwD2kVU3DUdTPU0n5mko5PLgtsk7n5/jgslvOUQHjx2A8Iz7L9
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10976"; a="1045637"
X-IronPort-AV: E=Sophos;i="6.05,250,1701158400"; 
   d="scan'208";a="1045637"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 19:16:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,250,1701158400"; 
   d="scan'208";a="1212585"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Feb 2024 19:16:40 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 6 Feb 2024 19:16:40 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 6 Feb 2024 19:16:40 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 6 Feb 2024 19:16:40 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DYPepoy8tuB/2Bcf7N9+HVsRrwyuU286XWvNLgm3N4phlv+JZZKUuRq/3Kx6UrKR8Wxdq+yUAagZoXWgasKhsa7kVa9pU7pegkuX8raUUZxN5rNDvGYZvJVYTmOotUWsul1uuxVAaUSB/535jot2sPRtMI1cZWUvlOHmNG6d3a667+PhkT357hN14iZpRCYsCabTeV0R8aWSbZ+htyxhPzszfIAQl0OO/txxZ4uDDmPpbulMnqC4NF0CUflngFqrSijjObPeTD0IBA3OaSuafSx3A/JBPUKYuy9Qsf4hqPwklyPckmLzr7/TqWAutiolt9L6v+kNmNrRKKfS0PGm7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xoZ+FHkwnf42CtxMTZ/JjrDlSCMUynVUng+V7rAG93g=;
 b=UarzU9oiwbkatChF2a6BGYk/GBEimZpadTbdrVQpDeUqPVwYlfbHm53nz2Fbq/rA3oc+UVEg3jpQn269KlJqAMbCnMI1bRKhFvxotDXtehfncFKJs/i2R6QVM60sPtEeiXnov2UEsYWR5PdLTEWTLu6U0ylnYIYb0RslCYHo0zpGLFhbcGnUZhFrDQE2YsXQ+se4lqPgmBIA99mUJBZBM3ckheUV7ACzPKoSkPWQPKlej8ZMqI/V6GVg8h3+dHX5AFypTkTjsjXS5dTFEkeoRhb6luvPeIpDK7hUCLJHpFA5Mf4T8iJL0mk8/mQOXG6HuJvwnjOggPIJIg3LDe7+3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6392.namprd11.prod.outlook.com (2603:10b6:930:37::15)
 by CO6PR11MB5604.namprd11.prod.outlook.com (2603:10b6:303:138::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36; Wed, 7 Feb
 2024 03:16:37 +0000
Received: from CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::b99c:f603:f176:aca]) by CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::b99c:f603:f176:aca%5]) with mapi id 15.20.7249.035; Wed, 7 Feb 2024
 03:16:37 +0000
Date: Wed, 7 Feb 2024 11:09:36 +0800
From: Yujie Liu <yujie.liu@intel.com>
To: "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>
CC: "Zhuo, Lillian" <Qingqing.Zhuo@amd.com>, Alexander Lobakin
	<aleksander.lobakin@intel.com>, kernel test robot <lkp@intel.com>,
	"oe-kbuild-all@lists.linux.dev" <oe-kbuild-all@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Siqueira, Rodrigo"
	<Rodrigo.Siqueira@amd.com>, "Li, Roman" <Roman.Li@amd.com>
Subject: Re:
 drivers/gpu/drm/amd/amdgpu/../display/dc/dml2/display_mode_core.c:6193:12:
 warning: stack frame size (3368) exceeds limit (2048) in
 'dml_core_mode_support'
Message-ID: <ZcL0cH1LZteapnTG@yujie-X299>
References: <202311200955.pmjdQEM1-lkp@intel.com>
 <a856cbeb-dd2e-436b-a7f2-74d3493df18e@intel.com>
 <PH7PR12MB583196EB28781C92A00970C1FB462@PH7PR12MB5831.namprd12.prod.outlook.com>
 <CH0PR12MB52845186C7D747A4547DA99A8B462@CH0PR12MB5284.namprd12.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CH0PR12MB52845186C7D747A4547DA99A8B462@CH0PR12MB5284.namprd12.prod.outlook.com>
X-ClientProxiedBy: SI1PR02CA0047.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::15) To CY5PR11MB6392.namprd11.prod.outlook.com
 (2603:10b6:930:37::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6392:EE_|CO6PR11MB5604:EE_
X-MS-Office365-Filtering-Correlation-Id: 54ebe6f4-394e-4b61-84dc-08dc278b3201
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W+9lxMZ/mUC8P8/NDWvhTT6JGZ+s6QcipMNhu56z0ONxSiADSzD4zAHR7G6+o5WkZJYNsaBRe+8OXVMae6Mlw6DO/Hf6tu1Y/cyJYsnUFORWeGFAJ/J80/Kx77s0Op1Sv5x1mdsJWjE+oUbfiNGvkXXKkgjQGidEXL5jz3vHvUCvt1gOkJTKT3R0l25SIUcM4FohjSvTQ34BNRScAUQqW7zsVrl1d3PmY2dAnQlyT5hjxc6qsxtIsfNIQeUhHwo4ZbRCNvTTCdvx8Aw9ZDxqWrmUF4GN8LAgT+bi8JWWZFkg1PiADBUiNpw1te9QrHYiuMRXrrxEK1fWN61BBdanio/DovY02a/2D9oK72D+j2Jbrg4rEhwp/YL1pW3iQ7PuaU82QUnOXZ3QNa9ivW+wZOEKQMIKL1EoRam/JZa8GZ3oqo645W5ir49XRlaxTIG6odEQiulHcc1KnqBcgbTngVQAKN63cg7UZ2oBdL8fiK2faDlwwkP7bpvgGtA9tqFdnS6cp8y4SYaBXfOOGGUAqP1pzaCkcqr954mIfuGHgR8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(396003)(366004)(39860400002)(346002)(376002)(230273577357003)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(41300700001)(33716001)(66476007)(66556008)(6486002)(66946007)(966005)(54906003)(6916009)(8936002)(53546011)(6512007)(478600001)(8676002)(6506007)(4326008)(316002)(9686003)(38100700002)(82960400001)(86362001)(83380400001)(26005)(5660300002)(44832011)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CEFYB6oCYlOy/QXi1EzMBchhHttW8r7lMHkyRznqBvwj8xDaMs41r0ie20DB?=
 =?us-ascii?Q?X7JA9Hqy2nTv/dPyOTH+o0MegUhPelBwbdZ41TOny+ungpXxa7Pi7RiVoH3s?=
 =?us-ascii?Q?XFEfW6SQnmCMSZt7u0a1FH23dCJUfHSsw83MU8zAWG/2SPck0o44E+WILlqA?=
 =?us-ascii?Q?+NbQEYjUiGKSLSTX3H+WowF3yEgFU0Lxot0Z3SAyAKDhp9mKuyqci5QQ9n73?=
 =?us-ascii?Q?6BX0+UJy2vU+xvLPZsP6EBDu5MXFmzfKulJ3eqjMSKHRnQ2s9aN7q4ObWqe4?=
 =?us-ascii?Q?g17MXc99qGIfbhmF6kGx0F8uDBkE+X3g1Zc7uDfOXkNQjEiwN+GQDraFvaBX?=
 =?us-ascii?Q?NvM2UqsDNdpcVyqnl1FT5o1eZu49ofhpcjLJ19jir1Jmlx6lkw3bot1LGpDa?=
 =?us-ascii?Q?DGlENlUBkKob6MCh8dYmAL3s614GUisJGIkisRbBAt6QPnh4dmrmIzauYzzC?=
 =?us-ascii?Q?3du1yrfi5BWlDeFLJmy0lhEr5ZdPFT0cdbkjDt2Rjm1naazPd7MZAKsUND/a?=
 =?us-ascii?Q?6V/RkC7tiMCuIlcQbtRTp+pn0Xvnd+xfkD5joK/v1bEATGBcUleOVeIEtuuV?=
 =?us-ascii?Q?XMrD11tiog+hUWcTy6NPEQvHLEHENT1ZDbKaB2g3mn4bmFqZAl/9sfJ27W6M?=
 =?us-ascii?Q?I4qOmTDlaV/8Cw1U7EPr/t1YDy3fj1ST4zZqyhaQo1pWKDsVupUqK0z6qedf?=
 =?us-ascii?Q?7+w771dAcLus6xijVwIT6YDmm7LnMjlzH/PWLww2YKGZhtUjQdhJyRrQRsRy?=
 =?us-ascii?Q?cCFu/F5QSIIbTlWq0Npmh1zI71BMqobdBJjS3xpy86IAoIg4dQtwRaNMpJgd?=
 =?us-ascii?Q?KEp+m8E1lkW+GEshB30oLIrKsvXI4YvSrXl4RHyhouuwuwqVlOPPSSEbfW94?=
 =?us-ascii?Q?H4iBFlH20OegyUMcjv2UDTZ805MHuerlN1nmOdO6wUAzpZ5gZa4mzRwpGrao?=
 =?us-ascii?Q?d5gbZEc0c+4cM6qyFZqGmBjCIIr/Bjy6WuRXJMb50TUWoJQJm+O50iyP7H1S?=
 =?us-ascii?Q?6MGTbKREX/bB3/G0UYbHATzH4vQkrIZWwVaMVme1s6BU0FeZZDu8JDO4qugt?=
 =?us-ascii?Q?q2bWQZKbF1gEYmAkh/wfhmrbFWG/6m4RM8mLMszSXMTu8+3sxxxP/ZeCkFRl?=
 =?us-ascii?Q?+UyzIWBya650rPdPGNtWeebMTTAHtCtGkEQEE9kUlOR6av6sG7B1qe3QUlEw?=
 =?us-ascii?Q?KK9L+jXsziYXDGY6crfrMhKv3v7gR9Ql1c7lFIfWGh80Sh1kyvqebpfP2Lvv?=
 =?us-ascii?Q?XuoYukASQ7tByWnudCntTP5MTOha+QQfO3NZ3USfANFKBnftFZKh1d7q/ktY?=
 =?us-ascii?Q?ccZQtZdiKA5prtIkz3Bb27qZJmiCx3z2zh9UQHcnfdT13StkgPXnFzzstyOC?=
 =?us-ascii?Q?yGVyEzxE1jLvqJtn+7tqXjiAtlbYSFrbKeD2JdbDaf+KEEHHyNyPa3b0K1oa?=
 =?us-ascii?Q?b3D5rvZyaphURsp74EvTKMuKxCVPJWkC1Khxtg0C8iC2aaib6Ciz6Jfw9Hqk?=
 =?us-ascii?Q?J59CqWGRVfA3rXkfvpJTELV14TTpFEmboYuY7FsI6Gwg3m5m+WT92NLmaSos?=
 =?us-ascii?Q?3hrkzkqtWsXR5WD7hZmIEecR6kQjvvrNM3RXZicT?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 54ebe6f4-394e-4b61-84dc-08dc278b3201
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2024 03:16:37.5933
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TGUgTFP51pLLgxGgrS/873CX5ynfLf2vDsAAOLHbiuBasTowfOcFOhOpmLg4d0eulfnc4cAGkYj+gJFJ6hTkOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR11MB5604
X-OriginatorOrg: intel.com

On Tue, Feb 06, 2024 at 04:18:55PM +0000, Pillai, Aurabindo wrote:
> [AMD Official Use Only - General]
> 
> Hi,
> 
> I tried with LLVM16 (from Manjaro) and couldnt repro the issue on both mainline and amd-staging-drm-next. Could someone share the config used for this build ?

Hi,

There is a "reproduce" link in the original report. Hope it would be
helpful:

reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231120/202311200955.pmjdQEM1-lkp@intel.com/reproduce)

For a quick check, please kindly try the following steps to reproduce
the issue:

$ git checkout v6.8-rc3
$ wget https://download.01.org/0day-ci/archive/20231120/202311200955.pmjdQEM1-lkp@intel.com/config -O .config
$ make W=1 LLVM=1 ARCH=x86_64 olddefconfig
$ make -j$(nproc) W=1 LLVM=1 ARCH=x86_64 drivers/gpu/drm/amd/amdgpu/
..
drivers/gpu/drm/amd/amdgpu/../display/dc/dml2/display_mode_core.c:6710:12: warning: stack frame size (3368) exceeds limit (3072) in 'dml_core_mode_support' [-Wframe-larger-than]
dml_bool_t dml_core_mode_support(struct display_mode_lib_st *mode_lib)
           ^

Best Regards,
Yujie

> 
> --
> 
> Regards,
> Jay
> ________________________________
> From: Zhuo, Lillian <Qingqing.Zhuo@amd.com>
> Sent: Tuesday, February 6, 2024 11:06 AM
> To: Alexander Lobakin <aleksander.lobakin@intel.com>; Pillai, Aurabindo <Aurabindo.Pillai@amd.com>
> Cc: kernel test robot <lkp@intel.com>; oe-kbuild-all@lists.linux.dev <oe-kbuild-all@lists.linux.dev>; linux-kernel@vger.kernel.org <linux-kernel@vger.kernel.org>; Deucher, Alexander <Alexander.Deucher@amd.com>; Siqueira, Rodrigo <Rodrigo.Siqueira@amd.com>; Li, Roman <Roman.Li@amd.com>
> Subject: RE: drivers/gpu/drm/amd/amdgpu/../display/dc/dml2/display_mode_core.c:6193:12: warning: stack frame size (3368) exceeds limit (2048) in 'dml_core_mode_support'
> 
> [AMD Official Use Only - General]
> 
> + Jay, who is looking into the issue
> 
> -----Original Message-----
> From: Alexander Lobakin <aleksander.lobakin@intel.com>
> Sent: Tuesday, February 6, 2024 8:20 AM
> To: Zhuo, Lillian <Qingqing.Zhuo@amd.com>
> Cc: kernel test robot <lkp@intel.com>; oe-kbuild-all@lists.linux.dev; linux-kernel@vger.kernel.org; Deucher, Alexander <Alexander.Deucher@amd.com>; Siqueira, Rodrigo <Rodrigo.Siqueira@amd.com>; Li, Roman <Roman.Li@amd.com>
> Subject: Re: drivers/gpu/drm/amd/amdgpu/../display/dc/dml2/display_mode_core.c:6193:12: warning: stack frame size (3368) exceeds limit (2048) in 'dml_core_mode_support'
> 
> From: Kernel Test Robot <lkp@intel.com>
> Date: Mon, 20 Nov 2023 10:01:21 +0800
> 
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > head:   037266a5f7239ead1530266f7d7af153d2a867fa
> > commit: 7966f319c66d9468623c6a6a017ecbc0dd79be75 drm/amd/display: Introduce DML2
> > date:   6 weeks ago
> > config: x86_64-randconfig-121-20231119
> > (https://download.01.org/0day-ci/archive/20231120/202311200955.pmjdQEM
> > 1-lkp@intel.com/config)
> > compiler: clang version 16.0.4
> > (https://github.com/llvm/llvm-project.git
> > ae42196bc493ffe877a7e3dff8be32035dea4d07)
> > reproduce (this is a W=1 build):
> > (https://download.01.org/0day-ci/archive/20231120/202311200955.pmjdQEM
> > 1-lkp@intel.com/reproduce)
> >
> > If you fix the issue in a separate patch/commit (i.e. not just a new
> > version of the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes:
> > | https://lore.kernel.org/oe-kbuild-all/202311200955.pmjdQEM1-lkp@inte
> > | l.com/
> >
> > All warnings (new ones prefixed by >>):
> >
> >    warning: unknown warning option '-Wstringop-truncation'; did you mean '-Wstring-concatenation'? [-Wunknown-warning-option]
> >    warning: unknown warning option '-Wpacked-not-aligned'; did you
> > mean '-Wpacked-non-pod'? [-Wunknown-warning-option]
> >>> drivers/gpu/drm/amd/amdgpu/../display/dc/dml2/display_mode_core.c:61
> >>> 93:12: warning: stack frame size (3368) exceeds limit (2048) in
> >>> 'dml_core_mode_support' [-Wframe-larger-than]
> >    dml_bool_t dml_core_mode_support(struct display_mode_lib_st
> > *mode_lib)
> 
> Ping? This still happens on the latest RC and linux-next on LLVM 19 at least (-O2) and breaks CONFIG_WERROR builds.
> 
> >               ^
> >    2183/3368 (64.82%) spills, 1185/3368 (35.18%) variables
> >    drivers/gpu/drm/amd/amdgpu/../display/dc/dml2/display_mode_core.c:8241:6: warning: stack frame size (2232) exceeds limit (2048) in 'dml_core_mode_programming' [-Wframe-larger-than]
> >    void dml_core_mode_programming(struct display_mode_lib_st *mode_lib, const struct dml_clk_cfg_st *clk_cfg)
> >         ^
> >    1441/2232 (64.56%) spills, 791/2232 (35.44%) variables
> >    4 warnings generated.
> Thanks,
> Olek

