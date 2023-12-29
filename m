Return-Path: <linux-kernel+bounces-12908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 37A7481FC6F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 02:46:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96C16285F0B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 01:46:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 117854434;
	Fri, 29 Dec 2023 01:46:32 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mg.richtek.com (mg.richtek.com [220.130.44.152])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C9DD23B4
	for <linux-kernel@vger.kernel.org>; Fri, 29 Dec 2023 01:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=richtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=richtek.com
X-MailGates: (SIP:2,PASS,NONE)(compute_score:DELIVER,40,3)
Received: from 192.168.10.47
	by mg.richtek.com with MailGates ESMTPS Server V6.0(636808:0:AUTH_RELAY)
	(envelope-from <cy_huang@richtek.com>)
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256/256); Fri, 29 Dec 2023 09:46:03 +0800 (CST)
Received: from ex3.rt.l (192.168.10.46) by ex4.rt.l (192.168.10.47) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.27; Fri, 29 Dec
 2023 09:46:03 +0800
Received: from linuxcarl2.richtek.com (192.168.10.154) by ex3.rt.l
 (192.168.10.45) with Microsoft SMTP Server id 15.2.1258.27 via Frontend
 Transport; Fri, 29 Dec 2023 09:46:03 +0800
From: <cy_huang@richtek.com>
To: Mark Brown <broonie@kernel.org>
CC: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>, ChiYuan Huang <cy_huang@richtek.com>,
	<alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] ASoC: codecs: rtq9128: Fix PM_RUNTIME usage
Date: Fri, 29 Dec 2023 09:46:01 +0800
Message-ID: <bebd9e2bed9e0528a7fd9c528d785da02caf4f1a.1703813842.git.cy_huang@richtek.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1703813842.git.cy_huang@richtek.com>
References: <cover.1703813842.git.cy_huang@richtek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

From: ChiYuan Huang <cy_huang@richtek.com>

If 'pm_runtime_resume_and_get' is used, must check the return value to
prevent the active count not matched problem.

Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
---
 sound/soc/codecs/rtq9128.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rtq9128.c b/sound/soc/codecs/rtq9128.c
index c22b047115cc..bda64f9eeb62 100644
--- a/sound/soc/codecs/rtq9128.c
+++ b/sound/soc/codecs/rtq9128.c
@@ -391,7 +391,11 @@ static int rtq9128_component_probe(struct snd_soc_component *comp)
 	unsigned int val;
 	int i, ret;
 
-	pm_runtime_resume_and_get(comp->dev);
+	ret = pm_runtime_resume_and_get(comp->dev);
+	if (ret < 0) {
+		dev_err(comp->dev, "Failed to resume device (%d)\n", ret);
+		return ret;
+	}
 
 	val = snd_soc_component_read(comp, RTQ9128_REG_EFUSE_DATA);
 
-- 
2.34.1


