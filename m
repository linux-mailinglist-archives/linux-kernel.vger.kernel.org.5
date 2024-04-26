Return-Path: <linux-kernel+bounces-159744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 384B68B338B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 11:06:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A3EB1C21AD5
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 09:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B30513E419;
	Fri, 26 Apr 2024 09:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lYpGcZwb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D2613C9A0;
	Fri, 26 Apr 2024 09:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714122327; cv=none; b=P6/eZ04AnaVrmBuqaD7ODXZZybS+MnC37J97A0hINBD47lz7YvNqOiHZQfovOtFJJ6PtFMda6CMWr4GOfuY9WMYND2WwPXYmy308qZOkZffFGOw4Uq36w7XfomNQYwoeAbILQ1hl3griecS+cfnwGkMsRlQSoYCLWYXX5UmkijI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714122327; c=relaxed/simple;
	bh=VnIAfmPx25oKsEp0zbK0tnxbnzdBHAOYcdVhtoHT55M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ubbTkE5iBBWpcz4xbGWCTn1hhGZ6vz6NXVcjKfZJil1HF6FPyWYBnL6MvacK1DHjE5EhXUYuxSvyt+jj7576UevZJgkN8RMJlezNuWGYj+shZps7QJMBOZvs2B9leCJozS8PFL+Zvs0P75wv9oxAd+86lspGPXd0xX0zGsSn2GQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lYpGcZwb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F82AC2BD11;
	Fri, 26 Apr 2024 09:05:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714122327;
	bh=VnIAfmPx25oKsEp0zbK0tnxbnzdBHAOYcdVhtoHT55M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=lYpGcZwbD++CwmC8RWqhElXVo952m5WjDHqKUqH3kLu2tpnsh/j90pgBBj3pd02pY
	 eCyM7knZlW4cjURhR5UmE2fDAgQ1K8T09MqwUdk1+fR6lqehvBJK7OqE+h/c2lf2bS
	 ISofovYCA2bDcFv0CPVCfNwgUWFSY/W53iH82l9eMxEeaw7QqAlyS9Y0Ri3WXYY8yN
	 EBoWE0XMHycjXYaHVYyPv5Yi72aoojICxP1pRBRqRas5ld7+D5XCwwQgqhCPmxUFh1
	 3KSQEOLxlofSYbE38KDnEqvqu1Vvq+wX7anoJ5El0iReGSqy7FI6Z22H6+j1H/n4NA
	 LTatyohdFI3uw==
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Fri, 26 Apr 2024 11:03:51 +0200
Subject: [PATCH v2 04/14] ASoC: SOF: Constify stored pointer to
 snd_sof_dsp_ops
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240426-n-const-ops-var-v2-4-e553fe67ae82@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=937; i=krzk@kernel.org;
 h=from:subject:message-id; bh=VnIAfmPx25oKsEp0zbK0tnxbnzdBHAOYcdVhtoHT55M=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmK24i5ldgk6ROfX3AbXjO+oI6liBQKOT8EK72p
 kq6RFuYidqJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZituIgAKCRDBN2bmhouD
 14UsD/0XY1oHKwddmpwGMp3fZbl8ZR4Yf1LvsKEzZAEwVg8Dnef8Ow3zrhLy2YP3NjWoFTKLfEF
 1eppLLdVNgIJphOhDh2zBCrF869W2O9Zd9OZQ3IIxZP91wgv6XKwNsaDCtYNavh9+/dLrDasQPP
 vIvah0BERFKIqXDqIo5g7pPNc4tszzsMA5TJhOKj7+yb5pCj2Jxcl0U+RuZJ8DTwKg5stb2WJOY
 zxTXX6Mj/NQagvsACTBILxPBPQNI2QUHvsk1fY7NCB0aMbpCiySZ6M1q/wkF8StCruiU1h3SbwQ
 DX5AGhQAsK7SIjzkXpkYOw6xqhM3RdC10DYUYk9Fg1+5xXrzVdechRI8GGpYcQ6zemKw6dmSqDX
 kmY9p5Zp7u+kj4lQGy9ZhDAlKeAQ2QDRcopZZzGVkFCix3fxteHQh1DCaklr/D8Npbtxv3nxbJh
 VhsNL0haC44Mdk4BAUwLioHcHEs5JOlC8A0meDqjsrYNrwep/N4Xmkxns91MRcVYxtFQzf0N7Nq
 vITemvqkZ9sJhS3nssaIVR+3j38/AurpPzl4fY5bKN+QN0yAvHDfOfkR2Q7ofNCFgEX9o6ULIIN
 lieNArQ4cwd2etxJFmftDi3/2rkkYSmUVGXcypwxEQpV8Mi6dtAFtCZ8clIRvZsyzPzJBqNX+E7
 iA/exbAmcYlKYxg==
X-Developer-Key: i=krzk@kernel.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

The core code does not modify the 'struct snd_sof_dsp_ops', stored in
'struct sof_dev_desc'.  Make the pointer to 'struct snd_sof_dsp_ops'
const to annotate this, make code a bit safer and allow individual
drivers to also define this structure as const.

Tested-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 include/sound/sof.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/sound/sof.h b/include/sound/sof.h
index 05213bb515a3..780c1a755917 100644
--- a/include/sound/sof.h
+++ b/include/sound/sof.h
@@ -166,7 +166,7 @@ struct sof_dev_desc {
 	/* default firmware name */
 	const char *default_fw_filename[SOF_IPC_TYPE_COUNT];
 
-	struct snd_sof_dsp_ops *ops;
+	const struct snd_sof_dsp_ops *ops;
 	int (*ops_init)(struct snd_sof_dev *sdev);
 	void (*ops_free)(struct snd_sof_dev *sdev);
 };

-- 
2.43.0


