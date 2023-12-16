Return-Path: <linux-kernel+bounces-2105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B64338157E8
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 06:59:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7DE4EB2479D
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 05:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC28D12B85;
	Sat, 16 Dec 2023 05:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jsTyNUtu"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FA4D125B9
	for <linux-kernel@vger.kernel.org>; Sat, 16 Dec 2023 05:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702706336; x=1734242336;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ozRJHUkLStOfh6AGFI9smbqOzIOYzZgkzpLwwGuj58s=;
  b=jsTyNUtuYeEJuI2yClxRVee95IXX0dut6tNNKhM6fcPNHqm6Si4O+vNx
   7HnT0W+F6PY7mAeOTEZNHmtJc+ur2I3MsPQ8kVp8nHxNX6Yc5rlGpO0GO
   rEhsZkUe75B1nI2xxWlCrcVIJconZYVmOse6DRiWSIMFff40A9EiH5Yky
   Y8uLqJ3KNhA2BPiCjBKlcS72ed2BUx+iCpdbLIjRYgvkNwK63kq2DUX+t
   BxQ/jCq8i7rCnVOnjRKxv3oSU6uoPWpJAevzsuDlPntjBtsrX3pNLXzRZ
   Z3709bgJCql1qbGKCXPZxvDC8FR1ScfBUEe8Vd+JqO3SU0NujokTfEjk5
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10925"; a="385779606"
X-IronPort-AV: E=Sophos;i="6.04,280,1695711600"; 
   d="scan'208";a="385779606"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2023 21:58:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10925"; a="1022173190"
X-IronPort-AV: E=Sophos;i="6.04,280,1695711600"; 
   d="scan'208";a="1022173190"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Dec 2023 21:58:54 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 15 Dec 2023 21:58:54 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 15 Dec 2023 21:58:54 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 15 Dec 2023 21:58:54 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 15 Dec 2023 21:58:54 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BXudtSD7zET5qpvVB5UwGeDGUvk3hol/qYS9xlMx5rByaadmKvqk0+vEQPLobjgmki9qrLk/8XMxbcxkFb342PkY4oOAf6OPnPfnKuinr3/VW9X8XAqOGZ46m19Wso9pZvPom2ubPL5Fi8bPP5iIkGbnNAw8r20NPUHiLsQOu71w+3yAy6FNdCU8whhLvr04SHV4cTQKdVhObfKIKmfvTVYiNNFNWYaUZyUjv95TsbACpT5MZZrSvGgbeJ/Wp+sr0C4qtoEY9BbwhXfUpWgvhKalYqXfz3AJvA6D2CnhTXO3tZItbjpjcTr2CxzYTibxk9lqwCQj5LyedEoCOKhE5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QIYb/zPiSf7B5QrmKunVMFiWD5x2Yx788Qbi5omgT74=;
 b=k1RdQUxW+0jp+FI32bV4Ax00dTFzrhfKAgRO7z4KpgF8zGLNkBNj0OwL24RwKM1jLWUD8YRqxP4PXlECNiIASy6iCtJKPyJRmAZ39+IdmB/opE1onsX0szZdRR00CLOowRerESIlgobp6Q3U3bQqNgUH6IHMSAo350TZGIoheHOs8UXQLEjJHD09bCqBIxlQFcuS0tCa56rxQ9nGI7ohkwiOJzb4j/Oc3mitrCg+p7OIRXd1ns7WxrTpVIDmRNYu7hxW+KLSXkpkg/alDM1EXdb1fnV/6bE72xNcFGNbKeazfUmZsu+mrbQ+i7kCjiFk52i08pw8vWi4hrjHNjmUYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL0PR11MB2995.namprd11.prod.outlook.com (2603:10b6:208:7a::28)
 by SJ2PR11MB8347.namprd11.prod.outlook.com (2603:10b6:a03:544::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.33; Sat, 16 Dec
 2023 05:58:52 +0000
Received: from BL0PR11MB2995.namprd11.prod.outlook.com
 ([fe80::2f1a:e62e:9fff:ae67]) by BL0PR11MB2995.namprd11.prod.outlook.com
 ([fe80::2f1a:e62e:9fff:ae67%5]) with mapi id 15.20.7091.030; Sat, 16 Dec 2023
 05:58:51 +0000
Date: Sat, 16 Dec 2023 13:58:43 +0800
From: Philip Li <philip.li@intel.com>
To: Matthew Wilcox <willy@infradead.org>
CC: kernel test robot <lkp@intel.com>, <oe-kbuild-all@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
	Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: filemap.c:(.text+0x4960): relocation truncated to fit:
 R_CKCORE_PCREL_IMM16BY4 against `__jump_table'
Message-ID: <ZX08kyNnueE2Yu4A@rli9-mobl>
References: <202312161000.zSaZMSRO-lkp@intel.com>
 <ZX0Vv3IyOi+Bp10Q@casper.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZX0Vv3IyOi+Bp10Q@casper.infradead.org>
X-ClientProxiedBy: SG2PR04CA0171.apcprd04.prod.outlook.com (2603:1096:4::33)
 To BL0PR11MB2995.namprd11.prod.outlook.com (2603:10b6:208:7a::28)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR11MB2995:EE_|SJ2PR11MB8347:EE_
X-MS-Office365-Filtering-Correlation-Id: bf4cd646-1bde-4ad9-70b7-08dbfdfc13c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pB1KxK7Xq0vX+RHTpR8dcRr48NnLu62LbixksERzY84+0uGYGsHn4GS93ym8l3gfj9XIQlUh1nglT0hkaPaIkw67Cuzfsd51qCYLEvSdF20MzfBMee4FzWOfxAqk7zwz3iaTzOwy3mRlCOAUYWGRO/8EdnxphgzG3sPnE7Ybfg+OzYQNaX23qmkS9uGRN2k5xBu26T+/o8sg9A2zAWvdJxSoryaW2ObxCTVYhJHlAWUQINy2LXx47ewhN6t0NNAaD6chOtk23/LqwpLCgXbYrbcD5YnctzBOJGfWORQR+feM7d+jaVQmfA65pJ6CWWsqHGL+HiuG5vSDAHCFlcDQAdlW8HyvyZrCOs14zJvFFYD16xVCMK3YgJKr0gh282CMuMtCxtGXBCygoSZlNNlQJGE4GciNMM3X8lTAmW0k3ZrYPq+oCLqDvseUUZ+NbyrpkI+fkCsTLiu7Gp2fTfAoJtky8NLOQdIl8B0QhkCJ+xV5brzVaMJEje1xstGFehvTZXE5NdLRQCLu3dqj/4hhY8VtNQVEM+GRtjpj78pgGBps3Nc10WqTy733dsKhSSfHkDUzWVXgOSMf6ZObLMBILQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB2995.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(366004)(136003)(376002)(346002)(39860400002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(9686003)(6666004)(6512007)(6506007)(26005)(82960400001)(38100700002)(86362001)(41300700001)(8936002)(8676002)(4326008)(33716001)(478600001)(2906002)(5660300002)(83380400001)(6486002)(966005)(44832011)(66946007)(66556008)(66476007)(54906003)(316002)(6916009);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?97ExaOdH+df7xdydYmyagrYqP1RUvc/+FN7cjJEA1TiFoOo/hKiDt2EXQX6d?=
 =?us-ascii?Q?jk0uLBAE8c5L3W9sJ4VQdWt9PQHfD2tEsl6KVJxv0fm9MALUARmPUaYBkva3?=
 =?us-ascii?Q?varLwCgTKk6+kRpzc60H3A6wdcLPNQFmKbXepXkImz1DCNV+7ACaV/ZHI3X+?=
 =?us-ascii?Q?oDY7vKVG2BQDXd6AorjH9Tsd626+krNXKGK5EOP3LfcucfIof8TCmXt8iTZD?=
 =?us-ascii?Q?gPxw3WQBqaR6RsSh7MlDwTJG0n6CAe854HVOVF3yVuxJGEiqfXc39G6chD0Q?=
 =?us-ascii?Q?8ecwugEBEKNF2PaVBYeUW9OhmTP9zMtF1cEN3npzSLkidWDq0146YEHA9T2c?=
 =?us-ascii?Q?o/kg/gv8jx5hAAM1lrAGANNtKIhCXmaZPXIKjpFd3iKZEjrXLYTZNLEcPdA/?=
 =?us-ascii?Q?DaZWDQCDtqlKO1zg+6mNR/tsJoPh47a8sZ8Z7z6Zs9CgtGvRqX0NSyStWx4B?=
 =?us-ascii?Q?fX23M5gLvr0I9CAwgAbUHTOw0QuAFwGjzGyysB6gxm/9H+lb7V/f7AO6PRNn?=
 =?us-ascii?Q?i7V6T6/z+x+2FvXBObTxeeadWOSIqgYD17vlZoGFO64Z0ugDhBFofjbPNDs4?=
 =?us-ascii?Q?Tiv/LlsFkCgAlyigROzmDridMufvRVs9hFKVeUrbUDszc+CjOGL0beqP3iDu?=
 =?us-ascii?Q?6AeMtdTdHnQeIyNEu9MbeYCTRHUkQMFlZBOucen7MQCFuMil5ksDp/wNKHrs?=
 =?us-ascii?Q?jPC/b5oiBIuSxdNW5cmvpaajkCvebGEFERwz+O4M4yLsI+cku/DsndlzcWn0?=
 =?us-ascii?Q?lTLxz+3KUEwkJwN0HNif07F34g0l3NCXXiDTW/+5ykH3100AYC5zCUVtkYdF?=
 =?us-ascii?Q?7XiA4NvZGc1Dab0bhq0pxZb5qNdvbfo9xXv+/iw+ZjITK0b53XlOEz1oBfUI?=
 =?us-ascii?Q?JL9lzmTOVAnnha+SFCsEzJr4iPUSIXTCmuRmJ5xL+ty8zRsfQg7Yng1OVHTY?=
 =?us-ascii?Q?MvgkepfOpEU1zqHvZJSXgPvVlvKrXRwkU1gWHsWgFB+cxjt49QuGlBFtSSyi?=
 =?us-ascii?Q?VlNP8Sfp+7V5FYbc2eaIDvE9QsEBAn5IpMIlcUhq652Akxp5i/yMdirFtKzL?=
 =?us-ascii?Q?v+mX9WmDFjUWgIKSs5MJixomMocK5iYLADQRJDVo8Hrne5IJcTPpXCzJrSZg?=
 =?us-ascii?Q?DpfGcXnLiYZYoKDg2ub7w2c8SYPUaJPj4yhQv6yXOKHBDPS8mCTnlRAV3ovr?=
 =?us-ascii?Q?hGgwEMMP6J83JraS8qfVHGfYuqV5BOXuvciDAlhbO8e9lT029EaY/E9K4LLV?=
 =?us-ascii?Q?GfBoKtxELyUMASi0qy5hUM9X0PK6gNo9fTuBhxXTOviwjLZOjjw1Us6yJQsa?=
 =?us-ascii?Q?JwBdFLQyfv3TVLqWewlsTNLRwnvx38feVrD8xg4NJq77MtMEss4G5xk5mT7l?=
 =?us-ascii?Q?L5b8fFw3bv8uAw3Tp6WbqE6CWsCNIaYnGXl1NicpGjQq/fi+arF7xIYPQBFi?=
 =?us-ascii?Q?0tFi2fMBbBUV7f5oKf72XU745Kb+qsJ1syITU9ceqTfaMAB0Ss6cndnbrL4h?=
 =?us-ascii?Q?qQ7NeWcE1dEC1Yi0z52cQv3jMozR75DX4beT0sJg5Aps4csa5wRTUFp3wYF+?=
 =?us-ascii?Q?kN9lKciF1bIX7xiyP3lPBWvHm2GAe95voSfdIx2I?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bf4cd646-1bde-4ad9-70b7-08dbfdfc13c8
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB2995.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2023 05:58:51.0503
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dN84BUF57RJfhVSFZQ8CWLZtEYp2MuHAKlECjcZpPCfJ6D9MJCDAvhwRqlPYziq90rxMQ52b0uNCWFc8F3RokQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8347
X-OriginatorOrg: intel.com

On Sat, Dec 16, 2023 at 03:13:03AM +0000, Matthew Wilcox wrote:
> On Sat, Dec 16, 2023 at 10:11:04AM +0800, kernel test robot wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > head:   3bd7d748816927202268cb335921f7f68b3ca723
> > commit: 2580d554585c52a644839864ef9238af5b030ebc mm: use folio_xor_flags_has_waiters() in folio_end_writeback()
> > date:   8 weeks ago
> > config: csky-buildonly-randconfig-r002-20220807 (https://download.01.org/0day-ci/archive/20231216/202312161000.zSaZMSRO-lkp@intel.com/config)
> > compiler: csky-linux-gcc (GCC) 13.2.0
> > reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231216/202312161000.zSaZMSRO-lkp@intel.com/reproduce)
> 
> This seems like a general problem with (some configurations of?) csky.
> I don't think I've made anything worse.  I don't intend to investigate
> this further.

Thanks for info, the bot will ignore this issue on csky to avoid less meaningful reports.

> 
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202312161000.zSaZMSRO-lkp@intel.com/
> > 
> > All errors (new ones prefixed by >>):
> > 
> >    mm/filemap.o: in function `folio_end_writeback':
> > >> filemap.c:(.text+0x4960): relocation truncated to fit: R_CKCORE_PCREL_IMM16BY4 against `__jump_table'
> >    filemap.c:(.text+0x4978): relocation truncated to fit: R_CKCORE_PCREL_IMM16BY4 against `__jump_table'
> >    filemap.c:(.text+0x4990): relocation truncated to fit: R_CKCORE_PCREL_IMM16BY4 against `__jump_table'
> >    filemap.c:(.text+0x49a2): relocation truncated to fit: R_CKCORE_PCREL_IMM16BY4 against `__jump_table'
> >    filemap.c:(.text+0x49b8): relocation truncated to fit: R_CKCORE_PCREL_IMM16BY4 against `__jump_table'
> >    filemap.c:(.text+0x49d2): relocation truncated to fit: R_CKCORE_PCREL_IMM16BY4 against `__jump_table'
> >    filemap.c:(.text+0x49f2): relocation truncated to fit: R_CKCORE_PCREL_IMM16BY4 against `__jump_table'
> >    filemap.c:(.text+0x4a0c): relocation truncated to fit: R_CKCORE_PCREL_IMM16BY4 against `__jump_table'
> >    filemap.c:(.text+0x4a4a): relocation truncated to fit: R_CKCORE_PCREL_IMM16BY4 against `__jump_table'
> >    filemap.c:(.text+0x4a50): relocation truncated to fit: R_CKCORE_PCREL_IMM16BY4 against `__jump_table'
> >    filemap.c:(.text+0x4a66): additional relocation overflows omitted from the output
> > 
> > -- 
> > 0-DAY CI Kernel Test Service
> > https://github.com/intel/lkp-tests/wiki
> 

