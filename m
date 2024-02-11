Return-Path: <linux-kernel+bounces-60967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44C80850BBE
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 23:16:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E08A01F21F09
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 22:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 034B55F49D;
	Sun, 11 Feb 2024 22:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WVpIB+8q"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 574FB5DF03
	for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 22:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707689789; cv=none; b=emkPa1OF/mQRgvia6aSz5gBKMeRsbXKaLL+K6viw3JJDzS751c4eM7+iiGxOH71zYTFUnN2fG2fhWKjdmlr4YtXwCFxAtrScb4hc28iXRcLMhB2r70MLg50yyoO9PD8hzmqDA3YlUb9pKf2U9W4KXiS9J/Lc3xgZEbCECy6NHXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707689789; c=relaxed/simple;
	bh=0trKfmmu8rRHJTfD6tfYc+PZauOvGEw3hUz06D302SE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=B2NDT2BfpB1ftF+ITOqQ89vlb0MT/HS/LEpJBT9awPuaz9PR+qpVvzt1fTqF1Jt+9l4sGG5ryDyKV2p16pt/RAZtPks31A2SdsYSGUDWhkIjpi+sDfEKNI8IP4+qxYaBpYRWbVbhL1OJ20YHzGqdQ/sS+XRONypU0nrxAV/Tgwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=WVpIB+8q; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=biX1YZPYTFWELtUlQ2JJPkGRj3v+GOt2S3ObPQGevHg=; b=WVpIB+8qH2F/+pZGlllMzQ6QDS
	+4aiEwPQcNJFVKp7u+tnXUB2RuaP/Rw8g+JVEb3xbkXL0unJ6MFJSxSpgUjYcb/+IzOrwo1Ai0+vX
	gRl4cQQl5ZKz6kH7zdAq75UfYHWSPQITTc9PXvVjPY6LzVv4bx4zGBDeO/T7yDq8+faBrd73Nqo+C
	sqmK9Hu4+UpKQVf2vk27LnD+fJNUqWmZO2Q9GsIqzyolmU1o+W/sRTCcBX98OaP/WAB4cp5f7fHcr
	Djef2BwbhRQhqvF0rVaTznGFmDjsHBRUTC8QOCaYAhsibJfJa4B/AjWl3cM/TceBcZp1YH0uIsKWQ
	zLkM7wTA==;
Received: from [50.53.50.0] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rZI7d-00000003Nk0-0Is5;
	Sun, 11 Feb 2024 22:16:25 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Yuan Tan <tanyuan@tinylab.org>
Subject: [PATCH] powerpc/32: fix ADB_CUDA kconfig warning
Date: Sun, 11 Feb 2024 14:16:23 -0800
Message-ID: <20240211221623.31112-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michael Ellerman <mpe@ellerman.id.au>

Fix a (randconfig) kconfig warning by correcting the select
statement:

WARNING: unmet direct dependencies detected for ADB_CUDA
  Depends on [n]: MACINTOSH_DRIVERS [=n] && (ADB [=n] || PPC_PMAC [=y]) && !PPC_PMAC64 [=n]
  Selected by [y]:
  - PPC_PMAC [=y] && PPC_BOOK3S [=y] && CPU_BIG_ENDIAN [=y] && POWER_RESET [=y] && PPC32 [=y]

The PPC32 isn't needed because ADB depends on (PPC_PMAC && PPC32).

Fixes: a3ef2fef198c ("powerpc/32: Add dependencies of POWER_RESET for pmac32")
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Tested: Randy Dunlap <rdunlap@infradead.org>
Cc: Yuan Tan <tanyuan@tinylab.org>
---
 arch/powerpc/platforms/powermac/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -- a/arch/powerpc/platforms/powermac/Kconfig b/arch/powerpc/platforms/powermac/Kconfig
--- a/arch/powerpc/platforms/powermac/Kconfig
+++ b/arch/powerpc/platforms/powermac/Kconfig
@@ -2,7 +2,7 @@
 config PPC_PMAC
 	bool "Apple PowerMac based machines"
 	depends on PPC_BOOK3S && CPU_BIG_ENDIAN
-	select ADB_CUDA if POWER_RESET && PPC32
+	select ADB_CUDA if POWER_RESET && ADB
 	select MPIC
 	select FORCE_PCI
 	select PPC_INDIRECT_PCI if PPC32

