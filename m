Return-Path: <linux-kernel+bounces-307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C4BC3813F02
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 02:10:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44F571F21601
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 01:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C8BA805;
	Fri, 15 Dec 2023 01:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ed0R0PL9"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 720C8EBC;
	Fri, 15 Dec 2023 01:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702602639; x=1734138639;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=hGHT2xFDPW1irjXpqDgB580PM8cj5c5cGBO8HS7HH4g=;
  b=ed0R0PL904eV69rXv1dR/S6WqBnDOgeWLfAiMoscBx9ShRncS3N2wfRp
   oNW2u6d3iS7kh/J9AtD4KKk+NjiyrfCMvX3NFWDn4Y4hOo41UDH0oK60w
   KfNdvDhe8t+2lvexnzg8mCLiFnpSjwTt002FFZvMvQLoxH3C9vl8PAC3x
   mxieHIeoL2u5JhK15Z3J5XzNbrStNLulqHPRplQGNe4VLDYf69nQG2ulh
   H2bE2RF+48nv/qRSqSwSDUTUSmVcG3HE9t51Cn1fyjSAfpsEy1GtPmLKJ
   4guwDPnYLfWFJ6miAREO0YUpsr9xiYdhd8h83e6TGIYSU1qusPGDBK4zT
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="2302330"
X-IronPort-AV: E=Sophos;i="6.04,277,1695711600"; 
   d="scan'208";a="2302330"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2023 17:10:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="897953816"
X-IronPort-AV: E=Sophos;i="6.04,277,1695711600"; 
   d="scan'208";a="897953816"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Dec 2023 17:10:37 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 14 Dec 2023 17:10:37 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 14 Dec 2023 17:10:37 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 14 Dec 2023 17:10:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GNJbjfn1QldXtGtJ18uydr2lHOdB2+RiOsTYoTaHmNtijJOhjnAYZSoT1+VLi13gEYLMD3JSWSpbAZP7wJsWQtJt7s/nlBDBXU8ZOG6cy54W6Rw3Y0uPaBM8GgZOm0T8mFnF3a8FsSqNilQOUDuZVv6FMjOOLZdmliDKHr+WkVD3ZgP6pT5wptQIfuJQ1Dcdq1besra5518Efc+QDMkaOvDCbMjcL6YQh0IY9fxepjIDyTFcVSIy4aHNN664gJ3ieyu3Nl/F1Mmf2xfYIY7yh8c8jFLZtyOPCe3FWP6odhfTtFLqEpvCCeynJxhXSmygeBMDL8TCn0aTbXsYaHZudQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uMiCaJqOpwBsJ9OvFVNJ3e+QyfG2TRG5c4rkTH6u1yc=;
 b=LKWnii507ZGy3//hA5mVJ0VnZsd1m4J52x3zhSmyfabu8acN/USryfUVNh31xxvX/tS9WQvEMs2l1JzPWdvmvoEKZp1cYJgMc+T8imcOeTKQrrwe7Y/Uc/BEdHSci5K0ea7uRjndQBk+aCCxdKrVnkuvCYOosklF9Tapb+lqvheWbOr13NVaysWZXkBA5gCmLXqRq8q7Fw9UYry58AwXR9CLms4/3t44K+1D+U1Oo23jhrzaFWijj5lYRjoLNDF2WMuTBqfkKv1/Ch8iG7RvBXs/2hFF31odCNqRVmiz7WDMCUDzigx+zC8wy7BpdjZHPf+cDbjj7TG07WBgH2BGjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN6PR11MB3006.namprd11.prod.outlook.com (2603:10b6:805:d1::24)
 by DM4PR11MB5343.namprd11.prod.outlook.com (2603:10b6:5:392::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Fri, 15 Dec
 2023 01:10:30 +0000
Received: from SN6PR11MB3006.namprd11.prod.outlook.com
 ([fe80::7f2d:3448:d474:f74e]) by SN6PR11MB3006.namprd11.prod.outlook.com
 ([fe80::7f2d:3448:d474:f74e%5]) with mapi id 15.20.7091.028; Fri, 15 Dec 2023
 01:10:30 +0000
Date: Fri, 15 Dec 2023 09:10:21 +0800
From: Philip Li <philip.li@intel.com>
To: Kees Cook <keescook@chromium.org>
CC: kernel test robot <lkp@intel.com>, <oe-kbuild-all@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
	Linux Memory Management List <linux-mm@kvack.org>, "Gustavo A. R. Silva"
	<gustavoars@kernel.org>, Peter Oberparleiter <oberpar@linux.ibm.com>,
	<linux-doc@vger.kernel.org>, <linux-hardening@vger.kernel.org>
Subject: Re: kernel/gcov/fs.c:103: warning: Excess struct member 'buffer'
 description in 'gcov_iterator'
Message-ID: <ZXunfWqei+vXUCnp@rli9-mobl>
References: <202312150432.oBngC94A-lkp@intel.com>
 <202312141344.9E41E46584@keescook>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <202312141344.9E41E46584@keescook>
X-ClientProxiedBy: SG2PR04CA0154.apcprd04.prod.outlook.com (2603:1096:4::16)
 To SN6PR11MB3006.namprd11.prod.outlook.com (2603:10b6:805:d1::24)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR11MB3006:EE_|DM4PR11MB5343:EE_
X-MS-Office365-Filtering-Correlation-Id: 1efa25bb-c372-4a2b-8230-08dbfd0aa147
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KdgjXarX4CD07FyyyKexWQ+65tUGmPH3IO5EOfahTFqED+NsAGDMKBsxgzHwGsLPrNG4bev9pxlCldVYHlOANL5gtB3mOaIxF7DEKd143DSQcfsyq9ANWm2TJwLKrmbIvYFOpWrOWTl/rhp7oKNxicZ13yEaSdJE2sE4WlkHWQFpEmKYNttmwRZLg0fMlBS9ZOIlcsGkE7N+0xsMDGx/6wi16tILMbB578UwubOJQcQ7WGu2HBldflsrN8KLS50mfC9xzeVQBEMHcim1/0QrtWUVrde/Xdonzf4Ex5Ph7lkg2FpE6VvXGnYM9SrbAggvTC7tUy8N0GDM3FQMdZnpaQzCNixs3ZRYKNj9EobV10YuMpBupiuV3zbHffMW0V7lNKS2Mt3gX/A/zZcccZN1mJKFUW1D0ORJxf5EUDU8RY7O28kvzntqNAk9n31YNkeC5HtN5LIADaqqH9ZqxtDXHBWld8w7QLuqIwEF6vugJfhR/US1V6X2CJanHzoVmsn+x+RistsSQK0m9ltyKt1wHdXaxrG6Tg5nfvXYcAY/kWLiiacgTWMzEI7U/qQZMl68qliHB4vMjBDmU3WZZiL139X/Zgc7nwRuKjBp3XVOI/hOlvs9Dxv9gbaMOtxfQNO+Fvvp5N4+n5TmyqtLYGxHoUMdsFgAiu+O46u3/Ud6AW1+wrhX/5wE+xNAfTkQeRGS
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR11MB3006.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(136003)(39860400002)(366004)(346002)(396003)(230922051799003)(230173577357003)(230273577357003)(1800799012)(186009)(451199024)(64100799003)(86362001)(82960400001)(41300700001)(6666004)(478600001)(6506007)(66946007)(54906003)(6916009)(66556008)(66476007)(26005)(9686003)(6512007)(33716001)(38100700002)(83380400001)(2906002)(966005)(6486002)(316002)(44832011)(5660300002)(8936002)(4326008)(8676002)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EdmHb60UR1MBqtdsiXCiZs3h/163beFThmL/aDaGItKDvxgzAWgKGixuNEKb?=
 =?us-ascii?Q?5bTaWxngblW2b+7LORmfHi5Qmlks1zW2yHQwc7Ug5c4qms6fVRcda2vHrIXt?=
 =?us-ascii?Q?ba5kLxQbS3uEaB2Dhixt9CwvKnfGAskTNRPRr7F8t531lKWcI7en0U+pPgVC?=
 =?us-ascii?Q?WFT0ygP1RDzcQ2lbmg2Ee/yWel2Dd4hsLE9Vhy/XdSerixrCLob84ejjYv+M?=
 =?us-ascii?Q?oHP2W0XEYG+HMx4+/EFSDu/0LGMGwgPzz6oD6iBA8Dy4QLdypFTzJvgRogE/?=
 =?us-ascii?Q?t7pA1XHeiLKlXb8qTTLfM8Q94J8IlSQg2XVVKlaJa67DlEc7Y5eitaNZ+frV?=
 =?us-ascii?Q?ofIClG0rr/TnK4UFXkrgDubbYK4B+VvQSflDBvcU6tOUgizdnNmwy0UfQOrS?=
 =?us-ascii?Q?FH1kzPnrivuAzTORfMFOc9O/JTtzbRnL3dHabWa2PtKAJtHSAnGwSCj7UiJM?=
 =?us-ascii?Q?umnuLXvbQb0s0bW/ttILjmYHbDwjZ4Mor42q+gSAkXHitcdOMUtup/5wTcQG?=
 =?us-ascii?Q?ESyehpP36m27RhstqcdwZqcXVsEOWMgaqWyCw00zxdb0PPAK06QRWwJ8r5jY?=
 =?us-ascii?Q?upm5PJga8QJtgQSfWegZa+o4eSqKTG+Ef9J7MLKc64tsT50r1UtSzZHMwEnu?=
 =?us-ascii?Q?vqvYiUpRUQoUZcImCqMu5+VWr5sYbk5CC0NDnxBc/TF4GfuXdpypAjrWvXVl?=
 =?us-ascii?Q?AvxTkKzvGr4e28o78MH7qlCi2mHRS3GES73FXQgnVl+8bwLF8sXkCr92weYP?=
 =?us-ascii?Q?owdQMo4VIWISrqdX/v5hmU3ZRr5oVNQac19W9XwF+5sb+0nibW+BGsKtcOn4?=
 =?us-ascii?Q?BAjHqqyfu7uQiHs9MyEwH8PmsxcJ8xAcs4uD4OARPSp4Qy4NoeKBsYkIjW5E?=
 =?us-ascii?Q?wDjQopvvhD3BaXui/2/aMU9aKlgOdAQLGSXH7LW+x+3kmugRZdjKOU8s6yXY?=
 =?us-ascii?Q?pWdM4GX6WWaBuFXk5cXN9Ihcj5HhgHooD7fbjivVwa4CFIqPpVDhZ+zslEic?=
 =?us-ascii?Q?CLSPvu50uR1h5vRzjfEW8icrZGRdXf7IWVn7U2rMFTY/XRb+hGxHzlwKG5Lp?=
 =?us-ascii?Q?9OZMbaNTrrCoaRpNplUeJyYBn1385+FyHfFRCa8R1Qa2GyJpXA5nPNO1c1hB?=
 =?us-ascii?Q?iEFdis5F2bT7MdmlSFB/GZJRPtiUU8GJ3FFv2PfxnoFHnJZZ2ygX6Axpa22A?=
 =?us-ascii?Q?1kb0m2EiXJgS4JWYj0IUwKt4NXadVID+V0zX38GfB9f6Gk9iq8QWYIJ4peGo?=
 =?us-ascii?Q?gYTEl/orkY5eqp9RdwQn5/R8k513oB9D+vMB/4qFL1ATRNygMZCk7VTxs3Hg?=
 =?us-ascii?Q?iO4xPrilTZm/ng6H0UsIbikYHMz9WbHOoV0RxctU1g4NWel22CrllTCDhMuQ?=
 =?us-ascii?Q?fcsKA4lOK3NbvRtYL4e0dRVsGMUs3zj2Ica1sxj+4MyhNCDHxyuZi+85rSlD?=
 =?us-ascii?Q?Ccn0WGjiuhfnJpeySnv9frsP6J87VcWmcFxblhPf0lbp7kd4oK0zCU5zZfCT?=
 =?us-ascii?Q?/XYAEQOr7Lv/7iqfwk1xzz1boxQ6mtn5BVKgZYODWL5wrvb17SEsA3NyTtZJ?=
 =?us-ascii?Q?l0Wx+nfcHlZmKYprE0wu9stlDECTZdwSGkS4ep2w?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1efa25bb-c372-4a2b-8230-08dbfd0aa147
X-MS-Exchange-CrossTenant-AuthSource: SN6PR11MB3006.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2023 01:10:30.3223
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WYc6EufxFFk8I2laln6E87QUbo9676njXOZeY4IdW32L6PdijXVw+FYmaWG+SW5XPPVxAY0wHCXB9Uhzc8Fl5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5343
X-OriginatorOrg: intel.com

On Thu, Dec 14, 2023 at 01:50:05PM -0800, Kees Cook wrote:
> On Fri, Dec 15, 2023 at 04:53:19AM +0800, kernel test robot wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > head:   5bd7ef53ffe5ca580e93e74eb8c81ed191ddc4bd
> > commit: fbd126f5a658b92c7f6af986a6d89cf5e5693268 gcov: annotate struct gcov_iterator with __counted_by
> > date:   8 weeks ago
> > config: i386-buildonly-randconfig-001-20231214 (https://download.01.org/0day-ci/archive/20231215/202312150432.oBngC94A-lkp@intel.com/config)
> > compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
> > reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231215/202312150432.oBngC94A-lkp@intel.com/reproduce)
> > 
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202312150432.oBngC94A-lkp@intel.com/
> > 
> > All warnings (new ones prefixed by >>):
> > 
> > >> kernel/gcov/fs.c:103: warning: Excess struct member 'buffer' description in 'gcov_iterator'
> > 
> > 
> > vim +103 kernel/gcov/fs.c
> > 
> > 7a1d55b987dfcb Johannes Berg 2021-05-06   90  
> > 7a1d55b987dfcb Johannes Berg 2021-05-06   91  /**
> > 7a1d55b987dfcb Johannes Berg 2021-05-06   92   * struct gcov_iterator - specifies current file position in logical records
> > 7a1d55b987dfcb Johannes Berg 2021-05-06   93   * @info: associated profiling data
> > 7a1d55b987dfcb Johannes Berg 2021-05-06   94   * @buffer: buffer containing file data
> > 7a1d55b987dfcb Johannes Berg 2021-05-06   95   * @size: size of buffer
> > 7a1d55b987dfcb Johannes Berg 2021-05-06   96   * @pos: current position in file
> > 7a1d55b987dfcb Johannes Berg 2021-05-06   97   */
> > 7a1d55b987dfcb Johannes Berg 2021-05-06   98  struct gcov_iterator {
> > 7a1d55b987dfcb Johannes Berg 2021-05-06   99  	struct gcov_info *info;
> > 7a1d55b987dfcb Johannes Berg 2021-05-06  100  	size_t size;
> > 7a1d55b987dfcb Johannes Berg 2021-05-06  101  	loff_t pos;
> > fbd126f5a658b9 Kees Cook     2023-09-22  102  	char buffer[] __counted_by(size);
> > 7a1d55b987dfcb Johannes Berg 2021-05-06 @103  };
> > 7a1d55b987dfcb Johannes Berg 2021-05-06  104  
> 
> It looks like whatever produces that error is not parsing attributes
> correctly. I suspect this is the "htmldocs" target and "__counted_by" is
> missing from Documentation/conf.py. I'll investigate...

This is triggered by W=1 build

        make W=1 O=build_dir ARCH=i386 olddefconfig
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash kernel/gcov/

The detail step is at [1], hope it can help reproduce the issue

[1] https://download.01.org/0day-ci/archive/20231215/202312150432.oBngC94A-lkp@intel.com/reproduce

> 
> -- 
> Kees Cook
> 

