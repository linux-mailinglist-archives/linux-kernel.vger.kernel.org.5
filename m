Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8E907F30A1
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 15:25:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234285AbjKUOZS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 09:25:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234274AbjKUOZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 09:25:15 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F31B11A3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 06:25:10 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-6cb66fbc63dso1968702b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 06:25:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1700576710; x=1701181510; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LtVyhAGSgxoCUXjWEvR6JSaSck3SbghSEmVuA82Ner4=;
        b=OqeuVnWBhBVwL4BhDqUp1/T5IIQOZIrg6ODry6HbSHtpxzIojyg4/QYSSZxgvdy2v8
         /TkbUokutA6fPZgyBCt+z1x3KIW3jxN5DfbuYN/aB0mUCI5etmuwDE49I+wWrgwNFxPB
         DqEJZKdO+4qseHxz1bz45qjMOk279EwOAphliF8WUPkBSbC9R/CvfRlws5aUSI2gnuOn
         /bT27Vbg9XpoWtFcRvziuPOpC6IiqsiiRxegRESK9M2qdI6Dn87/m8HztxMNYno8xFGY
         qdguKu+ESam6MVkbVmmTkUEI5SJjTIM1RmTrNN62r3Qn2OHy3XpaIkfbkeHM2vnkUrJ2
         5kzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700576710; x=1701181510;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LtVyhAGSgxoCUXjWEvR6JSaSck3SbghSEmVuA82Ner4=;
        b=UxSXYtyievy65Nz+gO9Ah7kjXk3GEPd1ei1W0AjEi4qGJshAhcqFAbId2SFqr3AYmw
         UokrK+HQeyUU9XniB4lcnvzk8woazKyv+z6aHAmdycd6dyGdJSKtcSYdv6IoHeBmC1jY
         foBgf/+qYk1GpQhB34ZRVYY5VWOGaxwfaQjnn/4ooprkgq6I19RcQMJjbwjbDIoFZ4fp
         h7Kso1UZNqU1ZlJsiaYDPMIIxNQrjfPAiBSbDciyOoe4NCr2NrRR0a+rhurzyXcZidbA
         Lv6saEJjKgsVavYpKO5pQsiIZt4KS1qsY39WY9zrC/Uprtol+pT/+PDRfUMyP8SdW6d+
         pucw==
X-Gm-Message-State: AOJu0Yx7NgsmY3MSpdPjFbuOkE45NYPylBTvtt4EIJpiyw0cMNQD6Ua2
        LZVDWBMmqqRkI1WwOtSK4Rs+7w==
X-Google-Smtp-Source: AGHT+IGFtHc4qKqJVnN1XjVMkiinlk0jG07pQ1wbI9nowl9FuK5wiYNBs1I2uzxLrjyzw/P8FvB74A==
X-Received: by 2002:a05:6a00:1d8c:b0:6cb:ba8d:96a7 with SMTP id z12-20020a056a001d8c00b006cbba8d96a7mr4393242pfw.14.1700576710440;
        Tue, 21 Nov 2023 06:25:10 -0800 (PST)
Received: from devz1.bytedance.net ([203.208.167.146])
        by smtp.gmail.com with ESMTPSA id d13-20020a056a00244d00b0068842ebfd10sm7923193pfj.160.2023.11.21.06.25.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Nov 2023 06:25:10 -0800 (PST)
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
Subject: [PATCH v3 4/5] arch,locking/atomic: hexagon: add arch_cmpxchg[64]_local
Date:   Tue, 21 Nov 2023 22:23:46 +0800
Message-Id: <20231121142347.241356-5-wuqiang.matt@bytedance.com>
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

hexagonc hasn't arch_cmpxhg_local implemented, which causes
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
 arch/hexagon/include/asm/cmpxchg.h | 51 +++++++++++++++++++++++++++++-
 1 file changed, 50 insertions(+), 1 deletion(-)

diff --git a/arch/hexagon/include/asm/cmpxchg.h b/arch/hexagon/include/asm/cmpxchg.h
index bf6cf5579cf4..302fa30f25aa 100644
--- a/arch/hexagon/include/asm/cmpxchg.h
+++ b/arch/hexagon/include/asm/cmpxchg.h
@@ -8,6 +8,8 @@
 #ifndef _ASM_CMPXCHG_H
 #define _ASM_CMPXCHG_H
 
+#include <linux/build_bug.h>
+
 /*
  * __arch_xchg - atomically exchange a register and a memory location
  * @x: value to swap
@@ -51,13 +53,15 @@ __arch_xchg(unsigned long x, volatile void *ptr, int size)
  *  variable casting.
  */
 
-#define arch_cmpxchg(ptr, old, new)				\
+#define __cmpxchg_32(ptr, old, new)				\
 ({								\
 	__typeof__(ptr) __ptr = (ptr);				\
 	__typeof__(*(ptr)) __old = (old);			\
 	__typeof__(*(ptr)) __new = (new);			\
 	__typeof__(*(ptr)) __oldval = 0;			\
 								\
+	BUILD_BUG_ON(sizeof(*(ptr)) != 4);			\
+								\
 	asm volatile(						\
 		"1:	%0 = memw_locked(%1);\n"		\
 		"	{ P0 = cmp.eq(%0,%2);\n"		\
@@ -72,4 +76,49 @@ __arch_xchg(unsigned long x, volatile void *ptr, int size)
 	__oldval;						\
 })
 
+#define __cmpxchg(ptr, old, val, size)				\
+({								\
+	__typeof__(*(ptr)) oldval;				\
+								\
+	switch (size) {						\
+	case 4:							\
+		oldval = __cmpxchg_32(ptr, old, val);		\
+		break;						\
+	default:						\
+		BUILD_BUG();					\
+		oldval = val;					\
+		break;						\
+	}							\
+								\
+	oldval;							\
+})
+
+#define arch_cmpxchg(ptr, o, n)	__cmpxchg((ptr), (o), (n), sizeof(*(ptr)))
+
+/*
+ * always make arch_cmpxchg[64]_local available, native cmpxchg
+ * will be used if available, then generic_cmpxchg[64]_local
+ */
+#include <asm-generic/cmpxchg-local.h>
+
+#define arch_cmpxchg_local(ptr, old, val)			\
+({								\
+	__typeof__(*(ptr)) __retval;				\
+	int __size = sizeof(*(ptr));				\
+								\
+	switch (__size) {					\
+	case 4:							\
+		__retval = __cmpxchg_32(ptr, old, val);		\
+		break;						\
+	default:						\
+		__retval = __generic_cmpxchg_local(ptr, old,	\
+						val, __size);	\
+		break;						\
+	}							\
+								\
+	__retval;						\
+})
+
+#define arch_cmpxchg64_local(ptr, o, n) __generic_cmpxchg64_local((ptr), (o), (n))
+
 #endif /* _ASM_CMPXCHG_H */
-- 
2.40.1

