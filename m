Return-Path: <linux-kernel+bounces-137631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A13289E4CE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 23:11:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE94A284500
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 21:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F175158A14;
	Tue,  9 Apr 2024 21:11:16 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D30D15886D;
	Tue,  9 Apr 2024 21:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712697076; cv=none; b=jS2w6PRcnTJZ/Vags1tudmP5mCBo2J67Xh9yDTk8NHE8QfxvcRRX+TFob+onpxv6NwJagBugTDH4ZKbnsUGY7QcBUyjEj7nc+IvPMjtJXz/U/7vh4wpZFleFVA8btZHMuJvtdBfOXx7yxAVf9jjd82CGlV2t4dwqh7xwfLSB73s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712697076; c=relaxed/simple;
	bh=8L0ERTzAy1BQjOx7mGGCwwAduTWBXdMYWDcECfPN7QY=;
	h=Message-ID:Date:From:To:Cc:Subject; b=FUiICzqKYXokk8KuS4rQs2Em71o0cmbtISei3DaouI4FM659Vxix357kmEpIZGGCzBnTIA2UOdm9I75l7TzDC0llbW2t6OiSTHehC1cTHJ8LnDmQdhZwHKbkf7r9LD5mVxt0BldSQ668dLvVwwfpPrBdXWW4/Z/V6bNfDBIMfk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83FA0C433C7;
	Tue,  9 Apr 2024 21:11:15 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1ruImt-00000000d1d-0Dhi;
	Tue, 09 Apr 2024 17:13:51 -0400
Message-ID: <20240409210254.660888920@goodmis.org>
User-Agent: quilt/0.67
Date: Tue, 09 Apr 2024 17:02:54 -0400
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
Subject: [POC][RFC][PATCH 0/2] pstore/mm/x86: Add wildcard memmap to map pstore consistently
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>


Add wildcard option of reserving physical memory on kernel command line

Background:

In ChromeOS, we have 1 MB of pstore ramoops reserved so that we can extract
dmesg output and some other information when a crash happens in the field.
(This is only done when the user selects "Allow Google to collect data for
 improving the system"). But there are cases when there's a bug that
requires more data to be retrieved to figure out what is happening. We would
like to increase the pstore size, either temporarily, or maybe even
permanently. The pstore on these devices are at a fixed location in RAM (as
the RAM is not cleared on soft reboots nor crashes). The location is chosen
by the BIOS (coreboot) and passed to the kernel via ACPI tables on x86.
There's a driver that queries for this to initialize the pstore for
ChromeOS:

  See drivers/platform/chrome/chromeos_pstore.c

Problem:

The problem is that, even though there's a process to change the kernel on
these systems, and is done regularly to install updates, the firmware is
updated much less frequently. Choosing the place in RAM also takes special
care, and may be in a different address for different boards. Updating the
size via firmware is a large effort and not something that many are willing
to do for a temporary pstore size change.

Requirement:

Need a way to reserve memory that will be at a consistent location for
every boot, if the kernel and system are the same. Does not need to work
if rebooting to a different kernel, or if the system can change the
memory layout between boots.

The reserved memory can not be an hard coded address, as the same kernel /
command line needs to run on several different machines. The picked memory
reservation just needs to be the same for a given machine, but may be
different for different machines.

Solution:

The solution I have come up with is to introduce a new "memmap=" kernel
command line (for x86 and I would like something similar for ARM that uses
device tree). As "memmap=" kernel command line parameter takes on several
flavors already, I would like to introduce a new one. The "memmap=" kernel
parameter is of the format of:

  memmap=nn[Xss]

Where nn is the size, 'X' defines the flavor, and 'ss' usually a parameter
to that flavor. The '$' flavor is to reserve physical memory where you could
have:

  memmap=12M$0xb000000

Where 12 megs of memory will be reserved at the address 0xb0000000. This
memory will not be part of the memory used by the kernel's memory management
system. (e.g. alloc_pages() and kmalloc() will not return memory in that
location).

I would like to introduce a "wildcard" flavor that is of the format:

  memmap=nn*align:label

Where nn is the size of memory to reserve, the align is the alignment of
that memory, and label is the way for other sub-systems to find that memory.
This way the kernel command line could have:


  memmap=12M*4096:oops   ramoops.mem_name=oops

At boot up, the kernel will search for 12 megabytes in usable memory regions
with an alignment of 4096. It will start at the highest regions and work its
way down (for those old devices that want access to lower address DMA). When
it finds a region, it will save it off in a small table and mark it with the
"oops" label. Then the pstore ramoops sub-system could ask for that memory
and location, and it will map itself there.

This prototype allows for 8 different mappings (which may be overkill, 4 is
probably plenty) with 16 byte size to store the label. The table lookup is
only available until boot finishes, which means it is only available for
builtin code and not for modules.

I have tested this and it works for us to solve the above problem. We can
update the kernel and command line and increase the size of pstore without
needing to update the firmware, or knowing every memory layout of each
board. I only tested this locally, it has not been tested in the field. Before
doing anything, I am looking for feedback. Maybe I missed something. Perhaps
there's a better way. Anyway, this is both a Proof of Concept as well as a
Request for Comments.

Thanks!

Steven Rostedt (Google) (2):
      mm/x86: Add wildcard '*' option as memmap=nn*align:name
      pstore/ramoops: Add ramoops.mem_name= command line option

----
 arch/x86/kernel/e820.c | 91 ++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/pstore/ram.c        | 18 ++++++++++
 include/linux/mm.h     |  2 ++
 mm/memory.c            |  7 ++++
 4 files changed, 118 insertions(+)

