Return-Path: <linux-kernel+bounces-66868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC0598562DA
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 13:15:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B5C41C219DC
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 12:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A593112BF22;
	Thu, 15 Feb 2024 12:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZzlBc8bI"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5449013AF0;
	Thu, 15 Feb 2024 12:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707999304; cv=none; b=holwt3Si4cfS9/WC+N45B6AeydDVFbemCg1/j629njUAC2MqP4QZjp9bp6D1etMj9Xv8H0P7x/FACotxS8EImh/TrTzAYyZ4/Ev3W8B8CBDA+I2iSD8fClPTqgaCq0tSa00MEjvERU7U/ETZTXFXxNhG/FQyeWWJGF8epKhHXIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707999304; c=relaxed/simple;
	bh=XQ1aJyK1SAN1DcXYLdO2xjFBiObgzNsn7YIjybWgQz4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G36oG6nf8xJsGeL5OcVjKjbXnOAYoTN+2VCwlBjbAMkrW89XV3W1Xohs4FUfexlL2KpBbnXwqcAMJ0sWzZUlxfiLQX+ECylWJSyD18zt896Fmzg7a8CTiPYAb249IXeQ/77vgidIHcD4Buhlkq/Sikk/FJ2AMyVo6LuwhUiMp2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZzlBc8bI; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707999302; x=1739535302;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=XQ1aJyK1SAN1DcXYLdO2xjFBiObgzNsn7YIjybWgQz4=;
  b=ZzlBc8bIDFVEJHSipYQI0IQjzvQ+iVSfVKVnyEGc71nR05gcQr7alZes
   toHhrENv2rIzAfjKvbR9g3ddqeVWqkfSlrFaahogn2nJG3ly5qAbPWAmP
   M83Nr2eXpiUV78l8VgIcgvI0QNbhAek8DWACKBfSfYCsp4qp36Gsc79Uf
   5exdOCXCtcrr6EqbZTgI4Wq1ga6bTnMfVCHCv31LhZ78rDioPJL4lpoFM
   g5k0gO3x37hfXD6T/HEVFWZswjVmiXmkjK1xSIOrfWo0o0/99jAYD/zhQ
   VAAeqbNZJKlyLnmicqE7QIT40acpebh0QjYSqzvjrk/rXaXxrrO4WIXbp
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10984"; a="5049410"
X-IronPort-AV: E=Sophos;i="6.06,161,1705392000"; 
   d="scan'208";a="5049410"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2024 04:15:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10984"; a="912156489"
X-IronPort-AV: E=Sophos;i="6.06,161,1705392000"; 
   d="scan'208";a="912156489"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2024 04:14:59 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1raadk-00000004mh1-3guR;
	Thu, 15 Feb 2024 14:14:56 +0200
Date: Thu, 15 Feb 2024 14:14:56 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Robin van der Gracht <robin@protonic.nl>,
	Paul Burton <paulburton@kernel.org>
Subject: Re: [PATCH v2 09/15] auxdisplay: linedisp: Add support for
 overriding character mapping
Message-ID: <Zc4AQFIgRg7lBS-7@smile.fi.intel.com>
References: <20240212170423.2860895-1-andriy.shevchenko@linux.intel.com>
 <20240212170423.2860895-10-andriy.shevchenko@linux.intel.com>
 <CAMuHMdV3TOXc-_L5qG7D_XyFUcgNOyCoOwBhFPqNFBfAVyVydA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdV3TOXc-_L5qG7D_XyFUcgNOyCoOwBhFPqNFBfAVyVydA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Feb 15, 2024 at 11:36:47AM +0100, Geert Uytterhoeven wrote:
> On Mon, Feb 12, 2024 at 6:04 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:

..

> > +static const struct attribute_group linedisp_group = {
> > +       .is_visible     = linedisp_attr_is_visible,
> 
> Shouldn't that be .is_bin_visible?
> 
> > +       .attrs          = linedisp_attrs,
> 
> Likewise, .bin_attrs?
> But that is a pre-existing issue in the ht16k33 driver.

I was wondering myself, but we have no infrastructure for that
(there are no DEVICE_BIN_ATTR_*() helpers, nor bin_attr member
 in struct device attribute).

As you pointed out, it's preexisted issue and should be addressed
separately and not only in this driver.

> > +};
> > +__ATTRIBUTE_GROUPS(linedisp);

-- 
With Best Regards,
Andy Shevchenko



