Return-Path: <linux-kernel+bounces-82652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 821718687C3
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 04:21:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE2911F2110B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 03:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E93491EB5B;
	Tue, 27 Feb 2024 03:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DK8naz7v"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F551D54C;
	Tue, 27 Feb 2024 03:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709004104; cv=fail; b=A3Vrsc9hv4c7pim703I74t8XFJsVLBCySOcAgJFDI3uGr9kAfrzs3QrXjC9DX49WIhrxqZCFM7rh/TgYWpXDDm9DeehPRqes1xIskOscmE3dmzrtjtSpqmQ0n4e5sQikFOd4odxqAwfQocxRirGiiJzIHbhOejAduZAdYaV/Isg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709004104; c=relaxed/simple;
	bh=+2QkoAJJzSkh+xCLQjvV/J6Vck1pue03sxHp5OYnx4Y=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CjcOqEKdiggEC5qvls0ZQwKA1VlPbPsve+NqJHtdXPyHKnauzf+YXgAA6zxMBWfSdCw1wY/JbxFLzBLtLg/LpOSmlEmAdB1/oa3VD+v4zlOZ+7g/xI7RuIYaZpS/NNNdhzY8wYZ1z1M31ZWj8nV5Nngc8dttD2urdUB0RrTaqXU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DK8naz7v; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709004101; x=1740540101;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=+2QkoAJJzSkh+xCLQjvV/J6Vck1pue03sxHp5OYnx4Y=;
  b=DK8naz7vOCqIZ1g2A9oj/UXD4X+aK4Cl/NoUWr3HK6b3bEAEGbfoetA3
   tjRGRiBinF4EWw2WxnopyyMICCTxkpAYZJSDOYFKL3tM1gmGg7JFAj5Ec
   FDxWcNEZgb+pTQDN31Np2G9QbNIhKNgWnL7CxPt1BP1RbtX1kEORMsJqq
   1ZX73DNQwg5lpskFxUgb9HOeo/+qCUfSbLHL9up9sn1QGSkj7c0zmQJt4
   u5DqfxqcshEJ+T0TNSfDGu6bzpp8f/DmdOvOiYUkJp7vjrghSk61AGd99
   ZZoMYkRtT1HY7D+6QoCWvpD6JWRIj9djz9xsSEMnlH/w5vN2WOJyT5qAx
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="7142727"
X-IronPort-AV: E=Sophos;i="6.06,187,1705392000"; 
   d="scan'208";a="7142727"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 19:21:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,187,1705392000"; 
   d="scan'208";a="7297440"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Feb 2024 19:21:40 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 26 Feb 2024 19:21:39 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 26 Feb 2024 19:21:39 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 26 Feb 2024 19:21:39 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I2Y1SswZhJPpPvyk5Pcbi51dwVwHPCAFE4HQ1gQwtBrC2D8kXCEf+//Ie/4M4Fo4EEG8FrfOH8jHNpfuHeOIrSMx2O/J91vVdONXJCODxpkUzNIc8sZudWjRS3kL8Wyi9es4uNXrZ/yipZEyUzDwZxtHzLd6MmWJzs67ARwsub2yBGlgLsnw5QqDrvRnY37rtyPd6sC63ZRYhjM7KnOAVMjsyIuLWk+VLtPvkqj0EVhtBz0HijDzeE7LFHi1cHwoCVKzWpBhCHfGxZVI5uSxkjISSGawD5nvcPS4VOZaPW+Uz+QsgvX1d+vsWslhaRkXM3BdaHYxc/Sk38mIwHLcew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=11qQVUCAlYeyIiAMSUKBULtnM1SA9Yt3c3+iB7RJYrw=;
 b=CsAZEd834Q9rxBJfDcbLhPnhXZ3asO+zit92d3hCoVChBeylnlSCOV/waa39WRffpV+wKH5NmYWX4TW4+0JbzMdFPICQhmi71QbiRYNCRGLoZk/kTg8GuxqTYZo+RkoAawdx2Q2YRQmZ7f1P3JOthOU1C+8pvul0Xuly8nTYeImzyhde968NY5BuLhWd6TS1SydGNHboc+ief8uA/vrOCfOjd15l058mw96hLGQ+s6DUKVAHqlVQK+5vGfq7REj+LjxUL5h3UvDBdGuG5PeXQCEZRIYQxk9+jGkXCCTQ3rDMOQtB99x8EmULDtYgaCwa6DBmzlS6cd5drFDTQsAw8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6392.namprd11.prod.outlook.com (2603:10b6:930:37::15)
 by PH7PR11MB6929.namprd11.prod.outlook.com (2603:10b6:510:204::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.25; Tue, 27 Feb
 2024 03:21:31 +0000
Received: from CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::401d:af3f:fb1a:2c6b]) by CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::401d:af3f:fb1a:2c6b%7]) with mapi id 15.20.7339.022; Tue, 27 Feb 2024
 03:21:31 +0000
Date: Tue, 27 Feb 2024 11:14:39 +0800
From: kernel test robot <yujie.liu@intel.com>
To: Richard Fitzgerald <rf@opensource.cirrus.com>, <broonie@kernel.org>,
	<tiwai@suse.com>
CC: <oe-kbuild-all@lists.linux.dev>, <linux-sound@vger.kernel.org>,
	<alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
	<patches@opensource.cirrus.com>, Richard Fitzgerald
	<rf@opensource.cirrus.com>
Subject: Re: [PATCH 9/9] ASoC: cs-amp-lib: Add KUnit test for calibration
 helpers
Message-ID: <202402221544.okaeWC1f-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240221150507.1039979-10-rf@opensource.cirrus.com>
X-ClientProxiedBy: SI1PR02CA0027.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::18) To CY5PR11MB6392.namprd11.prod.outlook.com
 (2603:10b6:930:37::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6392:EE_|PH7PR11MB6929:EE_
X-MS-Office365-Filtering-Correlation-Id: ed148311-c815-49e1-4275-08dc374331be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9Dyx1jMMNbKCpgEYgf/x8dGwdRxjWWzifg8KXXIbwJvHsFVjHXxdglbU7P/4QPGkH/WV4ldrelggMCjvDWCUQ1vlHoWVsLW/RAXWQ4q7n74GbDJw7kdsYvsV5u98bnHYZoz1nkLkQS6mVjqdcD1oLeabBSTBOfdvxBHo2RJwswyGoV+8y3HsMTsOMMdSo0fy2p6Tkel581kdAfI3XfGGnoO9SZegtETTmCihwH/Fu3GynpIi1igPP6F6Vx2kuAwMcJXRsdkcS8CM2R32B3ucE75e5Ta57GJ5kxPd/VxTsJNatxEaJTaicQf1VO5CgWK/Z4M9zm0UwtVXxb6FBH5jx3hbgYaLklgovSPDNlLJtf+MFxMbkXBT+HWX2HMmqaaAvrIwDi+TYZm7hklsgHYbqlR/6VGXfSoLRJu+CnhHvP8EjpNjrRJoH+hjiIY2XXzIRMkgqt5/Jt3Dp9jZPodEHJX/5FnKos9bbJmA//7nQZt+KwcmRpqeIWHO+Q16w00v3JhA7U8evKGkRJ0Tu1f5OVrITvJP5zImIhYYtiwD1w8WFuEsP2fx6bwvT3j6UdIR6jvvDV8NaLtTwToOzg8qLBZ8O0uUadEaWt1x/2K+g4a5+7+lxNLbklB03BsWMpen
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jjKC4LLxWKVsj60LEqrUTKRH167j8jgU1VF5wgxeG1BLK0hG9dLyv2Rd0ZBe?=
 =?us-ascii?Q?HZoujuChv/esAV1t0fiGvVbrmJ84tA54ifjc480crwboJMcIMLybjiu1WrG8?=
 =?us-ascii?Q?Io3PPmLIyQr9owZdC5eFmQU6txKRgufXAaWUPavlAjIudhBenxcXFROcyMP6?=
 =?us-ascii?Q?Ij1cMdOXOk3En1uDQr4OXPlAaoSkGN8/+dVbf1ywcjSVaf754KdoXp+wI+Ll?=
 =?us-ascii?Q?8hsovb4RXf75x90knOpBQI80NxBJQsWFKsddVEP46W2xKtXYRO1xDFiFmgTP?=
 =?us-ascii?Q?souQ0bGNtgehab9jXgQTdfAw+2Bw3FWWYZmkKIKcBzFqBWIoJgRMoJPKwL8R?=
 =?us-ascii?Q?qmCWD2gmh8uLjgDmOL9+evXb5nB5hAuKdk3bZFps1oKiwTY0hQ+Ng8yz1kO7?=
 =?us-ascii?Q?UA45Lx5psq77dYZxGqnHSF+TAwm1WcTruaVWCjk0v733sNxki9QPz5nyyc+n?=
 =?us-ascii?Q?6XBiSPa77qTClnYCPPXs80CtlFItuDlS8rqBdRVodv2vJZKRFOmA/j2z/iiH?=
 =?us-ascii?Q?k46apIIt39pMOnpFfSROhHpJTiXolrjs9cNgVHy3r7S6Y+pRALpKp3Z+U7Xb?=
 =?us-ascii?Q?CkWwdSu2GA/9lSNDkMuEc8G3BWVF9+WVQNySuZ1TS6zKkvpb8UOqblT8q4TO?=
 =?us-ascii?Q?1FgWatircckdXvhPfFsljIjg9MEM32kef3S4ZMRPYkITEQ0Dry1PhC6vlp5+?=
 =?us-ascii?Q?Ok3M7qFhx+1OxtC9RcdxmhB0bHlW6UgBHlmRBcMwUeuRF7q3NiceNokfZelt?=
 =?us-ascii?Q?YPdtd8aRtfzZbqSqNrWQBtVFgO29iKm92bR0aowQu41qA21/37A01g9yajok?=
 =?us-ascii?Q?K8fjybOjegXDT6316vVFJa8KbL9/wTUBuWh9F3f5X5ox1d6QL/j+REdMbNZQ?=
 =?us-ascii?Q?x70JjiFjArzKisN/QGP/lep69/oaGerZwUGBD8T/EVEykJZRKkrEW2BpyX8y?=
 =?us-ascii?Q?IVEG+yBgfCmzObAa2ihsdAuKz6RYL4OwzOUyZa9Wazd2vlKkSBFkLn0GfOgz?=
 =?us-ascii?Q?vKhTm6Cf0b69Fzs1WCRSK1wnHOtJSKzFbEhkKg+3n2mjWfzVwG1jbZv62KwC?=
 =?us-ascii?Q?Lg4mx6G08hHYF555Lzl2Ra84lUpCP4DbCRzUdq+9W6mcgx1GQvn6ZptVsQj5?=
 =?us-ascii?Q?QVZKG5wCEq6E6yAzZFERjE6Krt4OsDA+pICzbjF0NlGUP7XmwkYvLLyLssNf?=
 =?us-ascii?Q?l1LipCJXRUIrndm+9WyND4OIJbT689cJp3ne6RTR+WaYHblNmfx/TrWcLW3B?=
 =?us-ascii?Q?56Fgrz6I9f7pySOvdJjH+nrcE5n9q/eK/YnJAsWHNKR0eaK5SFR6E8BZvfTe?=
 =?us-ascii?Q?AglTF5TEyUpWFESp3SreRP1Ade4fIWCbsEXzk0t9cE1932qcufx7TO/00gop?=
 =?us-ascii?Q?8tHSV2ukSjvg/dfHnD5nUibg3dkCbmVpG+S9LgjPCDUYRblZH64r0hs/+QwO?=
 =?us-ascii?Q?L7UfEVJWIGW2LsTi7MIneg2biX/4SBOed3xKHTPNee0AXWiqFtV9YWvj+X1k?=
 =?us-ascii?Q?M4/sHp7FXlJ7TK3GUGwgK5chzuk7S1xgijnT+17YPkscCBc92GOU3QwYHnnM?=
 =?us-ascii?Q?8UnCsdnJ6aDle//eINcyWvssA1rSMPRBcJWcjC/m?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ed148311-c815-49e1-4275-08dc374331be
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2024 03:21:31.7736
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oZv1RrUiVrZoqj+QPSPbXpXOl8PLV32IKoMoLH8o+AB8QIXPTlIJfXFn9PneTwyD7zOqix0m8aySSy9/g6vWHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6929
X-OriginatorOrg: intel.com

Hi Richard,

kernel test robot noticed the following build errors:

[auto build test ERROR on broonie-sound/for-next]
[also build test ERROR on tiwai-sound/for-next tiwai-sound/for-linus linus/master v6.8-rc5 next-20240221]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Richard-Fitzgerald/ASoC-wm_adsp-Fix-missing-mutex_lock-in-wm_adsp_write_ctl/20240221-230851
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next
patch link:    https://lore.kernel.org/r/20240221150507.1039979-10-rf%40opensource.cirrus.com
patch subject: [PATCH 9/9] ASoC: cs-amp-lib: Add KUnit test for calibration helpers
config: hexagon-randconfig-r123-20240222 (https://download.01.org/0day-ci/archive/20240222/202402221544.okaeWC1f-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project 36adfec155de366d722f2bac8ff9162289dcf06c)
reproduce: (https://download.01.org/0day-ci/archive/20240222/202402221544.okaeWC1f-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <yujie.liu@intel.com>
| Closes: https://lore.kernel.org/r/202402221544.okaeWC1f-lkp@intel.com/

All errors (new ones prefixed by >>):

>> ld.lld: error: undefined symbol: efi_status_to_err
   >>> referenced by cs-amp-lib.c
   >>>               sound/soc/codecs/cs-amp-lib.o:(cs_amp_get_efi_calibration_data) in archive vmlinux.a
   >>> referenced by cs-amp-lib.c
   >>>               sound/soc/codecs/cs-amp-lib.o:(cs_amp_get_efi_calibration_data) in archive vmlinux.a

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


