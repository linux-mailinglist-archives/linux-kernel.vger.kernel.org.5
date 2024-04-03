Return-Path: <linux-kernel+bounces-130288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 535DF89766E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 19:23:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84C531C2906F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 17:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E075156F5E;
	Wed,  3 Apr 2024 17:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FGadNGHx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9730156F4B;
	Wed,  3 Apr 2024 17:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712164649; cv=none; b=IoBX5al+b9kNXeUCB4ZPJhPmUrVo0E3JlQg8UZ+0qoTZI6T6xNawxb3yR8dwRn0Y75mKG4iGL67SZwBemyfLSy1+eh2IhcTOFJuT76phNajKCrREHMXt7Bvwx7kTJKJ0+v1noq7GTfqPvu6jbbOhieH1vbDjS1M5rg0ftzj6ZfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712164649; c=relaxed/simple;
	bh=Ju0dCUBj7c1xHR7bdmc+deBQzJoteCBjACIm80EKbcM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P7i0BrL6uw8KWYDmpK+YUkDsG+VbhPiQt6JtKsA7K1H91NX0W/YJUSL+GKp90WzwmyZVjTWlpSoZsigejA/u3EiXMRMNF2BNUDL0YTF3rNxyIB/UTm3romueATCrWjiaAtYPw9gpogUBz4EGjLK0jrED6XAdFmyZ3SvjXbQG2Xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FGadNGHx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75F02C433F1;
	Wed,  3 Apr 2024 17:17:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712164648;
	bh=Ju0dCUBj7c1xHR7bdmc+deBQzJoteCBjACIm80EKbcM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FGadNGHx0XMTKC88wNKWzFds6VitESNtZiXw4r4OQdweBKZPGmDNAUvP9YecU4skn
	 +TNysV4tei5fW8IS9uJ4dy+UgxzKJ2UaiQRM4Y3F21SwlG6gLxrCdeZYUs+jhKqXMK
	 BWkEndMgZFoM2+7Xbw+OID7xOkOCiQmBHFwtK1bcXxqhlZvK8CMQfCl0fbTTxlBYKQ
	 2CJ8BsEA3of66HnSSEjnnWTbVctlJVVTGtwhxitb4+Co2TJynMiCIsgncCWsCPPjVz
	 eqnve55d/4Jjbxmp5v9nQW1qMwRVrm0NYyKs2493Xc69imgueoxIIwuUnE+sIHPtym
	 cxNJzhJ3+I9WA==
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
Subject: [PATCH AUTOSEL 6.8 14/28] usb: sl811-hcd: only defined function checkdone if QUIRK2 is defined
Date: Wed,  3 Apr 2024 13:16:16 -0400
Message-ID: <20240403171656.335224-14-sashal@kernel.org>
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
index 0956495bba575..2b871540bb500 100644
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


