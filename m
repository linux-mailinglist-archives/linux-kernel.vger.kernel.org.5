Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EEF07EABE6
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 09:46:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232547AbjKNIqH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 03:46:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232395AbjKNIpu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 03:45:50 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 336E0D4D;
        Tue, 14 Nov 2023 00:45:46 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-6c34e87b571so4448529b3a.3;
        Tue, 14 Nov 2023 00:45:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699951545; x=1700556345; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DYBrKD//Fwh/NYZY8hEC83Yv0uKXYu3iL+h8zoNblA8=;
        b=jSiuoen5cbGc0b5p0FsLgVqL1+1WNb3Wo8lERYUAY0YW1kOulucBZNJLZuanBdo4mu
         2N2rP7SvfV8x0/PKR9I+s9gnUWQ99g/Wi1P1z9dyQ+SXjrke5+DiV7x+yk+QWvj0Edsi
         vmYOpQbSBVRO0rwa5EDq37+6slPRVPbRA5ZcYsBx3mPNBopRu5JlfYCyf60n4nsZKvXz
         qW0sa0t5/7gs8gDMLS2/sDHJMMQhTF05oTGiSOtZ+gccBAGT6tNCVR6uuYL+XCekT+Pg
         ndaRsKyJco3yK4Do0n4TalSV2TP4XhRTdwau9GPF32agpWnbhPkf6eBWQYcb5cZOZfqa
         3viA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699951545; x=1700556345;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DYBrKD//Fwh/NYZY8hEC83Yv0uKXYu3iL+h8zoNblA8=;
        b=pAGgANwa99GBn0+/eXRNgmBbqzJftAK6I6CQAOPP8cA/SIIi8UCitHI1E7MVTbyvq7
         S6LJ/mQcmf3mC9Z7UFq+Z9klxgMq1I+kolyl5v8PH7AURcsBeGIf26oWqIj6BJSlsaoN
         OqFYSPAkV/L5t1y5Yu3izmyjc0ehjiyuCxR2EB/x0IZKwlQh0WA2PrIbpcKrwQY2N/2s
         d7/aOfgyAL2nxa9hxkk8ixpLLLbSu1rs8dHDcWdMnLYznxdSSB582pXlZwClfHvAz1C0
         tZG400kvoXASY5vjBU0YPLZRUPng5jC5rS2D9N3MbpaUM+cMMgaUMxU+deyQqG+7q8kD
         lsiQ==
X-Gm-Message-State: AOJu0YxLwIAYarhbPmPCtHWELWUq8q5Ry27U1+W9v3j4VYioDpGxJStO
        gZi2Z5QKzFgSdC4T9p+CPpg=
X-Google-Smtp-Source: AGHT+IE3UFGbSKRjwU4ysemEf6rTUEdsWYoIbCpV3qIcaf0HckuZQkAEhiYh5fxxDQR2IQqoLOwm8Q==
X-Received: by 2002:a05:6a00:230f:b0:6be:22db:7a13 with SMTP id h15-20020a056a00230f00b006be22db7a13mr8655258pfh.25.1699951545636;
        Tue, 14 Nov 2023 00:45:45 -0800 (PST)
Received: from carrot.. (i223-218-133-131.s42.a014.ap.plala.or.jp. [223.218.133.131])
        by smtp.gmail.com with ESMTPSA id u17-20020a056a00159100b006c4d2479c1asm748083pfk.219.2023.11.14.00.45.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 00:45:45 -0800 (PST)
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-nilfs@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 07/20] nilfs2: Convert nilfs_mdt_write_page() to use a folio
Date:   Tue, 14 Nov 2023 17:44:23 +0900
Message-Id: <20231114084436.2755-8-konishi.ryusuke@gmail.com>
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

Convert the incoming page to a folio.  Replaces three calls to
compound_head() with one.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
---
 fs/nilfs2/mdt.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/fs/nilfs2/mdt.c b/fs/nilfs2/mdt.c
index c97c77a39668..327408512b86 100644
--- a/fs/nilfs2/mdt.c
+++ b/fs/nilfs2/mdt.c
@@ -399,7 +399,8 @@ int nilfs_mdt_fetch_dirty(struct inode *inode)
 static int
 nilfs_mdt_write_page(struct page *page, struct writeback_control *wbc)
 {
-	struct inode *inode = page->mapping->host;
+	struct folio *folio = page_folio(page);
+	struct inode *inode = folio->mapping->host;
 	struct super_block *sb;
 	int err = 0;
 
@@ -407,16 +408,16 @@ nilfs_mdt_write_page(struct page *page, struct writeback_control *wbc)
 		/*
 		 * It means that filesystem was remounted in read-only
 		 * mode because of error or metadata corruption. But we
-		 * have dirty pages that try to be flushed in background.
-		 * So, here we simply discard this dirty page.
+		 * have dirty folios that try to be flushed in background.
+		 * So, here we simply discard this dirty folio.
 		 */
 		nilfs_clear_dirty_page(page, false);
-		unlock_page(page);
+		folio_unlock(folio);
 		return -EROFS;
 	}
 
-	redirty_page_for_writepage(wbc, page);
-	unlock_page(page);
+	folio_redirty_for_writepage(wbc, folio);
+	folio_unlock(folio);
 
 	if (!inode)
 		return 0;
-- 
2.34.1

