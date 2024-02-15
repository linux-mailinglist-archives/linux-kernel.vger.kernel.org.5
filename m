Return-Path: <linux-kernel+bounces-67590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B6E49856DCE
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 20:34:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63A6A1F25EB9
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 19:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79C771386AE;
	Thu, 15 Feb 2024 19:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R4/IGeaS"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9D6813A24E;
	Thu, 15 Feb 2024 19:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708025650; cv=none; b=Eq2fQ1PpX36pBgqqRH5U0WPoR+MNoA7F5G4gKoRm8APUl+p7FT95aQhb3LaVprtpx+lPoBlDtF+AUgfsD0Z3oL94j4VBsz0GQm+3ZME74THLSyTMVnEwkjiEHP67An3jD0jbu6xEiboSo6rZniidurAwjfpmK70SY984vmNcKno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708025650; c=relaxed/simple;
	bh=uI6p2EeYM8i+aIvLwXONNd+KHjJzBDE6AmusnfGfHWU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tC0hVUIuZd8BFz9xcpmVLpgOmyzDZZkvn0JZfvqzVMQcc7KkIeF16biPtzIDXJNOv3VXKv1jYp993J/RtMvS5yiFydUB9hDU6zj9oafg3jvYENgrRKZ0lLzkjlcoazJDJyCtv2dpnwiJdMfom078V/xzesrCbuotMKdktjSdx3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R4/IGeaS; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708025649; x=1739561649;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uI6p2EeYM8i+aIvLwXONNd+KHjJzBDE6AmusnfGfHWU=;
  b=R4/IGeaSNCICSNAnblNjGgyW8AwsURJyNjddio39Gfds1AyOm2KN/J3b
   VxiBdZbEU9omzd4HpZY4Ex05fFDW0f21eeC9w8IB/tpEYmth1ZZJPw8JV
   VVBbS3QMoHuoS8SsKh3HfYVWoEWXXwzqZMH9qdEnmVkRLg3VvWkKWgwn3
   9tKRbZnMdorXpRUAMW7TRlB0+HYlttYcGYGPywZXRRqVmcyMAw3k5EMOO
   6IGIW/mfitYOR7PqVIO10yJSEtWJHTMczlE/OFJF1VswNymsBT7IGzJc4
   iMeu7LiPxCPBPDmKtGZXK6xSKpgzgevSqvgcUV98+s1L3etecFOgxtMJl
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10985"; a="5948070"
X-IronPort-AV: E=Sophos;i="6.06,162,1705392000"; 
   d="scan'208";a="5948070"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2024 11:33:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10985"; a="912217507"
X-IronPort-AV: E=Sophos;i="6.06,162,1705392000"; 
   d="scan'208";a="912217507"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2024 11:33:34 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rahUB-00000004sJI-0qA7;
	Thu, 15 Feb 2024 21:33:31 +0200
Date: Thu, 15 Feb 2024 21:33:30 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Kees Cook <keescook@chromium.org>
Cc: Michal Wajdeczko <michal.wajdeczko@intel.com>,
	Jani Nikula <jani.nikula@intel.com>,
	Julia Lawall <Julia.Lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>, cocci@inria.fr,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] cocci: Add rules to find str_plural() replacements
Message-ID: <Zc5nCsE74E33PdD2@smile.fi.intel.com>
References: <20240215180156.work.548-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240215180156.work.548-kees@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Feb 15, 2024 at 10:02:00AM -0800, Kees Cook wrote:
> Add rules for finding places where str_plural() can be used. This
> currently finds:
>  54 files changed, 62 insertions(+), 61 deletions(-)

Can we extend this to cover string_choices and call the script probably
str_choices.cocci ?


-- 
With Best Regards,
Andy Shevchenko



