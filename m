Return-Path: <linux-kernel+bounces-25155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C84E282C8AE
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 02:24:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68D03B22AB3
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 01:24:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6B5C1A5B7;
	Sat, 13 Jan 2024 01:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A9acqmTk"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FF101A28F
	for <linux-kernel@vger.kernel.org>; Sat, 13 Jan 2024 01:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705109059; x=1736645059;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wOrYmsGbl+fO69fVopxBaZqDLxeOsTiN8hKc9Pxlk74=;
  b=A9acqmTktYC1ttjbn0O6yRtChV6SGpGMauvnRv2FMtqmXSvT9ftZp++s
   EfW4lwzdPK//2Elv4TjCPwHufyEf6v6dV3QGKuSjGOek1JFrks70oDwaD
   hszY/p33lYuZ4poaTIo4bkG3IRP+LN1on8RdzL8Z+JMmgGFVPpUa6ptdN
   BVAO54I5UC7Gf3jLfnsIjH03VFJBiRJ0efxqoVWYEIW74xA8gF2QMO82b
   f5PqhXptXhP7OFzdsWaDHdzCGMrRtJC0kCQYUSqhq7jEGI6xYAvFg42lP
   8Be9kY4eORV1mVjqIRLeniyTIMRC1lbGIhHSht90IRYR2lMFHCrVQiG42
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10951"; a="6088497"
X-IronPort-AV: E=Sophos;i="6.04,191,1695711600"; 
   d="scan'208";a="6088497"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2024 17:24:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10951"; a="817264197"
X-IronPort-AV: E=Sophos;i="6.04,191,1695711600"; 
   d="scan'208";a="817264197"
Received: from tassilo.jf.intel.com (HELO tassilo) ([10.54.38.190])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2024 17:24:18 -0800
Date: Fri, 12 Jan 2024 17:24:17 -0800
From: Andi Kleen <ak@linux.intel.com>
To: Marco Elver <elver@google.com>
Cc: Andrey Konovalov <andreyknvl@gmail.com>,
	Oscar Salvador <osalvador@suse.de>, andrey.konovalov@linux.dev,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexander Potapenko <glider@google.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Vlastimil Babka <vbabka@suse.cz>, kasan-dev@googlegroups.com,
	Evgenii Stepanov <eugenis@google.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Andrey Konovalov <andreyknvl@google.com>
Subject: Re: [PATCH v4 12/22] lib/stackdepot: use read/write lock
Message-ID: <ZaHmQU5DouedI9kS@tassilo>
References: <cover.1700502145.git.andreyknvl@google.com>
 <9f81ffcc4bb422ebb6326a65a770bf1918634cbb.1700502145.git.andreyknvl@google.com>
 <ZZUlgs69iTTlG8Lh@localhost.localdomain>
 <87sf34lrn3.fsf@linux.intel.com>
 <CANpmjNNdWwGsD3JRcEqpq_ywwDFoxsBjz6n=6vL5YksNsPyqHw@mail.gmail.com>
 <ZZ_gssjTCyoWjjhP@tassilo>
 <ZaA8oQG-stLAVTbM@elver.google.com>
 <CA+fCnZeS=OrqSK4QVUVdS6PwzGrpg8CBj8i2Uq=VMgMcNg1FYw@mail.gmail.com>
 <CANpmjNOoidtyeQ76274SWtTYR4zZPdr1DnxhLaagHGXcKwPOhA@mail.gmail.com>
 <ZaG56XTDwPfkqkJb@elver.google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZaG56XTDwPfkqkJb@elver.google.com>

On Fri, Jan 12, 2024 at 11:15:05PM +0100, Marco Elver wrote:
> +		/*
> +		 * Stack traces of size 0 are never saved, and we can simply use
> +		 * the size field as an indicator if this is a new unused stack
> +		 * record in the freelist.
> +		 */
> +		stack->size = 0;

I would use WRITE_ONCE here too, at least for TSan.

> +		return NULL;
> +
> +	/*
> +	 * We maintain the invariant that the elements in front are least
> +	 * recently used, and are therefore more likely to be associated with an
> +	 * RCU grace period in the past. Consequently it is sufficient to only
> +	 * check the first entry.
> +	 */
> +	stack = list_first_entry(&free_stacks, struct stack_record, free_list);
> +	if (stack->size && !poll_state_synchronize_rcu(stack->rcu_state))

READ_ONCE (also for TSan, and might be safer long term in case the
compiler considers some fancy code transformation)

> +		return NULL;
>  
> +		stack = depot_pop_free();
> +		if (WARN_ON(!stack))

Won't you get nesting problems here if this triggers due to the print?
I assume the nmi safe printk won't consider it like an NMI.

>  	counters[DEPOT_COUNTER_FREELIST_SIZE]++;
>  	counters[DEPOT_COUNTER_FREES]++;
>  	counters[DEPOT_COUNTER_INUSE]--;
> +
> +	printk_deferred_exit();

Ah this handles the WARN_ON? Should be ok then.

-Andi

