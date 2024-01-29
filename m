Return-Path: <linux-kernel+bounces-42530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC39E8402B8
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 11:23:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C36B282942
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 10:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8788057864;
	Mon, 29 Jan 2024 10:23:20 +0000 (UTC)
Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E71757302
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 10:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706523800; cv=none; b=PgKZbt+gvIto8FhjtvXIQAXU5+GXJF9mi0TEucgCHx7N/zj+hT7hQ2ln8JOXr/g/TF18y6v4PmMZY0ZmnUf+lkN8zmdJG9uZDcCcUZ/9C2IXRJcjhPyX3fQjcFk7HYFAdhJIgwLMu1AM6zMsW1Gfy5kFQpzpj9dxWFuhQ3G/WFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706523800; c=relaxed/simple;
	bh=6uQRtxfwHI6lbSKM3KACvgqQQaO9b8pFw4vx06rzZ/U=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VfdrsqF549MpfJSAjt/IDeotDXE1EUM65eD6Y6G4i1LYcEJFrz8KIA5OUvEm1wnpEkYreNXrlum9FOxDyaHAFocDmYC24W99ZQtIEMc5IFduOmac1NRGITNRb/nAWMrObjM4q38KcYomjDlJiony+j/ZWntPjzRd6KxVAR2IEdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 40TAMIU1022567;
	Mon, 29 Jan 2024 18:22:18 +0800 (+08)
	(envelope-from Zhiguo.Niu@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx02.spreadtrum.com [10.0.64.8])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4TNkgT6m5Qz2R5Td1;
	Mon, 29 Jan 2024 18:14:45 +0800 (CST)
Received: from bj08434pcu.spreadtrum.com (10.0.73.87) by
 BJMBX02.spreadtrum.com (10.0.64.8) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Mon, 29 Jan 2024 18:22:17 +0800
From: Zhiguo Niu <zhiguo.niu@unisoc.com>
To: <jaegeuk@kernel.org>, <chao@kernel.org>
CC: <linux-f2fs-devel@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>,
        <niuzhiguo84@gmail.com>, <zhiguo.niu@unisoc.com>, <ke.wang@unisoc.com>,
        <hongyu.jin@unisoc.com>
Subject: [PATCH 2/3] f2fs: fix panic issue in update_sit_entry
Date: Mon, 29 Jan 2024 18:22:01 +0800
Message-ID: <1706523721-24657-1-git-send-email-zhiguo.niu@unisoc.com>
X-Mailer: git-send-email 1.9.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SHCAS01.spreadtrum.com (10.0.1.201) To
 BJMBX02.spreadtrum.com (10.0.64.8)
X-MAIL:SHSQR01.spreadtrum.com 40TAMIU1022567

When CONFIG_F2FS_CHECK_FS is not enabled, f2fs_bug_on just printing
warning, get_new_segment may get an out-of-bounds segment when there
is no free segments. Then a block is allocated from this invalid
segment, update_sit_entry will access the invalid bitmap address,
cause system panic. Just as below call stack:

f2fs_allocate_data_block get a block address with 0x4000 and
partition size is 64MB

[   13.401997] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
[   13.402003] Mem abort info:
[   13.402006]   ESR = 0x96000005
[   13.402009]   EC = 0x25: DABT (current EL), IL = 32 bits
[   13.402015]   SET = 0, FnV = 0
[   13.402018]   EA = 0, S1PTW = 0
[   13.402021]   FSC = 0x05: level 1 translation fault
[   13.402025] Data abort info:
[   13.402027]   ISV = 0, ISS = 0x00000005
[   13.402030]   CM = 0, WnR = 0
[   13.402034] user pgtable: 4k pages, 39-bit VAs, pgdp=00000001066ab000
[   13.402038] [0000000000000000] pgd=0000000000000000, p4d=0000000000000000, pud=0000000000000000
[   13.402052] Internal error: Oops: 96000005 [#1] PREEMPT SMP
[   13.489854] pc : update_sit_entry+0x128/0x420
[   13.490497] lr : f2fs_allocate_data_block+0x6b0/0xc2c
[   13.491218] sp : ffffffc00e023440
[   13.501530] Call trace:
[   13.501930]  update_sit_entry+0x128/0x420
[   13.502523]  f2fs_allocate_data_block+0x6b0/0xc2c
[   13.503203]  do_write_page+0xf0/0x1d4
[   13.503752]  f2fs_outplace_write_data+0x68/0xfc
[   13.504408]  f2fs_do_write_data_page+0x3a8/0x65c
[   13.505076]  move_data_page+0x294/0x7a8
[   13.505647]  gc_data_segment+0x4b8/0x800
[   13.506229]  do_garbage_collect+0x354/0x674
[   13.506843]  f2fs_gc+0x280/0x68c
[   13.507340]  f2fs_balance_fs+0x104/0x144
[   13.507921]  f2fs_create+0x310/0x3d8
[   13.508458]  path_openat+0x53c/0xc28
[   13.508997]  do_filp_open+0xbc/0x16c
[   13.509535]  do_sys_openat2+0xa0/0x2a0

So sanity check should be add in update_sit_entry.
Also remove some redundant judgment code.

Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
---
 fs/f2fs/segment.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index ad6511f..f373ff7 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -2399,6 +2399,8 @@ static void update_sit_entry(struct f2fs_sb_info *sbi, block_t blkaddr, int del)
 #endif
 
 	segno = GET_SEGNO(sbi, blkaddr);
+	if (segno == NULL_SEGNO)
+		return;
 
 	se = get_seg_entry(sbi, segno);
 	new_vblocks = se->valid_blocks + del;
@@ -3464,8 +3466,7 @@ void f2fs_allocate_data_block(struct f2fs_sb_info *sbi, struct page *page,
 	 * since SSR needs latest valid block information.
 	 */
 	update_sit_entry(sbi, *new_blkaddr, 1);
-	if (GET_SEGNO(sbi, old_blkaddr) != NULL_SEGNO)
-		update_sit_entry(sbi, old_blkaddr, -1);
+	update_sit_entry(sbi, old_blkaddr, -1);
 
 	/*
 	 * If the current segment is full, flush it out and replace it with a
-- 
1.9.1


