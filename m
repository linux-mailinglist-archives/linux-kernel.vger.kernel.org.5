Return-Path: <linux-kernel+bounces-51647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F03F3848DDE
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 13:57:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84DB42821C4
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 12:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46DE3219FF;
	Sun,  4 Feb 2024 12:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mzp8kCor"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83AC51E51A;
	Sun,  4 Feb 2024 12:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707051447; cv=none; b=bhD2+5zrzQ5MjbxSiUouGNYtwo0nPHF4aHu+AecZNxuzGvtndGFzhofpgubHu7QVD71f/MkfCyuxdI6BT/uX8fr141+LzaX4U3U6hAsjwzyiFcYEanbMqL8iDF8PxONtYlWJGvNYpsUW++37Ah81wk/0CyK1BaMdPLl+dTv+Z5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707051447; c=relaxed/simple;
	bh=11ALOU6VsnZCMQ97q7QMgNjhbRhAQUuFE5x9Bwr0dTM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JOJjp8llLgQPqLxSkFGt7ERBss3nJuziWoZKFipnjyDr+PDl8A2ckhbjl9Rec9W4muaXvOmJTkUfXAPbQGt4rFqIsbEOu4Qh0Udbuwe51a9oU/7RJwYhV2kzoGLeDrF2uBXwcrHPz/734sM6NF8mF6mrtgrK+3EahR8R8UEbu4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mzp8kCor; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71DE8C43142;
	Sun,  4 Feb 2024 12:57:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707051447;
	bh=11ALOU6VsnZCMQ97q7QMgNjhbRhAQUuFE5x9Bwr0dTM=;
	h=From:To:Cc:Subject:Date:From;
	b=mzp8kCorouXZNIh5YdE3P/9BIzS8g0hVdJWYDPZ03Ux+V0TvVbltKZyt/1VvuRoMB
	 O46zrP/E03XVxp+e5ztdOV+Q53avZoO9m25AqfRWpWvD48OE5u9AnA+onDvW8uOaCj
	 TMA27NWgcJUkdl3D4gGQJ3NsQOQ4YiXn7awrd42pxPREhu9gmdhyYNoGHBm+gRw7Of
	 6SYY0AME+hrsr1J8vMiqIm5DU766wXQpcQK7+i9dNaYyohq6zoASo9YR3ZDdq7JcF4
	 Am01y4r6d+tcrzT1K7gmBS101DI3zDMFtiBHXY4cvTD/wMr1B6o0Bx7GYql7J+78K+
	 5MVyGX+SCPwIg==
From: Masahiro Yamada <masahiroy@kernel.org>
To: Aaro Koskinen <aaro.koskinen@iki.fi>,
	Janusz Krzysztofik <jmkrzyszt@gmail.com>,
	Tony Lindgren <tony@atomide.com>,
	linux-omap@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] arm: omap1: remove duplicated 'select ARCH_OMAP'
Date: Sun,  4 Feb 2024 21:57:16 +0900
Message-Id: <20240204125716.56756-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 980a637d11fe ("ARM: omap1: fix !ARCH_OMAP1_ANY link failures")
added one more 'select ARCH_OMAP'.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/arm/mach-omap1/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-omap1/Kconfig b/arch/arm/mach-omap1/Kconfig
index cbf703f0d850..a643b71e30a3 100644
--- a/arch/arm/mach-omap1/Kconfig
+++ b/arch/arm/mach-omap1/Kconfig
@@ -4,7 +4,6 @@ menuconfig ARCH_OMAP1
 	depends on ARCH_MULTI_V4T || ARCH_MULTI_V5
 	depends on CPU_LITTLE_ENDIAN
 	depends on ATAGS
-	select ARCH_OMAP
 	select ARCH_HAS_HOLES_MEMORYMODEL
 	select ARCH_OMAP
 	select CLKSRC_MMIO
-- 
2.40.1


