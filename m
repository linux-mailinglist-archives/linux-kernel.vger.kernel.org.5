Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A720D80C501
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 10:44:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234468AbjLKJoc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 04:44:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234619AbjLKJo1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 04:44:27 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EBC5CE
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 01:44:33 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-54da61eb366so5658441a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 01:44:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702287872; x=1702892672; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mfT6yTigw0JL9rPQ3RLVTHss5/tTMRXlGfMsOm5hiBA=;
        b=LxX+NeJmku4hhfwrCuLd7Y4EmSUJY/rWF4dkOk0wtCBLRLkUdksgBUIQT/wywyFOiW
         Ikm6SeMjQX2C/WuocV9tTcrHLtlvFC+zCdsqHQVofwfmntMnxLXnjPhYlOsLJn7rQQ5J
         MQNXYs1+GQQ6yLePwB5ukueLn4vCbBJPjKTaMmZmRXRCQLLnYQfrIB9HQKxAvUouOAJx
         NERDYxemmIj9ObiiDjfRn4EluEb/Xlw5nAo5oB1ZkiOxzpriI0MZYTN+U7p0rn+pEhTj
         ogqsXa/+W2dnuzPl1qe6sM0nLLDS9xJo0Uxiv0TWK5Kn+AvHnk0Fnxx5gfL5vworcrCo
         emag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702287872; x=1702892672;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mfT6yTigw0JL9rPQ3RLVTHss5/tTMRXlGfMsOm5hiBA=;
        b=BH3tTKaQQnnmfJaJcqyXsh3njcIqqBBimppTZ4C0Z2T1koobDg1TrWSg+HJz8ujjsI
         ICQ9KcSc37boEnV21wKj6cw6xnxF0mKc4w+tpy5dJMWG0gVGFaDEbon4O7lzcKli15Z7
         oai255l0CeHC+lYsBO2DcnSP4cquKIkF8gBd3TX38OJqzL/yPnuTAxFnN1JCvZ1DY9cr
         4LcxCp0hTyHqBQpdOa41AqwmWhkspklAujITN+yFFqlnxpeW9iJpV2WKCQZqkZlywuLm
         kIKh/i0z/WF4BMFlCGHVx0yHfrnF40oXq3JTX1NOF3iVnhUqs3hXAc5gvYzcokSOKcly
         6jmA==
X-Gm-Message-State: AOJu0YzilyW7ffo4LQUXiO/t1Xj1UfUhkvGYe1FK/MhoQVoFqgC6U15D
        A5kRX4bq69GiZkhzkhageoQ=
X-Google-Smtp-Source: AGHT+IGMxuKPrFTwj2zbLSblfgSfd44OwUT+BQyj3R0X1rt7fU+FpQfB/msMTDFYA5XJOFpr3giP2g==
X-Received: by 2002:a50:fb8b:0:b0:54c:4837:93f7 with SMTP id e11-20020a50fb8b000000b0054c483793f7mr2864378edq.62.1702287871520;
        Mon, 11 Dec 2023 01:44:31 -0800 (PST)
Received: from andrea.wind3.hub ([31.189.124.152])
        by smtp.gmail.com with ESMTPSA id if3-20020a0564025d8300b0054afcab0af2sm3463505edb.59.2023.12.11.01.44.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 01:44:31 -0800 (PST)
From:   Andrea Parri <parri.andrea@gmail.com>
To:     mathieu.desnoyers@efficios.com, paulmck@kernel.org,
        palmer@dabbelt.com, paul.walmsley@sifive.com, aou@eecs.berkeley.edu
Cc:     mmaas@google.com, hboehm@google.com, striker@us.ibm.com,
        charlie@rivosinc.com, rehn@rivosinc.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Andrea Parri <parri.andrea@gmail.com>
Subject: [PATCH v2 2/4] locking: Introduce prepare_sync_core_cmd()
Date:   Mon, 11 Dec 2023 10:44:12 +0100
Message-Id: <20231211094414.8078-3-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231211094414.8078-1-parri.andrea@gmail.com>
References: <20231211094414.8078-1-parri.andrea@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce an architecture function that architectures can use to set
up ("prepare") SYNC_CORE commands.

The function will be used by RISC-V to update its "deferred icache-
flush" data structures (icache_stale_mask).

Architectures defining prepare_sync_core_cmd() static inline need to
select ARCH_HAS_PREPARE_SYNC_CORE_CMD.

Suggested-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 include/linux/sync_core.h | 16 +++++++++++++++-
 init/Kconfig              |  3 +++
 kernel/sched/membarrier.c |  1 +
 3 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/include/linux/sync_core.h b/include/linux/sync_core.h
index 013da4b8b3272..67bb9794b8758 100644
--- a/include/linux/sync_core.h
+++ b/include/linux/sync_core.h
@@ -17,5 +17,19 @@ static inline void sync_core_before_usermode(void)
 }
 #endif
 
-#endif /* _LINUX_SYNC_CORE_H */
+#ifdef CONFIG_ARCH_HAS_PREPARE_SYNC_CORE_CMD
+#include <asm/sync_core.h>
+#else
+/*
+ * This is a dummy prepare_sync_core_cmd() implementation that can be used on
+ * all architectures which provide unconditional core serializing instructions
+ * in switch_mm().
+ * If your architecture doesn't provide such core serializing instructions in
+ * switch_mm(), you may need to write your own functions.
+ */
+static inline void prepare_sync_core_cmd(struct mm_struct *mm)
+{
+}
+#endif
 
+#endif /* _LINUX_SYNC_CORE_H */
diff --git a/init/Kconfig b/init/Kconfig
index 9ffb103fc927b..87daf50838f02 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1972,6 +1972,9 @@ source "kernel/Kconfig.locks"
 config ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
 	bool
 
+config ARCH_HAS_PREPARE_SYNC_CORE_CMD
+	bool
+
 config ARCH_HAS_SYNC_CORE_BEFORE_USERMODE
 	bool
 
diff --git a/kernel/sched/membarrier.c b/kernel/sched/membarrier.c
index 2ad881d07752c..58f801e013988 100644
--- a/kernel/sched/membarrier.c
+++ b/kernel/sched/membarrier.c
@@ -320,6 +320,7 @@ static int membarrier_private_expedited(int flags, int cpu_id)
 		      MEMBARRIER_STATE_PRIVATE_EXPEDITED_SYNC_CORE_READY))
 			return -EPERM;
 		ipi_func = ipi_sync_core;
+		prepare_sync_core_cmd(mm);
 	} else if (flags == MEMBARRIER_FLAG_RSEQ) {
 		if (!IS_ENABLED(CONFIG_RSEQ))
 			return -EINVAL;
-- 
2.34.1

