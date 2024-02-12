Return-Path: <linux-kernel+bounces-61800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 607148516B4
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 15:12:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CFF628126D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 14:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77C1E4E1C4;
	Mon, 12 Feb 2024 14:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n33n+3iX"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD934CE13;
	Mon, 12 Feb 2024 14:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707746659; cv=none; b=SHtS6L/RhRzNLMLL9RrxXB9PTJlX26tjPP+eyXVCiLODCrDdmWIsSpScccr92XZ5N7i+8/+DwQU5x2YO5z9E6+Oa6lTRqI9yR4HJUcDiu9quhP9o73td/pC1Z3gkdRrjZOQVQmtb/o0qMIH9WiikvJm05u6NiSZcfgzgHmrzruo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707746659; c=relaxed/simple;
	bh=kzWubUFjeWgniWqds5o3I9UShRuEGy8wlJtxZHCh1NY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kzin1R0z1tosMB2+awIWdXfAmdjaXvrzleLpATkyeP3r0GBby7boI4HTNzhaeWcYOfiHAZAZ0rNKEw/8hrpOhYqD4/qzjXVm2xZS1rM08ScN9jLaf4OzB5mFaVHza/cpipq8VE+QRKOre1H744K/s3Iukk63j599DDzXKvkYDw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n33n+3iX; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707746658; x=1739282658;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kzWubUFjeWgniWqds5o3I9UShRuEGy8wlJtxZHCh1NY=;
  b=n33n+3iXu6VdKe3eaXoKRu8ZhOKili5xDihavmmgWdCBdTxNxR/kyLAK
   DKuVDiXeabpZ/SYo/kWHWCtDKK/gfK7DL0asBRXluPMmOONPFyjaljy4b
   rHc1Wh8JAVLcoEw2TL1QpuwsIUrfW4pzgvmupiWobH9EaYBiyeOtY882T
   HLnarCBVwL4289OMEbHEdZPg2kVCXnwltLH5FkuwGxrWxIgIPDCIGdzcJ
   wyFAOTNws6tCTgO37pJbz6bQo/ZXUOWkxmWeKetI3tVZbHJ4DYzvZ/wxZ
   dEyQpsr2+e/H6UEqDqT/LEyKgOKNGtEFke3mPRWlZicO6BGWQ120gQG2D
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10981"; a="5536271"
X-IronPort-AV: E=Sophos;i="6.06,264,1705392000"; 
   d="scan'208";a="5536271"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 06:04:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10981"; a="911491167"
X-IronPort-AV: E=Sophos;i="6.06,264,1705392000"; 
   d="scan'208";a="911491167"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 06:04:12 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rZWun-00000003upH-2z5c;
	Mon, 12 Feb 2024 16:04:09 +0200
Date: Mon, 12 Feb 2024 16:04:09 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Ralf Schlatterbeck <rsc@runtux.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Miguel Ojeda <ojeda@kernel.org>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Robin van der Gracht <robin@protonic.nl>,
	Paul Burton <paulburton@kernel.org>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: auxdisplay: hit, hd44780: drop
 redundant GPIO node
Message-ID: <ZcolWdCeLf0nDPdY@smile.fi.intel.com>
References: <20240212083426.26757-1-krzysztof.kozlowski@linaro.org>
 <CAMuHMdU-c5_Z2AMNtNH4Cc4JUrn+oKU-1CumEOAP6=5Zomcj_A@mail.gmail.com>
 <2922eece-5486-4eff-af99-f7060cb61d17@linaro.org>
 <20240212115837.efz73yxinkysdmgh@runtux.com>
 <e2a5b005-7916-4296-b072-c24efd4b3357@linaro.org>
 <Zcogl6tqbMdQldKA@smile.fi.intel.com>
 <d603a588-d312-486e-b6c9-647a6b90580c@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d603a588-d312-486e-b6c9-647a6b90580c@linaro.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Feb 12, 2024 at 02:59:02PM +0100, Krzysztof Kozlowski wrote:
> On 12/02/2024 14:43, Andy Shevchenko wrote:
> > On Mon, Feb 12, 2024 at 02:38:27PM +0100, Krzysztof Kozlowski wrote:
> >> On 12/02/2024 12:58, Ralf Schlatterbeck wrote:

..

> >> Anyway, binding examples should not be collection of unrelated
> >> solutions, because then we should accept for each device schema several
> >> other variations and combinations.
> > 
> > Is this documented?
> 
> Yes, writing schema says what the example is. We repeated it multiple
> times on multiple reviews, we made multiple commits multiple times and I
> briefly mentioned it also in my talks.

Good to know, thanks!

-- 
With Best Regards,
Andy Shevchenko



