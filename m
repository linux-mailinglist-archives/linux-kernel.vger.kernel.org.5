Return-Path: <linux-kernel+bounces-58643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64BD284E953
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 21:05:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 022E91F21DD7
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 20:05:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4C45383AE;
	Thu,  8 Feb 2024 20:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YsulmrBi"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ECBC38384
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 20:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707422696; cv=none; b=Ig5XSyQXpSYvdHoYXy1aHNRf+sw27PnnzMmqqUfPC8M6B91u/IBGLpKbNvOFXS3ESwtwAXPjypxYhnIzsZ/7sqSPSK23Q63rF9IeenxQ2mefY+x0fJ1CMIwHueCOLnnAYLhAhiUdP38mUTZuOollOIwbNlPbOXV1lVOad8WxLvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707422696; c=relaxed/simple;
	bh=3z64KEFV+ywZgeTSGpLc92WSDJ22y1rSBk7p5RJceio=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dCYwLRYM2uFYaQvdaUEKBxussWZM+ceTlhTOq/ZVCla9NDW/DqQU/QTOVSf1OlA0pCV7q6L5+pGak9PlkyeBVNg+/pZ01GEdykfdxdYLOYuvrQTCxekUOLawAixXu2uj+SfzC8JVHfSJwnyGlfDi4pVXiATY6Ib39L7CUBlEDZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YsulmrBi; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707422696; x=1738958696;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3z64KEFV+ywZgeTSGpLc92WSDJ22y1rSBk7p5RJceio=;
  b=YsulmrBiJURUTiaY24gdse/X4MlLvV6EzVijVrpAHwj35axDf8nwyrRS
   O172im+nct3MJD1eG9M9OOIHMBLP0Gohpwq9sg9J6iSGJejhcDZZpNz8q
   jq6/0DW8X+N8soYJ/rk/uNZoHMAmQ2SOHadB40jHy/ttOo22AhGdfF/Po
   R/7uAWgdH/Z91TWdkXTFsv6SJXmJIqCzsfYm8eZsrIaLmY1airsWD4eS3
   UPGQbzodKekz9ZQTJF8DnWongbCT++hh7OAxiXZUTu31J2iUY4whmfoom
   rBQfsOed3O96dgh01zmyN+nJ7nl+CZIYM7gX5U++0jp3qBjNrYJDraW9r
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="12675169"
X-IronPort-AV: E=Sophos;i="6.05,254,1701158400"; 
   d="scan'208";a="12675169"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 12:04:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,254,1701158400"; 
   d="scan'208";a="6409306"
Received: from udig-mobl1.ger.corp.intel.com (HELO intel.com) ([10.246.32.229])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 12:04:48 -0800
Date: Thu, 8 Feb 2024 21:04:45 +0100
From: Andi Shyti <andi.shyti@linux.intel.com>
To: Lucas De Marchi <lucas.demarchi@intel.com>
Cc: Yury Norov <yury.norov@gmail.com>, linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	intel-xe@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
	Jani Nikula <jani.nikula@intel.com>
Subject: Re: [PATCH v3 2/3] bits: Introduce fixed-type BIT
Message-ID: <ZcUz3V56qNeTVq66@ashyti-mobl2.lan>
References: <20240208074521.577076-1-lucas.demarchi@intel.com>
 <20240208074521.577076-3-lucas.demarchi@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240208074521.577076-3-lucas.demarchi@intel.com>

Hi Lucas,

looks good, just one idea...

..

> +#define BIT_U8(b)		((u8)(BIT_INPUT_CHECK(u8, b) + BIT(b)))
> +#define BIT_U16(b)		((u16)(BIT_INPUT_CHECK(u16, b) + BIT(b)))
> +#define BIT_U32(b)		((u32)(BIT_INPUT_CHECK(u32, b) + BIT(b)))
> +#define BIT_U64(b)		((u64)(BIT_INPUT_CHECK(u64, b) + BIT(b)))

considering that BIT defines are always referred to unsigned
types, I would just call them

#define BIT8
#define BIT16
#define BIT32
#define BIT64

what do you think?

Andi

