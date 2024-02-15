Return-Path: <linux-kernel+bounces-67029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 74A46856508
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 14:56:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29B4B1F28EEC
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 13:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBCEA131E21;
	Thu, 15 Feb 2024 13:54:57 +0000 (UTC)
Received: from andre.telenet-ops.be (andre.telenet-ops.be [195.130.132.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 289DE13175A
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 13:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.132.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708005297; cv=none; b=e1D3kft4CEKFKSjbXQdRLCBaQHLWb4Gt5y9NNu3Qhw1fFHOZItOAFuCWIJCyUYi4Ld5hGFA+vtZMga/wF05HXFJMikoHQHIde3uhUSfpXZ1DgQus7mkYdptEcHVifS/ISgJXckn9etmjebP5ZUyenPohY9oVT8UrDeXG4QtvWyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708005297; c=relaxed/simple;
	bh=kjVeQ0gnpy2r4nY0LxRCwKtkhl3CJTCOJ3DRKNTKLYw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Rqv3PCpasAw4lYTYLJvY2g+zx3p3aNvm2A8T5wEuKwEPWhXj8YIV7vJCBb5WTJnhNtBDnAdkvXXT7NtwE/vF6AoRCrPE+cIu2SnOR58V3ttW1yJJDPDMByxZjbuDyLkmq+xa2JqPb2Xb3Tnhg3Pr+7lvV3THXiKm8ELkf4I8G5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.132.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:ac52:3a54:2a84:d65a])
	by andre.telenet-ops.be with bizsmtp
	id nRus2B00J0LVNSS01Rusre; Thu, 15 Feb 2024 14:54:53 +0100
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1racCL-000hBv-8e;
	Thu, 15 Feb 2024 14:54:52 +0100
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1racCS-00Hacm-JG;
	Thu, 15 Feb 2024 14:54:52 +0100
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Oleg Nesterov <oleg@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2] ARM: ptrace: Use bitfield helpers
Date: Thu, 15 Feb 2024 14:54:48 +0100
Message-Id: <f73e6deb1bef9696661a62498ee5a56ac9a389ce.1708005130.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The isa_mode() macro extracts two fields, and recombines them into a
single value.

Make this more obvious by using the FIELD_GET() helper, and shifting the
result into its final resting place.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
No changes in generated assembler code.

v2:
  - Drop irrelevant comment about non-existing off-by-one error,
  - Remove unnecessary parens.
---
 arch/arm/include/asm/ptrace.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/include/asm/ptrace.h b/arch/arm/include/asm/ptrace.h
index 7f44e88d1f25bcc5..14a38cc67e0bc966 100644
--- a/arch/arm/include/asm/ptrace.h
+++ b/arch/arm/include/asm/ptrace.h
@@ -10,6 +10,7 @@
 #include <uapi/asm/ptrace.h>
 
 #ifndef __ASSEMBLY__
+#include <linux/bitfield.h>
 #include <linux/types.h>
 
 struct pt_regs {
@@ -35,8 +36,8 @@ struct svc_pt_regs {
 
 #ifndef CONFIG_CPU_V7M
 #define isa_mode(regs) \
-	((((regs)->ARM_cpsr & PSR_J_BIT) >> (__ffs(PSR_J_BIT) - 1)) | \
-	 (((regs)->ARM_cpsr & PSR_T_BIT) >> (__ffs(PSR_T_BIT))))
+	(FIELD_GET(PSR_J_BIT, (regs)->ARM_cpsr) << 1 | \
+	 FIELD_GET(PSR_T_BIT, (regs)->ARM_cpsr))
 #else
 #define isa_mode(regs) 1 /* Thumb */
 #endif
-- 
2.34.1


