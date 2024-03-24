Return-Path: <linux-kernel+bounces-113391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96AA78883F4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:25:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 331E81F28BCC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 868486F069;
	Sun, 24 Mar 2024 22:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZZtziJiL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB75A1A2146;
	Sun, 24 Mar 2024 22:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320192; cv=none; b=poajXZllYqAoo4lvmHao5ksEswreQy6NqrgSz61QrjaZeE2GnQ89Zjc5Zmr8uH3FlKCZ/XqsZ0tPCiZUVGQKug/aYBiFbHeV5WGeQL1lwAq7BwEeO60W3XtSEGohdm/lQ2cEUznYDwgjCE+Nb0Vy1ZOoyBIdCg3iCCmdUyys8+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320192; c=relaxed/simple;
	bh=c4K8ZsQm+zOTS2fUOLLnP8gSNrKbnjB+6Do1gx198Co=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mBZEbaPM4fkRQaTMd1aOGbJfvUqlFq63ieDLItqbIUYyJx4mVu4tbMiUoGFLYqapz4pIhhEq3lCl5gzxN4XeUrmscBN8pWBRMQOqCq+RQ6P2TtpC/Pz7VW9iYGJ6aWI3we7YN6Zr91/35wCQZUDg8P1ywRJwR6Pp5/OzQ/Q2f2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZZtziJiL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06932C43390;
	Sun, 24 Mar 2024 22:43:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320192;
	bh=c4K8ZsQm+zOTS2fUOLLnP8gSNrKbnjB+6Do1gx198Co=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZZtziJiLqA7yiuOuZaps73gHlQvSu/hEygO9Hzug/ioNgm4WrQVcjGwA8vvOBwHdE
	 U6E71KZlAhJSjdNYkALgid//BpEi8XHmSadkbccVo8UWsTK+jzJh15svXFD8w5188k
	 7taS0lduE5QlMYAUXnAuAqGw4qCz30CyJYiJ5JgSKcH8s5O5qgEGHVRw0xxwwdIo06
	 R3nvpRq5Yia0sw6V/DZXO2P9URdT6mZv8Hj0+cUuACSdK26qzTILW4r6HV6kQsgtYN
	 FmYDSL/RQsuJCyz4vEt9anM9mskcOMxP67M4by0b4vSSR5CtkD6Ylob1XAkyQoOxTN
	 FMJxCBvFibNtQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Michael Ellerman <mpe@ellerman.id.au>,
	Randy Dunlap <rdunlap@infradead.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 500/715] powerpc/32: fix ADB_CUDA kconfig warning
Date: Sun, 24 Mar 2024 18:31:19 -0400
Message-ID: <20240324223455.1342824-501-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Michael Ellerman <mpe@ellerman.id.au>

[ Upstream commit b72c066ba85a131091498a15a62d6068997278a4 ]

Fix a (randconfig) kconfig warning by correcting the select
statement:

WARNING: unmet direct dependencies detected for ADB_CUDA
  Depends on [n]: MACINTOSH_DRIVERS [=n] && (ADB [=n] || PPC_PMAC [=y]) && !PPC_PMAC64 [=n]
  Selected by [y]:
  - PPC_PMAC [=y] && PPC_BOOK3S [=y] && CPU_BIG_ENDIAN [=y] && POWER_RESET [=y] && PPC32 [=y]

The PPC32 isn't needed because ADB depends on (PPC_PMAC && PPC32).

Fixes: a3ef2fef198c ("powerpc/32: Add dependencies of POWER_RESET for pmac32")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Tested: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://msgid.link/20240211221623.31112-1-rdunlap@infradead.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/platforms/powermac/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/powermac/Kconfig b/arch/powerpc/platforms/powermac/Kconfig
index 8bdae0caf21e5..84f101ec53a96 100644
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
-- 
2.43.0


