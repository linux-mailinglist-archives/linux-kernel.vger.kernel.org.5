Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8770B772AE0
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 18:31:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbjHGQbq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 12:31:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjHGQbo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 12:31:44 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C082172A
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 09:31:20 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2b9cbaee7a9so76420261fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 09:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691425821; x=1692030621;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4YJdY3GQFeB1iPWfE21MENyRveBHqJ2bQXsYhMqaqNs=;
        b=bud6gN/t8XSLO8U7xhVgJsxkJbTLTumJZ3cwqonbSPcqmJZKWDlYaKV5DHPrxuU0ct
         NecgEDbhmXMCPOKz71g4zgwIUvMvmYBdnOrZS1DLD3o+RTfjUSi4uXq0jt4K9tFfKgTE
         I98vyS/Kyazu9ASQ6Tni4YKr0DOOwxoql2GDoEfPUefntb+xlAP5IG/O3KWa16jtKFLo
         /peIzGTRy9XLXBdw7WlJX8elHsuEWzyNqua9ZX84jo9rFsbis2+7PJaEoyJoloLB0DRM
         FwMDyKx90u83xosKpkv8+wz9XAiHZNfmaUjMqXBWj9OVE2pk4rM1lA8f+3xN/NGvbkO3
         GWGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691425821; x=1692030621;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4YJdY3GQFeB1iPWfE21MENyRveBHqJ2bQXsYhMqaqNs=;
        b=cERAPtS1dEpozCMOrKvCmDZsbDD061a5Xi1q/UA2tjr0UkuI+U9a9ui6aglEf0GYh1
         Mki8UkUjAufW/GMXwlDioeMG8duOICO2a+52AXUbZMN2o66VvcQbGHM246J8Pmee/DOG
         T6BK0jequfVsiPy3rdwRSwtx2JbXquvt+G4ZNM+qNiFqaCNdfIebF9kofCFx6II5xREp
         YiTWPT1SuI1Qpf+ubojDpWoyxVzZQ51Awg3V+yg+fVIk4jYv60QtThNJqOmTHVKfUTDz
         nZGMBBWo7jCXOgbgQg1RTgSnp7bfOdvTu6v4ODu7IImpVLqoEJizEPUarIkZL0kFTbPI
         8vWw==
X-Gm-Message-State: AOJu0Yx8eVCBDMBghcoZ260uMbj9WyLOeLkszZIuYRSXceXcAQ1uCSUp
        IhLh1SO2f4zpVxVi2DzTr94=
X-Google-Smtp-Source: AGHT+IEXhrOmdBHpN5Q/bIH9nNrrHfqrgV5o9e7LcLLVXhYvdjOFkZFkSL5OYTbgiR6Cg8CGLsppgw==
X-Received: by 2002:a2e:9dc7:0:b0:2b9:ea17:5580 with SMTP id x7-20020a2e9dc7000000b002b9ea175580mr7062788ljj.17.1691425820702;
        Mon, 07 Aug 2023 09:30:20 -0700 (PDT)
Received: from f.. (cst-prg-21-219.cust.vodafone.cz. [46.135.21.219])
        by smtp.gmail.com with ESMTPSA id b3-20020a170906038300b0098e42bef732sm5389418eja.183.2023.08.07.09.30.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 09:30:19 -0700 (PDT)
From:   Mateusz Guzik <mjguzik@gmail.com>
To:     dhowells@redhat.com, keescook@chromium.org
Cc:     linux-kernel@vger.kernel.org, Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH] cred: add get_cred_many and put_cred_many
Date:   Mon,  7 Aug 2023 18:30:14 +0200
Message-Id: <20230807163014.1425738-1-mjguzik@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Shaves back-to-back atomics in a few places.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---
 include/linux/cred.h | 27 +++++++++++++++++++++------
 kernel/cred.c        | 29 +++++++++++++++++------------
 2 files changed, 38 insertions(+), 18 deletions(-)

diff --git a/include/linux/cred.h b/include/linux/cred.h
index 9ed9232af934..b2b570ba204a 100644
--- a/include/linux/cred.h
+++ b/include/linux/cred.h
@@ -226,12 +226,17 @@ static inline bool cap_ambient_invariant_ok(const struct cred *cred)
  * Get a reference on the specified set of new credentials.  The caller must
  * release the reference.
  */
-static inline struct cred *get_new_cred(struct cred *cred)
+static inline struct cred *get_new_cred_many(struct cred *cred, int nr)
 {
-	atomic_inc(&cred->usage);
+	atomic_add(nr, &cred->usage);
 	return cred;
 }
 
+static inline struct cred *get_new_cred(struct cred *cred)
+{
+	return get_new_cred_many(cred, 1);
+}
+
 /**
  * get_cred - Get a reference on a set of credentials
  * @cred: The credentials to reference
@@ -245,14 +250,19 @@ static inline struct cred *get_new_cred(struct cred *cred)
  * accidental alteration of a set of credentials that should be considered
  * immutable.
  */
-static inline const struct cred *get_cred(const struct cred *cred)
+static inline const struct cred *get_cred_many(const struct cred *cred, int nr)
 {
 	struct cred *nonconst_cred = (struct cred *) cred;
 	if (!cred)
 		return cred;
 	validate_creds(cred);
 	nonconst_cred->non_rcu = 0;
-	return get_new_cred(nonconst_cred);
+	return get_new_cred_many(nonconst_cred, nr);
+}
+
+static inline const struct cred *get_cred(const struct cred *cred)
+{
+	return get_cred_many(cred, 1);
 }
 
 static inline const struct cred *get_cred_rcu(const struct cred *cred)
@@ -278,17 +288,22 @@ static inline const struct cred *get_cred_rcu(const struct cred *cred)
  * on task_struct are attached by const pointers to prevent accidental
  * alteration of otherwise immutable credential sets.
  */
-static inline void put_cred(const struct cred *_cred)
+static inline void put_cred_many(const struct cred *_cred, int nr)
 {
 	struct cred *cred = (struct cred *) _cred;
 
 	if (cred) {
 		validate_creds(cred);
-		if (atomic_dec_and_test(&(cred)->usage))
+		if (atomic_sub_and_test(nr, &cred->usage))
 			__put_cred(cred);
 	}
 }
 
+static inline void put_cred(const struct cred *cred)
+{
+	put_cred_many(cred, 1);
+}
+
 /**
  * current_cred - Access the current task's subjective credentials
  *
diff --git a/kernel/cred.c b/kernel/cred.c
index 811ad654abd1..8a506bc7c1b8 100644
--- a/kernel/cred.c
+++ b/kernel/cred.c
@@ -159,23 +159,30 @@ EXPORT_SYMBOL(__put_cred);
  */
 void exit_creds(struct task_struct *tsk)
 {
-	struct cred *cred;
+	struct cred *real_cred, *cred;
 
 	kdebug("exit_creds(%u,%p,%p,{%d,%d})", tsk->pid, tsk->real_cred, tsk->cred,
 	       atomic_read(&tsk->cred->usage),
 	       read_cred_subscribers(tsk->cred));
 
-	cred = (struct cred *) tsk->real_cred;
+	real_cred = (struct cred *) tsk->real_cred;
 	tsk->real_cred = NULL;
-	validate_creds(cred);
-	alter_cred_subscribers(cred, -1);
-	put_cred(cred);
 
 	cred = (struct cred *) tsk->cred;
 	tsk->cred = NULL;
-	validate_creds(cred);
-	alter_cred_subscribers(cred, -1);
-	put_cred(cred);
+
+	if (real_cred == cred) {
+		validate_creds(cred);
+		alter_cred_subscribers(cred, -2);
+		put_cred_many(cred, 2);
+	} else {
+		validate_creds(real_cred);
+		validate_creds(cred);
+		alter_cred_subscribers(real_cred, -1);
+		put_cred(real_cred);
+		alter_cred_subscribers(cred, -1);
+		put_cred(cred);
+	}
 
 #ifdef CONFIG_KEYS_REQUEST_CACHE
 	key_put(tsk->cached_requested_key);
@@ -352,8 +359,7 @@ int copy_creds(struct task_struct *p, unsigned long clone_flags)
 #endif
 		clone_flags & CLONE_THREAD
 	    ) {
-		p->real_cred = get_cred(p->cred);
-		get_cred(p->cred);
+		p->real_cred = get_cred_many(p->cred, 2);
 		alter_cred_subscribers(p->cred, 2);
 		kdebug("share_creds(%p{%d,%d})",
 		       p->cred, atomic_read(&p->cred->usage),
@@ -517,8 +523,7 @@ int commit_creds(struct cred *new)
 		proc_id_connector(task, PROC_EVENT_GID);
 
 	/* release the old obj and subj refs both */
-	put_cred(old);
-	put_cred(old);
+	put_cred_many(old, 2);
 	return 0;
 }
 EXPORT_SYMBOL(commit_creds);
-- 
2.39.2

