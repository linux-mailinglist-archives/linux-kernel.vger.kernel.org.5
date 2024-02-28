Return-Path: <linux-kernel+bounces-85549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCB5586B788
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 19:45:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 453E4B25063
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 18:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C00B571ECD;
	Wed, 28 Feb 2024 18:45:37 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E98371EAE;
	Wed, 28 Feb 2024 18:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709145937; cv=none; b=N0QBRyArXmfss/UChefwQuw5YwBtzG84+ONr5RJVDP7xDyuPoG/zCfFjM0keo2syppgt/TvQ7jDFwuHRc3VdRSl8GvGxejZHt44GuwrE/+v0sBvAXbmLb5SWoJwpLUdG8jQWnB0tVylWgB5pnKS9XHJD/1o7BtY1I3Q4UF5ANdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709145937; c=relaxed/simple;
	bh=PuptU9qCfYeOwL5IH0ZHMjo0cCz+Qt/qZLM54d12CD8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cN0LmdxngE9MxTCqIFzW2WacGZDmhpoHjO8O+M7Cjgd5KQY8FSIRf82c/6I6NRb2/aaxfrqvaHKjwW1x591m+B5f48YuZbX4Mh1LEk7SK2pGL/BIK0hc6vfekYmZmJ1hojq1+pUL67kbR3Z9ec7Vz3TKcj6Qi3sQ96Eb++t/lQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="21023886"
X-IronPort-AV: E=Sophos;i="6.06,191,1705392000"; 
   d="scan'208";a="21023886"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 10:45:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="913958033"
X-IronPort-AV: E=Sophos;i="6.06,191,1705392000"; 
   d="scan'208";a="913958033"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 10:45:25 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andy.shevchenko@gmail.com>)
	id 1rfOvh-00000008Ir4-2XPh;
	Wed, 28 Feb 2024 20:45:21 +0200
Date: Wed, 28 Feb 2024 20:45:21 +0200
From: Andy Shevchenko <andy.shevchenko@gmail.com>
To: Chris Packham <Chris.Packham@alliedtelesis.co.nz>
Cc: "geert@linux-m68k.org" <geert@linux-m68k.org>,
	"robh+dt@kernel.org" <robh+dt@kernel.org>,
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
Subject: Re: [PATCH v2 0/4] auxdisplay: 7 segment LED display
Message-ID: <Zd9_Qc0fVD6OjbKi@smile.fi.intel.com>
References: <20240227212244.262710-1-chris.packham@alliedtelesis.co.nz>
 <CAHp75Vc7yFX6TLhc0ADx+76_+2Li=WgQiSqpcwkFSpP3pPdC5Q@mail.gmail.com>
 <2ad735ed-963c-4e75-b83e-687ea2c0aef5@alliedtelesis.co.nz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2ad735ed-963c-4e75-b83e-687ea2c0aef5@alliedtelesis.co.nz>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Feb 28, 2024 at 12:25:30AM +0000, Chris Packham wrote:
> 
> On 28/02/24 13:05, Andy Shevchenko wrote:
> > On Tue, Feb 27, 2024 at 11:22 PM Chris Packham
> > <chris.packham@alliedtelesis.co.nz> wrote:
> >> This series adds a driver for a 7 segment LED display.
> >>
> >> At this point I've decided not to pursue supporting >1 character. I had
> >> a look at what would be required to add a devm_fwnode_gpiod_get_array()
> >> and got bogged down in OF and ACPI code for counting GPIOs.
> > Out of curiosity, why did it happen? gpiod_count() works in an agnostic way.
> >
> At first I though I could create a fwnode_gpiod_count() out of the body 
> of gpiod_count(). But both of_gpio_get_count() and acpi_gpio_count() 
> take the dev not the fwnode. It looks like gpiod_count() (and 
> of_gpio_spi_cs_get_count()) could probably be re-written (or abstracted) 
> to take the device_node instead of the device. I started looking at 
> acpi_gpio_count() but I couldn't quite see how I could adapt this.
> 
> I'm definitely not saying it can't be done. Just that you probably don't 
> want an occasional contributor like me messing with some of these core 
> device abstractions.

I just sent a series. With it you may split gpiod_count() to
fwnode_gpio_count() and gpiod_count() that uses the former.
I believe you may do that easily as it won't require any special
knowledge.

-- 
With Best Regards,
Andy Shevchenko



