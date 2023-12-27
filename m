Return-Path: <linux-kernel+bounces-12153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22DF081F0A7
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 17:57:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D52D928253B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 16:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D21B24643C;
	Wed, 27 Dec 2023 16:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FHNOIsH0"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0534F45BFE;
	Wed, 27 Dec 2023 16:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703696214; x=1735232214;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=2yJFTx4ZE8jECzs1+U6wqnReWCpAiewcEcFY9qdNd5A=;
  b=FHNOIsH0qG4MTaBS5PX6RzIX0sOOsqc8vrcGDqmKKOAR3LAS6FgbDTmc
   UPQlCkEmSkJdaqhJmmjClXBd8L71q8wGU2eOWDhiRmpzmqXaBh8ftCue9
   uCqLPtZtClP1UHocXIqf01dTnd/7SBrSn+mL1wOAnqaRgcUvJhaftK1Vy
   GaQuz8TF885IPrBp8VXUzGm0B7IZCi6Yb6mft/p2B2L48I8Dicgzzv3/h
   zxJrDc1D1e6NEX+eZtRD4E8iaIT7aZ9NshygwmFvR23Tc9IPWlLrKgz8k
   zv/JhAtNOdxUXA+0XA8N7JnloRdtYddMz2HhLRDmUB4nKqzBRmc1iE0BH
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10936"; a="15131643"
X-IronPort-AV: E=Sophos;i="6.04,309,1695711600"; 
   d="scan'208";a="15131643"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2023 08:56:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10936"; a="812572900"
X-IronPort-AV: E=Sophos;i="6.04,309,1695711600"; 
   d="scan'208";a="812572900"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2023 08:56:49 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rIXD3-00000009T7I-33IT;
	Wed, 27 Dec 2023 18:56:45 +0200
Date: Wed, 27 Dec 2023 18:56:45 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: linux-mmc@vger.kernel.org, kernel-janitors@vger.kernel.org,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Yang Yingliang <yangyingliang@huawei.com>,
	LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr
Subject: Re: [PATCH] mmc: mmc_spi: Adjust error handling in mmc_spi_probe()
Message-ID: <ZYxXTVpLfI-mgxF4@smile.fi.intel.com>
References: <2aa6bd31-f3d8-41ac-abf1-9ec7cf7e064b@web.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2aa6bd31-f3d8-41ac-abf1-9ec7cf7e064b@web.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Dec 27, 2023 at 12:50:50PM +0100, Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Wed, 27 Dec 2023 12:23:20 +0100
> 
> The kfree() function was called in one case by
> the mmc_spi_probe() function during error handling
> even if the passed variable contained a null pointer.
> This issue was detected by using the Coccinelle software.

> * Thus return directly after a call of the function “kmalloc” failed
>   at the beginning.
> 
> * Move an error code assignment into an if branch.

How is this one better?

-- 
With Best Regards,
Andy Shevchenko



