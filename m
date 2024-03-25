Return-Path: <linux-kernel+bounces-116920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9122588B073
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 20:50:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7CD09C045CD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CC5E15664F;
	Mon, 25 Mar 2024 11:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O/stS8ao"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B0915AAC3
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 11:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711365099; cv=none; b=LK+YItdSVq3taq9Te/+Q7cjR0jzR9JXuMRvLjnA3kcG6iJYVEmApMwKqPtL3hFnPG5Bj1MSJj+TjOXlwSFepOszx1fBg8JM9Eb0PtrOM7k2VexkobfiLtq61UaIGjmIVQU8SSGY/p78APiqxM0BfhODlgGe8csp+vVF4dwyDTHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711365099; c=relaxed/simple;
	bh=akb0Xkda4VBBWXx+01f2VRfBJMybL/xPYRcZVbT0RVE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lWUHx+b4uwhDZlZQ8MABRy6KAVUm+UtJrSYSMYx5lu+3pGYsAPGjen+QjPwS0J6teK5qSEdSowgshiOH3cIjg9VB69JZSBAa/30hzoCx56LYRurgR8yUSqSkiiWZQ/exoROhTecAh1tSp4lvNCXevr7z+cj6g628sicNlnS1yYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O/stS8ao; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2FD3C433C7;
	Mon, 25 Mar 2024 11:11:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711365098;
	bh=akb0Xkda4VBBWXx+01f2VRfBJMybL/xPYRcZVbT0RVE=;
	h=From:To:Cc:Subject:Date:From;
	b=O/stS8ao4dr5RdcoD4k0KOBnLcHUDvYt9Cuu2EZpewlYVEZxvx9z4k8CvwcBT2TFV
	 wQ7s73BYayarwRGmiEEV0Q7zmZEF2mz7SsMZ56BJ4U+rj6vn6Zrb/p0xk2a4kK1l6d
	 uILbXVAsRM3oiigJ7PbdxTyCz6OhpUS82NkAYnI6zbEJcnirMHz4D6v5XsdP6I45qn
	 MMbcvz8ZmhSFY3jITAaxki2mLXOPk9ZksLkX+shs97VsKcn/jOWmji9arhuUMOTKTd
	 nKJNf6sIB0WC/GwHFLm53hBvkXQww/NCiKiM8I8B68GZllVWRXZ3nJM4GplivGrgVH
	 5XoDP6nHfcSEQ==
From: Jisheng Zhang <jszhang@kernel.org>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Samuel Holland <samuel.holland@sifive.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH v3 RESEND] riscv: select ARCH_HAS_FAST_MULTIPLIER
Date: Mon, 25 Mar 2024 18:58:23 +0800
Message-ID: <20240325105823.1483-1-jszhang@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, riscv linux requires at least IMA, so all platforms have a
multiplier. And I assume the 'mul' efficiency is comparable or better
than a sequence of five or so register-dependent arithmetic
instructions. Select ARCH_HAS_FAST_MULTIPLIER to get slightly nicer
codegen. Refer to commit f9b4192923fa ("[PATCH] bitops: hweight()
speedup") for more details.

In a simple benchmark test calling hweight64() in a loop, it got:
about 14% performance improvement on JH7110, tested on Milkv Mars.

about 23% performance improvement on TH1520 and SG2042, tested on
Sipeed LPI4A and SG2042 platform.

a slight performance drop on CV1800B, tested on milkv duo. Among all
riscv platforms in my hands, this is the only one which sees a slight
performance drop. It means the 'mul' isn't quick enough. However, the
situation exists on x86 too, for example, P4 doesn't have fast
integer multiplies as said in the above commit, x86 also selects
ARCH_HAS_FAST_MULTIPLIER. So let's select ARCH_HAS_FAST_MULTIPLIER
which can benefit almost riscv platforms.

Samuel also provided some performance numbers:
On Unmatched: 20% speedup for __sw_hweight32 and 30% speedup for
__sw_hweight64.
On D1: 8% speedup for __sw_hweight32 and 8% slowdown for
__sw_hweight64.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
Reviewed-by: Samuel Holland <samuel.holland@sifive.com>
Tested-by: Samuel Holland <samuel.holland@sifive.com>
Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 arch/riscv/Kconfig | 1 +
 1 file changed, 1 insertion(+)

Hi Palmer,

Similar as the pgprot_nx patch, this patch missed two merge window too.
Feel free to ask me questions if there's something need to be done from
my side.

Thanks

since v2:
 - rebase on v6.8-rc1
 - collect Reviewed-by and Tested-by tag

since v1:
 - fix typo in commit msg
 - add some performance numbers provided by Samuel
 - collect Reviewed-by and Tested-by tag

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index be09c8836d56..aba42b2bf660 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -23,6 +23,7 @@ config RISCV
 	select ARCH_HAS_DEBUG_VIRTUAL if MMU
 	select ARCH_HAS_DEBUG_VM_PGTABLE
 	select ARCH_HAS_DEBUG_WX
+	select ARCH_HAS_FAST_MULTIPLIER
 	select ARCH_HAS_FORTIFY_SOURCE
 	select ARCH_HAS_GCOV_PROFILE_ALL
 	select ARCH_HAS_GIGANTIC_PAGE
-- 
2.43.0


