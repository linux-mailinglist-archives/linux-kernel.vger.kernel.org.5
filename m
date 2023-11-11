Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B03C7E8A75
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Nov 2023 12:05:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230430AbjKKLE1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Nov 2023 06:04:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230441AbjKKLEZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Nov 2023 06:04:25 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4613C3C07
        for <linux-kernel@vger.kernel.org>; Sat, 11 Nov 2023 03:04:22 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-32d895584f1so1713164f8f.1
        for <linux-kernel@vger.kernel.org>; Sat, 11 Nov 2023 03:04:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699700660; x=1700305460; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8r0FmZTR6STnmbPAV9YPLA4Axw4SVrkLLNyDLZCWi9E=;
        b=eQbYxesk6UPqGUrrBQAcCOJRzdJQ852/i9kYqbmvtD2UKX/wKT2ZF+o99YS7rDxvdj
         R2sNKeEfJm8RUb35KrXWZBEVAM0ZPJqLOEQkw98UraCq49cVSMpAcrc+V8aRClHqu8yQ
         pwn6uKO8wkvFFGltmNdNJohkHWoKITlZOGbmPdM2Eu6w+VUDWyDkqArHADEgQmLI+hVi
         UJA+ET+8bSk+fciGqcV9aTlGg7BuWi0OxKkEYl42T5BJmRXq6h/W7Ze2HILQIRQBwB15
         mmQPYuXo9e0NY+m+dtURn34hPVoSBLym6bHhyIE87Xu18lK4WoaGbeXznyBgAoVDXHgn
         SIVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699700660; x=1700305460;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8r0FmZTR6STnmbPAV9YPLA4Axw4SVrkLLNyDLZCWi9E=;
        b=ZxTP0uTtDekcNp1WQJnDOsib7vh0Pgt4GpQD5PEG++MzOD3ZBLPz0CSA3KyS5f/9Gz
         IiN2CT6BxnIbrqFHVUFIMhEeBm3vY/uCM4E43tWFYFlrqpBXmz4Of0UBBbQcL915l1Ts
         xe4uYI8u0Hv8ZtOm7Er4zJjIv73z6NHY578uv15ow3K5Qd++BsRnf+STGv8FJiQlKcdT
         8DiNXC2UTY277+a/0iK8utgzI1QR/EuI6cKLrnlRWZQUAN+CgQyUJOuuO5rEBSa4ZOvV
         1LxjGGYZFumY+KqrkaCxWyWmlAgr5Rax3l2lyEKowZOTIU/9vINFgEu5puXlUbnHBi41
         ZYtA==
X-Gm-Message-State: AOJu0Ywk+4PIVbLkX/EuvYJ3D6maGvbuy5gMJZ175qarzI4kcP9exCtF
        CG8qzOtNmR9Kx4+RxWtO3h4=
X-Google-Smtp-Source: AGHT+IFGGh2/+JeObHNUzTNlG2D+WWzZRL26L+sR+3Bg51BU7nIBEbjruszGooz2Mxdqo1sw2tdZqg==
X-Received: by 2002:a05:6000:154d:b0:32d:8f4c:a70b with SMTP id 13-20020a056000154d00b0032d8f4ca70bmr1571057wry.9.1699700660330;
        Sat, 11 Nov 2023 03:04:20 -0800 (PST)
Received: from localhost.localdomain (host86-136-214-82.range86-136.btcentralplus.com. [86.136.214.82])
        by smtp.gmail.com with ESMTPSA id d1-20020a5d6441000000b0032f7f4d008dsm1256652wrw.20.2023.11.11.03.04.19
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 11 Nov 2023 03:04:19 -0800 (PST)
From:   Levi Yun <ppbuk5246@gmail.com>
To:     Liam.Howlett@oracle.com
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Levi Yun <ppbuk5246@gmail.com>
Subject: [PATCH] maple_tree: remove mast_overflow.
Date:   Sat, 11 Nov 2023 11:04:17 +0000
Message-ID: <20231111110417.38655-1-ppbuk5246@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mast_overflow is used only in mas_spanning_rebalance.
But when mast_sufficient is false, mast_overflow always returns false,
and when mast_suffictent is true, it never reaches to mast_overflow in
mas_spanning_rebalance.

Therefore, mast_overflow is dead code in mas_spanning_rebalance.
And there is no other usage of mast_overflow execpt
mas_spanning_rebalance, Remove mast_overflow.

Signed-off-by: Levi Yun <ppbuk5246@gmail.com>
---
 lib/maple_tree.c | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index bb24d84a4922..1e591e71621e 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -2767,19 +2767,6 @@ static inline bool mast_sufficient(struct maple_subtree_state *mast)
 	return false;
 }
 
-/*
- * mast_overflow: Check if there is too much data in the subtree state for a
- * single node.
- * @mast: The maple subtree state
- */
-static inline bool mast_overflow(struct maple_subtree_state *mast)
-{
-	if (mast->bn->b_end >= mt_slot_count(mast->orig_l->node))
-		return true;
-
-	return false;
-}
-
 static inline void *mtree_range_walk(struct ma_state *mas)
 {
 	unsigned long *pivots;
@@ -2934,9 +2921,6 @@ static int mas_spanning_rebalance(struct ma_state *mas,
 		if (mast_sufficient(mast))
 			continue;
 
-		if (mast_overflow(mast))
-			continue;
-
 		/* May be a new root stored in mast->bn */
 		if (mas_is_root_limits(mast->orig_l))
 			break;
-- 
2.41.0

