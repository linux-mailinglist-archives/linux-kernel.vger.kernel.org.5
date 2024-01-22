Return-Path: <linux-kernel+bounces-33458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 313078369EC
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 17:14:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 642831C24812
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 955E812DDA7;
	Mon, 22 Jan 2024 15:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="agDpCYDx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D972B3F8F7;
	Mon, 22 Jan 2024 15:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705936390; cv=none; b=hI3HgDavhtJ/jmzLDw6KtIY+d/NSze48y6r5VwA9P30HDeCCQpQ4Kss5g1P/hOCThQq2WFhXo9remy/+FgXewLuFQ+j2bP9J8cAqZMDLUAkxhdsXRvAvuXcGJAzJihLEEiMaxqNU63beRxOc5zXEsULSkxMaU/r0U4MZFMS1B6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705936390; c=relaxed/simple;
	bh=SKJ8JMCRTYz1nxoM3XXXbF6lMBTbs4wBGTCNP74OQG8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Iz13VTkpXbqrWA9fin2U/WXcOQ4p1bQF6cGLTjh/SqGg8+fIhMwDoGo0f1xMPBIjXJJpovLjT4DOIM1YJ1Xcw6KwHFiFvNhFZT09VsBIuk5x0gz1mI9xOja3ezCC+060/mTDnO5VlDN89QWs8/guzG6249CmxbZ3avAioNj5+oQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=agDpCYDx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E45A6C43601;
	Mon, 22 Jan 2024 15:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705936390;
	bh=SKJ8JMCRTYz1nxoM3XXXbF6lMBTbs4wBGTCNP74OQG8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=agDpCYDxYYyV+KhArbR2VfIk4dtMiRA3/NPHmJ0P4iEAtHz93OMRm2dBsx/pbvOsl
	 DqSTxKyTf8U5CTrCipTvbcWoZ+gZPP12azT6F1Gw9qdn4IqoaWgKu3Fll3p78wbraB
	 /jK7CX3xx3yX7kVE0RTnAeRW5rMcPGUetblyCEHIbYS4HJQ98hSTb8A8k0eip/res3
	 DJecx6/Oor5e9g2YDF4MkmoEG5lkclKN+a9P33/OaVOxQLjs1Pc4e6E6Mh4RKn356C
	 JtFwtS1+2c917ixEGnKxhbhF1sZ+aIZ8bFEBQ53faQ9DYLo/qLV76SLg2tMsF7m2zj
	 eO0kEDy7HVdRQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>,
	perex@perex.cz,
	tiwai@suse.com,
	cezary.rojewski@intel.com,
	broonie@kernel.org,
	chenhuacai@kernel.org,
	mengyingkun@loongson.cn,
	zhangyiqun@phytium.com.cn,
	siyanteng@loongson.cn,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 02/35] ALSA: hda: Refer to correct stream index at loops
Date: Mon, 22 Jan 2024 10:11:59 -0500
Message-ID: <20240122151302.995456-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122151302.995456-1-sashal@kernel.org>
References: <20240122151302.995456-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.147
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
index ec95d0449bfe..c3342c9fee86 100644
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
@@ -653,14 +651,13 @@ void snd_hdac_stream_sync(struct hdac_stream *azx_dev, bool start,
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


