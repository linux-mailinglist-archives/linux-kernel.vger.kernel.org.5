Return-Path: <linux-kernel+bounces-69094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 81231858467
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 18:44:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 184991F226C9
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 17:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 971F3136640;
	Fri, 16 Feb 2024 17:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Bnt1BzpK"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 949751353E2;
	Fri, 16 Feb 2024 17:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708105365; cv=none; b=mvyG3Q7GLv554GhLXSTdYHpqZHLv4QGaspUtQ4WjhbHclR1bxdcrjRwrwSNRHDTD3VNR2nzfVsoURx1ABWwTSPKJvRlabxooqy12jyS3Knapp/Ao4iYgHUPWt3iK107RQrs95ixuSf9xy/LlFgx3Bzsr5ibYw7fXbw/WM329tdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708105365; c=relaxed/simple;
	bh=1MQtowLsqNnUAtF7k2m7ABSUA8raDS+7g0jCaM4jd/8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IVt2H8RspuLD2Qy4MtJ9AulB8QWgNHlXn0vl0gs1b6j05oxN7Brhqu0LH1c/X9Fu+yWp/uHuOw3I9ZUYO6YWlKydJlL0B7105j6NbpScjBaYcmndt1tpXVBwIilu3qUJsEEw0vj1PiHMCozEoFyruYO/BbWeKUaKHwtE2AHdlOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Bnt1BzpK; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 536F2240002;
	Fri, 16 Feb 2024 17:42:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708105361;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bQ4JZ6IQLu/PlyZzbHme0fXEJFmS6Qd3821XRXAYit4=;
	b=Bnt1BzpKaZvhFgM9qnJiViQlFu22FurjerkDxdon4W6SuFwXs25VRhtTK+JbP2FpppOjkB
	IZnKtBB9Dk2VvtGLig+xQpu9ZlLClxOaRX25I32URFCJZxaFex23GS/P1PmVn79w5IhHUI
	67JUsglDUIQ54lqCF/csfOkXBv3lwnsfUX0smiJCL8r2MW5/Sn6mwjpdY0MHQK1lTg/PWI
	n6Avq63EWLfnZ5hqvBpTKZYe8J3iKW9pkIVw8ROsNgaAVW8YzDdzoe0nRIgox3glBBPenp
	hxnqdql32MsE+g1ukbD1EKabFVR2bwR90hqVLJmW+m6zJemr56dGS8ofjBGKxA==
From: Gregory CLEMENT <gregory.clement@bootlin.com>
To: Paul Burton <paulburton@kernel.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	linux-mips@vger.kernel.org,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Vladimir  Kondratiev <vladimir.kondratiev@mobileye.com>,
	Tawfik Bayouk <tawfik.bayouk@mobileye.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	=?UTF-8?q?Th=C3=A9o=20Lebrun?= <theo.lebrun@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Gregory CLEMENT <gregory.clement@bootlin.com>
Subject: [PATCH v8 12/14] MIPS: Share generic kernel code with other architecture
Date: Fri, 16 Feb 2024 18:42:21 +0100
Message-ID: <20240216174227.409400-13-gregory.clement@bootlin.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240216174227.409400-1-gregory.clement@bootlin.com>
References: <20240216174227.409400-1-gregory.clement@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: gregory.clement@bootlin.com

Some architectures might seek to utilize a significant portion of the
generic kernel code while maintaining independence from the generic
kernel due to specific peculiarities.

This patch allows for the reuse of core code, preventing unnecessary
duplication.

Suggested-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Reviewed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
---
 arch/mips/Kbuild           | 1 +
 arch/mips/Kconfig          | 3 +++
 arch/mips/generic/Makefile | 6 +++---
 3 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/mips/Kbuild b/arch/mips/Kbuild
index e2d623621a00e..e901bf554483b 100644
--- a/arch/mips/Kbuild
+++ b/arch/mips/Kbuild
@@ -11,6 +11,7 @@ obj- := $(platform-y)
 # mips object files
 # The object files are linked as core-y files would be linked
 
+obj-y += generic/
 obj-y += kernel/
 obj-y += mm/
 obj-y += net/
diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 797ae590ebdba..5549d26448941 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -109,6 +109,9 @@ config MIPS_FIXUP_BIGPHYS_ADDR
 config MIPS_GENERIC
 	bool
 
+config MACH_GENERIC_CORE
+	bool
+
 config MACH_INGENIC
 	bool
 	select SYS_SUPPORTS_32BIT_KERNEL
diff --git a/arch/mips/generic/Makefile b/arch/mips/generic/Makefile
index e37a59bae0a62..56011d738441f 100644
--- a/arch/mips/generic/Makefile
+++ b/arch/mips/generic/Makefile
@@ -4,9 +4,9 @@
 # Author: Paul Burton <paul.burton@mips.com>
 #
 
-obj-y += init.o
-obj-y += irq.o
-obj-y += proc.o
+obj-$(CONFIG_MACH_GENERIC_CORE) += init.o
+obj-$(CONFIG_MACH_GENERIC_CORE) += irq.o
+obj-$(CONFIG_MACH_GENERIC_CORE) += proc.o
 
 obj-$(CONFIG_YAMON_DT_SHIM)		+= yamon-dt.o
 obj-$(CONFIG_LEGACY_BOARD_SEAD3)	+= board-sead3.o
-- 
2.43.0


