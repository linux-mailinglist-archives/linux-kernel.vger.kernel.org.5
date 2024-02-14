Return-Path: <linux-kernel+bounces-65481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C065854D9D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 17:04:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF5FA1C2295A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 16:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95DD35F845;
	Wed, 14 Feb 2024 16:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fWnAB+ZZ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E9025F48C
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 16:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707926673; cv=none; b=hhXUAzWqdJiyh6Gtfhalhqkm6fWK1Yyk42Kfut/guOs4l7nUuURpKUrZPEoCrvkdklJn7n0u4R+sK+dDg4RjRpXL2V0EEvb93s4uxtYgYYoXH8LlvYZKaqr1XIMuqabkLiHrKGN52Lx+vkkttFG5/gpLDXtxh1krrNFvtsfYKmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707926673; c=relaxed/simple;
	bh=zjlfI68VJqiV0mbJegPWkzuV795dERGuYQ9D2+q4/G8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LoqXgVwyzZyIZJGlcm7QxQ7x867fcdbgoMJpbm4VmFdS3wkEjN4JIEr6rS8A36Ln6kSW2x13Nobv+Hqxq6EGTs6/UCWaWD2V/kpr033RI2aGHKBRHAJ9+h3t/QVNLOm/hIRAOn5JVtQHcYgoQlfnHL7cCXMmWf5VnmQj9zaMsAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fWnAB+ZZ; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707926672; x=1739462672;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zjlfI68VJqiV0mbJegPWkzuV795dERGuYQ9D2+q4/G8=;
  b=fWnAB+ZZGOi1RbOiesIadK1Q/Bc5kvZm73m5SpZQojIT9eex30tGhhXr
   0UCNq2evdjvlgyuVOnAd3i8ys3Dyer/y1kUotqF/carxseGUPOwbxK6Cn
   RMy9VhaoEsJ8ApEGjCqJkcXKaF5JrsD/po3M8TSlxJykPEEzAh3qbUt3M
   mTepbSP15ZC4t3M2CmKrtgEB6vdojcPjXuzqRdhQhMh8NzFJCuI4hKUS8
   8B47UAisfAzX88p028zl8GpYBZYhSk/EKBuy4aZcYmxJFj8j2ga92IQdm
   npPYqMJEQvbVoI+HfkdbA9//yumaik58b9wA1qxObnpiS+it8vdOS4UB9
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10984"; a="1847373"
X-IronPort-AV: E=Sophos;i="6.06,159,1705392000"; 
   d="scan'208";a="1847373"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2024 08:04:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10984"; a="912089992"
X-IronPort-AV: E=Sophos;i="6.06,159,1705392000"; 
   d="scan'208";a="912089992"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2024 08:04:24 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1raHkF-00000004XCR-11L1;
	Wed, 14 Feb 2024 18:04:23 +0200
Date: Wed, 14 Feb 2024 18:04:22 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Michal Wajdeczko <michal.wajdeczko@intel.com>
Cc: linux-kernel@vger.kernel.org, Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Jani Nikula <jani.nikula@intel.com>
Subject: Re: [RFC] include/linux/make_type.h: Helpers for making u16/u32/u64
 values
Message-ID: <ZczkhqW5_vU_hDbg@smile.fi.intel.com>
References: <20240214155408.1569-1-michal.wajdeczko@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240214155408.1569-1-michal.wajdeczko@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Feb 14, 2024 at 04:54:08PM +0100, Michal Wajdeczko wrote:
> It is quite common practice to make u16, u32 or u64 values from
> smaller words.  Add simple helpers for that.

..

> +++ b/include/linux/make_type.h

If we go with this, please make better name so we can combine this with
upper/lower_*_bits() helpers which seems related semantically to this.

Also _type suffix is a bit confusing as we use _types in the headers
that provide just data type(s).


-- 
With Best Regards,
Andy Shevchenko



