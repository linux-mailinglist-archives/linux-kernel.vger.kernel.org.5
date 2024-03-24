Return-Path: <linux-kernel+bounces-114316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51A188889C0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:02:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 839E11C27F46
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC181264D70;
	Sun, 24 Mar 2024 23:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y8xMzRbn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3E1713A89F;
	Sun, 24 Mar 2024 23:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321694; cv=none; b=dkzOjhet8GrGimQ4cJpq1bLTFxcyk+2uxt6MDkrr/2lqVmXm78DBF+9jmbQIU8qB0lc55TirFi62EhhsUihAwJ9DOt3ZEr16y+FAVWQwiHRNKSEUxkwI0LWQQQMClSGbKvvKdZ5LftB9xJL+gKOXXjIOa+5z6NX1FUFl6q2tL8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321694; c=relaxed/simple;
	bh=Gd32IM3+MPoIdKqaSx0pqzYfX7z6P6j7xfsNndqjB/8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bjhu36VNj1YB2mG2Jp+F+rrGXPgbeh5GHmwFMQzK6x2xkMTOffrpclORRiOnTet0vnwQCWF/fNkvmDe4PZZz6E3OVgdQh+IVwst7BQgbck4FRX59DNIxJKwAifvDAbyvFBoSwDjH7ToGywUhoDDWfiqu6RVcceQYPy15xaTIWJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y8xMzRbn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 288BAC433F1;
	Sun, 24 Mar 2024 23:08:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321692;
	bh=Gd32IM3+MPoIdKqaSx0pqzYfX7z6P6j7xfsNndqjB/8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y8xMzRbnq4nIM3sA71wB0CWknXXN3hiLUaxTjNBTH7JeqANCoYlcv3Wxumch59Z1D
	 EbhmL6ZUFilG9PcM0iS+Tt/o5qY+YllgMYR5a43rNhqLEb4y4QoBCEklkplLeZoWA4
	 aBL/j8GLGfsya/zNr40VoCPthaP5Tc/jhDXB1w+XJl6UZyT6RZWa9YNXTPVNHuO8I6
	 bX3IsaXlAHE3tOcXGUpGFizPjoZmsVJXOXiKkVpkmk3hNewnk3f8c6fULdW3WYLgKC
	 51bCKlNMaOSjI2IkSCF1sc5gJKwzumXFVJo09UOfd9xsI3FdzsSPCP+jpXozZKZgRY
	 xxAc7DaCiVrfw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Lucas Stach <l.stach@pengutronix.de>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 421/638] media: imx: csc/scaler: fix v4l2_ctrl_handler memory leak
Date: Sun, 24 Mar 2024 18:57:38 -0400
Message-ID: <20240324230116.1348576-422-sashal@kernel.org>
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


