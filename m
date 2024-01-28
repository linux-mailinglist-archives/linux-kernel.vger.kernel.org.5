Return-Path: <linux-kernel+bounces-41846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A7E483F893
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 18:43:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DA32283DE0
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 17:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C05071F606;
	Sun, 28 Jan 2024 17:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mutex.one header.i=@mutex.one header.b="ALLGWWgI"
Received: from mail.mutex.one (mail.mutex.one [62.77.152.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7878225635;
	Sun, 28 Jan 2024 17:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.77.152.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706463781; cv=none; b=UKdoz0WuL/EAFd/p3TqlQg2Cp2TxxnSRJjIt8Z0ofxqvsodvmBYy+fipWxrwPA3V8ISZxyPWndZyhhs9x8X1+S2jidS0Lm14kaY0jVRu6L/0kJcXbUMn5bOs4Od6J2fhXXi/fPJNlgKhey1o7zPwpGowdlYEydsM7kY0S6xCQU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706463781; c=relaxed/simple;
	bh=B5WmwXGS0N9URrRmpETD90ykLr9gtHFmbUouXkfqDD0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UNJlYHDI36yjxsGHfMEy5BTWAc6s+ldaGgszbxPjHS7RiKbuKYXTWYDWtWivIihCEbCgl2UnL1Vg+vZAGAb2BFwoa0SSjLbzB2nkzM6NIQeDEAVsaf1c6d01EkDO3Sfqy5QWEgZ7E/qyFcLmUpZpA+dA4QjJ+/gArg+o5qgl9QE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mutex.one; spf=pass smtp.mailfrom=mutex.one; dkim=pass (1024-bit key) header.d=mutex.one header.i=@mutex.one header.b=ALLGWWgI; arc=none smtp.client-ip=62.77.152.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mutex.one
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mutex.one
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.mutex.one (Postfix) with ESMTP id DC96116C0056;
	Sun, 28 Jan 2024 19:22:32 +0200 (EET)
X-Virus-Scanned: Debian amavisd-new at mail.mutex.one
Received: from mail.mutex.one ([127.0.0.1])
	by localhost (mail.mutex.one [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gUyIbahRNE3o; Sun, 28 Jan 2024 19:22:31 +0200 (EET)
From: Marian Postevca <posteuca@mutex.one>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mutex.one; s=default;
	t=1706462551; bh=B5WmwXGS0N9URrRmpETD90ykLr9gtHFmbUouXkfqDD0=;
	h=From:To:Cc:Subject:Date:From;
	b=ALLGWWgIktmmIygr/yLFeHHgtNsZKDutoRH4IZiya3xyk0AgGh8ybUToCn2Jzz3y3
	 XT/mWJeii2r2J0hVH3bXvwtNO2/0isOZ2FCpg7CxWUfQ6KJ2eFFNVpyBbtrZs59P85
	 O1Kqt4dqvplBAtoGUwWVStzoWwm6naPQ1bcZHuWY=
To: Mark Brown <broonie@kernel.org>,
	alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	Liam Girdwood <lgirdwood@gmail.com>,
	Takashi Iwai <tiwai@suse.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Marian Postevca <posteuca@mutex.one>
Subject: [PATCH] ASoC: amd: acp: Fix support for a Huawei Matebook laptop
Date: Sun, 28 Jan 2024 19:22:29 +0200
Message-ID: <20240128172229.657142-1-posteuca@mutex.one>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Previous commit that added support for Huawei MateBook D16 2021
with Ryzen 4600H (HVY-WXX9 M1010) was incomplete.

To activate support for this laptop, the DMI table in
acp3x-es83xx machine driver must also be updated.

Fixes: b5338b1b901e ("ASoC: amd: acp: Add support for a new Huawei Matebook laptop")
Signed-off-by: Marian Postevca <posteuca@mutex.one>
---
 sound/soc/amd/acp/acp3x-es83xx/acp3x-es83xx.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/sound/soc/amd/acp/acp3x-es83xx/acp3x-es83xx.c b/sound/soc/amd/acp/acp3x-es83xx/acp3x-es83xx.c
index f85b85ea4be9..2b0aa270a3e9 100644
--- a/sound/soc/amd/acp/acp3x-es83xx/acp3x-es83xx.c
+++ b/sound/soc/amd/acp/acp3x-es83xx/acp3x-es83xx.c
@@ -354,6 +354,14 @@ static const struct dmi_system_id acp3x_es83xx_dmi_table[] = {
 		},
 		.driver_data = (void *)(ES83XX_ENABLE_DMIC|ES83XX_48_MHZ_MCLK),
 	},
+	{
+		.matches = {
+			DMI_EXACT_MATCH(DMI_BOARD_VENDOR, "HUAWEI"),
+			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "HVY-WXX9"),
+			DMI_EXACT_MATCH(DMI_PRODUCT_VERSION, "M1010"),
+		},
+		.driver_data = (void *)(ES83XX_ENABLE_DMIC),
+	},
 	{
 		.matches = {
 			DMI_EXACT_MATCH(DMI_BOARD_VENDOR, "HUAWEI"),
-- 
2.43.0


