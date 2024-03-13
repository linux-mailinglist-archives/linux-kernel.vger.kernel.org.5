Return-Path: <linux-kernel+bounces-101284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FE7387A50D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 10:33:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFB78282540
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 09:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 238DC20DCF;
	Wed, 13 Mar 2024 09:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fI59V8H1"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 397D720B02
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 09:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710322418; cv=none; b=EXwXZa8vIVRqaD1rajLPr1b0DfKYIuJ/VniN7utxEtWWZIHOIQBMLlV+87+87s2fy/sNOXKeSfvh7iB8fDikCDQvqmnXGeN7FYwDvGSlBXFjNMODyRh/u7XhQjrhT0QxvcW3Yh5wI8xrotlteoko5TexAXr4JQVAm0zNOYUrjzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710322418; c=relaxed/simple;
	bh=HNoTeqv9uJwisu7mHmCgim+mSM6YtYt4TVzSQfLCs3A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hpRaN3D8I4pvDOKK1pGIQVsNj4oTA+WReDkB0+ebU+iPmgYhemJpT3M4RsLXawzHNsM36Kv3ij5shYcGZ2z8hyIpwrLQtlQ1E8Z2tNd43oJ5kz+3LnTuGJqmIEtTeCF9CDxMptFrTzqYJqVy7LY0A2Oy1UgIq7/eTsGUvAEiKAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fI59V8H1; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710322416; x=1741858416;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=HNoTeqv9uJwisu7mHmCgim+mSM6YtYt4TVzSQfLCs3A=;
  b=fI59V8H1n1dglR/EAn5zk1zr08iTmvVnFrCMfh6ij+uWG5JsSAhPnuTi
   lHpyExNEWX3pxyhnsFZayPFq7Z6HPVB79lCErReUur3Wh1EWDFgk2OqX4
   i5020tnQcNUUMxZfy7VQhUENinZAswpKbOx87yKsvzIeiKZuKo3Y9iTLH
   Y1MZlLZjrSfJ8omOchMxthWrvog0SglgtNO9O+2hbSx449vO40tI/xDDJ
   e2kVDeN6w0JQEVo7KNKioxL1pE1QZYylzPUIz77sN7yPD3noLDddPaPgJ
   NH+7kCWtIfFDLJwWpGLLvETtPfJ3H9l2w9B5peXKA2v1dlhgjqWfuB3qq
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11011"; a="4931191"
X-IronPort-AV: E=Sophos;i="6.07,122,1708416000"; 
   d="scan'208";a="4931191"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2024 02:16:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="12431369"
Received: from xiao-desktop.sh.intel.com ([10.239.46.158])
  by orviesa008.jf.intel.com with ESMTP; 13 Mar 2024 02:16:00 -0700
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
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Xiao Wang <xiao.w.wang@intel.com>
Subject: [PATCH] riscv: uaccess: Relax the threshold for fast path
Date: Wed, 13 Mar 2024 17:19:29 +0800
Message-Id: <20240313091929.4029960-1-xiao.w.wang@intel.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The bytes copy for unaligned head would cover at most SZREG-1 bytes, so
it's better to set the threshold as >= (SZREG-1 + word_copy stride size)
which equals to 9*SZREG-1.

Signed-off-by: Xiao Wang <xiao.w.wang@intel.com>
---
 arch/riscv/lib/uaccess.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/lib/uaccess.S b/arch/riscv/lib/uaccess.S
index bc22c078aba8..2e665f8f8fcc 100644
--- a/arch/riscv/lib/uaccess.S
+++ b/arch/riscv/lib/uaccess.S
@@ -44,7 +44,7 @@ SYM_FUNC_START(fallback_scalar_usercopy)
 	 * Use byte copy only if too small.
 	 * SZREG holds 4 for RV32 and 8 for RV64
 	 */
-	li	a3, 9*SZREG /* size must be larger than size in word_copy */
+	li	a3, 9*SZREG-1 /* size must >= (word_copy stride + SZREG-1) */
 	bltu	a2, a3, .Lbyte_copy_tail
 
 	/*
-- 
2.25.1


