Return-Path: <linux-kernel+bounces-6932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 41F96819F78
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 14:05:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6791B25517
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 13:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3112125571;
	Wed, 20 Dec 2023 13:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kc4bUzfH"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E3F36AF0;
	Wed, 20 Dec 2023 13:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703077515; x=1734613515;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zJytX3zE8ONPwbeFb4umrlqXX7hgiaaTV61DVCriigI=;
  b=kc4bUzfHHshSSF+pNTOoaC9k1u69skcZiWSH3EBLoTiE8Pc1O+aXtFbL
   lggdFe+bY+4ClAnaP0ZYEIxnV5/54VcHDF27s0lDHKD3bc08/wxjD0D+5
   reTIpXy+kdJk3adv3pb9fVd/SajD2Axtyl3Xa+lSpO3d0NGIw4mHK5oGi
   cAoYeTYKvf3yUJvRnVqTHJ/2/JO1teZwpzTxGkxg8MMBO3mLVfTTJo76S
   844Uxjry7k5KTgqnNpEJr7gV2uQE2nrt6+HA/9JtfCre9yE/SeiFPERJD
   HfZrFwXeMMi6FcVNew2r+uf5g55IjtAOrJqbcaS0O7bcsODoyFapTV5Dl
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10929"; a="398590174"
X-IronPort-AV: E=Sophos;i="6.04,291,1695711600"; 
   d="scan'208";a="398590174"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2023 05:05:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10929"; a="776327941"
X-IronPort-AV: E=Sophos;i="6.04,291,1695711600"; 
   d="scan'208";a="776327941"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 20 Dec 2023 05:05:11 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id 0D52454B; Wed, 20 Dec 2023 14:58:57 +0200 (EET)
Date: Wed, 20 Dec 2023 14:58:57 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Sanath S <sanaths2@amd.com>
Cc: Sanath S <Sanath.S@amd.com>, mario.limonciello@amd.com,
	andreas.noever@gmail.com, michael.jamet@intel.com,
	YehezkelShB@gmail.com, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [Patch v2 2/2] thunderbolt: Teardown tunnels and reset
 downstream ports created by boot firmware
Message-ID: <20231220125857.GA2543524@black.fi.intel.com>
References: <20231218104234.GB1074920@black.fi.intel.com>
 <c433f29b-597c-b6d6-aa48-2b84a26dc623@amd.com>
 <20231218113151.GC1074920@black.fi.intel.com>
 <20231218122312.GE1074920@black.fi.intel.com>
 <997f2a94-66d9-fb95-8f75-46d61937f7e8@amd.com>
 <20231218131840.GH1074920@black.fi.intel.com>
 <0fd5c09f-1cf2-8813-a8f9-1bd856e3a298@amd.com>
 <20231219122634.GJ1074920@black.fi.intel.com>
 <0816caa4-81b5-d0f9-2305-80c7fec6abb9@amd.com>
 <20231219180424.GL1074920@black.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231219180424.GL1074920@black.fi.intel.com>

On Tue, Dec 19, 2023 at 08:04:24PM +0200, Mika Westerberg wrote:
> > > One additional question though, say we have PCIe tunnel established by
> > > the BIOS CM and we do the "reset", that means there will be hot-remove
> > > on the PCIe side and then hotplug again, does this slow down the boot
> > > considerably? We have some delays there in the PCIe code that might hit
> > > us here although I agree that we definitely prefer working system rather
> > > than fast-booting non-working system but perhaps the delays are not
> > > noticeable by the end-user?
> > I've not observed any delay which is noticeable. As soon as I get the login
> > screen
> > and check dmesg, it would already be enumerated.
> 
> Okay, I need to try it on my side too.

One additional thing that came to mind. Please check with some device
with a real PCIe endpoint. For instance there is the integrated xHCI
controller on Intel Titan Ridge and Goshen Ridge based docks. With TR it
is easy because it does not support USB4 so xHCI is brought up
immediately once there is PCIe tunnel. For GR (the OWC dock you have) it
is disabled when the link is USB4 (because USB 3.x is tunneled as well)
but you can get it enabled too if you connect it with an active TBT3
cable.

