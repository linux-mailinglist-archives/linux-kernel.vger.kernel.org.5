Return-Path: <linux-kernel+bounces-129633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C427A896D99
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 13:04:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00E451C21FFE
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 11:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B4381411F6;
	Wed,  3 Apr 2024 11:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="eQdBw5ze"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C23BC139588;
	Wed,  3 Apr 2024 11:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712142222; cv=none; b=PT+Rsnz0abinWHqCX6iExKah48/9UJ0dcJv2hsX8BQNux583G8zFkr6YiuhK32F485NVovDEGYFWonP3sc0ya02R3B0epvCguFnlW/ebjBlkYtXY9rEp/LGmsUEV2QQYgoyuCVtHf2+mfBhZhEscARuCzLD8xSjx+/3PY9s7bWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712142222; c=relaxed/simple;
	bh=ND/CjkhRoWoq1S5wep3hrHMEuyRwnZ2aM5WQ8jAsR3g=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=FQl/lRH3aa8Y264ajegYPjRGUkchhFZPjoTvxA8FHhujjDhtCJhB3PE2B3dADzWfjMQDsT7xXzCglI/k3V9iFReHSgSh9GDa1maLj+QmkpCHByk6O9oduQE1LFjuxLyrF3s6IetbBuHruz/ZjDx8+m06PtlprQRdl5HFs/4PTWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=eQdBw5ze; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id B45F21C0002;
	Wed,  3 Apr 2024 11:03:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1712142211;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=FJDsJZRZvPjpMG0mfcOCLmMwwx8LDlLdoozWcuEeQ9k=;
	b=eQdBw5ze+KCVNTQz90sfBeP3bDwGQD2sAjgAzeQegUYHutgySLTbb8n4JJ/8X4AH9tXpWn
	VR57ziMV8smv1ShV6M141wETe3jg4hhHzQdjd2v9J7tHbRjZ06DXtJke1l7Iq/TJpFoJpK
	mbItQcoYkMHcNjKevkShT27uHwP+ktXPLMTBD/+sry/7Yub6E47CtUFVbwWZhAKDthBwW+
	5tiL/DmneZ1nVvdZEwbwgaBRyO1+V/gkP7DMILpWKKut7466jx92t32r3wgqAD2DGCF2Ax
	iUnch26U1ulzxbMcXmMqfNKfcg62W6NK/1HfKRGkq/OX9/ZvWmh4YLXvHYXrVg==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Subject: [PATCH v2 0/2] ASoC: codecs: rk3308: fix build warning without OF
Date: Wed, 03 Apr 2024 13:03:17 +0200
Message-Id: <20240403-rk3308-audio-codec-fix-warning-v2-0-816bae4c1dc5@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHU3DWYC/42NTQ6CMBBGr0K6dgwtAtaV9zAs+jPARO2YFlFDu
 LuVE7h835e8t4iEkTCJU7GIiDMl4pBB7QrhRhMGBPKZhSrVoayUhnitqvII5umJwbFHBz294WV
 ioDBALa2tW4XW60ZkySNivrfApcs8Upo4frbeLH/r3+pZggSrvWzb3vnG6bNlnm4U9o7volvX9
 QuKO/h9zgAAAA==
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Heiko Stuebner <heiko@sntech.de>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 kernel test robot <lkp@intel.com>
X-Mailer: b4 0.13.0
X-GND-Sasl: luca.ceresoli@bootlin.com

This small series fixes a build warning reported by kernel test robot
<lkp@intel.com> and improves the Kconfig entry.

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
Changes in v2:
- Replaced v1 implementation with __maybe_unused
- Added patch to depend on || COMPILE_TEST
- Link to v1: https://lore.kernel.org/r/20240329-rk3308-audio-codec-fix-warning-v1-1-b9d177fcd6c9@bootlin.com

---
Luca Ceresoli (2):
      ASoC: codecs: rk3308: fix "defined but not used" warning on !OF
      ASoC: codecs: rk3308: depend on ARM64 || COMPILE_TEST

 sound/soc/codecs/Kconfig        | 1 +
 sound/soc/codecs/rk3308_codec.c | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)
---
base-commit: 4ed0915f5bc4bcc81bca783a5b984f3d81e9764e
change-id: 20240329-rk3308-audio-codec-fix-warning-51bb572ebd96

Best regards,
-- 
Luca Ceresoli <luca.ceresoli@bootlin.com>


