Return-Path: <linux-kernel+bounces-26534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D3BA82E34F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 00:25:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 060581C214E4
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 23:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 472801BDCC;
	Mon, 15 Jan 2024 23:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WWNHDvVU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F6A1BDC5;
	Mon, 15 Jan 2024 23:24:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27ED0C433C7;
	Mon, 15 Jan 2024 23:24:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705361046;
	bh=UI25Gh3+V0YvBsdbOS97DYEXarBNS5Z20s9NRmA82HM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WWNHDvVU9H+TFOz1ITPWYdesYYMPk8PvxAe+UW9rQhTMxPViYWFg2BUl+UZfYTIg9
	 joBfvCXvZTea/SAjAiJgC+H4VFu0npmJ6rAlWRBDniO7ny+lhPt3LKF3KRNug34eul
	 J35Mvu+MkLHgE7HiwT1yOnYnBCgIwJwbrru8KrIxY2fmydmQ9yoiLiPLEqazTA4d8I
	 pBzMfnjdr/spseGmmoQO+GEIuqGfnhzDvL6DHS6AnVvo4DxteoQzkIJDKiNzp0VSCG
	 Y2zuvT+snEpqvz0QnU7pikSUxB8w4eVdsoPR5czSrHTth6tWvgBhrh0afHXa46ic/R
	 aXcduGddjygwQ==
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
Subject: [PATCH AUTOSEL 6.7 06/14] powerpc: Fix build error due to is_valid_bugaddr()
Date: Mon, 15 Jan 2024 18:23:20 -0500
Message-ID: <20240115232351.208489-6-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240115232351.208489-1-sashal@kernel.org>
References: <20240115232351.208489-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7
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
index 5ea2014aff90..11e062b47d3f 100644
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


