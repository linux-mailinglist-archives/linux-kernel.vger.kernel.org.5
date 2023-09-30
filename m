Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A3847B42CB
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 19:47:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234679AbjI3RrG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 13:47:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234568AbjI3RrF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 13:47:05 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13AB9E3
        for <linux-kernel@vger.kernel.org>; Sat, 30 Sep 2023 10:47:02 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id e9e14a558f8ab-3512efed950so41403445ab.2
        for <linux-kernel@vger.kernel.org>; Sat, 30 Sep 2023 10:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1696096021; x=1696700821; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RKqIHaosAw2qI5kHOFkLuyhg0rOLeHVcoTzGWdYEVOE=;
        b=AaMGLYeZ4BQ3JOTkvw/ULAeII5LK/E6KUWNx+ItK+R1bsTFDY3EYH3Ub9iihRjDWiG
         OA0Up0Z6YKIQL1At+HLSdaNqSPqAoMsW0YcnxuNC6kUWxbISLvTueNkRnDGQBrfIlKaz
         TodGmRZ3RVuEHgJLJ9PrifU5D9+TJA9Yf4w+k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696096021; x=1696700821;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RKqIHaosAw2qI5kHOFkLuyhg0rOLeHVcoTzGWdYEVOE=;
        b=O8IqDCTZCqc7yyFgwP5Bv3vgmlw7BbAA9dQcgxaMDrLaHfxgC2udfSEZSETVdNAGZW
         BxbI1VLJPf9HF11TXIwsmQNjLXI6c/nk5ko902tGVOR5UL25nx1ThLWinshDgA0fmC9k
         QJx6SnkjWI3CS1nLDMc+0z0RIoSNw6RhqJwDbuT9qbMga9mHDuZ+3aWYb/eKhvgDXZeE
         asYYEElEJ9mKFdEFyS8uXmYxsipoRklu1PnDkOOTFcH8qrx8DttlhjJxLfQiyblrVPOC
         hQwbxRgL6FpapbRQ3wPMx6AimPqGVJXo+bQ8rgV/nGp1lzevUk+nd3/WQRyycSKRr+yC
         +gMA==
X-Gm-Message-State: AOJu0YxEoqbfj8SRPSy3xDOTNkG16XRu7PuI/cewjh30QwYtUlsRfWok
        pjAH0MdQzaDlZpF2AdOTCc/ooGaIeQ/8Ri4Pn7k=
X-Google-Smtp-Source: AGHT+IEeRLDoJnr+xa+kRhIoy7UxPJbpr8f2S+GA/nCXzlpbbIBUpQwKBzpSAqt0cCAz3cGsIRCrtw==
X-Received: by 2002:a05:6e02:1c46:b0:34f:d665:4c2e with SMTP id d6-20020a056e021c4600b0034fd6654c2emr9306390ilg.30.1696096020883;
        Sat, 30 Sep 2023 10:47:00 -0700 (PDT)
Received: from joelboxx5.c.googlers.com.com (161.74.123.34.bc.googleusercontent.com. [34.123.74.161])
        by smtp.gmail.com with ESMTPSA id f4-20020a02a804000000b00418a5e0e93esm5884180jaj.162.2023.09.30.10.47.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Sep 2023 10:47:00 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Zqiang <qiang.zhang1211@gmail.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Christoph Paasch <cpaasch@apple.com>, stable@vger.kernel.org,
        rcu@vger.kernel.org
Subject: [PATCH] rcu: kmemleak: Ignore kmemleak false positives when RCU-freeing objects
Date:   Sat, 30 Sep 2023 17:46:56 +0000
Message-ID: <20230930174657.800551-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.42.0.582.g8ccd20d70d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Catalin Marinas <catalin.marinas@arm.com>

Since the actual slab freeing is deferred when calling kvfree_rcu(), so
is the kmemleak_free() callback informing kmemleak of the object
deletion. From the perspective of the kvfree_rcu() caller, the object is
freed and it may remove any references to it. Since kmemleak does not
scan RCU internal data storing the pointer, it will report such objects
as leaks during the grace period.

Tell kmemleak to ignore such objects on the kvfree_call_rcu() path. Note
that the tiny RCU implementation does not have such issue since the
objects can be tracked from the rcu_ctrlblk structure.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Reported-by: Christoph Paasch <cpaasch@apple.com>
Closes: https://lore.kernel.org/all/F903A825-F05F-4B77-A2B5-7356282FBA2C@apple.com/
Cc: <stable@vger.kernel.org>
Tested-by: Christoph Paasch <cpaasch@apple.com>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/rcu/tree.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index cb1caefa8bd0..24423877962c 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -31,6 +31,7 @@
 #include <linux/bitops.h>
 #include <linux/export.h>
 #include <linux/completion.h>
+#include <linux/kmemleak.h>
 #include <linux/moduleparam.h>
 #include <linux/panic.h>
 #include <linux/panic_notifier.h>
@@ -3388,6 +3389,14 @@ void kvfree_call_rcu(struct rcu_head *head, void *ptr)
 		success = true;
 	}
 
+	/*
+	 * The kvfree_rcu() caller considers the pointer freed at this point
+	 * and likely removes any references to it. Since the actual slab
+	 * freeing (and kmemleak_free()) is deferred, tell kmemleak to ignore
+	 * this object (no scanning or false positives reporting).
+	 */
+	kmemleak_ignore(ptr);
+
 	// Set timer to drain after KFREE_DRAIN_JIFFIES.
 	if (rcu_scheduler_active == RCU_SCHEDULER_RUNNING)
 		schedule_delayed_monitor_work(krcp);
-- 
2.42.0.582.g8ccd20d70d-goog

