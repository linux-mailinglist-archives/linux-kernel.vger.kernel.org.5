Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EE977EABDF
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 09:45:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232433AbjKNIpx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 03:45:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232406AbjKNIpm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 03:45:42 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FAD11A8;
        Tue, 14 Nov 2023 00:45:38 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-6b87c1edfd5so4179534b3a.1;
        Tue, 14 Nov 2023 00:45:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699951538; x=1700556338; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OKRmXBsUtiL4RTZEjbskUkxZvc6fttLs7R2u2to+Cz0=;
        b=dsQAd3LUkUw5DlwA8A03vrQCGBDA0tsZcA6eVnfhp40j95KxhAPrc4sgmfUGfmHopo
         H7fEzku/cTsTnILzJlzPMYCqDNSELpUNROX0AIuoZszJYv8y1Fi1IW+/FWEkTnHbnwkm
         bC3Cn6SZrny/7FPzg3a7UpIbtLetkEiw8YOSOZFj/weOceyKF4Vf+u5f8xQ5ktWTivZw
         ugQS2gKtlMH1nfHt1CnEQWc3EUQfPdPjeR35Wpea+lq5Ful0gf9tf8QseFbaIuMCnXK1
         YreTtYuBMAeVKTgnZyvWQqrL7+Y2EEu0+dTErl4xu6kki8+DZntwEUxai4VAv6TnbdCn
         HI4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699951538; x=1700556338;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OKRmXBsUtiL4RTZEjbskUkxZvc6fttLs7R2u2to+Cz0=;
        b=G99gcI7lNKx+6eEOkAed1qHtwen4rPNiMQ8ni60i4bbcw2bV8h/tpV+5wyEbv9znbv
         bzHhv41a5C1g2fbT3ahGY8OounxHmIfFjo/5dP+uqyZsJgfvU+udyAZx7HtB4LrJEF5N
         sjj1dCrrq6/Anf7mRx4jzOdoqHnJLFmnMK5Hnng74uHVkQmdFWONs830YeZQwzv12Ygg
         IxekjXfgHo0Q2R9ekgImYxJnyxs76OSwEkcQZOEQHxrnXUIxEOGz9836RHBOTtH6CfO+
         YxkuJ5EcaYA5ZpTrnQqlce+jQPfsjETi9Dnt6DnYBKI+4bXObY55e+Rniu7VV81pzRET
         s8fw==
X-Gm-Message-State: AOJu0YxFG3asawgJdg81K4S2r/oIb8WDUBXGEDiRZLb9uCHrZ66vj5o4
        GLYwOVvru7aS/eE2CHoEIJXDuS2uQmE=
X-Google-Smtp-Source: AGHT+IG4JE9MnA5DuPYG1VJOyEc3jOazUVKagtAzoQHQV1/OGfMTwiNQfMAixHhUS9eZATF68VhVIw==
X-Received: by 2002:a05:6a00:d44:b0:6c3:74d6:596e with SMTP id n4-20020a056a000d4400b006c374d6596emr5464562pfv.10.1699951537782;
        Tue, 14 Nov 2023 00:45:37 -0800 (PST)
Received: from carrot.. (i223-218-133-131.s42.a014.ap.plala.or.jp. [223.218.133.131])
        by smtp.gmail.com with ESMTPSA id u17-20020a056a00159100b006c4d2479c1asm748083pfk.219.2023.11.14.00.45.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 00:45:37 -0800 (PST)
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-nilfs@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 03/20] nilfs2: Convert nilfs_segctor_complete_write to use folios
Date:   Tue, 14 Nov 2023 17:44:19 +0900
Message-Id: <20231114084436.2755-4-konishi.ryusuke@gmail.com>
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

Use the new folio APIs, saving five calls to compound_head().
This includes the last callers of nilfs_end_page_io(), so
remove that too.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
---
 fs/nilfs2/segment.c | 49 +++++++++++++++++++--------------------------
 1 file changed, 21 insertions(+), 28 deletions(-)

diff --git a/fs/nilfs2/segment.c b/fs/nilfs2/segment.c
index 730062e79bfc..2a058aad5c2d 100644
--- a/fs/nilfs2/segment.c
+++ b/fs/nilfs2/segment.c
@@ -1778,13 +1778,6 @@ static void nilfs_end_folio_io(struct folio *folio, int err)
 	folio_end_writeback(folio);
 }
 
-static void nilfs_end_page_io(struct page *page, int err)
-{
-	if (!page)
-		return;
-	nilfs_end_folio_io(page_folio(page), err);
-}
-
 static void nilfs_abort_logs(struct list_head *logs, int err)
 {
 	struct nilfs_segment_buffer *segbuf;
@@ -1867,7 +1860,7 @@ static void nilfs_set_next_segment(struct the_nilfs *nilfs,
 static void nilfs_segctor_complete_write(struct nilfs_sc_info *sci)
 {
 	struct nilfs_segment_buffer *segbuf;
-	struct page *bd_page = NULL, *fs_page = NULL;
+	struct folio *bd_folio = NULL, *fs_folio = NULL;
 	struct the_nilfs *nilfs = sci->sc_super->s_fs_info;
 	int update_sr = false;
 
@@ -1878,21 +1871,21 @@ static void nilfs_segctor_complete_write(struct nilfs_sc_info *sci)
 				    b_assoc_buffers) {
 			set_buffer_uptodate(bh);
 			clear_buffer_dirty(bh);
-			if (bh->b_page != bd_page) {
-				if (bd_page)
-					end_page_writeback(bd_page);
-				bd_page = bh->b_page;
+			if (bh->b_folio != bd_folio) {
+				if (bd_folio)
+					folio_end_writeback(bd_folio);
+				bd_folio = bh->b_folio;
 			}
 		}
 		/*
-		 * We assume that the buffers which belong to the same page
+		 * We assume that the buffers which belong to the same folio
 		 * continue over the buffer list.
-		 * Under this assumption, the last BHs of pages is
-		 * identifiable by the discontinuity of bh->b_page
-		 * (page != fs_page).
+		 * Under this assumption, the last BHs of folios is
+		 * identifiable by the discontinuity of bh->b_folio
+		 * (folio != fs_folio).
 		 *
 		 * For B-tree node blocks, however, this assumption is not
-		 * guaranteed.  The cleanup code of B-tree node pages needs
+		 * guaranteed.  The cleanup code of B-tree node folios needs
 		 * special care.
 		 */
 		list_for_each_entry(bh, &segbuf->sb_payload_buffers,
@@ -1905,16 +1898,16 @@ static void nilfs_segctor_complete_write(struct nilfs_sc_info *sci)
 
 			set_mask_bits(&bh->b_state, clear_bits, set_bits);
 			if (bh == segbuf->sb_super_root) {
-				if (bh->b_page != bd_page) {
-					end_page_writeback(bd_page);
-					bd_page = bh->b_page;
+				if (bh->b_folio != bd_folio) {
+					folio_end_writeback(bd_folio);
+					bd_folio = bh->b_folio;
 				}
 				update_sr = true;
 				break;
 			}
-			if (bh->b_page != fs_page) {
-				nilfs_end_page_io(fs_page, 0);
-				fs_page = bh->b_page;
+			if (bh->b_folio != fs_folio) {
+				nilfs_end_folio_io(fs_folio, 0);
+				fs_folio = bh->b_folio;
 			}
 		}
 
@@ -1928,13 +1921,13 @@ static void nilfs_segctor_complete_write(struct nilfs_sc_info *sci)
 		}
 	}
 	/*
-	 * Since pages may continue over multiple segment buffers,
-	 * end of the last page must be checked outside of the loop.
+	 * Since folios may continue over multiple segment buffers,
+	 * end of the last folio must be checked outside of the loop.
 	 */
-	if (bd_page)
-		end_page_writeback(bd_page);
+	if (bd_folio)
+		folio_end_writeback(bd_folio);
 
-	nilfs_end_page_io(fs_page, 0);
+	nilfs_end_folio_io(fs_folio, 0);
 
 	nilfs_drop_collected_inodes(&sci->sc_dirty_files);
 
-- 
2.34.1

