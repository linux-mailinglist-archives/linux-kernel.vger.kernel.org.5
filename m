Return-Path: <linux-kernel+bounces-112776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 763BD887E01
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 18:15:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16DBCB228D5
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 17:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7A5A5BAFA;
	Sun, 24 Mar 2024 17:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ok39JWwp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 019875B200;
	Sun, 24 Mar 2024 17:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711300041; cv=none; b=Fro+mEFl9u74Qto/0wMePpydFRkiBokiJMst2wyCJFI6MlGuZTNdx7S+BkyV4VSfohrT+e2ewyTWQWO1/nGHrbcQW9UzAmq+IIuNBnu+24evVXMu619TzpXUG2sSW5PYUfQpdT3k+uechzzk0fK8yY/GYeON2ClmbbORAbNuuFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711300041; c=relaxed/simple;
	bh=XN56H29/t+TQV91EAOIpRPn/BfVIQUAtf2rRHgpwWT0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r6OKPZCDhmiEL+o60qqUQ9KyaEH5xRgsWdqwRtsFELDaJQh3but7fZVzlYM+Y42qsTqdOq+aa36HJG7RXHchp5mdGX8vYj2wAsVgOOww0WoBhi6DiN/Eyk5o1tKoLnefERda2DRfT/ts9sdqy3n5aB1laejik+LoDd9f804/0gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ok39JWwp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 118CDC433F1;
	Sun, 24 Mar 2024 17:07:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711300040;
	bh=XN56H29/t+TQV91EAOIpRPn/BfVIQUAtf2rRHgpwWT0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ok39JWwpKUH9+M4m3hhq8A5yJPl9acW8HWtpVXSo5IPl2eIzJwkIgG1Gi10d/UnOa
	 tEETHayTpDn0hVWhWWucJbQaWwmFmGZqG7Tr/OYQA9xz00qEDG/LnXWwLoBt4jUnXv
	 LMeiuoyKPQc/4c6o46Bu7WnYt+li2eUfqtmEu7apRbDqq9feAQI+tRsUIb6QaoGH81
	 ONDXZHSILPydzlrPXM1JfMeqPCAMvludoKaKcjfrEZ3GnRTQx98ECSInqp4bH9WeZT
	 UpCFGBEfieYH7iLr6hZacGctZveLUWjTANj/Kf65Y7V/CgsfXnA7obzxF9MtTi9syP
	 cYmBsSjmkoGDg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sasha Levin <sashal@kernel.org>,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.1 7/7] nvme: clear caller pointer on identify failure
Date: Sun, 24 Mar 2024 13:07:07 -0400
Message-ID: <20240324170709.546465-7-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324170709.546465-1-sashal@kernel.org>
References: <20240324170709.546465-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.82
Content-Transfer-Encoding: 8bit

From: Keith Busch <kbusch@kernel.org>

[ Upstream commit 7e80eb792bd7377a20f204943ac31c77d859be89 ]

The memory allocated for the identification is freed on failure. Set
it to NULL so the caller doesn't have a pointer to that freed address.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/core.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 0c088db944706..20c79cc67ce54 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1363,8 +1363,10 @@ static int nvme_identify_ctrl(struct nvme_ctrl *dev, struct nvme_id_ctrl **id)
 
 	error = nvme_submit_sync_cmd(dev->admin_q, &c, *id,
 			sizeof(struct nvme_id_ctrl));
-	if (error)
+	if (error) {
 		kfree(*id);
+		*id = NULL;
+	}
 	return error;
 }
 
@@ -1493,6 +1495,7 @@ static int nvme_identify_ns(struct nvme_ctrl *ctrl, unsigned nsid,
 	if (error) {
 		dev_warn(ctrl->device, "Identify namespace failed (%d)\n", error);
 		kfree(*id);
+		*id = NULL;
 	}
 	return error;
 }
-- 
2.43.0


