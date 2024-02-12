Return-Path: <linux-kernel+bounces-61826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2596B85170E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 15:32:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFF752831D5
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 14:32:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82E4C3A8EB;
	Mon, 12 Feb 2024 14:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AYdgzBft"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE75FC16;
	Mon, 12 Feb 2024 14:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707748317; cv=none; b=GSKXJvQup/zOSWctbq7jPkEC3o1HWgyo11v9TYyZ11tXy6C+dVkamYzF6lzANgf5Sf4lJQ5WIzhxn/B1btrnH55ioCY4phls58418bK8D0y+ijytGTqHZMnFj45WhJiizURhMhZHezBWflFD/byv0tmSFaVshHIh6XRLfG4K/jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707748317; c=relaxed/simple;
	bh=3JKFf0dcMk7JwnUdDXS61uJeYNwcS3K7/8lxDPV9RgE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oeS2BSZWVoM/Ei0zqE5jBwtybW5wQOGVdI0sxb4ElrtZd+GOS+m+Qh3UJDPleLFDm9TmY2ktJcEvFsNGjVJln8vsglI35FyZAd6xOIeMUaRxnBcqLAmTUJdmFL1aHCJgDVZ1F0JYZJ4Tfyhwt+Q3UZMHnlUyh7ijs9+U6Kw0sTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AYdgzBft; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707748317; x=1739284317;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3JKFf0dcMk7JwnUdDXS61uJeYNwcS3K7/8lxDPV9RgE=;
  b=AYdgzBftByJ9b3K/t/7JXfNkdatGGyVw1sIZM1siuQDWHb3pydei2Nfn
   LnFaH7pUqe4E//WodbSEnBxDaxpUvcSUMGc8Diu8UwBsxXUzpqNi8fhMP
   VuE5IDgnum4RmAuU70ux9/Y8zWD6Xnw3BmFLSwksUuRmbzu3VK1okc6lk
   wqpc9+RBfziIUQa75+AXB8XIJMTYRUSj6U0V4uPjlOh51260b0vsemfad
   IOA7H5nquR1BQ0BIcel6iIHGs3TKfHrzRYDPEMPz9EfF0Mkrz/cqWnOxU
   VRSS0jesQUwhDUXOzXrV0Onz5QrkjRKdH1bYyImhdrwqtae8aEu2+5JNG
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10981"; a="12814863"
X-IronPort-AV: E=Sophos;i="6.06,264,1705392000"; 
   d="scan'208";a="12814863"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 06:31:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10981"; a="911497299"
X-IronPort-AV: E=Sophos;i="6.06,264,1705392000"; 
   d="scan'208";a="911497299"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 06:31:52 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rZXLZ-00000003vFt-1yfL;
	Mon, 12 Feb 2024 16:31:49 +0200
Date: Mon, 12 Feb 2024 16:31:49 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Miguel Ojeda <ojeda@kernel.org>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Robin van der Gracht <robin@protonic.nl>,
	Paul Burton <paulburton@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: auxdisplay: hit,hd44780: drop redundant
 GPIO node
Message-ID: <Zcor1RYVMh3-V-wL@smile.fi.intel.com>
References: <20240212083426.26757-1-krzysztof.kozlowski@linaro.org>
 <ZcofhWb8stiddmru@smile.fi.intel.com>
 <906db6a6-48ba-41e5-be23-1dea0ecf96ee@linaro.org>
 <Zcomjp9oH9VfO3NA@smile.fi.intel.com>
 <b836cf9d-dc71-4835-b45f-1092aafa1dfd@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b836cf9d-dc71-4835-b45f-1092aafa1dfd@linaro.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Feb 12, 2024 at 03:20:26PM +0100, Krzysztof Kozlowski wrote:
> On 12/02/2024 15:09, Andy Shevchenko wrote:
> > On Mon, Feb 12, 2024 at 02:56:43PM +0100, Krzysztof Kozlowski wrote:
> >> On 12/02/2024 14:39, Andy Shevchenko wrote:
> >>> On Mon, Feb 12, 2024 at 09:34:24AM +0100, Krzysztof Kozlowski wrote:

..

> >>>> -    i2c {
> >>>> -            #address-cells = <1>;
> >>>> -            #size-cells = <0>;
> >>>>  
> >>>> -            pcf8574: pcf8574@27 {
> >>>> -                    compatible = "nxp,pcf8574";
> >>>> -                    reg = <0x27>;
> >>>> -                    gpio-controller;
> >>>> -                    #gpio-cells = <2>;
> >>>> -            };
> >>>> -    };
> >>>
> >>> In patch 3 you updated the lines that have lost their sense due to this one.
> >>
> >> How did they lose it?
> > 
> > Now they are referring to the non-existed node in the example. OTOH, there is
> > already hc595 case...
> 
> All of the bindings examples do it. It's expected.
> 
> > 
> > The Q here (as you pointed out that it's better to name nodes in generic way),
> > how these names are okay with the schema (hc595, pcf8574) as being referred to?
> 
> They are not OK, although I don't see the name "hc595". There is phandle
> to the hc595 label, but that's fine. Not a node name.

Ah, okay, so it's a semantic difference. Thank you for your patience and elaboration!

-- 
With Best Regards,
Andy Shevchenko



