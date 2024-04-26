Return-Path: <linux-kernel+bounces-159746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C61238B338D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 11:06:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02FFF1C2107B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 09:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D23E13DBAD;
	Fri, 26 Apr 2024 09:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XJuPY7xn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD1FB13D299;
	Fri, 26 Apr 2024 09:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714122342; cv=none; b=jpbbIhTC+3765Ph4jv+EG+K2giQBE3aWOUSTAEDIuFDFq2yqOkkdCev1Ub9d8MdRejqNheGoidZZGk32QbF12Nbn/EUxJxHWcmyBPVfYicVQVFqec85+HKruaQ3esufRyuTpK8oTMoG5jpioVZPwXMSpoPynj05IupG2QXtx1MU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714122342; c=relaxed/simple;
	bh=uSl9lHVhMhzqO5BXxIg9ZVHN/ovpA4vPraemkZEX5Es=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SK9z5VLZrZqRwQNNeoX2uv8RpdIEk1ho4zhVWJrJ01bSqSGNqmn0ZjNTPoJgXIFR6yD4yPTVQUsCNhx2RffoOwKPr3kK0B0pbxpmKIVlgHCpyDp7gZQGgXxrYASgXZ/uaZ9k4g5K6Zus+8xfgNpBF77D2YdShHmQKE5I8EW1HYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XJuPY7xn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2480EC2BD10;
	Fri, 26 Apr 2024 09:05:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714122342;
	bh=uSl9lHVhMhzqO5BXxIg9ZVHN/ovpA4vPraemkZEX5Es=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=XJuPY7xnJUG2dzuMuGAdf4kyeZY7M7fYQjmDTKiPN/ajF3y3nszsFvN+tkNNZ8iAC
	 0GoYRlbA8WaRguZ79eeYw/qOj1e2Pl2gaSaGVT2oX8GBHsj5veYRklqp3amBhwQMkt
	 AJwGXp1PlCBqLWBcWdu697dfCaGRG7EZfUcnwibVpB12LOxrCuUWAyRAGLFurnxLZq
	 fOO7s2vOFVb9qmM8P23pCIv6q7BNFDbdvf2xaZqP4/QsDZCxroqJ6o5iTorKYUtgn8
	 IAz8DW1EyjNTvdisltC+7e42xsMixFB4PSkhsUwNZGR74D4kOCJQWEJEdqsJMph0jT
	 zaUpu9rMxE/ng==
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Fri, 26 Apr 2024 11:03:53 +0200
Subject: [PATCH v2 06/14] ASoC: SOF: intel: hda: Constify snd_sof_dsp_ops
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240426-n-const-ops-var-v2-6-e553fe67ae82@kernel.org>
References: <20240426-n-const-ops-var-v2-0-e553fe67ae82@kernel.org>
In-Reply-To: <20240426-n-const-ops-var-v2-0-e553fe67ae82@kernel.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, 
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>, 
 Bard Liao <yung-chuan.liao@linux.intel.com>, 
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, 
 Daniel Baluta <daniel.baluta@nxp.com>, 
 Kai Vehmanen <kai.vehmanen@linux.intel.com>, 
 Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: sound-open-firmware@alsa-project.org, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 Krzysztof Kozlowski <krzk@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1399; i=krzk@kernel.org;
 h=from:subject:message-id; bh=uSl9lHVhMhzqO5BXxIg9ZVHN/ovpA4vPraemkZEX5Es=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmK24kIwXwjcILq4oTHU0GmodP7uXY1EGskkxrG
 kPPOLG9cu6JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZituJAAKCRDBN2bmhouD
 1/vID/94le4u7Mr/ZXMzNfG1RttG6ySshfgZ+i+gW5oeYZMWtcjv4vBVFDDh6e6C7bgwNPGxnJi
 en52qMwbnDb1d3xMNM0PAX/enkLznKz7jioV5V9QrmyOq0gZghU0lHvIPj7n38wFBnLH+T0YIbu
 PhSFiHHUSwmh1rK3+FRyxH2jNRrlK21TRKLDrsDQg2TmQHUHm92kZWZ4kKSscJW1vKRok4+8QBN
 oymMJyFTaLdgJ7QrMnaorTkJSd30SaTKw/Wb2g8Vh7+1bLxtpL2KT/ZsC8MkMBH1C0Ur0J72Hxy
 cqAkWq39UMY1DzcEKBkZEro6DtTlIGu/NTq4LPwVny+uIyic+1s8pXijWTDv+Gkt3IqduNJtgN2
 sgO9DfXUNig+e2OgtmiBR9Rkc1zZKJzuxrbKpHW446h2Ju6TqoqQpdqEfs5D0Mn+CU74qdbXyQQ
 yO9zWhU89QHztLVbD8I3BvzqHccHdNNxztyWFBScd2xJCMsDtOyIdWj2ZJ7OYgHXiLjcsYyQejs
 x9CBWz4fk3R7cCWYV0Fjz+IFhXXmbSSSTjBqVIEEu/0Cjy5UZhWfTabJvG50EyrwUoynQqVyuU9
 it2S3jqr84dVJ/of1XXbvrzdfPDxmWeYojacs3pRoidiPS9D+EPFAycuRPmWKmrbqj/DNf2zW8X
 vxnu7veStIRiIJg==
X-Developer-Key: i=krzk@kernel.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

'struct snd_sof_dsp_ops' is not modified by core code, so it can be made
const for increased code safety.

Tested-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 sound/soc/sof/intel/hda-common-ops.c | 2 +-
 sound/soc/sof/intel/hda.h            | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sof/intel/hda-common-ops.c b/sound/soc/sof/intel/hda-common-ops.c
index d71bb66b9991..466769c68da5 100644
--- a/sound/soc/sof/intel/hda-common-ops.c
+++ b/sound/soc/sof/intel/hda-common-ops.c
@@ -14,7 +14,7 @@
 #include "hda.h"
 #include "../sof-audio.h"
 
-struct snd_sof_dsp_ops sof_hda_common_ops = {
+const struct snd_sof_dsp_ops sof_hda_common_ops = {
 	/* probe/remove/shutdown */
 	.probe_early	= hda_dsp_probe_early,
 	.probe		= hda_dsp_probe,
diff --git a/sound/soc/sof/intel/hda.h b/sound/soc/sof/intel/hda.h
index b59d1a572bce..7804c5b50c26 100644
--- a/sound/soc/sof/intel/hda.h
+++ b/sound/soc/sof/intel/hda.h
@@ -874,7 +874,7 @@ int hda_dsp_dais_suspend(struct snd_sof_dev *sdev);
 /*
  * Platform Specific HW abstraction Ops.
  */
-extern struct snd_sof_dsp_ops sof_hda_common_ops;
+extern const struct snd_sof_dsp_ops sof_hda_common_ops;
 
 extern struct snd_sof_dsp_ops sof_skl_ops;
 int sof_skl_ops_init(struct snd_sof_dev *sdev);

-- 
2.43.0


