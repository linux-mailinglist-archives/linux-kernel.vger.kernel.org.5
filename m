Return-Path: <linux-kernel+bounces-159741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D27CA8B3388
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 11:05:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 893C91F2271E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 09:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D292013E02A;
	Fri, 26 Apr 2024 09:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ete9qowV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20CB913D528;
	Fri, 26 Apr 2024 09:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714122302; cv=none; b=mCeo9hwuIM1dykgn/RY28Qxkythzw5ZXu9Z3+nRSFdbM23VJnEIoafDSlCVRjr3wEs2N4Gz4rUDRnGZM8/g4biqp5HCB7NyJ3gRxN0rL6oK5nxCnRh6M2fw/hh5BD68xhF+B1YSICdqX+cRIkhXDQhZuzhfSauN/RvUsBAXKZJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714122302; c=relaxed/simple;
	bh=Fv58eJJ9g0/7T+qs81YevZa2aGi0MuehR4NJTOflK2I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sxB8ogbTgeCKBpkgzQVC+yJui6C/QYYin7ixJxfBNI6fHsFXU67rdZvOy0T+k/Ql8ZzsJ/qs30TrlZuIkPY+1clou/sSU87tx6zSR2JmEPyT8A4YGsgGHIm6de/RDYXWraeIZcWhdkH5+Qiq0rhZMiGiKzncpkN3QxW0nrMeXNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ete9qowV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6406C113CD;
	Fri, 26 Apr 2024 09:04:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714122301;
	bh=Fv58eJJ9g0/7T+qs81YevZa2aGi0MuehR4NJTOflK2I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Ete9qowVjLixlXuoXYCBwwgIs1Pydbar8cLML12g4KwYYDW8/erLjq1brHFfBH+Mq
	 Hdm/Cvqsd/Z7RD44RtDFjbgtn4cgkB3mqBR160aXwVXGcQmARQvoQoWs62ViU6uK+7
	 EBgFZTMYdzkw/bS+HNlSL7TcIOAbfKjo0WEvx5SM6ZbmGSy+nfTwC60R37mjIPyWUC
	 a5lz7q5Y9DTrYhpVChTVoL6FZ0nZ3Ep7mff3Invs53CrjFpLtFLdAqpxtgEWp22/Tj
	 G5ywq6gomNAQ342vglnAh6AQuPkq9ibbuO0WaKMgVDYaySWGhR9Jxx/JI2DYexT4Yb
	 UDOTHi02QYBag==
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Fri, 26 Apr 2024 11:03:48 +0200
Subject: [PATCH v2 01/14] ASoC: SOF: debug: Constify local snd_sof_dsp_ops
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240426-n-const-ops-var-v2-1-e553fe67ae82@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=856; i=krzk@kernel.org;
 h=from:subject:message-id; bh=Fv58eJJ9g0/7T+qs81YevZa2aGi0MuehR4NJTOflK2I=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmK24g8FMqyk5CcreafnICwJURXx3G/Vt1uYxPX
 DIZzjLVAGKJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZituIAAKCRDBN2bmhouD
 11YxD/0SAUyEFYV4mPU67fioBUbLoun6ybnfuwvrL1B88/tA0168kO8waj4x7soSQfkNXdBG9Tk
 Rz1HZ73v8oIXaJOwtxrDslVyaxBLU5HopSjZkDE7J0f+pk/sNor6WxfB6yD3ouvvSCWxxh3bhzP
 SJ4pEN192s6aSYT4cBsHRm8TnLYHCrMKa01css81vWFKvMEuKwaDic92/Ju6tbJZXY0QkNlrQM8
 Ol9oQzV7QDwSfcqNuwUx5F6ckgqyJSFMrmqQSODaoeIlwA+QPi+gYHm++/OnSBlWgQc9OuzoVOy
 xYPmVLu4Fze0JSZzF/T/2MlJfTZNrCzdk3K0yQjFBPfC3cppqrwWWsRiOzPhFawFvJg9nopMe9Y
 4euxMToOe9ngBL28cGIKWjTlGyE9z9s2GEaIJ76kEe4wW9/+KNUYDjdz+tozLb5dzM8rF49E8p9
 cH5vX9XCIe0TnAc0MUaknLm66tpqoObLiKVMWWM9uI8+Epx9UKI9lY5NPi/4xZzHbLZ7SFnHzn4
 ZSn4fXwQj0KRqP0UHtB3bitfOV5kAXbrBD4nxiycT3lddegIk5lWD4Hkh4l2bD6m3LxEZVs9DGi
 DtEeec6BbFC4q8Md9j1x+8xSrnvIx4AyT/FlkZ+vzseJWLkR1oNvCoU+ddPrJJHmUmbH+UybwpW
 HnrTY6/kxdzSxbQ==
X-Developer-Key: i=krzk@kernel.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Constify the pointer to 'struct snd_sof_dsp_ops' to annotate that
functioon does not modify pointed data.

Tested-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 sound/soc/sof/debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sof/debug.c b/sound/soc/sof/debug.c
index cf282c8b18af..884d85770426 100644
--- a/sound/soc/sof/debug.c
+++ b/sound/soc/sof/debug.c
@@ -311,8 +311,8 @@ EXPORT_SYMBOL_GPL(snd_sof_dbg_memory_info_init);
 
 int snd_sof_dbg_init(struct snd_sof_dev *sdev)
 {
+	const struct snd_sof_dsp_ops *ops = sof_ops(sdev);
 	struct snd_sof_pdata *plat_data = sdev->pdata;
-	struct snd_sof_dsp_ops *ops = sof_ops(sdev);
 	const struct snd_sof_debugfs_map *map;
 	struct dentry *fw_profile;
 	int i;

-- 
2.43.0


