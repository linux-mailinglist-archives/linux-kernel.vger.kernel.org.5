Return-Path: <linux-kernel+bounces-115014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0280F888C8A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:23:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB65D1F292A0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0901D284D7C;
	Mon, 25 Mar 2024 00:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nd8YSegg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A4F917AF97;
	Sun, 24 Mar 2024 23:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323779; cv=none; b=AmZH+z0HR69AGhc46ObCUbW2ugyxBLepvDTQgXwSFMK49xzIiCwMxOn4iQZfG3XB45ny+FRumPYnhIpWDHuWQHF147R7KiBJ93llAjk/qoMPmvZsFGU7xkqYM9qnrGCUFg40ahr7DyzbPTDEvPuatQer0JOEUpvqlyBnwhYuMWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323779; c=relaxed/simple;
	bh=Yjr34TEgyp7PzJaC3I+2zo5LTxg0MGz/MCnfuX7bBrE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BFHIFh5+dfQVcqGqDzK2G+kdRzaLmpm1Po0yhHKGZSPEOWYxXuym8/0b/UZHRCZEVn6Hwl9itFqRkRgdUZ+7p0RVMCQrlQb7r55NUI0+LSMWmIvpN99nBZCneEmdDajoy4cyz9oknNVVgpCAGqVumQrFCqsGZPgK//5NZAYzvjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nd8YSegg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7B41C43390;
	Sun, 24 Mar 2024 23:42:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323778;
	bh=Yjr34TEgyp7PzJaC3I+2zo5LTxg0MGz/MCnfuX7bBrE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nd8YSegg7SFa63979CKMDGNWhszdExIMEztbL/j6hXyei+3v8lUOflyj8SnYBk665
	 fog/K+ti74oL8H/SFCJc6GyyDjpgER4nct08uQq2NuPaN3U3Ehvl10e66iKJuOSGC/
	 r57UOgrKzH/x8R0CURBVuLibPS7YPhnofvPiJEOz0rOim1cN2c4y+tBAkJIWRMlyCy
	 qAsI4hPmCaDz+5nKeGp328bPvteoPlyRXReRs+CQbS2CjC3ZHFQXR6XLyHSlTK3VPj
	 ujXB9YC6xEd6SFuTMTTfnoCoQlMkI3Wk5b4Df9AEn3ZDb7fsqz/bOenyHwejyurP7N
	 U08oxskwA6KNw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Lucas Stach <l.stach@pengutronix.de>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 154/238] media: imx: csc/scaler: fix v4l2_ctrl_handler memory leak
Date: Sun, 24 Mar 2024 19:39:02 -0400
Message-ID: <20240324234027.1354210-155-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234027.1354210-1-sashal@kernel.org>
References: <20240324234027.1354210-1-sashal@kernel.org>
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
index 63a0204502a8b..939843b895440 100644
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


