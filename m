Return-Path: <linux-kernel+bounces-57363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DCEF184D787
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 02:26:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 764E71F234EE
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 01:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8BD81DFE8;
	Thu,  8 Feb 2024 01:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bewilderbeest.net header.i=@bewilderbeest.net header.b="WE/8Lz4f"
Received: from thorn.bewilderbeest.net (thorn.bewilderbeest.net [71.19.156.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 982781DFC9;
	Thu,  8 Feb 2024 01:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=71.19.156.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707355597; cv=none; b=td1B8pyCURM0Bs9/QwDOuvLIEmpImmlLO57zsx4T6QYfIN9psv0sdW5vVs1PjeVSpXUiEAndZir8gqgTrH2IQMYVzut1b9AMEd7bEEuYG5IdVvGPWiaDA1wbA1oI2im+ljmBVu4dI7QagZJJ+vBzQkmiGeCTUkADeuK3wyP+Tmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707355597; c=relaxed/simple;
	bh=OLe7cAlE7GWmn6Aw0nOYxdFDKvQ+HmBGQMrUtAdT8nM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pbYAdsZJd353StdQ1d4jrmMrmbILiRlVyOfRBYvrgl2tk/aHp3PBMEjQnwOCvfOp2eJvzw8m0VsLtmM/Oy4IHgnTpynlq7Xc/glLkCCyM6fJOm9IUUWat9XZYqSenohIru6SY/hjUfcK7xYw7GEDEYLMPRdv1KRHZxWI4+w5eq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bewilderbeest.net; spf=pass smtp.mailfrom=bewilderbeest.net; dkim=pass (1024-bit key) header.d=bewilderbeest.net header.i=@bewilderbeest.net header.b=WE/8Lz4f; arc=none smtp.client-ip=71.19.156.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bewilderbeest.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bewilderbeest.net
Received: from hatter.bewilderbeest.net (unknown [IPv6:2602:61:712b:6300::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: zev)
	by thorn.bewilderbeest.net (Postfix) with ESMTPSA id 90C25DD9;
	Wed,  7 Feb 2024 17:26:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bewilderbeest.net;
	s=thorn; t=1707355589;
	bh=jCfZxrSPfJRHCvrnkx78xqXBFO8QXL5lwiLPbS+xTAw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WE/8Lz4fbNW5hsXgLypZFn60E7qq3727+grkoIAgUAZO+kPRV+GimPEAfRtWnfs8N
	 BHEObsnhOydmXdgmSyMAojdnhwMYrIFvSnPrwMl8MGW8gyVf330s4rIozE0T5/dEE9
	 47SLwGlLubpXFlRqB6hCTSQk3VHSnmIl2CW0Z4oQ=
From: Zev Weiss <zev@bewilderbeest.net>
To: Russell King <linux@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org
Cc: Zev Weiss <zev@bewilderbeest.net>,
	openbmc@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 2/2] ARM: prctl: Reject PR_SET_MDWE on pre-ARMv6
Date: Wed,  7 Feb 2024 17:26:20 -0800
Message-ID: <20240208012620.32604-6-zev@bewilderbeest.net>
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
2.43.0


