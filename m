Return-Path: <linux-kernel+bounces-87669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE4CA86D797
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 00:16:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D9201F22CF5
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 23:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EECC774BFE;
	Thu, 29 Feb 2024 23:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PxZTJH0Q"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6382945957
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 23:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709248611; cv=none; b=URq6ha3ygs7uSWnmTUotxRHuotmcUNt2fEhcH7DBcy9eDOYO5Dx6TUHuqoZEBrqcRWjcpUBNg2yrvxt7uz+pvZMVx3kDQpjj26L0tAT3K3Nm6Lthz5Y5GdHkofP1lpkcR6zTwmTRqsVUtD18H5H8ZMlMIn5uaKHLhZQTEA8UW1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709248611; c=relaxed/simple;
	bh=kko1wRbcDQvt3W65DRy9btpMD1yYIdX2oPSHln6jwMQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KOrqsnciot3koltJASAIHNg6Aq6tgPX5d8UzyVaIMEWRa/+y8COzl/E/fGXWfUHj2ilUjGsv3P9rYq2nS4IbjKuxDTgYZOsfn6QI0WuNIdRCx+NryzYYZM9Li149RfG/KGWsyOCnUbFeLDJx1IcbKo636Rtjov2RRJcDGbTIXic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PxZTJH0Q; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-412ae15b06fso9920205e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 15:16:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709248608; x=1709853408; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=67SNOCAdR0s4Rh4ZptML72F1P1c4wCYZ2HszSt1XfEo=;
        b=PxZTJH0QpvrpwuxR0eAsRqbsE1hxxi2aOleLjuyUgs4dJHnarfOdl94pfLch+ds0Kl
         e3N5WSmCcWkeulNzfubup+SLWjsCzbkgc0s8gc+iCMHUYTv0ofBnSdY5xsIv80wAwj3N
         +eXJ3ZEzxuOSETZL/g+pf/dCuSHqbhyB/BQKtNuEfoPSFMGfn//8By2eeOmctVHSW+7Y
         3i3VYPA3Z1KaSdRNxq/X+wYwV4iMNoR6wClXx1n3ypXki9djpKW+UgPK86QeYuCoTQo9
         GtCzTkKO58ZXIaQjcjicqcGOcXD1SlzlTFIdPMtbTVaLwdr1d3zLKOQzt0UN7fcglwuo
         u7lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709248608; x=1709853408;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=67SNOCAdR0s4Rh4ZptML72F1P1c4wCYZ2HszSt1XfEo=;
        b=cTePe1PBwBPrJDTSPnahCDVKZx0x2QmKgewpz5TyhagdANs2m+VCEvBanVcsLyGejc
         196h0MyH9bUacXDfwzFT0GM23hMeBB/187YqfgJCxv4hiff0UFqYyAiutfOPhcyu+Dp+
         iZOWxpKsc/FXxapZKyHJKq+mOtfPVIJXqZgMjRXQs+J8HZu5iRmUXmK/ruwCIsZnoM0p
         vClEFzysDTAIHCTC7BZ5jWz4Tn5lM9ZNSN4V7pJcl1uXYOAZXqCOv9wXrC/SeOFZ+t51
         KimGhkYprFLKp1lHei1Dv97cDtZ6rdNv/6OY0LjHnK2Jzs7TwCx4MufRfn/UFyhHcmm4
         dmIQ==
X-Forwarded-Encrypted: i=1; AJvYcCX4ZHtaaO+GSiRnERB30psI60Fib54+HvXw9F04+eQI8xLKzYlFKFbvKjJExzDwEUuqN3zD967qGzC/7ibPiXTeP+Jok+hLqRfkheM8
X-Gm-Message-State: AOJu0YyAVYNkcS6DDiAmw1JuajgXPHGmxBk7zodU9mBj4/jpdBqGSvj4
	bGfB+rAfSfTYmXR5pLxxQF8gQstLJQOLV7aj9tCwy6qCw9D9wegQ
X-Google-Smtp-Source: AGHT+IE45Yvom/A/j4RSMfDYF1CUEdZTkwIkyVR4ezwPFfY1flUHd2kbPJ5xKXEOW1rOccNE4mu7Qg==
X-Received: by 2002:a05:600c:c8b:b0:412:85c2:db12 with SMTP id fj11-20020a05600c0c8b00b0041285c2db12mr75679wmb.2.1709248607440;
        Thu, 29 Feb 2024 15:16:47 -0800 (PST)
Received: from localhost (54-240-197-231.amazon.com. [54.240.197.231])
        by smtp.gmail.com with ESMTPSA id m17-20020a05600c4f5100b00412b7456ef7sm3506412wmq.5.2024.02.29.15.16.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Feb 2024 15:16:46 -0800 (PST)
From: Puranjay Mohan <puranjay12@gmail.com>
To: catalin.marinas@arm.com,
	will@kernel.org,
	nathan@kernel.org,
	mark.rutland@arm.com,
	broonie@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Cc: puranjay12@gmail.com
Subject: [PATCH] arm64: prohibit probing on arch_kunwind_consume_entry()
Date: Thu, 29 Feb 2024 23:16:20 +0000
Message-Id: <20240229231620.24846-1-puranjay12@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make arch_kunwind_consume_entry() as __always_inline otherwise the
compiler might not inline it and allow attaching probes to it.

Without this, just probing arch_kunwind_consume_entry() via
<tracefs>/kprobe_events will crash the kernel on arm64.

The crash can be reproduced using the following compiler and kernel
combination:
clang version 19.0.0git (https://github.com/llvm/llvm-project.git d68d29516102252f6bf6dc23fb22cef144ca1cb3)
commit 87adedeba51a ("Merge tag 'net-6.8-rc7' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net")

 [root@localhost ~]# echo 'p arch_kunwind_consume_entry' > /sys/kernel/debug/tracing/kprobe_events
 [root@localhost ~]# echo 1 > /sys/kernel/debug/tracing/events/kprobes/enable

 Modules linked in: aes_ce_blk aes_ce_cipher ghash_ce sha2_ce virtio_net sha256_arm64 sha1_ce arm_smccc_trng net_failover failover virtio_mmio uio_pdrv_genirq uio sch_fq_codel dm_mod dax configfs
 CPU: 3 PID: 1405 Comm: bash Not tainted 6.8.0-rc6+ #14
 Hardware name: linux,dummy-virt (DT)
 pstate: 604003c5 (nZCv DAIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
 pc : kprobe_breakpoint_handler+0x17c/0x258
 lr : kprobe_breakpoint_handler+0x17c/0x258
 sp : ffff800085d6ab60
 x29: ffff800085d6ab60 x28: ffff0000066f0040 x27: ffff0000066f0b20
 x26: ffff800081fa7b0c x25: 0000000000000002 x24: ffff00000b29bd18
 x23: ffff00007904c590 x22: ffff800081fa6590 x21: ffff800081fa6588
 x20: ffff00000b29bd18 x19: ffff800085d6ac40 x18: 0000000000000079
 x17: 0000000000000001 x16: ffffffffffffffff x15: 0000000000000004
 x14: ffff80008277a940 x13: 0000000000000003 x12: 0000000000000003
 x11: 00000000fffeffff x10: c0000000fffeffff x9 : aa95616fdf80cc00
 x8 : aa95616fdf80cc00 x7 : 205d343137373231 x6 : ffff800080fb48ec
 x5 : 0000000000000000 x4 : 0000000000000001 x3 : 0000000000000000
 x2 : 0000000000000000 x1 : ffff800085d6a910 x0 : 0000000000000079
 Call trace:
 kprobes: Failed to recover from reentered kprobes.
 kprobes: Dump kprobe:
 .symbol_name = arch_kunwind_consume_entry, .offset = 0, .addr = arch_kunwind_consume_entry+0x0/0x40
 ------------[ cut here ]------------
 kernel BUG at arch/arm64/kernel/probes/kprobes.c:241!
 kprobes: Failed to recover from reentered kprobes.
 kprobes: Dump kprobe:
 .symbol_name = arch_kunwind_consume_entry, .offset = 0, .addr = arch_kunwind_consume_entry+0x0/0x40

Fixes: 1aba06e7b2b49 ("arm64: stacktrace: factor out kunwind_stack_walk()")
Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
---
 arch/arm64/kernel/stacktrace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/stacktrace.c b/arch/arm64/kernel/stacktrace.c
index 7f88028a00c0..b2a60e0bcfd2 100644
--- a/arch/arm64/kernel/stacktrace.c
+++ b/arch/arm64/kernel/stacktrace.c
@@ -247,7 +247,7 @@ struct kunwind_consume_entry_data {
 	void *cookie;
 };
 
-static bool
+static __always_inline bool
 arch_kunwind_consume_entry(const struct kunwind_state *state, void *cookie)
 {
 	struct kunwind_consume_entry_data *data = cookie;

base-commit: 87adedeba51a822533649b143232418b9e26d08b
-- 
2.40.1


