Return-Path: <linux-kernel+bounces-126098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADA3B893225
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 18:00:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F4184B21655
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 16:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48D05145342;
	Sun, 31 Mar 2024 15:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="na8k+o5C"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F8F4144D1A
	for <linux-kernel@vger.kernel.org>; Sun, 31 Mar 2024 15:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711900798; cv=fail; b=YzNapG7JLsGuTa1J9U4FLp96/1AmjtYxrIaBus+J5TuraDKxHOLK6tytLUgqVNLEXWcDsdMOhnQddBq/9O9bRy4C7fPxVEuweYX7AeMo8O02Yci0vNk3jVn2vXMrTjlhsykDXdtjaMFw5fUX1CP/sKaJp/2vFTba3tCRBoutGsU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711900798; c=relaxed/simple;
	bh=rlyB35T/vu2j+RDrpD36oktrNn/zarcbUHuHd1QeBr4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TGmhbCzHJyqpEvK9C+Gg2Sk+Crfh/Jk5YZjdIcaePp13PGcpSMVO0bQ+JlacwCzgCd9IM8fdhaE1gVEMtmax9HRawQg8CD1OEfZFfS0KiZmno5R2P0Fu2IqrKqXO7lYfpT2f60eaAafP2UaAueQgotfrGFceWedMpqBq7mnmvbw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=na8k+o5C; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711900796; x=1743436796;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=rlyB35T/vu2j+RDrpD36oktrNn/zarcbUHuHd1QeBr4=;
  b=na8k+o5C/oVqMU5Ox+4rcADORqwIhqUHs6hO3EnD4NBYiUZ00hjneQbz
   UgQhV5F0vliOPhHy/sOIusBaGxQKtI3Yf4bLLOQDZ8wBRNZx+PO5YQYoQ
   WFnZ7IzTtDes4dlZdj8oNQBiTbSpyckyysP9cETVNO+WLDmILSvytpgB9
   sii/8kI4dNROPuNpu7SsWfKhw0uhW7w8SkkXU3WDJ1Iz6iIlda9DKakxS
   iKgdzUwLj1S77sZ0CCM7pyEjMpfK5rwTAsE3SR5oRdRcpjs1mJd4PjeDk
   PPKHw3ZUm3L6Eo7DubQ4K6FSaJZeBFATnMoFg0+Untp14hk/J10dJjatn
   g==;
X-CSE-ConnectionGUID: Rcb11PF/QJakunEeMn0JQg==
X-CSE-MsgGUID: ntOW6+oUQByjsuMIptk/jg==
X-IronPort-AV: E=McAfee;i="6600,9927,11030"; a="17656459"
X-IronPort-AV: E=Sophos;i="6.07,170,1708416000"; 
   d="scan'208";a="17656459"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2024 08:59:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,170,1708416000"; 
   d="scan'208";a="17546296"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 31 Mar 2024 08:59:55 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 31 Mar 2024 08:59:55 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sun, 31 Mar 2024 08:59:55 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 31 Mar 2024 08:59:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SBQ3RueznAhES1TZgHUTVU2kQ3rqDAJQ27i8hlDMYl+bOw2KUE/R9es6pQR9oMztPFCYIguEn5MrjMqAFolRPZ1Z+HVuWnXlVZVzfu3B2Df9LUq5nDRTS66aF8hyIcVGuFOWwfbmeu8qY+a1cF5pocg9yY4dBeUay4XuF3ws55PcnabMgXMqokCaxIaEZCKspWIdwnmC/ryXAOz4s9ZIq6+dInhgh+0QK1MrQTbbnGABFxr9QfgTf5yGSOhPoTT6qr49Z6ijeox8WBTzKzr9xXnrninwIqqal6KLn7i56+K9X3/L4ztDSw7Am5LZyY0fM5MRdwnL6N8/juLsqQpg7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YINJUj3XMneMXLQPvicozO6Bwp+NxscUlScjtGOGkE8=;
 b=jL8mUkgjqlARk2zCj4tbRpo48QCazZogSftw6pSIKmDZo2CYdC6mMg1TcyKKOjcsRVNMaFRSbo8NwcTd17nGvW1ZPpk/Kp5LFolaPi3NJzI8xI3mPkIcSpk2UIs99Vl9FuksVEMCxVAMzldKcvl9FoA/yj/Ta38fb1lfZxI2tkQ2EP0cCjl+oLMFS5aPCtuDkM81KOOShlkJMXjqxg/2H2UQFrj9eu1RhwErrlRXhNzgs3zlij52+ETNBohYAWMeJx5855enYLMBJUnH/hpQS8kDBNHnY6cZAIiepY3YjzChzdN+puKvZZlJFJS9dyq9TA9g6iQg7IyWPnItnh7kDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY5PR11MB6392.namprd11.prod.outlook.com (2603:10b6:930:37::15)
 by MN2PR11MB4677.namprd11.prod.outlook.com (2603:10b6:208:24e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.24; Sun, 31 Mar
 2024 15:59:52 +0000
Received: from CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::7118:c3d4:7001:cf9d]) by CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::7118:c3d4:7001:cf9d%6]) with mapi id 15.20.7452.017; Sun, 31 Mar 2024
 15:59:52 +0000
Date: Sun, 31 Mar 2024 23:53:12 +0800
From: Yujie Liu <yujie.liu@intel.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
CC: kernel test robot <lkp@intel.com>, <oe-kbuild-all@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [paulmck-rcu:dev.2024.03.27b 64/69]
 arch/xtensa/include/asm/cmpxchg.h:77:25: error: implicit declaration of
 function 'cmpxchg_emu_u8'
Message-ID: <ZgmG6BR6TtejfQcC@yujie-X299>
References: <202403292321.T55etywH-lkp@intel.com>
 <0303151f-c12e-4350-804a-11e3b734df91@paulmck-laptop>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <0303151f-c12e-4350-804a-11e3b734df91@paulmck-laptop>
X-ClientProxiedBy: SI2PR04CA0005.apcprd04.prod.outlook.com
 (2603:1096:4:197::16) To CY5PR11MB6392.namprd11.prod.outlook.com
 (2603:10b6:930:37::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6392:EE_|MN2PR11MB4677:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QrXYLvcI/ney2EjH7cNF3Bi/2kagN4APvWbjZK5ZdQFb5LYnyZ/j4zceK551ttkl8PJB2N3ri6Sm9Y6xgat9uDNhvDl+JskSk9h8YAEwZ8Y/0XBPHVum5VXO0XW8w+piTEe8frYAnitwRJoRok/PndWX5HUn8/jCOsRGUDBKjhDLLOz3sOhbhw0msD/PCID1X/Tz8F+vAymdnLZzXbxSiE79FXAt7nCLfT3g1qrjgZ0pmzS0bN+jr8+UZTDqhTgWfZhud73/4E5Ehx/csxrcAkpJKnfqnGuA/xP7Tq5cdwDuxbpTBebHZa4QnHTlwkAz2qXWa5TSx+p97UG29GUUfgcgnJLIqGWk6p2kJV19TM5dYdr7R66mRj+Kc0ObfzPXea282z1gfWelE/joGhymBNLphdDoI72dPViA1qLk/ICp6Xk3ZOfgOeeUfjW5GVmAEFTfC5rZvu7+eVtjrjyNY7DCRJ+dqrmJzT0z4uLQI1TJ1GGPQD7woO4YCzRxFPZ7QJa0Oa/pnrANSZcamKdHNASYsPNDj/XPVq3QbXH7IYaGVL8kDt3cZj9ZpKoB23bEJCuzkK998pS0XzLbl3/EzNX6G5xt4OdcQuBM31B1Ce63mfDFySmV5rpiwKryBLrG
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?j+zWunrOjWW0diaC7z7xokloZ6vLh+xSMPr1sWkZHaPDofISB5W9udjFJ9H7?=
 =?us-ascii?Q?vBQTrbD5XLgkF54WUNE8EH6d7uI9A5dUcAcSr7RpoAo3M1GxHtldz40vCW9N?=
 =?us-ascii?Q?T5XHMF8gkhfaX/2Ye0node+MOMlaz4T40cM3Jgd9Q1PPOmEX4cEu3ednYF0F?=
 =?us-ascii?Q?SyoDN3bMFgAGfEZmhDEbiS9aFCtFwTr7IyphA2oxtkWF4LKgZizLCk1Ppj2T?=
 =?us-ascii?Q?b5J3YKl0Q0rtMLR3k5ybq3US42UJCCZ6Py8YG2l6IWPga9roTJPvvNr6MQFO?=
 =?us-ascii?Q?qoXflJGtqBy7jCrkOaYSe8r57TgYvM+GwTw4DhhyBY2RZeTPyIrud76l5BOy?=
 =?us-ascii?Q?a7zkKnZI9a/B9nzlPIaDhJerIGQ4BMlA8wIj2QElNrjoonPotQMBDWyh0eJh?=
 =?us-ascii?Q?zRomchNoQRUh9j9hXEPuEkmhTbFGRbtNCT27C7aNHsyJqUSCXwd3NpzyYRyK?=
 =?us-ascii?Q?EjRsGAgiNdJcB+s08ghzFaa3flKQ/WR5+tsHPHV2agFriw3gEo6hsRAXV7tu?=
 =?us-ascii?Q?bcz4g0OE+3E53fZvyrkGZHwxfROsBj0VIPm2Fwt1l5jWv7MhCTZUWdLYTPZ6?=
 =?us-ascii?Q?ahmRFjZf867zMo2V3z8z+Z0gKYfKguGKen7sWIbyjFhMwhikmecCY7/iUnjR?=
 =?us-ascii?Q?sHBf7n6pTtohFTc25fqpERzK/OilRlGuqzObLNkwVlfVVm/esymaSh/I1dxO?=
 =?us-ascii?Q?cEg623Tnc0j5fxuLinOjGopLKDMHYNPTBqUNGvWKgTOcQBbTcG8KPSSFhcnW?=
 =?us-ascii?Q?IUFKL1LBaX7Svn/t9T/QwBbEkzvcEiJcdl12VkXn7I4oPVrC9hyRuuk8Da+l?=
 =?us-ascii?Q?cod2AKGK8FtOjDrqnbN9Qx8Q9lZJw2Eq6b8QuVrEKgEAnftbA5BZNlmdxKJ9?=
 =?us-ascii?Q?6CaNRvV8+I48tF//cUyBkYa4K4H5+48p/pJEfPQOehCFQHns5sOe/FiQ5q34?=
 =?us-ascii?Q?NcyIJHWGIi/KdBMuRlLu/LN9H8M0FAwuuHKX4mE1TzyHetYnIBN7q1kOeNgG?=
 =?us-ascii?Q?cpAM7oYEwChASCpCcmIAasjnPXrsYhP0Ofb+Ff74vdsalgVm8W4kFoQpb6R1?=
 =?us-ascii?Q?BMg7n8LVC+vP9hsGBXfzV/g84yPPFB95zt8LDTLKd8zyD17jEsI8kY7r6ls2?=
 =?us-ascii?Q?gqQTbxBgmyuYaxM/H5M60pgc58AiSCmWUNbnpxgKSxRlPEwxG6h+IBMZ0DlB?=
 =?us-ascii?Q?zJsmhSVWPKPPcvwBAHNrFtuKjIUGn2LHX7bsEnRvNRyBe4y4+NoNNW1t2YvX?=
 =?us-ascii?Q?0N+HH1PdKOrFBKDGHSRvmVLUeRiTGQlYYTCXUY6u7cM1T8l7lpEsnwKD0aQZ?=
 =?us-ascii?Q?b87qDQ4dA/zwnpkQCgY0OQ9dCMK0tfPLCRgSFOMOHtjsg2nQlUzvWOz7Gn0E?=
 =?us-ascii?Q?jU6C16G5m6zZUhnq4ewWukhHdqy7ydfDJyEBkY0mB53oY841R1dcx8MRFT0w?=
 =?us-ascii?Q?uP0kJSujZyNM2b8YF3Ltc/ho17CEUaqbxVHqPtoP5+ccuNn4QXu/34VwD87n?=
 =?us-ascii?Q?IohPlMqOh5Npfd8RfMnHgkd0Jfc7oaEP8CbntiwaGFkRGoITypfGPfBYbwO0?=
 =?us-ascii?Q?hbqFBsn83vI3DPZDelmZ0JZrxy7eOxiAzXATRcUZ?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a004cdd-acec-413e-105c-08dc519b9982
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2024 15:59:52.0947
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3GxpdaDxVorGvrLWFyvJOsd8Y8n1Xt817xox0H6jMItY0IO1IMz0Gt6flgyMDaABOEPSfIzcn0GJtCFqdBMJdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4677
X-OriginatorOrg: intel.com

On Fri, Mar 29, 2024 at 11:48:37AM -0700, Paul E. McKenney wrote:
> On Fri, Mar 29, 2024 at 11:08:04PM +0800, kernel test robot wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2024.03.27b
> > head:   786fab3085d764055a78edb54023420920344333
> > commit: b3b1a154281fc97efc4c1d5818a83c29c228dbd5 [64/69] xtensa: Emulate one-byte and two-byte cmpxchg
> > config: xtensa-allnoconfig (https://download.01.org/0day-ci/archive/20240329/202403292321.T55etywH-lkp@intel.com/config)
> > compiler: xtensa-linux-gcc (GCC) 13.2.0
> > reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240329/202403292321.T55etywH-lkp@intel.com/reproduce)
> > 
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202403292321.T55etywH-lkp@intel.com/
> > 
> > All errors (new ones prefixed by >>):
> > 
> >    In file included from arch/xtensa/include/asm/atomic.h:19,
> >                     from include/linux/atomic.h:7,
> >                     from include/asm-generic/bitops/atomic.h:5,
> >                     from arch/xtensa/include/asm/bitops.h:192,
> >                     from include/linux/bitops.h:68,
> >                     from include/linux/log2.h:12,
> >                     from kernel/bounds.c:13:
> >    arch/xtensa/include/asm/cmpxchg.h: In function '__cmpxchg':
> > >> arch/xtensa/include/asm/cmpxchg.h:77:25: error: implicit declaration of function 'cmpxchg_emu_u8' [-Werror=implicit-function-declaration]
> >       77 |         case 1:  return cmpxchg_emu_u8((volatile u8 *)ptr, old, new);
> >          |                         ^~~~~~~~~~~~~~
> 
> Good catch!  Does the diff at the end fix this?

The error is fixed by the diff at the end.

Tested-by: Yujie Liu <yujie.liu@intel.com>

> 
> 							Thanx, Paul
> 
> > >> arch/xtensa/include/asm/cmpxchg.h:78:25: error: implicit declaration of function 'cmpxchg_emu_u16' [-Werror=implicit-function-declaration]
> >       78 |         case 2:  return cmpxchg_emu_u16((volatile u16 *)ptr, old, new);
> >          |                         ^~~~~~~~~~~~~~~
> >    cc1: some warnings being treated as errors
> >    make[3]: *** [scripts/Makefile.build:117: kernel/bounds.s] Error 1
> >    make[3]: Target 'prepare' not remade because of errors.
> >    make[2]: *** [Makefile:1197: prepare0] Error 2
> >    make[2]: Target 'prepare' not remade because of errors.
> >    make[1]: *** [Makefile:240: __sub-make] Error 2
> >    make[1]: Target 'prepare' not remade because of errors.
> >    make: *** [Makefile:240: __sub-make] Error 2
> >    make: Target 'prepare' not remade because of errors.
> > 
> > 
> > vim +/cmpxchg_emu_u8 +77 arch/xtensa/include/asm/cmpxchg.h
> > 
> >     72	
> >     73	static __inline__ unsigned long
> >     74	__cmpxchg(volatile void *ptr, unsigned long old, unsigned long new, int size)
> >     75	{
> >     76		switch (size) {
> >   > 77		case 1:  return cmpxchg_emu_u8((volatile u8 *)ptr, old, new);
> >   > 78		case 2:  return cmpxchg_emu_u16((volatile u16 *)ptr, old, new);
> >     79		case 4:  return __cmpxchg_u32(ptr, old, new);
> >     80		default: __cmpxchg_called_with_bad_pointer();
> >     81			 return old;
> >     82		}
> >     83	}
> >     84	
> > 
> > -- 
> > 0-DAY CI Kernel Test Service
> > https://github.com/intel/lkp-tests/wiki
> 
> commit 663161aaa5c3286dcfc9ba2cd9e12170f9354ea7
> Author: Paul E. McKenney <paulmck@kernel.org>
> Date:   Fri Mar 29 11:47:13 2024 -0700
> 
>     squash! xtensa: Emulate one-byte and two-byte cmpxchg
>     
>     [ paulmck: Apply kernel test robot feedback. ]
>     
>     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> 
> diff --git a/arch/xtensa/include/asm/cmpxchg.h b/arch/xtensa/include/asm/cmpxchg.h
> index bcce915a98e21..a0f9a2070209b 100644
> --- a/arch/xtensa/include/asm/cmpxchg.h
> +++ b/arch/xtensa/include/asm/cmpxchg.h
> @@ -15,6 +15,7 @@
>  
>  #include <linux/bits.h>
>  #include <linux/stringify.h>
> +#include <linux/cmpxchg-emu.h>
>  
>  /*
>   * cmpxchg
> 

