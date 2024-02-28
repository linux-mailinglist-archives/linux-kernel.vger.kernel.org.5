Return-Path: <linux-kernel+bounces-85642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EFDB86B897
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 20:51:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3597B25E1F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 19:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F65C5E07E;
	Wed, 28 Feb 2024 19:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X6Q2KCRV"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 915225E06B;
	Wed, 28 Feb 2024 19:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709149847; cv=none; b=TYua+vPoh+1Fetar+BckAFYk0G8utatUU8JCuUizEEpESZyqx4x2ikTz1kOf4gG/nkkExp6n+0X27IH54QLqpD7nnf7Vp5nZRDu7qijx15Z8wkGwnDdGhyHc4F0QOskxdiRefbAkAP7YaaCoUfXKbgsQNqghcRZr+oVWyN7muik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709149847; c=relaxed/simple;
	bh=4R0SAbbcmH2Oaw34HtvwOEAfx7H3jhRjkycUCMLbko0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M9m1BkGouLIkNyWESt3PkZ3r9FDVw3ZB9QH77qRsbr+1UKO1AmG4p2OQJJZOkGAjie4kcno6+0zzoRwfyDAL4lxfg26ss217pLf5LeeX/cKFq2sdTFMcDL+VUaMZ1IAOUYkzn+0iMhqpw4Pf0ola8tCe3PDyEVetUv1uNUVaOvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X6Q2KCRV; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709149846; x=1740685846;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4R0SAbbcmH2Oaw34HtvwOEAfx7H3jhRjkycUCMLbko0=;
  b=X6Q2KCRV8ZyU5oD9+M2A0aYShrH8P+ojkjtPQWmPO+6BpfNVTg2kwiUU
   vwG15f4YEZmQAPRIjILyc6MaJeXAelRqO5otw3DRp07GRhlow7Jn1Gk1y
   Jxds7RGtqpfEObkk/I3bHHLGUa68Yq159P58Xh3o0+KDKW6laQvrOFZ2c
   FuXj8Qr5M2oF+ZafbW3Zo0hk/bUv3UTq2rmvZiIz17Iol/j1avjNV/6Nj
   f+cCMprPTD/WaAZEQ4HBODjyBpGhzjNo6CF2yNvALFZE7xaFFLiwwX0po
   0HkyYFUVtC+7zmBJq+ZDXUoXuLLb1PY4sU89jrndDWnGCf4w0kyHRBanR
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="14217744"
X-IronPort-AV: E=Sophos;i="6.06,191,1705392000"; 
   d="scan'208";a="14217744"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 11:50:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="913959723"
X-IronPort-AV: E=Sophos;i="6.06,191,1705392000"; 
   d="scan'208";a="913959723"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 11:50:41 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rfPws-00000008Tto-4BWU;
	Wed, 28 Feb 2024 21:50:39 +0200
Date: Wed, 28 Feb 2024 21:50:38 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Alisa-Dariana Roman <alisadariana@gmail.com>
Cc: michael.hennerich@analog.com, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	lars@metafoo.de, jic23@kernel.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	nuno.sa@analog.com, alisa.roman@analog.com, dlechner@baylibre.com
Subject: Re: [PATCH v4 0/4] iio: adc: ad7192: Add support for AD7194
Message-ID: <Zd-OjiZbk6ZieKiH@smile.fi.intel.com>
References: <20240228122617.185814-1-alisa.roman@analog.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240228122617.185814-1-alisa.roman@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Feb 28, 2024 at 02:26:13PM +0200, Alisa-Dariana Roman wrote:
> From: romandariana <alisa.roman@analog.com>

> Alisa-Dariana Roman (4):

Please fix and align the following:
- email From line (submitter)
- SoB tag(s)

-- 
With Best Regards,
Andy Shevchenko



