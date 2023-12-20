Return-Path: <linux-kernel+bounces-6434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 647508198C7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 07:47:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA19EB20F89
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 06:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2199A11CBA;
	Wed, 20 Dec 2023 06:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lfme1tHX"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78408168A9
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 06:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703054829; x=1734590829;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=5BZWZU1ihRpZuYFzp5PdnIo0D5MAeQNHXFog4dkyVUI=;
  b=lfme1tHXJXlzPlE91JNLLWZsOcBtgc2D98KV1l9WlFIJC6vL6PgDyR1Q
   l7DDItBD0kAdKfZEejL9paxa6GqFRc043wkJ9VUjgLoqjrPxuwDtfxZo9
   AnCwhz6M2dkCLXmy4m/hv+hxu5uOzNelexTstfHHprHaT8hKhgme95U4h
   BQpSuWT0rythbzM6Kpz+LrbighKt/AWM6KPMY80eG9ZUMRC2hD/kWX5Te
   nF2ul2/IA8KqB8FpUJO6jph+RYGVvvLdaCYCUbGRcaErTCnv+Jkhvtkj9
   h+7Nvtv/tPcc0wcP/mdvEq/l7mBxqNliybl1WWE2I3aRsiwQXpM3kSw6m
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10929"; a="481960269"
X-IronPort-AV: E=Sophos;i="6.04,290,1695711600"; 
   d="scan'208";a="481960269"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 22:47:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10929"; a="846618031"
X-IronPort-AV: E=Sophos;i="6.04,290,1695711600"; 
   d="scan'208";a="846618031"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Dec 2023 22:47:04 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 19 Dec 2023 22:47:04 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 19 Dec 2023 22:47:03 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 19 Dec 2023 22:47:03 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 19 Dec 2023 22:47:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UKS+PQ9NbDWiiAVEKvRu5WqaJk1Na1xG+7NWHFgOXBaPpLo3e7IZNQDRiJd5tmrQjmvgcwzUthoaetoW4RsHPOkAxo7HI0uXhllWM2UiwDIzf1sjzBJQHGaxl+lISW5VGa4FoX78tXC6rKmVNrLqDOAODagk5n2wWsBFWExelytpGhQQGeKR5vUBkKuOHhLOiffKzoFsoRvR2QMEjLgzqnCF9dUVuKDuAlVgVOYVTXa4gKl/X3Esdtb3V9QAL+40ppMshBZJ8Et5vL0B5jTy0MC2IgYZnuaHCVQf9OHsuQNCAte//YNbBTNyBGqIoVOZ46KrOa4WqBNS30ObiZOzlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PJiBqDm17//qYHCXhbu2kTiNN4HuSzsH7YHRj8hBtBg=;
 b=e3IgJtPYu9Cji2mgJrcrEMqrpwUEhik6xnguPLrm40FrCzSmEDino34fO6bc29Bm6Q/NOsyc0RKGMv4MPWRmCDUDu2fxL10auzlM/qD4Z9Hnf3zzUfOiFeNeGgP+5yK+YyJUsxHXXSveTbG73wmodh2tMqrrzbEQWfwaw1CxEN9NP78YDJvt7xdKGrL7rVvrTZ689VQuNtHO6B7NRXgUpkvlvyMDjfCDq35Lv5ChqDM0JPN+E4fXBNW2rzi32eY/WeBmRhWFuk+qbOET0/hsBm+oPWliKZC7ellPsIzNVV6x2p5W4kJsCcZLpOmu3M+b8H65M6QJHBcVqz0W3SBp/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6392.namprd11.prod.outlook.com (2603:10b6:930:37::15)
 by SJ0PR11MB4815.namprd11.prod.outlook.com (2603:10b6:a03:2dd::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.18; Wed, 20 Dec
 2023 06:47:01 +0000
Received: from CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::15d3:7425:a09e:1c86]) by CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::15d3:7425:a09e:1c86%4]) with mapi id 15.20.7091.034; Wed, 20 Dec 2023
 06:47:01 +0000
Date: Wed, 20 Dec 2023 14:42:35 +0800
From: Yujie Liu <yujie.liu@intel.com>
To: Kees Cook <keescook@chromium.org>
CC: kernel test robot <lkp@intel.com>, <oe-kbuild-all@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
Subject: Re: include/linux/fortify-string.h:52:29: warning:
 '__builtin_strcpy' source argument is the same as destination
Message-ID: <ZYKM2+WNOhY54bQS@yujie-X299>
References: <202311301039.7i51bZCz-lkp@intel.com>
 <202311301409.F2AFF5DA1@keescook>
 <ZYKHxJPcAZ+rGPeb@yujie-X299>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZYKHxJPcAZ+rGPeb@yujie-X299>
X-ClientProxiedBy: SG2PR04CA0208.apcprd04.prod.outlook.com
 (2603:1096:4:187::10) To CY5PR11MB6392.namprd11.prod.outlook.com
 (2603:10b6:930:37::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6392:EE_|SJ0PR11MB4815:EE_
X-MS-Office365-Filtering-Correlation-Id: a82f9a76-f671-4155-026b-08dc01277874
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dziK9D0tu6srMasbpxiPWfq7x5UbGlPwSbHrQIE4l3QuLKENJUtzjTGDj9fX2STUbTvvXBo2LsXGrp4+Uc+f/qRKYIC/OADQAu70m07lg/DQFxp95snsXDqvKuCnLyYk2zQBE2aYx9SvmRXbuK8acFsxepcTdGKP4dnw3NhjzHKZivNaVH/NEgEUheUux/Y0fntdcueaicAIFDZDgnHyiAUNdsMciXiDfcsb+MsyGYBOqMg89IfwYBRW8EYqzfcAqwDzebLUOD2Vp6ROi7kdVmdB2JuVZnbmvIvpI9zBU5Sh/GNM34Nxo9x/tKLLyo3UI0oeo7it9/KcmSqguPlZvfR2c7SrHk53KZ3ajjkMmUl2B2y0fEVcri0aLhqKFCp/pHxLOfxI2zu2jm4rHuONINhEghmoyAYPIS/UXxs5u8PFIkBy9NM/hobrOqYBv9HO4rbneYof7ymovjk4ReoQl5vi05EyaWs77FBboDdWq8rZVNO2B0IcJJW8Troyk1Ne3TFZiTZGEaxZtM4TViPmV6PCqDXAkZAHfpL0ZKK9Cact9D3wMEhUIx05blwoFHDHErTBoWRrig5aMu7pq52ltJfUBYKD2iRYdvRo5mATXtjh+FmmElk9JXaaQJXvp2wkz9r3q7aX97qZ4jZGN9tB2kRCdYBP/FF4Wur8gXlTapVr/YNwS3bbc1hlYTZRw5eY
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(396003)(136003)(366004)(346002)(39860400002)(230173577357003)(230922051799003)(230273577357003)(64100799003)(186009)(1800799012)(451199024)(38100700002)(26005)(83380400001)(86362001)(82960400001)(9686003)(6512007)(478600001)(44832011)(6506007)(6666004)(316002)(966005)(6916009)(66946007)(66556008)(66476007)(4326008)(8936002)(8676002)(5660300002)(2906002)(41300700001)(33716001)(6486002)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?c8DY1HQn71l3qe1FzX3qzSVIXuLY7XNs0ez1e7xD3y7Xi6lUZanp+9aceK1h?=
 =?us-ascii?Q?Bh95SNz7Muds/HhW3qtxgG5rIi6RdCaPRdJ9vofmqeiVs24rjF/ciBmLDkTq?=
 =?us-ascii?Q?BpVerjuB0c2rYhjJwwn45Ay4i2LYEz/qC2Tws4Th9OZonjDq6vhsp1H1cXKs?=
 =?us-ascii?Q?ielzksUunJBeMOb0KSHBsjZ+4tmyvUv7agIiL+zQ++5WWn2S7NyiXfOkl5W1?=
 =?us-ascii?Q?AyOWgWtB9IPVhRxCblk4b6EbOB1BiBhxV69DGZRCeA7pmbYFNC/pExlP7J8Q?=
 =?us-ascii?Q?PNWdDXgi+ejSRTW7hsVJtASLTk21xmnKJo7iAFygq6w5/7hesmev1dC4pjFK?=
 =?us-ascii?Q?uIa+y994romBh3ABJ3af2IHxBEVxwfaGp1kL2JGBk9EMc17bq3qRNCN+ZMbt?=
 =?us-ascii?Q?negteFu7bF9+hfwbMKg5gF/7DeXVRZuLGhl2WqgXELCVUs/OoQuiPlJnZgsh?=
 =?us-ascii?Q?dFklNeQybkBohQi5j+KyZdlAMl6IBhzpSYtnyAa8xudYPx/0Zx9PxaYLL9Lv?=
 =?us-ascii?Q?2HBbKKteUW8pfOSqEnEavGA6LJc6AA6LR5L0eJK0l9qggWadHptLpIINLAGT?=
 =?us-ascii?Q?l00h4bED6cVS2cPhfKa1EatwOGGXqG+sEcL3TH+30H2PUmsRTeqprV04OeBh?=
 =?us-ascii?Q?YnXVJtl82W81t2nUYEIZSKS92ZTTa/+JZiRIQXqJ2AXH1mnQz1+xrrv/BeYF?=
 =?us-ascii?Q?2NidnGi7SiYHYoUaUznFMbH6mULUxOJJmTLKFnqHaib3yif5NcOMR3Z0q1zD?=
 =?us-ascii?Q?tJnxItOnnx6re5JgwW3TigFwg5qpVnaCcKPmdKu2haLYFZDB13j/N0MTmgkQ?=
 =?us-ascii?Q?1xV2tiAc3zIe3oocr1vxCM2aafRDOt9ZqNEyoGaQNh/x6rM7fuDPy/AEbpJX?=
 =?us-ascii?Q?u3yU1TbDieLAFRAYWrjsJva6h9/flaYc6x5/PatStqGQJ1WjpAh4kh8ecrPY?=
 =?us-ascii?Q?Fkus8ejAMja/eyK99RWI+SGr2dmlE8tLTqIKCplVuoZVmwIAGlqHZs/aEQih?=
 =?us-ascii?Q?TBrutb0krNZz0xKXkl5TgTWaWNp6nPM+YfzO2eVf5Y3VyTBgTV3Yh+K5N1uM?=
 =?us-ascii?Q?60LYEHhC7OF4grJ+D8iVmLnuoFAK5q4F36R+pgch2GiF09k9ario34h5MuTD?=
 =?us-ascii?Q?GJrMQzOnsC0Zy8XEYjZ/OREA7pOCPm6Ci/QamHTEn5oT8KkXaFyEfLdr4RtJ?=
 =?us-ascii?Q?WHrWk01+gKzozEXW2Wqng9cmaTdsWpNS5w56wxWuVq+99DAieW2jN+x9sfeQ?=
 =?us-ascii?Q?D27zDtX+fWUZ0Sies9dKLv1oTuxqyhIA4OK8NbMO4WI40jYQ+XuYiER+QHRv?=
 =?us-ascii?Q?P11e3bHQ7PjzM03MHJikW2dcmCwe8sSwlstHhETdIW6LSkeoR0xf7WidsBql?=
 =?us-ascii?Q?o9vj8UKyh94vLFCehdmW4zEsHIIsp1FS5aF5bBEFi6VnjDS32txY+T5VUhvZ?=
 =?us-ascii?Q?rGlOhZrPGDzTc6wB4lHGoXoIrBFuBgd05LVrzd4D9m5QV7YIjCAxpiL4IX4j?=
 =?us-ascii?Q?riVxUtw8V2QmBHaQxUDziuhNxxaRqjTBsse5OOV2yF7fL/FuC+75bIJvUjz7?=
 =?us-ascii?Q?1w2kk1cd1KaXmtj8HNa2SkIVkzMfldibJw1Io8s0?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a82f9a76-f671-4155-026b-08dc01277874
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2023 06:47:01.6696
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UXN14X4Z0sMn12fUstJO7hwBZcdgijbxaFh0Yst5WNfnbynMWXG3dAYuXZz8/Xc/MIE/3jTu9vKQqtVN/AhF7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4815
X-OriginatorOrg: intel.com

On Wed, Dec 20, 2023 at 02:20:52PM +0800, Yujie Liu wrote:
> Hi Kees,
> 
> On Thu, Nov 30, 2023 at 02:11:54PM -0800, Kees Cook wrote:
> > On Thu, Nov 30, 2023 at 12:02:50PM +0800, kernel test robot wrote:
> > > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > > head:   3b47bc037bd44f142ac09848e8d3ecccc726be99
> > > commit: ba38961a069b0d8d03b53218a6c29d737577d448 um: Enable FORTIFY_SOURCE
> > > date:   1 year, 3 months ago
> > > config: um-randconfig-r034-20230830 (https://download.01.org/0day-ci/archive/20231130/202311301039.7i51bZCz-lkp@intel.com/config)
> > > compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
> > > reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231130/202311301039.7i51bZCz-lkp@intel.com/reproduce)
> > > 
> > > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > > the same patch/commit), kindly add following tags
> > > | Reported-by: kernel test robot <lkp@intel.com>
> > > | Closes: https://lore.kernel.org/oe-kbuild-all/202311301039.7i51bZCz-lkp@intel.com/
> > > 
> > > [...]
> > >    kernel/kallsyms.c: In function '__sprint_symbol.isra.0':
> > > >> include/linux/fortify-string.h:52:29: warning: '__builtin_strcpy' source argument is the same as destination [-Wrestrict]
> > >       52 | #define __underlying_strcpy __builtin_strcpy
> > >          |                             ^
> > >    include/linux/fortify-string.h:567:10: note: in expansion of macro '__underlying_strcpy'
> > >      567 |   return __underlying_strcpy(p, q);
> > >          |          ^~~~~~~~~~~~~~~~~~~
> > 
> > The only strcpy() in __sprint_symbol() is:
> > 
> > 	if (name != buffer)
> > 		strcpy(buffer, name);
> > 
> > Which is explicitly not the same address...
> > 
> > This appears to be a GCC 9 false positive, maybe?
> 
> Sorry for our late reply. We tested this with various versions of gcc,
> and this error disappeared when building with GCC 10 and 11, so it is
> very likely to be a GCC 9 false positive. We will configure the bot to
> use compilers newer than GCC 9 to test um arch.

Sorry, we will keep testing um with GCC 9 and configure the bot to
ignore this specific warning.

