Return-Path: <linux-kernel+bounces-75496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32A9385E98C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 22:07:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63CA01C22BEC
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 21:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41D3F126F10;
	Wed, 21 Feb 2024 21:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dk8Mxis/"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C7B983CD8
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 21:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708549664; cv=none; b=HXjtDpMX6VM9MeZ50LG2uO4ChYGvv63aDOScTXm6OwySUnMoEs5ogik+qWQbkNSyjm39zY7dwyo7qBS+JoxEHWzSLKHhg29dsJnx6FhIvPylYW/C2wXyvTOCCO4pmkPDJJyrUvvf8j/7NaLZ8LsWS/ZCSnpJUfvGYQbswgI9qjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708549664; c=relaxed/simple;
	bh=nA1youg90/ZP2DIb11j9lh81YY3aAWIu00fTWWD2H/U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cVfSidIoxQvLOixjpmyvBUj5QTTFewSdizqEveZR3KBKMw/7+mOeAr4bTwsdrmuYAFvpJniEwwcTSLH6hLXiMcsVRJNWbnbWqZlojHEO3VkOrL3mSfuDGx80zYwiZ4VWKJkCvzVEAoKXTx90Trz3b362XOcfEKGQwv257Ep6qk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dk8Mxis/; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708549663; x=1740085663;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nA1youg90/ZP2DIb11j9lh81YY3aAWIu00fTWWD2H/U=;
  b=dk8Mxis/i3cG6raRd/dzrrVPbTBo+BUHKv6U8F6eKMnvPOYwJ8Qs6Swl
   1HFwdTNbysGmvMU/8CiGDc7J+vK0xbBNRG8iUNBVCErTCkeggfwTenlq7
   xaibkoRHfO4VpYudt2UE6IBSygFuVfrZrnnHLS0b21h3mi8X9NTjya0gt
   ETZ3zOFGrjNbm2MAED1xS3yeyIZ8uoB/UXyTA0odlYV/sDailBOU7W1nU
   CBEYOKfSmf2bKgQgsRLMkCFMSpz0GKRpbymwoWotRyD64W4el9dSs8+Su
   JtrFJFPzhOLZoP0MiWsSEsCMVPDlAE0BZE0iyrcemnbEOJafyVb7dFQcb
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10991"; a="13297218"
X-IronPort-AV: E=Sophos;i="6.06,176,1705392000"; 
   d="scan'208";a="13297218"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2024 13:07:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10991"; a="913373115"
X-IronPort-AV: E=Sophos;i="6.06,176,1705392000"; 
   d="scan'208";a="913373115"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2024 13:07:40 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rctoX-00000006TCs-16Ap;
	Wed, 21 Feb 2024 23:07:37 +0200
Date: Wed, 21 Feb 2024 23:07:36 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Lucas De Marchi <lucas.demarchi@intel.com>,
	Yury Norov <yury.norov@gmail.com>, linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	Jani Nikula <jani.nikula@linux.intel.com>,
	intel-xe@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
	Jani Nikula <jani.nikula@intel.com>
Subject: Re: [PATCH v3 1/3] bits: introduce fixed-type genmasks
Message-ID: <ZdZmGJHQVF-CBm__@smile.fi.intel.com>
References: <20240208074521.577076-1-lucas.demarchi@intel.com>
 <20240208074521.577076-2-lucas.demarchi@intel.com>
 <CAA8EJpprfrtOjNzT6TFhV1n6MXzLdTahanfxcRW4uVjeHaBduA@mail.gmail.com>
 <CAA8EJpo3X5Ljdf5w8pj+WPQZaqab4mD53VXdAxfLFqsU4mNoPQ@mail.gmail.com>
 <ZdZlwWbYlReLEqRU@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZdZlwWbYlReLEqRU@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Feb 21, 2024 at 11:06:10PM +0200, Andy Shevchenko wrote:
> On Wed, Feb 21, 2024 at 10:37:30PM +0200, Dmitry Baryshkov wrote:
> > On Wed, 21 Feb 2024 at 22:30, Dmitry Baryshkov
> > <dmitry.baryshkov@linaro.org> wrote:

..

> > Excuse me, it seems a c&p from gitlab didn't work as expected.
> 
> No problem, it's clear that the patch has not been properly tested and
> obviously wrong. Has to be dropped. If somebody wants that, it will
> be material for v6.10 cycle.

..which makes me think that bitmap(bitops) lack of assembly test case(s).

-- 
With Best Regards,
Andy Shevchenko



