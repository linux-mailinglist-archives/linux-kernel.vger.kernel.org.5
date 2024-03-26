Return-Path: <linux-kernel+bounces-119856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2684488CDD0
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 21:04:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0CA71F65CAD
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 20:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B0BE13D290;
	Tue, 26 Mar 2024 20:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Wi9j+7bl"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0569D3DABE1;
	Tue, 26 Mar 2024 20:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711483490; cv=none; b=q7sTZ58jLOGe+KuDy5aTRkCjk4VOiByE3ETFpj2uhkCwAlsT7iUZRKbPyOrMyQquXOaN75yOR9nHRxvxZlG/0+r88icS9/pwP1fRX61NdHMRAo5268kGyLVHnRnbi7zBHlbwjPUL9dty9sV7cGYJaxfV+N7hdH5bzQbWQPx2jyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711483490; c=relaxed/simple;
	bh=BmIFG4WcPLJlFIuPlSfB+NIT8dikrnWScED+BVvdLYE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cZ4APihdGkvBoPUgYopJBbPFRn/02kuia3f0VhAQ8ClobCsZLaSBgKqfnJPnG3TYK1ehzpga7tLVny8k4mwb76oKBjxRR5G2ZEKrfFvuY2twk4KB9J6IzXQRTu+L4SS5oqz4w+esw8ZiiLqTc0sJ4Xa3Fq4+bdHAFQdR/K5P6vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Wi9j+7bl; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711483489; x=1743019489;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BmIFG4WcPLJlFIuPlSfB+NIT8dikrnWScED+BVvdLYE=;
  b=Wi9j+7blGePKrM6gV2UjtKM3HtT+pFcocDd/3mu8bGlpEbz7DSgqwDvZ
   GRF/YAIzGe5YRVHL3a42TYSt7lJcisNUJPMO0m7g8czSi3SaI2P5XYgwg
   OzvRcEuqu6KMmH+jos/b3uWUFrs6pDtCKN/3pPu2MoemETYelQY0wvBL1
   +NexTs9yF6dfEejQJgdLu609livZV5DE4cJ77xRx3L7OTv3NhtJtlkTG/
   xf3L9vuGeEWldwj4xGPj+8bq5tIEFU50nuEhKpAlAfbzUnDqUf5nycIIJ
   8+YlABwCO/NrpMHKCmZWhDHJ5e2QBHeGc4wLNne7/pRijApaOulNSJIvK
   A==;
X-CSE-ConnectionGUID: 0HgJAdDnQHifcn8kxfADJA==
X-CSE-MsgGUID: BdYPXVWLRfmy+QYu94OUFA==
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="6768768"
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="6768768"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 13:04:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="914889497"
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="914889497"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 13:04:46 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rpD2J-0000000GRSv-1dJS;
	Tue, 26 Mar 2024 22:04:43 +0200
Date: Tue, 26 Mar 2024 22:04:43 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Russell King <linux@armlinux.org.uk>
Subject: Re: [PATCH v1 01/10] spi: pxa2xx: Drop ACPI_PTR() and of_match_ptr()
Message-ID: <ZgMqW6TSHYJ2NOPq@smile.fi.intel.com>
References: <20240326181027.1418989-2-andriy.shevchenko@linux.intel.com>
 <14f08a50-edef-4b36-891e-2b4b2283f40c@sirena.org.uk>
 <ZgMSg5Tr97mWgPW4@smile.fi.intel.com>
 <424de3ed-f0ea-4fc1-80f5-3ab1d23cf1e1@sirena.org.uk>
 <ZgMXe4EMbJ44W1tr@smile.fi.intel.com>
 <c3066481-bac6-48fd-8b38-6797975d83c2@sirena.org.uk>
 <ZgMZhdsDc-bzWa6P@smile.fi.intel.com>
 <4241ecb8-07e4-4613-a289-4699c39d0d08@sirena.org.uk>
 <ZgMf5eISwE2P_1tN@smile.fi.intel.com>
 <a30da48d-f801-4d0a-9db7-9c9bb159ca6b@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a30da48d-f801-4d0a-9db7-9c9bb159ca6b@sirena.org.uk>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Mar 26, 2024 at 07:32:47PM +0000, Mark Brown wrote:
> On Tue, Mar 26, 2024 at 09:20:05PM +0200, Andy Shevchenko wrote:
> 
> > For my knowledge there is none of the ACPI-based platform where CONFIG_ACPI
> > needs to be 'n' while having the real device (as per ACPI ID table) to be on.
> > That's why I answered purely from the compilation point of view.
> 
> I don't understand the relevance of that, and frankly can't make much
> sense of it.

It's relevant to the ID table presence at run-time. But it seems I wrongly got
your point (see below).

> > Personally I see that dependency more confusing than hinting about anything.
> 
> When you don't have a dependency in Kconfig then people get offered the
> device even if it is impossible for it to be useful on their platform.

There is currently a dependency among others PCI || ACPI || COMPILE_TEST

From the point of view of the real platforms it means that if there is
a PCI compiled we support PCI devices that use this "platform" driver.
Similar with ACPI.

What you want is to hide this in the menuconfig for the irrelevant platforms
which have PCI _or_ ACPI enabled, correct?

But if we add x86 dependency to that, it will drop the support for non-x86
ACPI-based platforms with this device. I have no clue what are those.

Yes, we may try to have ((PCI || ACPI) && X86) at the end, but I believe
this will have a good regression effect.


> The purpose of any || COMPILE_TEST dependency is to improve the
> usability of Kconfig.

Right, when I see FOO || COMPILE_TEST I interpret FOO as *functional*
dependency, meaning that without FOO the certain driver makes no sense
from functional point of view.


-- 
With Best Regards,
Andy Shevchenko



