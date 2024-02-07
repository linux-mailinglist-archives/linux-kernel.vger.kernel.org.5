Return-Path: <linux-kernel+bounces-57225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD71084D552
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 23:05:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09F8A1C26976
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 22:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D83D314646A;
	Wed,  7 Feb 2024 21:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YP3bgd6B"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A1C136984;
	Wed,  7 Feb 2024 21:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707341267; cv=none; b=Wup9h+T9DjHr2b4i01rTj3V3/r082G/p18SjLW2gLwks5I89cGJG0aZLnCZG8nXkQ9qkyjjnMFf5a1nMPXbPvEB1DgSxF69ePRQGXejSbEIp0yz5jGAM1dccLCzeuheJRgc3Sy9+v3cuL+scj6RUmJWAbcCbcmyBChQFp45W3GE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707341267; c=relaxed/simple;
	bh=Vu7amYQlWzc2gJ5zlkyCD35RjnlQiWKoKLMQQOemOYc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rRsxh0EmKwLkEL4gj2gwNhocQ/LCD9tMTDmpoo1jZRj8wVWqNV2gQkqO95+PXxi+XbS4sOCnjsUMhh/I5UGujMscHhcmeRAfEf5FMwZcXoz+UOuOi8ZNBhYZXUVgPQOjMaT159Kb5N2HUBkwNBTwBEskP4S3I9z4+OVjaNbc5oQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YP3bgd6B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A356EC43399;
	Wed,  7 Feb 2024 21:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707341267;
	bh=Vu7amYQlWzc2gJ5zlkyCD35RjnlQiWKoKLMQQOemOYc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YP3bgd6Bk3iMW1azEgSYG9x1cM0Zne93QRlFSOeuIudC+FHN/+kS1bXqXKTT83vSB
	 WN8uZdkZpxkKkPaiE1Bn7Mq5d8EZTmgvTECdS1vlCegb+y96wwL3fCJS/CfKD40hZy
	 654GPczTQHzFKak5GN43eLntjEN73SHKPkE5/Yy3LEyzYQeRI8MBaVTbggtJRazM12
	 eRrhIuO+F6ihIJUrs7D5uBTznjAfRzSBa/uXtfPf5/KBSQnl/+6q0Y11DK49NrZPZg
	 WK/4Q0PXPWIUm7hgcJK+BROeW+6qOG9vrc5SAzAv9EEe5lfef1kuwunVZusRqVa6D5
	 3qQz2RBQQG4zg==
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
Subject: [PATCH AUTOSEL 5.4 7/7] nvmet-fc: abort command when there is no binding
Date: Wed,  7 Feb 2024 16:27:31 -0500
Message-ID: <20240207212732.4627-7-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207212732.4627-1-sashal@kernel.org>
References: <20240207212732.4627-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.268
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
index f74fc6481731..2dd39299fba0 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -796,6 +796,9 @@ nvmet_fc_alloc_target_assoc(struct nvmet_fc_tgtport *tgtport)
 	int idx;
 	bool needrandom = true;
 
+	if (!tgtport->pe)
+		return NULL;
+
 	assoc = kzalloc(sizeof(*assoc), GFP_KERNEL);
 	if (!assoc)
 		return NULL;
@@ -2180,8 +2183,9 @@ nvmet_fc_handle_fcp_rqst(struct nvmet_fc_tgtport *tgtport,
 
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


