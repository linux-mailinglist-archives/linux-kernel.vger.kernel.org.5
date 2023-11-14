Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42E147EABF0
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 09:46:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232574AbjKNIql (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 03:46:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232460AbjKNIqF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 03:46:05 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 583DD1A8;
        Tue, 14 Nov 2023 00:45:59 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-5a9bc2ec556so3223812a12.0;
        Tue, 14 Nov 2023 00:45:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699951559; x=1700556359; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zf/f9iBOx5zFbOHUi2L8dYuwfOZwOV/VjcIWW5aZNCI=;
        b=B8v0iAi4kWFSw4xBDhd+yCGqGjSxUsaQLqxk393Oponv1r4hKDIt0uXMdh4o9tLoZ7
         03Dzb6C0Vs3U9OREKrRHXw8faF3ZgeHWxoNsB+8lZm4mDNa806GOblpzPsbLEgjEkNxI
         r7ps5c/nFm7le8eQrDW/0ccyJ2FskBzkTp9o7b8wm9MoXk1RrMcDBTmEO1Ulqa05EUpS
         UMclit9dFQ0uUiclwSqPKD6ROK+V8q8vqAYfU7um3Wty0NxNfjn8H33TQosv4J+nyot0
         jap1zycVIyH9OP3LJiKcXqygEzR9XPDM2dR5SWQTKqTFsF+DQzKawMolSiaXJJCHAFaF
         t9Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699951559; x=1700556359;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zf/f9iBOx5zFbOHUi2L8dYuwfOZwOV/VjcIWW5aZNCI=;
        b=pxf2WmDPc9i0WCE3+wM9KwcpSwE6xjMivvJ4jj2w61ohiiOiWPHbnCsajhb1Fexvum
         HOK2xGgkPK7Rl4RECGuwzkdAqIeB+XXXeJ47hwRRVnDf89rXn64mDi7kdGknaDepQcvL
         6Hbfcth2266Llw8tNWg6+eo3cc3gALWoN/XeDp8yN8mV2s1Ouv0UW9DczauFeQiT82pC
         ZL8n/ByPR+4j1ZmbDaRluWOkRJA9iUzS0eONaCrrQp6Ewr5q2JYOs0UrydqMn0VpdsMk
         knJInRh/Xexxjzv9j40tABQ89hcEY7raO32aAkIYStnBXM6SIwNsgf7N3UpyYUWMPX2D
         d/Pw==
X-Gm-Message-State: AOJu0YwssL7kaqMjLBLRM9oaTsbfHzoQ4wgm6GueOx9NNRBcV+kpDAVj
        wZINF6vgchUR6+PxCNM2Ch4=
X-Google-Smtp-Source: AGHT+IHGqVToJdO+0H/0NSFkx7CPf9B44RgCTRB9vswuZp86zB2Aef/ztx0eec3ChpSL2pSFgZfAWQ==
X-Received: by 2002:a05:6a20:244a:b0:16b:80f2:f30c with SMTP id t10-20020a056a20244a00b0016b80f2f30cmr7338974pzc.26.1699951558709;
        Tue, 14 Nov 2023 00:45:58 -0800 (PST)
Received: from carrot.. (i223-218-133-131.s42.a014.ap.plala.or.jp. [223.218.133.131])
        by smtp.gmail.com with ESMTPSA id u17-20020a056a00159100b006c4d2479c1asm748083pfk.219.2023.11.14.00.45.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 00:45:58 -0800 (PST)
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-nilfs@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 14/20] nilfs2: Convert nilfs_gccache_submit_read_data to use a folio
Date:   Tue, 14 Nov 2023 17:44:30 +0900
Message-Id: <20231114084436.2755-15-konishi.ryusuke@gmail.com>
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
 fs/nilfs2/gcinode.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/nilfs2/gcinode.c b/fs/nilfs2/gcinode.c
index 8beb2730929d..bf9a11d58817 100644
--- a/fs/nilfs2/gcinode.c
+++ b/fs/nilfs2/gcinode.c
@@ -98,8 +98,8 @@ int nilfs_gccache_submit_read_data(struct inode *inode, sector_t blkoff,
 	*out_bh = bh;
 
  failed:
-	unlock_page(bh->b_page);
-	put_page(bh->b_page);
+	folio_unlock(bh->b_folio);
+	folio_put(bh->b_folio);
 	if (unlikely(err))
 		brelse(bh);
 	return err;
-- 
2.34.1

