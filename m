Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C04917EABE7
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 09:46:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232555AbjKNIqL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 03:46:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232456AbjKNIpv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 03:45:51 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A9D91AD;
        Tue, 14 Nov 2023 00:45:48 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-6b5af4662b7so4629386b3a.3;
        Tue, 14 Nov 2023 00:45:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699951547; x=1700556347; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WUc6IRzVdejbAHWCvNS1DFPLv9TAp+unQ6jPhpK5S64=;
        b=hUKxY5/OgRrTXw/KCmZeF/G5rcb4n9ND9bIYNq3XvJohw4B1RMU2daSOkWNYBI/98/
         JlkMjjr7cw6Pgd0SKSamAwr9RlF5Esqnv+7KpLcJRS9UTW6tBbIsRlwrjjtSAAvwyyyt
         kjTbJ0hRF8EQ0Vr9/uXOhpmpGDEYUs2bx/mtCUIsvwM7sk+SlNBF2EN2efqwbDLISlyk
         pWQyheN/eantQaSHQKCXiJHqN/oBy989ZaT1//bEyxnnl3GsQff4nseQRWZz/vi+IAxl
         s4poLMHCX16bAyxQ5N7XYN+NWPM6X4dsDRx/MLZrr1DpxWhiNUD60i+ImJlBSpgDngfY
         Nk7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699951547; x=1700556347;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WUc6IRzVdejbAHWCvNS1DFPLv9TAp+unQ6jPhpK5S64=;
        b=YHdKQvTfyVmM/BGA7izGKKxk+mMuCFTR6HDH7yV6ljcB1tffcJpLhjaUZjOe4EZCjg
         CLBVfycmbjyjFY6pdwz3+MKYNZnDgto5f11PSWXzaWlgnzXzMJPC9wyDvvT7g9T/nTCE
         NCkPOexpmy7/sj2unhZYbXL7ZJsNhdKAPa6pgEJeljnLaN/DjxDQFOoswy5e592nIF4D
         GvlWw7QiBv4H4NhCix380t7qJiv4lqpoN+oJjMVlLh0RbcF73Hw93/IFJSeHUWapUAnq
         KcG7KphXPor2LHcHi/zH+xIBH5FMuJ3u0ze5EADZIHt43QEYO3/DTirBp7bCYRMIqWDn
         Yj2Q==
X-Gm-Message-State: AOJu0Yw3yO0RjF5AvBx/mv+zzYRsu75MgzdMskRovlhcQmprvhogW+wV
        6Pvl8i9pBXoEOZJBtya+ZqiNRrxH2TY=
X-Google-Smtp-Source: AGHT+IGQqhQRt2iq5/W9PkbvFJZw46HZxPH6EJPuzU2Lu7eyHKk94twYXzZ7IMWx/OirKvRXgbrTQA==
X-Received: by 2002:a05:6a00:80c9:b0:68e:41e9:10be with SMTP id ei9-20020a056a0080c900b0068e41e910bemr5574881pfb.20.1699951547518;
        Tue, 14 Nov 2023 00:45:47 -0800 (PST)
Received: from carrot.. (i223-218-133-131.s42.a014.ap.plala.or.jp. [223.218.133.131])
        by smtp.gmail.com with ESMTPSA id u17-20020a056a00159100b006c4d2479c1asm748083pfk.219.2023.11.14.00.45.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 00:45:47 -0800 (PST)
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-nilfs@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 08/20] nilfs2: Convert to nilfs_clear_folio_dirty()
Date:   Tue, 14 Nov 2023 17:44:24 +0900
Message-Id: <20231114084436.2755-9-konishi.ryusuke@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231114084436.2755-1-konishi.ryusuke@gmail.com>
References: <20231114084436.2755-1-konishi.ryusuke@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

All callers of nilfs_clear_dirty_page() now have a folio, so rename
the function and pass in the folio.  Saves three hidden calls to
compound_head().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
---
 fs/nilfs2/inode.c |  2 +-
 fs/nilfs2/mdt.c   |  2 +-
 fs/nilfs2/page.c  | 27 ++++++++++++++-------------
 fs/nilfs2/page.h  |  2 +-
 4 files changed, 17 insertions(+), 16 deletions(-)

diff --git a/fs/nilfs2/inode.c b/fs/nilfs2/inode.c
index c7ec56358a79..8fe784f62720 100644
--- a/fs/nilfs2/inode.c
+++ b/fs/nilfs2/inode.c
@@ -186,7 +186,7 @@ static int nilfs_writepage(struct page *page, struct writeback_control *wbc)
 		 * have dirty pages that try to be flushed in background.
 		 * So, here we simply discard this dirty page.
 		 */
-		nilfs_clear_dirty_page(page, false);
+		nilfs_clear_folio_dirty(folio, false);
 		folio_unlock(folio);
 		return -EROFS;
 	}
diff --git a/fs/nilfs2/mdt.c b/fs/nilfs2/mdt.c
index 327408512b86..2e7952ac2f67 100644
--- a/fs/nilfs2/mdt.c
+++ b/fs/nilfs2/mdt.c
@@ -411,7 +411,7 @@ nilfs_mdt_write_page(struct page *page, struct writeback_control *wbc)
 		 * have dirty folios that try to be flushed in background.
 		 * So, here we simply discard this dirty folio.
 		 */
-		nilfs_clear_dirty_page(page, false);
+		nilfs_clear_folio_dirty(folio, false);
 		folio_unlock(folio);
 		return -EROFS;
 	}
diff --git a/fs/nilfs2/page.c b/fs/nilfs2/page.c
index 29799a49c234..48a91ff059f5 100644
--- a/fs/nilfs2/page.c
+++ b/fs/nilfs2/page.c
@@ -379,7 +379,7 @@ void nilfs_clear_dirty_pages(struct address_space *mapping, bool silent)
 			 * was acquired.  Skip processing in that case.
 			 */
 			if (likely(folio->mapping == mapping))
-				nilfs_clear_dirty_page(&folio->page, silent);
+				nilfs_clear_folio_dirty(folio, silent);
 
 			folio_unlock(folio);
 		}
@@ -389,32 +389,33 @@ void nilfs_clear_dirty_pages(struct address_space *mapping, bool silent)
 }
 
 /**
- * nilfs_clear_dirty_page - discard dirty page
- * @page: dirty page that will be discarded
+ * nilfs_clear_folio_dirty - discard dirty folio
+ * @folio: dirty folio that will be discarded
  * @silent: suppress [true] or print [false] warning messages
  */
-void nilfs_clear_dirty_page(struct page *page, bool silent)
+void nilfs_clear_folio_dirty(struct folio *folio, bool silent)
 {
-	struct inode *inode = page->mapping->host;
+	struct inode *inode = folio->mapping->host;
 	struct super_block *sb = inode->i_sb;
+	struct buffer_head *bh, *head;
 
-	BUG_ON(!PageLocked(page));
+	BUG_ON(!folio_test_locked(folio));
 
 	if (!silent)
 		nilfs_warn(sb, "discard dirty page: offset=%lld, ino=%lu",
-			   page_offset(page), inode->i_ino);
+			   folio_pos(folio), inode->i_ino);
 
-	ClearPageUptodate(page);
-	ClearPageMappedToDisk(page);
+	folio_clear_uptodate(folio);
+	folio_clear_mappedtodisk(folio);
 
-	if (page_has_buffers(page)) {
-		struct buffer_head *bh, *head;
+	head = folio_buffers(folio);
+	if (head) {
 		const unsigned long clear_bits =
 			(BIT(BH_Uptodate) | BIT(BH_Dirty) | BIT(BH_Mapped) |
 			 BIT(BH_Async_Write) | BIT(BH_NILFS_Volatile) |
 			 BIT(BH_NILFS_Checked) | BIT(BH_NILFS_Redirected));
 
-		bh = head = page_buffers(page);
+		bh = head;
 		do {
 			lock_buffer(bh);
 			if (!silent)
@@ -427,7 +428,7 @@ void nilfs_clear_dirty_page(struct page *page, bool silent)
 		} while (bh = bh->b_this_page, bh != head);
 	}
 
-	__nilfs_clear_page_dirty(page);
+	__nilfs_clear_page_dirty(&folio->page);
 }
 
 unsigned int nilfs_page_count_clean_buffers(struct page *page,
diff --git a/fs/nilfs2/page.h b/fs/nilfs2/page.h
index a8ab800e689c..c419bb1f5b7d 100644
--- a/fs/nilfs2/page.h
+++ b/fs/nilfs2/page.h
@@ -41,7 +41,7 @@ void nilfs_page_bug(struct page *);
 
 int nilfs_copy_dirty_pages(struct address_space *, struct address_space *);
 void nilfs_copy_back_pages(struct address_space *, struct address_space *);
-void nilfs_clear_dirty_page(struct page *, bool);
+void nilfs_clear_folio_dirty(struct folio *, bool);
 void nilfs_clear_dirty_pages(struct address_space *, bool);
 unsigned int nilfs_page_count_clean_buffers(struct page *, unsigned int,
 					    unsigned int);
-- 
2.34.1

