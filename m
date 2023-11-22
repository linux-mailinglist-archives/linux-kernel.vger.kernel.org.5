Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A8567F3C26
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 04:06:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343549AbjKVDGe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 22:06:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235035AbjKVDGb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 22:06:31 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF6E012C
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 19:06:27 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-6c115026985so6373921b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 19:06:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1700622387; x=1701227187; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xQTyfvTA/sT9rfHfHNgSFRFvzietrqmBvaroSzp1CzI=;
        b=GJkkVI7WcCmlpXCnMuay2CNDJOZacbcwlgUAnb8Xfl4Xaz2iatpSI1l7x9cpE4ESN/
         uyVSUTJC/LEsx1/KfZedaEpHA1mntL7uq7t0lMu9yA6nxIRXz4Ek26Z5JyBCvsphNz0H
         QCuHig0kc/J4QI8BMl0O6qfr1jJSFa7cLoZLHMn4Z2JeX+ey0RA07pqUYU896/pMZ9Y9
         /ar2HKRhvcjrYuYxrVkZmO9RhDsvZQgDrn8QA7+shJ3uG9sbtqEmuldlybyJYIGdM0x4
         3ZgNOBIdtOfvwZbSxso0IUV+iego45YucPVUIw+7tm+zLgchCuOsteANbg1FtHarMosh
         42pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700622387; x=1701227187;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xQTyfvTA/sT9rfHfHNgSFRFvzietrqmBvaroSzp1CzI=;
        b=uF5/Lp3w5AdeWCQh8Bq6/ihT8WyrfVVY+Fkdjs+Df5ppASnhzCMoveOadSL8ImXWWW
         556GV+oE+eF5Y+X3yi1mGaIUSgR93petnIdWLM8omUSGmra3/JugBpyXf15tepmku9gw
         5FyXTk9AA6g9lxZx6Fgqz0EvX9bHUn9O7iLF5bkeJPpFgwWfptVBDeA+Duaa8B8ZKc6l
         uZ3WvNuTQ5sOcFSSaXC8sZFTyLmPPsXwt+FEnBw8SRAz9BjN9YPretBOkCS4H5af8PP6
         U+QUURxf/bc720D2Ka4DZ4yeYvmpIk4Vko7n0plwnmo/4bqCyW8W9Nz4Y7EPOkFvLJcX
         B3wA==
X-Gm-Message-State: AOJu0YyiZszv/MgVzBb+i8dY0NLIxmyvqHGYf3eEOGcRZgdhcDHiyKYp
        ZJAGR+p8G47ntGmEd+OUeOwC4A==
X-Google-Smtp-Source: AGHT+IHMBi1+1x3Yt/bfrl9gyv/iDKPNW7+yCziyo+xCTBYWw/hNzj1p+tHsCVOZgnyBdWAdN+80eQ==
X-Received: by 2002:a05:6a20:78a2:b0:186:2389:a73e with SMTP id d34-20020a056a2078a200b001862389a73emr933242pzg.55.1700622387226;
        Tue, 21 Nov 2023 19:06:27 -0800 (PST)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id s2-20020aa78282000000b006a77343b0ccsm8614917pfm.89.2023.11.21.19.06.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Nov 2023 19:06:26 -0800 (PST)
From:   Samuel Holland <samuel.holland@sifive.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        linux-riscv@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        David Airlie <airlied@gmail.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Pan Xinhui <Xinhui.Pan@amd.com>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        Samuel Holland <samuel.holland@sifive.com>
Subject: [PATCH 1/3] riscv: Add support for kernel-mode FPU
Date:   Tue, 21 Nov 2023 19:05:13 -0800
Message-ID: <20231122030621.3759313-2-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231122030621.3759313-1-samuel.holland@sifive.com>
References: <20231122030621.3759313-1-samuel.holland@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is needed to support recent hardware in the amdgpu DRM driver. The
FPU code in that driver is not performance-critical, so only provide the
minimal support.

Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

 arch/riscv/include/asm/switch_to.h | 14 ++++++++++++++
 arch/riscv/kernel/process.c        |  3 +++
 2 files changed, 17 insertions(+)

diff --git a/arch/riscv/include/asm/switch_to.h b/arch/riscv/include/asm/switch_to.h
index f90d8e42f3c7..4b15f1292fc4 100644
--- a/arch/riscv/include/asm/switch_to.h
+++ b/arch/riscv/include/asm/switch_to.h
@@ -63,6 +63,20 @@ static __always_inline bool has_fpu(void)
 	return riscv_has_extension_likely(RISCV_ISA_EXT_f) ||
 		riscv_has_extension_likely(RISCV_ISA_EXT_d);
 }
+
+static inline void kernel_fpu_begin(void)
+{
+	preempt_disable();
+	fstate_save(current, task_pt_regs(current));
+	csr_set(CSR_SSTATUS, SR_FS);
+}
+
+static inline void kernel_fpu_end(void)
+{
+	csr_clear(CSR_SSTATUS, SR_FS);
+	fstate_restore(current, task_pt_regs(current));
+	preempt_enable();
+}
 #else
 static __always_inline bool has_fpu(void) { return false; }
 #define fstate_save(task, regs) do { } while (0)
diff --git a/arch/riscv/kernel/process.c b/arch/riscv/kernel/process.c
index 4f21d970a129..6a18bc709d1c 100644
--- a/arch/riscv/kernel/process.c
+++ b/arch/riscv/kernel/process.c
@@ -225,3 +225,6 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
 	p->thread.sp = (unsigned long)childregs; /* kernel sp */
 	return 0;
 }
+
+EXPORT_SYMBOL_GPL(__fstate_save);
+EXPORT_SYMBOL_GPL(__fstate_restore);
-- 
2.42.0

