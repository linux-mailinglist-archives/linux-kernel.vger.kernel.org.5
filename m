Return-Path: <linux-kernel+bounces-71633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 803EC85A80D
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 17:02:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 657FB1C21E79
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 16:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B18D93C062;
	Mon, 19 Feb 2024 16:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="biqvwINd"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208CC38F98
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 16:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708358497; cv=none; b=Bx73Mnj0OLGLrCoW32Fpv7RMqbdjF2gtlNoukGCpQpY0yy9zD88cVPysGiJ2KWungnPso7x+wU7E05eIVAF/1+1XFTqRo+aixnthvqFK42apb982vK/FLUwuLR8f7n6zyfTgfHKpvbT7Ph0A2/1P+akrfLmE6jd3+kEEBelfTN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708358497; c=relaxed/simple;
	bh=9rjvz9CM+LavqK3pQR6XiVskqXx8Rp5ZFRE6QcceZfA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DBDhmadKPd3T75inV/9WNkjFBULtNSURGm/rPpPFwSQFHhn6p2e8jysS7zNBqu2TFWLzrdGvwFTx8LXd3WXr5VXheK75HuOxgVWXumZ2Vzm6cdwAziB23pdgqCRdQR1dVVXyp24sUqs7GUuLYu1EzcAoYjSd9kUjN9rBn6LM7Q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=biqvwINd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708358493;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ACYtZtf7H5Q3rQRQKd2B0qBvUBXaYHTjNbsS69NayNU=;
	b=biqvwINdN5ifToadyyxKZVKIqnlLRC/Pok8HfXi75f1H/ZZhMccnHP9WKqac+6jSaAqXhg
	A0wJ03qFsh4vQOz0wEp0jkSeo0dOwh8Fd8FBLy0Wyclvr01CxbtVrpF3AECX+3pZ8cxWJ/
	TWrkIZn1OTpjfkFAQZUEBVppNRTHCMY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-625-N3l74wuWPYC-cgKPtsyPdg-1; Mon, 19 Feb 2024 11:01:30 -0500
X-MC-Unique: N3l74wuWPYC-cgKPtsyPdg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E6980108C063;
	Mon, 19 Feb 2024 16:01:29 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.115])
	by smtp.corp.redhat.com (Postfix) with ESMTP id F098F1121312;
	Mon, 19 Feb 2024 16:01:27 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: linux-m68k@lists.linux-m68k.org,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Ungerer <gerg@linux-m68k.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org,
	Oleg Nesterov <oleg@redhat.com>
Subject: [PATCH v2] m68k: Avoid CONFIG_COLDFIRE switch in uapi header
Date: Mon, 19 Feb 2024 17:01:26 +0100
Message-ID: <20240219160126.510498-1-thuth@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

We should not use any CONFIG switches in uapi headers since these
only work during kernel compilation; they are not defined for
userspace. Fix it by moving the struct pt_regs to the kernel-internal
header instead - struct pt_regs does not seem to be required for
the userspace headers on m68k at all.

Suggested-by: Greg Ungerer <gerg@linux-m68k.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 v2: Move the struct instead of changing the #ifdef

 See previous discussion here:
 https://lore.kernel.org/lkml/6e3f2a2e-2430-4b4f-9ead-d9a4d5e42713@linux-m68k.org/

 arch/m68k/include/asm/ptrace.h      | 29 +++++++++++++++++++++++++++++
 arch/m68k/include/uapi/asm/ptrace.h | 28 ----------------------------
 scripts/headers_install.sh          |  1 -
 3 files changed, 29 insertions(+), 29 deletions(-)

diff --git a/arch/m68k/include/asm/ptrace.h b/arch/m68k/include/asm/ptrace.h
index ea5a80ca1ab33..f200712946603 100644
--- a/arch/m68k/include/asm/ptrace.h
+++ b/arch/m68k/include/asm/ptrace.h
@@ -6,6 +6,35 @@
 
 #ifndef __ASSEMBLY__
 
+/*
+ * This struct defines the way the registers are stored on the
+ * stack during a system call.
+ */
+struct pt_regs {
+	long     d1;
+	long     d2;
+	long     d3;
+	long     d4;
+	long     d5;
+	long     a0;
+	long     a1;
+	long     a2;
+	long     d0;
+	long     orig_d0;
+	long     stkadj;
+#ifdef CONFIG_COLDFIRE
+	unsigned format :  4; /* frame format specifier */
+	unsigned vector : 12; /* vector offset */
+	unsigned short sr;
+	unsigned long  pc;
+#else
+	unsigned short sr;
+	unsigned long  pc;
+	unsigned format :  4; /* frame format specifier */
+	unsigned vector : 12; /* vector offset */
+#endif
+};
+
 #ifndef PS_S
 #define PS_S  (0x2000)
 #define PS_M  (0x1000)
diff --git a/arch/m68k/include/uapi/asm/ptrace.h b/arch/m68k/include/uapi/asm/ptrace.h
index 5b50ea592e002..a83bfe36dd10a 100644
--- a/arch/m68k/include/uapi/asm/ptrace.h
+++ b/arch/m68k/include/uapi/asm/ptrace.h
@@ -24,34 +24,6 @@
 
 #ifndef __ASSEMBLY__
 
-/* this struct defines the way the registers are stored on the
-   stack during a system call. */
-
-struct pt_regs {
-  long     d1;
-  long     d2;
-  long     d3;
-  long     d4;
-  long     d5;
-  long     a0;
-  long     a1;
-  long     a2;
-  long     d0;
-  long     orig_d0;
-  long     stkadj;
-#ifdef CONFIG_COLDFIRE
-  unsigned format :  4; /* frame format specifier */
-  unsigned vector : 12; /* vector offset */
-  unsigned short sr;
-  unsigned long  pc;
-#else
-  unsigned short sr;
-  unsigned long  pc;
-  unsigned format :  4; /* frame format specifier */
-  unsigned vector : 12; /* vector offset */
-#endif
-};
-
 /*
  * This is the extended stack used by signal handlers and the context
  * switcher: it's pushed after the normal "struct pt_regs".
diff --git a/scripts/headers_install.sh b/scripts/headers_install.sh
index f7d9b114de8f7..6bbccb43f7e72 100755
--- a/scripts/headers_install.sh
+++ b/scripts/headers_install.sh
@@ -74,7 +74,6 @@ arch/arc/include/uapi/asm/page.h:CONFIG_ARC_PAGE_SIZE_16K
 arch/arc/include/uapi/asm/page.h:CONFIG_ARC_PAGE_SIZE_4K
 arch/arc/include/uapi/asm/swab.h:CONFIG_ARC_HAS_SWAPE
 arch/arm/include/uapi/asm/ptrace.h:CONFIG_CPU_ENDIAN_BE8
-arch/m68k/include/uapi/asm/ptrace.h:CONFIG_COLDFIRE
 arch/nios2/include/uapi/asm/swab.h:CONFIG_NIOS2_CI_SWAB_NO
 arch/nios2/include/uapi/asm/swab.h:CONFIG_NIOS2_CI_SWAB_SUPPORT
 arch/x86/include/uapi/asm/auxvec.h:CONFIG_IA32_EMULATION
-- 
2.43.2


