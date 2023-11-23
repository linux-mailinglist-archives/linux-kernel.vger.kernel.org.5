Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E833D7F58BA
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 07:58:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235265AbjKWG6G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 01:58:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233910AbjKWG5w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 01:57:52 -0500
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19721C1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 22:57:37 -0800 (PST)
Received: by mail-ot1-x32f.google.com with SMTP id 46e09a7af769-6cd1918afb2so354593a34.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 22:57:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1700722656; x=1701327456; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x1SlIwZQZIPlzGLzwkEo+aJE2Wdd8/z5GIv+0pytAfk=;
        b=EriVfF3GALqZWQpXcdzO5RGhDIp/1dj8zic4vod/3EWriJKS99Fv59zri3r68B4p+a
         Wwm+CEmYJXS6n6O9ibbYCIovzeEXaSxPELtzpUzxvpdgNOYgCyipwq/hCZgSdVwIvHrE
         EpswHvlGK3TKtJWfyXOPbbjf1sdmOOSBAJ1UVEFUs6HWpzUc4Ff0/eaCa92pAmdGC1ip
         vAF3XkiR7v/QiKTJ/2zHwGnjhxixTRnGpD4F+AQbZdYay9/b1so+HCs0wvMJgKjm0nUn
         5NfvHAYJEpxUcKZ6zgUHzd6Hw6L9I7DX1a4Lc6179Gsq4+W15qrH5x5zNPVQ1O5AVY00
         bFTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700722656; x=1701327456;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x1SlIwZQZIPlzGLzwkEo+aJE2Wdd8/z5GIv+0pytAfk=;
        b=YH9kmusGu8qgzNog0L2p5wwhv+6M9WR8CTxsQvnKMq5XkcOfPH+itRjzfDMJPpjg1U
         KS6bYkCN1XOcJlHdyn+ZsQJCaDRp+aeMXiIyjKoYN2zZoxfaU6tQOU9xT08z8c9Dk1uX
         qIpRxAgRwOSN2UfkNyTCrJE0hUbhqJ5lm5bJvQHWPZbJcPT42e3b3GAue58dDsXv9+8h
         Bl66ej6nbz+f8jdtZypcGVU1itrkA6EH44IDnGDBatuJk1h78nhH5edDK7Eztg8chGEj
         WaKZNvXxMG5LdqgNkLnzjvNBVvor+BEc26NtTlxtXBRfO9V5EgmqMtvTpvuMwEGPaXpN
         l73w==
X-Gm-Message-State: AOJu0YwHDwynhWikWgyeNK/NvwUxdAZxPH76rb/u737Lw4EKFRd9r31S
        F2sqUiqyvc/eCkkja5hTAjKE3w==
X-Google-Smtp-Source: AGHT+IEzA3h3BSIYMfAOV+OKk+4/Lh1uORa+ogLGTQQeOgfArkr2f4ATFwv21Gu8GGvcH6ELupclgg==
X-Received: by 2002:a9d:6481:0:b0:6d7:f02f:dcc3 with SMTP id g1-20020a9d6481000000b006d7f02fdcc3mr3690469otl.28.1700722656378;
        Wed, 22 Nov 2023 22:57:36 -0800 (PST)
Received: from J9GPGXL7NT.bytedance.net ([139.177.225.230])
        by smtp.gmail.com with ESMTPSA id w37-20020a634765000000b005bd2b3a03eesm615437pgk.6.2023.11.22.22.57.31
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 22 Nov 2023 22:57:35 -0800 (PST)
From:   Xu Lu <luxu.kernel@bytedance.com>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, ardb@kernel.org, anup@brainfault.org,
        atishp@atishpatra.org
Cc:     dengliang.1214@bytedance.com, xieyongji@bytedance.com,
        lihangjing@bytedance.com, songmuchun@bytedance.com,
        punit.agrawal@bytedance.com, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, Xu Lu <luxu.kernel@bytedance.com>
Subject: [RFC PATCH V1 02/11] riscv: Introduce concept of hardware base page
Date:   Thu, 23 Nov 2023 14:56:59 +0800
Message-Id: <20231123065708.91345-3-luxu.kernel@bytedance.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <20231123065708.91345-1-luxu.kernel@bytedance.com>
References: <20231123065708.91345-1-luxu.kernel@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The key idea to implement larger base page based on MMU that only
supports 4K page is to decouple the MMU page from the software page in
view of kernel mm. In contrary to software page, we denote the MMU page
as hardware page.

To decouple these two kinds of pages, we should manage, allocate and map
memory at a granularity of software page, which is exactly what existing
mm code does. The page table operations, however, should configure page
table entries at a granularity of hardware page, which is the
responsibility of arch code.

This commit introduces the concept of hardware base page for RISCV.

Signed-off-by: Xu Lu <luxu.kernel@bytedance.com>
---
 arch/riscv/Kconfig            | 8 ++++++++
 arch/riscv/include/asm/page.h | 6 +++++-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 95a2a06acc6a..105cbb3ca797 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -221,6 +221,14 @@ config PAGE_OFFSET
 	default 0x80000000 if !MMU
 	default 0xff60000000000000 if 64BIT
 
+config RISCV_HW_PAGE_SHIFT
+	int
+	default 12
+
+config RISCV_PAGE_SHIFT
+	int
+	default 12
+
 config KASAN_SHADOW_OFFSET
 	hex
 	depends on KASAN_GENERIC
diff --git a/arch/riscv/include/asm/page.h b/arch/riscv/include/asm/page.h
index 57e887bfa34c..a8c59d80683c 100644
--- a/arch/riscv/include/asm/page.h
+++ b/arch/riscv/include/asm/page.h
@@ -12,7 +12,11 @@
 #include <linux/pfn.h>
 #include <linux/const.h>
 
-#define PAGE_SHIFT	(12)
+#define HW_PAGE_SHIFT	CONFIG_RISCV_HW_PAGE_SHIFT
+#define HW_PAGE_SIZE	(_AC(1, UL) << HW_PAGE_SHIFT)
+#define HW_PAGE_MASK	(~(HW_PAGE_SIZE - 1))
+
+#define PAGE_SHIFT	CONFIG_RISCV_PAGE_SHIFT
 #define PAGE_SIZE	(_AC(1, UL) << PAGE_SHIFT)
 #define PAGE_MASK	(~(PAGE_SIZE - 1))
 
-- 
2.20.1

