Return-Path: <linux-kernel+bounces-31212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBD31832AA6
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 14:41:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F7901C24075
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 13:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3129752F7C;
	Fri, 19 Jan 2024 13:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e4hKaqae"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E905524BF
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 13:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705671671; cv=none; b=rmbRdsnsUEQcADzASh0+TObbP/k5pGtW2FGFaduxbjGiILWDTF19aNGNPqKNw/YaNZzbtOjKHT74uhPJ2oh9wI++wlOuFRCkF/8XZYa5/FNkcrvIXX9lGfAj1lkdXaV84IG2preFwi3Y0BYU+CmX+I3oOOFkC1bZnLQy9Pgq1f4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705671671; c=relaxed/simple;
	bh=a0lNdiGqJGzTgYirDwvNUCa4oTicsxd5wNupHFDNJ+g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YqkVcGzCSa0lwZxdVKcBGhHM0pscTfZ7jz2fib8XZiD1oFIpFedsGJdBP07SqsMStRNmi2oT+aePU5cUohOe3H3x8r7WcHQMn9SQk+zbY78rQ2g9RbCPlHhTAM5XC3dKYG9kscCHq71w5AIDBtuHIj4Cd/YuAfeItNiSwFRltEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e4hKaqae; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705671669; x=1737207669;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=a0lNdiGqJGzTgYirDwvNUCa4oTicsxd5wNupHFDNJ+g=;
  b=e4hKaqaetRKIWte/1qPGo8qZYyEfa/GeDQqX7rcqRSZ597zI+frUCErS
   ky0B2EcciJvYDqLdqy0ajXFiPxTAZrOAQHv5K/GwDAb8eSReudkaKlaDN
   ukE52wMe36DvtTdPGnTCQieTIyv4x/a4i7KkHJr7RVb07kVvT4N9TekmG
   IVwIbnYf3EJLK32cOKWTTFHN/TBfg1/Am/yghoOfD/ZM/4N6460EpjB5A
   p0U41CVQ95TQL7A4GefdU7Vf2bwLxnrkwViJ89KaMfbrixqP+SH99lasg
   cSH6Dq9h+21mBmVwVOjPToUoX+CJQChsI4TnfqX5783qX0SljsloBx0pp
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10956"; a="8119742"
X-IronPort-AV: E=Sophos;i="6.05,204,1701158400"; 
   d="scan'208";a="8119742"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2024 05:41:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10956"; a="777993378"
X-IronPort-AV: E=Sophos;i="6.05,204,1701158400"; 
   d="scan'208";a="777993378"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.54.38.190])
  by orsmga007.jf.intel.com with ESMTP; 19 Jan 2024 05:41:08 -0800
Received: by tassilo.localdomain (Postfix, from userid 1000)
	id 81007302B79; Fri, 19 Jan 2024 05:41:08 -0800 (PST)
From: Andi Kleen <ak@linux.intel.com>
To: Lance Yang <ioworker0@gmail.com>
Cc: akpm@linux-foundation.org,  zokeefe@google.com,
  songmuchun@bytedance.com,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] mm/madvise: introduce MADV_TRY_COLLAPSE for
 attempted synchronous hugepage collapse
In-Reply-To: <20240117050217.43610-1-ioworker0@gmail.com> (Lance Yang's
	message of "Wed, 17 Jan 2024 13:02:16 +0800")
References: <20240117050217.43610-1-ioworker0@gmail.com>
Date: Fri, 19 Jan 2024 05:41:08 -0800
Message-ID: <87ededl9u3.fsf@linux.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Lance Yang <ioworker0@gmail.com> writes:

> This idea was inspired by MADV_COLLAPSE introduced by Zach O'Keefe[1].
>
> Introduce a new madvise mode, MADV_TRY_COLLAPSE, that allows users to
> make a least-effort attempt at a synchronous collapse of memory at
> their own expense.
>
> The only difference from MADV_COLLAPSE is that the new hugepage allocation
> avoids direct reclaim and/or compaction, quickly failing on allocation errors.
>
> The benefits of this approach are:
>
> * CPU is charged to the process that wants to spend the cycles for the THP
> * Avoid unpredictable timing of khugepaged collapse
> * Prevent unpredictable stalls caused by direct reclaim and/or
> compaction

I haven't completely followed the discussion, but it seem your second
and third point could be addressed by a asynchronous THP fault without
any new APIs: allocate 2MB while failing quickly, then on failure get
a 4K page and provide it to the process, while asking khugepaged to
convert the page ASAP in the background, but only after
it managed to allocate a fresh 2MB page to minimize the process visible
down time.

I suppose that would be much more predictable, although there would be a
slightly risk of overwhelming khugepaged. The later could be
addressed by using a scalable workqueue that allocates more threads
when needed.

-Andi


