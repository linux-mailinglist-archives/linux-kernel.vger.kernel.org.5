Return-Path: <linux-kernel+bounces-117545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 36A9988AC6A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:52:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE6321FA274D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A30413048C;
	Mon, 25 Mar 2024 17:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WbXuRjl9"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3BEA1EB5A;
	Mon, 25 Mar 2024 17:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711386413; cv=none; b=VbC4lJN4x8Nfk+dqZOH/Y44UBLCv8UeWJRtM6tTeF/hAZ6teFktTczVKeBWfHcYGx4ekSWiqBL3a5cNj41ubHOYLxYasFBtZ1UxI8r8MEssdMKPbQxJS6jPAgYIUY/xL73S15ivQGYkU2jYacn3HDlleRSZLP29S9aYbkBWUi8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711386413; c=relaxed/simple;
	bh=MAe5uuROFbCiGuIhQXAD8TvICt0pICzM9nlR0AdeEI4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MN1krODV1LfCHO+MTveplIDcWkE5xLRVwlagu7lf73GwPU4AAyGc3HlmqXa5f9Ut9MzNE4DGZwfTxU1sbHK5j3sbQc6uawFgS4BTFRCXIc3GXKHVHxxFBFwdt05ByJYzqkRdlGey9jhacYJ95MDVo0jziXTf5ESLHliHbifp8GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WbXuRjl9; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711386412; x=1742922412;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MAe5uuROFbCiGuIhQXAD8TvICt0pICzM9nlR0AdeEI4=;
  b=WbXuRjl9ZbZiX1Xf9OqBDYQnCwDA2N92mDBfDXOFMo8EBsqxzkt869Db
   gfoJ8HzNmfG/mFsUncIio7/yw/vM1Vb0033SjraY4LrjAUwq8Eb0t3V9j
   wJOe1REoSvE/TXlr0H7KmlviWQmT8tFdC0INPCwBGuQ56HTqGv/JPlyvD
   gewTXRdVL9CQjL1xHVr+GrX75zwcweiIBXLja5fM3Bddr6AYIq9DMShXq
   8h3uuIDQ0HNcDiYxovNYJBUcV/MwH6zfhWeX1UV39Ktk0QD5m21FSHUA7
   F2r6ttyFjK/lCSObSEnxqgHWfZ38OPMV1RFW8RaPK9YD0mb/naffn2rV0
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11024"; a="6266960"
X-IronPort-AV: E=Sophos;i="6.07,153,1708416000"; 
   d="scan'208";a="6266960"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 10:06:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11024"; a="914849374"
X-IronPort-AV: E=Sophos;i="6.07,153,1708416000"; 
   d="scan'208";a="914849374"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 10:06:47 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1ronmW-0000000G3ar-2wkT;
	Mon, 25 Mar 2024 19:06:44 +0200
Date: Mon, 25 Mar 2024 19:06:44 +0200
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
Subject: Re: [PATCH v2 1/1] ASoC: fsl: imx-es8328: Switch to using gpiod API
Message-ID: <ZgGvJDEpMjaeZzpC@smile.fi.intel.com>
References: <20240318200804.181516-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240318200804.181516-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Mar 18, 2024 at 10:07:56PM +0200, Andy Shevchenko wrote:
> This updates the driver to gpiod API, and removes yet another use of
> of_get_named_gpio().

This also needs a leftover removal. :-(

-- 
With Best Regards,
Andy Shevchenko



