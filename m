Return-Path: <linux-kernel+bounces-136078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 563E689CFD2
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 03:30:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E85B11F229BA
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 01:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F17F2030B;
	Tue,  9 Apr 2024 01:30:02 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA5B23A8CE
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 01:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712626201; cv=none; b=VUKQZIrfRXUV3Cgdv0QL8yCtvr4meUOTGEAbQtGp19IvJ3NFC/6Nqgbo/YOTkwoqW8OD6ludqp7kwkPPTq2jsFd5G6apSylZZ1/RebsBVl9aH/qxmxTUWCNnP0J4od+RH9Qww7f+YIeEpo5BTJyk418uE3iZK3jtOpZAb8dLAK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712626201; c=relaxed/simple;
	bh=xmdnB+OlH189zldRri5hZkoYzs160LsEOPCqB3tJe40=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wxpl97/t3cV4R27giiLtMM4I6kivbfNvVvCBnxzjsQxXnF+cXjfFZOpgj23KTyFak5f4n0hp0s143gjr/iBhcXZI4uLL6v5C3GQzw0DQMbq4qvv0739K9lJW5URaRAgQqUv6zGx7waQtd3dCTvguD7XraIgtj9jyXZq23ek5AGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4VD7cZ4gqFzNnJb;
	Tue,  9 Apr 2024 09:27:42 +0800 (CST)
Received: from kwepemd200013.china.huawei.com (unknown [7.221.188.133])
	by mail.maildlp.com (Postfix) with ESMTPS id 4240618007D;
	Tue,  9 Apr 2024 09:29:57 +0800 (CST)
Received: from huawei.com (10.67.174.28) by kwepemd200013.china.huawei.com
 (7.221.188.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.28; Tue, 9 Apr
 2024 09:29:55 +0800
From: Liao Chang <liaochang1@huawei.com>
To: <catalin.marinas@arm.com>, <will@kernel.org>, <maz@kernel.org>,
	<oliver.upton@linux.dev>, <james.morse@arm.com>, <suzuki.poulose@arm.com>,
	<yuzenghui@huawei.com>, <tglx@linutronix.de>, <mark.rutland@arm.com>,
	<ardb@kernel.org>, <broonie@kernel.org>, <liaochang1@huawei.com>,
	<anshuman.khandual@arm.com>, <miguel.luis@oracle.com>, <joey.gouly@arm.com>,
	<ryan.roberts@arm.com>, <jeremy.linton@arm.com>, <liwei391@huawei.com>,
	<daniel.thompson@linaro.org>, <sumit.garg@linaro.org>,
	<kristina.martsenko@arm.com>, <jpoimboe@kernel.org>, <ericchancf@google.com>,
	<robh@kernel.org>, <scott@os.amperecomputing.com>,
	<songshuaishuai@tinylab.org>, <shijie@os.amperecomputing.com>,
	<bhe@redhat.com>, <akpm@linux-foundation.org>, <thunder.leizhen@huawei.com>,
	<horms@kernel.org>, <rmk+kernel@armlinux.org.uk>, <takakura@valinux.co.jp>,
	<dianders@chromium.org>, <swboyd@chromium.org>, <frederic@kernel.org>,
	<reijiw@google.com>, <akihiko.odaki@daynix.com>, <ruanjinjie@huawei.com>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<kvmarm@lists.linux.dev>
Subject: [PATCH 1/9] arm64/sysreg: Add definitions for immediate versions of MSR ALLINT
Date: Tue, 9 Apr 2024 01:23:36 +0000
Message-ID: <20240409012344.3194724-2-liaochang1@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240409012344.3194724-1-liaochang1@huawei.com>
References: <20240409012344.3194724-1-liaochang1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemd200013.china.huawei.com (7.221.188.133)

From: Mark Brown <broonie@kernel.org>

Encodings are provided for ALLINT which allow setting of ALLINT.ALLINT
using an immediate rather than requiring that a register be loaded with
the value to write. Since these don't currently fit within the scheme we
have for sysreg generation add manual encodings like we currently do for
other similar registers such as SVCR.

Since it is required that these immediate versions be encoded with xzr
as the source register provide asm wrapper which ensure this is the
case.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/include/asm/nmi.h    | 27 +++++++++++++++++++++++++++
 arch/arm64/include/asm/sysreg.h |  2 ++
 2 files changed, 29 insertions(+)
 create mode 100644 arch/arm64/include/asm/nmi.h

diff --git a/arch/arm64/include/asm/nmi.h b/arch/arm64/include/asm/nmi.h
new file mode 100644
index 000000000000..0c566c649485
--- /dev/null
+++ b/arch/arm64/include/asm/nmi.h
@@ -0,0 +1,27 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2022 ARM Ltd.
+ */
+#ifndef __ASM_NMI_H
+#define __ASM_NMI_H
+
+#ifndef __ASSEMBLER__
+
+#include <linux/cpumask.h>
+
+extern bool arm64_supports_nmi(void);
+
+#endif /* !__ASSEMBLER__ */
+
+static __always_inline void _allint_clear(void)
+{
+	asm volatile(__msr_s(SYS_ALLINT_CLR, "xzr"));
+}
+
+static __always_inline void _allint_set(void)
+{
+	asm volatile(__msr_s(SYS_ALLINT_SET, "xzr"));
+}
+
+#endif
+
diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index 9e8999592f3a..b105773c57ca 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -167,6 +167,8 @@
  * System registers, organised loosely by encoding but grouped together
  * where the architected name contains an index. e.g. ID_MMFR<n>_EL1.
  */
+#define SYS_ALLINT_CLR			sys_reg(0, 1, 4, 0, 0)
+#define SYS_ALLINT_SET			sys_reg(0, 1, 4, 1, 0)
 #define SYS_SVCR_SMSTOP_SM_EL0		sys_reg(0, 3, 4, 2, 3)
 #define SYS_SVCR_SMSTART_SM_EL0		sys_reg(0, 3, 4, 3, 3)
 #define SYS_SVCR_SMSTOP_SMZA_EL0	sys_reg(0, 3, 4, 6, 3)
-- 
2.34.1


