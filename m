Return-Path: <linux-kernel+bounces-115475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AC368894E6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:11:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9FFFEB35430
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:43:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DD71129A9C;
	Mon, 25 Mar 2024 02:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EPQpMLkz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 214C21E9F8D;
	Sun, 24 Mar 2024 22:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320906; cv=none; b=n/V0DHc7ydY6mnSVoFXSuLCrn7Jvs/fCQ+b2soWfDnylipxwNYL6hqCL7bJnuTRVYc8rwMB2PoqFqvNPo27YjNs1yKU3eK/VneSb+JVFfqgDcp/c1Qzord/C+ImaovVefuWdrmEw40n/t+juN7ii/pWPCJUqhDBtVN4OWqoRipg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320906; c=relaxed/simple;
	bh=Gd32IM3+MPoIdKqaSx0pqzYfX7z6P6j7xfsNndqjB/8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iM0a/WCtvp1pEJBMuCzrvVA8Chbi2h+JEcfp/9BTDF/mOmmU3fP64Qxm0z6Z7uYGbK4viJHuCtLjcdw7n/ZTuk92YBzjQTE+/uA077Lmhcfm/hLL4r/ifGT8oqjDBfsPK5bwS4BuUzpPiRoYCPgAouK1incV1YO3Ap3X6pnBiHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EPQpMLkz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A29BC433C7;
	Sun, 24 Mar 2024 22:55:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320906;
	bh=Gd32IM3+MPoIdKqaSx0pqzYfX7z6P6j7xfsNndqjB/8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EPQpMLkzCTuutXGG29xsupB0WDgjoaScYvQB/Fd7SMdPAKSwQjscs/Ch5nQWGJzb0
	 ZIk75clLm74i/K9ncZVDh/aF5RdhkSSrUcEOYkzcDYCZqxAAebzsOiECEvk3/4Kjiq
	 xV24vlNFnze9Vs0dciKXzKgO1FstwW+M97mx98HsVoPOdlbE+MASw3xVk3j3rE/odU
	 w+i7F6i9kMjkHMQAYBzUa289/DLwR4sePQfi/cha+rdBNEwAAAec9jyftsiEWyzaVc
	 FD38rBDxh9/BIh2eLDboVBHX/fy4izxLPEAlHN8M7NzKvQGxWIIy8DrjXOKRUqMz30
	 XZ8N9hPolZO+Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Lucas Stach <l.stach@pengutronix.de>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 469/713] media: imx: csc/scaler: fix v4l2_ctrl_handler memory leak
Date: Sun, 24 Mar 2024 18:43:15 -0400
Message-ID: <20240324224720.1345309-470-sashal@kernel.org>
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


