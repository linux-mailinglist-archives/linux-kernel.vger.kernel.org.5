Return-Path: <linux-kernel+bounces-66878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 248B785630B
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 13:24:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD8B7B2776D
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 12:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 183DC12BF3D;
	Thu, 15 Feb 2024 12:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Byp4KWo3"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB7AB12BF04;
	Thu, 15 Feb 2024 12:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707999580; cv=none; b=nKYbhqi12B9+xo6DvUuws2lk5qHzv9PVg8EniugcUPiAmvdfYRLpktOWeWKWKfQ6Bnl+BvXtF2OuJhS7Yq1xgaj0lmN4NplxI2yoza6mmu6oHfOuqJy3wCDVxxaqN1opyBeCzU5paQ2agHkKFF5beoTmiYGx2IXG/klEFWTsPRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707999580; c=relaxed/simple;
	bh=K3WhC0oEC+qO0zQoV5jfi/pvA9TOx/NiS3IqRkMlXLU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GHKpylxA9H5BoqcGm7wTToA3gAH/d0NF1IwyMrYQTxxng9Y1TwE6WyqdxUk42oNUcNMS1mxUwOqZsy4nj6TxxPZ/bgv8rW8KTu18b2+c20/EXhnzChz4KtAB9K8DoSmj7MisKNmV9BKm1MsehNH0CHnk3cSLzbAsBN1Xt0XOfJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Byp4KWo3; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707999578; x=1739535578;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=K3WhC0oEC+qO0zQoV5jfi/pvA9TOx/NiS3IqRkMlXLU=;
  b=Byp4KWo33DbrJcQEAe6+vTVG2HL8KWRs0g/vQ0VKWphsGOxHwlIbR6pg
   q2oearnqiziKU7oq1EGHk1oy7KhzAitMwCsZurz0sf34cLtxTFSowzuSk
   Ux/6unGeCB1YIAhqcxdHRmaGy0Hx7DWrIl81H6adsFGKgErv00n0fm/F6
   x81tU10JRvUV7ngdOqr9mUyp1qczGQI0slhsXkP0tGHByMo4hUjtnTh17
   i5931Jp0RMbYlBUTgXtkeMXAIX6tBjmj1/QJn9TxMWZBYyvCWVdp3f3ji
   b+Xvdq5dO4kW5bJDrZl2RiGnnx/uk2m5q5NmPydgNbYDLxsGG5qoODoSO
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10984"; a="5049899"
X-IronPort-AV: E=Sophos;i="6.06,161,1705392000"; 
   d="scan'208";a="5049899"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2024 04:19:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10984"; a="912157066"
X-IronPort-AV: E=Sophos;i="6.06,161,1705392000"; 
   d="scan'208";a="912157066"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2024 04:19:34 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1raaiC-00000004mlg-37MC;
	Thu, 15 Feb 2024 14:19:32 +0200
Date: Thu, 15 Feb 2024 14:19:32 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Robin van der Gracht <robin@protonic.nl>,
	Paul Burton <paulburton@kernel.org>
Subject: Re: [PATCH v2 10/15] auxdisplay: linedisp: Provide a small buffer in
 the struct linedisp
Message-ID: <Zc4BVIwpAqJYPuTH@smile.fi.intel.com>
References: <20240212170423.2860895-1-andriy.shevchenko@linux.intel.com>
 <20240212170423.2860895-11-andriy.shevchenko@linux.intel.com>
 <CAMuHMdVtqWBi4Y1tj74m4V4kp-3cFe_FphKKeY7zOkrbMVkKRg@mail.gmail.com>
 <Zc4Au5Q_rOAx7_4Y@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zc4Au5Q_rOAx7_4Y@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Feb 15, 2024 at 02:17:00PM +0200, Andy Shevchenko wrote:
> On Thu, Feb 15, 2024 at 11:40:44AM +0100, Geert Uytterhoeven wrote:
> > On Mon, Feb 12, 2024 at 6:04 PM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:

..

> > > +       linedisp->buf = buf ? buf : linedisp->curr;
> > > +       linedisp->num_chars = buf ? num_chars : min(num_chars, LINEDISP_DEFAULT_BUF_SZ);
> > 
> > I think it would be safer to return an error if buf == NULL and
> > num_chars < LINEDISP_DEFAULT_BUF_SZ.
> 
> I think you meant >= ?
> 
> > Else a careless driver that doesn't check linedisp->num_chars might
> > overflow the buffer.
> 
> Okay, check has been added.

Hold on, but I have min() being called, isn't it enough?

-- 
With Best Regards,
Andy Shevchenko



