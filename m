Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 746B67F9D97
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 11:32:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233050AbjK0Kcs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 05:32:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232973AbjK0Kcm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 05:32:42 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C0F4EA
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 02:32:49 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-54b532b261bso1353393a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 02:32:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701081167; x=1701685967; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dIxf4qA9d3iQNURLT0XW05wJYozIZ97sH6EQJwhq5Vo=;
        b=mNG2haVOEUMCQtqqVzdu9hpGrP0xLDGnnmMTfKE9GOZADNqDr9c2Q9Xn6jxrTSSt0D
         SGcX2cocuCivDt+J+9MUiBIOf6pKCrtFiLdpz4I9dS4h1xE5OQpkjqbU5ihocYCkHGRz
         AmT26epBajAFq1rqoud622iTgJpwXh0pPELJMUeGAHf03PfGJjh4QAN7YKgE+IUKvCed
         tO4RWspeMNNHmGx74a1cio1Lt6ihRf0b+Aq1wKWexH7U7Cl35s7+LcAXqQaeutw/suH9
         ox8Swo4g6Qy4TNQDRtGJWUJb3TyTGyYiVGEEAvmsnXQEdxBaes9UJS6oVaLm2fnFJcqC
         NMAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701081167; x=1701685967;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dIxf4qA9d3iQNURLT0XW05wJYozIZ97sH6EQJwhq5Vo=;
        b=s6nbrBAsMCAD6VJO+GrtArBehDYACZi48NBSQPX/zRAKLlZQL8ti45Fy6ipvx4M66Q
         cU1DWwaoWovX4aPWBDipAjPdEJM1J7Axub5ftSicn0gAHaPG3N0XwNYEzLFC18Z4r6Bw
         jtZ6+Y3jtK52kKLMEaJOxtfdc1fBxyzNIKQshuSsebZUPGVTCkNPrkmUMLk4YWXe5xYE
         tXnC7MdgnzCw6L5EDLp7eqECQYcLVvR3u0uwzASQjoM42lzM5S9WAcIHHO0P1ryvWkcA
         YgfriW5mKPN3XoLAuu3suWHJc1ZU/x+FPU6xboovuc7cthrlnNQP3g5Q2vd9Vj7CHWB0
         uckw==
X-Gm-Message-State: AOJu0Yzz4+1LR8dI5CC1HhzhTPh8rKl2ucuv8JeAjQOfV+TPaeldQljp
        GVgGXMHVYjQa8+K4CUHR7mw=
X-Google-Smtp-Source: AGHT+IFmy1m9Y+H2p9q9elT0xydMtLsrFZsvRFhY2WqKMjU52KidZjpTJC0i2aZ2LuL0kaVMfQA+aQ==
X-Received: by 2002:a05:6402:751:b0:54b:3edc:180 with SMTP id p17-20020a056402075100b0054b3edc0180mr3517112edy.11.1701081167489;
        Mon, 27 Nov 2023 02:32:47 -0800 (PST)
Received: from andrea.wind3.hub ([31.189.63.178])
        by smtp.gmail.com with ESMTPSA id p5-20020a056402044500b00540ea3a25e6sm5142057edw.72.2023.11.27.02.32.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 02:32:47 -0800 (PST)
From:   Andrea Parri <parri.andrea@gmail.com>
To:     mathieu.desnoyers@efficios.com, paulmck@kernel.org,
        palmer@dabbelt.com, paul.walmsley@sifive.com, aou@eecs.berkeley.edu
Cc:     mmaas@google.com, hboehm@google.com, striker@us.ibm.com,
        charlie@rivosinc.com, rehn@rivosinc.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Andrea Parri <parri.andrea@gmail.com>
Subject: [PATCH 1/2] locking: Introduce prepare_sync_core_cmd()
Date:   Mon, 27 Nov 2023 11:32:34 +0100
Message-Id: <20231127103235.28442-2-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231127103235.28442-1-parri.andrea@gmail.com>
References: <20231127103235.28442-1-parri.andrea@gmail.com>
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

Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
Suggested-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
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

