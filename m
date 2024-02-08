Return-Path: <linux-kernel+bounces-58419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42CD584E643
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 18:09:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D30E51F291BA
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 17:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20887134759;
	Thu,  8 Feb 2024 17:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SgEMSM1L"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFEE886AFF;
	Thu,  8 Feb 2024 17:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707411881; cv=none; b=u9QwLhzrTbdxGnlWw8NQLs6rbokcKNgj7WWcZi89qOQnYHNcqG35KvwoHju/u8Ch2TsssaMxogS2nV6Qy+KOxgoge0vzcgS8vgBFOiWhqJXoaxHJh9GYxuu+11EU4N+5o39A24Wi1eT7MSTZh1s8gLI/pvpDnXMQXw7LUhJRPqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707411881; c=relaxed/simple;
	bh=PTrnrsT2Geunz+SnN8BD71O48bXNxNI49r+JQOFpfQI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UgQTZxazvcBL+ZfKvW4Q1nyppZOArfIb74Kcb2grcszjakLShGDublWeEuUl1bKkRkErlMvJ5c5/GHx13YFgCtlheBRA+ZeILf5S0Tb6ryQc+R5q0Cys2qpTtbzp6yzIM4hkWx2iVXRkGVtsRcc3apsPnd2Fdqk49li3cGzoKXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SgEMSM1L; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707411881; x=1738947881;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=PTrnrsT2Geunz+SnN8BD71O48bXNxNI49r+JQOFpfQI=;
  b=SgEMSM1LEmWMWwg5ST4wosPaJ1uN59v/82j1aII1eKFlfTiRHIWaUj7e
   R5eD5+TJeUcw7qg1rLghe/Ec+8u7TNW58f6D4ljdCkVT1tQyGZmX1CTvM
   Y6cGKeYqcCvJASoDvAzU4EO/r1QUthykU3fELm9gCPF4p1lYqP6ISqIQa
   d9aaOhJFgO2LO32BspAIvsNYOgm2qTN27etCOK0UTKBuoXztOEFtI+ivW
   9nPuwq82gI+RMqfk9kfpzh1eFgu70vkfIHN7Z8QWF3CFvIB8v1XnEpbyq
   pJXUnazy20IWUSsZxfvIbrRABuF9GpQ8sQZ907nSNqupdMF6Pjhomh/mq
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="11836371"
X-IronPort-AV: E=Sophos;i="6.05,254,1701158400"; 
   d="scan'208";a="11836371"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 09:04:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="910425503"
X-IronPort-AV: E=Sophos;i="6.05,254,1701158400"; 
   d="scan'208";a="910425503"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 09:04:36 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rY7pC-00000002vkG-0CEj;
	Thu, 08 Feb 2024 19:04:34 +0200
Date: Thu, 8 Feb 2024 19:04:33 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Raag Jadav <raag.jadav@intel.com>, jarkko.nikula@linux.intel.com,
	mika.westerberg@linux.intel.com, lakshmi.sowjanya.d@intel.com,
	linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/5] pwm: dwc: drop redundant error check
Message-ID: <ZcUJoSMhgC7lhY-H@smile.fi.intel.com>
References: <20240208070529.28562-1-raag.jadav@intel.com>
 <20240208070529.28562-2-raag.jadav@intel.com>
 <qrwcje4t2pbbxilnlfz2q7njodcp6vl54uaypdbvjgvwhgvc5g@4eq5wvumpjjx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <qrwcje4t2pbbxilnlfz2q7njodcp6vl54uaypdbvjgvwhgvc5g@4eq5wvumpjjx>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Feb 08, 2024 at 08:46:44AM +0100, Uwe Kleine-König wrote:
> On Thu, Feb 08, 2024 at 12:35:25PM +0530, Raag Jadav wrote:
> > pcim_iomap_table() fails only if pcim_iomap_regions() fails. No need to
> > check for failure if the latter is already successful.
> 
> Is this really true? pcim_iomap_table() calls devres_alloc_node() which
> might fail if the allocation fails. (Yes, I know
> https://lwn.net/Articles/627419/, but the rule is still to check for
> errors, right?)

We do not add a dead code to the kernel, right?

> What am I missing?

Mysterious ways of the twisted PCI devres code.
Read the above commit message again :-)

For your convenience I can elaborate. pcim_iomap_table() calls _first_
devres_find() which _will_ succeed if the pcim_iomap_regions() previously
succeeded. Does it help to understand how it designed?

-- 
With Best Regards,
Andy Shevchenko



