Return-Path: <linux-kernel+bounces-115232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C089B889366
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:28:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A849295A04
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EF5F3120CA;
	Mon, 25 Mar 2024 01:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qez0EzZj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B524D184EF4;
	Sun, 24 Mar 2024 23:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324330; cv=none; b=NbcYOnnFhCkLqgJ7sF6U/EsyU97faAABOmgy/JvWucgL7Tv/jBC/U71TfiFurBrBv+O1l5vuU+YTy79KeAOvehEZ5fWBWCRE1/synCsRwXXLnAcphUkMu8yZ8/Z8BHFs6UsezP5DPUeRnNgSbOHdnxopkIhxSRph8FIIpXQCLyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324330; c=relaxed/simple;
	bh=+y0TYPZiAtd+NHd92IK2TWo0iPyidCyhPNGn/a34lRE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ctKdQv7UIg9EfTsYNjWCvTzop6BwdrcBL22Q6eesZyGnndgyvNyefXjewVsW61bDwNEr5EvnHq4B4nBpyaoOptu9uP+JZ/KGwBlXvc7SYziqVm9sFtlfXu14zdZ1L/ZldGL9pnzVy39+9Y3VNPND8Kmdcv5d9HABXHfgRin/duA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qez0EzZj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE08AC433F1;
	Sun, 24 Mar 2024 23:52:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324329;
	bh=+y0TYPZiAtd+NHd92IK2TWo0iPyidCyhPNGn/a34lRE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qez0EzZjjAy37NcmxfsxCH5XH6HbHJfFaNJNvq1FRXoiaLOZ8FWf3IYhEpIf/0TVd
	 MCYtdxvcS8pXvHl5ktIXJjhuiux0v/s2wiv8W+racL/Q8pNelJ3ljkS0TasZ3LzX32
	 uDt0kQ/KBdSeTbvfDr3F78eqahKjFbSW/8UOCspTxRLgpffYmmsIG9FEnDMvdwpPUw
	 7ZICgRP4pvvLRRRACMxdhq/0C3FmF7vI4E82IL/PMm5DSWyn3qHVyu6zYEXa0/xQ9T
	 Fz1DICsm1wL5czx/xR6E55ybrVR2tJXNcipbHIkbdFQXY0D64sGXcNxKaPPdsL13Eh
	 SOkiUuX+Gs1cw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Takashi Iwai <tiwai@suse.de>,
	Arnd Bergmann <arnd@arndb.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 100/148] ALSA: seq: fix function cast warnings
Date: Sun, 24 Mar 2024 19:49:24 -0400
Message-ID: <20240324235012.1356413-101-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324235012.1356413-1-sashal@kernel.org>
References: <20240324235012.1356413-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Takashi Iwai <tiwai@suse.de>

[ Upstream commit d7bf73809849463f76de42aad62c850305dd6c5d ]

clang-16 points out a control flow integrity (kcfi) issue when event
callbacks get converted to incompatible types:

sound/core/seq/seq_midi.c:135:30: error: cast from 'int (*)(struct snd_rawmidi_substream *, const char *, int)' to 'snd_seq_dump_func_t' (aka 'int (*)(void *, void *, int)') converts to incompatible function type [-Werror,-Wcast-function-type-strict]
  135 |                 snd_seq_dump_var_event(ev, (snd_seq_dump_func_t)dump_midi, substream);
      |                                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
sound/core/seq/seq_virmidi.c:83:31: error: cast from 'int (*)(struct snd_rawmidi_substream *, const unsigned char *, int)' to 'snd_seq_dump_func_t' (aka 'int (*)(void *, void *, int)') converts to incompatible function type [-Werror,-Wcast-function-type-strict]
   83 |                         snd_seq_dump_var_event(ev, (snd_seq_dump_func_t)snd_rawmidi_receive, vmidi->substream);
      |                                                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

For addressing those errors, introduce wrapper functions that are used
for callbacks and bridge to the actual function call with pointer
cast.

The code was originally added with the initial ALSA merge in linux-2.5.4.

[ the patch description shamelessly copied from Arnd's original patch
  -- tiwai ]

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: Arnd Bergmann <arnd@arndb.de>
Link: https://lore.kernel.org/r/20240213101020.459183-1-arnd@kernel.org
Link: https://lore.kernel.org/r/20240213135343.16411-1-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/core/seq/seq_midi.c    | 8 +++++++-
 sound/core/seq/seq_virmidi.c | 9 ++++++++-
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/sound/core/seq/seq_midi.c b/sound/core/seq/seq_midi.c
index 9e0dabd3ce5f5..2bb6f21ac1964 100644
--- a/sound/core/seq/seq_midi.c
+++ b/sound/core/seq/seq_midi.c
@@ -125,6 +125,12 @@ static int dump_midi(struct snd_rawmidi_substream *substream, const char *buf, i
 	return 0;
 }
 
+/* callback for snd_seq_dump_var_event(), bridging to dump_midi() */
+static int __dump_midi(void *ptr, void *buf, int count)
+{
+	return dump_midi(ptr, buf, count);
+}
+
 static int event_process_midi(struct snd_seq_event *ev, int direct,
 			      void *private_data, int atomic, int hop)
 {
@@ -144,7 +150,7 @@ static int event_process_midi(struct snd_seq_event *ev, int direct,
 			pr_debug("ALSA: seq_midi: invalid sysex event flags = 0x%x\n", ev->flags);
 			return 0;
 		}
-		snd_seq_dump_var_event(ev, (snd_seq_dump_func_t)dump_midi, substream);
+		snd_seq_dump_var_event(ev, __dump_midi, substream);
 		snd_midi_event_reset_decode(msynth->parser);
 	} else {
 		if (msynth->parser == NULL)
diff --git a/sound/core/seq/seq_virmidi.c b/sound/core/seq/seq_virmidi.c
index af9af89a44d4e..23975b86e1d4b 100644
--- a/sound/core/seq/seq_virmidi.c
+++ b/sound/core/seq/seq_virmidi.c
@@ -76,6 +76,13 @@ static void snd_virmidi_init_event(struct snd_virmidi *vmidi,
 /*
  * decode input event and put to read buffer of each opened file
  */
+
+/* callback for snd_seq_dump_var_event(), bridging to snd_rawmidi_receive() */
+static int dump_to_rawmidi(void *ptr, void *buf, int count)
+{
+	return snd_rawmidi_receive(ptr, buf, count);
+}
+
 static int snd_virmidi_dev_receive_event(struct snd_virmidi_dev *rdev,
 					 struct snd_seq_event *ev,
 					 bool atomic)
@@ -94,7 +101,7 @@ static int snd_virmidi_dev_receive_event(struct snd_virmidi_dev *rdev,
 		if (ev->type == SNDRV_SEQ_EVENT_SYSEX) {
 			if ((ev->flags & SNDRV_SEQ_EVENT_LENGTH_MASK) != SNDRV_SEQ_EVENT_LENGTH_VARIABLE)
 				continue;
-			snd_seq_dump_var_event(ev, (snd_seq_dump_func_t)snd_rawmidi_receive, vmidi->substream);
+			snd_seq_dump_var_event(ev, dump_to_rawmidi, vmidi->substream);
 			snd_midi_event_reset_decode(vmidi->parser);
 		} else {
 			len = snd_midi_event_decode(vmidi->parser, msg, sizeof(msg), ev);
-- 
2.43.0


