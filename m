Return-Path: <linux-kernel+bounces-66769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81507856150
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 12:19:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE2C31C22706
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 11:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47FA812B163;
	Thu, 15 Feb 2024 11:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KnfYHgi+"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 064F01EF1D;
	Thu, 15 Feb 2024 11:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707995829; cv=none; b=Tne7o/XZpIvusPKIzvfetjk277aEE3zkXTkfVDuVC8yKThDazDHF2e41fSocjGJlK7BLiwMCNIaU+cM3y4Izc78MMAhg94JaonLOAmas6wDDpbApnmy7Otuup9JXZjcNFz4QgZXGg9pu8I3bG4Xd736q5ofwAk4omjlE/tYmwwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707995829; c=relaxed/simple;
	bh=f8P9dbNtAFnROptNGXdBS94c+k3CdsGOwXBnn1nCnWA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p1R3tJdZnQjRXIg2NA06ly9bBMhIm0JaUkaC0cP4GAqwgbWpuvoGeazGTKASAEitMwNgXAEgvLC05q1KtaMBovusqkpVG9D8gf+E6WqdK6OklI8ytUU2Q22NUavXPkWwx4Uz5OsEg2M7JVL5CWT8bbYH6TmgHLe7zE1ow8FZQfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KnfYHgi+; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707995828; x=1739531828;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=f8P9dbNtAFnROptNGXdBS94c+k3CdsGOwXBnn1nCnWA=;
  b=KnfYHgi+uzUv/+uaFvIVxckAAoFXjQ9JBFHKFSUkNB2kCYLbj6u7PmFE
   M/CjVtlf//El5T9FrbiNTrEaa704KCX51OFsA42IH/dJHUDU5W0lRMnAY
   RlWzmp5FzAeiZI6EdQf309E1L0OqGlYxvtfBHFHOn8UzqDIWlHuvS1hgo
   X/q8MVpDv6tZQz11Jrc13T+XaITzzOX0feiQTawzCplaC3Y1gTOyGtxZN
   In0iBNZqI6DqVCJ7HrP0z8n3Q+beS3CTPUlizzsO6TM13MSJ8lsmhIfvd
   l5BCfEJdp3AtLtV7nTuaGlzMDv6Ys/hMDcuZGPP6+q65U7sPWSInCk/gG
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10984"; a="5890767"
X-IronPort-AV: E=Sophos;i="6.06,161,1705392000"; 
   d="scan'208";a="5890767"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2024 03:17:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10984"; a="912148288"
X-IronPort-AV: E=Sophos;i="6.06,161,1705392000"; 
   d="scan'208";a="912148288"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2024 03:17:05 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1raZji-00000004lvA-02IS;
	Thu, 15 Feb 2024 13:17:02 +0200
Date: Thu, 15 Feb 2024 13:17:01 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Robin van der Gracht <robin@protonic.nl>,
	Paul Burton <paulburton@kernel.org>
Subject: Re: [PATCH v2 14/15] dt-bindings: auxdisplay: Add Maxim MAX6958/6959
Message-ID: <Zc3yrdAdQ7-SRs1C@smile.fi.intel.com>
References: <20240212170423.2860895-1-andriy.shevchenko@linux.intel.com>
 <20240212170423.2860895-15-andriy.shevchenko@linux.intel.com>
 <ZcpSDOk-IQVasHud@smile.fi.intel.com>
 <ZcpSaHW-RQ3dzywP@smile.fi.intel.com>
 <CAMuHMdV8mTa-qutFgqRKJyES7evEqEYhs=_eHtrKTTs5NkNa9A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdV8mTa-qutFgqRKJyES7evEqEYhs=_eHtrKTTs5NkNa9A@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Feb 15, 2024 at 11:57:53AM +0100, Geert Uytterhoeven wrote:
> On Mon, Feb 12, 2024 at 6:16 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Mon, Feb 12, 2024 at 07:14:53PM +0200, Andy Shevchenko wrote:

..

> > +description:
> > +  The Maxim MAX6958/6959 7-segment LED display controller provides
> > +  an I2C interface to up to four 7-segment LED digits. The MAX6959
> > +  in comparison to MAX6958 has the debounce and interrupt support.
> 
> IUIC, the primary differentiating factor is that the MAX6959 adds input
> and GPIO support?  Debounce and interrupt support are merely features
> of input support.

What should I do here? Rephrase?

> > +  Type of the chip can be autodetected via specific register read,
> > +  and hence the features may be enabled in the driver at run-time.
> 
> I don't think you need to read that register, as the users of the
> features (keypad mapping, interrupts property, ...) also need to be
> described in DTS (once supported).

So, the idea that if DT describes those we will check the chip ID and
instantiate what is asked?

> > +  Given hardware is simple and does not provide any additional pins,
> > +  such as reset or enable.
> 
> Does this matter? I.e. is it important to say this in the bindings?

From Krzysztof's review of v1 I understood that it is important to say so
people wouldn't wonder if HW has support of that which is not implemented
(yet) or simply has no such pins.

Personally I would lean towards leaving this in the description.

..

Can you propose the full description text how you see it?

-- 
With Best Regards,
Andy Shevchenko



