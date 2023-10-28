Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FD4E7DA956
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Oct 2023 22:55:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229486AbjJ1Urq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Oct 2023 16:47:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjJ1Uro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Oct 2023 16:47:44 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 512EFB8
        for <linux-kernel@vger.kernel.org>; Sat, 28 Oct 2023 13:47:42 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-6bd20c30831so803042b3a.1
        for <linux-kernel@vger.kernel.org>; Sat, 28 Oct 2023 13:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698526061; x=1699130861; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VpDOJLyU8MiY3ma65dn79lmcz6KLCXAwl31ARg43/8k=;
        b=aaiSaFa5r2K1CrnXL7xaQJavVuEAMxxQxWS6SkW2EKjKGZ3nqEAtBJ+IPyx9k7v2hB
         4ZU4KsGXnrJbUwwqBwmcMgyHiFJJ1v11W4lB9otsWivH8B6fJpvJzZcBdtrK9y54s1S3
         ov7MJ+v0+r7cs0ZsL5FmQsGpEPga1dYpxGoCHblMfcUjTPc5GQMjozg3WW9Gle2k3g3t
         fe3XOaFdn84MXz9aUAqDiNm8jXx1Iyw6u912ZNUXuL6N34ZnQE+TvlDQWxqIX6cgDtOg
         zFReNtcZThVQmi8isELZBbxMRefJ6uHiz7dfqHME0TOGGqErnBj8/DXnsB1u/XcbXpdf
         5c+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698526061; x=1699130861;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VpDOJLyU8MiY3ma65dn79lmcz6KLCXAwl31ARg43/8k=;
        b=vc5UBZsuKStVdtqcPWHcN/KMHdHQDEb97jCrTCHapPay7a+g9kqKRG7j5yyKjNIlnn
         Zgc1g1o11CNgNRVgQJ/ACxMEV7CRrkKpREwyghfuVDVzYv1VDQW00XOrmcKICdniVUKJ
         nfY8UdcD9AhjXTQ4m54gaDqmtrIM4t2TVuJAn3OTMOffPI3zSBmW2cC0yQFLwYjTxA0T
         4Ddi3WHmKG/5cP+S8fZzai6Hwj60/94cedTttLK9cbO64iTKY+a2XPZgxwZmKeckIorY
         acVm3sBHgiAiWkJZC/HcfuTt5vZJtFw/P8JXS6JGh8LtmTNrt51PF7TKER7sHtxv5F1W
         4+iA==
X-Gm-Message-State: AOJu0YwojM6lhFn2XbHB6/A/KbSZiJ8657qaR14oEKvINYRSJ53vp/kO
        xSIEhi/15KqeLoZ4WqeVeNY=
X-Google-Smtp-Source: AGHT+IHgmCGa+iM0HuEyly9OpQ7XusJhhgjc/45/fSDPdo/pKZN+Vo/ZmypHY7LVpk5J6VSz6v3wmA==
X-Received: by 2002:a17:903:2581:b0:1cc:3e45:ac1e with SMTP id jb1-20020a170903258100b001cc3e45ac1emr839464plb.6.1698526061323;
        Sat, 28 Oct 2023 13:47:41 -0700 (PDT)
Received: from abhinav.. ([103.75.161.208])
        by smtp.gmail.com with ESMTPSA id iw2-20020a170903044200b001ca86a9caccsm3611977plb.228.2023.10.28.13.47.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Oct 2023 13:47:40 -0700 (PDT)
From:   Abhinav Singh <singhabhinav9051571833@gmail.com>
To:     akpm@linux-foundation.org, brauner@kernel.org, surenb@google.com,
        mst@redhat.com, michael.christie@oracle.com,
        mathieu.desnoyers@efficios.com, mjguzik@gmail.com,
        npiggin@gmail.com, shakeelb@google.com, peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Abhinav Singh <singhabhinav9051571833@gmail.com>
Subject: [PATCH v3] Fixing directly deferencing a __rcu pointer warning
Date:   Sun, 29 Oct 2023 02:16:09 +0530
Message-Id: <20231028204609.426841-1-singhabhinav9051571833@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <93115738-6919-4855-81b7-eb9b2fc60137@gmail.com>
References: <93115738-6919-4855-81b7-eb9b2fc60137@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the warning about directly dereferencing a pointer
tagged with __rcu annotation.

Dereferencing the pointers tagged with __rcu directly should
always be avoided according to the docs. There is a rcu helper
function rcu_dereference(...) to use when dereferencing a __rcu
pointer inside rcu read side critical sections. This function 
returns the non __rcu tagged pointer which can be dereferenced 
just like a normal pointer.

Signed-off-by: Abhinav Singh <singhabhinav9051571833@gmail.com>
---

Link to original patch 
 https://lore.kernel.org/all/20231025222811.855336-1-singhabhinav9051571833@gmail.com/

Change from original -> v2 : 
 1. removed the null check before dereferencing the dereferenced rcu
    pointer at line 2372.
 2. added rcu_dereference(...) at line 2694
    
Changes from v2 -> v3 
 1. added rcu_dereference(...) at line 2693

 kernel/fork.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index 10917c3e1f03..e78649974669 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2369,7 +2369,7 @@ __latent_entropy struct task_struct *copy_process(
 
 	retval = -EAGAIN;
 	if (is_rlimit_overlimit(task_ucounts(p), UCOUNT_RLIMIT_NPROC, rlimit(RLIMIT_NPROC))) {
-		if (p->real_cred->user != INIT_USER &&
+		if (rcu_dereference(p->real_cred)->user != INIT_USER &&
 		    !capable(CAP_SYS_RESOURCE) && !capable(CAP_SYS_ADMIN))
 			goto bad_fork_cleanup_count;
 	}
@@ -2690,9 +2690,9 @@ __latent_entropy struct task_struct *copy_process(
 			 * tasklist_lock with adding child to the process tree
 			 * for propagate_has_child_subreaper optimization.
 			 */
-			p->signal->has_child_subreaper = p->real_parent->signal->has_child_subreaper ||
-							 p->real_parent->signal->is_child_subreaper;
-			list_add_tail(&p->sibling, &p->real_parent->children);
+			p->signal->has_child_subreaper = rcu_dereference(p->real_parent)->signal->has_child_subreaper ||
+							rcu_dereference(p->real_parent)->signal->is_child_subreaper;
+			list_add_tail(&p->sibling, &rcu_dereference(p->real_parent)->children);
 			list_add_tail_rcu(&p->tasks, &init_task.tasks);
 			attach_pid(p, PIDTYPE_TGID);
 			attach_pid(p, PIDTYPE_PGID);
-- 
2.39.2

