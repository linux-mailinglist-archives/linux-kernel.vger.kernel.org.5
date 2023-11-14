Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECCD87EABF9
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 09:47:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232557AbjKNIrG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 03:47:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232641AbjKNIqb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 03:46:31 -0500
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1C5D19A6;
        Tue, 14 Nov 2023 00:46:07 -0800 (PST)
Received: by mail-oi1-x22a.google.com with SMTP id 5614622812f47-3b2e4107f47so3625430b6e.2;
        Tue, 14 Nov 2023 00:46:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699951566; x=1700556366; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0u3It2drrXQuzpGZGjojr+w5m1YXAaW5alfZVPVoURE=;
        b=i/4913lMnZTbNYYbBZxoONrvQd3ILz3Gk1WhsiUXlZ1IK2BRpcSrN/A6OvM8Q8yWMW
         JeGAdcKOWdcl/M5YsFBxHi7tlv2tI5qOcAC6xl9loODcv6dpKPNcgApv0WF7CAKoYVKb
         VE4sQk+3BnMFAqfZbnXYRguV6wPuJcLsljkL0L8ccJKh/0RbLUqVdf4aIUiBRiuWlgr/
         fZbVBf+lOfe/qAarBh6BHTB2yJYjGPni/RuQ77idmjUD3YeP++5MDcDzY+L5ugjmMEEn
         xTJ6v23CQMUt287u6JtXJ6uvxUkvpFURDbjt8Ef5I/dbSIyVuY9b0GNBm7SVszmW5Ri4
         +PFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699951566; x=1700556366;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0u3It2drrXQuzpGZGjojr+w5m1YXAaW5alfZVPVoURE=;
        b=jMCGvASOmSOrzXnpFhCVK8gYXTGQgpSD5kWDX6bhBmRS7TsmJ4Cet6+WJXd8zc3A+m
         04tpefaWsGzbDWLABRqB/ea39OiXVA2tRDcDH9GW8dFIafu3SEhGW/eFdnm8o8qN7/1t
         cK0wQ0xTPAe7IizAzRFjxx4v5Rl3L2ZhlOpdKFIO2+gqfhEgp5+hLerZDZAKBZNNAgWc
         o7yAORnkrLvCPAYyELBp8153vhnc3bHbzseIln6d4g3wmgamqJlH3CFBnZYbHLzDQjR5
         CGwhN6xaTV/mO5WH27V84WxzU5gxLwR2Tgz7R8cp7H/Dtm7bhz1dtF8FoJeboS8cBWvy
         5XnQ==
X-Gm-Message-State: AOJu0YyvDSURW4++8jOnlvtwlz0ujfrQz9PddNJj/EopNE59u9pydM0l
        6gAU2y9g7p3L2IfzXHLRwO8=
X-Google-Smtp-Source: AGHT+IHe0NkBRnHHGw5uhCB3JTRF9/uKlWMkmGVcyOzxYmzjCv/Ni9gUHlUDcP2Ke5fyXZnVPlRjLw==
X-Received: by 2002:a05:6871:6203:b0:1f0:820a:e4b1 with SMTP id rd3-20020a056871620300b001f0820ae4b1mr11524624oab.34.1699951566366;
        Tue, 14 Nov 2023 00:46:06 -0800 (PST)
Received: from carrot.. (i223-218-133-131.s42.a014.ap.plala.or.jp. [223.218.133.131])
        by smtp.gmail.com with ESMTPSA id u17-20020a056a00159100b006c4d2479c1asm748083pfk.219.2023.11.14.00.46.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 00:46:05 -0800 (PST)
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-nilfs@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 18/20] nilfs2: Convert nilfs_btnode_prepare_change_key to use a folio
Date:   Tue, 14 Nov 2023 17:44:34 +0900
Message-Id: <20231114084436.2755-19-konishi.ryusuke@gmail.com>
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

Saves three calls to compound_head().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
---
 fs/nilfs2/btnode.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/fs/nilfs2/btnode.c b/fs/nilfs2/btnode.c
index e077d4a7a11c..da3e4366625f 100644
--- a/fs/nilfs2/btnode.c
+++ b/fs/nilfs2/btnode.c
@@ -185,23 +185,23 @@ int nilfs_btnode_prepare_change_key(struct address_space *btnc,
 	ctxt->newbh = NULL;
 
 	if (inode->i_blkbits == PAGE_SHIFT) {
-		struct page *opage = obh->b_page;
-		lock_page(opage);
+		struct folio *ofolio = obh->b_folio;
+		folio_lock(ofolio);
 retry:
 		/* BUG_ON(oldkey != obh->b_folio->index); */
-		if (unlikely(oldkey != opage->index))
-			NILFS_PAGE_BUG(opage,
+		if (unlikely(oldkey != ofolio->index))
+			NILFS_PAGE_BUG(&ofolio->page,
 				       "invalid oldkey %lld (newkey=%lld)",
 				       (unsigned long long)oldkey,
 				       (unsigned long long)newkey);
 
 		xa_lock_irq(&btnc->i_pages);
-		err = __xa_insert(&btnc->i_pages, newkey, opage, GFP_NOFS);
+		err = __xa_insert(&btnc->i_pages, newkey, ofolio, GFP_NOFS);
 		xa_unlock_irq(&btnc->i_pages);
 		/*
-		 * Note: page->index will not change to newkey until
+		 * Note: folio->index will not change to newkey until
 		 * nilfs_btnode_commit_change_key() will be called.
-		 * To protect the page in intermediate state, the page lock
+		 * To protect the folio in intermediate state, the folio lock
 		 * is held.
 		 */
 		if (!err)
@@ -213,7 +213,7 @@ int nilfs_btnode_prepare_change_key(struct address_space *btnc,
 		if (!err)
 			goto retry;
 		/* fallback to copy mode */
-		unlock_page(opage);
+		folio_unlock(ofolio);
 	}
 
 	nbh = nilfs_btnode_create_block(btnc, newkey);
@@ -225,7 +225,7 @@ int nilfs_btnode_prepare_change_key(struct address_space *btnc,
 	return 0;
 
  failed_unlock:
-	unlock_page(obh->b_page);
+	folio_unlock(obh->b_folio);
 	return err;
 }
 
-- 
2.34.1

