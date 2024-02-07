Return-Path: <linux-kernel+bounces-57142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36BB684D46C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 22:44:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6DC728953D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 21:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 667781534EE;
	Wed,  7 Feb 2024 21:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O8Nkdx8j"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A24F8153502;
	Wed,  7 Feb 2024 21:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707341083; cv=none; b=j2Zag0alIU8vk4/UJuijg5FG3TZiHqsXIKnlTcR8GfREtXQ3DMMO0D6E/VfRKRZ0gN8jIL/iNuAlD/8/ZGM2X4yV3MvW40wg3ZgQaUwTYCtVZmDOMZZeJoXL9ppAVRj6l8RnA35HthWzmo6nDnp1M4ib67/enUq0vihn4NbORJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707341083; c=relaxed/simple;
	bh=8DgjKcNwoJ0gbR303YsGNUiN+N+KYeLLmrDtZWXZQi4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KkmUvORcfJQiqIWZRcC6hqofy/OR37WbZf6l1CuStmR5LH90LW+xKtyiQueKcQoPXKhV2cLzeT5bz8RLLarc3vslA/wOEMumPBxKMjhHDh2SdvWbTxnFicXCwccCim0j61igTkSpyrDugOfCMc1X+H1Vx4tb+XXZLyxYB8VervA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O8Nkdx8j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B68AFC433A6;
	Wed,  7 Feb 2024 21:24:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707341083;
	bh=8DgjKcNwoJ0gbR303YsGNUiN+N+KYeLLmrDtZWXZQi4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O8Nkdx8joXni6LLiSoUfRjGH/8iSo438fD8G+tbvCbLObUezj7GEVDY3KR1IPCZSj
	 vo9I+B8W4iKPGz5RbA7zdf1JCOJHdqssMPAYUZeoV5btTZOaAZWKtm+STexnaMGIbp
	 nbKLx6q57GXnPPWfwU1iWAg+oMtTV2Kn27jyuFjT8B+0XvoT9dQUswlyzINtj1XlBz
	 v38vR/AwwKI+I7bLvoA2v1Ki4mSQinSF4rBnc3KEJ/a9Sc0x6qOSXPlEGlCdKx+HiN
	 Wy7UMSXfkvFLoilL4fxj8oHMxH9XpWHaFkhPGV72b3H9DOnom16T9JOV77OGz7H4On
	 FT/wKC1dz7sXg==
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
Subject: [PATCH AUTOSEL 6.6 32/38] nvmet-fc: abort command when there is no binding
Date: Wed,  7 Feb 2024 16:23:18 -0500
Message-ID: <20240207212337.2351-32-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207212337.2351-1-sashal@kernel.org>
References: <20240207212337.2351-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.16
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
index 64c26b703860..b4b2631eb530 100644
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


