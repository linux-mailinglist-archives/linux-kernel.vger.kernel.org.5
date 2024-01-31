Return-Path: <linux-kernel+bounces-46407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C1BB843F42
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 13:14:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D9A31F21418
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 12:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 243067995B;
	Wed, 31 Jan 2024 12:14:47 +0000 (UTC)
Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE4F978676
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 12:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706703282; cv=none; b=aCUb3oPvy4Yku5po3Znpb93ilDhq6s9pj3bwGMrg2G5/V4XlboJCq5UlGUkYBYonaOtFRGY+MRaeTq/zmgpg3sBL0lnmFdLtSFSMZwD8nOHh5kTon3BY//3La0HyPg07/0ot8uizTBvDAskmiF6OjxcTg386Tw3Kl9zugzduTqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706703282; c=relaxed/simple;
	bh=Q0wV+TnItOkEHfIiIhxUFssbDbFUQK4VKdx1sKcggrI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cq1KQty6iK0cmY9e6arFPTlpGafWMR2uUkgVjz+XUkZgB05EEM4WQa+Nt/yzKaJZ55gRMvJNCnU9LKY7rEFXZ7kb0sJp9gFJ/QGwnrHz66hWlUdUGeQP4BrSrbTXcK9WprLPHrh2VivrPoMema46blEWDUOwUaamxRlB8wK6ias=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 40VCE6du013504;
	Wed, 31 Jan 2024 20:14:06 +0800 (+08)
	(envelope-from zhaoyang.huang@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx01.spreadtrum.com [10.0.64.7])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4TQ13T1Q8Jz2SjW7v;
	Wed, 31 Jan 2024 20:06:29 +0800 (CST)
Received: from bj03382pcu01.spreadtrum.com (10.0.73.40) by
 BJMBX01.spreadtrum.com (10.0.64.7) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Wed, 31 Jan 2024 20:14:04 +0800
From: "zhaoyang.huang" <zhaoyang.huang@unisoc.com>
To: Damien Le Moal <dlemoal@kernel.org>,
        Niklas Cassel
	<niklas.cassel@wdc.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Hannes Reinecke <hare@suse.de>, <linux-kernel@vger.kernel.org>,
        Zhaoyang
 Huang <huangzhaoyang@gmail.com>, <steve.kang@unisoc.com>
Subject: [PATCH 1/1] block: print warning when invalid domain set to ioprio
Date: Wed, 31 Jan 2024 20:14:01 +0800
Message-ID: <20240131121401.3898735-1-zhaoyang.huang@unisoc.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHCAS01.spreadtrum.com (10.0.1.201) To
 BJMBX01.spreadtrum.com (10.0.64.7)
X-MAIL:SHSQR01.spreadtrum.com 40VCE6du013504

From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>

Since few caller check IOPRIO_PRIO_VALUE's return value and bio_set_prio
is a open macro to set bio->ioprio directly.It is confused for the developer
who run across kernel panic[1] but can find nothing in previous kernel log.
Add a pr_err here to dump the information.

[1]
Here is the kernel panic I run across which caused by a out of bounds check
introduced by CONFIG_FOTIFY_SOURCE.

[exception_serialno]:
[exception_kernel_version]:
[exception_reboot_reason]: kernel_crash
[exception_panic_reason]: UBSAN: array index out of bounds: Fatal exception
[exception_time]: 1970-01-01_08-00-23
[exception_file_info]: not-bugon
[exception_task_id]: 409
[exception_task_family]: [f2fs_ckpt-254:4, 409][kthreadd, 2]
[exception_pc_symbol]: [<ffffffc080736974>] dd_request_merge+0x100/0x110
[exception_stack_info]: [<ffffffc07a27e274>] get_exception_stack_info+0x124/0x2d8 [sysdump]gc
[<ffffffc07a27e670>] prepare_exception_info+0x158/0x1d4 [sysdump]gc
[<ffffffc07a280128>] sysdump_panic_event+0x5d8/0x748 [sysdump]gc
[<ffffffc08016a508>] notifier_call_chain+0x98/0x17cgc
[<ffffffc08016a9b4>] atomic_notifier_call_chain+0x44/0x68gc
[<ffffffc0810f0eb4>] panic+0x194/0x37cgc
[<ffffffc0800a638c>] die+0x300/0x310gc
[<ffffffc0800a77e8>] ubsan_handler+0x34/0x4cgc
[<ffffffc0800960a8>] brk_handler+0x9c/0x11cgc
[<ffffffc0800bf998>] do_debug_exception+0xb0/0x140gc
[<ffffffc0810f8bf0>] el1_dbg+0x58/0x74gc
[<ffffffc0810f89f4>] el1h_64_sync_handler+0x3c/0x90gc
[<ffffffc080091298>] el1h_64_sync+0x68/0x6cgc
[<ffffffc080736974>] dd_request_merge+0x100/0x110gc   //out of bound
here caused by the value of class transferred from ioprio
[<ffffffc080707f28>] elv_merge+0x248/0x270gc
[<ffffffc0807146e8>] blk_mq_sched_try_merge+0x4c/0x20cgc
[<ffffffc080736824>] dd_bio_merge+0x64/0xb4gc
[<ffffffc080723e3c>] blk_mq_sched_bio_merge+0x68/0x144gc
[<ffffffc08071b944>] blk_mq_submit_bio+0x2e8/0x6c0gc
[<ffffffc08070dd3c>] __submit_bio+0xbc/0x1b0gc
[<ffffffc08070c440>] submit_bio_noacct_nocheck+0xe4/0x2f0gc
[<ffffffc08070c8e4>] submit_bio_noacct+0x298/0x3d8gc
[<ffffffc08070caf8>] submit_bio+0xd4/0xf0gc
[<ffffffc080642644>] f2fs_submit_write_bio+0xcc/0x49cgc
[<ffffffc0806442d4>] __submit_merged_bio+0x48/0x13cgc
[<ffffffc080641de4>] __submit_merged_write_cond+0x18c/0x1f8gc
[<ffffffc080641c4c>] f2fs_submit_merged_write+0x2c/0x38
[<ffffffc080655724>] f2fs_sync_node_pages+0x6e0/0x740gc
[<ffffffc08063946c>] f2fs_write_checkpoint+0x4c0/0x97cgc
[<ffffffc08063b37c>] __checkpoint_and_complete_reqs+0x88/0x248gc
[<ffffffc08063ad70>] issue_checkpoint_thread+0x94/0xf4gc
[<ffffffc080167c20>] kthread+0x110/0x1b8gc

Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
---
 include/uapi/linux/ioprio.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/ioprio.h b/include/uapi/linux/ioprio.h
index bee2bdb0eedb..73c420a0df72 100644
--- a/include/uapi/linux/ioprio.h
+++ b/include/uapi/linux/ioprio.h
@@ -112,8 +112,11 @@ static __always_inline __u16 ioprio_value(int prioclass, int priolevel,
 {
 	if (IOPRIO_BAD_VALUE(prioclass, IOPRIO_NR_CLASSES) ||
 	    IOPRIO_BAD_VALUE(priolevel, IOPRIO_NR_LEVELS) ||
-	    IOPRIO_BAD_VALUE(priohint, IOPRIO_NR_HINTS))
+	    IOPRIO_BAD_VALUE(priohint, IOPRIO_NR_HINTS)) {
+		pr_err("%s: get a invalid domain in class %d, level %d, hint %d\n",
+			__func__, prioclass, priolevel, priohint);
 		return IOPRIO_CLASS_INVALID << IOPRIO_CLASS_SHIFT;
+	}
 
 	return (prioclass << IOPRIO_CLASS_SHIFT) |
 		(priohint << IOPRIO_HINT_SHIFT) | priolevel;
-- 
2.25.1


