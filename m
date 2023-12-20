Return-Path: <linux-kernel+bounces-6303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 09D748196F7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 03:57:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE1F21F261B1
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 02:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A1EA8813;
	Wed, 20 Dec 2023 02:57:24 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE6A1BE58;
	Wed, 20 Dec 2023 02:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4Svys95x1rz8XrRB;
	Wed, 20 Dec 2023 10:57:17 +0800 (CST)
Received: from xaxapp02.zte.com.cn ([10.88.97.241])
	by mse-fl2.zte.com.cn with SMTP id 3BK2v7Ji078029;
	Wed, 20 Dec 2023 10:57:07 +0800 (+08)
	(envelope-from yang.guang5@zte.com.cn)
Received: from mapi (xaxapp03[null])
	by mapi (Zmail) with MAPI id mid31;
	Wed, 20 Dec 2023 10:57:08 +0800 (CST)
Date: Wed, 20 Dec 2023 10:57:08 +0800 (CST)
X-Zmail-TransId: 2afb65825804ffffffff93b-ece67
X-Mailer: Zmail v1.0
Message-ID: <202312201057082362118@zte.com.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <yang.guang5@zte.com.cn>
To: <lgirdwood@gmail.com>
Cc: <jiang.xuexin@zte.com.cn>, <chen.haonan2@zte.com.cn>, <cgel.zte@gmail.com>,
        <broonie@kernel.org>, <perex@perex.cz>, <tiwai@suse.com>,
        <linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIIGxpbnV4LW5leHRdIEFTb0M6IHNvYy10b3BvbG9neTogU3dpdGNoIHRvIHVzZSBkZXZfZXJyX3Byb2JlKCkgaGVscGVy?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 3BK2v7Ji078029
X-Fangmail-Gw-Spam-Type: 0
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6582580D.000/4Svys95x1rz8XrRB

From: Yang Guang <yang.guang5@zte.com.cn>

dev_err() can be replace with dev_err_probe() which will
check if error code is -EPROBE_DEFER.

Signed-off-by: Chen Haonan <chen.haonan2@zte.com.cn>
---
 sound/soc/soc-topology.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
index ba4890991f0d..c0d40162aff2 100644
--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -1736,8 +1736,7 @@ static int soc_tplg_fe_link_create(struct soc_tplg *tplg,

 	ret = snd_soc_add_pcm_runtimes(tplg->comp->card, link, 1);
 	if (ret < 0) {
-		if (ret != -EPROBE_DEFER)
-			dev_err(tplg->dev, "ASoC: adding FE link failed\n");
+		dev_err_probe(tplg->dev, ret, "ASoC: adding FE link failed\n");
 		goto err;
 	}

-- 
2.25.1

