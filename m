Return-Path: <linux-kernel+bounces-7062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECBD681A123
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 15:30:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8142285424
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 14:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 162363526B;
	Wed, 20 Dec 2023 14:30:31 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CCB138FAB;
	Wed, 20 Dec 2023 14:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="380811906"
X-IronPort-AV: E=Sophos;i="6.04,291,1695711600"; 
   d="scan'208";a="380811906"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2023 06:30:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="919992164"
X-IronPort-AV: E=Sophos;i="6.04,291,1695711600"; 
   d="scan'208";a="919992164"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2023 06:30:27 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andy@kernel.org>)
	id 1rFxaa-00000007YhR-3EWU;
	Wed, 20 Dec 2023 16:30:24 +0200
Date: Wed, 20 Dec 2023 16:30:24 +0200
From: Andy Shevchenko <andy@kernel.org>
To: Kent Gibson <warthog618@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, brgl@bgdev.pl,
	linus.walleij@linaro.org
Subject: Re: [PATCH 2/4] gpiolib: cdev: allocate linereq using kvzalloc()
Message-ID: <ZYL6gIpG5GBONVSO@smile.fi.intel.com>
References: <20231220015106.16732-1-warthog618@gmail.com>
 <20231220015106.16732-3-warthog618@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231220015106.16732-3-warthog618@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Dec 20, 2023 at 09:51:04AM +0800, Kent Gibson wrote:
> The size of struct linereq may exceed a page, so allocate space for
> it using kvzalloc() instead of kzalloc().

It might be this needs a bit of elaboration. The kmalloc() tries to allocate
a contiguous (in physical address space) chunk of memory and with fragmented
memory it might be not possible. So the above issue might (rarely) happen.
In most cases the call to kmalloc() will succeed.

-- 
With Best Regards,
Andy Shevchenko



