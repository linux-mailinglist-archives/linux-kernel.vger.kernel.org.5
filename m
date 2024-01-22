Return-Path: <linux-kernel+bounces-33557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7DBC836B49
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 17:42:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB78D1C24D5C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF23E1509AF;
	Mon, 22 Jan 2024 15:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dbjq+fvt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEB36150982;
	Mon, 22 Jan 2024 15:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705936723; cv=none; b=GTjY3CllMzaoDVS/4l7eudiLXu2WCPOGaDZIoCFVvSyAp5AbFNROky86AKRwbaNGkCeHOn63AM+xTtuM1A3Jwn85HBo5m54HEQe9YbwjtG6wMqFDRe4AhyWt+SkfsfjO1fi8jQ2CFjNmIyIFOz5njQUV6gTrSDjM6bKcQwsdN2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705936723; c=relaxed/simple;
	bh=wlZP73cr1ojqpxCu/0uksqO1NPcd8XKawqbKWnZHO2A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=guyYo6yq1Nr4FHruPbmiZlJiCyHlU6JUFT+a8E9VltgbNbgEJvvKqdaLNQkhVtTAU443f+7qecEB4X6g0Hqc3fcqNIZWncM2o6xwaCWZdiAosufWA4yyiknEdFO46S4D4i4RiaMxn+NHRq6uKOPDIMt7nx1Cm1dYUxj2AuHU89c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dbjq+fvt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1018C43394;
	Mon, 22 Jan 2024 15:18:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705936722;
	bh=wlZP73cr1ojqpxCu/0uksqO1NPcd8XKawqbKWnZHO2A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dbjq+fvtSksumLg7R3Xa/JrSHX4rh3l+RxUVq9bkQpw46Bcj+zJD5ykGIIO4TheVr
	 gCbW2jTxsK8uZ1vChjRMMGZ8Gr/FrbXZ7p9N5UETIME4DWHzhSEKE+z01UW0MNBJWs
	 bdOKA2797ms9zOUTbaiJmRsK+IYfTrIyQYAfh6Hs5D3P/PgOC7R6Q9hrtkGtdUr1jj
	 U5t+VFYXYx+NJOi7D7HdTP1n5Kwo0RRqprxMlH48UkrZRqgwfhziDwKAkR0IzQ8E6W
	 hG6g9qF/O3GGrcPokSq4eNw3cKv/ZHwKgjRfBpdAVx778fp/iF5jWxgwKXE0xleRea
	 X2IOxYbJyPK3Q==
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
Subject: [PATCH AUTOSEL 4.19 09/23] media: stk1160: Fixed high volume of stk1160_dbg messages
Date: Mon, 22 Jan 2024 10:17:49 -0500
Message-ID: <20240122151823.997644-9-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122151823.997644-1-sashal@kernel.org>
References: <20240122151823.997644-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.305
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
index 2811f612820f..0e98b450ae01 100644
--- a/drivers/media/usb/stk1160/stk1160-video.c
+++ b/drivers/media/usb/stk1160/stk1160-video.c
@@ -117,8 +117,7 @@ void stk1160_copy_video(struct stk1160 *dev, u8 *src, int len)
 
 	/*
 	 * TODO: These stk1160_dbg are very spammy!
-	 * We should 1) check why we are getting them
-	 * and 2) add ratelimit.
+	 * We should check why we are getting them.
 	 *
 	 * UPDATE: One of the reasons (the only one?) for getting these
 	 * is incorrect standard (mismatch between expected and configured).
@@ -161,7 +160,7 @@ void stk1160_copy_video(struct stk1160 *dev, u8 *src, int len)
 
 	/* Let the bug hunt begin! sanity checks! */
 	if (lencopy < 0) {
-		stk1160_dbg("copy skipped: negative lencopy\n");
+		printk_ratelimited(KERN_DEBUG "copy skipped: negative lencopy\n");
 		return;
 	}
 
-- 
2.43.0


