Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C1777EABDD
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 09:45:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232400AbjKNIpt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 03:45:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232383AbjKNIpj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 03:45:39 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9F131A8;
        Tue, 14 Nov 2023 00:45:34 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-6b77ab73c6fso4142629b3a.1;
        Tue, 14 Nov 2023 00:45:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699951534; x=1700556334; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D03uI3RFs+q47sPLqFS/hl468TfZmA9CDM9quyOjWII=;
        b=Rc+wf/+xxTRFw2sLW/MX49h2Vyjtr5uaC9f74IPZumBsYP69ages2i6TzpLCRpUCzn
         TARk/evMn9Dk1/NbCEKe02wxDy441DgltNk9hcWvffRuxPSodMjAmOquphR9LD9fQnZC
         CGImK2CJHt5FnqyGCsgRZeSbJ0C94RuAfZXB4Ax5T8b2ru5mND4u1fkFiHDGuhL+O1Hw
         kXQuC+BR+qz5SMN+sYFzyzA8M/teEgbcbKbXsXraU2PFHrpBiuW0rBvGpW7v75nEX0Ze
         3tpAzLt+IH1j1I0flTTO9OzT1nR5kFrIvdSN6ic2eLHxDlSB3crVVQ9FhfHL1keF7uak
         k3DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699951534; x=1700556334;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D03uI3RFs+q47sPLqFS/hl468TfZmA9CDM9quyOjWII=;
        b=DaR9K2bmE2NG34BNReBhBRMzmLkzcTRGc2NNllEVSxrEZjwVAWm25NosRhzPQUMzWJ
         UUW4TtRXKZ41W8TJ8hhBBt1V3+3DqRUlwVdvlYMy2GI6EtLES3emxgAeiUlRzpEifmiK
         eT7lGFLEylZfVMNjUJoDnlRDWb5kFbbilvS/fglQbxBX+LCBR8KNx64iiTqjV85CtgV8
         cz3J0x3d8BI6BnfW/UxyBraSje49ccjp9WaWxD+DQ+DF8DkC1iIpC8jgQ2BlHiKULCQq
         EaUPKP0L+EK78WO7ysqEyigRnH0YYHqO05NQuAFw7IdiF1S/CbHXha2kVnvG5yuJcb7m
         7ZXg==
X-Gm-Message-State: AOJu0YxmOrnaVlFNHi0vhcvOybzIc0XwMkTpZf3GBMYbw8YuyroOtokK
        dU6YG66D6tore4v/XZ+feMA1TWG89Z4=
X-Google-Smtp-Source: AGHT+IFTIQDQhqAT8S4VE3G5UfriA4ZrFNQdjbbK9wOemjVyzHPD+0R5dVIHsGTw+hJV6WpBmnk3wg==
X-Received: by 2002:aa7:8b45:0:b0:6bf:15fb:4b32 with SMTP id i5-20020aa78b45000000b006bf15fb4b32mr2783598pfd.8.1699951533944;
        Tue, 14 Nov 2023 00:45:33 -0800 (PST)
Received: from carrot.. (i223-218-133-131.s42.a014.ap.plala.or.jp. [223.218.133.131])
        by smtp.gmail.com with ESMTPSA id u17-20020a056a00159100b006c4d2479c1asm748083pfk.219.2023.11.14.00.45.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 00:45:33 -0800 (PST)
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-nilfs@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 01/20] nilfs2: Add nilfs_end_folio_io()
Date:   Tue, 14 Nov 2023 17:44:17 +0900
Message-Id: <20231114084436.2755-2-konishi.ryusuke@gmail.com>
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

This is the folio counterpart of the existing nilfs_end_page_io()
which is retained as a wrapper of nilfs_end_folio_io().  Replaces
nine hidden calls to compound_head() with one.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
---
 fs/nilfs2/segment.c | 36 ++++++++++++++++++++++--------------
 1 file changed, 22 insertions(+), 14 deletions(-)

diff --git a/fs/nilfs2/segment.c b/fs/nilfs2/segment.c
index 55e31cc903d1..1df03d0895be 100644
--- a/fs/nilfs2/segment.c
+++ b/fs/nilfs2/segment.c
@@ -1739,17 +1739,18 @@ static int nilfs_segctor_write(struct nilfs_sc_info *sci,
 	return ret;
 }
 
-static void nilfs_end_page_io(struct page *page, int err)
+static void nilfs_end_folio_io(struct folio *folio, int err)
 {
-	if (!page)
+	if (!folio)
 		return;
 
-	if (buffer_nilfs_node(page_buffers(page)) && !PageWriteback(page)) {
+	if (buffer_nilfs_node(folio_buffers(folio)) &&
+			!folio_test_writeback(folio)) {
 		/*
 		 * For b-tree node pages, this function may be called twice
 		 * or more because they might be split in a segment.
 		 */
-		if (PageDirty(page)) {
+		if (folio_test_dirty(folio)) {
 			/*
 			 * For pages holding split b-tree node buffers, dirty
 			 * flag on the buffers may be cleared discretely.
@@ -1757,24 +1758,31 @@ static void nilfs_end_page_io(struct page *page, int err)
 			 * remaining buffers, and it must be cancelled if
 			 * all the buffers get cleaned later.
 			 */
-			lock_page(page);
-			if (nilfs_page_buffers_clean(page))
-				__nilfs_clear_page_dirty(page);
-			unlock_page(page);
+			folio_lock(folio);
+			if (nilfs_page_buffers_clean(&folio->page))
+				__nilfs_clear_page_dirty(&folio->page);
+			folio_unlock(folio);
 		}
 		return;
 	}
 
 	if (!err) {
-		if (!nilfs_page_buffers_clean(page))
-			__set_page_dirty_nobuffers(page);
-		ClearPageError(page);
+		if (!nilfs_page_buffers_clean(&folio->page))
+			filemap_dirty_folio(folio->mapping, folio);
+		folio_clear_error(folio);
 	} else {
-		__set_page_dirty_nobuffers(page);
-		SetPageError(page);
+		filemap_dirty_folio(folio->mapping, folio);
+		folio_set_error(folio);
 	}
 
-	end_page_writeback(page);
+	folio_end_writeback(folio);
+}
+
+static void nilfs_end_page_io(struct page *page, int err)
+{
+	if (!page)
+		return;
+	nilfs_end_folio_io(page_folio(page), err);
 }
 
 static void nilfs_abort_logs(struct list_head *logs, int err)
-- 
2.34.1

