Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B564A7B28AA
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 01:12:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbjI1XM6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 19:12:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjI1XM4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 19:12:56 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D76519D;
        Thu, 28 Sep 2023 16:12:53 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-573e67cc6eeso9204294a12.2;
        Thu, 28 Sep 2023 16:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695942772; x=1696547572; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=abvznY10/Fe6b09wbHg5BDrZRwmwtAQnZLYNnlZNZAM=;
        b=R5J0cEOMQ7to49YSKHdMS0CR0gxtfKHdCB7U5FN38Wbp+yOSQ8+A1NX5fqZaLsZxHg
         VO6Wbm79XxN4MvqKN0LtUae4znGfzjL7Jteyshx2kHW6ej/e/Vcx443eD3VOvWgjkXqj
         gfrcj+haqL9tcck9nRoJ4OrN3y54mMuEHxiFGbAhjGQdUDbGCKhOIoivfkAmP09iMjk4
         dNsAqwGbju3fAzTbR6xGkzlSXpw/0GK+Oh44Ac5tvWLMGc1eNEfEQ0Vw7Dg7M//Qg75q
         3dGXi9o2zHn6WI+mmahbxZJBl5bYw8JIVDc3pXlUzYw8KYO64yx9Zj+U1y/JrDQ48L5m
         LtOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695942772; x=1696547572;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=abvznY10/Fe6b09wbHg5BDrZRwmwtAQnZLYNnlZNZAM=;
        b=QlodafoQeXrdRhmG4ajfJf7IGCGU5GWAO910NMbIEfB3ikML/s0hGDEV8x1PmQTR1k
         OKLIczquxDsOxgHwIu3OjDlIfHPq99o8NWMg097euGrFAfp/qXtQPKJV6nxjglUzsLUw
         YcRNoY0L/0Na4AeZPNN5JS+1dFIq2X+/6oamkx+UERYEW+CJcs876TRbZAPmiT034CC7
         a31ClyaNwPj619A8YXzMuTOE2cfae//8E4f3U3znMq7V/r18UkcEd6+PxIMcxbZqlBkU
         W9yw6F4vd7hVzwB6JIEwCZRDFuBdMUt+oNCNVlz8pHTlRbFceOqmLxRcOY/oJLBXc6Lh
         /UaQ==
X-Gm-Message-State: AOJu0YxIrEW1xRCbyeK6Y5ClucFMJTS7qoQcXC2B+uaJ9nL29BtXSyV5
        8zwFq8raUnaASaDNddR2RRo=
X-Google-Smtp-Source: AGHT+IFO5cRPZ8csZWghvSTk6pM7bsKvFnuuxXZVJkz4vWw+8JhNSdOtsLsuaND0x6X21eFtrGTaGg==
X-Received: by 2002:a05:6a21:1f1c:b0:14c:ca25:3b53 with SMTP id ry28-20020a056a211f1c00b0014cca253b53mr2198937pzb.27.1695942772515;
        Thu, 28 Sep 2023 16:12:52 -0700 (PDT)
Received: from pek-lxu-l1.wrs.com ([111.198.228.56])
        by smtp.gmail.com with ESMTPSA id cp14-20020a17090afb8e00b0026f39c90111sm83811pjb.20.2023.09.28.16.12.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 16:12:52 -0700 (PDT)
From:   Edward AD <twuufnxlz@gmail.com>
To:     alex@ghiti.fr
Cc:     alexghiti@rivosinc.com, aou@eecs.berkeley.edu, conor@kernel.org,
        gregkh@linuxfoundation.org, guoren@kernel.org,
        jirislaby@kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-serial@vger.kernel.org,
        liushixin2@huawei.com, palmer@dabbelt.com,
        paul.walmsley@sifive.com,
        syzbot+8d2757d62d403b2d9275@syzkaller.appspotmail.com,
        syzkaller-bugs@googlegroups.com, twuufnxlz@gmail.com
Subject: [PATCH] riscv: fix out of bounds in walk_stackframe
Date:   Fri, 29 Sep 2023 07:12:40 +0800
Message-ID: <20230928231239.2144579-2-twuufnxlz@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <f74665d1-4d28-01a2-5694-b06fde202d39@ghiti.fr>
References: <f74665d1-4d28-01a2-5694-b06fde202d39@ghiti.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add vmalloc and kernel addresses check to prevent invalid access.

Closes: https://lore.kernel.org/all/20230926105949.1025995-2-twuufnxlz@gmail.com/
Fixes: 5d8544e2d007 ("RISC-V: Generic library routines and assembly")
Reported-and-test-by: syzbot+8d2757d62d403b2d9275@syzkaller.appspotmail.com
Link: https://lore.kernel.org/all/0000000000000170df0605ccf91a@google.com/T/
Signed-off-by: Edward AD <twuufnxlz@gmail.com>
---
 arch/riscv/kernel/stacktrace.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/riscv/kernel/stacktrace.c b/arch/riscv/kernel/stacktrace.c
index 64a9c093aef9..031a4a35c1d0 100644
--- a/arch/riscv/kernel/stacktrace.c
+++ b/arch/riscv/kernel/stacktrace.c
@@ -54,6 +54,9 @@ void notrace walk_stackframe(struct task_struct *task, struct pt_regs *regs,
 			break;
 		/* Unwind stack frame */
 		frame = (struct stackframe *)fp - 1;
+		if ((is_vmalloc_addr(frame) && !pfn_valid(page_to_pfn(vmalloc_to_page(frame)))) || 
+		     !virt_addr_valid(frame))
+			break;
 		sp = fp;
 		if (regs && (regs->epc == pc) && (frame->fp & 0x7)) {
 			fp = frame->ra;
-- 
2.25.1

