Return-Path: <linux-kernel+bounces-75492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 02D8E85E97A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 22:06:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC1101F229BA
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 21:06:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F8B386AD5;
	Wed, 21 Feb 2024 21:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GOvFXS1v"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AE813A1DB
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 21:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708549577; cv=none; b=jnDPcFLyRcB80QqPKZBY9BhYhu2rMHWEbi7ZBWjgEOkIc8LbuuUB401nKUDl01e14HQz5VKco5IsIRJgtqdpoAR+1OwLeXXrlXK7RuELZV3/08oKrX4fTpA/D83xodmIvVmkUSwMsdOg/fnulWO9i67OcqSVx2g8kB5CSLugTmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708549577; c=relaxed/simple;
	bh=KyMlo79JRas7N/ePSvTBhDPap36fYD1RTOI3K+oksGc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q0u/KS0dbPxReslLbE3x2Q9fGrkiPuT03yBj4zAMUN2QCJvJs+lEkGw7qv6uOY8d0iQzuANo7yUJ9Eqq9r49KrxYRilfI8dZGHxboVRaIw0iwvXJirgDVoaQYMpFAVLPw8WGFMxMuGXzCupzNkMDkGj3Bl+ZySaEMxRz8SpaI14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GOvFXS1v; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708549576; x=1740085576;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KyMlo79JRas7N/ePSvTBhDPap36fYD1RTOI3K+oksGc=;
  b=GOvFXS1vWCGLlSfj8dqzR1j3GiQRnxhsmamHxNCWMPI4kFpS3OSdIbcS
   VOHXbjbWElPWDP+tGs7HY8TLVrc+KBnKO3vgKERYUrvUjdNQvaxiVVQX7
   d4ol840NRyzt+2xlbPClcx7qQXn3i7WkD0elQdRmDKnCeLG4TIDeCQ6LP
   OMM1Y04QH8b89X082rmnqmSQ7doyTNtk2EjvyzCEcAQV16Zs7sKuQD6IJ
   +IpI97S3vQnjUXZ2hsMLe22ZgXrmy26BqDHJkGYyepB0gPDlc0Vifnn0o
   U+MYCsUkjN2BNbDD1+IIrcETQ/JFvi9HvPkbd8mogd2EtMRQKrM4PDLVy
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10991"; a="13297098"
X-IronPort-AV: E=Sophos;i="6.06,176,1705392000"; 
   d="scan'208";a="13297098"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2024 13:06:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10991"; a="913373035"
X-IronPort-AV: E=Sophos;i="6.06,176,1705392000"; 
   d="scan'208";a="913373035"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2024 13:06:13 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rctn8-00000006TBi-1Pa3;
	Wed, 21 Feb 2024 23:06:10 +0200
Date: Wed, 21 Feb 2024 23:06:09 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Lucas De Marchi <lucas.demarchi@intel.com>,
	Yury Norov <yury.norov@gmail.com>, linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	Jani Nikula <jani.nikula@linux.intel.com>,
	intel-xe@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
	Jani Nikula <jani.nikula@intel.com>
Subject: Re: [PATCH v3 1/3] bits: introduce fixed-type genmasks
Message-ID: <ZdZlwWbYlReLEqRU@smile.fi.intel.com>
References: <20240208074521.577076-1-lucas.demarchi@intel.com>
 <20240208074521.577076-2-lucas.demarchi@intel.com>
 <CAA8EJpprfrtOjNzT6TFhV1n6MXzLdTahanfxcRW4uVjeHaBduA@mail.gmail.com>
 <CAA8EJpo3X5Ljdf5w8pj+WPQZaqab4mD53VXdAxfLFqsU4mNoPQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA8EJpo3X5Ljdf5w8pj+WPQZaqab4mD53VXdAxfLFqsU4mNoPQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Feb 21, 2024 at 10:37:30PM +0200, Dmitry Baryshkov wrote:
> On Wed, 21 Feb 2024 at 22:30, Dmitry Baryshkov
> <dmitry.baryshkov@linaro.org> wrote:

..

> Excuse me, it seems a c&p from gitlab didn't work as expected.

No problem, it's clear that the patch has not been properly tested and
obviously wrong. Has to be dropped. If somebody wants that, it will
be material for v6.10 cycle.

-- 
With Best Regards,
Andy Shevchenko



