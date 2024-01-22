Return-Path: <linux-kernel+bounces-33495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A9F4836A52
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 17:25:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B03861F25D51
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 427E654278;
	Mon, 22 Jan 2024 15:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ws0LGl70"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F0AC54725;
	Mon, 22 Jan 2024 15:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705936527; cv=none; b=N7Y+9Y2BYteTnktsQd+yTEeduiL4iXsAAFMarcF0slPnG9FqwwmoC0gCwoZ0GMGwK6uJ6gzUp2w9fCxHZQvREkKfVMUeY4AqHQJCMsJWrWus2g4sTaIQEDJMd+PQBGzpAx5ZNNiN34lUlzr2vGccwe9AKOEx6PjdvGOqt/O+UmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705936527; c=relaxed/simple;
	bh=RfzChSiSxI/aPZMrr5e1Td0C75aQxQ9O4mnCCVXzJHI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mWcFmR5ab2po5z/lcEmYNvgkFZyxH7Pm+lfivAr8WwjYhDuMrFXGC7Rn7u3sT+NxL2b5Zjgv/WJAI8dCghwrwp17U4HinyoXvzxETVwgjTjxWdaGQr6Q1NmjCFi69Vky7CQ6IYEYn7MPnBb3kyuOODfFWwBS2Wd2+gwxtjPuL/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ws0LGl70; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00753C433A6;
	Mon, 22 Jan 2024 15:15:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705936527;
	bh=RfzChSiSxI/aPZMrr5e1Td0C75aQxQ9O4mnCCVXzJHI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ws0LGl70Lny9LL8UQl9edcjn2UaHlPtM6WFg848dGOqB+KfVfwe7aG4ztXtC6ltTc
	 4UlIL6te/BPHw3H1m148MLz0f24oZ063KwuWprXks2zx/QVxWtlWvuf3aZKGE2AsWt
	 b90G6mzcQ5HpNLM9zYLPrCYnyVt1xBZ1kraveZ1fGQADVewF7fdnSxfCF7AsVY0xt4
	 CMC43U2O0O3pBjcf76sVfLE95ocBzVUgOSoEBJWlv62y2wVVuDTT6BSnu3boSzXCuy
	 0m6cacYO/PTGBCN2Z8zusY8RMHpd/lLO5jRduO18yuF47bWB5mycgSLQIcO5IcxDju
	 AHlBLx2oX8VCw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>,
	perex@perex.cz,
	tiwai@suse.com,
	cezary.rojewski@intel.com,
	broonie@kernel.org,
	mengyingkun@loongson.cn,
	zhangyiqun@phytium.com.cn,
	siyanteng@loongson.cn,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 02/28] ALSA: hda: Refer to correct stream index at loops
Date: Mon, 22 Jan 2024 10:14:28 -0500
Message-ID: <20240122151521.996443-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122151521.996443-1-sashal@kernel.org>
References: <20240122151521.996443-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.208
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
index 5570722458ca..e510bf09967d 100644
--- a/sound/hda/hdac_stream.c
+++ b/sound/hda/hdac_stream.c
@@ -605,17 +605,15 @@ void snd_hdac_stream_timecounter_init(struct hdac_stream *azx_dev,
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
@@ -660,14 +658,13 @@ void snd_hdac_stream_sync(struct hdac_stream *azx_dev, bool start,
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


