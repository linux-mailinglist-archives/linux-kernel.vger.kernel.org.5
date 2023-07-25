Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE6ED761E54
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 18:20:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231452AbjGYQU4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 12:20:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230377AbjGYQUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 12:20:54 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB6A39B
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 09:20:53 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1bbbbb77b38so5550255ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 09:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690302053; x=1690906853;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PfcdMs05qbbvWSvCjBhMrfVNYM47fcDI6/vSHSSIjGI=;
        b=AW/H8+YHwZqQHCG698GDYbjxB4Udw647Cxg+7Mj54YqXvUsakNsrUGDhqR/esMRFes
         KXXHDgRCBtsbLntH7Sg5oT7uCV0i+/+FVsjwebyesidFZU/I9UcFrEkF1Hs7kaDm2JgM
         hmpjPWVgCTWnKi7W5xPIkSn/7aJhX955ntoNisX0S7uBf5WBeu3BVSk08gzEd6wyVzmw
         72IxKSfq9wH+dN+pj+6xWYxXMSinInmdo5yS7CY8ZkqUAqwvKxUiNA5CdIxC8bwZMI29
         zmn9Ky1s0z4zwkQILWZN2Cc1ZrFgrdZBgZrQO9lO0G+ymAdA5wB1ZrYSKWj0GZtfaPf3
         VcFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690302053; x=1690906853;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PfcdMs05qbbvWSvCjBhMrfVNYM47fcDI6/vSHSSIjGI=;
        b=ad+q1c93HRGqXKeowa/U2immoYPTYUWdGAhgO61cJWe7rxMHsmnbmUTkI/htAb8a12
         Ifu23MXhPsdcVkMDBIsPU+qQ9S+Q4Jpv6kMm/XaDVXRGYu8zUic6J00UVW2Pl3Jg4ipo
         yIq3c85jcQ8Hh/47QNOWbDJUU5MDYC4+uv6DXumzGVl81TASWQwr0tKpuM1+eQWL623m
         3T30TYWxuDS17U7oa6JzoJU1J6uTjXm+kjwTJIHZ+noSaYa2Id29I9fr/0qajptRRUnQ
         s7G09ezo58vgDTWyWPijnSXAzeQglpdd+h9y7B7IXIVTvBjMQAOaOc3BesFfC3VHV0z3
         /i/w==
X-Gm-Message-State: ABy/qLaSlvXoPgQc5y+fFos9QMbw58wyBqBh68OGodmeYvPpHl//qGVS
        WKM0GtGf5vlNU5r3EO05onCNZcjtkHQGoVzG
X-Google-Smtp-Source: APBJJlE/4eNNfsZVn52CpzYFsnPg3MEaCSZARbclxeBoCbAGsVo4UQcWB//p1/8hFyW5SH+1BkZHJg==
X-Received: by 2002:a17:90a:4313:b0:263:7d57:814e with SMTP id q19-20020a17090a431300b002637d57814emr9741815pjg.45.1690302053003;
        Tue, 25 Jul 2023 09:20:53 -0700 (PDT)
Received: from manas-VirtualBox.iitr.ac.in ([103.37.201.175])
        by smtp.gmail.com with ESMTPSA id c24-20020a17090ab29800b00267ae12b80bsm9858709pjr.34.2023.07.25.09.20.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 09:20:52 -0700 (PDT)
From:   Manas Ghandat <ghandatmanas@gmail.com>
To:     salah.triki@gmail.com, luisbg@kernel.org
Cc:     Manas Ghandat <ghandatmanas@gmail.com>,
        linux-kernel@vger.kernel.org, shuah@kernel.org,
        ivan.orlov0322@gmail.com
Subject: [PATCH] fs : fix shift-out-of-bounds in befs_check_sb
Date:   Tue, 25 Jul 2023 21:50:44 +0530
Message-Id: <20230725162044.103874-1-ghandatmanas@gmail.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The consistency check for the block_size by using the block_shift caused
integer overflow. Thus a max limit to the block_shift was defined named
BEFS_MAX_BLOCK_SHIFT in befs.h. Also check for the block_shift was added
so that overflow does not occur.

Signed-off-by: Manas Ghandat <ghandatmanas@gmail.com>
---
 fs/befs/befs.h  |  4 ++--
 fs/befs/super.c | 11 +++++++++++
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/fs/befs/befs.h b/fs/befs/befs.h
index 7cd47245694d..5490024adb33 100644
--- a/fs/befs/befs.h
+++ b/fs/befs/befs.h
@@ -13,7 +13,7 @@
 
 /* used in debug.c */
 #define BEFS_VERSION "0.9.3"
-
+#define BEFS_MAX_BLOCK_SHIFT 31
 
 typedef u64 befs_blocknr_t;
 /*
@@ -133,7 +133,7 @@ blockno2iaddr(struct super_block *sb, befs_blocknr_t blockno)
 
 	iaddr.allocation_group = blockno >> BEFS_SB(sb)->ag_shift;
 	iaddr.start =
-	    blockno - (iaddr.allocation_group << BEFS_SB(sb)->ag_shift);
+		blockno - (iaddr.allocation_group << BEFS_SB(sb)->ag_shift);
 	iaddr.len = 1;
 
 	return iaddr;
diff --git a/fs/befs/super.c b/fs/befs/super.c
index 7c50025c99d8..f2aeb2ed6e77 100644
--- a/fs/befs/super.c
+++ b/fs/befs/super.c
@@ -88,6 +88,17 @@ befs_check_sb(struct super_block *sb)
 		return BEFS_ERR;
 	}
 
+	/*
+	 * block_shift check added so that overflow does not
+	 * occur during the block_size check
+	 */
+
+	if (befs_sb->block_shift > BEFS_MAX_BLOCK_SHIFT) {
+		befs_error(sb, "block_size too large. "
+			   "Corruption likely.");
+		return BEFS_ERR;
+	}
+
 	/*
 	 * block_shift and block_size encode the same information
 	 * in different ways as a consistency check.
-- 
2.37.2

