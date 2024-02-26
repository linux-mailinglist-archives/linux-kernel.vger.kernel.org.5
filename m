Return-Path: <linux-kernel+bounces-81644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F18A28678B2
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 15:36:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC4A62919CE
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 14:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB1E512C551;
	Mon, 26 Feb 2024 14:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ziw/p1Vd"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93BFF12CDA6;
	Mon, 26 Feb 2024 14:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708958081; cv=none; b=Rg0w2XaRMdjwPYCQmtk7Y26oHpja4o62P9A0KckX5r1+emS/w6nP4USmI4Wv1r52tFhYJGpj1SRrBDsSfIsEoxDdWBF1Nm0K7XkpS+3L2E2JWQdJYrHjGdFp7bRXw8aGaMcHvhDgJSKrhofL2RA2gmxePAlx6GFBNdokXk5gT3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708958081; c=relaxed/simple;
	bh=bu+OkSthqFeI7rclWT8FvUzq5JjBdXYPuxeDAoSBvDE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Txvp8huXIdMG82Bv7vy6HWnr3SMSZvEcSqIPEE1Yj4UTVzIfcp87gjN5LQ1KBftuQjhCvbjMgUvLJVpJDkQqxCkmZZGXztTbnF4M25or+qpvsZuq/hJMTK5yypm13UWmzqt3jGQOev2UhpuVQVxCBOAQWlZCvEOIhHiRrIv74I8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ziw/p1Vd; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708958079; x=1740494079;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=bu+OkSthqFeI7rclWT8FvUzq5JjBdXYPuxeDAoSBvDE=;
  b=Ziw/p1VdMhvWvWeSwuWoa0Oo/pM/mgp5XDrL3PtRU7/Uj5Qoxq4TvQh4
   GBHW4ST36SJtNhTqnvs4fCYOacPbER5GYxrm8MPIdZ6BgOv7ZQVZzSxec
   Pywx4FtmHsMVDD0hqndSLLjIWLXMO+UkDWou3NgEScQlkuWHW8b3g8mhK
   mU4AGV1Gj97AyhTtwqdXNI+IGYkjqe3HO9aLYW6/cw6QfFX2RyTHkQDUR
   K+VVYpAoy76sQiIUUBRVwikUCIBdHpi6FMzG4fmV6CAeAlQNMcwuzt8PC
   jqyO34fZMT3+G7M3BWvdOIX+8CoOyoCbURzCEN2JRV8fXFeDpZwHZtwqA
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10995"; a="14679755"
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="14679755"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 06:34:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10995"; a="913873383"
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="913873383"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 06:34:37 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rec3u-00000007hiT-2RWd;
	Mon, 26 Feb 2024 16:34:34 +0200
Date: Mon, 26 Feb 2024 16:34:34 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Duje =?utf-8?Q?Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Cc: linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
	Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>
Subject: Re: [PATCH v2 1/1] leds: expresswire: Don't use "proxy" headers
Message-ID: <ZdyhepOL7YIwPGKJ@smile.fi.intel.com>
References: <20240223203010.881065-1-andriy.shevchenko@linux.intel.com>
 <e4173a45-61ca-4427-85aa-1733406a5f39@skole.hr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e4173a45-61ca-4427-85aa-1733406a5f39@skole.hr>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Sat, Feb 24, 2024 at 05:02:40PM +0100, Duje Mihanović wrote:
> On 2/23/2024 9:30 PM, Andy Shevchenko wrote:
> > Update header inclusions to follow IWYU (Include What You Use)
> > principle.

> Reviewed-by: Duje Mihanović <duje.mihanovic@skole.hr>

Thank you!

-- 
With Best Regards,
Andy Shevchenko



