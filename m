Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4D627D8661
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 18:01:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345549AbjJZQBq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 12:01:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345509AbjJZQBd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 12:01:33 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F3161B2
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 09:01:29 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-5ae143e08b1so8101977b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 09:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698336088; x=1698940888; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lsKN0vAWTPkRoeR+0eW+M/Vw4EKK+fkuLodskFQx/7g=;
        b=CrlvYmeciFZwZGlBVcmedkuCpuq2R5W736RvulBNXvei7KiUsb8Ui1DPebXWX+6oBA
         MpoLHSuAZ+UN0QDa0JXLqIEzOlCv+HQrylOYuuWqJLPJ9gTrFusR1bDEF6aGfTKnQ4is
         GNmu3cDG70MVnxL3ePXKGoF4a015jaXqK74jbvFvxMI0IA010CMKHKj37rZHoT00CIV5
         asaB/K8ktaJWqMZY3wCMF4ub9COmZvULUsfLyGSmbNkIkBeTTr6hkT1rvBS5EgnuAzrI
         aovyyn07bYO/TL6UvifJ2k4Wni9DeH5+hjivtZzdvTG4wEIbD2ks0PT4ZWLqtiOSMIMb
         Jvag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698336088; x=1698940888;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lsKN0vAWTPkRoeR+0eW+M/Vw4EKK+fkuLodskFQx/7g=;
        b=gJalBVHiTZAOETKgBJz8pXJ3pD/6N1IHVdrhS7r4SP6lf/KMiABpvyUHRFPkUqZrUU
         2KfmVgLGQnLEGQ+U5UE4jYplEs1lrOLZSha+1XO0RTvrHPlk03YpyJfSb8021WNbRpzp
         vhmDKM4oXPU6WzTBlWRtUse+dD//SNOtYzqO+PjhXD484zX7FbCLIJYbcJ0KIWswUiYr
         +jFfDOXgegD07LXoz/chH/PHAQNAoGrNE7L/RpzfrlVQI0ySPDumxT02J15e/Mop8bhO
         G28abG/yout8KVe5MQBPjjC8sTjeKps9VC40L8z/xxjrCeTce0jJCsQsUCXckxaW299d
         O5Ww==
X-Gm-Message-State: AOJu0YwiQ91AoFJOze6yxQkDIt1mMX/VSyuU/Xo3owCjrI3HEntpUexF
        PHEJYqaRstDHPnvCz1B16+zJK17Zhw==
X-Google-Smtp-Source: AGHT+IGN5yveNFav006OVTC2yBL+xthTYiF5MFSb88kMab5OKbAjbb1KVVGxcVKrUR6i79RM7uPUDg==
X-Received: by 2002:a05:690c:fc3:b0:5a7:cc02:68b0 with SMTP id dg3-20020a05690c0fc300b005a7cc0268b0mr23755342ywb.23.1698336087890;
        Thu, 26 Oct 2023 09:01:27 -0700 (PDT)
Received: from citadel.lan ([2600:6c4a:4d3f:6d5c::1019])
        by smtp.gmail.com with ESMTPSA id a71-20020a0dd84a000000b005a20ab8a184sm6130129ywe.31.2023.10.26.09.01.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 09:01:27 -0700 (PDT)
From:   Brian Gerst <brgerst@gmail.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Uros Bizjak <ubizjak@gmail.com>,
        Brian Gerst <brgerst@gmail.com>
Subject: [PATCH v2 03/11] x86/boot: Disable stack protector for early boot code
Date:   Thu, 26 Oct 2023 12:00:52 -0400
Message-ID: <20231026160100.195099-4-brgerst@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231026160100.195099-1-brgerst@gmail.com>
References: <20231026160100.195099-1-brgerst@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 64-bit, this will prevent crashes when the canary access is changed
from %gs:40 to %gs:__stack_chk_guard(%rip).  RIP-relative addresses from
the identity-mapped early boot code will target the wrong address with
zero-based percpu.  KASLR could then shift that address to an unmapped
page causing a crash on boot.

This early boot code runs well before userspace is active and does not
need stack protector enabled.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
---
 arch/x86/kernel/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index 0000325ab98f..aff619054e17 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -39,6 +39,8 @@ KMSAN_SANITIZE_nmi.o					:= n
 KCOV_INSTRUMENT_head$(BITS).o				:= n
 KCOV_INSTRUMENT_sev.o					:= n
 
+CFLAGS_head32.o := -fno-stack-protector
+CFLAGS_head64.o := -fno-stack-protector
 CFLAGS_irq.o := -I $(srctree)/$(src)/../include/asm/trace
 
 obj-y			+= head_$(BITS).o
-- 
2.41.0

