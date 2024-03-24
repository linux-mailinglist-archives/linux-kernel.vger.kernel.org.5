Return-Path: <linux-kernel+bounces-113461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E86888849D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:46:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52F7FB21D39
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:42:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62D031B16D5;
	Sun, 24 Mar 2024 22:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d62P8tl6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87DB81B16BA;
	Sun, 24 Mar 2024 22:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320262; cv=none; b=hLgShUrry4nb/k6WI6HJiBW8qQLxuQSkzHoRUpWdx7252vkVr4Hk6UsKQI0Xu9bDHIwR5lgcClyPTbe6be4kXSdGNVz7Y2x68aYu8+hcptYDTVNqmsvI6UcRoGcUWIyTpfd2a/gsGNHSxq1ZtmOrQNWwpTj2Jotrj4XH4TEBw0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320262; c=relaxed/simple;
	bh=tvr6kTmhbZ3h56f2WbWt45CJd1mLr8noobwId+SR7mM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a440W0ugimiqVB9kYCwydlzaWkN1OpHcvW04sjCO/oP6CbcC+xap2+L5vJxhb3O1i34CyNVabodsaCorvcuDNY3Ae8kxJll93sxObykIr6SlioB4WukY5J2STk6DyTnuuk3QOqSfiepxU2GtcQpZnlKRY4owTGUlJIXTK8Xq2Ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d62P8tl6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B13D2C43390;
	Sun, 24 Mar 2024 22:44:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320262;
	bh=tvr6kTmhbZ3h56f2WbWt45CJd1mLr8noobwId+SR7mM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d62P8tl6tKN76GAnTbdoHKEDrU/UmUE0jWcQcMwFkeCyGtUj4ICLTTgOc0438znIh
	 cSO67/XXNcm+iHYluRkWyJ4ZIHs8Gc4ALN4Nt26zuC4arXCw4TUApWf6tRJeJx3MR+
	 7GuMa2dJuKdr+cgwuy1EeaDwT+yTEAMBSfgyri0EUi/eZOou285RmRnA9RolRiuctU
	 ugvdeJ6g2p3aYJlXkOD1s6NxnpecuzX+HG3SsPjf/toamIl97IaGQr1nE0bf/m8c8i
	 mWGgInqb5UUjTG2Xp9E0ntHZj6UpekuvwTu8Kg7h3zcFsAtfhy8gYqgnM3TuNS/9HK
	 K/csn45aiJCXw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Luoyouming <luoyouming@huawei.com>,
	Junxian Huang <huangjunxian6@hisilicon.com>,
	Leon Romanovsky <leon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 570/715] RDMA/hns: Fix mis-modifying default congestion control algorithm
Date: Sun, 24 Mar 2024 18:32:29 -0400
Message-ID: <20240324223455.1342824-571-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Luoyouming <luoyouming@huawei.com>

[ Upstream commit d20a7cf9f714f0763efb56f0f2eeca1cb91315ed ]

Commit 27c5fd271d8b ("RDMA/hns: The UD mode can only be configured
with DCQCN") adds a check of congest control alorithm for UD. But
that patch causes a problem: hr_dev->caps.congest_type is global,
used by all QPs, so modifying this field to DCQCN for UD QPs causes
other QPs unable to use any other algorithm except DCQCN.

Revert the modification in commit 27c5fd271d8b ("RDMA/hns: The UD
mode can only be configured with DCQCN"). Add a new field cong_type
to struct hns_roce_qp and configure DCQCN for UD QPs.

Fixes: 27c5fd271d8b ("RDMA/hns: The UD mode can only be configured with DCQCN")
Fixes: f91696f2f053 ("RDMA/hns: Support congestion control type selection according to the FW")
Signed-off-by: Luoyouming <luoyouming@huawei.com>
Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
Link: https://lore.kernel.org/r/20240219061805.668170-1-huangjunxian6@hisilicon.com
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/hns/hns_roce_device.h | 17 +++++++++--------
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 16 ++++++++++------
 2 files changed, 19 insertions(+), 14 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index b1fce5ddf6316..46f8a631093ba 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -585,6 +585,13 @@ struct hns_roce_work {
 	u32 queue_num;
 };
 
+enum hns_roce_cong_type {
+	CONG_TYPE_DCQCN,
+	CONG_TYPE_LDCP,
+	CONG_TYPE_HC3,
+	CONG_TYPE_DIP,
+};
+
 struct hns_roce_qp {
 	struct ib_qp		ibqp;
 	struct hns_roce_wq	rq;
@@ -628,6 +635,7 @@ struct hns_roce_qp {
 	struct list_head	sq_node; /* all send qps are on a list */
 	struct hns_user_mmap_entry *dwqe_mmap_entry;
 	u32			config;
+	enum hns_roce_cong_type	cong_type;
 };
 
 struct hns_roce_ib_iboe {
@@ -699,13 +707,6 @@ struct hns_roce_eq_table {
 	struct hns_roce_eq	*eq;
 };
 
-enum cong_type {
-	CONG_TYPE_DCQCN,
-	CONG_TYPE_LDCP,
-	CONG_TYPE_HC3,
-	CONG_TYPE_DIP,
-};
-
 struct hns_roce_caps {
 	u64		fw_ver;
 	u8		num_ports;
@@ -835,7 +836,7 @@ struct hns_roce_caps {
 	u16		default_aeq_period;
 	u16		default_aeq_arm_st;
 	u16		default_ceq_arm_st;
-	enum cong_type	cong_type;
+	enum hns_roce_cong_type cong_type;
 };
 
 enum hns_roce_device_state {
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 8206daea6767d..34e58e09b15d8 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -4745,12 +4745,15 @@ static int check_cong_type(struct ib_qp *ibqp,
 			   struct hns_roce_congestion_algorithm *cong_alg)
 {
 	struct hns_roce_dev *hr_dev = to_hr_dev(ibqp->device);
+	struct hns_roce_qp *hr_qp = to_hr_qp(ibqp);
 
-	if (ibqp->qp_type == IB_QPT_UD)
-		hr_dev->caps.cong_type = CONG_TYPE_DCQCN;
+	if (ibqp->qp_type == IB_QPT_UD || ibqp->qp_type == IB_QPT_GSI)
+		hr_qp->cong_type = CONG_TYPE_DCQCN;
+	else
+		hr_qp->cong_type = hr_dev->caps.cong_type;
 
 	/* different congestion types match different configurations */
-	switch (hr_dev->caps.cong_type) {
+	switch (hr_qp->cong_type) {
 	case CONG_TYPE_DCQCN:
 		cong_alg->alg_sel = CONG_DCQCN;
 		cong_alg->alg_sub_sel = UNSUPPORT_CONG_LEVEL;
@@ -4778,8 +4781,8 @@ static int check_cong_type(struct ib_qp *ibqp,
 	default:
 		ibdev_warn(&hr_dev->ib_dev,
 			   "invalid type(%u) for congestion selection.\n",
-			   hr_dev->caps.cong_type);
-		hr_dev->caps.cong_type = CONG_TYPE_DCQCN;
+			   hr_qp->cong_type);
+		hr_qp->cong_type = CONG_TYPE_DCQCN;
 		cong_alg->alg_sel = CONG_DCQCN;
 		cong_alg->alg_sub_sel = UNSUPPORT_CONG_LEVEL;
 		cong_alg->dip_vld = DIP_INVALID;
@@ -4798,6 +4801,7 @@ static int fill_cong_field(struct ib_qp *ibqp, const struct ib_qp_attr *attr,
 	struct hns_roce_congestion_algorithm cong_field;
 	struct ib_device *ibdev = ibqp->device;
 	struct hns_roce_dev *hr_dev = to_hr_dev(ibdev);
+	struct hns_roce_qp *hr_qp = to_hr_qp(ibqp);
 	u32 dip_idx = 0;
 	int ret;
 
@@ -4810,7 +4814,7 @@ static int fill_cong_field(struct ib_qp *ibqp, const struct ib_qp_attr *attr,
 		return ret;
 
 	hr_reg_write(context, QPC_CONG_ALGO_TMPL_ID, hr_dev->cong_algo_tmpl_id +
-		     hr_dev->caps.cong_type * HNS_ROCE_CONG_SIZE);
+		     hr_qp->cong_type * HNS_ROCE_CONG_SIZE);
 	hr_reg_clear(qpc_mask, QPC_CONG_ALGO_TMPL_ID);
 	hr_reg_write(&context->ext, QPCEX_CONG_ALG_SEL, cong_field.alg_sel);
 	hr_reg_clear(&qpc_mask->ext, QPCEX_CONG_ALG_SEL);
-- 
2.43.0


