Return-Path: <linux-kernel+bounces-113817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38FF18886C3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:42:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD5661F25366
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 892D614F11D;
	Sun, 24 Mar 2024 23:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="im7aYSxw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F251292D5;
	Sun, 24 Mar 2024 22:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320844; cv=none; b=ZdUvcnUv7ZOmGtmu49FkbcsSiBQw4RItbMSjYdMZrsmwSR6U08Mc7Xav/goBemPTjjqDTsgLj19FrHBubNdXz59gcLXdFlxA0pMlG1zvgVfbDRpZpdZH2md04WOJ+78ZqjTrWv4zwxI8xR7/Vx6v94+yTdYoPcLw6X/GIPtG1uY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320844; c=relaxed/simple;
	bh=OHkauVxwhGFcSzxmwXCt6W4KQ6WVPYd3XE4W4dRigWM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qr+FZJmc7wrpsFVga6dWHdG4wTbAeQtfVYui8/aU15OSf923wAkMEwypVkOB7y1XDgC5/e9pSJVAb5uFnVwR3RG3MjUHg03/6NokHpdYYOJncqOcPZPAKs6UAxh7RIKXhoqzC3qf1OYSetdw+FTzJxv3daFERtMFRVpnTlnsOu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=im7aYSxw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3345FC433F1;
	Sun, 24 Mar 2024 22:54:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320844;
	bh=OHkauVxwhGFcSzxmwXCt6W4KQ6WVPYd3XE4W4dRigWM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=im7aYSxw03Kb5heYEb9iQKbQtYURYsGBoI8XH+qK/PNOPXqQMPHcPpamrO1HpfQYn
	 FXQcSRMxmMLSzQRE0pajn4yeFL4N4dzsDntAOIS+xmQ2NUHXLGeHs8K3UAOBiGhX+5
	 pv3qykkrdZtTp+DLFQjsZfqQRwzSGAzrW9OKKtejAdG2gulFqEZK0W/bzYYj0/q1dM
	 uY48vOW25T9T1s0AQ6ow5E09sd163LhimyoW9KKxIvv7EG5MAcdIOIEq1BkFOMo3X2
	 IgNPGEz6SwLYIv7ouMgPb24RGryrVVp90yDRd1eZ5l7dsLtTEdnUtr//R2mEXuOnnz
	 S7yxVK+r4P45g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Julien Massot <julien.massot@collabora.com>,
	Jai Luthra <j-luthra@ti.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 409/713] media: cadence: csi2rx: use match fwnode for media link
Date: Sun, 24 Mar 2024 18:42:15 -0400
Message-ID: <20240324224720.1345309-410-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Julien Massot <julien.massot@collabora.com>

[ Upstream commit 448699c522af9e3266f168c3f51f4c3713c7bee1 ]

Since commit 1029939b3782 ("media: v4l: async: Simplify async sub-device fwnode matching"),
async connections are matched using the async sub-device fwnode, not that
of the endpoint. Fix this by using the fwnode of the connection match to
find the pad.

Fixes: 1029939b3782 ("media: v4l: async: Simplify async sub-device fwnode matching")
Signed-off-by: Julien Massot <julien.massot@collabora.com>
Reviewed-by: Jai Luthra <j-luthra@ti.com>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/cadence/cdns-csi2rx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/cadence/cdns-csi2rx.c b/drivers/media/platform/cadence/cdns-csi2rx.c
index 889f4fbbafb3c..c2a979397b39f 100644
--- a/drivers/media/platform/cadence/cdns-csi2rx.c
+++ b/drivers/media/platform/cadence/cdns-csi2rx.c
@@ -465,7 +465,7 @@ static int csi2rx_async_bound(struct v4l2_async_notifier *notifier,
 	struct csi2rx_priv *csi2rx = v4l2_subdev_to_csi2rx(subdev);
 
 	csi2rx->source_pad = media_entity_get_fwnode_pad(&s_subdev->entity,
-							 s_subdev->fwnode,
+							 asd->match.fwnode,
 							 MEDIA_PAD_FL_SOURCE);
 	if (csi2rx->source_pad < 0) {
 		dev_err(csi2rx->dev, "Couldn't find output pad for subdev %s\n",
-- 
2.43.0


