Return-Path: <linux-kernel+bounces-90636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0BD6870290
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 14:23:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80E011F21B07
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 13:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B83313D97F;
	Mon,  4 Mar 2024 13:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DR/vqkTq"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 757493D547;
	Mon,  4 Mar 2024 13:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709558575; cv=none; b=QHgZb6DympXSbLHahj/dnsrP8n/zVe/GaOuEF4htjU/lZ5AjMU2w5ygy1pUMbpYnrScu/Jf9lY4CjG7ZTvXBRIjCd+ZGQsHUDicQ1twd6WpX5LqxzAWO8lZ5AaqZl4w1XDimU8IvUn5EjLGZQgZwekhyiBmrcFJH96Kn0lk2XyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709558575; c=relaxed/simple;
	bh=wvqVrTZYUETegQB929WmfG/ja/6JUPIg5ef7y9GtyRE=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=JC6OxYSqak4KHcvZ7SXvl++6qLNX3ibFSDOeXKP+Ry7bQhG2Fe+WdXHEr2tvXghpWNrn9gqSQWSgC1IYP6VxMHiBa9EeemMQJSyo/glMyW1Nl+4+lapj1i9JITvGgvis36RunAtnm4laHgMrVYye1IfSIom1LjlyTVHaUIQzmnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DR/vqkTq; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709558574; x=1741094574;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=wvqVrTZYUETegQB929WmfG/ja/6JUPIg5ef7y9GtyRE=;
  b=DR/vqkTqYzUop2/LTwXpStpV/fXjKlL1h9K5BpMfuwr4QgfQYnbDRSyM
   zdGnrmWnYL/nChqfBbD4KSMs8uvG+GHeEJDdpz8eARva2sFMhAMSneRwV
   7cp3mnHU6hNE486Sel0RKwtFZ16xsL72HbygF46G6K0zBPwwte2rB/3BV
   4jK5toE2n81Q1y5syJNrQY1ERalFw6PXPOc4quB4l7E+1De8qglegU/bX
   wPmRI2URsDCmtZ9OT7jxrMAXcnw0oAGt7PDmZQItGRAAiFI25Bwlyo5t3
   yxCwsSGWbw1e9INf421ZNgQBRiK4PllI3pY+efSRcV+Se+JgUgACj5Hp8
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11002"; a="15198228"
X-IronPort-AV: E=Sophos;i="6.06,203,1705392000"; 
   d="scan'208";a="15198228"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 05:22:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,203,1705392000"; 
   d="scan'208";a="8946080"
Received: from ekohn-mobl1.ger.corp.intel.com (HELO localhost) ([10.246.49.145])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 05:22:50 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 4 Mar 2024 15:22:47 +0200 (EET)
To: Dan Carpenter <dan.carpenter@linaro.org>, 
    Shravan Kumar Ramani <shravankr@nvidia.com>
cc: Hans de Goede <hdegoede@redhat.com>, Vadim Pasternak <vadimp@nvidia.com>, 
    platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] platform/mellanox: mlxbf-pmc: fix signedness bugs
In-Reply-To: <a4af764e-990b-4ebd-b342-852844374032@moroto.mountain>
Message-ID: <9bdeba5e-0f33-c1d9-4cb4-6fdb42ec2fa9@linux.intel.com>
References: <a4af764e-990b-4ebd-b342-852844374032@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 29 Feb 2024, Dan Carpenter wrote:

> These need to be signed for the error handling to work.  The
> mlxbf_pmc_get_event_num() function returns int so int type is correct.
> 
> Fixes: 1ae9ffd303c2 ("platform/mellanox: mlxbf-pmc: Cleanup signed/unsigned mix-up")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
> The code in mlxbf_pmc_valid_range() has a check for negatives but that
> has a signedness bug too.  Fortunately "(u32)-EINVAL + 8" will not
> result in an integer overflow so the offset is treated as invalid.

Hi,

While this patch itself was fine so I applied it, when reviewing the patch 
I noticed that some of the kstrtouint() derived values were not properly 
bound checked (some were fed directly to FIELD_PREP()).

-- 
 i.


