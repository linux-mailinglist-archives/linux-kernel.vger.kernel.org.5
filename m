Return-Path: <linux-kernel+bounces-112746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BD92887DBF
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 18:08:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0DF1B2164C
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 17:08:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9719937155;
	Sun, 24 Mar 2024 17:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B6ka3JHU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCEFF33CC1;
	Sun, 24 Mar 2024 17:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711299973; cv=none; b=gOGELPyojnsG1G4Gy43yRbgXVSKvMmc5+36JZopIWn67bfozwwSIna79z9Oa/11OAoVlTJRIqA3SjDDfzpnuw472yQ7w4/O+ZqSBxv87QoSVKyKIIIjel773ItEIhEOppexnXtzJTlWSZtdRiUr4nWeGIwL00wwA0T8DjS2kx/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711299973; c=relaxed/simple;
	bh=5otAryG/WYRNcxOQAOAJo949yLsICvxts9fIOJuqL1k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bBzQLQKbHPJrv2Un8DbyujQk+xtSPm+PHbnhgjLigBfXHOvXVtlVM2cjz4/YdkL48euCCSLrqCJS/a4JAG3BRjnzEXwZHtjZqJWuTKQwQv6K7IoqKSPG30qbIfsE8iqT3MxCgYgCEGtlH2h6u+0pCDwwomRndixDabWvFT7QkWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B6ka3JHU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E31DEC433C7;
	Sun, 24 Mar 2024 17:06:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711299973;
	bh=5otAryG/WYRNcxOQAOAJo949yLsICvxts9fIOJuqL1k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=B6ka3JHUB3k6V7C91Zg4OuFBfh5wJBIZfetOtH7RsSW83GA6f5YHvTLEkWUWtHlro
	 c+K35N0QgDfJh3PFAUfFi3jN+r/J/8pLC/DCIR+K3ukPIyWr4GOYFywFeiGDCv9uQd
	 nYOsDwmJt6Le+YIF+tYnq3Upl/2mvOT+eGTBEaB+EJ6mfwks3N4NcdWZOi4FvXXe57
	 9QZeFS+HAoHO9IsqZmYPlfWrrebaZvhvSzKiKY1Pe67qMIBqiJ250L8ljklAN2k+HD
	 KaerEwlM3vFG4liB7uUSalwgiYsBuQoe93PpaqVsecIfZRPcB5F97eTd4Yqc+a9czs
	 KE5OVegNZZkVg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sasha Levin <sashal@kernel.org>,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.8 11/11] nvme: clear caller pointer on identify failure
Date: Sun, 24 Mar 2024 13:05:46 -0400
Message-ID: <20240324170552.545730-11-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324170552.545730-1-sashal@kernel.org>
References: <20240324170552.545730-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.1
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
index 0a96362912ced..39ee3036bd516 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1398,8 +1398,10 @@ static int nvme_identify_ctrl(struct nvme_ctrl *dev, struct nvme_id_ctrl **id)
 
 	error = nvme_submit_sync_cmd(dev->admin_q, &c, *id,
 			sizeof(struct nvme_id_ctrl));
-	if (error)
+	if (error) {
 		kfree(*id);
+		*id = NULL;
+	}
 	return error;
 }
 
@@ -1528,6 +1530,7 @@ int nvme_identify_ns(struct nvme_ctrl *ctrl, unsigned nsid,
 	if (error) {
 		dev_warn(ctrl->device, "Identify namespace failed (%d)\n", error);
 		kfree(*id);
+		*id = NULL;
 	}
 	return error;
 }
-- 
2.43.0


