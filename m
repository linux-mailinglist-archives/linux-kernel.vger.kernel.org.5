Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 796B875151A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 02:19:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233368AbjGMATA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 20:19:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232298AbjGMASn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 20:18:43 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D6111FCD
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 17:18:42 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id d9443c01a7336-1b8b2a2e720so824515ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 17:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689207522; x=1691799522;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6XARlF0BXnO6/4Atr6/Ka8Rsp7ITnYdH8gSSlCIsHmQ=;
        b=dypHe3K1l/c1oaj2HHVrHq7fKVxuhlr/Ku9wHIlgid2l5uxeWU6gepVzV2p5HJ+Mtn
         HQbc73phPu16+ziP3vR3iq444D/tI3BAZT+QtWryBgLc3sVCy5eU27hzqaAtG1F8EqMl
         o/uPkLyFyiabmK6g1nZ8jFcEXuWM0VnyC/xfa332OEOupMY+ygXwWjny1snuRDFi0JkG
         s3xf57LVHLyYM8qLCEOrGRoywDSE6krtphd9CuaI+egnsX7ey3Kuc8nYch5I/S9m9RGe
         skHC5e2MOBIE+ANgafHaV29E/DQKCyjKboQ/a6THaV0HVxs4uK2tWwdUET7s3EB7CyXK
         CWZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689207522; x=1691799522;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6XARlF0BXnO6/4Atr6/Ka8Rsp7ITnYdH8gSSlCIsHmQ=;
        b=NKS0U1NY/oKPGL+SNezPxPym6RG6wHiRdIJJrKhJJuCBZd0gtN3ajfQh3xe1SU0wBn
         Mx5VcaRHfcJ3T+mBR5AcDx2kBlg6jVZiSzZRqcm80bHkT5K9gBel13PcatBofmYught3
         OI0RZjwJ02sjFF95uRXtzh67flD+gkSEUB/TfBu4gJuiwSJP8dP2pH/lIDVVaWj0p7sw
         lI8TzpSKrfbkxJkvqZYBvX5RiS2aFmoSla+g9p7c/6cDnucia9GHiDoUSHyLgo0GUom1
         I2s29tF/PQSo7z7DtmzGKQQWz/Si9pb80fFKI8nMdFk/UJbZ1L7Q/5D1ZU000QARenPB
         0avQ==
X-Gm-Message-State: ABy/qLa+A1yyp/840vhncDKhGcLn7ukawNxNm+xX7IM2BZCVRM5NTyao
        dOeWIoWcO1GI/0Jc6pa7BTYvRCdUZ+CrEw==
X-Google-Smtp-Source: APBJJlG1dH5gtGtj7+R2nOPMgHiIgop3mdrBpT2PYcsdRrW+V38DX7do6vdw3iO2pKOF0QHuX8mPhg685Rik7A==
X-Received: from yjq3.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:272f])
 (user=jiaqiyan job=sendgmr) by 2002:a17:902:7448:b0:1b7:dbb0:782b with SMTP
 id e8-20020a170902744800b001b7dbb0782bmr496plt.10.1689207521799; Wed, 12 Jul
 2023 17:18:41 -0700 (PDT)
Date:   Thu, 13 Jul 2023 00:18:32 +0000
In-Reply-To: <20230713001833.3778937-1-jiaqiyan@google.com>
Mime-Version: 1.0
References: <20230713001833.3778937-1-jiaqiyan@google.com>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230713001833.3778937-4-jiaqiyan@google.com>
Subject: [PATCH v4 3/4] hugetlbfs: improve read HWPOISON hugepage
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

When a hugepage contains HWPOISON pages, read() fails to read any byte
of the hugepage and returns -EIO, although many bytes in the HWPOISON
hugepage are readable.

Improve this by allowing hugetlbfs_read_iter returns as many bytes as
possible. For a requested range [offset, offset + len) that contains
HWPOISON page, return [offset, first HWPOISON page addr); the next read
attempt will fail and return -EIO.

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
Reviewed-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
Signed-off-by: Jiaqi Yan <jiaqiyan@google.com>
---
 fs/hugetlbfs/inode.c | 57 +++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 51 insertions(+), 6 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 7b17ccfa039d..e7611ae1e612 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -282,6 +282,41 @@ hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
 }
 #endif
 
+/*
+ * Someone wants to read @bytes from a HWPOISON hugetlb @page from @offset.
+ * Returns the maximum number of bytes one can read without touching the 1st raw
+ * HWPOISON subpage.
+ *
+ * The implementation borrows the iteration logic from copy_page_to_iter*.
+ */
+static size_t adjust_range_hwpoison(struct page *page, size_t offset, size_t bytes)
+{
+	size_t n = 0;
+	size_t res = 0;
+
+	/* First subpage to start the loop. */
+	page += offset / PAGE_SIZE;
+	offset %= PAGE_SIZE;
+	while (1) {
+		if (is_raw_hwpoison_page_in_hugepage(page))
+			break;
+
+		/* Safe to read n bytes without touching HWPOISON subpage. */
+		n = min(bytes, (size_t)PAGE_SIZE - offset);
+		res += n;
+		bytes -= n;
+		if (!bytes || !n)
+			break;
+		offset += n;
+		if (offset == PAGE_SIZE) {
+			page++;
+			offset = 0;
+		}
+	}
+
+	return res;
+}
+
 /*
  * Support for read() - Find the page attached to f_mapping and copy out the
  * data. This provides functionality similar to filemap_read().
@@ -300,7 +335,7 @@ static ssize_t hugetlbfs_read_iter(struct kiocb *iocb, struct iov_iter *to)
 
 	while (iov_iter_count(to)) {
 		struct page *page;
-		size_t nr, copied;
+		size_t nr, copied, want;
 
 		/* nr is the maximum number of bytes to copy from this page */
 		nr = huge_page_size(h);
@@ -328,16 +363,26 @@ static ssize_t hugetlbfs_read_iter(struct kiocb *iocb, struct iov_iter *to)
 		} else {
 			unlock_page(page);
 
-			if (PageHWPoison(page)) {
-				put_page(page);
-				retval = -EIO;
-				break;
+			if (!PageHWPoison(page))
+				want = nr;
+			else {
+				/*
+				 * Adjust how many bytes safe to read without
+				 * touching the 1st raw HWPOISON subpage after
+				 * offset.
+				 */
+				want = adjust_range_hwpoison(page, offset, nr);
+				if (want == 0) {
+					put_page(page);
+					retval = -EIO;
+					break;
+				}
 			}
 
 			/*
 			 * We have the page, copy it to user space buffer.
 			 */
-			copied = copy_page_to_iter(page, offset, nr, to);
+			copied = copy_page_to_iter(page, offset, want, to);
 			put_page(page);
 		}
 		offset += copied;
-- 
2.41.0.255.g8b1d071c50-goog

