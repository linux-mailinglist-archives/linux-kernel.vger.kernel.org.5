Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4C2D80F4E2
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 18:48:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377024AbjLLRsu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 12:48:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377026AbjLLRsr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 12:48:47 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4385EAB;
        Tue, 12 Dec 2023 09:48:54 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1d0897e99e0so34892675ad.3;
        Tue, 12 Dec 2023 09:48:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702403333; x=1703008133; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=btFMgkxywo8icROu0D3fMxutyCln5kSOeODGB3sFA/8=;
        b=Hovtu6L6rdxL/dcstSbje1s3PDnyAtd5s5WHkRMQXIWgA6OvB9ayCArB+fABzzQakX
         sxkfYNaEELD8X/rWfRIoTEAvNJx1iL3lq4QqcXSZG8z09TIuB73Uf+KxP4CPto/Vw4EQ
         4gEDKWOKwKoDBKuiG+y4+bO3Q56gib+kW7cAwDGAKCsWKNLyrdAccjzVIGfKKJElot31
         UxnyEmuLhCiuBlQ/hh81n0c8DMIk6h3wy5ZGQjpuRhv0zmB4KlvwYY0fGCBJNi3iYnQc
         ve6T7nSZDYVh9nnpQRv/F5J155+6Kcxh31RCJj8ymDnXKDWcUJm2+AhyTXKraHJoDseo
         MI3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702403333; x=1703008133;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=btFMgkxywo8icROu0D3fMxutyCln5kSOeODGB3sFA/8=;
        b=c4ytcBcjTSqlOCPrZbWCiqW8wT60XzKY1lMhP9myvFAbpuPhGYZdwtvEbYRuO087vB
         LxYyMF4o3+pjP9JiB99zBs/XUb/+ArSTEy2N5N/Vxw6XKHEHCJ/2B1XfaksTffddW/xh
         kSrQivGR5VRQoeDk4fRa50a8cb4tWuYNC9oc7Vgi498aAPfr5YqHFk5RAX7Wlh8l2CuN
         M4mB3UtHMSAeqAh+jBKjVlwmhZJ0Qfm7OWCL3LfrtLRugpF02RXCu2GB8j5WEmjcYXQ2
         Uixey+cSf//LbYWys+lwREBZlQmFcZdcmTseRYrEMUWMSQ3D3JVwEN7UK7hC+Htx8PRq
         5IRQ==
X-Gm-Message-State: AOJu0Ywv2XfNqAaLVz9yYxvzHYRzxYwrqda1qkzz149xsWtk64CwYfbf
        kn0xNa+turxcUFr9BPMy1BWjjgHe/A84hXXB
X-Google-Smtp-Source: AGHT+IF2FYbKe+vbMhBcMf71PvvDV88AaCRLwzE7NODtKKTCDPRq1ZkcMsRWJcA8R2zUcGXBL5n6zw==
X-Received: by 2002:a17:902:efc5:b0:1d0:cc54:85e2 with SMTP id ja5-20020a170902efc500b001d0cc5485e2mr3010887plb.21.1702403333073;
        Tue, 12 Dec 2023 09:48:53 -0800 (PST)
Received: from localhost.localdomain ([101.0.63.152])
        by smtp.gmail.com with ESMTPSA id l17-20020a170902eb1100b001d0b42fa98bsm8880871plb.4.2023.12.12.09.48.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 09:48:52 -0800 (PST)
From:   "Neeraj Upadhyay (AMD)" <neeraj.iitr10@gmail.com>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, paulmck@kernel.org, Neeraj.Upadhyay@amd.com,
        Frederic Weisbecker <frederic@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Neeraj Upadhyay <neeraj.iitr10@gmail.com>
Subject: [PATCH rcu 3/3] srcu: Explain why callbacks invocations can't run concurrently
Date:   Tue, 12 Dec 2023 23:18:17 +0530
Message-Id: <20231212174817.11919-3-neeraj.iitr10@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231212174750.GA11886@neeraj.linux>
References: <20231212174750.GA11886@neeraj.linux>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frederic Weisbecker <frederic@kernel.org>

If an SRCU barrier is queued while callbacks are running and a new
callbacks invocator for the same sdp were to run concurrently, the
RCU barrier might execute too early. As this requirement is non-obvious,
make sure to keep a record.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Neeraj Upadhyay (AMD) <neeraj.iitr10@gmail.com>
---
 kernel/rcu/srcutree.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 2bfc8ed1eed2..0351a4e83529 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -1715,6 +1715,11 @@ static void srcu_invoke_callbacks(struct work_struct *work)
 	WARN_ON_ONCE(!rcu_segcblist_segempty(&sdp->srcu_cblist, RCU_NEXT_TAIL));
 	rcu_segcblist_advance(&sdp->srcu_cblist,
 			      rcu_seq_current(&ssp->srcu_sup->srcu_gp_seq));
+	/*
+	 * Although this function is theoretically re-entrant, concurrent
+	 * callbacks invocation is disallowed to avoid executing an SRCU barrier
+	 * too early.
+	 */
 	if (sdp->srcu_cblist_invoking ||
 	    !rcu_segcblist_ready_cbs(&sdp->srcu_cblist)) {
 		spin_unlock_irq_rcu_node(sdp);
@@ -1745,6 +1750,7 @@ static void srcu_invoke_callbacks(struct work_struct *work)
 	sdp->srcu_cblist_invoking = false;
 	more = rcu_segcblist_ready_cbs(&sdp->srcu_cblist);
 	spin_unlock_irq_rcu_node(sdp);
+	/* An SRCU barrier or callbacks from previous nesting work pending */
 	if (more)
 		srcu_schedule_cbs_sdp(sdp, 0);
 }
-- 
2.40.1

