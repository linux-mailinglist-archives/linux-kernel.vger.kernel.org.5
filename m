Return-Path: <linux-kernel+bounces-67037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC0BF856521
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 14:58:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D8941F20ECA
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 13:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F10AE130AEF;
	Thu, 15 Feb 2024 13:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hyTYVfLZ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B30FA131E24;
	Thu, 15 Feb 2024 13:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708005485; cv=none; b=B5lzLJzLbClnd82v+4S85sVeDdbTonO/UURBIEKKoVZH67i+3bIlllRJS03N0RRAWD2w2ie9pzIlQA6XcKWVJ86W75sWYNFZgA65hcmPDUMqlCNJoC5VxXVB6GAxQqO0TNvBGT3nv8qu2L/ePj/CmIZ5EFGXSBS+3Y5a6Kp3aSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708005485; c=relaxed/simple;
	bh=UPKpN7nqui4ysDnCGreHX8nzGj9sjALQGsYZp/dmEZs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pDPwniKKDUxQ8UrZyrekUC38IGOOjVii+gQC0Xotn5fmZnIh9EqlAgME+SH8y5pTqoqSVnd7o+oclj4FuYJ77YclVeivhiFUc5lrlqR16d+j7es8CxyxRG+i5IU5C0YSKt/RjwsDojEwQb6lfi3OQwqHGT1p+R9GMYnyy9cOSzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hyTYVfLZ; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708005484; x=1739541484;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=UPKpN7nqui4ysDnCGreHX8nzGj9sjALQGsYZp/dmEZs=;
  b=hyTYVfLZ/DXIYFtqk6ccCyYqpHZrxBOD2XQYZZRb3MAJcmAHrx46K1iA
   Kckb4cuMuMKQ4p2mn3wxstzhhdsmgVPs8ot8NcSeNNFLiIiiUHSCYkUl4
   NtSXjJYgjG2TBmco35CILX6q3W0JQ47RjI2UqJEaFF86tNYGBKg8MO+xW
   Hz/njtzpUsYvB4zaG19YCp7NaLqYQfPwzgLXDopVGoVt0ktzhV1zP7xIK
   kSTuRDRdANDu7KUTwSJAl57LGuUdNigNgBhRzJNmtBZ2+Q8WDX8mWTM7M
   QIDtyGCz8UzTbvhORapVVph5kNj3ATwzqldQQEOlY0ZgqltpETw5G98z1
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10984"; a="5920052"
X-IronPort-AV: E=Sophos;i="6.06,161,1705392000"; 
   d="scan'208";a="5920052"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2024 05:58:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10984"; a="912169588"
X-IronPort-AV: E=Sophos;i="6.06,161,1705392000"; 
   d="scan'208";a="912169588"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2024 05:58:01 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1racFS-00000004o05-1lJP;
	Thu, 15 Feb 2024 15:57:58 +0200
Date: Thu, 15 Feb 2024 15:57:58 +0200
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
Message-ID: <Zc4YZo8Pt5qA9R38@smile.fi.intel.com>
References: <20240212170423.2860895-1-andriy.shevchenko@linux.intel.com>
 <20240212170423.2860895-11-andriy.shevchenko@linux.intel.com>
 <CAMuHMdVtqWBi4Y1tj74m4V4kp-3cFe_FphKKeY7zOkrbMVkKRg@mail.gmail.com>
 <Zc4Au5Q_rOAx7_4Y@smile.fi.intel.com>
 <Zc4BVIwpAqJYPuTH@smile.fi.intel.com>
 <CAMuHMdUR8i_08bz_B6HTzD4yx4URaC5aGG6byYNbmLmM0Gb4=w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdUR8i_08bz_B6HTzD4yx4URaC5aGG6byYNbmLmM0Gb4=w@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Feb 15, 2024 at 01:33:29PM +0100, Geert Uytterhoeven wrote:
> On Thu, Feb 15, 2024 at 1:19 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Thu, Feb 15, 2024 at 02:17:00PM +0200, Andy Shevchenko wrote:
> > > On Thu, Feb 15, 2024 at 11:40:44AM +0100, Geert Uytterhoeven wrote:
> > > > On Mon, Feb 12, 2024 at 6:04 PM Andy Shevchenko
> > > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > > +       linedisp->buf = buf ? buf : linedisp->curr;
> > > > > +       linedisp->num_chars = buf ? num_chars : min(num_chars, LINEDISP_DEFAULT_BUF_SZ);
> > > >
> > > > I think it would be safer to return an error if buf == NULL and
> > > > num_chars < LINEDISP_DEFAULT_BUF_SZ.
> > >
> > > I think you meant >= ?
> 
> Oops, yes/
> 
> > >
> > > > Else a careless driver that doesn't check linedisp->num_chars might
> > > > overflow the buffer.
> > >
> > > Okay, check has been added.
> >
> > Hold on, but I have min() being called, isn't it enough?
> 
> Yes you have.
> 
> A careless driver might not use linedisp->num_chars later, but instead
> just hardcode e.g. memcpy(linedisp->buf, source, LARGE_BUF_SIZE).

I see the point, yes, we need an additional check.

-- 
With Best Regards,
Andy Shevchenko



