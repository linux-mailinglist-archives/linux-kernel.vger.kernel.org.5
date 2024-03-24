Return-Path: <linux-kernel+bounces-116277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C961A889DEF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:57:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 114832A3022
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E5CB3CA2FC;
	Mon, 25 Mar 2024 03:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tjURE3il"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8068B181BA8;
	Sun, 24 Mar 2024 23:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324120; cv=none; b=MyuIHUCQqF74UK7tT1g3u3cByseI5UU1iba9HYftd1Fr9weUHCOtWeWmE8yF5md3/plsLJSNXESv4ToCsooPELGxrSCXzSw3qqB3gRo1PHTfc+nXk0fT4JXOeCZ9EagOlFclaPXX2b3udNGFSpOpfcHdso0srt7M8750pbmTEVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324120; c=relaxed/simple;
	bh=5hWHSp4Kd21wkJ4cGovNsX1pCsEPFCrHlCOQt2n9Y5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KQtnZjpI4HJG7gxywqxB7NbI/9+HKfzR649x3RJ+i3MEQ+82TT+JYXlSu+L7spqOt7HjuMHVjbv3Oc8UoYhOWhlbxZ25rRw+iT9vs+aMnuqLvh2j85JHv7a4lST8mqzQ7Q6G+vMiffR9FGBmTd0A4BmmxHaUf7nBQyDMxgVH7HE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tjURE3il; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9938AC433C7;
	Sun, 24 Mar 2024 23:48:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324119;
	bh=5hWHSp4Kd21wkJ4cGovNsX1pCsEPFCrHlCOQt2n9Y5Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tjURE3ilJb0GHj9nDkWnbzuZnMRZmDLV1L2cmWIZW1kdE5HDXhHh+nhDfHYiU7DKn
	 BBp++i7htL67IVx1TXf+mGL6UpUzbUCX7YIgt7lHdyqPFz7SBLGxluxXTK8vKs8RYV
	 XZyWTP75Uhm7zzhvxxE9G4/sZ0d0/WgQj/3vBYxxUUWck56dmBn3GB/hniS/hJ2EUR
	 yo7LhjT2kfeJcYWZO2AfeaaqFUsXU/vAP/sr+mNlFKCLiPVOikiIBpt4ij8Oi8DFsM
	 ZQQYZXEit8PRW84qVNHCxYYywJgLF9mkjkm2SCHQvU7yNC5iy7g5RWeoX+EhuMW9YV
	 W9F0DLNuaabZA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Lucas Stach <l.stach@pengutronix.de>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 117/183] media: imx: csc/scaler: fix v4l2_ctrl_handler memory leak
Date: Sun, 24 Mar 2024 19:45:30 -0400
Message-ID: <20240324234638.1355609-118-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234638.1355609-1-sashal@kernel.org>
References: <20240324234638.1355609-1-sashal@kernel.org>
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
index a15d970adb983..135e1e64c2443 100644
--- a/drivers/staging/media/imx/imx-media-csc-scaler.c
+++ b/drivers/staging/media/imx/imx-media-csc-scaler.c
@@ -800,6 +800,7 @@ static int ipu_csc_scaler_release(struct file *file)
 
 	dev_dbg(priv->dev, "Releasing instance %p\n", ctx);
 
+	v4l2_ctrl_handler_free(&ctx->ctrl_hdlr);
 	v4l2_m2m_ctx_release(ctx->fh.m2m_ctx);
 	v4l2_fh_del(&ctx->fh);
 	v4l2_fh_exit(&ctx->fh);
-- 
2.43.0


