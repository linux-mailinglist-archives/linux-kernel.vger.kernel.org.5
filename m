Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 427717D8ED5
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 08:37:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345216AbjJ0Ghl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 02:37:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjJ0Ghj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 02:37:39 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E627E1BD
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 23:37:36 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1cc13149621so2864425ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 23:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698388656; x=1698993456; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SzSfttDbr69NJfAH/KFCN3jVkR7G3r+bHSvK7He6Rw8=;
        b=MBCI807YAzzmqA0wdG+axJWEAbb1J9VYs8gNpiTOT8LGn8SPjc38Ew4UgdvdtbRsLl
         MX6c/wNCjG4VLdUYVsP2rVhX+lfIayfz+GAxNoiw5NxxyluLEKsXCre+0kH7CCHI6kte
         I5rct+bQTkk/ueyBmblE5v9/EU12mt/SFPGwxHt2hFFMoG9aAwPoxZ+0Ec5U6DWhr0Rt
         Nu3ZxgKsMOruiJK3KA2TnSgyGW9NMyCjgW4uWtimlqzVUmp+9AY5hVFtzd6m1ls1SyfI
         moa3s2YohLe4TlZ6Ni1lshqlyI3H5PWTsnXsJyC9ryFb5StFvlDvczkt+6rXa1/Dz8bY
         NPTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698388656; x=1698993456;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SzSfttDbr69NJfAH/KFCN3jVkR7G3r+bHSvK7He6Rw8=;
        b=MW/g/lBb/d1O1U3Ekf0MVuZSWy2IDi5JkPsTzBND9Y2VeSYIg5hU/i0UU1uMiNXbv2
         dpw4VEWiH2vaT3sxN0Y9Xjr6+6n2ac/EHNi4BpQDX9iZ9E8k08EezXTBdaYwqsO1bsjL
         eaV6+S3comFVx6jYmKPBWUUGLIL5KuzNbLgg5sjod11E0XqErsvKLNssjsgf1+dQyZfV
         zwjKH9BHcqdmfNFjJbCdYHsAeYxdO7S3RaF3P9h7/qLAwaRcVNPf0L4KC0Tk3qoU1sR9
         3R40inKSKTHWESDXWJhVRFi/EHWXbgeEU9gG29rFbYERfCdodoc3QZqhkTzB62iMDhul
         kPvg==
X-Gm-Message-State: AOJu0Yzl1+srZI/mo3JdL2YQ00AyWbok9IhaZMeBiyt6iQyd+z5xlFWD
        LDlrzSe4pgVJuiuh5wsfPEE=
X-Google-Smtp-Source: AGHT+IH9cSlLevIWT6YZkinJxKgWDc1KwsWHT9iUrhTAkvOQBUVFy6ss4UVZnuJKaQun311Ybn/MiA==
X-Received: by 2002:a05:6a20:3c8d:b0:17b:170c:2d11 with SMTP id b13-20020a056a203c8d00b0017b170c2d11mr2283271pzj.6.1698388656266;
        Thu, 26 Oct 2023 23:37:36 -0700 (PDT)
Received: from abhinav.. ([103.75.161.208])
        by smtp.gmail.com with ESMTPSA id h7-20020aa796c7000000b006b2dff03b3csm632673pfq.113.2023.10.26.23.37.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 23:37:35 -0700 (PDT)
From:   Abhinav Singh <singhabhinav9051571833@gmail.com>
To:     akpm@linux-foundation.org, brauner@kernel.org, surenb@google.com,
        mst@redhat.com, michael.christie@oracle.com,
        mathieu.desnoyers@efficios.com, mjguzik@gmail.com,
        npiggin@gmail.com, shakeelb@google.com, peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Abhinav Singh <singhabhinav9051571833@gmail.com>
Subject: [PATCH v3] Fixing directly deferencing a __rcu pointer warning
Date:   Fri, 27 Oct 2023 12:07:13 +0530
Message-Id: <20231027063713.1018624-1-singhabhinav9051571833@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231026114632-mutt-send-email-mst@kernel.org>
References: <20231026114632-mutt-send-email-mst@kernel.org>
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
functions rcu_dereference(...) to use when dereferencing a __rcu
pointer. This functions returns the non __rcu tagged pointer which
can be dereferenced just like a normal pointers.


Signed-off-by: Abhinav Singh <singhabhinav9051571833@gmail.com>
---
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

