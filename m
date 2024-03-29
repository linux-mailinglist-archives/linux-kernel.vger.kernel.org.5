Return-Path: <linux-kernel+bounces-124035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BA7589116E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 03:11:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E595B28F2D6
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 02:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACD6B39ACB;
	Fri, 29 Mar 2024 02:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PWtPAJ0m"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CED3381BB;
	Fri, 29 Mar 2024 02:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711678182; cv=none; b=OP0GwPh1iW5hiFGjbku4R/7w5YbZMxgdXUD/F4WdeLU4/Sgdbc+2+TZTtSXMzOIsOE2mE0xjr+/9USFsTRqs2HTEPGtuEbcKpuFgkEMt2yYTue8aLuwtC5eHaXvlOUDz9m90QpEsgQaW++YfXPQWfhz3qknCW/uZr9AUVb9nGcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711678182; c=relaxed/simple;
	bh=N6G0WKeysLe36XGor+TH2QHAhPLm6Xleh7fpJIEyD2Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=a3y194X/1rJBk8AQQyjVAUxPRKSeSthnBKzwk6UWRVXksx/nHGNba7ZHK4Q7sS48uBQ7WkR8v2t9my65pqUlTr13Er1DOB5kdCjxlUbFOqu6fgrYrRmjsTAhhwtYKsUHbMaMJbqABg6Xga70IE02UtXO6VIN9HiYjc4MGfLoIEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PWtPAJ0m; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711678180; x=1743214180;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=N6G0WKeysLe36XGor+TH2QHAhPLm6Xleh7fpJIEyD2Y=;
  b=PWtPAJ0mZArmRPOExLeNUWpKcm2uU3SsUOWm/yRQS9f7XRKdA7bwH+xv
   3QKiGU+iqzduCx/rvNQwIXc6QM9pphqUat75vFoiQpOygJwtw6pwNagcB
   lx2nixWjWVna1nI6Tq7HJWvY29QjHPtR9y8R2T8Z5MYEEHKO8icVaS8d1
   t02/TLPAOKFMgZQxsbc1ZYwe0cPf4OoFCAXO11SQvpcpZ8LQTP4UN7PDY
   czFdtf3an4+i6XUIDjS3YMQXyg6e41HETRWzzFP/HZIMeSGcaPnRp/GaL
   GC/5ap3E84j1G+XpGxdVMEt4cabAFqd9vgHH43xPlI/spfyePD1XBCYOp
   w==;
X-CSE-ConnectionGUID: PWVP/QhtR5W0PGJPUaiKrw==
X-CSE-MsgGUID: l8eI8ZV3RLKuVAm8QP7rFg==
X-IronPort-AV: E=McAfee;i="6600,9927,11027"; a="6700039"
X-IronPort-AV: E=Sophos;i="6.07,162,1708416000"; 
   d="scan'208";a="6700039"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2024 19:09:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,162,1708416000"; 
   d="scan'208";a="17301382"
Received: from chang-linux-3.sc.intel.com ([172.25.66.175])
  by orviesa006.jf.intel.com with ESMTP; 28 Mar 2024 19:09:39 -0700
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: linux-kernel@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	dm-devel@redhat.com
Cc: ebiggers@kernel.org,
	luto@kernel.org,
	dave.hansen@linux.intel.com,
	tglx@linutronix.de,
	bp@alien8.de,
	mingo@kernel.org,
	x86@kernel.org,
	herbert@gondor.apana.org.au,
	ardb@kernel.org,
	elliott@hpe.com,
	dan.j.williams@intel.com,
	bernie.keany@intel.com,
	charishma1.gairuboyina@intel.com,
	chang.seok.bae@intel.com
Subject: [PATCH v9 03/14] x86/insn: Add Key Locker instructions to the opcode map
Date: Thu, 28 Mar 2024 18:53:35 -0700
Message-Id: <20240329015346.635933-4-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240329015346.635933-1-chang.seok.bae@intel.com>
References: <20230603152227.12335-1-chang.seok.bae@intel.com>
 <20240329015346.635933-1-chang.seok.bae@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The x86 instruction decoder needs to know these new instructions that
are going to be used in the crypto library as well as the x86 core
code. Add the following:

LOADIWKEY:
	Load a CPU-internal wrapping key.

ENCODEKEY128:
	Wrap a 128-bit AES key to a key handle.

ENCODEKEY256:
	Wrap a 256-bit AES key to a key handle.

AESENC128KL:
	Encrypt a 128-bit block of data using a 128-bit AES key
	indicated by a key handle.

AESENC256KL:
	Encrypt a 128-bit block of data using a 256-bit AES key
	indicated by a key handle.

AESDEC128KL:
	Decrypt a 128-bit block of data using a 128-bit AES key
	indicated by a key handle.

AESDEC256KL:
	Decrypt a 128-bit block of data using a 256-bit AES key
	indicated by a key handle.

AESENCWIDE128KL:
	Encrypt 8 128-bit blocks of data using a 128-bit AES key
	indicated by a key handle.

AESENCWIDE256KL:
	Encrypt 8 128-bit blocks of data using a 256-bit AES key
	indicated by a key handle.

AESDECWIDE128KL:
	Decrypt 8 128-bit blocks of data using a 128-bit AES key
	indicated by a key handle.

AESDECWIDE256KL:
	Decrypt 8 128-bit blocks of data using a 256-bit AES key
	indicated by a key handle.

The detail can be found in Intel Software Developer Manual.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
---
Changes from v6:
* Massage the changelog -- add the reason a bit.

Changes from RFC v1:
* Separated out the LOADIWKEY addition in a new patch.
* Included AES instructions to avoid warning messages when the AES Key
  Locker module is built.
---
 arch/x86/lib/x86-opcode-map.txt       | 11 +++++++----
 tools/arch/x86/lib/x86-opcode-map.txt | 11 +++++++----
 2 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/arch/x86/lib/x86-opcode-map.txt b/arch/x86/lib/x86-opcode-map.txt
index 12af572201a2..c94988d5130d 100644
--- a/arch/x86/lib/x86-opcode-map.txt
+++ b/arch/x86/lib/x86-opcode-map.txt
@@ -800,11 +800,12 @@ cb: sha256rnds2 Vdq,Wdq | vrcp28ss/d Vx,Hx,Wx (66),(ev)
 cc: sha256msg1 Vdq,Wdq | vrsqrt28ps/d Vx,Wx (66),(ev)
 cd: sha256msg2 Vdq,Wdq | vrsqrt28ss/d Vx,Hx,Wx (66),(ev)
 cf: vgf2p8mulb Vx,Wx (66)
+d8: AESENCWIDE128KL Qpi (F3),(000),(00B) | AESENCWIDE256KL Qpi (F3),(000),(10B) | AESDECWIDE128KL Qpi (F3),(000),(01B) | AESDECWIDE256KL Qpi (F3),(000),(11B)
 db: VAESIMC Vdq,Wdq (66),(v1)
-dc: vaesenc Vx,Hx,Wx (66)
-dd: vaesenclast Vx,Hx,Wx (66)
-de: vaesdec Vx,Hx,Wx (66)
-df: vaesdeclast Vx,Hx,Wx (66)
+dc: vaesenc Vx,Hx,Wx (66) | LOADIWKEY Vx,Hx (F3) | AESENC128KL Vpd,Qpi (F3)
+dd: vaesenclast Vx,Hx,Wx (66) | AESDEC128KL Vpd,Qpi (F3)
+de: vaesdec Vx,Hx,Wx (66) | AESENC256KL Vpd,Qpi (F3)
+df: vaesdeclast Vx,Hx,Wx (66) | AESDEC256KL Vpd,Qpi (F3)
 f0: MOVBE Gy,My | MOVBE Gw,Mw (66) | CRC32 Gd,Eb (F2) | CRC32 Gd,Eb (66&F2)
 f1: MOVBE My,Gy | MOVBE Mw,Gw (66) | CRC32 Gd,Ey (F2) | CRC32 Gd,Ew (66&F2)
 f2: ANDN Gy,By,Ey (v)
@@ -814,6 +815,8 @@ f6: ADCX Gy,Ey (66) | ADOX Gy,Ey (F3) | MULX By,Gy,rDX,Ey (F2),(v) | WRSSD/Q My,
 f7: BEXTR Gy,Ey,By (v) | SHLX Gy,Ey,By (66),(v) | SARX Gy,Ey,By (F3),(v) | SHRX Gy,Ey,By (F2),(v)
 f8: MOVDIR64B Gv,Mdqq (66) | ENQCMD Gv,Mdqq (F2) | ENQCMDS Gv,Mdqq (F3)
 f9: MOVDIRI My,Gy
+fa: ENCODEKEY128 Ew,Ew (F3)
+fb: ENCODEKEY256 Ew,Ew (F3)
 EndTable
 
 Table: 3-byte opcode 2 (0x0f 0x3a)
diff --git a/tools/arch/x86/lib/x86-opcode-map.txt b/tools/arch/x86/lib/x86-opcode-map.txt
index 12af572201a2..c94988d5130d 100644
--- a/tools/arch/x86/lib/x86-opcode-map.txt
+++ b/tools/arch/x86/lib/x86-opcode-map.txt
@@ -800,11 +800,12 @@ cb: sha256rnds2 Vdq,Wdq | vrcp28ss/d Vx,Hx,Wx (66),(ev)
 cc: sha256msg1 Vdq,Wdq | vrsqrt28ps/d Vx,Wx (66),(ev)
 cd: sha256msg2 Vdq,Wdq | vrsqrt28ss/d Vx,Hx,Wx (66),(ev)
 cf: vgf2p8mulb Vx,Wx (66)
+d8: AESENCWIDE128KL Qpi (F3),(000),(00B) | AESENCWIDE256KL Qpi (F3),(000),(10B) | AESDECWIDE128KL Qpi (F3),(000),(01B) | AESDECWIDE256KL Qpi (F3),(000),(11B)
 db: VAESIMC Vdq,Wdq (66),(v1)
-dc: vaesenc Vx,Hx,Wx (66)
-dd: vaesenclast Vx,Hx,Wx (66)
-de: vaesdec Vx,Hx,Wx (66)
-df: vaesdeclast Vx,Hx,Wx (66)
+dc: vaesenc Vx,Hx,Wx (66) | LOADIWKEY Vx,Hx (F3) | AESENC128KL Vpd,Qpi (F3)
+dd: vaesenclast Vx,Hx,Wx (66) | AESDEC128KL Vpd,Qpi (F3)
+de: vaesdec Vx,Hx,Wx (66) | AESENC256KL Vpd,Qpi (F3)
+df: vaesdeclast Vx,Hx,Wx (66) | AESDEC256KL Vpd,Qpi (F3)
 f0: MOVBE Gy,My | MOVBE Gw,Mw (66) | CRC32 Gd,Eb (F2) | CRC32 Gd,Eb (66&F2)
 f1: MOVBE My,Gy | MOVBE Mw,Gw (66) | CRC32 Gd,Ey (F2) | CRC32 Gd,Ew (66&F2)
 f2: ANDN Gy,By,Ey (v)
@@ -814,6 +815,8 @@ f6: ADCX Gy,Ey (66) | ADOX Gy,Ey (F3) | MULX By,Gy,rDX,Ey (F2),(v) | WRSSD/Q My,
 f7: BEXTR Gy,Ey,By (v) | SHLX Gy,Ey,By (66),(v) | SARX Gy,Ey,By (F3),(v) | SHRX Gy,Ey,By (F2),(v)
 f8: MOVDIR64B Gv,Mdqq (66) | ENQCMD Gv,Mdqq (F2) | ENQCMDS Gv,Mdqq (F3)
 f9: MOVDIRI My,Gy
+fa: ENCODEKEY128 Ew,Ew (F3)
+fb: ENCODEKEY256 Ew,Ew (F3)
 EndTable
 
 Table: 3-byte opcode 2 (0x0f 0x3a)
-- 
2.34.1


