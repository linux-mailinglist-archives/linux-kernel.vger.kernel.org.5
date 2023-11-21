Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24AB37F30AB
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 15:26:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234378AbjKUOZ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 09:25:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234316AbjKUOZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 09:25:21 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A99BD5D
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 06:24:54 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-6cb66fbc63dso1968476b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 06:24:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1700576694; x=1701181494; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KQzQ3hctuM1DrYXT+jmSwlcI1w3CAnf53zL9eOZco7c=;
        b=lK8s4WR4D8qSeSl/wIndq3Y/ygX+TN/NIiGvIInZYS4yLgqoazrLYb8VAsi94YZzBI
         Ewym/spIimpGTmNWO7w2DqPAQtRk0t8uGS52aH9pk/e/RSSPg1qPA0gv2iH456fXHf2N
         ZXK1lnI6HFlp3OWOdl3g6XN8WYUSY3bAAdc0YJ4gN/FM4U+/ThowxrCYqtt3tszLtix3
         WN7go69/Fj1hDOdBr+s/K9yYhCiYll4EMUahkrElleQ9rr0BwlPgUhSNNWEGXydRVBUK
         Bu0F/GyJBqfWo6ozXYgA4xusqzgvnUHsanLlnxodjTMBnIVRIWOqkjX22HUiu1BXvR6Q
         Anpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700576694; x=1701181494;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KQzQ3hctuM1DrYXT+jmSwlcI1w3CAnf53zL9eOZco7c=;
        b=uJOCKiEZnLtEsiCUN2AZNYL32SirUG31g5NLP5UooDNKwM3dY6fb6DAaWdhvKSBnQT
         q527tG7l1UH2NKbZP33pIFQsLfwUrn2D9cRRZLOnYJflhpijiZxIhrgrkNUkdwD9g2re
         mzzdDvo0023Iazil5DBNzeUXvxrP8hapeQTX/GFg8b2zurRL2iobJTUtGwB6AbbcWdfj
         M2duBi8amAZXTCw4VEB89ooSDrpADYCxbLYdLs8gKO6g0Bah5Q1cUVdikQp87T95lTS5
         p4LVV0PD70bkS9oiu1YCsXKHEd4cWIc9C7uUNWkukcXfViZkk9UklrcI7Uc9/GrA5A+P
         hZ3A==
X-Gm-Message-State: AOJu0YyRl8R2HQRnzQ5AbvlZT9Pfc4UMdqu/JODQM7z8HuLGn9zqkBFe
        x0Gb45atCZP2WdbmpsgI03ogPA==
X-Google-Smtp-Source: AGHT+IHbYu2jqbF7t8/wu/0pojkQUebMfIzAqIQeTS1oR0oKU5ESn/XV9iR5u5ULhgBjAJ/tpgr/hw==
X-Received: by 2002:a05:6a00:228f:b0:6cb:8abd:39b5 with SMTP id f15-20020a056a00228f00b006cb8abd39b5mr4000172pfe.1.1700576693727;
        Tue, 21 Nov 2023 06:24:53 -0800 (PST)
Received: from devz1.bytedance.net ([203.208.167.146])
        by smtp.gmail.com with ESMTPSA id d13-20020a056a00244d00b0068842ebfd10sm7923193pfj.160.2023.11.21.06.24.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Nov 2023 06:24:53 -0800 (PST)
From:   "wuqiang.matt" <wuqiang.matt@bytedance.com>
To:     ubizjak@gmail.com, mark.rutland@arm.com, vgupta@kernel.org,
        bcain@quicinc.com, jonas@southpole.se,
        stefan.kristiansson@saunalahti.fi, shorne@gmail.com,
        chris@zankel.net, jcmvbkbc@gmail.com, geert@linux-m68k.org,
        andi.shyti@linux.intel.com, mingo@kernel.org, palmer@rivosinc.com,
        andrzej.hajda@intel.com, arnd@arndb.de, peterz@infradead.org,
        mhiramat@kernel.org
Cc:     linux-arch@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-hexagon@vger.kernel.org,
        linux-openrisc@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        mattwu@163.com, linux@roeck-us.net,
        "wuqiang.matt" <wuqiang.matt@bytedance.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v3 2/5] arch,locking/atomic: arc: add arch_cmpxchg[64]_local
Date:   Tue, 21 Nov 2023 22:23:44 +0800
Message-Id: <20231121142347.241356-3-wuqiang.matt@bytedance.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231121142347.241356-1-wuqiang.matt@bytedance.com>
References: <20231121142347.241356-1-wuqiang.matt@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

arc doesn't have arch_cmpxhg_local implemented, which causes
building failures for any references of try_cmpxchg_local,
reported by the kernel test robot.

This patch implements arch_cmpxchg[64]_local with the native
cmpxchg variant if the corresponding data size is supported,
otherwise generci_cmpxchg[64]_local is to be used.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202310272207.tLPflya4-lkp@intel.com/

Signed-off-by: wuqiang.matt <wuqiang.matt@bytedance.com>
Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
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

