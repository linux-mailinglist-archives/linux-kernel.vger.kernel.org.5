Return-Path: <linux-kernel+bounces-110336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E2BB885D63
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 17:27:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B998AB237D7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 16:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5A2912CD8D;
	Thu, 21 Mar 2024 16:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Io2Oecbi"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FEAC12CD82
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 16:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711038419; cv=none; b=lozzRTI8UUbybJt7/g1ja0qQ5C5T06jsf1RWQzS2mym8IzTfbJcCvztHbk5j9lazlXq2nHtRe7F9N4Bmb9HdGDknlvHarjGVDo+Ln6KMSmZ9EwMdBouQRgTVEXhsornW1pmnazoTZd6RnD15ER2nJqvksp07zl8WyHhXL/c0NfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711038419; c=relaxed/simple;
	bh=D7HGVSLVQqGuARtC5/0x7M5RBu9MLX3psyFHyMMmHxs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FrvIBp2PUbOAcFO2qnAjg+RZslTNAVEp9bRfjYNnvP3NcA/ANkvEn9kUgZRuRwyPg7LK1T0c28YU7ShKhVJmEcNq+v42Lo+AXdjX7ZGLKGPm/wT1Mk4/8T9VzXFaO6tfkFyastpz+3LKzVR9wI7NMOwCr1ymIw19ds7NY4T7zDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Io2Oecbi; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711038417; x=1742574417;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=D7HGVSLVQqGuARtC5/0x7M5RBu9MLX3psyFHyMMmHxs=;
  b=Io2OecbiKxtICbXhUNHbEMWijKWZ6Ufzd43otMICBlraVjprI1YIyR49
   th9prYvTPPmmKCuNIUo9z1RF9LTiBCFbI1n5J9+zbYEQNeKbc3aGKbohL
   ieYWTOQF3ZKYYZfeJDHYFdcxRg9igb6lnNLLsf9mlF9rOqWujUuGYFLsF
   At9Sr/nE1IFe4l84FKhIyPdL/ZY8UXfUIek6VxX5dJtu9GEjHVN9f+1do
   lohFWLjLb/UJeo2+X5g192y51zrwG8Q5EOtl3St4OkWJTzqVJMBOloR1P
   vRfm4bIUDzyZy8rGmFHEEfLHvtqlqJhLkLYVrvrsfKJhKZZBNSOKIVAxm
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11020"; a="5875238"
X-IronPort-AV: E=Sophos;i="6.07,143,1708416000"; 
   d="scan'208";a="5875238"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2024 09:26:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,143,1708416000"; 
   d="scan'208";a="52010322"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orviesa001.jf.intel.com with ESMTP; 21 Mar 2024 09:26:51 -0700
Received: from pkitszel-desk.intel.com (unknown [10.249.142.68])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id B9AC42819D;
	Thu, 21 Mar 2024 16:26:48 +0000 (GMT)
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
To: jiri@resnulli.us
Cc: 42.hyeyoo@gmail.com,
	akpm@linux-foundation.org,
	cl@linux.com,
	danielj@nvidia.com,
	iamjoonsoo.kim@lge.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	mingo@kernel.org,
	penberg@kernel.org,
	peterz@infradead.org,
	rientjes@google.com,
	roman.gushchin@linux.dev,
	vbabka@suse.cz
Subject: Re [patch RFC] mm/slab: introduce KZALLOC_FREE() cleanup-ed allocation macro
Date: Thu, 21 Mar 2024 17:26:48 +0100
Message-ID: <20240321162648.23693-1-przemyslaw.kitszel@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240315132249.2515468-1-jiri@resnulli.us>
References: <20240315132249.2515468-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> From: Jiri Pirko <jiri@nvidia.com>
> 
> With introduction of __free() macro using cleanup infrastructure, it
> will very likely become quite common to see following pattern:
> 	type *var __free(kfree) = kzalloc(sizeof(*var), GFP_KERNEL);
> 
> To follow the CLASS() flow from cleanup.h, introduce a simple macro
> KZALLOC_FREE() to wrap this over and allow the same flow.
> 
> Show an example usage in gpio-sim driver.
> 
> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
> ---
>  drivers/gpio/gpio-sim.c | 3 +--
>  include/linux/slab.h    | 3 +++
>  2 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpio/gpio-sim.c b/drivers/gpio/gpio-sim.c
> index c4106e37e6db..997237b3d80c 100644
> --- a/drivers/gpio/gpio-sim.c
> +++ b/drivers/gpio/gpio-sim.c
> @@ -1496,8 +1496,7 @@ gpio_sim_config_make_device_group(struct config_group *group, const char *name)
>  {
>  	int id;
>  
> -	struct gpio_sim_device *dev __free(kfree) = kzalloc(sizeof(*dev),
> -							    GFP_KERNEL);
> +	KZALLOC_FREE(struct gpio_sim_device *, dev, GFP_KERNEL);
>  	if (!dev)
>  		return ERR_PTR(-ENOMEM);
>  
> diff --git a/include/linux/slab.h b/include/linux/slab.h
> index b5f5ee8308d0..baee6acd58d3 100644
> --- a/include/linux/slab.h
> +++ b/include/linux/slab.h
> @@ -711,6 +711,9 @@ static inline __alloc_size(1) void *kzalloc(size_t size, gfp_t flags)
>  	return kmalloc(size, flags | __GFP_ZERO);
>  }
>  
> +#define KZALLOC_FREE(_type, var, _gfp_t)				\
> +	_type var __free(kfree) = kzalloc(sizeof(*var), _gfp_t)
> +

Nice, but I would rather see this wrapper in the cleanup.h file, that have all
of the rest of related stuff.

On top of that, I want to propose also a wrapper that is simpler in that it
does not allocate but just assigns null, with that in mind `_FREE` part of your
proposed name does not sound right.

Most of the similar functions that define or declare something are named
DEFINE_STH...

(Please CC me on any future version, I have to go, sorry).

>  /**
>   * kzalloc_node - allocate zeroed memory from a particular memory node.
>   * @size: how many bytes of memory are required.
> -- 
> 2.44.0
> 
> 

