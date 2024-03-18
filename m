Return-Path: <linux-kernel+bounces-106592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F07EE87F0B6
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 21:02:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2F81B20F97
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 20:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC84057866;
	Mon, 18 Mar 2024 20:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X7WXiWst"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA41F55C14;
	Mon, 18 Mar 2024 20:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710792136; cv=none; b=SoRPlJizBiN4PSSsQOms7fzDu8orBWyQ4C4cBkUKvFFQEMbSBr1jE1ntfTuLQw+rX7KaecTOrewC4J5CJhzkwR7mmT5mYzK6o+H0hPPgpa5X57Z6+NvdwqmMyLTU65vmj89swZbBOoH8ozhVigtKMOTcEdx3F+xIDVZcpCkVR6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710792136; c=relaxed/simple;
	bh=ioTrYBrdsE7izn+AcJYryuQbQLhywGSNPivL7f28es0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tv/Fx3Q8M8LxsNJzZpUFHteeNl5FGPwxbGfnMStMWnOmhpNXEVJyHgznJEAotkPdP/yPxaKp8IxkIxYO3QaEmvL7UdNzuyknvjDg9+I/j25RTRdF8kUTpkVSYvcP7p2CX2MhVv2YHthq3m3MwYg3xTEQX4j+CrWScGvSVnfg8yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X7WXiWst; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710792135; x=1742328135;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ioTrYBrdsE7izn+AcJYryuQbQLhywGSNPivL7f28es0=;
  b=X7WXiWstH0bSmWbDXvjT297wtSjgCEtQAxfoywR1fomvKcr3/pG6DPQb
   MP66lxbG2JdxzfRtk8bN7uIQOxMVxErBQJWRKgVAZwnfQGCaEQX2kyQ5P
   M58dw6o45LewqfmWjl3DW5UNZ80HGb2UjpzlIGYRO+zbyckoOXenVBjO3
   fJHOhLbU3w7VaykmOAiESgAxslJ0K5hDu6CK+pBb1XmCFEKQYzptlPPrr
   9mtDxD4cQ/yy4ZAHj2uIoILOPok/YJn5/A+fvYcx/tQUJecv27wMdHmZa
   9BFJ/uaO0UkbNElnH1J3FIJo1AFfK9GQraNWDuznnZFUNCke2B4u5Fcfd
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11017"; a="5508539"
X-IronPort-AV: E=Sophos;i="6.07,135,1708416000"; 
   d="scan'208";a="5508539"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2024 13:02:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11017"; a="914603538"
X-IronPort-AV: E=Sophos;i="6.07,135,1708416000"; 
   d="scan'208";a="914603538"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2024 13:02:10 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rmJBO-0000000E40t-2XpO;
	Mon, 18 Mar 2024 22:02:06 +0200
Date: Mon, 18 Mar 2024 22:02:06 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
	linux-sound@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Shengjiu Wang <shengjiu.wang@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>,
	Fabio Estevam <festevam@gmail.com>,
	Nicolin Chen <nicoleotsuka@gmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: Re: [PATCH v1 1/1] ASoC: fsl: imx-es8328: Switch to using gpiod API
Message-ID: <ZfidvrfrwMmYQBcK@smile.fi.intel.com>
References: <20240318195837.180069-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240318195837.180069-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Mar 18, 2024 at 09:58:37PM +0200, Andy Shevchenko wrote:
> This updates the driver to gpiod API, and removes yet another use of
> of_get_named_gpio().

This won't compile, sorry for the noise. I'll send a v2.

-- 
With Best Regards,
Andy Shevchenko



