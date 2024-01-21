Return-Path: <linux-kernel+bounces-32071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 276E7835602
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 14:55:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DD341F230C2
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 13:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05CD1376EF;
	Sun, 21 Jan 2024 13:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cTwLYzVw"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 086DB376ED;
	Sun, 21 Jan 2024 13:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705845311; cv=none; b=lrznMciRsAvLP9UEa/tD0xbWbRwLobB5tNaEQBUgu0etsfC+0WVKB0I3VaJ5U/sXhzox+vsPHO0PB6YKnEMWmb5yrOuAbnBYpqAlW8OfUsFIEchWRxZzaS5kXHiCEoNGxTmIDrKiutri7dVF/15GMn4dewCfSiGfzVDsqKCkB/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705845311; c=relaxed/simple;
	bh=xWyyPY/pPgSdMwCy46smjWIZscigOBsBxLXygB6GUA0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e4Lp2Mav7NSMivGpAqvfE8W2CTEVkewCqgG8dLzDyMdMfBL0JAXNP484Dj0hDZDOknXPKeVg8wJD5gCaXqvRoY1RBkahrDOIV4l3ClBhBgN99IOufSlQMZLuSGs2W81DP8ZsE1hpP8FKHgLbTjNDjez4fDjwl6MZHIIxjVtue/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cTwLYzVw; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705845310; x=1737381310;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xWyyPY/pPgSdMwCy46smjWIZscigOBsBxLXygB6GUA0=;
  b=cTwLYzVw0YptuNnSgO8ioyGxTBj+YXJuQnwID7ZYAEj0pkabpgguHxbP
   VOhQ2eCpTW413EHKG2wkdi0deSNZzDmu7boG3MPtfCjuaNIk+iirfF0Fe
   JfnA+dZgpvfrXuXl2yAY8vc1zQcM1lcNkhjF0D4i2ZFJqlgp0vwOgWMZX
   BLv1izo0aoS3rsT01YYsSeQSTThuN93paeqGTk0H1gj1Gk18LwA3J+dLA
   583Hx+jzF7wUlLLi8iW0lsDzQeK2QhQR63LsfG4sts2pEBzt7TV+25ytJ
   JbDQCssPld5VQ7Ygg6UEfyUDm2a6hzusGW4dsH+ObglMR+WQX1Szk7xw8
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10960"; a="7708832"
X-IronPort-AV: E=Sophos;i="6.05,209,1701158400"; 
   d="scan'208";a="7708832"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2024 05:55:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10960"; a="785447801"
X-IronPort-AV: E=Sophos;i="6.05,209,1701158400"; 
   d="scan'208";a="785447801"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2024 05:55:07 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rRYBB-0000000Fum7-1edI;
	Sun, 21 Jan 2024 15:48:05 +0200
Date: Sun, 21 Jan 2024 15:48:05 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Javier Martinez Canillas <javierm@redhat.com>
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Jingoo Han <jingoohan1@gmail.com>,
	Daniel Thompson <daniel.thompson@linaro.org>,
	Lee Jones <lee@kernel.org>, Helge Deller <deller@gmx.de>
Subject: Re: [PATCH v1 1/4] backlight: hx8357: Make use of device properties
Message-ID: <Za0glbPfzeTjdZjn@smile.fi.intel.com>
References: <20240114152759.1040563-1-andriy.shevchenko@linux.intel.com>
 <20240114152759.1040563-2-andriy.shevchenko@linux.intel.com>
 <87bk9novmp.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87bk9novmp.fsf@minerva.mail-host-address-is-not-set>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Jan 15, 2024 at 09:20:46AM +0100, Javier Martinez Canillas wrote:
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:

..

> > +typedef int (*hx8357_init)(struct lcd_device *);
> 
> This kind of typedef usage is frowned upon in the Linux coding style [0]
> (per my understanding at least) and indeed in my opinion it makes harder
> to grep.
> 
> [0] https://www.kernel.org/doc/Documentation/process/coding-style.rst

Thanks for pointing this out. However, this piece does _not_ clarify typedef:s
for function pointers which I personally find a good to have.

..

> > -	ret = ((int (*)(struct lcd_device *))match->data)(lcdev);
> 
> This is what I mean, before it was clear what was stored in match->data.
> But after you changes, what is returned by the device_get_match_data()
> function is opaque and you need to look at the typedef hx8357_init to
> figure that out.

The above is so ugly in my opinion, that justifies using typedef:s even
if you are quite skeptical about them.

..

> No strong opinion though and I see other drivers doing the same (but no
> other driver in drivers/video/backlight).
> 
> Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

Thank you for the review!

-- 
With Best Regards,
Andy Shevchenko



