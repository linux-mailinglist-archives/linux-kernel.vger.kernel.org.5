Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECA637C607E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 00:44:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376577AbjJKWoI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 18:44:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376550AbjJKWn7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 18:43:59 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D73E7A9
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 15:43:57 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id 6a1803df08f44-66d0760cd20so2713416d6.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 15:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697064236; x=1697669036; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HZGveJLgwifDwKHvj2/VHQXDCqoTe78KUSxE+lNTdAg=;
        b=awxtAks/9WVVH+7UeadSsBtLZKhKfCMVMsAsRl3L+7hg0BEKvqf0e0lcM1RPdJvM5Y
         JR316hc6OGz15ouCEDPgwA7i5lq8MkMKBdv5v94NkEpMQSvzgU9eu6AH2WM/HFzFerr3
         5KHXna0S1grvnPNdQZ1BLpiEor3mjjbxiGKP4HrCQFCoFn4Am55c/CbT9kjpMlZpRrM2
         Xhanru37wXgbAGIZOqbLlBffUsQR8xhcEEj/2EQZvRKpRvHv4c0N39UJMTMiFvXHl06K
         lJ5K1ojAAWG/f2fMU0/OjSrcsv4H7NmvrDvpknm9tOXT4ICADSgqr/5LUpt+1lP5x8RV
         cgKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697064236; x=1697669036;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HZGveJLgwifDwKHvj2/VHQXDCqoTe78KUSxE+lNTdAg=;
        b=T3ccQmZKmzQxvo7DA/iABj37ITHFYRjf2zp5OSwpFy3ZVzPUEi9rphHKRrvT8Je7UQ
         +5f/AwGIk0x5+7NsBP6sO+QGrzcMUcfAHg+a+MwNFKgSUZS+EFbGqHveXYVi89Ot4pO2
         opq9xXQPb7aJmNYA4LoNzIAh1l6bS1QdNla0dfuT6R8MUlkeMtklqKftI8sZM3Er/yzY
         psAU5GXaorP+c8wAfv/RQTM2i+MgeA6FQ/qJBrhOmn3Rxul972+uOsTBypE5YkcRvu6N
         v4pPTHFvmt4gou+IjFse8+U/PLDfYfiz4bYRGTW6enLN1eUoOq7r3xtn2zPccUjHySlG
         oUag==
X-Gm-Message-State: AOJu0Yzlj0TvpJ8PcodkIB6ptoddSZiVGo4PTINGNiNsMhvHqd0EbkMp
        MTk70oaGAFPOmEhJVqi8EzdJRJQuIA==
X-Google-Smtp-Source: AGHT+IHai+Y+y8sZx8W8FhlOxbeoOR1TWhTqWxRutap+GxQJCstB9QWtljWPF63mMXsnsNwCmf3WwA==
X-Received: by 2002:a05:6214:21ea:b0:66d:1103:3286 with SMTP id p10-20020a05621421ea00b0066d11033286mr2709612qvj.12.1697064236600;
        Wed, 11 Oct 2023 15:43:56 -0700 (PDT)
Received: from citadel.lan ([2600:6c4a:4d3f:6d5c::1019])
        by smtp.gmail.com with ESMTPSA id o10-20020a0cf4ca000000b0065b129ec0e8sm6132871qvm.57.2023.10.11.15.43.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 15:43:56 -0700 (PDT)
From:   Brian Gerst <brgerst@gmail.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Brian Gerst <brgerst@gmail.com>
Subject: [PATCH v3 2/3] x86/entry/64: Use TASK_SIZE_MAX for canonical RIP test
Date:   Wed, 11 Oct 2023 18:43:50 -0400
Message-ID: <20231011224351.130935-3-brgerst@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231011224351.130935-1-brgerst@gmail.com>
References: <20231011224351.130935-1-brgerst@gmail.com>
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

Using shifts to determine if an address is canonical is difficult for
the compiler to optimize when the virtual address width is variable
(LA57 feature) without using inline assembly.  Instead, compare RIP
against TASK_SIZE_MAX.  The only user executable address outside of that
range is the deprecated vsyscall page, which can fall back to using IRET.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
---
 arch/x86/entry/common.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
index 207149a0a9b3..e3d6f255379f 100644
--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -110,10 +110,10 @@ __visible noinstr bool do_syscall_64(struct pt_regs *regs, int nr)
 	 * in kernel space.  This essentially lets the user take over
 	 * the kernel, since userspace controls RSP.
 	 *
-	 * Change top bits to match most significant bit (47th or 56th bit
-	 * depending on paging mode) in the address.
+	 * TASK_SIZE_MAX covers all user-accessible addresses other than
+	 * the deprecated vsyscall page.
 	 */
-	if (unlikely(!__is_canonical_address(regs->ip, __VIRTUAL_MASK_SHIFT + 1)))
+	if (unlikely(regs->ip >= TASK_SIZE_MAX))
 		return false;
 
 	/*
-- 
2.41.0

