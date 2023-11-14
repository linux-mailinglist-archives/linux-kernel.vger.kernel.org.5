Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 008A27EABE2
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 09:46:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232496AbjKNIqB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 03:46:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232416AbjKNIpq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 03:45:46 -0500
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADDA51AD;
        Tue, 14 Nov 2023 00:45:42 -0800 (PST)
Received: by mail-oo1-xc2a.google.com with SMTP id 006d021491bc7-586ba7cdb6bso3058720eaf.2;
        Tue, 14 Nov 2023 00:45:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699951542; x=1700556342; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qsODlSSSo65NAC+DA2frAnS4pga3MJdWGA/tkcnA7Uo=;
        b=Me6WJPKINwOlt8beNUWkrP143YEOT2s90A06OXfnOz/0SiJ7mpaYcG9bB2Z+BQYM5e
         BLW5t0G5ebOJVk/AAB6wz61EhTHTRcetUfbKVskaLdX7l8EgvzkW4xCuLyMzTTEd9KvZ
         tf7oWX5tjLVizRPSIqkTNS2iqtmzn+zXLk6gL7v/znjWcaozUt/S1XlzIbFhMOrJsB9H
         5bW54ABbl17/xk/7K4UDWL7I34Alnd+zPRqfLxpxjGKontZMXGc9N9Gc0qCK/qtKaxWr
         IHtHBPjYP+AB61eReG5PJ/VVxnrSg58Th731gyGnT2rPjbSZVUuJbdHw2AcavjV3MaEx
         YNOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699951542; x=1700556342;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qsODlSSSo65NAC+DA2frAnS4pga3MJdWGA/tkcnA7Uo=;
        b=bvX+B+Cp7v+vYFy0qj2XdVH8pHWerQRJzp1oOj7JZhjrspl34paMeaCk/hoC79WQpA
         h0oll3fkyqKFLJZE9yL/oxfH9pTbqlio5d6p6riU68psmJQHYw+1CB1JtA+g1PazX41l
         aBKeEq6CRhPnVpZKMY2BEgiHKVLbi6c+bRt+W3EjPta6Ae8v7Sq/bjI/53PmfIsLFOFg
         wZN+7ToolpNYo2uqcjTWgMYMrTd2zJwR/3UpEuNbO38FVb8uFtw74XEacv5b+PgyuCt/
         lHmNHoqzet3McEdv7kZYwoV1IfcPg0w31PPTYqFQgY0I1zdiqnIRSCD6HHI6XeDaPoYl
         8nLA==
X-Gm-Message-State: AOJu0Yzh7IcoCN57CQIij5I2LB5XaKe4onwg1f6l6kiJJ/3DAo0BEAao
        t9kvUpdKbKsqfJxOkE/enM1vhMghtp8=
X-Google-Smtp-Source: AGHT+IHkwuqCdJrS6Zef1JObUCPq/Qg4yv1+GDAYaOYlYLDDSTW57rMHF5UOiFn4FQ6UVPBWujUiHQ==
X-Received: by 2002:a05:6871:5d2:b0:1e9:af81:54b6 with SMTP id v18-20020a05687105d200b001e9af8154b6mr12509563oan.55.1699951541863;
        Tue, 14 Nov 2023 00:45:41 -0800 (PST)
Received: from carrot.. (i223-218-133-131.s42.a014.ap.plala.or.jp. [223.218.133.131])
        by smtp.gmail.com with ESMTPSA id u17-20020a056a00159100b006c4d2479c1asm748083pfk.219.2023.11.14.00.45.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 00:45:41 -0800 (PST)
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-nilfs@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 05/20] nilfs2: Convert to nilfs_folio_buffers_clean()
Date:   Tue, 14 Nov 2023 17:44:21 +0900
Message-Id: <20231114084436.2755-6-konishi.ryusuke@gmail.com>
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

All callers of nilfs_page_buffers_clean() now have a folio, so convert
it to take a folio.  While I'm at it, make it return a bool.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
---
 fs/nilfs2/page.c    | 18 +++++++++---------
 fs/nilfs2/page.h    |  2 +-
 fs/nilfs2/segment.c |  4 ++--
 3 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/fs/nilfs2/page.c b/fs/nilfs2/page.c
index 3882acde1b3e..29799a49c234 100644
--- a/fs/nilfs2/page.c
+++ b/fs/nilfs2/page.c
@@ -81,7 +81,7 @@ void nilfs_forget_buffer(struct buffer_head *bh)
 
 	lock_buffer(bh);
 	set_mask_bits(&bh->b_state, clear_bits, 0);
-	if (nilfs_page_buffers_clean(&folio->page))
+	if (nilfs_folio_buffers_clean(folio))
 		__nilfs_clear_page_dirty(&folio->page);
 
 	bh->b_blocknr = -1;
@@ -131,23 +131,23 @@ void nilfs_copy_buffer(struct buffer_head *dbh, struct buffer_head *sbh)
 }
 
 /**
- * nilfs_page_buffers_clean - check if a page has dirty buffers or not.
- * @page: page to be checked
+ * nilfs_folio_buffers_clean - Check if a folio has dirty buffers or not.
+ * @folio: Folio to be checked.
  *
- * nilfs_page_buffers_clean() returns zero if the page has dirty buffers.
- * Otherwise, it returns non-zero value.
+ * nilfs_folio_buffers_clean() returns false if the folio has dirty buffers.
+ * Otherwise, it returns true.
  */
-int nilfs_page_buffers_clean(struct page *page)
+bool nilfs_folio_buffers_clean(struct folio *folio)
 {
 	struct buffer_head *bh, *head;
 
-	bh = head = page_buffers(page);
+	bh = head = folio_buffers(folio);
 	do {
 		if (buffer_dirty(bh))
-			return 0;
+			return false;
 		bh = bh->b_this_page;
 	} while (bh != head);
-	return 1;
+	return true;
 }
 
 void nilfs_page_bug(struct page *page)
diff --git a/fs/nilfs2/page.h b/fs/nilfs2/page.h
index d249ea1cefff..a8ab800e689c 100644
--- a/fs/nilfs2/page.h
+++ b/fs/nilfs2/page.h
@@ -36,7 +36,7 @@ struct buffer_head *nilfs_grab_buffer(struct inode *, struct address_space *,
 				      unsigned long, unsigned long);
 void nilfs_forget_buffer(struct buffer_head *);
 void nilfs_copy_buffer(struct buffer_head *, struct buffer_head *);
-int nilfs_page_buffers_clean(struct page *);
+bool nilfs_folio_buffers_clean(struct folio *);
 void nilfs_page_bug(struct page *);
 
 int nilfs_copy_dirty_pages(struct address_space *, struct address_space *);
diff --git a/fs/nilfs2/segment.c b/fs/nilfs2/segment.c
index 2a058aad5c2d..888b8606a1e8 100644
--- a/fs/nilfs2/segment.c
+++ b/fs/nilfs2/segment.c
@@ -1759,7 +1759,7 @@ static void nilfs_end_folio_io(struct folio *folio, int err)
 			 * all the buffers get cleaned later.
 			 */
 			folio_lock(folio);
-			if (nilfs_page_buffers_clean(&folio->page))
+			if (nilfs_folio_buffers_clean(folio))
 				__nilfs_clear_page_dirty(&folio->page);
 			folio_unlock(folio);
 		}
@@ -1767,7 +1767,7 @@ static void nilfs_end_folio_io(struct folio *folio, int err)
 	}
 
 	if (!err) {
-		if (!nilfs_page_buffers_clean(&folio->page))
+		if (!nilfs_folio_buffers_clean(folio))
 			filemap_dirty_folio(folio->mapping, folio);
 		folio_clear_error(folio);
 	} else {
-- 
2.34.1

