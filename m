Return-Path: <linux-kernel+bounces-85452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CD6DC86B632
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 18:39:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5EA83B21BC4
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 17:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C3EF15CD6A;
	Wed, 28 Feb 2024 17:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gHIgNzNT"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E666373509;
	Wed, 28 Feb 2024 17:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709141969; cv=none; b=s772BrznUHP5jBQ3/Dx2vW9kVWnRKZNW+X9oNoiqSqi2p+Om0IoEdSY9jeVSVsWg1lO4Ra5HWDzD/BYgxCTLMkc3v5ca3n7qeYG9tqb2uHLAXkIB2bN8chSVKhaqMUX7IH0SPDS7gYCAOM85sXHv1uw9wOkrGOz4RHVWNmxTB/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709141969; c=relaxed/simple;
	bh=FyH6BIiOWiWBx3YnExZt3Z2Nqd/kjnaRsbM9Vu4zJ5A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TgG+PqfdhLQT2ei5PPQw8sZmpUDhuo804mYlQjxttH9/2g6VJ4tTdvcHLUZ9lz7F6ThGxdtbXO/9TU10e7LMQUNzCvUjBgEf8KMg34WnqMk9uvHsHeso2I8+fDrhjGChrNi0wU/OGllazYKS4VyZz4gW6z79702a35rHaJSd4f0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gHIgNzNT; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709141968; x=1740677968;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FyH6BIiOWiWBx3YnExZt3Z2Nqd/kjnaRsbM9Vu4zJ5A=;
  b=gHIgNzNT0w+HCJl1CXWeAn3lVkNXgyZ+XF2SymHKH4ELD6XkLEJ7g1fa
   vHWD9GLZehMIS4Rp9IHOJW7eOsxtVOC5WZAnKNHq9ZKmu56WfgKVhx4JO
   vIsQlVXwWF2THdiiuZFeS+LYcage7gkPMgZSV1yP40wXIYlzi/anLTVL7
   13fn5uvzI1aUG6qYhd/OXDo2+n6lSx9MxHnmAXVvTLxNk7B02giVYFwp7
   iGdfzFRoo0rCvVjrQ5nDUV3GnQ2LztqDrzRVGlZnfT2tYq6N6MeTuL24Q
   BedSdAtr3Qa2CdDlMO0DwHBz4E52dAtzW36IG1nxtihVFNCuzTDC33mtA
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="14997460"
X-IronPort-AV: E=Sophos;i="6.06,190,1705392000"; 
   d="scan'208";a="14997460"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 09:39:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="913956496"
X-IronPort-AV: E=Sophos;i="6.06,190,1705392000"; 
   d="scan'208";a="913956496"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 09:39:23 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rfNto-00000008HnM-015k;
	Wed, 28 Feb 2024 19:39:20 +0200
Date: Wed, 28 Feb 2024 19:39:19 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Chris Down <chris@chrisdown.name>, Petr Mladek <pmladek@suse.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jessica Yu <jeyu@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Jason Baron <jbaron@akamai.com>, Jim Cromie <jim.cromie@gmail.com>,
	Ilya Dryomov <idryomov@gmail.com>, Xiubo Li <xiubli@redhat.com>,
	Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org,
	ceph-devel@vger.kernel.org
Subject: Re: [PATCH 2/4] dev_printk: Add and use dev_no_printk()
Message-ID: <Zd9vx2pM3Ds9-dzk@smile.fi.intel.com>
References: <cover.1709127473.git.geert+renesas@glider.be>
 <8583d54f1687c801c6cda8edddf2cf0344c6e883.1709127473.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8583d54f1687c801c6cda8edddf2cf0344c6e883.1709127473.git.geert+renesas@glider.be>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Feb 28, 2024 at 03:00:03PM +0100, Geert Uytterhoeven wrote:
> When printk-indexing is enabled, each dev_printk() invocation emits a
> pi_entry structure.  This is even true when the dev_printk() is
> protected by an always-false check, as is typically the case for debug
> messages: while the actual code to print the message is optimized out by
> the compiler, the pi_entry structure is still emitted.
> 
> Avoid emitting pi_entry structures for unavailable dev_printk() kernel
> messages by:
>   1. Introducing a dev_no_printk() helper, mimicked after the existing
>      no_printk() helper, which calls _dev_printk() instead of
>      dev_printk(),
>   2. Replacing all "if (0) dev_printk(...)" constructs by calls to the
>      new helper.
> 
> This reduces the size of an arm64 defconfig kernel with
> CONFIG_PRINTK_INDEX=y by 957 KiB.

..

> +/*
> + * Dummy dev_printk for disabled debugging statements to use whilst maintaining

dev_printk()

> + * gcc's format checking.
> + */
> +#define dev_no_printk(level, dev, fmt, ...)				\
> +	({								\
> +		if (0)							\
> +			_dev_printk(level, dev, fmt, ##__VA_ARGS__);	\
> +	})

-- 
With Best Regards,
Andy Shevchenko



