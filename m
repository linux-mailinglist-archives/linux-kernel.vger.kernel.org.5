Return-Path: <linux-kernel+bounces-86918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0974A86CCCC
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 16:23:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B6D01C21F92
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 15:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6EAA1474A8;
	Thu, 29 Feb 2024 15:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WsOx2Z2e"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD0513DB9B;
	Thu, 29 Feb 2024 15:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709220222; cv=none; b=IohCkPYQ1tCVJEp4by9TEuaM1qDb2xuXpaR0WlrEwTqpM7LgWmqj+7q/OaFRVR0ELmBhzVMurFVqcNQnxjNQ8qqJEdmST2WeOKjIL/7lDlB43GrUcw/oPXUlNmDjj0rWYbWlSWVuzmDO84ZTShnGemLu9Ky9tdhRFUT9b3HDEWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709220222; c=relaxed/simple;
	bh=0sy2ZSHMsNmRgHSSClE033djjcb7leBzhQfmozV+T4E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sbdd+jEjaOxGENX1DmdIZPfJslAfXpzOGO0OpG7QZiXSmAg+qLMJd7Tq5GAUkG63NzVpJg2UtMZN8vZNsgXlO1GT/VHFF84vLuHLfiUr+LiLFvemgYE44drGnNCRuGAo0nsNeOfHaWgahjTQHaE91QC+4H/HvZeCG4wOQiB3Da0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WsOx2Z2e; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709220221; x=1740756221;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0sy2ZSHMsNmRgHSSClE033djjcb7leBzhQfmozV+T4E=;
  b=WsOx2Z2eWrcNWUr1Er1dYyW7tllSx2h4L90WGpZNHUe95AZiGWXgUog0
   w7njIb3MA0L35QsF7D9I5HssvT6aHQhRUJkkuy6cTAXcmZ1mKhIVGTDL8
   OEN549wvKTL4xdw8vrKb7BwK48kg9T0HfK7FAkl8QLeCjgOH/Ad2XM0G6
   fwwphN353286tq5ml8fY8T37hdkOnhTkrh/n0XW/JI5ws4CUDvliD+QL0
   Rr+fL6h6xDLLsBavD92jxooZmArF4r9+lA5+umoGZZHBiQycQ36gMgm+x
   xQGmjzUlhElnVXlHUUsucNLpgYLHai5SDjAI8HHtt0wI1Jq38xUsifkBl
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10999"; a="3575056"
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="3575056"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Feb 2024 07:23:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10999"; a="913984426"
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="913984426"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Feb 2024 07:23:36 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rfiFw-00000008hib-27Mq;
	Thu, 29 Feb 2024 17:23:32 +0200
Date: Thu, 29 Feb 2024 17:23:32 +0200
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
Subject: Re: [PATCH v5 0/5] Add support for QMC HDLC
Message-ID: <ZeChdAsAhrC8a75t@smile.fi.intel.com>
References: <20240229141554.836867-1-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240229141554.836867-1-herve.codina@bootlin.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Feb 29, 2024 at 03:15:48PM +0100, Herve Codina wrote:
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

I think it's a good series and next version will be final. The only question is
possible use of the returned values from bitmap_scatter()/bitmap_gather(), the
rest are minors.

Feel free to add
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
to patches 4 and 5.

-- 
With Best Regards,
Andy Shevchenko



