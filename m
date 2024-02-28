Return-Path: <linux-kernel+bounces-85445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10F8686B60E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 18:33:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B2171F266EC
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 17:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BDAB1369B1;
	Wed, 28 Feb 2024 17:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BKDciDoM"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD701E514
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 17:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709141613; cv=none; b=sMgc9IofqsvZVkNMwGCOGXd/QBuiOzUgyPVaK3XdkEim5HGHNj6OcMesgcTFdtnaI0STvTDIe3HTTA0p7zhNUwXNyTUuz74l3SAyEUR1xgjDiep61qpapRjO314YN88G+3ASL7epo56N8CaBAFZIEvEUlY+lynTy34RR0cpVo6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709141613; c=relaxed/simple;
	bh=rqnPGPHelN/v2OFh//pjXKa7moKmEKkSgoJmULvhJWk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qj0urbNkSkE/1J5P2G3ZypHIINlG3+KLYyoEJ+XjUyeQfZNjw/zLCaNg02QgEQCiJG6OwIZK0ehdDcaeTrzjy228HF/eHWKo1epcbnu2NBleZGR8borTNucbEj4gRFvdxZKsZmJ4L5TJQ2YJSwn6+IxmbH9ekfnkiQ5gDxT0upw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BKDciDoM; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709141612; x=1740677612;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rqnPGPHelN/v2OFh//pjXKa7moKmEKkSgoJmULvhJWk=;
  b=BKDciDoMtsQ8tkqGq9r1prtNq5LUhHNt/V2M3BHQKcTG30+UFSrd5SxU
   AZb+l71kzmE65FG2MbSCWgrjfaDUpoEkEeYoa7c2GdjurvyJOc0jfy973
   9gGqIyq28AsIDylvCNI20a6YYVh6uh3XJL6NsVSOy44eXG4ks6NnSP0Bf
   6r4ukR0RKC0A5GXpYCgshbx+KAC6eIIuzo4yf7ZnZFo+7OpidohcXAHnO
   7BcUSFYCCGxian7dEO0LcI9cf5KXkxyvl854b7v9e9I7du7XflzDuQnB7
   ehkIa84HB2jKa4v8cC9Yw1iMZHfwFIYaczm8aobq7lFpRUBWIU6Yezbs6
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="14996076"
X-IronPort-AV: E=Sophos;i="6.06,190,1705392000"; 
   d="scan'208";a="14996076"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 09:32:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="913956334"
X-IronPort-AV: E=Sophos;i="6.06,190,1705392000"; 
   d="scan'208";a="913956334"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 09:32:40 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rfNnK-00000008Hg8-043c;
	Wed, 28 Feb 2024 19:32:38 +0200
Date: Wed, 28 Feb 2024 19:32:37 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Shahar Avidar <ikobh7@gmail.com>
Cc: gregkh@linuxfoundation.org, luca.ceresoli@bootlin.com,
	benjamin.tissoires@redhat.com, elder@linaro.org, robh@kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/5] Fix defines in rf69.h
Message-ID: <Zd9uNZ4AijishLyI@smile.fi.intel.com>
References: <20240227221204.534131-1-ikobh7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240227221204.534131-1-ikobh7@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Feb 28, 2024 at 12:11:59AM +0200, Shahar Avidar wrote:
> This patchset fixes several misuses of the define statement in rf69.h.
> Duplicted defines.
> Define in header instead of source file.
> Unused define.
> Using units.h macro to define frequency.

Good enough (esp. for staging),
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko



