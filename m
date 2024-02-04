Return-Path: <linux-kernel+bounces-51908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F20584909D
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 22:21:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CDCD1F21B3E
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 21:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E395428E09;
	Sun,  4 Feb 2024 21:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NhbfXbv7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 328DC2C1BA;
	Sun,  4 Feb 2024 21:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707081701; cv=none; b=ixvyK+AmiBBZ+Ao5vaYdkCKYG/BdVien/aYBjs2HRG0/mCm11iohbuxNzXhbij18xdIRJIIsMn8GS+QL9sZbD0ibPd+dR1AAHrD1LNKEW0/fbUOrdnckAAmU+4ERirWavvRWywl4Yy3mJbMZ+Y4uOtmpqHNaI7bgWk8asJd81zY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707081701; c=relaxed/simple;
	bh=46lfg4YvExRXyYOJW3a3RfaHnPfPgRlFNivzHCniyQY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sWoUSgCPKzUg7iCmKQ9jXTjgI1K5UgL+68USKMCqG6x64uhxgGnH87OVkPaFQayLmKBnyeVtXCvEcGI7CArMWrovRTO2KFiNyGxUv0EnhVc8LmVouX073SKSJddyWgHvT1spixkl663olCgbn1cRl2UxrJ8qz3zQPrIo+l29QWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NhbfXbv7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AA86C433F1;
	Sun,  4 Feb 2024 21:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707081700;
	bh=46lfg4YvExRXyYOJW3a3RfaHnPfPgRlFNivzHCniyQY=;
	h=From:To:Cc:Subject:Date:From;
	b=NhbfXbv7OsKRFXgM/C8i8RC/iRkajLh1NfWDxS3lNten1YhaVI3w4gSjrZRf61r0g
	 9TLWQV6hTJzy10YWjaChJ038FNORS35+P8nlSFOsUgPiqH14VU166lPWjmhshP1dbJ
	 XXA0zT+E4nPGXZYgAdkq9HUOZ4Ku+8SvxGLRwVzGykefwZd8cpS1tVGlrI83OC6Xv8
	 ookMAUO8Q0ormhwNYtEteJuT7o/rFjxlPxnKEnKa5WgR73ipwTRhGpPjYxuE8eLP96
	 1QC3IhWQIV88pnAo3apgDB2V2Yid+VyQMbHmBzKnXJ2kC8fZM/GUsBdvYCb83uHZPM
	 XfP5wYxHmy7LA==
From: Arnd Bergmann <arnd@kernel.org>
To: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Ivan Orlov <ivan.orlov0322@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: core: fix unit test dependencies
Date: Sun,  4 Feb 2024 22:21:29 +0100
Message-Id: <20240204212135.3158722-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

The Kunit tests fail to link when PCM support is disabled:

aarch64-linux-ld: sound/core/sound_kunit.o: in function `test_pcm_format_name':
sound_kunit.c:(.text+0x4c): undefined reference to `snd_pcm_format_name'
aarch64-linux-ld: sound_kunit.c:(.text+0x12c): undefined reference to `snd_pcm_format_name'
aarch64-linux-ld: sound/core/sound_kunit.o: in function `_test_fill_silence':
sound_kunit.c:(.text+0x284): undefined reference to `snd_pcm_format_set_silence'
aarch64-linux-ld: sound/core/sound_kunit.o: in function `test_format_signed':
sound_kunit.c:(.text+0x400): undefined reference to `snd_pcm_format_signed'
aarch64-linux-ld: sound_kunit.c:(.text+0x470): undefined reference to `snd_pcm_format_unsigned'
aarch64-linux-ld: sound/core/sound_kunit.o: in function `test_format_width':
sound_kunit.c:(.text+0x64c): undefined reference to `snd_pcm_format_width'
aarch64-linux-ld: sound_kunit.c:(.text+0x71c): undefined reference to `snd_pcm_format_width'

Add the appropriate dependencies.

Fixes: 3e39acf56ede ("ALSA: core: Add sound core KUnit test")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 sound/core/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/core/Kconfig b/sound/core/Kconfig
index 664c6ee2b5a1..9a44f259ccca 100644
--- a/sound/core/Kconfig
+++ b/sound/core/Kconfig
@@ -42,6 +42,7 @@ config SND_UMP_LEGACY_RAWMIDI
 config SND_CORE_TEST
 	tristate "Sound core KUnit test"
 	depends on KUNIT
+	depends on SND_PCM
 	default KUNIT_ALL_TESTS
 	help
 	  This options enables the sound core functions KUnit test.
-- 
2.39.2


