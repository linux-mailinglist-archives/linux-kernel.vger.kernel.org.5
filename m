Return-Path: <linux-kernel+bounces-61805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AE638516C2
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 15:14:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3D961F2558C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 14:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 714143CF55;
	Mon, 12 Feb 2024 14:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JpdGu26Z"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B6403CF41;
	Mon, 12 Feb 2024 14:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707746966; cv=none; b=tdBTtlcsYmh7uFCIFai/nFvJmd6wInO9SiRM8P0gKZNVhyeeUZtGr/QllPAPpxpFLyyyQ9281a7fagdeS3kSkyuHXzf/0r+OVtB5uKlDY6OPOXQ4ZCVv83CRhlAHtcc69LvD7W5uLfvUbN1uuSLpeTvtyE3zEiXjz5ZEKYpX1Yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707746966; c=relaxed/simple;
	bh=OmHT/FrhDUBQDUhpYbJEhjhkJGs91DlOR2aZmGme0ZE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BuOak+LfBZiAHnnD4dGjiaAYdI1SE9jeqzgIN7IdoAO/f5+u0NVnv8FICcanUUj1mf+dWXG1a2WyHypssaLJfKQGAusY/YmU+MZCcUaNY8WV84wzCq7ts+aMNV1pix0myQ7PceYNiIwiYZ+mq89GFjvQSEAczlLiWpNp5t8+9nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JpdGu26Z; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707746966; x=1739282966;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OmHT/FrhDUBQDUhpYbJEhjhkJGs91DlOR2aZmGme0ZE=;
  b=JpdGu26ZalTrkWHSQxOCb/8u7pi+JSHdjSvetd6XkWueBdE/ZtXm/+Zk
   BwkFwUxjNID9AvLL0Rp53KJTEJKHJoC1/chmf5kmw6shBUVNxLvKCusVB
   0t3Av85PJJLKAf1HXoY+M0KpH4Ut+KXTkg4cXjhxxgdtaVtppZUglDcsc
   ENSVE5siJkNxr4c0VhQ/A2eSHdjMhoQ9sGJxWt+vojBL0rSqeVjwE9b5k
   JLfTEamLCAt3VlfeQe5TCUbgiWrZlfT8Lrnll8zTpLVfafrsHi3rREe6g
   CTm8uHHmxsngi0tA3C02oXJA/AYqNt7dy3PgTtUxocgN+9lBGvVCxipVe
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10981"; a="5536913"
X-IronPort-AV: E=Sophos;i="6.06,264,1705392000"; 
   d="scan'208";a="5536913"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 06:09:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10981"; a="911493193"
X-IronPort-AV: E=Sophos;i="6.06,264,1705392000"; 
   d="scan'208";a="911493193"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 06:09:20 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rZWzn-00000003utH-0Cj3;
	Mon, 12 Feb 2024 16:09:19 +0200
Date: Mon, 12 Feb 2024 16:09:18 +0200
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
Message-ID: <Zcomjp9oH9VfO3NA@smile.fi.intel.com>
References: <20240212083426.26757-1-krzysztof.kozlowski@linaro.org>
 <ZcofhWb8stiddmru@smile.fi.intel.com>
 <906db6a6-48ba-41e5-be23-1dea0ecf96ee@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <906db6a6-48ba-41e5-be23-1dea0ecf96ee@linaro.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Feb 12, 2024 at 02:56:43PM +0100, Krzysztof Kozlowski wrote:
> On 12/02/2024 14:39, Andy Shevchenko wrote:
> > On Mon, Feb 12, 2024 at 09:34:24AM +0100, Krzysztof Kozlowski wrote:

..

> >> -    i2c {
> >> -            #address-cells = <1>;
> >> -            #size-cells = <0>;
> >>  
> >> -            pcf8574: pcf8574@27 {
> >> -                    compatible = "nxp,pcf8574";
> >> -                    reg = <0x27>;
> >> -                    gpio-controller;
> >> -                    #gpio-cells = <2>;
> >> -            };
> >> -    };
> > 
> > In patch 3 you updated the lines that have lost their sense due to this one.
> 
> How did they lose it?

Now they are referring to the non-existed node in the example. OTOH, there is
already hc595 case...

The Q here (as you pointed out that it's better to name nodes in generic way),
how these names are okay with the schema (hc595, pcf8574) as being referred to?

..

> > And I agree with others, please leave this example in place.
> 
> What for? Why this binding is special and 99% of others do not need GPIO
> expander in the example?

Some people already tried to explain you their point of view, but I see that:
- the unrelated nodes in the schemas are not welcome (as per your talks
  and documentation);
- the current file has other references that have no existing node in the
  example;
- you are DT maintainer, so I believe you know this better.

With this, I'm almost (see above question though) satisfied with the series.

-- 
With Best Regards,
Andy Shevchenko



