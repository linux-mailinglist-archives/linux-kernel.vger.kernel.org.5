Return-Path: <linux-kernel+bounces-2351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB9C3815B74
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 20:50:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6CB4BB21A75
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 19:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1F1632C6B;
	Sat, 16 Dec 2023 19:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="n7WvxKfH"
X-Original-To: linux-kernel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 318FF321B9
	for <linux-kernel@vger.kernel.org>; Sat, 16 Dec 2023 19:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=8Gi4x3Inp2xxLyTPy1lJV9jnNXXCCUrVYWMh7677tSA=; b=n7WvxKfH0MpM2VjSa9rOtaTbAu
	cnOVlkXGSRkE83w90MS9IvndZBoHQd+xan5z0Ac44AQWimTRq2hA/CWtLovV6FxG7/J/5/mBWH12f
	GrDXsxFb1Gvx6gHLCHDURtUAyyBzwpwWkXm4G6JGruJUlRbXynwNHpObsBOlSMCbsDZckGKMkU7hr
	hcG5phmB1QQ+uE+QEa5lOw19WzX63oIWMKbJzoplBIroz/YPDLfmgHAekDTXARs8ibIPRE59V3U9/
	GttyjrkhjeUgJt/yzz1ZoTOhqN5PuCCAQo6mdA3wvF/PdtPeuFE7qwS8HXRP08Fh6pec0lyt03xKJ
	pSxYX2Ug==;
Received: from [50.53.46.231] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rEaft-006eQs-2C;
	Sat, 16 Dec 2023 19:50:13 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org
Subject: [PATCH] x86/insn-eval: fix function param name in get_eff_addr_sib()
Date: Sat, 16 Dec 2023 11:50:13 -0800
Message-ID: <20231216195013.29117-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change "regoff" to "base_offset" in 2 places in the kernel-doc comments to
prevent warnings:

insn-eval.c:1152: warning: Function parameter or member 'base_offset' not described in 'get_eff_addr_sib'
insn-eval.c:1152: warning: Excess function parameter 'regoff' description in 'get_eff_addr_sib'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: x86@kernel.org
---
 arch/x86/lib/insn-eval.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff -- a/arch/x86/lib/insn-eval.c b/arch/x86/lib/insn-eval.c
--- a/arch/x86/lib/insn-eval.c
+++ b/arch/x86/lib/insn-eval.c
@@ -1129,15 +1129,15 @@ static int get_eff_addr_modrm_16(struct
  * get_eff_addr_sib() - Obtain referenced effective address via SIB
  * @insn:	Instruction. Must be valid.
  * @regs:	Register values as seen when entering kernel mode
- * @regoff:	Obtained operand offset, in pt_regs, associated with segment
+ * @base_offset: Obtained operand offset, in pt_regs, associated with segment
  * @eff_addr:	Obtained effective address
  *
  * Obtain the effective address referenced by the SIB byte of @insn. After
  * identifying the registers involved in the indexed, register-indirect memory
  * reference, its value is obtained from the operands in @regs. The computed
  * address is stored @eff_addr. Also, the register operand that indicates the
- * associated segment is stored in @regoff, this parameter can later be used to
- * determine such segment.
+ * associated segment is stored in @base_offset; this parameter can later be
+ * used to determine such segment.
  *
  * Returns:
  *

