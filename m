Return-Path: <linux-kernel+bounces-2107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AC6F8157F4
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 07:10:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB2D9287EE1
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 06:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D50B12E43;
	Sat, 16 Dec 2023 06:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fiw18RHT"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F9A12B6E
	for <linux-kernel@vger.kernel.org>; Sat, 16 Dec 2023 06:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702707040; x=1734243040;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=x1Xu6s4CE965yeEfjk7VUpPij8Jz+JLEBOFhefeUTBI=;
  b=fiw18RHTf8NGmoN2loWmBmmwztLQYK2CjNpmyiGZQPJheHAYsRnChiBm
   nkzrelbltrALwUJ/TeN6vrbktgeWEG0Na16pr4XDQ+d1vQhUSsMWISSLo
   n8Iy9/LQHV0b2Nnl5iBwbfEg0yIJO76MUbaCMuwNv6nmsJUPVdQ2JKd0W
   t6iuvl4TDK0g0TZYl7AA7P8Fvn9zFzMHRjdiKcUft54ZYnqXDay5ikxWp
   gZD6yR0tMXmzj5m9GHnnnRO1GIumUkorGDroWGwTitjC7XaMEoxc7sIva
   IgGTCP0eiUhxGykwEspa2dxEmaqu1mw00L5/FFtTYLscoIsWSRoSI7sEh
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10925"; a="385780551"
X-IronPort-AV: E=Sophos;i="6.04,280,1695711600"; 
   d="scan'208";a="385780551"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2023 22:10:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10925"; a="1022175173"
X-IronPort-AV: E=Sophos;i="6.04,280,1695711600"; 
   d="scan'208";a="1022175173"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Dec 2023 22:10:40 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 15 Dec 2023 22:10:39 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 15 Dec 2023 22:10:39 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 15 Dec 2023 22:10:39 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 15 Dec 2023 22:10:38 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gnJfKip5lKxc7meetiITbaT6yi797mrqyruYkietVPZ2ZQGbV1rk+jHSTM9srJhftFPHl5oHNpK8tbHvxKwobFYfZ63XotKuaXEcC6JRDOk1H8TipwN/iwsDRdmE22hp2U0SGMuB0L92MeajqZR/mv/W2LXOmfBj+wb65gmgWQ8xUl1OdSfJkDyo4i+LAawURDOocMsUVG2h7V1o/vfEb2npGkbZl8wlxl/YE5JXW2Z2/pYUJUz/V4QYQRI50x4qvYLxpkoqbPzcSB+FtyRAI/58nC9regCsJr3eSVLzd54BNG89rrpmJBSO3UhYxWdcH2d+1NnIgq22CpDYZWgYRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kvXj8qfPCeo/oM+ax9p8I1DUSlA/Jc+BhIoXBLAOl48=;
 b=e4IFE1BJ6TuS52Hd7rj/MW10EPU0QO1lt0CzpNBBulbSsjE30rXucA/TdaFb6OYBqQZzNaaBPc/LhDTQQClagznAj95oSv3ySejECBYKdoKMSO/F0es+GonK6W9XqvAtbALg4KNnG3IDNJmbmC7VIklCBCxRAcYkAdXeSpOSz+14r5h62toQXsph+WBoGNwbm669kauoYY226pTbLTrxcU+XHfG0EfqtG3r1YLuPiBDmDMsNO2Y4vg+KPZcnqx1lHICZH3SkNm4XlbF8l303Lg10Wq4/Wl0a7jDcGMHZceG0WsUVVWrmG4PpxyDrIAFI4Pzmgqw+pkXz6BEJUX3Jxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL0PR11MB2995.namprd11.prod.outlook.com (2603:10b6:208:7a::28)
 by SJ0PR11MB5149.namprd11.prod.outlook.com (2603:10b6:a03:2d1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.33; Sat, 16 Dec
 2023 06:10:36 +0000
Received: from BL0PR11MB2995.namprd11.prod.outlook.com
 ([fe80::2f1a:e62e:9fff:ae67]) by BL0PR11MB2995.namprd11.prod.outlook.com
 ([fe80::2f1a:e62e:9fff:ae67%5]) with mapi id 15.20.7091.030; Sat, 16 Dec 2023
 06:10:35 +0000
Date: Sat, 16 Dec 2023 14:10:27 +0800
From: Philip Li <philip.li@intel.com>
To: kernel test robot <lkp@intel.com>
CC: "Darrick J. Wong" <djwong@kernel.org>, <oe-kbuild-all@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, Dave Chinner <dchinner@redhat.com>
Subject: Re: fs/xfs/scrub/fscounters.c:227:(.text+0xaa0): relocation
 truncated to fit: R_CKCORE_PCREL_IMM16BY4 against `__jump_table'
Message-ID: <ZX0/U+EYK1aMk6Vu@rli9-mobl>
References: <202312152147.JntukftP-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <202312152147.JntukftP-lkp@intel.com>
X-ClientProxiedBy: SG2PR04CA0174.apcprd04.prod.outlook.com (2603:1096:4::36)
 To BL0PR11MB2995.namprd11.prod.outlook.com (2603:10b6:208:7a::28)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR11MB2995:EE_|SJ0PR11MB5149:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a37c4f4-5780-4de6-94b6-08dbfdfdb7a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tQE5w6UglIyUgUjQO5S7Sam30EWYiKNp02xTJkZQUz8H1KoJTTU+D+pQc8cRrJkxfRE7WD/AU02WeIDBzg3E0JJnwd21/gOOjl3mBdzvNbyGz3SmbIm+evMz89WXvflX5XDoOqOIeeCmOGjxaI/X3/84uhACcnynL2pGzKbZkz1lKhhhZQdcOthgaWaPYOBzkBXvCxkr/8C7JeCI/gEtWIynQSLbuJiVRoGXLv1k0WTx1puWx9RgTDiNNvbbP7ElX8IYKPBfUt3eVR3bFncRz56/Ci3LldV34jLcH1cwJIwo2t/SuW3saJmFCtbApfoHpnCPAX6lnX7iJ5DSWSXMbFfwpZqUZmkLtSuKmfUGmVrjJpSKNrhFB1lIUE5BSw9S+YEdYZqTdMdprBUD60LfT0k1XVS1DXkg+PYF58krNy9yyHTzLjHs6kPm5cvcqklfsCokCafh6PcZuLRg4Bs15u7grTUivevzs3Bt0+RGzyjMh5CyasHwc6c1GqvyvLKo4fiSB+jEGwgbV368Vf63owBDZQswS9JG/cyc+/71yFir5RVgJI5TKteF3Vh34VRb67gQZiSww9SZsZXd7rCtwg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB2995.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(346002)(39860400002)(366004)(136003)(396003)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(33716001)(38100700002)(2906002)(86362001)(5660300002)(26005)(83380400001)(6506007)(82960400001)(6512007)(6666004)(9686003)(966005)(6486002)(41300700001)(54906003)(66556008)(6636002)(316002)(44832011)(66476007)(478600001)(66946007)(4326008)(6862004)(8676002)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3Q3Oje4xVgm+ROienTDFSH9OwvrU09FrnVqrAcm5fQFBB3kZJT7NVvlSjKBc?=
 =?us-ascii?Q?62AcDrR2jw1qwOsP/DkkTEFqoZiraijUMc5VlpoGz7Jmw6TEUQX3xSqDeQmk?=
 =?us-ascii?Q?2AIpewCZMgGRWls3M+CsE9gxWy0V8+CjnV+I4Hv8zoac0XhQWrbLTCCSHCAe?=
 =?us-ascii?Q?BbUtELyonH2MlEosQJBq29Xqt6FnEdaGs2O8+i4zxXt06f1XC1AUiVlUktzD?=
 =?us-ascii?Q?5Fx1Dc3skvnK+OOCANOHZkUF/d8RsSev2tddHNq3LOg3KBQmaNj+rYJPYDcA?=
 =?us-ascii?Q?sstfXC3j4issuwCfIl03erEkpy6xZJtapY4HdafmZJ3TInFGM7BKlfg1ycLV?=
 =?us-ascii?Q?W9RJRiClBLYnFnip2b/zYqxu2C1agS4tYIiyGygWzFbJ5Ph78liNM7UkDT3z?=
 =?us-ascii?Q?hH6GlFz0TR1gJgmxhVVh+iWxDZxiexCN1zGB5bFF2tiHnCL4KJb84EK32Ymz?=
 =?us-ascii?Q?gdpdBRNnVPTGYt9IBei4VYyGA5XFHqrsBzIMn5IU5cic6DPXI+yFRqlGigFz?=
 =?us-ascii?Q?ZnoJ92Zml01JHP3gEs1jPWyct6Kz1yJc0jEUVYsKCj2rEKYtvdThUll7ZE8p?=
 =?us-ascii?Q?sGlpxd5uqbtILo8dizk1VtgisTYz3t+wxEE3T+Xsc0mt3eSBBY4xOG83kdc/?=
 =?us-ascii?Q?BQaM9x+tkQPasWrEeE3b55iaxVbowxpBk4vH69Ii2QNMFSXCy8sKrX2PDWOr?=
 =?us-ascii?Q?AhCPuLrl6Q9pE2TvfGJpPwo+c1pZZL3IquvwN5NdHYypIfbPu+XXuKY0SF00?=
 =?us-ascii?Q?iErLxtczxFHlwH1KbBAeDVLsioGM00fdllp5DsACfQVfOARKJb3wFtUfIhFO?=
 =?us-ascii?Q?CKYxaYBq90jQg3xM/UX8dWyRukZDCXkrIppciUBwyXxoBRlJqxOd6rF44aL+?=
 =?us-ascii?Q?+7KSfaadJ4mTz0SFeac/INBXhsrUN2UKwUOzPiBileDMhwSf7gJfwyK1djXm?=
 =?us-ascii?Q?Mxkzrw4UonqU6WXXbAyDXso4/mkINUAUC0F9GUtF7jPpqoswRzJ4NUEgc1w6?=
 =?us-ascii?Q?pDFv3+QPpUAfV2jX6zYRiHAtmE3QMW66sPpbPjPjOcCbwtvmh+wKkcOgQx7I?=
 =?us-ascii?Q?oUbNnKGTRd5n9yjR1S2EZ/K2uzVlwN3WLCd4vv/iNnWyuFf5/k3Zrf5gzbmm?=
 =?us-ascii?Q?UjyJodLnN/Yj5SU64Vxtk27sCr7MJIhU/qRJBFshl4LORDGpXMV88hpZCdip?=
 =?us-ascii?Q?3rLQQsQKcKsl6ZcWNhX1uEa6znkJo7jbF/GTTx/yM1HZYkXN9iPVZD+dmA17?=
 =?us-ascii?Q?T/LlgI3su8cNh88hCHy3M4Bp7CoJ2Ihlf8yHXLgVLtceaTunuRhUk2pbJc41?=
 =?us-ascii?Q?ycyVR5Y8Nx3omB6wDdMPXcV+orb0G/lH6sKeOrOwpEavi1UKPMoX+cyInlNs?=
 =?us-ascii?Q?JzlR9EI2uXyPfe8msX401PqkBiTxBdIbPoR6/+Uwe1XtRCnQVCzXdw9Is9c8?=
 =?us-ascii?Q?ckf2yw07mBldSFVyp2XMx0e9Q8kYPq8GGn75SibUWFiBhMZ3qSUC+3DCiKbn?=
 =?us-ascii?Q?nHnyaoG7142gWhMIGwizeM3uDlKv2Yoz4+6lDIv4OsZzbzg30IjWlXJLGdVb?=
 =?us-ascii?Q?rwlhDkpyOMLNQSs5OzmqFDW7tP7TFv6g/7xA9bj2?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a37c4f4-5780-4de6-94b6-08dbfdfdb7a9
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB2995.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2023 06:10:35.6018
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dhveyyGW6eTOjdZy/DWKeO2APVOA1NA42cmddlcaTllx7VzTWvwLuvTo3FvN24kcZ7zuJ99O5o1mKy30HpuvJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5149
X-OriginatorOrg: intel.com

On Fri, Dec 15, 2023 at 09:47:22PM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   3f7168591ebf7bbdb91797d02b1afaf00a4289b1
> commit: ce85a1e04645b1ed386b074297df27ab5b8801c0 xfs: stabilize fs summary counters for online fsck
> date:   4 months ago
> config: csky-randconfig-r033-20230427 (https://download.01.org/0day-ci/archive/20231215/202312152147.JntukftP-lkp@intel.com/config)
> compiler: csky-linux-gcc (GCC) 13.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231215/202312152147.JntukftP-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of

Kindly ignore this report, which could be the same reason as [1] that it is a
problem of csky when certain config is enabled. And the bot will skip the future
report for this.

[1] https://lore.kernel.org/oe-kbuild-all/202312161000.zSaZMSRO-lkp@intel.com/

> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202312152147.JntukftP-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
>    fs/xfs/scrub/fscounters.o: in function `__fatal_signal_pending':
> >> include/linux/sched/signal.h:406:(.text+0xa0a): relocation truncated to fit: R_CKCORE_PCREL_IMM16BY4 against `__jump_table'
>    fs/xfs/scrub/fscounters.o: in function `xfs_buf_relse':
> >> fs/xfs/xfs_buf.h:285:(.text+0xa2a): relocation truncated to fit: R_CKCORE_PCREL_IMM16BY4 against `__jump_table'
>    fs/xfs/xfs_buf.h:286:(.text+0xa36): relocation truncated to fit: R_CKCORE_PCREL_IMM16BY4 against `__jump_table'
>    fs/xfs/scrub/fscounters.o: in function `kmalloc_type':
> >> include/linux/slab.h:395:(.text+0xa6c): relocation truncated to fit: R_CKCORE_PCREL_IMM16BY4 against `__jump_table'
>    fs/xfs/scrub/fscounters.o: in function `kmalloc':
>    include/linux/slab.h:582:(.text+0xa80): relocation truncated to fit: R_CKCORE_PCREL_IMM16BY4 against `__jump_table'
>    fs/xfs/scrub/fscounters.o: in function `xchk_setup_fscounters':
> >> fs/xfs/scrub/fscounters.c:227:(.text+0xaa0): relocation truncated to fit: R_CKCORE_PCREL_IMM16BY4 against `__jump_table'
>    fs/xfs/scrub/fscounters.c:230:(.text+0xaaa): relocation truncated to fit: R_CKCORE_PCREL_IMM16BY4 against `__jump_table'
>    fs/xfs/scrub/fscounters.c:240:(.text+0xac2): relocation truncated to fit: R_CKCORE_PCREL_IMM16BY4 against `__jump_table'
>    fs/xfs/scrub/fscounters.c:245:(.text+0xad4): relocation truncated to fit: R_CKCORE_PCREL_IMM16BY4 against `__jump_table'
>    fs/xfs/scrub/fscounters.c:218:(.text+0xae0): relocation truncated to fit: R_CKCORE_PCREL_IMM16BY4 against `__jump_table'
>    fs/xfs/scrub/fscounters.o: in function `xchk_fscounters':
>    fs/xfs/scrub/fscounters.c:515:(.text+0xb30): additional relocation overflows omitted from the output
> 
> 
> vim +227 fs/xfs/scrub/fscounters.c
> 
> ce85a1e04645b1 Darrick J. Wong 2023-08-04  205  
> 75efa57d0bf5fc Darrick J. Wong 2019-04-25  206  int
> 75efa57d0bf5fc Darrick J. Wong 2019-04-25  207  xchk_setup_fscounters(
> 026f57ebe1beea Darrick J. Wong 2021-04-07  208  	struct xfs_scrub	*sc)
> 75efa57d0bf5fc Darrick J. Wong 2019-04-25  209  {
> 75efa57d0bf5fc Darrick J. Wong 2019-04-25  210  	struct xchk_fscounters	*fsc;
> 75efa57d0bf5fc Darrick J. Wong 2019-04-25  211  	int			error;
> 75efa57d0bf5fc Darrick J. Wong 2019-04-25  212  
> 466c525d6d35e6 Darrick J. Wong 2023-04-11  213  	/*
> 466c525d6d35e6 Darrick J. Wong 2023-04-11  214  	 * If the AGF doesn't track btreeblks, we have to lock the AGF to count
> 466c525d6d35e6 Darrick J. Wong 2023-04-11  215  	 * btree block usage by walking the actual btrees.
> 466c525d6d35e6 Darrick J. Wong 2023-04-11  216  	 */
> 466c525d6d35e6 Darrick J. Wong 2023-04-11  217  	if (!xfs_has_lazysbcount(sc->mp))
> 466c525d6d35e6 Darrick J. Wong 2023-04-11  218  		xchk_fsgates_enable(sc, XCHK_FSGATES_DRAIN);
> 466c525d6d35e6 Darrick J. Wong 2023-04-11  219  
> 306195f355bbdc Darrick J. Wong 2022-11-06  220  	sc->buf = kzalloc(sizeof(struct xchk_fscounters), XCHK_GFP_FLAGS);
> 75efa57d0bf5fc Darrick J. Wong 2019-04-25  221  	if (!sc->buf)
> 75efa57d0bf5fc Darrick J. Wong 2019-04-25  222  		return -ENOMEM;
> ce85a1e04645b1 Darrick J. Wong 2023-08-04  223  	sc->buf_cleanup = xchk_fscounters_cleanup;
> 75efa57d0bf5fc Darrick J. Wong 2019-04-25  224  	fsc = sc->buf;
> e74331d6fa2c21 Darrick J. Wong 2022-11-06  225  	fsc->sc = sc;
> 75efa57d0bf5fc Darrick J. Wong 2019-04-25  226  
> 75efa57d0bf5fc Darrick J. Wong 2019-04-25 @227  	xfs_icount_range(sc->mp, &fsc->icount_min, &fsc->icount_max);
> 75efa57d0bf5fc Darrick J. Wong 2019-04-25  228  
> 75efa57d0bf5fc Darrick J. Wong 2019-04-25  229  	/* We must get the incore counters set up before we can proceed. */
> 75efa57d0bf5fc Darrick J. Wong 2019-04-25  230  	error = xchk_fscount_warmup(sc);
> 75efa57d0bf5fc Darrick J. Wong 2019-04-25  231  	if (error)
> 75efa57d0bf5fc Darrick J. Wong 2019-04-25  232  		return error;
> 75efa57d0bf5fc Darrick J. Wong 2019-04-25  233  
> ce85a1e04645b1 Darrick J. Wong 2023-08-04  234  	/*
> ce85a1e04645b1 Darrick J. Wong 2023-08-04  235  	 * Pause all writer activity in the filesystem while we're scrubbing to
> ce85a1e04645b1 Darrick J. Wong 2023-08-04  236  	 * reduce the likelihood of background perturbations to the counters
> ce85a1e04645b1 Darrick J. Wong 2023-08-04  237  	 * throwing off our calculations.
> ce85a1e04645b1 Darrick J. Wong 2023-08-04  238  	 */
> ce85a1e04645b1 Darrick J. Wong 2023-08-04  239  	if (sc->flags & XCHK_TRY_HARDER) {
> ce85a1e04645b1 Darrick J. Wong 2023-08-04  240  		error = xchk_fscounters_freeze(sc);
> ce85a1e04645b1 Darrick J. Wong 2023-08-04  241  		if (error)
> ce85a1e04645b1 Darrick J. Wong 2023-08-04  242  			return error;
> ce85a1e04645b1 Darrick J. Wong 2023-08-04  243  	}
> ce85a1e04645b1 Darrick J. Wong 2023-08-04  244  
> ce85a1e04645b1 Darrick J. Wong 2023-08-04  245  	return xfs_trans_alloc_empty(sc->mp, &sc->tp);
> 75efa57d0bf5fc Darrick J. Wong 2019-04-25  246  }
> 75efa57d0bf5fc Darrick J. Wong 2019-04-25  247  
> 
> :::::: The code at line 227 was first introduced by commit
> :::::: 75efa57d0bf5fcf650a183f0ce0dc011ba8c4bc8 xfs: add online scrub for superblock counters
> 
> :::::: TO: Darrick J. Wong <darrick.wong@oracle.com>
> :::::: CC: Darrick J. Wong <darrick.wong@oracle.com>
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
> 

