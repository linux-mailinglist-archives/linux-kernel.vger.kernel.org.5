Return-Path: <linux-kernel+bounces-17531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AFF5824EEC
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 08:06:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E45AB232FC
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 07:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AB71199CD;
	Fri,  5 Jan 2024 07:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nCfWlCnp"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F6F1DDCA;
	Fri,  5 Jan 2024 07:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704438376; x=1735974376;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=KGqK0eMGMrJBlyOaChkg8/aXTrE/0goWy08rMJAWQfU=;
  b=nCfWlCnpxOKFgMQ78EDAEzpt81OJeKtNeM4ZWJh2Ejmhg+KS9jGR/P5b
   IIMfQGxfN4U+h8LKaXseqr5T2czwT4NyfOFh+90B/f44VFolAGWN7C4kc
   cQxz3RW7dO8x1/kH7w6QdQhw7FQi/L4gG3mkSoaDJl7HkApkf0i0Rjn2Y
   LznZXhvGLEaOnaU8N6h9zPX+tMLMvl4fFX0wa2gNKqNsyDXYD3vGFXQNe
   nNcuDVNSZRnzNCPuGGiG/E6ZGOjEWS2spi1mnvHAGjzET3T836u97nBMn
   UolHZkqzI+s/mP7HmBomBs6rbTp6big94Wuubuu6OMyV8ZRBwcWxldQ+b
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10943"; a="401234818"
X-IronPort-AV: E=Sophos;i="6.04,333,1695711600"; 
   d="scan'208";a="401234818"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2024 23:06:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10943"; a="846499314"
X-IronPort-AV: E=Sophos;i="6.04,333,1695711600"; 
   d="scan'208";a="846499314"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 04 Jan 2024 23:06:12 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id 927C529B; Fri,  5 Jan 2024 09:06:11 +0200 (EET)
Date: Fri, 5 Jan 2024 09:06:11 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Sanath S <sanaths2@amd.com>
Cc: Sanath S <Sanath.S@amd.com>, mario.limonciello@amd.com,
	andreas.noever@gmail.com, michael.jamet@intel.com,
	YehezkelShB@gmail.com, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [Patch v2 2/2] thunderbolt: Teardown tunnels and reset
 downstream ports created by boot firmware
Message-ID: <20240105070611.GM2543524@black.fi.intel.com>
References: <866cb714-b9a8-a7d4-4c59-6ba771ef325f@amd.com>
 <20231218104234.GB1074920@black.fi.intel.com>
 <c433f29b-597c-b6d6-aa48-2b84a26dc623@amd.com>
 <20231218113151.GC1074920@black.fi.intel.com>
 <20231218122312.GE1074920@black.fi.intel.com>
 <997f2a94-66d9-fb95-8f75-46d61937f7e8@amd.com>
 <20231218131840.GH1074920@black.fi.intel.com>
 <0fd5c09f-1cf2-8813-a8f9-1bd856e3a298@amd.com>
 <20231219122634.GJ1074920@black.fi.intel.com>
 <558fb39a-470d-16e3-0043-510e6b4b3f8e@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <558fb39a-470d-16e3-0043-510e6b4b3f8e@amd.com>

On Thu, Jan 04, 2024 at 10:19:20PM +0530, Sanath S wrote:
> 
> On 12/19/2023 5:56 PM, Mika Westerberg wrote:
> > On Tue, Dec 19, 2023 at 02:41:08PM +0530, Sanath S wrote:
> > > On 12/18/2023 6:48 PM, Mika Westerberg wrote:
> > > > On Mon, Dec 18, 2023 at 06:35:13PM +0530, Sanath S wrote:
> > > > > On 12/18/2023 5:53 PM, Mika Westerberg wrote:
> > > > > > On Mon, Dec 18, 2023 at 01:31:51PM +0200, Mika Westerberg wrote:
> > > > > > > On Mon, Dec 18, 2023 at 04:49:13PM +0530, Sanath S wrote:
> > > > > > > > > The discover part should not do anything (like write the hardware) so
> > > > > > > > > perhaps it is just some timing thing (but that's weird too).
> > > > > > > > > 
> > > > > > > > > I think we should do something like this:
> > > > > > > > > 
> > > > > > > > > 1. Disable all enabled protocol adapters (reset them to defaults).
> > > > > > > > > 2. Clear all protocol adapter paths.
> > > > > > > > > 3. Issue DPR over all enabled USB4 ports.
> > > > > > > > > 
> > > > > > > > > BTW, what you mean "didn't work"?
> > > > > > > > Path activation would go fine after DPR like below:
> > > > > > > > 
> > > > > > > > [   15.090905] thunderbolt 0000:c4:00.5: 0:5 <-> 2:9 (PCI): activating
> > > > > > > > [   15.090932] thunderbolt 0000:c4:00.5: activating PCIe Down path from 0:5
> > > > > > > > to 2:9
> > > > > > > > [   15.091602] thunderbolt 0000:c4:00.5: activating PCIe Up path from 2:9 to
> > > > > > > > 0:5
> > > > > > > > 
> > > > > > > > But, PCIE enumeration doesn't happen (pcie link up will not happen, will not
> > > > > > > > see below logs)
> > > > > > > > [   15.134223] pcieport 0000:00:03.1: pciehp: Slot(0-1): Card present
> > > > > > > > [   15.134243] pcieport 0000:00:03.1: pciehp: Slot(0-1): Link Up
> > > > > > > Okay, what if you like reset the PCIe adapter config spaces back to the
> > > > > > > defaults? Just as an experiment.
> > > > > > If this turns out to be really complex then I guess it is better to do
> > > > > > it like you did originally using discovery but at least it would be nice
> > > > > > to see what the end result of this experiment looks like :)
> > > I feel it's better to go with discover and then reset for now (as v3).
> > > I'll keep this experiment as "to do" and will send out when I crack it down.
> I got what we were missing. It's not required to do a discover_tunnel before
> we tear down.
> 
> We were resetting the downstream port and do a "continue;"
> So, we were not cleaning up its path. Actually we have to cleanup its path
> after DPR.
> 
> After changing it, It works without any tunnel_discover() api's.

Makes sense, good finding.

