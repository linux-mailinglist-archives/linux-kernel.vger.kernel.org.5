Return-Path: <linux-kernel+bounces-85455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 343C886B63E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 18:41:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD6541F23A8D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 17:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F86F3BBC5;
	Wed, 28 Feb 2024 17:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZkeVziyG"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B5B915B973;
	Wed, 28 Feb 2024 17:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709142096; cv=none; b=hH66DJ1KbgxG3LTNp2nejG03v+Qpd1bNAZgN6oNTebWwwC7WOBM9Kza/SrAFw3IH/6nzM1v4OiSgxFQ9w9AiIVUl/VuzI1RQaWUlyo/jNRrRdkjkLJkO12pTSpDYZlxMhMOj3zuvFvl0obCNpsHBvxS0o7D7sFc0mrfPj2sGvjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709142096; c=relaxed/simple;
	bh=ou/5HGkcYAX9xXteO2KtcJI6WR6PgAsdQKJqTBPuL6I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s1QXMtqWKxm0r3k5eG2GwM8hM0oFZIoWwoPr7T8Z2s4Z/PZLYVoCQ/iwaeGBgfQPYv6TdWoADrWKHwVdEfdMXdAkEoeZopjBPQQ6HLDWf0kDUWyZvDHlXtbq0Zmk1kone5eDhd6G9257v8XTA6XcLbtdgIkeOaSUNblbxkgh0o0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZkeVziyG; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709142095; x=1740678095;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ou/5HGkcYAX9xXteO2KtcJI6WR6PgAsdQKJqTBPuL6I=;
  b=ZkeVziyG5PXD+k/kjSWzt8F6kvsh8MeQqZycTBoSxxRnRlXRj4l3OLks
   EqhYH/AKmzrtR4eaS/PEAdAimfzL8ZlZ9Miqeew02Npc+OgxtykgOf0yN
   kjiddUE3h9ZNw9wozIvQtXkkChnYnOMKQ5BLUkJ8JKRz8Yqam6jZll6D1
   0pJcTWXQefwC0ufLBSDNvdjhqS/pfB/DXt3wvYMauiuE73te6PHYVehW/
   v9MLuFm/R1xS1ztwFw060VUa8GIcp+5m6sDBN/HI+M1Tdh7L2T9vntyk2
   wqUTIuxkB22zq5CBW4UpWEj75Z4SQqenZv+6DZiWuZVKdbepkfAt/ikL0
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="14998058"
X-IronPort-AV: E=Sophos;i="6.06,190,1705392000"; 
   d="scan'208";a="14998058"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 09:41:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="913956560"
X-IronPort-AV: E=Sophos;i="6.06,190,1705392000"; 
   d="scan'208";a="913956560"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 09:41:30 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rfNvq-00000008Hpf-41CM;
	Wed, 28 Feb 2024 19:41:26 +0200
Date: Wed, 28 Feb 2024 19:41:26 +0200
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
Subject: Re: [PATCH 0/4] printk_index: Fix false positives
Message-ID: <Zd9wRpJcijVcoBvz@smile.fi.intel.com>
References: <cover.1709127473.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1709127473.git.geert+renesas@glider.be>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Feb 28, 2024 at 03:00:01PM +0100, Geert Uytterhoeven wrote:
> 	Hi all,
> 
> When printk-indexing is enabled, each printk() invocation emits a
> pi_entry structure, containing the format string and other information
> related to its location in the kernel sources.  This is even true when
> the printk() is protected by an always-false check, as is typically the
> case for debug messages: while the actual code to print the message is
> optimized out by the compiler, the pi_entry structure is still emitted.
> Hence when debugging is disabled, this leads to the inclusion in the
> index of lots of printk formats that cannot be emitted by the current
> kernel.
> 
> This series fixes that for the common debug helpers under include/.
> It reduces the size of an arm64 defconfig kernel with
> CONFIG_PRINTK_INDEX=y by ca. 1.5 MiB, or 28% of the overhead of
> enabling CONFIG_PRINTK_INDEX=y.
> 
> Notes:
>   - netdev_(v)dbg() and netif_(v)dbg() are not affected, as
>     net{dev,if}_printk() do not implement printk-indexing, except
>     for the single global internal instance of __netdev_printk().
>   - This series fixes only debug code in global header files under
>     include/.  There are more cases to fix in subsystem-specific header
>     files and in sources files.


The whole series makes a lot of sense and gives a good examples for above
mentioned subsystem specific code on how to do it in a better way.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko



