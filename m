Return-Path: <linux-kernel+bounces-112487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8AC8887A72
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 22:23:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A1962820D8
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 21:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BBA758AA4;
	Sat, 23 Mar 2024 21:22:54 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 450FB22625
	for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2024 21:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711228973; cv=none; b=cbNi9RUwUb782QK2fVA8Elw2gAOtEzu/TpUKuj1PIdFYU+VICmkvgNkNXmpa3HYDm21aD2ppu7r8Bw2/Qb92ux4+GiM2xhXtZMHI71Z8o4Fqx01P0C/0+jaQHXxOdHjsK3Ku7u2l2U2ggc5TM3UoeMb+DT6Hj66CSplqSYSGBHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711228973; c=relaxed/simple;
	bh=Was92oTx9Qdp+cCz+e7LV2mkVbHUkFYFsvLVJIDfAzk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=H5I0qzDcgUihtsJrsSxeod1vZ4GoHu2UVFFbMnYILsC9ZiVtQqHwPQk4kB9RZELV2ltGivInZ8aU/Zbdq3ZYdlWYkVK3isUru6IkX3cGNkO2rxw50xVJz/ERHHaWi1pVnF3hJt6he5daWnwiBxc/vbXOTy3d6NfDi82Ge0MPg2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7c7e21711d0so235909239f.3
        for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2024 14:22:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711228971; x=1711833771;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ukcmNO5QdCCXmLEZP1Y8y2188YS0sz6T0pRINK4qEio=;
        b=LeELv6KC/8brZKVF3Ncuw/fJNZdkWaSgOK4o084U5ZFA5C8lrNID7VAZBA/hGF0Aal
         EjsRyukiy7UdDLVj3XN4VgG028s6TzuzKsEpbFs5mGwIXdYt7yCYy4xqk2lnbdlc6VIW
         MgH2I9QCneFmKEAYvEET+suVTTX286F4pE/l+H47930uyBrmqSBo0/ITkbcGZemXEhzo
         nbqZmDk/SU1+OnbRzZPd18TH4FFy+84KBc5kdG8jJy6N0ovY//AYo0RL39WkPaeHX2ut
         AjWGxDQ1uj2gBCPgtTxnKN9NnQcrS1EVWfjDN5QE3KpZNu8YhWqYyhROl3SykcNuFN8e
         l7hw==
X-Gm-Message-State: AOJu0YyIGRI80wFld2LkxysHcSZ+TJAqOpn58T8nevpmIhB7w/UZXWwt
	G4m5Cg5qWtQLY5Vb4nzB7B/X2IC5OssZj6cBPAC5OL7nhfAmKgZueCc47Bth8M4Pyks98e2WdG5
	i8NRrBK8wzb5jEkSjZLIuwgEv7VsRsBMaDo/1rJ/cKnokCP+Cc4xRsSVUVg==
X-Google-Smtp-Source: AGHT+IFCH+MKcvUt48LwmBVq7KznRbgNFVpBpNBWfwIk7Dq/bOTWjZUQV+iVnnE6Pc6h7X35aWqH92KaTHdidzsTueu6RbKen7mT
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2b0f:b0:47c:540:4eee with SMTP id
 fm15-20020a0566382b0f00b0047c05404eeemr199519jab.1.1711228971430; Sat, 23 Mar
 2024 14:22:51 -0700 (PDT)
Date: Sat, 23 Mar 2024 14:22:51 -0700
In-Reply-To: <0000000000000f823606139faa5d@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f8ca7706145a8a38@google.com>
Subject: Re: [syzbot] [PATCH] fix array-index-out-of-bounds in bpf_prog_select_runtime
From: syzbot <syzbot+d2a2c639d03ac200a4f1@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: [PATCH] fix array-index-out-of-bounds in bpf_prog_select_runtime
Author: cam.alvarez.i@gmail.com

#syz test

BPF documentation specifies that the maximum stack depth for a BPF
program is 512 bytes. This is not enforced when selecting a bpf
interpreter, thus casuing an index out of bounds error when trying to
obtain an interpreter with a bigger stack size.

This patch enforces the stack size to be not bigger than
512.

Signed-off-by: Camila Alvarez <cam.alvarez.i@gmail.com>
---
 kernel/bpf/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 696bc55de8e8..8167b3a721e9 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -2196,7 +2196,7 @@ static u64 ___bpf_prog_run(u64 *regs, const struct bpf_insn *insn)
 		BUG_ON(1);
 		return 0;
 }
-
+#define BPF_MAX_STACK_SIZE 512
 #define PROG_NAME(stack_size) __bpf_prog_run##stack_size
 #define DEFINE_BPF_PROG_RUN(stack_size) \
 static unsigned int PROG_NAME(stack_size)(const void *ctx, const struct bpf_insn *insn) \
@@ -2345,7 +2345,7 @@ static void bpf_prog_select_func(struct bpf_prog *fp)
 {
 #ifndef CONFIG_BPF_JIT_ALWAYS_ON
 	u32 stack_depth = max_t(u32, fp->aux->stack_depth, 1);
-
+	stack_depth = min_t(u32, stack_depth, BPF_MAX_STACK_SIZE);
 	fp->bpf_func = interpreters[(round_up(stack_depth, 32) / 32) - 1];
 #else
 	fp->bpf_func = __bpf_prog_ret0_warn;
-- 
2.34.1


