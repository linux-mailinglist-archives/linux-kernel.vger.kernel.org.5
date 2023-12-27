Return-Path: <linux-kernel+bounces-12191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DE5881F11E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 19:14:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D055E1C211BB
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 18:14:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8DFE4655B;
	Wed, 27 Dec 2023 18:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LXzx8ipy"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 994064653D;
	Wed, 27 Dec 2023 18:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703700873; x=1735236873;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=/qh2sd7G7vWu2XdpG1yELNyuBsKlxbirVHRumhnpcKE=;
  b=LXzx8ipy3KcJQEQ+gg1XJtpveTIA2dYSGUB6pSyplgcxPq+was7Gf1/a
   i/4GCeT2dCF5sRBwm2OqULI0ih43Nmpas49OMJ2MQZK6jBIjfTyQqzM7J
   S9AJSWWqRLYahjaZmEfmh7x2f2vE5n5+bhPfV+YNCwyxR4ZLzti2NW17u
   Aypy4lHTvEDwdf4D64QW5S+iyxw26+gZozfyHjA4F8ufrL0zgjykHhrGQ
   Tdy+IiP+u1aY2oSv7B5+mgb3+pOphEb+AZY5SL2hWG4YbE/uHSS40hgEC
   QsvUSOrwADVpFGJ21AlRTdh7EynD20N1fIgb+qfOPv91G8zVC9GIa5OmC
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10936"; a="15139926"
X-IronPort-AV: E=Sophos;i="6.04,309,1695711600"; 
   d="scan'208";a="15139926"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2023 10:14:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10936"; a="778298527"
X-IronPort-AV: E=Sophos;i="6.04,309,1695711600"; 
   d="scan'208";a="778298527"
Received: from hrmarapi-mobl1.ger.corp.intel.com ([10.249.35.233])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2023 10:14:30 -0800
Date: Wed, 27 Dec 2023 20:14:27 +0200 (EET)
From: =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: "David E. Box" <david.e.box@linux.intel.com>
cc: Hans de Goede <hdegoede@redhat.com>, rajvi.jingar@linux.intel.com, 
    platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/8] Intel PMC Core GBE LTR regression fix
In-Reply-To: <20231223032548.1680738-1-david.e.box@linux.intel.com>
Message-ID: <652cf483-6098-5e0-94ef-fdca344fa2ac@linux.intel.com>
References: <20231223032548.1680738-1-david.e.box@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 22 Dec 2023, David E. Box wrote:

> This patch series addresses the network performance regression caused by
> commit 804951203aa5 ("platform/x86:intel/pmc: Combine core_init() and
> core_configure()").
> 
> Unfortunately, the regression is included in the recent Lunar Lake and
> Arrow Lake support patches in the review branch. Patches 1 and 2 remove the
> LTR ignore without a fix. They may be folded into the respective enabling
> patches indicated in the changelog. This is done so that the next patches
> fixing the regression can be backported to stable kernels with fewer, if
> any, conflicts.
> 
> Patches 3 and 4 provide the support needed for Patch 5 to move the GBE LTR
> ignore from probe-time to suspend/resume time. All three carry the same
> Fixes tag so that the stable kernels can pick them up without causing a
> separate suspend-time PC10 regression.
>
> Patches 6 and 7 then add the LTR suspend/resume fix for Arrow Lake and
> Lunar Lake. Of course, they cannot be folded into the enabling patches
> unless the LTR fixes (3-5) are applied before. Sorry about this :(.

Wow, this is messy...

So the best order would be placing 3-5 before these Arrow Lake and Lunar 
Lake commits in for-next:
  119652b855e6 ("platform/x86/intel/pmc: Add Lunar Lake M support to intel_pmc_core driver")
  f34dcf397286 ("platform/x86/intel/pmc: Add Arrow Lake S support to intel_pmc_core driver")
? And then folding 1-2 and 6-7 into those respective commits?

It makes me wonder though why those two commits couldn't have been delayed 
slightly to get these fixes included first... :-/


-- 
 i.


