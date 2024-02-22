Return-Path: <linux-kernel+bounces-76591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C76585F9AF
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 14:25:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EE6C286B5C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 13:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B04813340A;
	Thu, 22 Feb 2024 13:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="haKE58fD"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 307C53F9ED;
	Thu, 22 Feb 2024 13:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708608330; cv=none; b=msIs0GjM89Bm8k1nkTgkcQ8qkbzjlCYyqwn52mUxzoFAfF6gsJd7eeLtvAzcc+SpD9Nf9qVaAvCRwrxr9atpVSLDzfj37xOaRGIL+f5BbB6dpqWL0aVPV/xep/AcVVGAWK7talpHXDOX1f3QRXfVcpIkTD3pWa8n1VF8Q5hI0U8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708608330; c=relaxed/simple;
	bh=9SfBk/e/iZIBUTSrdS5oEKXroNAoDwLwvm5z+Wgn6RA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KBIlWX7QHKbBGYsMplWrPMQ+cyY711L7EnwCad/ozwkKO5FkYJwIj6kb6oKviplec/0unnOROxc9N4xIvhXRG0lhc86GjFQc8gWnKVpYNTimM2/YE4MbJvmq3QWm9V2LH2Z8sjNToR4gcJt66APam5Jrge+KRFI4sWiMQfDbykw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=haKE58fD; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708608329; x=1740144329;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=9SfBk/e/iZIBUTSrdS5oEKXroNAoDwLwvm5z+Wgn6RA=;
  b=haKE58fD7Lm+ADvbgbzT5VA7p0tRNZQ0UxyyzUUNVKLwbh74YCC//iO3
   ANgf3To+Q/wIA16UVHgzx93oyIq+bmjkmlVQiOCWQaQ1vuThCviijlS3A
   ar+NAAM+a9sx0tGAAtkNhVSKg7zEUTCqIUZLSRABA1anOqFHTQzH/maa2
   l8C6x21Y9mk8izTHHsUY3avzhE28zdSDYJkdxcqp/LhFW2nzEvxcPMJ4Y
   k6BIkn4/JRaH+tVyrYP2kIX01oG2fr+9P5ocgNctSJyYhpptc59pEen1R
   X7gPdzvhEnQH0AgzYrQ75YasIkyzPqrvHKcuQGSHi0o3rH/sr9a0fKDOU
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10991"; a="25292383"
X-IronPort-AV: E=Sophos;i="6.06,177,1705392000"; 
   d="scan'208";a="25292383"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 05:25:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10991"; a="913524175"
X-IronPort-AV: E=Sophos;i="6.06,177,1705392000"; 
   d="scan'208";a="913524175"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 05:25:26 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rd94m-00000006dYX-1rc5;
	Thu, 22 Feb 2024 15:25:24 +0200
Date: Thu, 22 Feb 2024 15:25:24 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] gpiolib: Fix the error path order in
 gpiochip_add_data_with_key()
Message-ID: <ZddLRAqxFr7v3Zqs@smile.fi.intel.com>
References: <20240221192846.4156888-1-andriy.shevchenko@linux.intel.com>
 <CAMRc=MdvYdx6x=gSiOZ3SXAdJORnqhsNW79G2c7wABofWARwFw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=MdvYdx6x=gSiOZ3SXAdJORnqhsNW79G2c7wABofWARwFw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Feb 22, 2024 at 10:37:06AM +0100, Bartosz Golaszewski wrote:
> On Wed, Feb 21, 2024 at 8:28 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > After shuffling the code, error path wasn't updated correctly.
> > Fix it here.

> >         gpiochip_irqchip_free_valid_mask(gc);
> >  err_remove_acpi_chip:
> >         acpi_gpiochip_remove(gc);
> > +       gpiochip_remove_pin_ranges(gc);
> >  err_remove_of_chip:
> >         gpiochip_free_hogs(gc);
> >         of_gpiochip_remove(gc);
> 
> This undoes machine_gpiochip_add() and I think it also needs to be
> moved before acpi_gpiochip_remove().

You mean it should be like

       gpiochip_irqchip_free_valid_mask(gc);
       gpiochip_free_hogs(gc);
err_remove_acpi_chip:
       acpi_gpiochip_remove(gc);
       gpiochip_remove_pin_ranges(gc);
err_remove_of_chip:
       of_gpiochip_remove(gc);

?

-- 
With Best Regards,
Andy Shevchenko



