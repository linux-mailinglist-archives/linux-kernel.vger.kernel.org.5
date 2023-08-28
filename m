Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A33178B411
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 17:10:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232487AbjH1PJn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 11:09:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231284AbjH1PJV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 11:09:21 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FDC21AA
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 08:09:16 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-4013454fa93so28875295e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 08:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1693235354; x=1693840154;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QXssY8R3UfI51/fzerFRXliKac0QknXs4XkU/07pT5E=;
        b=TXgobUHzdy1/oc00DCkfPuEhJu9AWsZDH7ItfMlZ9px/6av7xSZfC0WrjhZ16H5vnH
         +BXZsUMOLMGBNanD+Ods+R3MJffoWBq5sR8yyAUkuszZbSoBMR1IFcOLTFENcXg98b7t
         Yahy0kl0OhvBiWJFAmjSAeDAGABOGBOn3jPxs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693235354; x=1693840154;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QXssY8R3UfI51/fzerFRXliKac0QknXs4XkU/07pT5E=;
        b=CEjxxbfcbIMn7C4ZcVN33X1Y4/5avd/9S/7OE+djoLG3TdQkj4Lo2unoRGVRagR73A
         vrOU5HLH2I3Ggk4ok+dYiS5rULVXjLcK8U2G7OAajVnRDAHJSPQIhlsv9OpfVKGoWcrI
         qvJJuMU3BtBhZD8Mgk84hRlSy5PQ0wgb59XvoCAv95CmkXgCRCW/pIcTfmcJna/GRXPM
         0zcDxZKJ2RMy6HhPBTcS1WtUpZiUSqW8tmLziXb8gH/9TIhsdnDT0vnx3ckklEoBhUZ+
         0YbkyJo3jW0gDLj3HRWq6HM8GjE/JMx44DFHMIKr/mkT1Hc9y6jZrP59pHMaeLz49UsA
         UgwQ==
X-Gm-Message-State: AOJu0YxTgJiRkMk0JcDd3nyniu3akR+GrpYK5sN0/eHxaCAdoUai8xGH
        KHHijQ2NuhgYdFKmWcPF8of3PR/sjsvvP5nAR/M=
X-Google-Smtp-Source: AGHT+IGqMEI1E4b+HWptK+/EKjF7xI4VmzXlfBLXmqDJvfgj+65VugBjpc0Hy94kYyiGhQQdqXzgkQ==
X-Received: by 2002:a1c:7508:0:b0:3fb:739d:27b2 with SMTP id o8-20020a1c7508000000b003fb739d27b2mr19489637wmc.8.1693235354252;
        Mon, 28 Aug 2023 08:09:14 -0700 (PDT)
Received: from revest.zrh.corp.google.com ([2a00:79e0:9d:6:40c6:6cff:63b:c70a])
        by smtp.gmail.com with ESMTPSA id v3-20020a5d43c3000000b003140fff4f75sm10730522wrr.17.2023.08.28.08.09.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 08:09:13 -0700 (PDT)
From:   Florent Revest <revest@chromium.org>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, catalin.marinas@arm.com,
        anshuman.khandual@arm.com, joey.gouly@arm.com, mhocko@suse.com,
        keescook@chromium.org, david@redhat.com, peterx@redhat.com,
        izbyshev@ispras.ru, broonie@kernel.org, szabolcs.nagy@arm.com,
        kpsingh@kernel.org, gthelen@google.com, toiwoton@gmail.com,
        ayush.jain3@amd.com, Florent Revest <revest@chromium.org>
Subject: [PATCH v4 5/6] mm: Add a NO_INHERIT flag to the PR_SET_MDWE prctl
Date:   Mon, 28 Aug 2023 17:08:57 +0200
Message-ID: <20230828150858.393570-6-revest@chromium.org>
X-Mailer: git-send-email 2.42.0.rc2.253.gd59a3bf2b4-goog
In-Reply-To: <20230828150858.393570-1-revest@chromium.org>
References: <20230828150858.393570-1-revest@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This extends the current PR_SET_MDWE prctl arg with a bit to indicate
that the process doesn't want MDWE protection to propagate to children.

To implement this no-inherit mode, the tag in current->mm->flags must be
absent from MMF_INIT_MASK. This means that the encoding for "MDWE but
without inherit" is different in the prctl than in the mm flags. This
leads to a bit of bit-mangling in the prctl implementation.

Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Florent Revest <revest@chromium.org>
---
 include/linux/sched/coredump.h   | 10 ++++++++++
 include/uapi/linux/prctl.h       |  1 +
 kernel/fork.c                    |  2 +-
 kernel/sys.c                     | 32 ++++++++++++++++++++++++++------
 tools/include/uapi/linux/prctl.h |  1 +
 5 files changed, 39 insertions(+), 7 deletions(-)

diff --git a/include/linux/sched/coredump.h b/include/linux/sched/coredump.h
index 0ee96ea7a0e9..1b37fa8fc723 100644
--- a/include/linux/sched/coredump.h
+++ b/include/linux/sched/coredump.h
@@ -91,4 +91,14 @@ static inline int get_dumpable(struct mm_struct *mm)
 				 MMF_DISABLE_THP_MASK | MMF_HAS_MDWE_MASK)
 
 #define MMF_VM_MERGE_ANY	29
+#define MMF_HAS_MDWE_NO_INHERIT	30
+
+static inline unsigned long mmf_init_flags(unsigned long flags)
+{
+	if (flags & (1UL << MMF_HAS_MDWE_NO_INHERIT))
+		flags &= ~((1UL << MMF_HAS_MDWE) |
+			   (1UL << MMF_HAS_MDWE_NO_INHERIT));
+	return flags & MMF_INIT_MASK;
+}
+
 #endif /* _LINUX_SCHED_COREDUMP_H */
diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
index 9a85c69782bd..370ed14b1ae0 100644
--- a/include/uapi/linux/prctl.h
+++ b/include/uapi/linux/prctl.h
@@ -284,6 +284,7 @@ struct prctl_mm_map {
 /* Memory deny write / execute */
 #define PR_SET_MDWE			65
 # define PR_MDWE_REFUSE_EXEC_GAIN	(1UL << 0)
+# define PR_MDWE_NO_INHERIT		(1UL << 1)
 
 #define PR_GET_MDWE			66
 
diff --git a/kernel/fork.c b/kernel/fork.c
index 7b8b63fb0438..9da5a1192c98 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1285,7 +1285,7 @@ static struct mm_struct *mm_init(struct mm_struct *mm, struct task_struct *p,
 	hugetlb_count_init(mm);
 
 	if (current->mm) {
-		mm->flags = current->mm->flags & MMF_INIT_MASK;
+		mm->flags = mmf_init_flags(current->mm->flags);
 		mm->def_flags = current->mm->def_flags & VM_INIT_DEF_MASK;
 	} else {
 		mm->flags = default_dump_filter;
diff --git a/kernel/sys.c b/kernel/sys.c
index 2410e3999ebe..4a8073c1b255 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -2368,19 +2368,41 @@ static int prctl_set_vma(unsigned long opt, unsigned long start,
 }
 #endif /* CONFIG_ANON_VMA_NAME */
 
+static inline unsigned long get_current_mdwe(void)
+{
+	unsigned long ret = 0;
+
+	if (test_bit(MMF_HAS_MDWE, &current->mm->flags))
+		ret |= PR_MDWE_REFUSE_EXEC_GAIN;
+	if (test_bit(MMF_HAS_MDWE_NO_INHERIT, &current->mm->flags))
+		ret |= PR_MDWE_NO_INHERIT;
+
+	return ret;
+}
+
 static inline int prctl_set_mdwe(unsigned long bits, unsigned long arg3,
 				 unsigned long arg4, unsigned long arg5)
 {
+	unsigned long current_bits;
+
 	if (arg3 || arg4 || arg5)
 		return -EINVAL;
 
-	if (bits & ~(PR_MDWE_REFUSE_EXEC_GAIN))
+	if (bits & ~(PR_MDWE_REFUSE_EXEC_GAIN | PR_MDWE_NO_INHERIT))
+		return -EINVAL;
+
+	/* NO_INHERIT only makes sense with REFUSE_EXEC_GAIN */
+	if (bits & PR_MDWE_NO_INHERIT && !(bits & PR_MDWE_REFUSE_EXEC_GAIN))
 		return -EINVAL;
 
+	current_bits = get_current_mdwe();
+	if (current_bits && current_bits != bits)
+		return -EPERM; /* Cannot unset the flags */
+
+	if (bits & PR_MDWE_NO_INHERIT)
+		set_bit(MMF_HAS_MDWE_NO_INHERIT, &current->mm->flags);
 	if (bits & PR_MDWE_REFUSE_EXEC_GAIN)
 		set_bit(MMF_HAS_MDWE, &current->mm->flags);
-	else if (test_bit(MMF_HAS_MDWE, &current->mm->flags))
-		return -EPERM; /* Cannot unset the flag */
 
 	return 0;
 }
@@ -2390,9 +2412,7 @@ static inline int prctl_get_mdwe(unsigned long arg2, unsigned long arg3,
 {
 	if (arg2 || arg3 || arg4 || arg5)
 		return -EINVAL;
-
-	return test_bit(MMF_HAS_MDWE, &current->mm->flags) ?
-		PR_MDWE_REFUSE_EXEC_GAIN : 0;
+	return get_current_mdwe();
 }
 
 static int prctl_get_auxv(void __user *addr, unsigned long len)
diff --git a/tools/include/uapi/linux/prctl.h b/tools/include/uapi/linux/prctl.h
index 9a85c69782bd..370ed14b1ae0 100644
--- a/tools/include/uapi/linux/prctl.h
+++ b/tools/include/uapi/linux/prctl.h
@@ -284,6 +284,7 @@ struct prctl_mm_map {
 /* Memory deny write / execute */
 #define PR_SET_MDWE			65
 # define PR_MDWE_REFUSE_EXEC_GAIN	(1UL << 0)
+# define PR_MDWE_NO_INHERIT		(1UL << 1)
 
 #define PR_GET_MDWE			66
 
-- 
2.42.0.rc2.253.gd59a3bf2b4-goog

