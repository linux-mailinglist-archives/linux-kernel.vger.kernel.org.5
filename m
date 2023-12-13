Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F8A8811999
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 17:34:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233400AbjLMQet (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 11:34:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232828AbjLMQen (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 11:34:43 -0500
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4820398
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 08:34:50 -0800 (PST)
Received: by mail-oo1-xc2c.google.com with SMTP id 006d021491bc7-591341db3a1so1459106eaf.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 08:34:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702485289; x=1703090089; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0jRCUHDjv1DH+xslDSOWHcTAXqFFUhTjlGi5aeTZ7dg=;
        b=hORLxIhb8zX/0tnmRehbazEAQAwetaHyuGEvYNALpjOZ/sCX1hVKofnjKz79MFFicU
         rZIJ/5/1O6FIH4dpxN3QJOM9lujdsIvGaj5Mc4GQws5qIkTh3XH3VXJjd6HogVZTnJB7
         dWXNT+DBgrtTuclTsv3ZlQdn8to5wsW1PB+6Ze9DcgjMOgSDj3M9mUIFEbYnDvahcvu/
         UdXbBGaRMWtPnv9PZWQQgVxTAvrFVZaFmBUg4a6YoSRjTwO8c6t6E2l1KWFarzu/mZ3L
         rFXzlrmNI3YstNv3fpA//iiz5Rv6cG2jz2HCXfEbSj2qsB/AdlhJGDdUxXYXVePbjeKa
         byeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702485289; x=1703090089;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0jRCUHDjv1DH+xslDSOWHcTAXqFFUhTjlGi5aeTZ7dg=;
        b=rH7rXCoAKsqPrsZV7tuu47jBWQJ+PqiPR5saCqVj/YsmpFSvbMXZP5/OVID2XITfsE
         DMyfuIrLLXHRdSZTtuVdD5M6jGb4cveslbg+Y4COjtUOjFSj04xVqk8aXvrvO/T5vmws
         /Fq71bTIh5cMmLt77GkRbsCAPUozD7HfsAwTTkUPmQbLuJ0wOco9SI32Fx/Bs/lOYbiG
         3i4iwL+3jaT+3vbCEBiSSWTCbQhvqA7pPf2RbSaaKjjaqrOPtJTYb2PqcAjF9tgSPk8Z
         hTaF7I3QLLPCYQYAMZxhPLszHZrNjHna48PbhEIBTa6l5/TamAlB8diPYN+tRyres5JV
         4ghg==
X-Gm-Message-State: AOJu0YyV8kNoTWSc/iGvM6jOhNnZB7dUt4lKj0FYcybEsrmuWvV0soS0
        fion4f4IvJqXTl4WWGX9cJI4Yy28LQ==
X-Google-Smtp-Source: AGHT+IHICJQ+9KUI4TLQoB+iBesdTTFd2pX3rGL/nGAM0Wii3JEKUYatOD7F8rd4WwwKgWjz0oFnvQ==
X-Received: by 2002:a05:6820:1c88:b0:590:95e0:bb6c with SMTP id ct8-20020a0568201c8800b0059095e0bb6cmr6124368oob.1.1702485289104;
        Wed, 13 Dec 2023 08:34:49 -0800 (PST)
Received: from citadel.lan ([2600:6c4a:4d3f:6d5c::1019])
        by smtp.gmail.com with ESMTPSA id j11-20020a4ad2cb000000b005907ad9f302sm3104901oos.37.2023.12.13.08.34.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 08:34:48 -0800 (PST)
From:   Brian Gerst <brgerst@gmail.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        Brian Gerst <brgerst@gmail.com>, Michal Luczaj <mhal@rbox.co>
Subject: [PATCH 2/3] x86/ptrace: Reject system segements
Date:   Wed, 13 Dec 2023 11:34:42 -0500
Message-ID: <20231213163443.70490-3-brgerst@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231213163443.70490-1-brgerst@gmail.com>
References: <20231213163443.70490-1-brgerst@gmail.com>
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

Do not allow system segments (TSS and LDT) from being poked into segment
registers via ptrace.  Loading these segments into a segment register
normally results in a general protection fault.  But in the case of
ptrace, setting CS or SS to a system segment will cause IRET to fault.
This then results in the instruction decoder attempting to use the
invalid segment.  This can be avoided by rejecting system segments in
PTRACE_SETREGS.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
Reported-By: Michal Luczaj <mhal@rbox.co>
Link: https://lore.kernel.org/lkml/20231206004654.2986026-1-mhal@rbox.co/
---
 arch/x86/include/asm/segment.h | 11 +++++++++++
 arch/x86/kernel/ptrace.c       | 12 ++----------
 2 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/arch/x86/include/asm/segment.h b/arch/x86/include/asm/segment.h
index a155843d0c37..ede1fa5aa4cc 100644
--- a/arch/x86/include/asm/segment.h
+++ b/arch/x86/include/asm/segment.h
@@ -359,6 +359,17 @@ static inline void __loadsegment_fs(unsigned short value)
 #define savesegment(seg, value)				\
 	asm("mov %%" #seg ",%0":"=r" (value) : : "memory")
 
+/*
+ * Determines whether a value may be installed in a segment register.
+ */
+static inline bool valid_user_selector(u16 value)
+{
+	if (unlikely(!(value & SEGMENT_TI_MASK) && value >= (GDT_SYSTEM_START * 8)))
+		return false;
+
+	return likely(value == 0 || (value & SEGMENT_RPL_MASK) == USER_RPL);
+}
+
 #endif /* !__ASSEMBLY__ */
 #endif /* __KERNEL__ */
 
diff --git a/arch/x86/kernel/ptrace.c b/arch/x86/kernel/ptrace.c
index 095f04bdabdc..4c3a2278691e 100644
--- a/arch/x86/kernel/ptrace.c
+++ b/arch/x86/kernel/ptrace.c
@@ -162,14 +162,6 @@ const char *regs_query_register_name(unsigned int offset)
 				  X86_EFLAGS_DF | X86_EFLAGS_OF |	\
 				  X86_EFLAGS_RF | X86_EFLAGS_AC))
 
-/*
- * Determines whether a value may be installed in a segment register.
- */
-static inline bool invalid_selector(u16 value)
-{
-	return unlikely(value != 0 && (value & SEGMENT_RPL_MASK) != USER_RPL);
-}
-
 #ifdef CONFIG_X86_32
 
 #define FLAG_MASK		FLAG_MASK_32
@@ -206,7 +198,7 @@ static int set_segment_reg(struct task_struct *task,
 	/*
 	 * The value argument was already truncated to 16 bits.
 	 */
-	if (invalid_selector(value))
+	if (!valid__user_selector(value))
 		return -EIO;
 
 	/*
@@ -296,7 +288,7 @@ static int set_segment_reg(struct task_struct *task,
 	/*
 	 * The value argument was already truncated to 16 bits.
 	 */
-	if (invalid_selector(value))
+	if (!valid_user_selector(value))
 		return -EIO;
 
 	/*
-- 
2.43.0

