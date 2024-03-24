Return-Path: <linux-kernel+bounces-112709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 94AFB887D36
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 15:30:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52E862816F5
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 14:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A616418050;
	Sun, 24 Mar 2024 14:30:20 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D28DE17BA5
	for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2024 14:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711290620; cv=none; b=X/rCgCwFVZ2delA/uqygi0oIsHXHciDIKhCSoDFmFF9TzwaO8015TImcDTRjwfE52Ae/KShvezc1uH9xUj87+TVq2nXYhv3qI+15g9g9Cjd2bC0nzL3vX7pDpRSeXz8A1Bs01Uibo4vGtegLg25jK/vUsbEJnkWoL+6uiKcZ+t0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711290620; c=relaxed/simple;
	bh=hOoOy2R15CLs9Wr+m+ubF/n6OS5oyuOShoBNjrq0iEA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=IUU0bs/r3VToXd2M33QcNb6p+cECvLMLcq2ZaiUHou0PmPqQ4SU0MN77nIVo+LSFE+aCNMXtZyEYpTpDpMrtwZBOkOb6eWZ93xGQ3qaJNUZEhBg/NjsTz8djNHVklrhjGbR+3/MUCqsA/dA7kv4zDwdJW4Z27hj46UC5wGHq0LI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3684e7a4770so36622665ab.0
        for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2024 07:30:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711290618; x=1711895418;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zPPSDlx7hKqH2sZcGMIDJSdB0ZptCI68pWaW9sID1zc=;
        b=CIDowLKDtYW4nLZ/+3BJ0vwPK/Iu5KlsOIxrvJtZXHphTjpEeHPwWKCVXAhzHYYOXR
         +l9dzfjgmyJbfGwqtSfGtUu83KEvx7kKU8+KJpHN0P7VZ4XIxOkT561IZ0yrM8E7YaiF
         u48q36d8Gw51opwDA4tRQBMcjknPk4RkV6DJSmqtQnqouYjyvNicuEhWd+U3UQOknXpE
         3NoOo/5a9Yc2jCH/XHET4mEUlDSoPegeLXeX10FXqgViWMQRcv2i4E9XqwL55hJ8b76g
         Sl4QCFPQkwWn+wuK87/bqlSV7+Ftu4P5WULPTy9RYvMYM39FGMt9dJ8K2SG4ggv6Lgta
         XCqQ==
X-Gm-Message-State: AOJu0Yw6VfPvcT2kOxCdGZNRE2o8WWTOUtow6ZtBWlLFjKcO95akc0/D
	QBmJ819czUiDUqB3mn8T2OsHLKsnhlAke0WS+3vq6q1qUEHuVXvIpfs0taYovVBywbha576EneT
	xLmY5oslPucZkDj6lkru8/5oTpMPL3256/v3xAuzkFyXCwGXmSU560BACvg==
X-Google-Smtp-Source: AGHT+IGuDD0K8XsE7rJCDmAcBzaKmGPYfUTZHwLSbVweEHbMkcT7g8oAf6YVfXQGG+TqGn6anFPeIlVApCvgxh6m1YHkP3f++GxT
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:20ce:b0:368:8cf9:9ab5 with SMTP id
 14-20020a056e0220ce00b003688cf99ab5mr32271ilq.2.1711290617932; Sun, 24 Mar
 2024 07:30:17 -0700 (PDT)
Date: Sun, 24 Mar 2024 07:30:17 -0700
In-Reply-To: <0000000000000f823606139faa5d@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000063c12f061468e5ab@google.com>
Subject: Re: [syzbot] [PATCH] fix array-index-out-of-bounds in bpf_prog_select_runtime
From: syzbot <syzbot+d2a2c639d03ac200a4f1@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: [PATCH] fix array-index-out-of-bounds in bpf_prog_select_runtime
Author: cam.alvarez.i@gmail.com

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

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


