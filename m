Return-Path: <linux-kernel+bounces-119300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4603388C6CF
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 16:25:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 779D11C63AC4
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 15:25:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 896B113C834;
	Tue, 26 Mar 2024 15:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fBOye8oL"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B0F913C824
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 15:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711466720; cv=none; b=U6PyyN7ZDeA6opyHDJM2Dmcb67vCifM6seZ8nDTiYVCrUJxmYH+g8IJ01XWbDmv9pEVhYi/1DG+b6tG7MVlmt1psixKlIrlqgCubp/6s/u3T6SSCxfpUohGT9O2pDoQK6ZkbgpzGgHPqC6bmEcDab85ZoBqtXce6ONac+8ETXy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711466720; c=relaxed/simple;
	bh=XttMrvgAYZMCP1U+O9bqXvByUWIjb6AitS7lpjeSNn4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AIaBMXhfV3jTVnlBMqf6MrFOzSpW8LV1o38rxDUGNW56cTCVlyiBsTktRAvULTaGVDocyeYCmA3LiIW4ckwmWuPyEI/Ci+NTbv/gX2xyrLiuoOjaL/sN1vxqbXqTDSamyEDoEK0lwHuuGwfAyvWJquUHJxFukN/jZLfg4yrmJCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fBOye8oL; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711466719; x=1743002719;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=XttMrvgAYZMCP1U+O9bqXvByUWIjb6AitS7lpjeSNn4=;
  b=fBOye8oLM5VQsYppG4jwZbCEw9teFbHnm3QEfBnbq9sqwNeqM70NoRet
   Dj82nc/fesfYUVWkPNdM/anAS4adnCRXJ0fWfb17wOc+EH7dYs5kAHLbo
   KHSr7TDnVlhbwmXEblN7jwb6J5sanPKOe3u22uD3T4cCbllqoTMDNFdjQ
   2L33Zbr1aQOI1lfq5B5050pwlIk0+Brtc3ZGhykkvGWvk2C4nytABMKJL
   i3UC1K46s32CMlU8/PRdL0GZGJ3J4C868dEPtGUWhBbhnjoai2SSKkCv1
   pV/NarUtnjHAbQqPsnp9T/wb5Z6SLmuyYGJWj76ossqZC2WHvdrwl1vAA
   w==;
X-CSE-ConnectionGUID: 7GcbCTtmQGy+K24bTMSXew==
X-CSE-MsgGUID: 0xHE1OecQKGwBR1Ju/XnCQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="6420087"
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="6420087"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 08:25:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="914883234"
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="914883234"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 08:25:17 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rp8fr-0000000GL3K-0VmZ;
	Tue, 26 Mar 2024 17:25:15 +0200
Date: Tue, 26 Mar 2024 17:25:14 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mateusz K <mateusz.kaduk@gmail.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Lee Jones <lee@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] mfd: intel-lpss: Switch over to MSI interrupts
Message-ID: <ZgLo2sbncwlkAOZE@smile.fi.intel.com>
References: <20240312165905.1764507-1-andriy.shevchenko@linux.intel.com>
 <20240325211915.GA1449994@bhelgaas>
 <CAPf=4Rc2vQrWqcs=-ND3iOZFJyKE7FdPoqU9w6DKjoSaJo6KaQ@mail.gmail.com>
 <ZgLefFQanbq-ozKM@smile.fi.intel.com>
 <CAPf=4Rdc6pHy34dSKex_KOmeAo2bsuaGv5X6MyJ6+Se5h3Mo4w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPf=4Rdc6pHy34dSKex_KOmeAo2bsuaGv5X6MyJ6+Se5h3Mo4w@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

Please, do not top post in the mailing lists!

On Tue, Mar 26, 2024 at 03:50:37PM +0100, Mateusz K wrote:
> Maybe it's much to ask, but I would really appreciate it if someone
> looked into intel-lpss supporting these devices.
> Been using a laptop without a functional touchpad over months now.
> If that helps, there is another thread here
> https://bugzilla.kernel.org/show_bug.cgi?id=218444 with perhaps more
> details on the problem.
> Battery and speaker are not a big deal, but the not working touchpad,
> which I believe should be handled by an intel-lpss driver, is kind of
> painful.
> If you need any help from my side, testing patches, don't hesitate to
> contact me.

I will look at the report closer, but I can't guarantee anything.

> On Tue, Mar 26, 2024 at 3:41 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > On Tue, Mar 26, 2024 at 11:06:38AM +0100, Mateusz K wrote:
> > > I tried the patch that changes PCI_IRQ_LEGACY into PCI_IRQ_ALL_TYPES
> > > and it seems I get some other error now
> > >
> > > [    1.477341] intel-lpss 0000:00:15.0: enabling device (0004 -> 0006)
> > > [    1.477466] intel-lpss 0000:00:15.0: can't derive routing for PCI INT A
> > > [    1.477468] intel-lpss 0000:00:15.0: PCI INT A: not connected
> > > [    1.477488] intel-lpss 0000:00:15.0: probe with driver intel-lpss
> > > failed with error -2147483648
> > > [    1.489572] intel-lpss 0000:00:15.2: enabling device (0004 -> 0006)
> > > [    1.489688] intel-lpss 0000:00:15.2: can't derive routing for PCI INT C
> > > [    1.489689] intel-lpss 0000:00:15.2: PCI INT C: not connected
> > > [    1.489715] intel-lpss 0000:00:15.2: probe with driver intel-lpss
> > > failed with error -2147483648
> > > [    1.501886] intel-lpss 0000:00:19.0: enabling device (0004 -> 0006)
> > > [    1.502034] intel-lpss 0000:00:19.0: can't derive routing for PCI INT A
> > > [    1.502036] intel-lpss 0000:00:19.0: PCI INT A: not connected
> > > [    1.502067] intel-lpss 0000:00:19.0: probe with driver intel-lpss
> > > failed with error -2147483648
> > > [    1.514288] intel-lpss 0000:00:19.1: enabling device (0004 -> 0006)
> > > [    1.514535] intel-lpss 0000:00:19.1: can't derive routing for PCI INT B
> > > [    1.514538] intel-lpss 0000:00:19.1: PCI INT B: not connected
> > > [    1.514570] intel-lpss 0000:00:19.1: probe with driver intel-lpss
> > > failed with error -2147483648
> > > [    1.526291] intel-lpss 0000:00:1e.0: enabling device (0004 -> 0006)
> > > [    1.526555] intel-lpss 0000:00:1e.0: can't derive routing for PCI INT A
> > > [    1.526557] intel-lpss 0000:00:1e.0: PCI INT A: not connected
> > > [    1.526604] intel-lpss 0000:00:1e.0: probe with driver intel-lpss
> > > failed with error -2147483648
> > > [    1.538130] intel-lpss 0000:00:1e.3: enabling device (0004 -> 0006)
> > > [    1.538233] intel-lpss 0000:00:1e.3: can't derive routing for PCI INT D
> > > [    1.538235] intel-lpss 0000:00:1e.3: PCI INT D: not connected
> > > [    1.538253] intel-lpss 0000:00:1e.3: probe with driver intel-lpss
> > > failed with error -2147483648
> >
> > Hmm... I have a unique board to test :-)
> > Let's revert it then.
> >
> > Bjorn, in such case your tree should keep conversion one.
> >
> > Lee, do you prefer a revert or can you simply drop this from the queue?

-- 
With Best Regards,
Andy Shevchenko



