Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6815A80CE32
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 15:20:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344293AbjLKOUe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 09:20:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344472AbjLKOUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 09:20:15 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88E5D19A7
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 06:19:34 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-40b5155e154so53159615e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 06:19:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1702304373; x=1702909173; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qOlCMJwBwYnq+sc4eyv2TB9LiWqmTIQQJ4G+eSTSNEs=;
        b=U4xF/Q2xaHy3Jmkhh6gctfRueXpaFEjwk+p7JvdBvTIwgEtmVYXqR8LwgSYOHBwLn2
         q6RIFJFKntZrnZyE9Kc5BD1IooCJm2PXkQdtJ4yUcsC5pI2dY92MBZQUZdkHw/gEypim
         ggN/Ie1T+OCvYGGCFNgg4R49oRSN6R/vN3gXB7w9KS4fuXcDjjshzKunyvu6xYDdhLkD
         ii3nQPwvkPKWGovSIcUP80r1ZcIerMlgyH75SBkWmvSiZuqSI03+20VVz2lC6QpHpRML
         3ZmZ4HGDjdC9B0LqjfNsJVWdaRGdTul1h/HJldgcZwt8g1FEWkGSm7WmSeTjtr/BRLTB
         3wKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702304373; x=1702909173;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qOlCMJwBwYnq+sc4eyv2TB9LiWqmTIQQJ4G+eSTSNEs=;
        b=i89d8SObZ6AreXsKtm6pMgnRURj8QzrzFY74XJubgbO7FBXP0Dxc84GntJHZtk7X+5
         5WrsPbR5dgpHaUhKkyfrClfr0/xxlTBVETIKVU9ebkr3w6Ifpmfq/QVCry60+1asdi+0
         S08/eq1aXOtDWzbDZwU7Bvk1C/3n5vzmkjZaRn1Au5GmIsJ6eetP+Bc+F3Q86e3FW+BZ
         quTrrrfNs8UJ4tQzPgmluhGiMY7Cntgaef0xhd7eOYGS7hyCzZNpnYHRP8wvqLJI8L84
         8cLcb4arIzKisBfhdX7jiADsIDpIov9+gyQObQ4ksxQWw+THaSb1R2eRQHeCropCp4Au
         3niQ==
X-Gm-Message-State: AOJu0YzpMZ8C/RCv9+D1GhldEZ25T0R9eiI593/YrKiJvi8B5YlrdLTE
        U/4BhbusEB0t7mehPneYlRDF2g==
X-Google-Smtp-Source: AGHT+IHNZuhUDSHQwqbqJR6bQF+DiZTNX+U7LebyL8QHidDrkYX/aM6pa1KWGCN0tezAhwkUCGFaWA==
X-Received: by 2002:a05:600c:1884:b0:40c:28dc:f26f with SMTP id x4-20020a05600c188400b0040c28dcf26fmr2263783wmp.36.1702304372926;
        Mon, 11 Dec 2023 06:19:32 -0800 (PST)
Received: from alex-rivos.ba.rivosinc.com (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id e17-20020a05600c4e5100b0040c34cb896asm11859176wmq.41.2023.12.11.06.19.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 06:19:32 -0800 (PST)
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     syzbot+afb726d49f84c8d95ee1@syzkaller.appspotmail.com
Subject: [PATCH -fixes] riscv: Fix wrong usage of lm_alias() when splitting a huge linear mapping
Date:   Mon, 11 Dec 2023 15:19:29 +0100
Message-Id: <20231211141929.74027-1-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

lm_alias() can only be used on kernel mappings since it explicitly uses
__pa_symbol(), so simply fix this by checking where the address belongs
to before.

Fixes: 311cd2f6e253 ("riscv: Fix set_memory_XX() and set_direct_map_XX() by splitting huge linear mappings")
Reported-by: syzbot+afb726d49f84c8d95ee1@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/linux-riscv/000000000000620dd0060c02c5e1@google.com/
Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 arch/riscv/mm/pageattr.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/mm/pageattr.c b/arch/riscv/mm/pageattr.c
index fc5fc4f785c4..f5f8aa1d38d6 100644
--- a/arch/riscv/mm/pageattr.c
+++ b/arch/riscv/mm/pageattr.c
@@ -304,9 +304,16 @@ static int __set_memory(unsigned long addr, int numpages, pgprot_t set_mask,
 			if (ret)
 				goto unlock;
 		}
-	} else if (is_kernel_mapping(start) || is_linear_mapping(start)) {
-		lm_start = (unsigned long)lm_alias(start);
-		lm_end = (unsigned long)lm_alias(end);
+	} else {
+		if (is_kernel_mapping(start)) {
+			lm_start = (unsigned long)lm_alias(start);
+			lm_end = (unsigned long)lm_alias(end);
+		} else if (is_linear_mapping(start)) {
+			lm_start = start;
+			lm_end = end;
+		} else {
+			goto unlock;
+		}
 
 		ret = split_linear_mapping(lm_start, lm_end);
 		if (ret)
-- 
2.39.2

