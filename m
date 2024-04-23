Return-Path: <linux-kernel+bounces-155118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BAB88AE57B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 14:07:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB2D7B250E8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 12:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5849A84E16;
	Tue, 23 Apr 2024 12:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b="fSdsf0mJ"
Received: from out0-219.mail.aliyun.com (out0-219.mail.aliyun.com [140.205.0.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C1C584FB9
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 12:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.205.0.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713873672; cv=none; b=kXvtMjQsMbthpo/YzrNeX1mnyCG3tK2HkKvbEO/oDdmU+aV4buZuMuKSNbFx8ZmJlECbXt9KZdeKjoV6Mj22n9L7tHDOWZ11O16krbebuW4s6f9xvCgjrZaZr5Uh40Kvh1AgOjGvAEySib/Gq9hWXG7Mzikzf6sfaVEz8KRcj+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713873672; c=relaxed/simple;
	bh=lO9Bd4UllQCFZec64y1qmF5J3KpOu4cT1md4bLuelWQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=r9O6w7j5awEZKtGE42jRU2jSiXm7eCttb6hba/OX0YCi9yUsMINE8MCvYWg/GlmaMwTXztkDxqiKCsqWrdqCwB4A0iJmrVhJdEPN+6QFMjvPx2PvhhIjUnToBTiZavtDYRKVTTBBQvWefHXJK8MVhMcpckmhzCQp67c2nuU/oW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com; spf=pass smtp.mailfrom=antgroup.com; dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b=fSdsf0mJ; arc=none smtp.client-ip=140.205.0.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antgroup.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1713873663; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=fZ3yJhfmevqTNF6DwN5orHbyXoVhDRkMA3HeGG/5QSU=;
	b=fSdsf0mJrJ/A+S4J9ITb+hEA9zinCZerCCo4vHUDueuBnnfv2QstELM9+DFqgyU4n9pLYK9fJolBMRbn316O149dm3sKDpsao5/tKNvSJCEIIo5yoeivmM+6MNb6JwtCfDmPF6keq8Nh01lz0bK9YGUzqbxlCQNDK/8PKip3dmM=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R721e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018047201;MF=houwenlong.hwl@antgroup.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---.XJWBgvy_1713873662;
Received: from localhost(mailfrom:houwenlong.hwl@antgroup.com fp:SMTPD_---.XJWBgvy_1713873662)
          by smtp.aliyun-inc.com;
          Tue, 23 Apr 2024 20:01:03 +0800
From: "Hou Wenlong" <houwenlong.hwl@antgroup.com>
To: linux-kernel@vger.kernel.org
Cc: "Hou Wenlong" <houwenlong.hwl@antgroup.com>,
  "Juergen Gross" <jgross@suse.com>,
  "Boris Ostrovsky" <boris.ostrovsky@oracle.com>,
  "Thomas Gleixner" <tglx@linutronix.de>,
  "Ingo Molnar" <mingo@redhat.com>,
  "Borislav Petkov" <bp@alien8.de>,
  "Dave Hansen" <dave.hansen@linux.intel.com>,
   <x86@kernel.org>,
  "H. Peter Anvin" <hpa@zytor.com>,
   <xen-devel@lists.xenproject.org>
Subject: [PATCH v2] x86/xen/pvh: Enable PAE mode for 32-bit guest only when CONFIG_X86_PAE is set
Date: Tue, 23 Apr 2024 20:00:58 +0800
Message-Id: <0469c27833be58aa66471920aa77922489d86c63.1713873613.git.houwenlong.hwl@antgroup.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The PVH entry is available for 32-bit KVM guests, and 32-bit KVM guests
do not depend on CONFIG_X86_PAE. However, mk_early_pgtbl_32() builds
different pagetables depending on whether CONFIG_X86_PAE is set.
Therefore, enabling PAE mode for 32-bit KVM guests without
CONFIG_X86_PAE being set would result in a boot failure during CR3
loading.

Signed-off-by: Hou Wenlong <houwenlong.hwl@antgroup.com>
Reviewed-by: Juergen Gross <jgross@suse.com>
---
v1 -> v2: Add the "Reviewed-by" tag from Juergen
v1: https://lore.kernel.org/lkml/8c5448eeebbba998a7fff9ed9b2f7e7f3e437967.1697792461.git.houwenlong.hwl@antgroup.com
---
 arch/x86/platform/pvh/head.S | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/platform/pvh/head.S b/arch/x86/platform/pvh/head.S
index f7235ef87bc3..18c69d213458 100644
--- a/arch/x86/platform/pvh/head.S
+++ b/arch/x86/platform/pvh/head.S
@@ -71,10 +71,12 @@ SYM_CODE_START_LOCAL(pvh_start_xen)
 
 	mov $_pa(early_stack_end), %esp
 
+#if defined(CONFIG_X86_64) || defined(CONFIG_X86_PAE)
 	/* Enable PAE mode. */
 	mov %cr4, %eax
 	orl $X86_CR4_PAE, %eax
 	mov %eax, %cr4
+#endif
 
 #ifdef CONFIG_X86_64
 	/* Enable Long mode. */
-- 
2.31.1


