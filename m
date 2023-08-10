Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5A5F777A83
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 16:23:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235632AbjHJOXR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 10:23:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235688AbjHJOXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 10:23:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 870FA2D53
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 07:22:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 193FD65D97
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 14:22:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BDD1C433C7;
        Thu, 10 Aug 2023 14:22:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691677367;
        bh=zm5Sn5aoo9lAExPG70q1GTsvtFdGFc5JFFuqji9a/WA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lpwr67WUt7XboGgjE35Yb5FuHHFbF8xfLwLRJScg6qXS5JQ1q+sp/Qdg735a63N9J
         hxm+hKPwITcQNHf2MfB12vwl7iWjn4aZgEZNbdHiV3GdADE4WOnRt7wbMSmB64hUWN
         YzVh7ZKXwjSnRD7KvnBPrzZWR7X3cl8eR32J5s0xZHGgqKzrWlL8Krg7jkbH8TVNR3
         /Lc5uZS4BYzT9k8ZXtWqEWgAY+nZnJw8pyEr81X+tWJPPz8wQ2Sg5XADc4q+FKq1s4
         4C7tpCe8q0aepKRZcNRkGm4dSodtw0kIhoSLE6ogUAqtganVElKZMjblH2vKC8m6va
         cCuCOK777NwCg==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 13/17] stackleak: add declarations for global functions
Date:   Thu, 10 Aug 2023 16:19:31 +0200
Message-Id: <20230810141947.1236730-14-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230810141947.1236730-1-arnd@kernel.org>
References: <20230810141947.1236730-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

With -Wmissing-prototypes enabled, the stackleak code produces a couple of
warnings that have no declarations because they are only called from assembler:

stackleak.c:127:25: error: no previous prototype for 'stackleak_erase' [-Werror=missing-prototypes]
stackleak.c:139:25: error: no previous prototype for 'stackleak_erase_on_task_stack' [-Werror=missing-prototypes]
stackleak.c:151:25: error: no previous prototype for 'stackleak_erase_off_task_stack' [-Werror=missing-prototypes]
stackleak.c:159:49: error: no previous prototype for 'stackleak_track_stack' [-Werror=missing-prototypes]

Add declarations to the stackleak header to shut up the warnings.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/linux/stackleak.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/stackleak.h b/include/linux/stackleak.h
index c36e7a3b45e7e..3be2cb564710b 100644
--- a/include/linux/stackleak.h
+++ b/include/linux/stackleak.h
@@ -14,6 +14,7 @@
 
 #ifdef CONFIG_GCC_PLUGIN_STACKLEAK
 #include <asm/stacktrace.h>
+#include <linux/linkage.h>
 
 /*
  * The lowest address on tsk's stack which we can plausibly erase.
@@ -76,6 +77,11 @@ static inline void stackleak_task_init(struct task_struct *t)
 # endif
 }
 
+asmlinkage void noinstr stackleak_erase(void);
+asmlinkage void noinstr stackleak_erase_on_task_stack(void);
+asmlinkage void noinstr stackleak_erase_off_task_stack(void);
+void __no_caller_saved_registers noinstr stackleak_track_stack(void);
+
 #else /* !CONFIG_GCC_PLUGIN_STACKLEAK */
 static inline void stackleak_task_init(struct task_struct *t) { }
 #endif
-- 
2.39.2

