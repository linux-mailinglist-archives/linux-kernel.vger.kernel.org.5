Return-Path: <linux-kernel+bounces-113910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA587888751
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:56:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B8FEB24240
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08079211D0A;
	Sun, 24 Mar 2024 23:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KEU5E9eb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B0A4149C57;
	Sun, 24 Mar 2024 22:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321004; cv=none; b=JtWXt1/WvwMoLVOTcxvMNb5yQt2XLK6mjGK3LcfKcfUBc4osckoPe8yiM+fpDxvymWeXdrMOY2iutudg6Y6no3UEG0EMEY/0bra8oHhKk/y4GiRF9PKdImDgNvILGNkyd2MsmXjxCjNfgrxsNlwKppSzSyFFxO78ilSmdE4itks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321004; c=relaxed/simple;
	bh=H2hNMM2t2VNMgNBMv77uz2X9DJy8Qm3/iWWXUBFqYuc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iVVdzAFKbb/bWo+3njcUqldqkJXTbQ5TIGvrtmhj1/rBsqGPqrchVF9DgtirNLpPkmAxvTlj3tNPIyKteGmT+ToAEUlwT9QUfeGRivweeqFxp//bB1gWd0FzfUmk74mSZ5Vcc56NtfOXT62/SwpSiBM7sA3bBuxUoCvK09Q4E7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KEU5E9eb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E74DC433C7;
	Sun, 24 Mar 2024 22:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321002;
	bh=H2hNMM2t2VNMgNBMv77uz2X9DJy8Qm3/iWWXUBFqYuc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KEU5E9eb1crG8P4iuxwSIeUuP7rrx83kLSSO/F107wb9Phyont72U+Nkdin9+YcYr
	 8xO8SxIAug8XMJIRP8xIeecwPhyLV516sq7QbENSD/2BHeHlPrvc4xwPExJQlaSnxN
	 RSr9dWXnTOcAIpJIsxtbhozB2kT662tJcBZqM7R14uyO2mRAsziOdLjewdf9nEt6Un
	 TMpSsd/8J33VIFcJJ0Vwup7NaJerXcXJU7/8ZFWFif+ZpzfKVLODmu5X35lxdhNRX3
	 AEaj5Vz9xa9PTOq6uQwsSZn6Xi94epeFCn54ne06I+63P2w/AIIe/L/WrCkUkQFdxy
	 O08WtsqmqBBlQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Mustafa Ismail <mustafa.ismail@intel.com>,
	Shiraz Saleem <shiraz.saleem@intel.com>,
	Sindhu Devale <sindhu.devale@intel.com>,
	Leon Romanovsky <leon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 565/713] RDMA/irdma: Remove duplicate assignment
Date: Sun, 24 Mar 2024 18:44:51 -0400
Message-ID: <20240324224720.1345309-566-sashal@kernel.org>
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


