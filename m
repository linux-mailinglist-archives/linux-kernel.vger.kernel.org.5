Return-Path: <linux-kernel+bounces-26575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D111082E3C0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 00:37:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC4CC287A0A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 23:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B80AD2230B;
	Mon, 15 Jan 2024 23:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t7F0UGmE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B0D22308;
	Mon, 15 Jan 2024 23:27:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED56FC433F1;
	Mon, 15 Jan 2024 23:27:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705361250;
	bh=2AzBnltgVnkqilTUrxFTbYwSk3MkGW/zLwHm0+XqAdw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=t7F0UGmEqPIhZwbHMfJURpHqWI0aCat9HH5AxHvYVcHzGZOR6jsqTZZ6vyVT6hgWY
	 Hebji7phLm9IMVnYU2D26py/vcOclaGVQ/Bb1/iBRKX//9hYYQNtKj63Y/mnNJ7vzj
	 GPP2euM0c24EleRCrWFdAbDiKYCqFIqylG/FfWReGwNYEcHNRhe5r/tQwJZPVV8+ZE
	 mtn4ocnCBcpNxNJXObdRB0hOZwqOuLNHfoyM4XcxjGMELoLm5vk9yaYcrVcM2rh9Ip
	 CW64hKUREv6V1E5VIVwCeFewatTk1EnbcPqvPAu5dYrLKsw/Oe3kVUgb+IpyWzW3XJ
	 82nlP9BOygJ0A==
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
Subject: [PATCH AUTOSEL 5.15 05/12] powerpc: Fix build error due to is_valid_bugaddr()
Date: Mon, 15 Jan 2024 18:26:50 -0500
Message-ID: <20240115232718.209642-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240115232718.209642-1-sashal@kernel.org>
References: <20240115232718.209642-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.147
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
index fe912983ced9..f1a2a75c4757 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -1423,10 +1423,12 @@ static int emulate_instruction(struct pt_regs *regs)
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


