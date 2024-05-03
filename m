Return-Path: <linux-kernel+bounces-167099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 351638BA489
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 02:24:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E03F21F23FE1
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 00:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B596363CF;
	Fri,  3 May 2024 00:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="kwM8XMwo"
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5391613D
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 00:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714695822; cv=none; b=U5c2vWTNZPTWyjnTp2JptxjvqElqpxPwmnqgefgirFqwc0ptRNWBrEh+W1aRg7RuWEFyXoaml4VPNnQXSkE0R7121tf5Fc8rWQNGCfG3KF1TKW7cTLE4PtruNxRdBsM8zKjcYfqBG9zy7oqzBE9Yv3g2fYfpxY/SnJbj5gJMPCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714695822; c=relaxed/simple;
	bh=cx7iAJmqJSiS6NJCpKGiGYKfhknQNbrNzE2LXtC9+8M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KDBOnepy2vQxDPOLpBe0BZBrFM8C6NpAYL2QpyMwe+kc0yH3dVw5CH6VGK5LpaI7eM2FT/9EN5ohwIRFME5sS/DDWw7ttSPHScr5zFamH0wGBX7TzY2QucComDX4z7AkCtw6jThfkmopl/GEouN2DaSfbgxD+pIQQs3P5d75ZJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=kwM8XMwo; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=TwhhGJYX8S5isC/qXpdo6M+smqQWbmRemXXOvuWIYPs=; b=kwM8XMwoqP4IbG0+
	0zfWn62s1OSNbxh4YF4B8RdGoTlVfokrYBsIV2RqrmUN9Sxo34stiEMPB4DFCFIV+ZmlRlf0KNQhl
	lj3Be/du6TDKhzddcj1tNl1hiRt8WI8dERlvyTkp52z6LqGqgLjD7o9csEVud+9bFnKBDqTc1+ztR
	jRZnWO4G+gjhzNbBrL0b8uTODfv9ebsHmiEGrNuU8mNtvUDZFrpDoqVkhO4DI6GVjv8F0hShx2Ipc
	3X4i31UON2ywDuyE0V95GDhhZlUh59ILEJW8WZtAWCM8QkOKhZlTv13DwfjkdGf+SF7kumemGuLAA
	V/HAXJSTJKPcnJfAqg==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1s2ghx-004Mi8-1m;
	Fri, 03 May 2024 00:23:25 +0000
From: linux@treblig.org
To: mpe@ellerman.id.au,
	npiggin@gmail.com
Cc: linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH] power: Remove arch specific module bug stuff
Date: Fri,  3 May 2024 01:23:17 +0100
Message-ID: <20240503002317.183500-1-linux@treblig.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

The last function to reference module_bug_list went in 2008's
  commit b9754568ef17 ("powerpc: Remove dead module_find_bug code")
but I don't think that was called since 2006's
  commit 73c9ceab40b1 ("[POWERPC] Generic BUG for powerpc")

Now that the list has gone, I think we can also clean up the bug
entries in mod_arch_specific.

Lightly boot tested.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 arch/powerpc/include/asm/module.h | 5 -----
 arch/powerpc/kernel/module.c      | 2 --
 2 files changed, 7 deletions(-)

diff --git a/arch/powerpc/include/asm/module.h b/arch/powerpc/include/asm/module.h
index a8e2e8339fb7f..300c777cc3075 100644
--- a/arch/powerpc/include/asm/module.h
+++ b/arch/powerpc/include/asm/module.h
@@ -48,11 +48,6 @@ struct mod_arch_specific {
 	unsigned long tramp;
 	unsigned long tramp_regs;
 #endif
-
-	/* List of BUG addresses, source line numbers and filenames */
-	struct list_head bug_list;
-	struct bug_entry *bug_table;
-	unsigned int num_bugs;
 };
 
 /*
diff --git a/arch/powerpc/kernel/module.c b/arch/powerpc/kernel/module.c
index f6d6ae0a16923..8989e069e3aae 100644
--- a/arch/powerpc/kernel/module.c
+++ b/arch/powerpc/kernel/module.c
@@ -17,8 +17,6 @@
 #include <asm/setup.h>
 #include <asm/sections.h>
 
-static LIST_HEAD(module_bug_list);
-
 static const Elf_Shdr *find_section(const Elf_Ehdr *hdr,
 				    const Elf_Shdr *sechdrs,
 				    const char *name)
-- 
2.44.0


