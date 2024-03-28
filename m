Return-Path: <linux-kernel+bounces-123370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B3464890744
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 18:35:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D25929C4CF
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 17:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3A8512F399;
	Thu, 28 Mar 2024 17:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=t-argos.ru header.i=@t-argos.ru header.b="fcRqWyBO"
Received: from mx1.t-argos.ru (mx1.t-argos.ru [109.73.34.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F14B14A84;
	Thu, 28 Mar 2024 17:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.73.34.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711647320; cv=none; b=QW3N5dpVxWUVDNCK13WYkv1b6SA4/zDdPozRj1RYX3T6YheIR/XHPVjc87Y4cJem4X5KeppOYP2B2OsbXec/u6vc5aWS/mSFSymqG2qwbw8ez1IqQX+Gmj0uKITQG7QNccUTz6r5iL/kAZclF3zf39eRakgDAk1sIDuJMy1q1Gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711647320; c=relaxed/simple;
	bh=pgpRjdYvE6XkBLzVGAuv411UInyEJ+Ima53o7NfjVLo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pZKCl5bcbC00VFAzgMHobbfsMTKtY0qPEMfZxxP5pS38DwPk7i8UG4B+5x72t1+ldY57s3xDRU1k0gTQ+wkGbFZ4meH9OnBqGzUbiVg7y9Wq6Pc3wkZhwNetLmhLDtpHbWmh+tQryrt3MUuqtVY3dI6vERDNa6zixUXYrzt2o10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=t-argos.ru; spf=pass smtp.mailfrom=t-argos.ru; dkim=pass (2048-bit key) header.d=t-argos.ru header.i=@t-argos.ru header.b=fcRqWyBO; arc=none smtp.client-ip=109.73.34.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=t-argos.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=t-argos.ru
Received: from mx1.t-argos.ru (localhost [127.0.0.1])
	by mx1.t-argos.ru (Postfix) with ESMTP id DA28B100002;
	Thu, 28 Mar 2024 20:34:55 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=t-argos.ru; s=mail;
	t=1711647295; bh=woseDRdyM4juKO+cAWZ27r4/vCdyFNNlrp2AGifkU38=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=fcRqWyBOhVtuk2UBYQi9x6cOUr5ApkyJr8Jdk7j4b67G8m/6CAuISxAcuSzDkue25
	 PuNsjybe0pS/g1YoBt9vDLJJoyZFCxIGCYEvotx+wxccw3RXFZZfm4uC4TyMaEQCTP
	 wnM35fHneXEkq9Imc2A1VvjuKp8WZYnRFGdymIImaq8yc6E+Xxv7AS3EXnTOcRgwS5
	 KBjyRRG9PJ1HCn7qUfqBL3SQ4EH64X2DfEvfvMIhzQbrG33O/OF8+oJjR6zYFsyjmO
	 VOBGa/H2HYoPkLVUqOlf1zEeos4j+dNnZWBULNoGVYILr8Tgl4qk9tgEUahdZqGwsB
	 Y5u2us+x8LYLQ==
Received: from mx1.t-argos.ru.ru (ta-mail-02.ta.t-argos.ru [172.17.13.212])
	by mx1.t-argos.ru (Postfix) with ESMTP;
	Thu, 28 Mar 2024 20:34:05 +0300 (MSK)
Received: from localhost.localdomain (172.17.215.6) by ta-mail-02
 (172.17.13.212) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 28 Mar
 2024 20:33:44 +0300
From: Aleksandr Mishin <amishin@t-argos.ru>
To: Liam Girdwood <lgirdwood@gmail.com>
CC: Aleksandr Mishin <amishin@t-argos.ru>, Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Kuninori
 Morimoto <kuninori.morimoto.gx@renesas.com>, <linux-sound@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <lvc-project@linuxtesting.org>
Subject: [PATCH] ASoC: kirkwood: Fix potential NULL dereference
Date: Thu, 28 Mar 2024 20:33:37 +0300
Message-ID: <20240328173337.21406-1-amishin@t-argos.ru>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ta-mail-02.ta.t-argos.ru (172.17.13.212) To ta-mail-02
 (172.17.13.212)
X-KSMG-Rule-ID: 1
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 184474 [Mar 28 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: amishin@t-argos.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 14 0.3.14 5a0c43d8a1c3c0e5b0916cc02a90d4b950c01f96, {Tracking_from_domain_doesnt_match_to}, d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;t-argos.ru:7.1.1;127.0.0.199:7.1.2;mx1.t-argos.ru.ru:7.1.1, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/03/28 17:08:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2024/03/28 12:50:00 #24493847
X-KSMG-AntiVirus-Status: Clean, skipped

In kirkwood_dma_hw_params() mv_mbus_dram_info() returns NULL if
CONFIG_PLAT_ORION macro is not defined.
Fix this bug by adding NULL check.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: bb6a40fc5a83 ("ASoC: kirkwood: Fix reference to PCM buffer address")
Signed-off-by: Aleksandr Mishin <amishin@t-argos.ru>
---
 sound/soc/kirkwood/kirkwood-dma.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/kirkwood/kirkwood-dma.c b/sound/soc/kirkwood/kirkwood-dma.c
index dd2f806526c1..ef00792e1d49 100644
--- a/sound/soc/kirkwood/kirkwood-dma.c
+++ b/sound/soc/kirkwood/kirkwood-dma.c
@@ -182,6 +182,9 @@ static int kirkwood_dma_hw_params(struct snd_soc_component *component,
 	const struct mbus_dram_target_info *dram = mv_mbus_dram_info();
 	unsigned long addr = substream->runtime->dma_addr;
 
+	if (!dram)
+		return 0;
+
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
 		kirkwood_dma_conf_mbus_windows(priv->io,
 			KIRKWOOD_PLAYBACK_WIN, addr, dram);
-- 
2.30.2


