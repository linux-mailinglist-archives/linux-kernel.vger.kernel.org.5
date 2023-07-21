Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E47B75CD71
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 18:11:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbjGUQLM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 12:11:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232045AbjGUQKx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 12:10:53 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B721A3586
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 09:10:48 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id d75a77b69052e-403b6b7c0f7so17586451cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 09:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689955847; x=1690560647;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tfQVUJeG82Bn7jUnxAG1fPc5fzriqyrGkxLsws2Rhtc=;
        b=FlKm/uhne4Q4zTBXZJj8mnli3+gsAwYvEmHxdunziS1nhM8Jnq8CdAZ0Au0Nzz/yyn
         /YHyemgMxFP6flT3BtZFWRTTY8Eex1vmcgHxQKDK0GaR/rj2ZApZqXL8Nb47PnGjwwQ+
         bFT/4aGMrzFY/owB+fbsGAGNv0U7XutlcKB5l/4xCfIi76irlQ06ep07BSr19VJmVUwo
         94RMHoBS95r3F/osFB8YsBoxMuI2SVil/EWQ+EkSmBGY8CkfXU0Ihv3cXwv826o8QNce
         omi4F2eopr0YfPZe/jH5a9WyKTxkUw3rfsLFdKE+YuYuT74j8bmohPGeqnO9tDnAdNGZ
         T0ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689955847; x=1690560647;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tfQVUJeG82Bn7jUnxAG1fPc5fzriqyrGkxLsws2Rhtc=;
        b=TCBYZFS6routxJUm39EWxWqoU34tmOnVBPEqnVgHA2WksL4a436L7AwvBmtjUOdS3c
         zUqenU94DRw22oFWcBmXJ8s0R0RtNqwTr0PyWYR3FKOHcN0Z/NP2iO9PsQ+3Tz4RDZoo
         jQcvth9HyakupBWScnj0IJ/yBn7PXuRV9MIKONBfaUgB7/ICyrkfJGzksmM36npRhkkY
         lEjJNDCWNdnQPdso1NWOIuBvuLk+OqlqGtAOQn5AEsQR1QNn+qfzIW2BdfbxcmvLrJzP
         F4MXh0UGfDnWyYRyMDbpHxqCk1ztFpZYn5kprlCmt/IHIcWX8KKvrx8JqYZ31emn8aAv
         TpkQ==
X-Gm-Message-State: ABy/qLZaNrUhy2Co+CDkVn0lH/VKLbCLGumq3k+lq/dqCEcEqZgXd4bE
        mO9m+s0WLX8QQYdnDjoqUjM8f5uDgA==
X-Google-Smtp-Source: APBJJlG7RCBET81XQQpwgB5hMP0SCzt9vuHR+TpDGjyb9suYeQprBmbYBMbEAg+WDVqVb3dhPW3Cug==
X-Received: by 2002:a05:622a:190a:b0:403:6fe6:3160 with SMTP id w10-20020a05622a190a00b004036fe63160mr619325qtc.61.1689955847108;
        Fri, 21 Jul 2023 09:10:47 -0700 (PDT)
Received: from citadel.. (047-026-243-217.res.spectrum.com. [47.26.243.217])
        by smtp.gmail.com with ESMTPSA id c16-20020ac87d90000000b004054fbf9273sm311286qtd.80.2023.07.21.09.10.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 09:10:46 -0700 (PDT)
From:   Brian Gerst <brgerst@gmail.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        =?UTF-8?q?Mika=20Penttil=C3=A4?= <mpenttil@redhat.com>,
        Brian Gerst <brgerst@gmail.com>
Subject: [PATCH v2 5/6] x86/entry/32: Remove SEP test for SYSEXIT
Date:   Fri, 21 Jul 2023 12:10:16 -0400
Message-ID: <20230721161018.50214-6-brgerst@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721161018.50214-1-brgerst@gmail.com>
References: <20230721161018.50214-1-brgerst@gmail.com>
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

SEP must be already be present in order for do_fast_syscall_32() to be
called on native 32-bit, so checking it again is unnecessary.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
---
 arch/x86/entry/common.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
index 5b3594457af3..4d7d6d25dda9 100644
--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -265,8 +265,7 @@ __visible noinstr bool do_fast_syscall_32(struct pt_regs *regs)
 	 * We don't allow syscalls at all from VM86 mode, but we still
 	 * need to check VM, because we might be returning from sys_vm86.
 	 */
-	return static_cpu_has(X86_FEATURE_SEP) &&
-		regs->cs == __USER_CS && regs->ss == __USER_DS &&
+	return regs->cs == __USER_CS && regs->ss == __USER_DS &&
 		regs->ip == landing_pad &&
 		(regs->flags & (X86_EFLAGS_RF | X86_EFLAGS_TF | X86_EFLAGS_VM)) == 0;
 #endif
-- 
2.41.0

