Return-Path: <linux-kernel+bounces-115533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C95AE889417
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:46:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83F17290844
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C57DC24340A;
	Mon, 25 Mar 2024 02:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oQh/d+Ys"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7CFC12BF03;
	Sun, 24 Mar 2024 22:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321000; cv=none; b=u6qckrt86tdFQ1gEPr8a3nLmnbEoxsyo+OT6WbW93Vvy/J35YIBCZn4C80vfQ2lDHhDZtWQpLHNzXB4FEyOfVvdPVI9kiAB7hTXj+3INkjyGpmyyZbzQS23zWb4Dsc3NEKP3g8IT1nKuPFFkXjdwSe5aBw8R7B3SkMOVYqh0WsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321000; c=relaxed/simple;
	bh=c+A4NeIGq37Vm8i5Cry9H8iEiSFWR9RE6zV+f7W98mQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mca+jVcXlicJ/H2OMlX26zThyLweLVNcRWGxfCXPpSgin6DPRwXsbqgXTKYUU08M/Pv3wqjj4tXiN14/RjYZP4aCEsYjGTZ8puL2+H1AMvnkjoKXLqXKmUdYz5AB8pnEw5eaZjBYUeLQLiLSKe1i0MN6/ntZ0ifwM6Ma9CZ283A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oQh/d+Ys; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2575DC43399;
	Sun, 24 Mar 2024 22:56:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321000;
	bh=c+A4NeIGq37Vm8i5Cry9H8iEiSFWR9RE6zV+f7W98mQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oQh/d+YsGs8YmsZ8zBcZD5D6+gu/rRnxzSR+iLXQ2V347q4ecjvXN70/xKZN+HgUm
	 01KnANR+aCmfMwV5SbOERxAzMUDX9f7x1aJbL1C/OyMQtMB6nAJqZBOp30QLTz7zjD
	 /4gUVyKuHE4TPE4r/7eT+xdRDBHD9fSXCGBCGmPKTJQ6brSu9pmqYcGS9Ly7VqeoKd
	 QdmfK2a8iHwKWBBrVXXZ3a507glXy8KhZQjRHlraJd1KXJxI+TVGeFyYcr0pcnOkDE
	 BkC66pZTHOuBDtI2AfSwO+w1N477233vV3XLpU4UmYZYz7ryaXpHssZUOfJP8attFU
	 hW19gRhx8ba8Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Johan Carlsson <johan.carlsson@teenage.engineering>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 563/713] ALSA: usb-audio: Stop parsing channels bits when all channels are found.
Date: Sun, 24 Mar 2024 18:44:49 -0400
Message-ID: <20240324224720.1345309-564-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
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


