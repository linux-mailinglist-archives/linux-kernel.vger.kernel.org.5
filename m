Return-Path: <linux-kernel+bounces-75489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C7A785E96E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 22:04:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A56DDB22255
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 21:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ED8D86AD5;
	Wed, 21 Feb 2024 21:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hgrnrwmd"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E5A8173D
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 21:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708549469; cv=none; b=C12a+3kktaaTx6Bdj4kHHbNm9cc+n3wqLSPqFIpLatdV/Bfu5LVXOjHsU6CEeMvgHb0SdECaWhZDBdNbkcecs8GgnyYPHDAWin9d999IxeP77nEx2htphB1aWrPU1PyGFojqRPA85w9zDqon6cOd2OSgUgOjQ956noY8WQmGaGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708549469; c=relaxed/simple;
	bh=MmfRwcbeEjTW+L079Q3/1enUCXGnhNR/XHjokIR0+AQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zi1KQj+OIWpAclB6ZIIF+uoAW9x8A5er8pzKANdceit01jLg6DIgbUugAvjGbnAgWVMNeK01J/g88ABb3v7uVJvc8KYfT1HjT5Yi74hol17aT8wbz57PEAZFLr8m5ojOJtdSJvQQLcqfsTU6kO+TLHkBW2Ch/KzwjRepRVMeP/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hgrnrwmd; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708549468; x=1740085468;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MmfRwcbeEjTW+L079Q3/1enUCXGnhNR/XHjokIR0+AQ=;
  b=hgrnrwmdRvMf4PdzNs831nGJrnC0WfaRwBb6e4gmiTP1icfLhLMNhzzX
   ZRdsZVuLVnZp1t1f0vcBD0G19WHQfvhoVpGx/c8wldeewan1z+uo97TrK
   CGgKk97mPrkNjuVx01gWW6G16ahVw576j61SwLifcFfI+DYBjPWk0pAKe
   kHPtp31Lvw6z1d6BVq49ojU9YpbfHepsTuLZBP7ZUqmm33UgHw6Lp2sJQ
   SeLFSi5E23T4cgHRGRScuCzfP/vrbQilIk08XNgAKKAKdE5iIbtL5XpCi
   ERpVVwIAJEzi1SsWHtN5OcDcIiQOtY+AiJmrSp1OpbqyYJijjD2gKlJ+7
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10991"; a="13296955"
X-IronPort-AV: E=Sophos;i="6.06,176,1705392000"; 
   d="scan'208";a="13296955"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2024 13:04:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10991"; a="913372710"
X-IronPort-AV: E=Sophos;i="6.06,176,1705392000"; 
   d="scan'208";a="913372710"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2024 13:04:25 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rctlO-00000006TAk-2zR4;
	Wed, 21 Feb 2024 23:04:22 +0200
Date: Wed, 21 Feb 2024 23:04:22 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Lucas De Marchi <lucas.demarchi@intel.com>,
	Yury Norov <yury.norov@gmail.com>, linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	Jani Nikula <jani.nikula@linux.intel.com>,
	intel-xe@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
	Jani Nikula <jani.nikula@intel.com>
Subject: Re: [PATCH v3 1/3] bits: introduce fixed-type genmasks
Message-ID: <ZdZlVn9BI-0q1Xdn@smile.fi.intel.com>
References: <20240208074521.577076-1-lucas.demarchi@intel.com>
 <20240208074521.577076-2-lucas.demarchi@intel.com>
 <CAA8EJpprfrtOjNzT6TFhV1n6MXzLdTahanfxcRW4uVjeHaBduA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA8EJpprfrtOjNzT6TFhV1n6MXzLdTahanfxcRW4uVjeHaBduA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Feb 21, 2024 at 10:30:02PM +0200, Dmitry Baryshkov wrote:
> On Thu, 8 Feb 2024 at 09:45, Lucas De Marchi <lucas.demarchi@intel.com> wrote:

..

> > +#define BITS_PER_TYPE(type)    (sizeof(type) * BITS_PER_BYTE)

Can sizeof() be used in assembly?

..

> > -#define __GENMASK(h, l) \
> > -       (((~UL(0)) - (UL(1) << (l)) + 1) & \
> > -        (~UL(0) >> (BITS_PER_LONG - 1 - (h))))
> > -#define GENMASK(h, l) \
> > -       (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))

> > +#define __GENMASK(t, h, l) \
> > +       (GENMASK_INPUT_CHECK(h, l) + \
> > +        (((t)~0ULL - ((t)(1) << (l)) + 1) & \
> > +        ((t)~0ULL >> (BITS_PER_TYPE(t) - 1 - (h)))))

Nevertheless, the use ~0ULL is not proper assembly, this broke initial
implementation using UL() / ULL().


> > -#define __GENMASK_ULL(h, l) \
> > -       (((~ULL(0)) - (ULL(1) << (l)) + 1) & \
> > -        (~ULL(0) >> (BITS_PER_LONG_LONG - 1 - (h))))
> > -#define GENMASK_ULL(h, l) \
> > -       (GENMASK_INPUT_CHECK(h, l) + __GENMASK_ULL(h, l))

Ditto.

> > +#define GENMASK(h, l)          __GENMASK(unsigned long,  h, l)
> > +#define GENMASK_ULL(h, l)      __GENMASK(unsigned long long, h, l)
> > +#define GENMASK_U8(h, l)       __GENMASK(u8,  h, l)
> > +#define GENMASK_U16(h, l)      __GENMASK(u16, h, l)
> > +#define GENMASK_U32(h, l)      __GENMASK(u32, h, l)
> > +#define GENMASK_U64(h, l)      __GENMASK(u64, h, l)
> 
> This breaks drm-tip on arm64 architecture:
> 
> arch/arm64/kernel/entry-fpsimd.S: Assembler messages:
> 465arch/arm64/kernel/entry-fpsimd.S:271: Error: found 'l', expected: ')'
> 466arch/arm64/kernel/entry-fpsimd.S:66: Info: macro invoked from here
> 467arch/arm64/kernel/entry-fpsimd.S:271: Error: found 'l', expected: ')'
> 468arch/arm64/kernel/entry-fpsimd.S:66: Info: macro invoked from here
> 469arch/arm64/kernel/entry-fpsimd.S:271: Error: found 'l', expected: ')'
> 470arch/arm64/kernel/entry-fpsimd.S:66: Info: macro invoked from here
> 471arch/arm64/kernel/entry-fpsimd.S:271: Error: found 'l', expected: ')'
> 472arch/arm64/kernel/entry-fpsimd.S:66: Info: macro invoked from here
> 473arch/arm64/kernel/entry-fpsimd.S:271: Error: unexpected characters
> following instruction at operand 3 -- `bic x2,x1,(0+(((unsigned
> long)~0ULL-((unsigned long)(1)<<(0))+1)&((unsigned
> long)~0ULL>>((sizeof(unsigned long)*8)-1-(3)))))'
> 474arch/arm64/kernel/entry-fpsimd.S:66: Info: macro invoked from here
> 475arch/arm64/kernel/entry-fpsimd.S:282: Error: found 'l', expected: ')'
> 476arch/arm64/kernel/entry-fpsimd.S:98: Info: macro invoked from here
> 477arch/arm64/kernel/entry-fpsimd.S:282: Error: found 'l', expected: ')'
> 478arch/arm64/kernel/entry-fpsimd.S:98: Info: macro invoked from here
> 479arch/arm64/kernel/entry-fpsimd.S:282: Error: found 'l', expected: ')'
> 480arch/arm64/kernel/entry-fpsimd.S:98: Info: macro invoked from here
> 481arch/arm64/kernel/entry-fpsimd.S:282: Error: found 'l', expected: ')'
> 482arch/arm64/kernel/entry-fpsimd.S:98: Info: macro invoked from here
> 483arch/arm64/kernel/entry-fpsimd.S:282: Error: unexpected characters
> following instruction at operand 3 -- `bic x2,x1,(0+(((unsigned
> long)~0ULL-((unsigned long)(1)<<(0))+1)&((unsigned
> long)~0ULL>>((sizeof(unsigned long)*8)-1-(3)))))'
> 484arch/arm64/kernel/entry-fpsimd.S:98: Info: macro invoked from here

-- 
With Best Regards,
Andy Shevchenko



