Return-Path: <linux-kernel+bounces-87042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5C7D86CE91
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 17:17:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C9A928B22D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 16:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C870975818;
	Thu, 29 Feb 2024 15:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k2mfONSN"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B495B75806;
	Thu, 29 Feb 2024 15:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709222235; cv=none; b=H6XlB5pakAaascZdBpT75Ipa/6CsvjUJD9kueesqaUoBKTMpk+RW340ewZr7xo/9KAbaniRpst6tFR89MJ7oAxFFu6AUYRh5DFgOGt8SD9PNYA8SyPTuyxqG9VYask8a6CWBulW2ljNDv1dko5yCmzFk9FmqzIiL9jzF3Sy0ttQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709222235; c=relaxed/simple;
	bh=eSlEN/iJzANN4Xwpoo5Ob1nnavsLRUR53xKJkQaQ76s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TWePj+bMZ6wVvcXlsdS3CNR+BEC9juFaAg1v4cfeKC+qwOpm5yhnRxYAbTBwKaCMdkBWOOt+5bOM080FEu7o0Mo4Ld15+MxUWweMboynpjKGMdBK+1kayBbsiGEPHt3zx3f12PKgUhBNvNjopYbR+nJ6DEzoL9UgCaqArckOa6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k2mfONSN; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709222234; x=1740758234;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=eSlEN/iJzANN4Xwpoo5Ob1nnavsLRUR53xKJkQaQ76s=;
  b=k2mfONSNyDuOtBKpzf+3VhZB8g+6MoEA4KvJgFQsEL6A/D/76l7Et5vV
   7deNGl8Nu5GNSN/JAUYtunEPS/EpQS1iqty/n0RGfaooTxAXGgLbVjgtC
   TO41qzBWgMSab7Lbdv0DGX0ZwSh7J5POOJObC3K3KGBRIbf/vH21Rp95I
   Hp4QGW6Vs2m1+IRJuWKfbFtCuKolD7WLzJKPYlgANJYcmwEkkDj/Xh6TH
   5VGT8S4dJpoV+4v5BAf/zURszF+ufKXeptXaO2zeZGFKqCTqf7GnduStf
   c1sMs5KsQT7hzgNTuh87uG8rWsCYTglOazRFjx8qsrANEs1I+7m0ANm+Y
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10999"; a="3555527"
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="3555527"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Feb 2024 07:57:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10999"; a="913985249"
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="913985249"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Feb 2024 07:57:10 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rfimR-00000008iFA-3NeJ;
	Thu, 29 Feb 2024 17:57:07 +0200
Date: Thu, 29 Feb 2024 17:57:07 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: Bagas Sanjaya <bagasdotme@gmail.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux x86 Platform Drivers <platform-driver-x86@vger.kernel.org>,
	Linux Regressions <regressions@lists.linux.dev>,
	Linux Stable <stable@vger.kernel.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Klara Modin <klarasmodin@gmail.com>,
	Hans de Goede <hdegoede@redhat.com>,
	"danilrybakov249@gmail.com" <danilrybakov249@gmail.com>
Subject: Re: Fwd: Continuous ACPI errors resulting in high CPU usage by
 journald
Message-ID: <ZeCpU8PC3Fs5ZiOc@smile.fi.intel.com>
References: <Zd2bsV8VsFJMlbFW@archie.me>
 <43nj7od4luzqjmto7tddhtp5kqi5gbqgeq5v5qiqijydkjgma5@li525a32nds3>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43nj7od4luzqjmto7tddhtp5kqi5gbqgeq5v5qiqijydkjgma5@li525a32nds3>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Feb 27, 2024 at 09:57:28AM +0000, Shinichiro Kawasaki wrote:
> On Feb 27, 2024 / 15:22, Bagas Sanjaya wrote:
> > 
> > On Bugzilla, danilrybakov249@gmail.com reported stable-specific, ACPI error
> > regression that led into high CPU temperature [1]. He wrote:
> 
> Thanks for the report, and sorry for the trouble.

Heads up. The problem seems with the caching algo which includes function 0
to be scanned. The investigation and fix development are in progress.

-- 
With Best Regards,
Andy Shevchenko



