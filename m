Return-Path: <linux-kernel+bounces-161917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DECB8B533F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 10:37:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2A161F21033
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 08:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BC1418041;
	Mon, 29 Apr 2024 08:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e9AcN+Hn"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A7313AEE;
	Mon, 29 Apr 2024 08:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714379827; cv=none; b=Uf1si5tNAEipY4f/OkqkRZknhZKDGZoqDgQvh7UoViL6/m+nVeNCJiNZj99TetU3PcWUSOcHZ7w6eeBOjTmBXTK3EBwZUKj0oEmcHBbghLtmeQspYywr622522lPwLLuq7juaR8G9/ZimA4KEwDBZgkIdIi7/8CGF/k01tjm0sI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714379827; c=relaxed/simple;
	bh=N0XGSmeKMB0rC6XgAkwwB5iWclud4yL7qhYZt2jHTvQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tma936htwrJoE8xlq7fznk9wlIUNijE9dRfarUtMe0mpjzgrhyyqjXYHXT7PYXQ0YBsxDeEQUwcezZk2IWNiY2Yw7vaCtxBFMETEckz6sR2iWbItdsYgRl4Txyj85W0kEClTJ+VeQd6B+rvfJR0/eJerROzg/se3VXztRf+cta4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e9AcN+Hn; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714379827; x=1745915827;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=N0XGSmeKMB0rC6XgAkwwB5iWclud4yL7qhYZt2jHTvQ=;
  b=e9AcN+Hn2DjM0mEP+NA75hoffKqpeMIt0dBBxBh8UihXlkJBJbfQokl5
   /X9G6GePX6QhNuxLaFituewmHEYN/TPoWtnPIIGADh24uHf8j1mqPIvF2
   maDOFZnFjoUCZgO2aGAzo3J8IBBRobr90PQjw6x3mnrbwjfMdSiPLPzpG
   yUZaFAg4vK569yORikkNCeygEmYpN3Yd1uEN3LcuMTIij08t0ZNsF7X7z
   Yl00pne10DvTgO+umOc7RwLoYja6f12xY4EtoAc8f+4Uqs9VNGn/NZ1Wl
   XBHOr3a+3JuHXGqedIi4J2TnXQAKxWDDlE3xZTiIhQIMRs+S/lwVET5M6
   g==;
X-CSE-ConnectionGUID: B2CSXVzSQayDBXPD4vtZqw==
X-CSE-MsgGUID: ASQU3e3LScmv7evgcUGCCQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11057"; a="21439663"
X-IronPort-AV: E=Sophos;i="6.07,239,1708416000"; 
   d="scan'208";a="21439663"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2024 01:37:06 -0700
X-CSE-ConnectionGUID: mhLrSkThTdOTHTLvEDDe+A==
X-CSE-MsgGUID: UUrw3BNuT/iOCT+pl66gNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,239,1708416000"; 
   d="scan'208";a="26117627"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2024 01:37:04 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1s1MVR-00000002Fzg-3ehE;
	Mon, 29 Apr 2024 11:37:01 +0300
Date: Mon, 29 Apr 2024 11:37:01 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>,
	Martijn Braam <martijn@brixit.nl>
Subject: Re: [PATCH v1 1/1] iio: light: stk3310: Drop most likely fake ACPI ID
Message-ID: <Zi9cLbf6JdomA8jW@smile.fi.intel.com>
References: <20240415141852.853490-1-andriy.shevchenko@linux.intel.com>
 <20240420122633.79b4185b@jic23-huawei>
 <ZiZEN807oywU-MAx@smile.fi.intel.com>
 <ZiZEqDCqc01Cx3oq@smile.fi.intel.com>
 <20240428164333.44a7f8f3@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240428164333.44a7f8f3@jic23-huawei>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Sun, Apr 28, 2024 at 04:43:33PM +0100, Jonathan Cameron wrote:
> On Mon, 22 Apr 2024 14:06:16 +0300
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > On Mon, Apr 22, 2024 at 02:04:23PM +0300, Andy Shevchenko wrote:

..

> > P.S>  
> > What I may agree on is to drop Fixes tag.
> > 
> That's a compromise I'm fine with. As long as we've done due diligence on
> whether there are known cases we can take the risk of breaking someone (briefly)
> if these turn out to be in use.

I'll try to remember not putting Fixes in similar patches in the future,
if any.

> Applied,

Thank you!

-- 
With Best Regards,
Andy Shevchenko



