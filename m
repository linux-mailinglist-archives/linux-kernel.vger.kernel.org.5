Return-Path: <linux-kernel+bounces-66085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14961855666
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 23:57:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C08B5289A45
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 22:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BED788662D;
	Wed, 14 Feb 2024 22:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E8yUxgNr"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA73712E72
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 22:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707951465; cv=none; b=FgXNpS57wlFu9Hfac6gEeF2SnzMtMdAmSKSHzUd0MHzQTLiMhPp6FxRCpD7Q/G+eMo3Kc4P8SkOX85vuABsYpMvNanXKk1dQAV7jnJiCvo+7oF2bPi3Iim+i0u5kQMzlr7nfx/66QcirZ1A4NsQz5AowkhA1Ya9LdmDKaNM9dyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707951465; c=relaxed/simple;
	bh=omDxOFUdQAytJ00R1OxBhkCDUc7XsQHnbed2qK7jLsw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=jr/Cmlrx35sAvJ15yCErg9hpM4Gph3Tm3Yo/BMSgojCTs1zEFmQuWVKofuNt6Ua/awI1ohPQ/yTP1B2kljq7TFHwyTKZyMWnVRQJAoXD570V9zuq5fVfsc+nh0lD29RU998U4ZrQZmnEeqUKcIdUP1wbfYmq6f5BfDkFinQmerY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--souravpanda.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=E8yUxgNr; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--souravpanda.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-607c2dd9a15so4211317b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 14:57:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707951463; x=1708556263; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ER/kDDF0VbhJ9fY0LYS6Jm2lqhCgvi5b8hhyOiCuUPM=;
        b=E8yUxgNrnMmpgucnbwoNjgTmw14t0eFYsbB9clhjSNwG4emKimBu6MkDkK8PK6le8U
         h7T9G3wl9bvZljYVZSm5YO6LY6Xm4mEeH2oqMB4Q4dVW8LNYMmc7IIhSCEiuzoq532Q8
         A7xFPz0XpCO48xqYgHM3lpxoj8+eRCEfDWzOSGEge191ZwZ98xqRDMb6wzhZAwR+5ega
         p9P9zikzLkTBN00k5g9Xouu/FxGELtVK32zKseo/634Ao0oVzveIm3j0gxidnU6NTMOA
         oaHVU6BH7AWHgWEtryZMVbPtZTsC6VfeNVXjAionGf+tSwrcGnGWvMwTtfqXozZHYjj4
         n2Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707951463; x=1708556263;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ER/kDDF0VbhJ9fY0LYS6Jm2lqhCgvi5b8hhyOiCuUPM=;
        b=khWFIM+yaHpzQcaQY1jQ0wRiWG3QLzyir859ysXB2EdIIYLLxf/8+OhUty/Fbbni0r
         /hun5tU5jIGWK5Sc+vbLHq0MBc/cY8DEas9XmR9yDOaGbbIqVljnX06EpZPjHVe8vMCz
         ChU+3sMn3rVHRTJgQar5mLTLxKK0BudjIPzh1bI3P3uhtz8AURhdIKBF4smbh31ex/pb
         XsJOBPGPHqO4uOV4wn1SOp+UAaVjFOZg6QqmyqCq5WE4FbA35fxGosvHfCOX7u+B91B/
         jUmbVUOYraFoU6aXo6ID5b7sX7ka+j3NKLy4/UJbOMEdU0gor3czdI5PEKnxcAPDm48I
         Nn9g==
X-Forwarded-Encrypted: i=1; AJvYcCWdWRrGCc0GY1p22LCA2/OX6XsBxceTuJZb8+NosuAvDLpDfo6UWKHMtMWt/1wzE55jPrm5X9EMQJic7MzdTYsosnJoZWl8PCBkMQkX
X-Gm-Message-State: AOJu0YwS4R9cVEgi/Rg3bo/KGxuPj2BOOngrqYznyrgMVLG66g2aFf5k
	VNT2oyewsg8GGxoZW9XQ1QZnarI62KciruijQJs3FKUBFVNKk1ALiPD9ZMXXR40xV2MJt0Drvbn
	XA/8rbpBKMuGQyQSQdNNZWA==
X-Google-Smtp-Source: AGHT+IFTRjt4DJhFCr9j1PqFgRtUHJFi+z87oKy8C90T3jT3GR3k+j/v65obVYtWfG5q0k1nva8mC1JT1TFc5nVKFg==
X-Received: from souravpanda.svl.corp.google.com ([2620:15c:2a3:200:b4ba:86fe:7d36:2fb0])
 (user=souravpanda job=sendgmr) by 2002:a81:99d5:0:b0:607:75af:8006 with SMTP
 id q204-20020a8199d5000000b0060775af8006mr3707ywg.0.1707951462771; Wed, 14
 Feb 2024 14:57:42 -0800 (PST)
Date: Wed, 14 Feb 2024 14:57:39 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Message-ID: <20240214225741.403783-1-souravpanda@google.com>
Subject: [PATCH v8 0/1] mm: report per-page metadata information
From: Sourav Panda <souravpanda@google.com>
To: corbet@lwn.net, gregkh@linuxfoundation.org, rafael@kernel.org, 
	akpm@linux-foundation.org, mike.kravetz@oracle.com, muchun.song@linux.dev, 
	rppt@kernel.org, david@redhat.com, rdunlap@infradead.org, 
	chenlinxuan@uniontech.com, yang.yang29@zte.com.cn, souravpanda@google.com, 
	tomas.mudrunka@gmail.com, bhelgaas@google.com, ivan@cloudflare.com, 
	pasha.tatashin@soleen.com, yosryahmed@google.com, hannes@cmpxchg.org, 
	shakeelb@google.com, kirill.shutemov@linux.intel.com, 
	wangkefeng.wang@huawei.com, adobriyan@gmail.com, vbabka@suse.cz, 
	Liam.Howlett@Oracle.com, surenb@google.com, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, 
	willy@infradead.org, weixugc@google.com
Content-Type: text/plain; charset="UTF-8"

Changelog:
v8:
	- Addressed Powerpc (Power8 LE) boot failure.
	  	- In __populate_section_memmap instead of calling
		  mod_node_page_state (unavaialable at boot for
		  powerpc), we call mod_node_early_perpage_metadata.
		  This was a helper function that was introduced
		  for arm, to combat this exact problem.
		- Since __populate_section_memmap is tagged with
		  __meminit, we also had to modify the tag of
		  mod_node_early_perpage_metadata from __init to
		  __meminit.
	- Naming Changes:
	  	- In /proc/meminfo PageMetadata --> Memmap
		- In /proc/vmstat  nr_page_metadata --> nr_memmap
		- In /proc/vmstat  nr_page_metadata_boot -->
		  nr_memmap_boot
	- Addressed clarifications requested by Andrew Morton.
	  	- Updated the commit log to include utility or
		  potential usage for userspace.
	- Declined changing  placement of metrics after attempting:
		- No changes in /proc/meminfo since it cannot be moved
		  to the end anyway. This is because we have also
		  hugetlb_report_meminfo() and arch_report_meminfo().
	- Rebased to version 6, patchlevel 8.
v7:
	- Addressed comments from David Rientjes
                - For exporting PageMetadata to /proc/meminfo,
                  utilize global_node_page_state_pages for item
                  NR_PAGE_METADATA. This is instead of iterating
                  over nodes and accumulating the output of
                  node_page_state.
v6:
	- Interface changes
	  	- Added per-node nr_page_metadata and
		  nr_page_metadata_boot fields that are exported
		  in /sys/devices/system/node/nodeN/vmstat
		- nr_page_metadata exclusively tracks buddy
		  allocations while nr_page_metadata_boot
		  exclusively tracks memblock allocations.
		- Modified PageMetadata in /proc/meminfo to only
		  include buddy allocations so that it is
		  comparable against MemTotal in /proc/meminfo
		- Removed the PageMetadata field added in
		  /sys/devices/system/node/nodeN/meminfo
	- Addressed bugs reported by the kernel test bot.
	  	- All occurences of __mod_node_page_state have
		  been replaced by mod_node_page_state.
	- Addressed comments from Muchun Song.
	  	- Removed page meta data accouting from
		  mm/hugetlb.c. When CONFIG_SPARSEMEM_VMEMMAP
		  is disabled struct pages should not be returned
		  to buddy.
	- Modified the cover letter with the results and analysis
		- From when memory_hotplug.memmap_on_memory is
		  alternated between 0 and 1.
		- To account for the new interface changes.

v5:
	- Addressed comments from Muchun Song.
		- Fixed errors introduced in v4 when
		  CONFIG_SPARSEMEM_VMEMMAP is disabled by testing
		  against FLATMEM and SPARSEMEM memory models.
		- Handled the condition wherein the allocation of
		  walk.reuse_page fails, by moving NR_PAGE_METADATA
		  update into the clause if( walk.reuse_page ).
		- Removed the usage of DIV_ROUND_UP from
		  alloc_vmemmap_page_list since "end - start" is
		  always a multiple of PAGE_SIZE.
		- Modified alloc_vmemmap_page_list to update
		  NR_PAGE_METADATA once instead of every loop.
v4:
	- Addressed comment from Matthew Wilcox.
		- Used __node_stat_sub_folio and __node_stat_add_folio
		  instead of __mod_node_page_state in mm/hugetlb.c.
		- Used page_pgdat wherever possible in the entire patch.
		- Used DIV_ROUND_UP() wherever possible in the entire
		  patch.
v3:
	- Addressed one comment from Matthew Wilcox.
	  	- In free_page_ext, page_pgdat() is now extracted
		  prior to freeing the memory.
v2:
	- Fixed the three bugs reported by kernel test robot.
	- Enhanced the commit message as recommended by David Hildenbrand.
	- Addressed comments from Matthew Wilcox:
	  	- Simplified alloc_vmemmap_page_list() and
		  free_page_ext() as recommended.
		- Used the appropriate comment style in mm/vmstat.c.
		- Replaced writeout_early_perpage_metadata() with
		  store_early_perpage_metadata() to reduce ambiguity
		  with what swap does.
	- Addressed comments from Mike Rapoport:
	  	- Simplified the loop in alloc_vmemmap_page_list().
		- Could NOT address a comment to move
		  store_early_perpage_metadata() near where nodes
		  and page allocator are initialized.
		- Included the vmalloc()ed page_ext in accounting
		  within free_page_ext().
		- Made early_perpage_metadata[MAX_NUMNODES] static.


Previous approaches and discussions
-----------------------------------
V7:
https://lore.kernel.org/all/20240129224204.1812062-1-souravpanda@google.com
V6:
https://lore.kernel.org/all/20231205223118.3575485-1-souravpanda@google.com
v5:
https://lore.kernel.org/all/20231101230816.1459373-1-souravpanda@google.com
v4:
https://lore.kernel.org/all/20231031223846.827173-1-souravpanda@google.com
v3:
https://lore.kernel.org/all/20231031174459.459480-1-souravpanda@google.com
v2:
https://lore.kernel.org/all/20231018005548.3505662-1-souravpanda@google.com
v1:
https://lore.kernel.org/r/20230913173000.4016218-2-souravpanda@google.com

Hi!

This patch adds two new per-node fields, namely nr_memmap and
nr_memmap_boot to /sys/devices/system/node/nodeN/vmstat and a
global Memmap field to /proc/meminfo. This information can be
used by users to see how much memory is being used by per-page
metadata, which can vary depending on build configuration, machine
architecture, and system use.

Per-page metadata is the amount of memory that Linux needs in order to
manage memory at the page granularity. The majority of such memory is
used by "struct page" and "page_ext" data structures.


Background
----------

Kernel overhead observability is missing some of the largest
allocations during runtime, including vmemmap (struct pages) and
page_ext. This patch aims to address this problem by exporting a
new metric Memmap.

On the contrary, the kernel does provide observibility for boot memory
allocations. For example, the metric reserved_pages depicts the pages
allocated by the bootmem allocator. This can be simply calculated as
present_pages - managed_pages, which are both exported in /proc/zoneinfo.
The metric reserved_pages is primarily composed of struct pages and
page_ext.

What about the struct pages (allocated by bootmem allocator) that are
free'd during hugetlbfs allocations and then allocated by buddy-allocator
once hugtlbfs pages are free'd?

/proc/meminfo MemTotal changes: MemTotal does not include memblock
allocations but includes buddy allocations. However, during runtime
memblock allocations can be shifted into buddy allocations, and therefore
become part of MemTotal.

Once the struct pages get allocated by buddy allocator, we lose track of
these struct page allocations overhead accounting. Therefore, we must
export new metrics. nr_memmap and nr_memmap_boot exclusively track the
struct page and page ext allocations made by the buddy allocator and
memblock allocator, respectively for each node. Memmap in /proc/meminfo
would report the struct page and page ext allocations made by the buddy
allocator.

Results and analysis
--------------------

Memory model: Sparsemem-vmemmap
$ echo 1 > /proc/sys/vm/hugetlb_optimize_vmemmap

$ cat /proc/meminfo | grep MemTotal
	MemTotal:       32919124 kB
$ cat /proc/meminfo | grep Memmap
	Memmap:		   65536 kB
$ cat /sys/devices/system/node/node0/vmstat | grep "nr_memmap"
	nr_memmap 8192
	nr_memmap_boot 65536
$ cat /sys/devices/system/node/node1/vmstat | grep "nr_memmap"
        nr_memmap 8192
	nr_memmap_boot 65536

AFTER HUGTLBFS RESERVATION
$ echo 512 > /proc/sys/vm/nr_hugepages

$ cat /proc/meminfo | grep MemTotal
	MemTotal:       32935508 kB
$ cat /proc/meminfo | grep Memmap
	Memmap:      67584 kB
$ cat /sys/devices/system/node/node0/vmstat | grep "nr_memmap"
	nr_memmap 8448
	nr_memmap_boot  63488
$ cat /sys/devices/system/node/node0/vmstat | grep "nr_memmap"
	nr_memmap 8448
	nr_memmap_boot  63488


AFTER FREEING HUGTLBFS RESERVATION
$ echo 0 > /proc/sys/vm/nr_hugepages

$ cat /proc/meminfo | grep MemTotal
        MemTotal:       32935508 kB
$ cat /proc/meminfo | grep Memmap
        Memmap:      81920 kB
$ cat /sys/devices/system/node/node0/vmstat | grep "nr_memmap"
        nr_memmap 10240
	nr_memmap_boot  63488
$ cat /sys/devices/system/node/node0/vmstat | grep "nr_memmap"
        nr_memmap 10240
	nr_memmap_boot  63488

------------------------

Memory Hotplug with memory_hotplug.memmap_on_memory=1

BEFORE HOTADD
$ cat /proc/meminfo | grep MemTotal
	MemTotal:       32919124 kB
$ cat /proc/meminfo | grep Memmap
	Memmap:      65536 kB
$ cat /sys/devices/system/node/node0/vmstat | grep "nr_memmap"
	nr_memmap 8192
	nr_memmap_boot  65536
$ cat /sys/devices/system/node/node0/vmstat | grep "nr_memmap"
	nr_memmap 8192
	nr_memmap_boot  65536

AFTER HOTADDING 1GB
$ cat /proc/meminfo | grep MemTotal
	MemTotal:       33951316 kB
$ cat /proc/meminfo | grep Memmap
	Memmap:      83968 kB
$ cat /sys/devices/system/node/node0/vmstat | grep "nr_memmap"
	nr_memmap 12800
	nr_memmap_boot 65536
$ cat /sys/devices/system/node/node0/vmstat | grep "nr_memmap"
	nr_memmap 8192
	nr_memmap_boot 65536

--------------------------

Memory Hotplug with memory_hotplug.memmap_on_memory=0

BEFORE HOTADD
$ cat /proc/meminfo | grep MemTotal
	MemTotal:       32919124 kB
$ cat /proc/meminfo | grep Memmap
	Memmap:      65536 kB
$ cat /sys/devices/system/node/node0/vmstat | grep "nr_memmap"
	nr_memmap 8192
	nr_memmap_boot 65536
$ cat /sys/devices/system/node/node0/vmstat | grep "nr_memmap"
	nr_memmap 8192
	nr_memmap_boot 65536

AFTER HOTADDING 1GB
$ cat /proc/meminfo | grep MemTotal
	MemTotal:       33967700 kB
$ cat /proc/meminfo | grep Memmap
	Memmap:      83968 kB
$ cat /sys/devices/system/node/node0/vmstat | grep "nr_memmap"
	nr_memmap 12800
	nr_memmap_boot 65536
$ cat /sys/devices/system/node/node0/vmstat | grep "nr_memmap"
	nr_memmap 8192
	nr_memmap_boot 65536

Sourav Panda (1):
  mm: report per-page metadata information

 Documentation/filesystems/proc.rst |  3 +++
 fs/proc/meminfo.c                  |  4 ++++
 include/linux/mmzone.h             |  4 ++++
 include/linux/vmstat.h             |  4 ++++
 mm/hugetlb_vmemmap.c               | 17 ++++++++++++----
 mm/mm_init.c                       |  3 +++
 mm/page_alloc.c                    |  1 +
 mm/page_ext.c                      | 32 +++++++++++++++++++++---------
 mm/sparse-vmemmap.c                |  8 ++++++++
 mm/sparse.c                        |  7 ++++++-
 mm/vmstat.c                        | 26 +++++++++++++++++++++++-
 11 files changed, 94 insertions(+), 15 deletions(-)

-- 
2.43.0.687.g38aa6559b0-goog


