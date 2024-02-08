Return-Path: <linux-kernel+bounces-58424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D023A84E657
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 18:11:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F7C41C20BE5
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 17:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9D681272A2;
	Thu,  8 Feb 2024 17:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CDAB24FY"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0E0486AE5;
	Thu,  8 Feb 2024 17:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707412130; cv=none; b=VCY2bSLoQ5BRlcvydXb0hK61Z1ZyUwDslQUAeRAB+fZo6vsbx9vfwnnvfk3H9ucswVhsVhHUPAwzAGSgLSjArS+XUMtQtp6LkOBtUYeIQSEEt5BV+I5sAODc3U+jTDpAbuTvPH8FltimQJ1SR/sgkg4L449q/e5mjr7tIxE1PhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707412130; c=relaxed/simple;
	bh=a0k4or3WYh5JsmiTSA5UkW0JwcVYQd963OTJEqpPdiI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M6v584PA4lJGESg0JSXxbPlhtD6WmBdgQtpMhxJgAwrtULr+vq/hTy3ADR5mWdhcDoDo5craOOWDIO7NXtJ25EA2WCY8Kt05KQlQ3ggyT5hy4+/DmrMYWWFygTdAg6UZXUjz2KhOAV72Eq370qRhmnzPXB6ylclm2rOtAjt4o4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CDAB24FY; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707412129; x=1738948129;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=a0k4or3WYh5JsmiTSA5UkW0JwcVYQd963OTJEqpPdiI=;
  b=CDAB24FYwul0ymCqlBlkC/qbyhTKg859nH4ogxLvRFtxsSv1hudEZzmK
   io2vfmUyVBuE7ge7VoFyjwI6l4tjY5f43G9i80mT4+rwViOsvZ921HRrL
   PlJRfgjii3r2rQZemhwQNgqvMzGjGfoYlM84Dw8DNEHmT/fJl9PN24hr+
   6Yb1sReGQ0Js8CfbqRJ0yLx4F4HyAs0CijbBx+XAC1hKVZYAr0+bSsNVp
   a06y4lP6amc9Sm1lwXeDryZ3CLRqpMcQsnTsmSlxThKegq/FkiAETz627
   x7kfyWx4CJM0uJqbxNfwAHOfFkekA/LCG+j+TIEJR1iP0+PG7NcOPUEgg
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="11838404"
X-IronPort-AV: E=Sophos;i="6.05,254,1701158400"; 
   d="scan'208";a="11838404"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 09:08:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="910427477"
X-IronPort-AV: E=Sophos;i="6.05,254,1701158400"; 
   d="scan'208";a="910427477"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 09:08:45 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rY7tC-00000002vpU-3OYe;
	Thu, 08 Feb 2024 19:08:42 +0200
Date: Thu, 8 Feb 2024 19:08:42 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Lee Jones <lee@kernel.org>
Cc: Daniel Thompson <daniel.thompson@linaro.org>,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Jingoo Han <jingoohan1@gmail.com>,
	Helge Deller <deller@gmx.de>
Subject: Re: [PATCH v2 0/4] backlight: hx8357: Clean up and make
 OF-independent
Message-ID: <ZcUKmlbtyktnKhLr@smile.fi.intel.com>
References: <20240201144951.294215-1-andriy.shevchenko@linux.intel.com>
 <20240208105304.GI689448@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240208105304.GI689448@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Feb 08, 2024 at 10:53:04AM +0000, Lee Jones wrote:
> On Thu, 01 Feb 2024, Andy Shevchenko wrote:

..

> Someone may wish to address this:
> 
> WARNING: DT compatible string "himax,hx8369" appears un-documented -- check ./Documentation/devicetree/bindings/
> #58: FILE: drivers/video/backlight/hx8357.c:636:
> +		.compatible = "himax,hx8369",

I can do it if and when have more time. But apparently it was before this
series, right?

-- 
With Best Regards,
Andy Shevchenko



