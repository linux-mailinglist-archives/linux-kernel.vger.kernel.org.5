Return-Path: <linux-kernel+bounces-121346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E965E88E676
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 15:38:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25F4B1C2DD5F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 14:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C915F13A406;
	Wed, 27 Mar 2024 13:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eGsYtM/w"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E6F8134415
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 13:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711545028; cv=none; b=TKGigzhqOhIvjugPmSe66gbwQoDhb1loPOITkJlOUS8wjBLX4w0WYzxjMGSM3NhzAkTRrCQP1xmhHmxMcFPlC7dDSLi4G7fmSEBi72if+djIz9Z/2xhTY2JqKx5YIaZd0vkWwFj+puQ1mH4xJgOb8Vmj4xmzZ1OKu3c79iZs7sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711545028; c=relaxed/simple;
	bh=H3xadqQfDw/NU4PTfDU+D7Sbt/ALnmmUzI9ke2A9X7E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wmn800Atln27lTIn/gFYrIBDZex++FK8auu6ZhsjShwzr/jb5WI1xesOOWys7+4wvBFHvBy6BWvSm6puzfyaDzEl+vqlox7U2z3qJouBSbWLwWJz8YXaQzO70euQ7SK9Pd6vdObYq6NA8OGHhJrv65bVcOrMf1UxIF0E6EH8qto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eGsYtM/w; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711545027; x=1743081027;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=H3xadqQfDw/NU4PTfDU+D7Sbt/ALnmmUzI9ke2A9X7E=;
  b=eGsYtM/w9ALUKledNdg4DTWMbWfLOJ24I7JKsHHL388DY6Xg/x36TmaU
   gfk99o4VgWhHcW/4AMZxRFbcNSAO5Mr6WU1cgY0+tKiFjp/R6ztsVSpZX
   A+Eq3hlUQqg80m3VNPcNryPoXuKtzAei1OaCHHZaxDyEm45mlohDgCZL2
   wHxAlsggHavsImawKFyEbQf7qRJcY0Sm0ek4QCElRQCg1c9ZJHTADyi8K
   f8uU2eV5SkmYbrd/vXlb6R43szCrOiecULOaW+1DL2ZrbHr8fXLBYN5Qn
   nT2LVuIGUehO3A4nd07DlDzjnHf4HmCji9PamgOpSo88B/ki1eYWzQBvr
   g==;
X-CSE-ConnectionGUID: kS+KjJitQpGMfyK36krjoQ==
X-CSE-MsgGUID: X58SCv0nRMeMAea7kLVJhQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="6581055"
X-IronPort-AV: E=Sophos;i="6.07,158,1708416000"; 
   d="scan'208";a="6581055"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2024 06:10:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="914912955"
X-IronPort-AV: E=Sophos;i="6.07,158,1708416000"; 
   d="scan'208";a="914912955"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2024 06:10:23 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rpT2q-0000000GdiM-49gT;
	Wed, 27 Mar 2024 15:10:20 +0200
Date: Wed, 27 Mar 2024 15:10:20 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Shahar Avidar <ikobh7@gmail.com>
Cc: gregkh@linuxfoundation.org, elder@linaro.org, robh@kernel.org,
	parthiban.veerasooran@microchip.com, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] staging: pi433: Fix includes, comments & macros.
Message-ID: <ZgQavKRkO0gt6Qdt@smile.fi.intel.com>
References: <20240327063156.96307-1-ikobh7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240327063156.96307-1-ikobh7@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Mar 27, 2024 at 08:31:53AM +0200, Shahar Avidar wrote:
> This patchset continues with some cleanups:
> 
> 1. Untangle include hierarchy.
> 2. Delete a misleading comment.
> 3. Make use of general macro instead of magic number.

> v2->v1:
> Undo macro update. Remove its inaccurate comment instead.

It's your responsibility to carry on the given tags for unchanged patches.
I believe I gave a tag to two out of three patches.

-- 
With Best Regards,
Andy Shevchenko



