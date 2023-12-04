Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC3F38040AC
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 22:03:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233859AbjLDVD1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 16:03:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233724AbjLDVDZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 16:03:25 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01411AA
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 13:03:31 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-40c0fc1cf3dso3452905e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 13:03:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701723810; x=1702328610; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jl45wvWcP4iiFsyKLXsZFij0FbjKyVAo4CJ25+GOTjE=;
        b=HDNqsAqB6mhHvIgxXgqCYN+9FvVqq2ZuzrBqitqc9epLJOTjh0S68vyB2+2cZ0AVzb
         C22JrtlpShdVXMe9JZZMMZyD1+zBTmEory0LAcOm0chnNV1ToHzLHIah5xmkG2ESNvBp
         O+17H4KyhTQI8eu/o9ukGXO4lZ4y1hGrkrfbAErMvwhnqVpL+jutrhBqzdk2mc2jr/4y
         +QVtmrHMxOAp073mpXU+eJ9C2GPs2BHSDsO2o2LrDsHuySCgo8WGLqNhh4S23Ec5iPgl
         eV8QLS63yKhri6JBkjBTFl1C17qi9LExhJ2ukxdidY19mvUOgIXDO1aUqCsuBc3A/8+z
         xfRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701723810; x=1702328610;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jl45wvWcP4iiFsyKLXsZFij0FbjKyVAo4CJ25+GOTjE=;
        b=SpVB9sm7r3o1JzxxPzoLYxeDQIAI3IzyUV6/SFWBmyMv3ca+zWYkAmegS6vdq3JCp8
         YmaWnpKKenbBCAUmFwz/+UMJliE9xf8G5mTnh1QzoC/uYYVTkApxmT5ca3xN8regKgde
         w9oQmlrBXhm624oV4gfynZ6ASg/AUdD0dFxOFhiFT/2mAd2AaISlSgIhj3ljlrt6bOPX
         F8lTeRp9ocyIstbLW3mQemq/7KwRE+j3rBj7exUaAk9K3DYzFkM5qK1Fq6BKpkI2NsMG
         QKTPize1DarhIyeF03EX+xyB1vf10rdSi42Wu8Kf1aSdmhbmac6pi7v9aLoCaJD6n67U
         soDw==
X-Gm-Message-State: AOJu0Yzbq2tglB3yAfn89j8LJhdpmA070lkzsPxt9oOCWx9DvYq/k6/Z
        P4SFp+mMz/eVGIYp3yzQ94D/UbyNoi8Q3TkR
X-Google-Smtp-Source: AGHT+IGJPn5osfjoX+p5IT7QtoaPr4sNrRPTaxhGtBOu6jXL5x8wg6fkGP8om5KAemOzD0gBvOCzCQ==
X-Received: by 2002:a05:600c:474e:b0:40b:47cb:5f90 with SMTP id w14-20020a05600c474e00b0040b47cb5f90mr2768696wmo.27.1701723810051;
        Mon, 04 Dec 2023 13:03:30 -0800 (PST)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id b18-20020a05600c4e1200b0040c08567bbfsm7414815wmq.17.2023.12.04.13.03.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 13:03:29 -0800 (PST)
From:   Uros Bizjak <ubizjak@gmail.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     Uros Bizjak <ubizjak@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH -tip v3 2/3] x86/traps: Use current_top_of_stack() helper in traps.c
Date:   Mon,  4 Dec 2023 22:02:30 +0100
Message-ID: <20231204210320.114429-2-ubizjak@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231204210320.114429-1-ubizjak@gmail.com>
References: <20231204210320.114429-1-ubizjak@gmail.com>
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

