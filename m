Return-Path: <linux-kernel+bounces-81853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F245867AFA
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 17:00:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DCAF1C28AEE
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 16:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D2A712C81A;
	Mon, 26 Feb 2024 16:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gaTDo5ZN"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DDC412C7F4;
	Mon, 26 Feb 2024 16:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708963217; cv=none; b=YUcg2pdzE8JPWiEa2s/nrrtP1/bsoVtSoJluBCmptV9QAYfR/W3v5VcH+LlIAQNazswSHgaz1Wp0JBXmlDbm97jXvhvoWhAAwwEITxNISPb37OE9SPtjx6Qj3DrU2tfMb7qeAPy0Y/5G+p07V2zPHsS86uPdvj9VwvUvLuZq1Tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708963217; c=relaxed/simple;
	bh=m0shflrtpVqGvHXwYmMQCHNbhtUzpt+80U4IeihsY3s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UanBdW5l0xAg9bXP1mDhtLhAvUOE0I8iPFjyWiye3YOMPW/l/N/T9rYi1dlEltaAuxEnx0eE/H3upU3dOZFwjPxcrVpziGXzMn+YV8IWZx5UafnYopuPHSdoEi0dQYlfHmS+JwjJ/Y9YpPZnxbSkotUl4IhXCp9NAYI5qLwF088=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gaTDo5ZN; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708963216; x=1740499216;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=m0shflrtpVqGvHXwYmMQCHNbhtUzpt+80U4IeihsY3s=;
  b=gaTDo5ZNUhgO+dVP7HlbROagyXTaVPIEZ4ySDsrUJnKvi6v1XBhW159k
   vLZks+RvauD7F96N5p8v3bl3zIrrp5YXvK6cMyD2ivlLAkbDG6bCSiXo+
   W5jS7AnkXQNQg5lXlyh/Y/iiv4mnTtZDQepaQLyp6328nXbDVswZ8HlC3
   u4vpZNDfjpTZqfcVy00/f0E1K2psL4mNUP6lI9C4RTWCSOSUE/wL39gOp
   Cju4H3w2grXkupnuoeL1NAdMydDxqQiGA+6/h95HowgbTdlIxAjAytKaZ
   aZ244TVA0b1NQhAbQ0GRgpn+BH0HXbhuTzAJh124rtUiti+nqN92ZrSaG
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="25722597"
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="25722597"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 08:00:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="913879061"
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="913879061"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 08:00:12 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1redOj-00000007j6f-2d7M;
	Mon, 26 Feb 2024 18:00:09 +0200
Date: Mon, 26 Feb 2024 18:00:09 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Robin van der Gracht <robin@protonic.nl>,
	Paul Burton <paulburton@kernel.org>
Subject: Re: [PATCH v3 1/9] auxdisplay: linedisp: Group display drivers
 together
Message-ID: <Zdy1icZvsr_NWt3O@smile.fi.intel.com>
References: <20240219170337.2161754-1-andriy.shevchenko@linux.intel.com>
 <20240219170337.2161754-2-andriy.shevchenko@linux.intel.com>
 <CAMuHMdVv==58uen8nukLDB9ADCvJJFYTb2bZSAcFKQ0wUmqL9w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdVv==58uen8nukLDB9ADCvJJFYTb2bZSAcFKQ0wUmqL9w@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Feb 26, 2024 at 04:28:20PM +0100, Geert Uytterhoeven wrote:
> On Mon, Feb 19, 2024 at 6:03 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > For better usability group the display drivers together in Kconfig
> > and Makefile. With this we will have the following sections:
> >   - Character LCD
> >   - Samsung KS0108 LCD controller
> >   - Single character line display
> >   - Character LCD with non-conforming interface

..

> > +config HT16K33
> > +       tristate "Holtek Ht16K33 LED controller with keyscan"
> 
> HT16K33 also supports dot-matrix displays using fbdev...
> Yes, categorizing is difficult.

So, what to do here?

..

> I still think these should be sorted alphabetically.

Okay.

-- 
With Best Regards,
Andy Shevchenko



