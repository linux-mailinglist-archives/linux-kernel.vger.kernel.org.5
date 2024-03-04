Return-Path: <linux-kernel+bounces-91428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1594D87115D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 00:56:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94CB6284A22
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 23:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDEAC7D3EF;
	Mon,  4 Mar 2024 23:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PTkY9xDH"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D59A7D07C
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 23:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709596605; cv=fail; b=FUdcrXC2WZbjiHegOwOTC5PINmB3bksp/hsS+9rmGXyD5lN4XfnYKZ8BZ/As1zECHn1EHsgmO3XXA6/JEhmtAlPxAKwsHmF7jOwOdmXCyy64ud0uzfiHCnV/ZH3TCU4jHYdyWxZKJ0ViXfq4GuYO9+IF2lIiN0dG6buSCqNwJzU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709596605; c=relaxed/simple;
	bh=UETm9foHgSCfa7FwVcHS5dd+PI6FudNX2EEnmvT7+h4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tBUCTygW4lcClp4tVAgYMZg3Yqam/5Kz3Mu20aVFtvjTtWrJccIrCNy4w+YrKEzdZvC9BwS1KYW14yxAbMsSfcRM3rendYkPak8fDjTHsyUG66WrgWAjnTaOa0Z2ZKP5v6KDvIfWcVV9xvp1Ibg/yH6Z3kyGObrfOIKVjDnmdM0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PTkY9xDH; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709596603; x=1741132603;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=UETm9foHgSCfa7FwVcHS5dd+PI6FudNX2EEnmvT7+h4=;
  b=PTkY9xDHV/L4xeieogrkHooy/YV2nFoGETEZC7lnk5TsGcPGeTz0nOJx
   XRC5jv0tZX0b6zXZB5k5R1UAl3X461u7nrkcv5UtV6+VCjjLRMHVRb9CY
   8hYliXGiTbwoPq5tXZbdczZHfMkybw2RcTboEZijo+tbO5UaK5Xc2a2Fh
   JRoDPwj3Ne4yn6b8sAG1vkG00FYOd8jXQWp/xHdF2/OUMHFF2qewlzT4J
   oJTeMligi1J3msz4R+Izn75Lq/b3YK3USyPikpsK1VWiwOKOZrlruobgf
   zcCWNwRzFu6cwJIU2y8sJ+DlqMcYDocCcN3IfqPZPTpKoBHmrA4Sg/w2R
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11003"; a="7940942"
X-IronPort-AV: E=Sophos;i="6.06,204,1705392000"; 
   d="scan'208";a="7940942"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 15:56:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,204,1705392000"; 
   d="scan'208";a="9759085"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Mar 2024 15:56:04 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 4 Mar 2024 15:56:01 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 4 Mar 2024 15:55:59 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 4 Mar 2024 15:55:59 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 4 Mar 2024 15:55:50 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IHlvfeA9QLRqGWdLFYTqJqpkXjAnN3a7AUe7X8+wMWgMQ7f92NTGA/r2kWP68QJkv6b9dTMhfZoyUXWfvJbW37sXycnAzjThxrgS+xRvkcbYGSSrrN9qw1uJuhDyjqOdgVzB9kQJUIhW9+ir5m0M6Ljp5Vikm1BCRsMoGMAZMnBrWjj9XnuH3b83bl6rD7c78Wjgd4cKH6cp6+HYbsh+UkiHDOPNYFI4KCCtJAjQpXNI1qcBQdpcy2WMnvZ4G/wXtrMkhICLJr5XdoCPmJZHQ/5sY57RDCoVfV/JsphtXZ8vEFC3iZL8YihsgMlXlK3mTDI8NrzzEgTlYljF/YWksg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RC6pT3h0WxMt4fsJeM+q7ABlU09PnqbSrKUZpv6QxEc=;
 b=KSXeZ9hJc/7iWkUr+LrFun25zKnMmTUD6XgeaL5FBvfDgM1RGoMyMhUIZ5ebFACbYW0PSZVbfUk+AG4lxYfzqWF8wHClZ5Bex+RU3JC0kogQm5/O9+EHxTlEvsZZdB27UrNCRLAqKcOCJEF/0kzR+S5ET/uyfHoL9A9Ujf0atkxh2qqyX9Xe6Jp7496SF51t/vbzWSBmu83yINuNH+g/d/T7pEWTfB/qd3MitFOlbn64d6i/vU3Fl7tPibkv5WxzU8SF/uDVz1RQH4DbG7RE2nJU4kgN4ajDW8P3lxOnImy4mYQZXcWm8U9z6S3m3IUwGAITT/OPlnSRx4MQfG8uDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6139.namprd11.prod.outlook.com (2603:10b6:930:29::17)
 by LV3PR11MB8507.namprd11.prod.outlook.com (2603:10b6:408:1b0::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.22; Mon, 4 Mar
 2024 23:55:48 +0000
Received: from CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::e9dd:320:976f:e257]) by CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::e9dd:320:976f:e257%4]) with mapi id 15.20.7362.019; Mon, 4 Mar 2024
 23:55:48 +0000
Date: Mon, 4 Mar 2024 17:55:45 -0600
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: "Souza, Jose" <jose.souza@intel.com>
CC: "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
	"johannes@sipsolutions.net" <johannes@sipsolutions.net>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Vivi,
 Rodrigo" <rodrigo.vivi@intel.com>, "quic_mojha@quicinc.com"
	<quic_mojha@quicinc.com>, "Cavitt, Jonathan" <jonathan.cavitt@intel.com>
Subject: Re: [PATCH v2 2/4] devcoredump: Add dev_coredumpm_timeout()
Message-ID: <zfrpz4vuhjwmilbqft5d4qh4s3gs3okzyxbsh4lc5rhzjy5ktx@xuu32mxhun4c>
References: <20240228165709.82089-1-jose.souza@intel.com>
 <20240228165709.82089-2-jose.souza@intel.com>
 <84e4f0d70c5552dd7fa350c61c28de9637628ee6.camel@sipsolutions.net>
 <a27ac0d3bc52c2181852a25641b7020f50a50648.camel@intel.com>
 <0f4244ea6866f451f3f8a5b5e2db8be53de1f0c2.camel@sipsolutions.net>
 <bdaf62020388d3dcf8d3a95ae465c0ae2db7eca1.camel@intel.com>
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Disposition: inline
In-Reply-To: <bdaf62020388d3dcf8d3a95ae465c0ae2db7eca1.camel@intel.com>
X-ClientProxiedBy: SJ0PR03CA0212.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::7) To CY5PR11MB6139.namprd11.prod.outlook.com
 (2603:10b6:930:29::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6139:EE_|LV3PR11MB8507:EE_
X-MS-Office365-Filtering-Correlation-Id: 926eff3e-a756-4c13-1fc1-08dc3ca69d1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7Q/kyOpUqRdz4CT9/bPRNVVxS64/96R/4recu/u2zr/idy6Ch2CuMBg32DQxyNb0qtDC6fH3OUEZ2JJzsPGvD2daE+weF3z11e5a3IbQQKMTegr6vjv01dIgzo9yKqyUPfL4aMBX7wLWt2EM1ZbdXQuOgfnFOixDsPj5V1Pps8MEWtUs9Q56FS36OjQb5D/wSYGO8rFWmiDBqhz13a4CjCJKIvxMK5eFnHhiS8Y58kgNg96JLD2x1MezmkujaUPIgfyKSnIRg8Z77wE2M4jxt+WAqNzJAtbWYW2P4IS5nOx4OzshC42I1Y5QGvrIPqWhKbGMSYWhA3+4RB8xBKTr5KB//2YqlLQJt/yz1X1Yag6ciKjAY+0+/5qv1A7QJZBintyie1imNR0Ao2k5dNQz3SEdwnoyGs4hpesX9akMa9mg+yUHuYiF8dgOl0u4ux01h/QZ+PHwlzTMsZTn88TIX+yUHZ45yE2yzOptnFafstxiBosylugChMb72i5tc9AgwE9FoFEd+i4JBglwmvH5rJlh9mMnZ1Q15OEVOKW/tVpgmaMnVHOc8CV/d7ni2CZXvvCYLuYcYhxN4ewyGB1quQQM+uQOqiXEu5i9toum190=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6139.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uJ5ZEw5fEgE3n9DJ1DGAEuyOT1MEBIZUK85pHLK0oGoSf9Lwwl2Ntff0gC1+?=
 =?us-ascii?Q?oRQLay8t3a8+0sb1FvoinBR8KxMpWfJQG9HK4QB8QVGFLbXus06wYzozz1ba?=
 =?us-ascii?Q?lFSg88dODnrbWQpbas7/jEKtF+t85UgqVjn0IFB3hT9d4y2nn62RzBS515dW?=
 =?us-ascii?Q?w2BcAQHKQW+VuAIBQYRb9sgid5U6+e4uNC+cE7qWPaoAlv1YFCvSgCoEBdmc?=
 =?us-ascii?Q?9UZc4YOHcwatUnGvDZsbzzNJzDntPy92+r45TRzQkDCC4fKlxwGDhXmDD2zQ?=
 =?us-ascii?Q?+rU6CZvFqFLgKrLXX1ZdzhyBZtm7+iVR34nw2sBBIEsV5zk+oYBF7hdM80d7?=
 =?us-ascii?Q?MFcDc2aXfV6SS0ulgy0lIFblfnlX85m/uXJZhtN/BMVwZ0Q4db+j0yo22++n?=
 =?us-ascii?Q?QqNHxTmlASN/79WXiOMogdDWW5VY/3Nch2InO3E7r1/T+UskatdQ5C5NH0zA?=
 =?us-ascii?Q?n1RVz24u4TXG0Yst1e/W3vexkXkQzXl2Hmg90dOAqsMUfjegtX+P6kEnSBJQ?=
 =?us-ascii?Q?25SVXc2TnTqVE1I8srcQbIg8+4qLdgeyzSZ4xFfo0n6ndFUW9NHTlldvzER1?=
 =?us-ascii?Q?x8r4rqeBMcK70BFVVO7gMgCK1Ph/cbaoZckyRsg2UEoSngp4GFPGqHqGaPvQ?=
 =?us-ascii?Q?g1MZXptTk4e6RQc6CppjBx+E0TNcnOiTRhFIgMkHhTTlntaB1PIYHW8nVTiW?=
 =?us-ascii?Q?NEPYSmVoxeVTyClm/V1BvPG6+45Eof2zaPy+TRGwB3M+/25x2eqWO36hDa5I?=
 =?us-ascii?Q?tP/ZE3/a1oQCCtTGmgWRjHh6mdc5tmGJxse1yM9YUvyab7o0n6wLb4nWc/mH?=
 =?us-ascii?Q?djwBdi8zdJImWSIQa82OVrURoP893VEPBZ9FG5D57BslYw1Z/NMV9DhgC9Kr?=
 =?us-ascii?Q?R0toTSjQr7XAHJ0biRHE5QFZy8Khss7rIc0ygrlLYkKtxxEGT8y0UHQ2jpiE?=
 =?us-ascii?Q?1+YJbm3FgRGLxe6mDpsYY5ZeLKCekEL8a9cNRdRL2ZiYb2JHfPQFz4kMlPwV?=
 =?us-ascii?Q?zohp0/YD3mcPfeyJ+oWFKHgolc9RkYG4l1Xz+ywSoCpw1RVvjvG4+ipXNhcr?=
 =?us-ascii?Q?Ua4hkkBVK4RPgnzXACajcicJu0+sxs2Z9oOoNIADn8jTCHPVVANv4UtTmEaI?=
 =?us-ascii?Q?LnK3JIv9zl5HviCBV77NTVoVJDtbHhAre/Atnj360gTELL3rPLRv/nmXtDZJ?=
 =?us-ascii?Q?Thy+3SBIWEHmPBTk9apgv7kfLL1dkvsy86A9Uw1vLXeo22RKYuyXFPkEyHp9?=
 =?us-ascii?Q?qCR+zm8CKDx9PpQArKO3N8HyilmbcNqlSelnKpjk2yCvcoH/DcOXEcU6Zw28?=
 =?us-ascii?Q?d3UrU+4C6ZaBvv3D+xcXSdCObUSk8JXBTg2Tatr7/113gweQBxsTLm+UwdvK?=
 =?us-ascii?Q?faPi+C6K/McrWgzPiY2dboZeIzHQcbDdq1GOsDAzhNleoHxPJv0+mpTHqeBs?=
 =?us-ascii?Q?ZmBj7RJe70Ff0vlWMwxal2HZ1yw+LWj6eV2OKUiUIdLESR9KhrFuSQjnLXc/?=
 =?us-ascii?Q?yfHSDFUrlZY6mUDdXPCqkWrAz26u2aIKFMUiEZzdV80sZLzgURGemQrVc+Xy?=
 =?us-ascii?Q?fbUGHT9IrBVaNFjcPq573vM/aJhCreBytWep7B+o5UtidgEW+b6sorAhtbe7?=
 =?us-ascii?Q?sg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 926eff3e-a756-4c13-1fc1-08dc3ca69d1d
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6139.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2024 23:55:48.0153
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: slSz0UACcR16zo6XtHPEhNMuZ1e44Q+A27rBMHdwFGrG3JCBLWHjAoDajGRra/H7W+HoF78cwniQeqxrl3vj4irh/zlauuF9A88uBOwgMSw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8507
X-OriginatorOrg: intel.com

On Mon, Mar 04, 2024 at 02:29:03PM +0000, Jose Souza wrote:
>On Fri, 2024-03-01 at 09:38 +0100, Johannes Berg wrote:
>> > On Wed, 2024-02-28 at 17:56 +0000, Souza, Jose wrote:
>> > > >
>> > > > In my opinion, the timeout should depend on the type of device driver.
>> > > >
>> > > > In the case of server-class Ethernet cards, where corporate users automate most tasks, five minutes might even be considered excessive.
>> > > >
>> > > > For our case, GPUs, users might experience minor glitches and only search for what happened after finishing their current task (writing an email,
>> > > > ending a gaming match, watching a YouTube video, etc.).
>> > > > If they land on https://drm.pages.freedesktop.org/intel-docs/how-to-file-i915-bugs.html or the future Xe version of that page, following the
>> > > > instructions alone may take inexperienced Linux users more than five minutes.
>> >
>> > That's all not wrong, but I don't see why you wouldn't automate this
>> > even on end user machines? I feel you're boxing the problem in by
>> > wanting to solve it entirely in the kernel?
>
>The other part of the stack that we provide are the libraries implementing Vulkan and OpenGL APIs, I don't think we could ship scripts that needs
>elevated privileges to read and store coredump.

it's still a very valid point though. Why are we doing this only on
kernel side or mesa side rather than doing it in the proper place?  As
Johannes said, this could very well be automated via udev rules.
Distros automate getting the coredump already with systemd-coredump and
the like.  Why wouldn't we do it similarly for GPU?  Handling this at
the proper place you leave the policy there for "how long to retain the
log", "maximum size", "rotation", etc.... outside of the kernel.

For the purposes of reporting a bug, wouldn't it be better to instruct
users to get the log that was saved to disk so they don't risk losing
it? I view the timeout more as a "protection" from the kernel side to
not waste memory if the complete stack is not in place. It shoudln't
be viewed as a timeout for how long the *user* will take to get the log
and create bug reports.

Lucas De Marchi

>
>> >
>> > > > I have set the timeout to one hour in the Xe driver, but this could increase if we start receiving user complaints.
>> >
>> > At an hour now, people will probably start arguing that "indefinitely"
>> > is about right? But at that point you're probably back to persisting
>> > them on disk anyway? Or maybe glitches happen during logout/shutdown ...
>
>i915 driver don't use coredump and it persist the error dump in memory until user frees it or reboot it and we got no complains.
>
>> >
>> > Anyway, I don't want to block this because I just don't care enough
>> > about how you do things, but I think the kernel is the wrong place to
>> > solve this problem... The intent here was to give some userspace time to
>> > grab it (and yes for that 5 minutes is already way too long), not the
>> > users. That's also part of the reason we only hold on to a single
>> > instance, since I didn't want it to keep consuming more and more memory
>> > for it if happens repeatedly.
>> >
>
>okay so will move forward with other version applying your suggestion to make dev_coredumpm() static inline and move to the header.
>
>thank you for the feedback
>
>> > johannes
>

