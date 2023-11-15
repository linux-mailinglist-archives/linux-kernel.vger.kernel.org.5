Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F50E7EC9CB
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 18:39:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232755AbjKORhm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 12:37:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232628AbjKORhg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 12:37:36 -0500
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57F511BD
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 09:37:31 -0800 (PST)
Received: by mail-qk1-x733.google.com with SMTP id af79cd13be357-7781bc3783fso459159685a.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 09:37:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700069850; x=1700674650; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PLUf2tkG8NZ4kfbeIrEm6olUf9NTE49Bj17ZfTFY3SY=;
        b=SEDG8xAQ8M4YUl7aNvW53zzlkGKixvtyFTOFSn4Q2KmfgCGUfp5jFJ6CbJBWg17b+S
         ufYPpeM22fNqQGNBXG+IS7fHm4DfU1N85bdV/mAaBURgtbI81yWx026QPnKbPxZ22VaP
         v+wOHouYq1pNqJrWp0mBr3Jx2/SfeFgSEyE2dtr9YM7HUxFczn72QYRqByATXKAUjcul
         RoqZ5iavlXMU7OK+tj8ZEX0oWkiPde2BOn/mep5NY8jXlAjHuAboFQzQZRjkHhayAZY1
         Nj7OsbuNBhueJHsjxRqufDjeKAnmk3I0IumaoWcI4M/m3dB6/onw36HARrs9M5KuSXR0
         I42A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700069850; x=1700674650;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PLUf2tkG8NZ4kfbeIrEm6olUf9NTE49Bj17ZfTFY3SY=;
        b=pKVQPyvgsAq09fmPfMRhIxnOO+NFTqHq858q8j4whvAOguVfxSCrqqkf3hbFm0YbxW
         EvtXn9NPvCmM+hjF2OL9/HWvMGrl3w7JwLD4L748tAVES3DtJwwwIHvbY0wLDOJ/LEYv
         9J8Eiy7sxagrrHRGd/Q+JOUF3CNk5S1fnQzDvITbXihvCiZFpBNe8il/FQE96qRxB/q/
         zxlCkos/66G3regTWS7s1P3E8sP5ZTbRQhWas3FOhBMQrpS1ur2P1fbr92p8KQedOqvw
         K+d82h0icr2psO8ZXhPV9OEtx8lYZrbyFV7+IO71nWkxKkxO+LYAnXI6rScLMHfdV5VO
         D6wA==
X-Gm-Message-State: AOJu0YyCdpyC3bc0EixsuJNWHOEckr1DzhMSF1Q3WKJA2NlDMW5YmmII
        pgCNxIieVf6EqkhIxlKAFZaYO0fkDw==
X-Google-Smtp-Source: AGHT+IH3FHEZ6WXjvOoIbOQbonAxGMCzxREdT8gD6rGN4CVKomo7hL9rr8ILmrb81OpvVFfEWLlwXA==
X-Received: by 2002:a05:620a:284d:b0:778:9824:4b7a with SMTP id h13-20020a05620a284d00b0077898244b7amr6407829qkp.69.1700069850080;
        Wed, 15 Nov 2023 09:37:30 -0800 (PST)
Received: from citadel.lan ([2600:6c4a:4d3f:6d5c::1019])
        by smtp.gmail.com with ESMTPSA id x20-20020a05620a0b5400b0077bda014d8esm3260099qkg.87.2023.11.15.09.37.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 09:37:28 -0800 (PST)
From:   Brian Gerst <brgerst@gmail.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Uros Bizjak <ubizjak@gmail.com>, David.Laight@aculab.com,
        Brian Gerst <brgerst@gmail.com>
Subject: [PATCH v3 04/14] x86/pvh: Use fixed_percpu_data for early boot GSBASE
Date:   Wed, 15 Nov 2023 12:36:58 -0500
Message-ID: <20231115173708.108316-5-brgerst@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231115173708.108316-1-brgerst@gmail.com>
References: <20231115173708.108316-1-brgerst@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of having a private area for the stack canary, use
fixed_percpu_data for GSBASE like the native kernel.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
---
 arch/x86/platform/pvh/head.S | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/arch/x86/platform/pvh/head.S b/arch/x86/platform/pvh/head.S
index c4365a05ab83..fab90368481f 100644
--- a/arch/x86/platform/pvh/head.S
+++ b/arch/x86/platform/pvh/head.S
@@ -94,10 +94,15 @@ SYM_CODE_START_LOCAL(pvh_start_xen)
 	/* 64-bit entry point. */
 	.code64
 1:
-	/* Set base address in stack canary descriptor. */
+	/*
+	 * Set up GSBASE.
+	 * Note that, on SMP, the boot cpu uses init data section until
+	 * the per cpu areas are set up.
+	 */
 	mov $MSR_GS_BASE,%ecx
-	mov $_pa(canary), %eax
-	xor %edx, %edx
+	lea INIT_PER_CPU_VAR(fixed_percpu_data)(%rip), %rdx
+	mov %edx, %eax
+	shr $32, %rdx
 	wrmsr
 
 	call xen_prepare_pvh
@@ -156,8 +161,6 @@ SYM_DATA_START_LOCAL(gdt_start)
 SYM_DATA_END_LABEL(gdt_start, SYM_L_LOCAL, gdt_end)
 
 	.balign 16
-SYM_DATA_LOCAL(canary, .fill 48, 1, 0)
-
 SYM_DATA_START_LOCAL(early_stack)
 	.fill BOOT_STACK_SIZE, 1, 0
 SYM_DATA_END_LABEL(early_stack, SYM_L_LOCAL, early_stack_end)
-- 
2.41.0

