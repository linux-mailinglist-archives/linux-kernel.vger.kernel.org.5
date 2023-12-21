Return-Path: <linux-kernel+bounces-8277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F28E81B4D5
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 12:23:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 341D9B217C2
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 11:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 179FD6BB51;
	Thu, 21 Dec 2023 11:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CXQz7efn"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28DA26BB44
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 11:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703157812; x=1734693812;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=gPhenD6FUWkIzHTbjwRQI/DTePpuG4+QKmmnxQQf9Lo=;
  b=CXQz7efnuh1O7WqS3viyPvk1nLEqoM76tOSIzYcvPeIW9WQlNQDL2Q01
   FLv3ynthniVuD/Yb/kcKXX9kOugvhW4Xy/TwmaBHc+2D6zFVQtpsCg8Sg
   AAPArmYli9GMu6c+Z2tHImMC1z80lEZngOtJzHtfi2StIIx2X17uE1rNq
   nw3xUNyg0pdYOpRYeIVcyoQ4QOfE05DnzJqr/VOfx1ROm4vhTUPhaORK0
   HJaF5xTya/j7pt12fGy48+zzHjDaV30Ear+Fq340gDu4xNHTEDNQIEKpT
   cQni5zTGkR2MNT7LXiXDKQUBKpddXgjgMpArxrLPTLopmz0myTl6WHYhG
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="9343219"
X-IronPort-AV: E=Sophos;i="6.04,293,1695711600"; 
   d="scan'208";a="9343219"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2023 03:23:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,293,1695711600"; 
   d="scan'208";a="18655721"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Dec 2023 03:23:24 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 21 Dec 2023 03:23:23 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 21 Dec 2023 03:23:22 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 21 Dec 2023 03:23:22 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 21 Dec 2023 03:23:22 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OKxHUBcBGqquxtYyI7d2uyrJMiEykJRmOWX+mx/9F3U2CcHVM5H6mpy3kiCTwUb8bAbc4h/LSjldrAUffwGVyRfTSdbYVo7sJqI8IvihV5A+gTN6h3dEf5BXCZaYtXBPu3gi07duFUWQ0/XRg63L4FDKwyz7ez+VwkvjtslwugcqOvRQyKQOMC7iFRpWn911UciV9caW4GhyVvyAB0JsM8bYdbN0fOWJnut/Z0VITmEH4XfJkxZ4/l4/Rfvn6KuZfOpgR1zoOtrdunHtwODQWuoIAPhIadDr2m5GD+QT4eyI2HOrgm0JoNvIPGlch7jJ3/u9U5eBwc8YFSRbBPR8vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FUr1Gc8gkkccKe6Nd6rjIES1FpWrUo+usjSgd4J+rws=;
 b=hCS3ElnaTVjM5eTg3mij2MVFsQzwwtIU6UDi9pKqY6/hWPSLJriBiSxZSWpHtTl5e+juf1Rt1d3dx2yvaIF+fYtjIWqkECvqSlcN3vB7ZBT4r/GfdGgzP++gv1CCE3q3ibfY3HTvjEDICjvPmuSL+QsgRGHINPSUG7D2ImcFfIsRTnsmMbPbSGMF1ppSD3H+ESNd8uEBZ4dLrWstai7XQsUGUfRp/M9JywspK9Ohx48siPkWAWfDxQeEagYKRkUtnftNMit0yC2wbzPmJqWZEXTUQ04kZqdhmfsEh4OIAWv3hAk04HJ6goaseIo5LfXMCfKRq1x8YLv1S29MeaSeNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by DM4PR11MB5405.namprd11.prod.outlook.com (2603:10b6:5:394::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.18; Thu, 21 Dec
 2023 11:23:15 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::1236:9a2e:5acd:a7f]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::1236:9a2e:5acd:a7f%3]) with mapi id 15.20.7113.016; Thu, 21 Dec 2023
 11:23:15 +0000
Date: Thu, 21 Dec 2023 19:23:06 +0800
From: Oliver Sang <oliver.sang@intel.com>
To: Andrew Morton <akpm@linux-foundation.org>
CC: Matthew Wilcox <willy@infradead.org>, <oe-lkp@lists.linux.dev>,
	<lkp@intel.com>, Linux Memory Management List <linux-mm@kvack.org>, "David
 Hildenbrand" <david@redhat.com>, <linux-kernel@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: Re: [linux-next:master] [mm]  bbcbf2a3f0: kernel_BUG_at_mm/memory.c
Message-ID: <ZYQgGmYNfF8j4JqL@xsang-OptiPlex-9020>
References: <202312192319.fa8f5709-oliver.sang@intel.com>
 <20231220141135.cb4241442b657104f0aeae34@linux-foundation.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231220141135.cb4241442b657104f0aeae34@linux-foundation.org>
X-ClientProxiedBy: SG3P274CA0015.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::27)
 To LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|DM4PR11MB5405:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b4a3edc-9d5e-4516-e3d1-08dc02173918
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cGf5DXYOUNBs39T2zJtDMuhM20kxadQMVKy7AD2YuwKFjGxuSGkuios3jkP5Y7ON6zu7WnqpC89bcRkcN0JaG2LAqpw+8L58PeeJRtXl4m9od4c4D8OZEgWdH8HnYBCks3cc3IsoSHA/TuK7pYa43c9cM6a/LlFI9HotijVjeOWMkxiqa2yL2dYivvHs8YIG6R3gWbA8++Gt7PyNo0rzDEkiwLFuKjBSQIB9uXcUu5Lpgx9LRa4tab5caERpLIYGflz4STmY+7umAV5WyN2Q9CBB0WphuCSoe3XPK8eZKAnS3gj4XbZfMwpWa+aD00CjwEuAaOIjYXGZzR8CpGJQ7Y7A7fjl2T/gDnbmmUOcB9ZQKYah9jGYJbYjXfN7vM/Qcxb8gN2KCAy0/ppUvdU0KridjBoMZgJUer/+2ZEHX3+opqV4sabfoLRNksnIBACg8YlUVQgrmBc1J8A84eqYf0wCEATpf67F3pIMcWfAaOUgSVEMSUQ67YCi2ACKQMrLolpfArOxidA/jPRbqmOx6oeFYzJlN29UlI3CCcSxGYyksaD7kFJxMbDUY2Kd4N3SdPjGBs5ibWuXkb39hOAHEg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(376002)(39860400002)(136003)(346002)(396003)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(478600001)(38100700002)(45080400002)(66556008)(66476007)(6916009)(66946007)(316002)(6512007)(41300700001)(86362001)(9686003)(82960400001)(6666004)(33716001)(6506007)(26005)(4326008)(5660300002)(44832011)(83380400001)(107886003)(30864003)(8936002)(54906003)(2906002)(8676002)(6486002)(966005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?b07a/RJTea/8lYb/wjSnW45aLBPkJ0MzH2ZnFGIYURW65B8Iz8VPcbTun9OZ?=
 =?us-ascii?Q?6hx6otCivq6KV3E3Mr9i7Jspc1/Ff0c849AFUV/gqxfzK3wWce+/yUv/A24E?=
 =?us-ascii?Q?w35JWclpgzSmjV4/sFfMiyDvpeq7262+mPUEoG+Td+2PLoEzkapQYHncfKEA?=
 =?us-ascii?Q?0TiZBTASeAVCKcG+CSBovw8K26P7eR1LDyYh7GXHiHahCdMp3fQGxoBEtFP6?=
 =?us-ascii?Q?ieMRH1gh6BFPTD4BzvJ7XChfQWkZxT0qHfLPaOJ3eCQRnmckxPvUq+Nhn418?=
 =?us-ascii?Q?RchZqEKWJHnArPOvPCYanKP92/CKezj0gFigSGex5T01ccBJ92f3OjsFiONM?=
 =?us-ascii?Q?w82mMGkE347OU9bVwrCl0fUBthjAigJdE7b7J81NoSfO0lUi558Z5g84kEv1?=
 =?us-ascii?Q?SJgqKPYdMWrEeV0gi5vdWdMJHQ7jW+42dS3lsnn/dLHeDtTOYZO59/agyjoz?=
 =?us-ascii?Q?6ie8mdYiNSuBWBTd9ivzrNtCUUKZMGuJGTif5pDkEmOzFsbvihBgN3bpi2cl?=
 =?us-ascii?Q?o24SCvNfMaPxIFx90yGeDgq46r2QNdic7jLGhMhQr5M2YuzEWb5FiBmLfpqw?=
 =?us-ascii?Q?jQQaGHv0rLP4lUCVF15lmvDXDaYYTulwW07YGkKtlX3zCAMcZeLqRaT/INlN?=
 =?us-ascii?Q?tJptPNQkJLBa7zJ8aeI/RnaEpPIAdHqE5/NuIeOTN2CJvkg1MTN/rYWpWrg8?=
 =?us-ascii?Q?X/dYwD4wvEm5kMKSQ0QDoqNaTlELbzVDJTO6CBERcgcqx0M+ODp5APqBcOyo?=
 =?us-ascii?Q?zPWpHQyTg+RFAEGsYmJZtzmpcKEI5LewR/IwXLog0lZlZOezFvIxVhE6gGHU?=
 =?us-ascii?Q?yF3vhpPfTYqdMRc0Q8sP1pV/hZXKW/OTB++qKyVdedHcNEh/cjYCpI0Rt7Cx?=
 =?us-ascii?Q?61yQz9AQgGCwnptC8Up+Gk8prZ0nHKXueb/zAsn6Lo63r6vgnhYmAp5tqW1f?=
 =?us-ascii?Q?SFtr8f9dKnR2oSTtRqD2FmWZVOdBZfWEpBSFezaswNFbUyIYzq+wVJbTwG53?=
 =?us-ascii?Q?90u+p09CzJvfYVcs2Yp37Vjrr8ptYhPIAfauAI+mNjoPf2aMDAaIxhou9/i0?=
 =?us-ascii?Q?4BEYHtjti8Q2QEiuEJx50h5KtiIqhfZWWk21pXwC/BqX6G64QsV78xmccoLr?=
 =?us-ascii?Q?My049LuysoWt9Mj6cOOpQSsgnQsXe5KgvxM0UU3bNfOKiyk5kNHuHJmNzmhP?=
 =?us-ascii?Q?9ooIenUGDbOMlplpy1Ubrqqs6MYWGKOjQCHmQcJ1/DE0lhay+R4FVQ35FJSK?=
 =?us-ascii?Q?iNNwCriOpSvEPb2xWqSajIXphx4N6GuleQZM03Ahro5Ony4Gv37RQwjzKTAg?=
 =?us-ascii?Q?IfgBoeX3/RkSSHjv2WIMgYoMwPsK4h1MV/cbFBew7TifuY30s5U7I5GRzic7?=
 =?us-ascii?Q?h6weV7qp7xn4wQDpxA/IwRxlGoO/cAS7AGAG28L6xru57y1A1WNC6O2vTstr?=
 =?us-ascii?Q?Iue2f/bjRI+PYzHQKakhnmFq5vbl3u5HH6eU5hJn7ud8j8UwvQdDDW6sbVce?=
 =?us-ascii?Q?uLYzHeHZQy+sKWMjY/TzE00dy3/2t9R4uuop8UpG7lyF4FVjZ9YnMpA5l7+A?=
 =?us-ascii?Q?o9/eYvYDym2PuDsKiBMSthqBcI1v7B6IWUbzbjU0?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b4a3edc-9d5e-4516-e3d1-08dc02173918
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2023 11:23:15.0250
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J/Dx/J8dtzmzZAA8AU/VfpuAFtPtC+9a/ixrhTqev/gUX7Ure0VxN92V2MQojyzJYIyDkidfEixpa1H/HN9UMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5405
X-OriginatorOrg: intel.com

hi, Andrew Morton,

On Wed, Dec 20, 2023 at 02:11:35PM -0800, Andrew Morton wrote:
> On Tue, 19 Dec 2023 23:46:50 +0800 kernel test robot <oliver.sang@intel.com> wrote:
> 
> > 
> > 
> > Hello,
> > 
> > kernel test robot noticed "kernel_BUG_at_mm/memory.c" on:
> > 
> > commit: bbcbf2a3f05f74f9d268eab57abbdce6a65a94ad ("mm: convert ksm_might_need_to_copy() to work on folios")
> 
> I assume this is a bisection result, so it's quite repeatable?

yes, we bisect to this commit, it's quite repeatable:

ddd06bb63d9793ce bbcbf2a3f05f74f9d268eab57ab
---------------- ---------------------------
       fail:runs  %reproduction    fail:runs
           |             |             |
           :6          100%           6:6     dmesg.Kernel_panic-not_syncing:Fatal_exception
           :6          100%           6:6     dmesg.RIP:do_swap_page
           :6          100%           6:6     dmesg.invalid_opcode:#[##]
           :6          100%           6:6     dmesg.kernel_BUG_at_mm/memory.c


> 
> > https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
> > 
> > [test failed on linux-next/master aa4db8324c4d0e67aa4670356df4e9fae14b4d37]
> > 
> > in testcase: vm-scalability
> > version: vm-scalability-x86_64-1.0-0_20220518
> > with following parameters:
> > 
> > 	runtime: 300
> > 	thp_enabled: always
> > 	thp_defrag: always
> > 	nr_task: 32
> > 	nr_ssd: 1
> > 	priority: 1
> > 	test: swap-w-rand
> > 	cpufreq_governor: performance
> > 
> > test-description: The motivation behind this suite is to exercise functions and regions of the mm/ of the Linux kernel which are of interest to us.
> > test-url: https://git.kernel.org/cgit/linux/kernel/git/wfg/vm-scalability.git/
> > 
> > 
> > compiler: gcc-12
> > test machine: 128 threads 2 sockets Intel(R) Xeon(R) Platinum 8358 CPU @ 2.60GHz (Ice Lake) with 128G memory
> > 
> > (please refer to attached dmesg/kmsg for entire log/backtrace)
> > 
> > 
> > 
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <oliver.sang@intel.com>
> > | Closes: https://lore.kernel.org/oe-lkp/202312192319.fa8f5709-oliver.sang@intel.com
> > 
> > 
> > [   61.404380][ T5947] ------------[ cut here ]------------
> > [   61.409984][ T5947] kernel BUG at mm/memory.c:3990!
> > [   61.415085][ T5947] invalid opcode: 0000 [#1] SMP NOPTI
> 
> This is
> 
> 	BUG_ON(folio_test_anon(folio) && PageAnonExclusive(page));
> 
> and I don't believe that the error path fix
> (https://lkml.kernel.org/r/ZXnPtblC6A1IkyAB@casper.infradead.org) will
> address this.
> 
> Matthew, have you had a chance to consider?
> 
> Thanks.
> 
> > [   61.420506][ T5947] CPU: 32 PID: 5947 Comm: usemem Tainted: G S                 6.7.0-rc4-00252-gbbcbf2a3f05f #1
> > [   61.430881][ T5947] Hardware name: Intel Corporation M50CYP2SB1U/M50CYP2SB1U, BIOS SE5C620.86B.01.01.0003.2104260124 04/26/2021
> > [ 61.442761][ T5947] RIP: 0010:do_swap_page (mm/memory.c:3990 (discriminator 3)) 
> > [ 61.448112][ T5947] Code: 6f 28 31 d2 be 01 00 00 00 4c 89 ff e8 9b 43 03 00 49 c7 47 28 00 00 00 00 4c 89 f9 48 c7 44 24 08 00 00 00 00 e9 cf fb ff ff <0f> 0b 49 8b 45 08 f0 48 83 28 01 0f 85 3f fc ff ff 49 8b 45 08 4c
> > All code
> > ========
> >    0:	6f                   	outsl  %ds:(%rsi),(%dx)
> >    1:	28 31                	sub    %dh,(%rcx)
> >    3:	d2 be 01 00 00 00    	sarb   %cl,0x1(%rsi)
> >    9:	4c 89 ff             	mov    %r15,%rdi
> >    c:	e8 9b 43 03 00       	call   0x343ac
> >   11:	49 c7 47 28 00 00 00 	movq   $0x0,0x28(%r15)
> >   18:	00 
> >   19:	4c 89 f9             	mov    %r15,%rcx
> >   1c:	48 c7 44 24 08 00 00 	movq   $0x0,0x8(%rsp)
> >   23:	00 00 
> >   25:	e9 cf fb ff ff       	jmp    0xfffffffffffffbf9
> >   2a:*	0f 0b                	ud2		<-- trapping instruction
> >   2c:	49 8b 45 08          	mov    0x8(%r13),%rax
> >   30:	f0 48 83 28 01       	lock subq $0x1,(%rax)
> >   35:	0f 85 3f fc ff ff    	jne    0xfffffffffffffc7a
> >   3b:	49 8b 45 08          	mov    0x8(%r13),%rax
> >   3f:	4c                   	rex.WR
> > 
> > Code starting with the faulting instruction
> > ===========================================
> >    0:	0f 0b                	ud2
> >    2:	49 8b 45 08          	mov    0x8(%r13),%rax
> >    6:	f0 48 83 28 01       	lock subq $0x1,(%rax)
> >    b:	0f 85 3f fc ff ff    	jne    0xfffffffffffffc50
> >   11:	49 8b 45 08          	mov    0x8(%r13),%rax
> >   15:	4c                   	rex.WR
> > [   61.468016][ T5947] RSP: 0000:ffa000000bb5fd98 EFLAGS: 00010206
> > [   61.474169][ T5947] RAX: ff11000111a47c99 RBX: ffa000000bb5fe08 RCX: 0000002064ac7000
> > [   61.482233][ T5947] RDX: 0057ffffc00a106d RSI: 0000000000000043 RDI: ffd400008192b1e8
> > [   61.490296][ T5947] RBP: 000000000100c13b R08: 0000000000000000 R09: ffa000000bb5fe08
> > [   61.498366][ T5947] R10: 0000000055555554 R11: ff1100018bebbd0c R12: ffd4000044128000
> > [   61.506438][ T5947] R13: ff1100205d33d800 R14: ff11000130cd2da8 R15: ffd4000044128000
> > [   61.514508][ T5947] FS:  00007f49c900c740(0000) GS:ff11002001000000(0000) knlGS:0000000000000000
> > [   61.523534][ T5947] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [   61.530225][ T5947] CR2: 00007f4966b3b6b8 CR3: 00000010af786004 CR4: 0000000000771ef0
> > [   61.538307][ T5947] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > [   61.546387][ T5947] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > [   61.554471][ T5947] PKRU: 55555554
> > [   61.558137][ T5947] Call Trace:
> > [   61.561544][ T5947]  <TASK>
> > [ 61.564599][ T5947] ? die (arch/x86/kernel/dumpstack.c:421 arch/x86/kernel/dumpstack.c:434 arch/x86/kernel/dumpstack.c:447) 
> > [ 61.568429][ T5947] ? do_trap (arch/x86/kernel/traps.c:112 arch/x86/kernel/traps.c:153) 
> > [ 61.572692][ T5947] ? do_swap_page (mm/memory.c:3990 (discriminator 3)) 
> > [ 61.577475][ T5947] ? do_error_trap (arch/x86/include/asm/traps.h:59 arch/x86/kernel/traps.c:174) 
> > [ 61.582172][ T5947] ? do_swap_page (mm/memory.c:3990 (discriminator 3)) 
> > [ 61.586966][ T5947] ? exc_invalid_op (arch/x86/kernel/traps.c:265) 
> > [ 61.591743][ T5947] ? do_swap_page (mm/memory.c:3990 (discriminator 3)) 
> > [ 61.596515][ T5947] ? asm_exc_invalid_op (arch/x86/include/asm/idtentry.h:568) 
> > [ 61.601638][ T5947] ? do_swap_page (mm/memory.c:3990 (discriminator 3)) 
> > [ 61.606412][ T5947] ? do_swap_page (mm/memory.c:3971) 
> > [ 61.611179][ T5947] __handle_mm_fault (mm/memory.c:5274) 
> > [ 61.616203][ T5947] handle_mm_fault (mm/memory.c:5439) 
> > [ 61.621051][ T5947] do_user_addr_fault (arch/x86/mm/fault.c:1365) 
> > [ 61.626151][ T5947] exc_page_fault (arch/x86/include/asm/irqflags.h:37 arch/x86/include/asm/irqflags.h:72 arch/x86/mm/fault.c:1513 arch/x86/mm/fault.c:1561) 
> > [ 61.630824][ T5947] asm_exc_page_fault (arch/x86/include/asm/idtentry.h:570) 
> > [   61.635748][ T5947] RIP: 0033:0x5612d5878ad6
> > [ 61.640229][ T5947] Code: 01 00 00 00 e8 1b f9 ff ff 89 c7 e8 6c ff ff ff bf 00 00 00 00 e8 0a f9 ff ff 85 d2 74 08 48 8d 04 f7 48 8b 00 c3 48 8d 04 f7 <48> 89 30 b8 00 00 00 00 c3 41 54 55 53 48 85 ff 0f 84 21 01 00 00
> > All code
> > ========
> >    0:	01 00                	add    %eax,(%rax)
> >    2:	00 00                	add    %al,(%rax)
> >    4:	e8 1b f9 ff ff       	call   0xfffffffffffff924
> >    9:	89 c7                	mov    %eax,%edi
> >    b:	e8 6c ff ff ff       	call   0xffffffffffffff7c
> >   10:	bf 00 00 00 00       	mov    $0x0,%edi
> >   15:	e8 0a f9 ff ff       	call   0xfffffffffffff924
> >   1a:	85 d2                	test   %edx,%edx
> >   1c:	74 08                	je     0x26
> >   1e:	48 8d 04 f7          	lea    (%rdi,%rsi,8),%rax
> >   22:	48 8b 00             	mov    (%rax),%rax
> >   25:	c3                   	ret
> >   26:	48 8d 04 f7          	lea    (%rdi,%rsi,8),%rax
> >   2a:*	48 89 30             	mov    %rsi,(%rax)		<-- trapping instruction
> >   2d:	b8 00 00 00 00       	mov    $0x0,%eax
> >   32:	c3                   	ret
> >   33:	41 54                	push   %r12
> >   35:	55                   	push   %rbp
> >   36:	53                   	push   %rbx
> >   37:	48 85 ff             	test   %rdi,%rdi
> >   3a:	0f 84 21 01 00 00    	je     0x161
> > 
> > Code starting with the faulting instruction
> > ===========================================
> >    0:	48 89 30             	mov    %rsi,(%rax)
> >    3:	b8 00 00 00 00       	mov    $0x0,%eax
> >    8:	c3                   	ret
> >    9:	41 54                	push   %r12
> >    b:	55                   	push   %rbp
> >    c:	53                   	push   %rbx
> >    d:	48 85 ff             	test   %rdi,%rdi
> >   10:	0f 84 21 01 00 00    	je     0x137
> > [   61.660112][ T5947] RSP: 002b:00007ffd09f037d8 EFLAGS: 00010246
> > [   61.666250][ T5947] RAX: 00007f4966b3b6b8 RBX: 000000000000358f RCX: 00000005deece66d
> > [   61.674295][ T5947] RDX: 0000000000000000 RSI: 000000002fa0f0d7 RDI: 00007f47e9ac3000
> > [   61.682347][ T5947] RBP: 000000002fa0f0d7 R08: 00007ffd09f0386c R09: 0000000000000001
> > [   61.690401][ T5947] R10: 00007ffd09f037c0 R11: 0000000000000000 R12: 000000000001ac78
> > [   61.698449][ T5947] R13: 00007f47e9ac3000 R14: 00007ffd09f0386c R15: 00007ffd09f03970
> > [   61.706500][ T5947]  </TASK>
> > [   61.709607][ T5947] Modules linked in: kmem xfs loop device_dax nd_pmem dax_pmem nd_btt btrfs blake2b_generic xor raid6_pq libcrc32c intel_rapl_msr intel_rapl_common x86_pkg_temp_thermal intel_powerclamp coretemp sd_mod t10_pi crc64_rocksoft_generic crc64_rocksoft crc64 kvm_intel sg kvm irqbypass crct10dif_pclmul crc32_pclmul crc32c_intel ghash_clmulni_intel sha512_ssse3 ahci ipmi_ssif rapl intel_cstate ast libahci mei_me drm_shmem_helper i2c_i801 ioatdma acpi_ipmi libata drm_kms_helper mei intel_uncore joydev i2c_smbus intel_pch_thermal dax_hmem dca wmi ipmi_si ipmi_devintf ipmi_msghandler nfit libnvdimm acpi_power_meter acpi_pad drm fuse ip_tables
> > [   61.768510][ T5947] ---[ end trace 0000000000000000 ]---
> > [   61.786010][ T5947] pstore: backend (erst) writing error (-28)
> > [ 61.792055][ T5947] RIP: 0010:do_swap_page (mm/memory.c:3990 (discriminator 3)) 
> > [ 61.797397][ T5947] Code: 6f 28 31 d2 be 01 00 00 00 4c 89 ff e8 9b 43 03 00 49 c7 47 28 00 00 00 00 4c 89 f9 48 c7 44 24 08 00 00 00 00 e9 cf fb ff ff <0f> 0b 49 8b 45 08 f0 48 83 28 01 0f 85 3f fc ff ff 49 8b 45 08 4c
> > All code
> > ========
> >    0:	6f                   	outsl  %ds:(%rsi),(%dx)
> >    1:	28 31                	sub    %dh,(%rcx)
> >    3:	d2 be 01 00 00 00    	sarb   %cl,0x1(%rsi)
> >    9:	4c 89 ff             	mov    %r15,%rdi
> >    c:	e8 9b 43 03 00       	call   0x343ac
> >   11:	49 c7 47 28 00 00 00 	movq   $0x0,0x28(%r15)
> >   18:	00 
> >   19:	4c 89 f9             	mov    %r15,%rcx
> >   1c:	48 c7 44 24 08 00 00 	movq   $0x0,0x8(%rsp)
> >   23:	00 00 
> >   25:	e9 cf fb ff ff       	jmp    0xfffffffffffffbf9
> >   2a:*	0f 0b                	ud2		<-- trapping instruction
> >   2c:	49 8b 45 08          	mov    0x8(%r13),%rax
> >   30:	f0 48 83 28 01       	lock subq $0x1,(%rax)
> >   35:	0f 85 3f fc ff ff    	jne    0xfffffffffffffc7a
> >   3b:	49 8b 45 08          	mov    0x8(%r13),%rax
> >   3f:	4c                   	rex.WR
> > 
> > Code starting with the faulting instruction
> > ===========================================
> >    0:	0f 0b                	ud2
> >    2:	49 8b 45 08          	mov    0x8(%r13),%rax
> >    6:	f0 48 83 28 01       	lock subq $0x1,(%rax)
> >    b:	0f 85 3f fc ff ff    	jne    0xfffffffffffffc50
> >   11:	49 8b 45 08          	mov    0x8(%r13),%rax
> >   15:	4c                   	rex.WR
> > 
> > 
> > The kernel config and materials to reproduce are available at:
> > https://download.01.org/0day-ci/archive/20231219/202312192319.fa8f5709-oliver.sang@intel.com
> > 
> > 
> > 
> > -- 
> > 0-DAY CI Kernel Test Service
> > https://github.com/intel/lkp-tests/wiki
> > 

