Return-Path: <linux-kernel+bounces-115034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77E2A888CD5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:32:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16D06B2DA6F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C05C92EC890;
	Mon, 25 Mar 2024 00:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dASX9/SU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B426C17CF75;
	Sun, 24 Mar 2024 23:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323814; cv=none; b=PGdWyLRl+3JLUe3/R6BwwprOk8goT6vOyGQiygDefZmNK7/zTOE9EUDQUUgtHLFi4R1D3y6Iqw0DHhONzqQGBM6SWmV2LyBuzc2t0ECTK2hZdYe06iC/tgPNKVCsIq5DyC6wCQkukPYLvnrowBmMOaFhikFY1XHsyi/5yd8dSLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323814; c=relaxed/simple;
	bh=L3pOOBB702mTdXQE+rDjJWlUh+W+fmnwUarJWQgscLM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kwauqV/kXXSSgzh2E53iPBp5l0Fpmv3slqr2+8Q2ZaX47xmEZiWp8js+V6xd5bP6uPv6akMqk5+FgTF7hfME1YFLnmcQgqDHK5mWmLGlNjJh9llvh59pYRdu8B3f8RZ/KG7vxWvaEYu1F53xpUqqF6qeC/9jN5EnChD76b8eMW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dASX9/SU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1AE3C43390;
	Sun, 24 Mar 2024 23:43:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323813;
	bh=L3pOOBB702mTdXQE+rDjJWlUh+W+fmnwUarJWQgscLM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dASX9/SUc1OUSpNdcge7+h1/N3jHvwKewMTbNi3FARRuvs5p43k9551IMxwcYuijg
	 TC/buvW1IZzHLHkt6smEY0C0EMn59BKLQ/5tcNVXuqcw+so0iF2SVWucp/80BC7mWO
	 GjdAQe7Dd9PI3zt2VxBnyMUBWAXdySU7dHW0oXQLktIqhfsJylIpcf3X+6n4nyx+Rt
	 qxv/n3hxwiSI6K4/kNupkKiVLlEmXn0yHd8JwcoVO1/wi9yLuPMAkHRQaKsxTIRpwt
	 BAC5HWS0Bao+AnZq1cSJS/hby1ORo5k+bWD79fTrN2kUxN0D/UvP+I88xJwuIVmkB4
	 iP2xSWoaK0LcQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Johan Carlsson <johan.carlsson@teenage.engineering>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 192/238] ALSA: usb-audio: Stop parsing channels bits when all channels are found.
Date: Sun, 24 Mar 2024 19:39:40 -0400
Message-ID: <20240324234027.1354210-193-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234027.1354210-1-sashal@kernel.org>
References: <20240324234027.1354210-1-sashal@kernel.org>
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
index c4f4585f9b851..f51e901a9689e 100644
--- a/sound/usb/stream.c
+++ b/sound/usb/stream.c
@@ -301,9 +301,12 @@ static struct snd_pcm_chmap_elem *convert_chmap(int channels, unsigned int bits,
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


