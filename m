Return-Path: <linux-kernel+bounces-121684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C84488EC65
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 18:19:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4950829FD02
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 17:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3733314E2DC;
	Wed, 27 Mar 2024 17:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="Fh6W9ymS"
Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 348E214E2D9
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 17:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711559917; cv=none; b=fgnIBecakx33EPK6686H9JJeUgF/+Kb2gGuvtI8kLtjCREvwRgHq5ClThI5K2zrL8oa9xtYu/EomgMdUCc5gP/d14AovsdgR09m7bMabKJYBA2jryLkA574loR/vtfsGP9+zcfLD5yl8FD8ixdskrArzsPEqsE29QRL/ytL9QC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711559917; c=relaxed/simple;
	bh=F1pqsc6yA/HV/3XyW47RmJKXv1PKsfVTHF8V7dly7UM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KbQJcgoDojUlfh3fCL/UTdnyZIc3LyU83xZ3lYLUlXTUgV7CYgATK3ka056LCuexfd5DsELfHCertr977uX/kHeNgV/jW17MoCDXYdl55kzLmYcETwXLL5fyQmrMIvPbw+eunBczTRMbrilvun0C/6PBANAO5XdIVpiy11nMyD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=Fh6W9ymS; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
	s=default; t=1711559915;
	bh=F1pqsc6yA/HV/3XyW47RmJKXv1PKsfVTHF8V7dly7UM=;
	h=From:To:Cc:Subject:Date:From;
	b=Fh6W9ymSD/DcjLV3NqlAW1P51PmWY56HAen4AMuo3f+cyaQXZkcgYyVl/Ydis5/AY
	 MlagIngvWDwP0K3slPck15SpbCxMdsIpwTDKxBlORqCWxb8qY4ORH8V8kFm/U9tV6D
	 Crh7v/kz1U3Lpk+LL7mYzDuSJnL29eLaik6BWpts=
Received: from stargazer.. (unknown [IPv6:240e:358:111f:6100:dc73:854d:832e:8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id B449666B9E;
	Wed, 27 Mar 2024 13:18:31 -0400 (EDT)
From: Xi Ruoyao <xry111@xry111.site>
To: Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>
Cc: loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	Xi Ruoyao <xry111@xry111.site>
Subject: [PATCH] LoongArch: Select ARCH_HAS_FAST_MULTIPLIER
Date: Thu, 28 Mar 2024 01:18:07 +0800
Message-ID: <20240327171807.27741-1-xry111@xry111.site>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

LA464 and LA664 can do 32-bit/64-bit integer multiplication with a
latency of 4 cycles and a throughput of 2 ops per cycle.  It's
comparable to mainstream x86 and arm64 cores, so select
ARCH_HAS_FAST_MULTIPLIER like them.

It speeds up __sw_hweight32 in lib/hweight.c for about 14% on LA464 and
11% on LA664, and __sw_hweight64 for about 30% on LA464 and 33% on
LA664.

Signed-off-by: Xi Ruoyao <xry111@xry111.site>
---
 arch/loongarch/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index 5a769bb92d7c..d52a95195e7f 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -16,6 +16,7 @@ config LOONGARCH
 	select ARCH_HAS_ACPI_TABLE_UPGRADE	if ACPI
 	select ARCH_HAS_CPU_FINALIZE_INIT
 	select ARCH_HAS_CURRENT_STACK_POINTER
+	select ARCH_HAS_FAST_MULTIPLIER
 	select ARCH_HAS_FORTIFY_SOURCE
 	select ARCH_HAS_KCOV
 	select ARCH_HAS_NMI_SAFE_THIS_CPU_OPS
-- 
2.44.0


