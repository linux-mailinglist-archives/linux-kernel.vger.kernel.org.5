Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AC7479E55A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 12:54:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239796AbjIMKyP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 06:54:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239795AbjIMKyM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 06:54:12 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2AA819AF
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 03:54:08 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-401d80f4ef8so72280485e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 03:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1694602447; x=1695207247; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HvAW5HglNzFFKY02dQL2QCkQguw1CPVi9WQHfYQdWVQ=;
        b=h0VVpYdN84xbMdEtnN1XNkQlKJ+TXQ7/JBBGx9NAvKIGlqjSdcq1QNBIHPvEvmBHZj
         evJv4iPHL18OT7srF+imsAkmriRjANgq3jGiWZ88pA4i54BdI4LVz37hpNM+NoCuA7ax
         WoblLdI5f2mpw3cK4qk2tWqgUjT6k49yyX26ODA0O4SMnm/V0vUjxT+Rs9dNMfM/Sr3Q
         8GP8BM9rPqeu24zDBGwagsF1A6lRnRIN0+4NrnRM3Sur+43CWeQ4vz22EiqfPG6G7G9A
         VqCwqiVrQdxLc+kYyTcmi1ePyl9FwlNkwB38zyQjWSeZ5i49JkGAkRAjM7uYW7znQEnR
         IwDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694602447; x=1695207247;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HvAW5HglNzFFKY02dQL2QCkQguw1CPVi9WQHfYQdWVQ=;
        b=JYalv5cjFN5df9UpD0G7gc6BeErHwQhUkn64CxLNflMSCF/vYA2StuXKP3dWeHV987
         UHDi7k6H30/aa4YEkx8Ddj9ivn0+LCtKWYYB2H2MRy8oIRkHqieonJflc9xoNc8LwuYf
         3SuQp4BO6bXwgcc0eBv1SgNYgIYpvQVVU3jflCS8z/k5JUYXflpv1v5EmrzanVNdDt37
         DePVmFKIPgOLLSFGCwmt9ZfOqcIdU7bvkMr3xVRqI2QFmMEbBrTPP607aVzdqxi5g8xu
         VSgfXKvuqv+GqJO+brhvac9iH3fBvoQWC6dp84IVcfzE8cfX53DD5n37hFvf/1LKG7VQ
         ReWw==
X-Gm-Message-State: AOJu0YyU7nU1tG/BAnLAye27CsZ0V+65YOhICfe22bm93s4wDl/rnksL
        ELqOWnJLHTzsGKSVfAo9vC6T9g==
X-Google-Smtp-Source: AGHT+IHvbrYE5CU1LLfrzLv3Yh3xia4AXw13/BHJVfTjNw8q0gSbwaI8RZroEq0GxStSNj/tvBmGxA==
X-Received: by 2002:a05:600c:2196:b0:402:bcac:5773 with SMTP id e22-20020a05600c219600b00402bcac5773mr1720136wme.38.1694602447327;
        Wed, 13 Sep 2023 03:54:07 -0700 (PDT)
Received: from localhost.localdomain ([2a02:6b6a:b5c7:0:59d5:28b9:7f13:cd1b])
        by smtp.gmail.com with ESMTPSA id p36-20020a05600c1da400b003ff013a4fd9sm1757055wms.7.2023.09.13.03.54.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 03:54:06 -0700 (PDT)
From:   Usama Arif <usama.arif@bytedance.com>
To:     linux-mm@kvack.org, muchun.song@linux.dev, mike.kravetz@oracle.com,
        rppt@kernel.org
Cc:     linux-kernel@vger.kernel.org, songmuchun@bytedance.com,
        fam.zheng@bytedance.com, liangma@liangbit.com,
        punit.agrawal@bytedance.com, Usama Arif <usama.arif@bytedance.com>
Subject: [v5 2/4] memblock: pass memblock_type to memblock_setclr_flag
Date:   Wed, 13 Sep 2023 11:53:59 +0100
Message-Id: <20230913105401.519709-3-usama.arif@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230913105401.519709-1-usama.arif@bytedance.com>
References: <20230913105401.519709-1-usama.arif@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This allows setting flags to both memblock types and is in preparation for
setting flags (for e.g. to not initialize struct pages) on reserved
memory region.

Signed-off-by: Usama Arif <usama.arif@bytedance.com>
Reviewed-by: Muchun Song <songmuchun@bytedance.com>
Reviewed-by: Mike Rapoport (IBM) <rppt@kernel.org>
Acked-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 mm/memblock.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/mm/memblock.c b/mm/memblock.c
index 913b2520a9a0..a49efbaee7e0 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -901,10 +901,9 @@ int __init_memblock memblock_physmem_add(phys_addr_t base, phys_addr_t size)
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
@@ -933,7 +932,7 @@ static int __init_memblock memblock_setclr_flag(phys_addr_t base,
  */
 int __init_memblock memblock_mark_hotplug(phys_addr_t base, phys_addr_t size)
 {
-	return memblock_setclr_flag(base, size, 1, MEMBLOCK_HOTPLUG);
+	return memblock_setclr_flag(&memblock.memory, base, size, 1, MEMBLOCK_HOTPLUG);
 }
 
 /**
@@ -945,7 +944,7 @@ int __init_memblock memblock_mark_hotplug(phys_addr_t base, phys_addr_t size)
  */
 int __init_memblock memblock_clear_hotplug(phys_addr_t base, phys_addr_t size)
 {
-	return memblock_setclr_flag(base, size, 0, MEMBLOCK_HOTPLUG);
+	return memblock_setclr_flag(&memblock.memory, base, size, 0, MEMBLOCK_HOTPLUG);
 }
 
 /**
@@ -962,7 +961,7 @@ int __init_memblock memblock_mark_mirror(phys_addr_t base, phys_addr_t size)
 
 	system_has_some_mirror = true;
 
-	return memblock_setclr_flag(base, size, 1, MEMBLOCK_MIRROR);
+	return memblock_setclr_flag(&memblock.memory, base, size, 1, MEMBLOCK_MIRROR);
 }
 
 /**
@@ -982,7 +981,7 @@ int __init_memblock memblock_mark_mirror(phys_addr_t base, phys_addr_t size)
  */
 int __init_memblock memblock_mark_nomap(phys_addr_t base, phys_addr_t size)
 {
-	return memblock_setclr_flag(base, size, 1, MEMBLOCK_NOMAP);
+	return memblock_setclr_flag(&memblock.memory, base, size, 1, MEMBLOCK_NOMAP);
 }
 
 /**
@@ -994,7 +993,7 @@ int __init_memblock memblock_mark_nomap(phys_addr_t base, phys_addr_t size)
  */
 int __init_memblock memblock_clear_nomap(phys_addr_t base, phys_addr_t size)
 {
-	return memblock_setclr_flag(base, size, 0, MEMBLOCK_NOMAP);
+	return memblock_setclr_flag(&memblock.memory, base, size, 0, MEMBLOCK_NOMAP);
 }
 
 static bool should_skip_region(struct memblock_type *type,
-- 
2.25.1

