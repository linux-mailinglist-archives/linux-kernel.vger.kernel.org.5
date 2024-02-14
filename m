Return-Path: <linux-kernel+bounces-65145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BBB4985488C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 12:38:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEC6A1C22441
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 11:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74B8D1B5B2;
	Wed, 14 Feb 2024 11:37:31 +0000 (UTC)
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 147951C29E;
	Wed, 14 Feb 2024 11:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707910651; cv=none; b=bqEJHgZySoSuTAKiiqmvmIpxIaVWXik7WSzLe7cwXoQe6v9dAsKXXUZC6gWwY6GZGwq8t30nli60MBGkcsW5wfx0IDuyGhCL49mkmJpMa+l6puOWoXcS7884oYn23Jdd01kDfIjFqL6FYOP7NtlaROE8UZTj8m6eYykx6Mwa194=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707910651; c=relaxed/simple;
	bh=6FpxsbhND52y0CgrNgtNyqX/mYBXOyT7iZFZQdqCIHA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tv8FHJDmVK9sZ3mC2JLXIfwWLFTDqoeGIEOegnbQlm9BvsGCnYm8rOFuZJM7sAr4tlcURSi2zjFEOP+wigtdWUqz63flyYhN8Gm2nlfJsJqi+ear33pnzYwrTJy16B5U04rzJxo+OCIbaedUCOfuUr9BQ1u/lpYsKMHbmg2bcZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4TZbPs4VDPz9ynSb;
	Wed, 14 Feb 2024 19:22:09 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id 17E1B1405A0;
	Wed, 14 Feb 2024 19:37:26 +0800 (CST)
Received: from huaweicloud.com (unknown [10.45.156.69])
	by APP1 (Coremail) with SMTP id LxC2BwAHshp7pcxlDJx9Ag--.51624S9;
	Wed, 14 Feb 2024 12:37:25 +0100 (CET)
From: Petr Tesarik <petrtesarik@huaweicloud.com>
To: Jonathan Corbet <corbet@lwn.net>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	"H. Peter Anvin" <hpa@zytor.com>,
	Andy Lutomirski <luto@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Xin Li <xin3.li@intel.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Kees Cook <keescook@chromium.org>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Pengfei Xu <pengfei.xu@intel.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Ze Gao <zegao2021@gmail.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Kai Huang <kai.huang@intel.com>,
	David Woodhouse <dwmw@amazon.co.uk>,
	Brian Gerst <brgerst@gmail.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Joerg Roedel <jroedel@suse.de>,
	"Mike Rapoport (IBM)" <rppt@kernel.org>,
	Tina Zhang <tina.zhang@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	linux-doc@vger.kernel.org (open list:DOCUMENTATION),
	linux-kernel@vger.kernel.org (open list)
Cc: Roberto Sassu <roberto.sassu@huaweicloud.com>,
	petr@tesarici.cz,
	Petr Tesarik <petr.tesarik1@huawei-partners.com>
Subject: [PATCH v1 7/8] sbm: documentation of the x86-64 SandBox Mode implementation
Date: Wed, 14 Feb 2024 12:35:15 +0100
Message-Id: <20240214113516.2307-8-petrtesarik@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240214113516.2307-1-petrtesarik@huaweicloud.com>
References: <20240214113516.2307-1-petrtesarik@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:LxC2BwAHshp7pcxlDJx9Ag--.51624S9
X-Coremail-Antispam: 1UD129KBjvJXoW7Kw1DWF48AFy7GrWDJFWrZrb_yoW8CFWxpa
	4DCas3WF4kJa42v3Z3Jr47ZryrXay8Gr47GFn3G34UJF9Fg34jyryftF1UtayUGryDCa40
	qayjgryxWw4Yy37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUml14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267AKxVW8Jr0_
	Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6x
	IIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_
	Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8c
	xan2IY04v7MxkF7I0Ew4C26cxK6c8Ij28IcwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE
	7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI
	8E67AF67kF1VAFwI0_Wrv_Gr1UMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Gr0_
	Xr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1lIxAIcVCF04k26cxKx2IYs7xG6r
	1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4U
	JbIYCTnIWIevJa73UjIFyTuYvjfUnzVbDUUUU
X-CM-SenderInfo: hshw23xhvd2x3n6k3tpzhluzxrxghudrp/

From: Petr Tesarik <petr.tesarik1@huawei-partners.com>

Add a section about the x86-64 implementation.

Signed-off-by: Petr Tesarik <petr.tesarik1@huawei-partners.com>
---
 Documentation/security/sandbox-mode.rst | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/Documentation/security/sandbox-mode.rst b/Documentation/security/sandbox-mode.rst
index 4405b8858c4a..84816b6b68de 100644
--- a/Documentation/security/sandbox-mode.rst
+++ b/Documentation/security/sandbox-mode.rst
@@ -111,6 +111,31 @@ These hooks must be implemented to select HAVE_ARCH_SBM.
 		:identifiers: arch_sbm_init arch_sbm_destroy arch_sbm_exec
 			      arch_sbm_map_readonly arch_sbm_map_writable
 
+X86_64 Implementation
+=====================
+
+The x86_64 implementation provides strong isolation and recovery from CPU
+exceptions.
+
+Sandbox mode runs in protection ring 3 (same as user mode). This means that:
+
+* sandbox code cannot execute privileged CPU instructions,
+* memory accesses are treated as user accesses.
+
+The thread stack is readable in sandbox mode, because an on-stack data
+structure is used by call helpers and thunks to pass target function
+arguments. However, it is not writable, and sandbox code runs on its own
+stack. The thread stack is not used by interrupt handlers either. Non-IST
+interrupt handlers run on a separate sandbox exception stack.
+
+The interrupt entry path modifies the saved pt_regs to make it appear as
+coming from kernel mode. The CR3 register is then switched to kernel mode.
+The interrupt exit path is modified to restore actual pt_regs and switch the
+CR3 register back to its sandbox mode value, overriding CR3 changes for page
+table isolation.
+
+Support for paravirtualized kernels is not (yet) provided.
+
 Current Limitations
 ===================
 
-- 
2.34.1


