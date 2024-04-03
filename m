Return-Path: <linux-kernel+bounces-130309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF79D8976E8
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 19:35:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7337DB31ADF
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 17:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C051A159215;
	Wed,  3 Apr 2024 17:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cZN/uooR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F701591FC;
	Wed,  3 Apr 2024 17:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712164705; cv=none; b=kcrmK0uMh8ybYhAabWY3HW3lyWMBBU81TVcjq33rloQiKya7QH+zW+4rP+RmbiI1tR1ubs1IB812RLwdTgBbQs71OJgT88t7F12KXdDzOZAs/O1jKsogjsFzHJebsM+xts8BYDCLNdEFGzf4XtJF1B7odSAAZiult3CV/xpc6qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712164705; c=relaxed/simple;
	bh=AeKmAdl4pViMytfg9tD4t0EtqD9ZeJOer8TWoZ6U40Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SMlEwDkC13wYkm6J3sbx/eFAYUSgFpI6QPj918VrbSymLkN/qL5/Td6QktlifguaFuQIhyv9989aKQqWhTWb7n1oA7wYYoQgD+iDfsb0u515EqVM+YC8vkxJg9xyvn6swNSrocj9QNGLhNAbg8LFQeDXTvBinyUlm3vH4j1mrKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cZN/uooR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C76BC433F1;
	Wed,  3 Apr 2024 17:18:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712164704;
	bh=AeKmAdl4pViMytfg9tD4t0EtqD9ZeJOer8TWoZ6U40Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cZN/uooRg2oXjvJhvvTlBvTmcDW7V1EtxPQcPyexRgT9D55kxapqMBGuaq8qicooi
	 MMRWyEuK/KMJJeGv6eqL9nzG9SZWcvBwYBKzMhIYnV90dm47saTQgGbxxfGKNLNFbF
	 B6+gQv2Dt6Mp5CprpWzNBdgIrPoIOHPfpyg+C8AQ+l7F8pDIsuS6yn2DhIvq3+oXv8
	 1tNWsPlPtZea1+dieH0r4fIdslHqpwcoy7xeSZoKgGK4jCeSkTbS2fb4hsprSNe3b+
	 uVU290Zcphv4RwWXniKDHSV/ibseceftZ1YGx3hLET5AE7uo//rFlH17nczpTy6wal
	 YM9eeu+g0YGIQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Michael Grzeschik <m.grzeschik@pengutronix.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	laurent.pinchart@ideasonboard.com,
	dan.scally@ideasonboard.com,
	linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 05/20] usb: gadget: uvc: mark incomplete frames with UVC_STREAM_ERR
Date: Wed,  3 Apr 2024 13:17:46 -0400
Message-ID: <20240403171815.342668-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240403171815.342668-1-sashal@kernel.org>
References: <20240403171815.342668-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.24
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
index 91af3b1ef0d41..281e75027b344 100644
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


