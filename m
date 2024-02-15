Return-Path: <linux-kernel+bounces-67837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A2C68571A9
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 00:37:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EFBA1C21692
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 23:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBD15145343;
	Thu, 15 Feb 2024 23:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TbN/Q7xz"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9885145B2A
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 23:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708040237; cv=none; b=ey8fESJSJqxrn1RrH6zQDKgVE88JurTUlbAl3bQU4YuTBgyFl32IJE2hklR9CoUuv0SqtA3VSbHk7X3llwNt2hBspqZCrMbE34wkjKMC2N9kyv73sYTe2pq0qBKYcERCpS8Utz8yDXtDHWPWLVw2/BFdILteHnrS9CngADf4vX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708040237; c=relaxed/simple;
	bh=VLM77YDupfYB4kAQurAItMchR5NURwNyHpDPD9NDVwY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nQYdoj9z61BKALF5n4wbLyfyBv9jr3Sc3IGE6rwCN9+n8LehkSkWzjeC9OB6X5/Q0CV2NpNFGdJ6ONa932sANZihBQ0Rn3VgGavaZPezI6WIEziAg7tM3VvfN7V+j7014yVpw1dFqPRaAfDrGb6KuidxroUU5ud7pT2ifj8Cftk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TbN/Q7xz; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-339289fead2so831418f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 15:37:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708040234; x=1708645034; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y/m8RYJ/2xy2EJlSTReMNxRLLHi4TElTKh67Aw8kBy8=;
        b=TbN/Q7xz2qH1iCy72Zw0JiQj0CXJaieJPepLlzo62jdFTfdiGqhZldhx0BEBqOpZb2
         0Ah74Lsv5NiX74DdRC0c9csrViEBJu6v2DYJGh2KAk895JjA6KaHyfr2uBOsi5FGBYJU
         rJSgVOa9XFoa+d2Wlum75zGQZ2d2jZSAt08oSvjBlc4h6PVptWiAyb2rThi3c0bmj2oK
         YZOh+fZ9lVQHTAePpYBXjhnK9+NIO2N2IE9iWwndmTeImzqe273msXEy+dTr/7sxPdkF
         xO/JxlqL0l8FEF8dBJ/Tri30WL80RtWPYajKQzJo4lLC70UayFWzUGrEI3nQ9Fud5Ac2
         zGcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708040234; x=1708645034;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y/m8RYJ/2xy2EJlSTReMNxRLLHi4TElTKh67Aw8kBy8=;
        b=Ga+AoR5nztkWWlheI/pfw2Jn3uf03I8M84+8fiJu5C0KZG/ovMMI5WmudgFxYoxK2H
         nwPYRcCeYObNisptP3nifJbkn+CnlzcxQYhomeO29B2KKMP4kY4PwPtApyXTiVMO7p2g
         U3QkaSHYFIweKvEqcRUkyuVBagbZmEZ/3IcuBBEZbeJicaGyT43dB1dhtvWFzqrlZxUV
         BrwHQdMITbGdb6tao22clleVZJxTHvmJLgGe+jgCM5zJ45snX/Bu5oQKypjMCJz5HKZv
         zcY/zTVPQkcHo0IFFms6p8jftGviBFeaff/vQpRg4xtbczJn/+z/Ovp7yKBtJcUT9jfL
         9T/A==
X-Forwarded-Encrypted: i=1; AJvYcCV6YAN9aIVSkoov0EP/Jn5xWVeSAu9KapY2xrTBReLy8ANFGJ9+rF9O99qAKvmwq3+RgFEwJS0jxFzCMzlZ1K70iWx8u3utoU0uCh5i
X-Gm-Message-State: AOJu0Yz6bEER7iYuAGwMiSsOEJ+4qHEmMM0TUAyrQwNvaJmHXhc0rpW9
	h9ZJxphHf+KDEkPB6rcNVOqL4qCN9ixNHWw8ZuKF5WDdM21FNdyj2rX+VK29Y9JvXZPlUEexR5l
	UfmTOPm7zi9rAUHPSzDagvVkQv6k=
X-Google-Smtp-Source: AGHT+IG8IeXazwKjfl2t4ZhPPlmb0lTrd7uK1A+7dlMs7k9Ly5CAcoJ3L0coWubOHXiOFB0X7MK3ocRk2XkMLC2wepA=
X-Received: by 2002:adf:f44e:0:b0:33b:2a6f:385a with SMTP id
 f14-20020adff44e000000b0033b2a6f385amr2601719wrp.30.1708040233947; Thu, 15
 Feb 2024 15:37:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240215215907.20121-1-osalvador@suse.de>
In-Reply-To: <20240215215907.20121-1-osalvador@suse.de>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Fri, 16 Feb 2024 00:37:03 +0100
Message-ID: <CA+fCnZc=nhFLRFDH97waabDHpOv3iauF5s7hebBQCPt7JY3Sew@mail.gmail.com>
Subject: Re: [PATCH v10 0/7] page_owner: print stacks and their outstanding allocations
To: Oscar Salvador <osalvador@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, Michal Hocko <mhocko@suse.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Marco Elver <elver@google.com>, Alexander Potapenko <glider@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 15, 2024 at 10:57=E2=80=AFPM Oscar Salvador <osalvador@suse.de>=
 wrote:
>
> Changes v9 -> v10
>      - Fix unwanted change in patch#2
>      - Collect Acked-by and Reviewed-by from Marco and Vlastimil
>        for the missing patches
>      - Fix stack_record count by substracting 1 in stack_print by Vlastim=
il
>
> Changes v8 -> v9
>      - Fix handle-0 for the very first stack_record entry
>      - Collect Acked-by and Reviewed-by from Marco and Vlastimil
>      - Adressed feedback from Marco and Vlastimil
>      - stack_print() no longer allocates a memory buffer, prints directly
>        using seq_printf: by Vlastimil
>      - Added two static struct stack for dummy_handle and faiure_handle
>      - add_stack_record_to_list() now filters out the gfp_mask the same w=
ay
>        stackdepot does, for consistency
>      - Rename set_threshold to count_threshold
>
> Changes v7 -> v8
>      - Rebased on top of -next
>      - page_owner maintains its own stack_records list now
>      - Kill auxiliary stackdepot function to traverse buckets
>      - page_owner_stacks is now a directory with 'show_stacks'
>        and 'set_threshold'
>      - Update Documentation/mm/page_owner.rst
>      - Adressed feedback from Marco
>
> Changes v6 -> v7:
>      - Rebased on top of Andrey Konovalov's libstackdepot patchset
>      - Reformulated the changelogs
>
> Changes v5 -> v6:
>      - Rebase on top of v6.7-rc1
>      - Move stack_record struct to the header
>      - Addressed feedback from Vlastimil
>        (some code tweaks and changelogs suggestions)
>
> Changes v4 -> v5:
>      - Addressed feedback from Alexander Potapenko
>
> Changes v3 -> v4:
>      - Rebase (long time has passed)
>      - Use boolean instead of enum for action by Alexander Potapenko
>      - (I left some feedback untouched because it's been long and
>         would like to discuss it here now instead of re-vamping
>         and old thread)
>
> Changes v2 -> v3:
>      - Replace interface in favor of seq operations
>        (suggested by Vlastimil)
>      - Use debugfs interface to store/read valued (suggested by Ammar)
>
>
> page_owner is a great debug functionality tool that lets us know
> about all pages that have been allocated/freed and their specific
> stacktrace.
> This comes very handy when debugging memory leaks, since with
> some scripting we can see the outstanding allocations, which might point
> to a memory leak.
>
> In my experience, that is one of the most useful cases, but it can get
> really tedious to screen through all pages and try to reconstruct the
> stack <-> allocated/freed relationship, becoming most of the time a
> daunting and slow process when we have tons of allocation/free operations=
.
>
> This patchset aims to ease that by adding a new functionality into
> page_owner.
> This functionality creates a new directory called 'page_owner_stacks'
> under 'sys/kernel//debug' with a read-only file called 'show_stacks',
> which prints out all the stacks followed by their outstanding number
> of allocations (being that the times the stacktrace has allocated
> but not freed yet).
> This gives us a clear and a quick overview of stacks <-> allocated/free.
>
> We take advantage of the new refcount_f field that stack_record struct
> gained, and increment/decrement the stack refcount on every
> __set_page_owner() (alloc operation) and __reset_page_owner (free operati=
on)
> call.
>
> Unfortunately, we cannot use the new stackdepot api
> STACK_DEPOT_FLAG_GET because it does not fulfill page_owner needs,
> meaning we would have to special case things, at which point
> makes more sense for page_owner to do its own {dec,inc}rementing
> of the stacks.
> E.g: Using STACK_DEPOT_FLAG_PUT, once the refcount reaches 0,
> such stack gets evicted, so page_owner would lose information.
>
> This patch also creates a new file called 'set_threshold' within
> 'page_owner_stacks' directory, and by writing a value to it, the stacks
> which refcount is below such value will be filtered out.
>
> A PoC can be found below:
>
>  # cat /sys/kernel/debug/page_owner_stacks/show_stacks > page_owner_full_=
stacks.txt
>  # head -40 page_owner_full_stacks.txt
>   prep_new_page+0xa9/0x120
>   get_page_from_freelist+0x801/0x2210
>   __alloc_pages+0x18b/0x350
>   alloc_pages_mpol+0x91/0x1f0
>   folio_alloc+0x14/0x50
>   filemap_alloc_folio+0xb2/0x100
>   page_cache_ra_unbounded+0x96/0x180
>   filemap_get_pages+0xfd/0x590
>   filemap_read+0xcc/0x330
>   blkdev_read_iter+0xb8/0x150
>   vfs_read+0x285/0x320
>   ksys_read+0xa5/0xe0
>   do_syscall_64+0x80/0x160
>   entry_SYSCALL_64_after_hwframe+0x6e/0x76
>  stack_count: 521
>
>
>
>   prep_new_page+0xa9/0x120
>   get_page_from_freelist+0x801/0x2210
>   __alloc_pages+0x18b/0x350
>   alloc_pages_mpol+0x91/0x1f0
>   folio_alloc+0x14/0x50
>   filemap_alloc_folio+0xb2/0x100
>   __filemap_get_folio+0x14a/0x490
>   ext4_write_begin+0xbd/0x4b0 [ext4]
>   generic_perform_write+0xc1/0x1e0
>   ext4_buffered_write_iter+0x68/0xe0 [ext4]
>   ext4_file_write_iter+0x70/0x740 [ext4]
>   vfs_write+0x33d/0x420
>   ksys_write+0xa5/0xe0
>   do_syscall_64+0x80/0x160
>   entry_SYSCALL_64_after_hwframe+0x6e/0x76
>  stack_count: 4609
> ...
> ...
>
>  # echo 5000 > /sys/kernel/debug/page_owner_stacks/set_threshold
>  # cat /sys/kernel/debug/page_owner_stacks/show_stacks > page_owner_full_=
stacks_5000.txt
>  # head -40 page_owner_full_stacks_5000.txt
>   prep_new_page+0xa9/0x120
>   get_page_from_freelist+0x801/0x2210
>   __alloc_pages+0x18b/0x350
>   alloc_pages_mpol+0x91/0x1f0
>   folio_alloc+0x14/0x50
>   filemap_alloc_folio+0xb2/0x100
>   __filemap_get_folio+0x14a/0x490
>   ext4_write_begin+0xbd/0x4b0 [ext4]
>   generic_perform_write+0xc1/0x1e0
>   ext4_buffered_write_iter+0x68/0xe0 [ext4]
>   ext4_file_write_iter+0x70/0x740 [ext4]
>   vfs_write+0x33d/0x420
>   ksys_pwrite64+0x75/0x90
>   do_syscall_64+0x80/0x160
>   entry_SYSCALL_64_after_hwframe+0x6e/0x76
>  stack_count: 6781
>
>
>
>   prep_new_page+0xa9/0x120
>   get_page_from_freelist+0x801/0x2210
>   __alloc_pages+0x18b/0x350
>   pcpu_populate_chunk+0xec/0x350
>   pcpu_balance_workfn+0x2d1/0x4a0
>   process_scheduled_works+0x84/0x380
>   worker_thread+0x12a/0x2a0
>   kthread+0xe3/0x110
>   ret_from_fork+0x30/0x50
>   ret_from_fork_asm+0x1b/0x30
>  stack_count: 8641
>
> Oscar Salvador (7):
>   lib/stackdepot: Fix first entry having a 0-handle
>   lib/stackdepot: Move stack_record struct definition into the header
>   mm,page_owner: Maintain own list of stack_records structs
>   mm,page_owner: Implement the tracking of the stacks count
>   mm,page_owner: Display all stacks and their count
>   mm,page_owner: Filter out stacks by a threshold
>   mm,page_owner: Update Documentation regarding page_owner_stacks
>
>  Documentation/mm/page_owner.rst |  45 +++++++
>  include/linux/stackdepot.h      |  58 +++++++++
>  lib/stackdepot.c                |  65 +++--------
>  mm/page_owner.c                 | 200 +++++++++++++++++++++++++++++++-
>  4 files changed, 318 insertions(+), 50 deletions(-)
>
> --
> 2.43.0
>

Acked-by: Andrey Konovalov <andreyknvl@gmail.com>

