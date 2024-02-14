Return-Path: <linux-kernel+bounces-65695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48AC1855087
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 18:40:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B2161C2934C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 17:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A64EA84A3D;
	Wed, 14 Feb 2024 17:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jL8OrNId"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CA5683CC7
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 17:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707932433; cv=none; b=maTKVWFxhocxlMWbGXoG1jXcXL+NlWeH/HAN2rx/T6U6TcoPM506W6O0Kp2516R+Zr+R4aggNPhN4YORjxAht8PKbo8+7/PBMZV4R5zWRHE7qyzCLHS7EVwedRB7EQrQCwgkWawP+fcBx/oRSHQnnzPigBZXdUYh/0gfTbz4Hf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707932433; c=relaxed/simple;
	bh=HZSTDjLTjtJutTTm3uF/PqRH0u2jT56Wvocr3fhg+CQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ea77XKdu4oCesjXth7DpbyyEJ8/902sVqGTCKnNDk1ayA1yl9s2H2us34ACRt2RHr/7tFpBrqz1qJzsNFz79jo6e2VqUfSQPBak4wFjBPAMKZZcPcnzFU61kZ7T8iQZddD5SYPi54BL+/34fcKelhK7hoO41q5KsHK38L8ynDdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jL8OrNId; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707932431; x=1739468431;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=HZSTDjLTjtJutTTm3uF/PqRH0u2jT56Wvocr3fhg+CQ=;
  b=jL8OrNId4wj6YGCki4EV5TgbMi7QxixyvQKUY9dCX9qMS2utB9NPOHw4
   R9BMgeXVX2UMCJYqzyx01lk/fM1Mp9XyUFjbBvOxu59U3K8/RoOPdE9et
   K04njc6XVQ2Rhi24Lc7OSGRREaDywEzdDlMBOHPbrh8F91GxwaSxRP2HE
   bCdm8v6jSYhXwG5tBVXN5yjkTyozWkUee+BlSEkqJJoMepCyPzUKrYg+k
   UOL5hwQPmhpdEAQWv54fY937+a6wE/Qo1m65f9R3eIQEoumtsBqkHB07/
   z2zC697sXuqzWifa1PGRSRkiq/P16HdYbp/9sktf6N9zJVK9PVccb8mPj
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10984"; a="13379235"
X-IronPort-AV: E=Sophos;i="6.06,160,1705392000"; 
   d="scan'208";a="13379235"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2024 09:40:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10984"; a="912092379"
X-IronPort-AV: E=Sophos;i="6.06,160,1705392000"; 
   d="scan'208";a="912092379"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2024 09:40:28 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1raJFC-00000004YZP-08cR;
	Wed, 14 Feb 2024 19:40:26 +0200
Date: Wed, 14 Feb 2024 19:40:25 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	linux-kernel@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>
Subject: Re: [PATCH v2 2/3] auxdisplay: Move cfag12864b.h to the subsystem
 folder
Message-ID: <Zcz7Cfc5XSM2MtKV@smile.fi.intel.com>
References: <20240212132515.2660837-2-andriy.shevchenko@linux.intel.com>
 <20240212132515.2660837-4-andriy.shevchenko@linux.intel.com>
 <Zcoe9axtLXxB7Jeo@smile.fi.intel.com>
 <CAMuHMdUJ4gSGo4A0BVGkieWvNyqa9Dv_rQVMFj9N8GWYoKCZVg@mail.gmail.com>
 <CANiq72muoZHzX+qNKabYWnH738okKqrfAruUOpY-4WUJBLP=Yw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72muoZHzX+qNKabYWnH738okKqrfAruUOpY-4WUJBLP=Yw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Feb 14, 2024 at 06:15:48PM +0100, Miguel Ojeda wrote:
> On Wed, Feb 14, 2024 at 5:59 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> >
> > /me looked at your branch
> >
> > Just use a pattern? drivers/auxdisplay/cfag12864b*
> 
> +1

I don't want to rebase, esp. taking into account the proposal below.

> In fact, for `cfag12864b{,fb}` and `ks0108`, they should probably go
> into staging anyway and removed if nobody complains (I am not aware of
> anyone using them nowadays).

Send a patch?

-- 
With Best Regards,
Andy Shevchenko



