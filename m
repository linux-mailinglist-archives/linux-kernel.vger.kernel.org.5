Return-Path: <linux-kernel+bounces-119549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C74F88CA58
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 18:09:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 579512E7255
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 17:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 750E420B04;
	Tue, 26 Mar 2024 17:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nZIaAvtO"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DF1D17BA0;
	Tue, 26 Mar 2024 17:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711472814; cv=none; b=N4LvMJmawVNlMMiVxwGB+G2fOr7TXkdNcv2lxVkqYzuljCjKy4TJAUVj25qZSqSNfRNAW1iOntxnVj/pgj2MvT2VhUD33meEYFU8SE5GOyZbIuPilhq9iC0n3q5mX48FY19Agj0RQ6PYbPVfbTqYIS9IAqJ/UUu/tagZLeAQYwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711472814; c=relaxed/simple;
	bh=tEGEBe98n5yV7Nin67LqiSt90t6EYdkW6aOGPf8PFJQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JLPgGqJ6kHrSROGksaI3B+rCYnalh2Mc0N9t9A/yh7AevsDQAmweMSnZHUycd+z6XafdXa9SspmLDI5NrIAFDAejI+s+v8+1FBgqKAA7b91YC7qLd9y/vhdLOu3rrtBZpuM7Uck6e5XIUTXtjwknfhmeOhAJV/dBwGhpo9SD+k0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nZIaAvtO; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711472813; x=1743008813;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tEGEBe98n5yV7Nin67LqiSt90t6EYdkW6aOGPf8PFJQ=;
  b=nZIaAvtOP52f5VsDnQxIwftJylLniK/cEZj2XjBOt7bctkfPhJ2Ik5Wn
   LvAHEz6P7YFLMOT0nU2KsyNKYui1mEWXah3bzckVqAw3cBnevY+ePBq7J
   9N0O7aDfpfiGFPS6WljI1L8sK73D5tBIZLwWG64+qf/vV4Mu0OuU0VSxA
   gRLK0T1njRhMqOArbcVjQq2Udq/PdYwzI9w2Y6wd7pvRnC8oLhqMFVxmb
   15SFjHZtS2AuPukWKcW7XW1HIeic1z7JfJ8/v6aCKcVPtusf51mcEtuwC
   94UgFuycXGzQ4yXvmx7LKZuqh0ggo7PqIu+/5/0h6hTuBh9I07cRojMtM
   w==;
X-CSE-ConnectionGUID: 4SRYtynuQx6uP0dV9+0glw==
X-CSE-MsgGUID: LSH6xxiDTKaTWF5/IWnQoA==
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="24026924"
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="24026924"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 10:06:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="914885445"
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="914885445"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 10:06:49 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1rpAG6-0000000GOc7-0Hn7;
	Tue, 26 Mar 2024 19:06:46 +0200
Date: Tue, 26 Mar 2024 19:06:45 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Mark Brown <broonie@kernel.org>,
	Ryan Wanner <ryan.wanner@microchip.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] spi: remove struct spi_message::is_dma_mapped
Message-ID: <ZgMApTO6nuDNzNs_@smile.fi.intel.com>
References: <20240325-spi-remove-is_dma_mapped-v2-1-d08d62b61f1c@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240325-spi-remove-is_dma_mapped-v2-1-d08d62b61f1c@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Mar 25, 2024 at 02:22:53PM -0500, David Lechner wrote:
> There are no more users of the deprecated is_dma_mapped in struct
> spi_message so it can be removed.
> 
> References in documentation and comments are also removed.
> 
> A few similar checks if xfer->tx_dma or xfer->rx_dma are not NULL are
> also removed since these are now guaranteed to be NULL because they
> were previously set only if is_dma_mapped was true.

Nice cleanup, thank you!

-- 
With Best Regards,
Andy Shevchenko



