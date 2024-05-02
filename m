Return-Path: <linux-kernel+bounces-166799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 583268B9FA4
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 19:38:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13E56282F2E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 17:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15ACC16FF55;
	Thu,  2 May 2024 17:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fI3Oa68C"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B589816FF3C
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 17:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714671507; cv=none; b=AgIqDy07Jqg0Tt9zSJUkzevUhQFUYn+jiXymoDpqZ3LNXSDrK+txPtsqlM2wuX9VacbGquUl/hkF66RJTfOvZjL55UFRcwFn3w/3HArrfbwpkjP6dp81LUyCvSyaxQB8qiQjnvpAns22HzN5igd2wKBP7KkpU9m7//RmiGtPIgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714671507; c=relaxed/simple;
	bh=GvwRPHoxtk/jezrpSCZ86ku2akWlX5bSrTJGDd347OE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cT2spxEiQbG28ZSRZzZotZGIFPUwl+89vIhokwH78BOzDecBUZxslaG7bPoKO5J2f6MTf8vOGwE3JpTvNsK+WK8CaGYTZ5luz0r4rIcoRMzpOE4X/Nx5i9Vet03vI7khpHfKf2aaSjzH3PSc2Zuh/9Le8YYAQGf1JN1hZHLmgpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fI3Oa68C; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714671504;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=3JxNBtIIqVU4bz0zF1ZmAy1QkpyEGqwoMSlvusLpYz4=;
	b=fI3Oa68CFFK2sJQbB9+AtRLIYF5WTY9FU/26GIMHqHz9CKwKTtW5ZZQzDn34KJQwYHUdz0
	K2tHSKnHQNwYU1sfvveZ5e1VX14xN9xFQ88L+rnWaFB5AGxcnMRhKX+ckWIGbHHrbybLqZ
	nUnom3TInsVw4nsCWLj87Is7v/Wr7VU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-272-jV_WCGHFOX6v_SgVPx2G9Q-1; Thu, 02 May 2024 13:38:21 -0400
X-MC-Unique: jV_WCGHFOX6v_SgVPx2G9Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F31D78032FA;
	Thu,  2 May 2024 17:38:20 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.54])
	by smtp.corp.redhat.com (Postfix) with ESMTP id B012DEC682;
	Thu,  2 May 2024 17:38:19 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Brian Cain <bcain@quicinc.com>
Cc: linux-kernel@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	linux-arch@vger.kernel.org,
	linux-hexagon@vger.kernel.org
Subject: [PATCH] hexagon: Move kernel prototypes out of uapi/asm/setup.h header
Date: Thu,  2 May 2024 19:38:18 +0200
Message-ID: <20240502173818.58152-1-thuth@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

The kernel function prototypes are of no use for userspace and
shouldn't get exposed in an uapi header, so let's move them into
an internal header instead.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 arch/hexagon/include/asm/setup.h      | 20 ++++++++++++++++++++
 arch/hexagon/include/uapi/asm/setup.h | 14 ++------------
 2 files changed, 22 insertions(+), 12 deletions(-)
 create mode 100644 arch/hexagon/include/asm/setup.h

diff --git a/arch/hexagon/include/asm/setup.h b/arch/hexagon/include/asm/setup.h
new file mode 100644
index 000000000000..9f2749cd4052
--- /dev/null
+++ b/arch/hexagon/include/asm/setup.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2010-2011, The Linux Foundation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 and
+ * only version 2 as published by the Free Software Foundation.
+ */
+
+#ifndef _ASM_HEXAGON_SETUP_H
+#define _ASM_HEXAGON_SETUP_H
+
+#include <linux/init.h>
+#include <uapi/asm/setup.h>
+
+extern char external_cmdline_buffer;
+
+void __init setup_arch_memory(void);
+
+#endif
diff --git a/arch/hexagon/include/uapi/asm/setup.h b/arch/hexagon/include/uapi/asm/setup.h
index 8ce9428b1583..598f74f671f6 100644
--- a/arch/hexagon/include/uapi/asm/setup.h
+++ b/arch/hexagon/include/uapi/asm/setup.h
@@ -17,19 +17,9 @@
  * 02110-1301, USA.
  */
 
-#ifndef _ASM_SETUP_H
-#define _ASM_SETUP_H
-
-#ifdef __KERNEL__
-#include <linux/init.h>
-#else
-#define __init
-#endif
+#ifndef _UAPI_ASM_HEXAGON_SETUP_H
+#define _UAPI_ASM_HEXAGON_SETUP_H
 
 #include <asm-generic/setup.h>
 
-extern char external_cmdline_buffer;
-
-void __init setup_arch_memory(void);
-
 #endif
-- 
2.44.0


