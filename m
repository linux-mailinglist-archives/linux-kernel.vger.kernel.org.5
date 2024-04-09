Return-Path: <linux-kernel+bounces-137632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 11FED89E4CF
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 23:11:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DAA41F232E5
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 21:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2210158A1B;
	Tue,  9 Apr 2024 21:11:16 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BF6A158871;
	Tue,  9 Apr 2024 21:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712697076; cv=none; b=SM1URxDqrLFbk6agCZYkMaB1VVBEs1zlN3xzUHuyBD16qqcBfihjsTS0Aagkdc3Wvl1niHw6UxmKzNLC4zG39Vs6UodMId2ofyuMAHU/L2hjpWiw0S16moSyRkInhQHNxnVgKMmq3TogqI7aM6ECQDbAvCe3p1UhwL7GOvm21so=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712697076; c=relaxed/simple;
	bh=qjHBmxO19+VYEQPH6eAGJ8GUUULWhDNC6hilZ/5xo2U=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=Iy5l/AixfnZ4h3Dig5iRbQv3aaHucH5I1YU4UzEpvGsJGuYnZi6Jxr84iORZf4CaLiITgdeE278YoaPv6g4VdP5lmNH50XLTUGUKrl1y2HN0+MzDboyMT766wZcB+EElT4e4xPWE98GyW08jz8Zs4oByVaoDdF6IfzHWXQPdvTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A950FC433A6;
	Tue,  9 Apr 2024 21:11:15 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1ruImt-00000000d28-0tuD;
	Tue, 09 Apr 2024 17:13:51 -0400
Message-ID: <20240409211351.075320273@goodmis.org>
User-Agent: quilt/0.67
Date: Tue, 09 Apr 2024 17:02:55 -0400
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
Subject: [POC][RFC][PATCH 1/2] mm/x86: Add wildcard * option as memmap=nn*align:name
References: <20240409210254.660888920@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

In order to allow for requesting a memory region that can be used for
things like pstore on multiple machines where the memory is not the same,
add a new option to the memmap=nn$ kernel command line.

The memmap=nn$addr will reserve nn amount of memory at the physical
address addr. To use this, one must know the physical memory layout and
know where usable memory exists in the physical layout.

Add a '*' option that will assign memory by looking for a range that can
fit the given size and alignment. It will start at the high addresses, and
then work its way down.

The format is:  memmap=nn*align:name

Where it will find nn amount of memory at the given alignment of align.
The name field is to allow another subsystem to retrieve where the memory
was found. For example:

  memmap=12M*4096:oops ramoops.mem_name=oops

Where ramoops.mem_name will tell ramoops that memory was reserved for it
via the wildcard '*' option and it can find it by calling:

  if (memmap_named("oops", &start, &size)) {
	// start holds the start address and size holds the size given

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 arch/x86/kernel/e820.c | 91 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/mm.h     |  2 +
 mm/memory.c            |  7 ++++
 3 files changed, 100 insertions(+)

diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
index 6f1b379e3b38..a8831ef30c73 100644
--- a/arch/x86/kernel/e820.c
+++ b/arch/x86/kernel/e820.c
@@ -64,6 +64,61 @@ struct e820_table *e820_table __refdata			= &e820_table_init;
 struct e820_table *e820_table_kexec __refdata		= &e820_table_kexec_init;
 struct e820_table *e820_table_firmware __refdata	= &e820_table_firmware_init;
 
+/* For wildcard memory requests, have a table to find them later */
+#define E820_MAX_MAPS		8
+#define E820_MAP_NAME_SIZE	16
+struct e820_mmap_map {
+	char			name[E820_MAP_NAME_SIZE];
+	u64			start;
+	u64			size;
+};
+static struct e820_mmap_map e820_mmap_list[E820_MAX_MAPS] __initdata;
+static int e820_mmap_size				__initdata;
+
+/* Add wildcard region with a lookup name */
+static int __init e820_add_mmap(u64 start, u64 size, const char *name)
+{
+	struct e820_mmap_map *map;
+
+	if (!name || !name[0] || strlen(name) >= E820_MAP_NAME_SIZE)
+		return -EINVAL;
+
+	if (e820_mmap_size >= E820_MAX_MAPS)
+		return -1;
+
+	map = &e820_mmap_list[e820_mmap_size++];
+	map->start = start;
+	map->size = size;
+	strcpy(map->name, name);
+	return 0;
+}
+
+/**
+ * memmap_named - Find a wildcard region with a given name
+ * @name: The name that is attached to a wildcard region
+ * @start: If found, holds the start address
+ * @size: If found, holds the size of the address.
+ *
+ * Returns: 1 if found or 0 if not found.
+ */
+int __init memmap_named(const char *name, u64 *start, u64 *size)
+{
+	struct e820_mmap_map *map;
+	int i;
+
+	for (i = 0; i < e820_mmap_size; i++) {
+		map = &e820_mmap_list[i];
+		if (!map->size)
+			continue;
+		if (strcmp(name, map->name) == 0) {
+			*start = map->start;
+			*size = map->size;
+			return 1;
+		}
+	}
+	return 0;
+}
+
 /* For PCI or other memory-mapped resources */
 unsigned long pci_mem_start = 0xaeedbabe;
 #ifdef CONFIG_PCI
@@ -200,6 +255,29 @@ static void __init e820_print_type(enum e820_type type)
 	}
 }
 
+/*
+ * Search for usable ram that can be reserved for a wildcard.
+ * Start at the highest memory and work down to lower memory.
+ */
+static s64 e820__region(u64 size, u64 align)
+{
+	u64 start;
+	int i;
+
+	for (i = e820_table->nr_entries; i >= 0; i--) {
+		if (e820_table->entries[i].type != E820_TYPE_RAM &&
+		    e820_table->entries[i].type != E820_TYPE_RESERVED_KERN)
+			continue;
+
+		start = e820_table->entries[i].addr + e820_table->entries[i].size;
+		start -= size;
+		start = ALIGN_DOWN(start, align);
+		if (start >= e820_table->entries[i].addr)
+			return start;
+	}
+	return -1;
+}
+
 void __init e820__print_table(char *who)
 {
 	int i;
@@ -944,6 +1022,19 @@ static int __init parse_memmap_one(char *p)
 	} else if (*p == '$') {
 		start_at = memparse(p+1, &p);
 		e820__range_add(start_at, mem_size, E820_TYPE_RESERVED);
+	} else if (*p == '*') {
+		u64 align;
+		/* Followed by alignment and ':' then the name */
+		align = memparse(p+1, &p);
+		start_at = e820__region(mem_size, align);
+		if ((s64)start_at < 0)
+			return -EINVAL;
+		if (*p != ':')
+			return -EINVAL;
+		p++;
+		e820_add_mmap(start_at, mem_size, p);
+		p += strlen(p);
+		e820__range_add(start_at, mem_size, E820_TYPE_RESERVED);
 	} else if (*p == '!') {
 		start_at = memparse(p+1, &p);
 		e820__range_add(start_at, mem_size, E820_TYPE_PRAM);
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 0436b919f1c7..cf9b34454c6f 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -4202,4 +4202,6 @@ static inline bool pfn_is_unaccepted_memory(unsigned long pfn)
 	return range_contains_unaccepted_memory(paddr, paddr + PAGE_SIZE);
 }
 
+int memmap_named(const char *name, u64 *start, u64 *size);
+
 #endif /* _LINUX_MM_H */
diff --git a/mm/memory.c b/mm/memory.c
index d2155ced45f8..7a29f17df7c1 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -120,6 +120,13 @@ static bool vmf_orig_pte_uffd_wp(struct vm_fault *vmf)
 	return pte_marker_uffd_wp(vmf->orig_pte);
 }
 
+int __init __weak memmap_named(const char *name, u64 *start, u64 *size)
+{
+	pr_info("Kernel command line: memmap=nn*align:name not supported on this kernel");
+	/* zero means not found */
+	return 0;
+}
+
 /*
  * A number of key systems in x86 including ioremap() rely on the assumption
  * that high_memory defines the upper bound on direct map memory, then end
-- 
2.43.0



