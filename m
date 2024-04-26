Return-Path: <linux-kernel+bounces-159752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 386A68B3393
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 11:07:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69BCE1C2176A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 09:07:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB04A13E892;
	Fri, 26 Apr 2024 09:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KUvDf75B"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E42F713E41D;
	Fri, 26 Apr 2024 09:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714122383; cv=none; b=YCzGymlptbayJi/2R0/kaE9+N5jAb0htnzIbH7piSlj0hGL5ryvSEq/MpaYFPye2+3M4vXnZbirGAaEwsHYs6tVwk0y8Mh7qKchKsULksXrDWsyIkh9btnnXfK0IM04BuLn2BoUt94jYICPkcU0MgumwHTZOSZQwv0iqdTIXN80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714122383; c=relaxed/simple;
	bh=isNUL/vRKVlQ1eZTCoLyvgGCM7+AWqSNXzyNZ1JAgVQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HgBx7ABaWx6NLrkDQtC40pvcUIlTWDd8Fn+Tp6AZtW9f5ll94ptmeF3jHBW/hIDPtKUY/nYAXPAzLjAuTnRk04Mr2Dc8j63ibi4jrXO5SmcSJ1gEz2k/R9HfmtiJFCvPBD93U+Akugk/DHj7xgQSWpoxetsdQ5va7IZfjjryclI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KUvDf75B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE265C32782;
	Fri, 26 Apr 2024 09:06:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714122382;
	bh=isNUL/vRKVlQ1eZTCoLyvgGCM7+AWqSNXzyNZ1JAgVQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=KUvDf75BZd3tzuPpW5Tnxnbr44RIL2v/DmbrRLu3PdZ8Dxh6zJk82m0r8J07rcV1w
	 XMckxQdjRKz9sJD/+4xEfnU3qNTlYgRzSckVD8RADQlRU1NuLKzsMvP945fkqmpDDI
	 WKb1Wxo18VLKdY/FJpKxDS8oPA8xD19tiewfpodTVY7yIFlQ4VOfMrfaeuKZ/LuZsU
	 oRpvp2ijuWAXAErToNXR+dw5c2Q8nDReEAYQzYw/zPO0EnYw3iQXThMSOVH7OPCfCT
	 xjFwo8GfkPAGLbSGRIS8PU0HAQOslH8CZiOKLYwSNypHdu0pUyZvZ/xe50XXgBnFT0
	 XtWyGQllwQryQ==
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Fri, 26 Apr 2024 11:03:59 +0200
Subject: [PATCH v2 12/14] ASoC: SOF: intel: byt: Constify snd_sof_dsp_ops
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240426-n-const-ops-var-v2-12-e553fe67ae82@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1100; i=krzk@kernel.org;
 h=from:subject:message-id; bh=isNUL/vRKVlQ1eZTCoLyvgGCM7+AWqSNXzyNZ1JAgVQ=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmK24p3G6kz61lcHobtIaDgPNnSnNLElP6yNqv4
 d5mde+9U/iJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZituKQAKCRDBN2bmhouD
 1xilD/9WzCd04U01VkyAG2Gv0122YqqRyfAcH+BtznzcxDG149CZ+DBfGS6C5ura8681PUqlSXq
 8WsrnaqcLskSYo/T52AAffi6x0T/2TFeVNMDz0FDYx2urhKEijhtVwJ8zwYwevs1/vsAUr3iwiu
 GTWXKSfU9FyLIR5SJtNAp2AiIgj+fJK8auNJPwfy/4Kc4ReLwDQqTQO0TUhTUIX875xl+sGGoIN
 tLq/xMrwdR1JzW7UN/LHl+P5SR2Snvvj9PuVNgNSTx9UG3povBp4fXEQfoWXaRhuCG7c5n5Cqso
 GA0dX3MKXIRXiPe+KPyxPVYcz6ramwBw15pF7q2vIsECMxTm2zi34I6VIh4PEf0px8vIUlcJqn+
 p7mPCR/+vrNZ0tXmzs3q2mveWAggxdgRK2khR4Asw+GGU8GJHvluDgdZLoHYm957PQsZIQu1/4a
 sSLrrMWW5yTytspZIKLdQsqV/A8I8dO9y+t5u+N/xwq89PDoxCzYeAzNt4t/szZDcFkFNQSFRAs
 Z20/8CDn4m+HCxTgMplFXdrdoytzDih3WVjIeV7ptAFvAZ/Oe6c/E0op3eFNFhEE+0rGouOcXbh
 G2AtqjqudqvPwwKBrdVesyTsNlEbEnBGazJUwhdatF1AGNt+XOsq3vq7UC2WREwKIRqvKeGcNBc
 j9TIfpJRzBRs1eQ==
X-Developer-Key: i=krzk@kernel.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

'struct snd_sof_dsp_ops' is not modified by core code, so it can be made
const for increased code safety.

Tested-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 sound/soc/sof/intel/byt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sof/intel/byt.c b/sound/soc/sof/intel/byt.c
index 373527b206d7..14a065999a89 100644
--- a/sound/soc/sof/intel/byt.c
+++ b/sound/soc/sof/intel/byt.c
@@ -214,7 +214,7 @@ static int byt_acpi_probe(struct snd_sof_dev *sdev)
 }
 
 /* baytrail ops */
-static struct snd_sof_dsp_ops sof_byt_ops = {
+static const struct snd_sof_dsp_ops sof_byt_ops = {
 	/* device init */
 	.probe		= byt_acpi_probe,
 	.remove		= byt_remove,
@@ -289,7 +289,7 @@ static const struct sof_intel_dsp_desc byt_chip_info = {
 };
 
 /* cherrytrail and braswell ops */
-static struct snd_sof_dsp_ops sof_cht_ops = {
+static const struct snd_sof_dsp_ops sof_cht_ops = {
 	/* device init */
 	.probe		= byt_acpi_probe,
 	.remove		= byt_remove,

-- 
2.43.0


