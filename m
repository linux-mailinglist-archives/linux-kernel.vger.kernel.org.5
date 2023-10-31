Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C43837DD876
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 23:39:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376281AbjJaWiy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 18:38:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346824AbjJaWiv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 18:38:51 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 000C510D
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 15:38:48 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5afa77f9a33so55477997b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 15:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698791928; x=1699396728; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=E4k1hGGxw36dmwLt1HOw2cRLPR7SfORP0QkzJq8sNG4=;
        b=w7yoISG9OB6UaATuaOUv8CjI+FKuWQ4OKjpuN6ItWeh7++/hY9b8JadKneKShLnXxx
         YtEp/DajeMcikLarLTeD6J55jnSuypp/1UyvPW67Fzw6QsuA6lXVq5eRfA0jzQkMBIEU
         7OX0fC02G0HKrzagh2K4bW2z55czxsIq3h2DyFB1GpFeALTf9GVQXzYsQdU0swAZ/q+I
         5g36KrwXngDBFTYnEIdnhk0ejiTTkOCR3GurD8T2+Gynat1n6XTshXGHLT5xjmiHEfh1
         XN2KZBaZO0dPtI/4Ii70g4rb1fYk9CXkrwKekzvdVatPxA1EoijiQdZuxDNsHIezg64Z
         GTvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698791928; x=1699396728;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E4k1hGGxw36dmwLt1HOw2cRLPR7SfORP0QkzJq8sNG4=;
        b=XwP7dU8ytP0jqPxewBkSggR4jtvRu5t5e0jeDKUXnaPad53rWnKtVb4HkFt+GCOWe2
         ThrLidJo+Mmp66oeWorQ1C9T8p0IKDx1pxLp3YPBIUk3Z33UPRJ7h9vbcj2WzGENeOor
         3lshbnlUBcvbqM/IDSKNkP9YmfGxHaginxAQeLfmszGYiTT1RIGTdVEFkwyRieBj4MvG
         08eYvVDWotzQrXqZemdnm2Hbdlaix0smAjuWaRLVrKr9cMAGicyT1qlFrDRpql68bGeX
         /CFXQolOY4pyGoYuOYnEE4B55EW2KqqdQH2399NMbquyP84ANs9jmN5yIFYGewKF6756
         I5ng==
X-Gm-Message-State: AOJu0YxQXnt+IJagem6ByHTHNBWGivr/c9UQPzTNOJky6D+xfewAiaAE
        SHDasgYqPYsNHBgCCier/+zSjCfhXwZHRy3VQw==
X-Google-Smtp-Source: AGHT+IFM2W41gegeIUvzp7uUlh/DfO8Ica5ODCIQO4qan/QTBGDN4jXaqaSexGBwblyANavfH28+tAwYTUKQP15dBg==
X-Received: from souravpanda.svl.corp.google.com ([2620:15c:2a3:200:84c2:bfa0:7c62:5d77])
 (user=souravpanda job=sendgmr) by 2002:a05:6902:549:b0:da3:b96c:6c48 with
 SMTP id z9-20020a056902054900b00da3b96c6c48mr2053ybs.9.1698791928152; Tue, 31
 Oct 2023 15:38:48 -0700 (PDT)
Date:   Tue, 31 Oct 2023 15:38:45 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.820.g83a721a137-goog
Message-ID: <20231031223846.827173-1-souravpanda@google.com>
Subject: [PATCH v4 0/1] mm: report per-page metadata information
From:   Sourav Panda <souravpanda@google.com>
To:     corbet@lwn.net, gregkh@linuxfoundation.org, rafael@kernel.org,
        akpm@linux-foundation.org, mike.kravetz@oracle.com,
        muchun.song@linux.dev, rppt@kernel.org, david@redhat.com,
        rdunlap@infradead.org, chenlinxuan@uniontech.com,
        yang.yang29@zte.com.cn, souravpanda@google.com,
        tomas.mudrunka@gmail.com, bhelgaas@google.com, ivan@cloudflare.com,
        pasha.tatashin@soleen.com, yosryahmed@google.com,
        hannes@cmpxchg.org, shakeelb@google.com,
        kirill.shutemov@linux.intel.com, wangkefeng.wang@huawei.com,
        adobriyan@gmail.com, vbabka@suse.cz, Liam.Howlett@Oracle.com,
        surenb@google.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-mm@kvack.org, willy@infradead.org, weixugc@google.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changelog:
v4:
	- Addressed comment from Matthew Wilcox.
		- Used __node_stat_sub_folio and __node_stat_add_folio
		  instead of __mod_node_page_state in mm/hugetlb.c.
		- Used page_pgdat wherever possible in the entire patch.
		- Used DIV_ROUND_UP() wherever possible in the entire
		  patch.
v3:
	- Addressed comment from Matthew Wilcox.
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
v3:
https://lore.kernel.org/all/20231031174459.459480-1-souravpanda@google.com
v2:
https://lore.kernel.org/all/20231018005548.3505662-1-souravpanda@google.com
v1:
https://lore.kernel.org/r/20230913173000.4016218-2-souravpanda@google.com

Hi!

This patch adds a new per-node PageMetadata field to
/sys/devices/system/node/nodeN/meminfo and a global PageMetadata field
to /proc/meminfo. This information can be used by users to see how much
memory is being used by per-page metadata, which can vary depending on
build configuration, machine architecture, and system use.

Per-page metadata is the amount of memory that Linux needs in order to
manage memory at the page granularity. The majority of such memory is
used by "struct page" and "page_ext" data structures.


Background
----------

Kernel overhead observability is missing some of the largest
allocations during runtime, including vmemmap (struct pages) and
page_ext. This patch aims to address this problem by exporting a
new metric PageMetadata.

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
export a new metric that we shall refer to as PageMetadata (exported by
node). This shall also comprise the struct page and page_ext allocations
made during runtime.

Results and analysis
--------------------

Memory model: Sparsemem-vmemmap
$ echo 1 > /proc/sys/vm/hugetlb_optimize_vmemmap

$ cat /proc/meminfo | grep MemTotal
	MemTotal:       32918196 kB
$ cat /proc/meminfo | grep Meta
	PageMetadata:     589824 kB
$ cat /sys/devices/system/node/node0/meminfo | grep Meta
	Node 0 PageMetadata:     294912 kB
$ cat /sys/devices/system/node/node1/meminfo | grep Meta
	Node 1 PageMetadata:     294912 kB


AFTER HUGTLBFS RESERVATION
$ echo 512 > /proc/sys/vm/nr_hugepages

$ cat /proc/meminfo | grep MemTotal

MemTotal:       32934580 kB
$ cat /proc/meminfo | grep Meta
PageMetadata:     575488 kB
$ cat /sys/devices/system/node/node0/meminfo | grep Meta
Node 0 PageMetadata:     287744 kB
$ cat /sys/devices/system/node/node1/meminfo | grep Meta
Node 1 PageMetadata:     287744 kB

AFTER FREEING HUGTLBFS RESERVATION
$ echo 0 > /proc/sys/vm/nr_hugepages
$ cat /proc/meminfo | grep MemTotal
MemTotal:       32934580 kB
$ cat /proc/meminfo | grep Meta
PageMetadata:    589824 kB
$ cat /sys/devices/system/node/node0/meminfo | grep Meta
Node 0 PageMetadata:       294912 kB
$ cat /sys/devices/system/node/node1/meminfo | grep Meta
Node 1 PageMetadata:       294912 kB



Sourav Panda (1):
  mm: report per-page metadata information

 Documentation/filesystems/proc.rst |  3 +++
 drivers/base/node.c                |  2 ++
 fs/proc/meminfo.c                  |  7 +++++++
 include/linux/mmzone.h             |  3 +++
 include/linux/vmstat.h             |  4 ++++
 mm/hugetlb.c                       | 11 ++++++++--
 mm/hugetlb_vmemmap.c               |  8 ++++++--
 mm/mm_init.c                       |  3 +++
 mm/page_alloc.c                    |  1 +
 mm/page_ext.c                      | 32 +++++++++++++++++++++---------
 mm/sparse-vmemmap.c                |  3 +++
 mm/sparse.c                        |  7 ++++++-
 mm/vmstat.c                        | 24 ++++++++++++++++++++++
 13 files changed, 94 insertions(+), 14 deletions(-)

-- 
2.42.0.820.g83a721a137-goog

