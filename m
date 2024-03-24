Return-Path: <linux-kernel+bounces-115725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E30AD889746
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:12:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 820E51F37733
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCB7636294B;
	Mon, 25 Mar 2024 02:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S0U4fWA0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9000113F004;
	Sun, 24 Mar 2024 23:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321796; cv=none; b=qjVyZwI7fEjUBIxzpQwIUB0IyU1ey824UhonX6HdQ3gogeU0CuRliLa16h2a7I8tOGcRewQdCrZY9hN3OSuum7THJM8oGYTUA0VmeeLlJFwxmYazgPhme9e1SRfbZmr36rpE/V4oryiWTn4VqojqXGykc5Q8Wb7OJNS7/1L0Y4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321796; c=relaxed/simple;
	bh=2487uyEWYMiG1zqA3cbS9DBoal7pOEM20MTlnBXdtQY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=amETzBBl/x7NCFDZ8B236vRqxuX9D0QI9/qGniUkm4VMfBGca/QvZCqBPPWo2WuQgnwaVbMmVW1ePMSAYoUvy6EC4cLZTuOKfNyFshcaWXZ9eEld7keNoryFsJZuxZvs+9R1voY7q0Oca6mpY5mB26wKDdUY1NXVwOZYlhZ57zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S0U4fWA0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA352C43394;
	Sun, 24 Mar 2024 23:09:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321796;
	bh=2487uyEWYMiG1zqA3cbS9DBoal7pOEM20MTlnBXdtQY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=S0U4fWA0LPXuTLCt2UbIeyqYg0+hO2SfZiKz1lZR+kYgv5OIr3VBhhKFJ7nY25Rp0
	 /hwJi+tXJVb4q8H3YoNqTYYHuX9q0swBtqJqcYtK0WY8nytVj4KYmieMVVwzws6Xn5
	 xwi9+7z9mZ6PZCILK/gXTadKnlgz7K8Fwk84lsNGtZ3RUH27FqNWpzo+4Uyrn1x1g8
	 5oCcVCiv8HgW5MDjTx1iFG3eENaST8AcAuUt9S+vysyH2zFvl647o8oEK5+XlLHwvt
	 wcCadyOkTK29KvzyOYM856n5pua6G+PAHZMwwpL20Ctq2U6EWGimLTYav7k6LbP/Z1
	 4HGW4JGFajd7Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Luoyouming <luoyouming@huawei.com>,
	Junxian Huang <huangjunxian6@hisilicon.com>,
	Leon Romanovsky <leon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 524/638] RDMA/hns: Fix mis-modifying default congestion control algorithm
Date: Sun, 24 Mar 2024 18:59:21 -0400
Message-ID: <20240324230116.1348576-525-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
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
index 7f0d0288beb1e..82066859cc113 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -581,6 +581,13 @@ struct hns_roce_work {
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
@@ -624,6 +631,7 @@ struct hns_roce_qp {
 	struct list_head	sq_node; /* all send qps are on a list */
 	struct hns_user_mmap_entry *dwqe_mmap_entry;
 	u32			config;
+	enum hns_roce_cong_type	cong_type;
 };
 
 struct hns_roce_ib_iboe {
@@ -695,13 +703,6 @@ struct hns_roce_eq_table {
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
@@ -831,7 +832,7 @@ struct hns_roce_caps {
 	u16		default_aeq_period;
 	u16		default_aeq_arm_st;
 	u16		default_ceq_arm_st;
-	enum cong_type	cong_type;
+	enum hns_roce_cong_type cong_type;
 };
 
 enum hns_roce_device_state {
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 3c62a0042da48..b4799c83282e2 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -4728,12 +4728,15 @@ static int check_cong_type(struct ib_qp *ibqp,
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
@@ -4761,8 +4764,8 @@ static int check_cong_type(struct ib_qp *ibqp,
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
@@ -4781,6 +4784,7 @@ static int fill_cong_field(struct ib_qp *ibqp, const struct ib_qp_attr *attr,
 	struct hns_roce_congestion_algorithm cong_field;
 	struct ib_device *ibdev = ibqp->device;
 	struct hns_roce_dev *hr_dev = to_hr_dev(ibdev);
+	struct hns_roce_qp *hr_qp = to_hr_qp(ibqp);
 	u32 dip_idx = 0;
 	int ret;
 
@@ -4793,7 +4797,7 @@ static int fill_cong_field(struct ib_qp *ibqp, const struct ib_qp_attr *attr,
 		return ret;
 
 	hr_reg_write(context, QPC_CONG_ALGO_TMPL_ID, hr_dev->cong_algo_tmpl_id +
-		     hr_dev->caps.cong_type * HNS_ROCE_CONG_SIZE);
+		     hr_qp->cong_type * HNS_ROCE_CONG_SIZE);
 	hr_reg_clear(qpc_mask, QPC_CONG_ALGO_TMPL_ID);
 	hr_reg_write(&context->ext, QPCEX_CONG_ALG_SEL, cong_field.alg_sel);
 	hr_reg_clear(&qpc_mask->ext, QPCEX_CONG_ALG_SEL);
-- 
2.43.0


