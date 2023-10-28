Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B408C7DA664
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Oct 2023 12:23:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbjJ1KXP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Oct 2023 06:23:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbjJ1KXN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Oct 2023 06:23:13 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05F0CFC
        for <linux-kernel@vger.kernel.org>; Sat, 28 Oct 2023 03:23:11 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id ca18e2360f4ac-7a680e6a921so33405839f.1
        for <linux-kernel@vger.kernel.org>; Sat, 28 Oct 2023 03:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698488590; x=1699093390; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kb55IUehlVDFui1W5Bu4cGzv/u+VjTYYaWK8F7NZpEw=;
        b=casQPkA30IyE/MyqqHLmzGeMJs0JzMWhWs0hSSP8EkuriItkxmNpPtRxDSsZjMIPKO
         G18zhFwbWI1DeemfLuOau3NoVFVZ6te2DoDXky8jH7+Cyia4sKJfqHr2GsRic0oLkIZv
         bhEfrNQTP0iF/ET9rsT8/ZamkucoiQ4pMmKYp2PlTPdhpLbCGpYiEDtZ3slmIZaIPRbH
         ChSWWF4hIKWXtmRM7ll/G4rZYi7d/HbtRatSW3YBm49sVigE2N8zpEQHsTPJmNdWU8+O
         9Tl4np++M0mzC5QBo1RA5ZuYjNkVgwoJ3pF+1hKtARB469lYBZCz7CX6r9Fh6gtoI9tm
         G7xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698488590; x=1699093390;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kb55IUehlVDFui1W5Bu4cGzv/u+VjTYYaWK8F7NZpEw=;
        b=k3zE3Cbm9PU3U+e3UbNz33GK+GptRrXLes21n1h3L6q4Kjnpc6jLfw/hbnuKwVWkgm
         scdZGWTFkvMawHePIb0CGV1rn+FhsOIF+Sw5uVF06ohgV6Gm3/NtuY0tTGULYfj25qQF
         /DRR5GpOi458LV/rSLsKdGEtdBuR0sRr/nrdE5TbWn2ZLsq1+V8/TMXaiaXXJgsq8+1l
         fGDBFKjnp2yakfC1rZqNXOa1DiipEzFPUz3QlF0la5a2yHqHwJ5VtVy0hd5wHyXuSA/8
         feUxVd/E0emLAutBZP5JfJjsb4HXbEaeP79nfcDSE+9jF1SeQysqy/G4+w1ro6hMNo00
         JiXw==
X-Gm-Message-State: AOJu0Yz8t2irlWstZfJkdtPDUrF8NDRAgN9jvwZqVLyec88f/AoUTcR0
        hlnjDw+LVUtEh02Z0DMjyYA=
X-Google-Smtp-Source: AGHT+IHeixX1hbPYYC1zBSVSB2/SC6Alo2uqS0ckaaWewKEhn82kZj6BhgrRpooEQkU8idBvXmwU2g==
X-Received: by 2002:a92:d38f:0:b0:357:a23c:b99b with SMTP id o15-20020a92d38f000000b00357a23cb99bmr5577483ilo.3.1698488590152;
        Sat, 28 Oct 2023 03:23:10 -0700 (PDT)
Received: from abhinav.. ([103.75.161.210])
        by smtp.gmail.com with ESMTPSA id u188-20020a6379c5000000b0057c29fec795sm2187640pgc.37.2023.10.28.03.23.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Oct 2023 03:23:09 -0700 (PDT)
From:   Abhinav Singh <singhabhinav9051571833@gmail.com>
To:     akpm@linux-foundation.org, brauner@kernel.org, surenb@google.com,
        mst@redhat.com, michael.christie@oracle.com,
        mathieu.desnoyers@efficios.com, mjguzik@gmail.com,
        npiggin@gmail.com, shakeelb@google.com, peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Abhinav Singh <singhabhinav9051571833@gmail.com>
Subject: [PATCH v3] Fixing directly deferencing a __rcu pointer warning
Date:   Sat, 28 Oct 2023 15:52:47 +0530
Message-Id: <20231028102247.404488-1-singhabhinav9051571833@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231027122221.GA24128@redhat.com>
References: <20231027122221.GA24128@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
pointer. This function returns the non __rcu tagged pointer which
can be dereferenced just like a normal pointer.

Signed-off-by: Abhinav Singh <singhabhinav9051571833@gmail.com>
---
v1 -> v2 : added rcu_dereference(...) at line 2694
v2 -> v3 : added rcu_dereference(...) at line 2695

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

