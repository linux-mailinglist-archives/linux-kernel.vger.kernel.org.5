Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E24D67D8660
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 18:01:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345543AbjJZQBm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 12:01:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345510AbjJZQBc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 12:01:32 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B7BD1B5
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 09:01:30 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-5a8628e54d4so9760157b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 09:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698336089; x=1698940889; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YqzolOp4klsZhxy+kaJN9ua5Z74gn7QT8Zy5CMJl/9s=;
        b=MRk7DpXmZtyr4jc5oJnfhUSoRLt8ev+5bU8OdegWIpgAI6CG5oNr+BTqY2NEUeLeff
         zmLt2+YCVzmu2iuUGUGjeZk8DnQNzu3gpxpZMcO6OcBUzmJNVLtEt7k0whyWReWppuHM
         7QMS0zbCJAANzKuzKiW+zCigN7sEcM3rzXVjkgPgYUqRtkBsEm6ZYI71v7HpO5qPk33n
         aDnshcntezXMvUyEwNu26wIpj7Uiq8bdHKLLM9FQ/vw5d7vQohAmsot/52NppDz7v1HE
         jCFtcOjHtpskwQe/Sx6zzxNdTG/KXFASMWl9huTj/3B6zPaO25m38SwdDkpgjY3w28eQ
         UieA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698336089; x=1698940889;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YqzolOp4klsZhxy+kaJN9ua5Z74gn7QT8Zy5CMJl/9s=;
        b=cS3WJos7bcem+SegvKU0dm9xzjkJIT3q+4fShHWyM7BeaZkmwDhfcK1pZelIX3MTLE
         cZNephvSbxtP7X3OQRTdIQxpYe866pbjUTXN92jpxi6Iygn7urEQ4zzL4Iz2D7lPQQtE
         JwunnvU/0md0aw6KtqZtproiqUaTDb7LxpYUc0LnKW3EQn12+YKFg1VqSPa1OolEJQ25
         AUnx06ZNX/RAIO8Tu0QNwcKStW7/7F9FFH+HihV5AGcXBJpDThdSvUT5bhfEtu/6eP4C
         dFDXMo2Vp7ciwD46ED5PRUQ1DspiJ2ESO4oqGKBTafynpH1Yw2NjMMTd3NlV+9ltAchU
         Hqxg==
X-Gm-Message-State: AOJu0YxgCu3t6wCL+8ylmzj3hgBWv5YLbfhPPa1RXsLehmB69rgqwkq2
        YDluAcjw9FvtlxodjLdKS85Vr7MNqQ==
X-Google-Smtp-Source: AGHT+IFZOdjzXQnSeStkRLfPo1D+KeSluiX/djppRMVDEz7aDCdvO/CnqxSLmq8fW+xMt7r/6DdfTQ==
X-Received: by 2002:a81:ac02:0:b0:5af:5651:3d31 with SMTP id k2-20020a81ac02000000b005af56513d31mr414114ywh.7.1698336089005;
        Thu, 26 Oct 2023 09:01:29 -0700 (PDT)
Received: from citadel.lan ([2600:6c4a:4d3f:6d5c::1019])
        by smtp.gmail.com with ESMTPSA id a71-20020a0dd84a000000b005a20ab8a184sm6130129ywe.31.2023.10.26.09.01.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 09:01:28 -0700 (PDT)
From:   Brian Gerst <brgerst@gmail.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Uros Bizjak <ubizjak@gmail.com>,
        Brian Gerst <brgerst@gmail.com>
Subject: [PATCH v2 04/11] x86/pvh: Use fixed_percpu_data for early boot GSBASE
Date:   Thu, 26 Oct 2023 12:00:53 -0400
Message-ID: <20231026160100.195099-5-brgerst@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231026160100.195099-1-brgerst@gmail.com>
References: <20231026160100.195099-1-brgerst@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of having a private area for the stack canary, use
fixed_percpu_data for GSBASE like the native kernel.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
---
 arch/x86/platform/pvh/head.S | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/x86/platform/pvh/head.S b/arch/x86/platform/pvh/head.S
index c4365a05ab83..be8d973c0528 100644
--- a/arch/x86/platform/pvh/head.S
+++ b/arch/x86/platform/pvh/head.S
@@ -96,8 +96,9 @@ SYM_CODE_START_LOCAL(pvh_start_xen)
 1:
 	/* Set base address in stack canary descriptor. */
 	mov $MSR_GS_BASE,%ecx
-	mov $_pa(canary), %eax
-	xor %edx, %edx
+	lea INIT_PER_CPU_VAR(fixed_percpu_data)(%rip), %rdx
+	mov %edx, %eax
+	shr $32, %rdx
 	wrmsr
 
 	call xen_prepare_pvh
@@ -156,8 +157,6 @@ SYM_DATA_START_LOCAL(gdt_start)
 SYM_DATA_END_LABEL(gdt_start, SYM_L_LOCAL, gdt_end)
 
 	.balign 16
-SYM_DATA_LOCAL(canary, .fill 48, 1, 0)
-
 SYM_DATA_START_LOCAL(early_stack)
 	.fill BOOT_STACK_SIZE, 1, 0
 SYM_DATA_END_LABEL(early_stack, SYM_L_LOCAL, early_stack_end)
-- 
2.41.0

