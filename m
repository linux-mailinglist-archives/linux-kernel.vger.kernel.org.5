Return-Path: <linux-kernel+bounces-26594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C3F282E3EF
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 00:43:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E1C5B22539
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 23:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA4191BC29;
	Mon, 15 Jan 2024 23:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YybAOP4l"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33EE31CAA0;
	Mon, 15 Jan 2024 23:29:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A82A1C433F1;
	Mon, 15 Jan 2024 23:29:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705361350;
	bh=VrJYYzn6bes7WgepxrZlwxQXRsTJyIJPZ1o5nEIXXUw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YybAOP4lqVzjnaNp4NQMc3yhKn+jh/Y7ysN1IcVHMptWH4uQF9sO7h8rE7stry9mR
	 L2rYsi9UnksmgklEOv/HmFN11J6aqmIRGKCMmfMs5ekZW4+5D7gg4reiGWPp0HVM0m
	 aeq19/r0MOzNldSRkb+nZDTWAgPsWupjf6S8pLzbp6qoATnM7ShNhrzHy7zw/ztZU+
	 A5Rceo/qWZoCU39ZkOA9w8VsfbZov/FHvPAIkCOr7bMtUl3Z9LzeeZVyvJBPmzL5z2
	 C8NoSVW1TTrkP48/kpwSDMNPfxBp8qMeRSI1ySKLVCbYN0L3qA/DQysLQAPx60n/Oh
	 leEcm0CrJQ/Ig==
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
Subject: [PATCH AUTOSEL 5.4 2/7] powerpc: Fix build error due to is_valid_bugaddr()
Date: Mon, 15 Jan 2024 18:28:47 -0500
Message-ID: <20240115232905.210324-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240115232905.210324-1-sashal@kernel.org>
References: <20240115232905.210324-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.267
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
index 70b99246dec4..402a05f3a484 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -1424,10 +1424,12 @@ static int emulate_instruction(struct pt_regs *regs)
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


