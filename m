Return-Path: <linux-kernel+bounces-33343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CA15836892
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:41:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04C411F23F9F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 15:41:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06B19634E0;
	Mon, 22 Jan 2024 15:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="omaxcpam"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 461ED6340D;
	Mon, 22 Jan 2024 15:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705935936; cv=none; b=EBfYJ89XVCa5UHUPcJOlcwjSbUqfnq86W2IZXogmdyD5gkqW6ngahfunTwWSZCoaupQFAi05/7gG04wxw+tm4lEHQNEkGnuMOaRq5cuSE3vFPSgi5nA5i5o0+2a/zwuvK+wiQj9O+/vNaslm8HEaeJiY7UInLowtb+qQWZv/gCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705935936; c=relaxed/simple;
	bh=WSnveHPssNRx7TdCN2Ea+FpbjEEUboBjA/H5N671na8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZkA9L0xaRjpJojs8tJSQqUIMEjfm5Jb3nWp0nHJKcamjj5sYrcV7MJl4c8ukRbzmjmLqyumQG3HmGpGTBD8BOhf5Y2NZzP7DCwOOJAC03Xb+F8fpaKT4+3RtZEaFYj7eq6RVm5D4igftOjsAdyKFk9GbzYS6H5BedjD//1nkwLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=omaxcpam; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBB88C43390;
	Mon, 22 Jan 2024 15:05:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705935935;
	bh=WSnveHPssNRx7TdCN2Ea+FpbjEEUboBjA/H5N671na8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=omaxcpamLn5X5KdeK4dUqwNmjmkuXM0TUwGpTAPdCvnfx2j4CIMBKGFfpGCKpc706
	 OPSSssM/7YbmbC70ycd0KVArfyONNkI/wR2mslmsu2dJOxlgGBHwlEShqlyOXWOTkj
	 +lchjC8WN0L7VpvHgWx9ALOn74NBNR9Zibx9Ko8Pb18wLTXrkPSWgQCRCNI2yHQUS0
	 Ip350LNxDawaf6W9r4WD38SLiRQZ+nNkmXBDHfZPkSkfdLy/NsNyE8YexeCUIZg/80
	 o+JVSkkZ0JwsUbCTB5GIAAKoxqjgX+JRf8aDXTaZ5tnjVkLfxlCgt5QPAZXOTEIMOY
	 h7yNPzbXg1sOw==
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
Subject: [PATCH AUTOSEL 6.6 21/73] media: stk1160: Fixed high volume of stk1160_dbg messages
Date: Mon, 22 Jan 2024 10:01:35 -0500
Message-ID: <20240122150432.992458-21-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122150432.992458-1-sashal@kernel.org>
References: <20240122150432.992458-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.13
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


