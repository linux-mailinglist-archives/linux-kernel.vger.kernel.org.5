Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C1DB78857E
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 13:19:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240738AbjHYLTa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 07:19:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243103AbjHYLTR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 07:19:17 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DB8ECD1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 04:18:51 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-313e742a787so539724f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 04:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1692962330; x=1693567130;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LjF+zN6TJ1BvEvRrI5C4CD8rIkkkthqR+fjsUt4Q8CQ=;
        b=arFqt1RTyp2yJ+qBHYnjbmsTvf9yikTfxTS2ZNvYs2M11Hlpj8DhIjlISwrDnL6HJG
         WEAKtjAc0kFEN8lxFwik4/1OUesCxPtqjE8+g0XBxBCrsd8wW2t+0KR83Ei7FuHlf3+N
         q44ZOVmcpl/SM5UrImy/4Zwyb3S4VKAI9MvDv5kHG3Wl49UpTUbepRZ8KnvEAvA+tbHw
         6iuQYc0p0a1s7nX0im3kgSKFNlKt2Dpu3gp59UyVHEqsh7BFth7+gIqsiHpq9VZvb1ar
         YrKNpyAQzfy61sEIwUFBts1gdBuOR47DT+cM+daulfr4gUp3ttCceUtshX1CRUx3IgGV
         vfdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692962330; x=1693567130;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LjF+zN6TJ1BvEvRrI5C4CD8rIkkkthqR+fjsUt4Q8CQ=;
        b=ccaO52qo2et0l9gdUGhbK8pRqoaKnlOACzCVfNZsyG1H6VtiKaTKQfx2z4oo3gNU2t
         GR2yhKkYM9h3q4HLPHp3SJYT/b+leu/rHFm46coSEFoFtdRLIFq3GIN/PMdt0sme2WvD
         QqnsyXopcg+YLgQ4+5/2dO0YfwlISbovgdZYLmYiwr+nSXg2wboh8Zooxqf13k5eeWNM
         B+nO7lP4Q1angZCswlUGQClXQZxF9TbNT8Y6B7BSzya3sORDTxuR3YuzkhgeO6j72OSD
         dMnK2XRuKC3eKn0d0wFCMdYK57pb4gxQfvWIxGpbVvB0dSrTgf+6P9xNJY1zI50t+bIe
         MSxw==
X-Gm-Message-State: AOJu0Yyc74IWac8aAB/+w+O0E0SstmErwxtfGdPvWmtSVXyRMJQ6+1Rt
        0YOkLmf6afOkvy8LoE3aaRDHrA==
X-Google-Smtp-Source: AGHT+IFlq4uXcqCHuwCivQQQkMphZFErOKTGJdelk1WSHrPd5grjavTs+RZd4i9P7/+NjTNfRJorLw==
X-Received: by 2002:a5d:510f:0:b0:313:df09:acfb with SMTP id s15-20020a5d510f000000b00313df09acfbmr16500274wrt.11.1692962330072;
        Fri, 25 Aug 2023 04:18:50 -0700 (PDT)
Received: from localhost.localdomain ([2a02:6b6a:b5c7:0:9000:8d13:d0bb:ba7d])
        by smtp.gmail.com with ESMTPSA id g9-20020a056000118900b0031ad5fb5a0fsm1939502wrx.58.2023.08.25.04.18.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 04:18:49 -0700 (PDT)
From:   Usama Arif <usama.arif@bytedance.com>
To:     linux-mm@kvack.org, muchun.song@linux.dev, mike.kravetz@oracle.com,
        rppt@kernel.org
Cc:     linux-kernel@vger.kernel.org, songmuchun@bytedance.com,
        fam.zheng@bytedance.com, liangma@liangbit.com,
        punit.agrawal@bytedance.com, Usama Arif <usama.arif@bytedance.com>
Subject: [v3 2/4] memblock: pass memblock_type to memblock_setclr_flag
Date:   Fri, 25 Aug 2023 12:18:34 +0100
Message-Id: <20230825111836.1715308-3-usama.arif@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230825111836.1715308-1-usama.arif@bytedance.com>
References: <20230825111836.1715308-1-usama.arif@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This allows setting flags to both memblock types and is in preparation for
setting flags (for e.g. to not initialize struct pages) on reserved
memory region.

Signed-off-by: Usama Arif <usama.arif@bytedance.com>
---
 mm/memblock.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/mm/memblock.c b/mm/memblock.c
index f9e61e565a53..43cb4404d94c 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -896,10 +896,9 @@ int __init_memblock memblock_physmem_add(phys_addr_t base, phys_addr_t size)
  *
  * Return: 0 on success, -errno on failure.
  */
-static int __init_memblock memblock_setclr_flag(phys_addr_t base,
-				phys_addr_t size, int set, int flag)
+static int __init_memblock memblock_setclr_flag(struct memblock_type *type,
+				phys_addr_t base, phys_addr_t size, int set, int flag)
 {
-	struct memblock_type *type = &memblock.memory;
 	int i, ret, start_rgn, end_rgn;
 
 	ret = memblock_isolate_range(type, base, size, &start_rgn, &end_rgn);
@@ -928,7 +927,7 @@ static int __init_memblock memblock_setclr_flag(phys_addr_t base,
  */
 int __init_memblock memblock_mark_hotplug(phys_addr_t base, phys_addr_t size)
 {
-	return memblock_setclr_flag(base, size, 1, MEMBLOCK_HOTPLUG);
+	return memblock_setclr_flag(&memblock.memory, base, size, 1, MEMBLOCK_HOTPLUG);
 }
 
 /**
@@ -940,7 +939,7 @@ int __init_memblock memblock_mark_hotplug(phys_addr_t base, phys_addr_t size)
  */
 int __init_memblock memblock_clear_hotplug(phys_addr_t base, phys_addr_t size)
 {
-	return memblock_setclr_flag(base, size, 0, MEMBLOCK_HOTPLUG);
+	return memblock_setclr_flag(&memblock.memory, base, size, 0, MEMBLOCK_HOTPLUG);
 }
 
 /**
@@ -957,7 +956,7 @@ int __init_memblock memblock_mark_mirror(phys_addr_t base, phys_addr_t size)
 
 	system_has_some_mirror = true;
 
-	return memblock_setclr_flag(base, size, 1, MEMBLOCK_MIRROR);
+	return memblock_setclr_flag(&memblock.memory, base, size, 1, MEMBLOCK_MIRROR);
 }
 
 /**
@@ -977,7 +976,7 @@ int __init_memblock memblock_mark_mirror(phys_addr_t base, phys_addr_t size)
  */
 int __init_memblock memblock_mark_nomap(phys_addr_t base, phys_addr_t size)
 {
-	return memblock_setclr_flag(base, size, 1, MEMBLOCK_NOMAP);
+	return memblock_setclr_flag(&memblock.memory, base, size, 1, MEMBLOCK_NOMAP);
 }
 
 /**
@@ -989,7 +988,7 @@ int __init_memblock memblock_mark_nomap(phys_addr_t base, phys_addr_t size)
  */
 int __init_memblock memblock_clear_nomap(phys_addr_t base, phys_addr_t size)
 {
-	return memblock_setclr_flag(base, size, 0, MEMBLOCK_NOMAP);
+	return memblock_setclr_flag(&memblock.memory, base, size, 0, MEMBLOCK_NOMAP);
 }
 
 static bool should_skip_region(struct memblock_type *type,
-- 
2.25.1

