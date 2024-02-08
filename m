Return-Path: <linux-kernel+bounces-57364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E19AA84D788
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 02:26:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C1691C22CB3
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 01:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0815C1E497;
	Thu,  8 Feb 2024 01:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bewilderbeest.net header.i=@bewilderbeest.net header.b="ONjRy3aH"
Received: from thorn.bewilderbeest.net (thorn.bewilderbeest.net [71.19.156.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 982C91DFD9;
	Thu,  8 Feb 2024 01:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=71.19.156.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707355597; cv=none; b=fCSdHHTF6NyoPPAVnXbCH2M1nn/F3HDIRMclelOx+W1hQhLZ8i3cb2/lHOXtdyz0DoTjYiZp8GFiUmbvbTcaZdt0k/SaRke7qRkZ0PYu/eqMvmyqK/UyJwOP2iDVVvixrv6vbBVSHYFbZvhhLk7x08goPeOylcf/xY5PWP0PPL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707355597; c=relaxed/simple;
	bh=ug8BB4J+brYFbiC3nrhWpCBaYptY56PfygpljvCrZgg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tl9EQyMf4IymLttnFhW7XVTmjZdSzIbc/H/+zNFm79BSOTbJf89M0r9393UsAd1I2kz5eL6InIQL/o1yWDLvGuBxJI8ZT4dQkzvYK2/Gj4OFgqHkJ4ygOAz4dlM4KR2ijpDw9YlkM1LMGGcKpPv/MpO90dun8NI8Z3X+nE+xFBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bewilderbeest.net; spf=pass smtp.mailfrom=bewilderbeest.net; dkim=pass (1024-bit key) header.d=bewilderbeest.net header.i=@bewilderbeest.net header.b=ONjRy3aH; arc=none smtp.client-ip=71.19.156.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bewilderbeest.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bewilderbeest.net
Received: from hatter.bewilderbeest.net (unknown [IPv6:2602:61:712b:6300::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: zev)
	by thorn.bewilderbeest.net (Postfix) with ESMTPSA id ED594D98;
	Wed,  7 Feb 2024 17:26:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bewilderbeest.net;
	s=thorn; t=1707355589;
	bh=3HS5yhO/DTt8/grju8Sqzw88K9FEC/162WIjUF71ihQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ONjRy3aHpvhgvdr/qZopPFDDk9gJT0Cc5cn1ptSvy4EpaL5K7ZCgYTwrWu+Pty3Wb
	 FZJfZ784SCOysGyooOeqod7rgLZS9cjuzJ3WNFHtv5+CQyU9dcdZEKM4TWtPfJaG3N
	 eFGWY8+D/ROgtTNbHFzNbcJwhr2E3vXpCERbyNMI=
From: Zev Weiss <zev@bewilderbeest.net>
To: Helge Deller <deller@gmx.de>,
	linux-parisc@vger.kernel.org,
	Florent Revest <revest@chromium.org>
Cc: Zev Weiss <zev@bewilderbeest.net>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Mike Rapoport (IBM)" <rppt@kernel.org>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Yang Shi <yang@os.amperecomputing.com>,
	Stefan Roesch <shr@devkernel.io>,
	Oleg Nesterov <oleg@redhat.com>,
	David Hildenbrand <david@redhat.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Ondrej Mosnacek <omosnace@redhat.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	openbmc@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Sam James <sam@gentoo.org>,
	stable@vger.kernel.org
Subject: [PATCH 1/2] prctl: Generalize PR_SET_MDWE support check to be per-arch
Date: Wed,  7 Feb 2024 17:26:19 -0800
Message-ID: <20240208012620.32604-5-zev@bewilderbeest.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240208012620.32604-4-zev@bewilderbeest.net>
References: <20240208012620.32604-4-zev@bewilderbeest.net>
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
index e219fcfa112d..8d4bd24fa555 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -2394,8 +2394,11 @@ static inline int prctl_set_mdwe(unsigned long bits, unsigned long arg3,
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
2.43.0


