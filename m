Return-Path: <linux-kernel+bounces-130353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E623897712
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 19:42:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EE331F2E3EF
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 17:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAE7C16D9CF;
	Wed,  3 Apr 2024 17:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="opsGT8h1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01D8416D9BA;
	Wed,  3 Apr 2024 17:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712164814; cv=none; b=bMWvW2svgH5mzy9ysw2DYf/JVEkJndNVKWWTG9m1Doq0URLnblHBIHJtEQpFWsmQp6iL9cWdMtKTAlBYtWIi/pVQpbzHGdscFIhUMvpT4fr9q+DA3ME4I81GhNSKGidWZi0dfmdYs6ygQn/WwfqYzpNIuy+7kzLsRZ3MsBQebVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712164814; c=relaxed/simple;
	bh=omDK8ATC7zjxQypnUCkye0G9rSVtvt61YKJnjYhtQYI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IcHy7uMgttNjmyaWcwEgeJJ+tgPp3wL3Upb5hkH68ihzUcfxiKI3rRoAi9T5thnbkF17xQ+TDhd+otRoDHfgp7zWPiidX8d7cs5+CqgAPtW7mmj8L+ap6JLcsl4pQr4tLclBqZYAwuwhCqauKZ03cHhDLKiHJJxOWHIxK85767o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=opsGT8h1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D5A9C433F1;
	Wed,  3 Apr 2024 17:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712164813;
	bh=omDK8ATC7zjxQypnUCkye0G9rSVtvt61YKJnjYhtQYI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=opsGT8h1oTQuheE0Yh5ct49GbxGgVdlVjSq4yiLo8JOElS3fGS2csjLolIe2NoeGO
	 qE7lib/nXol+QYobneAvOpG6lhqNV28/u5xcLw6uxi2mxs5RM112m7ZuMSYAXPhXIM
	 HJ9G+tv24XPzN5W5qfXacx9u9QmQmp/Y0BWyXMzl+Meq/qt+64qMsmTcVAy2QRBJ/l
	 vmzmHj787lat/IzI4jEfeP5j6fRQNT0HFUsDnHM18KLihNPCaIYMPYh/Y14L4vZnKV
	 fuZI4SRcMPSU4lYvx3isB+7Jo+MCObp7GzUSPMBLUIfB8W+6g9uPeT+buZXK0sNWOF
	 ODytXl3pxWUUA==
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
Subject: [PATCH AUTOSEL 5.10 4/8] usb: sl811-hcd: only defined function checkdone if QUIRK2 is defined
Date: Wed,  3 Apr 2024 13:19:58 -0400
Message-ID: <20240403172006.353022-4-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240403172006.353022-1-sashal@kernel.org>
References: <20240403172006.353022-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.214
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
index 9465fce99c822..f803079a9f263 100644
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


