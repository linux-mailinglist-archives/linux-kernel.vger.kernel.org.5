Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B41157EABFD
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 09:47:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232600AbjKNIrT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 03:47:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232672AbjKNIqd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 03:46:33 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D10E1BC6;
        Tue, 14 Nov 2023 00:46:11 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-6c320a821c4so4572396b3a.2;
        Tue, 14 Nov 2023 00:46:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699951570; x=1700556370; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cYy3qj/vutDt+D3+abE3OR1PaLNKfT9k3Yx/seQi4CM=;
        b=eseC46oWq92951qfMVbWpumE3BsQ7VPqmRlMHOIssSdgBVMOK12OFTH9omCxYSNh2G
         NSzd7b1MNxLC4f2a6A7p3cb/S/oQB+c7R6bOTtGSfGRP+35Zqj8VSExp5oYCZau/WdtO
         1tKlscof0R9uHb3SuJg2yFkZdYK09l6nUwyUBhdt1o4W0644W3VQeaLiUhcwtYihcQOu
         yusFsXn723WdqzBlixD8bNWkT4v8xs+cw1bLawUYRJZ/388OW/wNgLfg3/nDqbS35fGG
         Vc8ODGIauiXWctNi5+Vg5v7y+L3R9DpLIZy2AgEUV+EZerwHVrcKAFhbHxXwpTOZL1zu
         6MZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699951570; x=1700556370;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cYy3qj/vutDt+D3+abE3OR1PaLNKfT9k3Yx/seQi4CM=;
        b=jZ8qKtEZWBqdiSJEy42nvLR8ylNxygO0h9ezbvkmRC5BLnl2IJAQL/5cuXAun6cYi8
         0DxK6KOvZZJjz1/EysiRVlT5Hl0cjH+IA417y8C4Lop2NnaEXcGOvVwS22h8uvV7YZ36
         tcL7X4xfamBiVh3q38E1L3ccxdCAdYz1rBJ6osy5j5m+04ebDW/EZfMndfZJsKm/QCus
         Przq9DCQIDebXEli0itm7IYa4kCQCUFB3iOPG2dsrBVSBfwJFe9QwAOGhd2jmCe3TWPl
         luNx4ozqjnwdXPZrW1mlI63GdpMVnNJfgIXLUCAzjOzAlaep1+LAucJfokynyDyKsrlE
         vT8g==
X-Gm-Message-State: AOJu0YwEiwkPxWvf5slyITGl7UBUQsfvjKEFdDdmPNFraRgV8Odqk4oi
        kj1BDiA2axh8ViI+BBPY2TFYCEbkg50=
X-Google-Smtp-Source: AGHT+IGoNFWQTBdRQ8lFIohacw/5UPQ+Mex4ArUkR7byM9Apbrjb6Iw0AXUEpKyrNtWOzX2IprESKA==
X-Received: by 2002:a05:6a00:4388:b0:6c0:642c:274b with SMTP id bt8-20020a056a00438800b006c0642c274bmr7557613pfb.9.1699951570453;
        Tue, 14 Nov 2023 00:46:10 -0800 (PST)
Received: from carrot.. (i223-218-133-131.s42.a014.ap.plala.or.jp. [223.218.133.131])
        by smtp.gmail.com with ESMTPSA id u17-20020a056a00159100b006c4d2479c1asm748083pfk.219.2023.11.14.00.46.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 00:46:09 -0800 (PST)
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-nilfs@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 20/20] nilfs2: Convert nilfs_btnode_abort_change_key to use a folio
Date:   Tue, 14 Nov 2023 17:44:36 +0900
Message-Id: <20231114084436.2755-21-konishi.ryusuke@gmail.com>
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

Saves one call to compound_head().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
---
 fs/nilfs2/btnode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nilfs2/btnode.c b/fs/nilfs2/btnode.c
index fb1638765d54..1204dd06ead8 100644
--- a/fs/nilfs2/btnode.c
+++ b/fs/nilfs2/btnode.c
@@ -284,7 +284,7 @@ void nilfs_btnode_abort_change_key(struct address_space *btnc,
 
 	if (nbh == NULL) {	/* blocksize == pagesize */
 		xa_erase_irq(&btnc->i_pages, newkey);
-		unlock_page(ctxt->bh->b_page);
+		folio_unlock(ctxt->bh->b_folio);
 	} else {
 		/*
 		 * When canceling a buffer that a prepare operation has
-- 
2.34.1

