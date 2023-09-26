Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8C007AEBAC
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 13:44:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233633AbjIZLn6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 07:43:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233303AbjIZLn5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 07:43:57 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C1E9CE;
        Tue, 26 Sep 2023 04:43:51 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id 98e67ed59e1d1-2776d882214so2359440a91.2;
        Tue, 26 Sep 2023 04:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695728630; x=1696333430; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dkwcmvcDx9Ry059cwK4qWkjs1uRcxEVpsz5bX/95ZV4=;
        b=THs0IF4I87Qxou6FCfqyXbpiyufhwQTq1Zvo2JzQQU7RTEiUfCd/3sJ3J+XkaHXmCp
         I7NyFBCIi77bXBFprLQWWyXnBLdhj5Z3m0bTNmj3eSWTsB4MVEgGKKw2wu1p6rGl4KAP
         WrTimqRBDsFxaPtvbphAQKFeAfR8QQIHBIpMKHMJ4lG0jx6PAyflO/JXbCv6pJOJQwNr
         w0lcVtJp6t45YLDKKI7udzxAnhgGqFzsgWi5w22cmt2fGuU5VXnW4NXAnYpHPxy4XKiK
         OSYLDUZjCCm5DfGKqxjwaP0B1CPHseGAGTgVIklJHV62NmO2Dc9K+QqwnbkX2tUVRbZG
         5gLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695728630; x=1696333430;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dkwcmvcDx9Ry059cwK4qWkjs1uRcxEVpsz5bX/95ZV4=;
        b=o5HIoMPYQ6ynGlK2NAUEPzj6hq/ikFZiNZg8H+xfOKOrwbesA/hDa7JpHIQT4gljgL
         0/em+akqQr2uaOSdQeXdHrARO32fL1tB81TJXLICc+AyuneZgKtlTq+v5fTPv4b7v+kj
         qaa5uVlpHXTGHXkVqlf3L80D87G+xnV9C5RKYrNs6VG0xWtTfqT5VjzZDUgK3kUi/rxB
         Hr9fgDdiQbmTmlZIufkO0/VcPJ/89QLWLwdQKbFnsgjIHM0L08axXqSZp8eXfOFukNqK
         iKjltWpuYRcdRszkFBLpCkvwig5C+emKtspRvINrKZXzLhM8pT1ElK2qkYrLBt55KTaM
         bkNQ==
X-Gm-Message-State: AOJu0YyCQAi1EFT9Kc7Xj8DNlLPYWxV4V6g6y/mr3zZfVg9V+YIwGcuj
        cqIxO7wELs4gBhysKGFWn24=
X-Google-Smtp-Source: AGHT+IGBetiia33KIgJTB+2g0zG108wbsJDTIr+rmVK8b2s3SIkW1+K9Jp1b0rKSdhJnYDjRtvVp3w==
X-Received: by 2002:a17:90a:ec08:b0:274:8e3b:27cd with SMTP id l8-20020a17090aec0800b002748e3b27cdmr6874049pjy.14.1695728630616;
        Tue, 26 Sep 2023 04:43:50 -0700 (PDT)
Received: from pek-lxu-l1.wrs.com ([111.198.228.56])
        by smtp.gmail.com with ESMTPSA id m6-20020a17090a414600b00274a9f8e82asm93692pjg.51.2023.09.26.04.43.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Sep 2023 04:43:50 -0700 (PDT)
From:   Edward AD <twuufnxlz@gmail.com>
To:     conor@kernel.org
Cc:     syzbot+8d2757d62d403b2d9275@syzkaller.appspotmail.com,
        gregkh@linuxfoundation.org, jirislaby@kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, guoren@kernel.org,
        alexghiti@rivosinc.com, liushixin2@huawei.com,
        linux-riscv@lists.infradead.org
Subject: [PATCH] riscv: fix out of bounds in walk_stackframe
Date:   Tue, 26 Sep 2023 19:43:44 +0800
Message-ID: <20230926114343.1061739-2-twuufnxlz@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <0000000000000170df0605ccf91a@google.com>
References: <0000000000000170df0605ccf91a@google.com>
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

Increase the check on the frame after assigning its value. This is to prevent 
frame access from crossing boundaries.

Closes: https://lore.kernel.org/all/20230926105949.1025995-2-twuufnxlz@gmail.com/
Fixes: 5d8544e2d007 ("RISC-V: Generic library routines and assembly")
Reported-and-tested-by: syzbot+8d2757d62d403b2d9275@syzkaller.appspotmail.com
Link: https://lore.kernel.org/all/0000000000000170df0605ccf91a@google.com/T/
Signed-off-by: Edward AD <twuufnxlz@gmail.com>
---
 arch/riscv/kernel/stacktrace.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/riscv/kernel/stacktrace.c b/arch/riscv/kernel/stacktrace.c
index 64a9c093aef9..53bd18672329 100644
--- a/arch/riscv/kernel/stacktrace.c
+++ b/arch/riscv/kernel/stacktrace.c
@@ -54,6 +54,8 @@ void notrace walk_stackframe(struct task_struct *task, struct pt_regs *regs,
 			break;
 		/* Unwind stack frame */
 		frame = (struct stackframe *)fp - 1;
+		if (!virt_addr_valid(frame))
+			break;
 		sp = fp;
 		if (regs && (regs->epc == pc) && (frame->fp & 0x7)) {
 			fp = frame->ra;
-- 
2.25.1

