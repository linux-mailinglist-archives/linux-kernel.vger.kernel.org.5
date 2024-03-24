Return-Path: <linux-kernel+bounces-112680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DC22887CE5
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 14:38:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2920B2813C2
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 13:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4F1E17C66;
	Sun, 24 Mar 2024 13:38:25 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB31117BCF
	for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2024 13:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711287505; cv=none; b=HmvVuQa8tHsGmDiUTXSbrUx9I8rWXNigQ+PzM5XO+9z4xbLWv11geuDZa5nBXgb5Si4ikGFpbQ4TEh52bzfPlfsFTbcHFfcN+dob2eX0LcB8r6e3romRbpt5/aQmOjaBC1XWjO8miiOX4msXywlgCdrt6Yaj0UUhuaGO1DTw7AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711287505; c=relaxed/simple;
	bh=3Fe/iIMQqp+WJeQACVWKx+C04G6JyTPfBoK5VF53soc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=t9yUovqGEJsuK3Gx/XIQR/am49k4T0Nic6BTvsQY40krq02l1TZKjLsNWM6EM9fT8LtYVhgbpXM/t5UlX8/ESe85GWQYA6n0YiPfwG4Fr9ZogjkYzL8ZQrVLVn6IyPnP65FhcINJI57jHr2PdbgeHvgAqWCwFDDilzUlV+N12Jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7cc012893acso378476939f.2
        for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2024 06:38:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711287503; x=1711892303;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ldjIjH5C/+85jRoW3Fh1JBwVwnwfJeYcs5iw49zJn2g=;
        b=bL432f7UbxSO377PGJFCD3k/UkOsxawiWf57wZFJfsuD9TWFvJ445/768Hb+6ZUZ5P
         02wSqkMhWN1yign42EuvfiqDUzg7lYbUJOw9sOrtdPyiI5epA6pazD9z+FvLMF/4DEBi
         r3rzvjD3yxEVJ5FA2+BVG/rTg7yh4gWq2n0OZwCP+Tm+Om+ps0N3KNOiRYMWqGsvoars
         AQC2RYkycsnhNp7oNbnbdiCNqcHWtR12mIMoTyUBn1sqCjvchXEjAv/jYR9vfDbE58y7
         H6bPsJC3BysFKoSPS1IbY1AlfQZlFC4gSdHSHYWbvmGPWLVUa6eINKO2YjQ+152QCCHQ
         qYgQ==
X-Gm-Message-State: AOJu0Yx7dqtyfu7EZgnXE4i4TKJkJNKU34cktDPqE7Wc12khNmDdUVzt
	NqwgAs6FNh+3nJPgKa7j3kVRZcY9x7MblvN7mNf6/NQwbusAx1Fros67sgBtRzoLeJ2BoR42O+N
	jxTGqRHcfm+oQ0jaTx2TyIwUgsrZd76+aBe+hs4+auns7gs+BpexkSIXIYw==
X-Google-Smtp-Source: AGHT+IEctvXyqwveOltRdDceMLxUr7ICQky8QC+RczNzvhXtQqIU1A4x3ULwnFwJsmzRQCDXKPXumTjVThs4v+3moseUD1vApfmy
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:3790:b0:47c:829:32ad with SMTP id
 w16-20020a056638379000b0047c082932admr104259jal.0.1711287502848; Sun, 24 Mar
 2024 06:38:22 -0700 (PDT)
Date: Sun, 24 Mar 2024 06:38:22 -0700
In-Reply-To: <0000000000000f823606139faa5d@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b757af0614682b1e@google.com>
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


