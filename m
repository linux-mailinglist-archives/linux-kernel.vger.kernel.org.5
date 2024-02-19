Return-Path: <linux-kernel+bounces-70955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E3E0A859EAB
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 09:46:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 743A4B21E96
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 08:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2748623776;
	Mon, 19 Feb 2024 08:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N+Zqi9N1"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F38FB21370
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 08:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708332339; cv=none; b=o+/Qs/548WbJOcHI8Y3nwklwEmzBRE6xjIcJW/U8DwEiahvle4BOmuqycUARpwe47wWvbWofjcwnnZK8wAc7boiU/W69ujT7RhgTo9js6ijYsGqcFpV/3HWYjlGklWr0wvQyF/nrhfp584KZW8gmQeqNDtNPCtvkMySnYf+3aWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708332339; c=relaxed/simple;
	bh=zVnfL6Jp+oSJOUtDQ+unuSLLB1RYfJ3Mtfu5OW3hnRo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cU3h5Qh0BYdzPjdVqg2jxlyijugyObJ4qUGHgc9duWm5mTJkqvsJjGXb5X7KGEFMPRQulYuF2NezdOd7Ukh/NXz3aL4yZepygkujVc3RCuN767ie0un97PNnrU/ud8MuPc2yNrs7Obfws9opLCiVKG+duWvk1VRHDiCnongoc4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N+Zqi9N1; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708332337; x=1739868337;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=zVnfL6Jp+oSJOUtDQ+unuSLLB1RYfJ3Mtfu5OW3hnRo=;
  b=N+Zqi9N1R2dD2p+HJnmeCpQPJrGxmzajWfMqTdSjo7rqGHk7mKxPcEnh
   dbwk/n7Gd8IEzVYpKXHDaw9PUQei9lHeUgVF6qW/Tgu/RlLePpz9qEwBj
   Rh1ewjMP7IIhzBWFkck8szydJOvbJTshBIXbfxE/9qvCO9F+RPBsOv2X8
   DekDBMl5qD/56iYX9ElDOvCmk5+7JXWVOHTTRJxK+97orOFN89EYdn/Ve
   gdLJ4mdfclDnxkaeOq0Mr+o8nP/zGpBNkm4fP3NS83XxcNhq141yCJcNP
   CTpXrptL8+V/y6+XR7yGVFYPiiTUHM2Corn2UOF/H37QH5AXJATcAo4C5
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10988"; a="6203668"
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="6203668"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2024 00:45:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="9100008"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2024 00:45:33 -0800
From: "Huang, Ying" <ying.huang@intel.com>
To: Byungchul Park <byungchul@sk.com>
Cc: mingo@redhat.com,  peterz@infradead.org,  juri.lelli@redhat.com,
  vincent.guittot@linaro.org,  dietmar.eggemann@arm.com,
  rostedt@goodmis.org,  bsegall@google.com,  mgorman@suse.de,
  bristot@redhat.com,  vschneid@redhat.com,  linux-kernel@vger.kernel.org,
  linux-mm@kvack.org,  kernel_team@skhynix.com,  akpm@linux-foundation.org
Subject: Re: [PATCH v4] sched/numa, mm: do not try to migrate memory to
 memoryless nodes
In-Reply-To: <20240219041920.1183-1-byungchul@sk.com> (Byungchul Park's
	message of "Mon, 19 Feb 2024 13:19:20 +0900")
References: <20240219041920.1183-1-byungchul@sk.com>
Date: Mon, 19 Feb 2024 16:43:36 +0800
Message-ID: <87o7ccrghz.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Hi, Byungchul,

Byungchul Park <byungchul@sk.com> writes:

> Changes from v3:
> 	1. Rewrite the comment in code and the commit message to make it
> 	   more clear. (feedbacked by Oscar Salvador)
> 	2. Add "Reviewed-by: Oscar Salvador <osalvador@suse.de>"
>
> Changes from v2:
> 	1. Rewrite the comment in code and the commit message becasue it
> 	   turns out that this patch is not the real fix for the oops
> 	   descriped. The real fix goes in another patch below:
>
> 	   https://lore.kernel.org/lkml/20240216111502.79759-1-byungchul@sk.com/
>
> Changes from v1:
> 	1. Trim the verbose oops in the commit message. (feedbacked by
> 	   Phil Auld)
> 	2. Rewrite a comment in code. (feedbacked by Phil Auld)
>
> --->8---
>>From 98f5d472c08e3ed5b9b6543290d392a2e50fcf3c Mon Sep 17 00:00:00 2001
> From: Byungchul Park <byungchul@sk.com>
> Date: Mon, 19 Feb 2024 13:10:47 +0900
> Subject: [PATCH v4] sched/numa, mm: do not try to migrate memory to memoryless nodes
>
> Memoryless nodes do not have any memory to migrate to, so stop trying
> it.
>
> Signed-off-by: Byungchul Park <byungchul@sk.com>
> Reviewed-by: Oscar Salvador <osalvador@suse.de>
> ---
>  kernel/sched/fair.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index d7a3c63a2171..3e3b44ae72d1 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -1828,6 +1828,12 @@ bool should_numa_migrate_memory(struct task_struct *p, struct folio *folio,
>  	int dst_nid = cpu_to_node(dst_cpu);
>  	int last_cpupid, this_cpupid;
>  
> +	/*
> +	 * Cannot migrate to memoryless nodes.
> +	 */
> +	if (!node_state(dst_nid, N_MEMORY))
> +		return false;
> +
>  	/*
>  	 * The pages in slow memory node should be migrated according
>  	 * to hot/cold instead of private/shared.

Good catch!

IIUC, you will use patch as fix to the issue in

https://lore.kernel.org/lkml/20240216111502.79759-1-byungchul@sk.com/

If so, we need the Fixes: tag to make it land in -stable properly.

Feel free to add

Reviewed-by: "Huang, Ying" <ying.huang@intel.com>

