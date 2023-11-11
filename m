Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 904907E8875
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Nov 2023 03:49:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345554AbjKKCtH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 21:49:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230338AbjKKCtB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 21:49:01 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22E9B3C15;
        Fri, 10 Nov 2023 18:48:57 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-6b1d1099a84so2721372b3a.1;
        Fri, 10 Nov 2023 18:48:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699670936; x=1700275736; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=047RScGgMjhfhvkeVSqTgX+A9EaMBWDmBq31ySPa+B0=;
        b=O+jiY3TFnZrwNUsQ2sOpDv0XttRsKbZDX6WUQnF1eYbv56lIa5InU7jeylczt02leP
         OMn/+KuhU/ja2eUs22nywaoDmRXRqWdVZoDTIOjOHhwHRbjg7r3SkxAbdEP2onwiojwI
         5gY74lKKoJjiY5MauXai+Y74TJfMkZwhCjcjYSWhvfYoNKx0xU+s5n9UkTiRxtqGq15o
         eaKd5mEdCxsjHgai6Z03ATSVCEweEUutB6pGQmQ60SXD8ELUIb0nez3ms6B2hN3LgLqN
         htMYxVPVlGlTORZjOkMjrK9o1Llo39vfmRwvQl2zmb5vG0wyWNjVCGDwDTpUXhfdVXTh
         y0IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699670936; x=1700275736;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=047RScGgMjhfhvkeVSqTgX+A9EaMBWDmBq31ySPa+B0=;
        b=o6KO1UrZtyUZiXr1d/m3VY6pYQnYRxzAvN9ON1Saqo+GyVlGYOLcdchQRsnuvXJWaz
         4iRLWt1RtuzBQp0svJCtt80Qs+7tLCdF/7zo1kj9AAk4F7VNa+xHei2AITV1j/Pcyt79
         0fBj+rBxwooF5RTqWhrsMeKM28FSUeCk3w7zEejOer5OvnQ6vxDDhQYE/ndrTnyP/Gyx
         XhAwoj38wF4WxZtqCika97td6Rj0jr54nb8BfBQ5X3pNLU4EFO2PJQMZyrfjrnJnHSmi
         YXcP1GqO45MipxQCquU02Pq/wr+sM2srL1mSAdsy1HYzgcPrWGsRZS0XBdhORKUgzvlH
         sR9A==
X-Gm-Message-State: AOJu0Yy1wNv/KgdSiSCm7QrIG+X9cGMbX2gS4uAnaNB8t7rQNZtIAorx
        Z8Q5Pu9Pw7LEXRQueChk8SU=
X-Google-Smtp-Source: AGHT+IHQLCJahNyA+ScLSn5pPMMwd9BjDvwBNhTkSwF7/JXPfbg14Sz/EvG6j536DODoFObhzAajQw==
X-Received: by 2002:a05:6a00:10c8:b0:6b8:a6d6:f51a with SMTP id d8-20020a056a0010c800b006b8a6d6f51amr925662pfu.31.1699670936344;
        Fri, 10 Nov 2023 18:48:56 -0800 (PST)
Received: from localhost ([2620:10d:c090:400::4:7384])
        by smtp.gmail.com with ESMTPSA id e14-20020a62ee0e000000b00688435a9915sm382537pfi.189.2023.11.10.18.48.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Nov 2023 18:48:55 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
From:   Tejun Heo <tj@kernel.org>
To:     torvalds@linux-foundation.org, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org,
        joshdon@google.com, brho@google.com, pjt@google.com,
        derkling@google.com, haoluo@google.com, dvernet@meta.com,
        dschatzberg@meta.com, dskarlat@cs.cmu.edu, riel@surriel.com,
        changwoo@igalia.com, himadrics@inria.fr, memxor@gmail.com
Cc:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        kernel-team@meta.com, Tejun Heo <tj@kernel.org>
Subject: [PATCH 01/36] cgroup: Implement cgroup_show_cftypes()
Date:   Fri, 10 Nov 2023 16:47:27 -1000
Message-ID: <20231111024835.2164816-2-tj@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231111024835.2164816-1-tj@kernel.org>
References: <20231111024835.2164816-1-tj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement cgroup_show_cftypes() which shows and hides all cgroup files
associated with the specified set of cgroup file types. CFTYPE_HIDDEN flag
is added so that files can be created hidden from the get-go.

cgroup_show_cftypes() can be used whether the cftypes are added or not. It
also combines with cgroup_show_file() so that a given file is visible iff
both its cftype and cfile are visible.

This will be used by a new sched_class to selectively show and hide CPU
controller interface files depending on whether they're supported.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reviewed-by: David Vernet <dvernet@meta.com>
Acked-by: Josh Don <joshdon@google.com>
Acked-by: Hao Luo <haoluo@google.com>
Acked-by: Barret Rhoden <brho@google.com>
---
 include/linux/cgroup-defs.h |  8 +++
 include/linux/cgroup.h      |  1 +
 kernel/cgroup/cgroup.c      | 97 ++++++++++++++++++++++++++++++++++---
 3 files changed, 99 insertions(+), 7 deletions(-)

diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
index 265da00a1a8b..6194d7c13573 100644
--- a/include/linux/cgroup-defs.h
+++ b/include/linux/cgroup-defs.h
@@ -127,12 +127,18 @@ enum {
 	CFTYPE_WORLD_WRITABLE	= (1 << 4),	/* (DON'T USE FOR NEW FILES) S_IWUGO */
 	CFTYPE_DEBUG		= (1 << 5),	/* create when cgroup_debug */
 
+	CFTYPE_HIDDEN		= (1 << 6),	/* file type hidden, see cgroup_show_cftypes() */
+
 	/* internal flags, do not use outside cgroup core proper */
 	__CFTYPE_ONLY_ON_DFL	= (1 << 16),	/* only on default hierarchy */
 	__CFTYPE_NOT_ON_DFL	= (1 << 17),	/* not on default hierarchy */
 	__CFTYPE_ADDED		= (1 << 18),
 };
 
+enum cfile_flags {
+	CFILE_HIDDEN		= (1 << 0),	/* file instance hidden */
+};
+
 /*
  * cgroup_file is the handle for a file instance created in a cgroup which
  * is used, for example, to generate file changed notifications.  This can
@@ -140,7 +146,9 @@ enum {
  */
 struct cgroup_file {
 	/* do not access any fields from outside cgroup core */
+	struct cftype *cft;
 	struct kernfs_node *kn;
+	unsigned int flags;
 	unsigned long notified_at;
 	struct timer_list notify_timer;
 };
diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
index 0ef0af66080e..d164eaeacfa6 100644
--- a/include/linux/cgroup.h
+++ b/include/linux/cgroup.h
@@ -113,6 +113,7 @@ int cgroup_transfer_tasks(struct cgroup *to, struct cgroup *from);
 int cgroup_add_dfl_cftypes(struct cgroup_subsys *ss, struct cftype *cfts);
 int cgroup_add_legacy_cftypes(struct cgroup_subsys *ss, struct cftype *cfts);
 int cgroup_rm_cftypes(struct cftype *cfts);
+void cgroup_show_cftype(struct cftype *cft, bool show);
 void cgroup_file_notify(struct cgroup_file *cfile);
 void cgroup_file_show(struct cgroup_file *cfile, bool show);
 
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 484adb375b15..d00fa84edd4c 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -4210,10 +4210,13 @@ static int cgroup_add_file(struct cgroup_subsys_state *css, struct cgroup *cgrp,
 		return ret;
 	}
 
+	kernfs_show(kn, !(cft->flags & CFTYPE_HIDDEN));
+
 	if (cft->file_offset) {
 		struct cgroup_file *cfile = (void *)css + cft->file_offset;
 
 		timer_setup(&cfile->notify_timer, cgroup_file_notify_timer, 0);
+		cfile->cft = cft;
 
 		spin_lock_irq(&cgroup_file_kn_lock);
 		cfile->kn = kn;
@@ -4489,6 +4492,24 @@ void cgroup_file_notify(struct cgroup_file *cfile)
 	spin_unlock_irqrestore(&cgroup_file_kn_lock, flags);
 }
 
+static struct kernfs_node *cfile_kn_get(struct cgroup_file *cfile)
+{
+	struct kernfs_node *kn;
+
+	spin_lock_irq(&cgroup_file_kn_lock);
+	kn = cfile->kn;
+	kernfs_get(kn);
+	spin_unlock_irq(&cgroup_file_kn_lock);
+
+	return kn;
+}
+
+static bool cfile_visible(struct cgroup_file *cfile)
+{
+	return !(cfile->cft->flags & CFTYPE_HIDDEN) &&
+		!(cfile->flags & CFILE_HIDDEN);
+}
+
 /**
  * cgroup_file_show - show or hide a hidden cgroup file
  * @cfile: target cgroup_file obtained by setting cftype->file_offset
@@ -4498,15 +4519,20 @@ void cgroup_file_show(struct cgroup_file *cfile, bool show)
 {
 	struct kernfs_node *kn;
 
-	spin_lock_irq(&cgroup_file_kn_lock);
-	kn = cfile->kn;
-	kernfs_get(kn);
-	spin_unlock_irq(&cgroup_file_kn_lock);
+	mutex_lock(&cgroup_mutex);
 
-	if (kn)
-		kernfs_show(kn, show);
+	if (show)
+		cfile->flags &= ~CFILE_HIDDEN;
+	else
+		cfile->flags |= CFILE_HIDDEN;
 
-	kernfs_put(kn);
+	kn = cfile_kn_get(cfile);
+	if (kn) {
+		kernfs_show(kn, cfile_visible(cfile));
+		kernfs_put(kn);
+	}
+
+	mutex_unlock(&cgroup_mutex);
 }
 
 /**
@@ -5534,6 +5560,63 @@ static void offline_css(struct cgroup_subsys_state *css)
 	wake_up_all(&css->cgroup->offline_waitq);
 }
 
+/**
+ * cgroup_show_cftype - show or hide a cgroup file type
+ * @cft: cftype to show or hide
+ * @show: whether to show or hide
+ *
+ * Sets %CFTYPE_HIDDEN and shows/hides the matching files according to @show.
+ * @cft may or may not be added at the time of this call. After hiding, it's
+ * guaranteed that there are no in-flight operations on the hidden files.
+ */
+void cgroup_show_cftype(struct cftype *cft, bool show)
+{
+	struct cgroup_subsys *ss = cft->ss;
+	struct cgroup *root = ss ? &ss->root->cgrp : &cgrp_dfl_root.cgrp;
+	struct cgroup_subsys_state *css;
+
+	mutex_lock(&cgroup_mutex);
+
+	if (show)
+		cft->flags &= ~CFTYPE_HIDDEN;
+	else
+		cft->flags |= CFTYPE_HIDDEN;
+
+	if (!(cft->flags & __CFTYPE_ADDED))
+		goto out_unlock;
+
+	css_for_each_descendant_pre(css, cgroup_css(root, ss)) {
+		struct cgroup *cgrp = css->cgroup;
+		struct kernfs_node *kn;
+
+		if (!(css->flags & CSS_VISIBLE))
+			continue;
+
+		if (cft->file_offset) {
+			struct cgroup_file *cfile =
+				(void *)css + cft->file_offset;
+
+			kn = cfile_kn_get(cfile);
+			if (kn) {
+				kernfs_show(kn, cfile_visible(cfile));
+				kernfs_put(kn);
+			}
+		} else {
+			char buf[CGROUP_FILE_NAME_MAX];
+
+			kn = kernfs_find_and_get(cgrp->kn,
+					cgroup_file_name(cgrp, cft, buf));
+			if (kn) {
+				kernfs_show(kn, show);
+				kernfs_put(kn);
+			}
+		}
+	}
+
+out_unlock:
+	mutex_unlock(&cgroup_mutex);
+}
+
 /**
  * css_create - create a cgroup_subsys_state
  * @cgrp: the cgroup new css will be associated with
-- 
2.42.0

