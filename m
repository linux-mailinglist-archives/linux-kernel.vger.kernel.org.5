Return-Path: <linux-kernel+bounces-100036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96CFE879124
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 10:42:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4958D1F232DB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 09:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53DC378691;
	Tue, 12 Mar 2024 09:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="jc6uYaHG"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F7578274;
	Tue, 12 Mar 2024 09:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710236504; cv=none; b=DkFbcYNDPlVkjD1XCcA5IS0Z/jarFCKWsN9z1mSdLHjzyg9DrG7wt3162FC0L6D3WYMQkGHhi8zBn0VB5ae0L1T1sNSpNOKFELaHHPo++9JF+FzIsWRGnABSypNdDT/0mpev1KWkulx1H3iE7CVUoFx8obIfXitrqIx001aaiSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710236504; c=relaxed/simple;
	bh=Y20q2GHyYvn4IMCZter81h5YE8yYywNCvuN8kMhR93Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Dk8KdJJegKbdWqUC8yhYQzWOK+76ZTwYoxbO5hcI4XaT8u4UwWYiAumQepzhAYq3Fwk37a1q5MWF0LEtdFQUiNhFXfIgvQR/NfCM91NB1TivOKxQBG3QVidB0fql/YkWLTm4KO9jNdAgJYUeWBz1L6kGIu7kJUj876I8OZ3jmvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=jc6uYaHG; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [127.0.1.1] (91-154-34-181.elisa-laajakaista.fi [91.154.34.181])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 675CADFB;
	Tue, 12 Mar 2024 10:41:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1710236473;
	bh=Y20q2GHyYvn4IMCZter81h5YE8yYywNCvuN8kMhR93Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=jc6uYaHGU7u2yNC5dKa5YQ1XkiLwVNzQIDUYAuwtx6ntZIwjn65AFWOcj9mWGq5Kr
	 e97d1b4D2FYGHfNzTtlwlgGHo2WiBQM1LfzU4KUazirL1kUD6cJbGJWJlQr4ps6LSt
	 svkxt/SBF2G0DkqWfrNmq76IjZOpxs4df+hcS4n0=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Tue, 12 Mar 2024 11:41:02 +0200
Subject: [PATCH 1/4] ASoC: dmaengine_pcm: Allow passing component name via
 config
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240312-xilinx-dp-audio-v1-1-696c79facbb9@ideasonboard.com>
References: <20240312-xilinx-dp-audio-v1-0-696c79facbb9@ideasonboard.com>
In-Reply-To: <20240312-xilinx-dp-audio-v1-0-696c79facbb9@ideasonboard.com>
To: Lars-Peter Clausen <lars@metafoo.de>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Michal Simek <michal.simek@amd.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, Vishal Sagar <vishal.sagar@amd.com>, 
 Anatoliy Klymenko <anatoliy.klymenko@amd.com>, 
 =?utf-8?q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2760;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=Y20q2GHyYvn4IMCZter81h5YE8yYywNCvuN8kMhR93Y=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBl8CNKmHTvKOCOEEFwtj9jcZSpkgC6g5K4s/BuU
 3XtQVx35ZuJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCZfAjSgAKCRD6PaqMvJYe
 9fyiD/41i6r4AfXqSSPLB04IsYhdCuxvfRH3yFul6aSXRkSQEfUXAaskoggc5/Opc4cKTzBav7Z
 RszLw/BN2WmUWZqL2DSQQbIf6qAxFUXEFLsCi3MpyEIOU7cy42NbtI1ffxcwAYnsWxYGNzl30JO
 IlXhcIXjtMIlX4yVSgmDUDsbAHw7q93Ghh4paQ4ngzxWMRaqrTWhnAvfe7evIYJwlrD3MUqegvU
 ol4FV86A6d/939RKEk7VCKmr5dFeiPwfppbZmpGsRLf9GF95Q2NBlm6AxQ5gRU/Wih+cOvNy1Dc
 XbPWNEpLfBopB/rIkFW/bpOOoMa2H3Cf5yEYZeU5VnLt9tQWn9rtQY0uhOUhSx9jeQ5RWAX1C3/
 StQZZaZhgpx0F6SGofJYU50mtbiXNQIdq/WcAU+2fPzCqhRkB5NLkU97rKdepxzWINRjyCGfilC
 DngtbhAq1caIa088k5MidS+1/SIsPPWZvhquL9fFUiUtXQg2+PYabQ10kR3yrOpDoFRKOqAlcLP
 x+SW2FvjhM9FLJk65MVABDLh54XgpnSX2Tt3QdyRSLe/dXjOuxDX4nknZ3MMQZhrhE8Bvkp3ELB
 YWLz+KtotBhkEKy/JFIgnGrjgufGmk4QEtjDwq9bKOWQ4Sl8WdryiXkmcQj0T4doThInY3ZKUX7
 6FettnOo+TSUU+Q==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5

At the moment we cannot instantiate two dmaengine_pcms with the same
parent device, as the components will be named the same, leading to
conflicts.

Add 'name' field to the snd_dmaengine_pcm_config, and use that (if
defined) as the component name instead of deriving the component name
from the device.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 include/sound/dmaengine_pcm.h         | 2 ++
 sound/soc/soc-core.c                  | 8 +++++---
 sound/soc/soc-generic-dmaengine-pcm.c | 3 +++
 3 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/include/sound/dmaengine_pcm.h b/include/sound/dmaengine_pcm.h
index d70c55f17df7..c11aaf8079fb 100644
--- a/include/sound/dmaengine_pcm.h
+++ b/include/sound/dmaengine_pcm.h
@@ -118,6 +118,7 @@ int snd_dmaengine_pcm_refine_runtime_hwparams(
  *   which do not use devicetree.
  * @process: Callback used to apply processing on samples transferred from/to
  *   user space.
+ * @name: Component name. If null, dev_name will be used.
  * @compat_filter_fn: Will be used as the filter function when requesting a
  *  channel for platforms which do not use devicetree. The filter parameter
  *  will be the DAI's DMA data.
@@ -143,6 +144,7 @@ struct snd_dmaengine_pcm_config {
 	int (*process)(struct snd_pcm_substream *substream,
 		       int channel, unsigned long hwoff,
 		       unsigned long bytes);
+	const char *name;
 	dma_filter_fn compat_filter_fn;
 	struct device *dma_dev;
 	const char *chan_names[SNDRV_PCM_STREAM_LAST + 1];
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 516350533e73..772d67065611 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -2792,10 +2792,12 @@ int snd_soc_component_initialize(struct snd_soc_component *component,
 	INIT_LIST_HEAD(&component->list);
 	mutex_init(&component->io_mutex);
 
-	component->name = fmt_single_name(dev, &component->id);
 	if (!component->name) {
-		dev_err(dev, "ASoC: Failed to allocate name\n");
-		return -ENOMEM;
+		component->name = fmt_single_name(dev, &component->id);
+		if (!component->name) {
+			dev_err(dev, "ASoC: Failed to allocate name\n");
+			return -ENOMEM;
+		}
 	}
 
 	component->dev		= dev;
diff --git a/sound/soc/soc-generic-dmaengine-pcm.c b/sound/soc/soc-generic-dmaengine-pcm.c
index 092ca09f3631..83db1a83d8ba 100644
--- a/sound/soc/soc-generic-dmaengine-pcm.c
+++ b/sound/soc/soc-generic-dmaengine-pcm.c
@@ -441,6 +441,9 @@ int snd_dmaengine_pcm_register(struct device *dev,
 	pcm->config = config;
 	pcm->flags = flags;
 
+	if (config->name)
+		pcm->component.name = config->name;
+
 	ret = dmaengine_pcm_request_chan_of(pcm, dev, config);
 	if (ret)
 		goto err_free_dma;

-- 
2.34.1


