Return-Path: <linux-kernel+bounces-116077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D361889920
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:02:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F0141C321B2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D905213C672;
	Mon, 25 Mar 2024 03:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BY8zURmD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C387227B110;
	Sun, 24 Mar 2024 23:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323505; cv=none; b=TaH1OFg/X8N1M0M5XexKqX71598mlIFpfjlNCj0E+g+Lo49obOA9IW/QnFddsbmSpmO/4N+rAYa6IdhiQ2C7k8LfdC9xkDRgv6PfyXL4wPcvozxTgsUkZPGjKiI20zyIizA78AkjXbtWbwS5NIWEEhspdTq7S/rqYdZCMVxv34s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323505; c=relaxed/simple;
	bh=1+J6QYKpPbWfELo6BtEJ8dydpL7F24zkrHNhJf6zRe4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tEYn+PBjlUoANPhgz4sf0Q3CuAQdwQzcYDVlPqOkZyDDdEtbDnIOUj7CddMa7mF1qEn93MLX9UcnwJvn3WknvrZrdGJ9clXNu7JEweAwSGwzWHKXBN8VHX1A0sFkrqoysSXPz2Nc447a26kqhX7CRLo47W9cX0xNdWiWU+azHoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BY8zURmD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFD74C43390;
	Sun, 24 Mar 2024 23:38:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323504;
	bh=1+J6QYKpPbWfELo6BtEJ8dydpL7F24zkrHNhJf6zRe4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BY8zURmDLrwG6z/8T2UqKYgiXoGLAhpEOyRYhfg4WF+x/VjdlpUOIsO9xyMyLul1j
	 gZCDFFsr9LfdSXfXd9oRJPe5bdgvt7zkbU3ngrPj0aoVqZKCfn95Pp3XrY6T29pqcJ
	 nIFrDCYx0W+Wo7ZRgDoA0TS6l79LhDjab/aMleeUAn0XXwVHP3IdD4tvelDXZEz+R7
	 oE09QUYJlNAX0afIZ/yZBdOUwnoV7TxeYMR/tV5M1KbmAdA2MRLKZjk4VfiKuK/Ws4
	 H7YN03zBvN97111saywJ/xRKfArN6ouzIb/MVNKgM09uRMluJU3QfesuYmQdmXHdxq
	 tGqtmMYHHyMqw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Lucas Stach <l.stach@pengutronix.de>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 210/317] media: imx: csc/scaler: fix v4l2_ctrl_handler memory leak
Date: Sun, 24 Mar 2024 19:33:10 -0400
Message-ID: <20240324233458.1352854-211-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324233458.1352854-1-sashal@kernel.org>
References: <20240324233458.1352854-1-sashal@kernel.org>
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
index eb6da9b9d8ba8..c29a950639e46 100644
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


