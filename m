Return-Path: <linux-kernel+bounces-69293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A32198586B1
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 21:25:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE123B20EDD
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 20:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54ECF13956D;
	Fri, 16 Feb 2024 20:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MnNmhh1/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E4444369
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 20:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708115132; cv=none; b=rkTRFNBVvYdnUUC9jpFg40wUBsQ3H0mWntr79CW51FTI0yMuqKp7QHjsESDDoSdjVLbDMLHNiAv50oY+NlZNTEFLB665MlQLLt8k6C0n4NGQ8m+tQnTeNzddtmyKmFI7IVJlnp4AMZoTsclkQOPHLflAQwLTDPGFuEVs8j/Scvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708115132; c=relaxed/simple;
	bh=5m10hyFOE1LGB3w8Av1dfB/+tfaDWVKf5u7u9AlK1ok=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ufktK4UQ4RGbVzd0rjIp2II5K1C8DPNuh4kikOXdCeQI610bqOmmwsmyAitAqUQlrgy8FEtk8fmy20sWeuZOHhXOxyZbsmMvcJDkkFcT/7kq8Bb3VJrnGld2v2PDYF/yw+UX5cuN0n3HK8iDYGbfu9MsaoPz6lGmBqw1ACvpTsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MnNmhh1/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CED9FC433C7;
	Fri, 16 Feb 2024 20:25:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708115132;
	bh=5m10hyFOE1LGB3w8Av1dfB/+tfaDWVKf5u7u9AlK1ok=;
	h=From:To:Cc:Subject:Date:From;
	b=MnNmhh1//5twLjJEkyCnIDz9Um/b2GOKFtnqMuxk9ERPUcI+pUQonhRu/Sh64ion7
	 sHPrqpdy0NNwF/cXo0KoOA/F23NVdadthL6IggofQ7flgncidAB2XgP4ZXxYqcMepR
	 yhN5JTA1vHapW/9vg3GvLxM+oN3klxnxBUqO73GNWtv3AaKMxAE4baeP/3IzHMtPXy
	 IP+23WhEuOoK2Xa/o6Ey3/YuaqhSDJ33oCafVJ+FBd7S0dZLN89EAUro38Qq3rBKlJ
	 eVmpRP7nGNwuXiGyQq99Ll5PyVHO0j13tNsO00DsO08z/gAJ+uD5FoTf3kU2DecEol
	 cwqBHuKGaPq+w==
From: Arnd Bergmann <arnd@kernel.org>
To: Xin Li <xin@zytor.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Andy Lutomirski <luto@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] x86/fred: fix building without CONFIG_KVM
Date: Fri, 16 Feb 2024 21:25:14 +0100
Message-Id: <20240216202527.2493264-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

Some constants are only defined if KVM is enabled:

arch/x86/entry/entry_fred.c:117:9: error: use of undeclared identifier 'POSTED_INTR_VECTOR'
  117 |         SYSVEC(POSTED_INTR_VECTOR,              kvm_posted_intr_ipi),
      |                ^
arch/x86/entry/entry_fred.c:118:9: error: use of undeclared identifier 'POSTED_INTR_WAKEUP_VECTOR'
  118 |         SYSVEC(POSTED_INTR_WAKEUP_VECTOR,       kvm_posted_intr_wakeup_ipi),
      |                ^
arch/x86/entry/entry_fred.c:119:9: error: use of undeclared identifier 'POSTED_INTR_NESTED_VECTOR'
  119 |         SYSVEC(POSTED_INTR_NESTED_VECTOR,       kvm_posted_intr_nested_ipi),
      |                ^

Hiding the references behind the same preprocessor conditional is
probably the best fix here.

Fixes: 14619d912b65 ("x86/fred: FRED entry/exit and dispatch code")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/x86/entry/entry_fred.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/entry/entry_fred.c b/arch/x86/entry/entry_fred.c
index ac120cbdaaf2..660b7f7f9a79 100644
--- a/arch/x86/entry/entry_fred.c
+++ b/arch/x86/entry/entry_fred.c
@@ -114,9 +114,11 @@ static idtentry_t sysvec_table[NR_SYSTEM_VECTORS] __ro_after_init = {
 
 	SYSVEC(IRQ_WORK_VECTOR,			irq_work),
 
+#if IS_ENABLED(CONFIG_KVM)
 	SYSVEC(POSTED_INTR_VECTOR,		kvm_posted_intr_ipi),
 	SYSVEC(POSTED_INTR_WAKEUP_VECTOR,	kvm_posted_intr_wakeup_ipi),
 	SYSVEC(POSTED_INTR_NESTED_VECTOR,	kvm_posted_intr_nested_ipi),
+#endif
 };
 
 static bool fred_setup_done __initdata;
-- 
2.39.2


