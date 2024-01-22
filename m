Return-Path: <linux-kernel+bounces-33245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39A37836726
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:11:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E712028D4D0
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 15:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35C624F5EC;
	Mon, 22 Jan 2024 14:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="diGDLhIO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 735983F8D6;
	Mon, 22 Jan 2024 14:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705935483; cv=none; b=khMfLPwKfCVt+1ZEMfdPGb+UTSl/wMywo1ZdljG3YIazkl5+6GfDGFFtYGVVrqNcCJ+0nd5cHRUDQM57dkkNgIQblL1WhhIfu9xkm2A8CklBpLog7KJymkbCvUNRVnG0NXWBaKkMTqONwiVFyraD9GdApuaVNFx+r2wkGQ6yjMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705935483; c=relaxed/simple;
	bh=WSnveHPssNRx7TdCN2Ea+FpbjEEUboBjA/H5N671na8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sLiyeM0ZU/g2aFhaBjEkBBvcf1a+uD84VGUeFb4YuBt/6hJY1voD95DDSLHWaBhI3c+lJukIHWVWVKRV2p6T41DN+Ycfu6okhyweDvgmEX6UQu3HaeHrxjSJ30RXFcH8NI8YXRuU++eYnvQMmF63CSVoQToPJLBKiOT//46fKyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=diGDLhIO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC41FC433B1;
	Mon, 22 Jan 2024 14:58:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705935483;
	bh=WSnveHPssNRx7TdCN2Ea+FpbjEEUboBjA/H5N671na8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=diGDLhIOSuAONJsu0G9SW8w0mKJK/FvVTGFwMxcuBe9lhg9Ovqeqktl3TgwMk7mym
	 kS6jhxK68FHZFE5Em2Po5lXWccqyjsbI8CFfNFssOgINga1ysWI8QCfpV+l1TcvXch
	 0QUBVHUjmlkZ2oryaHgjJSBjlyTDFh5hTyE+p0L98wqS2XYAdqrwzql3IAdl/KiMsD
	 ivCb+tnPnq4B3gXVYXsAl01UkhRNU20fmYU9NyWsIjDB2pZ5w36jbrdLz6JYIzYHrC
	 4evLCMzlmH/lYd8g3yNOIYBY0b6JOHxACoyOkXFJCahhBqGHa3XbJxnMmn9i6ke2T/
	 wZ/G3rPjxagww==
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
Subject: [PATCH AUTOSEL 6.7 27/88] media: stk1160: Fixed high volume of stk1160_dbg messages
Date: Mon, 22 Jan 2024 09:51:00 -0500
Message-ID: <20240122145608.990137-27-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122145608.990137-1-sashal@kernel.org>
References: <20240122145608.990137-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.1
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
index 4e966f6bf608..366f0e4a5dc0 100644
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


