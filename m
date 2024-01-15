Return-Path: <linux-kernel+bounces-26601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0527082E402
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 00:44:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E3831F2522A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 23:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70EB425628;
	Mon, 15 Jan 2024 23:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dohr+iEq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDDC02561C;
	Mon, 15 Jan 2024 23:29:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3AEBC433F1;
	Mon, 15 Jan 2024 23:29:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705361380;
	bh=rls3hu2yxw7xGfeW2g+0mweBZp4srpjlWaeIfa8oFt8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Dohr+iEqgxXXqbuOiUy8cjbDJv6V57OfxVPnEPY9iJ2KfTJLamUPxbWK38zcqD5Vu
	 va9XeU7Vyrt/seWbBXcVtYQ1m+gusKyKGSnFVXHX8mIJ3ax/AJmfLKQqJrFHc7Ud3f
	 3IEJDZfReeDOiWMx8MgN4/HzJSa4fu6LTp+t/+AdN+mvMI/yV5A4t2GECyMmsownGE
	 gMpQlX4v+xvkCwp84lruiQd3e3dhJi/9h0YQ0Eoyr0fZY/HqMaHdE0BT2l96glZEZf
	 sOTK3sud6bV95/YV2MWgsBdD8GZnnyaIvLuxp4FHotJ+YsVHqCnBe4PEId87wZW/Fv
	 GsSxP4gCUJx2A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Michael Ellerman <mpe@ellerman.id.au>,
	Sasha Levin <sashal@kernel.org>,
	christophe.leroy@csgroup.eu,
	bgray@linux.ibm.com,
	arnd@arndb.de,
	naveen@kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH AUTOSEL 4.19 2/4] powerpc: Fix build error due to is_valid_bugaddr()
Date: Mon, 15 Jan 2024 18:29:27 -0500
Message-ID: <20240115232935.210529-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240115232935.210529-1-sashal@kernel.org>
References: <20240115232935.210529-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.305
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
index 63c751ce130a..67a00131ec42 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -1341,10 +1341,12 @@ static int emulate_instruction(struct pt_regs *regs)
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


