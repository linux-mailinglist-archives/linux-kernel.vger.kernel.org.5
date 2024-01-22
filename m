Return-Path: <linux-kernel+bounces-33213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D02183669D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:05:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37533B28AE6
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 15:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40C6341766;
	Mon, 22 Jan 2024 14:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OZFTQT7X"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 792474174B;
	Mon, 22 Jan 2024 14:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705935375; cv=none; b=cQYlD7uY+bKgSFlGXJupFxkK/WH4kpHPyQ+G+o+NnjeUb0tIm+Hx0thN7+3nz5tsCH5+7Uezk4o7bU/BkmmZURcFEjY++oE3XfoJx/dj8fqWY+RG/OHup5U/JxmOiD+2OBMmZPYyQ1gVbRZytVpwupWF11rCu9Bju36O+qyopFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705935375; c=relaxed/simple;
	bh=PQgYt7o+gUgE7d9c9OZP21qdogIkHbNi1GtRSNglT/0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VNBaBhkbfr2r5oZzDe29lwnaIhc6cwqyTENsJT2y93EZaYNtpag+utyYJYPiVI3lYDGiqiIzXHa4Xz4MIy0WSKahrwDnZo+evqm8k4WlIWvVvhki8qfoLpNkjGrHOAaHX/5of+Kgn8O86NpHcy4KRqACrgOqRzvmMopaFwcYwzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OZFTQT7X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86185C433C7;
	Mon, 22 Jan 2024 14:56:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705935375;
	bh=PQgYt7o+gUgE7d9c9OZP21qdogIkHbNi1GtRSNglT/0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OZFTQT7XU9SZCOLVNfzgSDsQ5tgn3R5pfry9tDQkkDakG+L2bw8gSikNF9bvxEVxH
	 BzgB+9eeGbCVQ391DLxS6doNzIqTrdlk2EpMQbkRVXoaHJVcLz0HAXCymRLDhsJOOa
	 DJ+heI9Ytkme3k6a0VGS8m7ph1GIOA21sF80IX2pOCL8innjsDkFvAyW8N9pU7ibNm
	 qyjXdAB+2yxdvfmFnYVS498xo8bgGGiEuh6QUYsqdU/qyT36ZhGL9QoOgcDN/S2O/P
	 vBu8vGBsI7pyLhF4WPDvgLO+n38jVu+vLdGOpiffSAxb9fWfBOG4wASFLk2AxeRxBi
	 /y5edUKnjKC/A==
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
Subject: [PATCH AUTOSEL 6.7 02/88] ALSA: hda: Refer to correct stream index at loops
Date: Mon, 22 Jan 2024 09:50:35 -0500
Message-ID: <20240122145608.990137-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122145608.990137-1-sashal@kernel.org>
References: <20240122145608.990137-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.1
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
index 6ce24e248f8e..610ea7a33cd8 100644
--- a/sound/hda/hdac_stream.c
+++ b/sound/hda/hdac_stream.c
@@ -671,17 +671,15 @@ void snd_hdac_stream_timecounter_init(struct hdac_stream *azx_dev,
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
@@ -726,14 +724,13 @@ void snd_hdac_stream_sync(struct hdac_stream *azx_dev, bool start,
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


