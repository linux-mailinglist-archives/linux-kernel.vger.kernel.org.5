Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C12D7A514D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 19:55:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbjIRRzU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 13:55:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjIRRzT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 13:55:19 -0400
Received: from zproxy1.foxvalley.net (zimbra.foxvalley.net [212.78.26.134])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 596CCDB
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 10:55:13 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zproxy1.foxvalley.net (Postfix) with ESMTP id F410B40ED5;
        Mon, 18 Sep 2023 12:55:11 -0500 (CDT)
Received: from zproxy1.foxvalley.net ([127.0.0.1])
 by localhost (zproxy1.foxvalley.net [127.0.0.1]) (amavis, port 10032)
 with ESMTP id yQ0kNSsyuzew; Mon, 18 Sep 2023 12:55:11 -0500 (CDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zproxy1.foxvalley.net (Postfix) with ESMTP id A2F2D40F14;
        Mon, 18 Sep 2023 12:55:11 -0500 (CDT)
X-Virus-Scanned: amavis at zproxy1.foxvalley.net
Received: from zproxy1.foxvalley.net ([127.0.0.1])
 by localhost (zproxy1.foxvalley.net [127.0.0.1]) (amavis, port 10026)
 with ESMTP id TRsghhA2XIK4; Mon, 18 Sep 2023 12:55:11 -0500 (CDT)
Received: from [192.168.1.3] (unknown [161.97.241.227])
        by zproxy1.foxvalley.net (Postfix) with ESMTPSA id 5319B40ED5;
        Mon, 18 Sep 2023 12:55:11 -0500 (CDT)
Message-ID: <14c27df7-12a3-e432-a741-17672185c092@foxvalley.net>
Date:   Mon, 18 Sep 2023 11:55:10 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Content-Language: en-US
To:     linux-kernel@vger.kernel.org, x86@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com
From:   Dan Raymond <draymond@foxvalley.net>
Subject: [PATCH v1] arch/x86: port I/O tracing on x86
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for port I/O tracing on x86.  Memory mapped I/O tracing is
available on x86 via CONFIG_MMIOTRACE but that relies on page faults
so it doesn't work with port I/O.  This feature uses tracepoints in a
similar manner as CONFIG_TRACE_MMIO_ACCESS.

Signed-off-by: Dan Raymond <draymond@foxvalley.net>
Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 arch/x86/include/asm/shared/io.h | 11 +++++++
 arch/x86/lib/Makefile            |  1 +
 arch/x86/lib/trace_portio.c      | 18 ++++++++++++
 include/trace/events/portio.h    | 49 ++++++++++++++++++++++++++++++++
 4 files changed, 79 insertions(+)
 create mode 100644 arch/x86/lib/trace_portio.c
 create mode 100644 include/trace/events/portio.h

diff --git a/arch/x86/include/asm/shared/io.h b/arch/x86/include/asm/shared/io.h
index c0ef921c0586..e7ef4212e00b 100644
--- a/arch/x86/include/asm/shared/io.h
+++ b/arch/x86/include/asm/shared/io.h
@@ -2,13 +2,23 @@
 #ifndef _ASM_X86_SHARED_IO_H
 #define _ASM_X86_SHARED_IO_H
 
+#include <linux/instruction_pointer.h>
 #include <linux/types.h>
 
+#if defined(CONFIG_TRACEPOINTS) && !defined(BOOT_COMPRESSED_MISC_H) && !defined(BOOT_BOOT_H)
+extern void do_trace_portio_read(u32 value, u16 port, char width, long ip_addr);
+extern void do_trace_portio_write(u32 value, u16 port, char width, long ip_addr);
+#else
+static inline void do_trace_portio_read(u32 value, u16 port, char width, long ip_addr) {}
+static inline void do_trace_portio_write(u32 value, u16 port, char width, long ip_addr) {}
+#endif
+
 #define BUILDIO(bwl, bw, type)						\
 static inline void __out##bwl(type value, u16 port)			\
 {									\
 	asm volatile("out" #bwl " %" #bw "0, %w1"			\
 		     : : "a"(value), "Nd"(port));			\
+	do_trace_portio_write(value, port, #bwl[0], _THIS_IP_);		\
 }									\
 									\
 static inline type __in##bwl(u16 port)					\
@@ -16,6 +26,7 @@ static inline type __in##bwl(u16 port)					\
 	type value;							\
 	asm volatile("in" #bwl " %w1, %" #bw "0"			\
 		     : "=a"(value) : "Nd"(port));			\
+	do_trace_portio_read(value, port, #bwl[0], _THIS_IP_);		\
 	return value;							\
 }
 
diff --git a/arch/x86/lib/Makefile b/arch/x86/lib/Makefile
index f76747862bd2..254f223c025d 100644
--- a/arch/x86/lib/Makefile
+++ b/arch/x86/lib/Makefile
@@ -40,6 +40,7 @@ $(obj)/inat.o: $(obj)/inat-tables.c
 clean-files := inat-tables.c
 
 obj-$(CONFIG_SMP) += msr-smp.o cache-smp.o
+obj-$(CONFIG_TRACEPOINTS) += trace_portio.o
 
 lib-y := delay.o misc.o cmdline.o cpu.o
 lib-y += usercopy_$(BITS).o usercopy.o getuser.o putuser.o
diff --git a/arch/x86/lib/trace_portio.c b/arch/x86/lib/trace_portio.c
new file mode 100644
index 000000000000..443361b460a5
--- /dev/null
+++ b/arch/x86/lib/trace_portio.c
@@ -0,0 +1,18 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+#define CREATE_TRACE_POINTS
+#include <trace/events/portio.h>
+
+void do_trace_portio_read(u32 value, u16 port, char width, long ip_addr)
+{
+	trace_portio_read(value, port, width, ip_addr);
+}
+EXPORT_SYMBOL_GPL(do_trace_portio_read);
+EXPORT_TRACEPOINT_SYMBOL_GPL(portio_read);
+
+void do_trace_portio_write(u32 value, u16 port, char width, long ip_addr)
+{
+	trace_portio_write(value, port, width, ip_addr);
+}
+EXPORT_SYMBOL_GPL(do_trace_portio_write);
+EXPORT_TRACEPOINT_SYMBOL_GPL(portio_write);
diff --git a/include/trace/events/portio.h b/include/trace/events/portio.h
new file mode 100644
index 000000000000..3591a75a475e
--- /dev/null
+++ b/include/trace/events/portio.h
@@ -0,0 +1,49 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM portio
+
+#if !defined(_TRACE_PORTIO_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_PORTIO_H
+
+#include <linux/tracepoint.h>
+
+DECLARE_EVENT_CLASS(portio_class,
+	TP_PROTO(u32 value, u16 port, char width, long ip_addr),
+
+	TP_ARGS(value, port, width, ip_addr),
+
+	TP_STRUCT__entry(
+		__field(u32, value)
+		__field(u16, port)
+		__field(char, width)
+		__field(long, ip_addr)
+	),
+
+	TP_fast_assign(
+		__entry->value = value;
+		__entry->port = port;
+		__entry->width = width;
+		__entry->ip_addr = ip_addr;
+	),
+
+	TP_printk("port=0x%04x value=0x%0*x %pS",
+		__entry->port,
+		__entry->width == 'b' ? 2 :
+		__entry->width == 'w' ? 4 : 8,
+		__entry->value, (void *)__entry->ip_addr)
+);
+
+DEFINE_EVENT(portio_class, portio_read,
+	TP_PROTO(u32 value, u16 port, char width, long ip_addr),
+	TP_ARGS(value, port, width, ip_addr)
+);
+
+DEFINE_EVENT(portio_class, portio_write,
+	TP_PROTO(u32 value, u16 port, char width, long ip_addr),
+	TP_ARGS(value, port, width, ip_addr)
+);
+
+#endif /* _TRACE_PORTIO_H */
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>

base-commit: be8b93b5cc7d533eb8c9b0590cdac055ecafe13a
-- 
2.25.1
