Return-Path: <linux-kernel+bounces-114380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D35DC888A1F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:11:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D913290911
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AB682716A4;
	Sun, 24 Mar 2024 23:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pg5g3174"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B57217E05;
	Sun, 24 Mar 2024 23:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321781; cv=none; b=I9eeaoy3zsUZl2/f6oHqufxk9rnCADsKSNeI3TO6PXmPZvQ+tuC+kBbB8wo43yPnamdhIcDT65vmNREU8Pw/lCOOs1oU/DAxouLKEPcd7g/10t3cKq089GCsCsQKeSL6eFiCSK/nmJFTqvdSGP2SHTtK7N6z7kpwaGXvD2sPU38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321781; c=relaxed/simple;
	bh=Nq/1J7cAFfxLhMkKfL+OgxXajCbPPICS93POMZRo9rA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X+7NOy1XLxaSch/oihMUpuq24JN7I+BVH65w6PN4aJ037byHyVIOjw2sUapGaCmobhW7WyTZmhYpSe+Kvpl+tM2Ilz8YGbvYcWU0Y1QUJiLTYiO0D89pJ81kL4c/k99uuoNOIK0QBVDW+Y9c0bm7vIm72dJnrLn81s2tcKE5BYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pg5g3174; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F10FAC43394;
	Sun, 24 Mar 2024 23:09:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321779;
	bh=Nq/1J7cAFfxLhMkKfL+OgxXajCbPPICS93POMZRo9rA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pg5g3174rwK9N5IXIRpxyKaeRet5/qC6dw1RKIyDl7lR4M9MKapx5ISG+4KPFTE+R
	 VfXmh+30qxn//yK85DxBFM5mSCN3wkCC/V1WyggqyzdEulOdIAVYGXNE/t2kYrC0JN
	 la+25RWQOcXBYSEUtfvG8SnlU081dt7LpxXSLY1cjy6vHH9bQ/uZAv/WB1c+82vSev
	 fxMMX+3q12mXoJcsNdBUyxHhh4af/5sjKtZ++ZXU5A+irK3FXWJNYsjpKawspmpk+M
	 /EjE8BivbQp2UZEJ7gvn4Al0eEAPlJtDONDPk+mP5DOcTq4qgU+zJr7oZ9R2CaR0ba
	 OqdDfbYnXrSOQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Mustafa Ismail <mustafa.ismail@intel.com>,
	Shiraz Saleem <shiraz.saleem@intel.com>,
	Sindhu Devale <sindhu.devale@intel.com>,
	Leon Romanovsky <leon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 507/638] RDMA/irdma: Remove duplicate assignment
Date: Sun, 24 Mar 2024 18:59:04 -0400
Message-ID: <20240324230116.1348576-508-sashal@kernel.org>
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
index 60618b2046b97..ca3e89909ecf4 100644
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


