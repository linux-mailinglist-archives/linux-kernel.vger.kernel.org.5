Return-Path: <linux-kernel+bounces-33319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3EF78368B3
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:44:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C475B26FE0
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 15:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7959604DF;
	Mon, 22 Jan 2024 15:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CPmXQWTP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 034F3604CF;
	Mon, 22 Jan 2024 15:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705935878; cv=none; b=P0ehgjfquQhRN2ZvtI608n1kvq4rTERj9CXA8pXGLXD/fEO0CqvrWyoFy5OmqjUFwkB2FFD5iK88zblpHnW06d5YXwR9oQyu6KL8+XSrpnn6YkOAKDTX0Y70ac3G5LdFGpsDx39xCaTtzDogSmy2PLAXb/edXT70K3iTy5W1t7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705935878; c=relaxed/simple;
	bh=Jz1HmeThtcLH5WNGvoduX2Hcm/Ch1b20nxUWsbIL0dU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uGgPM643FvXA3IiFllVbJP15tSTtWgAAe0hb2+BNCmMpGDG/AWsflI3AYb7XKAIbj26pTJl2YUwAFVC4MPXrC71yGWZaQjaNLY0yflvGuPsa8lH0khPaP9OZpUed0zJSf4QHgUkfbpALmqgDdbMW40cl4AhG/z5UVLLmSpACypQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CPmXQWTP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67E0AC433B1;
	Mon, 22 Jan 2024 15:04:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705935877;
	bh=Jz1HmeThtcLH5WNGvoduX2Hcm/Ch1b20nxUWsbIL0dU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CPmXQWTPGR79N+NT/5mMpxPv/YXeVWVk7x/2AR/KkuB9VDIUGgsfv0imOKOQme5Kr
	 FSZ5rAiwl2z+yOJA94gIisE0Mk6d1j+j+spew6hswLfBxEu4vFNv+zkjXJiWXs/Rln
	 nFz15OtfU1zRBfU04WDuyvGCpLpt/QZpYn9gg+RyBmr67u8T80aPp0lOL2lU3q5gCy
	 Uc/+VSOz2zpOPUTRuPYE6AO74eiYQMNEfStLUw+s6us9w6YLSHQaeceAHKHmGcfYDR
	 CH7TU//hFiTWn1czxw9BWJPSmYBcQORcAam8xJwrIIw5BLCp77WxJXrgM7Vbd+FMBc
	 ghbqMPrApgEkg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>,
	perex@perex.cz,
	tiwai@suse.com,
	cezary.rojewski@intel.com,
	broonie@kernel.org,
	pierre-louis.bossart@linux.intel.com,
	siyanteng@loongson.cn,
	zhangyiqun@phytium.com.cn,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 02/73] ALSA: hda: Refer to correct stream index at loops
Date: Mon, 22 Jan 2024 10:01:16 -0500
Message-ID: <20240122150432.992458-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122150432.992458-1-sashal@kernel.org>
References: <20240122150432.992458-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.13
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
index 214a0680524b..fe0958f9969c 100644
--- a/sound/hda/hdac_stream.c
+++ b/sound/hda/hdac_stream.c
@@ -660,17 +660,15 @@ void snd_hdac_stream_timecounter_init(struct hdac_stream *azx_dev,
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
@@ -715,14 +713,13 @@ void snd_hdac_stream_sync(struct hdac_stream *azx_dev, bool start,
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
-			if (!(streams & (1 << i++)))
+			if (!(streams & (1 << s->index)))
 				continue;
 
 			if (start) {
-- 
2.43.0


