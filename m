Return-Path: <linux-kernel+bounces-98957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BE79A878195
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 15:26:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 794BB1F24281
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 14:26:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 092533FE4C;
	Mon, 11 Mar 2024 14:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ve6LwyeZ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD6C3FBBA;
	Mon, 11 Mar 2024 14:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710167155; cv=none; b=jKpJLMCy92aMICE9B44ZvpBW9unWpSxEpXFDC0J/bVZhspeCW/EYHm7/P1n2hMvdw1X7gwRJ3+zZO3wSbYvnZMVU13xOgu9opGzwSB8Xqh2cHxDCePApQ2beYFnqxkELz7+RmTNp917pVgsLo2CQKj17BCqoh1U/EgBkpjDaNi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710167155; c=relaxed/simple;
	bh=3EO+X4FVrYQQ7pN1391msu9E8YQJAXij990MMl3E35o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r9h/iePah2nxyaYndxkSXqtqfsbAdYR+wDOfQ6t8sti7RuSSvPcVB2JeHMEyZGu8EOW6hB14ET//1aW5AfQO2ic6I93DMtc+oy1yBKI6AYVXLl16R+c3xw6BPdcJylmUix2FQ0vjO6LvV/jSOha1Jm9ikafmy83ivwR9qrvLUdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ve6LwyeZ; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710167153; x=1741703153;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3EO+X4FVrYQQ7pN1391msu9E8YQJAXij990MMl3E35o=;
  b=Ve6LwyeZb7nd0G2AIug62wSkrpdG5wYJY/xa9Bt8IgYDkLVTd+V3kLse
   kflte/vJKGkpBylPRl6wIN1xs61zobScasUknPxQdF9ehQZD3KoOkG4ii
   7Z8dFJ1paM5/LXH/gOd8EJNF/hcidI5MCLQMUIAKsvfuWGd3wozd9hcOR
   3zJTHR1RDd0wKIAr7UshjtdgBXhZhBVKBxRz6beElzlTCSIA2KjZp+mr8
   fTmaeVzvkJ1WXKL9UAKSK7wT8xw3N0hiVvqWxSQXcUFgflfjncnnl+bD2
   Mv/moNhYKHVsT9ImIJyKIoaFZc8iTPhZiiNR59WtCn/SNPDoB2oVen52D
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11009"; a="15470984"
X-IronPort-AV: E=Sophos;i="6.07,116,1708416000"; 
   d="scan'208";a="15470984"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2024 07:25:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11009"; a="914361324"
X-IronPort-AV: E=Sophos;i="6.07,116,1708416000"; 
   d="scan'208";a="914361324"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2024 07:25:51 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rjgb7-0000000BeLH-26Z1;
	Mon, 11 Mar 2024 16:25:49 +0200
Date: Mon, 11 Mar 2024 16:25:49 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Sean Young <sean@mess.org>, Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: Re: [PATCH v1 1/1] media: rc: gpio-ir-recv: Remove unused of_gpio.h
Message-ID: <Ze8Ubb5YQ4DzNHTt@smile.fi.intel.com>
References: <20240304180510.1201042-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240304180510.1201042-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Mar 04, 2024 at 08:05:10PM +0200, Andy Shevchenko wrote:
> of_gpio.h is deprecated and subject to remove.
> The driver doesn't use it, simply remove the unused header.

Sean, are you okay with this change?

-- 
With Best Regards,
Andy Shevchenko



