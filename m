Return-Path: <linux-kernel+bounces-97216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EDB087671D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 16:14:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A8D41C2169A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 15:14:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05FDB1DA2E;
	Fri,  8 Mar 2024 15:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Io1WvYLm"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 226564C90
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 15:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709910884; cv=fail; b=D9P1eNwpeEiMkxoTnZcdT/JRY2ukdNdAH9V5s/E/+dSJHIOEZpivFojGTeHC0JkjTPZSO258379BgGkwfnI7MbK8weiPxzK6kWet8Kd+ooqfeWveFbkQLOM/I32825Uey299IwTlFa3R+ZVXa9HJqo4sfmp+yPz7/feDYm/mNRo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709910884; c=relaxed/simple;
	bh=AcnpDmDho0WoZG0W/flTbnmxQy4gN+FBMHiVVqktALk=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bYiJyfCtprcp6X/sx6Z8K420KCiy4shT7gFZQJ7NdeLgl22c+65LxKekNAcT+epdzu1XOSFxxt/tj0pmXagdkJG8uExtBWxbPs3uEfXh/FMV52DkHhim9DbIglBTsQRIgnSyF/OsJF5hOMxVBNcxk3ETUznjR/0g5JH+BLoS5Hk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Io1WvYLm; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709910882; x=1741446882;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=AcnpDmDho0WoZG0W/flTbnmxQy4gN+FBMHiVVqktALk=;
  b=Io1WvYLmwKjtCpvLCpfX3elRZ9v1RHfT7fAne053cS/Gx2xDoIcg1sd0
   KFkRwcjdwLVeuh/DiTmybryAI9n/eN6nQCeawTWVZHbvcRnhYmc6U606Y
   qUH4j+LPx+oY32oD5zqZhNflNhPm/0TWuStoArfKY8qvy7Z+AgEZAHxSy
   EpqywOky5lHlJcVAZAVWFC3IPYuGECs+r/DzH/9jkitHmxpRWOPP0UetE
   Trfluhk6KEgoEEuc1n1QAbIGvz5mkwyNK55AKYUb3b2ZThl5UeNyCC+T/
   o4TQm6233ixG+veNYl3Ow4jdTRZnCpIViaS7h7ejxYKF8lDKKI9w1+n/4
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="5232253"
X-IronPort-AV: E=Sophos;i="6.07,109,1708416000"; 
   d="scan'208";a="5232253"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2024 07:10:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,109,1708416000"; 
   d="scan'208";a="10416184"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Mar 2024 07:10:19 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 8 Mar 2024 07:10:19 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 8 Mar 2024 07:10:18 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 8 Mar 2024 07:10:18 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iabtNgK4fZJQ1MmcR9ImxJ5zX14gqsK/nsoDRZ0HsqhmF2gF+DDO+bntenXUuPrNBUQF0AqYbV6R4xJo8I3RAFzlQufPKIYODAN6pHgC2Y1ARlguwhUBiY428GLAt3FdjzMusmlbVEBfjI1lwkIvwLivil5WP1HTOwxJnCebgENueQGTvFHdMBVVQO8j7MNX9ZW/U1lpSRdpa3bnbvmb9umc4cFsz/YMsfd9D8zBmLf3gKeffi+zxNyljNULbHTSTrpLfNQNdiWwdmOyAxUnk09Xuxjfu4lOxb20v2svL/ZCN6XnxgPuzYEka9UulatXOJTqiDDWF3MMVQm6rzh8XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3nABWLSmvOjLJDnpFP0L4FZ5e6J5iK1pdQ/wz3RF2u8=;
 b=EsgNfAdxMpgTANXHzfzX9N4ULU1rc+M/vWqaoNE2sxJKCZovE/Bcupaa94ByUG4viLVSCuAoJOO8R6PmrqA7WD7siZ+aps1QmOgIedkIxipjOzXra2V6NoMwfXJHQBhQ6eDUxWlE47Sv7u2Xd/Q3KVWkTDHwqdXppDLVxj1W+lTut9WBan1nhyi/4ZJyh3wAOgoNKHIHHbHC2Bi8P8SVccD8nQcLx8DZjkHLi47EeKVrLrEdj08Gbt6FtMNeDOWWxeBVVJLrPNAWWLy7/hu6Wtj7Aq0x2WJ7OInZj4nB+ViKs9hlCMT0bVe94+5LEerg/jhAmOgFgIsRp3rZgXTSKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6059.namprd11.prod.outlook.com (2603:10b6:208:377::9)
 by PH0PR11MB4855.namprd11.prod.outlook.com (2603:10b6:510:41::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.9; Fri, 8 Mar
 2024 15:10:16 +0000
Received: from MN0PR11MB6059.namprd11.prod.outlook.com
 ([fe80::a7f1:384c:5d93:1d1d]) by MN0PR11MB6059.namprd11.prod.outlook.com
 ([fe80::a7f1:384c:5d93:1d1d%4]) with mapi id 15.20.7362.019; Fri, 8 Mar 2024
 15:10:16 +0000
Date: Fri, 8 Mar 2024 10:10:12 -0500
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: Lucas De Marchi <lucas.demarchi@intel.com>
CC: "Souza, Jose" <jose.souza@intel.com>, "intel-xe@lists.freedesktop.org"
	<intel-xe@lists.freedesktop.org>, "quic_mojha@quicinc.com"
	<quic_mojha@quicinc.com>, "johannes@sipsolutions.net"
	<johannes@sipsolutions.net>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Cavitt, Jonathan"
	<jonathan.cavitt@intel.com>
Subject: Re: [PATCH v2 2/4] devcoredump: Add dev_coredumpm_timeout()
Message-ID: <ZesqVChUizIBmkvK@intel.com>
References: <20240228165709.82089-2-jose.souza@intel.com>
 <84e4f0d70c5552dd7fa350c61c28de9637628ee6.camel@sipsolutions.net>
 <a27ac0d3bc52c2181852a25641b7020f50a50648.camel@intel.com>
 <0f4244ea6866f451f3f8a5b5e2db8be53de1f0c2.camel@sipsolutions.net>
 <bdaf62020388d3dcf8d3a95ae465c0ae2db7eca1.camel@intel.com>
 <zfrpz4vuhjwmilbqft5d4qh4s3gs3okzyxbsh4lc5rhzjy5ktx@xuu32mxhun4c>
 <f7c2d3381e50dd9c5e9211461e0abe487f5059df.camel@intel.com>
 <u4tngmdxcciblq327yi75fdfkadv3fomnopnpgbwkk7smh3knp@d2h7373q4msf>
 <04cee1ad22cdb1d6a6a4a7482e4ebf7d28cd63e9.camel@intel.com>
 <f4fjvfx6a3gk55mdbqrirlyxdzsjxelynhosqonrtmsiiorqe7@m6q2kkuwhgdt>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <f4fjvfx6a3gk55mdbqrirlyxdzsjxelynhosqonrtmsiiorqe7@m6q2kkuwhgdt>
X-ClientProxiedBy: SJ0PR05CA0075.namprd05.prod.outlook.com
 (2603:10b6:a03:332::20) To MN0PR11MB6059.namprd11.prod.outlook.com
 (2603:10b6:208:377::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6059:EE_|PH0PR11MB4855:EE_
X-MS-Office365-Filtering-Correlation-Id: d8e2c6a0-e833-473e-e58d-08dc3f81dc65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PeqiS/8aa/+l4vH1RWNV+kpX2V3SC+GWbY3N0vhLYgELkZujKI+CbvCTdubcqF/aVngKAaSCztiFauiY5nEqeSNhOEG4s2n76jglYC+SbL7Rn6LVOYpps7+y+gEURvQ2m6ZJuDwVErIsSLuepgLyunBV1Hu0LybSdsxIyogxBIJaturnxmZzpP/Q6Et1JGVczpRWAxuxlTMUoEIfV98+PBdr+Pv1w78iEtT99uhFIAnEnPjfrY3wkFne+ut2tYe7vw0Pb5wm54RufmY7/aqktiyAXGt+yBeiRdWyN0W+ACTYpAlVQPPccyDesGVyBMo8tfUGUoZCl6z5F+BJXPToI0hyUyHYuPe3q2da4FUue1ntDeWNfzf7JiltLy+gltNdFOjVe8YdT/NvjKyQHQIbrVNypMafshilW4FVtvCnLHzK5ELuwUW7mE+e+eqSYKwP/2zCqnvKkz8yVSwddBJeecES4zExATRS8MxIcz6igdkuhnlRM/QjdKL0135P27av1xy02Ekh3dUKkk1HPtQwyXbhXjojmnWGjDH9BlqTv5wRrz68iNlXCVR5lSvHgcdxgJEBCJFvvyBWn9Iffecdc8ZhGyJeMFgDaHp0dhm3ihs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6059.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?irTlVArBqFCfFZv+PxYgPP7nlGhNlkqcwWawI6hwMmPEwkcfH6KkTsksSNZb?=
 =?us-ascii?Q?DBo00ZyDIA+TYxV9ZotFgOoSBl75DAGvGn229VsoHWmv2FkaxsxiHU2EAVSE?=
 =?us-ascii?Q?Pajo0ZjgBqaDaHSB5fB9kMq8cDkuoWBbtcZwn/CL7KHjTvopDkABop2UIWVV?=
 =?us-ascii?Q?ZyaTrT3mE2+l4OT1VC/j8lYPIBG+3ozCXFlEvZTtDVfLv/l+RMpXm5yH8dsU?=
 =?us-ascii?Q?9lF5RJS4dOBuUDqrqlljAnGn2tBzVwfUj6IQnTJKWjKThGOi3hdRhx/jHjqu?=
 =?us-ascii?Q?5Uqw+2u4XW0Ysf9TP8vHzl0/YZzlXJGQb5JPG3MJXXxJGiZW2eHOepJTbz3B?=
 =?us-ascii?Q?2ln18imZ6ogUBnKsLsD3wb6a06if5BFR9pHn57GX0l83wje3OIuq2rEgEuDy?=
 =?us-ascii?Q?Idra4IDyTgMMhMULFNJeiTJiPQBK5Lbv1pZl5+0bKVvZZbvGz4p5wqweC/FJ?=
 =?us-ascii?Q?k5M22SiW27W/twm4jbQ37dzGnkebEz54KMA5Bgvj8a2mvzT2r27hRTq2hNaS?=
 =?us-ascii?Q?3RN0OQwNuPtUF8kNc+gI6OIRqzOJMOXSxHt9k3zbA78zojKLFgKs3y3rtSDu?=
 =?us-ascii?Q?QkvXFcMtwmPcT2awTF4tk+BawJqV7tFVhzyJ3kkzSVxr36msHKV417aQ1yoz?=
 =?us-ascii?Q?My93iPtmPR3YtuRQLSE9DsLztY2lVegdyc5Heqbl5uu5Ea8vu5Xwn35wx5Rm?=
 =?us-ascii?Q?CKDFGtyE4Qq55+9ingOxHoQZIsNCDC/Vycj7EArmuLtteZh77QmGvbb5ILwo?=
 =?us-ascii?Q?Mjuc3hZQIU/r+ADJl1DNrxJHnVUU2LwxBZmMTUNvJ+NW1Lba1eRBM0O2DpIE?=
 =?us-ascii?Q?wvG67/NoFEXBOc5wJe+aysMzoomNFmZhwL1Am8xwHCuR/Q45S2A8Y/8jghbf?=
 =?us-ascii?Q?zyfrPSpMLT95W4QUbKEFwrSPidMX1o5BS0+M8ogH2APUQjb5MhT/gQpQ3rgq?=
 =?us-ascii?Q?yNzRi3Xq6bb7yR2UFuaQv3o8v1kyUg6raqEE4YZKNGHwzBFwKP345lPlKHqD?=
 =?us-ascii?Q?apkexAC5OU3hHCQ1RcRHojh/4va59ctTH1Gkg6yPtTE34gB4xoJe0/ma3Zka?=
 =?us-ascii?Q?t0DMTQ+5lQM5LNIhntcTsNZJPy6kdrIj2d7+VzdZjpacem68SjZyiKpHx+2j?=
 =?us-ascii?Q?uaixIIjsM0yZX4rkjwUtoevb28FlNDdLD9rMjYoQCCLO9ToDRHBk1pgrbaiX?=
 =?us-ascii?Q?fx28x7VJ0mC7HqBfsPgH0+VHOuo+xbRAPYq9SC496BZwWsTYsLOzW1DYY6Sx?=
 =?us-ascii?Q?Sy9Nvj1W6ZFaNvqpLo8l8oQVxWthie0uv1abrv70A86moqxvJrC0Fob3VtI8?=
 =?us-ascii?Q?BtAd0FPItXL0rUQziOIBFcs6WHl23aBpan2WFOjKpW3BWHkijzrYfVoTRzil?=
 =?us-ascii?Q?XzzEIA76NsdOF2szylGvLSHYlqWci3sdWZOmSWGJW7Vbo9lHZ3S7fL0M+nRK?=
 =?us-ascii?Q?a9t19M9fIkIwkaOfnvPoUNJy9YxDmEEse4baNgScVOrkOoE2GdYcWYcJB/gp?=
 =?us-ascii?Q?PH77ANBONHSe5Rv4P/Sx2q4SRqqxWuqDQ4gohMWV8Wid9sNtpE8qI6XSEtzS?=
 =?us-ascii?Q?/ZVmEI+dQ4MBOzFIpbzY27PLdmDwkkX7hezpg55e?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d8e2c6a0-e833-473e-e58d-08dc3f81dc65
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6059.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2024 15:10:16.2816
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xy6X0zGR20oS5v1kA07ZRSee3acaxqDBa/LoulVp8oHGlwJAJ6uBWZu+4eAvSLu63fMynKWDucVvPX7XMrziKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4855
X-OriginatorOrg: intel.com

On Fri, Mar 08, 2024 at 08:53:24AM -0600, Lucas De Marchi wrote:
> On Tue, Mar 05, 2024 at 03:38:58PM +0000, Jose Souza wrote:
> > On Tue, 2024-03-05 at 09:22 -0600, Lucas De Marchi wrote:
> > > On Tue, Mar 05, 2024 at 02:21:45PM +0000, Jose Souza wrote:
> > > > On Mon, 2024-03-04 at 17:55 -0600, Lucas De Marchi wrote:
> > > > > On Mon, Mar 04, 2024 at 02:29:03PM +0000, Jose Souza wrote:
> > > > > > On Fri, 2024-03-01 at 09:38 +0100, Johannes Berg wrote:
> > > > > > > > On Wed, 2024-02-28 at 17:56 +0000, Souza, Jose wrote:
> > > > > > > > > >
> > > > > > > > > > In my opinion, the timeout should depend on the type of device driver.
> > > > > > > > > >
> > > > > > > > > > In the case of server-class Ethernet cards, where corporate users automate most tasks, five minutes might even be considered excessive.
> > > > > > > > > >
> > > > > > > > > > For our case, GPUs, users might experience minor glitches and only search for what happened after finishing their current task (writing an email,
> > > > > > > > > > ending a gaming match, watching a YouTube video, etc.).
> > > > > > > > > > If they land on https://drm.pages.freedesktop.org/intel-docs/how-to-file-i915-bugs.html or the future Xe version of that page, following the
> > > > > > > > > > instructions alone may take inexperienced Linux users more than five minutes.
> > > > > > > >
> > > > > > > > That's all not wrong, but I don't see why you wouldn't automate this
> > > > > > > > even on end user machines? I feel you're boxing the problem in by
> > > > > > > > wanting to solve it entirely in the kernel?
> > > > > >
> > > > > > The other part of the stack that we provide are the libraries implementing Vulkan and OpenGL APIs, I don't think we could ship scripts that needs
> > > > > > elevated privileges to read and store coredump.
> > > > >
> > > > > it's still a very valid point though. Why are we doing this only on
> > > > > kernel side or mesa side rather than doing it in the proper place?  As
> > > > > Johannes said, this could very well be automated via udev rules.
> > > > > Distros automate getting the coredump already with systemd-coredump and
> > > > > the like.  Why wouldn't we do it similarly for GPU?  Handling this at
> > > > > the proper place you leave the policy there for "how long to retain the
> > > > > log", "maximum size", "rotation", etc.... outside of the kernel.
> > > >
> > > > Where and how would this udev rules be distributed?

Perhaps we can have igt tool to distribute the udev rule?

> > > 
> > > it depends on where you implement such a logic to collect gpu coredump.
> > > It might be a new project, it might be a daemon from mesa itself, it
> > > might be extending systemd-coredump.  Your decision on where to
> > > implement it will influence what's the reach it will have.
> > 
> > Don't make sense to be in Mesa, compute and media stacks also needs it.
> 
> so what? A project can't have something that is useful to other
> projects? Anyway, having it in mesa is just one of the possibilities I
> mentinoned.

There's one big case that I don't see in this discussion here but some
folks might be wondering about.

It might not be a matter of where and how we distribute the rule or how
we capture the log.

We might have cases where the dump is extremely huge: 2GB+ if we are
setting to capture all the textures and everything else.
And only the very first hang is useful for debugging.

So, in this case we perhaps want to avoid extra huge captures.
Okay, most of that could be scripted out with udev. If the dump
is huge don't write 1 back to data so you don't keep capturing
more, but then after 5 minutes we will have more huge captures
that we could likely be avoided to start with if we had the option
to do so.

This would possibly be one argument for a single capture or longer
timeout before coredump removal.

But well, I believe this case only happen in debug machines by devs
so maybe not a so strong case in the end of the day.

> 
> > 
> > > 
> > > > There is portable way to do that for distros that don't ship with systemd?
> > > 
> > > If you do it in one place, people who care can probably replicate to
> > > other environments.
> > 
> > But then the 5 min timeout is still problematic.
> > 
> > In my opinion we can have this automation, make it store codedump in disk, do the dump rotation... but also have a 1 hour timeout.
> > The automation can write "0" to devcoredump/data and free the dump from memory for the distros that supports this automation.
> 
> IMO it should not be treated as advanced automation, but rather the
> normal way to collect dev coredump. It's much more useful to the end user
> than documenting "oh, if you see a glitch on the screen, hurry up you
> have X min to look at file /path/to/log to get it from the kernel. And
> btw the glitch couldn be something else that does not generate a
> coredump, so if you don't have it, it's normal)".
> 
> It's not up to me to decide though. If maintainers think it's ok due to
> be a small change with no dire consequences, then fine.
> 
> Lucas De Marchi
> 
> > 
> > > 
> > > Lucas De Marchi
> > > 
> > > >
> > > > >
> > > > > For the purposes of reporting a bug, wouldn't it be better to instruct
> > > > > users to get the log that was saved to disk so they don't risk losing
> > > > > it? I view the timeout more as a "protection" from the kernel side to
> > > > > not waste memory if the complete stack is not in place. It shoudln't
> > > > > be viewed as a timeout for how long the *user* will take to get the log
> > > > > and create bug reports.
> > > > >
> > > > > Lucas De Marchi
> > > > >
> > > > > >
> > > > > > > >
> > > > > > > > > > I have set the timeout to one hour in the Xe driver, but this could increase if we start receiving user complaints.
> > > > > > > >
> > > > > > > > At an hour now, people will probably start arguing that "indefinitely"
> > > > > > > > is about right? But at that point you're probably back to persisting
> > > > > > > > them on disk anyway? Or maybe glitches happen during logout/shutdown ...
> > > > > >
> > > > > > i915 driver don't use coredump and it persist the error dump in memory until user frees it or reboot it and we got no complains.
> > > > > >
> > > > > > > >
> > > > > > > > Anyway, I don't want to block this because I just don't care enough
> > > > > > > > about how you do things, but I think the kernel is the wrong place to
> > > > > > > > solve this problem... The intent here was to give some userspace time to
> > > > > > > > grab it (and yes for that 5 minutes is already way too long), not the
> > > > > > > > users. That's also part of the reason we only hold on to a single
> > > > > > > > instance, since I didn't want it to keep consuming more and more memory
> > > > > > > > for it if happens repeatedly.
> > > > > > > >
> > > > > >
> > > > > > okay so will move forward with other version applying your suggestion to make dev_coredumpm() static inline and move to the header.
> > > > > >
> > > > > > thank you for the feedback
> > > > > >
> > > > > > > > johannes
> > > > > >
> > > >
> > 

