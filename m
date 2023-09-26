Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC6B27AEAF8
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 13:00:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234497AbjIZLAI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 07:00:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbjIZLAG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 07:00:06 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4846EE5;
        Tue, 26 Sep 2023 03:59:58 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-6910ea9cca1so6358647b3a.1;
        Tue, 26 Sep 2023 03:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695725998; x=1696330798; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AC9zbFzLXKPuYOJNpw2kNkoiGNa6WmVnEzplbAtdNls=;
        b=BE6R+SjFYT3gY/GURiK/jTTE1acczdwE9k10jVpMUnyDLEx3CS5SH325OKuW9WNVlD
         WNhxkJVF7ya4Hwzx48dkF2RFU9YRty21QQAxokg+NTPC54b7uz9F1Iw4bY5HS2igr+Xw
         XBjos2G8soQoEJF/WYQINTYOIBSonhBOVLc/w81SK6mmn1pM9V8DWOYzZgjL4xs1GNHf
         VhywI4wjZYhAdxlalH/kRoLA8IvO+G8yuhGScW3qDZzv4YLIVfzV26el2ejoLEHypQUL
         LyzZ7KtkiVVbXaQKs+xj3jxoDzmBih0qopfhVx3xPbqpgXX4kjbhM+obYW2AQPjck/Oi
         n9DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695725998; x=1696330798;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AC9zbFzLXKPuYOJNpw2kNkoiGNa6WmVnEzplbAtdNls=;
        b=fhxEwtPuNxSaet2fhCUBwe0017Lj9eMDhoqpxRluPTpG7/LsiC7+WAaROm/8blj9SP
         WhayVYOK30pQxJU0bLV13iBVJltFLlP8bxwUpOvSbGQv7qj9hL5twK+FNOkg314SqwMw
         EJ+Gbfimi/CWdgX80EHcMOKTaWfciq62Q3XlN5jcg9d06nhOfZppAomQN7jwzbE4xvvz
         H4Ab3mrY8vMZO/l/LCDfMFgjuFW/t7eT0oQAirMCmD+mRj9BV/R8vds6yccHQ6cO3Bbw
         8PYsvYgmEQmbidILfi+Tli/GXTt/lUvQj1k2Y8Y0fJQbt9Q6ffmv/o8sZ93SMpRDcbes
         kj6w==
X-Gm-Message-State: AOJu0YyKXFVEpdyhJatOiavrS996q2OtJWKOXd3E9oPzOwOcK3mGgawT
        wIIVNMuDDprUe7sk5WJ4eYM=
X-Google-Smtp-Source: AGHT+IHWneCV+Mz6Gw+G3yuA8QPOEJ/reQtqZalQcjtOurzGyztL1UODGQuLeltZqdhisCVBOw6O5Q==
X-Received: by 2002:a05:6a00:4683:b0:692:cede:c902 with SMTP id de3-20020a056a00468300b00692cedec902mr4844980pfb.9.1695725997687;
        Tue, 26 Sep 2023 03:59:57 -0700 (PDT)
Received: from pek-lxu-l1.wrs.com ([111.198.228.56])
        by smtp.gmail.com with ESMTPSA id f9-20020a639c09000000b005781e026905sm9176996pge.56.2023.09.26.03.59.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Sep 2023 03:59:57 -0700 (PDT)
From:   Edward AD <twuufnxlz@gmail.com>
To:     syzbot+8d2757d62d403b2d9275@syzkaller.appspotmail.com
Cc:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: [PATCH] riscv: fix out of bounds in walk_stackframe
Date:   Tue, 26 Sep 2023 18:59:50 +0800
Message-ID: <20230926105949.1025995-2-twuufnxlz@gmail.com>
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

Reported-and-tested-by: syzbot+8d2757d62d403b2d9275@syzkaller.appspotmail.com
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

