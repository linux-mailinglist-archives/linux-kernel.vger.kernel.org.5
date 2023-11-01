Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F21DF7DDB8E
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 04:35:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232602AbjKADfY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 23:35:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231924AbjKADfV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 23:35:21 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B63E7A4;
        Tue, 31 Oct 2023 20:35:19 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-6b77ab73c6fso369224b3a.1;
        Tue, 31 Oct 2023 20:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698809719; x=1699414519; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4AYaAfrBQMEF3rm9agZrtQ/weHtjQJC7TH+07CV4Lio=;
        b=hNiJFe2hWRWqcT8E4Pfk7GdFEFHdYU9ZVQqN5thpreM9DQsxXGBilzSmRdaTaFtnnp
         MHCTyw0fptKGNQVvDeq0PbLyMldSduERS2vOgptZ2GitMcle0rFisJOnhP2pdlXDgnPt
         74OpzzvWEi5akJyJd4uuXixsGiChIsdQI/IuLanuZ8f+OByL1068QwH6iiJD5qAxJ1fR
         pIqbCa9F7yUk1SZ3mYgxOmYCavPEn5pOOCDZnE7Er+325fsHXobORPekHooW/MUK5mZq
         E4nIl3w9HxNWylXZT82DYc8nbw5SI4jffYKzmFJWJsvwoy0NGO+PUhFdK2l7N2RgXWWG
         LCwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698809719; x=1699414519;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4AYaAfrBQMEF3rm9agZrtQ/weHtjQJC7TH+07CV4Lio=;
        b=Piy4V/ZkZ1TlVkDW0SrEXunr/nJM226/wBalUgkPhHWF8UaXLjcY6GSeEMHnU1o+eU
         nhwVyWyl9kiBCvyaShGJRKcXfn3GxEwPVJlB0URwyQSncBXlKZEC9QU5m9NwBJpa0Q+M
         EzrYFYbgSNdw2tObT8XTq27MaQ0Rmv0QQW9D5pYa7cD6HSoTVEAD8yK8V503IJMKN/8S
         Ggp3avSnacxgI5nlvGuBstct0477HYJ2fYwbETXkEx3F1oa+PbpBSSQaZ402auiuyhYN
         Io0iY446j3q2n90744x4payvPqyg3Qcuwpr7ZTmkSMVyTGwM+kIND55JOGCzgn4IonZL
         IwVA==
X-Gm-Message-State: AOJu0YysQ9FF2aNMbMWvnJB0FPck91kcGRNcW6IVx7Mf2SZLkHECtkj6
        M6pQUmVDzM1FVHQSh15bdaM=
X-Google-Smtp-Source: AGHT+IF3mX4zc556RUaR2jgd8ySpk0ygG0OmR8sbEjicvUr/Sl3cBWGb4IqIu4oDakMCiTY66/B9fQ==
X-Received: by 2002:a05:6a00:6ca1:b0:6c2:e263:5c3d with SMTP id jc33-20020a056a006ca100b006c2e2635c3dmr1528475pfb.0.1698809719082;
        Tue, 31 Oct 2023 20:35:19 -0700 (PDT)
Received: from MSCND1355B05.fareast.nevint.com ([183.242.39.186])
        by smtp.gmail.com with ESMTPSA id z3-20020aa785c3000000b0069ea08a2a99sm318749pfn.211.2023.10.31.20.35.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Oct 2023 20:35:18 -0700 (PDT)
From:   Zqiang <qiang.zhang1211@gmail.com>
To:     paulmck@kernel.org, frederic@kernel.org, joel@joelfernandes.org,
        boqun.feng@gmail.com
Cc:     qiang.zhang1211@gmail.com, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] rcu: Force quiescent states only for ongoing grace period
Date:   Wed,  1 Nov 2023 11:35:07 +0800
Message-Id: <20231101033507.21651-1-qiang.zhang1211@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, when running the rcutorture testing, if the fqs_task
kthread was created, the periodic fqs operations will be performed,
regardless of whether the grace-period is ongoing. however, if there
is no ongoing grace-period, invoke the rcu_force_quiescent_state() has
no effect, because when the new grace-period starting, will clear all
flags int rcu_state.gp_flags in rcu_gp_init(). this commit therefore add
rcu_gp_in_progress() check in rcu_force_quiescent_state(), if there is
no ongoing grace-period, return directly.

Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>
---
 kernel/rcu/tree.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index aa4c808978b8..5b4279ef66da 100644
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
2.17.1

