Return-Path: <linux-kernel+bounces-86770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5753486CA88
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 14:43:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A90328439E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 13:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DF6912C524;
	Thu, 29 Feb 2024 13:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZJdgEQMV"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F67A86275;
	Thu, 29 Feb 2024 13:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709214182; cv=none; b=Fs/Eq7/wqJ0wFc5S7rfgykGEAESHZp8q0Ts+S3HqRm7Vbf1Iu78/xI0vsEQTjau2C6NUsLQVJa/2qyGeZ6fPSAiKWgflc+BYHjwWtkeCpXzmNarJd4WnVaVWlyHSDOullTkjgvHgeo7st38kMr4TVIGdypfFV0pOSHAshZB6jeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709214182; c=relaxed/simple;
	bh=cVMDpv/rmNUZzkwlOJy8xoCXdpLlErcTFFgyw367/gA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M0jSOQ/32lEQZz9w9mxPzwh759w+cSqW3CQPX0PsDF9hfvabd2AVQ/OQSuZdwX4u3LcHC+MheXp1p/CSo9/MrM9IKQE1unrF5Daxp9vjb4WXrasVBTnWTd8FS2roNB2uqnK4BIh41z8qbihESBFFiAokIv2dbNo0MeX9GvTs7Tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZJdgEQMV; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709214181; x=1740750181;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=cVMDpv/rmNUZzkwlOJy8xoCXdpLlErcTFFgyw367/gA=;
  b=ZJdgEQMV9gxbT68aKvvmGnXfnPZzS4xpbysxofOBzlYJ/L7Wu3K/ouQg
   OqXJ7m4oimO+rx2sMhkjrpc3vWhVp4Be0Jy61tGUbS6rnqCor5HTfgDoN
   wxAITOx6Q8Hboj93x6867t4iHoCxn9U+G7GXYJ28y/uKChxnnKwUZr73k
   bfPfS7gJ9h8yaSWCj9apdyy67rHbe39N4vnneyjcKaWyXDoJea7dUAqbZ
   WGJsODUdQ/y2qXA/tHdLhSJXqGoX0EtBWDAsUuBLWWNEbjrz7DkylYI3U
   I0benqlFdk9wALwwwVglWpCv9zviEQxaFfxl8qPCQcFzWhKfurFoq+jhN
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="14834400"
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="14834400"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Feb 2024 05:43:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="913982428"
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="913982428"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Feb 2024 05:42:56 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rfggX-00000008gIm-2sDh;
	Thu, 29 Feb 2024 15:42:53 +0200
Date: Thu, 29 Feb 2024 15:42:53 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Marek Vasut <marex@denx.de>,
	Anshul Dalal <anshulusr@gmail.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Matt Ranostay <matt@ranostay.sg>,
	Stefan Windfeldt-Prytz <stefan.windfeldt-prytz@axis.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 5/5] iio: light: Add support for APDS9306 Light Sensor
Message-ID: <ZeCJ3T8HVaQZC1Ps@smile.fi.intel.com>
References: <20240228122408.18619-1-subhajit.ghosh@tweaklogic.com>
 <20240228122408.18619-6-subhajit.ghosh@tweaklogic.com>
 <a828e77c-b3d4-49bb-b0bb-b9fd6cb7d114@gmail.com>
 <Zd9tApJClX7Frq20@smile.fi.intel.com>
 <45386f39-a034-4d70-a6d4-8804c27aadce@tweaklogic.com>
 <21ecfb62-30b7-4073-bad6-46a9e08e08b0@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <21ecfb62-30b7-4073-bad6-46a9e08e08b0@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Feb 29, 2024 at 02:58:52PM +0200, Matti Vaittinen wrote:
> On 2/29/24 14:34, Subhajit Ghosh wrote:
> > On 29/2/24 03:57, Andy Shevchenko wrote:
> > > On Wed, Feb 28, 2024 at 03:08:56PM +0200, Matti Vaittinen wrote:
> > > > On 2/28/24 14:24, Subhajit Ghosh wrote:

..

> > > > > +    if (gain_new < 0) {
> > > > > +        dev_err_ratelimited(dev, "Unsupported gain with time\n");
> > > > > +        return gain_new;
> > > > > +    }
> > > 
> > > What is the difference between negative response from the function
> > > itself and
> > > similar in gain_new?
> > > 
> > -ve response form the function is an error condition.
> > -ve value in gain_new means - no valid gains could be computed.
> > In case of error conditions from the function, the gain_new is also set
> > to -1.
> > My use case is valid hardware gain so I went for checking only gain_new.
> > Matti will be the best person to answer on this.
> 
> I now rely on the kerneldoc for the
> iio_gts_find_new_gain_by_old_gain_time() as it seems reasonable to me:
> 
> * Return: 0 if an exactly matching supported new gain was found. When a
> * non-zero value is returned, the @new_gain will be set to a negative or
> * positive value. The negative value means that no gain could be computed.
> * Positive value will be the "best possible new gain there could be". There
> * can be two reasons why finding the "best possible" new gain is not deemed
> * successful. 1) This new value cannot be supported by the hardware. 2) The
> new
> * gain required to maintain the scale would not be an integer. In this case,
> * the "best possible" new gain will be a floored optimal gain, which may or
> * may not be supported by the hardware.

> Eg, if ret is zero, there is no need to check validity of the gain_new but
> it is guaranteed to be one of the supported gains.

Right, but this kernel doc despite being so verbose does not fully answer my
question. What is the semantic of that "negative value"? I would expect to have
the error code there (maybe different to what the function returns), but at
least be able to return it to the upper layers if needed.

Hence 2 ARs I see:
1) clarify the kernel documentation there;
2) update the semantic of the gain_new to simplify caller's code.

-- 
With Best Regards,
Andy Shevchenko



