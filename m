Return-Path: <linux-kernel+bounces-82539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3A39868606
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 02:36:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 106EB1C215AD
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 01:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C94E5F9D6;
	Tue, 27 Feb 2024 01:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bewilderbeest.net header.i=@bewilderbeest.net header.b="i8pi9UQD"
Received: from thorn.bewilderbeest.net (thorn.bewilderbeest.net [71.19.156.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA2925695;
	Tue, 27 Feb 2024 01:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=71.19.156.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708997758; cv=none; b=vFDkcYPNklW9ccbNTSrXJe28VF6NUqtWbylXL36VsnisLHF1EW4jfkYrPmNlu+3g1PDbifNybmnnXkjEOIFnXBewmcR9Fz1EGPmQgo6fZE0F5eTtdMxaSxR44UMvywnilji9lsboFJb0V7/Y40toT6sli9801Bvk+lJS30b37Xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708997758; c=relaxed/simple;
	bh=UfJ5aIrJuflIizXwpp3hAJQHhiJ7bqa/sOMnF4kfdBs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IDyNqTiKWqu+EVrZOaP7MIUCcRr7DYdoSSiHgxrwn/Lc0Q/0175HB70l7NjMeMEjxdzagbGXBa5O8uJqjW0LwCiTMmYNPYsii+SzWp5Oue1g+Bufbr0LN7jl6DH5Li4yOZ97WzYGb0RzS0+V8nO77MAlU96vXFo39HwNouzevXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bewilderbeest.net; spf=pass smtp.mailfrom=bewilderbeest.net; dkim=pass (1024-bit key) header.d=bewilderbeest.net header.i=@bewilderbeest.net header.b=i8pi9UQD; arc=none smtp.client-ip=71.19.156.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bewilderbeest.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bewilderbeest.net
Received: from hatter.bewilderbeest.net (unknown [IPv6:2602:61:712b:6300::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: zev)
	by thorn.bewilderbeest.net (Postfix) with ESMTPSA id 70FAB42C7;
	Mon, 26 Feb 2024 17:35:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bewilderbeest.net;
	s=thorn; t=1708997756;
	bh=BpkbZoKcb/ElcmyFvuLHFS6Mz0ozyOSKWVwGl1poh1I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i8pi9UQDl+FTEkyoh7hOS5J5lRGjMIL8a3rV/L92/Ad3dZCdBxJOWKlDIP2Mxec0c
	 LnnIgq4N20v+KoqvA71dCi7nzTaFMc4gZN0pNNwiND5AEDG/ShB0ouziEmHKwtYsxD
	 cZIMb7RFbVGdMffzTaUtGY0JwePwtrzZORnDBQKc=
From: Zev Weiss <zev@bewilderbeest.net>
To: Russell King <linux@armlinux.org.uk>,
	linux-parisc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Helge Deller <deller@gmx.de>,
	Florent Revest <revest@chromium.org>
Cc: Zev Weiss <zev@bewilderbeest.net>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Yin Fengwei <fengwei.yin@intel.com>,
	"Mike Rapoport (IBM)" <rppt@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Kees Cook <keescook@chromium.org>,
	Yang Shi <yang@os.amperecomputing.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Oleg Nesterov <oleg@redhat.com>,
	David Hildenbrand <david@redhat.com>,
	Stefan Roesch <shr@devkernel.io>,
	Josh Triplett <josh@joshtriplett.org>,
	Ondrej Mosnacek <omosnace@redhat.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	linux-kernel@vger.kernel.org,
	openbmc@lists.ozlabs.org,
	Sam James <sam@gentoo.org>,
	stable@vger.kernel.org
Subject: [PATCH RESEND 2/2] ARM: prctl: Reject PR_SET_MDWE on pre-ARMv6
Date: Mon, 26 Feb 2024 17:35:42 -0800
Message-ID: <20240227013546.15769-6-zev@bewilderbeest.net>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240227013546.15769-4-zev@bewilderbeest.net>
References: <20240227013546.15769-4-zev@bewilderbeest.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On v5 and lower CPUs we can't provide MDWE protection, so ensure we
fail any attempt to enable it via prctl(PR_SET_MDWE).

Previously such an attempt would misleadingly succeed, leading to any
subsequent mmap(PROT_READ|PROT_WRITE) or execve() failing
unconditionally (the latter somewhat violently via
force_fatal_sig(SIGSEGV) due to READ_IMPLIES_EXEC).

Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
Cc: <stable@vger.kernel.org> # v6.3+
---
 arch/arm/include/asm/mman.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)
 create mode 100644 arch/arm/include/asm/mman.h

diff --git a/arch/arm/include/asm/mman.h b/arch/arm/include/asm/mman.h
new file mode 100644
index 000000000000..2189e507c8e0
--- /dev/null
+++ b/arch/arm/include/asm/mman.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __ASM_MMAN_H__
+#define __ASM_MMAN_H__
+
+#include <asm/system_info.h>
+#include <uapi/asm/mman.h>
+
+static inline bool arch_memory_deny_write_exec_supported(void)
+{
+	return cpu_architecture() >= CPU_ARCH_ARMv6;
+}
+#define arch_memory_deny_write_exec_supported arch_memory_deny_write_exec_supported
+
+#endif /* __ASM_MMAN_H__ */
-- 
2.43.2


