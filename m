Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 501B07EABEF
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 09:46:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232493AbjKNIqf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 03:46:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232520AbjKNIqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 03:46:03 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5826172A;
        Tue, 14 Nov 2023 00:45:55 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-6c33ab26dddso4647572b3a.0;
        Tue, 14 Nov 2023 00:45:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699951555; x=1700556355; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jOfolZFbaeNksDOEbKm+WHbGTOTwNzBMg/acdZEYYm0=;
        b=Q4/Q46fQKj/iZ+6jlByyi8fVg2sibhtdHaSm03Bmt8R51a/vcqR995EAXBYKk7dB3/
         LCg3350aatZC9wTrxN6QUnkQhAS6kjrTDFCXs0UfSMLm9AihNbIieZAFajAPwaVzIfjO
         0T3apb2g+IIWCGQ4+GF3uZzfJtWMfvdNAei/keglE1WWMY4ZmRqrMaCfXF3E8jUseOVf
         VbcHeLY8x5RRBfMdvEXcl022V/e9wkNwGPsQmUIWN+RIiZHAXMe6KwCl+c1pMHEYyBNq
         cQ3pF220say2e+PB5/HkO8CyE0H2CmULrElKZfKYZt1LDL6kOJBrUGiTwACMIpZ0MXjA
         qVgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699951555; x=1700556355;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jOfolZFbaeNksDOEbKm+WHbGTOTwNzBMg/acdZEYYm0=;
        b=wvE0L2u7/289yHL3o4Db1KUhNz2WFnrKTM+/Zq4VDbAcrZXZ58VNIPfssN6bRC+CsQ
         2DLteAfS/waP0VFrHmw4bsCniryjxxRoQ8BgCfXXIA7TYH+SLLL36imdaPN2wdLn27pv
         631DUwiE1666E86IVbDeUfzVJCNzyxOTP7ix3KRPIloiyaK5sM+v0SLCIhnrqv0lizov
         Q7we9TVF6xr+kEHo4cB1jDjs+M4Gfu3uVeJRvbb7mjVTd0ueG82wkg1g1niqV//2GojL
         qErq9uxwtEv4J57/aC3BbF6/IgN1aHXqx/Y3/wCrzUOV6GVSYxh13c7x497CvSh1H3gl
         6llQ==
X-Gm-Message-State: AOJu0YxU4rguTBUceJFxP1pwMukAweFu1l2kkg44sFP9215A0yspXeej
        RydXjVlxvFPr5IbiypByf/0=
X-Google-Smtp-Source: AGHT+IFRkq0ZMiECnb8jMt5B1LgZZ4K009MFF6pkKsoYuJb9UzOLGt4BV+BpbptFEx/LEX5AEHnnvQ==
X-Received: by 2002:a05:6a00:2e1f:b0:6c6:b762:ad8c with SMTP id fc31-20020a056a002e1f00b006c6b762ad8cmr7012892pfb.0.1699951555054;
        Tue, 14 Nov 2023 00:45:55 -0800 (PST)
Received: from carrot.. (i223-218-133-131.s42.a014.ap.plala.or.jp. [223.218.133.131])
        by smtp.gmail.com with ESMTPSA id u17-20020a056a00159100b006c4d2479c1asm748083pfk.219.2023.11.14.00.45.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 00:45:54 -0800 (PST)
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-nilfs@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 12/20] nilfs2: Convert nilfs_mdt_create_block to use a folio
Date:   Tue, 14 Nov 2023 17:44:28 +0900
Message-Id: <20231114084436.2755-13-konishi.ryusuke@gmail.com>
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

Saves two calls to compound_head().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
---
 fs/nilfs2/mdt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/nilfs2/mdt.c b/fs/nilfs2/mdt.c
index 2e7952ac2f67..7e4dcff2c94b 100644
--- a/fs/nilfs2/mdt.c
+++ b/fs/nilfs2/mdt.c
@@ -97,8 +97,8 @@ static int nilfs_mdt_create_block(struct inode *inode, unsigned long block,
 	}
 
  failed_bh:
-	unlock_page(bh->b_page);
-	put_page(bh->b_page);
+	folio_unlock(bh->b_folio);
+	folio_put(bh->b_folio);
 	brelse(bh);
 
  failed_unlock:
-- 
2.34.1

