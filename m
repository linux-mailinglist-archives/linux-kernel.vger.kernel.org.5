Return-Path: <linux-kernel+bounces-78587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 512B6861561
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 16:18:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BC9828756E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 15:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2554C80615;
	Fri, 23 Feb 2024 15:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bcqvNIJL"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB7E135EF1;
	Fri, 23 Feb 2024 15:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708701530; cv=none; b=YOjnRWyETEzqOrA2Rqwg07lz2HwHlMF/VuYyyMny7ve38WbgsSVRxeODVP+I8YbrRV4PK/b3h6aT3GR5YjuMqqx/LyjbitwutyubiBXzjKFXf1rfbLGnmHcqrcZ43gGFkV4evRVZjTse/At+Fd8tjvMcO4knkLP0QuVH+1aCvPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708701530; c=relaxed/simple;
	bh=Os0Q+W8N00jfigFeOBwUgp4cCuPYza9m4uboeFPhkXA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KANTopI2jHYcdkA52kk8pZfnKVhISLzNuNxuTt7kgjp9eqL+I6iD5N5+yg/FaB0qIoqWzayfb4m5HLVLm5veF45wzqA3hjKc3t36wXFVCLAaRX8D1iGsCmONKRrkolOoGLisvu8gM+M0e0uxlFwyUxsb+LO1nMVb8SOMgA0f+w8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bcqvNIJL; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708701529; x=1740237529;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Os0Q+W8N00jfigFeOBwUgp4cCuPYza9m4uboeFPhkXA=;
  b=bcqvNIJLElnWzaJp9iqp5vX/V8opbg6mgNbilvW0t8aSWx3r8KhTmf2z
   CBII8sFzy7m6P/MGE+Xv9l/86tQ3tlR5/jUNW+xkMWVztf5Fq0bsbzshH
   Uc7u3AgFG6I77I2FMdYrQW4eFPBGtgFrKNW3Q3jguVuJ5nHLjnDFQz31u
   UYuLjno8Hstk1KQk96pVIuFI93ipIKUjZPGf9PQA0fdgFj2HwQucEdIIL
   fFySqjdo15g3+l9Mws+9wA7XbRWoqkqhscR5mql7rLfj0zJiU0KssF30+
   35cfwsJZ8jEWi5SGGtEcmmkJVijmPmgxvjqZcjyB8bthljTu9E06pbBiE
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10993"; a="6837496"
X-IronPort-AV: E=Sophos;i="6.06,180,1705392000"; 
   d="scan'208";a="6837496"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2024 07:18:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10993"; a="913748814"
X-IronPort-AV: E=Sophos;i="6.06,180,1705392000"; 
   d="scan'208";a="913748814"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2024 07:18:44 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rdXJx-00000006vvg-1Kjl;
	Fri, 23 Feb 2024 17:18:41 +0200
Date: Fri, 23 Feb 2024 17:18:41 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Guan-Yu Lin <guanyulin@google.com>
Cc: rafael@kernel.org, pavel@ucw.cz, len.brown@intel.com,
	gregkh@linuxfoundation.org, petr.tesarik.ext@huawei.com,
	rdunlap@infradead.org, james@equiv.tech, broonie@kernel.org,
	james.clark@arm.com, masahiroy@kernel.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v3] PM / core: conditionally skip system pm in
 device/driver model
Message-ID: <Zdi3UWWRfKw1N_Jn@smile.fi.intel.com>
References: <20240223143833.1509961-1-guanyulin@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240223143833.1509961-1-guanyulin@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Feb 23, 2024 at 02:38:29PM +0000, Guan-Yu Lin wrote:
> In systems with a main processor and a co-processor, asynchronous
> controller management can lead to conflicts.  One example is the main
> processor attempting to suspend a device while the co-processor is
> actively using it. To address this, we introduce a new sysfs entry
> called "conditional_skip". This entry allows the system to selectively
> skip certain device power management state transitions. To use this
> feature, set the value in "conditional_skip" to indicate the type of
> state transition you want to avoid.  Please review /Documentation/ABI/
> testing/sysfs-devices-power for more detailed information.

..

> +static ssize_t conditional_skip_store(struct device *dev,
> +				      struct device_attribute *attr,
> +				      const char *buf, size_t n)
> +{

> +	int ret;

> +	if (kstrtoint(buf, 0, &ret))

Why is it int? It seems like flags, should not be unsigned as u32 or so?

> +		return -EINVAL;

Do not shadow the real error code without justification.

> +	ret &= (PM_EVENT_FREEZE|PM_EVENT_SUSPEND|PM_EVENT_HIBERNATE);
> +
> +	dev->power.conditional_skip_pm = ret;
> +
> +	return n;
> +}

> +

Redundant blank line.

> +static DEVICE_ATTR_RW(conditional_skip);

-- 
With Best Regards,
Andy Shevchenko



