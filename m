Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42180789BC8
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Aug 2023 09:22:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbjH0HVw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 03:21:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbjH0HVh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 03:21:37 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBA93B3
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 00:21:10 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1bc63ef9959so17706915ad.2
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 00:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1693120870; x=1693725670;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FBwoJcGBnb1veA8KnUD3qT8I054w63hMR1j00YfM/x8=;
        b=BeWq9KckrnODaNNHCG1z2qbWpWBcfLgX3L/Qu1m7FTHWPA+7aJObjrZT73pVfo2VQ8
         PDvOBcCdDGGMGy/4d6NJxGWnu+YBTX1E0z1sl3g55fY0UN+PKURSmFn5mqWUkhsNojOk
         akXAIq2Jlhx+Isuab+SvAQsA1VU3vnDp6a6fdTdrlEXiec8bKgUAcJc7Kwr/EJujGRIe
         XUz/5cuve3mM8dEsFn9UvBIGOScMhyDqYU+uANsNnx0oZ7jp04gs/ycrTUW0btrbmCdD
         zKNLa7SWbPL7dinpaXVNCYfvltjTs/MngWa0W3rrVLzD61mObJp+9goc+D2VT2Y+mGeO
         9S1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693120870; x=1693725670;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FBwoJcGBnb1veA8KnUD3qT8I054w63hMR1j00YfM/x8=;
        b=MGmpK+eoj0CWExyRbwFnfRYdsb4CaX2xgpTjHckfZsPDUZ6xuNmDNJsvuPTBkfZH3h
         +WbbFTpVh6MdwXNaeKteLkEds1qA1Xa1bUusZQKIxUI16pwmP0fgRdeGLrbgFNgHl5Ay
         HfFa8+1cKr0ZfwV8nmj8At6HEuClP/8EmyCvwjnSmasUj/ThU9aiGSe9yIEQTP7998zL
         aKCeb3y+NUhFC7n3DwAmvosZQ7dntMm9O10xUwPjcg+yhSgKn06NnSSK8pB3Fhi1TYE5
         xTJRdIG9rNtoiLvPU6TuPhsja3U5/qJmJ1ZH4lEvwCrHfhPZdm0vlb9PVT3TsX3XO/t9
         tLGA==
X-Gm-Message-State: AOJu0Yz3bMv8nfJA9TpEBAgxY0Z9LMet0QGqTARdteh6FVCJu+gDuUDG
        JEYRASlsi9mHv42OJduWRJAaGQ==
X-Google-Smtp-Source: AGHT+IHiEPvFBXe3lELVZXbNjUVfpsIF2DxyqTE1VuJNCcAsiC8D9F7OTFyPQRkKAGq/03B8V+Sj7w==
X-Received: by 2002:a17:902:ced0:b0:1bb:97d0:c628 with SMTP id d16-20020a170902ced000b001bb97d0c628mr27739664plg.31.1693120870474;
        Sun, 27 Aug 2023 00:21:10 -0700 (PDT)
Received: from n37-019-243.byted.org ([180.184.51.134])
        by smtp.gmail.com with ESMTPSA id m3-20020a1709026bc300b001befac3b3cbsm4769723plt.290.2023.08.27.00.21.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Aug 2023 00:21:10 -0700 (PDT)
From:   Chuyi Zhou <zhouchuyi@bytedance.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@kernel.org, linux-kernel@vger.kernel.org,
        Chuyi Zhou <zhouchuyi@bytedance.com>
Subject: [RFC PATCH bpf-next 2/4] bpf: Introduce process open coded iterator kfuncs
Date:   Sun, 27 Aug 2023 15:20:55 +0800
Message-Id: <20230827072057.1591929-3-zhouchuyi@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230827072057.1591929-1-zhouchuyi@bytedance.com>
References: <20230827072057.1591929-1-zhouchuyi@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds kfuncs bpf_iter_process_{new,next,destroy} which allow
creation and manipulation of struct bpf_iter_process in open-coded iterator
style. BPF programs can use these kfuncs or through bpf_for_each macro to
iterate all processes in the system.

Signed-off-by: Chuyi Zhou <zhouchuyi@bytedance.com>
---
 include/uapi/linux/bpf.h       |  4 ++++
 kernel/bpf/helpers.c           |  3 +++
 kernel/bpf/task_iter.c         | 31 +++++++++++++++++++++++++++++++
 tools/include/uapi/linux/bpf.h |  4 ++++
 tools/lib/bpf/bpf_helpers.h    |  5 +++++
 5 files changed, 47 insertions(+)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 2a6e9b99564b..cfbd527e3733 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -7199,4 +7199,8 @@ struct bpf_iter_css_task {
 	__u64 __opaque[1];
 } __attribute__((aligned(8)));
 
+struct bpf_iter_process {
+	__u64 __opaque[1];
+} __attribute__((aligned(8)));
+
 #endif /* _UAPI__LINUX_BPF_H__ */
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index cf113ad24837..81a2005edc26 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2458,6 +2458,9 @@ BTF_ID_FLAGS(func, bpf_iter_num_destroy, KF_ITER_DESTROY)
 BTF_ID_FLAGS(func, bpf_iter_css_task_new, KF_ITER_NEW)
 BTF_ID_FLAGS(func, bpf_iter_css_task_next, KF_ITER_NEXT | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_iter_css_task_destroy, KF_ITER_DESTROY)
+BTF_ID_FLAGS(func, bpf_iter_process_new, KF_ITER_NEW)
+BTF_ID_FLAGS(func, bpf_iter_process_next, KF_ITER_NEXT | KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_iter_process_destroy, KF_ITER_DESTROY)
 BTF_ID_FLAGS(func, bpf_dynptr_adjust)
 BTF_ID_FLAGS(func, bpf_dynptr_is_null)
 BTF_ID_FLAGS(func, bpf_dynptr_is_rdonly)
diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
index b1bdba40b684..a6717a76c1e0 100644
--- a/kernel/bpf/task_iter.c
+++ b/kernel/bpf/task_iter.c
@@ -862,6 +862,37 @@ __bpf_kfunc void bpf_iter_css_task_destroy(struct bpf_iter_css_task *it)
 	kfree(kit->css_it);
 }
 
+struct bpf_iter_process_kern {
+	struct task_struct *tsk;
+} __attribute__((aligned(8)));
+
+__bpf_kfunc int bpf_iter_process_new(struct bpf_iter_process *it)
+{
+	struct bpf_iter_process_kern *kit = (void *)it;
+
+	BUILD_BUG_ON(sizeof(struct bpf_iter_process_kern) != sizeof(struct bpf_iter_process));
+	BUILD_BUG_ON(__alignof__(struct bpf_iter_process_kern) !=
+					__alignof__(struct bpf_iter_process));
+
+	rcu_read_lock();
+	kit->tsk = &init_task;
+	return 0;
+}
+
+__bpf_kfunc struct task_struct *bpf_iter_process_next(struct bpf_iter_process *it)
+{
+	struct bpf_iter_process_kern *kit = (void *)it;
+
+	kit->tsk = next_task(kit->tsk);
+
+	return kit->tsk == &init_task ? NULL : kit->tsk;
+}
+
+__bpf_kfunc void bpf_iter_process_destroy(struct bpf_iter_process *it)
+{
+	rcu_read_unlock();
+}
+
 DEFINE_PER_CPU(struct mmap_unlock_irq_work, mmap_unlock_work);
 
 static void do_mmap_read_unlock(struct irq_work *entry)
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 2a6e9b99564b..cfbd527e3733 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -7199,4 +7199,8 @@ struct bpf_iter_css_task {
 	__u64 __opaque[1];
 } __attribute__((aligned(8)));
 
+struct bpf_iter_process {
+	__u64 __opaque[1];
+} __attribute__((aligned(8)));
+
 #endif /* _UAPI__LINUX_BPF_H__ */
diff --git a/tools/lib/bpf/bpf_helpers.h b/tools/lib/bpf/bpf_helpers.h
index f4d74b2aaddd..7d6a828d98b5 100644
--- a/tools/lib/bpf/bpf_helpers.h
+++ b/tools/lib/bpf/bpf_helpers.h
@@ -309,6 +309,11 @@ extern int bpf_iter_css_task_new(struct bpf_iter_css_task *it,
 extern struct task_struct *bpf_iter_css_task_next(struct bpf_iter_css_task *it) __weak __ksym;
 extern void bpf_iter_css_task_destroy(struct bpf_iter_css_task *it) __weak __ksym;
 
+struct bpf_iter_process;
+extern int bpf_iter_process_new(struct bpf_iter_process *it) __weak __ksym;
+extern struct task_struct *bpf_iter_process_next(struct bpf_iter_process *it) __weak __ksym;
+extern void bpf_iter_process_destroy(struct bpf_iter_process *it) __weak __ksym;
+
 #ifndef bpf_for_each
 /* bpf_for_each(iter_type, cur_elem, args...) provides generic construct for
  * using BPF open-coded iterators without having to write mundane explicit
-- 
2.20.1

