Return-Path: <linux-kernel+bounces-114379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65BEF888A1A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:10:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FFC6290933
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7359270C8C;
	Sun, 24 Mar 2024 23:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G4MOw5xf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC13C217DE7;
	Sun, 24 Mar 2024 23:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321779; cv=none; b=m+tq/josuztnvbB2a9lWPGdhD0hFXLbSIMwAXSOhVY4v2K7xmWzoVJK4kIj7UmwOx4vAx9othQyF6kslGInm4XJUNO5AYX12xC84EYf43cJ00xj3DXeq7KEAMokOxrr/2wwBfq6JFJ/x9xn6jAlv+P/+nMWFkVGVubmrAQ4MOqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321779; c=relaxed/simple;
	bh=c+A4NeIGq37Vm8i5Cry9H8iEiSFWR9RE6zV+f7W98mQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mjI95Lubcv6JdnBdv8y0idMOPiR+NhJK8oWifHC07THm3iWcU9ibVGfnxGhH+bgO0Aot0CEMCMgfi2vBl3FekWrskNJpIgv+IBMYRi1wYv0o7ks2NVgUqdctEq2TAPy3agZhQt9RMsnxhHmVh+vkN0AExAvEVRI1z4dVn+G1WHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G4MOw5xf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16DCAC433F1;
	Sun, 24 Mar 2024 23:09:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321778;
	bh=c+A4NeIGq37Vm8i5Cry9H8iEiSFWR9RE6zV+f7W98mQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=G4MOw5xfA+MGoYgq8LP/JkHZXlaj6/NgEQqJenmJUBJVXKIaVertdRUAxEg6ymoo9
	 spAJhBWJID+AgS3E52wxmwIYeHmr50bEKrvUqW+UPrSA9PXE+a3LcvtNwAfztSM16p
	 q1dZiy6POUmXt0P6FeeY54PGAA2jYf13tjJCAXwoJQikf4L7og7CkaQ4MbpJrTDHa7
	 ZVnfLxBysTeez8j3n8n3uARO4jazK0AmMnQsWALxN9xr2NoY0UQIqsaRcDl9YrN0Qs
	 aEiQizDg60YEdQuvrzwVXCg4PpGh/SykgV7BR1hwDYViB2P0qDxzJ7VDTxplkNcic/
	 nsTN8Z7+Av0FQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Johan Carlsson <johan.carlsson@teenage.engineering>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 506/638] ALSA: usb-audio: Stop parsing channels bits when all channels are found.
Date: Sun, 24 Mar 2024 18:59:03 -0400
Message-ID: <20240324230116.1348576-507-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
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


