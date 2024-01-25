Return-Path: <linux-kernel+bounces-38797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F2E783C61F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 16:10:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F455B234A0
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 15:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B614B73167;
	Thu, 25 Jan 2024 15:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uI9AdYXo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A776E2D1
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 15:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706195398; cv=none; b=Z/apkBS/yVLj8X/3HIb9mLq4/UttUPoBOS/SKTDu0j7ivE7mF5ZD1kuSghm3UdjOizAqahW/mXSg1hSpM3ROOvjSiyKiXwskQzV2YjJxbrxrU6/OZdD6t016oJxvDBy0KjeGZJubO8BeWWBcmrAOADbI/Po6UwpnrM00PBHJ9lY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706195398; c=relaxed/simple;
	bh=jGTeEqT3oFqBR8XDClyO1GAGfuARRlp1VqsQY6R1rZE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Mi4/shoWrHerSAXu2VL2ykYhhI+601YyeymaNFFJl+C+aVo0xxPDjeJUnzBPO71w+zRZjWpZ4wKftsmp1jWAt31Sx3dV5vfnYC8sn7vZwd/9qitVW5g+1GGqhaVW0e3DeNGKZYEG9bW75a8gGSj+xFA6D/nwp5Km/aa0Rug5a5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uI9AdYXo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D064AC433F1;
	Thu, 25 Jan 2024 15:09:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706195397;
	bh=jGTeEqT3oFqBR8XDClyO1GAGfuARRlp1VqsQY6R1rZE=;
	h=From:To:Cc:Subject:Date:From;
	b=uI9AdYXoCYAn5DBxuyyvDJKzDd81svW6+pDf8TyqdpmXSirs3iM9UeAu1/KDakzpV
	 IsqSQZZyeebMygPcY5g00qnnK1S0gz/6X6kmK1YWDzmCMrCqpY7j22STrwxn7SsMpi
	 QDEINiE6NdWlX0MeVJS4Yd3YR19GMSiS4ny5m9hMlWkUnaUAFIpg+3HTCgksRBRK8F
	 Bhj9/CB/yxx+Rie9jLZn0MhbBGmsz1F/GRzXkvTd+X4K+jvpQGDQbzl6vDgahv6Dhs
	 TpmiRDUvSyW/6S9BJ8kHywTlbsnN/ws880XQbUxLr8V8e5f2QVuFvCvDfuRSFVT8bg
	 cEhhhy2eSrB3A==
From: Jisheng Zhang <jszhang@kernel.org>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Samuel Holland <samuel.holland@sifive.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH v3] riscv: select ARCH_HAS_FAST_MULTIPLIER
Date: Thu, 25 Jan 2024 22:57:03 +0800
Message-ID: <20240125145703.913-1-jszhang@kernel.org>
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
since v2:
 - rebase on v6.8-rc1
 - collect Reviewed-by and Tested-by tag

since v1:
 - fix typo in commit msg
 - add some performance numbers provided by Samuel
 - collect Reviewed-by and Tested-by tag

 arch/riscv/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index bffbd869a068..fdd1a595ebd8 100644
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


