Return-Path: <linux-kernel+bounces-33525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BD0E836AD5
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 17:35:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C1F6B2BED3
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4173656755;
	Mon, 22 Jan 2024 15:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eFVRlfMJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8034156776;
	Mon, 22 Jan 2024 15:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705936625; cv=none; b=E5m53Q1C3wHJn570m7qbV8dz/EvKeGGFtDJMNJedkgNFDczq5xw9voCtOw129lbmbGX5j0ATzIK5t8NFqg1nQdCpAnA+fYQatoR06ZNQuaNAyfir8nuU/G0YYS0IV5Em7nbepOjiVyBlnlz73lwuiAMizzVFMcrIP+JSXEUbPWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705936625; c=relaxed/simple;
	bh=8wZK5/mKd2QFneQq4dciiZ+LWwMHMu8Xaf3FxI4/OKs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DZ2gAHXZeuMrucjkiDmspahZeeVu+BBQeEgGiiOXNoFtQiofrP5QxVvvZJjxiMBClT9ClxdeDi2kEHmiMv+pnDcZWQGJrd/m60j8njPuDvKvmCVB8FEmYiPY8Ybul/dPp732y9R44uGvSOeZL6Rt5zjZRpubwEPo2VN6GdbPJM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eFVRlfMJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC893C433C7;
	Mon, 22 Jan 2024 15:17:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705936625;
	bh=8wZK5/mKd2QFneQq4dciiZ+LWwMHMu8Xaf3FxI4/OKs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eFVRlfMJwSvyKOv8coP5FNeKntEqoYdgfudfuG7N2WvG/KNZRjD593iOzCyjZ5QN/
	 VagdqIIdNQ2d9l5RI5tp9mUK2sUgzfpGttHeQNx54JPhUzYXm7wgNAo/AoLPU6ygg6
	 RrfWm2F9nJvDnc0GpwboTI5Is3E8shl8OINQgccUvvBntA+1gNv3hEdj0k6E7ZG6YP
	 c5C7k47Jfab/Kkm80zYeuznanXztUakL2p2ezYTqpGIDHeI007r2YQJ5erYsneJ3ty
	 4AyRO1nvPyZwbfZ0ginFn5i5f63+BmFpSsEw7YeAwoaG8dTNoGn69e49bXzJMkJPjA
	 FPdqpXbrM1tKA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>,
	perex@perex.cz,
	tiwai@suse.com,
	cezary.rojewski@intel.com,
	broonie@kernel.org,
	zhangyiqun@phytium.com.cn,
	chenhuacai@kernel.org,
	siyanteng@loongson.cn,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 02/24] ALSA: hda: Refer to correct stream index at loops
Date: Mon, 22 Jan 2024 10:16:16 -0500
Message-ID: <20240122151659.997085-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122151659.997085-1-sashal@kernel.org>
References: <20240122151659.997085-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.267
Content-Transfer-Encoding: 8bit

From: Takashi Iwai <tiwai@suse.de>

[ Upstream commit 26257869672fd4a06a60c2da841e15fb2cb47bbe ]

In a couple of loops over the all streams, we check the bitmap against
the loop counter.  A more correct reference would be, however, the
index of each stream, instead.

This patch corrects the check of bitmaps to the stream index.

Note that this change doesn't fix anything for now; all existing
drivers set up the stream indices properly, hence the loop count is
always equal with the stream index.  That said, this change is only
for consistency.

Link: https://lore.kernel.org/r/20231121154125.4888-1-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/hda/hdac_stream.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/sound/hda/hdac_stream.c b/sound/hda/hdac_stream.c
index f810f401c1de..bff931ff291c 100644
--- a/sound/hda/hdac_stream.c
+++ b/sound/hda/hdac_stream.c
@@ -598,17 +598,15 @@ void snd_hdac_stream_timecounter_init(struct hdac_stream *azx_dev,
 	struct hdac_stream *s;
 	bool inited = false;
 	u64 cycle_last = 0;
-	int i = 0;
 
 	list_for_each_entry(s, &bus->stream_list, list) {
-		if (streams & (1 << i)) {
+		if ((streams & (1 << s->index))) {
 			azx_timecounter_init(s, inited, cycle_last);
 			if (!inited) {
 				inited = true;
 				cycle_last = s->tc.cycle_last;
 			}
 		}
-		i++;
 	}
 
 	snd_pcm_gettime(runtime, &runtime->trigger_tstamp);
@@ -651,14 +649,13 @@ void snd_hdac_stream_sync(struct hdac_stream *azx_dev, bool start,
 			  unsigned int streams)
 {
 	struct hdac_bus *bus = azx_dev->bus;
-	int i, nwait, timeout;
+	int nwait, timeout;
 	struct hdac_stream *s;
 
 	for (timeout = 5000; timeout; timeout--) {
 		nwait = 0;
-		i = 0;
 		list_for_each_entry(s, &bus->stream_list, list) {
-			if (streams & (1 << i)) {
+			if (streams & (1 << s->index)) {
 				if (start) {
 					/* check FIFO gets ready */
 					if (!(snd_hdac_stream_readb(s, SD_STS) &
-- 
2.43.0


