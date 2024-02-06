Return-Path: <linux-kernel+bounces-55507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 50B9384BD85
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 19:55:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82D921C2531F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 18:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78E6513AE9;
	Tue,  6 Feb 2024 18:55:08 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20462134BA;
	Tue,  6 Feb 2024 18:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707245708; cv=none; b=aTnOPkO2P57Ex9XsiBclH8Z+6GQNo7Lzi9HSXScsragEmXN22LEHRkmuoazw3B2RE2y4mLGksg7ED/7Ltl+Vu8GW/Oac4BpaerYBDZ9+RvvndcUNOZMWF2cqNlz2iltw1uRV6kSttNZQKd5Rl9BUhoKGZTvOXch38A8gTEeGLjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707245708; c=relaxed/simple;
	bh=S42Qb/IOsVLqz//aj0//ln1a0A1if9ZOh1Ru54rYsOk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=J8MSGiPnhKdouw4SwyoepVlpl306c9MoOJqL8+L/4/MWkzFkcApC06H8ggddgDg9sf4ipwzyti/DWmRcWtETNHVv5/SP279vyHvGDuOv1xGsJnG+5A7tA57jil86R0ukroNNcZYG/k8eruJa0KzaT/ZZgU45vBO2oP4erroddlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0D44F221BF;
	Tue,  6 Feb 2024 18:55:04 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E230E139D8;
	Tue,  6 Feb 2024 18:55:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id w/hlNIeAwmXWGQAAD6G6ig
	(envelope-from <aporta@suse.de>); Tue, 06 Feb 2024 18:55:03 +0000
From: Andrea della Porta <andrea.porta@suse.com>
To: Jonathan Corbet <corbet@lwn.net>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Andrea della Porta <andrea.porta@suse.com>
Subject: [PATCH] arm64: Add the arm64.no32bit_el0 command line option
Date: Tue,  6 Feb 2024 19:54:59 +0100
Message-ID: <20240206185459.32465-1-andrea.porta@suse.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	dkim=none
X-Spamd-Result: default: False [7.49 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FORGED_SENDER(0.30)[andrea.porta@suse.com,aporta@suse.de];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 R_DKIM_NA(2.20)[];
	 MIME_TRACE(0.00)[0:+];
	 FROM_NEQ_ENVFROM(0.10)[andrea.porta@suse.com,aporta@suse.de];
	 RCVD_TLS_ALL(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: 7.49
X-Rspamd-Queue-Id: 0D44F221BF
X-Spam-Level: *******
X-Spam-Flag: NO
X-Spamd-Bar: +++++++

Introducing the field 'el0' to the idreg-override for register
ID_AA64PFR0_EL1. This field is also aliased to the new kernel
command line option 'arm64.no32bit_el0' as a more recognizable
and mnemonic name to disable the execution of 32 bit userspace
applications (i.e. avoid Aarch32 execution state in EL0) from
kernel command line.

Link: https://lore.kernel.org/r/ZVTleETzfFUchs77@apocalypse
Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 3 +++
 arch/arm64/kernel/idreg-override.c              | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 65731b060e3f..9f962deeef5a 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -433,6 +433,9 @@
 	arm64.nosve	[ARM64] Unconditionally disable Scalable Vector
 			Extension support
 
+	arm64.no32bit_el0 [ARM64] Unconditionally disable the execution of
+			32 bit applications
+
 	ataflop=	[HW,M68k]
 
 	atarimouse=	[HW,MOUSE] Atari Mouse
diff --git a/arch/arm64/kernel/idreg-override.c b/arch/arm64/kernel/idreg-override.c
index e30fd9e32ef3..642cda19e42d 100644
--- a/arch/arm64/kernel/idreg-override.c
+++ b/arch/arm64/kernel/idreg-override.c
@@ -86,6 +86,7 @@ static const struct ftr_set_desc pfr0 __prel64_initconst = {
 	.override	= &id_aa64pfr0_override,
 	.fields		= {
 	        FIELD("sve", ID_AA64PFR0_EL1_SVE_SHIFT, pfr0_sve_filter),
+		FIELD("el0", ID_AA64PFR0_EL1_EL0_SHIFT, NULL),
 		{}
 	},
 };
@@ -197,6 +198,7 @@ static const struct {
 	{ "arm64.nomops",		"id_aa64isar2.mops=0" },
 	{ "arm64.nomte",		"id_aa64pfr1.mte=0" },
 	{ "nokaslr",			"arm64_sw.nokaslr=1" },
+	{ "arm64.no32bit_el0",		"id_aa64pfr0.el0=1" },
 };
 
 static int __init parse_hexdigit(const char *p, u64 *v)
-- 
2.41.0


