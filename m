Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B51377D1FD
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 20:39:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239174AbjHOSig (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 14:38:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239231AbjHOSiP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 14:38:15 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5E361FCE;
        Tue, 15 Aug 2023 11:38:10 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4fe1b00fce2so8547068e87.3;
        Tue, 15 Aug 2023 11:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692124689; x=1692729489;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4YJdY3GQFeB1iPWfE21MENyRveBHqJ2bQXsYhMqaqNs=;
        b=jqZ1Qnztra5zzKL7pKzwp1m8JUM+DWATFg0LqTqR1HpEWzC+rydke/J7ygTMcLm3z0
         kwiqfa8LdKZ55Qm5sE4TrSe8dYwRCJ3IeA9AH/e6Oa+dnuQlRshOrxgOctUtLDvVIbHZ
         FsoQDAkjF0S0UIoGyYxBAw+yLZXGtJx0B9YGudtZSooZdrHee4jh/llvrK9dbHDbwAz2
         L+IU8EDH1+T2VEtyzBfgRHHgdsEWK8m3T8N9YIYeHh21KVClPqU969gnyO5ajSQJjjU3
         lf+G0fBu1h/5H9MfAB5mI/3UsY9Ku5q88+0079KX4uU17zzVfFxog8IbuL/NUSxXFKMK
         oL4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692124689; x=1692729489;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4YJdY3GQFeB1iPWfE21MENyRveBHqJ2bQXsYhMqaqNs=;
        b=iQlnGGmf2zVEG1bzUUxeO8m//4QoLQk84oFNgW6CkzgCqf/t97ViWjRVEnmfZpsgSl
         BBUw3Nzc77a/2ntRYT2PIg5M7D4gVNl1Cz3cnsPMmSpUapVGION8zjth9ZUlb/69MAzB
         bpE3Slku9mfToGjEsKC6k+Td5fNkzlfDA5eifI9i0ohG3zVUKp4B9F8XtwjxWizlesWx
         tnFGf0xJ3+hTBaJh0JyDKtp/KPrOeyM2CoDDT3APLHo2ahzPkPBlUSK5NlH+2uSD393v
         Fnihtn+ub6vJgMK59d+nc+gLrCNzqY0KwLXlzkss13PU8lTTSPsxOSuVF4ogUEOOhBTj
         OWmw==
X-Gm-Message-State: AOJu0Yxt648/2n3syz+E6X2+sHLMIdGcEy/ka+RjbqJjdXREI6oybq9h
        qkJUUCpLX8J4888SSTYNFX2T85rMrCxs2w==
X-Google-Smtp-Source: AGHT+IGAxUqmjRBq+AaVWc8MKqYHI/ETVfCUYtRL3ZbwRWUoVCmGJDJfM8mg79Tg5k0ErvM63f0aFg==
X-Received: by 2002:a05:6512:10d4:b0:4fe:25bc:71f5 with SMTP id k20-20020a05651210d400b004fe25bc71f5mr10112355lfg.11.1692124688731;
        Tue, 15 Aug 2023 11:38:08 -0700 (PDT)
Received: from f.. (cst-prg-75-195.cust.vodafone.cz. [46.135.75.195])
        by smtp.gmail.com with ESMTPSA id b24-20020aa7dc18000000b005233647bc4csm7197869edu.59.2023.08.15.11.38.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Aug 2023 11:38:08 -0700 (PDT)
From:   Mateusz Guzik <mjguzik@gmail.com>
To:     linux-security-module@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Mateusz Guzik <mjguzik@gmail.com>
Subject: [RESEND PATCH] cred: add get_cred_many and put_cred_many
Date:   Tue, 15 Aug 2023 20:37:59 +0200
Message-Id: <20230815183759.1821357-1-mjguzik@gmail.com>
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

