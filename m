Return-Path: <linux-kernel+bounces-33507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7130836A77
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 17:28:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F16B287815
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E04555C11;
	Mon, 22 Jan 2024 15:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TJVBF+Uw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A18EC3FB21;
	Mon, 22 Jan 2024 15:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705936554; cv=none; b=uNT2S0o5VTo528CMfkDXAqJuynw5QWQLHekQeh7sPRcAIQTkdsx84+Vn/1/fSBllH/C/AnHY7ZMoztwwC0MzAXCPyoKx5tAxwGue5KAG5Fr/tw0d1dJ/dPZbQSPp1rkOFNLPmZKvjh+dl0VQEE2SPpppkUxvTVz0gsELm8HBRuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705936554; c=relaxed/simple;
	bh=VdRpCz7IZslD0fN6wOVHgHdqX/ObRo5Mos+NE/dFVaA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JJdSzjQWnqS0snLcv7fA+tOleOUieML47+RPvutyn/Oe2yZGowLOCYvCnxKZnB+d3fG9iL9c0akKwyYWAShZ1x3l8V6EEHZziEUIXNGiTnpsxaUBIc/isZZq5qwyPbwrKuvhK28Mitn7n40yvfl1F46q4CoN18Wz3kZ4s6SPfh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TJVBF+Uw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75BEEC43394;
	Mon, 22 Jan 2024 15:15:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705936554;
	bh=VdRpCz7IZslD0fN6wOVHgHdqX/ObRo5Mos+NE/dFVaA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TJVBF+UwkTsI+qoT/5ITonSnc0P6MLwMewm9TeMpgEE0+a0fJd21HPmw1v8IvbB/p
	 I9s6IB5/rCFKnmBQIpw645GmxpLlMl4xGrubW1KaXzp2qxJ5oGoyskhFU/ACGIGrT0
	 lNHm5snE7n3oFm6JyP/i2FZan17a9UaKMt6IRS1vykUGkP2DM2lKpXii3sKIQJY0f9
	 GpA2XbEHTnAd+atXuKqL7mQglzTzkQQewCVj961uoJ+QSbpc70TesDA0JRBoq+sVGU
	 EMHDksgEOZnolnUIcLs4dhIvVh8GwH03kBCnMjV9PBBAO1qayvcZNM1aeLU9pLCg0n
	 kznCNS5LZUyNg==
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
Subject: [PATCH AUTOSEL 5.10 13/28] media: stk1160: Fixed high volume of stk1160_dbg messages
Date: Mon, 22 Jan 2024 10:14:39 -0500
Message-ID: <20240122151521.996443-13-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122151521.996443-1-sashal@kernel.org>
References: <20240122151521.996443-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.208
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
index 202b084f65a2..4cf540d1b250 100644
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


