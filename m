Return-Path: <linux-kernel+bounces-148410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 76C5B8A8231
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 13:35:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 302D92828BB
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 11:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BF1B13CAB7;
	Wed, 17 Apr 2024 11:35:13 +0000 (UTC)
Received: from out187-22.us.a.mail.aliyun.com (out187-22.us.a.mail.aliyun.com [47.90.187.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE30813342F
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 11:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.187.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713353712; cv=none; b=HNzdFpK7cErIXmDu+Blr1XA49e/JRcOomw9xUBN9U+zviLKx4+BUvcIYzKW9EIF/C29OVz32ytvxIH+pa1f95NnEb8Vb/h54QNux7En1wMZBb3ENOfTx67kRUSPDjFfCrkp/WWos1vZFGYuqYBxclavsyB3ysULTkFXeJ9eMPKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713353712; c=relaxed/simple;
	bh=n14/sySfYPYINuS9vorA4OCr6N3fLDbKH8jedRl4r1w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kZqT1P3upkHYAlCKOKcdgLMxtap23jkMR5OTISp1P0sEW+xRsoDbwLqjSuYoO2TyQf8iXrZzYSpYb/LvoCTam35g/R6WJE6BFGMVCwBQVEeZY4BApbcIVadyOAZoluqZ0AKb6XXGoqqeLBEopbguQRuyu9mcKZho3d6SEAmxP5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com; spf=pass smtp.mailfrom=antgroup.com; arc=none smtp.client-ip=47.90.187.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antgroup.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R431e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018047211;MF=houwenlong.hwl@antgroup.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---.XDVJ19w_1713353690;
Received: from localhost(mailfrom:houwenlong.hwl@antgroup.com fp:SMTPD_---.XDVJ19w_1713353690)
          by smtp.aliyun-inc.com;
          Wed, 17 Apr 2024 19:34:51 +0800
From: "Hou Wenlong" <houwenlong.hwl@antgroup.com>
To: linux-kernel@vger.kernel.org
Cc: "Hou Wenlong" <houwenlong.hwl@antgroup.com>,
  "Xin Li" <xin@zytor.com>,
  "H. Peter Anvin" <hpa@zytor.com>,
  "Andy Lutomirski" <luto@kernel.org>,
  "Thomas Gleixner" <tglx@linutronix.de>,
  "Ingo Molnar" <mingo@redhat.com>,
  "Borislav Petkov" <bp@alien8.de>,
  "Dave Hansen" <dave.hansen@linux.intel.com>,
   <x86@kernel.org>
Subject: [PATCH] x86/fred: Fix incorrect error code printout in fred_bad_type()
Date: Wed, 17 Apr 2024 19:34:25 +0800
Message-Id: <b2a8f0a41449d25240e314a2ddfbf6549511fb04.1713353612.git.houwenlong.hwl@antgroup.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The 'regs->orig_ax' has been invalidated to '-1' in the entry, so in the
printout, fred_bad_type() should use the passed parameter 'error_code'.

Fixes: 14619d912b65 ("x86/fred: FRED entry/exit and dispatch code")
Signed-off-by: Hou Wenlong <houwenlong.hwl@antgroup.com>
---
 arch/x86/entry/entry_fred.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/entry/entry_fred.c b/arch/x86/entry/entry_fred.c
index ac120cbdaaf2..099697ba6e58 100644
--- a/arch/x86/entry/entry_fred.c
+++ b/arch/x86/entry/entry_fred.c
@@ -28,9 +28,9 @@ static noinstr void fred_bad_type(struct pt_regs *regs, unsigned long error_code
 	if (regs->fred_cs.sl > 0) {
 		pr_emerg("PANIC: invalid or fatal FRED event; event type %u "
 			 "vector %u error 0x%lx aux 0x%lx at %04x:%016lx\n",
-			 regs->fred_ss.type, regs->fred_ss.vector, regs->orig_ax,
+			 regs->fred_ss.type, regs->fred_ss.vector, error_code,
 			 fred_event_data(regs), regs->cs, regs->ip);
-		die("invalid or fatal FRED event", regs, regs->orig_ax);
+		die("invalid or fatal FRED event", regs, error_code);
 		panic("invalid or fatal FRED event");
 	} else {
 		unsigned long flags = oops_begin();
@@ -38,10 +38,10 @@ static noinstr void fred_bad_type(struct pt_regs *regs, unsigned long error_code
 
 		pr_alert("BUG: invalid or fatal FRED event; event type %u "
 			 "vector %u error 0x%lx aux 0x%lx at %04x:%016lx\n",
-			 regs->fred_ss.type, regs->fred_ss.vector, regs->orig_ax,
+			 regs->fred_ss.type, regs->fred_ss.vector, error_code,
 			 fred_event_data(regs), regs->cs, regs->ip);
 
-		if (__die("Invalid or fatal FRED event", regs, regs->orig_ax))
+		if (__die("Invalid or fatal FRED event", regs, error_code))
 			sig = 0;
 
 		oops_end(flags, regs, sig);
-- 
2.31.1


