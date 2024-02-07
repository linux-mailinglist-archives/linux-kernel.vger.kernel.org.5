Return-Path: <linux-kernel+bounces-56351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFEB484C914
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 11:59:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E3B4283B46
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 10:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F035A17C95;
	Wed,  7 Feb 2024 10:58:57 +0000 (UTC)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCE3917BCB;
	Wed,  7 Feb 2024 10:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707303537; cv=none; b=UGUbBGZ5Igyo8L7twU6o7wwXySORxxgwbU4FskJ4JqjRZT07f0XnysEBltGuzf2Thsfi15Crc6KFquB0zCuEqpuZWsGKsrg7n3pTXDy02RQLYIScxqiX84DxDdS4Lpqq7iQlWJ0cjn3KVEtVrPn/XJ85Ss2GElDVYwXEkvMlHoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707303537; c=relaxed/simple;
	bh=9yvCHFpFNSKig3GejEmI993BO2VSKfewgD0CXZXnn7s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ivovG6CT0wh5yYxS2goi+VkHZJkxNt9RZ9FJNs77FTi4Kk7f3j+QZYXuXhx7PdQF2zrXCe69mkH0cp85oH7aQ4SsQB+yKml8yzWiDPu4+e39h8nDFKb4zDafCco9UjBsio0DB0Udkcy/IEMAeniffMqE0ZD0DDFvIVDTrImkNRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D6D651F74D;
	Wed,  7 Feb 2024 10:58:53 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BA203139D8;
	Wed,  7 Feb 2024 10:58:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id yOWnKm1iw2WRcAAAD6G6ig
	(envelope-from <aporta@suse.de>); Wed, 07 Feb 2024 10:58:53 +0000
From: Andrea della Porta <andrea.porta@suse.com>
To: Jonathan Corbet <corbet@lwn.net>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Andrea della Porta <andrea.porta@suse.com>
Subject: [PATCH v2] arm64: Add the arm64.no32bit_el0 command line option
Date: Wed,  7 Feb 2024 11:58:47 +0100
Message-ID: <20240207105847.7739-1-andrea.porta@suse.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [10.40 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 BAYES_SPAM(5.10)[100.00%];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FORGED_SENDER(0.30)[andrea.porta@suse.com,aporta@suse.de];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 MIME_TRACE(0.00)[0:+];
	 FROM_NEQ_ENVFROM(0.10)[andrea.porta@suse.com,aporta@suse.de];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Level: **********
X-Spam-Score: 10.40
X-Spam-Flag: NO

Introducing the field 'el0' to the idreg-override for register
ID_AA64PFR0_EL1. This field is also aliased to the new kernel
command line option 'arm64.no32bit_el0' as a more recognizable
and mnemonic name to disable the execution of 32 bit userspace
applications (i.e. avoid Aarch32 execution state in EL0) from
kernel command line.

Changes in V2:
- fixed the order of appearance of arm64.no32bit_el0 entry in
  kernel-parameters.txt documentation.

Link: https://lore.kernel.org/r/ZVTleETzfFUchs77@apocalypse
Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 3 +++
 arch/arm64/kernel/idreg-override.c              | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 65731b060e3f..fa7cdf2f4f3a 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -415,6 +415,9 @@
 	arcrimi=	[HW,NET] ARCnet - "RIM I" (entirely mem-mapped) cards
 			Format: <io>,<irq>,<nodeID>
 
+	arm64.no32bit_el0 [ARM64] Unconditionally disable the execution of
+			32 bit applications
+
 	arm64.nobti	[ARM64] Unconditionally disable Branch Target
 			Identification support
 
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


