Return-Path: <linux-kernel+bounces-130283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 00529897660
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 19:22:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95B541F2B303
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 17:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2859215689E;
	Wed,  3 Apr 2024 17:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FJLQwpmp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6578F15687D;
	Wed,  3 Apr 2024 17:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712164633; cv=none; b=ncllqyiG+99+6gB06N7FhsY8vwCyj9N71V5/n+R1XVYGE76j7HP2vumAgsYsoCVDuOHM/o8JLizvwG872WdH/Gsuko2dwT5ftO3ass3OfMQQNIMuS6S7xu9T+jZ+CIUikWX6pc4qvUX/DQeG+3icA++FZBzrTave/CzZrk722t0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712164633; c=relaxed/simple;
	bh=H7GnAJyR/w/vFwtUJetaJZsFTHxXNWQ303r7nG7XEq4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UShuEP2/crxOh1zpmaeJ4VmG5ks2Q66FthFfQxjkjP4RwKivMBwFB/666C6B+tkNvv9/3yN6ImeD9wPg6MNl3TKu1AhtZTSYTtrV04iaqhw+KLkKQ/r8LQhN+UKQQ3P6KGYkNwlkPhglDHggQoWkac1eNcv9Rk4+9nF18ssDGVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FJLQwpmp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26651C433C7;
	Wed,  3 Apr 2024 17:17:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712164633;
	bh=H7GnAJyR/w/vFwtUJetaJZsFTHxXNWQ303r7nG7XEq4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FJLQwpmpouhPDQthTD5RbJ0GL87498E26Z82M7P9OBGNXmtjOzz9UlnLDCCoUAnA6
	 SnXE4sem4/wJyhM/9xJG3SOUW/9oDWxgj2mvGn3neFihUybZA5BfrFj5yNIgUilNwg
	 hygzuW4Zts8Xgy49kCsjO90lZH2ZtaHNn41Wq0RCu3PnrA8yGwas76/M6mw2Y4Afo2
	 D5baLYFrrTc0LICK7hT5816qF4g3PfH+56sr1EXOb/9avON+7hG2O8DfPKcdTEp6qQ
	 mhRs6wwTGQ0WSCd0LF2NPeAcPjjmUd0+ixY7vjLhIsbjH0AIMaqZ/uc2ykIhaR8Fyy
	 V6LBHsNqlIyRw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Michael Grzeschik <m.grzeschik@pengutronix.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	laurent.pinchart@ideasonboard.com,
	dan.scally@ideasonboard.com,
	linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 6.8 09/28] usb: gadget: uvc: mark incomplete frames with UVC_STREAM_ERR
Date: Wed,  3 Apr 2024 13:16:11 -0400
Message-ID: <20240403171656.335224-9-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240403171656.335224-1-sashal@kernel.org>
References: <20240403171656.335224-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.3
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
index dbdd9033c1268..53e4cd81ea446 100644
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


