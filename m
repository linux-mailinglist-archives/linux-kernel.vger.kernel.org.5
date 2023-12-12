Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8480C80FB20
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 00:17:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377988AbjLLXRL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 18:17:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377975AbjLLXRJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 18:17:09 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4452CD0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 15:17:14 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-5ca29c131ebso1716749a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 15:17:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1702423034; x=1703027834; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vgg0J3qxY24SnHD9sqtPXJJls+X5lh0PMbmZ3jrDVoQ=;
        b=T6wsIoUGX3fIwDf01FpNscoSVu4ubDm1E9zTDGFrSasB/SBA+rC/I52alm6lkdDh7m
         PqA/teR0nmJ7Hdgl+e/ylfl9d3bs1oKwrnNortNZZ67G6sZrRO+zazp3yadNcdjwxQtP
         BJ5VJ7ZYbEzS/lulvk5t77B4RRA68VnFkTfWM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702423034; x=1703027834;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vgg0J3qxY24SnHD9sqtPXJJls+X5lh0PMbmZ3jrDVoQ=;
        b=Cnl4zEnW9iBoY4BmoYq/f15U7AGJFzyCNcdNx9uVLAiAeGZzTK93DdTGerkBc8fP9+
         P6HQFBEjUAvQq5wbBZOBfY9qw7wdaafAuVqH5v+iP9dgu7seE52deft6AunzxqjJnDq8
         RiZvn8gzf/YF7pP4YuxB/Tq7VfCyYiMIhDLupMuxrXuSO+xsxHrTSH6cZgHhUJ8eIfgR
         W6dzyBcyooQe7pLJM3xVANVrO8yV4dGlQwPQAmfvpJymywDtNMNP4qz5/o6L9JOuh+kW
         m/iUX3LnZS89sa/l0kNxHERm7JGbmKtp7vdaBTBt/NXjNZaRDoWbqWt3Vpe3ES+AwBpY
         d3iQ==
X-Gm-Message-State: AOJu0Yyl+EQrE50BiXrynsvrAteAgVSKMfSM/85KpE7ZH/QtDV27RBey
        j9r7jojSA063uOjIeut99t0sOQ==
X-Google-Smtp-Source: AGHT+IH0w5ya9vjJqVfLSwVuEpvbnpor4YM2jb0u3s8vpT0Fs9e2ntlip5J/9UPEmwW3uq6XLY2yzA==
X-Received: by 2002:a05:6a20:429a:b0:190:50ec:e2e4 with SMTP id o26-20020a056a20429a00b0019050ece2e4mr9563392pzj.45.1702423033741;
        Tue, 12 Dec 2023 15:17:13 -0800 (PST)
Received: from localhost (34.133.83.34.bc.googleusercontent.com. [34.83.133.34])
        by smtp.gmail.com with UTF8SMTPSA id b4-20020aa78704000000b006ce41b1ba8csm8575780pfo.131.2023.12.12.15.17.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Dec 2023 15:17:13 -0800 (PST)
From:   jeffxu@chromium.org
To:     akpm@linux-foundation.org, keescook@chromium.org, jannh@google.com,
        sroettger@google.com, willy@infradead.org,
        gregkh@linuxfoundation.org, torvalds@linux-foundation.org
Cc:     jeffxu@google.com, jorgelo@chromium.org, groeck@chromium.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, pedro.falcato@gmail.com, dave.hansen@intel.com,
        linux-hardening@vger.kernel.org, deraadt@openbsd.org,
        Jeff Xu <jeffxu@chromium.org>
Subject: [RFC PATCH v3 03/11] mseal: add can_modify_mm and can_modify_vma
Date:   Tue, 12 Dec 2023 23:16:57 +0000
Message-ID: <20231212231706.2680890-4-jeffxu@chromium.org>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
In-Reply-To: <20231212231706.2680890-1-jeffxu@chromium.org>
References: <20231212231706.2680890-1-jeffxu@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jeff Xu <jeffxu@chromium.org>

Two utilities to be used later.

can_modify_mm:
 checks sealing flags for given memory range.

can_modify_vma:
  checks sealing flags for given vma.

Signed-off-by: Jeff Xu <jeffxu@chromium.org>
---
 include/linux/mm.h | 18 ++++++++++++++++++
 mm/mseal.c         | 38 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 56 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 3d1120570de5..2435acc1f44f 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3339,6 +3339,12 @@ static inline unsigned long vma_seals(struct vm_area_struct *vma)
 	return (vma->vm_seals & MM_SEAL_ALL);
 }
 
+extern bool can_modify_mm(struct mm_struct *mm, unsigned long start,
+		unsigned long end, unsigned long checkSeals);
+
+extern bool can_modify_vma(struct vm_area_struct *vma,
+		unsigned long checkSeals);
+
 #else
 static inline bool check_vma_seals_mergeable(unsigned long vm_seals1)
 {
@@ -3349,6 +3355,18 @@ static inline unsigned long vma_seals(struct vm_area_struct *vma)
 {
 	return 0;
 }
+
+static inline bool can_modify_mm(struct mm_struct *mm, unsigned long start,
+		unsigned long end, unsigned long checkSeals)
+{
+	return true;
+}
+
+static inline bool can_modify_vma(struct vm_area_struct *vma,
+		unsigned long checkSeals)
+{
+	return true;
+}
 #endif
 
 /* These take the mm semaphore themselves */
diff --git a/mm/mseal.c b/mm/mseal.c
index 13bbe9ef5883..d12aa628ebdc 100644
--- a/mm/mseal.c
+++ b/mm/mseal.c
@@ -26,6 +26,44 @@ static bool can_do_mseal(unsigned long types, unsigned long flags)
 	return true;
 }
 
+/*
+ * check if a vma is sealed for modification.
+ * return true, if modification is allowed.
+ */
+bool can_modify_vma(struct vm_area_struct *vma,
+		    unsigned long checkSeals)
+{
+	if (checkSeals & vma_seals(vma))
+		return false;
+
+	return true;
+}
+
+/*
+ * Check if the vmas of a memory range are allowed to be modified.
+ * the memory ranger can have a gap (unallocated memory).
+ * return true, if it is allowed.
+ */
+bool can_modify_mm(struct mm_struct *mm, unsigned long start, unsigned long end,
+		   unsigned long checkSeals)
+{
+	struct vm_area_struct *vma;
+
+	VMA_ITERATOR(vmi, mm, start);
+
+	if (!checkSeals)
+		return true;
+
+	/* going through each vma to check. */
+	for_each_vma_range(vmi, vma, end) {
+		if (!can_modify_vma(vma, checkSeals))
+			return false;
+	}
+
+	/* Allow by default. */
+	return true;
+}
+
 /*
  * Check if a seal type can be added to VMA.
  */
-- 
2.43.0.472.g3155946c3a-goog

