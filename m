Return-Path: <linux-kernel+bounces-56769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F80A84CEED
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 17:34:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81E5C1C2698E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 16:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ABBF7A70E;
	Wed,  7 Feb 2024 16:34:15 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90941446C8;
	Wed,  7 Feb 2024 16:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707323655; cv=none; b=RxOl8ENv3vsQPPcP4VKToIa3KrXSGOtC/6PQR9A/Iqpb4IOwwVksYrW3RS6XwvnHbR7SAw8qfqTNfYctb7Yf2WHrtCLXyHDvl1AD1RUGGahYptOdk4/n8zcn+jcFxhJBy3XyG/XiKfaJQA+YAfA4izZw0j0FaB8C4l43+a99awg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707323655; c=relaxed/simple;
	bh=CNpATxVE7hKjcMfwE7sqK0SOMIV7HhiDIUzTYUEw6g0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U8N2ld2dPJ2Nb3KVHu7rtdQn1Uz34ckJ0knXLEW6qO9z3Bk8OMy7QdfMsjpbb6mpXAN5nxCyIB5ndHYwBxV90Sxm8bv5Cedzs9NWbuxFfvD17MXJu8zeqtcCxCSK3h1U/it/Pb082R4XiDHL2/Xlk6WztGhUvO3mctPzn+oxlgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
X-IronPort-AV: E=McAfee;i="6600,9927,10977"; a="12384133"
X-IronPort-AV: E=Sophos;i="6.05,251,1701158400"; 
   d="scan'208";a="12384133"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2024 08:34:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10977"; a="910037935"
X-IronPort-AV: E=Sophos;i="6.05,251,1701158400"; 
   d="scan'208";a="910037935"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2024 08:34:10 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andy.shevchenko@gmail.com>)
	id 1rXksB-00000002eol-28Gd;
	Wed, 07 Feb 2024 18:34:07 +0200
Date: Wed, 7 Feb 2024 18:34:07 +0200
From: Andy Shevchenko <andy.shevchenko@gmail.com>
To: Kees Cook <keescook@chromium.org>
Cc: Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
	Marco Elver <elver@google.com>, Eric Biggers <ebiggers@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/3] overflow: Introduce wrapping_inc() and
 wrapping_dec()
Message-ID: <ZcOw_5-1ghxJrqfg@smile.fi.intel.com>
References: <20240207152317.do.560-kees@kernel.org>
 <20240207152422.3855315-3-keescook@chromium.org>
 <CAHp75Vf3emnw-=it-Smb_NG+xYjWhB+U0+i1hcNPWA=BByN6nw@mail.gmail.com>
 <202402070806.445F7F7F03@keescook>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <202402070806.445F7F7F03@keescook>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Feb 07, 2024 at 08:08:14AM -0800, Kees Cook wrote:
> On Wed, Feb 07, 2024 at 05:31:54PM +0200, Andy Shevchenko wrote:
> > On Wed, Feb 7, 2024 at 5:24 PM Kees Cook <keescook@chromium.org> wrote:
> > >
> > > This allows replacements of the idioms "var += offset" and "var -= offset"
> > > with the wrapping_inc() and wrapping_dec() helpers respectively. They
> > > will avoid wrap-around sanitizer instrumentation.
> > >
> > > Add to the selftests to validate behavior and lack of side-effects.
> > 
> > I would expect inc/dec to add/subtract 1. So, to me the terminology is
> > confusing. The list of the C/C++ operators on Wikipedia describes
> > above as
> > 
> > += Assignment by sum
> > -= Assignment by difference
> > 
> > Hence the proposal is to have
> > 
> > wrapping_sum()
> > wrapping_diff()
> 
> I think maybe the missing phrase is "assign", which is what makes
> argument 1 "special" -- it's being changed. Perhaps:
> 
> wrapping_add_assign()
> wrapping_sub_assign()
> 
> ?

WFM!

-- 
With Best Regards,
Andy Shevchenko



