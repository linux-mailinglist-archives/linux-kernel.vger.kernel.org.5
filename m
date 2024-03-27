Return-Path: <linux-kernel+bounces-120234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B01188D4A5
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 03:41:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4923D300897
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 02:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2548920B12;
	Wed, 27 Mar 2024 02:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h9IxAVQa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F3CD1CF92
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 02:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711507286; cv=none; b=olsRr+6OpPc79TgPBMqjZt7/eHTUw/H+e5AXLcrNLtDnBCEzuE7unO3/FUvKPY1KMN3LCMSJ3QYP82OxUcSqSG3AyVX5My/L5a1mN/f1Dl7tnkfm9x17aKLbESnlwsXxjdaAdeW4YjMpPIVGXAgbqVhS1BoPbYOTJzv9hI//i9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711507286; c=relaxed/simple;
	bh=QHEFYyJ0ZlpC9va2tA5qgb0s5US0vAP7cmBdzlyHBPc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ETx7Ymm/jnnBEvynASOIH8msnjtPIJeuaRou4TqdkhXo1HOw/FwW9zmUcfLf9JS9gn1DuyklNhCEKC5f2lXC3f49aYiFuzPEq7HX+15qgI0TOs4vft2/lZeNgpQFsz2DB+DNmLPh829Hpn4tBGROIUEDO1PBsIpOF/H1APm2lfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h9IxAVQa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2885BC433C7;
	Wed, 27 Mar 2024 02:41:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711507286;
	bh=QHEFYyJ0ZlpC9va2tA5qgb0s5US0vAP7cmBdzlyHBPc=;
	h=From:To:Cc:Subject:Date:From;
	b=h9IxAVQa2oQhabHEkXkOcYtPUK21b/6G1Rfh8FAV0eI1h6CBRQKvHFlwYh3GtP0lv
	 HgnR7yzaN1QFOmydw81Xy/m749TVemFMyLLbVm/+r/YXVhR18+G05yWVexbgoIMsJs
	 9JwrCMthQgq3MOGOTqVo4uKpoUuq8Vg9am7ps46Z9RQHqoR9L8zRZkFS+EppllT2Sl
	 cwiPS6SBxekUwWum/z0J7xxnodtf9NOe1vUDNDSrhHKILcZLTiXX8Gs0Wawi5e/i+Y
	 vM57XDJpeVtp0ncfpMRh/fqqEGgJyIZYr0A1B1Eg+hY/Vn8ifkyoJBbsT6tSitaJfs
	 DX7/PpdbQh3hQ==
From: alexs@kernel.org
To: Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	"H. Peter Anvin" <hpa@zytor.com>,
	linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT))
Cc: linux-kernel@vger.kernel.org,
	Alex Shi <alexs@kernel.org>
Subject: [PATCH v3] x86/dumpstack: uniform die messages prompt
Date: Wed, 27 Mar 2024 10:44:19 +0800
Message-ID: <20240327024419.471433-1-alexs@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alex Shi <alexs@kernel.org>

panic() has a uniform prompt, like "Kernel panic - not syncing:". That's
easy to indicate a panic there. But die() message doesn't have.

We died thousands machine with very different reasons weekly. w/o a prompt
in dmesg, it's hard to write scripts to collect and anaylis the die reasons.
That makes admins' life pretty hard.

A uniform die() prompt like "Oops:" could save some hair for admins.

Signed-off-by: Alex Shi <alexs@kernel.org>
To: linux-kernel@vger.kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>
To: x86@kernel.org
To: Dave Hansen <dave.hansen@linux.intel.com>
To: Borislav Petkov <bp@alien8.de>
To: Ingo Molnar <mingo@redhat.com>
To: Thomas Gleixner <tglx@linutronix.de>
To: Peter Zijlstra <peterz@infradead.org>
To: Josh Poimboeuf <jpoimboe@kernel.org>
---
 arch/x86/kernel/dumpstack.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/dumpstack.c b/arch/x86/kernel/dumpstack.c
index f18ca44c904b..e1358ef80b59 100644
--- a/arch/x86/kernel/dumpstack.c
+++ b/arch/x86/kernel/dumpstack.c
@@ -405,8 +405,8 @@ static void __die_header(const char *str, struct pt_regs *regs, long err)
 		pr = IS_ENABLED(CONFIG_PREEMPT_RT) ? " PREEMPT_RT" : " PREEMPT";
 
 	printk(KERN_DEFAULT
-	       "%s: %04lx [#%d]%s%s%s%s%s\n", str, err & 0xffff, ++die_counter,
-	       pr,
+	       "Oops: %s: %04lx [#%d]%s%s%s%s%s\n", str, err & 0xffff,
+	       ++die_counter, pr,
 	       IS_ENABLED(CONFIG_SMP)     ? " SMP"             : "",
 	       debug_pagealloc_enabled()  ? " DEBUG_PAGEALLOC" : "",
 	       IS_ENABLED(CONFIG_KASAN)   ? " KASAN"           : "",
-- 
2.43.0


