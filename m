Return-Path: <linux-kernel+bounces-32524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4934835CAB
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 09:32:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 164DD1C21DBA
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 08:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1AF52110B;
	Mon, 22 Jan 2024 08:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dyZMGVN+"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B9C39AC4
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 08:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=134.134.136.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705912292; cv=fail; b=rU1jhBzQZyo2PA+X4+MlMUxhJYV+dIYHhHG5sWklwRd5551pFsalTVkf6w+IQNUJupMVXGZFLtyvrMmTTHyBY8lTiZQMBO+lgIlnplLeF7Rl1h3K9aOCY6IrNAWwn4DkcfC/N3OnXBosNWWfaUBGUD562AunJKalt546F5coWZ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705912292; c=relaxed/simple;
	bh=dpO6A5vC+WLqa7Ocp3DNpfWYcY/b6OOM8KxVPSZ+MvU=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=kdmfCwFtZ36cO4jMkedXBmjOZsR9E6lmwLtXTqd4Kt54E9xfAd90ziyiKGAYQ8jvhZwYuX8M1xmcTRHkMM/G4ZvRDqd54uQZbPLpxwQAXUQ1yGOPfduVEA8AmUQKbe93+r6aNagGiO6QSbz/oFm1zaXL6Sb8xvhQnQKRDuT5ak0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dyZMGVN+; arc=fail smtp.client-ip=134.134.136.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705912289; x=1737448289;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=dpO6A5vC+WLqa7Ocp3DNpfWYcY/b6OOM8KxVPSZ+MvU=;
  b=dyZMGVN+fnZUyoys4DMTno5NTETHiQIulwspCcXA1y1CewN+sOczM8wR
   BEVoLxiXkcwQ5nTmRUyxYjzlBLieyOZgCh+/KlTX7FzrEvSIMspT0Ls8K
   F3Oc6cVeF7m+8oeSaeKbgttga1Z9bWlN+aDaykeB/fm9HGpChZgLhsGHJ
   VJQLiea2nvVV9XdVPAyhtyNOTe5MkMBhAlf17OOU6j1xM16x9vWDbDod9
   moGeLigJpHHblHQJEwoogQAapm8LkHvQQf4NjZ/U9hLItw6ZDmjdnmrsU
   XE3FTXKKo46KlOStSMzHDHd011sPWMWbBZnHAYGzV55fgpTEpRhaIPt7v
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10960"; a="404899312"
X-IronPort-AV: E=Sophos;i="6.05,211,1701158400"; 
   d="scan'208";a="404899312"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2024 00:31:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10960"; a="908871084"
X-IronPort-AV: E=Sophos;i="6.05,211,1701158400"; 
   d="scan'208";a="908871084"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Jan 2024 00:31:20 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 22 Jan 2024 00:31:19 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 22 Jan 2024 00:31:18 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 22 Jan 2024 00:31:18 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 22 Jan 2024 00:31:18 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MXwc5qe0JOb2MGRRLTunpCOFzhNZKxtT3acRJ9g5oFGX+TD3opNWkWp8UaleTdt6ZDAbO5J7JaXGsROH+lEq+wbXmjdMEZe9dD5wUVki1qZVsZZyEqDq7xghmoDUk0J2/lcbKgjCbeGtEjVNW5XRC/hBirUAn+hfSiwqp/PFWQQzHB4BpLap7Lx/fWAVs7+wWjmR3MG5AhyudGvQkf9aC2zAm+klTca/5b6dyTeorjqFJ9YpBCUB8SagnbrjOwvqQKcrDn4FNDmhVB3/W2HQmJ8eTw2XyrcUdIKf5em9sEe9kripUcO/VtcfuY4rMcEX9T11trubqojpg0p2TmykCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZNyeEUzuBIcpsuaitmkcHurfn1FqjMhfMztRbRKo/nU=;
 b=JlCyaiQPp2w8yzNncOO0Hhg35vTDj8mE2gpOgdTMFyBsKr0CetQn7zI6zX0vRDCmW1I19AvPS/4wOEYqD+VPXXg4YKCyVRQCN3I46jJA2pEXDtdVe/I+qndgvsONH0NN3ULsKWTYi3mX/1hJN0hE/NMh2llhznVfXbu6p0DxW1tJgGpKIndXeVJrMsMLO/ATsh4zH8vCHbI6bgaQMsHyxXdMQrPnczEHoQB8iaNRgROTzxcTdXLVumplEDVzbyG+w+9aSIwqOPwR0Dm+DG7qTA4ELtDC4LZNgdeHKJxy9xHHs581DvC/E3Un0IdNx+NYVpqE8g6duN6KFL1u+aXYhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB8414.namprd11.prod.outlook.com (2603:10b6:610:17e::19)
 by SJ1PR11MB6084.namprd11.prod.outlook.com (2603:10b6:a03:489::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.31; Mon, 22 Jan
 2024 08:31:16 +0000
Received: from CH3PR11MB8414.namprd11.prod.outlook.com
 ([fe80::ed34:4cf2:df58:f708]) by CH3PR11MB8414.namprd11.prod.outlook.com
 ([fe80::ed34:4cf2:df58:f708%4]) with mapi id 15.20.7202.034; Mon, 22 Jan 2024
 08:31:15 +0000
Date: Mon, 22 Jan 2024 16:31:08 +0800
From: kernel test robot <lkp@intel.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
CC: <oe-kbuild-all@lists.linux.dev>, <linux-kernel@vger.kernel.org>, "Mark
 Brown" <broonie@kernel.org>
Subject: sound/ac97/bus.c:192: warning: Function parameter or member 'drv'
 not described in 'snd_ac97_codec_driver_register'
Message-ID: <Za4nzDtwGVA+U1OL@rli9-mobl>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SG2PR04CA0157.apcprd04.prod.outlook.com (2603:1096:4::19)
 To CH3PR11MB8414.namprd11.prod.outlook.com (2603:10b6:610:17e::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8414:EE_|SJ1PR11MB6084:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b938a89-c673-4d52-9da0-08dc1b247f82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NRwGrmMA3dZvw7yBxjLcmvc+LvN6rRZvNRCD8C7NNXNvRr6ZfglTSPbCtbSuZqverr75Fuor35s8RoWtjTsK+KaIG3wp6c41uQ4NyY/CogjRt2APv+dOwGJtXMDvvovjfjKez48dh6BeGqbzhKjO2P2obbRTCpxrR+oJA4trriV0CC7MYcss7qfVq4grB0s6eGTw5ItV3wbaWiVBN4g/oLZLv3/23exTxusacqP/1X/1t8Plre6Yu2/nS8hDKY91VWpDUWg4KyZObuvhgNxmCopxivpDncjqldgYK5M1ydIib7vfrLtdwwGLMR4zBG376D0grRr6PuRVtBa0203rUU4fpPh4/Sbcz1+/Q7eHw8kbEGzWtDw2fEFuq9rm1yZFVpPrNKjxzMqMTqLg6x2rxyFTRaUHfukim8SSd0oKLWsImMwDIzzQDPyMrIFfkvv68ED76/jHiL9fz1GhJL/I9+dkqPp1wAWCRxppCkJk8l605l0tuYzl23cigULANWfQmx+zst6QZ9vUkrpgMl64rGk1XEsY8cIHlM6sDfEtkItFm4d3fPORCHNMNGUDVNr2Ro+Ed4Kka/qPbFVjTdhDCf0US3WIntcEgI8o07HFOisovuTkyc3vNouEOXAu72uHAHiVI16IiEP1gSmHpfuqlbYZaPfuwSfzVK+1xVKIRJHNYwS6n2DeL9CBFrE3Jv7/KckzkAzM59Mk1q3DsplfCQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8414.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(39860400002)(376002)(136003)(396003)(366004)(230173577357003)(230922051799003)(230273577357003)(1800799012)(451199024)(186009)(64100799003)(6506007)(9686003)(26005)(6666004)(6512007)(966005)(83380400001)(5660300002)(30864003)(6486002)(4326008)(2906002)(8936002)(33716001)(41300700001)(316002)(478600001)(6916009)(66946007)(66476007)(66556008)(8676002)(82960400001)(86362001)(38100700002)(67856001)(15866825006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EqPKAPpHptFGTl13JindKbSQ28pwvm2VFd/ox1ygcHEfa3YMY8wHbkQbjsiV?=
 =?us-ascii?Q?rjP72WV3eJZ2WhvbqcfOnoWXIQMzMBKm0d79f4KL3Dm07C41I0suwappGocn?=
 =?us-ascii?Q?Ye8qtHGIcIi11m8v4Ee9dkdlUzHVZtvZXutj8OouKAEkH62/58ArxGg0wbiY?=
 =?us-ascii?Q?5l3IINOPzOb5zoXYJWV/DBBsSTxZ6NIEgGVzD4CGfBg2ldJ5idruytH191nj?=
 =?us-ascii?Q?fuv/Um++EKuFu3wgWkeoyjYZ3HbKW1rkO7lPbfFbW8Mh6H6fzLekDRgk0ci2?=
 =?us-ascii?Q?E9imcwlhivmvlHgAHfkeWnyzlyxyvUkmHNCpLPLdxmxreoDMHMzkbStNFjH3?=
 =?us-ascii?Q?xsFO8ExR3R5L5DFV2fa0jtsQfo/DrKusdGkQ/Ue1TpzmVl1bqonK3uxxoB67?=
 =?us-ascii?Q?U8XQnXEreDWEPZHsSqjVgcIb6hxAXE9xgR0M+4pgwzRpRmLU+b1l+OSwrbFb?=
 =?us-ascii?Q?CCD6Yi1bG/gN3FMLNIm2qX3yUqOtPn54O/1+DQmcO4wJyzk3cP7CjpVCvy7g?=
 =?us-ascii?Q?k37U/B1aZ3/EZkbRhmUQLIHOmyHJIkwYzQzg/nN3SkUmEFVi5Yzd0t5tqDHA?=
 =?us-ascii?Q?rmWtCnU//q0HvyUHXlLiALcT4BVmEnIrohaokSoceAvPD0pDUnzWJxdcw3Rs?=
 =?us-ascii?Q?AIkw+v0esZJLeNAiaw57hsRabgGbtFe4wE0RPnH9QFLhVY2mrpoQx+g5HzOs?=
 =?us-ascii?Q?c+1wuVmNSONbN+vnP4Rm1hSmUMd9ufmFT0XZXSco3EWFzRXTYuw5AdOqSKzu?=
 =?us-ascii?Q?3j1NoP3jj7ji54zJ9srBLWbCE1S6mD1cYihpc3Pth/5qR9IAhI7VS/g/S89j?=
 =?us-ascii?Q?Z3jelx5VrkW+Tsf0Iee4l+5onhH4CmaURxKfwHHE8KWb0Av8mNfLeRz1REz8?=
 =?us-ascii?Q?xofPy5wbl6kepRoOrCxF8TCyxEQzLkIPGG4sFvKh3gUBuRmI8dNPd64YGFtH?=
 =?us-ascii?Q?3h2Cm/l5pZONL9qO8DxwgkR3IoWLLRIoHY3+SifiTBXagwr6HMKIbBZ4zF8r?=
 =?us-ascii?Q?pE6OTiZ8UzBPLJ2iN5066SQ7dh9C/EHEbwb0da4fxT3rcwrEs+Y5YxAVAd7o?=
 =?us-ascii?Q?xI9rjvYmS/DWpjmhurv9jcwzqrC8+rZtYIKFOP8A7/FmEoT/h1gZ/a08uRpO?=
 =?us-ascii?Q?gwmBoehiUCVpGUBuhB0w0JZpdZJhqNrT2cTonBbWp3JfxGdd0nGCx+oMRAjz?=
 =?us-ascii?Q?emq2Vt6OYGis/muLl1oCOWTjTrrZ97ZpECkPIJI7kwLaQYPSJmNSfcWZmhJK?=
 =?us-ascii?Q?kKicueefpNJWVLOf05HOtHQw7IKuyNKsPhiLaTqY4+lvxBuf4qrK3LNpArj8?=
 =?us-ascii?Q?Hx0RPNwsi9DIj7VIoCi2pYnvbwuGdNCYMFe6cyftLGne5DhSrbTaSDK4ZLD2?=
 =?us-ascii?Q?6dh7FGI0a3G0XK6LhP0NdhgZMe6yAHdqYui0lCYutkxGJQd3um2x+njWqxft?=
 =?us-ascii?Q?u2XZEFwC8p8w3x3KtUn+Um8XneglWHjzN14RsLYZF4ecYI7RD8iJ51wm0xUC?=
 =?us-ascii?Q?oSAsskAc4peL3nIL6YnwHq9KI+C9qudViJyO+6Vqf+VlXfQNA9jNM1sNZ1jS?=
 =?us-ascii?Q?vrR3Yp+Wswi5nS6iVqJAQwLDyyViBgin61cNO1QFUxuq+eJhjO0cPEDzDJah?=
 =?us-ascii?Q?HQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b938a89-c673-4d52-9da0-08dc1b247f82
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8414.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2024 08:31:15.7431
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vTqRxhoJ2udrp8z4zJDBusCFKswNwDfx3aNEY6IXnAvnFTXQwFhDVBY9ugeH3Rf5YLUum85gBHFqTVFn6sm/qg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6084
X-OriginatorOrg: intel.com

Hi Geert,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   ac865f00af293d081356bec56eea90815094a60e
commit: ea00d95200d02ece71f5814d41b14f2eb16d598b ASoC: Use imply for SND_SOC_ALL_CODECS
date:   3 years, 11 months ago
:::::: branch date: 16 hours ago
:::::: commit date: 3 years, 11 months ago
config: x86_64-buildonly-randconfig-003-20231102 (https://download.01.org/0day-ci/archive/20240104/202401042239.2zkHgzki-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240104/202401042239.2zkHgzki-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/r/202401042239.2zkHgzki-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> sound/ac97/bus.c:192: warning: Function parameter or member 'drv' not described in 'snd_ac97_codec_driver_register'
>> sound/ac97/bus.c:192: warning: Excess function parameter 'dev' description in 'snd_ac97_codec_driver_register'
>> sound/ac97/bus.c:205: warning: Function parameter or member 'drv' not described in 'snd_ac97_codec_driver_unregister'
>> sound/ac97/bus.c:205: warning: Excess function parameter 'dev' description in 'snd_ac97_codec_driver_unregister'
>> sound/ac97/bus.c:351: warning: Function parameter or member 'codecs_pdata' not described in 'snd_ac97_controller_register'

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for REGMAP_SPI
   Depends on [n]: SPI [=n]
   Selected by [m]:
   - SND_SOC_ADAU1781_SPI [=m] && SOUND [=y] && !UML && SND [=m] && SND_SOC [=m]
   - SND_SOC_ADAU1977_SPI [=m] && SOUND [=y] && !UML && SND [=m] && SND_SOC [=m]


vim +192 sound/ac97/bus.c

74426fbff66eea Robert Jarzmik 2017-09-02  181  
74426fbff66eea Robert Jarzmik 2017-09-02  182  /**
74426fbff66eea Robert Jarzmik 2017-09-02  183   * snd_ac97_codec_driver_register - register an AC97 codec driver
74426fbff66eea Robert Jarzmik 2017-09-02  184   * @dev: AC97 driver codec to register
74426fbff66eea Robert Jarzmik 2017-09-02  185   *
74426fbff66eea Robert Jarzmik 2017-09-02  186   * Register an AC97 codec driver to the ac97 bus driver, aka. the AC97 digital
74426fbff66eea Robert Jarzmik 2017-09-02  187   * controller.
74426fbff66eea Robert Jarzmik 2017-09-02  188   *
74426fbff66eea Robert Jarzmik 2017-09-02  189   * Returns 0 on success or error code
74426fbff66eea Robert Jarzmik 2017-09-02  190   */
74426fbff66eea Robert Jarzmik 2017-09-02  191  int snd_ac97_codec_driver_register(struct ac97_codec_driver *drv)
74426fbff66eea Robert Jarzmik 2017-09-02 @192  {
74426fbff66eea Robert Jarzmik 2017-09-02  193  	drv->driver.bus = &ac97_bus_type;
74426fbff66eea Robert Jarzmik 2017-09-02  194  	return driver_register(&drv->driver);
74426fbff66eea Robert Jarzmik 2017-09-02  195  }
74426fbff66eea Robert Jarzmik 2017-09-02  196  EXPORT_SYMBOL_GPL(snd_ac97_codec_driver_register);
74426fbff66eea Robert Jarzmik 2017-09-02  197  
74426fbff66eea Robert Jarzmik 2017-09-02  198  /**
74426fbff66eea Robert Jarzmik 2017-09-02  199   * snd_ac97_codec_driver_unregister - unregister an AC97 codec driver
74426fbff66eea Robert Jarzmik 2017-09-02  200   * @dev: AC97 codec driver to unregister
74426fbff66eea Robert Jarzmik 2017-09-02  201   *
74426fbff66eea Robert Jarzmik 2017-09-02  202   * Unregister a previously registered ac97 codec driver.
74426fbff66eea Robert Jarzmik 2017-09-02  203   */
74426fbff66eea Robert Jarzmik 2017-09-02  204  void snd_ac97_codec_driver_unregister(struct ac97_codec_driver *drv)
74426fbff66eea Robert Jarzmik 2017-09-02 @205  {
74426fbff66eea Robert Jarzmik 2017-09-02  206  	driver_unregister(&drv->driver);
74426fbff66eea Robert Jarzmik 2017-09-02  207  }
74426fbff66eea Robert Jarzmik 2017-09-02  208  EXPORT_SYMBOL_GPL(snd_ac97_codec_driver_unregister);
74426fbff66eea Robert Jarzmik 2017-09-02  209  
74426fbff66eea Robert Jarzmik 2017-09-02  210  /**
74426fbff66eea Robert Jarzmik 2017-09-02  211   * snd_ac97_codec_get_platdata - get platform_data
74426fbff66eea Robert Jarzmik 2017-09-02  212   * @adev: the ac97 codec device
74426fbff66eea Robert Jarzmik 2017-09-02  213   *
74426fbff66eea Robert Jarzmik 2017-09-02  214   * For legacy platforms, in order to have platform_data in codec drivers
74426fbff66eea Robert Jarzmik 2017-09-02  215   * available, while ac97 device are auto-created upon probe, this retrieves the
74426fbff66eea Robert Jarzmik 2017-09-02  216   * platdata which was setup on ac97 controller registration.
74426fbff66eea Robert Jarzmik 2017-09-02  217   *
74426fbff66eea Robert Jarzmik 2017-09-02  218   * Returns the platform data pointer
74426fbff66eea Robert Jarzmik 2017-09-02  219   */
74426fbff66eea Robert Jarzmik 2017-09-02  220  void *snd_ac97_codec_get_platdata(const struct ac97_codec_device *adev)
74426fbff66eea Robert Jarzmik 2017-09-02  221  {
74426fbff66eea Robert Jarzmik 2017-09-02  222  	struct ac97_controller *ac97_ctrl = adev->ac97_ctrl;
74426fbff66eea Robert Jarzmik 2017-09-02  223  
74426fbff66eea Robert Jarzmik 2017-09-02  224  	return ac97_ctrl->codecs_pdata[adev->num];
74426fbff66eea Robert Jarzmik 2017-09-02  225  }
74426fbff66eea Robert Jarzmik 2017-09-02  226  EXPORT_SYMBOL_GPL(snd_ac97_codec_get_platdata);
74426fbff66eea Robert Jarzmik 2017-09-02  227  
74426fbff66eea Robert Jarzmik 2017-09-02  228  static void ac97_ctrl_codecs_unregister(struct ac97_controller *ac97_ctrl)
74426fbff66eea Robert Jarzmik 2017-09-02  229  {
74426fbff66eea Robert Jarzmik 2017-09-02  230  	int i;
74426fbff66eea Robert Jarzmik 2017-09-02  231  
74426fbff66eea Robert Jarzmik 2017-09-02  232  	for (i = 0; i < AC97_BUS_MAX_CODECS; i++)
74426fbff66eea Robert Jarzmik 2017-09-02  233  		if (ac97_ctrl->codecs[i]) {
74426fbff66eea Robert Jarzmik 2017-09-02  234  			ac97_ctrl->codecs[i]->ac97_ctrl = &ac97_unbound_ctrl;
74426fbff66eea Robert Jarzmik 2017-09-02  235  			device_unregister(&ac97_ctrl->codecs[i]->dev);
74426fbff66eea Robert Jarzmik 2017-09-02  236  		}
74426fbff66eea Robert Jarzmik 2017-09-02  237  }
74426fbff66eea Robert Jarzmik 2017-09-02  238  
74426fbff66eea Robert Jarzmik 2017-09-02  239  static ssize_t cold_reset_store(struct device *dev,
74426fbff66eea Robert Jarzmik 2017-09-02  240  				struct device_attribute *attr, const char *buf,
74426fbff66eea Robert Jarzmik 2017-09-02  241  				size_t len)
74426fbff66eea Robert Jarzmik 2017-09-02  242  {
74426fbff66eea Robert Jarzmik 2017-09-02  243  	struct ac97_controller *ac97_ctrl;
74426fbff66eea Robert Jarzmik 2017-09-02  244  
74426fbff66eea Robert Jarzmik 2017-09-02  245  	mutex_lock(&ac97_controllers_mutex);
74426fbff66eea Robert Jarzmik 2017-09-02  246  	ac97_ctrl = to_ac97_controller(dev);
74426fbff66eea Robert Jarzmik 2017-09-02  247  	ac97_ctrl->ops->reset(ac97_ctrl);
74426fbff66eea Robert Jarzmik 2017-09-02  248  	mutex_unlock(&ac97_controllers_mutex);
74426fbff66eea Robert Jarzmik 2017-09-02  249  	return len;
74426fbff66eea Robert Jarzmik 2017-09-02  250  }
74426fbff66eea Robert Jarzmik 2017-09-02  251  static DEVICE_ATTR_WO(cold_reset);
74426fbff66eea Robert Jarzmik 2017-09-02  252  
74426fbff66eea Robert Jarzmik 2017-09-02  253  static ssize_t warm_reset_store(struct device *dev,
74426fbff66eea Robert Jarzmik 2017-09-02  254  				struct device_attribute *attr, const char *buf,
74426fbff66eea Robert Jarzmik 2017-09-02  255  				size_t len)
74426fbff66eea Robert Jarzmik 2017-09-02  256  {
74426fbff66eea Robert Jarzmik 2017-09-02  257  	struct ac97_controller *ac97_ctrl;
74426fbff66eea Robert Jarzmik 2017-09-02  258  
74426fbff66eea Robert Jarzmik 2017-09-02  259  	if (!dev)
74426fbff66eea Robert Jarzmik 2017-09-02  260  		return -ENODEV;
74426fbff66eea Robert Jarzmik 2017-09-02  261  
74426fbff66eea Robert Jarzmik 2017-09-02  262  	mutex_lock(&ac97_controllers_mutex);
74426fbff66eea Robert Jarzmik 2017-09-02  263  	ac97_ctrl = to_ac97_controller(dev);
74426fbff66eea Robert Jarzmik 2017-09-02  264  	ac97_ctrl->ops->warm_reset(ac97_ctrl);
74426fbff66eea Robert Jarzmik 2017-09-02  265  	mutex_unlock(&ac97_controllers_mutex);
74426fbff66eea Robert Jarzmik 2017-09-02  266  	return len;
74426fbff66eea Robert Jarzmik 2017-09-02  267  }
74426fbff66eea Robert Jarzmik 2017-09-02  268  static DEVICE_ATTR_WO(warm_reset);
74426fbff66eea Robert Jarzmik 2017-09-02  269  
74426fbff66eea Robert Jarzmik 2017-09-02  270  static struct attribute *ac97_controller_device_attrs[] = {
74426fbff66eea Robert Jarzmik 2017-09-02  271  	&dev_attr_cold_reset.attr,
74426fbff66eea Robert Jarzmik 2017-09-02  272  	&dev_attr_warm_reset.attr,
74426fbff66eea Robert Jarzmik 2017-09-02  273  	NULL
74426fbff66eea Robert Jarzmik 2017-09-02  274  };
74426fbff66eea Robert Jarzmik 2017-09-02  275  
74426fbff66eea Robert Jarzmik 2017-09-02  276  static struct attribute_group ac97_adapter_attr_group = {
74426fbff66eea Robert Jarzmik 2017-09-02  277  	.name	= "ac97_operations",
74426fbff66eea Robert Jarzmik 2017-09-02  278  	.attrs	= ac97_controller_device_attrs,
74426fbff66eea Robert Jarzmik 2017-09-02  279  };
74426fbff66eea Robert Jarzmik 2017-09-02  280  
74426fbff66eea Robert Jarzmik 2017-09-02  281  static const struct attribute_group *ac97_adapter_groups[] = {
74426fbff66eea Robert Jarzmik 2017-09-02  282  	&ac97_adapter_attr_group,
74426fbff66eea Robert Jarzmik 2017-09-02  283  	NULL,
74426fbff66eea Robert Jarzmik 2017-09-02  284  };
74426fbff66eea Robert Jarzmik 2017-09-02  285  
74426fbff66eea Robert Jarzmik 2017-09-02  286  static void ac97_del_adapter(struct ac97_controller *ac97_ctrl)
74426fbff66eea Robert Jarzmik 2017-09-02  287  {
74426fbff66eea Robert Jarzmik 2017-09-02  288  	mutex_lock(&ac97_controllers_mutex);
74426fbff66eea Robert Jarzmik 2017-09-02  289  	ac97_ctrl_codecs_unregister(ac97_ctrl);
74426fbff66eea Robert Jarzmik 2017-09-02  290  	list_del(&ac97_ctrl->controllers);
74426fbff66eea Robert Jarzmik 2017-09-02  291  	mutex_unlock(&ac97_controllers_mutex);
74426fbff66eea Robert Jarzmik 2017-09-02  292  
74426fbff66eea Robert Jarzmik 2017-09-02  293  	device_unregister(&ac97_ctrl->adap);
74426fbff66eea Robert Jarzmik 2017-09-02  294  }
74426fbff66eea Robert Jarzmik 2017-09-02  295  
74426fbff66eea Robert Jarzmik 2017-09-02  296  static void ac97_adapter_release(struct device *dev)
74426fbff66eea Robert Jarzmik 2017-09-02  297  {
74426fbff66eea Robert Jarzmik 2017-09-02  298  	struct ac97_controller *ac97_ctrl;
74426fbff66eea Robert Jarzmik 2017-09-02  299  
74426fbff66eea Robert Jarzmik 2017-09-02  300  	ac97_ctrl = to_ac97_controller(dev);
74426fbff66eea Robert Jarzmik 2017-09-02  301  	idr_remove(&ac97_adapter_idr, ac97_ctrl->nr);
74426fbff66eea Robert Jarzmik 2017-09-02  302  	dev_dbg(&ac97_ctrl->adap, "adapter unregistered by %s\n",
74426fbff66eea Robert Jarzmik 2017-09-02  303  		dev_name(ac97_ctrl->parent));
74426fbff66eea Robert Jarzmik 2017-09-02  304  }
74426fbff66eea Robert Jarzmik 2017-09-02  305  
74426fbff66eea Robert Jarzmik 2017-09-02  306  static const struct device_type ac97_adapter_type = {
74426fbff66eea Robert Jarzmik 2017-09-02  307  	.groups		= ac97_adapter_groups,
74426fbff66eea Robert Jarzmik 2017-09-02  308  	.release	= ac97_adapter_release,
74426fbff66eea Robert Jarzmik 2017-09-02  309  };
74426fbff66eea Robert Jarzmik 2017-09-02  310  
74426fbff66eea Robert Jarzmik 2017-09-02  311  static int ac97_add_adapter(struct ac97_controller *ac97_ctrl)
74426fbff66eea Robert Jarzmik 2017-09-02  312  {
74426fbff66eea Robert Jarzmik 2017-09-02  313  	int ret;
74426fbff66eea Robert Jarzmik 2017-09-02  314  
74426fbff66eea Robert Jarzmik 2017-09-02  315  	mutex_lock(&ac97_controllers_mutex);
74426fbff66eea Robert Jarzmik 2017-09-02  316  	ret = idr_alloc(&ac97_adapter_idr, ac97_ctrl, 0, 0, GFP_KERNEL);
74426fbff66eea Robert Jarzmik 2017-09-02  317  	ac97_ctrl->nr = ret;
74426fbff66eea Robert Jarzmik 2017-09-02  318  	if (ret >= 0) {
74426fbff66eea Robert Jarzmik 2017-09-02  319  		dev_set_name(&ac97_ctrl->adap, "ac97-%d", ret);
74426fbff66eea Robert Jarzmik 2017-09-02  320  		ac97_ctrl->adap.type = &ac97_adapter_type;
74426fbff66eea Robert Jarzmik 2017-09-02  321  		ac97_ctrl->adap.parent = ac97_ctrl->parent;
74426fbff66eea Robert Jarzmik 2017-09-02  322  		ret = device_register(&ac97_ctrl->adap);
74426fbff66eea Robert Jarzmik 2017-09-02  323  		if (ret)
74426fbff66eea Robert Jarzmik 2017-09-02  324  			put_device(&ac97_ctrl->adap);
74426fbff66eea Robert Jarzmik 2017-09-02  325  	}
74426fbff66eea Robert Jarzmik 2017-09-02  326  	if (!ret)
74426fbff66eea Robert Jarzmik 2017-09-02  327  		list_add(&ac97_ctrl->controllers, &ac97_controllers);
74426fbff66eea Robert Jarzmik 2017-09-02  328  	mutex_unlock(&ac97_controllers_mutex);
74426fbff66eea Robert Jarzmik 2017-09-02  329  
74426fbff66eea Robert Jarzmik 2017-09-02  330  	if (!ret)
74426fbff66eea Robert Jarzmik 2017-09-02  331  		dev_dbg(&ac97_ctrl->adap, "adapter registered by %s\n",
74426fbff66eea Robert Jarzmik 2017-09-02  332  			dev_name(ac97_ctrl->parent));
74426fbff66eea Robert Jarzmik 2017-09-02  333  	return ret;
74426fbff66eea Robert Jarzmik 2017-09-02  334  }
74426fbff66eea Robert Jarzmik 2017-09-02  335  
74426fbff66eea Robert Jarzmik 2017-09-02  336  /**
74426fbff66eea Robert Jarzmik 2017-09-02  337   * snd_ac97_controller_register - register an ac97 controller
74426fbff66eea Robert Jarzmik 2017-09-02  338   * @ops: the ac97 bus operations
74426fbff66eea Robert Jarzmik 2017-09-02  339   * @dev: the device providing the ac97 DC function
74426fbff66eea Robert Jarzmik 2017-09-02  340   * @slots_available: mask of the ac97 codecs that can be scanned and probed
74426fbff66eea Robert Jarzmik 2017-09-02  341   *                   bit0 => codec 0, bit1 => codec 1 ... bit 3 => codec 3
74426fbff66eea Robert Jarzmik 2017-09-02  342   *
74426fbff66eea Robert Jarzmik 2017-09-02  343   * Register a digital controller which can control up to 4 ac97 codecs. This is
74426fbff66eea Robert Jarzmik 2017-09-02  344   * the controller side of the AC97 AC-link, while the slave side are the codecs.
74426fbff66eea Robert Jarzmik 2017-09-02  345   *
74426fbff66eea Robert Jarzmik 2017-09-02  346   * Returns a valid controller upon success, negative pointer value upon error
74426fbff66eea Robert Jarzmik 2017-09-02  347   */
74426fbff66eea Robert Jarzmik 2017-09-02  348  struct ac97_controller *snd_ac97_controller_register(
74426fbff66eea Robert Jarzmik 2017-09-02  349  	const struct ac97_controller_ops *ops, struct device *dev,
74426fbff66eea Robert Jarzmik 2017-09-02  350  	unsigned short slots_available, void **codecs_pdata)
74426fbff66eea Robert Jarzmik 2017-09-02 @351  {
74426fbff66eea Robert Jarzmik 2017-09-02  352  	struct ac97_controller *ac97_ctrl;
74426fbff66eea Robert Jarzmik 2017-09-02  353  	int ret, i;
74426fbff66eea Robert Jarzmik 2017-09-02  354  
74426fbff66eea Robert Jarzmik 2017-09-02  355  	ac97_ctrl = kzalloc(sizeof(*ac97_ctrl), GFP_KERNEL);
74426fbff66eea Robert Jarzmik 2017-09-02  356  	if (!ac97_ctrl)
74426fbff66eea Robert Jarzmik 2017-09-02  357  		return ERR_PTR(-ENOMEM);
74426fbff66eea Robert Jarzmik 2017-09-02  358  
74426fbff66eea Robert Jarzmik 2017-09-02  359  	for (i = 0; i < AC97_BUS_MAX_CODECS && codecs_pdata; i++)
74426fbff66eea Robert Jarzmik 2017-09-02  360  		ac97_ctrl->codecs_pdata[i] = codecs_pdata[i];
74426fbff66eea Robert Jarzmik 2017-09-02  361  
74426fbff66eea Robert Jarzmik 2017-09-02  362  	ac97_ctrl->ops = ops;
74426fbff66eea Robert Jarzmik 2017-09-02  363  	ac97_ctrl->slots_available = slots_available;
74426fbff66eea Robert Jarzmik 2017-09-02  364  	ac97_ctrl->parent = dev;
74426fbff66eea Robert Jarzmik 2017-09-02  365  	ret = ac97_add_adapter(ac97_ctrl);
74426fbff66eea Robert Jarzmik 2017-09-02  366  
74426fbff66eea Robert Jarzmik 2017-09-02  367  	if (ret)
74426fbff66eea Robert Jarzmik 2017-09-02  368  		goto err;
74426fbff66eea Robert Jarzmik 2017-09-02  369  	ac97_bus_reset(ac97_ctrl);
74426fbff66eea Robert Jarzmik 2017-09-02  370  	ac97_bus_scan(ac97_ctrl);
74426fbff66eea Robert Jarzmik 2017-09-02  371  
74426fbff66eea Robert Jarzmik 2017-09-02  372  	return ac97_ctrl;
74426fbff66eea Robert Jarzmik 2017-09-02  373  err:
74426fbff66eea Robert Jarzmik 2017-09-02  374  	kfree(ac97_ctrl);
74426fbff66eea Robert Jarzmik 2017-09-02  375  	return ERR_PTR(ret);
74426fbff66eea Robert Jarzmik 2017-09-02  376  }
74426fbff66eea Robert Jarzmik 2017-09-02  377  EXPORT_SYMBOL_GPL(snd_ac97_controller_register);
74426fbff66eea Robert Jarzmik 2017-09-02  378  

:::::: The code at line 192 was first introduced by commit
:::::: 74426fbff66eea8e8d1f42c8238c268d1e63a832 ALSA: ac97: add an ac97 bus

:::::: TO: Robert Jarzmik <robert.jarzmik@free.fr>
:::::: CC: Mark Brown <broonie@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


