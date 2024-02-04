Return-Path: <linux-kernel+bounces-51541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21D4B848C57
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 10:02:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 535241C21570
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 09:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A0C814AA5;
	Sun,  4 Feb 2024 09:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d4fBkaNl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCA2E16423;
	Sun,  4 Feb 2024 09:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707037358; cv=none; b=iBGbEKwhxzfoNB9ElC+F7FpT+/raovmVpYa98pQmZLMWS6Z4OtF1IDYow0y+ryvjizz1k4nWMLzi6IV7vbBHTj3lMDu+ZD7ui6HxnFZoqvJS5KY4AxMarwTDrInl61C1nxwkiYkBkisdl1amYStJqHmijZIU0H/e73FwKE6jKKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707037358; c=relaxed/simple;
	bh=5ptrkBTCp9PnqC2wnOM4MZCSA/1n9Rx4gG6x/LT81BM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UK+vFTegNhGXpheQ9A9T46U0cLvLn8TNsfC/nNFZCnAYpywBCtPwtxIOP39uev1Hl3rY5uznqdctcAV3Mneq3e+usnpIhR9lVJMWJ0ztvJoxHFXj5FlUALtaQ08fbc4LUGsx0T8GGH8qB1u5/Zo9smYXx0JLRV+bvBHBhylMH34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d4fBkaNl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 889FEC433C7;
	Sun,  4 Feb 2024 09:02:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707037358;
	bh=5ptrkBTCp9PnqC2wnOM4MZCSA/1n9Rx4gG6x/LT81BM=;
	h=From:To:Cc:Subject:Date:From;
	b=d4fBkaNlmIohjQOfFjusKff/PEusCcpJGH4Pd9FZFLEzEFGr3MKukgVrB6eQxQw5n
	 pvm+v6xWWNV0ApHHp+p7URCckBbDffgZ86nkgmkYrRnUHTMgBY0y6hnxdJrYqbz6bL
	 N9hp2dlf+9gucV3l6d+361qg2AsFpIUlzExJLeOKPbpiEL5w1Y0OThGn4Gk29zgsvA
	 FYVvVtUllMhPMLe9U9nii0S0saPFy5Ztx3d/Zcdp4G/8vQbvGG8IPq9ibBZmqiwU2J
	 Lr0T169FSQ9rEtybalEfImD5Ku3gZKvTODv3IuYUxOud8thWaZIgz1ZKo/pvjTN6jd
	 ws52zUppuKVcg==
From: Masahiro Yamada <masahiroy@kernel.org>
To: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org,
	Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	linux-arm-kernel@lists.infradead.org,
	Mark Brown <broonie@kernel.org>
Cc: Masahiro Yamada <masahiroy@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] sound: remove duplicated CONFIG_SND_PXA2XX_AC97 entry
Date: Sun,  4 Feb 2024 18:02:23 +0900
Message-Id: <20240204090223.37621-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

'config SND_PXA2XX_AC97' is already present in sound/arm/Kconfig with
a prompt.

Commit 734c2d4bb7cf ("[ALSA] ASoC pxa2xx build support") redundantly
added the second one to sound/soc/pxa/Kconfig.

Remove it.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 sound/soc/pxa/Kconfig | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/sound/soc/pxa/Kconfig b/sound/soc/pxa/Kconfig
index f03c74809324..e05d6ce4c8fa 100644
--- a/sound/soc/pxa/Kconfig
+++ b/sound/soc/pxa/Kconfig
@@ -8,9 +8,6 @@ config SND_PXA2XX_SOC
 	  the PXA2xx AC97, I2S or SSP interface. You will also need
 	  to select the audio interfaces to support below.
 
-config SND_PXA2XX_AC97
-	tristate
-
 config SND_PXA2XX_SOC_AC97
 	tristate "SoC AC97 support for PXA2xx"
 	depends on SND_PXA2XX_SOC
-- 
2.40.1


