Return-Path: <linux-kernel+bounces-115143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AD2C888D70
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:48:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E70A928DE61
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BADC3021E3;
	Mon, 25 Mar 2024 01:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cb8GrQeT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E3EA18270C;
	Sun, 24 Mar 2024 23:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324157; cv=none; b=Rq7pWiO/3YUGN7EDSPlJvyBo0gId7XHs2Ib5oFh7/SevGOWjipNnJIMlg6jGQHh9tUZHc25XRxRsPn5Coxt7HdAYwO1ZYU1HfR0OiAteOXAtGwesp0d7ulFkCbKvdO1Sik46jCSxzwWLpF93rVRnVbM/2xWBjv/YmUWh9/g/5/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324157; c=relaxed/simple;
	bh=LfjZMeh8B0UJYHITRDVD2721PgS92r/hA3GJ6dfo/5c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IllIHJbV/PO10Pru8diLsM3uA0CNtVW29cxK9DrRe3eDE9k00ed6gwgjjywGOHQByYE8sQcXKhjITlsZ+wdZDNHDSwc73wbBR9x0UhcxiGfR02/YJLHgbp58o50M3Q0RHU1as5S8VyJ0jl3aWfFWFnajIvyoDrdBF+ItF5AwPB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cb8GrQeT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D16FC433F1;
	Sun, 24 Mar 2024 23:49:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324156;
	bh=LfjZMeh8B0UJYHITRDVD2721PgS92r/hA3GJ6dfo/5c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Cb8GrQeTNkyQNsVJjlk8uFWvSTWq+fP1YFYCu9XCmHhE2x21FjvIEgaQgF9ltRI6b
	 kWpK6ilBUC/FZQEKFfXK/VqyyV3LLrVxeg3+lzmnMP5sgPUSXe8WhhKMBhyEirI9LK
	 ANQejRUHhuESO/XybMcwXudc3gWRDmIzy29uQumXZdCfGMRNGzjk7XCRKSPf1ZSf5H
	 UQDUMnmAWEiyzDFG/UBYjE/HkrWo+MTK3wUhGkOxxEcC6AvLKxWPVfl0pYRxkzI7Fq
	 NSvj/dHSYlk5mRLyF8f5T5XdxKc0uUQeTubkw2FFuQNKwMjil6qtH9rsGSzCE19TWl
	 Luqj/oeXg0twA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Johan Carlsson <johan.carlsson@teenage.engineering>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 152/183] ALSA: usb-audio: Stop parsing channels bits when all channels are found.
Date: Sun, 24 Mar 2024 19:46:05 -0400
Message-ID: <20240324234638.1355609-153-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234638.1355609-1-sashal@kernel.org>
References: <20240324234638.1355609-1-sashal@kernel.org>
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
index d35684e5f07f0..967f05d7e205f 100644
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


