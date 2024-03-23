Return-Path: <linux-kernel+bounces-112511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31E5D887AB4
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 23:54:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3F22281EF0
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 22:54:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7B185B5B3;
	Sat, 23 Mar 2024 22:54:50 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A20E523C
	for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2024 22:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711234490; cv=none; b=ReXWRcNJcBuhWiOiZuhkkn1pnRpT5ycoj0oWutln0oTrTKtOCs08+I97WIk6TJpesEse3J6ireZUEmY4uRJERUs29lCgcRr7Bk680wAj0GlfmHbsekVdHz/v3gnWS8q3XDyOCfDXkT6yvEPkeB6k8KigXUUuGjCQ+kqNlMpzmVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711234490; c=relaxed/simple;
	bh=3Fe/iIMQqp+WJeQACVWKx+C04G6JyTPfBoK5VF53soc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=BEGoiRaDEsaysnHfROVaKyStNrO+WtOYz/n9y95oLAjqToiTJtRMAQ3b0uazYUiara2r+gDuaNU8Rs+CA4hFzsPxo6Ktplv0JdCrSNeSsbR/6Br05+RQ8b3tRhLhGPJfg1S8EdH+vjTfTi12QowU4fhnSCyzxFKjqDCv47N1jxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-366999e233aso32020385ab.0
        for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2024 15:54:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711234488; x=1711839288;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ldjIjH5C/+85jRoW3Fh1JBwVwnwfJeYcs5iw49zJn2g=;
        b=wM6P2jvMXv9OiNI7Zn34/ekBzGDGxs7j0TtgKdOC7nf9LB6dc5X+nU3tTZ/W3+zhLL
         +QxQV2knc3e6P3lLzWHmQRDC3soy7qLGZobF3zw6soWjJvm5yaQPqjOrKxCNqN6b4Juj
         Qoo+qjgE8vW6e/vavuShJbX2aByzsEVcKknuROt2S5dmXg/f18jG5XxGors55LTiZ1N7
         VgH0WcB8S8wTUSyAzwDS+foKUcIi90aLAFaLrGdEqpDntAnZG/pys6BIVmffS2S4W/dl
         t1vE7HF1/CRrikcJCOZk56Q/TokFl1heggmJi3k3p8N0mMHPcXqkIfZyUaL34AqD8bnx
         V9mQ==
X-Gm-Message-State: AOJu0YxRLOFRf7HuijI3sIzvSZPHWJShuZCUP9nfcIIVWe/W7YnqfTuU
	g+mH9GWQ/p90O7pGni40xCLrSgBldlQpXpf7kCTJ9HbeXTAJARD7IqxoesNNAoHFijVb27KGmYw
	ikeGGNLyvxDY1OggEXYdAFq+TCJ+K8ajAIC2XKPdxnwcy0qKWJRXrIYuyjA==
X-Google-Smtp-Source: AGHT+IFo8WAhoYjzmyV5FwELKDtNbpnNZp5O9CCDNdzrsLB00Sgz1d6mVlnc0ZQSma1tohKQQZAeidXqRfmZUdPsAiz1ycPwwlmE
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:524:b0:366:97fc:b9cf with SMTP id
 h4-20020a056e02052400b0036697fcb9cfmr107907ils.0.1711234488278; Sat, 23 Mar
 2024 15:54:48 -0700 (PDT)
Date: Sat, 23 Mar 2024 15:54:48 -0700
In-Reply-To: <0000000000000f823606139faa5d@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000cd321c06145bd37f@google.com>
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


