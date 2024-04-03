Return-Path: <linux-kernel+bounces-130328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A835F8976D3
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 19:34:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 636D1289B95
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 17:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72D1A15FA68;
	Wed,  3 Apr 2024 17:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FF4/ZhxP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA6415F414;
	Wed,  3 Apr 2024 17:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712164757; cv=none; b=UrhiYb3BqCv28u9DPhQPrKqpCUl8ss/wlI737NEykmzTOmls/wOzyk0C4k0IlFo7MDfZ2+afLFAunS8ZVbBSJUIt9yEG4shidvHkkmB6qIFN7iN3WeZouJDtCIaxELJwLuPjSBUL779XtwhS2KT+dds3w4VNBEdetZK7JOy10Zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712164757; c=relaxed/simple;
	bh=3b+INcSJJSJUy/25aCdkSPAGlKJnV28mox/F4ybfhy0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bQCsniwwykKaxG7hDHfDac5eTes04RH9NHQz58WOCEkjH+vC9YbAnlZcqGvnFhuiy2qKSWQpiTBQyU808reXkbR0qHA7ta8gpxE2pOXHILx2dyyA+Ul78XF1HQsq7gfqldyRxpNhdeEmyS5VuzUH8AagLxVi/qw+95UQ+NC2KpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FF4/ZhxP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B48CC43390;
	Wed,  3 Apr 2024 17:19:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712164757;
	bh=3b+INcSJJSJUy/25aCdkSPAGlKJnV28mox/F4ybfhy0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FF4/ZhxPDzaN1JD1rYooKmIRmPjhkb3MkBd28kz6FO1VtemW3n/HY1zdpO0n7Ysvz
	 OouhC6vN3WTQSzUGdNF9Du2g3kJxB6LAbi90s3a82y0GmdlvTO9mFFWdKvdbGXEAl0
	 odPCQ6nKMCuW1KJXahYRyfKtqZUl3nVntsShdIbVw93HUzDxEyA2cJeU6LhRSWoEMx
	 2DyUSsLKMB13B/Q/wGqhrZ0HosC+K5i/GV2JNXPoKrG1/RS94/uOnTEpdYOGQLuyya
	 f7B3Gnw4jziuKP44sUGxK+0UzM7QbEf8REoWtyv84H+iUExSvVCZuj0VY2itySYmWw
	 WGbGa1jLXuTsg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Michael Grzeschik <m.grzeschik@pengutronix.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	laurent.pinchart@ideasonboard.com,
	dan.scally@ideasonboard.com,
	linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 04/15] usb: gadget: uvc: mark incomplete frames with UVC_STREAM_ERR
Date: Wed,  3 Apr 2024 13:18:48 -0400
Message-ID: <20240403171909.345570-4-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240403171909.345570-1-sashal@kernel.org>
References: <20240403171909.345570-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.84
Content-Transfer-Encoding: 8bit

From: Michael Grzeschik <m.grzeschik@pengutronix.de>

[ Upstream commit 2a3b7af120477d0571b815ccb8600cafd5ebf02f ]

If an frame was transmitted incomplete to the host, we set the
UVC_STREAM_ERR bit in the header for the last request that is going
to be queued. This way the host will know that it should drop the
frame instead of trying to display the corrupted content.

Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
Link: https://lore.kernel.org/r/20240214-uvc-error-tag-v1-2-37659a3877fe@pengutronix.de
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/gadget/function/uvc_video.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/gadget/function/uvc_video.c b/drivers/usb/gadget/function/uvc_video.c
index e81865978299c..be48d5ab17c7b 100644
--- a/drivers/usb/gadget/function/uvc_video.c
+++ b/drivers/usb/gadget/function/uvc_video.c
@@ -35,6 +35,9 @@ uvc_video_encode_header(struct uvc_video *video, struct uvc_buffer *buf,
 
 	data[1] = UVC_STREAM_EOH | video->fid;
 
+	if (video->queue.flags & UVC_QUEUE_DROP_INCOMPLETE)
+		data[1] |= UVC_STREAM_ERR;
+
 	if (video->queue.buf_used == 0 && ts.tv_sec) {
 		/* dwClockFrequency is 48 MHz */
 		u32 pts = ((u64)ts.tv_sec * USEC_PER_SEC + ts.tv_nsec / NSEC_PER_USEC) * 48;
-- 
2.43.0


