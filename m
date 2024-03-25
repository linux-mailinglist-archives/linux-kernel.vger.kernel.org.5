Return-Path: <linux-kernel+bounces-117247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C890388A911
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:25:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D95F1F60CC4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3929137C32;
	Mon, 25 Mar 2024 14:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FyGEGrqc"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABBAF12BE93;
	Mon, 25 Mar 2024 14:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711376666; cv=none; b=sJtrwbPwTDJr22LG8UNL1hf0Nf/PWL88y/Vq4lcFvp15m1yP+VvnyAWugxj7apSe9IPi0G+dF4gO2mz6IcxEyb/LIeoqVb4BUQpzAPa82t41N+31yOXcJvVdOHLYz2qie7DbEgEohUZMmzCfB7T+TuZ8AkpG3ayIj8bH2JN6msM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711376666; c=relaxed/simple;
	bh=n7AYIpBNE4Gj2MIGAfcW8LUXQxcPg7bE9HkjkhemoBQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vCZLpCf2FKHC+VpC7kK2fVdj+V3KqomQWfAHuy/N63ENX++pUA3bMLZoaX8JeD3jZo0wW0cjETLAyaYHGi1fV2CDx1UJfZpbNgz0yFT9uf1CXJlVDMGPHOosZ5E6W8x+QpvJwquLVBUKQs5ijncj3JiHOQ0kmxdksgItP8CR4QA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FyGEGrqc; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711376665; x=1742912665;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=n7AYIpBNE4Gj2MIGAfcW8LUXQxcPg7bE9HkjkhemoBQ=;
  b=FyGEGrqcQ44O5yn1XLSfoqHdsN9zbcc5NsKL15ZBeGX4HIHYCQJfZTyQ
   6l89a6J5PWSQvcVwDeMcVl6Bk74vReHYfL1MUK2YPCVpEkFJAXnsDzdNJ
   3JIDjCrlnNG/HWcchkWmJacd8KgiMVfrVttFSXZijKpV+7qN2tES08gin
   b4qLEKT5RgtKYfxoLQwVHQWspUye3wjxpmukleHLOjuwx78mRPbXJgplW
   uikqvwHwsqDWH2dsj2jRuoADlqPPT2RkVk5Z7eA9uvrX9sqigDahlJ61v
   e97sfuwsmDhCV4kNYdnhyXVRsYzPTpA5HqgftzfLiu/iEbbDhVoRy0U/3
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11023"; a="17814021"
X-IronPort-AV: E=Sophos;i="6.07,153,1708416000"; 
   d="scan'208";a="17814021"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 07:24:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11023"; a="914844881"
X-IronPort-AV: E=Sophos;i="6.07,153,1708416000"; 
   d="scan'208";a="914844881"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 07:24:22 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rolFL-0000000G0aH-44f8;
	Mon, 25 Mar 2024 16:24:19 +0200
Date: Mon, 25 Mar 2024 16:24:19 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mark Brown <broonie@kernel.org>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: Re: [PATCH v1 1/1] ASoC: soc-jack: Get rid of legacy GPIO support
Message-ID: <ZgGJE0JNAESe5xUf@smile.fi.intel.com>
References: <20240318202602.182619-1-andriy.shevchenko@linux.intel.com>
 <e6900b97-c1b7-45a5-bc3c-4a4a2745fdf3@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e6900b97-c1b7-45a5-bc3c-4a4a2745fdf3@sirena.org.uk>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Mar 25, 2024 at 02:16:15PM +0000, Mark Brown wrote:
> On Mon, Mar 18, 2024 at 10:25:16PM +0200, Andy Shevchenko wrote:

..

> > If I am not mistaken, after
> > https://lore.kernel.org/r/20240318200804.181516-1-andriy.shevchenko@linux.intel.com
> > there is no more users. Hence the above is the only dependency.
> 
> You are mistaken, please try compile tests:
> 
> /build/stage/linux/sound/soc/generic/simple-card-utils.c: In function ‘simple_util_init_jack’:
> /build/stage/linux/sound/soc/generic/simple-card-utils.c:755:20: error: ‘struct snd_soc_jack_gpio’ has no member named ‘gpio’
>   755 |         sjack->gpio.gpio = -ENOENT;
>       |                    ^
> 
> (this is among other things in x86 allmodconfig).

I usually enable the particular drivers and I have compile tested this,
but indeed, I haven't enabled _all_ modules.

Thank you for the pointing out.

-- 
With Best Regards,
Andy Shevchenko



