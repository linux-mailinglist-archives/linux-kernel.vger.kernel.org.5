Return-Path: <linux-kernel+bounces-116086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44B2E88992F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:04:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D88021F304B1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:04:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 357013A59DA;
	Mon, 25 Mar 2024 03:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hja+rks7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EE5627CBE0;
	Sun, 24 Mar 2024 23:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323545; cv=none; b=PpPj1p1XKDr2pWZbclWgWQP6z0WzMN9vhfQXAiCa9S6S5LJUxZGVVpUKQnPJP0zoXCg5qZvBse5CmAv9Cs0mfjocMxbnli+WNd0Edxd4DtshGgShXHkW9pN7PzIwdscvz3Rvf8ozPQsjHXapf/E20dc8m9/BBVifjpRrqA/15f0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323545; c=relaxed/simple;
	bh=c+A4NeIGq37Vm8i5Cry9H8iEiSFWR9RE6zV+f7W98mQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E809K2jUlD0F2BMXxvN9u7R8thtL8fMVZasGmgUBDY6D/Dz+64RS2CCXo/2X1hR0Gwg445rh2N1mRqmCYb/gKUDlUp6U/xkoye53OajAIka/q5k50uUi5t6QAGC676MMq3ydZRsfcDBhA1SYyM603RKra3q+V71wZ+PkRHbS/ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hja+rks7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69021C433B1;
	Sun, 24 Mar 2024 23:39:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323545;
	bh=c+A4NeIGq37Vm8i5Cry9H8iEiSFWR9RE6zV+f7W98mQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Hja+rks7OuvlX2MWU88qLsvgqwTGxFHp8Jc0jrLM5M9FYuqkNjGMuCvya6P7OuDdZ
	 jRzn2JJN/bacilDkPe8pjtZgwZXh9a1EabAZyZSl4YlT4txyMs/C4nFXfZCCmCW1Sn
	 8xrPXTc7q1wOmnuCd2NCcOVE6oCuIyy5cvlY156VuBGex85HRMx/LL03gY2NJcdxb7
	 TQpghIZ9mE/A2s7l9WUaQzWC2i9kCFBWXtKQT7ci/9yfKd1GHtcyRKSAz8nFLnqS/7
	 7XRMKT2Yo1rZGiPrDC9zWhOb1udBLh+ibJSwsgObqxwHGKDkg22usxtKM8H4yxS25h
	 1oI+M/gSQiEVw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Johan Carlsson <johan.carlsson@teenage.engineering>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 253/317] ALSA: usb-audio: Stop parsing channels bits when all channels are found.
Date: Sun, 24 Mar 2024 19:33:53 -0400
Message-ID: <20240324233458.1352854-254-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324233458.1352854-1-sashal@kernel.org>
References: <20240324233458.1352854-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Johan Carlsson <johan.carlsson@teenage.engineering>

[ Upstream commit a39d51ff1f52cd0b6fe7d379ac93bd8b4237d1b7 ]

If a usb audio device sets more bits than the amount of channels
it could write outside of the map array.

Signed-off-by: Johan Carlsson <johan.carlsson@teenage.engineering>
Fixes: 04324ccc75f9 ("ALSA: usb-audio: add channel map support")
Message-ID: <20240313081509.9801-1-johan.carlsson@teenage.engineering>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/usb/stream.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/sound/usb/stream.c b/sound/usb/stream.c
index 3d4add94e367d..d5409f3879455 100644
--- a/sound/usb/stream.c
+++ b/sound/usb/stream.c
@@ -300,9 +300,12 @@ static struct snd_pcm_chmap_elem *convert_chmap(int channels, unsigned int bits,
 	c = 0;
 
 	if (bits) {
-		for (; bits && *maps; maps++, bits >>= 1)
+		for (; bits && *maps; maps++, bits >>= 1) {
 			if (bits & 1)
 				chmap->map[c++] = *maps;
+			if (c == chmap->channels)
+				break;
+		}
 	} else {
 		/* If we're missing wChannelConfig, then guess something
 		    to make sure the channel map is not skipped entirely */
-- 
2.43.0


