Return-Path: <linux-kernel+bounces-116344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E3EF9889FCD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:40:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 765E4B45BE5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:08:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05D6A299165;
	Mon, 25 Mar 2024 03:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rrcgboyo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E2B2987BE;
	Sun, 24 Mar 2024 23:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324361; cv=none; b=pfUE349QVSsG66wxm5DaeLl8vsmi/tgu7hWCEyVSrKTR8LdaxXnq06kxkUiLjUv0/Z7hDWp4ppxX9vvkUY9BZd88WhnrSXBNk8zYLlsBS9M2aU3kM3ic2j4zK8A92bzu0tWbqT/P2JRh+AvFuI9dgXWm3l3kBFknaNYW3rMAWyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324361; c=relaxed/simple;
	bh=fsol7G2VQdcWBezi229DI5jXveSllbDp0hy5//iZjkA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XBCm4iXTLT3YusWIMgtK3AVuZ6Vud8Mub8PvP5wN8fgAWJ0yUZtsNpr1MG52JB7x+cCXkkeEzxkko51UEQx8pWOo0M0gIdLOPn5ZQoQ8gimaqWWSKp/H/sJGYAjDp47fl5V/a2Y3CD2UW35Kg2+h4bbEBxVSekRy+5s3JgXf0C0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rrcgboyo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC38DC433C7;
	Sun, 24 Mar 2024 23:52:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324360;
	bh=fsol7G2VQdcWBezi229DI5jXveSllbDp0hy5//iZjkA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RrcgboyoKoMFfpU+MaS5kMtwPHkEVPXD3Jjz8RKIAe1DUgQfeWxn+h+DUBNDz8mGo
	 GeDa9e5qyX5KBj/UpPGhBMv8yT9pPb4088FFVYpeJXJ98RN1a6ckwPzNA6Tg0Tisjr
	 7WzPZJD+Ok2BchbkrzRyBnLCBrNZc53LOxEnhvujEETue+J19OrjAtQqlDhDLkd3If
	 jCA3dqUJKnPXDLZ6GbUIgO++TV1K2zLoymfY/vuOMqt3O3uY/DZcoEnK1IcoDnYx5K
	 ovgAGJ1aYi6Ah11pIPXA+6dD3rv60Oe2zDR7bxMXpO8iVbN/NyuaiSqAu31u90HOHE
	 fYQ8heGDBIUcg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Johan Carlsson <johan.carlsson@teenage.engineering>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 128/148] ALSA: usb-audio: Stop parsing channels bits when all channels are found.
Date: Sun, 24 Mar 2024 19:49:52 -0400
Message-ID: <20240324235012.1356413-129-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324235012.1356413-1-sashal@kernel.org>
References: <20240324235012.1356413-1-sashal@kernel.org>
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
index 1cfb30465df7d..3f20438a1b56e 100644
--- a/sound/usb/stream.c
+++ b/sound/usb/stream.c
@@ -306,9 +306,12 @@ static struct snd_pcm_chmap_elem *convert_chmap(int channels, unsigned int bits,
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


