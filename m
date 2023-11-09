Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 094F87E72A7
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 21:10:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345119AbjKIUKp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 15:10:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbjKIUKo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 15:10:44 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D63544AF
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 12:10:42 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-9e1021dbd28so222242466b.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Nov 2023 12:10:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699560641; x=1700165441; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Hme3VruWKu/ViE/hI0yCfth5H5XHosene3ze2VB+fj0=;
        b=iPNq1jgNr3/tmuR8g00EBYI2QqNsN1XknCKiSngcBwExvfP8C3HKn3WfzoKIxJHDot
         gXLaz722ol8Vwc0xBBUEy9uwWROnAPK3k7GDCfyBv7jkGZ8zaR9o3tWGlyTRfmsASP9A
         QH2WZrVUiK/0VRHxNPiWz1qazCRbjwe49DIGDWrpGXvf8NuPf7/zRGkKJmPxqCXudd2x
         RNpabKsLAOx+COJwBHCMdluFUicp6v2fmbaaUF5Jga8GByHoZFMBhyXp5GuSo3jb/1JK
         oDXLJje6e6yRTi24OMh1UncVh4nHAPkytru1zFXLEVYXfG5DDfYMZqrCVDfm0ANzbYIh
         b3Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699560641; x=1700165441;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Hme3VruWKu/ViE/hI0yCfth5H5XHosene3ze2VB+fj0=;
        b=UO+QlYnq5DBsHgxlMrvzFD3DTwmwIOCl32C8R8B8FQWr7bYPPHDs2sAyoWRK+W4YH7
         ssUwPq6c5HSjegQrOPzCAIR6ex3QKR++8n9wZisjupVnxqXo781HkaGzMSibD2VKyclZ
         tLETF74jzzSHJ29z3y1EY1YmRZKphIauu/uufpb8CHl5K2P6ta4o3i0fy+QRWelRtwYh
         jWAp4g3H+228RZZUILhreRbmvCmY9oNl97seIgPQsQcAhbel9Z03aPYBQpiZujBy82XX
         MSgWq5zMThhSRlz1p2SKMRZ+vbJzyPVHEN9RiXX3dt/fjYW1F+zYgYwXJt6ATOE+Ylz8
         7OIA==
X-Gm-Message-State: AOJu0Ywo9MOtoXRt+LhVBee1WiBGF1asvj4aY4Ak6rZPI/0riZdjFKLH
        2ZfMP3MvZgU8F3rkJUWgQ18=
X-Google-Smtp-Source: AGHT+IEQ/3pQdgQDPdZlU5i0auVUfXxaqEQg0tb9j5qH0CmWWQIlsc/hmEVDExu5fNvI71CUehTp+w==
X-Received: by 2002:a17:906:7943:b0:9bd:a063:39d2 with SMTP id l3-20020a170906794300b009bda06339d2mr5681005ejo.16.1699560640630;
        Thu, 09 Nov 2023 12:10:40 -0800 (PST)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id qx11-20020a170906fccb00b009b2f2451381sm2976019ejb.182.2023.11.09.12.10.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 12:10:40 -0800 (PST)
From:   Uros Bizjak <ubizjak@gmail.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     Uros Bizjak <ubizjak@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: [PATCH] x86/head_64: Use testb instead of testl in secondary_startup_64_no_verify
Date:   Thu,  9 Nov 2023 21:09:56 +0100
Message-ID: <20231109201032.4439-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no need to use testl when checking LSB with a test instruction.
Use testb, which is three bytes shorter:

   f6 05 00 00 00 00 01    testb  $0x1,0x0(%rip)

vs:

   f7 05 00 00 00 00 01    testl  $0x1,0x0(%rip)
   00 00 00

for the same effect.

No functional changes intended.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>
Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
---
 arch/x86/kernel/head_64.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index 086a2c3aaaa0..1f79d809305d 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -182,7 +182,7 @@ SYM_INNER_LABEL(secondary_startup_64_no_verify, SYM_L_GLOBAL)
 	/* Enable PAE mode, PSE, PGE and LA57 */
 	orl	$(X86_CR4_PAE | X86_CR4_PSE | X86_CR4_PGE), %ecx
 #ifdef CONFIG_X86_5LEVEL
-	testl	$1, __pgtable_l5_enabled(%rip)
+	testb	$1, __pgtable_l5_enabled(%rip)
 	jz	1f
 	orl	$X86_CR4_LA57, %ecx
 1:
-- 
2.41.0

