Return-Path: <linux-kernel+bounces-60642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE2308507F4
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 07:24:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD78A2860CB
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 06:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78BB61754A;
	Sun, 11 Feb 2024 06:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OeHMihjG"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F2DA17546
	for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 06:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707632695; cv=none; b=akPeYIzKTpuEoJdCEiAEeywXI/feXdTlOFwP9CruG/LvQrQciq7x72YPaUcsrxqiZRMAijKFNDBFn8jhIS1zT0GikVUfY71yuJigCOzpYqei6OObOskUD8511+hj0NYHkf+VmwWQjyyV4cRRVtC9P95vJKnh5/HA7YIWZZviTPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707632695; c=relaxed/simple;
	bh=TWnmXLjFtf+KqVyj6IgcwqUp+Pq7eD50KiSfsrNZSmg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XcNoCER4wpZpYG7elHo9WrzCuSVVLJF9urj62Q/MrNvia/IAlgZunkChozRjR0ySbubSV399FndUkFr3NkALYmCEm/qIMRMV6oxFefwBXGji6iRxGZt0f1XWVyvMzdQxrSsKVyhiMocpWmH+Z8WK3ZDNEeWfjbCGYkToolg0qac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=OeHMihjG; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=duXlDOFIqmRCHP4x6D44mmwH+nyj5pj32pQL3O49Fd8=; b=OeHMihjGzj7kBEE3fMvKtvr5iQ
	juNNMkHkIKIRSYC307VJqpP/G0RkUWalUUF9uy/dB4mvA1TAAc7tWy/x1L/oK41lXKXY33U0F1PgG
	ycptED8uD/OeuFQroV7dj3TpASLTb+y2eeW4j94QJ4E3sErGsY+qvqde7rIxUB+ZPGwJQtI0xnEAk
	o340f0/S5SJBs85sCmZ8Wjpthvt5OuWJCQaH0C713z2KhfQ/OnH4GigxvdHxNYtQ/9eD9IGfrsYlA
	iW+BbAORJqLMFrdHU4N9AjRhIvS3BwJNEh26gRCfRmKTCnQkxP/FN31CQ36rXvrdanh3VkHavfsZ4
	e2jIXMGw==;
Received: from [50.53.50.0] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rZ3Gm-00000002PCT-2Occ;
	Sun, 11 Feb 2024 06:24:52 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org
Subject: [PATCH v2] x86/insn-eval: fix function param name in get_eff_addr_sib()
Date: Sat, 10 Feb 2024 22:24:52 -0800
Message-ID: <20240211062452.16411-1-rdunlap@infradead.org>
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
v2: rebase & resend

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

