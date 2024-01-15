Return-Path: <linux-kernel+bounces-26586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F3A082E3DC
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 00:41:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 122982842AD
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 23:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F01623760;
	Mon, 15 Jan 2024 23:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PsCPU+eW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A041023756;
	Mon, 15 Jan 2024 23:28:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E821C433C7;
	Mon, 15 Jan 2024 23:28:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705361307;
	bh=o6hjOCZpCIrAq2lKdnhKOsFGDmvRd26IEfx4BA5QwdI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PsCPU+eWs1U+dwop7/ZHDrkTitCEdBnazcQk46lNuFjUDaeaIAIs4TnW41qRQ0rMB
	 Rf4+mBiwYbJG9yfdGzaOe8JSQdyTrsjrpNemgiAlcyzYnQkGF0LVU5s2YMpFjBTxDv
	 N0pMicW3AdKORLHJnYdv2c+r5Ycyh1bDEWDH/DR9hmnzHZfbmKoeINonXm3jA43qoc
	 9QR4bfNua8HNjexqkbnaCxDA8K++Ae7LL8MZbkZOWhgb7MfKZgAjVzEvLsPC53yqXF
	 MAso78RbiqIoFvhzmPQVRcij20PwopZeFAEvIPj1qv3ZQEqhM5rKup7UkPEFiJKDdo
	 AfwVxorL2y+EA==
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
Subject: [PATCH AUTOSEL 5.10 04/10] powerpc: Fix build error due to is_valid_bugaddr()
Date: Mon, 15 Jan 2024 18:27:53 -0500
Message-ID: <20240115232818.210010-4-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240115232818.210010-1-sashal@kernel.org>
References: <20240115232818.210010-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.208
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
index 5e5a2448ae79..b0e87dce2b9a 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -1432,10 +1432,12 @@ static int emulate_instruction(struct pt_regs *regs)
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


