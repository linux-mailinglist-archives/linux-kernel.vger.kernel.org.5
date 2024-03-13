Return-Path: <linux-kernel+bounces-101356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F29A387A5E6
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 11:30:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A70561F24827
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 10:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FBFB3A292;
	Wed, 13 Mar 2024 10:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RLz3oKo9"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5559F3D0C0
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 10:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710325795; cv=none; b=tW50q0YCFIIdrYmA5eH1rFmT0fybXsO4hsGBfM1FtdyjzaKZe9WJJ3y+efKH7Exq9KdOTZpe5dNkKd1XVMb/Hh9GbiJU+Sg4pKGFrchwQee7rjGqxw51FlxVFqZWVXcPk1fbCgKHlyReKGVumcT/qcfWCgv2R0pXla4WDzHcrsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710325795; c=relaxed/simple;
	bh=ezE2f0FsYk3tRVBf2Lqw/FnuOLfDSFbhqIpCHKJemDA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HHIHDtpPGkU27eMjjag71cpLj5PltpeoCPx3k5b1szg6NU+JV9nRWwVKdrlmsAwVN3c2VvVPvqegTx5+yYUhOiBQX4ZOBGquatTrQfB8Sg8v+NPvAVSsGDEbbSKPSGb7hWFxNJ0+9SPy+yXVZ4KSAM6g6cRRxCGxHqR+HeaLD0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RLz3oKo9; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710325795; x=1741861795;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ezE2f0FsYk3tRVBf2Lqw/FnuOLfDSFbhqIpCHKJemDA=;
  b=RLz3oKo9L3by0ZaFyx+sz+jnnEFJ3a8e9GDPzjiwcnjQ4EkHpVL+ITcZ
   HowCeAGLbzouIVqJM0Lo42l3pZqO6k0l3nRGpv8B/0IANWCWGdoNbGdbv
   r+kkwpKpeQoBimPbyExPJ1D4S8XRJIctbdBDwzjBFeTXRQXcgKyo/gAni
   ZGvmFbxwBHKf9hF7RrrQ3T/WdaKOxZJxtdGLHjTE/s7/hNO5kTD+WbpJI
   6hvqaL9zHCjSd/ySPAs1zoUwc29TucwrLqIBzvqh8A/yWANbCeLUt2+m9
   5xFCEo83dmak1sahGoE6rWUVNgEog5dRcXE0JoKkZsMKaZN/VD348xJCo
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11011"; a="15805159"
X-IronPort-AV: E=Sophos;i="6.07,122,1708416000"; 
   d="scan'208";a="15805159"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2024 03:29:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,122,1708416000"; 
   d="scan'208";a="11937824"
Received: from xiao-desktop.sh.intel.com ([10.239.46.158])
  by fmviesa006.fm.intel.com with ESMTP; 13 Mar 2024 03:29:29 -0700
From: Xiao Wang <xiao.w.wang@intel.com>
To: paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu
Cc: jerry.shih@sifive.com,
	nick.knight@sifive.com,
	ajones@ventanamicro.com,
	bjorn@rivosinc.com,
	andy.chiu@sifive.com,
	viro@zeniv.linux.org.uk,
	cleger@rivosinc.com,
	alexghiti@rivosinc.com,
	haicheng.li@intel.com,
	akira.tsukamoto@gmail.com,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Xiao Wang <xiao.w.wang@intel.com>
Subject: [PATCH] riscv: uaccess: Allow the last potential unrolled copy
Date: Wed, 13 Mar 2024 18:33:34 +0800
Message-Id: <20240313103334.4036554-1-xiao.w.wang@intel.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the dst buffer pointer points to the last accessible aligned addr, we
could still run another iteration of unrolled copy.

Signed-off-by: Xiao Wang <xiao.w.wang@intel.com>
---
 arch/riscv/lib/uaccess.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/lib/uaccess.S b/arch/riscv/lib/uaccess.S
index 2e665f8f8fcc..1399d797d81b 100644
--- a/arch/riscv/lib/uaccess.S
+++ b/arch/riscv/lib/uaccess.S
@@ -103,7 +103,7 @@ SYM_FUNC_START(fallback_scalar_usercopy)
 	fixup REG_S   t4,  7*SZREG(a0), 10f
 	addi	a0, a0, 8*SZREG
 	addi	a1, a1, 8*SZREG
-	bltu	a0, t0, 2b
+	bleu	a0, t0, 2b
 
 	addi	t0, t0, 8*SZREG /* revert to original value */
 	j	.Lbyte_copy_tail
-- 
2.25.1


