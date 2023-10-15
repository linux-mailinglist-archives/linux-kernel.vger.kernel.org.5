Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A725D7C9B79
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Oct 2023 22:27:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230394AbjJOU1A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Oct 2023 16:27:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229990AbjJOU07 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Oct 2023 16:26:59 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 955CCC1
        for <linux-kernel@vger.kernel.org>; Sun, 15 Oct 2023 13:26:57 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-32db8f8441eso24292f8f.0
        for <linux-kernel@vger.kernel.org>; Sun, 15 Oct 2023 13:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697401616; x=1698006416; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9mJQUt7Wf0+dPq/8JTeI94cIlxhXMv5ZBTCjETmdTqU=;
        b=fP8Sj+Zmgowryvn3edaUpvRhj5ctaNKQFZeTysSjAZKduvzY/o+aQ6Jj0kMakxC0kT
         RMVBkwehKFD4d0cEdjDRQAYqJtlnU5aWr/vk9kKeFJRkxWSy4N+r0y5ytkuRzNaSycFr
         /mBzW5GQtaGoEkrRFVgr/yV1fAwQFYPWWrTyc7aVln2QIz+/I2vBCyvmHeUvqWWm+oud
         pGeh4ROzyk0Np/O5cjxAkt6ZA3vAHbkHefCvL0XVO8gN+9ym9Jl58nmyFMGPWD5X3O/u
         XRE18d0uTbEfvk5fMm77esD/uH00Ui1qigGEGvUwqNCfqJy//Gy1V5CHqy6hlnowNL3D
         Mr1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697401616; x=1698006416;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9mJQUt7Wf0+dPq/8JTeI94cIlxhXMv5ZBTCjETmdTqU=;
        b=jCWCaR1QEN4VxxYebUF9l0K5d3ow4tDIcYV/+vCi3hG4QELmUL2y3SD31pEnHoSXA9
         pnlVAsl6Xli7+etOTyvZtS2aUwEl3DggHOs2eUiFLCv+Cjh3l4exb4nYDlF7IriR70Gq
         6kPbEWf6A/rj2rKVT48YkDc663R5rClXEGvSoq+p/Ixq087dlF78yXbZp6zvXI3pDKQY
         NqvePKkn1/7lzyOB1Fgqo0rRhlBEnKYJt0MlUEVXCysvFJn4XykeS4gTL241rnV5UuAH
         hMt7b2Si7IVrQHWEAVlAOinzXDseMyAiKn7M8uobwOLCZdEXM7jreeUI+aWg8B7kZXH8
         zQ6A==
X-Gm-Message-State: AOJu0YyxZznIPSOeO2TCMLee6m8JkSkzkQObWBUTHy7p5UvlOI7Pneak
        oxGaQADkIEgcRGYYG+6seDE=
X-Google-Smtp-Source: AGHT+IE39XZwC0ne09DLeEYAEDmDf3xkSkL6BIj3dVUMU1+rWVkbO5e5YJUqWsPJnfwvd93Lb7r9Yg==
X-Received: by 2002:a05:6000:1189:b0:321:6936:c217 with SMTP id g9-20020a056000118900b003216936c217mr26180665wrx.14.1697401615768;
        Sun, 15 Oct 2023 13:26:55 -0700 (PDT)
Received: from PC-PEDRO-ARCH.lan ([2001:8a0:7280:5801:9441:3dce:686c:bfc7])
        by smtp.gmail.com with ESMTPSA id u1-20020adfa181000000b0032da49e18fasm4303429wru.23.2023.10.15.13.26.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Oct 2023 13:26:55 -0700 (PDT)
From:   Pedro Falcato <pedro.falcato@gmail.com>
To:     kasan-dev@googlegroups.com, Alexander Potapenko <glider@google.com>
Cc:     Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Pedro Falcato <pedro.falcato@gmail.com>
Subject: [PATCH] mm: kmsan: Panic on failure to allocate early boot metadata
Date:   Sun, 15 Oct 2023 21:26:50 +0100
Message-ID: <20231015202650.85777-1-pedro.falcato@gmail.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Given large enough allocations and a machine with low enough memory (i.e
a default QEMU VM), it's entirely possible that
kmsan_init_alloc_meta_for_range's shadow+origin allocation fails.

Instead of eating a NULL deref kernel oops, check explicitly for memblock_alloc()
failure and panic with a nice error message.

Signed-off-by: Pedro Falcato <pedro.falcato@gmail.com>
---
 mm/kmsan/shadow.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/mm/kmsan/shadow.c b/mm/kmsan/shadow.c
index 87318f9170f..3dae3d9c0b3 100644
--- a/mm/kmsan/shadow.c
+++ b/mm/kmsan/shadow.c
@@ -285,12 +285,18 @@ void __init kmsan_init_alloc_meta_for_range(void *start, void *end)
 	size = PAGE_ALIGN((u64)end - (u64)start);
 	shadow = memblock_alloc(size, PAGE_SIZE);
 	origin = memblock_alloc(size, PAGE_SIZE);
+
+	if (!shadow || !origin)
+		panic("%s: Failed to allocate metadata memory for early boot range "
+		      "of size %llu",
+		      __func__, size);
+
 	for (u64 addr = 0; addr < size; addr += PAGE_SIZE) {
 		page = virt_to_page_or_null((char *)start + addr);
-		shadow_p = virt_to_page_or_null((char *)shadow + addr);
+		shadow_p = virt_to_page((char *)shadow + addr);
 		set_no_shadow_origin_page(shadow_p);
 		shadow_page_for(page) = shadow_p;
-		origin_p = virt_to_page_or_null((char *)origin + addr);
+		origin_p = virt_to_page((char *)origin + addr);
 		set_no_shadow_origin_page(origin_p);
 		origin_page_for(page) = origin_p;
 	}
-- 
2.42.0

