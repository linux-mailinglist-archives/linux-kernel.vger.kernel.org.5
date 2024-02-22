Return-Path: <linux-kernel+bounces-76580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 38A3F85F977
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 14:19:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E52412881A6
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 13:19:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A91B8131728;
	Thu, 22 Feb 2024 13:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y8STiMcz"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4CCD3F9ED;
	Thu, 22 Feb 2024 13:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708607961; cv=none; b=T3ObKvC/jT1M6lySN5GAO2fORGgBaW2dIr+Vy0RAbDUBQRYjXZBLMDMU018As3UW3cKleDUUhRO9TF8atX4virCWQHyBs/7C3pmlM7tmTbES/dHNb3Tth4cRB4kkpZhJJL/ZqDyVP16RqStA49O3MXFxbCeSq/012re/q7NzHj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708607961; c=relaxed/simple;
	bh=rM+QYYYxCsdPj+BR4nYWbptpIkJSRUn3xXx4ABpm30o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TXBKT3DSYfYp+3lvsYVbDG0tchiecjoP5Iac+p9sEXV6nKS0k8Zqx/G7vzenN50NcTXpKAskcUppGS57UCFg4DwDg/a4YFwPp8jEgJKqkmGSxih5Rwuw98QeGbbZUVF5zxpVsFqjjN+GNm7V49dz50Z/B6bCWgv20X6jSI+VHq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y8STiMcz; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708607960; x=1740143960;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rM+QYYYxCsdPj+BR4nYWbptpIkJSRUn3xXx4ABpm30o=;
  b=Y8STiMczR5yaQiHBIDmIkJGhxpf1E7BlcrXqKMZJpY69Ah6pbAiE4Q5w
   ELrOTRgAQ0iwr85AargjGkrIytOMyRbx0D9KCd9DKMA7CK+dm3BhxJ3iq
   Z2u1nctwHvlOMng2xMjF7GnrKocsUtN+5EYn5SB3JLOlpX04iPHXn2sfn
   xth1NWApx/F8Hm/bUE4rQiIcds9TJ1VpM19z1nno5ePOgsGfPOhKgs6MD
   C1DBsW5LsIevIueNvb1uaMC0os6RvEp/OEEr8LOXE5NpJEoQ8edPexlDM
   ic33zj+zDsBkZin4B4+bk+FbEjU+dy6FQ2z5+MQnWfyevL102PmEBL5UK
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10991"; a="25291521"
X-IronPort-AV: E=Sophos;i="6.06,177,1705392000"; 
   d="scan'208";a="25291521"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 05:19:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10991"; a="913522881"
X-IronPort-AV: E=Sophos;i="6.06,177,1705392000"; 
   d="scan'208";a="913522881"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 05:19:15 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rd8yl-00000006dTP-2xKh;
	Thu, 22 Feb 2024 15:19:11 +0200
Date: Thu, 22 Feb 2024 15:19:11 +0200
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
Subject: Re: [PATCH v3 RESEND 1/6] net: wan: Add support for QMC HDLC
Message-ID: <ZddJz9msz1ACmw_k@smile.fi.intel.com>
References: <20240212075646.19114-1-herve.codina@bootlin.com>
 <20240212075646.19114-2-herve.codina@bootlin.com>
 <ZcoNoDRF6h2C7TQd@smile.fi.intel.com>
 <20240222130516.5e139612@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240222130516.5e139612@bootlin.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Feb 22, 2024 at 01:05:16PM +0100, Herve Codina wrote:
> On Mon, 12 Feb 2024 14:22:56 +0200
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

..

> > > +#include <linux/dma-mapping.h>
> > > +#include <linux/hdlc.h>
> > > +#include <linux/module.h>  
> > 
> > > +#include <linux/of.h>
> > > +#include <linux/of_platform.h>  
> > 
> > I do not see how these are being used, am I right?
> > What's is missing OTOH is the mod_devicetable.h.
> 
> Agree for removing of.h and of_platform.h.
> 
> Why do I need mod_devicetable.h ?
> Isn't including module.h enough ?

In that header the definitions of many of ID table data structures are located.
You are using that in the code.

-- 
With Best Regards,
Andy Shevchenko



