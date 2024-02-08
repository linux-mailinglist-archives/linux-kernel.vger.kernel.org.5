Return-Path: <linux-kernel+bounces-57671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAA9F84DC07
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 09:54:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE0D11C25D93
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 08:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 465E176020;
	Thu,  8 Feb 2024 08:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LHtdaUei"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D9E6E2B8
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 08:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707382213; cv=none; b=WF0NX3u/pvti7IZ+KLrFsxqA3jW9qQsjaygmuI0KECBPTcSo5D9dKlMm49P0xiPFCDU9qpCfP2VF5VzepHYrm9mGQFgjQ6MZDYrYnu4I2xCKtPad53x9FqBgQcYPZOaTJiGvbRxi5+WOQYx/0SrQOCOZk3YgwTGWdfRYZCoie7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707382213; c=relaxed/simple;
	bh=0lR0Js2Ta6ESjjgeXWYiaIlClzCWLnCunSK0HHuu9dE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=n2WyqRnZtr/1Sk17yqmZGrbbTkL3ddm+mH8RCRRJ7Xkz5gqCoov9DifCQwU3lg9PPW5QTe6GMlAL3uZWlYEzvydaFp6fibmFO4PbVPw6wYTt+GxMUOGTjkjJC2vhZm6KsLWMSafvFiv32j1QzZdFGkd4dS4L3BoIjIicxn9aYIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LHtdaUei; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707382211; x=1738918211;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=0lR0Js2Ta6ESjjgeXWYiaIlClzCWLnCunSK0HHuu9dE=;
  b=LHtdaUei2mWgF11jrzXUM8EAMPNu3DfkN5WE29bhgq7B7gPPJt334efk
   qdabvbAL0vJY7CClRie1YOcZ9SkcYE1Q6AvAMkAPKO2HXPtftRQfC0PM3
   jqdJPTwmDATRZSxaAaYuUzLeG6487ISh5cb7llq3klq0sQabsxlqUP2KJ
   N8RCn6rYyYo5f2LKK/A2X0/VmOX5QmkFVWh3JCDekYXWjnv8JJb/tysP2
   340HspukyIsfEEyfJLhD1kI5zU5Y95hef0ysllygOs5nkwgEx4EHv3Mym
   SDGaW0JoySkgWuLPVla2l9dkdFa/qapaSZLb+Xe3bS/fwYpe/9Mfg9mOt
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10977"; a="1071740"
X-IronPort-AV: E=Sophos;i="6.05,253,1701158400"; 
   d="scan'208";a="1071740"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 00:50:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,253,1701158400"; 
   d="scan'208";a="1837099"
Received: from aavzirov-mobl.ger.corp.intel.com (HELO localhost) ([10.252.61.13])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 00:50:04 -0800
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Lucas De Marchi <lucas.demarchi@intel.com>, Yury Norov
 <yury.norov@gmail.com>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Andy
 Shevchenko <andriy.shevchenko@linux.intel.com>,
 intel-xe@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, Lucas De
 Marchi <lucas.demarchi@intel.com>
Subject: Re: [PATCH v3 3/3] drm/i915: Convert REG_GENMASK* to fixed-width
 GENMASK_*
In-Reply-To: <20240208074521.577076-4-lucas.demarchi@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20240208074521.577076-1-lucas.demarchi@intel.com>
 <20240208074521.577076-4-lucas.demarchi@intel.com>
Date: Thu, 08 Feb 2024 10:49:58 +0200
Message-ID: <875xyzcpc9.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, 07 Feb 2024, Lucas De Marchi <lucas.demarchi@intel.com> wrote:
> Now that include/linux/bits.h implements fixed-width GENMASK_*, use them
> to implement the i915/xe specific macros. Converting each driver to use
> the generic macros are left for later, when/if other driver-specific
> macros are also generalized.
>
> Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
> Acked-by: Jani Nikula <jani.nikula@intel.com>

Thanks for doing this!

This is fine to merge via whichever tree you find best. The i915 parts
have very little conflict potential, there haven't been changes here in
a while.

BR,
Jani.


-- 
Jani Nikula, Intel

