Return-Path: <linux-kernel+bounces-139593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39E818A04E9
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 02:51:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A50061F252AC
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 00:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED9D69454;
	Thu, 11 Apr 2024 00:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marcan.st header.i=@marcan.st header.b="ylASkj0g"
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ADBB2CA4
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 00:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.63.210.85
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712796696; cv=none; b=u/Dx76mb04o4RsMPbRdwS5wWWYqkDCZ75Cy+Yawjf67OSzc0IhPEgiGzHc3hccxxtfix9dQc12CFdGGFBpWl+EBeWQ0u6Z2w5q7MFtqFr1HFkLWiYS4asXL1ZFGXu7rW/SlZGpsz6TJRS0aYHbXvQ2kjjIj/dt6EJf6qDIJq3dY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712796696; c=relaxed/simple;
	bh=nxya/b7E+A6BVmNU6QddSmRkpeeUmd91NwPZg8zTcWA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=EAbmjKvCZqJmuExht2idWdeRGgLJgT+g//+KkwEkApSw5GM/uGAZfmCQenHyvkvxcDvttz3S5PRbVw5VrNOX9VU4qZWCDafGHsvu7moq6Qmdr3gb0EEQVzsfLEGoVF52Xpm8pYGSVJ2x2ISQV/Qju3ZcabEU+CNe0nLCTK561qE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marcan.st; spf=pass smtp.mailfrom=marcan.st; dkim=pass (2048-bit key) header.d=marcan.st header.i=@marcan.st header.b=ylASkj0g; arc=none smtp.client-ip=212.63.210.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marcan.st
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marcan.st
Received: from [127.0.0.1] (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sendonly@marcansoft.com)
	by mail.marcansoft.com (Postfix) with ESMTPSA id 05645425BB;
	Thu, 11 Apr 2024 00:51:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
	t=1712796690; bh=nxya/b7E+A6BVmNU6QddSmRkpeeUmd91NwPZg8zTcWA=;
	h=From:Subject:Date:To:Cc;
	b=ylASkj0gP/QMhmRNIvwKuEdCIVPxgosdu2BqIWIWtVcA+4sxwIfsCYxeYUd8Oig5A
	 lrgYWXm3bTQWGn+DRkaoCV/0PUOcKJujcyC1l+JpuIF9dnY5DKFXCZP8Mwe29QeDpd
	 vNwZ5LmEox/uyZgWoWP2ioV4Lvx9KnrJM8FNuWGjA+oItbpDBFqFdDWVfkEMNFM61j
	 lN38i36EcHO6GN9i3eAY2BjNe0G936qUWj09l25T7TrGXKtGn+7un5IToz0G3vfUHY
	 64syV6TV2sOkgUf4TNcr/Vu+MZ82LWbf3WJAZd5CavNjnETt9+MLLwnuZNSBssTPmd
	 u3TiC55+C7SWQ==
From: Hector Martin <marcan@marcan.st>
Subject: [PATCH 0/4] arm64: Support the TSO memory model
Date: Thu, 11 Apr 2024 09:51:19 +0900
Message-Id: <20240411-tso-v1-0-754f11abfbff@marcan.st>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAc0F2YC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDE0ND3ZLifN1UC7O0lOTUJEuTJAsloMqCotS0zAqwKdGxtbUA7VNoR1U
 AAAA=
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>
Cc: Zayd Qumsieh <zayd_qumsieh@apple.com>, Justin Lu <ih_justin@apple.com>, 
 Ryan Houdek <Houdek.Ryan@fex-emu.org>, Mark Brown <broonie@kernel.org>, 
 Ard Biesheuvel <ardb@kernel.org>, Mateusz Guzik <mjguzik@gmail.com>, 
 Anshuman Khandual <anshuman.khandual@arm.com>, 
 Oliver Upton <oliver.upton@linux.dev>, Miguel Luis <miguel.luis@oracle.com>, 
 Joey Gouly <joey.gouly@arm.com>, Christoph Paasch <cpaasch@apple.com>, 
 Kees Cook <keescook@chromium.org>, Sami Tolvanen <samitolvanen@google.com>, 
 Baoquan He <bhe@redhat.com>, Joel Granados <j.granados@samsung.com>, 
 Dawei Li <dawei.li@shingroup.cn>, Andrew Morton <akpm@linux-foundation.org>, 
 Florent Revest <revest@chromium.org>, David Hildenbrand <david@redhat.com>, 
 Stefan Roesch <shr@devkernel.io>, Andy Chiu <andy.chiu@sifive.com>, 
 Josh Triplett <josh@joshtriplett.org>, Oleg Nesterov <oleg@redhat.com>, 
 Helge Deller <deller@gmx.de>, Zev Weiss <zev@bewilderbeest.net>, 
 Ondrej Mosnacek <omosnace@redhat.com>, Miguel Ojeda <ojeda@kernel.org>, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Asahi Linux <asahi@lists.linux.dev>, Hector Martin <marcan@marcan.st>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5393; i=marcan@marcan.st;
 h=from:subject:message-id; bh=nxya/b7E+A6BVmNU6QddSmRkpeeUmd91NwPZg8zTcWA=;
 b=owGbwMvMwCUm+yP4NEe/cRLjabUkhjRxE26+LT/3PJ/+89teKROlYJ/0zYWnTohs2sS+jP/Zy
 im7K/9LdJSyMIhxMciKKbI0nug91e05/Zy6asp0mDmsTCBDGLg4BWAib18zMlzcNZ+/2EZF/cKx
 zGbzopnLArb8mlc9szl9bi2H2jb/Fy4M/zNOivxMeZv+2d5YV+jmu167wwYZQlFiB9odJRrC1Rb
 E8AAA
X-Developer-Key: i=marcan@marcan.st; a=openpgp;
 fpr=FC18F00317968B7BE86201CBE22A629A4C515DD5

x86 CPUs implement a stricter memory modern than ARM64 (TSO). For this
reason, x86 emulation on baseline ARM64 systems requires very expensive
memory model emulation. Having hardware that supports this natively is
therefore very attractive. Such hardware, in fact, exists. This series
adds support for userspace to identify when TSO is available and
toggle it on, if supported.

Some ARM64 CPUs intrinsically implement the TSO memory model, while
others expose is as an IMPDEF control. Apple Silicon SoCs are in the
latter category. Using TSO for x86 emulation on chips that support it
has been shown to provide a massive performance boost [1].

Patch 1 introduces the PR_{SET,GET}_MEM_MODEL userspace control, which
is initially not implemented for any architectures.

Patch 2 implements it for CPUs which are known, to the best of my
knowledge, to always implement the TSO memory model unconditionally.
This uses the cpufeature mechanism to only enable this if *all* cores in
the system meet the requirements.

Patch 3 adds the scaffolding necesasry to save/restore the ACTLR_EL1
register across context switches. This register contains IMPDEF flags
related to CPU execution, and on Apple CPUs this is where the runtime
TSO toggle bit is implemented. Other CPUs could conceivably benefit from
this scaffolding if they also use ACTLR_EL1 for things that could
ostensibly be runtime controlled and context-switched. For this to work,
ACTLR_EL1 must have a uniform layout across all cores in the system.

Finally, patch 4 implements PR_{SET,GET}_MEM_MODEL for Apple CPUs by
hooking it up to flip the appropriate ACTLR_EL1 bit when the Apple TSO
feature is detected (on all CPUs, which also implies the uniform
ACTLR_EL1 layout).

This series has been brewing in the downstream Asahi Linux tree for a
while now, and ships to thousands of users. A subset have been using it
with FEX-Emu, which already supports this feature. This rebase on
v6.9-rc1 is only build-tested (all intermediate commits with and without
the config enabled, on ARM64) but I'll update the downstream branch soon
with this version and get it pushed out to users/testers.

The Apple support works on bare metal and *should* work exactly the same
way on macOS VMs (as alluded to by Zayd in his independent submission [3]),
though I haven't personally verified this. KVM support for this is left
for a future patchset.

(Apologies for the large Cc: list; I want to make sure nobody who got
Cced on Zayd's alternate take is left out of this one.) 

[1] https://fex-emu.com/FEX-2306/
[2] https://github.com/AsahiLinux/linux/tree/bits/220-tso
[3] https://lore.kernel.org/lkml/20240410211652.16640-1-zayd_qumsieh@apple.com/

To: Catalin Marinas <catalin.marinas@arm.com>
To: Will Deacon <will@kernel.org>
To: Marc Zyngier <maz@kernel.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: Zayd Qumsieh <zayd_qumsieh@apple.com>
Cc: Justin Lu <ih_justin@apple.com>
Cc: Ryan Houdek <Houdek.Ryan@fex-emu.org>
Cc: Mark Brown <broonie@kernel.org>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Mateusz Guzik <mjguzik@gmail.com>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Oliver Upton <oliver.upton@linux.dev>
Cc: Miguel Luis <miguel.luis@oracle.com>
Cc: Joey Gouly <joey.gouly@arm.com>
Cc: Christoph Paasch <cpaasch@apple.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Sami Tolvanen <samitolvanen@google.com>
Cc: Baoquan He <bhe@redhat.com>
Cc: Joel Granados <j.granados@samsung.com>
Cc: Dawei Li <dawei.li@shingroup.cn>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Florent Revest <revest@chromium.org>
Cc: David Hildenbrand <david@redhat.com>
Cc: Stefan Roesch <shr@devkernel.io>
Cc: Andy Chiu <andy.chiu@sifive.com>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Helge Deller <deller@gmx.de>
Cc: Zev Weiss <zev@bewilderbeest.net>
Cc: Ondrej Mosnacek <omosnace@redhat.com>
Cc: Miguel Ojeda <ojeda@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Cc: Asahi Linux <asahi@lists.linux.dev>

Signed-off-by: Hector Martin <marcan@marcan.st>
---
Hector Martin (4):
      prctl: Introduce PR_{SET,GET}_MEM_MODEL
      arm64: Implement PR_{GET,SET}_MEM_MODEL for always-TSO CPUs
      arm64: Introduce scaffolding to add ACTLR_EL1 to thread state
      arm64: Implement Apple IMPDEF TSO memory model control

 arch/arm64/Kconfig                        | 14 ++++++
 arch/arm64/include/asm/apple_cpufeature.h | 15 +++++++
 arch/arm64/include/asm/cpufeature.h       | 10 +++++
 arch/arm64/include/asm/processor.h        |  3 ++
 arch/arm64/kernel/Makefile                |  3 +-
 arch/arm64/kernel/cpufeature.c            | 11 ++---
 arch/arm64/kernel/cpufeature_impdef.c     | 61 ++++++++++++++++++++++++++
 arch/arm64/kernel/process.c               | 71 +++++++++++++++++++++++++++++++
 arch/arm64/kernel/setup.c                 |  8 ++++
 arch/arm64/tools/cpucaps                  |  2 +
 include/linux/memory_ordering_model.h     | 11 +++++
 include/uapi/linux/prctl.h                |  5 +++
 kernel/sys.c                              | 21 +++++++++
 13 files changed, 229 insertions(+), 6 deletions(-)
---
base-commit: 4cece764965020c22cff7665b18a012006359095
change-id: 20240411-tso-e86fdceb94b8

Best regards,
-- 
Hector Martin <marcan@marcan.st>


