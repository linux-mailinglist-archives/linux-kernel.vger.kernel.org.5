Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C615680F4E0
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 18:48:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376904AbjLLRsm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 12:48:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233101AbjLLRsk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 12:48:40 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B47793;
        Tue, 12 Dec 2023 09:48:46 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1d0897e99e0so34891605ad.3;
        Tue, 12 Dec 2023 09:48:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702403325; x=1703008125; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G3OUBl8PInHDk+EeLZROk+XnMSbBZv0NI2vC5EMY4Yw=;
        b=LrBqFtUIqrqlAHsZbfsBEkG9PjuhmY5wlIwoex3KxtuVFIKSnBb0bqR68bq9vGZJ3M
         fZDseTr+tzsi4bHzPte8i9kYIzKUJl5qmTVksXLa0cZ1kN4sfXwU3+FxT0GB/7c1CsMW
         jWG1HanLRDasQcWf/s/3tVvd6msWwU5OnyMg2EmuAIwvQTv3rUJyyrXbsYlOQPyoY0qP
         HEQwIIbQA13vqwo8DLKmuOvyFADfogSD85UIhYTN1VmOeOnnEFLevac5hyXh5CzzQesB
         Ftyi8y50nFLiHy2jGo0TT5HVz0w58IVeBptLZnf4UxLnTZBctYv7D1x382aVQyqHNH00
         EPHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702403325; x=1703008125;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G3OUBl8PInHDk+EeLZROk+XnMSbBZv0NI2vC5EMY4Yw=;
        b=aNWnmMw465Vry9N5reDSxe+BYl8eNW3odestr5HUqOExWhUHAJOcD1qPn4EUiVDPkz
         PzUTDZQbHIE5PvFtdUnh/9YL+3mKS85RBuwC+3k5RkdRISJPAED4o9hKkedR5XHlLg0r
         cfwi7YK1VEe4ODZMQC931m/P1UL0EbopODuHuhWxYrorr2Le37gvom3f8h5Be491SPBN
         C71Z35d7JHr4jWHfiJICL8aywWf5No6E8sf36w7P3TMu1YqU76YQVsYRii5aHAVCAxiP
         BqVoeVT+dG5dSTWl2YT6Wm9edhKGN/xfL0LIabBLTDB+ARVwtWGkDWMgtQ13G+OStOe1
         CKVg==
X-Gm-Message-State: AOJu0Yxp1fwkYwwEZ2GABStX6/Ubo+ezX88YHGrPCTGV+nGZ5FV6lGbi
        Xi+gkx1JaVkpchuY8Jv9q79QvYfIHWbg+Tuh
X-Google-Smtp-Source: AGHT+IGouXu/1nQCE7p7oral2r2qBfOVPWGdexBL6LrAOdHe8ZCg3wK1dbPwvf6lWAJKJQdkaBhQVA==
X-Received: by 2002:a17:902:778c:b0:1d0:aeda:9ad5 with SMTP id o12-20020a170902778c00b001d0aeda9ad5mr3032883pll.34.1702403324689;
        Tue, 12 Dec 2023 09:48:44 -0800 (PST)
Received: from localhost.localdomain ([101.0.63.152])
        by smtp.gmail.com with ESMTPSA id l17-20020a170902eb1100b001d0b42fa98bsm8880871plb.4.2023.12.12.09.48.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 09:48:44 -0800 (PST)
From:   "Neeraj Upadhyay (AMD)" <neeraj.iitr10@gmail.com>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, paulmck@kernel.org, Neeraj.Upadhyay@amd.com,
        Frederic Weisbecker <frederic@kernel.org>,
        Yong He <zhuangel570@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Neeraj Upadhyay <neeraj.iitr10@gmail.com>
Subject: [PATCH rcu 1/3] srcu: Remove superfluous callbacks advancing from srcu_gp_start()
Date:   Tue, 12 Dec 2023 23:18:15 +0530
Message-Id: <20231212174817.11919-1-neeraj.iitr10@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231212174750.GA11886@neeraj.linux>
References: <20231212174750.GA11886@neeraj.linux>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frederic Weisbecker <frederic@kernel.org>

Callbacks advancing on SRCU must be performed on two specific places:

1) On enqueue time in order to make room for the acceleration of the
   new callback.

2) On invocation time in order to move the callbacks ready to invoke.

Any other callback advancing callsite is needless. Remove the remaining
one in srcu_gp_start().

Co-developed-by: Yong He <zhuangel570@gmail.com>
Signed-off-by: Yong He <zhuangel570@gmail.com>
Co-developed-by: Joel Fernandes <joel@joelfernandes.org>
Signed-off-by: Joel Fernandes <joel@joelfernandes.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Co-developed-by: Neeraj Upadhyay (AMD) <neeraj.iitr10@gmail.com>
Signed-off-by: Neeraj Upadhyay (AMD) <neeraj.iitr10@gmail.com>
---
 kernel/rcu/srcutree.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 560e99ec5333..e9356a103626 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -772,20 +772,10 @@ EXPORT_SYMBOL_GPL(__srcu_read_unlock_nmisafe);
  */
 static void srcu_gp_start(struct srcu_struct *ssp)
 {
-	struct srcu_data *sdp;
 	int state;
 
-	if (smp_load_acquire(&ssp->srcu_sup->srcu_size_state) < SRCU_SIZE_WAIT_BARRIER)
-		sdp = per_cpu_ptr(ssp->sda, get_boot_cpu_id());
-	else
-		sdp = this_cpu_ptr(ssp->sda);
 	lockdep_assert_held(&ACCESS_PRIVATE(ssp->srcu_sup, lock));
 	WARN_ON_ONCE(ULONG_CMP_GE(ssp->srcu_sup->srcu_gp_seq, ssp->srcu_sup->srcu_gp_seq_needed));
-	spin_lock_rcu_node(sdp);  /* Interrupts already disabled. */
-	rcu_segcblist_advance(&sdp->srcu_cblist,
-			      rcu_seq_current(&ssp->srcu_sup->srcu_gp_seq));
-	WARN_ON_ONCE(!rcu_segcblist_segempty(&sdp->srcu_cblist, RCU_NEXT_TAIL));
-	spin_unlock_rcu_node(sdp);  /* Interrupts remain disabled. */
 	WRITE_ONCE(ssp->srcu_sup->srcu_gp_start, jiffies);
 	WRITE_ONCE(ssp->srcu_sup->srcu_n_exp_nodelay, 0);
 	smp_mb(); /* Order prior store to ->srcu_gp_seq_needed vs. GP start. */
-- 
2.40.1

