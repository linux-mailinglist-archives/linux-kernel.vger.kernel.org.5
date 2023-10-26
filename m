Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB3017D82A1
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 14:28:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344928AbjJZM2G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 08:28:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344904AbjJZM2F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 08:28:05 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CE6A192
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 05:28:03 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1cacbd54b05so1478755ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 05:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698323283; x=1698928083; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XO8QG8mtg640mQEHVkNaf9/uSEs9JeitYsu0UTItPaY=;
        b=lgZ7JEnAt5In/D2KRzJbpAPn5xAIFaxDzpf2iOFIVM64g7uDJj+Q/zTJJuojUbeHgz
         Z12QHUl9XVDIHbKd2WkVilKCMCRCIbpy29EOTBBhuLYUkdIhjp5vLDHHcILEXt+dQtZi
         tkQ4oSjyXbw5crQW2jyTMWGfpzoRNfZOtTzyknx1a6NmXqGS+JYfROfL2lVi9yxheJHg
         hS5lrZH0gY0/o5hFbZWZiDraO9S3ZEiC2Rgaz1mTvAT0LJEkbFY/HcSmNGhhDB+VuR4+
         GusYYzKSKrZgJTnX2RqvQE/xQqom483vWFCnoVwfjtng6cD5Q+rAknJtc2UJlfGy1Z84
         HUqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698323283; x=1698928083;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XO8QG8mtg640mQEHVkNaf9/uSEs9JeitYsu0UTItPaY=;
        b=IHir7ErRTQ5GK1cPH3nW4U/R1Oidzguo005XuaRhxC3o6Y8xkgP4JLAyJfPXl40+YB
         r1OIWBUdy6SsmmezRv1TP0fAVSazvacCeWH6AizqitGc2LF3DFai+YEMunWlSaNLtI6/
         DVPyhUQD1oUT/DVoWhOLSBQXVxz18Qg3l3Nl4cjJugdhajpMqfcz0YIUhsWmVRw4Ie4G
         kMMpvVWOth5jWOe1cogIneOap+yn1MMuUAAekG+gDSMFkyYHTGu7AQwtriWWtKCArp0L
         qrrVO0X/e/l111wZ+zkAsFsbesIbJouchHzk7JDzIEYJ+5v6Zg4RZJ83ysGOZfYvtjdo
         Rnkg==
X-Gm-Message-State: AOJu0YzGiSUe/TKTGOcvdgcYSEsUEQZCTxcmrDZ0QzqHseOJtw/r9bPU
        9RGJJt370ucJuOb4tdwPpS4=
X-Google-Smtp-Source: AGHT+IH1gymU2/FGsSj8zyAx/Aju3HVO9NonWPsq42FvYiLPy0FZ0P17oXb7rdiEvEs+blNOiSFOyQ==
X-Received: by 2002:a17:902:654d:b0:1ca:273d:22f with SMTP id d13-20020a170902654d00b001ca273d022fmr17306876pln.0.1698323282764;
        Thu, 26 Oct 2023 05:28:02 -0700 (PDT)
Received: from abhinav.. ([103.75.161.211])
        by smtp.gmail.com with ESMTPSA id 1-20020a170902c10100b001c44dbc92a2sm10850507pli.184.2023.10.26.05.27.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 05:28:02 -0700 (PDT)
From:   Abhinav Singh <singhabhinav9051571833@gmail.com>
To:     akpm@linux-foundation.org, brauner@kernel.org, surenb@google.com,
        mst@redhat.com, michael.christie@oracle.com,
        mathieu.desnoyers@efficios.com, mjguzik@gmail.com,
        npiggin@gmail.com, shakeelb@google.com, peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Abhinav Singh <singhabhinav9051571833@gmail.com>
Subject: [PATCH] Fixing directly deferencing a __rcu pointer warning
Date:   Thu, 26 Oct 2023 17:57:48 +0530
Message-Id: <20231026122748.359162-1-singhabhinav9051571833@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231025165002.64ab92e6d55d204b66e055f4@linux-foundation.org>
References: <20231025165002.64ab92e6d55d204b66e055f4@linux-foundation.org>
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
 kernel/fork.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index 10917c3e1f03..802b7bbe3d92 100644
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
@@ -2692,7 +2692,7 @@ __latent_entropy struct task_struct *copy_process(
 			 */
 			p->signal->has_child_subreaper = p->real_parent->signal->has_child_subreaper ||
 							 p->real_parent->signal->is_child_subreaper;
-			list_add_tail(&p->sibling, &p->real_parent->children);
+			list_add_tail(&p->sibling, &(rcu_dereference(p->real_parent)->children));
 			list_add_tail_rcu(&p->tasks, &init_task.tasks);
 			attach_pid(p, PIDTYPE_TGID);
 			attach_pid(p, PIDTYPE_PGID);
-- 
2.39.2

