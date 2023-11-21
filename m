Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 642057F30A3
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 15:25:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234116AbjKUOZI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 09:25:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233912AbjKUOZF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 09:25:05 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69E9E197
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 06:25:02 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-6c33ab26dddso4866118b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 06:25:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1700576702; x=1701181502; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ma7hrIwqvDM4lCpBvbnn1WZG4yWufWgrZRtOwNFwz5Q=;
        b=UW9ckZHW8W7pnYJbKIM/+E86k6AjyG3KWPYF7p1lDxUKXH63MHhA+pEmmILOd5OseX
         /GuTXcmZE8r8mR6P9gc2dPF7z0271cbf+xlqjssqQZTX3MhZEQnHdSxlAvR9DbOwfu4j
         orhpbXhuMorz+HTFrvwBu3WxCW1tZGC67GrwQVfNo3/qnYDzeYiSIm6f+P3vIZ30GvIQ
         OrqlGqNXbOVV4CAI9o0q2jQrLPGIBRMDL6DeHVKUCKIlynjGqWuRE5HKG/5+I5ic/JTm
         //TyEvFIbWPy8/+FpftXIq1N8VGOe8WYSGH4Zye8m8xwomMy1WN2/k9SX+asjr1tnnfr
         OYVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700576702; x=1701181502;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ma7hrIwqvDM4lCpBvbnn1WZG4yWufWgrZRtOwNFwz5Q=;
        b=mHAgr3BluGl6BeUK449FxQojGGrzNBXeTRmnFAWh06f71uqLxfWm4DlxHrX5Y6UJ/7
         hPjYzjOWLIukB4GTNKmM+ENb9B9MKFZ75/GjlV8KE8MaPBLlvO0m6KIcvJlz3YpV15Oa
         ZSfbf2jzYRKu/uKWk0q4IA5PI9LKg0m1g1NeFL8qI/80R7gIg33QiYQi7Sxs1Ot4WO3d
         z0PnY9ZZ4/xA341a0z4PzjZHzf/Lkux1nvTIRJuE/eN6m2wVE/gTHjIZQdOiSplUkwmv
         eh6nY6nuCbMbPaRTUfxAgTVcGHDAQZKMJhgbdL5/NEd60Dv9vV2Czpka7Q0NvPIy1i3z
         kVkg==
X-Gm-Message-State: AOJu0YzTeINiBx00iPWKCNfp0CR/ctuLb9MhIGvEthPn1OE5PZmq3jE2
        ve4Q8dG5WEYV1SywfFFCQ0RKmQ==
X-Google-Smtp-Source: AGHT+IHISvT3HOK4Q8QdxNY25egV5B1w+H+S5nFIY6gWXptDkpevoMSwLQoow/dwb6Z7gSO9fV5N9w==
X-Received: by 2002:a05:6a00:3923:b0:68e:3eab:9e18 with SMTP id fh35-20020a056a00392300b0068e3eab9e18mr9207536pfb.12.1700576701929;
        Tue, 21 Nov 2023 06:25:01 -0800 (PST)
Received: from devz1.bytedance.net ([203.208.167.146])
        by smtp.gmail.com with ESMTPSA id d13-20020a056a00244d00b0068842ebfd10sm7923193pfj.160.2023.11.21.06.24.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Nov 2023 06:25:01 -0800 (PST)
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
Subject: [PATCH v3 3/5] arch,locking/atomic: openrisc: add arch_cmpxchg[64]_local
Date:   Tue, 21 Nov 2023 22:23:45 +0800
Message-Id: <20231121142347.241356-4-wuqiang.matt@bytedance.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231121142347.241356-1-wuqiang.matt@bytedance.com>
References: <20231121142347.241356-1-wuqiang.matt@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

openrisc hasn't arch_cmpxhg_local implemented, which causes
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
 arch/openrisc/include/asm/cmpxchg.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/openrisc/include/asm/cmpxchg.h b/arch/openrisc/include/asm/cmpxchg.h
index 8ee151c072e4..f1ffe8b6f5ef 100644
--- a/arch/openrisc/include/asm/cmpxchg.h
+++ b/arch/openrisc/include/asm/cmpxchg.h
@@ -139,6 +139,12 @@ static inline unsigned long __cmpxchg(volatile void *ptr, unsigned long old,
 					       (unsigned long)(n),	\
 					       sizeof(*(ptr)));		\
 	})
+#define arch_cmpxchg_local arch_cmpxchg
+
+/* always make arch_cmpxchg64_local available for openrisc */
+#include <asm-generic/cmpxchg-local.h>
+
+#define arch_cmpxchg64_local(ptr, o, n) __generic_cmpxchg64_local((ptr), (o), (n))
 
 /*
  * This function doesn't exist, so you'll get a linker error if
-- 
2.40.1

