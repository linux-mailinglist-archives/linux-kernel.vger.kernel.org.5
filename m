Return-Path: <linux-kernel+bounces-113876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C889888EC4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:27:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D8A81C29A34
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:27:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B277E12AAE2;
	Sun, 24 Mar 2024 23:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WzPAYRFh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF1312AACE;
	Sun, 24 Mar 2024 22:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320928; cv=none; b=A7PPBW0xb4Gum0bM8taUEx/e2kCUeT9Qen1zHekOh3jOohtqHtYIEda9ORjZ/7gJ69GX7/gdhIOeHtgWZu59yTwLvvoKBzF5EpcuGo37vcwOVfto0fKZUOURHqfTFXZDF5BgN8UjJur1uJ2e1ECtAEWYaFBlLxMImP5Nt1IBxF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320928; c=relaxed/simple;
	bh=Wcdrb6gOgku9puptlABs/qT9m4J8tRZ3AZqW5/Dsyxc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gc0mzfZZBPVCW+XX+c3bGN8bLaSwqrEr8oD9pMQVvxbt6g+SV33G9ewzkMy8RGylc3Nw5/Fp8N6ofc1f8jdeSBdkbjB8DKxOubkYTjp56gqopSjeUe8EMVXc6M8OKkM8vhrzvRbaMwCqIJN7NQVSo74nIorWlyhcHINd7ijs5f4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WzPAYRFh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75FA2C433B2;
	Sun, 24 Mar 2024 22:55:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320927;
	bh=Wcdrb6gOgku9puptlABs/qT9m4J8tRZ3AZqW5/Dsyxc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WzPAYRFhg0FLVAMerTDHh4eQ2NVDu8smRGYI9HOWAGP6rHzA0YsSSJbLCtCgj6jLp
	 boK0HE7EVcaTabHhYol7rYikUKD/IIoXm3cBzX3gx2XH0C/7Rn3R9K6GIhpVYfhoNo
	 FeWE01FcRkT4G6XCODD+qheL8LRX5Z7mxrsUtwPj24Arpsisg77LhXf65mVkvrgOwC
	 p+EapPEt//gdbGU+iJbgdIEnUQIyiXMJT8hfnVL5WvcSywfifvtuLattEVETgmrWyA
	 e3YNepLHNBZKjocPQx+JVX5af7M/Xs8RUvRjmam73oTXkUPSHZVUJBquia8hhjMXWN
	 U884zKM9oUZQQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 491/713] media: ivsc: csi: Swap SINK and SOURCE pads
Date: Sun, 24 Mar 2024 18:43:37 -0400
Message-ID: <20240324224720.1345309-492-sashal@kernel.org>
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
index 2a6b828fd8dd5..e111fd6ff6f6b 100644
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
 
@@ -584,7 +584,7 @@ static int mei_csi_notify_bound(struct v4l2_async_notifier *notifier,
 	csi->remote_pad = pad;
 
 	return media_create_pad_link(&subdev->entity, pad,
-				     &csi->subdev.entity, 1,
+				     &csi->subdev.entity, CSI_PAD_SINK,
 				     MEDIA_LNK_FL_ENABLED |
 				     MEDIA_LNK_FL_IMMUTABLE);
 }
-- 
2.43.0


