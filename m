Return-Path: <linux-kernel+bounces-113443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B9C5888460
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:38:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01A681F22C93
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:38:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEC7F71723;
	Sun, 24 Mar 2024 22:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D+w8WdTD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC751ACFE8;
	Sun, 24 Mar 2024 22:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320245; cv=none; b=N/QBNVjRVoZ1MswF8m1TBM02txOyzVlDna+pdKs6XC6j2YEMviBhRNugDNrdTzUgiuVs/bdaJhVZt+zCfEbf4yevwEEEtFhLXnTrDRlj28uPyHiKILqpyjH74cwcegpai1odBgIC7Rd5JH7N1fGdw55kEbU2LmEJDwj5zMB7+Mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320245; c=relaxed/simple;
	bh=c+A4NeIGq37Vm8i5Cry9H8iEiSFWR9RE6zV+f7W98mQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RohPu/NR+o4hBYgxfDb8KElY2Xg2CsjbzmeVgeLfjt/jZYqqhG0xuesvhPvupAx4XqpJ1JKkybvk7sYKMoWy3hU5pLoVbCBMVFp8q6wizKNxOwnqVn6SyCRZHkS+MALPd88spIbDgQRA+iL58nLBimv0kyCPAwGB62HWQGMlHdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D+w8WdTD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FA8BC43394;
	Sun, 24 Mar 2024 22:44:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320244;
	bh=c+A4NeIGq37Vm8i5Cry9H8iEiSFWR9RE6zV+f7W98mQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=D+w8WdTDP+BcSslNfdhW8P4opNUwNO8/KWQnBB061wPiwqxXlFNJ13RPoWHR+TUKo
	 UXXGZVIMYk3cXuAMCkzQX34JElFChPft3n0PgVSZkutP28DO863lgIosl1aUj+rH1f
	 xuPwTp+mj4dA8q5NAJPSanaBbCKgdseINK/KZZ+BQsLemGY3Qf5IqEZgoCSrT0YP7v
	 EH/FoKRgCqJRjAoJm5nbtvMRAoCY4YP5v6bR+m3faKA1Rb6FtsWOkUBD37571QwhkI
	 fQAK2cn0dqqWBawggG7c+pCaI/6xMMCvZrgjPQT+QeOg8GbtxdBWmDr7v1ZvWqolje
	 /8iQ8wfs2tMdQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Johan Carlsson <johan.carlsson@teenage.engineering>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 552/715] ALSA: usb-audio: Stop parsing channels bits when all channels are found.
Date: Sun, 24 Mar 2024 18:32:11 -0400
Message-ID: <20240324223455.1342824-553-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
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


