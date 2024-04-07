Return-Path: <linux-kernel+bounces-134428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA0EB89B15F
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 15:21:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32F4CB21A60
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 13:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F9A96A028;
	Sun,  7 Apr 2024 13:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YMXnVBU+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 757D069E07;
	Sun,  7 Apr 2024 13:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712495522; cv=none; b=XwRGjYVBfelFjxK8MbMkguGli0bNalFsf/0aU4Om5M3VOa7Q5IpTV02MuSz3dwSkSPMV16HDYq0ibgKlZ88BoxmBNQlaQ9vWFe82QCt8w480YZzZPwG89XqmUw52rbw0QRt8iX1ljsExPyh0VeFJHvXegcVuFtWIcGSS3D6IVDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712495522; c=relaxed/simple;
	bh=MYI9hucmJjrC1y+/yT6Q0wmTFDq0qLdPEo07FDuWJbg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XanrQG1nwFQ3nIem0XLUYKkFcExPIEi4DpFQFEJzq0hactlJcu65fQeiTdjARhGA139ZDRejS8WAfZe4hVDxWpsHJ2UQ0NVgAQAPBWXUICdBqvlGyCV+BajC8kDFqo/FnvsSqDTOOk08qFSBBoE/9avgskpvK3oPlmcuY8NEe3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YMXnVBU+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3089EC43609;
	Sun,  7 Apr 2024 13:12:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712495522;
	bh=MYI9hucmJjrC1y+/yT6Q0wmTFDq0qLdPEo07FDuWJbg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YMXnVBU+6sVPMJIcPfbs0ttnESkorf/ygds70n+gtOaJrDDqQ7plrNxVAyiwJ3ohK
	 3tc+xR/Q8syMsULoXApYnl1frkn4a1kZgOlhLyYCbe1lnhxqpGcmUZCv3R2kWMgx80
	 +4jM3Dn9c2yYn7cq821CJtTF7e5iFORJPQBmVaMFk/kLXYUq+cWeRML/zUwU2sj/Zg
	 f5cFkgaefw3KwQAIp2j7/ifDac19a4eDRY0HWLwICEeggRuYBE2Kl/lRCi9B4lSTyl
	 7z0P69YUxGknt7FIykWpoY2lq2cFcnnVFqsju+A43+sLZfDTT1BPzfjk14uZQlzxEa
	 CTiNH8u6cXMPA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Saurav Kashyap <skashyap@marvell.com>,
	Guangwu Zhang <guazhang@redhat.com>,
	Nilesh Javali <njavali@marvell.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>,
	jhasan@marvell.com,
	GR-QLogic-Storage-Upstream@marvell.com,
	jejb@linux.ibm.com,
	linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.8 18/25] scsi: bnx2fc: Remove spin_lock_bh while releasing resources after upload
Date: Sun,  7 Apr 2024 09:11:06 -0400
Message-ID: <20240407131130.1050321-18-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240407131130.1050321-1-sashal@kernel.org>
References: <20240407131130.1050321-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.4
Content-Transfer-Encoding: quoted-printable

From: Saurav Kashyap <skashyap@marvell.com>

[ Upstream commit c214ed2a4dda35b308b0b28eed804d7ae66401f9 ]

The session resources are used by FW and driver when session is offloaded,
once session is uploaded these resources are not used. The lock is not
required as these fields won't be used any longer. The offload and upload
calls are sequential, hence lock is not required.

This will suppress following BUG_ON():

[  449.843143] ------------[ cut here ]------------
[  449.848302] kernel BUG at mm/vmalloc.c:2727!
[  449.853072] invalid opcode: 0000 [#1] PREEMPT SMP PTI
[  449.858712] CPU: 5 PID: 1996 Comm: kworker/u24:2 Not tainted 5.14.0-118.=
el9.x86_64 #1
Rebooting.
[  449.867454] Hardware name: Dell Inc. PowerEdge R730/0WCJNT, BIOS 2.3.4 1=
1/08/2016
[  449.876966] Workqueue: fc_rport_eq fc_rport_work [libfc]
[  449.882910] RIP: 0010:vunmap+0x2e/0x30
[  449.887098] Code: 00 65 8b 05 14 a2 f0 4a a9 00 ff ff 00 75 1b 55 48 89 =
fd e8 34 36 79 00 48 85 ed 74 0b 48 89 ef 31 f6 5d e9 14 fc ff ff 5d c3 <0f=
> 0b 0f 1f 44 00 00 41 57 41 56 49 89 ce 41 55 49 89 fd 41 54 41
[  449.908054] RSP: 0018:ffffb83d878b3d68 EFLAGS: 00010206
[  449.913887] RAX: 0000000080000201 RBX: ffff8f4355133550 RCX: 000000000d4=
00005
[  449.921843] RDX: 0000000000000001 RSI: 0000000000001000 RDI: ffffb83da53=
f5000
[  449.929808] RBP: ffff8f4ac6675800 R08: ffffb83d878b3d30 R09: 00000000000=
efbdf
[  449.937774] R10: 0000000000000003 R11: ffff8f434573e000 R12: 00000000000=
01000
[  449.945736] R13: 0000000000001000 R14: ffffb83da53f5000 R15: ffff8f43d4e=
a3ae0
[  449.953701] FS:  0000000000000000(0000) GS:ffff8f529fc80000(0000) knlGS:=
0000000000000000
[  449.962732] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  449.969138] CR2: 00007f8cf993e150 CR3: 0000000efbe10003 CR4: 00000000003=
706e0
[  449.977102] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000000000=
00000
[  449.985065] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 00000000000=
00400
[  449.993028] Call Trace:
[  449.995756]  __iommu_dma_free+0x96/0x100
[  450.000139]  bnx2fc_free_session_resc+0x67/0x240 [bnx2fc]
[  450.006171]  bnx2fc_upload_session+0xce/0x100 [bnx2fc]
[  450.011910]  bnx2fc_rport_event_handler+0x9f/0x240 [bnx2fc]
[  450.018136]  fc_rport_work+0x103/0x5b0 [libfc]
[  450.023103]  process_one_work+0x1e8/0x3c0
[  450.027581]  worker_thread+0x50/0x3b0
[  450.031669]  ? rescuer_thread+0x370/0x370
[  450.036143]  kthread+0x149/0x170
[  450.039744]  ? set_kthread_struct+0x40/0x40
[  450.044411]  ret_from_fork+0x22/0x30
[  450.048404] Modules linked in: vfat msdos fat xfs nfs_layout_nfsv41_file=
s rpcsec_gss_krb5 auth_rpcgss nfsv4 dns_resolver dm_service_time qedf qed c=
rc8 bnx2fc libfcoe libfc scsi_transport_fc intel_rapl_msr intel_rapl_common=
 x86_pkg_temp_thermal intel_powerclamp dcdbas rapl intel_cstate intel_uncor=
e mei_me pcspkr mei ipmi_ssif lpc_ich ipmi_si fuse zram ext4 mbcache jbd2 l=
oop nfsv3 nfs_acl nfs lockd grace fscache netfs irdma ice sd_mod t10_pi sg =
ib_uverbs ib_core 8021q garp mrp stp llc mgag200 i2c_algo_bit drm_kms_helpe=
r syscopyarea sysfillrect sysimgblt mxm_wmi fb_sys_fops cec crct10dif_pclmu=
l ahci crc32_pclmul bnx2x drm ghash_clmulni_intel libahci rfkill i40e libat=
a megaraid_sas mdio wmi sunrpc lrw dm_crypt dm_round_robin dm_multipath dm_=
snapshot dm_bufio dm_mirror dm_region_hash dm_log dm_zero dm_mod linear rai=
d10 raid456 async_raid6_recov async_memcpy async_pq async_xor async_tx raid=
6_pq libcrc32c crc32c_intel raid1 raid0 iscsi_ibft squashfs be2iscsi bnx2i =
cnic uio cxgb4i cxgb4 tls
[  450.048497]  libcxgbi libcxgb qla4xxx iscsi_boot_sysfs iscsi_tcp libiscs=
i_tcp libiscsi scsi_transport_iscsi edd ipmi_devintf ipmi_msghandler
[  450.159753] ---[ end trace 712de2c57c64abc8 ]---

Reported-by: Guangwu Zhang <guazhang@redhat.com>
Signed-off-by: Saurav Kashyap <skashyap@marvell.com>
Signed-off-by: Nilesh Javali <njavali@marvell.com>
Link: https://lore.kernel.org/r/20240315071427.31842-1-skashyap@marvell.com
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/bnx2fc/bnx2fc_tgt.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/scsi/bnx2fc/bnx2fc_tgt.c b/drivers/scsi/bnx2fc/bnx2fc_=
tgt.c
index 2c246e80c1c4d..d91659811eb3c 100644
--- a/drivers/scsi/bnx2fc/bnx2fc_tgt.c
+++ b/drivers/scsi/bnx2fc/bnx2fc_tgt.c
@@ -833,7 +833,6 @@ static void bnx2fc_free_session_resc(struct bnx2fc_hba =
*hba,
=20
 	BNX2FC_TGT_DBG(tgt, "Freeing up session resources\n");
=20
-	spin_lock_bh(&tgt->cq_lock);
 	ctx_base_ptr =3D tgt->ctx_base;
 	tgt->ctx_base =3D NULL;
=20
@@ -889,7 +888,6 @@ static void bnx2fc_free_session_resc(struct bnx2fc_hba =
*hba,
 				    tgt->sq, tgt->sq_dma);
 		tgt->sq =3D NULL;
 	}
-	spin_unlock_bh(&tgt->cq_lock);
=20
 	if (ctx_base_ptr)
 		iounmap(ctx_base_ptr);
--=20
2.43.0


