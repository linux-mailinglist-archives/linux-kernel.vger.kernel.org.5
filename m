Return-Path: <linux-kernel+bounces-115165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF4E1888D8C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:51:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A31A1F2A7B4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B714B3066D5;
	Mon, 25 Mar 2024 01:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pgfAWwYZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05568181D0A;
	Sun, 24 Mar 2024 23:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324221; cv=none; b=swP4X6fJYHHe+hebB8h+QF/L+s8tn2z7gubv94rU0bis6hOsrsM/EVR4XVhnez4wtInB0bLywy+iWt92N+ZF1GWPHBFKVP9+XThq6Bk2XaeYI1LirfNUqVkcbLJWHH5/nL2tg22fy6uVIOm5OGwM3q6/9O18aNY+zm47pxCxP5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324221; c=relaxed/simple;
	bh=/nChahqELmINXvbQzfOoAMqupqs+JnDqhzIcM9K/gI8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ngqkYV5XFG7I8zR5ppc8aovrc5/a1iDJUapmPnR1bnvY8UZFIXDBxWQzhcCx3VQswWmL3FHiI+ZFIe8XcI9UzPWx3Q+klH+n6T/BVfBFJbYL38GMIz2e9l6hWHRnXMUm6GJBCZ08U8fQRkCi8Tisk1SknXtbL/mdf94cb9XLz88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pgfAWwYZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 401ACC433F1;
	Sun, 24 Mar 2024 23:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324219;
	bh=/nChahqELmINXvbQzfOoAMqupqs+JnDqhzIcM9K/gI8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pgfAWwYZGbIJE12neJQOZJQckuLLTebkE/wQJJBgPsFrC5grSXmQUxEd+r/sUcssA
	 0EUzAwueRJ9Xf6nBta74fLX51q542KgCDA7Dk3CNgs0carUZ77lDbEt9Pqc0OdXOQ6
	 vYqUSqPbnAaBerDYdYuTHHQR5enJNZYhhRk/gv3y7WvkbfDtDiKDoR4OEIiL0NeEaL
	 Iaov/2zgGzK2pKuVuTdGbdED2gwYMI2sZqmQ9baBCywB71gKcqaMUyr9f6a//vY6PR
	 hEU/B/1dAYF/USaaKJKWpzzOf1FwVLOl7oCqKMHvEA5dEZulWWV/aXxYmUIwCSCg/K
	 YyoLju+FqUggg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 003/148] MIPS: Clear Cause.BD in instruction_pointer_set
Date: Sun, 24 Mar 2024 19:47:47 -0400
Message-ID: <20240324235012.1356413-4-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324235012.1356413-1-sashal@kernel.org>
References: <20240324235012.1356413-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Jiaxun Yang <jiaxun.yang@flygoat.com>

[ Upstream commit 9d6e21ddf20293b3880ae55b9d14de91c5891c59 ]

Clear Cause.BD after we use instruction_pointer_set to override
EPC.

This can prevent exception_epc check against instruction code at
new return address.
It won't be considered as "in delay slot" after epc being overridden
anyway.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/mips/include/asm/ptrace.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/include/asm/ptrace.h b/arch/mips/include/asm/ptrace.h
index b6578611dddbf..e45c082e12316 100644
--- a/arch/mips/include/asm/ptrace.h
+++ b/arch/mips/include/asm/ptrace.h
@@ -65,6 +65,7 @@ static inline void instruction_pointer_set(struct pt_regs *regs,
                                            unsigned long val)
 {
 	regs->cp0_epc = val;
+	regs->cp0_cause &= ~CAUSEF_BD;
 }
 
 /* Query offset/name of register from its name/offset */
-- 
2.43.0


