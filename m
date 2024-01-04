Return-Path: <linux-kernel+bounces-16448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B29EC823EBA
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 10:34:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 673C61F24359
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 09:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A8A8208BC;
	Thu,  4 Jan 2024 09:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="K3Jo2mzl";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+89tdcqF"
X-Original-To: linux-kernel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB6A2208A8;
	Thu,  4 Jan 2024 09:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 04 Jan 2024 09:34:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1704360875;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m1dzXWXtanidcRqNf7pTgZuB9sg4I7BIsO8RkysnZBw=;
	b=K3Jo2mzlh1Gs6VdSKUEBt4LtQBVZhzHKhk+lGH1oJ8JTxQOwqot9fy4wKZlwP+U59HGCdU
	bomWoxj5ANQLBT0SbxI9ON2v57T7JrHMA5mk+ZrUmie+pGRHMsyzGOWXcI+Q5nd7Xxnt2o
	EN17oJPDYyVr5Q6ChkEp2vsLepMpbFQsfs+TZ8s+z/MsPUltTzreOqNYH51rOgr8rHaWhi
	wb85hQGzKd3pJTO+5LjsBSejdnAF82sIi6dJ+MmLi/k3QtZj9hDmjhYNyEqjieZ09KKoym
	TwLUFlkanPLOwU5TqMPEDp2s+IyPMunWIVnhkSs1mATXyH4ts3n7OWWgr+GRsg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1704360875;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m1dzXWXtanidcRqNf7pTgZuB9sg4I7BIsO8RkysnZBw=;
	b=+89tdcqFGh+FegbQyTYTbSesmePm3gWHWURr+SRydv3MD/FHxethgIgSXbHGWJaRRvypmA
	5IWukeLB/OIZ6CDw==
From: "tip-bot2 for Nathan Chancellor" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/build] x86/tools: objdump_reformat.awk: Skip bad
 instructions from llvm-objdump
Cc: Nathan Chancellor <nathan@kernel.org>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C20231205-objdump=5Freformat-awk-handle-llvm-objdum?=
 =?utf-8?q?p-bad=5Fexpr-v1-1-b4a74f39396f=40kernel=2Eorg=3E?=
References: =?utf-8?q?=3C20231205-objdump=5Freformat-awk-handle-llvm-objdump?=
 =?utf-8?q?-bad=5Fexpr-v1-1-b4a74f39396f=40kernel=2Eorg=3E?=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170436087400.398.10481270651479609667.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/build branch of tip:

Commit-ID:     bcf7ef56daca2eacf836d22eee23c66f7cd96a65
Gitweb:        https://git.kernel.org/tip/bcf7ef56daca2eacf836d22eee23c66f7cd96a65
Author:        Nathan Chancellor <nathan@kernel.org>
AuthorDate:    Tue, 05 Dec 2023 12:53:08 -07:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Thu, 04 Jan 2024 10:04:02 +01:00

x86/tools: objdump_reformat.awk: Skip bad instructions from llvm-objdump

When running the instruction decoder selftest with LLVM=1 and
CONFIG_PVH=y, there is a series of warnings:

  arch/x86/tools/insn_decoder_test: warning: Found an x86 instruction decoder bug, please report this.
  arch/x86/tools/insn_decoder_test: warning: ffffffff81000050     ea                      <unknown>
  arch/x86/tools/insn_decoder_test: warning: objdump says 1 bytes, but insn_get_length() says 7
  arch/x86/tools/insn_decoder_test: warning: Decoded and checked 7214721 instructions with 1 failures

GNU objdump outputs "(bad)" instead of "<unknown>", which is already
handled in the bad_expr regex, so there is no warning.

  $ objdump -d arch/x86/platform/pvh/head.o | grep -E '50:\s+ea'
  50:   ea                      (bad)

  $ llvm-objdump -d arch/x86/platform/pvh/head.o | grep -E '50:\s+ea'
        50: ea                            <unknown>

Add "<unknown>" to the bad_expr regex to clear up the warning, allowing
the instruction decoder selftest to fully pass with llvm-objdump.

Signed-off-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20231205-objdump_reformat-awk-handle-llvm-objdump-bad_expr-v1-1-b4a74f39396f@kernel.org
---
 arch/x86/tools/objdump_reformat.awk | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/tools/objdump_reformat.awk b/arch/x86/tools/objdump_reformat.awk
index a4120d9..20b08a6 100644
--- a/arch/x86/tools/objdump_reformat.awk
+++ b/arch/x86/tools/objdump_reformat.awk
@@ -11,7 +11,7 @@ BEGIN {
 	prev_addr = ""
 	prev_hex = ""
 	prev_mnemonic = ""
-	bad_expr = "(\\(bad\\)|^rex|^.byte|^rep(z|nz)$|^lock$|^es$|^cs$|^ss$|^ds$|^fs$|^gs$|^data(16|32)$|^addr(16|32|64))"
+	bad_expr = "(\\(bad\\)|<unknown>|^rex|^.byte|^rep(z|nz)$|^lock$|^es$|^cs$|^ss$|^ds$|^fs$|^gs$|^data(16|32)$|^addr(16|32|64))"
 	fwait_expr = "^9b[ \t]*fwait"
 	fwait_str="9b\tfwait"
 }

