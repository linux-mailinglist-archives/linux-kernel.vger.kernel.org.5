Return-Path: <linux-kernel+bounces-93983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 52AC28737C7
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 14:36:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F08521F26BB5
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 13:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41FBA130E57;
	Wed,  6 Mar 2024 13:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JZ9n/ao1"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F16C8130AD5;
	Wed,  6 Mar 2024 13:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709732162; cv=none; b=b73sIr3rSrL3VsVYUC1G6P++LVQwJTcVSREjj0ku9ENkEP5ROq5tMvS5n29989Z/oOcFFk9jN4aSLkMMN9r6RMiwHS7cFeD2NC1uTm7xg6xtXBNvV2CNDMdP38On9dzS7rhHzRmQfLX3Zrj8UbofkYhl0qseTE7SAYE+pNsyU2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709732162; c=relaxed/simple;
	bh=MemqcjPwJQZWP7+0A11zacmkdchsbQdVCJLcuQ9fTVc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vD0WZ1pXX3wck02druuwwD9grWvR4FmPIjnbb4fyJxQnpsOtmKNVXIdYwvjwiJTSGSz+Ba2Fur2N7Z/XCu7blt/uNc7IVvTo6n44GGbHMr/mNmI5614xJyKnWolnLesMD4pYec/zXYAq7ImkbmOWXxJXGMd/L36H0nWsl6WgBaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JZ9n/ao1; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709732161; x=1741268161;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MemqcjPwJQZWP7+0A11zacmkdchsbQdVCJLcuQ9fTVc=;
  b=JZ9n/ao1jGuXxel6EGQ0jPZeuFilchgabjj9+tmHjJVJj+WFYd9ji40u
   xblGecaK3vwaKJUWnBAUS8lirsnsH/w6wqlQw8RWZsH0KjKWonO224qxn
   BVXMoV1GD9I25CzLOSfc5/I2vhb4iQHLC6x64ZaZ6hZQ5rDJw/UEtVcdc
   EvLWGnTDpka5Ojqi56q6K8oUiiM8bqkIHIC4boahZdEblBaE3NbDRZdWS
   iRcvGJLoub4ULWauxeM8UeduuvxdmN6BX2VfFM/zR27JIk5ydNul086xv
   CyAIEMK8lNIpSeZrEhsoOIYvh2syzJAt+rlXctV9yct6u7l7JWEn5/FKA
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11004"; a="4207366"
X-IronPort-AV: E=Sophos;i="6.06,208,1705392000"; 
   d="scan'208";a="4207366"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2024 05:36:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11004"; a="914178566"
X-IronPort-AV: E=Sophos;i="6.06,208,1705392000"; 
   d="scan'208";a="914178566"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2024 05:35:58 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rhrR6-0000000AHFQ-2aGk;
	Wed, 06 Mar 2024 15:35:56 +0200
Date: Wed, 6 Mar 2024 15:35:56 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andi Shyti <andi.shyti@kernel.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
	Sean Young <sean@mess.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: Re: [SPAM] [PATCH v1 5/5] media: ir-spi: Unify indentation and
 comment style
Message-ID: <ZehxPFh2ecxsKsOF@smile.fi.intel.com>
References: <20240305174933.1370708-1-andriy.shevchenko@linux.intel.com>
 <20240305174933.1370708-6-andriy.shevchenko@linux.intel.com>
 <hwtodfwrgonzzf2dpoqa3b5b3v66ypp7uu7upsnt6dx7weua2f@byxbgpxurhmf>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <hwtodfwrgonzzf2dpoqa3b5b3v66ypp7uu7upsnt6dx7weua2f@byxbgpxurhmf>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Mar 05, 2024 at 11:52:15PM +0100, Andi Shyti wrote:
> On Tue, Mar 05, 2024 at 07:48:30PM +0200, Andy Shevchenko wrote:

..

> > +static int ir_spi_tx(struct rc_dev *dev, unsigned int *buffer, unsigned int count)
> 
> this goes over 80 characters, though. Not an error, but not worth
> a change either.

It's only 82 characters and I consider this as an improvement in readability.
It's quite pity that some of the subsystems are too conservative, hope this
one is not an obstacle for them.

> I'm not going block the patch as the rest is OK.
> 
> Reviewed-by: Andi Shyti <andi.shyti@kernel.org>

Thank you!

Btw, don't you want to either add your entry into .mailcap and/or update your
email address in this source file (and maybe others)? I Cc'ed you only after
I looked closer to the sources...

-- 
With Best Regards,
Andy Shevchenko



