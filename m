Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 154B8799A8C
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 21:19:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242219AbjIITTs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Sep 2023 15:19:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230331AbjIITTr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Sep 2023 15:19:47 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D14471AA;
        Sat,  9 Sep 2023 12:19:42 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-52683da3f5cso4034788a12.3;
        Sat, 09 Sep 2023 12:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694287181; x=1694891981; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VCiyyGxHUfWj2a16BGYodmWe931Hll8Cz0TSaFHH9lw=;
        b=pcYcBHUa1ZOeFmlvLlLGJe32hsdS5pUtSTW99rbNWnuZzY8FRhIACbOrQ3jDEqEJO1
         LR3gooP4tu9T+376zemeTE3CruhYYF5eNmQ6bQ61rA2gH1ydYqB9BBDuMAdQ9BfNzzJS
         mWi308RskTk7WEqT3lVw2sCnA3VY1Es38vjfpoRzHF47b4T2M4TSZzCmmQNvvdh5bmnc
         5Z/lnFgjLwEXbwZAlerztiCz1cEVkMzX0NicB4DFw7fH1xYQsIAML5UXzak9kgz0N2bM
         efgOwWpvNQXQhlBbm7f8mJxosOBXR4C7If0sxWmxAWne3cq9qqd9FWNyU9SCarWHCDhg
         l4iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694287181; x=1694891981;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VCiyyGxHUfWj2a16BGYodmWe931Hll8Cz0TSaFHH9lw=;
        b=bfITykF9cW0Tts9bw1t7nEkUIO6VHPByxjsBP9mp8wqxXYxuWGIUnzqiqPpoARS6B4
         beM+RpZWMWkYGuCScmVYpM0fftR05Oe3PUrAEB+a4vVxyj+XKQlUal/F18dEkvlgDA1p
         Khpgzw0GBT2fT/NYME2wtQKwkiBXVGVqgjPMNwX/opKpcPqU8M5hGBK9otuBVDfIBR+l
         vl7MvXR6voHxFYMz3GQItcwq+Gd/+jQF/GuIhF+D2oDeg4Y7rUxRX/2ytE1pmtTa49k7
         232Ko8Vp+cIqexfZjZCVYZ3a6ZVNnn0L92dlrr98IAt/2djBz3d+byrIUy1I7Do1P0bL
         J/YQ==
X-Gm-Message-State: AOJu0YyPKSN9Km+p6+I2yyYwnpl4eQKVoVe4Ln/J4QtxzQgdMdkTqTMe
        gMljZ6shp7vFgT1O2xlIb6Jam5HeqVE=
X-Google-Smtp-Source: AGHT+IEQnfQJXsZfD5l3eTHMFXEnf/LuX1aOWRKHKb0YO9vboO3g/ow1Ng2yjIbywfhnwipFXttfcA==
X-Received: by 2002:a05:6402:493:b0:523:100b:462b with SMTP id k19-20020a056402049300b00523100b462bmr5019955edv.5.1694287181004;
        Sat, 09 Sep 2023 12:19:41 -0700 (PDT)
Received: from f.. (cst-prg-30-5.cust.vodafone.cz. [46.135.30.5])
        by smtp.gmail.com with ESMTPSA id d4-20020aa7d5c4000000b0052544bca116sm2482314eds.13.2023.09.09.12.19.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Sep 2023 12:19:40 -0700 (PDT)
From:   Mateusz Guzik <mjguzik@gmail.com>
To:     linux-security-module@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, paul@paul-moore.com,
        Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH v2] cred: add get_cred_many and put_cred_many
Date:   Sat,  9 Sep 2023 21:19:32 +0200
Message-Id: <20230909191932.3187633-1-mjguzik@gmail.com>
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

Some of the frequent consumers of get_cred and put_cred operate on 2
references on the same creds back-to-back.

Switch them to doing the work in one go instead.

v2:
- add kdoc entries
- hoist validate_cred call in exit_creds
- reword commit message

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---
 include/linux/cred.h | 59 +++++++++++++++++++++++++++++++++++++-------
 kernel/cred.c        | 26 ++++++++++---------
 2 files changed, 65 insertions(+), 20 deletions(-)

diff --git a/include/linux/cred.h b/include/linux/cred.h
index f923528d5cc4..56bc432fe49b 100644
--- a/include/linux/cred.h
+++ b/include/linux/cred.h
@@ -218,6 +218,20 @@ static inline bool cap_ambient_invariant_ok(const struct cred *cred)
 					  cred->cap_inheritable));
 }
 
+/**
+ * get_new_cred_many - Get references on a new set of credentials
+ * @cred: The new credentials to reference
+ * @nr: Number of references to acquire
+ *
+ * Get references on the specified set of new credentials.  The caller must
+ * release all acquired references.
+ */
+static inline struct cred *get_new_cred_many(struct cred *cred, int nr)
+{
+	atomic_add(nr, &cred->usage);
+	return cred;
+}
+
 /**
  * get_new_cred - Get a reference on a new set of credentials
  * @cred: The new credentials to reference
@@ -227,16 +241,16 @@ static inline bool cap_ambient_invariant_ok(const struct cred *cred)
  */
 static inline struct cred *get_new_cred(struct cred *cred)
 {
-	atomic_inc(&cred->usage);
-	return cred;
+	return get_new_cred_many(cred, 1);
 }
 
 /**
- * get_cred - Get a reference on a set of credentials
+ * get_cred_many - Get references on a set of credentials
  * @cred: The credentials to reference
+ * @nr: Number of references to acquire
  *
- * Get a reference on the specified set of credentials.  The caller must
- * release the reference.  If %NULL is passed, it is returned with no action.
+ * Get references on the specified set of credentials.  The caller must release
+ * all acquired reference.  If %NULL is passed, it is returned with no action.
  *
  * This is used to deal with a committed set of credentials.  Although the
  * pointer is const, this will temporarily discard the const and increment the
@@ -244,14 +258,28 @@ static inline struct cred *get_new_cred(struct cred *cred)
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
+/*
+ * get_cred - Get a reference on a set of credentials
+ * @cred: The credentials to reference
+ *
+ * Get a reference on the specified set of credentials.  The caller must
+ * release the reference.  If %NULL is passed, it is returned with no action.
+ *
+ * This is used to deal with a committed set of credentials.
+ */
+static inline const struct cred *get_cred(const struct cred *cred)
+{
+	return get_cred_many(cred, 1);
 }
 
 static inline const struct cred *get_cred_rcu(const struct cred *cred)
@@ -269,6 +297,7 @@ static inline const struct cred *get_cred_rcu(const struct cred *cred)
 /**
  * put_cred - Release a reference to a set of credentials
  * @cred: The credentials to release
+ * @nr: Number of references to release
  *
  * Release a reference to a set of credentials, deleting them when the last ref
  * is released.  If %NULL is passed, nothing is done.
@@ -277,17 +306,29 @@ static inline const struct cred *get_cred_rcu(const struct cred *cred)
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
 
+/*
+ * put_cred - Release a reference to a set of credentials
+ * @cred: The credentials to release
+ *
+ * Release a reference to a set of credentials, deleting them when the last ref
+ * is released.  If %NULL is passed, nothing is done.
+ */
+static inline void put_cred(const struct cred *cred)
+{
+	put_cred_many(cred, 1);
+}
+
 /**
  * current_cred - Access the current task's subjective credentials
  *
diff --git a/kernel/cred.c b/kernel/cred.c
index 98cb4eca23fb..9398e534b997 100644
--- a/kernel/cred.c
+++ b/kernel/cred.c
@@ -162,23 +162,29 @@ EXPORT_SYMBOL(__put_cred);
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
+
 	validate_creds(cred);
-	alter_cred_subscribers(cred, -1);
-	put_cred(cred);
+	if (real_cred == cred) {
+		alter_cred_subscribers(cred, -2);
+		put_cred_many(cred, 2);
+	} else {
+		validate_creds(real_cred);
+		alter_cred_subscribers(real_cred, -1);
+		put_cred(real_cred);
+		alter_cred_subscribers(cred, -1);
+		put_cred(cred);
+	}
 
 #ifdef CONFIG_KEYS_REQUEST_CACHE
 	key_put(tsk->cached_requested_key);
@@ -355,8 +361,7 @@ int copy_creds(struct task_struct *p, unsigned long clone_flags)
 #endif
 		clone_flags & CLONE_THREAD
 	    ) {
-		p->real_cred = get_cred(p->cred);
-		get_cred(p->cred);
+		p->real_cred = get_cred_many(p->cred, 2);
 		alter_cred_subscribers(p->cred, 2);
 		kdebug("share_creds(%p{%d,%d})",
 		       p->cred, atomic_read(&p->cred->usage),
@@ -520,8 +525,7 @@ int commit_creds(struct cred *new)
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

