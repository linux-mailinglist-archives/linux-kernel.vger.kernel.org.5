Return-Path: <linux-kernel+bounces-81766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6ED2867A1F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 16:25:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7227B2BC32
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 15:17:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18BA912D76F;
	Mon, 26 Feb 2024 15:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iQ5DYI//"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 241621BDD8
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 15:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708960265; cv=none; b=cl6bmad0s16LV2C1q9seEK9dUDEqJzWJ0TcWq/79nc+oyNZkK2nupegjZo6oOsqyqAHhspc93wG8oiULqd/QtD73ByZIh5zwemmUE4k47w2qBwlddfqmquNda/6NNnENlvL0NXF6NussPhu+Rsc9ZyFTaFprYt5ev1zeAnimJpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708960265; c=relaxed/simple;
	bh=JcCMhwYI/pAOkjaeQfNlKLNrW7x1kCS/e8P8N5NWzEI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DSRqscuxD6t9ve+a6dYj3IcYr6il9GbGfeWbkqdWAsce/YJbPonwM8P0GfusWDaGl7XGa2uWfiqK+byeBjvIOQW2jc9edJWZ0aA8hWN6hjromVTWLJGvQmLnhwakR9q1GEELC2VYeI/1iruCRzbAMi0B1vrUr0Lq3nd9y0REU6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iQ5DYI//; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708960263; x=1740496263;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=JcCMhwYI/pAOkjaeQfNlKLNrW7x1kCS/e8P8N5NWzEI=;
  b=iQ5DYI//BNJRkH7PQBX8foFdZw/Z4pjIjwjcZdMhX2y1xwKMBiLX2yXX
   StMIRwGXjK2dAXKqgK2pGOdx4qsRoHJkf0WBGyd2Xw1zjzexjLu/X2zd0
   9DuKeXoZr/2Gal7BeVPkcInl61pWJKdoZlskPlSF+XPFA4z7thp5uObsC
   vfhNOKNtPdVcmB295YHkf/1QSB6u9ioF6arpGzXEZrxZZ1HDP5qd6+9Fa
   /RRLyiZqDsFZ65RDO9zlUWGBRnE/fi2V6/ZoH/aq9yfQcxoy5yMLNCSln
   3KXMo4p6r5fPrhCKmdESPsJqvUd73CdwNdQFwhtOtzZzkSEE1O4FxDbp1
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10995"; a="3107758"
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="3107758"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 07:11:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10995"; a="913875895"
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="913875895"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 07:10:59 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1recd6-00000007iDB-3l9c;
	Mon, 26 Feb 2024 17:10:56 +0200
Date: Mon, 26 Feb 2024 17:10:56 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	intel-gfx@lists.freedesktop.org, Petr Mladek <pmladek@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/12] drm/i915: Indicate which pipe failed the fastset
 check overall
Message-ID: <ZdyqAMfEfhyk6zm2@smile.fi.intel.com>
References: <20240215164055.30585-1-ville.syrjala@linux.intel.com>
 <20240215164055.30585-2-ville.syrjala@linux.intel.com>
 <ZdfApN1h97GTfL1t@intel.com>
 <Zdj2ONs8BZ6959Xb@intel.com>
 <87bk83mfwp.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87bk83mfwp.fsf@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Feb 26, 2024 at 04:57:58PM +0200, Jani Nikula wrote:
> On Fri, 23 Feb 2024, Ville Syrjälä <ville.syrjala@linux.intel.com> wrote:
> > On Thu, Feb 22, 2024 at 04:46:12PM -0500, Rodrigo Vivi wrote:

..

> > I think the proper solution would be to have actually
> > sensible conversion specifiers in the format string.
> > So instead of %<set of random characters> we'd have something
> > more like %{drm_crtc} (or whatever color you want to throw
> > on that particular bikeshed).
> 
> Personally I suck at remembering even the standard printf conversion
> specifiers, let alone all the kernel extensions. I basically have to
> look them up every time. I'd really love some %{name} format for named
> pointer things. And indeed preferrably without the %p. Just %{name}.

It will become something like %{name[:subextensions]}, where subextensions
is what we now have with different letters/numbers after %pX (X is a letter
which you proposed to have written as name AFAIU).

> And then we could discuss adding support for drm specific things. I
> guess one downside is that the functions to do this would have to be in
> vsprintf.c instead of drm. Unless we add some code in drm for this
> that's always built-in.

-- 
With Best Regards,
Andy Shevchenko



