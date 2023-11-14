Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD7CC7EABE8
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 09:46:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232558AbjKNIqO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 03:46:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232440AbjKNIpx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 03:45:53 -0500
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com [IPv6:2607:f8b0:4864:20::c31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B60DD5F;
        Tue, 14 Nov 2023 00:45:50 -0800 (PST)
Received: by mail-oo1-xc31.google.com with SMTP id 006d021491bc7-586b512ba0aso2407881eaf.3;
        Tue, 14 Nov 2023 00:45:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699951549; x=1700556349; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ACTke6Zf0OUOc76NPf/lv5o2wBWaGEEAOlcvwIBiVRQ=;
        b=kg33XimFsbH2RExCawortrrH665/l1gaORpGq0UYPOKDAePT4/BQhJO4C79TT7ONfL
         3VpTMl9s2En8lfFFTWGfb9Ns9HNiRfitEqPhMrXyBqXhzO5zILVvthu359qcRCFgHE7R
         FPGMlKatbMSRaK2Liob/gVKZ7PV5bl0we3Pfy4uugedjvud6LyKUTJ8gh1adeZf8rCgJ
         pfV3lST+vzMlFABJURF6o3ShDvjjZDLjvHuGDwbkqxS6SzxyOuZ9PfATCV5glye62Deb
         Bvqt1JoMf+/7sSmjfa1dmLaGbU8dy2pa+80aZL/LLru2nMbSPGsZ6jfbZ1s3SfBjPlb2
         8Ufg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699951549; x=1700556349;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ACTke6Zf0OUOc76NPf/lv5o2wBWaGEEAOlcvwIBiVRQ=;
        b=s39POC/ujzeoJsus9Q1gfU9yJfnfy7kDPZuv02leT86kfcieg0OxRbCYU3FQ+lQaxh
         5c5LnCPFicepKRN6uot5iMQGjzvNWHGOef8qWsc5acNmg3tWVks2Gxo/ZIyZ3OgSZqv4
         iJZYyRHRFlT3d/zSN633RA90E39VMp+qEV8X7nUOTFOmyd3qMHKKKjeWMlHBP3Nb3qln
         S8VHZBw12w6Mae0eSmVGlARPaPlYzvxf0ws0xokgJbLtNPG6cG2M2lEMc6TbTWqBsDUD
         bwYfJNLv78B/Pn2E1fIR85YQ05NFXqcrMjrFsAp5sdno2FF53/GgIl52voCpduwDzYWE
         hXIw==
X-Gm-Message-State: AOJu0YxJzQKq552Q8qAuFRfcHJkXfYQEcuOWF3bMlC0L1ITbhb3lyJ/8
        pSV+0cjKSDVbQrP6vWVyY/PlRDZUS4c=
X-Google-Smtp-Source: AGHT+IGlMfvNvMnEuydX2KTekDIT1vCzIvQsDbMfMw05BGYwXG36HBcWTIEvd02gUEMpjuDZhJ4Ulg==
X-Received: by 2002:a05:6870:498b:b0:1f0:a639:49a1 with SMTP id ho11-20020a056870498b00b001f0a63949a1mr8791524oab.15.1699951549432;
        Tue, 14 Nov 2023 00:45:49 -0800 (PST)
Received: from carrot.. (i223-218-133-131.s42.a014.ap.plala.or.jp. [223.218.133.131])
        by smtp.gmail.com with ESMTPSA id u17-20020a056a00159100b006c4d2479c1asm748083pfk.219.2023.11.14.00.45.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 00:45:48 -0800 (PST)
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-nilfs@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 09/20] nilfs2: Convert to __nilfs_clear_folio_dirty()
Date:   Tue, 14 Nov 2023 17:44:25 +0900
Message-Id: <20231114084436.2755-10-konishi.ryusuke@gmail.com>
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

All callers now have a folio, so convert to pass a folio.  No caller
uses the return value, so make it return void.  Removes a couple of
hidden calls to compound_head().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
---
 fs/nilfs2/page.c    | 19 ++++++++++---------
 fs/nilfs2/page.h    |  2 +-
 fs/nilfs2/segment.c |  2 +-
 3 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/fs/nilfs2/page.c b/fs/nilfs2/page.c
index 48a91ff059f5..94e11bcee05b 100644
--- a/fs/nilfs2/page.c
+++ b/fs/nilfs2/page.c
@@ -82,7 +82,7 @@ void nilfs_forget_buffer(struct buffer_head *bh)
 	lock_buffer(bh);
 	set_mask_bits(&bh->b_state, clear_bits, 0);
 	if (nilfs_folio_buffers_clean(folio))
-		__nilfs_clear_page_dirty(&folio->page);
+		__nilfs_clear_folio_dirty(folio);
 
 	bh->b_blocknr = -1;
 	folio_clear_uptodate(folio);
@@ -428,7 +428,7 @@ void nilfs_clear_folio_dirty(struct folio *folio, bool silent)
 		} while (bh = bh->b_this_page, bh != head);
 	}
 
-	__nilfs_clear_page_dirty(&folio->page);
+	__nilfs_clear_folio_dirty(folio);
 }
 
 unsigned int nilfs_page_count_clean_buffers(struct page *page,
@@ -458,22 +458,23 @@ unsigned int nilfs_page_count_clean_buffers(struct page *page,
  * 2) Some B-tree operations like insertion or deletion may dispose buffers
  *    in dirty state, and this needs to cancel the dirty state of their pages.
  */
-int __nilfs_clear_page_dirty(struct page *page)
+void __nilfs_clear_folio_dirty(struct folio *folio)
 {
-	struct address_space *mapping = page->mapping;
+	struct address_space *mapping = folio->mapping;
 
 	if (mapping) {
 		xa_lock_irq(&mapping->i_pages);
-		if (test_bit(PG_dirty, &page->flags)) {
-			__xa_clear_mark(&mapping->i_pages, page_index(page),
+		if (folio_test_dirty(folio)) {
+			__xa_clear_mark(&mapping->i_pages, folio->index,
 					     PAGECACHE_TAG_DIRTY);
 			xa_unlock_irq(&mapping->i_pages);
-			return clear_page_dirty_for_io(page);
+			folio_clear_dirty_for_io(folio);
+			return;
 		}
 		xa_unlock_irq(&mapping->i_pages);
-		return 0;
+		return;
 	}
-	return TestClearPageDirty(page);
+	folio_clear_dirty(folio);
 }
 
 /**
diff --git a/fs/nilfs2/page.h b/fs/nilfs2/page.h
index c419bb1f5b7d..968b311d265b 100644
--- a/fs/nilfs2/page.h
+++ b/fs/nilfs2/page.h
@@ -30,7 +30,7 @@ BUFFER_FNS(NILFS_Checked, nilfs_checked)	/* buffer is verified */
 BUFFER_FNS(NILFS_Redirected, nilfs_redirected)	/* redirected to a copy */
 
 
-int __nilfs_clear_page_dirty(struct page *);
+void __nilfs_clear_folio_dirty(struct folio *);
 
 struct buffer_head *nilfs_grab_buffer(struct inode *, struct address_space *,
 				      unsigned long, unsigned long);
diff --git a/fs/nilfs2/segment.c b/fs/nilfs2/segment.c
index 888b8606a1e8..8c675c118c66 100644
--- a/fs/nilfs2/segment.c
+++ b/fs/nilfs2/segment.c
@@ -1760,7 +1760,7 @@ static void nilfs_end_folio_io(struct folio *folio, int err)
 			 */
 			folio_lock(folio);
 			if (nilfs_folio_buffers_clean(folio))
-				__nilfs_clear_page_dirty(&folio->page);
+				__nilfs_clear_folio_dirty(folio);
 			folio_unlock(folio);
 		}
 		return;
-- 
2.34.1

