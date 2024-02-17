Return-Path: <linux-kernel+bounces-69805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 273F4858EC9
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 11:43:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70DC6282A7A
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 10:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35FAD4E1A3;
	Sat, 17 Feb 2024 10:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DPIfn2oy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7305B1078D;
	Sat, 17 Feb 2024 10:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708166599; cv=none; b=DqbEJM1xocubMSV1OFGuBr3twsieGtNfbNUMHdIzuRMQ8wcZNFBQz9xXR7xyw+1kxLx5LCvVfGyNqxAZA4uh20S9m71v/xeFYyAnI67CQWVjBr9CPorg5juWlb/2+n1QB+RtzxutSbvjv8FrxMg9LZ4qWkUkSUta5IJM6m5oG8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708166599; c=relaxed/simple;
	bh=HIy5sPMU9DHH+BFlRRjzwudwVw7t66cdgcOhFZZZ5H8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TF4iQ+pZT5c+dp+3maJP8FC8jhtdA/HXVE7yTFl2isZap6ERjVwCh6WGzoobddacpuFsx4r+nH4rz7XxBzLbJ1Su2IRjMHn55jNDYMyh9p3XJ+su5fJdxuyzSh+OwgLVdx6XyhJZKoICCfklsCHuYIA6Jl7dHDZgsn7zzoviTjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DPIfn2oy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6010DC433C7;
	Sat, 17 Feb 2024 10:43:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708166599;
	bh=HIy5sPMU9DHH+BFlRRjzwudwVw7t66cdgcOhFZZZ5H8=;
	h=From:To:Cc:Subject:Date:From;
	b=DPIfn2oymuRzJAmPhNCXqwj3+kIXG/rda9ZYzZ7RU+zxrV1I92iTgA7a3dHB/OKuK
	 sZH5vCk3ai/DEDGuTDNXAWiQVsKVqAS7p8SKhiSJQwKFfHoMyShLN05McWhSYjLZ+a
	 x/XLUPqRdFqtWkX65h8KJ/z7L+SYel7HDW5UfwwM792kZDJlkEfOGwBkrHtSWf1loK
	 bPaSbI9ylR8Hg+2bswYJAtMbemK4XtW6VmWu1Jgnq10Uk8VGeIsHX9o4iVf55zprVL
	 mPXx7ipGWOXbgYb315O5+e7pIIYSf9XQpvWefoFlywPAyTW/sCmesiClenav87dXR5
	 o1zIGwZAjNVZg==
From: Arnd Bergmann <arnd@kernel.org>
To: Ivan Orlov <ivan.orlov0322@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Naresh Kamboju <naresh.kamboju@linaro.org>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] [v2] ALSA: core: fix buffer overflow in test_format_fill_silence()
Date: Sat, 17 Feb 2024 11:42:38 +0100
Message-Id: <20240217104311.3749655-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

KASAN caught a buffer overflow with the hardcoded 2048 byte buffer
size, when 2080 bytes are written to it:

 BUG: KASAN: slab-out-of-bounds in snd_pcm_format_set_silence+0x3bc/0x3e4
 Write of size 8 at addr ffff0000c8149800 by task kunit_try_catch/1297

 CPU: 0 PID: 1297 Comm: kunit_try_catch Tainted: G N 6.8.0-rc4-next-20240216 #1
 Hardware name: linux,dummy-virt (DT)
 Call trace:
  kasan_report+0x78/0xc0
  __asan_report_store_n_noabort+0x1c/0x28
  snd_pcm_format_set_silence+0x3bc/0x3e4
  _test_fill_silence+0xdc/0x298
  test_format_fill_silence+0x110/0x228
  kunit_try_run_case+0x144/0x3bc
  kunit_generic_run_threadfn_adapter+0x50/0x94
  kthread+0x330/0x3e8
  ret_from_fork+0x10/0x20

 Allocated by task 1297:
  __kmalloc+0x17c/0x2f0
  kunit_kmalloc_array+0x2c/0x78
  test_format_fill_silence+0xcc/0x228
  kunit_try_run_case+0x144/0x3bc
  kunit_generic_run_threadfn_adapter+0x50/0x94
  kthread+0x330/0x3e8
  ret_from_fork+0x10/0x20

Replace the incorrect size with the correct length of 260 64-bit samples.

Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Suggested-by: Ivan Orlov <ivan.orlov0322@gmail.com>
Fixes: 3e39acf56ede ("ALSA: core: Add sound core KUnit test")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
v2: use a named constant as suggested by Ivan Orlov
---
 sound/core/sound_kunit.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/core/sound_kunit.c b/sound/core/sound_kunit.c
index 5d5a7bf88de4..4212c4a20697 100644
--- a/sound/core/sound_kunit.c
+++ b/sound/core/sound_kunit.c
@@ -8,7 +8,8 @@
 #include <sound/core.h>
 #include <sound/pcm.h>
 
-#define SILENCE_BUFFER_SIZE 2048
+#define SILENCE_BUFFER_MAX_FRAMES 260
+#define SILENCE_BUFFER_SIZE (sizeof(u64) * SILENCE_BUFFER_MAX_FRAMES)
 #define SILENCE(...) { __VA_ARGS__ }
 #define DEFINE_FORMAT(fmt, pbits, wd, endianness, signd, silence_arr) {		\
 	.format = SNDRV_PCM_FORMAT_##fmt, .physical_bits = pbits,		\
@@ -165,7 +166,7 @@ static void _test_fill_silence(struct kunit *test, struct snd_format_test_data *
 
 static void test_format_fill_silence(struct kunit *test)
 {
-	u32 buf_samples[] = { 10, 20, 32, 64, 129, 260 };
+	u32 buf_samples[] = { 10, 20, 32, 64, 129, SILENCE_BUFFER_MAX_FRAMES };
 	u8 *buffer;
 	u32 i, j;
 
-- 
2.39.2


