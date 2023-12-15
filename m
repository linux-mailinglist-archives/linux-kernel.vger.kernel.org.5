Return-Path: <linux-kernel+bounces-1318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D286D814D5E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 17:43:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF11A1C2331B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 16:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA4283DBB8;
	Fri, 15 Dec 2023 16:43:38 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E27381C3;
	Fri, 15 Dec 2023 16:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="426427620"
X-IronPort-AV: E=Sophos;i="6.04,279,1695711600"; 
   d="scan'208";a="426427620"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2023 08:43:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="1106173081"
X-IronPort-AV: E=Sophos;i="6.04,279,1695711600"; 
   d="scan'208";a="1106173081"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2023 08:43:32 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andy@kernel.org>)
	id 1rEBHd-00000006Ag8-3BCB;
	Fri, 15 Dec 2023 18:43:29 +0200
Date: Fri, 15 Dec 2023 18:43:29 +0200
From: Andy Shevchenko <andy@kernel.org>
To: Kent Gibson <warthog618@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, brgl@bgdev.pl,
	linus.walleij@linaro.org
Subject: Re: [PATCH v3 0/5] gpiolib: cdev: relocate debounce_period_us
Message-ID: <ZXyCMaAa3eFToICm@smile.fi.intel.com>
References: <20231215023805.63289-1-warthog618@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231215023805.63289-1-warthog618@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Dec 15, 2023 at 10:38:00AM +0800, Kent Gibson wrote:
> This series contains minor improvements to gpiolib-cdev.
> 
> The banner change is relocating the debounce_period_us from gpiolib's
> struct gpio_desc to cdev's struct line.  Patch 1 stores the field
> locally in cdev.  Patch 2 removes the now unused field from gpiolib.
> 
> Patch 3 is somewhat related and removes a FIXME from
> gpio_desc_to_lineinfo().  The FIXME relates to a race condition in
> the calculation of the used flag, but I would assert that from
> the userspace perspective the read operation itself is inherently racy.
> The line being reported as unused in the info provides no guarantee -
> it just an indicator that requesting the line is likely to succeed -
> assuming the line is not otherwise requested in the meantime.
> Given the overall operation is racy, trying to stamp out an unlikely
> race within the operation is pointless. Accept it as a possibility
> that has negligible side-effects and reduce the number of locks held
> simultaneously and the duration that the gpio_lock is held.
> 
> Patches 1 and 3 introduce usage of guard() and scoped_guard() to cdev.
> Patch 4 replaces any remaining discrete lock/unlock calls around
> critical sections with guard() or scoped_guard().
> 
> Patch 5 is unrelated to debounce or info, but addresses Andy's
> recent lamentation that the linereq get/set values functions are
> confusing and under documented.
> Figured I may as well add that while I was in there.

This version LGTM, few minor comments here and there, but feel free to add

Reviewed-by: Andy Shevchenko <andy@kernel.org>

-- 
With Best Regards,
Andy Shevchenko



