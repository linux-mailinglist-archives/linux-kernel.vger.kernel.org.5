Return-Path: <linux-kernel+bounces-163426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 262A58B6ABB
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 08:44:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0CF4281771
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 06:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53E191BC35;
	Tue, 30 Apr 2024 06:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mCD18L+R"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F06C1B5B1
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 06:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714459468; cv=fail; b=jv+z7z4Z5oRLmJ06uiCmZ9b4bbq88iu0cPWzCj9jZ22PrzjhmP4a+IdugJSRM/Ym5g7br6b9R1afOOLc/zn/RUjlLQ1XO1gZr0qm+1JaqG+hipTK3+Q7Ejt4gOxrNndGWOul2XrfCB6f0XqIZqA+9b/mccIyPghl97HDayag0qY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714459468; c=relaxed/simple;
	bh=PvjshIoJ1xRdP64dYkChPdGxfaQHnmpNGvlrcfL+HgU=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=uoeorgt66m8ufoy+n8D7e3yc48b7cReHFs8MZ5ihqjF6Q2H/bBkx2ndGJIAsn/0sC/pMKAeKcFx3RS9Sv+g4gAbNl6J7mLu036RFyksboOj+iFGfIvoUPbiwT0ZXeAG+940KjRlD9Rn6BgtBmht7mY26XNYWkjzIqxq89cnyZU0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mCD18L+R; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714459466; x=1745995466;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=PvjshIoJ1xRdP64dYkChPdGxfaQHnmpNGvlrcfL+HgU=;
  b=mCD18L+R++wKl7/7II0uch1ZkzC0u+6f4hsf5NKIqZ56igOYlx/XFWtb
   4eDVkVOrdzbjBLH02VvHHACz1fHcAsE9S6GwdO03TJeJMp2vGooBSGSr7
   okbJegjrCY2HInNhJShzFmRKCMcDw+SGWXW8lJ7EGv4BTMW73TyVSz7t0
   qWmxqVa2Nycjl5xXOoaXs2jDJa4wsO2E2eLZCnsAKXnM6lIyq6mby+Bv3
   K7R/e/+J5MoxEWwSTrbe+VSHLgzCNshDiNlz0Jbr++J4bWxxRaAFsHlsX
   DxXBNMPtk/fY95c2Sd88ZZF7J8Sgxu6V5CEn1ifJ4Kp/gyRlZwYFmXTOz
   g==;
X-CSE-ConnectionGUID: aKPj7zmvRrOIoRmQMJoFUw==
X-CSE-MsgGUID: k71xTFBSRTeSCBbKBijsCw==
X-IronPort-AV: E=McAfee;i="6600,9927,11059"; a="10316938"
X-IronPort-AV: E=Sophos;i="6.07,241,1708416000"; 
   d="scan'208";a="10316938"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2024 23:44:25 -0700
X-CSE-ConnectionGUID: p3KT++UySCSl9S5BtZM3+A==
X-CSE-MsgGUID: Ekgab+4bREez2IC6YDwr9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,241,1708416000"; 
   d="scan'208";a="49554993"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Apr 2024 23:44:25 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 29 Apr 2024 23:44:24 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 29 Apr 2024 23:44:24 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 29 Apr 2024 23:44:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KhLYPyJSPHqvCuhVXxY0uOKlULA7QzskKb4M+wCq7oGChLEZ0JGTxBaRieLisiJeVG56sRjxgz+DVnOm0Poml0I7h52m1tXpJQxPzvoQtor9OXX727gQoMVMJMA+GbuS6CShduOt71mHUIg+P8+1/siBTof9kIT3TOHKYbqaPuexa2d4vKIGo+14Ck4OcbxFd+mdQdgifEVmQRwcvC3i/3oe0kqPGSF64+xkD2sIqcssUDu30VR/MO9cdQPM0nmiSXlhf7XSJAD+11E+dAVQrubKiY9CVnUW1G5DAsa77My08HA+4UtMEMhf64KoddWImDOtNkrwUCO/mRfU0mjxyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sMLCAegT7fD8LIpMosSrUtXVPPEwwN7lHekluf7UP+8=;
 b=nXljj+rdC8DZ0RHpU7gMXkaXTqega4wAwxJ0Jdt3rUFzP+Abc9t2XRdzKaot1PgjtDyA3Ok4uQN/Cv15A9vFKamizHpF3qLT1VJarrJL/mj4T0WzUhQxNL14Rc8vhtEOiMNv9Bc1wanj3r3n78KmdUv7/+I9cEz1maPVUg5Msu0k97/CAYrXoJnB9dNG9AXgAFaYmQQiz7p54nqhsGh3bNJwfyzdB5lfDKcwAuadWhmKynDi1SIxuYee1ybbNhWlHwmLR2MCVNB2uf0uWqRLE8zFDpKXbHk6IjfLELnNh6sq3Sv+CiXM5qGiz6TeLGmhn+ZXNS6T8i9Dp3pAnBdKjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by CH0PR11MB8192.namprd11.prod.outlook.com (2603:10b6:610:191::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Tue, 30 Apr
 2024 06:44:22 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::58dd:99ca:74a6:2e3e]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::58dd:99ca:74a6:2e3e%3]) with mapi id 15.20.7519.035; Tue, 30 Apr 2024
 06:44:21 +0000
Date: Tue, 30 Apr 2024 14:44:13 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Marco Elver <elver@google.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Kees Cook <keescook@chromium.org>, <linux-arm-kernel@lists.infradead.org>,
	<kvmarm@lists.linux.dev>, <oliver.sang@intel.com>
Subject: [linus:master] [list_debug]  b16c42c8fd:
 WARNING:at_lib/list_debug.c:#__list_add_valid_or_report
Message-ID: <202404301424.203ace84-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SI1PR02CA0024.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::12) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|CH0PR11MB8192:EE_
X-MS-Office365-Filtering-Correlation-Id: a3ce18cf-a3a8-4793-69a5-08dc68e0f765
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?SDqcEdcV+Ms9ZMkLECIPkDi5RGBM4xelj+XpJRLrEmyC46mZbDwjEznjhCwe?=
 =?us-ascii?Q?15eYDMPSLspSGUPg1/Ka9K54XvYdCnBHymp9j9nbLJ/UnpadsWxxXqsIBO/4?=
 =?us-ascii?Q?M8E4fZZPAXclzotDTcBStKtN19zWQx/FF9/P5sk/By/9cs8iE5DD148wt+b2?=
 =?us-ascii?Q?5J2iWQIgfUdwYLc4l+r1DUUqpaYgl1/U7FkGS4ceZPmvhZkcm2cJGvM5qiYO?=
 =?us-ascii?Q?YsWLwT5vGbMYUhofFWikP75ly6dM/NFiRPFEGRjWFs6X8IytPYz+KwoB9Lpz?=
 =?us-ascii?Q?mFGd7Y+6XsCz7ju4DHenQ105EXfZ9hA7tjxBaAudaZCKCV+gkOkAw7mHLXyN?=
 =?us-ascii?Q?7U1H40wpfZ578H9BOb7Oi/0biRsmo4xJ9HYqYhWcGfGvLu368W0w5pl8ffb7?=
 =?us-ascii?Q?Mnn4s2DETrEXdllAcpiBwEyDdgdMeyZc4n1qKDoX3/EGmoCpc5U1leuiEtSQ?=
 =?us-ascii?Q?yij0zdKWOGzGPZrCII7j0jaXyLDSihcelkyHDaX/3IuKMkan4paQ4loeAkfx?=
 =?us-ascii?Q?B1JIkml1nhdn0f8j9DWa6ks/kdPJcJeEEjlt3Dvf03x3vMgp1SN2hKgrvWLO?=
 =?us-ascii?Q?jIyyeszbjUobR8V5meRKFuyflRqj/HoaYephl73I/Mi1WBy15DvrJVB7cDCy?=
 =?us-ascii?Q?t9/GqYxCvY35wvpzh+PP+w82lt/90iGyTmz1BHB0ekV7xkd/AHrYDSHW+FVZ?=
 =?us-ascii?Q?VbI5LHkWkBW95gHSt5HGAW+coPeWdls3G8AveQELhC5pezwazpVHag6V8m7T?=
 =?us-ascii?Q?NEsA72C8eczZ3lVlg+4aUXaz4rCgHe5ufaBtpOVjlxzWj3KU5E+GRl+Fv6Al?=
 =?us-ascii?Q?mZqlBg9vRHjdbIlbqrUDoSBLzl0UOEIOMU8yKcuErV94Oqf5U0PwdDQKaqv7?=
 =?us-ascii?Q?dWtFkcnBXAF+xYFaljfKZ2RCt6mhkG3DAWRtLfm4ERdtm9R8Q4Xp9uCuuqqN?=
 =?us-ascii?Q?8A3D7TMuNonNlop9x9GOGOER79FMVwkr2/Lwy1hcyAEEeVE+ol3lr0oHI581?=
 =?us-ascii?Q?CNznh8XwrJsjl+cCWWaUbn98XINznSwisP6G3PNBxNKz7NtEAz0tZdIPTtpe?=
 =?us-ascii?Q?czaH8m1ihcYjFINbSkvvvqYJArp6U/79QFEJEL/LO4qTsNS4IYyqrEVWwwgS?=
 =?us-ascii?Q?LEgP7PlZ+DOEPlSfOqIP6BFfbOTaqV+LQUN8zoJPCo9sAas/ibwl7uyxqMf0?=
 =?us-ascii?Q?M+R/lplQfUEH/vDm8CCxYncrAaQMhZMEnmPWw+7Fcxt7CMxtFj+iW6erCxg?=
 =?us-ascii?Q?=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Y08hgttxZRn37r32Kbb/wtT1ZhkXql3pyQ8lEPw96kkl/ajmQ8xXuplzFeZw?=
 =?us-ascii?Q?jaVGNLborct88L1llJMuO52bJ1gWFXaJNs/LSfQvF1X9t9uNwEQ2viJBlgAM?=
 =?us-ascii?Q?pNSwsJS+iOTZO3fu/qjvFH8JBC7KoT1Q8wPPHPddt11ERwPuAcIGJFcJii9p?=
 =?us-ascii?Q?uu8y4qhhIjm5VMh/mNmI9xIupZqcKnajxmVRfUtm/73upoRt0+z9/kUZv0Fr?=
 =?us-ascii?Q?g0nIJHCl3RHyENKjqQATcOomonbKYNDXQ+RxyDZsWpJvc4UY+PFOykAHOSmM?=
 =?us-ascii?Q?Dmv0KYgdnDtBkH0wD7KZCXFuILBThCwp8do9kl4JogUTufRe4isGH/4U/tLf?=
 =?us-ascii?Q?lUctJQIKJH8BJCbKS1t09yE0FhbMtaVvy2zRmvspSeYul8yIVWsvUjRefiiw?=
 =?us-ascii?Q?Qzjm3WmCJYayanhHWrUyz9J09E0l3Y2miA5N4mjmIWPffhAu/rVL1KsNcsrT?=
 =?us-ascii?Q?kgq+O7KchWYZg7FIrN8FMcMjQsWN07IyHnuRpeQhWUkSxcic7X5XVFPYo7Rv?=
 =?us-ascii?Q?yzajfO3dtVZ3BcQrTshqeac2nLm3/y/HE2QL2mpJH93rzdzZHTd3wUi0xq1y?=
 =?us-ascii?Q?yZMd25YRxgp7f0RIpEysX+9sFasQSNC2xZtPx+6SpE7hTGwwfFU6a3v6J6L/?=
 =?us-ascii?Q?aEYb23k2b2/9mkn4PuzFcgeQ38RP38HkNDF7uOZF8q3bfmvs0rb8sXDQapkY?=
 =?us-ascii?Q?mDMSP+Vbtd4SrcTXlrPi7JBr/qDKFiSBV+L4vbGV4iNQ5Vzpid55UL3NPg5c?=
 =?us-ascii?Q?1FcmJHkQ194yEQjPrzUQ4cfNxGXceDGwdR9OZuplCU5MRm4CmoLc3d2jMmcy?=
 =?us-ascii?Q?ECu4MgJLsMOKmXyzej1MTSeihaNwoGxegeJXeBWzsTYhzF9Cl71i1uZ8zQvp?=
 =?us-ascii?Q?bnRq9O8jPVX0tEpDMaqnAnScCw0XOvYyFgw2uSHWj35vRxb4Stu4Yl/koyeo?=
 =?us-ascii?Q?eU4VJdIB4uVadNfSxiF1PRlbE4jwr2OZlYE6vzwfF+BuoVx0WiF7Vc37oyqk?=
 =?us-ascii?Q?XomWFB3c3tyvYROWNnh3zcfJ5FSiJ9yvn9Geg+5p9p0nXM83+LKXJkgEudUj?=
 =?us-ascii?Q?flHc8SDmBWGh3PW5p2XZc4s4ZqbAbKXlwhTlN0IEjcyZ53qIBi8uSjumpNcw?=
 =?us-ascii?Q?k+MTRqikNUYI/lV4fQfcwTVfL7MbuOyUpDAgv6GhDKjcXD19jAxt4lmgUJVl?=
 =?us-ascii?Q?Flc0rl4PDDXad7oaqgaUEoi/Q0pwhgZ9fXa5nCo5nQ0hyD+MoBUJUgD/ZXC8?=
 =?us-ascii?Q?9PPaUAWkr0ZKJaF2QRJdWKOdVHq+QvhXHHh2/ySQyVBCU6RdDDWVnVozvpWn?=
 =?us-ascii?Q?/2AZJS9og3BMrVGvOayQglh/3hmwQwD5YHEaagktRWhB2xQEWO6M97HXdJfS?=
 =?us-ascii?Q?EozGMLl0H5xYO02sKO5IZYgQ3TqvWeJat1g/cCJcz8HXAbAYM2wDWKYBsBJi?=
 =?us-ascii?Q?3NgdB3YRmJY/Tlzul+UGg+ER45xHqjjMgOtx6W/rwzQh55I8cRxNa7Yt4drz?=
 =?us-ascii?Q?nNHZNCjxpX3R5XkDemuYRhGeG8xDlnoBaQbspYqb1x/dSkyxdGrqplZgvkSx?=
 =?us-ascii?Q?LUFsECLqWCWbxxQ8rVanFOGJZR3W6UXkygTU7hPerZW9WD2QQJUqsRjat8F6?=
 =?us-ascii?Q?VA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a3ce18cf-a3a8-4793-69a5-08dc68e0f765
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2024 06:44:21.5444
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vjxgszUGQ267C6mVHNM1YA0rNDttzj1tS36OMOhjCeClRT8w36NB6HxB/HYj+9qyGBo9BfXj8lV0RHb60W6O7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB8192
X-OriginatorOrg: intel.com



Hello,

we see a WARNING in this trinity test with a i386-randconfig.
we think it is not caused by this commit, but just changes the stats like below
by this commit:

7a0fd5e167850553 b16c42c8fde808b4f047d94f1f2
---------------- ---------------------------
       fail:runs  %reproduction    fail:runs
           |             |             |
          6:6          -83%            :6     dmesg.EIP:__list_add_valid
           :6           83%           6:6     dmesg.EIP:__list_add_valid_or_report
          6:6          -83%            :6     dmesg.WARNING:at_lib/list_debug.c:#__list_add_valid
           :6           83%           6:6     dmesg.WARNING:at_lib/list_debug.c:#__list_add_valid_or_report

however, we failed to bisect "WARNING:at_lib/list_debug.c:#__list_add_valid"
to capture real fbc. so just report on this commit FYI what we observed in our
tests.

below are details.



kernel test robot noticed "WARNING:at_lib/list_debug.c:#__list_add_valid_or_report" on:

commit: b16c42c8fde808b4f047d94f1f2aeda93487670d ("list_debug: Introduce inline wrappers for debug checks")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

[test failed on linus/master a93289b830ce783955b22fbe5d1274a464c05acf]
[test failed on linux-next/master 5e4f84f18c4ee9b0ccdc19e39b7de41df21699dd]

in testcase: trinity
version: trinity-i386-abe9de86-1_20230429
with following parameters:

	runtime: 300s
	group: group-02
	nr_groups: 5



compiler: gcc-13
test machine: qemu-system-i386 -enable-kvm -cpu SandyBridge -smp 2 -m 4G

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202404301424.203ace84-oliver.sang@intel.com


[  249.924267][ T3900] INFO: trying to register non-static key.
[  249.924758][ T3900] The code is fine but needs lockdep annotation, or maybe
[  249.925363][ T3900] you didn't initialize this object before use?
[  249.925873][ T3900] turning off the locking correctness validator.
[  249.926399][ T3900] CPU: 0 PID: 3900 Comm: trinity-c1 Tainted: G        W   E    N 6.5.0-rc2-00011-gb16c42c8fde8 #1
[  249.927271][ T3900] Call Trace:
[ 249.927544][ T3900] ? dump_stack_lvl (lib/dump_stack.c:107 (discriminator 1)) 
[ 249.927942][ T3900] ? dump_stack (lib/dump_stack.c:114) 
[ 249.928292][ T3900] ? register_lock_class (kernel/locking/lockdep.c:985 kernel/locking/lockdep.c:1297) 
[ 249.928726][ T3900] ? find_held_lock (kernel/locking/lockdep.c:5251 (discriminator 1)) 
[ 249.929118][ T3900] ? __lock_acquire (kernel/locking/lockdep.c:5022) 
[ 249.929508][ T3900] ? lock_acquire (kernel/locking/lockdep.c:467 (discriminator 4) kernel/locking/lockdep.c:5763 (discriminator 4) kernel/locking/lockdep.c:5726 (discriminator 4)) 
[ 249.929906][ T3900] ? __wait_for_common (kernel/sched/completion.c:74 kernel/sched/completion.c:106) 
[ 249.930325][ T3900] ? __schedule (kernel/sched/core.c:5384) 
[ 249.930710][ T3900] ? _raw_spin_lock_irq (include/linux/spinlock_api_smp.h:120 kernel/locking/spinlock.c:170) 
[ 249.931119][ T3900] ? __wait_for_common (kernel/sched/completion.c:74 kernel/sched/completion.c:106) 
[ 249.931530][ T3900] ? __wait_for_common (kernel/sched/completion.c:74 kernel/sched/completion.c:106) 
[ 249.931947][ T3900] ? usleep_range_state (kernel/time/timer.c:2129) 
[ 249.932361][ T3900] ? wait_for_common (kernel/sched/completion.c:118) 
[ 249.932753][ T3900] ? wait_for_completion_state (kernel/sched/completion.c:256) 
[ 249.933216][ T3900] ? kmod_dup_request_exists_wait (kernel/module/dups.c:211) 
[ 249.933720][ T3900] ? __request_module (kernel/module/kmod.c:168 (discriminator 1)) 
[ 249.934154][ T3900] ? __sock_create (net/socket.c:1517) 
[ 249.934545][ T3900] ? sock_create (net/socket.c:1588) 
[ 249.934918][ T3900] ? __sys_socket_create (net/socket.c:1625) 
[ 249.935337][ T3900] ? __sys_socket (net/socket.c:1652) 
[ 249.935712][ T3900] ? __do_sys_socketcall (net/socket.c:3015) 
[ 249.936145][ T3900] ? __ia32_sys_socketcall (net/socket.c:2986) 
[ 249.936576][ T3900] ? __do_fast_syscall_32 (arch/x86/entry/common.c:112 (discriminator 1) arch/x86/entry/common.c:178 (discriminator 1)) 
[ 249.937004][ T3900] ? lockdep_hardirqs_on_prepare (kernel/locking/lockdep.c:4589) 
[ 249.937542][ T3900] ? syscall_exit_to_user_mode (kernel/entry/common.c:300) 
[ 249.937989][ T3900] ? __do_fast_syscall_32 (arch/x86/entry/common.c:182) 
[ 249.938409][ T3900] ? __lock_release+0x4c/0x118 
[ 249.938839][ T3900] ? find_ge_pid (include/linux/rcupdate.h:777) 
[ 249.939211][ T3900] ? lockdep_hardirqs_on_prepare (kernel/locking/lockdep.c:4589) 
[ 249.939724][ T3900] ? syscall_exit_to_user_mode (kernel/entry/common.c:300) 
[ 249.940165][ T3900] ? __do_fast_syscall_32 (arch/x86/entry/common.c:182) 
[ 249.940580][ T3900] ? syscall_exit_to_user_mode (kernel/entry/common.c:300) 
[ 249.941029][ T3900] ? __do_fast_syscall_32 (arch/x86/entry/common.c:182) 
[ 249.941446][ T3900] ? __do_fast_syscall_32 (arch/x86/entry/common.c:182) 
[ 249.941847][ T3900] ? __do_fast_syscall_32 (arch/x86/entry/common.c:182) 
[ 249.942253][ T3900] ? __do_fast_syscall_32 (arch/x86/entry/common.c:182) 
[ 249.942646][ T3900] ? __do_fast_syscall_32 (arch/x86/entry/common.c:182) 
[ 249.943040][ T3900] ? __do_fast_syscall_32 (arch/x86/entry/common.c:182) 
[ 249.943459][ T3900] ? irqentry_exit_to_user_mode (kernel/entry/common.c:313) 
[ 249.943926][ T3900] ? irqentry_exit (kernel/entry/common.c:413) 
[ 249.944307][ T3900] ? do_fast_syscall_32 (arch/x86/entry/common.c:203 (discriminator 1)) 
[ 249.944708][ T3900] ? do_SYSENTER_32 (arch/x86/entry/common.c:247) 
[ 249.945082][ T3900] ? entry_SYSENTER_32 (arch/x86/entry/entry_32.S:840) 
[  249.945502][ T3900] ------------[ cut here ]------------
[  249.945937][ T3900] list_add corruption. prev is NULL.
[ 249.946397][ T3900] WARNING: CPU: 0 PID: 3900 at lib/list_debug.c:23 __list_add_valid_or_report (lib/list_debug.c:23 (discriminator 1)) 
[  249.947178][ T3900] Modules linked in: can_isotp ieee802154_socket ieee802154 af_key mpls_router smc rose qrtr kcm nfc rfkill phonet rxrpc cn ax25 crc32_pclmul crc32c_intel serio_raw floppy rtc_cmos fuse configfs autofs4 ofpart(E) cmdlinepart(E)
[  249.948959][ T3900] CPU: 0 PID: 3900 Comm: trinity-c1 Tainted: G        W   E    N 6.5.0-rc2-00011-gb16c42c8fde8 #1
[ 249.949823][ T3900] EIP: __list_add_valid_or_report (lib/list_debug.c:23 (discriminator 1)) 
[ 249.950334][ T3900] Code: e8 9b 14 56 00 83 c4 34 5b 5e 5f 5d 31 d2 31 c9 c3 55 89 e5 56 53 85 d2 74 06 85 c9 75 10 eb 1b 68 17 a7 11 42 e8 ad 8a c6 ff <0f> 0b eb 19 89 c3 89 d0 8b 51 04 39 c2 74 13 eb 19 68 4c a7 11 42
All code
========
   0:	e8 9b 14 56 00       	call   0x5614a0
   5:	83 c4 34             	add    $0x34,%esp
   8:	5b                   	pop    %rbx
   9:	5e                   	pop    %rsi
   a:	5f                   	pop    %rdi
   b:	5d                   	pop    %rbp
   c:	31 d2                	xor    %edx,%edx
   e:	31 c9                	xor    %ecx,%ecx
  10:	c3                   	ret
  11:	55                   	push   %rbp
  12:	89 e5                	mov    %esp,%ebp
  14:	56                   	push   %rsi
  15:	53                   	push   %rbx
  16:	85 d2                	test   %edx,%edx
  18:	74 06                	je     0x20
  1a:	85 c9                	test   %ecx,%ecx
  1c:	75 10                	jne    0x2e
  1e:	eb 1b                	jmp    0x3b
  20:	68 17 a7 11 42       	push   $0x4211a717
  25:	e8 ad 8a c6 ff       	call   0xffffffffffc68ad7
  2a:*	0f 0b                	ud2		<-- trapping instruction
  2c:	eb 19                	jmp    0x47
  2e:	89 c3                	mov    %eax,%ebx
  30:	89 d0                	mov    %edx,%eax
  32:	8b 51 04             	mov    0x4(%rcx),%edx
  35:	39 c2                	cmp    %eax,%edx
  37:	74 13                	je     0x4c
  39:	eb 19                	jmp    0x54
  3b:	68 4c a7 11 42       	push   $0x4211a74c

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2
   2:	eb 19                	jmp    0x1d
   4:	89 c3                	mov    %eax,%ebx
   6:	89 d0                	mov    %edx,%eax
   8:	8b 51 04             	mov    0x4(%rcx),%edx
   b:	39 c2                	cmp    %eax,%edx
   d:	74 13                	je     0x22
   f:	eb 19                	jmp    0x2a
  11:	68 4c a7 11 42       	push   $0x4211a74c
[  249.951968][ T3900] EAX: 00000000 EBX: 5538fd44 ECX: 00000000 EDX: 00000000
[  249.952569][ T3900] ESI: 70b1ae6c EDI: 00000000 EBP: 5538fd14 ESP: 5538fd08
[  249.953513][ T3900] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 0068 EFLAGS: 00010046
[  249.954136][ T3900] CR0: 80050033 CR2: 00000020 CR3: 034051c0 CR4: 000406b0
[  249.954715][ T3900] DR0: 33ceb000 DR1: 00000000 DR2: 00000000 DR3: 00000000
[  249.955298][ T3900] DR6: ffff0ff0 DR7: 00070602
[  249.955687][ T3900] Call Trace:
[ 249.955972][ T3900] ? show_regs (arch/x86/kernel/dumpstack.c:479 arch/x86/kernel/dumpstack.c:465) 
[ 249.956325][ T3900] ? __list_add_valid_or_report (lib/list_debug.c:23 (discriminator 1)) 
[ 249.956799][ T3900] ? __warn (kernel/panic.c:673) 
[ 249.957130][ T3900] ? report_bug (lib/bug.c:201 lib/bug.c:219) 
[ 249.957451][ T3900] ? up (kernel/locking/semaphore.c:193) 
[ 249.957706][ T3900] ? __list_add_valid_or_report (lib/list_debug.c:23 (discriminator 1)) 
[ 249.958098][ T3900] ? exc_overflow (arch/x86/kernel/traps.c:337) 
[ 249.958418][ T3900] ? handle_bug (arch/x86/kernel/traps.c:324) 
[ 249.958740][ T3900] ? exc_invalid_op (arch/x86/kernel/traps.c:345 (discriminator 1)) 
[ 249.959105][ T3900] ? handle_exception (arch/x86/entry/entry_32.S:1049) 
[ 249.959495][ T3900] ? print_usage_bug (kernel/locking/lockdep.c:4017) 
[ 249.959953][ T3900] ? emit_ia32_lsh_i64 (arch/x86/net/bpf_jit_comp32.c:899 (discriminator 1)) 
[ 249.960389][ T3900] ? exc_overflow (arch/x86/kernel/traps.c:337) 
[ 249.960768][ T3900] ? __list_add_valid_or_report (lib/list_debug.c:23 (discriminator 1)) 
[ 249.961248][ T3900] ? emit_ia32_lsh_i64 (arch/x86/net/bpf_jit_comp32.c:899 (discriminator 1)) 
[ 249.961661][ T3900] ? exc_overflow (arch/x86/kernel/traps.c:337) 
[ 249.962034][ T3900] ? __list_add_valid_or_report (lib/list_debug.c:23 (discriminator 1)) 
[ 249.962501][ T3900] ? list_add_tail (include/linux/list.h:98 (discriminator 1) include/linux/list.h:131 (discriminator 1)) 
[ 249.962879][ T3900] ? __prepare_to_swait (kernel/sched/swait.c:89) 
[ 249.963291][ T3900] ? __wait_for_common (kernel/sched/completion.c:83 (discriminator 1) kernel/sched/completion.c:106 (discriminator 1)) 
[ 249.963688][ T3900] ? usleep_range_state (kernel/time/timer.c:2129) 
[ 249.964083][ T3900] ? wait_for_common (kernel/sched/completion.c:118) 
[ 249.964467][ T3900] ? wait_for_completion_state (kernel/sched/completion.c:256) 
[ 249.964906][ T3900] ? kmod_dup_request_exists_wait (kernel/module/dups.c:211) 
[ 249.965386][ T3900] ? __request_module (kernel/module/kmod.c:168 (discriminator 1)) 
[ 249.965775][ T3900] ? __sock_create (net/socket.c:1517) 
[ 249.966144][ T3900] ? sock_create (net/socket.c:1588) 
[ 249.966506][ T3900] ? __sys_socket_create (net/socket.c:1625) 
[ 249.966932][ T3900] ? __sys_socket (net/socket.c:1652) 
[ 249.967299][ T3900] ? __do_sys_socketcall (net/socket.c:3015) 
[ 249.967721][ T3900] ? __ia32_sys_socketcall (net/socket.c:2986) 
[ 249.968158][ T3900] ? __do_fast_syscall_32 (arch/x86/entry/common.c:112 (discriminator 1) arch/x86/entry/common.c:178 (discriminator 1)) 
[ 249.968590][ T3900] ? lockdep_hardirqs_on_prepare (kernel/locking/lockdep.c:4589) 
[ 249.969155][ T3900] ? syscall_exit_to_user_mode (kernel/entry/common.c:300) 
[ 249.969591][ T3900] ? __do_fast_syscall_32 (arch/x86/entry/common.c:182) 
[ 249.969993][ T3900] ? __lock_release+0x4c/0x118 
[ 249.970421][ T3900] ? find_ge_pid (include/linux/rcupdate.h:777) 
[ 249.970787][ T3900] ? lockdep_hardirqs_on_prepare (kernel/locking/lockdep.c:4589) 
[ 249.971314][ T3900] ? syscall_exit_to_user_mode (kernel/entry/common.c:300) 
[ 249.971775][ T3900] ? __do_fast_syscall_32 (arch/x86/entry/common.c:182) 
[ 249.972201][ T3900] ? syscall_exit_to_user_mode (kernel/entry/common.c:300) 
[ 249.972648][ T3900] ? __do_fast_syscall_32 (arch/x86/entry/common.c:182) 
[ 249.973052][ T3900] ? __do_fast_syscall_32 (arch/x86/entry/common.c:182) 
[ 249.973473][ T3900] ? __do_fast_syscall_32 (arch/x86/entry/common.c:182) 
[ 249.973922][ T3900] ? __do_fast_syscall_32 (arch/x86/entry/common.c:182) 
[ 249.974364][ T3900] ? __do_fast_syscall_32 (arch/x86/entry/common.c:182) 
[ 249.974805][ T3900] ? __do_fast_syscall_32 (arch/x86/entry/common.c:182) 
[ 249.975235][ T3900] ? irqentry_exit_to_user_mode (kernel/entry/common.c:313) 
[ 249.975698][ T3900] ? irqentry_exit (kernel/entry/common.c:413) 
[ 249.976070][ T3900] ? do_fast_syscall_32 (arch/x86/entry/common.c:203 (discriminator 1)) 
[ 249.976473][ T3900] ? do_SYSENTER_32 (arch/x86/entry/common.c:247) 
[ 249.976838][ T3900] ? entry_SYSENTER_32 (arch/x86/entry/entry_32.S:840) 
[  249.977243][ T3900] irq event stamp: 187890
[ 249.977579][ T3900] hardirqs last enabled at (187889): raw_spin_rq_unlock_irq (arch/x86/include/asm/irqflags.h:42 arch/x86/include/asm/irqflags.h:77 kernel/sched/sched.h:1378) 
[ 249.978296][ T3900] hardirqs last disabled at (187890): _raw_spin_lock_irq (arch/x86/include/asm/preempt.h:80 (discriminator 10) include/linux/spinlock_api_smp.h:118 (discriminator 10) kernel/locking/spinlock.c:170 (discriminator 10)) 
[ 249.979000][ T3900] softirqs last enabled at (114732): __do_softirq (arch/x86/include/asm/preempt.h:27 (discriminator 1) kernel/softirq.c:400 (discriminator 1) kernel/softirq.c:582 (discriminator 1)) 
[ 249.979690][ T3900] softirqs last disabled at (114723): do_softirq_own_stack (arch/x86/kernel/irq_32.c:57 arch/x86/kernel/irq_32.c:147) 
[  249.980435][ T3900] ---[ end trace 0000000000000000 ]---
[  250.072040][ T3802] module: module-autoload: duplicate request for module net-pf-27
[  250.082073][ T3654] module: module-autoload: duplicate request for module net-pf-32



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240430/202404301424.203ace84-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


