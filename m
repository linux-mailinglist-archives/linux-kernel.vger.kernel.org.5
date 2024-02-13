Return-Path: <linux-kernel+bounces-63313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E6F7B852D88
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 11:10:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1781A1C22C4B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 10:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93527225D2;
	Tue, 13 Feb 2024 10:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OxfnLvrP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87DBA224E6;
	Tue, 13 Feb 2024 10:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707819026; cv=none; b=tr1NuoGIev474NycY9/cmZn6Yx4kh8L7g/8QWlX9Cq7vmkw5LqR2fveXXARcXwJ/4kyiQVrnBJhfae66Ne9CPkfqYC29hN8m7B0sXHg+I37jxh1U5Mn06jGh8VrmXL5fHee898/Nbm6HBXtsMtL88wrmhSqS58K+ErlbfMJQK/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707819026; c=relaxed/simple;
	bh=w5dtS5XYoH5xYbJtlCqzMWy5gRh0p5BGjVx/CjsDQco=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HbSx/K8fLM094SY4yp9+kJGykVLYv10OWOLQp8vkjXFad28e9zTFz9m18gW5OZRViIgs7mJte4lp5pzpVlv+1SGoI1I7oOPG2D+pN+h/uxK5kNX5JMPoBE60dGDR49vTawcSeTClvQlfFKt129LOIs0MzYCgQo7WOFzPg6TbKHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OxfnLvrP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73167C433F1;
	Tue, 13 Feb 2024 10:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707819026;
	bh=w5dtS5XYoH5xYbJtlCqzMWy5gRh0p5BGjVx/CjsDQco=;
	h=From:To:Cc:Subject:Date:From;
	b=OxfnLvrPJSOSHEYQr0yLc7o8hpE/rZo/D0kLg49rakf0sB5DBcUm4umlYh+7aV/5X
	 dTUng5qFz/HCPSt5RVAxRew1c2tZyMTMPxFbhDj+ZzDUzVgnKwPBKyzHSHpzxrr+ba
	 mi/Wie0N9GZUa6UwUSCabvjL90LZjQIDlmJboSYTmz/VONvl5c7nURFs4dkC3bTtIL
	 hM5Z9NaZ6UY4JVhepQhHNCu2/Pj7ERGQk4aJ/zbf0kZ0ZIu5ZUFGsAL5jPqYXSxfBC
	 IgFIizNnVifkP9IenL4xQwEa+juY/WQwsXvNtasgbIQOlN1G+IVhdtEzO32UHe20bC
	 RZzBY1lzSWIVA==
From: Arnd Bergmann <arnd@kernel.org>
To: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Curtis Malainey <cujomalainey@chromium.org>,
	Dmitry Antipov <dmantipov@yandex.ru>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH] ALSA: fix function cast warnings
Date: Tue, 13 Feb 2024 11:09:56 +0100
Message-Id: <20240213101020.459183-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

clang-16 points out a control flow integrity (kcfi) issue when event
callbacks get converted to incompatible types:

sound/core/seq/seq_midi.c:135:30: error: cast from 'int (*)(struct snd_rawmidi_substream *, const char *, int)' to 'snd_seq_dump_func_t' (aka 'int (*)(void *, void *, int)') converts to incompatible function type [-Werror,-Wcast-function-type-strict]
  135 |                 snd_seq_dump_var_event(ev, (snd_seq_dump_func_t)dump_midi, substream);
      |                                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
sound/core/seq/seq_virmidi.c:83:31: error: cast from 'int (*)(struct snd_rawmidi_substream *, const unsigned char *, int)' to 'snd_seq_dump_func_t' (aka 'int (*)(void *, void *, int)') converts to incompatible function type [-Werror,-Wcast-function-type-strict]
   83 |                         snd_seq_dump_var_event(ev, (snd_seq_dump_func_t)snd_rawmidi_receive, vmidi->substream);
      |                                                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Change these both to take a 'const void *' buffer and a 'void *' context,
converting to the respective types in the callee. The change to 'const'
buffers propagates to a couple of other functions.

The code was originally added with the initial ALSA merge in linux-2.5.4.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/sound/rawmidi.h            | 3 +--
 include/sound/seq_kernel.h         | 2 +-
 sound/core/rawmidi.c               | 6 +++---
 sound/core/seq/oss/seq_oss_readq.c | 4 ++--
 sound/core/seq/oss/seq_oss_readq.h | 2 +-
 sound/core/seq/seq_memory.c        | 4 ++--
 sound/core/seq/seq_midi.c          | 5 +++--
 sound/core/seq/seq_virmidi.c       | 2 +-
 8 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/include/sound/rawmidi.h b/include/sound/rawmidi.h
index f31cabf0158c..91947fb16e07 100644
--- a/include/sound/rawmidi.h
+++ b/include/sound/rawmidi.h
@@ -161,8 +161,7 @@ int snd_rawmidi_free(struct snd_rawmidi *rmidi);
 
 /* callbacks */
 
-int snd_rawmidi_receive(struct snd_rawmidi_substream *substream,
-			const unsigned char *buffer, int count);
+int snd_rawmidi_receive(void *ptr, const void *buffer, int count);
 int snd_rawmidi_transmit_empty(struct snd_rawmidi_substream *substream);
 int snd_rawmidi_transmit_peek(struct snd_rawmidi_substream *substream,
 			      unsigned char *buffer, int count);
diff --git a/include/sound/seq_kernel.h b/include/sound/seq_kernel.h
index c8621671fa70..804194d7c606 100644
--- a/include/sound/seq_kernel.h
+++ b/include/sound/seq_kernel.h
@@ -67,7 +67,7 @@ int snd_seq_kernel_client_ctl(int client, unsigned int cmd, void *arg);
 #define SNDRV_SEQ_EXT_USRPTR	0x80000000
 #define SNDRV_SEQ_EXT_CHAINED	0x40000000
 
-typedef int (*snd_seq_dump_func_t)(void *ptr, void *buf, int count);
+typedef int (*snd_seq_dump_func_t)(void *ptr, const void *buf, int count);
 int snd_seq_expand_var_event(const struct snd_seq_event *event, int count, char *buf,
 			     int in_kernel, int size_aligned);
 int snd_seq_expand_var_event_at(const struct snd_seq_event *event, int count,
diff --git a/sound/core/rawmidi.c b/sound/core/rawmidi.c
index 1431cb997808..ad588dcf857f 100644
--- a/sound/core/rawmidi.c
+++ b/sound/core/rawmidi.c
@@ -1165,9 +1165,9 @@ static struct timespec64 get_framing_tstamp(struct snd_rawmidi_substream *substr
  *
  * Return: The size of read data, or a negative error code on failure.
  */
-int snd_rawmidi_receive(struct snd_rawmidi_substream *substream,
-			const unsigned char *buffer, int count)
+int snd_rawmidi_receive(void *ptr, const void *buffer, int count)
 {
+	struct snd_rawmidi_substream *substream = ptr;
 	unsigned long flags;
 	struct timespec64 ts64 = get_framing_tstamp(substream);
 	int result = 0, count1;
@@ -1195,7 +1195,7 @@ int snd_rawmidi_receive(struct snd_rawmidi_substream *substream,
 	} else if (count == 1) {	/* special case, faster code */
 		substream->bytes++;
 		if (runtime->avail < runtime->buffer_size) {
-			runtime->buffer[runtime->hw_ptr++] = buffer[0];
+			runtime->buffer[runtime->hw_ptr++] = ((u8 *)buffer)[0];
 			runtime->hw_ptr %= runtime->buffer_size;
 			runtime->avail++;
 			result++;
diff --git a/sound/core/seq/oss/seq_oss_readq.c b/sound/core/seq/oss/seq_oss_readq.c
index f0db5d3dcba4..3679938c0ad9 100644
--- a/sound/core/seq/oss/seq_oss_readq.c
+++ b/sound/core/seq/oss/seq_oss_readq.c
@@ -86,7 +86,7 @@ snd_seq_oss_readq_clear(struct seq_oss_readq *q)
  * put a midi byte
  */
 int
-snd_seq_oss_readq_puts(struct seq_oss_readq *q, int dev, unsigned char *data, int len)
+snd_seq_oss_readq_puts(struct seq_oss_readq *q, int dev, const unsigned char *data, int len)
 {
 	union evrec rec;
 	int result;
@@ -113,7 +113,7 @@ struct readq_sysex_ctx {
 	int dev;
 };
 
-static int readq_dump_sysex(void *ptr, void *buf, int count)
+static int readq_dump_sysex(void *ptr, const void *buf, int count)
 {
 	struct readq_sysex_ctx *ctx = ptr;
 
diff --git a/sound/core/seq/oss/seq_oss_readq.h b/sound/core/seq/oss/seq_oss_readq.h
index 38d0c4682b29..bb99743fec7d 100644
--- a/sound/core/seq/oss/seq_oss_readq.h
+++ b/sound/core/seq/oss/seq_oss_readq.h
@@ -30,7 +30,7 @@ struct seq_oss_readq *snd_seq_oss_readq_new(struct seq_oss_devinfo *dp, int maxl
 void snd_seq_oss_readq_delete(struct seq_oss_readq *q);
 void snd_seq_oss_readq_clear(struct seq_oss_readq *readq);
 unsigned int snd_seq_oss_readq_poll(struct seq_oss_readq *readq, struct file *file, poll_table *wait);
-int snd_seq_oss_readq_puts(struct seq_oss_readq *readq, int dev, unsigned char *data, int len);
+int snd_seq_oss_readq_puts(struct seq_oss_readq *readq, int dev, const unsigned char *data, int len);
 int snd_seq_oss_readq_sysex(struct seq_oss_readq *q, int dev,
 			    struct snd_seq_event *ev);
 int snd_seq_oss_readq_put_event(struct seq_oss_readq *readq, union evrec *ev);
diff --git a/sound/core/seq/seq_memory.c b/sound/core/seq/seq_memory.c
index e705e7538118..3be3ee178e20 100644
--- a/sound/core/seq/seq_memory.c
+++ b/sound/core/seq/seq_memory.c
@@ -135,7 +135,7 @@ EXPORT_SYMBOL(snd_seq_dump_var_event);
  * expand the variable length event to linear buffer space.
  */
 
-static int seq_copy_in_kernel(void *ptr, void *src, int size)
+static int seq_copy_in_kernel(void *ptr, const void *src, int size)
 {
 	char **bufptr = ptr;
 
@@ -144,7 +144,7 @@ static int seq_copy_in_kernel(void *ptr, void *src, int size)
 	return 0;
 }
 
-static int seq_copy_in_user(void *ptr, void *src, int size)
+static int seq_copy_in_user(void *ptr, const void *src, int size)
 {
 	char __user **bufptr = ptr;
 
diff --git a/sound/core/seq/seq_midi.c b/sound/core/seq/seq_midi.c
index 18320a248aa7..e6547da31b09 100644
--- a/sound/core/seq/seq_midi.c
+++ b/sound/core/seq/seq_midi.c
@@ -94,8 +94,9 @@ static void snd_midi_input_event(struct snd_rawmidi_substream *substream)
 	}
 }
 
-static int dump_midi(struct snd_rawmidi_substream *substream, const char *buf, int count)
+static int dump_midi(void *ptr, const void *buf, int count)
 {
+	struct snd_rawmidi_substream *substream = ptr;
 	struct snd_rawmidi_runtime *runtime;
 	int tmp;
 
@@ -132,7 +133,7 @@ static int event_process_midi(struct snd_seq_event *ev, int direct,
 			pr_debug("ALSA: seq_midi: invalid sysex event flags = 0x%x\n", ev->flags);
 			return 0;
 		}
-		snd_seq_dump_var_event(ev, (snd_seq_dump_func_t)dump_midi, substream);
+		snd_seq_dump_var_event(ev, dump_midi, substream);
 		snd_midi_event_reset_decode(msynth->parser);
 	} else {
 		if (msynth->parser == NULL)
diff --git a/sound/core/seq/seq_virmidi.c b/sound/core/seq/seq_virmidi.c
index 1b9260108e48..ef8536408af4 100644
--- a/sound/core/seq/seq_virmidi.c
+++ b/sound/core/seq/seq_virmidi.c
@@ -80,7 +80,7 @@ static int snd_virmidi_dev_receive_event(struct snd_virmidi_dev *rdev,
 		if (ev->type == SNDRV_SEQ_EVENT_SYSEX) {
 			if ((ev->flags & SNDRV_SEQ_EVENT_LENGTH_MASK) != SNDRV_SEQ_EVENT_LENGTH_VARIABLE)
 				continue;
-			snd_seq_dump_var_event(ev, (snd_seq_dump_func_t)snd_rawmidi_receive, vmidi->substream);
+			snd_seq_dump_var_event(ev, snd_rawmidi_receive, vmidi->substream);
 			snd_midi_event_reset_decode(vmidi->parser);
 		} else {
 			len = snd_midi_event_decode(vmidi->parser, msg, sizeof(msg), ev);
-- 
2.39.2


