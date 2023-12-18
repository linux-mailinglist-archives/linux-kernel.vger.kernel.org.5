Return-Path: <linux-kernel+bounces-3564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A594816DE3
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 13:23:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE86B1F22761
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 12:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D90214B12D;
	Mon, 18 Dec 2023 12:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Lq8cBDxh"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC023481AB;
	Mon, 18 Dec 2023 12:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702902196; x=1734438196;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=N7eUeKAMzm2gBFL7HvjuwqCenf2l5Dhwml6Vay6Fgy0=;
  b=Lq8cBDxhJ8qwdWwYGtJ7oP9LqJix2nvkkhGwYQSFdJUOzQpUhkXEzK5l
   ZbnoomT55iKSQDmloGu6JWgGkNiDLHvUlIsOZu4rZ3NdzCH9eg9DWKWTo
   yi6LGgU8qQ6jHt/pTySdfFVMaE44uVmUm75ihpib58x4oyhG2EH7P91o/
   /wc/9rhabMcSMzk9D709TpeRfZCFoBovpOe/VGL8irf0xbp3PBD6Qgcqa
   Lf7LCiDaduYd1ZP6HBxjCF91s8osRduDu1vsY91zJuKKibycOuGCTF8Uk
   C7Oc+HiiRFfpoJIda4GPrMi8bqpZ5Dibs2hI9DyjtzhV1GoeQE3iMIa+1
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10927"; a="8859487"
X-IronPort-AV: E=Sophos;i="6.04,285,1695711600"; 
   d="scan'208";a="8859487"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2023 04:23:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10927"; a="768822020"
X-IronPort-AV: E=Sophos;i="6.04,285,1695711600"; 
   d="scan'208";a="768822020"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 18 Dec 2023 04:23:13 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id 5FB543CC; Mon, 18 Dec 2023 14:23:12 +0200 (EET)
Date: Mon, 18 Dec 2023 14:23:12 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Sanath S <sanaths2@amd.com>
Cc: Sanath S <Sanath.S@amd.com>, mario.limonciello@amd.com,
	andreas.noever@gmail.com, michael.jamet@intel.com,
	YehezkelShB@gmail.com, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [Patch v2 2/2] thunderbolt: Teardown tunnels and reset
 downstream ports created by boot firmware
Message-ID: <20231218122312.GE1074920@black.fi.intel.com>
References: <32163f49-8387-0754-534f-1764e731f26d@amd.com>
 <20231214073242.GT1074920@black.fi.intel.com>
 <ff143967-63ff-c4fb-9c88-8537a663c45b@amd.com>
 <20231215115521.GW1074920@black.fi.intel.com>
 <c7d174d3-028f-9ce4-7ef5-3e033c195159@amd.com>
 <20231215140224.GX1074920@black.fi.intel.com>
 <866cb714-b9a8-a7d4-4c59-6ba771ef325f@amd.com>
 <20231218104234.GB1074920@black.fi.intel.com>
 <c433f29b-597c-b6d6-aa48-2b84a26dc623@amd.com>
 <20231218113151.GC1074920@black.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231218113151.GC1074920@black.fi.intel.com>

On Mon, Dec 18, 2023 at 01:31:51PM +0200, Mika Westerberg wrote:
> On Mon, Dec 18, 2023 at 04:49:13PM +0530, Sanath S wrote:
> > > The discover part should not do anything (like write the hardware) so
> > > perhaps it is just some timing thing (but that's weird too).
> > > 
> > > I think we should do something like this:
> > > 
> > > 1. Disable all enabled protocol adapters (reset them to defaults).
> > > 2. Clear all protocol adapter paths.
> > > 3. Issue DPR over all enabled USB4 ports.
> > > 
> > > BTW, what you mean "didn't work"?
> > Path activation would go fine after DPR like below:
> > 
> > [   15.090905] thunderbolt 0000:c4:00.5: 0:5 <-> 2:9 (PCI): activating
> > [   15.090932] thunderbolt 0000:c4:00.5: activating PCIe Down path from 0:5
> > to 2:9
> > [   15.091602] thunderbolt 0000:c4:00.5: activating PCIe Up path from 2:9 to
> > 0:5
> > 
> > But, PCIE enumeration doesn't happen (pcie link up will not happen, will not
> > see below logs)
> > [   15.134223] pcieport 0000:00:03.1: pciehp: Slot(0-1): Card present
> > [   15.134243] pcieport 0000:00:03.1: pciehp: Slot(0-1): Link Up
> 
> Okay, what if you like reset the PCIe adapter config spaces back to the
> defaults? Just as an experiment.

If this turns out to be really complex then I guess it is better to do
it like you did originally using discovery but at least it would be nice
to see what the end result of this experiment looks like :)

