Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 253B3768627
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jul 2023 17:16:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbjG3PQR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 11:16:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbjG3PQO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 11:16:14 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C5F3138
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 08:16:13 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3fba8e2aa52so42188475e9.1
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 08:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1690730172; x=1691334972;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LjF+zN6TJ1BvEvRrI5C4CD8rIkkkthqR+fjsUt4Q8CQ=;
        b=Vg/2oAVG+oc700uPemJAECQqoZhvkHC4+v5G5umPPiGRagPclA/x9n9QgA5SDk8rdg
         xAP9ReHyrkmHzKD+QCBzbqzaesJvP/4YCVXhkUBDq7oFIh6fXXlQ/W6sesudYok3JgtG
         i8bNtt0JeBjQ7J+lYkbC40TeksYu8cuU6k1rZccXxVLpTekSilTdDcASxORLzoJggl+u
         dRvUz2KpmJ9ZuYWecFzFZAf1jF7ZS6Fe1gbbhfyhcMe2hud5pyNq2/bry4VpryWWF7x9
         5XjSiGdDOVXVOjoB9TsdMcNi/ewnPLEIYUwh7l9m4DJjOtr0WmlRT+SiTcjbgC7BRS1N
         Zt9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690730172; x=1691334972;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LjF+zN6TJ1BvEvRrI5C4CD8rIkkkthqR+fjsUt4Q8CQ=;
        b=a1u51rrFCKwhbysKj25kUQzqMgF1p+lTpRpo/E+2EreLrDNo4by/xnIEI71kLJDM3Y
         ekrAw3Y4BhzlFyyO2/YUfqmAO7PvAaPBGDOND+z51YTcYjV3S4VOvZhbBMd4Hfi7Mmi8
         pwKbeC83i6YGYdDi8a+YcBeMib+H+K74fSlhm49KUQP3qSKDDdvMAhD7B5JMpnWHRz11
         U5XPINj2A6CYAKtH9w1Bl4wubqJkwkByee6aHMJB4iXV3hwymBnDKUahszwKcodfj6pJ
         VIRcNPdHm3X/UTYLZr/BiuT36shaDodImA03BjZQ7LkGFvKhbKhoPCPT3NNCkoDQDFq5
         ad0Q==
X-Gm-Message-State: ABy/qLbOPXSMQ2MAtfcqdkcpBphnzHeod0VAc3dEUiKiLtLkiZ3IdohO
        WzQD8C88niBY4LOJAImguKcpGg==
X-Google-Smtp-Source: APBJJlEBTcG9vQb7sO+eVhsdznDus6PkQqwHLouS3PQ0kKj5rr+MyIEAIBdbHeu9lJsdSY/4wUqiMA==
X-Received: by 2002:a7b:c450:0:b0:3fb:c990:3b2 with SMTP id l16-20020a7bc450000000b003fbc99003b2mr5960153wmi.34.1690730172214;
        Sun, 30 Jul 2023 08:16:12 -0700 (PDT)
Received: from localhost.localdomain ([2a02:6b6a:b465:0:eda5:aa63:ce24:dac2])
        by smtp.gmail.com with ESMTPSA id f17-20020a7bcc11000000b003fd2d33ea53sm9123027wmh.14.2023.07.30.08.16.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jul 2023 08:16:11 -0700 (PDT)
From:   Usama Arif <usama.arif@bytedance.com>
To:     linux-mm@kvack.org, muchun.song@linux.dev, mike.kravetz@oracle.com,
        rppt@kernel.org
Cc:     linux-kernel@vger.kernel.org, fam.zheng@bytedance.com,
        liangma@liangbit.com, simon.evans@bytedance.com,
        punit.agrawal@bytedance.com, Usama Arif <usama.arif@bytedance.com>
Subject: [v2 3/6] memblock: pass memblock_type to memblock_setclr_flag
Date:   Sun, 30 Jul 2023 16:16:03 +0100
Message-Id: <20230730151606.2871391-4-usama.arif@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230730151606.2871391-1-usama.arif@bytedance.com>
References: <20230730151606.2871391-1-usama.arif@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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

