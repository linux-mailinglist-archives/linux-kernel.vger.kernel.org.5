Return-Path: <linux-kernel+bounces-3743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08059817073
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 14:27:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F137B23E95
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 13:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 623715BFBF;
	Mon, 18 Dec 2023 13:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BpLOR7b7"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26280129EF6;
	Mon, 18 Dec 2023 13:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702905524; x=1734441524;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=/u5LGqruIqYB+yzW0Punt2bLuFOnz4Aw9zIFhQKw/x8=;
  b=BpLOR7b7798PuglGU6RLncb8RBz+didVEYza7WU/+/zC/9jY8rKzkxfJ
   i7MmqKpBKPtkOGiLwZDuXhjPyFjlM0x3PrqWeKP/fmgZl1tqGZdKfwmvE
   yc+GdLYOdYMpmnSsNEANnb4tEYJnro2Fy8QiUm29ATdiATu1ckbEzD1qT
   TjeZrOjCX516NnwChWbK6VIFbAN6/Tz9/ev2IzqmdHrJOYYlrORJi5ix7
   MeejvEhx7B8TSCJ+O8ecGnWJB9p6Bh1uvvUAOfs9Zz/QxRUOjh5xruNmA
   TT+RDRbeVSvJ+TyjIdVj7HZrPPpkzj1nur24nQwbe8/k9Q/dWYDTKWpSf
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10927"; a="394379613"
X-IronPort-AV: E=Sophos;i="6.04,285,1695711600"; 
   d="scan'208";a="394379613"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2023 05:18:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10927"; a="779092371"
X-IronPort-AV: E=Sophos;i="6.04,285,1695711600"; 
   d="scan'208";a="779092371"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 18 Dec 2023 05:18:41 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id 4696B387; Mon, 18 Dec 2023 15:18:40 +0200 (EET)
Date: Mon, 18 Dec 2023 15:18:40 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Sanath S <sanaths2@amd.com>
Cc: Sanath S <Sanath.S@amd.com>, mario.limonciello@amd.com,
	andreas.noever@gmail.com, michael.jamet@intel.com,
	YehezkelShB@gmail.com, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [Patch v2 2/2] thunderbolt: Teardown tunnels and reset
 downstream ports created by boot firmware
Message-ID: <20231218131840.GH1074920@black.fi.intel.com>
References: <ff143967-63ff-c4fb-9c88-8537a663c45b@amd.com>
 <20231215115521.GW1074920@black.fi.intel.com>
 <c7d174d3-028f-9ce4-7ef5-3e033c195159@amd.com>
 <20231215140224.GX1074920@black.fi.intel.com>
 <866cb714-b9a8-a7d4-4c59-6ba771ef325f@amd.com>
 <20231218104234.GB1074920@black.fi.intel.com>
 <c433f29b-597c-b6d6-aa48-2b84a26dc623@amd.com>
 <20231218113151.GC1074920@black.fi.intel.com>
 <20231218122312.GE1074920@black.fi.intel.com>
 <997f2a94-66d9-fb95-8f75-46d61937f7e8@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <997f2a94-66d9-fb95-8f75-46d61937f7e8@amd.com>

On Mon, Dec 18, 2023 at 06:35:13PM +0530, Sanath S wrote:
> 
> On 12/18/2023 5:53 PM, Mika Westerberg wrote:
> > On Mon, Dec 18, 2023 at 01:31:51PM +0200, Mika Westerberg wrote:
> > > On Mon, Dec 18, 2023 at 04:49:13PM +0530, Sanath S wrote:
> > > > > The discover part should not do anything (like write the hardware) so
> > > > > perhaps it is just some timing thing (but that's weird too).
> > > > > 
> > > > > I think we should do something like this:
> > > > > 
> > > > > 1. Disable all enabled protocol adapters (reset them to defaults).
> > > > > 2. Clear all protocol adapter paths.
> > > > > 3. Issue DPR over all enabled USB4 ports.
> > > > > 
> > > > > BTW, what you mean "didn't work"?
> > > > Path activation would go fine after DPR like below:
> > > > 
> > > > [   15.090905] thunderbolt 0000:c4:00.5: 0:5 <-> 2:9 (PCI): activating
> > > > [   15.090932] thunderbolt 0000:c4:00.5: activating PCIe Down path from 0:5
> > > > to 2:9
> > > > [   15.091602] thunderbolt 0000:c4:00.5: activating PCIe Up path from 2:9 to
> > > > 0:5
> > > > 
> > > > But, PCIE enumeration doesn't happen (pcie link up will not happen, will not
> > > > see below logs)
> > > > [   15.134223] pcieport 0000:00:03.1: pciehp: Slot(0-1): Card present
> > > > [   15.134243] pcieport 0000:00:03.1: pciehp: Slot(0-1): Link Up
> > > Okay, what if you like reset the PCIe adapter config spaces back to the
> > > defaults? Just as an experiment.
> > If this turns out to be really complex then I guess it is better to do
> > it like you did originally using discovery but at least it would be nice
> > to see what the end result of this experiment looks like :)
> 
> Yes, I'll give a try.
> As an experiment, I tried to compare the path deactivation that occurs at
> two place.
> 1. In tb_switch_reset where we are calling tb_path_deactivate_hop(port, i).
> 2. While we get a unplug event after doing DPR.
> 
> I observed both have different hop_index and port numbers.
> So, are we calling tb_path_deactivate_hop with wrong hop ids ?

Wrong adapters possibly.

> From deactivate tunnel (called while unplug) :
> [    3.408268] thunderbolt 0000:c4:00.5: deactivating PCIe Down path from
> 2:9 to 0:5
> [    3.408282] deactivate hop port = 9 hop_index=8
> [    3.408328] deactivate hop port = 2 hop_index=10

Definitely should be port = 5 (that's PCIe down in your log) and
hop_index = 8 (that's the one used with PCIe).

> Deactivate from tb_switch_reset() :
> deactivate hop port = 5 hop_index=8

Can you add some more logging and provide me the dmesg or
alternativively investigate it yourself. You can use tb_port_dbg() to
get the port numbers to the log.

