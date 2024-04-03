Return-Path: <linux-kernel+bounces-130366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CCE31897734
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 19:46:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84F3728CD6A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 17:46:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48F2C16F8FE;
	Wed,  3 Apr 2024 17:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f3WnXXNH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 868D316F833;
	Wed,  3 Apr 2024 17:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712164846; cv=none; b=fxNiHZw3gC5D+sTVLRkdrfryzcII3l5DaTjXcOjWQntULkvwWKHQ+npx89UWZvwMdrV0K7yuxTiHHnW3G4zLwIv3b3Q5IKCuANwpdQB02W3lxBA4kbn1mppG3u1P5q7XfG5pFhmw22QagmBTw4hIBcOZtNztZ1h9JT9CK9GagbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712164846; c=relaxed/simple;
	bh=XeDmjHm8t4xnvB2jcdIrjVdqivN8LwNRi3oEsyVNH84=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IsdKE1HFvjC+wOGPeqHfG7XUSoh97rdV/0jeZplCTYei/9secTEX7ef2tR7OBxR2a0KAIUWoT6qcMcAm9dEG4PsSZASAUtBhEpoF4ceGdQnKZJ+M3nro2G40IOkplWPcG68izDJQEQMTSI+bn9lOv/MgyoJHco4jGd53lJ4Vk3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f3WnXXNH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 664CBC433C7;
	Wed,  3 Apr 2024 17:20:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712164845;
	bh=XeDmjHm8t4xnvB2jcdIrjVdqivN8LwNRi3oEsyVNH84=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f3WnXXNH/dJ5/DOp+KQfQFlHdZZd9Dx15sOdHl4kmNA44u+gy4bQCIMwI9qvEs3dd
	 N2a72bVGJv3SBXcmw1+I2dxqzJdUYcfECOZZZCjaBgvHgq75heDGacg4hbdAzhYmqn
	 HKpnGVRHV/YAR30UQea50p41QfiIdyfgsvZC2sU424PS4Demd4fxEAoVJ9QnuxTO8q
	 ot49YONDktcW5NZoAudhqY8M0HB3wIA+D8Yr9upY4bwMPXG1684ogjTH/OnMg8b8jy
	 JeceuqXBlxCZNdTHh9cVGKDTMolhwOwwmQpVb02MjX1lKIV6F2Ab3zAHd3A4iizmmC
	 d7n8HJCAIzJmw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Colin Ian King <colin.i.king@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	nathan@kernel.org,
	u.kleine-koenig@pengutronix.de,
	linux-usb@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH AUTOSEL 4.19 3/5] usb: sl811-hcd: only defined function checkdone if QUIRK2 is defined
Date: Wed,  3 Apr 2024 13:20:36 -0400
Message-ID: <20240403172041.354877-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240403172041.354877-1-sashal@kernel.org>
References: <20240403172041.354877-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.311
Content-Transfer-Encoding: 8bit

From: Colin Ian King <colin.i.king@gmail.com>

[ Upstream commit 12f371e2b6cb4b79c788f1f073992e115f4ca918 ]

Function checkdone is only required if QUIRK2 is defined, so add
appropriate #if / #endif around the function.

Cleans up clang scan build warning:
drivers/usb/host/sl811-hcd.c:588:18: warning: unused function
'checkdone' [-Wunused-function]

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
Link: https://lore.kernel.org/r/20240307111351.1982382-1-colin.i.king@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/host/sl811-hcd.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/host/sl811-hcd.c b/drivers/usb/host/sl811-hcd.c
index 6dedefada92b1..873300e8cd277 100644
--- a/drivers/usb/host/sl811-hcd.c
+++ b/drivers/usb/host/sl811-hcd.c
@@ -585,6 +585,7 @@ done(struct sl811 *sl811, struct sl811h_ep *ep, u8 bank)
 		finish_request(sl811, ep, urb, urbstat);
 }
 
+#ifdef QUIRK2
 static inline u8 checkdone(struct sl811 *sl811)
 {
 	u8	ctl;
@@ -616,6 +617,7 @@ static inline u8 checkdone(struct sl811 *sl811)
 #endif
 	return irqstat;
 }
+#endif
 
 static irqreturn_t sl811h_irq(struct usb_hcd *hcd)
 {
-- 
2.43.0


