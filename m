Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 380277E0E88
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 10:16:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231480AbjKDJQr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Nov 2023 05:16:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjKDJQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Nov 2023 05:16:45 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2394D48
        for <linux-kernel@vger.kernel.org>; Sat,  4 Nov 2023 02:16:41 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1cc3c51f830so22539795ad.1
        for <linux-kernel@vger.kernel.org>; Sat, 04 Nov 2023 02:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1699089401; x=1699694201; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NnHn4ZqYSv6UF9nJWzupxlkq5TCbHngLtT+ZAjUP9Mk=;
        b=Q4/bGFeK6PryaX6xz0Umt5F6pdSwliT8DB/64Q2tnWd5rLp/QxHziczqlKUTgKcNUm
         UuZzoLV/vDvCqARluWIpE57H6YOeqa6Q4t/+qsZLkNVRvAJlsgRRyPcfGlb1XMAkp137
         qmXvPz2ns/+rII8VjusLg+cWGUj8FFrsaro1up07ivlfBofsQoxghAO4thhX3qRayPco
         HQz1REuIfvw8PJRPsUqPxRP5XUt7OMt9SmEOOnFF6DIVEG8KdDexIKQ1mKPsUSISF2lc
         3cPprdt7Kxv0B/NPAzMjvy9wqu8wtI3ZThTTW+1fMRMytDpvxj9a3Vh0ppFvPTgsYb14
         kaZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699089401; x=1699694201;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NnHn4ZqYSv6UF9nJWzupxlkq5TCbHngLtT+ZAjUP9Mk=;
        b=Mbh3IQTNBCHrw1LGNn0KRTnhkHZwjn3Wguvkc0FKuZN/1af4ShL+N3Y6B3XHMzcRQv
         nHNGeqmoKHgkZU8cH3ojq/McnlZkXXykFB/sESgNWyLpVailpQHvkljjHWLJFV+Qcx0A
         5tfK4V1N/M6kNatQzbxwUIkRTKWQVaxZufa1nP0cF3NgddaL1jqOQa2aAl9hJT0uLW+P
         WiDA4QDD/I8z0mT+6HTfwT1A8xx027bHB1hpqI9LZ+3gyxhfgv1dv1c2RcUsGDkMeiBW
         wEyMbCss1xFMMYoiQKgzKUf/zexT/hpGsUGPJAzg1NRkf1858J3MuT72U61kmrvmdv8F
         fffg==
X-Gm-Message-State: AOJu0Yw4ePaEZWMprajh5gtRwROaMMrdNkL/y95uIM4pi4zWmlR0r7L0
        oUxd72PDvDIW96t78VasNMUnQA==
X-Google-Smtp-Source: AGHT+IE936bciD6jxw/aPE7Ri4Nchb1ZjhcSOeC+o89C0cd9w4WgJ6Zblfg0CycLSJlNDrYYtwFiUA==
X-Received: by 2002:a17:902:d28b:b0:1cc:13d0:d515 with SMTP id t11-20020a170902d28b00b001cc13d0d515mr17598501plc.20.1699089401491;
        Sat, 04 Nov 2023 02:16:41 -0700 (PDT)
Received: from devz1.bytedance.net ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id d4-20020a170903230400b001cc54202429sm2585127plh.288.2023.11.04.02.16.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Nov 2023 02:16:41 -0700 (PDT)
From:   "wuqiang.matt" <wuqiang.matt@bytedance.com>
To:     vgupta@kernel.org, bcain@quicinc.com, jonas@southpole.se,
        stefan.kristiansson@saunalahti.fi, shorne@gmail.com,
        geert@linux-m68k.org, andi.shyti@linux.intel.com, mingo@kernel.org,
        palmer@rivosinc.com, andrzej.hajda@intel.com, arnd@arndb.de,
        peterz@infradead.orgm, mhiramat@kernel.org
Cc:     linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-hexagon@vger.kernel.org, linux-openrisc@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, mattwu@163.com,
        linux@roeck-us.ne, "wuqiang.matt" <wuqiang.matt@bytedance.com>
Subject: [PATCH v2 2/4] locking/atomic: arc: arch_cmpxchg[64]_local undefined
Date:   Sat,  4 Nov 2023 17:16:13 +0800
Message-Id: <20231104091615.4884-3-wuqiang.matt@bytedance.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231104091615.4884-1-wuqiang.matt@bytedance.com>
References: <20231104091615.4884-1-wuqiang.matt@bytedance.com>
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

For architectures that support native cmpxchg, we'd like to
implement arch_cmpxchg[64]_local with the native variants of
supported data size. If not, the generci_cmpxchg[64]_local
will be used.

Signed-off-by: wuqiang.matt <wuqiang.matt@bytedance.com>
---
 arch/arc/include/asm/cmpxchg.h | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arc/include/asm/cmpxchg.h b/arch/arc/include/asm/cmpxchg.h
index bf46514f6f12..91429f2350df 100644
--- a/arch/arc/include/asm/cmpxchg.h
+++ b/arch/arc/include/asm/cmpxchg.h
@@ -80,6 +80,34 @@
 
 #endif
 
+/*
+ * always make arch_cmpxchg[64]_local available, native cmpxchg
+ * will be used if available, then generic_cmpxchg[64]_local
+ */
+#include <asm-generic/cmpxchg-local.h>
+static inline unsigned long __cmpxchg_local(volatile void *ptr,
+				      unsigned long old,
+				      unsigned long new, int size)
+{
+	switch (size) {
+#ifdef CONFIG_ARC_HAS_LLSC
+	case 4:
+		return __cmpxchg_32((int32_t *)ptr, old, new);
+#endif
+	default:
+		return __generic_cmpxchg_local(ptr, old, new, size);
+	}
+
+	return old;
+}
+#define arch_cmpxchg_local(ptr, o, n) ({				\
+	(__typeof__(*ptr))__cmpxchg_local((ptr),			\
+					(unsigned long)(o),		\
+					(unsigned long)(n),		\
+					sizeof(*(ptr)));		\
+})
+#define arch_cmpxchg64_local(ptr, o, n) __generic_cmpxchg64_local((ptr), (o), (n))
+
 /*
  * xchg
  */
-- 
2.40.1

