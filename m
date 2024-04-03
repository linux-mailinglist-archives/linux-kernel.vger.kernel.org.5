Return-Path: <linux-kernel+bounces-129863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C1F7897166
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 15:42:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F080A1F27C4C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 13:42:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C633F147C6C;
	Wed,  3 Apr 2024 13:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mKkkZdZ7"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CDAF1487CC;
	Wed,  3 Apr 2024 13:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712151708; cv=none; b=Y0DxoIT7G3BMUpuRdzSKcAkMdJr2kogh0lv3KgIt69lLNM6Ec51YODPmrJ/XEHfJ6QsBAN/bQwsAkjlQMQIGeLdABw5BXad9BTHJcyAvSSP8mLG1upp9+zw/FtTb/FxuZofM0sBRz3igu2amprD1omaj7uFTC3xgn8UEp5qpweE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712151708; c=relaxed/simple;
	bh=XHMsc/h/Nm772eO4vH1pvsQEGrFpRDZqz/OY/JDqP8w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dI35t118PG4hmVesXX8ZVH+Es2TWiEDlyaPepfAhZtkeoBcXMTDLNNESNuywM8wcQ24/SvoTbz8A1GLqn4fK1I3FxYGxQI8nCi0yw6z9boG2axMOM8uH//xPjRVMLdsdDasjfVePxfGZ4sMdcaUN7n4nlJ6m6qoS1B5eCeQiYhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mKkkZdZ7; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712151707; x=1743687707;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XHMsc/h/Nm772eO4vH1pvsQEGrFpRDZqz/OY/JDqP8w=;
  b=mKkkZdZ7Agd9uvtKU+NND0D+nlMUqvfSbsJx9S0GNqUkG3uarpadtXil
   EHtUrZAfoBsbzk9+IAgff7rruqOQoTJdU/aykbo3FVkUgQqXt11n55W6T
   nPtIix18kxIFEf4tUzAJj/Q3V9wDJJ2JtPeEhapn74q6U5bc+Zr5aG4p4
   BKKEKqJ9Nr7NdoI7FpyELQjQgdhJOFypeyo0CQP8ofmrmRKFIB5GKazji
   D2XtsohMqLE2jm1XLn/gBb62x4u+kqfn/qrNKJM+Mq0EnPsL5oVoycljQ
   UnAAyaH1C7PrFjNJWf8SXr+18tBWrlZVvOAj1Hh0wne+3qlzYgvxM0Rq8
   A==;
X-CSE-ConnectionGUID: 6rzmfy4URiumpcuqEWwdkw==
X-CSE-MsgGUID: 3MHezPpETKefc4GXAnTFww==
X-IronPort-AV: E=McAfee;i="6600,9927,11033"; a="7246709"
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; 
   d="scan'208";a="7246709"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2024 06:41:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11033"; a="915183828"
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; 
   d="scan'208";a="915183828"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2024 06:41:43 -0700
Received: from andy by smile with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rs0s0-000000018GC-47U5;
	Wed, 03 Apr 2024 16:41:40 +0300
Date: Wed, 3 Apr 2024 16:41:40 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Russell King <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>
Subject: Re: (subset) [PATCH v2 0/9] spi: pxa2xx: Drop linux/spi/pxa2xx_spi.h
Message-ID: <Zg1clCuOwkCNzSgy@smile.fi.intel.com>
References: <20240327193138.2385910-1-andriy.shevchenko@linux.intel.com>
 <171167575036.187521.17547262230962160149.b4-ty@kernel.org>
 <Zg04cWhT_Dl6AUik@smile.fi.intel.com>
 <b7ac20d0-ca45-4e65-92ff-ddf84da6645a@sirena.org.uk>
 <Zg1cAHEkhIf2vpwJ@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zg1cAHEkhIf2vpwJ@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Apr 03, 2024 at 04:39:13PM +0300, Andy Shevchenko wrote:
> On Wed, Apr 03, 2024 at 02:29:38PM +0100, Mark Brown wrote:
> > On Wed, Apr 03, 2024 at 02:07:29PM +0300, Andy Shevchenko wrote:
> > 
> > > Do I need to do anything else to get the rest applied?
> > 
> > All the concerns I have with swnodes just being a more complex and less
> > maintainable way of doing things still stand, I'm not clear that this is
> > making anything better.
> 
> As I explained before it's not less maintainable than device tree sources.
> The only difference is that we don't have validation tool for in-kernel
> tables. And I don't see why we need that. The data describes the platforms
> and in the very same way may come to the driver from elsewhere.
> How would you validate that? It the same as we trust firmware (boot loader)
> or not. If we don't than how should we do at all?
> 
> Can you point out what the exact aspect is most significant from C language
> perspective that we miss after conversion? Type checking? Something else?

Also note, after hiding the data structures from that file we open
the door for the much bigger cleanup, and I have patches already precooked
(need a bit of time to test, though).

-- 
With Best Regards,
Andy Shevchenko



