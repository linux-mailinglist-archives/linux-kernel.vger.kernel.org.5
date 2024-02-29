Return-Path: <linux-kernel+bounces-86789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22BC086CACE
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 14:58:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54D5F1C22679
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 13:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50C4E12CD89;
	Thu, 29 Feb 2024 13:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TLx3OGs4"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D42C28627D;
	Thu, 29 Feb 2024 13:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709215096; cv=none; b=P5H2/1EBjWKqsAyQ8XuNxSYP+IFUdq0MmomCVLLjzsi9JZdZeZz0iqyChKrrKfTAMPa3cRMjonV3p4FideKjjsdWvX5uAZUzvxGF3+QQJ2TKpBMK03ROik9tahWqCBDX3swgVi617/qFPn4qoq4mtCa6GVJ0Y5aFSMRWfCuXCPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709215096; c=relaxed/simple;
	bh=vsDRj1lrlW5nFpY8MoqEfXKmAZAXlZ0hsF8p7PHkdVo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VShZoL1PU/qgSxUzJyyQ6UwZqFxNPWPC6ZOaE4Wi01ILsiPcxF0oa6XS04uBb9zoPdA3SeM1PXTdoaeOTXfkK5/W2b1vRg1RbxYwOsC1BL3gv3ic5vlWHnwBpklfBzsfofG6zMPOnRDTqF7bFX+s4E5bYOXXuyr1xUBbH2Mq1l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TLx3OGs4; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709215095; x=1740751095;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vsDRj1lrlW5nFpY8MoqEfXKmAZAXlZ0hsF8p7PHkdVo=;
  b=TLx3OGs4rVhzZE98g+7DGJLyop8KUYxlLJjjX9Rechg8G5OeEfytoRjN
   zzgYWFkCCmScaf47dcWF2rt9WKMeCkJ3Zmrq/Q55MEd6GQUsxtvCSjGcF
   hmfSuAW5MydXFNPN/X3n+Oj+4Z8+OtJ5mZeOv/zF+MTZJD95S1qp3qv72
   HbVEnyfZZN72OoVe30pUtQ94CtZebcNhozNBzVFlmpEAiqG36UcbjKDqn
   zCCv3ttRtSKfin5FR603TLZY6DPXXl1KS8t/h4XNWn1Mj6HwC7I37Cfdb
   iIfBzk2JZzdlBi/XomNElN6f5ViUOex7Z+wkoB89FLHI5zpOABI3ap6Z8
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="14836176"
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="14836176"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Feb 2024 05:58:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="913982739"
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="913982739"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Feb 2024 05:58:10 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rfgvG-00000008gYy-3Yqf;
	Thu, 29 Feb 2024 15:58:06 +0200
Date: Thu, 29 Feb 2024 15:58:06 +0200
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
Subject: Re: [PATCH v4 5/5] net: wan: fsl_qmc_hdlc: Add framer support
Message-ID: <ZeCNboCslYgT8tjb@smile.fi.intel.com>
References: <20240222142219.441767-1-herve.codina@bootlin.com>
 <20240222142219.441767-6-herve.codina@bootlin.com>
 <ZddtFG4bvCX-lsn3@smile.fi.intel.com>
 <20240229135605.6454052f@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240229135605.6454052f@bootlin.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Feb 29, 2024 at 01:56:05PM +0100, Herve Codina wrote:
> On Thu, 22 Feb 2024 17:49:40 +0200
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > On Thu, Feb 22, 2024 at 03:22:18PM +0100, Herve Codina wrote:

..

> I've got an issue with guard(spinlock_irqsave).

No, you got an issue with sparse.

> I have the following warning (make C=1):
> drivers/net/wan/fsl_qmc_hdlc.c:49:12: warning: context imbalance in 'qmc_hdlc_framer_set_carrier' - wrong count at exit
> 
> I also tried to call guard(spinlock_irqsave) before 'if (!qmc_hdlc->framer)'
> but it does not change anything.
> 
> Did I miss something in the guard(spinlock_irqsave) usage ?

You may ignore that for now. Not your problem, no problem in the code.

https://lore.kernel.org/linux-sparse/8d596a06-9f25-4d9f-8282-deb2d03a6b0a@moroto.mountain/

-- 
With Best Regards,
Andy Shevchenko



