Return-Path: <linux-kernel+bounces-33595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 314F1836BFD
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 17:55:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F21D1F2542A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A2B55DF03;
	Mon, 22 Jan 2024 15:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="O1jM10gZ"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 243125D8E3
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 15:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705937350; cv=none; b=AIVgum7kP4w6KBU0NzLSrKjW/n0rQKLISlL3y7poBOU6xWR6niQXdvWUf7AVI3EAobMB74C81qc66i5bNe9Tn9hz1I7R7LLsDq2/pomm/FldMjiaUEEx7QI7QJvOh9GcNhV1tQ/3ICZk5z7gM4XNXAKos9Lc9bMBmXBpMwyh2g8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705937350; c=relaxed/simple;
	bh=tqYclGki0Ep8eWqwJNFxv5GiMcJQcDYtapo8Vs1igTo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=aLzPWIOi9OcFYdDIRgsOVcFQdyncqvvbslnc4MvrRt8e93QwHnulk1W/kbnyBoUJbQa91XvgqklBJl2RDG2qAwlPzAbiUzqdqKrelSbSP2IPi/3k2Q4XwZe7agGShjNwppnh6YDs4RkpgyfqZFyC4bx7m/KhOognT6uSIyCPOFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=O1jM10gZ; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1d70b0e521eso23676625ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 07:29:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1705937348; x=1706542148; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7wQcbezNT+/RjXYY8eCSxvRyrPZ4DMIc5I/z5N1RfdQ=;
        b=O1jM10gZo3UnNBaoVLMbSm1Sb1V28mx0KyI4W47mlgMXrEcwQW0jy2B11A3JKIv6Jz
         1/H1aG4p0H4raV99ppfMpAI5RTTrNcde2H5lkCisvHdIo/tQUZh3HDSr2YnowUZmGZ0O
         EffjYKbVBUEtxOFjIPbnGN7v0B8DLFKwe4vcY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705937348; x=1706542148;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7wQcbezNT+/RjXYY8eCSxvRyrPZ4DMIc5I/z5N1RfdQ=;
        b=MVLfOsXCy2vmgWRg0mNA7X845iYvwUtUnkNT5VFglE46rF8E+mrCe0ol38kZ7WYjga
         6l/QRDmnHiYIMvHiGmhfUf/436Zm1oN6/pJtguqdCXWI0W0VDtWpLTNK+LDW6rXeWQgB
         wY6EbRkFfEBPcXzjsd9ZF7zjUev+eVOE5LD8rPoHf0G/tc2yq1+i92WQFShjTEu1O2pe
         rb7tgoHUWfMnh8nxQN12BuIzvrrvD8FQ8RUGiEW5GLUOEF0fStmhL9AZCY8aO4UIpyfd
         /BctF68WzJrTN4aWwW9F5ka8eN33Tj7SKQRHoeI3A9V+oPoMcrlpFTHScXyfgwzUzBbx
         btzw==
X-Gm-Message-State: AOJu0YyJakaty82QXE59GiUKe4eCxXhJUYlqz0REaxYmFZABFDGRqN0L
	PiXI0PK0/uwldoKeA13f8QJ0jYljTteNZRRgafziSMr7O5rTO8+32oJKBy9cDA==
X-Google-Smtp-Source: AGHT+IHZ79GK1aXYnnWb9q7+P5nP9QYQp8e6sdlkbYXp1r4C5vMOT6bSo0SU5Rd+GH1MWjerbZ5/EA==
X-Received: by 2002:a17:902:b702:b0:1d7:57d:2792 with SMTP id d2-20020a170902b70200b001d7057d2792mr4475806pls.103.1705937348244;
        Mon, 22 Jan 2024 07:29:08 -0800 (PST)
Received: from localhost (34.85.168.34.bc.googleusercontent.com. [34.168.85.34])
        by smtp.gmail.com with UTF8SMTPSA id u9-20020a170903124900b001d60a705628sm7285775plh.246.2024.01.22.07.29.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jan 2024 07:29:07 -0800 (PST)
From: jeffxu@chromium.org
To: akpm@linux-foundation.org,
	keescook@chromium.org,
	jannh@google.com,
	sroettger@google.com,
	willy@infradead.org,
	gregkh@linuxfoundation.org,
	torvalds@linux-foundation.org,
	usama.anjum@collabora.com,
	rdunlap@infradead.org
Cc: jeffxu@google.com,
	jorgelo@chromium.org,
	groeck@chromium.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	pedro.falcato@gmail.com,
	dave.hansen@intel.com,
	linux-hardening@vger.kernel.org,
	deraadt@openbsd.org,
	Jeff Xu <jeffxu@chromium.org>
Subject: [PATCH v7 0/4] Introduce mseal()
Date: Mon, 22 Jan 2024 15:28:46 +0000
Message-ID: <20240122152905.2220849-1-jeffxu@chromium.org>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Jeff Xu <jeffxu@chromium.org>

This patchset proposes a new mseal() syscall for the Linux kernel.

In a nutshell, mseal() protects the VMAs of a given virtual memory
range against modifications, such as changes to their permission bits.

Modern CPUs support memory permissions, such as the read/write (RW)
and no-execute (NX) bits. Linux has supported NX since the release of
kernel version 2.6.8 in August 2004 [1]. The memory permission feature
improves the security stance on memory corruption bugs, as an attacker
cannot simply write to arbitrary memory and point the code to it. The
memory must be marked with the X bit, or else an exception will occur.
Internally, the kernel maintains the memory permissions in a data
structure called VMA (vm_area_struct). mseal() additionally protects
the VMA itself against modifications of the selected seal type.

Memory sealing is useful to mitigate memory corruption issues where a
corrupted pointer is passed to a memory management system. For
example, such an attacker primitive can break control-flow integrity
guarantees since read-only memory that is supposed to be trusted can
become writable or .text pages can get remapped. Memory sealing can
automatically be applied by the runtime loader to seal .text and
rodata pages and applications can additionally seal security critical
data at runtime. A similar feature already exists in the XNU kernel
with the VM_FLAGS_PERMANENT [3] flag and on OpenBSD with the
mimmutable syscall [4]. Also, Chrome wants to adopt this feature for
their CFI work [2] and this patchset has been designed to be
compatible with the Chrome use case.

Two system calls are involved in sealing the map:  mmap() and mseal().

The new mseal() is an syscall on 64 bit CPU, and with
following signature:

int mseal(void addr, size_t len, unsigned long flags)
addr/len: memory range.
flags: reserved.

mseal() blocks following operations for the given memory range.

1> Unmapping, moving to another location, and shrinking the size,
   via munmap() and mremap(), can leave an empty space, therefore can
   be replaced with a VMA with a new set of attributes.

2> Moving or expanding a different VMA into the current location,
   via mremap().

3> Modifying a VMA via mmap(MAP_FIXED).

4> Size expansion, via mremap(), does not appear to pose any specific
   risks to sealed VMAs. It is included anyway because the use case is
   unclear. In any case, users can rely on merging to expand a sealed VMA.

5> mprotect() and pkey_mprotect().

6> Some destructive madvice() behaviors (e.g. MADV_DONTNEED) for anonymous
   memory, when users don't have write permission to the memory. Those
   behaviors can alter region contents by discarding pages, effectively a
   memset(0) for anonymous memory.

In addition: mmap() has two related changes.

The PROT_SEAL bit in prot field of mmap(). When present, it marks
the map sealed since creation.

The MAP_SEALABLE bit in the flags field of mmap(). When present, it marks
the map as sealable. A map created without MAP_SEALABLE will not support
sealing, i.e. mseal() will fail.

Applications that don't care about sealing will expect their behavior
unchanged. For those that need sealing support, opt-in by adding
MAP_SEALABLE in mmap().

The idea that inspired this patch comes from Stephen Röttger’s work in
V8 CFI [5]. Chrome browser in ChromeOS will be the first user of this
API.

Indeed, the Chrome browser has very specific requirements for sealing,
which are distinct from those of most applications. For example, in
the case of libc, sealing is only applied to read-only (RO) or
read-execute (RX) memory segments (such as .text and .RELRO) to
prevent them from becoming writable, the lifetime of those mappings
are tied to the lifetime of the process.

Chrome wants to seal two large address space reservations that are
managed by different allocators. The memory is mapped RW- and RWX
respectively but write access to it is restricted using pkeys (or in
the future ARM permission overlay extensions). The lifetime of those
mappings are not tied to the lifetime of the process, therefore, while
the memory is sealed, the allocators still need to free or discard the
unused memory. For example, with madvise(DONTNEED).

However, always allowing madvise(DONTNEED) on this range poses a
security risk. For example if a jump instruction crosses a page
boundary and the second page gets discarded, it will overwrite the
target bytes with zeros and change the control flow. Checking
write-permission before the discard operation allows us to control
when the operation is valid. In this case, the madvise will only
succeed if the executing thread has PKEY write permissions and PKRU
changes are protected in software by control-flow integrity.

Although the initial version of this patch series is targeting the
Chrome browser as its first user, it became evident during upstream
discussions that we would also want to ensure that the patch set
eventually is a complete solution for memory sealing and compatible
with other use cases. The specific scenario currently in mind is
glibc's use case of loading and sealing ELF executables. To this end,
Stephen is working on a change to glibc to add sealing support to the
dynamic linker, which will seal all non-writable segments at startup.
Once this work is completed, all applications will be able to
automatically benefit from these new protections.

In closing, I would like to formally acknowledge the valuable
contributions received during the RFC process, which were instrumental
in shaping this patch:

Jann Horn: raising awareness and providing valuable insights on the
destructive madvise operations.
Linus Torvalds: assisting in defining system call signature and scope.
Pedro Falcato: suggesting sealing in the mmap().
Theo de Raadt: sharing the experiences and insights gained from
implementing mimmutable() in OpenBSD.

Change history:
===============
V7:
- fix index.rst (Randy Dunlap)
- fix arm build (Randy Dunlap)
- return EPERM for blocked operations (Theo de Raadt)

V6:
- Drop RFC from subject, Given Linus's general approval.
- Adjust syscall number for mseal (main Jan.11/2024) 
- Code style fix (Matthew Wilcox)
- selftest: use ksft macros (Muhammad Usama Anjum)
- Document fix. (Randy Dunlap)
https://lore.kernel.org/all/20240111234142.2944934-1-jeffxu@chromium.org/

V5:
- fix build issue in mseal-Wire-up-mseal-syscall
  (Suggested by Linus Torvalds, and Greg KH)
- updates on selftest.
https://lore.kernel.org/lkml/20240109154547.1839886-1-jeffxu@chromium.org/#r

V4:
(Suggested by Linus Torvalds)
- new signature: mseal(start,len,flags)
- 32 bit is not supported. vm_seal is removed, use vm_flags instead.
- single bit in vm_flags for sealed state.
- CONFIG_MSEAL kernel config is removed.
- single bit of PROT_SEAL in the "Prot" field of mmap().
Other changes:
- update selftest (Suggested by Muhammad Usama Anjum)
- update documentation.
https://lore.kernel.org/all/20240104185138.169307-1-jeffxu@chromium.org/

V3:
- Abandon per-syscall approach, (Suggested by Linus Torvalds).
- Organize sealing types around their functionality, such as
  MM_SEAL_BASE, MM_SEAL_PROT_PKEY.
- Extend the scope of sealing from calls originated in userspace to
  both kernel and userspace. (Suggested by Linus Torvalds)
- Add seal type support in mmap(). (Suggested by Pedro Falcato)
- Add a new sealing type: MM_SEAL_DISCARD_RO_ANON to prevent
  destructive operations of madvise. (Suggested by Jann Horn and
  Stephen Röttger)
- Make sealed VMAs mergeable. (Suggested by Jann Horn)
- Add MAP_SEALABLE to mmap()
- Add documentation - mseal.rst
https://lore.kernel.org/linux-mm/20231212231706.2680890-2-jeffxu@chromium.org/

v2:
Use _BITUL to define MM_SEAL_XX type.
Use unsigned long for seal type in sys_mseal() and other functions.
Remove internal VM_SEAL_XX type and convert_user_seal_type().
Remove MM_ACTION_XX type.
Remove caller_origin(ON_BEHALF_OF_XX) and replace with sealing bitmask.
Add more comments in code.
Add a detailed commit message.
https://lore.kernel.org/lkml/20231017090815.1067790-1-jeffxu@chromium.org/

v1:
https://lore.kernel.org/lkml/20231016143828.647848-1-jeffxu@chromium.org/

----------------------------------------------------------------
[1] https://kernelnewbies.org/Linux_2_6_8
[2] https://v8.dev/blog/control-flow-integrity
[3] https://github.com/apple-oss-distributions/xnu/blob/1031c584a5e37aff177559b9f69dbd3c8c3fd30a/osfmk/mach/vm_statistics.h#L274
[4] https://man.openbsd.org/mimmutable.2
[5] https://docs.google.com/document/d/1O2jwK4dxI3nRcOJuPYkonhTkNQfbmwdvxQMyXgeaRHo/edit#heading=h.bvaojj9fu6hc
[6] https://lore.kernel.org/lkml/CAG48ez3ShUYey+ZAFsU2i1RpQn0a5eOs2hzQ426FkcgnfUGLvA@mail.gmail.com/
[7] https://lore.kernel.org/lkml/20230515130553.2311248-1-jeffxu@chromium.org/

Jeff Xu (4):
  mseal: Wire up mseal syscall
  mseal: add mseal syscall
  selftest mm/mseal memory sealing
  mseal:add documentation

 Documentation/userspace-api/index.rst       |    1 +
 Documentation/userspace-api/mseal.rst       |  183 ++
 arch/alpha/kernel/syscalls/syscall.tbl      |    1 +
 arch/arm/tools/syscall.tbl                  |    1 +
 arch/arm64/include/asm/unistd.h             |    2 +-
 arch/arm64/include/asm/unistd32.h           |    2 +
 arch/m68k/kernel/syscalls/syscall.tbl       |    1 +
 arch/microblaze/kernel/syscalls/syscall.tbl |    1 +
 arch/mips/kernel/syscalls/syscall_n32.tbl   |    1 +
 arch/mips/kernel/syscalls/syscall_n64.tbl   |    1 +
 arch/mips/kernel/syscalls/syscall_o32.tbl   |    1 +
 arch/parisc/kernel/syscalls/syscall.tbl     |    1 +
 arch/powerpc/kernel/syscalls/syscall.tbl    |    1 +
 arch/s390/kernel/syscalls/syscall.tbl       |    1 +
 arch/sh/kernel/syscalls/syscall.tbl         |    1 +
 arch/sparc/kernel/syscalls/syscall.tbl      |    1 +
 arch/x86/entry/syscalls/syscall_32.tbl      |    1 +
 arch/x86/entry/syscalls/syscall_64.tbl      |    1 +
 arch/xtensa/kernel/syscalls/syscall.tbl     |    1 +
 include/linux/mm.h                          |   48 +
 include/linux/syscalls.h                    |    1 +
 include/uapi/asm-generic/mman-common.h      |    8 +
 include/uapi/asm-generic/unistd.h           |    5 +-
 kernel/sys_ni.c                             |    1 +
 mm/Makefile                                 |    4 +
 mm/madvise.c                                |   12 +
 mm/mmap.c                                   |   27 +
 mm/mprotect.c                               |   10 +
 mm/mremap.c                                 |   31 +
 mm/mseal.c                                  |  343 ++++
 tools/testing/selftests/mm/.gitignore       |    1 +
 tools/testing/selftests/mm/Makefile         |    1 +
 tools/testing/selftests/mm/mseal_test.c     | 1997 +++++++++++++++++++
 33 files changed, 2690 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/userspace-api/mseal.rst
 create mode 100644 mm/mseal.c
 create mode 100644 tools/testing/selftests/mm/mseal_test.c

-- 
2.43.0.429.g432eaa2c6b-goog


