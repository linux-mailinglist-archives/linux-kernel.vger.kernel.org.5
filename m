Return-Path: <linux-kernel+bounces-33402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90DDF836940
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:57:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3C0C1C22C64
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 15:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECFAF4CB27;
	Mon, 22 Jan 2024 15:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gMcJTK1s"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A3F74C3B9;
	Mon, 22 Jan 2024 15:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705936196; cv=none; b=iwIvZdpMI8svMvABvZlUbNc7e0kU6ujy8mFdFNKCvcHJ74OB4MolCGzmqkEBXq/bGdrtl9nA1JCsyxf5ei8qNEgbUGtX9g28UqKLp106Xu87sewzLKQvJzBCCQ0mN96ZfqZoTnrTETG2GjAA5lMHgOocwekshAVNfAuTh/X90wE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705936196; c=relaxed/simple;
	bh=J3ZoyCqNWoh5B7jt/nT+iHpNhhc/7+h3H7S4EDnayoQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PMBMDF6yP/X9Y5iAtWfYbaG3kssnWtP+NExKLOcQ/iISbFyfKzM5dtvsYShJBR2+NEb7zxr6vTvlxnjIwBC6/UAHkS4G9B8waziMpd8lMdf4nmsgDETezaoIFJzlfhXxrvHINbq7dwinaAkPMS/cgCCvStbzCA3mg/5HR0pwWCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gMcJTK1s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54893C433B1;
	Mon, 22 Jan 2024 15:09:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705936195;
	bh=J3ZoyCqNWoh5B7jt/nT+iHpNhhc/7+h3H7S4EDnayoQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gMcJTK1sajq0OtpFnQLH0INdD4h12FFdWVzOxil6UmklO8GP2myzl01UuBJxjJs8/
	 DtxTD9hAWWmpuQmCELrOlNcvhRKLODBR38fZbXbqTLWONhnYSQh0/SS511TAXIsVfr
	 d/yY/BDeVkbrv5hb0rwr25GsxEa4B23ZAhOHWOQBtwvgib10cHqJqOGrUFoJ3tI6p4
	 VNdBtY5IMIpAyVvZlc0k8p4VyB62wrYBntn6/Jq8V+ZngmVGmcaXfAsHfhcq7RGg1i
	 +eSCGtTOmRpRoBfrlcPUvLeOUgPFJ4r6xOCshieNTvswnCFw+d6Vg9Wu//XeVeyDtW
	 Gf8iAB7IsmpFw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>,
	perex@perex.cz,
	tiwai@suse.com,
	cezary.rojewski@intel.com,
	broonie@kernel.org,
	siyanteng@loongson.cn,
	zhangyiqun@phytium.com.cn,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 02/53] ALSA: hda: Refer to correct stream index at loops
Date: Mon, 22 Jan 2024 10:08:03 -0500
Message-ID: <20240122150949.994249-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122150949.994249-1-sashal@kernel.org>
References: <20240122150949.994249-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.74
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
index 741a5d17ae4c..ecd3aec57c87 100644
--- a/sound/hda/hdac_stream.c
+++ b/sound/hda/hdac_stream.c
@@ -629,17 +629,15 @@ void snd_hdac_stream_timecounter_init(struct hdac_stream *azx_dev,
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
@@ -684,14 +682,13 @@ void snd_hdac_stream_sync(struct hdac_stream *azx_dev, bool start,
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


