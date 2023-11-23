Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52AF17F58C1
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 07:59:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344852AbjKWG7J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 01:59:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233005AbjKWG6m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 01:58:42 -0500
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89E8D173A
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 22:58:15 -0800 (PST)
Received: by mail-oi1-x22b.google.com with SMTP id 5614622812f47-3b2f4a5ccebso397698b6e.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 22:58:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1700722695; x=1701327495; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xy98WgGNwj9rOwWzhsI6VzEfMnk+JFUolM0E3kCQh54=;
        b=MB/rSC/3YZADVKTafFmvFV3jrY93Z0k8QNx3OSQcfLT/4ksxpUwtrwR3SmnG8TPxYx
         fq/ayY6XLaToLZ7QVLJoqphbgRrgYVtjqHEA7j2kvLBi+2OwhIt7fK3kUnBGv4z36PYb
         RTj2fTGlHpY/hExfVb3KJOhTIZS9Kxb8mqa+Ow7NKwov2UHX8M/6FCjZmI4k4yIdmHsP
         E38IHohxg3UvBdQoP78c8wiNIltyvITUyh8euXvqbxNzEU6G7ZK5F665jEK9VYgb5z33
         XtnAKDtuKujnojVMEaV+YSsmiN2gbRiiNpFV4EXAHcXeuSS8nNVw7cFY0R9Aa9+QkLV8
         1ekQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700722695; x=1701327495;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xy98WgGNwj9rOwWzhsI6VzEfMnk+JFUolM0E3kCQh54=;
        b=EW8C7hTHuHb/XJLbGkliqKV5aVZFSfyp68KrSx6rEoYMY1rZy/3OjnLrgF78ebaQ8K
         DFMUtaf1S/erYqWb/198Iaz4S7xGpvd9Oj/1G/aBzwf5poOF2ca9pIks+s8lQVA2hVeK
         Y3/0vd/iembImm5JJ34t7ctxYdTxp/O6SeSWv/RNtUFY/KPgKKyDS3Pjtr47a8rCjBid
         rmjFsKtAOV2SlftZMsWfBy6eG25YVtUw6+dlm5dhjlSJGFUzACokD/8EZGXhfWRuYE5g
         rFWvCPhyCuB1Uymz9MG2KSgZi1Zrxt1Vmv/r6G0BpwKYLuUxsjpRjYXW6xoLJE6wJHlG
         kEcA==
X-Gm-Message-State: AOJu0Yw5+79+K70raMuyMfkVBBncbC/gWbpgbSJIVQoXtO2fmiuHNn3S
        evxJ/iHscl/yaNJxHncK8jCJNg==
X-Google-Smtp-Source: AGHT+IEh9UjPGyaaQjuaIBLcYWiSd7ay7EOeP118dTtKlJ+CAM34oaGt+k986nYAGOfCpnNSdObjog==
X-Received: by 2002:a05:6808:ab8:b0:3b2:f557:666e with SMTP id r24-20020a0568080ab800b003b2f557666emr5093225oij.19.1700722694829;
        Wed, 22 Nov 2023 22:58:14 -0800 (PST)
Received: from J9GPGXL7NT.bytedance.net ([139.177.225.230])
        by smtp.gmail.com with ESMTPSA id w37-20020a634765000000b005bd2b3a03eesm615437pgk.6.2023.11.22.22.58.09
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 22 Nov 2023 22:58:14 -0800 (PST)
From:   Xu Lu <luxu.kernel@bytedance.com>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, ardb@kernel.org, anup@brainfault.org,
        atishp@atishpatra.org
Cc:     dengliang.1214@bytedance.com, xieyongji@bytedance.com,
        lihangjing@bytedance.com, songmuchun@bytedance.com,
        punit.agrawal@bytedance.com, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, Xu Lu <luxu.kernel@bytedance.com>
Subject: [RFC PATCH V1 09/11] riscv: Adjust fix_btmap slots number to match variable page size
Date:   Thu, 23 Nov 2023 14:57:06 +0800
Message-Id: <20231123065708.91345-10-luxu.kernel@bytedance.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <20231123065708.91345-1-luxu.kernel@bytedance.com>
References: <20231123065708.91345-1-luxu.kernel@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The existing fixmap slot number will cause the fixmap size to exceed
FIX_FDT_SIZE when base page becomes larger than 4K. This patch adjusts
the slot number to make them always match.

Signed-off-by: Xu Lu <luxu.kernel@bytedance.com>
---
 arch/riscv/include/asm/fixmap.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/include/asm/fixmap.h b/arch/riscv/include/asm/fixmap.h
index 0a55099bb734..17bf31334bd5 100644
--- a/arch/riscv/include/asm/fixmap.h
+++ b/arch/riscv/include/asm/fixmap.h
@@ -44,7 +44,8 @@ enum fixed_addresses {
 	 * before ioremap() is functional.
 	 */
 #define NR_FIX_BTMAPS		(SZ_256K / PAGE_SIZE)
-#define FIX_BTMAPS_SLOTS	7
+#define FIX_BTMAPS_SIZE		(FIXADDR_SIZE - ((FIX_BTMAP_END + 1) << PAGE_SHIFT))
+#define FIX_BTMAPS_SLOTS	(FIX_BTMAPS_SIZE / SZ_256K)
 #define TOTAL_FIX_BTMAPS	(NR_FIX_BTMAPS * FIX_BTMAPS_SLOTS)
 
 	FIX_BTMAP_END = __end_of_permanent_fixed_addresses,
-- 
2.20.1

