Return-Path: <linux-kernel+bounces-57172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3F6384D4B8
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 22:52:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54075284CE9
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 21:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB96215CB86;
	Wed,  7 Feb 2024 21:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wz9AlSiK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2784215CB72;
	Wed,  7 Feb 2024 21:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707341155; cv=none; b=T2K0O/sLdWEfIWwg5JKSj5tj9PuIitUxeAybXCfOxih1gKjrWEzEsIj7hdNoOscKAKxBLB5zXUpUIRWKqiF8pDG9IaZJl9NGYOiBcmyv+oqaFuDKMXEcDPfWKzQhgpc6DblyHf73766kFLEsV7vfyVRsIbBCnsmttgQlMgFm6ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707341155; c=relaxed/simple;
	bh=8DgjKcNwoJ0gbR303YsGNUiN+N+KYeLLmrDtZWXZQi4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g9zzTMdeUUS3hazIrMn8rI3NKnZuezT2Up6xBBQXKoYXoc+ysSdw87aymaRALJIUpjKDDCtJJ+FbV3oUs8XPfIKzNoqpd5O+dWpxKzJTh8hS3yEm5cjqIj38Jg0GYWIHOAySDnJbj1XJj5iNZeoc58GegnXi3TYeDrng7X/cSGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wz9AlSiK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98D48C433B1;
	Wed,  7 Feb 2024 21:25:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707341155;
	bh=8DgjKcNwoJ0gbR303YsGNUiN+N+KYeLLmrDtZWXZQi4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Wz9AlSiKW/qheRJoZCRIamy/CmGNQUfg0/DysFE/8nLts1vdkU4uzOi2qF5WTnxM8
	 p2iqatESf/N2oUKKEujqem6BPfKHdXqaN3rGoPMF9z3imsxg4JqawrZmF7Lja3W+mp
	 j2bhkOjPLwYfSYjJv6qg3UYKij3vf24FhynolIGu33yBXYfxxMG9WeYWw28Ee6K+Ml
	 nsvWKVubaGPnr7deAb/SGczmI0kg05Oto+hNvWd+lysNxvyI4k4izNmhWBxuY2wn5k
	 2i6avxuJOcIi9Vt+QYYY3JJMfLSXRispEo+S3IuRlFBbKAl3QNOB0WflRcA6GY4PYY
	 lkcnFBk32F9kQ==
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
Subject: [PATCH AUTOSEL 6.1 24/29] nvmet-fc: abort command when there is no binding
Date: Wed,  7 Feb 2024 16:24:49 -0500
Message-ID: <20240207212505.3169-24-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207212505.3169-1-sashal@kernel.org>
References: <20240207212505.3169-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.77
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


