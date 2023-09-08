Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E70EE798B9B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 19:57:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243750AbjIHR4y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 13:56:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235668AbjIHR4x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 13:56:53 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B17B21FCA
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 10:56:49 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d780a0d3cefso2195323276.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Sep 2023 10:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1694195809; x=1694800609; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sm/GVlmeHT2HjPSaV/RDHBoToFYHbp3bUGhZJgMdMmw=;
        b=0jG0/2f0PfKOx0VDJQmWxIWGxQ/NZVhUQ1qFOl99Er3164aVoXG615Fser1XzIMg0U
         D0Awptk4YCj5B38PV91xwF5SD96SOyW0f3e1Xe0ygzcnqa2YxvxoSvUWJWOQ6a6+cu0B
         VSUbv+aWhzjCI5i8vTgWxkIQAVuC6J1gHmP4N/+XMrIkEJNJNSt73B3ZrZVwOTJuRFlj
         kLdmJp7cadZAkRfY4/EmmlaCPOV2wtWnRCS2jKFaIQBYan5sjITQvM8MsauVJwu1pp0M
         cqnOoibFUxaKcf/qb0vV4G1U/D23L5y9LW3KLxykcf1Tf6zf5i88SOg2h+mqASGsIuP5
         RFbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694195809; x=1694800609;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sm/GVlmeHT2HjPSaV/RDHBoToFYHbp3bUGhZJgMdMmw=;
        b=Z+60qTCR6nXspY55hr/k82f/5IfPUrL+Pl4o77Bi14GU5U/iQ/xgDLxMFQ9GSSq47D
         pNG1oXxZT2cgmc+J2+imUF1eWxuR3CEgJNTbA4ddr14Gsgjz0Fu8Vc437m4jj9JzxswK
         qojJphPDGxRMty47F3FwqCX0c1nUxEMZTFzyPZ6VD4ou0Ps9gUB0XJEgC0t498C3slZ7
         NvmY4GtjunnpRSL47Bo0zSJiV1Sr99TxVaYH4vJ4Gn6lKF/pgLYVsO5XkV78iRmp2Bb+
         UFTcRp+rxbJP0Qo/7cME6RuAQySWVnYy6wI9fo5V1Dd6ohOA4apqRukhL5SVLtTA8pyc
         RPxg==
X-Gm-Message-State: AOJu0Yzb3ptPguFUgK3uU1qEZp13f3lEAbT/PGYRgVjYMoxpl6fAER8u
        ZtnDzsGinMxzPHI0vZZuKSW5ghkabA==
X-Google-Smtp-Source: AGHT+IGbH9h3+1Y2V0Rq0JiRLyDE+YvbbZH0ToxlJtk7Svq8q3keOY/ii6n+qTBrDMd2Bg6pEy4BFOzkxg==
X-Received: from sagi.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:241b])
 (user=sagis job=sendgmr) by 2002:a25:d7d0:0:b0:d77:bcce:eb11 with SMTP id
 o199-20020a25d7d0000000b00d77bcceeb11mr65829ybg.10.1694195808968; Fri, 08 Sep
 2023 10:56:48 -0700 (PDT)
Date:   Fri,  8 Sep 2023 10:56:44 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
Message-ID: <20230908175644.2478924-1-sagis@google.com>
Subject: [PATCH] x86/tdx: Allow extended topology CPUID leafs to be emulated
 by hypercall
From:   Sagi Shahar <sagis@google.com>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Jun Nakajima <jun.nakajima@intel.com>,
        Isaku Yamahata <isaku.yamahata@intel.com>,
        Erdem Aktas <erdemaktas@google.com>,
        Vishal Annapurve <vannapurve@google.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Nikolay Borisov <nik.borisov@suse.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Sagi Shahar <sagis@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current TDX module does not handle extended topology leaves
explicitly and will generate a #VE but the current #VE handler
implementation blindly returns 0 for those CPUID leaves.

This currently causes TDX guests to see 0 values when querying the numa
topology leading to incorrect numa configurations.

This patch fixes this behavior by emulating the extended topology leaves
using the CPUID hypercall.

Change-Id: I427807e3ac8d9e3be50a6fac40ebd3f54b445b0c
Signed-off-by: Sagi Shahar <sagis@google.com>
---
 arch/x86/coco/tdx/tdx.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index 1d6b863c42b0..db9a4673555a 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -321,13 +321,16 @@ static int handle_cpuid(struct pt_regs *regs, struct ve_info *ve)
 	};
 
 	/*
-	 * Only allow VMM to control range reserved for hypervisor
-	 * communication.
+	 * Only emulate CPUID in 2 cases:
+	 * - CPUID is in the range reserved for hypervisor communication.
+	 * - CPUID is an extended topology leaf which is not emulated natively
+	 *   by the TDX module.
 	 *
-	 * Return all-zeros for any CPUID outside the range. It matches CPU
-	 * behaviour for non-supported leaf.
+	 * Return all-zeros for any other CPUID. It matches CPU behaviour for
+	 * non-supported leaf.
 	 */
-	if (regs->ax < 0x40000000 || regs->ax > 0x4FFFFFFF) {
+	if ((regs->ax < 0x40000000 || regs->ax > 0x4FFFFFFF) &&
+	    regs->ax != 0x0b && regs->ax != 0x1f) {
 		regs->ax = regs->bx = regs->cx = regs->dx = 0;
 		return ve_instr_len(ve);
 	}
-- 
2.42.0.283.g2d96d420d3-goog

