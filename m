Return-Path: <linux-kernel+bounces-81736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 10306867984
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 16:08:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41AD91C2AF42
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 15:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1825A133281;
	Mon, 26 Feb 2024 14:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fvxr/8TR"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE66B12CD89;
	Mon, 26 Feb 2024 14:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708958965; cv=none; b=jUIsZHVZ0/xtSWpb5/HVkbP/ha1gP2KmOlKgx3l4D2scRI10k2eM48tGcmMmgtBabe2pCGfK0/eL3ztUr8tyPM5uPQZ/b6nVlGFCrD3V32guZp4jjikYZeeZDAi2gMb0XC66NWCbtqZbnJpFWb/yFFmyADh4fE9EzkxtAsgBXzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708958965; c=relaxed/simple;
	bh=pCB2xvyDUz4udYP2q+QRzpYQk36Y6qJcgoSZFIZwsrc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lOUzfqx4XqmFz5RWVVKxzziG+3wiR9HhyP6dQeI7bWdPgsGPBLHBLrar7AH1u5AkeNrwM1VwsLuc4zKUivxujf1ICsZfmGw8Woy1nlgN65/3EkHZ6xYYrfE4Wxj+Bj79BtKclRKeVydPYdx0ZdW8nO0eOCbZrOTbHuKx4kukhYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fvxr/8TR; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708958964; x=1740494964;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=pCB2xvyDUz4udYP2q+QRzpYQk36Y6qJcgoSZFIZwsrc=;
  b=fvxr/8TRKv9homNkJ6lkJtLRdlSqI+rPaoipgqO+ddHYhWiYbRhtq9lX
   ipresFHi42L1JwDCZf2nE/u8pND2EL/CTr16TfnHRrP868wLNA5qGLQZC
   lPitPeo3/bZV7hmB8vNKl6b9sKMW2XXd1rSbF3kxmQ5WuX2gsEbOt7v/Z
   evgn8hsIzJXGlYMD4coyJpvvBjsbwXfGe9fYjPUyjg1EL5OHrD6Xo2L0b
   qi/OHYjJjQhe4r+HcHiaLKxkwHrSvPCB9ixq++4uTdro6fkqqKQmY+Ced
   AHALT64Xy/PL/I1KNhjn7FTgKToPMcEqc3jht3y38Mp3ZdkTv7v6ZD6Co
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10995"; a="3167085"
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="3167085"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 06:49:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="6573411"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by fmviesa007.fm.intel.com with ESMTP; 26 Feb 2024 06:49:21 -0800
From: Alexander Lobakin <aleksander.lobakin@intel.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	Michael Chan <michael.chan@broadcom.com>,
	Somnath Kotur <somnath.kotur@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] bnxt_en: fix accessing vnic_info before allocating it
Date: Mon, 26 Feb 2024 15:49:11 +0100
Message-ID: <20240226144911.1297336-1-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bnxt_alloc_mem() dereferences ::vnic_info in the variable declaration
block, but allocates it much later. As a result, the following crash
happens on my setup:

 BUG: kernel NULL pointer dereference, address: 0000000000000090
 fbcon: Taking over console
 #PF: supervisor write access in kernel mode
 #PF: error_code (0x0002) - not-present page
 PGD 12f382067 P4D 0
 Oops: 8002 [#1] PREEMPT SMP NOPTI
 CPU: 47 PID: 2516 Comm: NetworkManager Not tainted 6.8.0-rc5-libeth+ #49
 Hardware name: Intel Corporation M50CYP2SBSTD/M58CYP2SBSTD, BIOS SE5C620.86B.01.01.0088.2305172341 05/17/2023
 RIP: 0010:bnxt_alloc_mem+0x1609/0x1910 [bnxt_en]
 Code: 81 c8 48 83 c8 08 31 c9 e9 d7 fe ff ff c7 44 24 Oc 00 00 00 00 49 89 d5 e9 2d fe ff ff 41 89 c6 e9 88 00 00 00 48 8b 44 24 50 <80> 88 90 00 00 00 Od 8b 43 74 a8 02 75 1e f6 83 14 02 00 00 80 74
 RSP: 0018:ff3f25580f3432c8 EFLAGS: 00010246
 RAX: 0000000000000000 RBX: ff15a5cfc45249e0 RCX: 0000002079777000
 RDX: ff15a5dfb9767000 RSI: 0000000000000000 RDI: 0000000000000000
 RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
 R10: ff15a5dfb9777000 R11: ffffff8000000000 R12: 0000000000000000
 R13: 0000000000000000 R14: 0000000000000020 R15: ff15a5cfce34f540
 FS:  000007fb9a160500(0000) GS:ff15a5dfbefc0000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CRO: 0000000080050033
 CR2: 0000000000000090 CR3: 0000000109efc00Z CR4: 0000000000771ef0
 DR0: 0000000000000000 DR1: 0000000000000000 DRZ: 0000000000000000
 DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
 PKRU: 55555554

 Call Trace:
 <TASK>
 ? __die_body+0x68/0xb0
 ? page_fault_oops+0x3a6/0x400
 ? exc_page_fault+0x7a/0x1b0
 ? asm_exc_page_fault+0x26/8x30
 ? bnxt_alloc_mem+0x1609/0x1910 [bnxt_en]
 ? bnxt_alloc_mem+0x1389/8x1918 [bnxt_en]
 _bnxt_open_nic+0x198/0xa50 [bnxt_en]
 ? bnxt_hurm_if_change+0x287/0x3d0 [bnxt_en]
 bnxt_open+0xeb/0x1b0 [bnxt_en]
 _dev_open+0x12e/0x1f0
 _dev_change_flags+0xb0/0x200
 dev_change_flags+0x25/0x60
 do_setlink+0x463/0x1260
 ? sock_def_readable+0x14/0xc0
 ? rtnl_getlink+0x4b9/0x590
 ? _nla_validate_parse+0x91/0xfa0
 rtnl_newlink+0xbac/0xe40
 <...>

Don't create a variable and dereference the first array member directly
since it's used only once in the code.

Fixes: ef4ee64e9990 ("bnxt_en: Define BNXT_VNIC_DEFAULT for the default vnic index")
Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 9968d67e6c77..a15e6d31fc22 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -5004,7 +5004,6 @@ static void bnxt_free_mem(struct bnxt *bp, bool irq_re_init)
 
 static int bnxt_alloc_mem(struct bnxt *bp, bool irq_re_init)
 {
-	struct bnxt_vnic_info *vnic0 = &bp->vnic_info[BNXT_VNIC_DEFAULT];
 	int i, j, rc, size, arr_size;
 	void *bnapi;
 
@@ -5133,8 +5132,9 @@ static int bnxt_alloc_mem(struct bnxt *bp, bool irq_re_init)
 	if (rc)
 		goto alloc_mem_err;
 
-	vnic0->flags |= BNXT_VNIC_RSS_FLAG | BNXT_VNIC_MCAST_FLAG |
-			BNXT_VNIC_UCAST_FLAG;
+	bp->vnic_info[BNXT_VNIC_DEFAULT].flags |= BNXT_VNIC_RSS_FLAG |
+						  BNXT_VNIC_MCAST_FLAG |
+						  BNXT_VNIC_UCAST_FLAG;
 	if (BNXT_SUPPORTS_NTUPLE_VNIC(bp) && (bp->flags & BNXT_FLAG_RFS))
 		bp->vnic_info[BNXT_VNIC_NTUPLE].flags |=
 			BNXT_VNIC_RSS_FLAG | BNXT_VNIC_NTUPLE_FLAG;
-- 
2.43.2


