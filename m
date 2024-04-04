Return-Path: <linux-kernel+bounces-131206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48089898479
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 11:58:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 782D31C22EEE
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 09:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E04A74C17;
	Thu,  4 Apr 2024 09:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ubs7MaYc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F8B745DC;
	Thu,  4 Apr 2024 09:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712224682; cv=none; b=Ma4HsQruuOYiDRK1swr4ZF9+ETcAMcCFOZbNiDmBnwS5NHnGd7g/XhJh/yNSnoWjjvzqS4oD7z4mbhEI4GGZpDkFqDCIij6R8vSyvb7nFfw3TloFpFTx+QBYI4HnkEMnRLyK6BEeShEpVd2Fno6dvwoQbEDy0NqXUGzMDrRylTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712224682; c=relaxed/simple;
	bh=17mEkdPvUNZVSmiPTDoEKoSyn8eH26ZHEB3ewee+IqE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rYns++U9AXJ6OUtucTb8Svhca6ZiyUtZpfBdCvX3S2rxvEEHaeS6/8+/fkgd4NI0l/bLKf+PPaYuMiM+61nxsONfUl6/YjtZAMjX3euPvBN1TKSrUeZAdmLX7vIX1NEJGUA62gVz9seB1uZQZte9Sa2eoErwVhNtSECYBF/QeL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ubs7MaYc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74D1DC433C7;
	Thu,  4 Apr 2024 09:57:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712224681;
	bh=17mEkdPvUNZVSmiPTDoEKoSyn8eH26ZHEB3ewee+IqE=;
	h=From:To:Cc:Subject:Date:From;
	b=Ubs7MaYcCK0B+GYrcVzd6Mebo9OgNtS07tIjn49URnebTW9cKbtwyzk6mUNagqIOG
	 0HY4NWzLUZRHWdoubYzcWeBcG40XDmJznomC3Fs5FCbpVvr5DfvO8WzxR5chZ1ora3
	 otO8abv7IcSfsJtUSLFZlv6p15J+j0XkZnttBjzN686qK2A+TUQEoynPzTRk3TBhFN
	 vKiG7qGLG72GJQNd2XDWuMqm5ES8nCNAaOgqQgwqFRNxo69ymek4RGc84KzodczycA
	 kT6laB/8cXwD2UkG1MpWo6iwGmvGlRbJbJD3KHQkDI8cABO+GM/gufsKgC9xvs/S51
	 PkV7csNFN1YOA==
From: Arnd Bergmann <arnd@kernel.org>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Mark Brown <broonie@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: codecs: rk3308: fix building without CONFIG_OF
Date: Thu,  4 Apr 2024 11:57:34 +0200
Message-Id: <20240404095755.650364-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

The newly added codec has an extraneous of_match_ptr() annotation for
the ID table:

sound/soc/codecs/rk3308_codec.c:956:34: error: 'rk3308_codec_of_match' defined but not used [-Werror=unused-const-variable=]
  956 | static const struct of_device_id rk3308_codec_of_match[] = {

Remove it to avoid introducing a warning when -Wunused-const-variable
gets enabled by default:

Fixes: 4ed0915f5bc4 ("ASoC: codecs: Add RK3308 internal audio codec driver")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 sound/soc/codecs/rk3308_codec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rk3308_codec.c b/sound/soc/codecs/rk3308_codec.c
index 9d3e4691a7b5..6b1cb92997b4 100644
--- a/sound/soc/codecs/rk3308_codec.c
+++ b/sound/soc/codecs/rk3308_codec.c
@@ -962,7 +962,7 @@ MODULE_DEVICE_TABLE(of, rk3308_codec_of_match);
 static struct platform_driver rk3308_codec_driver = {
 	.driver = {
 		.name = "rk3308-acodec",
-		.of_match_table = of_match_ptr(rk3308_codec_of_match),
+		.of_match_table = rk3308_codec_of_match,
 	},
 	.probe = rk3308_codec_platform_probe,
 };
-- 
2.39.2


