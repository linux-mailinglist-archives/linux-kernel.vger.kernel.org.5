Return-Path: <linux-kernel+bounces-112783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A9A2B887E13
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 18:17:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49DF61F20D3E
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 17:17:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9366C6BFA1;
	Sun, 24 Mar 2024 17:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GQD6sgKR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA7886BB33;
	Sun, 24 Mar 2024 17:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711300060; cv=none; b=KyXyLlnaO6OFPmh+bUZh/cb5u7VlyJIyMxOrzhq1hocM53+2kpTkVdZB456/HV9M/k2cqPxle5jTZBHhQjjf0hAq14v8R8Avnju2PQnBNfX6hhQK/4AYixA1282lnItuBXH1ZwudfbGwglxW8XSodniDb/2Ihs4PTfoPMgcgnMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711300060; c=relaxed/simple;
	bh=K1c7/bIX7waGm3DxSRRRej1jh5k3h52Mpft+aw2Oay0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CEUi5P3xw/wdg2gUe20cl0rUOTuE6tJNQO7oTF/581MyR8eeURtTtCRO4FCo0hjUJ0gwOkfNR5d3q7hOQYAkxxmXDWuwJi5Lx1LQi+VyEYx+HGDUDhx/unBlHRuOxQC+DLszpbqjYFDKaCvdQmC4ku3dDYswxUHOdTCswBGu5uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GQD6sgKR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9554EC43390;
	Sun, 24 Mar 2024 17:07:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711300060;
	bh=K1c7/bIX7waGm3DxSRRRej1jh5k3h52Mpft+aw2Oay0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GQD6sgKRsyFAut2JPBCyqKQzTHivBIUi4B9QpQ7biJf11bdv6+6GHyfS0dXiHMtkU
	 gvuZZgCee3Osvg5Z5L0bXyvXsgmzVndc8KIFlvKaonpBJ5EUDtwVgvkcUxaw64GU6T
	 EJkoLZPfiMfO6AfyjPQ4vGwYXbg9bt5Q1m+1G1ZNzAzdPNRVemja9Ir8mYwKvneuMi
	 OMTZX7/KvQ7YhWnnAO7gJ1GPL4XDyTRF9OCzMvcYCxtEQA3J44XPu4Iu6sb68i9A5z
	 0ibSvz5y5b0Rvj/o9FpBKcygwe6Qnc306d4+5uMvhOdEb9BZaR4WH4fXjuk3iyqmE0
	 it/diKB4Oxkpw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sasha Levin <sashal@kernel.org>,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 5.4 3/3] nvme: clear caller pointer on identify failure
Date: Sun, 24 Mar 2024 13:07:33 -0400
Message-ID: <20240324170735.546735-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324170735.546735-1-sashal@kernel.org>
References: <20240324170735.546735-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.272
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
index 9144ed14b0741..0676637e1eab6 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1080,8 +1080,10 @@ static int nvme_identify_ctrl(struct nvme_ctrl *dev, struct nvme_id_ctrl **id)
 
 	error = nvme_submit_sync_cmd(dev->admin_q, &c, *id,
 			sizeof(struct nvme_id_ctrl));
-	if (error)
+	if (error) {
 		kfree(*id);
+		*id = NULL;
+	}
 	return error;
 }
 
@@ -1193,6 +1195,7 @@ static int nvme_identify_ns(struct nvme_ctrl *ctrl,
 	if (error) {
 		dev_warn(ctrl->device, "Identify namespace failed (%d)\n", error);
 		kfree(*id);
+		*id = NULL;
 	}
 
 	return error;
-- 
2.43.0


