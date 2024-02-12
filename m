Return-Path: <linux-kernel+bounces-62008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B8578519FE
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 17:50:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FB261F23B54
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 16:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEC5F3D3A5;
	Mon, 12 Feb 2024 16:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OE69wcFO"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A68AF3B2A4;
	Mon, 12 Feb 2024 16:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707756604; cv=none; b=B4wJG5vayR6ttssx4MPF/qbTMK2/Ev0ygztdGZwi4ko0k8dbrF80quEttarf2xqo+EuV+DmMbsjLoACsJFQaynUzAycSNpDeyUvGoFbLOrMRi/g1gRdkXHTu/u+wD9Le3cjnm36cN4mN5BxVDcBommsXEq5b9eQ54XMUIGAbBio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707756604; c=relaxed/simple;
	bh=qRmyrxFlXjewttj2hOMa7Rcn2XH4DDnyFrEFrynkY/s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ydaf5E2P3Gwxql1hIUcWtmpTaEPWFZOzk+GNu+vFbKXRzwpTZeXYkk7Xfoe4DBcB9GPPAw1AtkIqwbO2NfhrKQyGA3gYEPuW3fB3KDTiAb74foGXNKH45tvNBLT/Ixddt9ibLc09xAn0ekIQkrAjYYBoYFNa3T+3UlV7OAU48vE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OE69wcFO; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707756603; x=1739292603;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qRmyrxFlXjewttj2hOMa7Rcn2XH4DDnyFrEFrynkY/s=;
  b=OE69wcFOJBo6XTd5ibxtHwakQzHUgC4SFSASkMk5cW3RYIUIlce+2jBp
   MacGD0KLsR/ETy7LkIhwNgGNkTn6lBmxW7lz+3H3dGnXikXN633LvNzwH
   v/pYRrBmEEQrdnbrsKv7hH2EYq9QapipWS4tVcq4GDhr8PQyd9yIb2S4a
   3q7KcdQ/tQu0rF6izGrrdhcG+RCwcgJLCl7gCzg4yL9R66onb1YMhSKhq
   iYVx6EQrM5ZBs+uOX6tgOY/0BeQXUtuyeZcffVp0h3fj041rL1xVNMDoq
   SqOuIGwj9Qu6P67aCTzRd0RR4bppAGu12iXKSGCSKFTh5tCHf8F6EQRDk
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="19247654"
X-IronPort-AV: E=Sophos;i="6.06,264,1705392000"; 
   d="scan'208";a="19247654"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 08:49:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="911540822"
X-IronPort-AV: E=Sophos;i="6.06,264,1705392000"; 
   d="scan'208";a="911540822"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 08:49:50 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rZZV7-00000003x6Q-1DTH;
	Mon, 12 Feb 2024 18:49:49 +0200
Date: Mon, 12 Feb 2024 18:49:49 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Robin van der Gracht <robin@protonic.nl>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Miguel Ojeda <ojeda@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Burton <paulburton@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: [PATCH v1 10/15] auxdisplay: linedisp: Provide a small buffer in
 the struct linedisp
Message-ID: <ZcpMLXTfc95fGTae@smile.fi.intel.com>
References: <20240208184919.2224986-1-andriy.shevchenko@linux.intel.com>
 <20240208184919.2224986-11-andriy.shevchenko@linux.intel.com>
 <20240212092500.62f006cc@ERD993>
 <ZcoF9ZxPBkVS_6Da@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZcoF9ZxPBkVS_6Da@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Feb 12, 2024 at 01:50:13PM +0200, Andy Shevchenko wrote:
> On Mon, Feb 12, 2024 at 09:25:00AM +0100, Robin van der Gracht wrote:
> > On Thu,  8 Feb 2024 20:48:08 +0200
> > Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> 
> > > +	linedisp->num_chars = buf ? num_chars : min(num_chars, LINEDISP_DEFAULT_BUF_SZ);
> > 
> > It's not a big buffer, but now it's always there even if it's not used.
> > And even if it's used, it might be only partially used.
> > Why not used a malloc instead?
> 
> malloc() infra takes more than this IIRC (something like up to 32 bytes on
> 64-bit platforms) or comparable sizes. Yes, the malloc() along with the
> linedisp structure might make sense, but will require more invasive change.
> 
> Do you want me to drop this one from the set?
> (I have no hard feelings about it, as I see better way and just having no
>  time for taking care about, as it's not the main point of the series.)

Looking again into it, the allocation separately with linedisp structure
is indeed too much invasive. I prefer (as we save lines of code and deduplicate
the buffer at least for two drivers, including a new one) to leave this patch
for now. We may rework it later on. Do you agree?

-- 
With Best Regards,
Andy Shevchenko



