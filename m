Return-Path: <linux-kernel+bounces-127264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3128F8948EB
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 03:48:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFB9A283D71
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 01:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EBCBF9DA;
	Tue,  2 Apr 2024 01:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="B3iyhwRp"
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F2CCD52A;
	Tue,  2 Apr 2024 01:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=72.21.196.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712022468; cv=none; b=vEYqKGDSkbFVcAa/orhlU0nC29kJyTJOd5EVnrygmF4zko31hHc5fc7nFTi1ZrLd47aBP/bTSf+TtfUARk6Kh5fS3VvQM0eGacqPOXLAMqZHnye6nEQjoCNWFK+4kvCPCO0jMPY80QvBlYKCGajvHCgyxJa+5ndG9hzjcODFwYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712022468; c=relaxed/simple;
	bh=byrp57rZFpFTLThv1cyX8/wDPU8rPp83GIPgcwu5g3o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PeSvi11st6fJJbBHVs7PyP0TajgINEgS2oOatHAgi7lXaeAL+1MiYSxlKuNS1LIKsGS+ymTuZDNzwG/2DpClyL0KWgm4fWBBElcsiRFTtyMLm0esopDkFghRhQW6F+PuGmxJE3Gk+Wqy9RwIfSpRo2otzYrgJVcz97pb3y1jjqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=B3iyhwRp; arc=none smtp.client-ip=72.21.196.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1712022468; x=1743558468;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=i4X7K8R3U0XvMmPyqS+IPCIp/zMWFiuyylPYoGweXMQ=;
  b=B3iyhwRpMxrOSqY0qbrSL9K5AvQwNvmOdzRt72NRhQp0Bqw/w/Yd3wGz
   BL22kHTonboLlUTwYGd3RTbtd9PneUS9X4BaLhXug3dWVnnCX6Ksqki6D
   pqRa/664hc5NQBcKVPCpqkTzZMCOBcpzjHzidxqpkdiu2Oq7RugRgEgAA
   8=;
X-IronPort-AV: E=Sophos;i="6.07,173,1708387200"; 
   d="scan'208";a="391962966"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2024 01:47:47 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.38.20:22255]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.7.132:2525] with esmtp (Farcaster)
 id 6f55626c-399e-4a5c-a1dc-3175624daa6b; Tue, 2 Apr 2024 01:47:45 +0000 (UTC)
X-Farcaster-Flow-ID: 6f55626c-399e-4a5c-a1dc-3175624daa6b
Received: from EX19D001UWA003.ant.amazon.com (10.13.138.211) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Tue, 2 Apr 2024 01:47:44 +0000
Received: from u34cccd802f2d52.ant.amazon.com (10.252.141.8) by
 EX19D001UWA003.ant.amazon.com (10.13.138.211) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.28;
 Tue, 2 Apr 2024 01:47:43 +0000
From: Haris Okanovic <harisokn@amazon.com>
To: <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
	<linux-assembly@vger.kernel.org>
CC: <peterz@infradead.org>, Haris Okanovic <harisokn@amazon.com>
Subject: [PATCH 2/3] arm64: add __READ_ONCE_EX()
Date: Mon, 1 Apr 2024 20:47:05 -0500
Message-ID: <20240402014706.3969151-2-harisokn@amazon.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240402014706.3969151-1-harisokn@amazon.com>
References: <20240402014706.3969151-1-harisokn@amazon.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D035UWB001.ant.amazon.com (10.13.138.33) To
 EX19D001UWA003.ant.amazon.com (10.13.138.211)

Perform an exclusive load, which atomically loads a word and arms the
execusive monitor to enable wfe() polling of an address.

Adding this macro in preparation for an arm64 cpuidle driver which
supports a wfe() based polling state.

https://developer.arm.com/documentation/dht0008/a/arm-synchronization-primitives/exclusive-accesses/exclusive-monitors

Signed-off-by: Haris Okanovic <harisokn@amazon.com>
---
 arch/arm64/include/asm/readex.h | 46 +++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)
 create mode 100644 arch/arm64/include/asm/readex.h

diff --git a/arch/arm64/include/asm/readex.h b/arch/arm64/include/asm/readex.h
new file mode 100644
index 000000000000..51963c3107e1
--- /dev/null
+++ b/arch/arm64/include/asm/readex.h
@@ -0,0 +1,46 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Based on arch/arm64/include/asm/rwonce.h
+ *
+ * Copyright (C) 2020 Google LLC.
+ * Copyright (C) 2024 Amazon.com, Inc. or its affiliates.
+ */
+
+#ifndef __ASM_READEX_H
+#define __ASM_READEX_H
+
+#define __LOAD_EX(sfx, regs...) "ldaxr" #sfx "\t" #regs
+
+#define __READ_ONCE_EX(x)						\
+({									\
+	typeof(&(x)) __x = &(x);					\
+	int atomic = 1;							\
+	union { __unqual_scalar_typeof(*__x) __val; char __c[1]; } __u;	\
+	switch (sizeof(x)) {						\
+	case 1:								\
+		asm volatile(__LOAD_EX(b, %w0, %1)			\
+			: "=r" (*(__u8 *)__u.__c)			\
+			: "Q" (*__x) : "memory");			\
+		break;							\
+	case 2:								\
+		asm volatile(__LOAD_EX(h, %w0, %1)			\
+			: "=r" (*(__u16 *)__u.__c)			\
+			: "Q" (*__x) : "memory");			\
+		break;							\
+	case 4:								\
+		asm volatile(__LOAD_EX(, %w0, %1)			\
+			: "=r" (*(__u32 *)__u.__c)			\
+			: "Q" (*__x) : "memory");			\
+		break;							\
+	case 8:								\
+		asm volatile(__LOAD_EX(, %0, %1)			\
+			: "=r" (*(__u64 *)__u.__c)			\
+			: "Q" (*__x) : "memory");			\
+		break;							\
+	default:							\
+		atomic = 0;						\
+	}								\
+	atomic ? (typeof(*__x))__u.__val : (*(volatile typeof(__x))__x);\
+})
+
+#endif
-- 
2.34.1


