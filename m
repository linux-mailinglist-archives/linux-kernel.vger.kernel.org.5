Return-Path: <linux-kernel+bounces-113329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CE0E888374
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:11:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D16CB22EAB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 835DA195FE7;
	Sun, 24 Mar 2024 22:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nz6W7Pm+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD821195FCB;
	Sun, 24 Mar 2024 22:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320130; cv=none; b=I6p1Cl20/xJM2Kn/p00yL7kKSzXQ3xqrMW/VGPkvy0VFm90/+ac03sZvBV+OVheB5GlB1kNYbC1DTSZTqdKr/Jh6ABR8NUAEy2lmzvS4gip3Ozk7jRYtCynsliSW1ofRLnAH3q/XJZONN0KujAO8Xos6hyjTU7TPJgWo9a1v5YU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320130; c=relaxed/simple;
	bh=Gd32IM3+MPoIdKqaSx0pqzYfX7z6P6j7xfsNndqjB/8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ix86vmsRW/jVCR3xOCqVHh3ZXkx9I588nvCBgTbrDzkVZof5T/XdAP+y6iZX9nP8lsqpGyZNyPtXR1QO42Dc7fXRY5ac2naHKdfupPEsqC9xWlnbSASuy/3eI74fnWDOGsc3wa+jCxg3miE4SC373qUKMD5qYwgznNEklv4nH6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nz6W7Pm+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5B32C433F1;
	Sun, 24 Mar 2024 22:42:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320130;
	bh=Gd32IM3+MPoIdKqaSx0pqzYfX7z6P6j7xfsNndqjB/8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Nz6W7Pm+VJ/fAQu60LLH4otZRu5Tivso8Zq5KfZSUm9L+jhoG62KLyb1hrXWFG5RR
	 zxE0zbYSfWK4mnsDw/u9KfWqsrFhWtbS9k0dwVa8uqEQrfApCeH47xk46NfOPG4u3F
	 PMjdShj23KBvYQMxYQBbuevX5MJBohl7fXMyYK3PMYkOijjBD7F8DvIewEbesgYDcO
	 duybwW+zphTKNwuJ6nZ8XAalIhiHUXIKeyFV4Uwea9nFV1BlRBSPv7UI4XmNTIb+E5
	 TQsDhUDsDjuk9y0/9jOKnBUiLR3Pqa9sAsqNO08rOuQP/EeLfrbt/rIu4pKWoikQoP
	 +UmIaQ0gRYOeQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Lucas Stach <l.stach@pengutronix.de>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 438/715] media: imx: csc/scaler: fix v4l2_ctrl_handler memory leak
Date: Sun, 24 Mar 2024 18:30:17 -0400
Message-ID: <20240324223455.1342824-439-sashal@kernel.org>
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


