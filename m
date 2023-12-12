Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8BEB80F4C7
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 18:41:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376893AbjLLRkz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 12:40:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235127AbjLLRki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 12:40:38 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 420C1B9;
        Tue, 12 Dec 2023 09:40:43 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1d08a924fcfso54654525ad.2;
        Tue, 12 Dec 2023 09:40:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702402842; x=1703007642; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+hVYCAI2p7S4gpzlrrN9H99T+gyz5l3W/ngLbHdWIEo=;
        b=OCM2och8DqNHnDY2/UUWsGzcmowjOpGVCwtjbdHPEOUtHDT0+9fo/JzRp+aqAhFFNE
         UGNjkIqMQ9Q3+RgQSUP1gHcGOiEinhmcG6dC8JpCDP66YdHrp+GZ4lkXZI+h0f/b8uga
         ea2xjFsU8XPgapZ0VJHl8teOZ95AoKVhjCH01h25yMw+tFssuyFP6Z1gH7QkKAFeBU+q
         v+mLL+5GSaUC5qH2A7qr13CcX0wTi5EZLq1MZFV2zRq6AuwKYTmDEj69nlSFKUOmfR01
         A+tyqHMjG4LuJireZHpWA3sFX9ZVRCFCARpSYIuYTBqzPuMKNyVNFtSjy5DOURCnoANA
         cPxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702402842; x=1703007642;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+hVYCAI2p7S4gpzlrrN9H99T+gyz5l3W/ngLbHdWIEo=;
        b=iB3IHnOeysgUD0W5b7pbTtzlTrhorN/phZ+h61hANlEInkfXbWSmUJEeNnoSvnEif2
         +PxBf52qqjgNRzmKLZnatYjfIvfGKSfNaWyI5RP4b9NFwp4Tb4t4MOV3EQGZZO+kDWIP
         9oDZEZRIrY+Bxk8GmeXZWN+DuJIgaJo/QHHWnkeNs3fGQGAzMZC3GlqY4eH1gmRxZvUG
         5O58BMsiF6h5EkfeYUDxtIXJCTNjTQ8yA495YKXgtrylAL7Tz6MOg/lg1w8/WSQnczAf
         ckj3tAV0jqMMfGx8uDZr5j/bY5ZOsduovZCtqOsUE3ZOfVqYHV+UfPlGTWez97XKCbut
         g22w==
X-Gm-Message-State: AOJu0YxRb1l/LQFcfqLdhbRa5meW5eeFrDekhxbLFFsd0Up+Nu+uWAWx
        RJR1ulRK2HWDIhiTEaJdPFOrJ+Dz5ZHVW4S5
X-Google-Smtp-Source: AGHT+IEqiUuAayQvAwz5Tqis+nTCZ6fx/x3J3Ye/XIu03msGYuEq51Dc7OEnEDlhsaD7wtOmp2zaPQ==
X-Received: by 2002:a17:90a:df08:b0:28a:bf3f:e69d with SMTP id gp8-20020a17090adf0800b0028abf3fe69dmr1077249pjb.44.1702402841714;
        Tue, 12 Dec 2023 09:40:41 -0800 (PST)
Received: from localhost.localdomain ([101.0.63.152])
        by smtp.gmail.com with ESMTPSA id jc19-20020a17090325d300b001cc25cfec58sm8903135plb.226.2023.12.12.09.40.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 09:40:41 -0800 (PST)
From:   "Neeraj Upadhyay (AMD)" <neeraj.iitr10@gmail.com>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, paulmck@kernel.org, Neeraj.Upadhyay@amd.com,
        Zqiang <qiang.zhang1211@gmail.com>,
        Neeraj Upadhyay <neeraj.iitr10@gmail.com>
Subject: [PATCH rcu 3/3] rcu: Force quiescent states only for ongoing grace period
Date:   Tue, 12 Dec 2023 23:10:04 +0530
Message-Id: <20231212174004.11754-3-neeraj.iitr10@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231212173948.GA11724@neeraj.linux>
References: <20231212173948.GA11724@neeraj.linux>
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

From: Zqiang <qiang.zhang1211@gmail.com>

If an rcutorture test scenario creates an fqs_task kthread, it will
periodically invoke rcu_force_quiescent_state() in order to start
force-quiescent-state (FQS) operations.  However, an FQS operation
will be started even if there is no RCU grace period in progress.
Although testing FQS operations startup when there is no grace period in
progress is necessary, it need not happen all that often.  This commit
therefore causes rcu_force_quiescent_state() to take an early exit
if there is no grace period in progress.

Note that there will still be attempts to start an FQS scan in the
absence of a grace period because the grace period might end right
after the rcu_force_quiescent_state() function's check.  In actual
testing, this happens about once every ten minutes, which should
provide adequate testing.

Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Neeraj Upadhyay (AMD) <neeraj.iitr10@gmail.com>
---
 kernel/rcu/tree.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 3ac3c846105f..1ae851777806 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2338,6 +2338,8 @@ void rcu_force_quiescent_state(void)
 	struct rcu_node *rnp;
 	struct rcu_node *rnp_old = NULL;
 
+	if (!rcu_gp_in_progress())
+		return;
 	/* Funnel through hierarchy to reduce memory contention. */
 	rnp = raw_cpu_read(rcu_data.mynode);
 	for (; rnp != NULL; rnp = rnp->parent) {
-- 
2.40.1

