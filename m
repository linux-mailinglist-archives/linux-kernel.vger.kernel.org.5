Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E4D97C852D
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 14:00:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231598AbjJML7T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 07:59:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231591AbjJML7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 07:59:16 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 538FDA9;
        Fri, 13 Oct 2023 04:59:14 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0BB0C433C7;
        Fri, 13 Oct 2023 11:59:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697198353;
        bh=QSG6hSbymQR94WKaIKBPaZ45C4sCdjinqu5taG9tkdg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ST+LcM3kTPie/f4gkDT0cUkbNWb3QyNRsKSk10jgGlWr2PeS6+U3wSok2DF0IK8La
         8ZTxGilr1I71zi49J1hyWv7bt5fSBDMpDN//3E6k1a/7JX1D0WtmJXYthV+Qf8IoNv
         65GP3qfrkDMIwm86TZDVQzthXMGFfj7HhJQyQyiLtJUljR29rwm9JTBUwI7cXFHr4M
         3a6TYfvLFkoIQpcw+mY8P4O2BKsANgaxt0QMm43q2UNT3TkRxioGLnKaoBNk1jBrdM
         AexJvDe+NCk41waI36+jQlFhjh6yAnGPsaSF0ikKnmWxq/Bl0AhB+pElrcO8eabFRt
         20IMFX6kyDcCw==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Uladzislau Rezki <urezki@gmail.com>, rcu <rcu@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH 02/18] srcu: Fix error handling in init_srcu_struct_fields()
Date:   Fri, 13 Oct 2023 13:58:46 +0200
Message-Id: <20231013115902.1059735-3-frederic@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231013115902.1059735-1-frederic@kernel.org>
References: <20231013115902.1059735-1-frederic@kernel.org>
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

From: "Joel Fernandes (Google)" <joel@joelfernandes.org>

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
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
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
2.34.1

