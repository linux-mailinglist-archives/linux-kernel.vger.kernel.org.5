Return-Path: <linux-kernel+bounces-63323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97B24852D9B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 11:14:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B30F1F22159
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 10:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85BD923749;
	Tue, 13 Feb 2024 10:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K0yAQdle"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCC862BB0E;
	Tue, 13 Feb 2024 10:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707819213; cv=none; b=DDvv77hYZ3FSWfDXewmEkRKOrtLyf+V1BZgPcaZ5HARCabyR8L33Xex7ihgzSpWzszeTaXsGjisrwpjgydSVizP6Chu3BazftJz0yw7lwxxgJm1x6H+kQmYfOKKEN+ctcuBXezS5hj8vqq5k4uDOWa8Pm/uc+nVBxvzAluK5Vw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707819213; c=relaxed/simple;
	bh=3+IG0j3O1LBG7lwMQUhmH60xhIv6owNHQLirTIxa6kk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CPaoXG8j9aFL22O0Yf/fPhupNBkYa4xrPQvUJ7nXt2GR7hRQX6Vr8j1I50gDGhmnv2Goedovhen6o/3a+g8BMrf5OcbToPv7/b2tMREK4NX1ulUsJNZA/m2O+eW1594mhIpNWygZcUdNUxTsjejmgJHZl4iqsyMIGn+yRHinUKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K0yAQdle; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2CDBC433C7;
	Tue, 13 Feb 2024 10:13:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707819213;
	bh=3+IG0j3O1LBG7lwMQUhmH60xhIv6owNHQLirTIxa6kk=;
	h=From:To:Cc:Subject:Date:From;
	b=K0yAQdleEJ+O3q3zOzf4XOypaOaV/eEjVm3b3YzNKsgRXtANa8APVm9A10agKVXC0
	 xXypXSc4MQXAt6rMsWRPRgg/9M0FYksQMoZK9IwhyynJzaYZtNTczewNt3NrJroWeE
	 /wx+mFn+n+i0iFZy49CU5U43qMJpX3gb6wQLh1ErClWVifIMHr6HPCK1DR/XHYDKYA
	 /bhctPo13V4f2xs0nJJNGP21zlj0FRL3qTagmBOPRevP6SaLu+StB9d6Fn8pDEuttY
	 couhC2vlbrwPUnHPBQnPkG74p2lg6eoDhqIOOdzQKpZez00KyCFQJ2bW9jMB5C6Zxj
	 EsVXm0GjGlS4g==
From: Arnd Bergmann <arnd@kernel.org>
To: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Cedric Bregardis <cedric.bregardis@free.fr>,
	Jean-Christian Hassler <jhassler@free.fr>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH] ALSA: aw2: avoid casting function pointers
Date: Tue, 13 Feb 2024 11:13:19 +0100
Message-Id: <20240213101327.460191-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

clang-16 started warning about incompatible function pointers here:

sound/pci/aw2/aw2-alsa.c:363:11: error: cast from 'void (*)(struct snd_pcm_substream *)' to 'snd_aw2_saa7146_it_cb' (aka 'void (*)(void *)') converts to incompatible function type [-Werror,-Wcast-function-type-strict]
  363 |                                                     (snd_aw2_saa7146_it_cb)
      |                                                     ^~~~~~~~~~~~~~~~~~~~~~~
  364 |                                                     snd_pcm_period_elapsed,
      |                                                     ~~~~~~~~~~~~~~~~~~~~~~
sound/pci/aw2/aw2-alsa.c:392:10: error: cast from 'void (*)(struct snd_pcm_substream *)' to 'snd_aw2_saa7146_it_cb' (aka 'void (*)(void *)') converts to incompatible function type [-Werror,-Wcast-function-type-strict]
  392 |                                                    (snd_aw2_saa7146_it_cb)
      |                                                    ^~~~~~~~~~~~~~~~~~~~~~~
  393 |                                                    snd_pcm_period_elapsed,
      |                                                    ~~~~~~~~~~~~~~~~~~~~~~

Add a forward declaration for struct snd_pcm_substrea to allow it to just
use the correct prototype.

Fixes: 98f2a97f207a ("[ALSA] Emagic Audiowerk 2 ALSA driver.")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 sound/pci/aw2/aw2-saa7146.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/pci/aw2/aw2-saa7146.h b/sound/pci/aw2/aw2-saa7146.h
index b5c5a71c0ac3..3a3de56b9b07 100644
--- a/sound/pci/aw2/aw2-saa7146.h
+++ b/sound/pci/aw2/aw2-saa7146.h
@@ -19,11 +19,12 @@
 
 #define NUM_STREAM_CAPTURE_ANA 0
 
-typedef void (*snd_aw2_saa7146_it_cb) (void *);
+struct snd_pcm_substream;
+typedef void (*snd_aw2_saa7146_it_cb) (struct snd_pcm_substream *);
 
 struct snd_aw2_saa7146_cb_param {
 	snd_aw2_saa7146_it_cb p_it_callback;
-	void *p_callback_param;
+	struct snd_pcm_substream *p_callback_param;
 };
 
 /* definition of the chip-specific record */
-- 
2.39.2


