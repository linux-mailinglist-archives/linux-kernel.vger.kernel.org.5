Return-Path: <linux-kernel+bounces-62662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F1CA852422
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 01:43:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59589283463
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 00:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32D71627F2;
	Tue, 13 Feb 2024 00:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DLwVkvXd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E8EF626A7;
	Tue, 13 Feb 2024 00:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707783696; cv=none; b=rdd0mB287HV7eL4G3Py45fwOaCEyB8ryfKaoQvX6QV66iNAU4MKw0qHd47UqAv4L4CptuDXebit6TWEKamgXS5MBu3kMsL8gdRlPDR74IuB7mujnS8vY5Gql0B1aHFwCz6pvydImf1n6cYIZ5W/2+A6vtj4gmMBFzZfXy6OoTzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707783696; c=relaxed/simple;
	bh=g2u1j3aPbsPh2d5A6m5TpM+/8oeyM+LqEmkbciEdN4A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nBxDZej6M6K00FtmnzhoDTh1zFr3cqjF8o7sErs0lEuRuk7tuPs93bSi/mljOxEe2LAHQCSCyObAfEBwaCdWdvAWDUXABugkdBbtHirtw0GHy94Nzyhgkp3F+vUsUClW5IGYC5nu0YYzSaUwIjbsqksJQn1Ock9pASxcpTCFOQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DLwVkvXd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 694A9C433F1;
	Tue, 13 Feb 2024 00:21:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707783695;
	bh=g2u1j3aPbsPh2d5A6m5TpM+/8oeyM+LqEmkbciEdN4A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DLwVkvXdshJA++ULZAs+bWFdHGzN8rP9AyCYVFD6DPoPB2qY76GhZP5MYpadTPv4p
	 D1758UrhWNzU3hyiqvvPyF0StSwc2NhgG3MPla7ug4xtIUwxlfjt53EM4AhKxEeYuj
	 WZwU91sVqqbs/JBjdSAfPEdeC3fBduqw1lxLYUIfGYN6hzXwelwDecmIt6tF3Yq/WP
	 0+sIPYqfQcOjPpScPOI7ysnaK5Oi/HVU1ngrFp9rkvuhvlyawSseoLbQm3mvSkQSYm
	 r89wEyLTNs1uNItlN/90R/XEW22GGFa4dViGiYrG9N2xJToLalQDpBPpzZkDyhr2zt
	 EnNoESKu7Ln6A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Alice Chao <alice.chao@mediatek.com>,
	Stanley Jhu <chu.stanley@gmail.com>,
	Bart Van Assche <bvanassche@acm.org>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>,
	jejb@linux.ibm.com,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	stanley.chu@mediatek.com,
	avri.altman@wdc.com,
	quic_cang@quicinc.com,
	quic_nguyenb@quicinc.com,
	peter.wang@mediatek.com,
	beanhuo@micron.com,
	manivannan.sadhasivam@linaro.org,
	quic_ziqichen@quicinc.com,
	athierry@redhat.com,
	linux-scsi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH AUTOSEL 6.6 31/51] scsi: ufs: core: Fix shift issue in ufshcd_clear_cmd()
Date: Mon, 12 Feb 2024 19:20:08 -0500
Message-ID: <20240213002052.670571-31-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240213002052.670571-1-sashal@kernel.org>
References: <20240213002052.670571-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.16
Content-Transfer-Encoding: 8bit

From: Alice Chao <alice.chao@mediatek.com>

[ Upstream commit b513d30d59bb383a6a5d6b533afcab2cee99a8f8 ]

When task_tag >= 32 (in MCQ mode) and sizeof(unsigned int) == 4, 1U <<
task_tag will out of bounds for a u32 mask. Fix this up to prevent
SHIFT_ISSUE (bitwise shifts that are out of bounds for their data type).

[name:debug_monitors&]Unexpected kernel BRK exception at EL1
[name:traps&]Internal error: BRK handler: 00000000f2005514 [#1] PREEMPT SMP
[name:mediatek_cpufreq_hw&]cpufreq stop DVFS log done
[name:mrdump&]Kernel Offset: 0x1ba5800000 from 0xffffffc008000000
[name:mrdump&]PHYS_OFFSET: 0x80000000
[name:mrdump&]pstate: 22400005 (nzCv daif +PAN -UAO)
[name:mrdump&]pc : [0xffffffdbaf52bb2c] ufshcd_clear_cmd+0x280/0x288
[name:mrdump&]lr : [0xffffffdbaf52a774] ufshcd_wait_for_dev_cmd+0x3e4/0x82c
[name:mrdump&]sp : ffffffc0081471b0
<snip>
Workqueue: ufs_eh_wq_0 ufshcd_err_handler
Call trace:
 dump_backtrace+0xf8/0x144
 show_stack+0x18/0x24
 dump_stack_lvl+0x78/0x9c
 dump_stack+0x18/0x44
 mrdump_common_die+0x254/0x480 [mrdump]
 ipanic_die+0x20/0x30 [mrdump]
 notify_die+0x15c/0x204
 die+0x10c/0x5f8
 arm64_notify_die+0x74/0x13c
 do_debug_exception+0x164/0x26c
 el1_dbg+0x64/0x80
 el1h_64_sync_handler+0x3c/0x90
 el1h_64_sync+0x68/0x6c
 ufshcd_clear_cmd+0x280/0x288
 ufshcd_wait_for_dev_cmd+0x3e4/0x82c
 ufshcd_exec_dev_cmd+0x5bc/0x9ac
 ufshcd_verify_dev_init+0x84/0x1c8
 ufshcd_probe_hba+0x724/0x1ce0
 ufshcd_host_reset_and_restore+0x260/0x574
 ufshcd_reset_and_restore+0x138/0xbd0
 ufshcd_err_handler+0x1218/0x2f28
 process_one_work+0x5fc/0x1140
 worker_thread+0x7d8/0xe20
 kthread+0x25c/0x468
 ret_from_fork+0x10/0x20

Signed-off-by: Alice Chao <alice.chao@mediatek.com>
Link: https://lore.kernel.org/r/20240205104905.24929-1-alice.chao@mediatek.com
Reviewed-by: Stanley Jhu <chu.stanley@gmail.com>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/ufs/core/ufshcd.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 44e0437bd19d..f6c83dcff8a8 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -2949,7 +2949,7 @@ bool ufshcd_cmd_inflight(struct scsi_cmnd *cmd)
  */
 static int ufshcd_clear_cmd(struct ufs_hba *hba, u32 task_tag)
 {
-	u32 mask = 1U << task_tag;
+	u32 mask;
 	unsigned long flags;
 	int err;
 
@@ -2967,6 +2967,8 @@ static int ufshcd_clear_cmd(struct ufs_hba *hba, u32 task_tag)
 		return 0;
 	}
 
+	mask = 1U << task_tag;
+
 	/* clear outstanding transaction before retry */
 	spin_lock_irqsave(hba->host->host_lock, flags);
 	ufshcd_utrl_clear(hba, mask);
-- 
2.43.0


