Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA167751516
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 02:18:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232625AbjGMASn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 20:18:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230134AbjGMASi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 20:18:38 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C97BB1FCD
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 17:18:37 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-553d076dce5so97929a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 17:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689207517; x=1691799517;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ja2GaLe3g335IB6oeNLcPuMSFkLQtw6DqY/qEV7GBLU=;
        b=sSvffJG7xloWj0xslk56oYNElU6sGdnDP1NivBKRPkTAcD4pqPFb2cRhNF7GGpfuZC
         i/SDqj16RtWk2642Ou/AMLJ3ec5/si1D7yta4V4NLBWU4Ycjo5wWKl7/sfJZNmHEYiYN
         +9NA30YQ7GSXJStIzq5GrOCNHfnhK7v3UJMmpPixPkcKGW1d1Z53jD6+fXe3aXmJZsXL
         g9MlPog3zzfQp5oY4ltY0as50tJyEmtIF0twGgvrUDE8LocBNwtQzn8gme4Ofy0RF0dz
         eKsFs49Nxvp3xxcLigbFaO8Hc08TYXMGkZDZjOi1Fj2zsufrl26geQ3cYggVyBKzLDX+
         PYhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689207517; x=1691799517;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ja2GaLe3g335IB6oeNLcPuMSFkLQtw6DqY/qEV7GBLU=;
        b=CNNsQo8tSibC0buxMDadrxxFS2yDv5BcaeAuaVVXoOJ95dNjqbT9FVx0dC8IW/EoWs
         0TYnC2ltpDdETV39RmOz1Kgi9kDwaBv6rD1JgwwKuCJeOEetlkaxFvrRYAIDRcF0vSvw
         qH8II8FGQfG3v5PB2+k7bz36iMGPWi8KqpwQbaS0c8PDjHMawy5FsInW4OArL13MyC62
         GRvpJkP4tqHUTN1zffuJvC+E7yJCG0rL/000th6x0ZiqodEIAO7JUoXjK9jrZw6It/BS
         IujrjT4H5kHLbRBra5K0dUFd6PY8Wdr01oRZil8WUXPi008cqfgJNpq+pHSDdYgwgSMG
         B8eg==
X-Gm-Message-State: ABy/qLZ4vh1WC6VK8XQZrw0gDlpmN5rAiAY049cW9ra2TGP1v4YZjiXH
        M62QuamEzuIKJa4DaQwl78Tqv7QzbNV73g==
X-Google-Smtp-Source: APBJJlGtncLzAwvfmCIMVnb1+qNlBnXGUpvLOlivkS2jNCdjnGNupfd6nQULBZqoNC0x0OsjN3lvv2K6cMUGBA==
X-Received: from yjq3.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:272f])
 (user=jiaqiyan job=sendgmr) by 2002:a65:6a84:0:b0:55a:c629:4047 with SMTP id
 q4-20020a656a84000000b0055ac6294047mr10115518pgu.6.1689207517185; Wed, 12 Jul
 2023 17:18:37 -0700 (PDT)
Date:   Thu, 13 Jul 2023 00:18:29 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230713001833.3778937-1-jiaqiyan@google.com>
Subject: [PATCH v4 0/4] Improve hugetlbfs read on HWPOISON hugepages
From:   Jiaqi Yan <jiaqiyan@google.com>
To:     linmiaohe@huawei.com, mike.kravetz@oracle.com,
        naoya.horiguchi@nec.com
Cc:     akpm@linux-foundation.org, songmuchun@bytedance.com,
        shy828301@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, jthoughton@google.com,
        Jiaqi Yan <jiaqiyan@google.com>
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

Today when hardware memory is corrupted in a hugetlb hugepage,
kernel leaves the hugepage in pagecache [1]; otherwise future mmap or
read will suject to silent data corruption. This is implemented by
returning -EIO from hugetlb_read_iter immediately if the hugepage has
HWPOISON flag set.

Since memory_failure already tracks the raw HWPOISON subpages in a
hugepage, a natural improvement is possible: if userspace only asks for
healthy subpages in the pagecache, kernel can return these data.

This patchset implements this improvement. It consist of three parts.
The 1st commit exports the functionality to tell if a subpage inside a
hugetlb hugepage is a raw HWPOISON page. The 2nd commit teaches
hugetlbfs_read_iter to return as many healthy bytes as possible.
The 3rd commit properly tests this new feature.

[1] commit 8625147cafaa ("hugetlbfs: don't delete error page from pagecache")

Changelog

v3 => v4
* incorporate feedbacks from Matthew Wilcox <willy@infradead.org>,
  Miaohe Lin <linmiaohe@huawei.com>, Mike Kravetz
  <mike.kravetz@oracle.com> and Naoya Horiguchi
  <naoya.horiguchi@nec.com>.
* rename is_raw_hwp_subpage => is_raw_hwpoison_page_in_hugepage.
* instead of taking hugetlb_lock, is_raw_hwpoison_page_in_hugepage needs
  to hold mf_mutex.
* use llist_for_each_entry, instead of llist_for_each_entry_safe in
  is_raw_hwpoison_page_in_hugepage.
* is_raw_hwpoison_page_in_hugepage doesn't need the folio argument.
* no need to export struct raw_hwp_page to header file.
* v4 is based on commit fd3006d2d0e7 ("Sync mm-stable with v6.5-rc1.").

v2 => v3
* Update commit messages for future reader to know background and
  code details.
* v3 is based on commit 5bb367dca2b9 ("Merge branch 'master' into
  mm-stable").

v1 => v2
* incorporate feedbacks from both Mike Kravetz
  <mike.kravetz@oracle.com> and Naoya Horiguchi
  <naoya.horiguchi@nec.com>.
* __folio_free_raw_hwp deletes all entries in raw_hwp_list before it
  traverses and frees raw_hwp_page.
* find_raw_hwp_page => __is_raw_hwp_subpage and __is_raw_hwp_subpage
  only returns bool instead of a raw_hwp_page entry.
* is_raw_hwp_subpage holds hugetlb_lock while checking
  __is_raw_hwp_subpage.
* No need to do folio_lock in adjust_range_hwpoison.
* v2 is based on commit a6e79df92e4a ("mm/gup: disallow FOLL_LONGTERM
  GUP-fast writing to file-backed mappings").

Jiaqi Yan (4):
  mm/hwpoison: delete all entries before traversal in
    __folio_free_raw_hwp
  mm/hwpoison: check if a raw page in a hugetlb folio is raw HWPOISON
  hugetlbfs: improve read HWPOISON hugepage
  selftests/mm: add tests for HWPOISON hugetlbfs read

 fs/hugetlbfs/inode.c                          |  57 +++-
 include/linux/hugetlb.h                       |   5 +
 mm/memory-failure.c                           |  48 ++-
 tools/testing/selftests/mm/.gitignore         |   1 +
 tools/testing/selftests/mm/Makefile           |   1 +
 .../selftests/mm/hugetlb-read-hwpoison.c      | 322 ++++++++++++++++++
 6 files changed, 421 insertions(+), 13 deletions(-)
 create mode 100644 tools/testing/selftests/mm/hugetlb-read-hwpoison.c

-- 
2.41.0.255.g8b1d071c50-goog

