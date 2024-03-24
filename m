Return-Path: <linux-kernel+bounces-115007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CFEB888C80
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:22:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EDC91C29C8D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:22:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D6571C0C25;
	Mon, 25 Mar 2024 00:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jy0M3AJ2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 848A117C626;
	Sun, 24 Mar 2024 23:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323771; cv=none; b=TC/TGv2xo9pxhJ15utGgHG90CnFMBLumyKlX8WwgwA1gxD8trIF7eLV+PLBaNDlVHenQDQPqhbaVfIackR5e+8z3zvB0YpdZGvENBGrssILQvPwQeO6ihkfCtxcPgpjpXO2tEOgy/y2aWJ/r1bIQ+qVUk0rc+y4/1woBbvhTogA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323771; c=relaxed/simple;
	bh=lqEdFFPxC0/3d/WRyr5uSH3G+pJQvMxlAk1JO+CwFYs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GjjAIWU/4K1Kyo2QakgE7Qy44fx5aW/mtBgpjc2dPqlAV/wk0H09t2SFuNO+czsB5/roP7Ns7IWa71cxMEnvnaWhCRMEbe4nVL9Ao1e3OmgB7m0TCc0GkPj9XrLj69sHqFiYhqLWlkGFy5/58Ei9UUXebyOXIkDsk9ljTEs0aMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jy0M3AJ2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3DAFC433C7;
	Sun, 24 Mar 2024 23:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323770;
	bh=lqEdFFPxC0/3d/WRyr5uSH3G+pJQvMxlAk1JO+CwFYs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Jy0M3AJ2Kkzjzgi2yDmhjYSTeX4MhtVP500pt+JLjNqvJJ2LzrZ4IWLahi9lwJbCr
	 9vS2URENuu+hzVu017dHgmHT5MIQ2aDogkKhR+C4kys4TeTXSPu133QjKfXF3N0YIv
	 nkeznby6DoI8eoBBJKUMUQ4Ady4hAiW1a76rxe4U6wlp2zTa8IqLfU+J7bCj5yAaPq
	 7zzfeEsst+cDxnZzuoGriDkNKIRu/3xi1eykc8Gt9LE6MjGEC4x7KPm3QGm30j5FnM
	 rwyduQNCiJVuj5Xh9rK4mCl5G66Qul5zhzt2bJzaJ/znYeoaWLSBvDKbI/gMrkxjQ1
	 ZY2Dox9LjaONg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Takashi Iwai <tiwai@suse.de>,
	Arnd Bergmann <arnd@arndb.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 146/238] ALSA: seq: fix function cast warnings
Date: Sun, 24 Mar 2024 19:38:54 -0400
Message-ID: <20240324234027.1354210-147-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234027.1354210-1-sashal@kernel.org>
References: <20240324234027.1354210-1-sashal@kernel.org>
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
index 6825940ea2cf8..a741d1ae6639a 100644
--- a/sound/core/seq/seq_midi.c
+++ b/sound/core/seq/seq_midi.c
@@ -111,6 +111,12 @@ static int dump_midi(struct snd_rawmidi_substream *substream, const char *buf, i
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
@@ -130,7 +136,7 @@ static int event_process_midi(struct snd_seq_event *ev, int direct,
 			pr_debug("ALSA: seq_midi: invalid sysex event flags = 0x%x\n", ev->flags);
 			return 0;
 		}
-		snd_seq_dump_var_event(ev, (snd_seq_dump_func_t)dump_midi, substream);
+		snd_seq_dump_var_event(ev, __dump_midi, substream);
 		snd_midi_event_reset_decode(msynth->parser);
 	} else {
 		if (msynth->parser == NULL)
diff --git a/sound/core/seq/seq_virmidi.c b/sound/core/seq/seq_virmidi.c
index 77d7037d1476f..82396b8c885a5 100644
--- a/sound/core/seq/seq_virmidi.c
+++ b/sound/core/seq/seq_virmidi.c
@@ -62,6 +62,13 @@ static void snd_virmidi_init_event(struct snd_virmidi *vmidi,
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
@@ -80,7 +87,7 @@ static int snd_virmidi_dev_receive_event(struct snd_virmidi_dev *rdev,
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


