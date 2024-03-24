Return-Path: <linux-kernel+bounces-113930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5545788876B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:00:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8FD91F25E3E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70852216167;
	Sun, 24 Mar 2024 23:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X7y75FhX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A67AE12C532;
	Sun, 24 Mar 2024 22:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321020; cv=none; b=aYDBhuhfwzLXc477p0g2YPUUU/CInkCJEUtmCFmAw96xNeiFsepH7z9FuMu4yoCnu6DWZ7N9Ef2pjVowfK5k5iKfUAB5HF4wgV4h82YXdvZI1W7OJeTzW8ym8rHvMhSEzPSfe/04Q1XlLdFOYkORBCQ3br+4JkIumRhA+bD8/W0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321020; c=relaxed/simple;
	bh=d4d70dx4mY4TtK4N2jcZedJwT75E082k/GEnjjKrmuo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cOK5KKpH2u0ezx/goZIl01dqECoCbdmE7r0L850feOPYY230WswUM1/PVAiPSvgMYReAZAIp2RQTiGRU/4Et6iIbQfI/Wg3hyJi0SFzmKjwjx3DIFJCkKMsbd6GsY3bdlMDxnTYHHaf9QBs58CEP+r2sqe4zSfFsrO7s6zAK+WI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X7y75FhX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCD7BC43399;
	Sun, 24 Mar 2024 22:56:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321019;
	bh=d4d70dx4mY4TtK4N2jcZedJwT75E082k/GEnjjKrmuo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=X7y75FhXvxxJNLJjp3sFKXOdEmnNuUvjnQfkODYyq/YGzMkZw59/5GnLrDTIgu7EP
	 obB+vS8+mIwe7G1v1YJ6gr/y+KvAN1Mda92zBafBHA7RlXocbpuFBiCH9lZP0dWt/l
	 5QhQi7VBpIhPdmkFBULvIyNYCrgC50bOfxPW2KeEnFftynDtR5KtaOX3nw8Jduo5wD
	 QF46+cv832sJhv167a4rRGdFNDLlQ96kgKwHHFoIEIbgehlFB6HWybq3dmPeKSMvdr
	 eWyWiM5FyCCx+Gb5mmyxEsW5sAsuMT6xeISeVtbtP9GkYGJVnvJq1WYZvgMFble+Ey
	 hxB87HMgHLzfA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Luoyouming <luoyouming@huawei.com>,
	Junxian Huang <huangjunxian6@hisilicon.com>,
	Leon Romanovsky <leon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 582/713] RDMA/hns: Fix mis-modifying default congestion control algorithm
Date: Sun, 24 Mar 2024 18:45:08 -0400
Message-ID: <20240324224720.1345309-583-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
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
index 1627f3b0ef28b..f08417d3721dc 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -584,6 +584,13 @@ struct hns_roce_work {
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
@@ -627,6 +634,7 @@ struct hns_roce_qp {
 	struct list_head	sq_node; /* all send qps are on a list */
 	struct hns_user_mmap_entry *dwqe_mmap_entry;
 	u32			config;
+	enum hns_roce_cong_type	cong_type;
 };
 
 struct hns_roce_ib_iboe {
@@ -698,13 +706,6 @@ struct hns_roce_eq_table {
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
@@ -834,7 +835,7 @@ struct hns_roce_caps {
 	u16		default_aeq_period;
 	u16		default_aeq_arm_st;
 	u16		default_ceq_arm_st;
-	enum cong_type	cong_type;
+	enum hns_roce_cong_type cong_type;
 };
 
 enum hns_roce_device_state {
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index aa9527ac2fe06..81d6d4331cdd6 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -4733,12 +4733,15 @@ static int check_cong_type(struct ib_qp *ibqp,
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
@@ -4766,8 +4769,8 @@ static int check_cong_type(struct ib_qp *ibqp,
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
@@ -4786,6 +4789,7 @@ static int fill_cong_field(struct ib_qp *ibqp, const struct ib_qp_attr *attr,
 	struct hns_roce_congestion_algorithm cong_field;
 	struct ib_device *ibdev = ibqp->device;
 	struct hns_roce_dev *hr_dev = to_hr_dev(ibdev);
+	struct hns_roce_qp *hr_qp = to_hr_qp(ibqp);
 	u32 dip_idx = 0;
 	int ret;
 
@@ -4798,7 +4802,7 @@ static int fill_cong_field(struct ib_qp *ibqp, const struct ib_qp_attr *attr,
 		return ret;
 
 	hr_reg_write(context, QPC_CONG_ALGO_TMPL_ID, hr_dev->cong_algo_tmpl_id +
-		     hr_dev->caps.cong_type * HNS_ROCE_CONG_SIZE);
+		     hr_qp->cong_type * HNS_ROCE_CONG_SIZE);
 	hr_reg_clear(qpc_mask, QPC_CONG_ALGO_TMPL_ID);
 	hr_reg_write(&context->ext, QPCEX_CONG_ALG_SEL, cong_field.alg_sel);
 	hr_reg_clear(&qpc_mask->ext, QPCEX_CONG_ALG_SEL);
-- 
2.43.0


