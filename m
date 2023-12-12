Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4061D80F4E1
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 18:48:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377001AbjLLRsp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 12:48:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377004AbjLLRsn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 12:48:43 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D641F83;
        Tue, 12 Dec 2023 09:48:49 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1d03bcf27e9so36314725ad.0;
        Tue, 12 Dec 2023 09:48:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702403329; x=1703008129; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nkU8r/Y5CKJ4k3AvWmhHYljnGizcb7g2Kv2I06R4LwY=;
        b=R8bc4BioBTYCMyz2DdyJKXZxZto0bYhdEGMIVbRg/2WIAWTx70VeICDRfvyC8ZCdrH
         bo3naoCTbDqHq3yQf7WuqYTQYy/H5GbUcNsx76Dqd2eVjy+630l2bJRx+kDY8L1o++Fg
         bk6wSFEG5Frv84S6CQwxk70qwElT3Exe7bea8coYkmOxzTRyIYFmIaMwO55NXxscSeCH
         u8X14cjAMt9PJIHNp6nuL76Z16izXYqXiolnfbhBkZO1e8Ph+RAton2nDd52sOI2GJWj
         Be3DWOCcL9O9jbfq41LYIlE/kuKhEl4SvYeYgMOr1wU2cTHXRyLxAjxuhcT+MVm8nBjD
         S/5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702403329; x=1703008129;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nkU8r/Y5CKJ4k3AvWmhHYljnGizcb7g2Kv2I06R4LwY=;
        b=bOpk5EbtREP1fvFxdmoexCV0JnxB9v1ABtm7q9qiOnnnbWM0eBuPQOOYJyibB+CKo2
         x1YHNOvBLCqo/3LbfHClAiFRnuXkTc2xuQ2x5eLFG/feCqxhssX/nlkpot4iq6adqtkM
         UFhdbxtz93tEWlv2oROkXVo7h/60gPcD/enPIVZ7jMxNpYF3tbZpTZyjcAghat+yvLe4
         EQ2lublm3OJhNsKKQ4ozMAZmbPTQ85gs+XrQMx6NbbQ6xCZoLxNqjKsWD8WKr4Na0aKg
         0FLsYXUhEzXYRgT3A91ImABqLMFWItnb56Er2lz7GKajXbRFqzQmjVlc3rxxo6+Exs/c
         pC4g==
X-Gm-Message-State: AOJu0Yyu/yCkWAo/RZ+ET70AoN8cgfEKkTk8Z+YCSquHoUcPCiL0b8kP
        h1Z4WuzW/eHf1BQc0k5juaSoLHRs4MMsIaCd
X-Google-Smtp-Source: AGHT+IGdpAkxhoSQdiTeUrIoVI3DwaBHDSrp+D1qX2xg14wlJophzhTnPos4dt5ubuXpd9pc8qA5Hw==
X-Received: by 2002:a17:902:e752:b0:1d0:b926:bbcd with SMTP id p18-20020a170902e75200b001d0b926bbcdmr4343131plf.54.1702403328722;
        Tue, 12 Dec 2023 09:48:48 -0800 (PST)
Received: from localhost.localdomain ([101.0.63.152])
        by smtp.gmail.com with ESMTPSA id l17-20020a170902eb1100b001d0b42fa98bsm8880871plb.4.2023.12.12.09.48.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 09:48:48 -0800 (PST)
From:   "Neeraj Upadhyay (AMD)" <neeraj.iitr10@gmail.com>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, paulmck@kernel.org, Neeraj.Upadhyay@amd.com,
        Frederic Weisbecker <frederic@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Neeraj Upadhyay <neeraj.iitr10@gmail.com>
Subject: [PATCH rcu 2/3] srcu: No need to advance/accelerate if no callback enqueued
Date:   Tue, 12 Dec 2023 23:18:16 +0530
Message-Id: <20231212174817.11919-2-neeraj.iitr10@gmail.com>
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

While in grace period start, there is nothing to accelerate and
therefore no need to advance the callbacks either if no callback is
to be enqueued.

Spare these needless operations in this case.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Neeraj Upadhyay (AMD) <neeraj.iitr10@gmail.com>
---
 kernel/rcu/srcutree.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index e9356a103626..2bfc8ed1eed2 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -1261,9 +1261,11 @@ static unsigned long srcu_gp_start_if_needed(struct srcu_struct *ssp,
 	 *     period (gp_num = X + 8). So acceleration fails.
 	 */
 	s = rcu_seq_snap(&ssp->srcu_sup->srcu_gp_seq);
-	rcu_segcblist_advance(&sdp->srcu_cblist,
-			      rcu_seq_current(&ssp->srcu_sup->srcu_gp_seq));
-	WARN_ON_ONCE(!rcu_segcblist_accelerate(&sdp->srcu_cblist, s) && rhp);
+	if (rhp) {
+		rcu_segcblist_advance(&sdp->srcu_cblist,
+				      rcu_seq_current(&ssp->srcu_sup->srcu_gp_seq));
+		WARN_ON_ONCE(!rcu_segcblist_accelerate(&sdp->srcu_cblist, s));
+	}
 	if (ULONG_CMP_LT(sdp->srcu_gp_seq_needed, s)) {
 		sdp->srcu_gp_seq_needed = s;
 		needgp = true;
-- 
2.40.1

