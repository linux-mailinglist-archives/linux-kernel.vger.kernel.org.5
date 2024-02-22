Return-Path: <linux-kernel+bounces-76817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6643D85FD07
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 16:51:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 957011C21FDD
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 15:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78B38150992;
	Thu, 22 Feb 2024 15:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W0t8+K8m"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6287C14E2FC;
	Thu, 22 Feb 2024 15:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708617051; cv=none; b=Dz6+UBDwVVz3GEXbrYBk6mV1pzM8yIEzP5Tl96OILzxvPfIeO9jrGLwUUJnaOvbxVMRACDABF8JHQ7nhJ9DnVpuKr1Wl6tBftNof5Lz09laNF0E4s+7hqPWT/JLTpkyb1pAVyBGAPYdp72OeusMgRdgG1mimZHzh+yb2tMw/F64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708617051; c=relaxed/simple;
	bh=LtZSACAXUNjJ5/i2hJMB9PJg2gM46nS3S99u+jVf0ok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tIi6Cz+czohovj6r4zdbFVl+1cNBpwyTEAvVzCzDNpTMj2q+xWT3AMEi5xdFV04HPIhQHXiDTh0fMVBBtWY3omriOr2PMUOPSFHkDYcaV2/wwKzkH9WNkv3e9gfydKbLYQsZdGPtSAqrpTLrk9LRfKSPfXcUTv8PB8yRgOmqYms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W0t8+K8m; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708617050; x=1740153050;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LtZSACAXUNjJ5/i2hJMB9PJg2gM46nS3S99u+jVf0ok=;
  b=W0t8+K8mYsKIqVSRjD1+Uiu6r3sFwBryHd0MpbKS/oBhMwwIA7XOM/Xp
   V1qxa1yT1vJsgDHT0XcTjQrhEYTsBX0hkgnQKzoI0crgssRjoOEOTkDyz
   h0DzkMBsv8ud0lpLj+eGzPNSUWTFz4vzHAaKzNKujgY+/pP1ZFBVCZNwe
   AYb3CxD3JvZ+YW54b0qwLDJ0V+BU0PesJdR1PiqsDbvSe3jvuRmMgc9TI
   lRok1yYYGQOTm5ZCDmFAByvtffZciZ9z34NHrJfgL/OIgRqSo4tekMEiy
   oO+P9Gor0qInbPA/GntVM8eHkKML8gQok+FvEW9qKUxNJ2+C//w2kD9jL
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10992"; a="13551092"
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="13551092"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 07:50:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10992"; a="827566298"
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="827566298"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 07:50:44 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rdBLN-00000006fVD-0oAA;
	Thu, 22 Feb 2024 17:50:41 +0200
Date: Thu, 22 Feb 2024 17:50:40 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Herve Codina <herve.codina@bootlin.com>
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, Andrew Lunn <andrew@lunn.ch>,
	Mark Brown <broonie@kernel.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v4 0/5] Add support for QMC HDLC
Message-ID: <ZddtUJqer3zLGc-B@smile.fi.intel.com>
References: <20240222142219.441767-1-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240222142219.441767-1-herve.codina@bootlin.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Feb 22, 2024 at 03:22:13PM +0100, Herve Codina wrote:
> Hi,
> 
> This series introduces the QMC HDLC support.
> 
> Patches were previously sent as part of a full feature series and were
> previously reviewed in that context:
> "Add support for QMC HDLC, framer infrastructure and PEF2256 framer" [1]
> 
> In order to ease the merge, the full feature series has been split and
> needed parts were merged in v6.8-rc1:
>  - "Prepare the PowerQUICC QMC and TSA for the HDLC QMC driver" [2]
>  - "Add support for framer infrastructure and PEF2256 framer" [3]
> 
> This series contains patches related to the QMC HDLC part (QMC HDLC
> driver):
>  - Introduce the QMC HDLC driver (patches 1 and 2)
>  - Add timeslots change support in QMC HDLC (patch 3)
>  - Add framer support as a framer consumer in QMC HDLC (patch 4)
> 
> Compare to the original full feature series, a modification was done on
> patch 3 in order to use a coherent prefix in the commit title.
> 
> I kept the patches unsquashed as they were previously sent and reviewed.
> Of course, I can squash them if needed.
> 
> Compared to the previous iteration:
>   https://lore.kernel.org/linux-kernel/20240212075646.19114-1-herve.codina@bootlin.com/
> this v4 series mainly:

From my point of view after addressing the few non-critical issues
the v4 will be final. Thank you!

-- 
With Best Regards,
Andy Shevchenko



