Return-Path: <linux-kernel+bounces-135807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5475489CB9D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 20:21:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E84628AA54
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 18:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBEE81448E2;
	Mon,  8 Apr 2024 18:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N+EJOHe3"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 547FB1E532;
	Mon,  8 Apr 2024 18:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712600479; cv=none; b=tSDU0CFqZQfyS4pxwmjlFHpX7wqGVb4nXrlAUHF9vAkNjhP8FpET89p7+JImW7UwxgfUi3dkfxMDA86lhG42AGReeHRu/9XQo22MhohfqwzDFQUsZJn62+CTzJ3/iaiQ0FcCgM0Qa7hcqeRFec2uv9zcPDAM3uWzaSbVeSzzIn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712600479; c=relaxed/simple;
	bh=z34/j1vtWd7zC0EObYfQ9rp8AHR0JiC5h7Q/5NrsV78=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V8/rKVN1NHosZj0hnOHnRrizyVQw2gQ+J+fjEC7OSt88W49a9hgM/8yC9XUTSvDLo0UklBZxORcZZluH7shc1P14MUZUl8DTRBBfBipxkEVM62iOIb+A/As+5T9jTgb1wThvSH/F61X7/hiHP+2ICuXCw7km0ab9J/M2fSCfFWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N+EJOHe3; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712600477; x=1744136477;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=z34/j1vtWd7zC0EObYfQ9rp8AHR0JiC5h7Q/5NrsV78=;
  b=N+EJOHe3FGMBMePRpngDxDa5I8iHtXAAINYHncT0J3rCIJXLWfPFLHyo
   /ioHdeN3HmOgjLKahXZH6YKkGren9s/VSs3bj4TkFQuZd1ISuoOhWxJ4c
   Qluad/toQ9nqGx1as89kG/HrOlkYA/kZrpSYcxdUZbsMvcmI3phpYgP8N
   Dxh7f9K3qgCxp2tjerXEpxFs6kakXMhG4LCbWuVrRhXqevSLBu0vZvuE0
   dezSI0jzkJXYX+1Gkq4lcn5qOnaxO3ng9T9KN/XizVgDcmPQ3DxMg4eCY
   1xNqSG4hAxaKu/h9QW1IVM+0AMDuZhmARo2S3iW6hjuUAV9l+H0g0iNb0
   Q==;
X-CSE-ConnectionGUID: DIoouLBHQhaj9fTQ4UQayA==
X-CSE-MsgGUID: Zju/Hrh3T9yWbB5cfBGzIg==
X-IronPort-AV: E=McAfee;i="6600,9927,11038"; a="7801089"
X-IronPort-AV: E=Sophos;i="6.07,187,1708416000"; 
   d="scan'208";a="7801089"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 11:21:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11038"; a="915373773"
X-IronPort-AV: E=Sophos;i="6.07,187,1708416000"; 
   d="scan'208";a="915373773"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 11:21:14 -0700
Received: from andy by smile with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rttcF-00000002bo6-3kBX;
	Mon, 08 Apr 2024 21:21:11 +0300
Date: Mon, 8 Apr 2024 21:21:11 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Kent Gibson <warthog618@gmail.com>, linux-gpio@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [PATCH v1 1/1] gpiolib: Update the kernel documentation - add
 Return sections
Message-ID: <ZhQ1l6naYpVlmlex@smile.fi.intel.com>
References: <20240404212706.3587456-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240404212706.3587456-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Apr 05, 2024 at 12:27:06AM +0300, Andy Shevchenko wrote:
> $ scripts/kernel-doc -v -none -Wall drivers/gpio/gpiolib* 2>&1 | grep -w warning | wc -l
> 67
> 
> Fix these by adding Return sections. While at it, make sure all of
> Return sections use the same style.

Bart, this is the biggest part from the v1, I would like to have that applied
first if no objections since it fixes kernel doc warnings. What do you think?

-- 
With Best Regards,
Andy Shevchenko



