Return-Path: <linux-kernel+bounces-86569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 33D6886C730
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 11:44:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9D1A1F23816
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 10:44:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5A3479DCF;
	Thu, 29 Feb 2024 10:44:36 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC5C9111E;
	Thu, 29 Feb 2024 10:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709203476; cv=none; b=TXlHZOUSuPFayXYD4Hp4lQPLYFchcoNVIVQKrHWNe0Znrxatj9j7D3wUtN6YiK2jioULliPLXgDl7LNvobhlgARqCRcAG4frs84f9N9gOMyyypQvodA2rRLBaQERsxStiS6ghQ1AVRbFLnlO+GUu4fVvKJb+LZ49zV5A7TESINw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709203476; c=relaxed/simple;
	bh=jhhDWrQfbqTYlkzq71ZEnwk4+pwgB5CiiGI3IQ6of3c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e6WjkchgBAHv1Kzi5uAZz7pa+cti3sbGp8ESi4KUDFvFVIlSB+vQe0Ktnmhlm3FE1AeMnR+HUuwQOj7EL8a+XNiZlZbTCWN48qrP54Y8zWu/9GiBSWrCeDggWauBdOWbOvgD4WxpQIy4KT5y+rJOblnq7AOgep4VJPISLzhuJU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="21121343"
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="21121343"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Feb 2024 02:44:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="913978704"
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="913978704"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Feb 2024 02:44:29 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andy@kernel.org>)
	id 1rfdtp-00000008e0h-2kST;
	Thu, 29 Feb 2024 12:44:25 +0200
Date: Thu, 29 Feb 2024 12:44:25 +0200
From: "andy@kernel.org" <andy@kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Chris Packham <Chris.Packham@alliedtelesis.co.nz>,
	Rob Herring <robh@kernel.org>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"andrew@lunn.ch" <andrew@lunn.ch>,
	"gregory.clement@bootlin.com" <gregory.clement@bootlin.com>,
	"sebastian.hesselbarth@gmail.com" <sebastian.hesselbarth@gmail.com>,
	"ojeda@kernel.org" <ojeda@kernel.org>,
	"tzimmermann@suse.de" <tzimmermann@suse.de>,
	"javierm@redhat.com" <javierm@redhat.com>,
	"robin@protonic.nl" <robin@protonic.nl>,
	"lee@kernel.org" <lee@kernel.org>, "pavel@ucw.cz" <pavel@ucw.cz>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 2/4] dt-bindings: auxdisplay: Add bindings for generic
 7 segment LED
Message-ID: <ZeBgCSsO0FH1jb7h@smile.fi.intel.com>
References: <20240227212244.262710-1-chris.packham@alliedtelesis.co.nz>
 <20240227212244.262710-3-chris.packham@alliedtelesis.co.nz>
 <20240228140423.GA3307293-robh@kernel.org>
 <d666668b-f371-47e0-846e-6e8a56b4bb2f@alliedtelesis.co.nz>
 <CAMuHMdXJT5THun7XG8ig746Bh+paAP5uSMg33aa=Csui4Dkb4g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdXJT5THun7XG8ig746Bh+paAP5uSMg33aa=Csui4Dkb4g@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Feb 29, 2024 at 10:24:33AM +0100, Geert Uytterhoeven wrote:
> On Wed, Feb 28, 2024 at 9:02 PM Chris Packham
> <Chris.Packham@alliedtelesis.co.nz> wrote:
> > On 29/02/24 03:04, Rob Herring wrote:
> > > On Wed, Feb 28, 2024 at 10:22:42AM +1300, Chris Packham wrote:

..

> > > How does one know which GPIO is which segment?
> >
> > I've expanded the description in v3.
> >
> > + An array of GPIOs one per segment. The first GPIO corresponds to the A
> > + segment the last GPIO corresponds to the G segment.
> >
> > Do you think that's sufficient or do I need to add more? In the driver
> > itself I've put a little ascii art diagram of the segments.
> 
> Given users are reading the bindings rather than the driver source,
> I would move the diagram to the bindings.

+1 here. We have a diagram already in UAPI headers, but that won't be (quickly)
visible for the real users, duplicating in the code doesn't add any value, but
adding it to DT description will be beneficial.

-- 
With Best Regards,
Andy Shevchenko



