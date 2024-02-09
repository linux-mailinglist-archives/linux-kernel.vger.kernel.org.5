Return-Path: <linux-kernel+bounces-59398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2366584F654
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 14:59:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFD4D283B23
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 13:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02C204CB28;
	Fri,  9 Feb 2024 13:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WgggZU4q"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA82447F59;
	Fri,  9 Feb 2024 13:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707487153; cv=none; b=R5iMnrF9s6/8bBMmHhVK97WDXfvMAhI3YJyP91LWssTioot/lVj0+ivC9fPYAgBY4wP+ezJ8TfqfqrGMmTrTCrCjCSiqU41CrWYhISn2crouXQQ1gTh7hoTQmo9DEAmVwHjk6DNa0UXllLwBTt5oREjR/d8tZOsWFYHinvDC80s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707487153; c=relaxed/simple;
	bh=Tfk3gkxi23N79ZvpnMrQxEz7UN3b3W0KhHbPWAA4WAA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NNE3Y7EIdG1hyUV/qHfEMSNZWXdFLtjw+XfEsrCSdc/PHpHYn5xk21dPgRvp4DuXTrqSgXfZjpGbq5PBiGIPYBhbpmM8Fz7m9I+LlcHLvdrbcfLilEmTjAMact54w4+ea9bvbqg9RVVKvP5yqE2a6eFkeuKQPzZqjChp0nmPnvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WgggZU4q; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707487152; x=1739023152;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Tfk3gkxi23N79ZvpnMrQxEz7UN3b3W0KhHbPWAA4WAA=;
  b=WgggZU4qxATW0g7pyCR5LKRy+DPAPaPqq4Ii27DmnskCob393O1icTpx
   /w4xldTuu5bfEe+KDabfkds7Tvfy9V997D1805uBRx65v4dTEjkZaLStY
   5guTuWwTdVlsG85yGZho+lvSejt5+7uHenf2WMsoQ7hFvgF6KRSZcUkvd
   aLuay9Qy7VE40wgVw8LrQjBE2z56T4/d4wkFBobU9L3NNflI/+5QU1rFw
   +bczYmMVV2dJyBwwMBpggPkIIunD9MQWwaT6kZhwVuTIb9WBFVr9mz9EQ
   V51zbLEsBqrALlf6q3w8qbcvhCmtOA1WOVPTNDDMlyeN70Fj0dCPmS2/b
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="23910722"
X-IronPort-AV: E=Sophos;i="6.05,257,1701158400"; 
   d="scan'208";a="23910722"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2024 05:59:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="910715450"
X-IronPort-AV: E=Sophos;i="6.05,257,1701158400"; 
   d="scan'208";a="910715450"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2024 05:59:08 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rYRPG-00000003AJ6-02jg;
	Fri, 09 Feb 2024 15:59:06 +0200
Date: Fri, 9 Feb 2024 15:59:05 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Miguel Ojeda <ojeda@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Robin van der Gracht <robin@protonic.nl>,
	Paul Burton <paulburton@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: [PATCH v1 14/15] dt-bindings: auxdisplay: Add Maxim MAX6958/6959
Message-ID: <ZcYvqW9Q1OI3AK4g@smile.fi.intel.com>
References: <20240208184919.2224986-1-andriy.shevchenko@linux.intel.com>
 <20240208184919.2224986-15-andriy.shevchenko@linux.intel.com>
 <55b4a973-653c-4798-81ec-198f204a09e1@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55b4a973-653c-4798-81ec-198f204a09e1@linaro.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Feb 09, 2024 at 09:02:44AM +0100, Krzysztof Kozlowski wrote:
> On 08/02/2024 19:48, Andy Shevchenko wrote:
> > Add initial device tree documentation for Maxim MAX6958/6959.

..

> Please describe the device, e.g. bus/interface.

OK.

..

> > +properties:
> > +  compatible:
> > +    const: maxim,max6959
> 
> Your title said also max6958, so I would expect it to be here as well.
> Cam be followed by 6959 fallback compatible, if they are compatible.

Same question as I asked before, why should we have them separated?
The hardware features can be autodetected. What's the reason for (unneeded
in my opinion and duplicative) compatible?

..

> > +  reg:
> > +    maxItems: 1
> 
> No power supplies? No reset pins?

No power supplies, no reset pins. At least there is no as such in
the datasheet. Do you see them there?

..

> > +examples:
> > +  - |
> > +    i2c {
> > +            #address-cells = <1>;
> 
> Use 4 spaces for example indentation. 2 is also fine.

Sure. Btw, this is copy&pasted from the existing YAML. Are you going to
fix them?

> > +            #size-cells = <0>;
> > +
> > +            max6959: max6959@38 {
> 
> Node names should be generic. See also an explanation and list of

(Same remark: it's a pattern from the existing code. Are you going to fix
 that?)

> examples (not exhaustive) in DT specification:
> https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation
> e.g. display-controller or display

Sure, thanks for review!

> > +                    compatible = "maxim,max6959";
> > +                    reg = <0x38>;
> > +            };
> > +      };

-- 
With Best Regards,
Andy Shevchenko



