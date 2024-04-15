Return-Path: <linux-kernel+bounces-145279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 911988A51F7
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 15:43:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2D9D1C2213A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 13:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EA397C090;
	Mon, 15 Apr 2024 13:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GDFferfj"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22B0078C81;
	Mon, 15 Apr 2024 13:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713188441; cv=none; b=LWJbrjTZQLehb/0IUb1dfq5pGub7iHiJGEiXolIrdaPsb9zpkCqyv4b13cpzxWYqRFKSFRwBBaQbtxrptGtBAuNfulucKI10WYnViZf8cD1WVRxOFtQzya1niV90sV313Md52PJLvZIzIawGWJ2h0w5XWx701lYXyxLOuLTlduE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713188441; c=relaxed/simple;
	bh=jswgADzYLisK/+q+Lljjrhqiq0M5wIMXmq+RZcfr7Do=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WwyeENqknqB9K4QC+RBm64v1c011aPNNl50cTLzil7Jo38zedmBuNJBLgz89+g+0qX3vs0pxsoDDAMHFOojxYEye9vplWu5E8CZGvQcSWVJcHnLReHX9VHPY0GrkC7ezcw5blKRSmQCZPBpVZmDnGK8pLiUhfk1ONempxkOuJsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GDFferfj; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713188440; x=1744724440;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=jswgADzYLisK/+q+Lljjrhqiq0M5wIMXmq+RZcfr7Do=;
  b=GDFferfjflf1nlaRwkRdl4PBySItTEFdZA8N7iUkNwHaHvrn/DDq/Mlp
   Mtx30FpmL7sqgX7LKORK1EGuxLFlRM4BzBOvoL0sEkgo3ijt4MvEvIEkv
   W2glZN9IW8Suz1u6A98+jBmK0jNTxMZ9o+AmM7eI18X/xxlhVK+MYBfye
   pArF4wLXgOrM8qWAPV+5dlgyYamQqKbXosz2FvKd+Clevk66lFBjZQZyw
   0vpBMX84g6yzCY4w82Ogc2Vs7KK96Uh45fDjoehhf8dA2H+JmY0ugmclZ
   qKkCyEeD9se0bIkr6UzG6T5UmNhONfwNhZyNf3kmMWBQ2QbIVkD6cmGwh
   A==;
X-CSE-ConnectionGUID: 1O4jSvwwT8yg7EasQyJslQ==
X-CSE-MsgGUID: RlW+L7+CQ/yXmtKdiBVVVA==
X-IronPort-AV: E=McAfee;i="6600,9927,11044"; a="20002197"
X-IronPort-AV: E=Sophos;i="6.07,203,1708416000"; 
   d="scan'208";a="20002197"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2024 06:40:39 -0700
X-CSE-ConnectionGUID: tj2iD4lQQOK1BCH9L2p/Cg==
X-CSE-MsgGUID: zHMc3HfyRjKLiRiEMjp6sQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,203,1708416000"; 
   d="scan'208";a="26582753"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2024 06:40:38 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rwMZX-00000004QCO-0p5e;
	Mon, 15 Apr 2024 16:40:35 +0300
Date: Mon, 15 Apr 2024 16:40:34 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v1 2/2] mmc: sdhci-acpi: Use
 devm_platform_ioremap_resource()
Message-ID: <Zh0uUjdHg1qV0RfT@smile.fi.intel.com>
References: <20240412184706.366879-2-andriy.shevchenko@linux.intel.com>
 <20240412184706.366879-4-andriy.shevchenko@linux.intel.com>
 <b8751b8d-f42d-4121-836d-f21b91df1b7e@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b8751b8d-f42d-4121-836d-f21b91df1b7e@wanadoo.fr>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Apr 15, 2024 at 07:20:49AM +0200, Christophe JAILLET wrote:
> Le 12/04/2024 à 20:46, Andy Shevchenko a écrit :

..

> > -	len = resource_size(iomem);
> > -	if (len < 0x100)
> > -		dev_err(dev, "Invalid iomem size!\n");
> 
> Was this test useful?

I'm not sure. ioremap anyway works on page size granularity on many
architectures, but even besides that, the check was from day 1 for unknown
reasons. Perhaps can be safely removed.

> Should it be mentioned in the commit message?

Or in a separate patch. I'll think about it.

-- 
With Best Regards,
Andy Shevchenko



