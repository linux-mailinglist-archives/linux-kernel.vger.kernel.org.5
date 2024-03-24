Return-Path: <linux-kernel+bounces-114497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 58DFE888AE3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:33:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4753FB2AC76
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0690A180B69;
	Sun, 24 Mar 2024 23:47:39 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D60157A55
	for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2024 23:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321946; cv=none; b=JnvoHhVliGKazW0/Xsx8Ez2tcOERf/X7LdmLBhPQvDzNO/iiLj+ae+Gpco0GhVNBTWQxrL7TyDxbeScWpjaHkgUXrn/V4aIPtTKPxr2fDDuiGm+uwTEBrrkR/t3CGkwsPJndliR+0udExMZ3nPb70YJuqNsZtKjRHHw/U7zs//Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321946; c=relaxed/simple;
	bh=0WjLgWBQoroXCRkQb/KF76ttyuNQInEBm/vMs2T8VKs=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Mgn+stqnHWIgEudTRJmzFSgwIvpbCniqYXtnP781a/osugAg8gg2SARnN55GacrbjEIaIlw7ZnieAXerswONn+1p2gx4QU54L2zQmA+g1v9DLjBq1zELOQ/28qv0tktzuWUs0kNMgTAwTTsKMAKNpx6BeBvksagEbHDMo1R0D9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-366999e233aso35754855ab.0
        for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2024 16:12:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711321943; x=1711926743;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6vdJxKM8GH8kekxC4WoOuGNkwNYKb1BRCY7iBjPRJhs=;
        b=YYow5GmCN11d8OH8S13tzORQt55FzUXfQeg8ytCjRYQX9ypX+vrHykjI6RqDGGWQK6
         vHu1EasWntuRQozrVCvFAnORuQRw6BhLLer97UiXWqZBZDobfLES/bEA2IrkplFYpMvU
         +M+pZAMWXgXtf5wQhnZk33cevFgv3viQ79Gz5Uk7h+xQ3GX7qKqHvCLhmWzb1LyyaWxe
         BEkoFvfPxDg6PUzKMQ/kSbfAovu6XePz9kX4ubLMBzqIzMdQIkCtb7tPr80jDoTS6guU
         3s79i7I3Wca3lnHl/AhN79nVDPU/PzHDdpDAG3jpGIefmmh+BHsRQZHQQpntzyhYoqPS
         y3vw==
X-Gm-Message-State: AOJu0Yz9+nsrER2HbHEeQZVNUwyVELKGYpWwcaPVu7TiUx5IejEV+mHi
	Zi0UG+VMSMQmV6QF4JtKQHZ1a5LoccZ8EahhRo8FD0f4VKnc1dmwDCWKrMK9QKvhJ2MksPMVdkr
	yh9UGKhjK7PqJT76JHg4N/jzD5Ag2AK5RE78Yp+0DJW8jFjISotS/FtjBUQ==
X-Google-Smtp-Source: AGHT+IEdeR7vqhjXVXUqfhn4OMRaUQjVLWEzxWL7oBWFdDrPjgXsGKfAc3tlumJbTj76USaRGXONQlYkg7/3t0ySer+b6OcQzXzW
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c0c:b0:366:bbfb:5866 with SMTP id
 l12-20020a056e021c0c00b00366bbfb5866mr274294ilh.3.1711321943188; Sun, 24 Mar
 2024 16:12:23 -0700 (PDT)
Date: Sun, 24 Mar 2024 16:12:23 -0700
In-Reply-To: <0000000000000f823606139faa5d@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008535e40614703068@google.com>
Subject: Re: [syzbot] [PATCH] fix array-index-out-of-bounds in bpf_prog_select_runtime
From: syzbot <syzbot+d2a2c639d03ac200a4f1@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: [PATCH] fix array-index-out-of-bounds in bpf_prog_select_runtime
Author: cam.alvarez.i@gmail.com

Please test the following

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 9187210eee7d

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


