Return-Path: <linux-kernel+bounces-91018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6815F870882
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 18:43:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55FEE1C21E41
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 17:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C857D612F6;
	Mon,  4 Mar 2024 17:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mr5lOpib"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74F944653A
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 17:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709574226; cv=none; b=daSJ8QYDGMI7TXoaG0NlW+zHCZv+iLH7/8qDljvgrKv1XHs3QXXgxy/XUeB0emEW/hXhpe/kSG1lkhzQ9dXOg4IocKmmQeVpFKicdR1GLffG+71UiqmVXBc6IfFYjHGD436/VfULZO99CxIYRk4rQuzz2JOe+qbO14mKgjgh0Hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709574226; c=relaxed/simple;
	bh=csBhKfknigH6z0pQN2wfmequHHA18feIPmtOVrb7rUA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gfbjAszOjeJB8MwRH+bkQ6TGndOLXccOMAnrGEHZbzLXJyeU8qGPiznEI+IAFiCXHbbEDEPf8oB8+fAbHKVdaygaQiqq7h2VaWhn1GUGanUbufULl/ibC1lLp8zFB8RbhM3E4bUo190VodPPC6jOeBV0sfEqjdGtZ5bHRmCklGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mr5lOpib; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-412d84ffbfaso1995e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 09:43:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709574223; x=1710179023; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=avRWHU8M4QiZaJ1VUjT1h71GgCHpu89KSWnmXCLWs8U=;
        b=mr5lOpibv3RMTfIytOlWQuuL+PqHQcNpLkx/pJ2pW4zo/Xmcnq2Z7ybD9Z47vT2UpR
         ibcDZ1v3frWv5n/y0u+wz/pTHofFduYbJODhV9nOJggXT4KwkHctZnxj25S7cWgZ1VRj
         UglN4zSPgsn4PDyIwUwml3i+87iVHpwh/4grafiB5m0/A8ADwUHG8YD7J4FsPDX/ks4+
         RmjjYSOKs5V6UWocqPQsyDfS10+mARU4Y3biw06IoNEy4cmHa2FPliWBbPugjcemISb+
         3yNEeswu9C3LyR0msqYKZYGDYrG7qsOG/wq7fuXhZ/RJIY60f7LVZ/2lq2MZfjc0dEHe
         oPCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709574223; x=1710179023;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=avRWHU8M4QiZaJ1VUjT1h71GgCHpu89KSWnmXCLWs8U=;
        b=j2Mw5zPn/RsSDEFrGC9lKU8fp/VtehuqvsWTRqmjTG7AWNBxae13oj1nGnMMEoXhey
         m7WGnery4Zneq9tVGwujaIe6oPvW2PQNi2g5/45djYSLMI9oP+8pAF60sOOmAGq+lhjx
         U7kxO6HGLZrxMGJ1gmGY0GXMxLlVvLt+E0EDzXUtsrzkibrU53c+k9LQU27x8l3IFgLt
         iDPjnkRlw/QZupk1EV9c5m8NSi6RDDnCShkUBBiMfV/dY48y/PtellFjPyndz1vc92IS
         QCehLjxbHIeU/RFUzPEVJcm1crNJBd++SbOCqIDffSFMqitD0e8UulUwv4FHWVyda1rR
         XacQ==
X-Forwarded-Encrypted: i=1; AJvYcCVd75aAcNn5bmvHJWU8WV1E7JmuzG+11qnFS88rVfrPTgYleMO7AbwoQEJHnih7AYEePdKgH8t4hbCz8olqnumQ3ncMQcda0+M6IzDc
X-Gm-Message-State: AOJu0YyI/7SVDEMrgYIg2/szLtae26GSTofSuW/bPxkxvOOz2lEOCTkB
	CleA1pzMYHJNVXQ4cgLm4d2JoHgvHCDihDQD5Zs0RoM+ztqK3rKKu+8dOxbRaA==
X-Google-Smtp-Source: AGHT+IGn3FZZKm8D4lufj25CBQJ8aXgL/bNOvcErxQeVF7L6wgBXv9M+E6e14jT1Sn6m02HweXz9pQ==
X-Received: by 2002:a05:600c:3b20:b0:412:e4fc:b10 with SMTP id m32-20020a05600c3b2000b00412e4fc0b10mr175366wms.3.1709574222713;
        Mon, 04 Mar 2024 09:43:42 -0800 (PST)
Received: from localhost ([2a00:79e0:9d:4:ad6c:c121:3812:b9b6])
        by smtp.gmail.com with ESMTPSA id q13-20020a5d61cd000000b0033e11ff6284sm12119927wrv.12.2024.03.04.09.43.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 09:43:42 -0800 (PST)
From: Jann Horn <jannh@google.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] x86/debug: Forbid tracing arch_uninstall_hw_breakpoint()
Date: Mon,  4 Mar 2024 18:43:36 +0100
Message-ID: <20240304174336.68929-1-jannh@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I tried using perf_event_open() to set hardware breakpoints on every
allowed address between the kernel's _text and _etext. (For reasons.)

arch_uninstall_hw_breakpoint() was the only function where this immediately
blew up, with DB0 set to the address of the instruction for
`dr7 = this_cpu_read(cpu_dr7)`, where the directly preceding instruction
does `*slot = NULL;`.
I think the issue there is that we clear the breakpoint tracking state
before actually disarming the breakpoint.

Signed-off-by: Jann Horn <jannh@google.com>
---
 arch/x86/kernel/hw_breakpoint.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/hw_breakpoint.c b/arch/x86/kernel/hw_breakpoint.c
index b01644c949b2..f46a460dbd31 100644
--- a/arch/x86/kernel/hw_breakpoint.c
+++ b/arch/x86/kernel/hw_breakpoint.c
@@ -140,8 +140,11 @@ int arch_install_hw_breakpoint(struct perf_event *bp)
  *
  * Atomic: we hold the counter->ctx->lock and we only handle variables
  * and registers local to this cpu.
+ *
+ * noinstr avoids getting hit with a breakpoint when the debug register is
+ * still active but we've already removed ourselves from bp_per_reg.
  */
-void arch_uninstall_hw_breakpoint(struct perf_event *bp)
+void noinstr arch_uninstall_hw_breakpoint(struct perf_event *bp)
 {
 	struct arch_hw_breakpoint *info = counter_arch_bp(bp);
 	unsigned long dr7;
-- 
2.39.2


