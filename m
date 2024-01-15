Return-Path: <linux-kernel+bounces-26548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA43582E374
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 00:29:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73D2C283D0A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 23:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1BBB1CD38;
	Mon, 15 Jan 2024 23:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KpZK6k81"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 172DA1CD2D;
	Mon, 15 Jan 2024 23:25:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF294C433F1;
	Mon, 15 Jan 2024 23:25:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705361114;
	bh=4klcEXXdg2M92rQa92t457C3dMUm7VRf2LMEPDiYXvs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KpZK6k81v1Z7stXq1n5VZyZYvQn/9ULMplld/HYftSvESmOckrunKUmUQ4DjwWFh8
	 KiVwhCmpEPhqpvI3xQ5y9u1NFJrzbgzHJf3h3OLwdpK+A0LxHz067JsX2wZX7T/4En
	 ttZko9HtPaQcKvY7WEWQofz4mpSEGoVpV5o3iWII3ky15SSRWXE0Dxbexhb/L6f0fS
	 iXPJzRJL5o6v+43fGNm6LG/JpSeaKnD8K+Ke49bIz0pf5TsF1rI5xDY2w+u+8VpXCH
	 qLLygBGG8nwoyZ6k9x9V0OxucfwJB4/80M2WHrxp+NBcgxlsTX6a7vHPj8JLCQTjg2
	 2H2OAjbEcJf9A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Michael Ellerman <mpe@ellerman.id.au>,
	Sasha Levin <sashal@kernel.org>,
	christophe.leroy@csgroup.eu,
	bgray@linux.ibm.com,
	naveen@kernel.org,
	arnd@arndb.de,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH AUTOSEL 6.6 06/14] powerpc: Fix build error due to is_valid_bugaddr()
Date: Mon, 15 Jan 2024 18:24:29 -0500
Message-ID: <20240115232501.208889-6-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240115232501.208889-1-sashal@kernel.org>
References: <20240115232501.208889-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.12
Content-Transfer-Encoding: 8bit

From: Michael Ellerman <mpe@ellerman.id.au>

[ Upstream commit f8d3555355653848082c351fa90775214fb8a4fa ]

With CONFIG_GENERIC_BUG=n the build fails with:

  arch/powerpc/kernel/traps.c:1442:5: error: no previous prototype for ‘is_valid_bugaddr’ [-Werror=missing-prototypes]
  1442 | int is_valid_bugaddr(unsigned long addr)
       |     ^~~~~~~~~~~~~~~~

The prototype is only defined, and the function is only needed, when
CONFIG_GENERIC_BUG=y, so move the implementation under that.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://msgid.link/20231130114433.3053544-2-mpe@ellerman.id.au
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/kernel/traps.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index fe3f720c9cd6..2de7f6dcd32b 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -1439,10 +1439,12 @@ static int emulate_instruction(struct pt_regs *regs)
 	return -EINVAL;
 }
 
+#ifdef CONFIG_GENERIC_BUG
 int is_valid_bugaddr(unsigned long addr)
 {
 	return is_kernel_addr(addr);
 }
+#endif
 
 #ifdef CONFIG_MATH_EMULATION
 static int emulate_math(struct pt_regs *regs)
-- 
2.43.0


