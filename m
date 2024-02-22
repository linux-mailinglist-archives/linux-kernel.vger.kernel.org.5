Return-Path: <linux-kernel+bounces-76965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7943585FF25
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 18:19:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A608289B3A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 17:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B56E815530A;
	Thu, 22 Feb 2024 17:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gMOPKaTA"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 589AC1552EF;
	Thu, 22 Feb 2024 17:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708622282; cv=none; b=eRnssKK2D9nZ3MrI+rOp1QqqXB3NU9Q6hjPQTKDJwvfRVRxmm8a2ccwguo8a/UmK2YNLKhZz/fxzI8ea41DUVQx6SPhe3xmAYoBoTEwS8W12TphWIGqfnQ0bCLi0eTwCUh/FlndSdcc508Nk4z3fwZ0KvMfPOqYMFhQlxrskdxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708622282; c=relaxed/simple;
	bh=O/0Gz7vAaC3S8gLPnPm8qA1Nclu74fJDM5Pg0xVTtyk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NzjDIUF9IvfdIP2yLDHXXWKQ8MvePZkE77ehgK0hRtyqCaHVRLFsp7WXHhZt/PPGEJoRzw7VGJuNXxJVzGMT02IqEmdY57wGI3OUsqnHVyVz5YoSiGThLAU05yxjdkjwMGe+rZRTNPExw43o3oiXPNRmcnQZsMbiRLs8nfhkDWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gMOPKaTA; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708622280; x=1740158280;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=O/0Gz7vAaC3S8gLPnPm8qA1Nclu74fJDM5Pg0xVTtyk=;
  b=gMOPKaTAF61gyHWbKikw3IZ5Ad3/ps94TsUA83JbXox+p7cqN8JXRpfI
   2h11bQghu19s5B3quAH4SBcluJqlzZ4wIdn0QD5CJGLoGQrsKDVwuIKND
   JVVlMW57X5sxHWTL4/MbdyD5r7yGSHRSrGYmPbYd+fvjojOsF8tJdI5BI
   sdc4KWAiW+NgVSZkIUnrKNp9lfn9GQrrH9ptXuvOm3rSbFtiTsBL/VoJ9
   iHavKs9s4ZawdOnHywo8G3bpqgmzs6tyJyrmHQEr/cfbm5jprmyG3uNeG
   Cy+IJChzDwVruqTAkoyKU8dMKCK9DjfF5Am9fk3GY+743zOxk1QJ9QJ4G
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10992"; a="6683638"
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="6683638"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 09:17:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10992"; a="913558245"
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="913558245"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 09:17:58 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rdChn-00000006ggT-3yHX;
	Thu, 22 Feb 2024 19:17:55 +0200
Date: Thu, 22 Feb 2024 19:17:55 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Kees Cook <keescook@chromium.org>
Cc: linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v1 1/1] kernel.h: Move lib/cmdline.c prototypes to
 string.h
Message-ID: <ZdeBwyCyFx13LTEC@smile.fi.intel.com>
References: <20231003130142.2936503-1-andriy.shevchenko@linux.intel.com>
 <202310031638.D39E80C32B@keescook>
 <CAHp75VeqvxjqXjmF8ymEYevJkCoQVnkJiuBkccHuGsU_E14LzA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75VeqvxjqXjmF8ymEYevJkCoQVnkJiuBkccHuGsU_E14LzA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Oct 04, 2023 at 12:27:41PM +0300, Andy Shevchenko wrote:
> On Wed, Oct 4, 2023 at 2:39 AM Kees Cook <keescook@chromium.org> wrote:
> > On Tue, Oct 03, 2023 at 04:01:42PM +0300, Andy Shevchenko wrote:
> > > The lib/cmdline.c is basically a set of some small string parsers
> > > which are wide used in the kernel. Their prototypes belong to the
> > > string.h rather then kernel.h.
> >
> > I think these should live in string_helpers.h not string.h (which is, in
> > theory, supposed to be used for the standard C string library functions,
> > though that's not 100% currently)...
> 
> These are being used in the early stages where usually we have
> string.h. So, I would argue, but if you insist, I can move them. What
> about lib/argv_slit.c then? Because semantically it's quite close to
> what the lib/cmdline.c is doing.

So, if no further ARs, can we got this applied and move on?

-- 
With Best Regards,
Andy Shevchenko



