Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF8437EABF8
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 09:47:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232634AbjKNIrD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 03:47:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232629AbjKNIqa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 03:46:30 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AE921998;
        Tue, 14 Nov 2023 00:46:05 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-6b1d1099a84so5371894b3a.1;
        Tue, 14 Nov 2023 00:46:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699951564; x=1700556364; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v358YCD378yAUvjDSYqbMjqywkD/bfhThxAzZwlQTSk=;
        b=mHOGuFVK4jFaLGYVqhWbAgtTr37E66fbEpUFyra2s7OyZHcEoJf4DB6vTfujlQxHT6
         nJ1TEcgQ3kNTV4OkPsw+m/CmcnNDLMFGa7VG2jPCvEwoTGmIipzixdtMunc50sNPwRLn
         DSZodufzhCsqS3Sn5JBsAnyJJ0i1vkLRdXxmfGpqsKxwwZBoeLIo1/Zbz6rOqCXMR/13
         Xib4P6ZLl0FbKUTSSXMzLMpbk0WwPTo+h40DQoyaKejKSaBXrYDdorgCDZikp8MjUGM9
         QbO5UdeZw3vJXAg86nlxgnhpXdEuRxX5q3JGY1HyjP7/ilAP9b9O98/2xLXvpUge5mRm
         2Haw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699951564; x=1700556364;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v358YCD378yAUvjDSYqbMjqywkD/bfhThxAzZwlQTSk=;
        b=MLZ4CPWCMs7lYcSX/gZW7hq+M2zvpAqbPXIkhBJZfXVYnGGctm2mEUsckFynCRFDU9
         k8PvAtBZ/ImHpjzPlQ1SZFiwMS6I8Kw5CAO+muBOynXBXHTLAPkelAy65eDg1h9TlOIn
         EHaINJbKI13ySVt1fDskVbylxPdOnH6Z/CCzSz8RtV9n7thWhBb65BZJpJ3b+KueYzHa
         LuxQ91vh9dbTcx7GmidxVz5HAcZEn4M8EB3KgPmx0mPlJrDGUCpzvhYWI5SRSHJC2PnI
         opBiSV6VcXMcMXyaGOV++QHOmzqDgi9pImO51X/GZ9m9L3NzQt/W1jwM9cO4l7vfmOV/
         ttjA==
X-Gm-Message-State: AOJu0YzL3bcyS7s/vw65cSrQZrehdnZGfphnldqxXQaZQpl2SyrllXce
        8rgr4rf5uoXarOO1KXlZseI=
X-Google-Smtp-Source: AGHT+IHhs//nGD6esu/F6izEI8z4t8rdfe+6DIWTJVnJ+oTVGq+8evvez39HT07/TiWPXBGZQ0dRrQ==
X-Received: by 2002:a05:6a21:788b:b0:180:daeb:ac5e with SMTP id bf11-20020a056a21788b00b00180daebac5emr12442402pzc.10.1699951564355;
        Tue, 14 Nov 2023 00:46:04 -0800 (PST)
Received: from carrot.. (i223-218-133-131.s42.a014.ap.plala.or.jp. [223.218.133.131])
        by smtp.gmail.com with ESMTPSA id u17-20020a056a00159100b006c4d2479c1asm748083pfk.219.2023.11.14.00.46.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 00:46:03 -0800 (PST)
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-nilfs@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 17/20] nilfs2: Convert nilfs_btnode_delete to use a folio
Date:   Tue, 14 Nov 2023 17:44:33 +0900
Message-Id: <20231114084436.2755-18-konishi.ryusuke@gmail.com>
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

Saves six calls to compound_head().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
---
 fs/nilfs2/btnode.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/fs/nilfs2/btnode.c b/fs/nilfs2/btnode.c
index 5ef9eebd8d2e..e077d4a7a11c 100644
--- a/fs/nilfs2/btnode.c
+++ b/fs/nilfs2/btnode.c
@@ -145,19 +145,19 @@ int nilfs_btnode_submit_block(struct address_space *btnc, __u64 blocknr,
 void nilfs_btnode_delete(struct buffer_head *bh)
 {
 	struct address_space *mapping;
-	struct page *page = bh->b_page;
-	pgoff_t index = page_index(page);
+	struct folio *folio = bh->b_folio;
+	pgoff_t index = folio->index;
 	int still_dirty;
 
-	get_page(page);
-	lock_page(page);
-	wait_on_page_writeback(page);
+	folio_get(folio);
+	folio_lock(folio);
+	folio_wait_writeback(folio);
 
 	nilfs_forget_buffer(bh);
-	still_dirty = PageDirty(page);
-	mapping = page->mapping;
-	unlock_page(page);
-	put_page(page);
+	still_dirty = folio_test_dirty(folio);
+	mapping = folio->mapping;
+	folio_unlock(folio);
+	folio_put(folio);
 
 	if (!still_dirty && mapping)
 		invalidate_inode_pages2_range(mapping, index, index);
-- 
2.34.1

