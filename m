Return-Path: <linux-kernel+bounces-113351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD7B48883A1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:15:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87EA91F239B1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9209019A5FA;
	Sun, 24 Mar 2024 22:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V2rMjTPR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC0E1199EBC;
	Sun, 24 Mar 2024 22:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320151; cv=none; b=FdO1JBrqGP9cKnqTDzl1HVrEUyo85eCnp9A8Rb27qXJptEE3invbswP5BWzIs7w+yLnjRTwJRozUej7jtXBeiZMrf8dVhE80j1ZL+p78PruzyRsnKE3fgUEbteO4Xo0XLkfHpQnARGg9LL2tUNjUL+04e0WI9+E4SNK8KMm3VJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320151; c=relaxed/simple;
	bh=9ZETl/gy0Y8jktpocnhL5DTxHf3vVl9bRFVzwPJKPDI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=maoEq3a3sh7hWviL8BSFoOwzayNTfZ3mCp2M+gfSEgSelW3nVIRWwDlN5QtRf+vxQLfAi4/YxvBvx1ustQqkdbws7+QVDs2YdUxk9Z6OQRz3XwEstAHNcHA6cGuA2FwdrxTRsod/3Aqklmq182dmOXTagvgvUHIBOVQ56HyCRTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V2rMjTPR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3BA5C43394;
	Sun, 24 Mar 2024 22:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320151;
	bh=9ZETl/gy0Y8jktpocnhL5DTxHf3vVl9bRFVzwPJKPDI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=V2rMjTPRAtxHKCPCiGLcZcyg+lmJQUal/tH3E8NyGKvwMzYDpt92VkVIX6EGsPhi4
	 KGHAzPrrKBj5KdmC1nNr4QBeGHQTUtYS6eUxOC9DrUYjkhglnhvjr02QxTb3NxeweT
	 jIItGO2R8YPI9vrpVef4DRCRFJ+pAhcHuUsGTxyAmWlLu2A9Di9mmImL5vMFYK/RAS
	 kja9aDwAxPjAlIYlmKj1k3DbiigrOcLo7j3bB4Xh9aA1bV/irc8PDekPS89ks9g7LB
	 AYAeYMLVKJD+wmGsyisGSgy0XdL4gNGLZHbC+cyEFV6MEd5jqK0LMZAP/SDHm3n2YM
	 ntyXhonAtnmDQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 460/715] media: ivsc: csi: Swap SINK and SOURCE pads
Date: Sun, 24 Mar 2024 18:30:39 -0400
Message-ID: <20240324223455.1342824-461-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Sakari Ailus <sakari.ailus@linux.intel.com>

[ Upstream commit 48f5fd8967f8dd01679fc1618b0cba02095cddc5 ]

This patch swaps SINK and SOURCE pads of the MEI CSI sub-device. While
this does change the UAPI by swapping the pads, the driver has never been
usable in upstream kernel as the Intel IPU6 driver it depends on any
functionality has not yet been merged.

Fixes: 29006e196a56 ("media: pci: intel: ivsc: Add CSI submodule")
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/pci/intel/ivsc/mei_csi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/pci/intel/ivsc/mei_csi.c b/drivers/media/pci/intel/ivsc/mei_csi.c
index 15b905f66ab72..3c74d06a27fad 100644
--- a/drivers/media/pci/intel/ivsc/mei_csi.c
+++ b/drivers/media/pci/intel/ivsc/mei_csi.c
@@ -71,8 +71,8 @@ enum ivsc_privacy_status {
 };
 
 enum csi_pads {
-	CSI_PAD_SOURCE,
 	CSI_PAD_SINK,
+	CSI_PAD_SOURCE,
 	CSI_NUM_PADS
 };
 
@@ -587,7 +587,7 @@ static int mei_csi_notify_bound(struct v4l2_async_notifier *notifier,
 	csi->remote_pad = pad;
 
 	return media_create_pad_link(&subdev->entity, pad,
-				     &csi->subdev.entity, 1,
+				     &csi->subdev.entity, CSI_PAD_SINK,
 				     MEDIA_LNK_FL_ENABLED |
 				     MEDIA_LNK_FL_IMMUTABLE);
 }
-- 
2.43.0


