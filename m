Return-Path: <linux-kernel+bounces-137630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7386689E4CD
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 23:11:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 277B6284464
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 21:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55992158A08;
	Tue,  9 Apr 2024 21:11:16 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D982905;
	Tue,  9 Apr 2024 21:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712697075; cv=none; b=CLii9lW3Z3MTOFyLAE96hkSgzG2lLA0GW08xdMHN3LBOYGkJJdCnI93N7sFartalOzomy87K2fj+1Q05EFEIf60hOQpOxGDnrVnzvurV5c3gBsKlaMuKyIsH7cp8hnRRt7to6kGzO+0fPszx5/rPPA/1gt69DeO4Rx5BnSPOShI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712697075; c=relaxed/simple;
	bh=ElVDNmYvP/wbcQKWFCeHfImQrTWe9WSMoe1E90/HAHY=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=rOqHv2AXLYXo1rmjNx5BMSAUPxTUBtn/9uIR9lgLUHj8IJ/k/zV0v/cob4CnL3uob4yVpCKOhe6xsa3Yp86w3EP7A7hGN2TX+ngPqQhnPb+TlNFVgKnNfzeS7yrAYSjjfCuXH3qCkbZ+l1ow++zdqhdpFktLViQGFFopA9Yg2KY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB506C43399;
	Tue,  9 Apr 2024 21:11:15 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1ruImt-00000000d2d-1ZXv;
	Tue, 09 Apr 2024 17:13:51 -0400
Message-ID: <20240409211351.234897475@goodmis.org>
User-Agent: quilt/0.67
Date: Tue, 09 Apr 2024 17:02:56 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>,
 Lorenzo Stoakes <lstoakes@gmail.com>,
 linux-mm@kvack.org,
 Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Kees Cook <keescook@chromium.org>,
 Tony Luck <tony.luck@intel.com>,
 "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
 linux-hardening@vger.kernel.org,
 Guenter Roeck <linux@roeck-us.net>,
 Ross Zwisler <zwisler@google.com>,
 wklin@google.com,
 Vineeth Remanan Pillai <vineeth@bitbyteword.org>,
 Joel Fernandes <joel@joelfernandes.org>,
 Suleiman Souhlal <suleiman@google.com>,
 Linus Torvalds <torvalds@linuxfoundation.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>
Subject: [POC][RFC][PATCH 2/2] pstore/ramoops: Add ramoops.mem_name= command line option
References: <20240409210254.660888920@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

Add a method to find a region specified by memmap=nn*align:name for
ramoops. Adding a kernel command line parameter:

  memmap=12M*4096:oops ramoops.mem_name=oops

Will use the size and location defined by the memmap parameter where it
finds the memory and labels it "oops". The "oops" in the ramoops option
is used to search for it.

This allows for arbitrary RAM to be used for ramoops if it is known that
the memory is not cleared on kernel crashes or soft reboots.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 fs/pstore/ram.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/fs/pstore/ram.c b/fs/pstore/ram.c
index b1a455f42e93..c200388399fb 100644
--- a/fs/pstore/ram.c
+++ b/fs/pstore/ram.c
@@ -50,6 +50,11 @@ module_param_hw(mem_address, ullong, other, 0400);
 MODULE_PARM_DESC(mem_address,
 		"start of reserved RAM used to store oops/panic logs");
 
+static char *mem_name;
+module_param_named(mem_name, mem_name, charp, 0400);
+MODULE_PARM_DESC(mem_name,
+		"name of kernel param that holds addr (builtin only)");
+
 static ulong mem_size;
 module_param(mem_size, ulong, 0400);
 MODULE_PARM_DESC(mem_size,
@@ -914,6 +919,19 @@ static void __init ramoops_register_dummy(void)
 {
 	struct ramoops_platform_data pdata;
 
+#ifndef MODULE
+	/* Only allowed when builtin */
+	if (mem_name) {
+		u64 start;
+		u64 size;
+
+		if (memmap_named(mem_name, &start, &size)) {
+			mem_address = start;
+			mem_size = size;
+		}
+	}
+#endif
+
 	/*
 	 * Prepare a dummy platform data structure to carry the module
 	 * parameters. If mem_size isn't set, then there are no module
-- 
2.43.0



