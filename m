Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C779F7BA9D9
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 21:15:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230117AbjJETPZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 15:15:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbjJETPY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 15:15:24 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3868D9;
        Thu,  5 Oct 2023 12:15:21 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-40572aeb673so12896585e9.0;
        Thu, 05 Oct 2023 12:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696533320; x=1697138120; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aT0LmIsvnpX1kglnb6ckTRuS7J+F7V3HjLnCaWyOAWA=;
        b=ddCiNOuF1B43oVIe0WuZA5qVAS5WvLJQqsyxHnwtMgP/l609NMZ0/H3G8+0e3j7IVv
         SienX65ftG31St1G2ymNpX7R1I0iaWRG0jmQJdcCtw/VB3kCCT02yUxv1Rimc0Lg1QAd
         ZKXoU9xF/Z9RNd+Leaiu/TEdlkW6EQm8WBSfR6q3cM5qpVD9r/m5skjmZUcLcBxHTt9C
         JYZ/6CYM76c6GJDg0URUFXlkTRrLY0ZSguK+jp6Ftg2tTYTCFUs2W2aUowyBc5McDLVd
         s664/d+XSARr89z7dKEviogx7XmSEXMMdcY4J1gfZLVEWiixPIvysENXpge3fECb9L4V
         r92Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696533320; x=1697138120;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aT0LmIsvnpX1kglnb6ckTRuS7J+F7V3HjLnCaWyOAWA=;
        b=meG2qotec99EKNu0f9lzn2eaMLIZ4nsUEs6USSxWTF97S16fTJR8RMaP6TzdMbSKCd
         /gZvNqX7W90O7vaVxLzYejxyLR0wN3vezeZQIHkHduKwvZ9IXs8y+dkuBQB5BPyByxmd
         cGh6OKHh968VlHzTkCVSH4bWNmziqQEfT90PmkUf4diRKM3aptE3NwUwibQxMrZvxGLB
         2ylBlQpfe+uuHGX2np2fojg4XzVuZglBXgjpgCgkvmbpeke3CHq79bl1i8CAtKHxjrXI
         TxAqSqcU6Wk7Ig9smfk5lnruAmKMfGHZBPetNKkXDVYwfVr+AKt/A3Nj/w9ZZwZPHn6o
         iC/g==
X-Gm-Message-State: AOJu0Yyyv06gTw6DmMTR50DZ9C/GhMlv47//lLkkCy6/OV/5nDf6DWpC
        EB/yq9PB1BqPyhsoU86Bwgc=
X-Google-Smtp-Source: AGHT+IEhZPgfkx8mQXQXOTrcuxb3QDkXOODotGOIc9va7MNCtseyZWgXnTuij5CEQYcIdxu+L4NXdw==
X-Received: by 2002:a1c:721a:0:b0:405:1baf:cedf with SMTP id n26-20020a1c721a000000b004051bafcedfmr5855968wmc.24.1696533319961;
        Thu, 05 Oct 2023 12:15:19 -0700 (PDT)
Received: from localhost.localdomain ([2001:818:e906:400:b2bc:40c:b83d:9c16])
        by smtp.gmail.com with ESMTPSA id 19-20020a05600c025300b00401d8181f8bsm4407235wmj.25.2023.10.05.12.15.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 12:15:19 -0700 (PDT)
From:   Ricardo Lopes <ricardoapl.dev@gmail.com>
To:     manishc@marvell.com, GR-Linux-NIC-Dev@marvell.com,
        coiby.xu@gmail.com, gregkh@linuxfoundation.org
Cc:     netdev@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH] staging: qlge: Replace strncpy with strscpy
Date:   Thu,  5 Oct 2023 20:14:55 +0100
Message-ID: <20231005191459.10698-1-ricardoapl.dev@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Avoid read overflows and other misbehavior due to missing termination.

Reported by checkpatch:

WARNING: Prefer strscpy, strscpy_pad, or __nonstring over strncpy

Signed-off-by: Ricardo Lopes <ricardoapl.dev@gmail.com>
---
 drivers/staging/qlge/qlge_dbg.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/qlge/qlge_dbg.c b/drivers/staging/qlge/qlge_dbg.c
index c7e865f51..5f08a8492 100644
--- a/drivers/staging/qlge/qlge_dbg.c
+++ b/drivers/staging/qlge/qlge_dbg.c
@@ -696,7 +696,7 @@ static void qlge_build_coredump_seg_header(struct mpi_coredump_segment_header *s
 	seg_hdr->cookie = MPI_COREDUMP_COOKIE;
 	seg_hdr->seg_num = seg_number;
 	seg_hdr->seg_size = seg_size;
-	strncpy(seg_hdr->description, desc, (sizeof(seg_hdr->description)) - 1);
+	strscpy(seg_hdr->description, desc, sizeof(seg_hdr->description));
 }
 
 /*
@@ -737,7 +737,7 @@ int qlge_core_dump(struct qlge_adapter *qdev, struct qlge_mpi_coredump *mpi_core
 		sizeof(struct mpi_coredump_global_header);
 	mpi_coredump->mpi_global_header.image_size =
 		sizeof(struct qlge_mpi_coredump);
-	strncpy(mpi_coredump->mpi_global_header.id_string, "MPI Coredump",
+	strscpy(mpi_coredump->mpi_global_header.id_string, "MPI Coredump",
 		sizeof(mpi_coredump->mpi_global_header.id_string));
 
 	/* Get generic NIC reg dump */
@@ -1225,7 +1225,7 @@ static void qlge_gen_reg_dump(struct qlge_adapter *qdev,
 		sizeof(struct mpi_coredump_global_header);
 	mpi_coredump->mpi_global_header.image_size =
 		sizeof(struct qlge_reg_dump);
-	strncpy(mpi_coredump->mpi_global_header.id_string, "MPI Coredump",
+	strscpy(mpi_coredump->mpi_global_header.id_string, "MPI Coredump",
 		sizeof(mpi_coredump->mpi_global_header.id_string));
 
 	/* segment 16 */
-- 
2.41.0

