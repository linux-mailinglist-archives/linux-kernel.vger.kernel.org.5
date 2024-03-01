Return-Path: <linux-kernel+bounces-87969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBDA986DB9B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 07:44:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 278EB1C22F0D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 06:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62FF867E89;
	Fri,  1 Mar 2024 06:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DgV63WxT"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A246E692ED;
	Fri,  1 Mar 2024 06:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709275444; cv=none; b=J5DxV5Hbo/UrGn4reqqoCmwjrHbwiCbLKdoIx1GZ8EK92OiIq3b07W8xPyEvW8qvu6QgZvCBsAAHVyCBg7xPfYlgWfgGGQoAeUAKGbGCBnR0l1tpYzrdku3dtsyRCrApveqAKvG0Cvs0HNLM5Na6ZxGmIB83FM8akZTqDlFhTHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709275444; c=relaxed/simple;
	bh=nj6R/NWcs7xCKL/xpKr5SF3gUQ36p7ueOQilXXZj4CM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g/0JH7xRJrQC/59sdstHp4ghVlwmaqLniaf05ZcQKqH8jrfWS8qcpa6bQN08Z7nGDy9YAEWyBrRCUZOFSqzu+Mqgohj3wcU2Z//U/r9Y9WHOes9R3A+awZkt0/nvI5Smw3ocq59qqF1J9Fo47GF5IlzixHGSRRbjhatFj+RslwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DgV63WxT; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709275443; x=1740811443;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nj6R/NWcs7xCKL/xpKr5SF3gUQ36p7ueOQilXXZj4CM=;
  b=DgV63WxTQTr2OlFurlPYlDlrHTktAWB1Q7/sbLT1VaqFlicZpQaFLKXv
   kZzloVATMSDM8M3Upo0fzHCjub9Sd9XSZHrgVJe9Cvr0ViQonpJu7Iih/
   6RZGO7RcikkeMaUyXC59PEQMN+F8wvLOr+qgzUeJHWMcwDW3HDEhIBqLo
   Tol+wnEHB/ViGc8nPxujXIiypqvHNNw5CCfen0iax6tASdbIsQXjnZr8o
   YaqQo7dBfjVojpfoUN7G3mpzZ5sE4m2DRNzpezzSQHiaC/9uC5QuU8eEk
   3Xhge8zAp+EZN4+6OjMN88patxc0ZkhktfhBq1tIchksdkPs8StS4sP23
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10999"; a="14436715"
X-IronPort-AV: E=Sophos;i="6.06,195,1705392000"; 
   d="scan'208";a="14436715"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Feb 2024 22:44:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10999"; a="937037068"
X-IronPort-AV: E=Sophos;i="6.06,195,1705392000"; 
   d="scan'208";a="937037068"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 29 Feb 2024 22:43:59 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id B659E3BC; Fri,  1 Mar 2024 08:43:58 +0200 (EET)
Date: Fri, 1 Mar 2024 08:43:58 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Chris Packham <Chris.Packham@alliedtelesis.co.nz>
Subject: Re: [PATCH v2 0/2] gpiolib: Align prototypes of *gpio_count() APIs
Message-ID: <20240301064358.GL8454@black.fi.intel.com>
References: <20240229145303.3801332-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240229145303.3801332-1-andriy.shevchenko@linux.intel.com>

On Thu, Feb 29, 2024 at 04:51:37PM +0200, Andy Shevchenko wrote:
> Two out of three GPIO count APIs take device pointer. OF case clearly
> does not need it as it immediately switches to device node inside, and
> ACPI abstracts that to struct acpi_device pointer. Unify all these by
> making them to take struct fwnode_handle pointer. This, in particular,
> will allow to create fwnode_gpio_count() API if needed. The need of that
> was discussed here [1].
> 
> Note, no functional changes intended.
> 
> Link: https://lore.kernel.org/r/2ad735ed-963c-4e75-b83e-687ea2c0aef5@alliedtelesis.co.nz [1]
> 
> In v2:
> - fixed typo (Chris)
> - added tag (Linus)
> 
> Andy Shevchenko (2):
>   gpiolib-of: Make of_gpio_get_count() take firmware node as a parameter
>   gpiolib-acpi: Make acpi_gpio_count() take firmware node as a parameter

For both,

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>

