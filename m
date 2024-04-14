Return-Path: <linux-kernel+bounces-144338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E47E8A44BE
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 20:50:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18A9B28225F
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 18:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 957CE1369A9;
	Sun, 14 Apr 2024 18:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tz9d0Fxd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D68BB2E3E0;
	Sun, 14 Apr 2024 18:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713120514; cv=none; b=U7HHQAmL7xQ4Hl/ogfdIROwZ1lxUlREbWuNPu5xDgNB/xD4uKkLehaLHMjrTPxsKX4vl59fd9up0cLcS6l5XZr/SPE5oTP6tRHR1AYXxWRdTdQZN9vVyIqrVcYLm4PLf4UGLbiTiIa+wPKIThc7j0sccBaO9STuaIZld/CufQWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713120514; c=relaxed/simple;
	bh=ODYRn2RdENpaKnJgZLjiwAca8icK8fqKMWlq39yx68A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TA2WnhR2zD/fAj9XUafnXXptYentlZFi7X2wZHMzxpBoo+iugEZLg3CRj5IQ/OpoH1hqwi40i0ObFydd50Toqk0HzJkubsaiAqwPz1BQaGttn389QZA+BUrH/pOQYGiQTlv2eLEdi26AtFA81MD6x9eli9JZucd9kIosxxGWOOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tz9d0Fxd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ADCEC3277B;
	Sun, 14 Apr 2024 18:48:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713120514;
	bh=ODYRn2RdENpaKnJgZLjiwAca8icK8fqKMWlq39yx68A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Tz9d0Fxdi92/WqzdH6POx08Z2+ZuVV0P/a4thX8q0xcpqwmwUy9JSc9OJ1pIU3Wfn
	 L7VrBEsRlrtK6TogPf0I/svnoS0PWVk+kTTQDgHpYTbeS0VhG8DJbx70DGcgzg8/Ki
	 CdYIHAne6z11iw6DQfGZxppZj9KUtowPIDLzq/it5ItXpe5lCACO5kgMa15ZNre6YF
	 Q30Mzi+ewHlEo/18uC+QdZqlvw//8+8thbyeb7x2QYuctLvo3pjZSzRx2d3pVhVD4L
	 gOzki8UrzMXTytlW9XePTuWP/9gYa0ZWHJU3sS23eRL70Lxg35CG1v9hEOiiOVkOgN
	 mm/8rlEOvBJUQ==
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Sun, 14 Apr 2024 20:47:31 +0200
Subject: [PATCH 06/14] ASoC: SOF: intel: hda: Constify snd_sof_dsp_ops
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240414-n-const-ops-var-v1-6-8f53ee5d981c@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1327; i=krzk@kernel.org;
 h=from:subject:message-id; bh=ODYRn2RdENpaKnJgZLjiwAca8icK8fqKMWlq39yx68A=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmHCTJea+7a6S6/0ABA+BT4aNIYMDEgQLCwYl0y
 NVOjuIpHQ6JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZhwkyQAKCRDBN2bmhouD
 1w0/D/4kT2T/U2kjeb533yzTZJrtn1IQZrnfh2AARz5j1/KEXUbKhX3g23zIiE7v2uMAApP0XbG
 oMf4MZfc7/qxfxOTNF5eRJl164ezv/XfeOt+o+oh/CMEUg45jLOvgQZVgCwGEWg69WdPhq1Wllw
 9mg+myz1Dhdw8SHJdmcuyWktFnliFSaLuoJm/gNoYJQ5ZBLwVDJN6KR5Daph/qb5p9BN071uE0n
 UNU5jfiPip/X9yMcmvbZRI/rxnKWlmvqSDq3GWkqT9eAdXFBZXwkYv73fkfaB63z1iOwIaIXSoI
 OZ/ekB+e9EG09ga9KKimHX/jEhzQk4kR7ypK8F0vLr2YrEaGQ95hpmBzsYSu70Px3ggKj14nFFv
 Dwf54mgvRiChYGnzxVa6WuYnVrvN6s/WmTEjmiMRm78dqD1JtSH3/O644bol12PTP39YNzZwzzR
 RbzWz8sy/n1WTeRCJJBK7K6RXbnbrvLYTg2sRTe+amJEhLjpL798Io6O69aZhO8GI2YF3leuVsl
 P2VTiXGQw4q14WhUuUkHitxtN2PKgC0QA1cYreDg6F/bWC/byVhFjNox1ziPoyoHoF8TqbIrmJe
 9Fd/PjxONIj5GvJXa6GyeunyqfvJRaUCHlYQq8LnP3kHTrkHIQ+wLuwRCzNQ0J8PMhac1oe4iZ7
 xj4+dUU5YGoX8Ug==
X-Developer-Key: i=krzk@kernel.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

'struct snd_sof_dsp_ops' is not modified by core code, so it can be made
const for increased code safety.

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
2.34.1


