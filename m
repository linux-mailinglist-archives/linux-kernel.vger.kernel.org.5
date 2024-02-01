Return-Path: <linux-kernel+bounces-47478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 25588844E74
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 02:12:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8ECF61F2B833
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 01:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 024F55255;
	Thu,  1 Feb 2024 01:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZnvbKHVI"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C5585234;
	Thu,  1 Feb 2024 01:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706749733; cv=none; b=GTiHHDK9Z9Gxn57mnMYDgGqm0caj/0x7wziWqIzE5qij9lzgdpcc/5VXvwzj/nYuUIPLxcaM6Pw4hQJv4HjhvDmWKiClQm71V5ygbl/EvYrekCaaEiuryLDF5a2gGiOfujGnT6ZkVGe2ue3E/IeuhB2gYEjUZ0SadmmhmE0aM2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706749733; c=relaxed/simple;
	bh=wepony5/D8UeXMHqv4TWwd2Y5ZKTXYDkBHaFDO5jjNM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R2IlPDece3NcgUvyCIEM7J7TZ+vTn/bwRQX/xYMtiFiFmhNJsBmiTl7HykeHJh0oTDlZIIAGkcd8qRz2oBApyJckpVkFYw18s1TDYxqDQiwhZeGik1K1BR8L1gP+Th3eyD34pc3T8pIo001WTIIqDdysx1LSwupqM2uqjLpyB08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZnvbKHVI; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706749732; x=1738285732;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wepony5/D8UeXMHqv4TWwd2Y5ZKTXYDkBHaFDO5jjNM=;
  b=ZnvbKHVI+OAmhvmH8HmRQkftAa/MRUMsEmQJSFJhgMA3/kWymFnK+OKB
   3lM3bFPBbAXCerwMs16vLv0EHCECTIgCfsZytNwbgA4/GzQJ3YWOIjspX
   x5oo1ZqTW8kl1XubdMgqdRbI2hEpJleq133NVBmVuFOgbcOos2QG80D2d
   F7GGACLZIhXyOpyPl4JxUlkS7Xf6uHoKS6deKtERIXtuyIYc2THBkKsgT
   jOuugHnh0LVPdnuKOXe7M+mupVa/Tn3PKCp+F+SYjWYWLZiOtOcfIhQQK
   OkOLl0NZu2tYdN+RV40QCFBAAkiEldTZsuEPzbkFKiSDt78j9ujqpbsH+
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="22276487"
X-IronPort-AV: E=Sophos;i="6.05,233,1701158400"; 
   d="scan'208";a="22276487"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 17:08:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="858991587"
X-IronPort-AV: E=Sophos;i="6.05,233,1701158400"; 
   d="scan'208";a="858991587"
Received: from tomaszbi-mobl.ger.corp.intel.com (HELO fdefranc-mobl3.localnet) ([10.213.21.45])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 17:08:48 -0800
From: "Fabio M. De Francesco" <fabio.maria.de.francesco@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>, dan.j.williams@intel.com
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
 linux-cxl@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>
Subject: Re: [RFC PATCH v3] cleanup: Add cond_guard() to conditional guards
Date: Thu, 01 Feb 2024 02:08:44 +0100
Message-ID: <6168759.DvuYhMxLoT@fdefranc-mobl3>
Organization: intel
In-Reply-To:
 <20240131134108.423258-1-fabio.maria.de.francesco@linux.intel.com>
References: <20240131134108.423258-1-fabio.maria.de.francesco@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

I just noticed that this is not the final version. It misses a semicolon. 
Please discard this v3. I'm sending v4.

Fabio

On Wednesday, 31 January 2024 14:37:35 CET Fabio M. De Francesco wrote:
> Add cond_guard() to conditional guards.
> 
> cond_guard() is used for the _interruptible(), _killable(), and _try
> versions of locks.
> 
> It stores a return value to a variable whose address is given to its
> second argument, that is either '-1' on failure or '0' on success to
> acquire a lock. The returned value can be checked to act accordingly
> (e.g., to call printk() and return -EINTR in case of failure of an
> _interruptible() variant)
> 
> As the other guards, it avoids to open code the release of the lock
> after a goto to an 'out' label.
> 
> This remains an RFC because Dan suggested a slightly different syntax.
> 
> The changes to the CXL code are provided only to show the use of this
> macro. If consensus is gathered on this macro, the cleanup of
> show_targetN() will be submitted later in a separate patch.
> 
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Suggested-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Fabio M. De Francesco
> <fabio.maria.de.francesco@linux.intel.com> ---
> 
> Changes from v1 and v2:
> 	I've taken into account Dan's comments (thanks).
> 
>  drivers/cxl/core/region.c | 15 +++++----------
>  include/linux/cleanup.h   | 19 +++++++++++++++++++
>  2 files changed, 24 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 0f05692bfec3..560f25bdfd11 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -668,26 +668,21 @@ static size_t show_targetN(struct cxl_region *cxlr,
> char *buf, int pos) struct cxl_endpoint_decoder *cxled;
>  	int rc;
> 
> -	rc = down_read_interruptible(&cxl_region_rwsem);
> +	cond_guard(rwsem_read_intr, &rc, &cxl_region_rwsem);
>  	if (rc)
> -		return rc;
> +		return -EINTR;
> 
>  	if (pos >= p->interleave_ways) {
>  		dev_dbg(&cxlr->dev, "position %d out of range %d\n", pos,
>  			p->interleave_ways);
> -		rc = -ENXIO;
> -		goto out;
> +		return -ENXIO;
>  	}
> 
>  	cxled = p->targets[pos];
>  	if (!cxled)
> -		rc = sysfs_emit(buf, "\n");
> +		return sysfs_emit(buf, "\n");
>  	else
> -		rc = sysfs_emit(buf, "%s\n", dev_name(&cxled->cxld.dev));
> -out:
> -	up_read(&cxl_region_rwsem);
> -
> -	return rc;
> +		return sysfs_emit(buf, "%s\n", dev_name(&cxled->cxld.dev));
>  }
> 
>  static int match_free_decoder(struct device *dev, void *data)
> diff --git a/include/linux/cleanup.h b/include/linux/cleanup.h
> index c2d09bc4f976..a4b40d511f9e 100644
> --- a/include/linux/cleanup.h
> +++ b/include/linux/cleanup.h
> @@ -134,6 +134,20 @@ static inline class_##_name##_t
> class_##_name##ext##_constructor(_init_args) \ *	an anonymous instance of
> the (guard) class, not recommended for *	conditional locks.
>   *
> + * cond_guard(name, ret, args...):
> + * 	for conditional locks like mutex_trylock() or
> down_read_interruptible(). + * 	'ret' is a pointer to a variable 
where this
> macro stores 0 on success + * 	and -1 on failure to acquire a lock.
> + *
> + * 	Example:
> + *
> + * 	int ret;
> + * 	cond_guard(rwsem_read_try, &ret, &sem);
> + * 	if (ret) {
> + * 		dev_dbg("down_read_trylock() failed to down 'sem')\n");
> + * 		return 0; // down_read_trylock() returns 0 on contention
> + * 	}
> + *
>   * scoped_guard (name, args...) { }:
>   *	similar to CLASS(name, scope)(args), except the variable (with the
>   *	explicit name 'scope') is declard in a for-loop such that its scope 
is
> @@ -165,6 +179,11 @@ static inline class_##_name##_t
> class_##_name##ext##_constructor(_init_args) \
> 
>  #define __guard_ptr(_name) class_##_name##_lock_ptr
> 
> +#define cond_guard(_name, _ret, args...) \
> +	CLASS(_name, scope)(args); \
> +	if (!__guard_ptr(_name)(&scope)) *_ret = -1 \
> +	else *_ret = 0
> +
>  #define scoped_guard(_name, args...)					\
>  	for (CLASS(_name, scope)(args),					\
>  	     *done = NULL; __guard_ptr(_name)(&scope) && !done; done = (void 
*)1)





