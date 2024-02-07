Return-Path: <linux-kernel+bounces-57104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D774084D40F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 22:33:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8854B1F23825
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 21:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53CCC13C1D2;
	Wed,  7 Feb 2024 21:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g06LgTFy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E08813C1C7;
	Wed,  7 Feb 2024 21:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707340993; cv=none; b=mMMcX3a1Q/Apzr5fFhPvupJDQPYIay2IQuu76ulXwDCBKkqsTyusTCun1g6FO2BjjnBT41zQfP1URMy2/wRIs7TyyiQ9JHiD9kuFUEhDGAO+mfUlDyoa4u4ioiimUdPXzUrDSRHDAe/PZ9FUDo5FKYjI47GWIztUIQDni9bBmnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707340993; c=relaxed/simple;
	bh=LT+L/7PYPwDnnATDNcJq2+vE/jlPYOwwnStBT/2zcO8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=et5aLxVzHXPii1mDlVx1RLadOTmSOhGBWLBmoNvefjRdmCfCu0NuvQ8L299/k+0VDSVVJUwaIkDU7TsoZU9N+LT6wBTfWyome4Ddu1y7tAlJVjuyRrHZbmhfTMVQXEHeflXTCBXjkwtkTTdIyZuhZNRR+ZylWUNY3DasvuZYm2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g06LgTFy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18DD8C433F1;
	Wed,  7 Feb 2024 21:23:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707340993;
	bh=LT+L/7PYPwDnnATDNcJq2+vE/jlPYOwwnStBT/2zcO8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=g06LgTFy0VTEgAFfDGEI4hHgPrqz+FTMPaQ9IAVcjG0YuykWaE/Fa8a0CsiNlxcpI
	 Kj0/aQ/yZAZWyHUsI1J/+37Si8YTBUz1kMWbbA5UsQ1y2gWu0vG7c2bKBQZ3um/Hy2
	 8VUWFgigyPvtvQgMZpqEAC8QnOPxaIgcLr9wzVDooC63MrlO3k2MrB9ZFwor+ZmFkF
	 CKlCVjqlGig+seSC2Ylv62iYi6G1PxDbu6kUfVTIj4lvaXFLnQ11jHLCCez7BITQ4v
	 SlBjTbC4VexvAILFMJ+v+qd19jEhLDnsqYoiLOm0PWUnp5mkutb5k9vISGDUuUtSPU
	 MEznaTwqGlgwg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Daniel Wagner <dwagner@suse.de>,
	Hannes Reinecke <hare@suse.de>,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	james.smart@broadcom.com,
	sagi@grimberg.me,
	kch@nvidia.com,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.7 38/44] nvmet-fc: abort command when there is no binding
Date: Wed,  7 Feb 2024 16:21:05 -0500
Message-ID: <20240207212142.1399-38-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207212142.1399-1-sashal@kernel.org>
References: <20240207212142.1399-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.4
Content-Transfer-Encoding: 8bit

From: Daniel Wagner <dwagner@suse.de>

[ Upstream commit 3146345c2e9c2f661527054e402b0cfad80105a4 ]

When the target port has not active port binding, there is no point in
trying to process the command as it has to fail anyway. Instead adding
checks to all commands abort the command early.

Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Daniel Wagner <dwagner@suse.de>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/target/fc.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index d50af99e847d..1eda4fa0ae06 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -1100,6 +1100,9 @@ nvmet_fc_alloc_target_assoc(struct nvmet_fc_tgtport *tgtport, void *hosthandle)
 	int idx;
 	bool needrandom = true;
 
+	if (!tgtport->pe)
+		return NULL;
+
 	assoc = kzalloc(sizeof(*assoc), GFP_KERNEL);
 	if (!assoc)
 		return NULL;
@@ -2516,8 +2519,9 @@ nvmet_fc_handle_fcp_rqst(struct nvmet_fc_tgtport *tgtport,
 
 	fod->req.cmd = &fod->cmdiubuf.sqe;
 	fod->req.cqe = &fod->rspiubuf.cqe;
-	if (tgtport->pe)
-		fod->req.port = tgtport->pe->port;
+	if (!tgtport->pe)
+		goto transport_error;
+	fod->req.port = tgtport->pe->port;
 
 	/* clear any response payload */
 	memset(&fod->rspiubuf, 0, sizeof(fod->rspiubuf));
-- 
2.43.0


