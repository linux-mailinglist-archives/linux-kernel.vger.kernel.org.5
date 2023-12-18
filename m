Return-Path: <linux-kernel+bounces-3433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CD9C816C2C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 12:32:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 373CC2844AB
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 11:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24C3D199DB;
	Mon, 18 Dec 2023 11:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L2fEUAA9"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF000199A0;
	Mon, 18 Dec 2023 11:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702899115; x=1734435115;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=4FhFbG0sBZc+TGV56La6V9iAQRv2TwSBI9ELI2O1vXQ=;
  b=L2fEUAA9A6GzIx53gFt2qaK3dt0Zk6IwcK51LxJSc7pR/RiY4PN7ef/n
   zXJ9dxNKE6pZwFyhSSfrXZq0IFvjBPzRGD9NXC4uGl3P4Chxya5rIwSNr
   d8DILMZCtBGVz7nl+XPusXk5+SrnpucNlTyU4KcoZjRZ1Qca25KT6GEHI
   3x1VOXNWsCnQi+Pw8vgJR9BRArvxisVKEKoeDsc/HdLvLfR93S/0EdvTP
   Y3uBt7Ac1wxDFFYY7w0DaM/qXg3x0lvxJWvT9s/Iw3O0QSjYGZ/GcCUqf
   UhUAq9fyP1YuD5UKdCLbKKiTIQV/X2wBrEbZo/B9a44lfLPt3WZCYbZ6M
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10927"; a="385916760"
X-IronPort-AV: E=Sophos;i="6.04,285,1695711600"; 
   d="scan'208";a="385916760"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2023 03:31:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10927"; a="775548374"
X-IronPort-AV: E=Sophos;i="6.04,285,1695711600"; 
   d="scan'208";a="775548374"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 18 Dec 2023 03:31:52 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id 5BF6938C; Mon, 18 Dec 2023 13:31:51 +0200 (EET)
Date: Mon, 18 Dec 2023 13:31:51 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Sanath S <sanaths2@amd.com>
Cc: Sanath S <Sanath.S@amd.com>, mario.limonciello@amd.com,
	andreas.noever@gmail.com, michael.jamet@intel.com,
	YehezkelShB@gmail.com, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [Patch v2 2/2] thunderbolt: Teardown tunnels and reset
 downstream ports created by boot firmware
Message-ID: <20231218113151.GC1074920@black.fi.intel.com>
References: <20231214070746.GS1074920@black.fi.intel.com>
 <32163f49-8387-0754-534f-1764e731f26d@amd.com>
 <20231214073242.GT1074920@black.fi.intel.com>
 <ff143967-63ff-c4fb-9c88-8537a663c45b@amd.com>
 <20231215115521.GW1074920@black.fi.intel.com>
 <c7d174d3-028f-9ce4-7ef5-3e033c195159@amd.com>
 <20231215140224.GX1074920@black.fi.intel.com>
 <866cb714-b9a8-a7d4-4c59-6ba771ef325f@amd.com>
 <20231218104234.GB1074920@black.fi.intel.com>
 <c433f29b-597c-b6d6-aa48-2b84a26dc623@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c433f29b-597c-b6d6-aa48-2b84a26dc623@amd.com>

On Mon, Dec 18, 2023 at 04:49:13PM +0530, Sanath S wrote:
> > The discover part should not do anything (like write the hardware) so
> > perhaps it is just some timing thing (but that's weird too).
> > 
> > I think we should do something like this:
> > 
> > 1. Disable all enabled protocol adapters (reset them to defaults).
> > 2. Clear all protocol adapter paths.
> > 3. Issue DPR over all enabled USB4 ports.
> > 
> > BTW, what you mean "didn't work"?
> Path activation would go fine after DPR like below:
> 
> [   15.090905] thunderbolt 0000:c4:00.5: 0:5 <-> 2:9 (PCI): activating
> [   15.090932] thunderbolt 0000:c4:00.5: activating PCIe Down path from 0:5
> to 2:9
> [   15.091602] thunderbolt 0000:c4:00.5: activating PCIe Up path from 2:9 to
> 0:5
> 
> But, PCIE enumeration doesn't happen (pcie link up will not happen, will not
> see below logs)
> [   15.134223] pcieport 0000:00:03.1: pciehp: Slot(0-1): Card present
> [   15.134243] pcieport 0000:00:03.1: pciehp: Slot(0-1): Link Up

Okay, what if you like reset the PCIe adapter config spaces back to the
defaults? Just as an experiment.

> > > > > > +			} else if (tb_port_is_usb3_down(port) ||
> > > > > > +				   tb_port_is_usb3_up(port)) {
> > > > > > +				tb_usb3_port_enable(port, false);
> > > > > > +			} else if (tb_port_is_dpin(port) ||
> > > > > > +				   tb_port_is_dpout(port)) {
> > > > > > +				tb_dp_port_enable(port, false);
> > > > > > +			} else if (tb_port_is_pcie_down(port) ||
> > > > > > +				   tb_port_is_pcie_up(port)) {
> > > > > > +				tb_pci_port_enable(port, false);
> > > Here, as per spec it would be better if we first teardown it for DOWN path
> > > and then the UP
> > > path.
> > Right makes sense.
> We never get up_port of protocol adapters here for reset. It's always
> down_port.
> So probably when we discover the path, we do path deactivation for both down
> and up ports.

If we are going to do DPR anyway, it should not matter.

