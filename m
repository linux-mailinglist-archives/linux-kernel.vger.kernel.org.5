Return-Path: <linux-kernel+bounces-47931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8CEE8454C8
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 11:04:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 701C22927CC
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 10:04:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B398D15A4A1;
	Thu,  1 Feb 2024 10:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VXMUwAX7"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F7D15B11F;
	Thu,  1 Feb 2024 10:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706781866; cv=none; b=bJb5Et9d9081TpGeTcECHdTPxRLG8jPDq3SJp5qkdN/oiUWBjoQ1pTm0lM5Lfr4o7unuT/rb8LRbF0RrqIQJ+1JUnXkXtS5B/LGBoftZ6+yTsfYXLbum/YE+MpIwLuIJlqvhD4e0myWpBLcD+YYgQUnQQIxQQsVgxMRcZSL1wnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706781866; c=relaxed/simple;
	bh=KdgUCk8gXka/4nZtIoc5a4Qez4+qKNQZz5DWDBkPpJ4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=I864DciMPyhcVjPRQnNU3G7Fk4clRQ1e3qtJSbnZB2gYTYw98JfuGzFyO+YPfqHrHJ+r0amoUPflRjTP3bvKFP7da4aFb2s+qNg6G+H2qjz3IHBnvRvT7UqhDnVg9OovzGh2kdL391gEdAwY176Lx33L3I4BxtOQIe7JZv+uMFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VXMUwAX7; arc=none smtp.client-ip=192.55.52.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706781864; x=1738317864;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=KdgUCk8gXka/4nZtIoc5a4Qez4+qKNQZz5DWDBkPpJ4=;
  b=VXMUwAX78eja/LpntaPKECzocIyY+u3gurXFyLBv5d3e4RgdsJMjJasS
   sQpHbbycEQdfojgI8xxn0+ywU0xMWvPB9zH7ZDME5V+ADgKvMvkf+gXcl
   KbVdAay8pN3y6oFtIy0HjrKMhwgHcRntLEM1E4dbsI2smfvTwd239kwzn
   jS042PY5YUySIjZd5NXQV6ntLa3HAjF72tonkkDCGnZOuDpAmkzEXAGb4
   4SfRbvXOXnsETN/NvWBZDrRy9KrsZdhL4S1oNDajJdwGt6EvfwNcD7Yqp
   kCuflxjDH399IOod2aAUz5HByc7dqWWeoAGphaSgVLmOd5WqhKmBOQbJ/
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="400992750"
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="400992750"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2024 02:04:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="23070696"
Received: from aragners-mobl.ger.corp.intel.com (HELO localhost) ([10.252.43.111])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2024 02:04:21 -0800
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Cong Liu <liucong2@kylinos.cn>, Helge Deller <deller@gmx.de>
Cc: linux-fbdev@vger.kernel.org, Cong Liu <liucong2@kylinos.cn>,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] fbdev/sh_mobile_lcdcfb: Replace deprecated
 simple_strtol with kstrtol
In-Reply-To: <20240201070127.3290465-1-liucong2@kylinos.cn>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20240201070127.3290465-1-liucong2@kylinos.cn>
Date: Thu, 01 Feb 2024 12:04:18 +0200
Message-ID: <87a5okh55p.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, 01 Feb 2024, Cong Liu <liucong2@kylinos.cn> wrote:
> This patch replaces the use of the deprecated simple_strtol [1] function
> in the sh_mobile_lcdcfb.c file with the recommended kstrtol function.
> This change improves error handling and boundary checks.
>
> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#simple-strtol-simple-strtoll-simple-strtoul-simple-strtoull
>
> Signed-off-by: Cong Liu <liucong2@kylinos.cn>

This is completely wrong, and obviously not tested at all.

The recommended replacements are *not* drop-in replacements. Look into
the documentation of the functions.

BR,
Jani.

> ---
>  drivers/video/fbdev/sh_mobile_lcdcfb.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/video/fbdev/sh_mobile_lcdcfb.c b/drivers/video/fbdev/sh_mobile_lcdcfb.c
> index eb2297b37504..5fc7d74b273e 100644
> --- a/drivers/video/fbdev/sh_mobile_lcdcfb.c
> +++ b/drivers/video/fbdev/sh_mobile_lcdcfb.c
> @@ -1278,11 +1278,11 @@ overlay_position_store(struct device *dev, struct device_attribute *attr,
>  	int pos_x;
>  	int pos_y;
>  
> -	pos_x = simple_strtol(buf, &endp, 10);
> +	pos_x = kstrtol(buf, &endp, 10);
>  	if (*endp != ',')
>  		return -EINVAL;
>  
> -	pos_y = simple_strtol(endp + 1, &endp, 10);
> +	pos_y = kstrtol(endp + 1, &endp, 10);
>  	if (isspace(*endp))
>  		endp++;

-- 
Jani Nikula, Intel

