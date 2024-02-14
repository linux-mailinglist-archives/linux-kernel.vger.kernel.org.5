Return-Path: <linux-kernel+bounces-65690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BBE8855075
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 18:38:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 502D91F220DB
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 17:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D842839ED;
	Wed, 14 Feb 2024 17:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="if6Z7TNf"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DD145F865;
	Wed, 14 Feb 2024 17:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707932284; cv=none; b=MnED1N6QJwTC94jBniTZi5jCfIfzYCztv630uUCQeKfpqEGNSZp3QGklbT7F/XqK4LcNtnYuwOM8xFUnW/aINjJbtR127WqBk18BcjAIAOrQ/vTtvwtX1Q72LCvPQEVmRsgsYIiD9JZzVujG8uUHY0rLc9cMEK5XJykT7QyQuR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707932284; c=relaxed/simple;
	bh=XWUAHVjqKJCcZpzFJ3o1ueTJgBHTHr2KA5qq2NYJvQw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VTircHLl4CoEGgxlEnSBVt9I1sUCd5a0WbS/XdBNIfuP3CMck4rno3FDtGFFowY7/dcGqOIU7w9CHEsylCsKluweU8RXTCRMQzSUqB2E056Qc1LoxGFf9LFiEhIIR5gqtTzU4hhqoI7/ItBVNYdVBt/GWwWaSNmnHZ63GtPUHqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=if6Z7TNf; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707932283; x=1739468283;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XWUAHVjqKJCcZpzFJ3o1ueTJgBHTHr2KA5qq2NYJvQw=;
  b=if6Z7TNfZWhj3NPrubvn5SeW4nNHzAHGYpGbv0G7+5QwUqsIxFh72U04
   N2GTuYq8lSrgTR3izyql2GrIJAdq92nTmu7czmIX661MmHP3GjaXyO6Ck
   aJBelaCaCJ6uzHQq/EUDfUuDTC/ABHsYO+o2BC6QDW/DxfwU3wKxFof/c
   nh4E/Eaopg+sFqs5x7Zx3aDS6GhGP6Ey7gvpyNeCMJyD8bHz2UUipbEMb
   nRGk86alhohQ32JoTJptsAjLUSNDEKQAMTdt9z2YFCJh4Ic1SbEPb7cT5
   JZ7NH7s4bRrErVfkrFHdfPdIiygaQd09OF1JsGFb4LEk2Oi5hFjgFbD1S
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10984"; a="13379043"
X-IronPort-AV: E=Sophos;i="6.06,160,1705392000"; 
   d="scan'208";a="13379043"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2024 09:38:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10984"; a="912092337"
X-IronPort-AV: E=Sophos;i="6.06,160,1705392000"; 
   d="scan'208";a="912092337"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2024 09:37:59 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1raJCm-00000004YXQ-3xy8;
	Wed, 14 Feb 2024 19:37:56 +0200
Date: Wed, 14 Feb 2024 19:37:56 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Miguel Ojeda <ojeda@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Robin van der Gracht <robin@protonic.nl>,
	Paul Burton <paulburton@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] dt-bindings: auxdisplay: hit,hd44780: use defines
 for GPIO flags
Message-ID: <Zcz6dMz2h2jrhOXu@smile.fi.intel.com>
References: <20240214155438.155139-1-krzysztof.kozlowski@linaro.org>
 <20240214155438.155139-2-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240214155438.155139-2-krzysztof.kozlowski@linaro.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Feb 14, 2024 at 04:54:38PM +0100, Krzysztof Kozlowski wrote:
> Improve example DTS readability by using known defines for GPIO flags.

Applied, thanks!

-- 
With Best Regards,
Andy Shevchenko



