Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E49C07EC9CF
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 18:39:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232977AbjKORi0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 12:38:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232823AbjKORiI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 12:38:08 -0500
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68433173B
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 09:37:44 -0800 (PST)
Received: by mail-qk1-x732.google.com with SMTP id af79cd13be357-7781bc3783fso459173485a.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 09:37:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700069862; x=1700674662; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pv8uTN4aHjsRuvoEGWM8GCEtdvaJFwUVZz3IVlIYzsA=;
        b=nJqMBNDDm80Mc+hthJoqWkPkxqQXFZWfWTrkbyCp8IBMYn6lBhkBiC5FtTz/hwl4TY
         +v0ckxFYS6QXHe2ZdYiGbTlo7ZUD5hfgnE9cojKZ11kiNBtadb2IQilXlrt0NS4R7rsV
         m26+aTppe6lwxvSWSVBniMDFjD6zNnh7OOlYCPyVyI4tRYdGUK9loC+iKsEGfrSEHRmF
         36UH0UJzUq+DWb0dI8uYrPy9LcM6gVFAaOT0v10Kt0ukNZMV1VMqLQnaGXV+DLFGrZ7G
         IKfkFlOyqS40bHlhIhKxJHh9eFVQFk+SjlMPTLUzaD5Msc7dNSEdWapzQP03ubOKEMpm
         9KEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700069862; x=1700674662;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pv8uTN4aHjsRuvoEGWM8GCEtdvaJFwUVZz3IVlIYzsA=;
        b=F5sm9ss3dmFuu0G8NcLnvDfy41OkWmf8vQuW2dViLIh2VNFJyBxklxvauh0kx128sw
         1FoIMAAHMBbW8YEVf8+SilIHVxlHdzGl2LNfBTZVRWFQgtVHWZNyn2a8fxBFPZlSDXXQ
         +JdpBgWzzogvQ0Vg+4nJkh+KHZQL4sUPH86PoiUZvL5GS498W9EG96r/SAxJ3qULJOU7
         GhWPwkloDze3z6bisZ7+I/BqF+YyTpUNso4crkoEVchV7vRuKzDsgBzyUHcjWOZuvIn+
         I306Kn75sZ9AvOFXda6uCLtAJe6Tf0kInUP3kncTkuMYipolIVDqbIj7riOK1XNegyh/
         u/FQ==
X-Gm-Message-State: AOJu0YzKNoOUeFk1fYUoTT38ytmlL2f+xAhue8RMJ0SU0VX5PmBtzxzD
        0IaIMPRBdpEb01gFhdhEYRTGuMUnug==
X-Google-Smtp-Source: AGHT+IEDZsp9UakDhaCQ083s0oOcpalrQ55cJXqz8rBgiwh1nm1vQuVM64EOFrfe4e03iMP0/rU6Ww==
X-Received: by 2002:a05:6214:c62:b0:671:3493:61e8 with SMTP id t2-20020a0562140c6200b00671349361e8mr8034104qvj.26.1700069862230;
        Wed, 15 Nov 2023 09:37:42 -0800 (PST)
Received: from citadel.lan ([2600:6c4a:4d3f:6d5c::1019])
        by smtp.gmail.com with ESMTPSA id x20-20020a05620a0b5400b0077bda014d8esm3260099qkg.87.2023.11.15.09.37.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 09:37:41 -0800 (PST)
From:   Brian Gerst <brgerst@gmail.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Uros Bizjak <ubizjak@gmail.com>, David.Laight@aculab.com,
        Brian Gerst <brgerst@gmail.com>
Subject: [PATCH v3 13/14] percpu: Remove PER_CPU_FIRST_SECTION
Date:   Wed, 15 Nov 2023 12:37:07 -0500
Message-ID: <20231115173708.108316-14-brgerst@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231115173708.108316-1-brgerst@gmail.com>
References: <20231115173708.108316-1-brgerst@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

x86-64 was the only user.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
---
 include/asm-generic/vmlinux.lds.h |  1 -
 include/linux/percpu-defs.h       | 12 ------------
 2 files changed, 13 deletions(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index bae0fe4d499b..579bd5ad09b9 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -1026,7 +1026,6 @@
  */
 #define PERCPU_INPUT(cacheline)						\
 	__per_cpu_start = .;						\
-	*(.data..percpu..first)						\
 	. = ALIGN(PAGE_SIZE);						\
 	*(.data..percpu..page_aligned)					\
 	. = ALIGN(cacheline);						\
diff --git a/include/linux/percpu-defs.h b/include/linux/percpu-defs.h
index ec3573119923..b9ddee91e6c7 100644
--- a/include/linux/percpu-defs.h
+++ b/include/linux/percpu-defs.h
@@ -26,13 +26,11 @@
 #define PER_CPU_SHARED_ALIGNED_SECTION "..shared_aligned"
 #define PER_CPU_ALIGNED_SECTION "..shared_aligned"
 #endif
-#define PER_CPU_FIRST_SECTION "..first"
 
 #else
 
 #define PER_CPU_SHARED_ALIGNED_SECTION ""
 #define PER_CPU_ALIGNED_SECTION "..shared_aligned"
-#define PER_CPU_FIRST_SECTION ""
 
 #endif
 
@@ -114,16 +112,6 @@
 #define DEFINE_PER_CPU(type, name)					\
 	DEFINE_PER_CPU_SECTION(type, name, "")
 
-/*
- * Declaration/definition used for per-CPU variables that must come first in
- * the set of variables.
- */
-#define DECLARE_PER_CPU_FIRST(type, name)				\
-	DECLARE_PER_CPU_SECTION(type, name, PER_CPU_FIRST_SECTION)
-
-#define DEFINE_PER_CPU_FIRST(type, name)				\
-	DEFINE_PER_CPU_SECTION(type, name, PER_CPU_FIRST_SECTION)
-
 /*
  * Declaration/definition used for per-CPU variables that must be cacheline
  * aligned under SMP conditions so that, whilst a particular instance of the
-- 
2.41.0

