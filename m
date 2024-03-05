Return-Path: <linux-kernel+bounces-92593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A258872292
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 16:22:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD1941F22597
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 15:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 646EE1272BA;
	Tue,  5 Mar 2024 15:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EMS4Fnqd"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5AAF4683
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 15:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709652159; cv=fail; b=sZivVBPXQVhdg8tb8wxULVAFajl6PbPCABoh30r96+Yq7eWwWoJKgflLzjcmQOTVnDU3vClQjvICn7cGCdH5/57g5ZuCkC85kxj+mdxZgc/y766+YIXdP4UXTcfjjqjCYck0Hh7GUc1XbZaNF6R38MQgPHJdOH6KO+MwfyqU+I4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709652159; c=relaxed/simple;
	bh=2PTSw/dcBLPSN9e6uvDl2ToaLlauPTMntu0HQTaOgOI=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YLNiftMgRAdzzXPeiLJzbjbvRs+h7jZZsiGEkjRCaiAFJPS/xdLYDqvINCalSrlCnahtGsr9h6VP73+SqEuUFzMb/r0JKtjwMAr181gNtd+PHuRWQ8Gg1BCm05rKv+iVC0v0vf+zhat5zX0DaWZLOBm0Nyq52oFsVmv6tkHl0mc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EMS4Fnqd; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709652158; x=1741188158;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=2PTSw/dcBLPSN9e6uvDl2ToaLlauPTMntu0HQTaOgOI=;
  b=EMS4FnqdW6v4ilrj6RLW50sfMJC90phE684Vmkoek2x36orw6mmbxwUn
   KOFTadcG1hJQJbgz1mcyVnrVnBPGTojcZcAZpoZJcYuFavW0s+YeOqDer
   Gl2U2gPVzziSL7emfr93voZknvERyfnels8muOJQXochzJdt89JJ2isrP
   lc/cox1W1eNsumcheEDepwJawEze45qCHyQc1YznI4PJZlLwmweNqih1S
   HS8/1l2At9Ma3JfyhBVmv6RC6JB6FLmpAY8hyT3KNil6caXaiQ+FeRslA
   1D+rmqR6d1FHaKlcG3QUaoQCx6c3nMQt2XPvHEG2P5b6F/g5wt6ajDj66
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11003"; a="14792064"
X-IronPort-AV: E=Sophos;i="6.06,205,1705392000"; 
   d="scan'208";a="14792064"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2024 07:22:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,205,1705392000"; 
   d="scan'208";a="14101126"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Mar 2024 07:22:36 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 5 Mar 2024 07:22:34 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 5 Mar 2024 07:22:34 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 5 Mar 2024 07:22:32 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n1FJjwqpi65NeymlZUFKAzCPlBleajqkSasSs3b+7ZWhhNLUaKApv7fNs9vgJtr/M6XghOWIzcdmz4UX5q9bcmTXIIKF9RSp2phOVfoPe746RdKVYZKHmP5X0oHBXSSkTexxyMRpCfYyO9+xzccKlXQXB9KooEC6KCuTJ2YPUNFjHn4H4bV+VTM6g/6Oo84f7j7Ohdki/Iri1g76H0GUYoFEQkh52byZHZFAabur0D1g0QeqtUS1aqJ3e4i56qWjqrAHgs4r5iknlBmEX/nqSotZfTjO1/1pcSFzYyd+AieQqNSgRhmKD1nKOkFjJeB8412N1Y2aCo55qMyP9D31tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2KaIezSJWRt6ZW44eqRVeT8l4YLtvgRGe3xtxvJYpG8=;
 b=E8hH3rVLQLOTWvfM6UUsCljy+e0uXcCGfOEfnHZ7m4g5XNNu+ED1gWi6zacNHl1v/bsXHlegbdEbID3cJvD5DvoSfnDIxcqQdNrEn0G6/xNQ4+KraUQyD8CQihhF79K4NSeqzm0vkczkmrW9/ru3gnvECRFKEh+ykl17H4CcC142CEAJAZYcdEaqQXnI3nO4bkuoad6VK4iYZTn6HYx4T4XkFtXy/ngaw0/+MJflcG0rLToCF2tqRh8Jy+r/A2yC7kkm0Vkpg2fuaArtvkJP5gdWRjL5BkyqDH066OLI8qHS4EzbwSeDUbuX4OsFoEOOBA3M5gZqFl1Dxo5j9bklIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6139.namprd11.prod.outlook.com (2603:10b6:930:29::17)
 by SA3PR11MB7534.namprd11.prod.outlook.com (2603:10b6:806:305::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.23; Tue, 5 Mar
 2024 15:22:29 +0000
Received: from CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::e9dd:320:976f:e257]) by CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::e9dd:320:976f:e257%4]) with mapi id 15.20.7362.019; Tue, 5 Mar 2024
 15:22:29 +0000
Date: Tue, 5 Mar 2024 09:22:26 -0600
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: "Souza, Jose" <jose.souza@intel.com>
CC: "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>, "Vivi,
 Rodrigo" <rodrigo.vivi@intel.com>, "quic_mojha@quicinc.com"
	<quic_mojha@quicinc.com>, "johannes@sipsolutions.net"
	<johannes@sipsolutions.net>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Cavitt, Jonathan"
	<jonathan.cavitt@intel.com>
Subject: Re: [PATCH v2 2/4] devcoredump: Add dev_coredumpm_timeout()
Message-ID: <u4tngmdxcciblq327yi75fdfkadv3fomnopnpgbwkk7smh3knp@d2h7373q4msf>
References: <20240228165709.82089-1-jose.souza@intel.com>
 <20240228165709.82089-2-jose.souza@intel.com>
 <84e4f0d70c5552dd7fa350c61c28de9637628ee6.camel@sipsolutions.net>
 <a27ac0d3bc52c2181852a25641b7020f50a50648.camel@intel.com>
 <0f4244ea6866f451f3f8a5b5e2db8be53de1f0c2.camel@sipsolutions.net>
 <bdaf62020388d3dcf8d3a95ae465c0ae2db7eca1.camel@intel.com>
 <zfrpz4vuhjwmilbqft5d4qh4s3gs3okzyxbsh4lc5rhzjy5ktx@xuu32mxhun4c>
 <f7c2d3381e50dd9c5e9211461e0abe487f5059df.camel@intel.com>
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Disposition: inline
In-Reply-To: <f7c2d3381e50dd9c5e9211461e0abe487f5059df.camel@intel.com>
X-ClientProxiedBy: BY5PR13CA0009.namprd13.prod.outlook.com
 (2603:10b6:a03:180::22) To CY5PR11MB6139.namprd11.prod.outlook.com
 (2603:10b6:930:29::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6139:EE_|SA3PR11MB7534:EE_
X-MS-Office365-Filtering-Correlation-Id: 8dfb8977-be9e-40e5-2b2a-08dc3d281202
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BPaW1nCanjp8G5i6VnWSBzjInsykQ4WNfecfQpK7Vbdoyv/d3rN0nSePiFDS3QjEmpwk4J9p5gWG7dM+6ZB/UZFRSWlQ2uMK1bjz5EnIaTT+c796M9s06agZYPNBNE1Db9iJt0ovwHnKH7vZ9eonWXiK8BXD5gHscRgeSFSV48PUDN3LOTAZXjQg1SH3NU5b+hvDThPS5JKIw+cnhG6q6KhpaH74ygDu5ZJmgELt29IAhQR982VbqT4SwmKtIqvpVzstRRH9bYO//8Oy2Iw1BH0ilOiUL/eyoOYGVMVONjLMbB5A2kkjc+tQaqoI0+p2i9ubnxS1GGfrzxugRG3JYUR7gVZsiWgmF2u8rQZiRXAWpyWrGM1YTrcoCLd2KGGdKzM2AWe6yYvWrQ9TunX+RXUQ6lM6XMfK5GlExvAM6ffLoOZ0MMKFkCNyTA/oT1J+PhQQs87rr2TPZJhz+4Y2nyDUGiIM0VH7quXpSSypFTnz9NmrrTghiZre8xIRUpeLtZj+4t+TULk+ums68FS28Q4IJKGi96zuv5MsEcW2wQewUB3vl13LyEcqznZS8/CfLqB5nRK1O8PMrN9mnOHu37Mn8Nubipw/hWqctThxkcM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6139.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yyxEUprIXRCL7tR5QfsyXyLaRlzjvYzZSqDCHVAcrzm/wjvC9lWqFLO2Ftgf?=
 =?us-ascii?Q?pJKai+Rs5FmHUfCmEap3PagvSTRxYBMNYDSA7KD7V9GUFcdSIuK49yApmrf6?=
 =?us-ascii?Q?/Xx5xL2oTz0QDT6ys7hOlNdSjJpVrsa0oZCsCv5HECsr86TaCm+mpqk13D0v?=
 =?us-ascii?Q?koj0YEupc7o8+x5I4BuoZ8CcY7cCMH7DaIl2gNyHwrR1UUjCPu+8iMEKjou6?=
 =?us-ascii?Q?Elg5h+W8QVPQercKSQs8iutU9irTMzmGD7mEqTnus9FWnENlVbQkJF+Xb1lv?=
 =?us-ascii?Q?+CzvYeZEid2BFIyvNzMr7faB9exj2tDvT403gJ0JAbaQrXT6CyzAlwb3VP8i?=
 =?us-ascii?Q?cRCehbDXlHN8GoJVY+381q1Y/X52UA7vRgrjZSXs27M6Cu63ekzN6v+U/qG3?=
 =?us-ascii?Q?O3mim8BD7bkRm2bgg8JZhzQNhZZFLD7NiV99++0ZFbNKsfOHIiIqwd/aaf9w?=
 =?us-ascii?Q?O4brNMnz7s6mw5rqezj3R/GhY5i8aeQ4K2IYUVCYVVHZ3BpRwBAvI/J23sbD?=
 =?us-ascii?Q?USwo+Ou3Ie1HM5+6YPp+Ph+jIkZKKY4LwHwz/xajHoFq5Dm+sBdYcsXIhdOg?=
 =?us-ascii?Q?7Pzi/s+hRKBSBjMePUnkX1hdD3uHcBHglnQIFIkipDp2HDIlvAMqkoQY9ZKw?=
 =?us-ascii?Q?0/HVQm1EpJZFgD8vjfYGptN5K3kNsxPfzUUdUS46d16zCwKucXKrnuwrX54u?=
 =?us-ascii?Q?+/aE1UPDcc97xNJ6FrEf73j2JbMUgrzLpAVCqdB0Zp+xL1nE3YX9pIVxjbxY?=
 =?us-ascii?Q?MwRAaf47InmJ3qRAp/zqbSHIB4qF74mg+YDEKqnmBgn6Lgcd5P2Mw4HP7IKZ?=
 =?us-ascii?Q?zItEZShkBPPnHAOGoty2aDpobSDygwQgVMZ6n+o4fZqFbGchTHutAm8jG/IL?=
 =?us-ascii?Q?bl2GYeTs0X8LClcXMhpDHLl6lk/cV/b95/EzzDc0fStvq09l7o0+EQ0y58Yf?=
 =?us-ascii?Q?Elsdc2GZTr0Cjm7h0mCsmxD2QLJ+E4LSHNBZTzLHYylVGz3rkjRSuZRK5qu+?=
 =?us-ascii?Q?7Hi/MEmiUztsZ1u0swgeFqi+KZ4jdElwLc7zQg281F2oh8fJ6WkiAsqk0X0m?=
 =?us-ascii?Q?AqRSoZzfut3Um2c8TnP90TNmzlpAvajd5EQW8Yh0qOqSmCF1q9hUeiQ+rlAE?=
 =?us-ascii?Q?eEJzbyc63UqYBR4vDfA/x3UIX9yooiXcZ/gKttCT8uHltuQm5UGolmJmMUbX?=
 =?us-ascii?Q?sjFMJvzR38GAlSN/kMCSHR+x8ees8CSQpc6HRWd3qWJNkivWbLBpZq+K3nkm?=
 =?us-ascii?Q?sqJFeKdritmS7pHIg6KQ/kv17NY3jfweszmxa5RoUObVQ04tIbYNSRZZS6JF?=
 =?us-ascii?Q?X5U5ZQVpsjdCgYxzssSGQjenF2CEy4rzl91VlKdR1UfPd+/QqxQxeSXuMYMx?=
 =?us-ascii?Q?D/TK43vxH2y5/cAYPDhrFer2lcfwK+kTU+HJvgDjA7bNB7Ze0YwnmTx2/pin?=
 =?us-ascii?Q?8qI6MqxZ3rlR3n06LC8XhjiblV02Jakk0IF6sD5oBjyG+/Znyhgpoj6PiA9W?=
 =?us-ascii?Q?CWLdtvaZq7P9del3fy8ZkePNRNMceAYFdUCqR3QtR4TWG2EfvzIPlHEyUNzj?=
 =?us-ascii?Q?EPwDZ8FbzC7CjGqGdsT15vPqfLgBbAsFM4Rk0h5wqGNMC+5Mp0VyorWcgt4k?=
 =?us-ascii?Q?SA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dfb8977-be9e-40e5-2b2a-08dc3d281202
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6139.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2024 15:22:29.1440
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BuOLL0JlNUQaEy6bIX8qij8vpVHI/LHmB+UMIA0+wHCDs0oGMv1z4w4D9zSg1ZmF7s9B+VqzQnPVkdorgiwEx+puQIFljSgZb3y0xrTtwpI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7534
X-OriginatorOrg: intel.com

On Tue, Mar 05, 2024 at 02:21:45PM +0000, Jose Souza wrote:
>On Mon, 2024-03-04 at 17:55 -0600, Lucas De Marchi wrote:
>> On Mon, Mar 04, 2024 at 02:29:03PM +0000, Jose Souza wrote:
>> > On Fri, 2024-03-01 at 09:38 +0100, Johannes Berg wrote:
>> > > > On Wed, 2024-02-28 at 17:56 +0000, Souza, Jose wrote:
>> > > > > >
>> > > > > > In my opinion, the timeout should depend on the type of device driver.
>> > > > > >
>> > > > > > In the case of server-class Ethernet cards, where corporate users automate most tasks, five minutes might even be considered excessive.
>> > > > > >
>> > > > > > For our case, GPUs, users might experience minor glitches and only search for what happened after finishing their current task (writing an email,
>> > > > > > ending a gaming match, watching a YouTube video, etc.).
>> > > > > > If they land on https://drm.pages.freedesktop.org/intel-docs/how-to-file-i915-bugs.html or the future Xe version of that page, following the
>> > > > > > instructions alone may take inexperienced Linux users more than five minutes.
>> > > >
>> > > > That's all not wrong, but I don't see why you wouldn't automate this
>> > > > even on end user machines? I feel you're boxing the problem in by
>> > > > wanting to solve it entirely in the kernel?
>> >
>> > The other part of the stack that we provide are the libraries implementing Vulkan and OpenGL APIs, I don't think we could ship scripts that needs
>> > elevated privileges to read and store coredump.
>>
>> it's still a very valid point though. Why are we doing this only on
>> kernel side or mesa side rather than doing it in the proper place?  As
>> Johannes said, this could very well be automated via udev rules.
>> Distros automate getting the coredump already with systemd-coredump and
>> the like.  Why wouldn't we do it similarly for GPU?  Handling this at
>> the proper place you leave the policy there for "how long to retain the
>> log", "maximum size", "rotation", etc.... outside of the kernel.
>
>Where and how would this udev rules be distributed?

it depends on where you implement such a logic to collect gpu coredump.
It might be a new project, it might be a daemon from mesa itself, it
might be extending systemd-coredump.  Your decision on where to
implement it will influence what's the reach it will have.

>There is portable way to do that for distros that don't ship with systemd?

If you do it in one place, people who care can probably replicate to
other environments.

Lucas De Marchi

>
>>
>> For the purposes of reporting a bug, wouldn't it be better to instruct
>> users to get the log that was saved to disk so they don't risk losing
>> it? I view the timeout more as a "protection" from the kernel side to
>> not waste memory if the complete stack is not in place. It shoudln't
>> be viewed as a timeout for how long the *user* will take to get the log
>> and create bug reports.
>>
>> Lucas De Marchi
>>
>> >
>> > > >
>> > > > > > I have set the timeout to one hour in the Xe driver, but this could increase if we start receiving user complaints.
>> > > >
>> > > > At an hour now, people will probably start arguing that "indefinitely"
>> > > > is about right? But at that point you're probably back to persisting
>> > > > them on disk anyway? Or maybe glitches happen during logout/shutdown ...
>> >
>> > i915 driver don't use coredump and it persist the error dump in memory until user frees it or reboot it and we got no complains.
>> >
>> > > >
>> > > > Anyway, I don't want to block this because I just don't care enough
>> > > > about how you do things, but I think the kernel is the wrong place to
>> > > > solve this problem... The intent here was to give some userspace time to
>> > > > grab it (and yes for that 5 minutes is already way too long), not the
>> > > > users. That's also part of the reason we only hold on to a single
>> > > > instance, since I didn't want it to keep consuming more and more memory
>> > > > for it if happens repeatedly.
>> > > >
>> >
>> > okay so will move forward with other version applying your suggestion to make dev_coredumpm() static inline and move to the header.
>> >
>> > thank you for the feedback
>> >
>> > > > johannes
>> >
>

