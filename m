Return-Path: <linux-kernel+bounces-57198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 626FF84D509
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 22:58:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F506287D8B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 21:58:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60D15129A63;
	Wed,  7 Feb 2024 21:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Klkow8DW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B5856930E;
	Wed,  7 Feb 2024 21:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707341208; cv=none; b=fri5PWdg5rquW+G+2HZRslsOZ9VfnspOfm8+hDnolgRi+5Ye8JlrRX9lGKaU8qm+U9KevSStt7+nrfavna0qA7884UZfi97u+9+54lvL3XxCUJiHtudOqgKutgyO1ullgi4Q3j1aSigCOC3Cpauqd4QlN8wqTV0O2Zvr54vB2Y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707341208; c=relaxed/simple;
	bh=FviiJagCBZHb7Fvg7aMwogccBrc+Iw0X+SEhpBKYDRs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DapCHCl665+SeQh+mYPhquF5G0nrjUmpTXxIP3fjb3ljX3MH0uHmPrmUP9xouRJnkZkELJlskWZdyCLiJ8vu8vyYFlSZ89TYaAWd2yOOmf/+MH2J4koeDDudPaFAK63tK3KYIktdf8pnPB6uS7PFwWO3f45gVv+KfJa0otc3Ri8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Klkow8DW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0CC8C43399;
	Wed,  7 Feb 2024 21:26:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707341208;
	bh=FviiJagCBZHb7Fvg7aMwogccBrc+Iw0X+SEhpBKYDRs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Klkow8DWj2l+l6g8t7cJtHbPLswe3/6XBVldT+hqaDMrxEbqIN96fFZoQMvDpnSwC
	 oDpDStARz++JH4Z2fG+fp7OPAHhyffmOWf3dOTqBBhiGzEGWzfwGLGIxps6H6YrwwY
	 HVXhhbTCIunNFztTvpO6r/pYfxjvkrU0nrjqYmYx4gqsLQD3HTlFYI14XIXCSi9UPR
	 C8qXpF/rShymz59eqKtz+tR/njei/xjwQk1A8Vp6jMyDqiFBhzaTyGrqtrzZzKnsBf
	 Qe+CD0FBJPaLu5T2W96Y5/WdzfSgu7ZCOWnlWFMaEBeDxiv3l1CbTxtxIbsJL8GMGf
	 oBVJpRVby7A9A==
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
Subject: [PATCH AUTOSEL 5.15 19/23] nvmet-fc: abort command when there is no binding
Date: Wed,  7 Feb 2024 16:26:00 -0500
Message-ID: <20240207212611.3793-19-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207212611.3793-1-sashal@kernel.org>
References: <20240207212611.3793-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.148
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
index 06d11bb7b944..20d3013be08a 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -1101,6 +1101,9 @@ nvmet_fc_alloc_target_assoc(struct nvmet_fc_tgtport *tgtport, void *hosthandle)
 	int idx;
 	bool needrandom = true;
 
+	if (!tgtport->pe)
+		return NULL;
+
 	assoc = kzalloc(sizeof(*assoc), GFP_KERNEL);
 	if (!assoc)
 		return NULL;
@@ -2523,8 +2526,9 @@ nvmet_fc_handle_fcp_rqst(struct nvmet_fc_tgtport *tgtport,
 
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


