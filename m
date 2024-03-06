Return-Path: <linux-kernel+bounces-93212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A558E872C68
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 02:58:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5201FB24660
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 01:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B5AEDF71;
	Wed,  6 Mar 2024 01:58:15 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D66D29E;
	Wed,  6 Mar 2024 01:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709690294; cv=none; b=hFd1e8WB7c2hUPEQoPacsR7T+MR+SpTPUGpM/CsiR5+KdQTZbmqObGd4ittTSZJ+MMEnHZlQWZItXLpqF/z8tmmP6zA0lDBnkWKJRKbO0Q7vsPqAxrqpEsXSHWtZ37sYyTc1zJtbXxTwZUN20NjEq4Id99oRh4cXv5N2GfbCNVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709690294; c=relaxed/simple;
	bh=em3ZqGZ6YTuBG08XGUyrZRoIgT6NwNqNxuWnOr9k2IA=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=MkShHj9HhTwAS5QYZlqfOso+HForEcRBY4MPYzCmltKHdC+fgyzSkvmXmFXavxVhKFD7FSW0OBJinJbcXa4zRd75X7gGdZBMqI1bwI2fZf45EyvxLB7WUCWXaeZ3U1J+A4yOEVO47+pNKzDLGzuMjgnGVFHqrxTW290GIPtwgXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95FC3C433F1;
	Wed,  6 Mar 2024 01:58:14 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1rhgZi-00000000TBs-0KlB;
	Tue, 05 Mar 2024 21:00:06 -0500
Message-ID: <20240306020005.944149230@goodmis.org>
User-Agent: quilt/0.67
Date: Tue, 05 Mar 2024 20:59:14 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Vincent Donnefort <vdonnefort@google.com>,
 Joel Fernandes <joel@joelfernandes.org>,
 Daniel Bristot de Oliveira <bristot@redhat.com>,
 Ingo Molnar <mingo@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 suleiman@google.com,
 Thomas Gleixner <tglx@linutronix.de>,
 Vineeth Pillai <vineeth@bitbyteword.org>,
 Youssef Esmat <youssefesmat@google.com>,
 Beau Belgrave <beaub@linux.microsoft.com>,
 Alexander Graf <graf@amazon.com>,
 Baoquan He <bhe@redhat.com>,
 Borislav Petkov <bp@alien8.de>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 David Howells <dhowells@redhat.com>
Subject: [PATCH 4/8] HACK: Hard code in mapped tracing buffer address
References: <20240306015910.766510873@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

Do not submit!

This is for testing purposes only. It hard codes an address that I was
using to store the ring buffer range. How the memory actually gets mapped
will be another project.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 arch/x86/kernel/setup.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 84201071dfac..dcba729349d3 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -26,6 +26,8 @@
 #include <linux/swiotlb.h>
 #include <linux/random.h>
 
+#include <linux/trace.h>
+
 #include <uapi/linux/mount.h>
 
 #include <xen/xen.h>
@@ -1106,6 +1108,24 @@ void __init setup_arch(char **cmdline_p)
 	 */
 	arch_reserve_crashkernel();
 
+	trace_buffer_size = 12582912;
+	{
+		phys_addr_t ftrace_addr;
+		unsigned long phys_start = 0x285400000;
+		unsigned long phys_end = phys_start + trace_buffer_size + 1024*1024;
+
+		ftrace_addr = memblock_phys_alloc_range(trace_buffer_size, 4096,
+							phys_start, phys_end);
+		if (ftrace_addr) {
+			printk("MEMORY ALLOC %lx-%lx\n", (long)ftrace_addr,
+			       (long)ftrace_addr + trace_buffer_size);
+			trace_buffer_start = (unsigned long)__va(ftrace_addr);
+			printk("MEMORY ADDR %lx-%lx\n", trace_buffer_start,
+			       trace_buffer_start + trace_buffer_size);
+		} else
+			printk("MEMORY FAILED\n");
+	}
+
 	memblock_find_dma_reserve();
 
 	if (!early_xdbc_setup_hardware())
-- 
2.43.0



