Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 027F37FA2D5
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 15:32:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233904AbjK0Ock (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 09:32:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233799AbjK0ObW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 09:31:22 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8711C1AD;
        Mon, 27 Nov 2023 06:31:25 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1cf89df1eecso27319505ad.3;
        Mon, 27 Nov 2023 06:31:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701095485; x=1701700285; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LQ0hTMNOO2rQEY/dpZit98zV3CambmsVJR+t1rZ7hqw=;
        b=lvFBsreHk2zBB4k3PxfvUiSWpHMqxYMoxPpfUbGsWPzafdGKfV9jpTYqrtJtgbMJr0
         YLQ5fZl+e6CMCbDY+1aGMrqmtXUGHrwj0F8bQJJF5RY/XHhdxxQ7j99AZWHcfRntw+FT
         3dtMoaiUrQ3vSNhMf3CRCDNIKozNsXaE+7lLATjUgzIu3+9afC+r3PNfq9yG26mrEuj2
         KBtmM2wJp38mRb1irXA3GEyo3CxwrurWtr2o2CiloHIiKVP/jbzg7Q0zPdsBZWba2arb
         XtpXPHGl8/OQMNnGqRuED2NqSeqTfr6w++2yuqLkT/SQUrcuZ3wT5sZa1slrV7MN1nc6
         zpng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701095485; x=1701700285;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LQ0hTMNOO2rQEY/dpZit98zV3CambmsVJR+t1rZ7hqw=;
        b=oE72ZTJXknOkhAjo3J3fxy49gThjWmVuykMy8N94IEOPx6zQ61MukmGAHxCSyZNTBf
         ks0GJYEJOTgg9iDzzmPVSj/+U0I9HZ1Wi0/KH7MC4sV4x7REkBYraYcupaIau8zFvX3f
         yzm3uny6w4gDXVOyN1O+URquzUEzx/UpkRaUtVB5CVIax9k3FYPldLMVOkpcaR3xvpPV
         1o6fCJ8FCOPvWzfSJ1fsFu6Voq0/XRCHXCZSv8Ibf0PPNaaFKpnQJDkoyfCz69cZi6GW
         Cs3/NSH9Lwje7HJUwcBEA+Ui0rumqDU4TX+YnLG9PIzM18h5VMLjuFl0WISgwQH+bDsX
         1efQ==
X-Gm-Message-State: AOJu0YxjHT9idnkKOUUp8H3D2koxfUuEF1wYakmvTIB3XmvB41Ru4njk
        DKFSFCUmltCSxWNU8iZTRsA=
X-Google-Smtp-Source: AGHT+IGy/CYDGZVItVW7R8O6dqj5gmUXwm0OW1c2CXsygrOfqAP0Is/gJQa5ZYWaF7N2qjYgEcMYuw==
X-Received: by 2002:a17:902:e843:b0:1cf:d24c:7b6c with SMTP id t3-20020a170902e84300b001cfd24c7b6cmr2485252plg.59.1701095484950;
        Mon, 27 Nov 2023 06:31:24 -0800 (PST)
Received: from carrot.. (i60-34-119-11.s42.a014.ap.plala.or.jp. [60.34.119.11])
        by smtp.gmail.com with ESMTPSA id a5-20020a170902ee8500b001cf51972586sm8302784pld.292.2023.11.27.06.31.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 06:31:24 -0800 (PST)
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-nilfs@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 14/17] nilfs2: Convert nilfs_empty_dir() to use a folio
Date:   Mon, 27 Nov 2023 23:30:33 +0900
Message-Id: <20231127143036.2425-15-konishi.ryusuke@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231127143036.2425-1-konishi.ryusuke@gmail.com>
References: <20231127143036.2425-1-konishi.ryusuke@gmail.com>
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

Remove three calls to compound_head() by using the folio API.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
---
 fs/nilfs2/dir.c | 19 ++++---------------
 1 file changed, 4 insertions(+), 15 deletions(-)

diff --git a/fs/nilfs2/dir.c b/fs/nilfs2/dir.c
index 8d8c42e34148..919936d9ec27 100644
--- a/fs/nilfs2/dir.c
+++ b/fs/nilfs2/dir.c
@@ -203,17 +203,6 @@ static void *nilfs_get_folio(struct inode *dir, unsigned long n,
 	return ERR_PTR(-EIO);
 }
 
-static void *nilfs_get_page(struct inode *dir, unsigned long n,
-		struct page **pagep)
-{
-	struct folio *folio;
-	void *kaddr = nilfs_get_folio(dir, n, &folio);
-
-	if (!IS_ERR(kaddr))
-		*pagep = &folio->page;
-	return kaddr;
-}
-
 /*
  * NOTE! unlike strncmp, nilfs_match returns 1 for success, 0 for failure.
  *
@@ -611,14 +600,14 @@ int nilfs_make_empty(struct inode *inode, struct inode *parent)
  */
 int nilfs_empty_dir(struct inode *inode)
 {
-	struct page *page = NULL;
+	struct folio *folio = NULL;
 	char *kaddr;
 	unsigned long i, npages = dir_pages(inode);
 
 	for (i = 0; i < npages; i++) {
 		struct nilfs_dir_entry *de;
 
-		kaddr = nilfs_get_page(inode, i, &page);
+		kaddr = nilfs_get_folio(inode, i, &folio);
 		if (IS_ERR(kaddr))
 			continue;
 
@@ -647,12 +636,12 @@ int nilfs_empty_dir(struct inode *inode)
 			}
 			de = nilfs_next_entry(de);
 		}
-		unmap_and_put_page(page, kaddr);
+		folio_release_kmap(folio, kaddr);
 	}
 	return 1;
 
 not_empty:
-	unmap_and_put_page(page, kaddr);
+	folio_release_kmap(folio, kaddr);
 	return 0;
 }
 
-- 
2.34.1

