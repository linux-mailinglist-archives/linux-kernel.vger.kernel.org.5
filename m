Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91C1780284E
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 23:12:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233971AbjLCWMA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 17:12:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbjLCWL5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 17:11:57 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE27DD5
        for <linux-kernel@vger.kernel.org>; Sun,  3 Dec 2023 14:12:03 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-40bd5eaa66cso20737095e9.2
        for <linux-kernel@vger.kernel.org>; Sun, 03 Dec 2023 14:12:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701641522; x=1702246322; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jl45wvWcP4iiFsyKLXsZFij0FbjKyVAo4CJ25+GOTjE=;
        b=AspID5fkWRpmTi1Fe1T5hfcpRdQwHyq88N+HLYaOuN0rlOjbFStNpW40NJSF28PKqy
         niteN7NsKxc+Cpms5s6R+CqgjU6uiXtIQUfCi4Hed+HKq9jN38890Q1IGZO/+Dvsb3ff
         G/EnHlzPREtQmbZFxsQkQxEW7lTsnFrUA9y8r7ZpcLOR8lDafzqVEBrYITgNZ+JnPyIy
         cf1yVAH2MctqOQRQNtDhY5sQ7PQDkVeXO/zWpeNQEHsJL3AGWGbN0gbIgBdBlulvVmGt
         nReWc7LEaS/VwIXeSuBf+vX/gf/c6z3pWFJUJjia76DCHyeeAATDhAJLupSYCkcUxkI1
         ECgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701641522; x=1702246322;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jl45wvWcP4iiFsyKLXsZFij0FbjKyVAo4CJ25+GOTjE=;
        b=aqNi28Zy987jR3zpNKep2QBuDZY6Cy3vI3tLIopZTZuOICTO/nQa9A3UpFDTU37Efe
         x341ypg0OJzPdtWBz/fIz6XxSm54FShYwFY3eSquJJsMSqR4S9R8+/7KewsTXQKFTLgI
         CDe1hSjw+zOvoc2l0qLQ6xMVek9o2CWpTr8TDND/r8l86K8FY2rZFu+MEEfNJ1LCvwcV
         w8gUgmtjZo0fzCxOQdWJJdPQW1qvmIypmH0TZXAgtWXps+wRlAXubchFZeKEmF88mOBP
         kNzYg0JGQmbVNDtr2/+F9MibqFBKmNPfby+81zB3xH8iQEgZI/OWd+q9zRuE2Ku72wPh
         TFbA==
X-Gm-Message-State: AOJu0Yz8MtQypzj6Bm8p9h+KD+E/oYa4YrSN5HuDZnbIPGaPJwajEPOr
        Xn7cyH8MFRA6fOflqqteaJA=
X-Google-Smtp-Source: AGHT+IFKQIvn5kfrLhppfm0Kuucy4T59wJ1D0g7Loipws0ogzAHcLJsQzaOtMkGKsl2GnaUrLQMWCg==
X-Received: by 2002:a05:600c:2d86:b0:40b:5e21:dd1f with SMTP id i6-20020a05600c2d8600b0040b5e21dd1fmr1926330wmg.77.1701641522184;
        Sun, 03 Dec 2023 14:12:02 -0800 (PST)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id ay10-20020a05600c1e0a00b0040b397787d3sm16589181wmb.24.2023.12.03.14.12.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Dec 2023 14:12:02 -0800 (PST)
From:   Uros Bizjak <ubizjak@gmail.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     Uros Bizjak <ubizjak@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH -tip 2/3] x86/traps: Use current_top_of_stack() helper in traps.c
Date:   Sun,  3 Dec 2023 23:10:53 +0100
Message-ID: <20231203221151.794615-2-ubizjak@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231203221151.794615-1-ubizjak@gmail.com>
References: <20231203221151.794615-1-ubizjak@gmail.com>
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

Use current_top_of_stack() helper in sync_regs() and vc_switch_off_ist()
instead of reading top_of_stack percpu variable explicitly.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
---
 arch/x86/kernel/traps.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index c876f1d36a81..78b1d1a6ed2c 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -772,7 +772,7 @@ DEFINE_IDTENTRY_RAW(exc_int3)
  */
 asmlinkage __visible noinstr struct pt_regs *sync_regs(struct pt_regs *eregs)
 {
-	struct pt_regs *regs = (struct pt_regs *)this_cpu_read(pcpu_hot.top_of_stack) - 1;
+	struct pt_regs *regs = (struct pt_regs *)current_top_of_stack() - 1;
 	if (regs != eregs)
 		*regs = *eregs;
 	return regs;
@@ -790,7 +790,7 @@ asmlinkage __visible noinstr struct pt_regs *vc_switch_off_ist(struct pt_regs *r
 	 * trust it and switch to the current kernel stack
 	 */
 	if (ip_within_syscall_gap(regs)) {
-		sp = this_cpu_read(pcpu_hot.top_of_stack);
+		sp = current_top_of_stack();
 		goto sync;
 	}
 
-- 
2.42.0

