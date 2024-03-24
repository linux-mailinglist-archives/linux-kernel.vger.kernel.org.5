Return-Path: <linux-kernel+bounces-114577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD6B0888B21
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:41:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87E7F28F556
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89DC229ADF5;
	Sun, 24 Mar 2024 23:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QQbM3sXo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 867E41FDA16;
	Sun, 24 Mar 2024 23:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322222; cv=none; b=Ms/QG3OefXP6FDnb5ABdhn/YQlaklfm08hTJCdhU0DAslBpLwaTeRYBKB0vV8S85fnlWuc+gjRqI5aK5RS0vuqWJqPLXfOxBX08uXBsPvDY79W1xnGiIhalgbschG2QDBDR1JqQ2H25GfzGpvWE46yJukQrwyJPCGIxxHnH5XDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322222; c=relaxed/simple;
	bh=Gd32IM3+MPoIdKqaSx0pqzYfX7z6P6j7xfsNndqjB/8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZE+5mNLat0oJ0Y1BoYGgWHFeqnqZd/6u3VreYUMHmrow2t7kaOrfGOE4xsi8ogkTHvMHEm24XAcghdJWAGG+JWMkQrMjzu/UrJkbGAct3UmrBXgwBS+oLQv1mRpgPKbm2BHDgB3tD1TK71A+Ax5IVfGdrYLzydsE3aIR4uNh2Bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QQbM3sXo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 606DCC43399;
	Sun, 24 Mar 2024 23:17:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322221;
	bh=Gd32IM3+MPoIdKqaSx0pqzYfX7z6P6j7xfsNndqjB/8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QQbM3sXoxp6YS1BuOaDyJ4NnH5g6vYlJWNnwTu+nPXaKldr13v/xyQqGGD8WluAYT
	 JFYIAfRn/mhXRQ7XbcY084mN4Fgfivm893vQCNhZeFL8PRyGI+Jq1i4wGblGVKtB2r
	 B4jhxF+Ii4sQOVNtBXrp0RxXEnb8gy8lmiwFzcdPUmaGPIjUztiMsL1AKJMe8hFbEU
	 7ic0NQzaqA7zh4sHWOjHylIzqy9n5bE6jQL9exs5oTDw5u/NUSuNtk+/CDHBs351Mo
	 9uOlEkktPy1z4PNk6otvsRRYWeByuWOWmfyzpPUfV2KPBpoIkHhX3hxdHOAH00nF2R
	 isKaTfgGimMMg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Lucas Stach <l.stach@pengutronix.de>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 301/451] media: imx: csc/scaler: fix v4l2_ctrl_handler memory leak
Date: Sun, 24 Mar 2024 19:09:37 -0400
Message-ID: <20240324231207.1351418-302-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Lucas Stach <l.stach@pengutronix.de>

[ Upstream commit 4797a3dd46f220e6d83daf54d70c5b33db6deb01 ]

Free the memory allocated in v4l2_ctrl_handler_init on release.

Fixes: a8ef0488cc59 ("media: imx: add csc/scaler mem2mem device")
Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/staging/media/imx/imx-media-csc-scaler.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/media/imx/imx-media-csc-scaler.c b/drivers/staging/media/imx/imx-media-csc-scaler.c
index 1fd39a2fca98a..95cca281e8a37 100644
--- a/drivers/staging/media/imx/imx-media-csc-scaler.c
+++ b/drivers/staging/media/imx/imx-media-csc-scaler.c
@@ -803,6 +803,7 @@ static int ipu_csc_scaler_release(struct file *file)
 
 	dev_dbg(priv->dev, "Releasing instance %p\n", ctx);
 
+	v4l2_ctrl_handler_free(&ctx->ctrl_hdlr);
 	v4l2_m2m_ctx_release(ctx->fh.m2m_ctx);
 	v4l2_fh_del(&ctx->fh);
 	v4l2_fh_exit(&ctx->fh);
-- 
2.43.0


