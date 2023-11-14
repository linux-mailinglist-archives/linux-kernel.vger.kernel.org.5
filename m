Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 511517EABD9
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 09:45:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232399AbjKNIpo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 03:45:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232394AbjKNIpk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 03:45:40 -0500
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 932621AA;
        Tue, 14 Nov 2023 00:45:36 -0800 (PST)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-1f0f94943d9so2586057fac.2;
        Tue, 14 Nov 2023 00:45:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699951536; x=1700556336; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yWvfE7i+Wd531m2SA+EEUbQTk1YRMjmDg9WKu9uNV+I=;
        b=ZcZ009AiJgpxRqcxcMEfaPhOlJV0MCqCrRPP0QfluVr3EkRyDN1zFwpKHh3c2xNYl8
         AAg8wrdIZYrBtMBMMs/d1FFoGTNCCkAEhBQa/kY4g50h5C24v58hepmmziRLJkxk59yz
         XeEVbbba6fSDetEK7ain4lcOT6oMrHBKqyEzrkCt3boL9OHHYhx3cSxplJqbmFcv7Sdf
         FHZaFbuz0HQliOKa09WLJdz7U/nO09099u+9uNRVj0EguBVgpzT/WcT467704YauVbjL
         Pnaw8UnoaGaAHLlqc0zrqZCNRpgdl6Wr69MGIWbVaFdh/ofQ07CyLJBaxYgwwpShsbBd
         lAWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699951536; x=1700556336;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yWvfE7i+Wd531m2SA+EEUbQTk1YRMjmDg9WKu9uNV+I=;
        b=oS3jVLA/u0cL3pGNOVoeCrHVyMxnmVuMSEankOPnZrT7xh5O1LiBtOa302UqAP4x2m
         N5iVbndN++ufS1rFUE58QJlL1Ht5nHLsCncRKSvadgMe3FyvWWKMZ8iUl64blEBjlImZ
         X009s5iH5As7oRSCqtIjMEX5UKkoMv2bKg2uboUvJIlHDEjqTsGsZtWjYtBQvtsJAdhA
         ZLvscumrzXqT026mei6hZ5ooCWvJR4rMztog2sULacKLvdb+Lk0dBUebKd+X8qZo4nkP
         HeXJxTWh2sr5ApzdLY+/1WgVI/fZ5aF02TC6y9e55/GqUxfByWVjPlTwZeQuR4Bn/AJ4
         yvDQ==
X-Gm-Message-State: AOJu0YyHc/6sml8aiBXXUyIDWvU+kqkWcCmbYtQn6kAS4xjZWZfrscW7
        +E1iuzx3E/HpM+oNATzddqPSu695rz8=
X-Google-Smtp-Source: AGHT+IGmFz6ZefiBoSRP2wkdhVdW9RaUeRwHNSD7WB7NGAVstoQ0BYpCQNvMLK1A5dLk79uh8yDumg==
X-Received: by 2002:a05:6871:5a8f:b0:1f0:630b:c84e with SMTP id oo15-20020a0568715a8f00b001f0630bc84emr9199228oac.57.1699951535866;
        Tue, 14 Nov 2023 00:45:35 -0800 (PST)
Received: from carrot.. (i223-218-133-131.s42.a014.ap.plala.or.jp. [223.218.133.131])
        by smtp.gmail.com with ESMTPSA id u17-20020a056a00159100b006c4d2479c1asm748083pfk.219.2023.11.14.00.45.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 00:45:35 -0800 (PST)
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-nilfs@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 02/20] nilfs2: Convert nilfs_abort_logs to use folios
Date:   Tue, 14 Nov 2023 17:44:18 +0900
Message-Id: <20231114084436.2755-3-konishi.ryusuke@gmail.com>
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

Use the new folio APIs, saving five hidden calls to compound_head().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
---
 fs/nilfs2/segment.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/fs/nilfs2/segment.c b/fs/nilfs2/segment.c
index 1df03d0895be..730062e79bfc 100644
--- a/fs/nilfs2/segment.c
+++ b/fs/nilfs2/segment.c
@@ -1788,7 +1788,7 @@ static void nilfs_end_page_io(struct page *page, int err)
 static void nilfs_abort_logs(struct list_head *logs, int err)
 {
 	struct nilfs_segment_buffer *segbuf;
-	struct page *bd_page = NULL, *fs_page = NULL;
+	struct folio *bd_folio = NULL, *fs_folio = NULL;
 	struct buffer_head *bh;
 
 	if (list_empty(logs))
@@ -1798,10 +1798,10 @@ static void nilfs_abort_logs(struct list_head *logs, int err)
 		list_for_each_entry(bh, &segbuf->sb_segsum_buffers,
 				    b_assoc_buffers) {
 			clear_buffer_uptodate(bh);
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
 
@@ -1810,22 +1810,22 @@ static void nilfs_abort_logs(struct list_head *logs, int err)
 			clear_buffer_async_write(bh);
 			if (bh == segbuf->sb_super_root) {
 				clear_buffer_uptodate(bh);
-				if (bh->b_page != bd_page) {
-					end_page_writeback(bd_page);
-					bd_page = bh->b_page;
+				if (bh->b_folio != bd_folio) {
+					folio_end_writeback(bd_folio);
+					bd_folio = bh->b_folio;
 				}
 				break;
 			}
-			if (bh->b_page != fs_page) {
-				nilfs_end_page_io(fs_page, err);
-				fs_page = bh->b_page;
+			if (bh->b_folio != fs_folio) {
+				nilfs_end_folio_io(fs_folio, err);
+				fs_folio = bh->b_folio;
 			}
 		}
 	}
-	if (bd_page)
-		end_page_writeback(bd_page);
+	if (bd_folio)
+		folio_end_writeback(bd_folio);
 
-	nilfs_end_page_io(fs_page, err);
+	nilfs_end_folio_io(fs_folio, err);
 }
 
 static void nilfs_segctor_abort_construction(struct nilfs_sc_info *sci,
-- 
2.34.1

