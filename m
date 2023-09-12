Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 110EC79C77E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 09:02:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231161AbjILHCR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 03:02:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231216AbjILHCN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 03:02:13 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02061E7C
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 00:02:10 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1c0ecb9a075so37537735ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 00:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1694502129; x=1695106929; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+2pL38sdR1zkqvND06hEOkj6aCyDQM/YMk3Q7fUlrh4=;
        b=M2IuHdH8p6VL/T+r4KhufKVPTFU9Qdd3Vj8fRX16Ps/8Jex8HpP2UTkOUzS3bE7/oW
         p0lcRAwO7+0E3dt+h7uqMRwB2GqCI5g1PuSu6FZ9Ct0E7OnEX2gq5qyVLx3IIsoPkP6Q
         /2dD5jdLkzIsjH5bpUst9xbVHww97Jsxzgzlp5UJ2M4/+FHtUSdVd/tN+dxIcr/kq/bS
         GO2r9XE86jJyy7IkIzNpEanGMne3qAOb/KEHS2MlvGdiAEYv9VkI7cR7SuirsS019hcM
         DYFOZjhfY7g19waibSAbfQyTU+hR1nhYAnO2Bmms4oPTE+dMd4ikYAN0QIGgiINaHiuJ
         Vnzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694502129; x=1695106929;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+2pL38sdR1zkqvND06hEOkj6aCyDQM/YMk3Q7fUlrh4=;
        b=gu0csuK4shNgeEb8z7dGU+8cshjShm4OUeaO2UinoPJGvKajXjjZBOfaNTKaj9D60l
         epgXi+lP1UNRBKUKWKwM7ZEpKj/m2Os3pMwhCBWC+n2yRkylBNDJSKMTSZelFyUQM48E
         TfRpJS47uQDzab+7b9yti0M0xHDBZ8mLGCJtM35YfYFLoPtfydYt7pksEtzucwqGB4Sx
         zgmF7KwxT9dhXN4dApQVUXNX+A1JviKsr4JaMmJbvoGRv42zZtqVAcBGz8AaS9iZWFIv
         PmxRunnJ0g0knSfUXOhOJUx3GsLPOff5ghtxMhz67gLQb4rAz0+4G8mwVqMGaTErLYV2
         FyCg==
X-Gm-Message-State: AOJu0Yz+CrGjL0u+fFLhui7t384WpRDulcnx8fQPQn3VcT/XFCROTiHn
        xl+MwZMGjlCv5YExSCOuewE2Pg==
X-Google-Smtp-Source: AGHT+IFLHzQBh59ISNd1Ew9UXrAaH+IQXBWi+Di1oQTdwgCpmr79ELmZXckxp25ZL61NyEOj/fQqLg==
X-Received: by 2002:a17:903:2302:b0:1bb:e74b:39ff with SMTP id d2-20020a170903230200b001bbe74b39ffmr12134008plh.0.1694502129564;
        Tue, 12 Sep 2023 00:02:09 -0700 (PDT)
Received: from n37-019-243.byted.org ([180.184.84.173])
        by smtp.gmail.com with ESMTPSA id b8-20020a170902d50800b001b8953365aesm7635401plg.22.2023.09.12.00.02.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 00:02:09 -0700 (PDT)
From:   Chuyi Zhou <zhouchuyi@bytedance.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@kernel.org, tj@kernel.org, linux-kernel@vger.kernel.org,
        Chuyi Zhou <zhouchuyi@bytedance.com>
Subject: [PATCH bpf-next v2 3/6] bpf: Introduce process open coded iterator kfuncs
Date:   Tue, 12 Sep 2023 15:01:46 +0800
Message-Id: <20230912070149.969939-4-zhouchuyi@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230912070149.969939-1-zhouchuyi@bytedance.com>
References: <20230912070149.969939-1-zhouchuyi@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
 kernel/bpf/task_iter.c         | 29 +++++++++++++++++++++++++++++
 tools/include/uapi/linux/bpf.h |  4 ++++
 tools/lib/bpf/bpf_helpers.h    |  5 +++++
 5 files changed, 45 insertions(+)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index de02c0971428..befa55b52e29 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -7322,4 +7322,8 @@ struct bpf_iter_css_task {
 	__u64 __opaque[1];
 } __attribute__((aligned(8)));
 
+struct bpf_iter_process {
+	__u64 __opaque[1];
+} __attribute__((aligned(8)));
+
 #endif /* _UAPI__LINUX_BPF_H__ */
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index d6a16becfbb9..9b7d2c6f99d1 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2507,6 +2507,9 @@ BTF_ID_FLAGS(func, bpf_iter_num_destroy, KF_ITER_DESTROY)
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
index d8539cc05ffd..9d1927dc3a06 100644
--- a/kernel/bpf/task_iter.c
+++ b/kernel/bpf/task_iter.c
@@ -851,6 +851,35 @@ __bpf_kfunc void bpf_iter_css_task_destroy(struct bpf_iter_css_task *it)
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
+}
+
 DEFINE_PER_CPU(struct mmap_unlock_irq_work, mmap_unlock_work);
 
 static void do_mmap_read_unlock(struct irq_work *entry)
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index de02c0971428..befa55b52e29 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -7322,4 +7322,8 @@ struct bpf_iter_css_task {
 	__u64 __opaque[1];
 } __attribute__((aligned(8)));
 
+struct bpf_iter_process {
+	__u64 __opaque[1];
+} __attribute__((aligned(8)));
+
 #endif /* _UAPI__LINUX_BPF_H__ */
diff --git a/tools/lib/bpf/bpf_helpers.h b/tools/lib/bpf/bpf_helpers.h
index f48723c6c593..858252c2641c 100644
--- a/tools/lib/bpf/bpf_helpers.h
+++ b/tools/lib/bpf/bpf_helpers.h
@@ -310,6 +310,11 @@ extern int bpf_iter_css_task_new(struct bpf_iter_css_task *it,
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

