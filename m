Return-Path: <linux-kernel+bounces-33533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 268E1836ADF
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 17:35:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D25831F2557E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B128856B8A;
	Mon, 22 Jan 2024 15:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MlSgGGqo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F15B91487C3;
	Mon, 22 Jan 2024 15:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705936643; cv=none; b=rK+cuhPa5UJtzi3GJUZeuVBrwTOR45bgrgHRkzvIH63qaGzcCoPSOCROH1Kx2kx5GfyYzi+6NucGY5vnrTi8HA+N9uTy2mDym/QbBHzlS1GNk9SxaMH0f2GRkJprGR4eYNQndGImO1jQnM7MmZCEPagosa9k1HRIOlV7wgV7gjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705936643; c=relaxed/simple;
	bh=VdRpCz7IZslD0fN6wOVHgHdqX/ObRo5Mos+NE/dFVaA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tu1mNDouVGDwEUZl4upV/DPxUqDvfcpxyAKkovHLYdzV/mSAnZWykgC78YF1G+rHLeIysh2OFzeR4oLb9+wMU4MRliz4vCCk6VOpJzzcImcTz8G3ngo+faWFce9lVFP0jvmho1GfVSBG2+QIjpSujnQgAxsT6beAabXpBcEa34w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MlSgGGqo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C14B4C43390;
	Mon, 22 Jan 2024 15:17:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705936642;
	bh=VdRpCz7IZslD0fN6wOVHgHdqX/ObRo5Mos+NE/dFVaA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MlSgGGqok3HcOBNz1xnmAp2K0bQRmUOAoI+ji6+4LOR4FNI10jAwZcAnlJu/w3j8z
	 +2xEQvlzbqgkufUqiMXfKh1XoAvPDzZFiFFzCkBsOEVY/suE/4r6jtwVb2eaj0vIej
	 qtc4+KIWod7h+AtvPIxjJl1+hU90QLrjpDnhsgbdi3bjJAJ4Yu7PgunIw732QSmYvj
	 zfipe/asmnLOKHTCXeeHFvJioazkuPqXcXZXariKuFepBl7q1Q6osb27ftJE26Y1gN
	 HfqXVTeSpbea7vGyohyJRNXMmPXF/gFcCiaDsDsWW4j9YHPnIPw2kVkJLOwNzPLvXO
	 l7Mm39sccb3qQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ghanshyam Agrawal <ghanshyam1898@gmail.com>,
	Phillip Potter <phil@philpotter.co.uk>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Sasha Levin <sashal@kernel.org>,
	ezequiel@vanguardiasur.com.ar,
	mchehab@kernel.org,
	linux-media@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 10/24] media: stk1160: Fixed high volume of stk1160_dbg messages
Date: Mon, 22 Jan 2024 10:16:24 -0500
Message-ID: <20240122151659.997085-10-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122151659.997085-1-sashal@kernel.org>
References: <20240122151659.997085-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.267
Content-Transfer-Encoding: 8bit

From: Ghanshyam Agrawal <ghanshyam1898@gmail.com>

[ Upstream commit b3695e86d25aafbe175dd51f6aaf6f68d341d590 ]

The function stk1160_dbg gets called too many times, which causes
the output to get flooded with messages. Since stk1160_dbg uses
printk, it is now replaced with printk_ratelimited.

Suggested-by: Phillip Potter <phil@philpotter.co.uk>
Signed-off-by: Ghanshyam Agrawal <ghanshyam1898@gmail.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/usb/stk1160/stk1160-video.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/media/usb/stk1160/stk1160-video.c b/drivers/media/usb/stk1160/stk1160-video.c
index 202b084f65a2..4cf540d1b250 100644
--- a/drivers/media/usb/stk1160/stk1160-video.c
+++ b/drivers/media/usb/stk1160/stk1160-video.c
@@ -107,8 +107,7 @@ void stk1160_copy_video(struct stk1160 *dev, u8 *src, int len)
 
 	/*
 	 * TODO: These stk1160_dbg are very spammy!
-	 * We should 1) check why we are getting them
-	 * and 2) add ratelimit.
+	 * We should check why we are getting them.
 	 *
 	 * UPDATE: One of the reasons (the only one?) for getting these
 	 * is incorrect standard (mismatch between expected and configured).
@@ -151,7 +150,7 @@ void stk1160_copy_video(struct stk1160 *dev, u8 *src, int len)
 
 	/* Let the bug hunt begin! sanity checks! */
 	if (lencopy < 0) {
-		stk1160_dbg("copy skipped: negative lencopy\n");
+		printk_ratelimited(KERN_DEBUG "copy skipped: negative lencopy\n");
 		return;
 	}
 
-- 
2.43.0


