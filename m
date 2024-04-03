Return-Path: <linux-kernel+bounces-130282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 286A489765D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 19:21:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7403291B14
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 17:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E673F156870;
	Wed,  3 Apr 2024 17:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z0RlTuRu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA8A156673;
	Wed,  3 Apr 2024 17:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712164632; cv=none; b=ASUfYq77c5ddmKE3s9yVCiVEnfVQLAGrX6ynpvRSYd59pCpD9n2YsJ4zqdlXWdR7IJc+ev/ir8/RNloCBdvph3ucIUqA48jP63d5BGJZ+kjxOJhWpy7X56T8xl5y84OUyFlo323DTfQwae49G9PdAmoN8YkyEGgCeXSZqTUPOaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712164632; c=relaxed/simple;
	bh=ru5lDLRfiKzcSYBhnMYqdwXhhP79xcHM9THPZsvn8cQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lQna8CueY42ZFxqbgPQLZBAPBykrIaos+qkLr5O6OdnuhQbx8E5CerKFW/EOoqo+b77edwJlI5xOrjguUBhLpfDmj6OhqwKujhUUf6R0tOgqpBIgUT86nM2PNR1br+ImU5PdiY6KoATUbYgcfpTivzfl+k7CEMwY6xj3WlRdeLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z0RlTuRu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5A30C433F1;
	Wed,  3 Apr 2024 17:17:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712164631;
	bh=ru5lDLRfiKzcSYBhnMYqdwXhhP79xcHM9THPZsvn8cQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z0RlTuRuyEjkr9XkvEAjFMw1aM8587aO4znHh7fcf0xIN1DoTMnv5eboDBeaKQShU
	 cDx1cEihtFDOw1+cK0YbcmmIi3nZ2jJvEgAxFZEt9+ZxOzhQIsijZcWrv/xcYstGxl
	 P6tpg6Yul/CojSHRCYOS7QeRUOWJPY7Nv9tlc1v+4Gwu/LZU/9uSu/FZPB8SdX2tJ1
	 fiipKTJvo3UTrpuhYZfHsjE5r2vbvWAo3gQlGrbnDIEIb88gzIFCM1sOLpixlxV03I
	 6HBk08CN30uJCbEpTeW0eJsVGLwLnoNErzLaM8V1O7HMCaKILu7QBPXjdZXXiCXaaj
	 qt1fh4M99ukBQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Michael Grzeschik <m.grzeschik@pengutronix.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	laurent.pinchart@ideasonboard.com,
	dan.scally@ideasonboard.com,
	linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 6.8 08/28] usb: gadget: uvc: refactor the check for a valid buffer in the pump worker
Date: Wed,  3 Apr 2024 13:16:10 -0400
Message-ID: <20240403171656.335224-8-sashal@kernel.org>
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

[ Upstream commit 5e7ea65daf13a95a6cc63d1377e4c500e4e1340f ]

By toggling the condition check for a valid buffer, the else path
can be completely avoided.

Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
Link: https://lore.kernel.org/r/20240214-uvc-gadget-cleanup-v1-2-de6d78780459@pengutronix.de
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/gadget/function/uvc_video.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/gadget/function/uvc_video.c b/drivers/usb/gadget/function/uvc_video.c
index dd3241fc6939d..dbdd9033c1268 100644
--- a/drivers/usb/gadget/function/uvc_video.c
+++ b/drivers/usb/gadget/function/uvc_video.c
@@ -594,10 +594,7 @@ static void uvcg_video_pump(struct work_struct *work)
 		 */
 		spin_lock_irqsave(&queue->irqlock, flags);
 		buf = uvcg_queue_head(queue);
-
-		if (buf != NULL) {
-			video->encode(req, video, buf);
-		} else {
+		if (!buf) {
 			/*
 			 * Either the queue has been disconnected or no video buffer
 			 * available for bulk transfer. Either way, stop processing
@@ -607,6 +604,8 @@ static void uvcg_video_pump(struct work_struct *work)
 			break;
 		}
 
+		video->encode(req, video, buf);
+
 		spin_unlock_irqrestore(&queue->irqlock, flags);
 
 		spin_lock_irqsave(&video->req_lock, flags);
-- 
2.43.0


