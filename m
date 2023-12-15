Return-Path: <linux-kernel+bounces-1307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10CEB814D2C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 17:35:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1938283375
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 16:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53F313D98C;
	Fri, 15 Dec 2023 16:35:21 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC5E1249EA;
	Fri, 15 Dec 2023 16:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="375442960"
X-IronPort-AV: E=Sophos;i="6.04,279,1695711600"; 
   d="scan'208";a="375442960"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2023 08:35:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="809025747"
X-IronPort-AV: E=Sophos;i="6.04,279,1695711600"; 
   d="scan'208";a="809025747"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2023 08:35:17 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andy@kernel.org>)
	id 1rEB9e-00000006AZP-1Vsd;
	Fri, 15 Dec 2023 18:35:14 +0200
Date: Fri, 15 Dec 2023 18:35:14 +0200
From: Andy Shevchenko <andy@kernel.org>
To: Kent Gibson <warthog618@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, brgl@bgdev.pl,
	linus.walleij@linaro.org
Subject: Re: [PATCH v3 1/5] gpiolib: cdev: relocate debounce_period_us from
 struct gpio_desc
Message-ID: <ZXyAQq7tVaOFI2Vs@smile.fi.intel.com>
References: <20231215023805.63289-1-warthog618@gmail.com>
 <20231215023805.63289-2-warthog618@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231215023805.63289-2-warthog618@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Dec 15, 2023 at 10:38:01AM +0800, Kent Gibson wrote:
> Store the debounce period for a requested line locally, rather than in
> the debounce_period_us field in the gpiolib struct gpio_desc.
> 
> Add a global tree of lines containing supplemental line information
> to make the debounce period available to be reported by the
> GPIO_V2_GET_LINEINFO_IOCTL and the line change notifier.

LGTM, a few minor comments below.

...

> +/*

(now you can have a kernel doc :-)

> + * a rbtree of the struct lines containing supplemental info.
> + * Used to populate gpio_v2_line_info with cdev specific fields not contained
> + * in the struct gpio_desc.
> + * A line is determined to contain supplemental information by
> + * line_is_supplemental().
> + */
> +static struct rb_root supinfo_tree = RB_ROOT;
> +/* covers supinfo_tree */
> +DEFINE_SPINLOCK(supinfo_lock);

Shouldn't this also be static?

...

> +	guard(spinlock)(&supinfo_lock);

+ cleanup.h ?

...

> +static void supinfo_to_lineinfo(struct gpio_desc *desc,
> +				struct gpio_v2_line_info *info)
> +{
> +	struct gpio_v2_line_attribute *attr;
> +	struct line *line;
> +
> +	guard(spinlock)(&supinfo_lock);
> +
> +	line = supinfo_find(desc);
> +	if (line) {

	if (!line)
		return;

?

> +		attr = &info->attrs[info->num_attrs];
> +		attr->id = GPIO_V2_LINE_ATTR_ID_DEBOUNCE;
> +		attr->debounce_period_us = READ_ONCE(line->debounce_period_us);
> +		info->num_attrs++;
> +	}
> +}

-- 
With Best Regards,
Andy Shevchenko



