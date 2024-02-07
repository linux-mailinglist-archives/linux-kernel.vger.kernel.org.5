Return-Path: <linux-kernel+bounces-57216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 06AF684D537
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 23:03:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A4D0B2109D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 22:03:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D92C8142C52;
	Wed,  7 Feb 2024 21:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hO0HVvZT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BCAA14367E;
	Wed,  7 Feb 2024 21:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707341247; cv=none; b=MQuUQF7nYjgLwdxhnPJ3c7dx2W1UkXGWvEQBbJOJhAWWy86PqXffkBFXAi4IqxDeEq0EApF9596kekbLuLrGhLO0WEsN8Z51e1+JsUZqdryPhBJvTTM2ArAI9VEHWbZnELcIVQ/ukLafCQBViGfXDIIC+nZBUarPj31KZOf7U7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707341247; c=relaxed/simple;
	bh=bQdppS9UAQRred1gpAr3p4kft8EjZf1tmlb3dTOulA8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NiEqYbnEMuM7fwx7aaoY6hNRRzFXn9ccHdau0gNo+UcbN1nKjElXI+bVJ/UaCt1x8tYR208r1e01q3kgm9zff14P0puxB59aIhUUBTtzh/YiTzv4BEwVF8Fn8aw/aiiK9yfCnllTO+7MsCJJZQk8ATkJ2eUWgd4IoIrR7Xo6qTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hO0HVvZT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9269FC43390;
	Wed,  7 Feb 2024 21:27:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707341246;
	bh=bQdppS9UAQRred1gpAr3p4kft8EjZf1tmlb3dTOulA8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hO0HVvZTCPS8syvHGZYj32fFcRWkChaK0AveWX7j8Xb88QK1SAdX1tYJ38ajtxXnB
	 f+ECc+x8l5rNaeOVR9P5iDyH+atZdMu74mIQ2m2OSpMvp4jdszBZL5mEs6sk2/j/wB
	 l/PVJ1crsoX6wClgCCScJmBTkM+UFgpVj+g+bhp4cub1I5hkmDQt74n6TnS+ODIZsi
	 XF0XKQplr8NrMJQzVTSCuQP/N36Ef1JA/r2qcYKSQcj9TLN1h4FVY84vgdPlVaG+ng
	 ovYmjJWDBk1DgCrpt5WRps24TKQ/4z39BQX4fk1DkqFP5vtgQRC2rdvzQVRZZ06/N/
	 +wZ+Hnb6pni8w==
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
Subject: [PATCH AUTOSEL 5.10 14/16] nvmet-fc: abort command when there is no binding
Date: Wed,  7 Feb 2024 16:26:54 -0500
Message-ID: <20240207212700.4287-14-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207212700.4287-1-sashal@kernel.org>
References: <20240207212700.4287-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.209
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
index ebbc513682e1..6bdf9235b14d 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -1102,6 +1102,9 @@ nvmet_fc_alloc_target_assoc(struct nvmet_fc_tgtport *tgtport, void *hosthandle)
 	int idx;
 	bool needrandom = true;
 
+	if (!tgtport->pe)
+		return NULL;
+
 	assoc = kzalloc(sizeof(*assoc), GFP_KERNEL);
 	if (!assoc)
 		return NULL;
@@ -2524,8 +2527,9 @@ nvmet_fc_handle_fcp_rqst(struct nvmet_fc_tgtport *tgtport,
 
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


