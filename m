Return-Path: <linux-kernel+bounces-115975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A49A8898F4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:57:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04D652992CD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C2D53958F4;
	Mon, 25 Mar 2024 03:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c7nQzA+H"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96BFD15E20D;
	Sun, 24 Mar 2024 23:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322266; cv=none; b=BMOnDfPof1VwpkCfwWXXvUzDmnxJx+dw6tR4xYTMbCiH4NJ5cxxZ7sh6o6M6pVoHyoQ5/lgVP8v7CZDgvGYUo1NcO+6q8MvcbBIl5rjVi0N59wsmPfOEY9ltocKuDuZMjxzT5ULJb2STZjU23xrliSwoq0EQDA6rSsrIjrdlJJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322266; c=relaxed/simple;
	bh=c+A4NeIGq37Vm8i5Cry9H8iEiSFWR9RE6zV+f7W98mQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BUbYjCn2y5p3RiWHDR9gDjvzYtBUP+9N7RmcR03wcyisnts7Uh+oC7+N+Fd9XP8d/0Up0pws+sJcxST+tydZi+0dab+S7IsJb0YTokYeHkq0YMDtt7zbqtqctpQG8ozwGb/meuajia2fspfjrsdMAwGLWNy06RH7lP066dKFLyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c7nQzA+H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2DE7C43390;
	Sun, 24 Mar 2024 23:17:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322265;
	bh=c+A4NeIGq37Vm8i5Cry9H8iEiSFWR9RE6zV+f7W98mQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=c7nQzA+HS9yywZSYv/16U1J8UbTbuwbrvqmXenrDsYnWzlLUO0OelfIJRuyL0LWuD
	 7Ipk2ycuVoP6EK6ptrhIRFpZCPqI6eQYsgL8Dg6TOgmOUj7YL/q4TFEA3SHa0u7ygq
	 ZcErsUvLJC3b5Ss4VnzhXiVg9ZKYKOmfcEMSN3LMmzWb7EfUNm6XlTZ7RFgmoSFwPO
	 blRwjNpp6QLaDV9VZSjS9BwKGRFY9yK4ueNenqc0X4joVRz5waloMEIkZNIzVFSmvP
	 4BYg/U31NETy4uRnFKYl9qVfO7nZye4k9yo1v5N4NKTbKP34juCR9YxPppvempjBgR
	 Vy5JN6SJIxsdw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Johan Carlsson <johan.carlsson@teenage.engineering>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 348/451] ALSA: usb-audio: Stop parsing channels bits when all channels are found.
Date: Sun, 24 Mar 2024 19:10:24 -0400
Message-ID: <20240324231207.1351418-349-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
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


