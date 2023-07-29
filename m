Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E197768005
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 16:28:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231949AbjG2O2D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jul 2023 10:28:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231918AbjG2O16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jul 2023 10:27:58 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE3162686
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jul 2023 07:27:57 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id e9e14a558f8ab-348de515667so13590085ab.1
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jul 2023 07:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1690640877; x=1691245677;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K/AP9GOcXVQHz8AOI7UjuaU+sYzEqAzG6F3W2fxwbBg=;
        b=J4kyjvgZ82W4wgXCeEeMZsVCguRFpikKkcE2HcgJj1qeY7vt+QnMIYGWOOT+WB4w/d
         QxBIq/qctXIL+Pq+QR5781uOJJWRU23mvLFOkz/5oH2U307qLuDCMVxppr9LWan2wYgB
         x4GjVCbkk7A28bEYLtEBKdloUvZLupH9Z4E6M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690640877; x=1691245677;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K/AP9GOcXVQHz8AOI7UjuaU+sYzEqAzG6F3W2fxwbBg=;
        b=MmbCjhmnhhzS+cV4pIno0bermGYFpi59srOVhM0NWii3lzPecxpKkPEaGBy/7RwRVl
         UK+6r8rJk8niLD1yqz9UN9jtDByXARzXI6kxS7WQI6Mq2OlYAGVEZuqsjMDeiZci4A5D
         SHUAZcdZkejHdiiu+KYq8JRi9UD39xy2botbHI28KX7b88RMhboc69WVKacaOZY0lR6m
         zxmGPI3ZyL1c8m8y0oKto2S+vPCZCrf5sISflUC+rP7WGGmtLC4u6BrZIOtnDmrrKGeK
         tBfV5b+jAy1B03izf/cO7nSJmsVW8TeUn+JuqlLtJLYzUBhoaZH/5sBG+uprfSIsZk6P
         CtiQ==
X-Gm-Message-State: ABy/qLZTWYXoW924/o/fA03kK1INuyktAARTGlttc/NWM62t8weZ6Wmf
        +lJ3wWqNwi2aO3N18jLq7F1wemR1BvUf2BhPS4A=
X-Google-Smtp-Source: APBJJlE8nBeVkXcUMALJORNmqTh8c7r1ht4vw0YPrIrwKi+ZvPe7AoO4UA+ZLaLbe2+FsI5VCRzahg==
X-Received: by 2002:a92:c7c1:0:b0:345:ad81:ecaf with SMTP id g1-20020a92c7c1000000b00345ad81ecafmr2084447ilk.3.1690640876885;
        Sat, 29 Jul 2023 07:27:56 -0700 (PDT)
Received: from joelboxx5.c.googlers.com.com (254.82.172.34.bc.googleusercontent.com. [34.172.82.254])
        by smtp.gmail.com with ESMTPSA id q9-20020a0566380ec900b0042b35c7b8c5sm1855362jas.61.2023.07.29.07.27.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Jul 2023 07:27:56 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     rcu@vger.kernel.org, paulmck@kernel.org,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH v2 2/5] srcu: Fix error handling in init_srcu_struct_fields()
Date:   Sat, 29 Jul 2023 14:27:32 +0000
Message-ID: <20230729142738.222208-3-joel@joelfernandes.org>
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
In-Reply-To: <20230729142738.222208-1-joel@joelfernandes.org>
References: <20230729142738.222208-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current error handling in init_srcu_struct_fields() is a bit
inconsistent.  If init_srcu_struct_nodes() fails, the function either
returns -ENOMEM or 0 depending on whether ssp->sda_is_static is true or
false. This can make init_srcu_struct_fields() return 0 even if memory
allocation failed!

Simplify the error handling by always returning -ENOMEM if either
init_srcu_struct_nodes() or the per-CPU allocation fails. This makes the
control flow easier to follow and avoids the inconsistent return values.

Add goto labels to avoid duplicating the error cleanup code.

Link: https://lore.kernel.org/r/20230404003508.GA254019@google.com
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/rcu/srcutree.c | 32 +++++++++++++++++---------------
 1 file changed, 17 insertions(+), 15 deletions(-)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 20d7a238d675..f1a905200fc2 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -255,29 +255,31 @@ static int init_srcu_struct_fields(struct srcu_struct *ssp, bool is_static)
 	ssp->srcu_sup->sda_is_static = is_static;
 	if (!is_static)
 		ssp->sda = alloc_percpu(struct srcu_data);
-	if (!ssp->sda) {
-		if (!is_static)
-			kfree(ssp->srcu_sup);
-		return -ENOMEM;
-	}
+	if (!ssp->sda)
+		goto err_free_sup;
 	init_srcu_struct_data(ssp);
 	ssp->srcu_sup->srcu_gp_seq_needed_exp = 0;
 	ssp->srcu_sup->srcu_last_gp_end = ktime_get_mono_fast_ns();
 	if (READ_ONCE(ssp->srcu_sup->srcu_size_state) == SRCU_SIZE_SMALL && SRCU_SIZING_IS_INIT()) {
-		if (!init_srcu_struct_nodes(ssp, GFP_ATOMIC)) {
-			if (!ssp->srcu_sup->sda_is_static) {
-				free_percpu(ssp->sda);
-				ssp->sda = NULL;
-				kfree(ssp->srcu_sup);
-				return -ENOMEM;
-			}
-		} else {
-			WRITE_ONCE(ssp->srcu_sup->srcu_size_state, SRCU_SIZE_BIG);
-		}
+		if (!init_srcu_struct_nodes(ssp, GFP_ATOMIC))
+			goto err_free_sda;
+		WRITE_ONCE(ssp->srcu_sup->srcu_size_state, SRCU_SIZE_BIG);
 	}
 	ssp->srcu_sup->srcu_ssp = ssp;
 	smp_store_release(&ssp->srcu_sup->srcu_gp_seq_needed, 0); /* Init done. */
 	return 0;
+
+err_free_sda:
+	if (!is_static) {
+		free_percpu(ssp->sda);
+		ssp->sda = NULL;
+	}
+err_free_sup:
+	if (!is_static) {
+		kfree(ssp->srcu_sup);
+		ssp->srcu_sup = NULL;
+	}
+	return -ENOMEM;
 }
 
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
-- 
2.41.0.487.g6d72f3e995-goog

