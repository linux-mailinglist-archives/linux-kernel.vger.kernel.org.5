Return-Path: <linux-kernel+bounces-59022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 387B784EFFD
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 06:44:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E889C284B0F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 05:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9907856B8F;
	Fri,  9 Feb 2024 05:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kPpd5fdU"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF50857300;
	Fri,  9 Feb 2024 05:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707457489; cv=none; b=jQauBLtoMeLzKXkmstqcp7G3g0XeD5A5io4iTqOdYotfyPzbPHGlBiLP3UKTTn/KggwHmJKxRdCY2yb5Oz6OD0mS784zEi8ZR+0ca7EKUFv3SUA7yUTkMHs1SHT2JMIB7txxXq15mKIrBOgVwmhkB1UMTfXjuVAZWazsFh6Yses=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707457489; c=relaxed/simple;
	bh=8sFBjJKkaT738fMSKfGFk4q0gebR79K+EYwCD+8CU1o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fij/E1DSv3s9jk35uc7bqPRI5mF6fJSmkq3DoYyNVX+o5ETrffoTWbrrQ+qRYuWMuHRYZsPmGdAUdzIJdpQpXLVIBz3yB8CgIbDgdKmJSFaEDHFXl1Y8NYTOiDMmiWCPVbapUr01/htQPsdLzWwFgL8LXKkgnAe1Nwu+GRhNWj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kPpd5fdU; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707457489; x=1738993489;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8sFBjJKkaT738fMSKfGFk4q0gebR79K+EYwCD+8CU1o=;
  b=kPpd5fdUMaeAcJsO8h/jcJXYUHAJt7Sf9/HjUJs/daTZxI9RqV85qZFw
   aw1PqolFq8VpAitRS4sMTJ0TrUOGOHFJDxVoTuH5aMlHiyIG6ht2FnvbE
   GWQKWWOIF+C1wP2GMFpeclI5f/pQi01dHzxnLR3x5k8ZeCCi20Mg/TFME
   yHk/NMT80N7T4frSbTc56hkPNchz6JsG+wfFntsvO4gTL77/5ZEJuE1Lu
   KM1X9g9TC1PIVgWDf9c2Ug7EVO4slNZ78yGqdY/9oTaTrf8qmk24HAU7C
   eZ1XtmWDUvAl1prGMQfKTzNpbx+UGnh6jkGM6t1t+LrBJKWFBIH1Aj716
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="1259601"
X-IronPort-AV: E=Sophos;i="6.05,255,1701158400"; 
   d="scan'208";a="1259601"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 21:44:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="934343636"
X-IronPort-AV: E=Sophos;i="6.05,255,1701158400"; 
   d="scan'208";a="934343636"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 08 Feb 2024 21:44:45 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id 0CBD2159; Fri,  9 Feb 2024 07:44:43 +0200 (EET)
Date: Fri, 9 Feb 2024 07:44:43 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>, linux-gpio@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gpio: constify opaque pointer in gpio_device_find()
 match function
Message-ID: <20240209054443.GU8454@black.fi.intel.com>
References: <20240208202704.631203-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240208202704.631203-1-krzysztof.kozlowski@linaro.org>

On Thu, Feb 08, 2024 at 09:27:04PM +0100, Krzysztof Kozlowski wrote:
> The match function used in gpio_device_find() should not modify the
> contents of passed opaque pointer, because such modification would not
> be necessary for actual matching and it could lead to quite unreadable,
> spaghetti code.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>

