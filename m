Return-Path: <linux-kernel+bounces-61604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD6F4851424
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 14:10:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73FFB1F21751
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 13:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6E1E3A1C6;
	Mon, 12 Feb 2024 13:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SD7O2Yv0"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C83E2EB0E;
	Mon, 12 Feb 2024 13:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707743400; cv=none; b=dzbvVa0MyVpEe19w5ZUaPVCTH5ze10A15QjBcOd8O+2sWH6hJZAgmbsI0jkNsc6rd25pU/HgFg9Y9IMP4XfTkG4c3R7gicJODiZlTzoWBRrs6+CZRvn8t6ISH9mupiyCt89JyVKdtmfuwV+x6dexcgyC/6uAAAqXyEOYViStzgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707743400; c=relaxed/simple;
	bh=Wz8lmJrhPbGk6Ex3bZLvYi7zbdejWd4g60mupDQBJGI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uO3GIf33JN6K6mkTSw9qIITRNeOhv+MYZg9NjYDTZMMG2JA6gtyEJoCEN0yRQH1fGcjyq25mX3JNdB0Bdtw3+iOAU3KO6kH9t+JyZMOBpiMPrBbnaJW/fMJLW+EfHqVR4oN5u3f8XdI/QD3u7D4Kzc8l+HarKlThH3rv6YN7GKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SD7O2Yv0; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707743398; x=1739279398;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=Wz8lmJrhPbGk6Ex3bZLvYi7zbdejWd4g60mupDQBJGI=;
  b=SD7O2Yv06QEcTHYBEOXK1qCkpt3vOCSBdTzZOOKQUIEMQfqN7hxA+8wH
   NsrjytafXSIbaZQM6hcrw25xZIE0RU22BJu2qvwFAnYbNJCu6ttIwVMny
   UZgYbugXtmh4b2TGmBag3aFzKAdcFAWbnd5y5YTPysXcyYkdIEl2nJdCJ
   Bso7pxIy6WsgxffqFS0UzHEgSYD0Z+vyvpqNp2Uh2w11n9xyJdTrgdYTe
   3nJEfZP0R3goao5wD1qWl4Rq0LQKSIzuiYH2YZLCgj+NwbXIyUC1RsQS/
   NP41LaEdisEN3D1OIfheJE3Gk3XReJ8uCPF7RY5/1u/Y00/OVxUmFWxXG
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10981"; a="1840459"
X-IronPort-AV: E=Sophos;i="6.06,263,1705392000"; 
   d="scan'208";a="1840459"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 05:09:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,263,1705392000"; 
   d="scan'208";a="2977475"
Received: from belyakov-mobl.ccr.corp.intel.com (HELO localhost) ([10.252.63.91])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 05:09:55 -0800
From: Jani Nikula <jani.nikula@intel.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>, Daniel Vetter
 <daniel.vetter@ffwll.ch>
Cc: Dave Airlie <airlied@redhat.com>, Intel Graphics
 <intel-gfx@lists.freedesktop.org>, DRI <dri-devel@lists.freedesktop.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the drm-misc tree
In-Reply-To: <87le7q9hb9.fsf@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20240212122652.0961dc7c@canb.auug.org.au>
 <87le7q9hb9.fsf@intel.com>
Date: Mon, 12 Feb 2024 15:09:51 +0200
Message-ID: <871q9hakww.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, 12 Feb 2024, Jani Nikula <jani.nikula@intel.com> wrote:
> On Mon, 12 Feb 2024, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>> Hi all,
>>
>> After merging the drm-misc tree, today's linux-next build (x86_64
>> allmodconfig) failed like this:
>>
>> drivers/gpu/drm/tests/drm_mm_test.c: In function 'drm_test_mm_debug':
>> drivers/gpu/drm/tests/drm_mm_test.c:191:32: error: implicit declaration of function 'drm_debug_printer'; did you mean 'drm_dbg_printer'? [-Werror=implicit-function-declaration]
>>   191 |         struct drm_printer p = drm_debug_printer(test->name);
>>       |                                ^~~~~~~~~~~~~~~~~
>>       |                                drm_dbg_printer
>> drivers/gpu/drm/tests/drm_mm_test.c:191:32: error: invalid initializer
>> cc1: all warnings being treated as errors
>>
>> Caused by commit
>>
>>   e154c4fc7bf2 ("drm: remove drm_debug_printer in favor of drm_dbg_printer")
>>
>> I have used the drm-misc tree from next-20240209 for today.
>
> Fix at [1].

Commit 826eafebf68b ("drm/tests: mm: Convert to drm_dbg_printer") in
drm-misc-next.

>
> BR,
> Jani.
>
>
> [1] https://lore.kernel.org/r/20240209140818.106685-1-michal.winiarski@intel.com

-- 
Jani Nikula, Intel

