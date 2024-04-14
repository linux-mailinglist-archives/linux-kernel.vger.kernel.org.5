Return-Path: <linux-kernel+bounces-144341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 181A88A44C1
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 20:51:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4925F1C21176
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 18:51:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9837137744;
	Sun, 14 Apr 2024 18:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="niYESIi6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15ED6136E1A;
	Sun, 14 Apr 2024 18:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713120538; cv=none; b=Q2+5jmRXpPHWwEJtCP8Ouj4qUUM5Ue8iVd04aoBQnd3ohgugmGUh2L9rEuctxHj4o73RietGV4zz6BFVx5zZvTb/q8IGcMt9DIFxjAqCjwZ9AcajK9lvTmz3ts20Jn+6AHQBboOBk0cC+xZNBzMKNIYFVq9D26RrURd9qJ6BVp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713120538; c=relaxed/simple;
	bh=qGfyTvGICPhMHxBZDbcLXXOoOsd+zSSiD1gfuAYE4MY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SrsvNMpg7n2fzW0eYyPjVxCY8oBwwREHT0WMBDviEFddqd30CwkiVYFOUalrD3KF09lVVnHTMnDYtS3SpW6Oxqez3jZK72668HBkayBYWo1BCNQN+20jicyEgMyjMmewCRiWs4/6f+I4Ivzbfqy0fU5yU8jDmjSE2ASaVkKwqYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=niYESIi6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C43DC072AA;
	Sun, 14 Apr 2024 18:48:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713120537;
	bh=qGfyTvGICPhMHxBZDbcLXXOoOsd+zSSiD1gfuAYE4MY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=niYESIi6e8GXhnX852cWMpeysLlS/4DIaVyqjzXERRtKYeECb5Jr7QwK6QUkQEQDT
	 wWfQunAovcDWR9dPN47cygQXdTSOZDd/XEygWnA/gdVJuyItiJKlTAekWnGASf9bRP
	 w5TpFqQDfgzHZYocMMcSaUi7Rw5DCOg2lYNzUSuvMsx19ZhoaOMJyQoqx+kEd+icqE
	 VjmR4JVp3OvBvtpPSB9XzwM4ZFtKblGCLSAbLTJPoWayQEeBPhs6PPzSUm4Js3xoaD
	 YuYmamA+vBEz0KfK36nN8sq4ITlp4Gmf2c+W6ihX/r9H8f37fIPpMmrH7bSwikhAWF
	 EwNZxVZ0F+ZuQ==
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Sun, 14 Apr 2024 20:47:34 +0200
Subject: [PATCH 09/14] ASoC: SOF: imx8m: Constify snd_sof_dsp_ops
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240414-n-const-ops-var-v1-9-8f53ee5d981c@kernel.org>
References: <20240414-n-const-ops-var-v1-0-8f53ee5d981c@kernel.org>
In-Reply-To: <20240414-n-const-ops-var-v1-0-8f53ee5d981c@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=757; i=krzk@kernel.org;
 h=from:subject:message-id; bh=qGfyTvGICPhMHxBZDbcLXXOoOsd+zSSiD1gfuAYE4MY=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmHCTMy020XGfYFIH5zZasAx/0Yq+7kXrHiZidJ
 bs+CZTSp4CJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZhwkzAAKCRDBN2bmhouD
 12/CD/4udUivIHc2GoSjjDdUwGppx+SlrIvBVJeW68W/cXwaOCyKth5jrChyQjpnz6AEj1GAzux
 E+3yBwwZ/tFyTqlcdC/21mYVXHynylQi2YuTXpvuW917Kjqife+XqkWYFWQzqfVq+qAA7n6VYDw
 ypPDRVorC84imXoLpKXK98BDfETTD0w9MuQqSoeQXAydIKI93iZbGmvnT0n5LM7v4ZRja5xG4Wg
 K9F4C4cl+FMVyXUeWpcOK7z7HDKKvZitNkJMPTKGCpSG9toJPBeYhbLde79BwlUU9Atc1CTE63s
 P4h15Vg6BpleEwTxVcn0q66n/f9bylIxMUHb4DA4swKcIFkWEJef0/cGrG2EOlyElSwJEELU68e
 kBsPFg343+A2YgffVnGac5++GYyYqFWtCEdl12nBA4PdhJ7HYdI+6gE7xnZzU51tvxZRbZ1mfSs
 yJcbNWEMOuE0EnA8WOD9pFx0kMshvQ/mcYA6rK5QefP/exy4110uWJxmAs08ySg73umrzc644Ux
 oDeFNOvWXhQaW7NGT/bUeU+hT9/NBglZX1WX8q6PwA0E8DsCCNToy4xtzqqkDei59Vd0Vy8DoMR
 TIS5IoNtOwDMt6OjzIfuJsewT8KRjl3TPKPSw126k5ODK9XvY7DEsUv4eKhjbq85M5qjqFOhyaD
 OnGoBk2dIFXz9yA==
X-Developer-Key: i=krzk@kernel.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

'struct snd_sof_dsp_ops' is not modified by core code, so it can be made
const for increased code safety.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 sound/soc/sof/imx/imx8m.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sof/imx/imx8m.c b/sound/soc/sof/imx/imx8m.c
index 3e0b88002b4f..4ed415f04345 100644
--- a/sound/soc/sof/imx/imx8m.c
+++ b/sound/soc/sof/imx/imx8m.c
@@ -411,7 +411,7 @@ static int imx8m_dsp_suspend(struct snd_sof_dev *sdev, unsigned int target_state
 }
 
 /* i.MX8 ops */
-static struct snd_sof_dsp_ops sof_imx8m_ops = {
+static const struct snd_sof_dsp_ops sof_imx8m_ops = {
 	/* probe and remove */
 	.probe		= imx8m_probe,
 	.remove		= imx8m_remove,

-- 
2.34.1


