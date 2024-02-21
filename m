Return-Path: <linux-kernel+bounces-74192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB6F185D0ED
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 08:10:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CFEC287604
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 07:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 841703A26E;
	Wed, 21 Feb 2024 07:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SVI+m3TR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEAD539AF1
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 07:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708499439; cv=none; b=C/742LTtqd9KDNrRG7agwL0ybn3UrTM21g7NusEGXaW7P1LkP/gxiltrNYaLLM09NJlu9iHZ3+G/HTJzLTNAA/PPmXzHsQCc9UZr0/78kd2RfDAqCK60gEFsDgu/RHYegeMuxXD/Z4ORwHaZvm6KI2U9JlVELE6qwm8/1eqxVTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708499439; c=relaxed/simple;
	bh=A+d6DunIrChPzyLKEwkHG4SMJU+8ZOEePbqT/034MOg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AoCF2kCUM/3Sfi2+Zh9OCW6d82hrxblVYY9rfzOF9aE9ERigmdrZDA26b5/HydAGoGovwtz/Gp+YS71RFlRCOIsKoQ1MHuOHmEZitg54bq+kUjcyLmrr385C5G/5lKqGjxR36Nc489OkeyOhyWWDzWCCzuV+gSLZyWL/K0rBBGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SVI+m3TR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2042C433F1;
	Wed, 21 Feb 2024 07:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708499439;
	bh=A+d6DunIrChPzyLKEwkHG4SMJU+8ZOEePbqT/034MOg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SVI+m3TRr9NZeiwKeQU+Je9+cyUMD7o4+u25WNFyM8EfHG6wE/PR1+OKIXjoFamMz
	 9kKnpafi5tsUeaxG+fEscpdoTOmK+6kYgcIDQfIeQquQgDPLOEkwAiDq8yevqlucsG
	 9BkboSvAtkQj0iDqe1YsbII0eh1IQIMNmYxQmXncNC96+OFeoTPDaRIrvm+a4/DARd
	 WGOR/LXPDR7lRCjeHl1770zJep5xa3WNsM5XxGls6h4Dhsz02BbRvfM9LhpE8BOhNW
	 qG4LNXFnNckMsjkpGo30HJsP1z5BxdP6gU4CpH/Ta1jGxBn72QzgtLSlPKrsKw9mvh
	 IpTqG7pAYkXKQ==
Date: Wed, 21 Feb 2024 09:10:02 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc: Liam.Howlett@oracle.com, akpm@linux-foundation.org, debug@rivosinc.com,
	broonie@kernel.org, kirill.shutemov@linux.intel.com,
	keescook@chromium.org, tglx@linutronix.de, mingo@redhat.com,
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
	luto@kernel.org, peterz@infradead.org, hpa@zytor.com,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/8] mm: Switch mm->get_unmapped_area() to a flag
Message-ID: <ZdWhylSaUwZkdDFb@kernel.org>
References: <20240215231332.1556787-1-rick.p.edgecombe@intel.com>
 <20240215231332.1556787-2-rick.p.edgecombe@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240215231332.1556787-2-rick.p.edgecombe@intel.com>

On Thu, Feb 15, 2024 at 03:13:25PM -0800, Rick Edgecombe wrote:
> The mm_struct contains a function pointer *get_unmapped_area(), which
> is set to either arch_get_unmapped_area() or
> arch_get_unmapped_area_topdown() during the initialization of the mm.
> 
> Since the function pointer only ever points to two functions that are named
> the same across all arch's, a function pointer is not really required. In
> addition future changes will want to add versions of the functions that
> take additional arguments. So to save a pointers worth of bytes in
> mm_struct, and prevent adding additional function pointers to mm_struct in
> future changes, remove it and keep the information about which
> get_unmapped_area() to use in a flag.
> 
> Introduce a helper, mm_get_unmapped_area(), to easily convert code that
> refers to the old function pointer to instead select and call either
> arch_get_unmapped_area() or arch_get_unmapped_area_topdown() based on the
> flag. Then drop the mm->get_unmapped_area() function pointer. Leave the
> get_unmapped_area() pointer in struct file_operations alone. The main
> purpose of this change is to reorganize in preparation for future changes,
> but it also converts the calls of mm->get_unmapped_area() from indirect
> branches into a direct ones.
> 
> The stress-ng bigheap benchmark calls realloc a lot, which calls through
> get_unmapped_area() in the kernel. On x86, the change yielded a ~4%
> improvement there. (bogo ops/s (usr+sys time))
> 
> In testing a few x86 configs, removing the pointer unfortunately didn't
> result in any actual size reductions in the compiled layout of mm_struct.
> But depending on compiler or arch alignment requirements, the change could
> possibly shrink the size of mm_struct.
> 
> Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> ---
>  arch/s390/mm/hugetlbpage.c       |  2 +-
>  arch/s390/mm/mmap.c              |  4 ++--
>  arch/sparc/kernel/sys_sparc_64.c | 15 ++++++---------
>  arch/sparc/mm/hugetlbpage.c      |  2 +-
>  arch/x86/kernel/cpu/sgx/driver.c |  2 +-
>  arch/x86/mm/hugetlbpage.c        |  2 +-
>  arch/x86/mm/mmap.c               |  4 ++--
>  drivers/char/mem.c               |  2 +-
>  drivers/dax/device.c             |  6 +++---
>  fs/hugetlbfs/inode.c             |  2 +-
>  fs/proc/inode.c                  | 15 ++++++++-------
>  fs/ramfs/file-mmu.c              |  2 +-
>  include/linux/mm_types.h         |  6 +-----
>  include/linux/sched/coredump.h   |  1 +
>  include/linux/sched/mm.h         |  5 +++++
>  io_uring/io_uring.c              |  2 +-
>  mm/debug.c                       |  6 ------
>  mm/huge_memory.c                 |  6 +++---
>  mm/mmap.c                        | 21 ++++++++++++++++++---
>  mm/shmem.c                       | 11 +++++------
>  mm/util.c                        |  6 +++---
>  21 files changed, 65 insertions(+), 57 deletions(-)
> 
> diff --git a/include/linux/sched/coredump.h b/include/linux/sched/coredump.h
> index 02f5090ffea2..428e440424c5 100644
> --- a/include/linux/sched/coredump.h
> +++ b/include/linux/sched/coredump.h
> @@ -74,6 +74,7 @@ static inline int get_dumpable(struct mm_struct *mm)
>  #define MMF_DISABLE_THP_MASK	(1 << MMF_DISABLE_THP)
>  #define MMF_OOM_REAP_QUEUED	25	/* mm was queued for oom_reaper */
>  #define MMF_MULTIPROCESS	26	/* mm is shared between processes */
> +#define MMF_TOPDOWN		27	/* mm is shared between processes */

Nit: you may want to update the comment here ;-)

>  /*
>   * MMF_HAS_PINNED: Whether this mm has pinned any pages.  This can be either
>   * replaced in the future by mm.pinned_vm when it becomes stable, or grow into

-- 
Sincerely yours,
Mike.

