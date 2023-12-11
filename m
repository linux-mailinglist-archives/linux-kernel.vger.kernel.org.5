Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DE5F80BEF9
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 03:13:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232303AbjLKB50 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 20:57:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjLKB5Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 20:57:24 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA82EE5
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 17:57:30 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id ca18e2360f4ac-7b6fc474d16so168517639f.1
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 17:57:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1702259849; x=1702864649; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/Vr+YzVHJ/mPJrnzMDjXJsm4sTrJoVDHcdAw1WNnfhs=;
        b=o92bPhVgbk4+YC5frbcvgO0CTMoUE0sUyyXnbwH+wCFtUN6ib9YMCx0tp8EOYws4C1
         i7pN14jEvQUfKBdfvVJ3GhT7GzpAqoOF6sEGmVU40vHAt4pTuJYP2bNG4tkKcwbbZupN
         Nuom+jKi1EpuYFxmOY6M2q6xjvv+chr+00EE8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702259849; x=1702864649;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/Vr+YzVHJ/mPJrnzMDjXJsm4sTrJoVDHcdAw1WNnfhs=;
        b=FzQdHbde93OAislZu9S3XLOSmRH8oOlgayasCM+PgM4lpN61dXui9gWAFVtH/tuMOd
         QmvjMVQn57Nyns1k+KfnjBFqLube39O84SPdD105yw7zTtTdm09sAOFxCc2Qf/nbyqFD
         NQu88iUbyrAEAIgEr3aaQoj4Icu0wby9QoyhJwF8JX0vh0srH42rpzBA8td2cknFuv6q
         h9wkiQw4oODXpA5b0PO7jtgLY3gYOC+TJ2Ozdnat3Nki7UBaxs3AZHgEVQ/Hl2+eSP/D
         G1bbjlimxIWu9ka2m+53igKtrQcGcfmIIsVTmHq7m1J3kYQzLdL6Bum9PnqVoro2ox2z
         wIoA==
X-Gm-Message-State: AOJu0Yy5xOoLqmKkJ1ihuIjvp5n5ExD1sAyuQgc8uQD0vl1LAX360Iwa
        zrG0HRaNdN4L4MVCJjZu6yhk+BiD+f6q/o7gWz0=
X-Google-Smtp-Source: AGHT+IFnO0bKn5i2P1O8YLdvk4Da1GGmaNBPL6L8dgKEQo7Tbfw6V9d/9SYoyqYp1nMH3ueuW9QIBw==
X-Received: by 2002:a6b:4115:0:b0:7b4:28f8:d0 with SMTP id n21-20020a6b4115000000b007b428f800d0mr5524811ioa.25.1702259849093;
        Sun, 10 Dec 2023 17:57:29 -0800 (PST)
Received: from joelboxx5.c.googlers.com.com (74.120.171.34.bc.googleusercontent.com. [34.171.120.74])
        by smtp.gmail.com with ESMTPSA id h11-20020a056602130b00b007b74680132esm474248iov.38.2023.12.10.17.57.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Dec 2023 17:57:28 -0800 (PST)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <neeraj.iitr10@gmail.com>, rcu@vger.kernel.org
Subject: [PATCH v2] srcu: Improve comments about acceleration leak
Date:   Mon, 11 Dec 2023 01:57:16 +0000
Message-ID: <20231211015717.1067822-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The comments added in commit 1ef990c4b36b ("srcu: No need to
advance/accelerate if no callback enqueued") are a bit confusing to me.
The comments are describing a scenario for code that was moved and is
no longer the way it was (snapshot after advancing). Improve the code
comments to reflect this and also document by acceleration can never
fail.

Cc: Frederic Weisbecker <frederic@kernel.org>
Cc: Neeraj Upadhyay <neeraj.iitr10@gmail.com>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
v1->v2: Fix typo in change log.

 kernel/rcu/srcutree.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 0351a4e83529..051e149490d1 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -1234,11 +1234,20 @@ static unsigned long srcu_gp_start_if_needed(struct srcu_struct *ssp,
 	if (rhp)
 		rcu_segcblist_enqueue(&sdp->srcu_cblist, rhp);
 	/*
-	 * The snapshot for acceleration must be taken _before_ the read of the
-	 * current gp sequence used for advancing, otherwise advancing may fail
-	 * and acceleration may then fail too.
+	 * It's crucial to capture the snapshot 's' for acceleration before
+	 * reading the current gp_seq that is used for advancing. This is
+	 * essential because if the acceleration snapshot is taken after a
+	 * failed advancement attempt, there's a risk that a grace period may
+	 * conclude and a new one may start in the interim. If the snapshot is
+	 * captured after this sequence of events, the acceleration snapshot 's'
+	 * could be excessively advanced, leading to acceleration failure.
+	 * In such a scenario, an 'acceleration leak' can occur, where new
+	 * callbacks become indefinitely stuck in the RCU_NEXT_TAIL segment.
+	 * Also note that encountering advancing failures is a normal
+	 * occurrence when the grace period for RCU_WAIT_TAIL is in progress.
 	 *
-	 * This could happen if:
+	 * To see this, consider the following events which occur if
+	 * rcu_seq_snap() were to be called after advance:
 	 *
 	 *  1) The RCU_WAIT_TAIL segment has callbacks (gp_num = X + 4) and the
 	 *     RCU_NEXT_READY_TAIL also has callbacks (gp_num = X + 8).
@@ -1264,6 +1273,13 @@ static unsigned long srcu_gp_start_if_needed(struct srcu_struct *ssp,
 	if (rhp) {
 		rcu_segcblist_advance(&sdp->srcu_cblist,
 				      rcu_seq_current(&ssp->srcu_sup->srcu_gp_seq));
+		/*
+		 * Acceleration can never fail because the state of gp_seq used
+		 * for advancing is <= the state of gp_seq used for
+		 * acceleration. This means that RCU_NEXT_TAIL segment will
+		 * always be able to be emptied by the acceleration into the
+		 * RCU_NEXT_READY_TAIL or RCU_WAIT_TAIL segments.
+		 */
 		WARN_ON_ONCE(!rcu_segcblist_accelerate(&sdp->srcu_cblist, s));
 	}
 	if (ULONG_CMP_LT(sdp->srcu_gp_seq_needed, s)) {
-- 
2.43.0.472.g3155946c3a-goog

