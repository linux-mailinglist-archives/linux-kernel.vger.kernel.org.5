Return-Path: <linux-kernel+bounces-33362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBF90836934
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:56:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F843B21246
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 15:47:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1C65487BD;
	Mon, 22 Jan 2024 15:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U2NnDphU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E0AC67E82;
	Mon, 22 Jan 2024 15:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705935975; cv=none; b=ViDyHrfFziY+vGTEhWKP/LIpXHOEzvVVuGrFhTy/l4BOLjP06qUa7YRb88oj2rQKniSV3v/dRPr6zcbZVgLpOYnRNQimmohxBTGqO1bBRRXnVqE00UMp2psyTmoIr+yb7ZSGKFYqhhdDq859b9P+Hyw0rAUZusAbg3/J/3hO5fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705935975; c=relaxed/simple;
	bh=LKTSZOGSaxq2ddTyAl0YeKbC+oAsCIrtnkAvoJDLljQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YoA38ZcFh8g8pU8QPcBNiV0h48OMguoxCDrWTYg8Xc4ffiXz+6JUvsyyPVsKmMiaifq+bODeEZeFbdHKJx+0vCjSmvqTD33D5+yZKAn7/cLpHB19NP8YNafp3UGsxi4Tx1U3dYTg3R4dAJmI4LoMKAcnyBwChwNlUD649eovTwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U2NnDphU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBD85C433A6;
	Mon, 22 Jan 2024 15:06:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705935974;
	bh=LKTSZOGSaxq2ddTyAl0YeKbC+oAsCIrtnkAvoJDLljQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=U2NnDphUESzzfBySXeStlCLV9nKp1tA3rMIqGZyzA4IZJnKiOz8hlheUXWIYMCz8r
	 OxhQ5tN6zw9D2D35gtfDcWOxS/e+KexmBjx6aY0IvjRXsEDh0eIivFx6lEyVEoKBNh
	 Pcj0fKBPk0dT6nxn65JLCXwTsGaQkUoGR6t7Y2oa4BpYkxz69ex4YXIj50IkIP55q1
	 2c/HAPvXOTMFciS4SaMpesjB9D9YBSLtXWDB321T0YOMaqA2W40Om1XRpJrRILl6YK
	 FSE5OkeJKC3PumEy/Ge9d6pQVu63/cIW43irVl3eOzmnhxxiSfdeOM0txoOw9bD5CH
	 ia5t3q3Ak4P5A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ming Qian <ming.qian@nxp.com>,
	Xiaolei Wang <xiaolei.wang@windriver.com>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Sasha Levin <sashal@kernel.org>,
	eagle.zhou@nxp.com,
	mchehab@kernel.org,
	linux-media@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 40/73] media: amphion: remove mutext lock in condition of wait_event
Date: Mon, 22 Jan 2024 10:01:54 -0500
Message-ID: <20240122150432.992458-40-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122150432.992458-1-sashal@kernel.org>
References: <20240122150432.992458-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.13
Content-Transfer-Encoding: 8bit

From: Ming Qian <ming.qian@nxp.com>

[ Upstream commit f9c8ddce2fe3b767582f299d03fc8fb85943568c ]

mutext_lock should not be called in condition of wait_event, otherwise,
when CONFIG_DEBUG_ATOMIC_SLEEP is enabled, we may meet the following
warning:
do not call blocking ops when !TASK_RUNNING; state=2
WARNING: CPU: 5 PID: 741 at kernel/sched/core.c:9859
__might_sleep+0x80/0xa4
Hardware name: Freescale i.MX8QM MEK (DT)
pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)  pc :
__might_sleep+0x80/0xa4  lr : __might_sleep+0x80/0xa4  sp : ffffffc0123738a0
x29: ffffffc0123738a0 x28: ffffffc009194c48 x27: ffffffc00bbc1050
x26: ffffff8814b282f0 x25: ffffff8814b280d0 x24: ffffff8814b28080
x23: 0000000000000001 x22: 0000000000000032 x21: ffffffc00bbc1000
x20: 000000000000011b x19: ffffffc009324670 x18: 00000000fffffffd
x17: 30303c5b20746120 x16: 74657320323d6574 x15: 617473203b474e49
x14: 00058b5b8b9aa1f1 x13: ffffffc00903cda0 x12: 00000000d744fcc9
x11: 000000000000001c x10: 00000000000009a0 x9 : ffffffc0090201f4
x8 : ffffff8828245000 x7 : 0000000000000001 x6 : 0000000000000001
x5 : 00000000410fd080 x4 : 0000000000000002 x3 : ffffff8815aab4c8
x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffffff8828244600
Call trace:
 __might_sleep+0x80/0xa4
 mutex_lock+0x2c/0x80
 sync_session_response+0x110/0x310
 vpu_session_send_cmd+0x18c/0x244
 vpu_session_start+0x38/0x70
 vdec_start_session+0x1b4/0x3e0
 vpu_vb2_start_streaming+0xa0/0x1c4
 vb2_start_streaming+0x74/0x160
 vb2_core_qbuf+0x488/0x650
 vb2_qbuf+0x9c/0x100
 v4l2_m2m_qbuf+0x7c/0x224
 v4l2_m2m_ioctl_qbuf+0x20/0x2c
 v4l_qbuf+0x50/0x6c
 __video_do_ioctl+0x174/0x3f0
 video_usercopy+0x210/0x7cc
 video_ioctl2+0x20/0x30
 v4l2_ioctl+0x48/0x6c

we need to refine check_is_responsed() to remove the mutext_lock, each
cmd has a monotonically increasing id, and cmds are executed
sequentially, so we can check the id of the last reponsed cmd, then
determine whether a command has been responded or not.

Signed-off-by: Ming Qian <ming.qian@nxp.com>
CC: Xiaolei Wang <xiaolei.wang@windriver.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/amphion/vpu.h      |  3 ++-
 drivers/media/platform/amphion/vpu_cmds.c | 28 ++++++++---------------
 drivers/media/platform/amphion/vpu_v4l2.c |  1 +
 3 files changed, 12 insertions(+), 20 deletions(-)

diff --git a/drivers/media/platform/amphion/vpu.h b/drivers/media/platform/amphion/vpu.h
index 5a701f64289e..0246cf0ac3a8 100644
--- a/drivers/media/platform/amphion/vpu.h
+++ b/drivers/media/platform/amphion/vpu.h
@@ -154,7 +154,6 @@ struct vpu_core {
 	struct vpu_mbox tx_type;
 	struct vpu_mbox tx_data;
 	struct vpu_mbox rx;
-	unsigned long cmd_seq;
 
 	wait_queue_head_t ack_wq;
 	struct completion cmp;
@@ -253,6 +252,8 @@ struct vpu_inst {
 
 	struct list_head cmd_q;
 	void *pending;
+	unsigned long cmd_seq;
+	atomic_long_t last_response_cmd;
 
 	struct vpu_inst_ops *ops;
 	const struct vpu_format *formats;
diff --git a/drivers/media/platform/amphion/vpu_cmds.c b/drivers/media/platform/amphion/vpu_cmds.c
index c2337812573e..5695f5c1cb3e 100644
--- a/drivers/media/platform/amphion/vpu_cmds.c
+++ b/drivers/media/platform/amphion/vpu_cmds.c
@@ -32,6 +32,7 @@ struct vpu_cmd_t {
 	struct vpu_cmd_request *request;
 	struct vpu_rpc_event *pkt;
 	unsigned long key;
+	atomic_long_t *last_response_cmd;
 };
 
 static struct vpu_cmd_request vpu_cmd_requests[] = {
@@ -115,6 +116,8 @@ static void vpu_free_cmd(struct vpu_cmd_t *cmd)
 {
 	if (!cmd)
 		return;
+	if (cmd->last_response_cmd)
+		atomic_long_set(cmd->last_response_cmd, cmd->key);
 	vfree(cmd->pkt);
 	vfree(cmd);
 }
@@ -172,7 +175,8 @@ static int vpu_request_cmd(struct vpu_inst *inst, u32 id, void *data,
 		return -ENOMEM;
 
 	mutex_lock(&core->cmd_lock);
-	cmd->key = core->cmd_seq++;
+	cmd->key = ++inst->cmd_seq;
+	cmd->last_response_cmd = &inst->last_response_cmd;
 	if (key)
 		*key = cmd->key;
 	if (sync)
@@ -246,26 +250,12 @@ void vpu_clear_request(struct vpu_inst *inst)
 
 static bool check_is_responsed(struct vpu_inst *inst, unsigned long key)
 {
-	struct vpu_core *core = inst->core;
-	struct vpu_cmd_t *cmd;
-	bool flag = true;
+	unsigned long last_response = atomic_long_read(&inst->last_response_cmd);
 
-	mutex_lock(&core->cmd_lock);
-	cmd = inst->pending;
-	if (cmd && key == cmd->key) {
-		flag = false;
-		goto exit;
-	}
-	list_for_each_entry(cmd, &inst->cmd_q, list) {
-		if (key == cmd->key) {
-			flag = false;
-			break;
-		}
-	}
-exit:
-	mutex_unlock(&core->cmd_lock);
+	if (key <= last_response && (last_response - key) < (ULONG_MAX >> 1))
+		return true;
 
-	return flag;
+	return false;
 }
 
 static int sync_session_response(struct vpu_inst *inst, unsigned long key, long timeout, int try)
diff --git a/drivers/media/platform/amphion/vpu_v4l2.c b/drivers/media/platform/amphion/vpu_v4l2.c
index 0f6e4c666440..d7e0de49b3dc 100644
--- a/drivers/media/platform/amphion/vpu_v4l2.c
+++ b/drivers/media/platform/amphion/vpu_v4l2.c
@@ -716,6 +716,7 @@ int vpu_v4l2_open(struct file *file, struct vpu_inst *inst)
 		func = &vpu->decoder;
 
 	atomic_set(&inst->ref_count, 0);
+	atomic_long_set(&inst->last_response_cmd, 0);
 	vpu_inst_get(inst);
 	inst->vpu = vpu;
 	inst->core = vpu_request_core(vpu, inst->type);
-- 
2.43.0


