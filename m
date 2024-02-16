Return-Path: <linux-kernel+bounces-68606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF29F857D10
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 14:01:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7961E1F266A5
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 13:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BEB31292E7;
	Fri, 16 Feb 2024 13:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qw9uyJj5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A9012883D;
	Fri, 16 Feb 2024 13:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708088456; cv=none; b=UWWKLbHzHVIX76og69Hwx/QywNgy/TJ9YmZapaIzHzaxUdVEZrTTSE2FgluSKUMNGk7j8p9SUg96Mc5b/EK5DShaWXE04vzTtsO3j/bm5N6u851WS0GJyFVah1VYRfpQXHqmw9VJM8UfdaNIctZFsup4OxLj0v+iNLJ5d1d5CEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708088456; c=relaxed/simple;
	bh=cJk02p6GPEQNgHFZ7cmc8x6CZ4W/98+yT4cisVv1/94=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZSu/kB3YQb7YT4TpgLZSe0fwHatE2QAobhiKzpS/uh92DGTC08kdNUUzsfTNzuz+eTDbSRnIV3aWD5tTtooeuE8UX/mze3LTYpdFOC35zgcs9sxpTqLOadBms3Er6C+NT2THzXFQVU8Sv5n6E6YbL2xNNLZsyQoheIVqrd5LaJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qw9uyJj5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81FF1C433C7;
	Fri, 16 Feb 2024 13:00:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708088456;
	bh=cJk02p6GPEQNgHFZ7cmc8x6CZ4W/98+yT4cisVv1/94=;
	h=From:To:Cc:Subject:Date:From;
	b=qw9uyJj5rL//tl/+WhqXqS0rS0sB2ZXF8MkSr/3r1VUYaiTzBWD76Oly4f4EIltKa
	 AVjZfJdCzfNr7k7BYFIhok5cO4Go2c6rD4HrKBykHSlLaj5Dp/YIPRyzsoEiQdSKEx
	 7KSLzwMPltNIlkxwjXApheXGaxyLEjFG5vmyEV7sCvi3dEyhbCQMMNPxGufOsn89iN
	 qBNz02XSSo7jHB12IbVFiSzG9gyzHmXssjvhezbcSj2tNKH7TFQQF0jrEY5jCkrFTI
	 o1xJhxaI4CxOKWCqECdjLS0lgmt8ucFOdi3Z0/kyFWUNVs/yJT8/2FGXC6RxHONk72
	 /aeXCfhMJChcA==
From: Arnd Bergmann <arnd@kernel.org>
To: Ivan Orlov <ivan.orlov0322@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Naresh Kamboju <naresh.kamboju@linaro.org>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: core: fix buffer overflow in test_format_fill_silence()
Date: Fri, 16 Feb 2024 14:00:36 +0100
Message-Id: <20240216130050.3786789-1-arnd@kernel.org>
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
Fixes: 3e39acf56ede ("ALSA: core: Add sound core KUnit test")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
Naresh, I slightly changed the patch to make the computation more obvious,
can you test again to make sure I got this right?
---
 sound/core/sound_kunit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/core/sound_kunit.c b/sound/core/sound_kunit.c
index 5d5a7bf88de4..7f16101ece7a 100644
--- a/sound/core/sound_kunit.c
+++ b/sound/core/sound_kunit.c
@@ -8,7 +8,7 @@
 #include <sound/core.h>
 #include <sound/pcm.h>
 
-#define SILENCE_BUFFER_SIZE 2048
+#define SILENCE_BUFFER_SIZE (sizeof(u64) * 260)
 #define SILENCE(...) { __VA_ARGS__ }
 #define DEFINE_FORMAT(fmt, pbits, wd, endianness, signd, silence_arr) {		\
 	.format = SNDRV_PCM_FORMAT_##fmt, .physical_bits = pbits,		\
-- 
2.39.2


