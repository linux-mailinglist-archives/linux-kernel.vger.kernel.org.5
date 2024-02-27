Return-Path: <linux-kernel+bounces-82538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D8E2D868604
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 02:36:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14B0D1C21C0B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 01:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51C55E56E;
	Tue, 27 Feb 2024 01:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bewilderbeest.net header.i=@bewilderbeest.net header.b="AxLlMvyX"
Received: from thorn.bewilderbeest.net (thorn.bewilderbeest.net [71.19.156.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EADF53A7;
	Tue, 27 Feb 2024 01:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=71.19.156.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708997757; cv=none; b=BBd6brvpNXgobFymLQhG/dF4YcvgHaL2tpZP3ihWqJYzjYH3vgHiunkkChq9Sd2K1LKIk5SOCbRoc5UItKjR+1Ivxzglb+f5iDoIrGJxmVBVVnc0yjL1fl/6iy6iLTfavduDb2d4NohMI8BHiFPZaZBo9s80LpljsHm+GR5qWpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708997757; c=relaxed/simple;
	bh=cskhCraRLUN/8AG+y2v+YigFt0ecsFqLjy2QTRPHqrE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dvEP0PRnTBtXYUFXuk2i4YYa+7hQclkO1v0HC9N90V4+K8JssQ1Q5Cgn77kTv9+8ZIiT89ghwFoS37+FWxklBTRyawh2tlSBPr/sp3H48XbVYthOnt9NtnKwtDXznUpGYrakUxSaANFvbbT/7hZdzPKhm7pPWO3PqSSAeo28jvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bewilderbeest.net; spf=pass smtp.mailfrom=bewilderbeest.net; dkim=pass (1024-bit key) header.d=bewilderbeest.net header.i=@bewilderbeest.net header.b=AxLlMvyX; arc=none smtp.client-ip=71.19.156.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bewilderbeest.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bewilderbeest.net
Received: from hatter.bewilderbeest.net (unknown [IPv6:2602:61:712b:6300::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: zev)
	by thorn.bewilderbeest.net (Postfix) with ESMTPSA id BAB8642BE;
	Mon, 26 Feb 2024 17:35:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bewilderbeest.net;
	s=thorn; t=1708997755;
	bh=djflHMn74Aoza7I3oyPhQDEGULANvQSmtPsfFrwIYIA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AxLlMvyXHvt14ldDBhIa4S0wWMk7ibuO9rV2OF7ak9xXdpCJTaFgDzP64nK/sv6Gm
	 Fowrni/G+U1w2BihQcqwfrtfhR1BA4Cl1XVSXbu659qFAh+yQDK1nNCqPM1hssMDdE
	 bWpi/y082Tr2j+A0xZ8/9iE6fD6FJJPTY1hpF18o=
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
Subject: [PATCH RESEND 1/2] prctl: Generalize PR_SET_MDWE support check to be per-arch
Date: Mon, 26 Feb 2024 17:35:41 -0800
Message-ID: <20240227013546.15769-5-zev@bewilderbeest.net>
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

There exist systems other than PARISC where MDWE may not be feasible
to support; rather than cluttering up the generic code with additional
arch-specific logic let's add a generic function for checking MDWE
support and allow each arch to override it as needed.

Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
Cc: <stable@vger.kernel.org> # v6.3+
---
 arch/parisc/include/asm/mman.h | 14 ++++++++++++++
 include/linux/mman.h           |  8 ++++++++
 kernel/sys.c                   |  7 +++++--
 3 files changed, 27 insertions(+), 2 deletions(-)
 create mode 100644 arch/parisc/include/asm/mman.h

diff --git a/arch/parisc/include/asm/mman.h b/arch/parisc/include/asm/mman.h
new file mode 100644
index 000000000000..47c5a1991d10
--- /dev/null
+++ b/arch/parisc/include/asm/mman.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __ASM_MMAN_H__
+#define __ASM_MMAN_H__
+
+#include <uapi/asm/mman.h>
+
+/* PARISC cannot allow mdwe as it needs writable stacks */
+static inline bool arch_memory_deny_write_exec_supported(void)
+{
+	return false;
+}
+#define arch_memory_deny_write_exec_supported arch_memory_deny_write_exec_supported
+
+#endif /* __ASM_MMAN_H__ */
diff --git a/include/linux/mman.h b/include/linux/mman.h
index dc7048824be8..bcb201ab7a41 100644
--- a/include/linux/mman.h
+++ b/include/linux/mman.h
@@ -162,6 +162,14 @@ calc_vm_flag_bits(unsigned long flags)
 
 unsigned long vm_commit_limit(void);
 
+#ifndef arch_memory_deny_write_exec_supported
+static inline bool arch_memory_deny_write_exec_supported(void)
+{
+	return true;
+}
+#define arch_memory_deny_write_exec_supported arch_memory_deny_write_exec_supported
+#endif
+
 /*
  * Denies creating a writable executable mapping or gaining executable permissions.
  *
diff --git a/kernel/sys.c b/kernel/sys.c
index f8e543f1e38a..8bb106a56b3a 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -2408,8 +2408,11 @@ static inline int prctl_set_mdwe(unsigned long bits, unsigned long arg3,
 	if (bits & PR_MDWE_NO_INHERIT && !(bits & PR_MDWE_REFUSE_EXEC_GAIN))
 		return -EINVAL;
 
-	/* PARISC cannot allow mdwe as it needs writable stacks */
-	if (IS_ENABLED(CONFIG_PARISC))
+	/*
+	 * EOPNOTSUPP might be more appropriate here in principle, but
+	 * existing userspace depends on EINVAL specifically.
+	 */
+	if (!arch_memory_deny_write_exec_supported())
 		return -EINVAL;
 
 	current_bits = get_current_mdwe();
-- 
2.43.2


