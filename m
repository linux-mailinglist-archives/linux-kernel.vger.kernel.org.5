Return-Path: <linux-kernel+bounces-114610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1271888B4D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:45:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E37B01C292E9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC91E15E201;
	Sun, 24 Mar 2024 23:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xe0BJqEV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB15233167;
	Sun, 24 Mar 2024 23:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322268; cv=none; b=Su16JxSxe9GebDG4Yf/8QmlAjZcRo/JqpBsp4iAWahV4CrmR0bAhaF6GNZQFW/4AZnyRqNuv6ZZtxKXXuoJdV6bndYh+SIsJxV0Ih4/WISPtCu1EikiXyh6aGJgT2OqXOJtzGfOflmXqkK41bcb0cvzfJ6hW/J+Jzmg3y3MvV7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322268; c=relaxed/simple;
	bh=vME7K5eAEv5eFGI7Yz5w5s+epa0I0sTu8tiSmu0265I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nQuYtu0ci+2dXbhYActTldWH38ClNjojHPOit8z+j/Wy1SJb2RhwFH053Keh/PvMChSWXw0shxresr2Cc+/AilBfVvp1fpP2GvGSj5BR1Bld3nyGIYHEu5VSrkbxFu0WA52ShEORIHeHzXnbti5DPNGA6r1sxUjpmGI3XZdahmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xe0BJqEV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE67EC43390;
	Sun, 24 Mar 2024 23:17:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322267;
	bh=vME7K5eAEv5eFGI7Yz5w5s+epa0I0sTu8tiSmu0265I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Xe0BJqEVGsOenUbHHyFTFTf6fetkcDfKaF4N/l9OGdcvnhzdJcU0NmA5zFMLm64IX
	 69P3kNfVTDotIkzfk25iB9IEV6pDfY/ZjKfTqtqoy5oqaNcI8NmHYVpexXrKQooXMu
	 vN3MhUfHVE6BH+6iFlK5Hm/COcCSOfP8gtsQSyDgacUmqmbr3vai4OJpE/ZShJIMdD
	 mhyRe+nHE2BqIFBmUTAHQNrS3BLbwfYaLujaWHELXrwMgh1QmlMcvnWGS4te2BGfvx
	 MqwxW2aBxrE9mOl6nfYvwvNhgBW3PLT/8IIonjSvZFiFYBZU8Xzh4X6T+7/eC7uJde
	 bVBU79lsBVcTg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Mustafa Ismail <mustafa.ismail@intel.com>,
	Shiraz Saleem <shiraz.saleem@intel.com>,
	Sindhu Devale <sindhu.devale@intel.com>,
	Leon Romanovsky <leon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 350/451] RDMA/irdma: Remove duplicate assignment
Date: Sun, 24 Mar 2024 19:10:26 -0400
Message-ID: <20240324231207.1351418-351-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
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
index bb423849968d9..76c5f461faca0 100644
--- a/drivers/infiniband/hw/irdma/verbs.c
+++ b/drivers/infiniband/hw/irdma/verbs.c
@@ -716,7 +716,6 @@ static int irdma_setup_kmode_qp(struct irdma_device *iwdev,
 		info->rq_pa + (ukinfo->rq_depth * IRDMA_QP_WQE_MIN_SIZE);
 	ukinfo->sq_size = ukinfo->sq_depth >> ukinfo->sq_shift;
 	ukinfo->rq_size = ukinfo->rq_depth >> ukinfo->rq_shift;
-	ukinfo->qp_id = iwqp->ibqp.qp_num;
 
 	iwqp->max_send_wr = (ukinfo->sq_depth - IRDMA_SQ_RSVD) >> ukinfo->sq_shift;
 	iwqp->max_recv_wr = (ukinfo->rq_depth - IRDMA_RQ_RSVD) >> ukinfo->rq_shift;
@@ -941,7 +940,7 @@ static int irdma_create_qp(struct ib_qp *ibqp,
 	iwqp->host_ctx.size = IRDMA_QP_CTX_SIZE;
 
 	init_info.pd = &iwpd->sc_pd;
-	init_info.qp_uk_init_info.qp_id = iwqp->ibqp.qp_num;
+	init_info.qp_uk_init_info.qp_id = qp_num;
 	if (!rdma_protocol_roce(&iwdev->ibdev, 1))
 		init_info.qp_uk_init_info.first_sq_wq = 1;
 	iwqp->ctx_info.qp_compl_ctx = (uintptr_t)qp;
-- 
2.43.0


