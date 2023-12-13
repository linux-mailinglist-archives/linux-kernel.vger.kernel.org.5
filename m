Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05493811998
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 17:34:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233114AbjLMQeo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 11:34:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232663AbjLMQem (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 11:34:42 -0500
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38C1998
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 08:34:49 -0800 (PST)
Received: by mail-oo1-xc2e.google.com with SMTP id 006d021491bc7-59093f6c94aso2375406eaf.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 08:34:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702485287; x=1703090087; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zJ6yzzdHCK6etXayum+0eGdCGB2aFZEnSrrZblNix5w=;
        b=R+YhY2IBlfBgXuGL1bpFveRtSQR9n0PiMGYM4wqdsvdj38EURvCi5SE2KyX7pLol1V
         Ux74x1K4AUNUKCgGB6WESiM+54J14rLQmvG4l0pqIEHqsSFDrf3IljRU2kfc7SKuIER3
         yYIcbJp0DjUKVeFE689yIz32ESMhle7NPXbzOdiBq/oFk2DuOkmbqnk/5LfNPEK7XfAV
         /GWzoXGYMRD0T6psf3cZFiYarwpKR39/4X3eVd6SLVWsdKmCPB0exQQrjzL7v8zOZiTi
         856ydvvV06Dh0PPi5jPsujAhasB1itWXPeIP5PNslI43KOssBndqjG2Ql49PZTExKdY+
         kqxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702485287; x=1703090087;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zJ6yzzdHCK6etXayum+0eGdCGB2aFZEnSrrZblNix5w=;
        b=kcllg9wLL8G7GxQhWPp0tvUUIcgyHr9nctEHDonTbjtElWdnO82p2i057YGJgURvkY
         k9aQy6ZLv2cg2eQVclX5hL10/6qexyxAGhk/9QgqPSkKwc4PtGUpXkNSFiJr2ty75Bqf
         7wcjbZkvvPUZddwv6+WqkXcfnsTIjNzrmhZZ08ED5xT8+5idqp4w+N0ITf+HJXkujWKA
         6NjV97YtLfM3hcx35Q6PdIcq1p+TAg8kdfT2JNFnOe7txk0KgURkYIbMT4p0NSUHhmmN
         uuDCX8zq7WSwjlBblwCqaW6ncCbU3EQH/fJsQqRiVtO1jgCwReNGThuyDXSi6qhFs4z8
         M6cA==
X-Gm-Message-State: AOJu0Yw5WNEHboq9s01IaLhhinsCSoUOhVg/MfKOfiK8vPB8XvinrYeZ
        g+abiKtzkXsJOHr0THKlcGYTrDc9rQ==
X-Google-Smtp-Source: AGHT+IH9N99VQwIawvjz/NKYBGbiBOggFlFZ3Aq+V/+voSZvc8Rizdq+CDR5fdnvazMceMuNCFSKjQ==
X-Received: by 2002:a4a:e825:0:b0:590:e78e:3e37 with SMTP id d5-20020a4ae825000000b00590e78e3e37mr2884222ood.1.1702485287640;
        Wed, 13 Dec 2023 08:34:47 -0800 (PST)
Received: from citadel.lan ([2600:6c4a:4d3f:6d5c::1019])
        by smtp.gmail.com with ESMTPSA id j11-20020a4ad2cb000000b005907ad9f302sm3104901oos.37.2023.12.13.08.34.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 08:34:47 -0800 (PST)
From:   Brian Gerst <brgerst@gmail.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        Brian Gerst <brgerst@gmail.com>
Subject: [PATCH 1/3] x86: Move TSS and LDT to end of the GDT
Date:   Wed, 13 Dec 2023 11:34:41 -0500
Message-ID: <20231213163443.70490-2-brgerst@gmail.com>
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

This will make testing for system segments easier.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
---
 arch/x86/include/asm/segment.h | 33 +++++++++++++++++++++------------
 1 file changed, 21 insertions(+), 12 deletions(-)

diff --git a/arch/x86/include/asm/segment.h b/arch/x86/include/asm/segment.h
index 9d6411c65920..a155843d0c37 100644
--- a/arch/x86/include/asm/segment.h
+++ b/arch/x86/include/asm/segment.h
@@ -83,8 +83,8 @@
  *  13 - kernel data segment
  *  14 - default user CS
  *  15 - default user DS
- *  16 - TSS								<=== cacheline #5
- *  17 - LDT
+ *  16 - unused								<=== cacheline #5
+ *  17 - unused
  *  18 - PNPBIOS support (16->32 gate)
  *  19 - PNPBIOS support
  *  20 - PNPBIOS support						<=== cacheline #6
@@ -97,8 +97,11 @@
  *  26 - ESPFIX small SS
  *  27 - per-cpu			[ offset to per-cpu data area ]
  *  28 - VDSO getcpu
- *  29 - unused
- *  30 - unused
+ *
+ *  ------- start of system segments:
+ *
+ *  29 - TSS
+ *  30 - LDT
  *  31 - TSS for double fault handler
  */
 #define GDT_ENTRY_TLS_MIN		6
@@ -108,8 +111,6 @@
 #define GDT_ENTRY_KERNEL_DS		13
 #define GDT_ENTRY_DEFAULT_USER_CS	14
 #define GDT_ENTRY_DEFAULT_USER_DS	15
-#define GDT_ENTRY_TSS			16
-#define GDT_ENTRY_LDT			17
 #define GDT_ENTRY_PNPBIOS_CS32		18
 #define GDT_ENTRY_PNPBIOS_CS16		19
 #define GDT_ENTRY_PNPBIOS_DS		20
@@ -121,6 +122,10 @@
 #define GDT_ENTRY_PERCPU		27
 #define GDT_ENTRY_CPUNODE		28
 
+/* Start of system segments */
+
+#define GDT_ENTRY_TSS			29
+#define GDT_ENTRY_LDT			30
 #define GDT_ENTRY_DOUBLEFAULT_TSS	31
 
 /*
@@ -188,20 +193,22 @@
 #define GDT_ENTRY_DEFAULT_USER_DS	5
 #define GDT_ENTRY_DEFAULT_USER_CS	6
 
-/* Needs two entries */
-#define GDT_ENTRY_TSS			8
-/* Needs two entries */
-#define GDT_ENTRY_LDT			10
-
 #define GDT_ENTRY_TLS_MIN		12
 #define GDT_ENTRY_TLS_MAX		14
 
 #define GDT_ENTRY_CPUNODE		15
 
+/* Start of system segments */
+
+/* Needs two entries */
+#define GDT_ENTRY_TSS			16
+/* Needs two entries */
+#define GDT_ENTRY_LDT			18
+
 /*
  * Number of entries in the GDT table:
  */
-#define GDT_ENTRIES			16
+#define GDT_ENTRIES			20
 
 /*
  * Segment selector values corresponding to the above entries:
@@ -219,6 +226,8 @@
 
 #endif
 
+#define GDT_SYSTEM_START		GDT_ENTRY_TSS
+
 #define IDT_ENTRIES			256
 #define NUM_EXCEPTION_VECTORS		32
 
-- 
2.43.0

