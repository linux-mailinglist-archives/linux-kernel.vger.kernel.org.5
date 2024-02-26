Return-Path: <linux-kernel+bounces-81885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A5403867B8F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 17:17:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4524C1F269E6
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 16:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69F1512C55B;
	Mon, 26 Feb 2024 16:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CI8sybhw"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D9951D531;
	Mon, 26 Feb 2024 16:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708964254; cv=none; b=Z5kldy+lCodJi4WsEmA2w9b3j8Dc3wlrVM/lpxROFVbvdWwFyPFGJOy6VXfxFgjE27xizzSfR0VNxxSYOHRPhftuc5MXnkMvoQ2RTq1OUSnkmjkjwCOIrSkbG5fPgo1xODdGnGjVU/5VMywdBMlaK5fNepj96eFvlzaxVr8F47Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708964254; c=relaxed/simple;
	bh=kL7LUNB8fATmqEvONvO/82NaFVfnKvx48g056TlSyro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bof3YUEGuaN6HEpKqIg28zDbBDA02ZhhPJh07EHXI8oICG7rz2GXpukur1fq8Nw3jxPdrPVKLEGYwhXNgXqLQxcbbAgDzynp2SKVRj6vXagHVzGbWpifrZZ0/V1qN+hrVIRom4N0UewgOjAvLqN3oQwBjVWgLxMKCHAMlWp/umA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CI8sybhw; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708964253; x=1740500253;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=kL7LUNB8fATmqEvONvO/82NaFVfnKvx48g056TlSyro=;
  b=CI8sybhw7h0PxMW09zqSMrvgRfPV46ORsL/2+5U5Ol9FDDK1tx7sHQ+V
   NdyIXSRBPZdgsXnpbX7yjX1mBulCW428ZvapBs4bvVYtPoGIw+nUn3tFf
   q7YCE0Yk7LDT7LlxIOn4I/uhi9EQ21p880qkbx6iMW42oF6Xd8Tzz87lH
   EhPUrwDkXeea6X5Gz4MBqnSxkimKl7WzJFLkMnNypKaH5IFe1pJrL0gB4
   uWD+vVyRnKpTrEFXw6uCSWCS5WM9wEPQzQPeEzgcNZk5j3UkOJ1pKn2Wf
   aEhZnCi0shyxmd1BHaWJv6x1X2xCZ7mZE7Wlg4+bURCG0zBqEMvS51u7U
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="3182520"
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="3182520"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 08:17:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="913880217"
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="913880217"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 08:17:27 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1redfR-00000007jJy-0pXI;
	Mon, 26 Feb 2024 18:17:25 +0200
Date: Mon, 26 Feb 2024 18:17:24 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Robin van der Gracht <robin@protonic.nl>,
	Paul Burton <paulburton@kernel.org>
Subject: Re: [PATCH v3 9/9] auxdisplay: Add driver for MAX695x 7-segment LED
 controllers
Message-ID: <Zdy5lDOBrQ9XFCpm@smile.fi.intel.com>
References: <20240219170337.2161754-1-andriy.shevchenko@linux.intel.com>
 <20240219170337.2161754-10-andriy.shevchenko@linux.intel.com>
 <CAMuHMdWpepH0P8g9dPfq1rsZRJsvOnoZ7VnjqTL9nkSGtKFpYQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdWpepH0P8g9dPfq1rsZRJsvOnoZ7VnjqTL9nkSGtKFpYQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Feb 26, 2024 at 05:01:46PM +0100, Geert Uytterhoeven wrote:
> On Mon, Feb 19, 2024 at 6:03 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > Add initial driver for the MAX6958 and MAX6959 7-segment LED
> > controllers.

> LGTM, so
> Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

Thanks, but see below.

..

> > +       u8 buf[4];
> > +
> > +       /* Map segments according to datasheet */
> > +       buf[0] = bitrev8(map_to_seg7(&map->map.seg7, *s++)) >> 1;
> > +       buf[1] = bitrev8(map_to_seg7(&map->map.seg7, *s++)) >> 1;
> > +       buf[2] = bitrev8(map_to_seg7(&map->map.seg7, *s++)) >> 1;
> > +       buf[3] = bitrev8(map_to_seg7(&map->map.seg7, *s++)) >> 1;
> 
> for (unsigned int i = 0; i < linedisp->num_chars; i++) { ... }
> 
> > +
> > +       regmap_bulk_write(priv->regmap, REG_DIGIT(0), buf, ARRAY_SIZE(buf));
> 
> linedisp->num_chars

Maybe, but then we probably want to synchronize the 4 there and here as we
can't have VLA on stack.

> > +}

..

> > +       ret = linedisp_register(&priv->linedisp, dev, 4, &max6959_linedisp_ops);
> 
> + device_property_read_u32(dev, "display-width-chars", ...) handling.

Not sure it should be part of this series.

-- 
With Best Regards,
Andy Shevchenko



