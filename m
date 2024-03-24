Return-Path: <linux-kernel+bounces-113448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0537B88846A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:39:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98D2E1F219AB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37C371AE053;
	Sun, 24 Mar 2024 22:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZPpMDAdq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 628DA1AE038;
	Sun, 24 Mar 2024 22:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320250; cv=none; b=cl4xwjzz7Po4vZCLBmrkgkI06DM5UpqriT8gKz/hW9vHAE/rtMmGyQHobp5orbbHy71PsAPRDNJ6WCb8irgJhQqxlpIcAu19mhMHHSOLHTWwvIIXjW7AWkFAe/0b1Vvk9SXnvFz7gG5ZPbDh/iZk9xgHf84FnHOTwX3VKfAKcV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320250; c=relaxed/simple;
	bh=H2hNMM2t2VNMgNBMv77uz2X9DJy8Qm3/iWWXUBFqYuc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OVzjyPFf+OV7zOgr06BpzZMpWqFZ5eNbwtk06i8p+/oZhLE+p/q6Fm8pjsAAXx76f7iamUafl93Y9s9pS/b2l3kZf7uVC+M9fN6YM1ykZWys5zl4dml+1WhiPzVTUfItWpKekIOnkyFKHHJQHTb4/RRGLk7hZDuZ7Ez+pmhvhqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZPpMDAdq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19436C433F1;
	Sun, 24 Mar 2024 22:44:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320249;
	bh=H2hNMM2t2VNMgNBMv77uz2X9DJy8Qm3/iWWXUBFqYuc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZPpMDAdqQsggQ/MFVH8kTey9g8akEt5icGf7iGiVDuMe5jD3KrTXOIi1JVKl1VLDI
	 iZ17XhLAKnesUMdPLEtiQetfvWeT43jfVVdDIGWc0Sblgh014UxprTkwDjuTb2WUPP
	 nDIPwc2NW/fWnX4lyhbWV1P1Wc+tBYt7p+nfeYy+DB6+8dH5frzMAcO5SwJjHhLsvY
	 I4tgarGxAkU2d3qppKxxcMgu/RsrwJVxCSbp9Iq8Z3mDwhItwbi6sierxUuilaxCxh
	 W18wEEYPofgafasPFPn6/d1LkB3O0VodlfPWkxl6/m+jobm+PJPGBLEK+lVCYlFi4R
	 QkvG0+IbfYSNg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Mustafa Ismail <mustafa.ismail@intel.com>,
	Shiraz Saleem <shiraz.saleem@intel.com>,
	Sindhu Devale <sindhu.devale@intel.com>,
	Leon Romanovsky <leon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 557/715] RDMA/irdma: Remove duplicate assignment
Date: Sun, 24 Mar 2024 18:32:16 -0400
Message-ID: <20240324223455.1342824-558-sashal@kernel.org>
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

From: Mustafa Ismail <mustafa.ismail@intel.com>

[ Upstream commit 926e8ea4b8dac84f6d14a4b60d0653f1f2ba9431 ]

Remove the unneeded assignment of the qp_num which is already
set in irdma_create_qp().

Fixes: b48c24c2d710 ("RDMA/irdma: Implement device supported verb APIs")
Signed-off-by: Mustafa Ismail <mustafa.ismail@intel.com>
Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
Signed-off-by: Sindhu Devale <sindhu.devale@intel.com>
Link: https://lore.kernel.org/r/20240131233953.400483-1-sindhu.devale@intel.com
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/irdma/verbs.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
index 0b046c061742b..12704efb7b19a 100644
--- a/drivers/infiniband/hw/irdma/verbs.c
+++ b/drivers/infiniband/hw/irdma/verbs.c
@@ -719,7 +719,6 @@ static int irdma_setup_kmode_qp(struct irdma_device *iwdev,
 		info->rq_pa + (ukinfo->rq_depth * IRDMA_QP_WQE_MIN_SIZE);
 	ukinfo->sq_size = ukinfo->sq_depth >> ukinfo->sq_shift;
 	ukinfo->rq_size = ukinfo->rq_depth >> ukinfo->rq_shift;
-	ukinfo->qp_id = iwqp->ibqp.qp_num;
 
 	iwqp->max_send_wr = (ukinfo->sq_depth - IRDMA_SQ_RSVD) >> ukinfo->sq_shift;
 	iwqp->max_recv_wr = (ukinfo->rq_depth - IRDMA_RQ_RSVD) >> ukinfo->rq_shift;
@@ -944,7 +943,7 @@ static int irdma_create_qp(struct ib_qp *ibqp,
 	iwqp->host_ctx.size = IRDMA_QP_CTX_SIZE;
 
 	init_info.pd = &iwpd->sc_pd;
-	init_info.qp_uk_init_info.qp_id = iwqp->ibqp.qp_num;
+	init_info.qp_uk_init_info.qp_id = qp_num;
 	if (!rdma_protocol_roce(&iwdev->ibdev, 1))
 		init_info.qp_uk_init_info.first_sq_wq = 1;
 	iwqp->ctx_info.qp_compl_ctx = (uintptr_t)qp;
-- 
2.43.0


