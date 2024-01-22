Return-Path: <linux-kernel+bounces-33550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D14E1836B2A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 17:40:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8916A1F260BF
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69E5914E2DA;
	Mon, 22 Jan 2024 15:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bD+KHZI8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A972458116;
	Mon, 22 Jan 2024 15:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705936709; cv=none; b=oDbQ6VFO6vv3LfuLA7pj/399fIasqNb/IURvsgNW1hVKMzONcvGMVjzlqb21DnJsFP01YeXQv5hgDT0OrVsv7KMxsWTKCqRsFukHsLIO3RbpApsJPx9AJhM//ipSBTEyRGtR8sUmz9Adoh3dgrhsF/XdtDbk0EjAvKMeos5OhPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705936709; c=relaxed/simple;
	bh=HFYCk+hYTAIq1AVhr7RKr4+P/Q7WYAAq/us3zvVcSSk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X1bSc8DgbYGIha5H1S2L0kQUg1uxr7jlbUz0MRQ9iggf9vB4X41NmSjjckDWcQX3oEQDkgQA0YEIMvN/NYt7PH2Om1nXByp3oXWj/6mxUVo5D3PDNXkmNC6N0Rt4eI2dJi6RuVMpmjciNDFqw6xCZ1zVwRN5lPQ+xHwn14EnmfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bD+KHZI8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3589C433C7;
	Mon, 22 Jan 2024 15:18:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705936709;
	bh=HFYCk+hYTAIq1AVhr7RKr4+P/Q7WYAAq/us3zvVcSSk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bD+KHZI8Q2mSk+BLN4CYMABzGzW69kZGy0wrOi5gdct0GJtA1JJoNGWJcZ/34/KHA
	 m9HD3RZ45EVfhiYLxizLf/jEvbSk4twCDLdAcIdgl8DiiTM7FPNveePN/eyzfY3n6e
	 Ojf4DTAxUSoPDLk5tuSmGPJQPUA9ejRdhubPt7K5UygAh4cRoLXwo+Dwc+IPUXJFeq
	 jrxxwMe6ZGjcNutpqPtzWBErmT8BU/9orMDL+9Rxj6eGYnyt0efx11IYvCZi49GJeS
	 cfRXH2y9p05BVlaa21L0rOPjdg38Fm7pHmXlKPxfMsUW4oinyhUG6DCO+4twrEAVii
	 x8ipQhEExkw7Q==
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
	pierre-louis.bossart@linux.intel.com,
	siyanteng@loongson.cn,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 02/23] ALSA: hda: Refer to correct stream index at loops
Date: Mon, 22 Jan 2024 10:17:42 -0500
Message-ID: <20240122151823.997644-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122151823.997644-1-sashal@kernel.org>
References: <20240122151823.997644-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.305
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
index 2569f82b6fa0..57379edd5dab 100644
--- a/sound/hda/hdac_stream.c
+++ b/sound/hda/hdac_stream.c
@@ -526,17 +526,15 @@ void snd_hdac_stream_timecounter_init(struct hdac_stream *azx_dev,
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
@@ -579,14 +577,13 @@ void snd_hdac_stream_sync(struct hdac_stream *azx_dev, bool start,
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


