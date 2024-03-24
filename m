Return-Path: <linux-kernel+bounces-114325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D86D888FA3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:57:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D09A1F2B3F9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:57:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AD3F266A17;
	Sun, 24 Mar 2024 23:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YYc6eyEj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F5413AA57;
	Sun, 24 Mar 2024 23:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321711; cv=none; b=LCFspGyre5cNpv+eeozafivy2eAZ243SudJoXHaxpQdkwVy+crsO5OoXrvde9LGaq/t34JQcIhiaALgwR80WPDEqfZrNlHRRzlr3GM973e544sAWU5uaJqvVcNAvYHG7SdrLJRYv+LYjd+iCKAV011/LUvqRA/EVUvpFcJ49lYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321711; c=relaxed/simple;
	bh=CybuspodR3vz9++RZe9BIfHdfxRRy0RqESbhMxesbbk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TkOe06SJiS8/I7pDFYiBjN5LlDSklUmoBNuB2aYGty7uY3IV+OYllQgjsaFt+ZLmNsvui7lFpGxVUVGq/a5ZBKEjh8gkZOKULZYPa5x4TFUBhU0zSNMyu/pn0MlEgNFCUwmSSGckJ+q/YH9zNjWBISwI+JSB9Ecrns33Pb58tbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YYc6eyEj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A669DC433F1;
	Sun, 24 Mar 2024 23:08:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321710;
	bh=CybuspodR3vz9++RZe9BIfHdfxRRy0RqESbhMxesbbk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YYc6eyEjLprY6DHGuz66veqaHm+MyNLUl9DridvmDYN86BTdSCNJKpWFzpY2UH6TZ
	 eXcuFxH4Y6+zCB9c6R8lqa0krQpaHPjLq3b4JQGHs6f6Je4+2v0HWFVyvg8epgi2ab
	 612Jnv1qmeF4EhmojQNbvNShjOYPPmVLlqPsEHpR8P7joG9gsx+bzKPbA6LjouK47P
	 TC0WlfR0bvWp7YQTt2OHYoDqkfWWQKec8xuqPU8iU9rOwnj1mgY1W6BN3D2LC3ny0W
	 jsUBSdmZ+XzHTnYpEN6PxKDdsINlhdn1Fcv389ptnXdMmFldYqvXL1iYkZMEda8zMa
	 nLYGdn8hkE/eA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 439/638] media: ivsc: csi: Swap SINK and SOURCE pads
Date: Sun, 24 Mar 2024 18:57:56 -0400
Message-ID: <20240324230116.1348576-440-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
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
index 00ba611e0f68d..5132a7527febb 100644
--- a/drivers/media/pci/intel/ivsc/mei_csi.c
+++ b/drivers/media/pci/intel/ivsc/mei_csi.c
@@ -72,8 +72,8 @@ enum ivsc_privacy_status {
 };
 
 enum csi_pads {
-	CSI_PAD_SOURCE,
 	CSI_PAD_SINK,
+	CSI_PAD_SOURCE,
 	CSI_NUM_PADS
 };
 
@@ -585,7 +585,7 @@ static int mei_csi_notify_bound(struct v4l2_async_notifier *notifier,
 	csi->remote_pad = pad;
 
 	return media_create_pad_link(&subdev->entity, pad,
-				     &csi->subdev.entity, 1,
+				     &csi->subdev.entity, CSI_PAD_SINK,
 				     MEDIA_LNK_FL_ENABLED |
 				     MEDIA_LNK_FL_IMMUTABLE);
 }
-- 
2.43.0


