Return-Path: <linux-kernel+bounces-82015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DE72867DD0
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 18:15:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE127B2AD27
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 17:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6394C134CE9;
	Mon, 26 Feb 2024 17:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g3tzPsg/"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE4812CDAE;
	Mon, 26 Feb 2024 17:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708966993; cv=none; b=HH3lCU0GG05JtttK0FMn+yV8FT6VpO/rl60mSRYglwl4UTdVHf7xk3dTR8hPOM/Zb3bNjQ/Sxft+4dWIohDJtzrMoVJ7f2Np2MgyBt9J0gRDbbtDlKyIYhL+fm8yOu3FLkkxTc2dni8FJ499KTt676CczyPMLeonTEj8YOaN2OQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708966993; c=relaxed/simple;
	bh=NUzHR+U4SYb2lE4JHpxCjO2+K8X+/FKb4mt4Sicx7s0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mIRv7JdH/1A/bRtlUvLObFv8guvh2rUyOy0hdXw8zAh3+chfO4jC5TU1VKTx3r8cP83wy2C601/dCDQ7XrCawMVzU4rda2sN4jWAbbPDiREk6b3ie39N/yUkEWeMyEGEP6xK56SVEn5OxljvHR16XNKRH6VdMUmkZuuzOPHoCZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g3tzPsg/; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708966992; x=1740502992;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=NUzHR+U4SYb2lE4JHpxCjO2+K8X+/FKb4mt4Sicx7s0=;
  b=g3tzPsg//Pg+Pza2arRbxD+ppjDi0Vbz95htOS6LezOASQm0UkgRIvpP
   NOH5k03/lScFkFXsZ2nDgEwFR8OJh1xBV4bHbtHp6sF9HyWg45Cqb0XS1
   q/Qk0JOkqC3WCi+WSp5tH9iynxe9/wxqUQxIBaP3D4tJNYf9g0LtZD6F9
   IzC4kOoxnXOTWojqzdT7nGC2OsnqhoFkqhZVA6076NTQ+Qj7mPPYsKhuC
   yLn5AGs+PNB9uzZZfMKRxkcNdbUOFlhCqUoGdxZNi0vjOKpWUByHvRVy1
   LOb843Q5cw6rVhXIqAYVUx7VJ0h8kObqOVWidzaDqVTm4Jwp1V6TO8u8h
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="13905714"
X-IronPort-AV: E=Sophos;i="6.06,186,1705392000"; 
   d="scan'208";a="13905714"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 09:03:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="913882086"
X-IronPort-AV: E=Sophos;i="6.06,186,1705392000"; 
   d="scan'208";a="913882086"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 09:03:08 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1reeNe-00000007k6Q-0DB5;
	Mon, 26 Feb 2024 19:03:06 +0200
Date: Mon, 26 Feb 2024 19:03:05 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Robin van der Gracht <robin@protonic.nl>,
	Paul Burton <paulburton@kernel.org>
Subject: Re: [PATCH v3 8/9] dt-bindings: auxdisplay: Add Maxim MAX6958/6959
Message-ID: <ZdzESR_sELGcHsi7@smile.fi.intel.com>
References: <20240219170337.2161754-1-andriy.shevchenko@linux.intel.com>
 <20240219170337.2161754-9-andriy.shevchenko@linux.intel.com>
 <CAMuHMdVjh3jofcf2SdjRO5bAfokEzjoxv_z89JJyyfwwt5DZsw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdVjh3jofcf2SdjRO5bAfokEzjoxv_z89JJyyfwwt5DZsw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Feb 26, 2024 at 04:52:34PM +0100, Geert Uytterhoeven wrote:
> On Mon, Feb 19, 2024 at 6:03 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:

..

> To handle cases where less than 4 characters are wired
> (based on hit,hd44780.yaml):
> 
>     display-width-chars:
>       description: Width of the display, in character cells.
>       minimum: 1
>       maximum: 4
>       default: 4

As discussed in the patch 9 this seems to be a material for other update.

> The rest LGTM, so
> Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

I'll take this tag when applying the patch. Tell me if it's not the case.
Thank you!

-- 
With Best Regards,
Andy Shevchenko



