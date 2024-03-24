Return-Path: <linux-kernel+bounces-112769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24C17887DF0
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 18:13:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 563041C20C7E
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 17:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24A2F54911;
	Sun, 24 Mar 2024 17:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dlZbe3Ho"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6512654901;
	Sun, 24 Mar 2024 17:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711300026; cv=none; b=V7b3eNSzRqiChtYRpsz4/NSLwZgtognAdrzc34Un+UwxYNk3YVla+5Onjfn2oeCSQmS5vE3u3iBGbS0dBDOrMlVwzVX9EngELvox8DEsFFQkz13SI2IzejXrlTMozEdT6Vkf3pURwNTVyLGNlyWJvbJFQ/aKo2PEmorrVzM2yGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711300026; c=relaxed/simple;
	bh=RDb3xLJ5GXEXzKnyGjx42fYqsVclF72OeRAWNWggeaI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gctDnGsB1HYvU/XOGA18lWBki28Gw92vu12ekV+WINYOl82NTbmGf2/zzxrH8ixY9tfYaJwS/NrIk/NoCEN2G+YhSulDLf6ovy9X2HqcM1hdgFSGya2xgPLE4qju5NS5edzvzkyySecTN7pNnu506zMce+iAvr1iAq/bmSRGQmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dlZbe3Ho; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36E67C433B1;
	Sun, 24 Mar 2024 17:07:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711300026;
	bh=RDb3xLJ5GXEXzKnyGjx42fYqsVclF72OeRAWNWggeaI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dlZbe3HoOwfgkUQrzWMtCjcWMfmJYRTrmM+kFXSWtOlC+P0ctjRCsRNvItoa65Aco
	 ri82Ryae63oGJMChzikWAh2JH6t8YU0QG0fOa04G7sv43Gc82ccIWlytGOsiHRAImD
	 fNmUrL6DPTv3CwHaOZ8pEXjoIVTDAP+tNCg6QL1661+F3E/PXpBsbf1cLeu8hK1KKB
	 ZpLyrsBCh57xtj1SCxfLsqnaxqy0PdVdBpVPI+Fg6NA371z0mHrDcxEcHbCNbEwjBN
	 TlLI+9f5sUw10weQ/WILTMGFEiF+BejJJ6nsUzVuTdPcxy2/fVszucoiyB58P46pjz
	 2nbD8ABI9NabA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sasha Levin <sashal@kernel.org>,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.6 11/11] nvme: clear caller pointer on identify failure
Date: Sun, 24 Mar 2024 13:06:41 -0400
Message-ID: <20240324170645.546220-11-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324170645.546220-1-sashal@kernel.org>
References: <20240324170645.546220-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.22
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
index d4564a2517eb5..63d9ec076792a 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1333,8 +1333,10 @@ static int nvme_identify_ctrl(struct nvme_ctrl *dev, struct nvme_id_ctrl **id)
 
 	error = nvme_submit_sync_cmd(dev->admin_q, &c, *id,
 			sizeof(struct nvme_id_ctrl));
-	if (error)
+	if (error) {
 		kfree(*id);
+		*id = NULL;
+	}
 	return error;
 }
 
@@ -1463,6 +1465,7 @@ static int nvme_identify_ns(struct nvme_ctrl *ctrl, unsigned nsid,
 	if (error) {
 		dev_warn(ctrl->device, "Identify namespace failed (%d)\n", error);
 		kfree(*id);
+		*id = NULL;
 	}
 	return error;
 }
-- 
2.43.0


