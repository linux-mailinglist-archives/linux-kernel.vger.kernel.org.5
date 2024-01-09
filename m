Return-Path: <linux-kernel+bounces-20252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8AF0827C72
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 02:17:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0ACFD1C230C3
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 01:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5873E186C;
	Tue,  9 Jan 2024 01:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="EdZY1ZzG"
Received: from relay.smtp-ext.broadcom.com (unknown [192.19.166.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED3F15AA
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 01:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-lvn-it-01.lvn.broadcom.net (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 4A454C00164C;
	Mon,  8 Jan 2024 17:09:18 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 4A454C00164C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1704762558;
	bh=V4xcLfwSh9yIFBt8S2FOyzIEAI9i04RmDH6sxuuDTC0=;
	h=From:To:Cc:Subject:Date:From;
	b=EdZY1ZzGIhoiU8CdF9jbjPETPcbplglWMdoAav375MT0Kb0j4eoKWG98AJGvgNp6t
	 nViQgZUXJvGTQR9AoskQ/tVyOTbWZXhNJvG3d8ergC/J5aK8n1B7jSmpzey7Y5M8+h
	 D9DnZvbqGGSOaAQg/tfQ5nRrYm6RR8gvmmEVjuPY=
Received: from fainelli-desktop.igp.broadcom.net (fainelli-desktop.dhcp.broadcom.net [10.67.48.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail-lvn-it-01.lvn.broadcom.net (Postfix) with ESMTPSA id BBA2E18041CAC4;
	Mon,  8 Jan 2024 17:09:16 -0800 (PST)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Arnd Bergmann <arnd@arndb.de>,
	"peterz@infradead.org" <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Nhat Pham <nphamcs@gmail.com>,
	Palmer Dabbelt <palmer@sifive.com>,
	Sohil Mehta <sohil.mehta@intel.com>,
	Miklos Szeredi <mszeredi@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	Ian Kent <raven@themaw.net>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] ARM64: Update __NR_compat_syscalls for statmount/listmount
Date: Mon,  8 Jan 2024 17:09:04 -0800
Message-Id: <20240109010906.429652-1-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit d8b0f5465012 ("wire up syscalls for statmount/listmount") added
two new system calls to arch/arm64/include/asm/unistd32.h but forgot to
update the __NR_compat_syscalls number, thus causing the following build
failures:

/arch/arm64/include/asm/unistd32.h:922:24: error: array index in initializer exceeds array bounds
  922 | #define __NR_statmount 457
      |                        ^~~
arch/arm64/kernel/sys32.c:130:34: note: in definition of macro '__SYSCALL'
  130 | #define __SYSCALL(nr, sym)      [nr] = __arm64_##sym,
      |                                  ^~

Bump up the number by two to accomodate for the new system calls added.

Fixes: d8b0f5465012 ("wire up syscalls for statmount/listmount")
Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 arch/arm64/include/asm/unistd.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/unistd.h b/arch/arm64/include/asm/unistd.h
index 531effca5f1f..b63f870debaf 100644
--- a/arch/arm64/include/asm/unistd.h
+++ b/arch/arm64/include/asm/unistd.h
@@ -39,7 +39,7 @@
 #define __ARM_NR_compat_set_tls		(__ARM_NR_COMPAT_BASE + 5)
 #define __ARM_NR_COMPAT_END		(__ARM_NR_COMPAT_BASE + 0x800)
 
-#define __NR_compat_syscalls		457
+#define __NR_compat_syscalls		459
 #endif
 
 #define __ARCH_WANT_SYS_CLONE
-- 
2.34.1


