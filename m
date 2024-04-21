Return-Path: <linux-kernel+bounces-152594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22FA98AC0EB
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 21:17:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B634B20FFB
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 19:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CCC33FB14;
	Sun, 21 Apr 2024 19:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lo50098D"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D323F8ED
	for <linux-kernel@vger.kernel.org>; Sun, 21 Apr 2024 19:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713727052; cv=none; b=HDGMoBmrZsqkJGsZAYLlLGKbTppn4uv71UeQvNpo5s8sBm7fFco7lNkdb3KwQ4QvRWCs8dBQl6LDMZhy8H00Kenxl3Jj3fkmtuqFhgS8clHCCDqW5g0nRo0FW7zVTDRlWLXWSC0AAMkI0JwdB72ZN6qUOmnBXrOpti3KT0wJmKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713727052; c=relaxed/simple;
	bh=J0OuVPrjKnI+2yDEh2HpOwIHUwKzrGSnjwOnVRO+I9w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q2/Xs2jLxPNnaPFcqQWJJKn3RoJE5amo95wFN2Hpe0iZVN732hW84SE6gRTebIxEhy5NIwIUpGayN2ghmuMx5jbsXd8Q/zKQyjWrA2yptVSVMghLSXKrLL3hVue+XoZ8KxXp1qi2a56A5tI0Fb+oZSQI+4FuhDr+XTNltjBBEXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lo50098D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4397CC113CE;
	Sun, 21 Apr 2024 19:17:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713727052;
	bh=J0OuVPrjKnI+2yDEh2HpOwIHUwKzrGSnjwOnVRO+I9w=;
	h=From:To:Cc:Subject:Date:From;
	b=Lo50098Dwtw0gXq6T/8vjxoZxdE43Ngplj+Obijq6Z6mDLMdct9VdG2tJ74CZS5RK
	 clS1QjzfncEq24hRCG1AE7eP0CwdSRPoX0E0s5c12JUgc7g+IsHcXStVtW7k71ape7
	 79WpxIXrDLU8G8HEaTshLtRSDPei0B7cOJkokNEDJpWIjCuRnfiYCTl3YwYRB2HA6n
	 rKvPvz2l+P79Kpoj1QVoF7TVAaTliS7I95amvGiziLJ2OHet3llbTldB2yzRzNkvex
	 ItxEopqR/gqmLtntj5cW3rm7r/I1n0sVHxm72GBE10vUgPgp6DLC1nom2wesav3/+G
	 6uLJruFrwcBsQ==
From: bp@kernel.org
To: X86 ML <x86@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	David Kaplan <david.kaplan@amd.com>,
	Borislav Petkov <bp@alien8.de>
Subject: [PATCH] x86/cpu: Fix check for RDPKRU in __show_regs()
Date: Sun, 21 Apr 2024 21:17:28 +0200
Message-ID: <20240421191728.32239-1-bp@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Kaplan <david.kaplan@amd.com>

cpu_feature_enabled(X86_FEATURE_OSPKE) does not necessarily reflect
whether CR4.PKE is set on the CPU.  In particular, they may differ on
non-BSP CPUs before setup_pku() is executed.  In this scenario, RDPKRU
will #UD causing the system to hang.

Fix by checking CR4 for PKE enablement which is always correct for the
current CPU.

The scenario happens by inserting a WARN* before setup_pku() in
identiy_cpu() or some other diagnostic which would lead to calling
__show_regs().

  [ bp: Massage commit message. ]

Signed-off-by: David Kaplan <david.kaplan@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
---
 arch/x86/kernel/process_64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index 7062b84dd467..6d3d20e3e43a 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -139,7 +139,7 @@ void __show_regs(struct pt_regs *regs, enum show_regs_mode mode,
 		       log_lvl, d3, d6, d7);
 	}
 
-	if (cpu_feature_enabled(X86_FEATURE_OSPKE))
+	if (cr4 & X86_CR4_PKE)
 		printk("%sPKRU: %08x\n", log_lvl, read_pkru());
 }
 
-- 
2.43.0


