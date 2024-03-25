Return-Path: <linux-kernel+bounces-117068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7398988A6A2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:32:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1427F1F3C1A8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E9FE74E3D;
	Mon, 25 Mar 2024 12:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="BYwSrx7R"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 442DB38DFB;
	Mon, 25 Mar 2024 12:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711371423; cv=none; b=WhvZXQnEObzaQDXSt5X6YYMmj4z1xmLurjZCml7uUHENz0K8VMlnAji6wonFv/8hSX1/SbN8x/Ozfy8yCvFvNSAFJXq5yytnWd9mob/WYCZcglczKp+vDlaZ8wmRstWkn+LyMGZlbu1p0h13+HZmz96s5ul/A/uD+mqdQUiQeeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711371423; c=relaxed/simple;
	bh=RUllOB4kMGk0CFo8XwTIjMOO3T3GbHWi6dMwwwH6M9E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CYy6KaH8khax2Jhzstv4TMmlZoaQNCfxpcOe3HO5JkQuxZ0TpHvX1QbmCWXlB/aKrpqlX92YC+f1LMsF48zD4Zgy8IcRYSgbKmAScFztfEZ/b7627Xhu0DNnTZ/x2ZtlgSlVPjvtL76Ui+7+JdQbWeN8/gszAVxd4a1FZ/gV8xA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=BYwSrx7R; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42P3wbgC000927;
	Mon, 25 Mar 2024 07:56:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	PODMain02222019; bh=xj2uHvx66aHHaH32S4duzTFa+mcPFLckOCA6lL3XaxE=; b=
	BYwSrx7RG1FXLgZH305/A63SWtbzmJ6uJBuLPZlf9zawx6UYuhy5mmplZaIAcnP1
	YJOgh7NY8n9OXwmMUnyC5d6E/MfIDpOFKYgbwiebrxwVqkUSRgd8OXUwF8hmlwhQ
	U44MWUUdPPKcte2SotUyMpIWUfqhLC896uTgOU+PO1MhTkiMMC7FbJupIHrSnjIq
	gs2ZCly7dqy3M4mmNyFzvXH+JA69EGNlSpQhGTnTlEnVYJZQYCTlzEYm1n9+pUJe
	ILzzfpqijw9fsvLMDctuRsFJU/vJtIlslgEowZZCqTBF7oG/IQ3eoe4Ec/b3/5+k
	/qxVn75v2TLMBcSJyRaMuw==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3x1vfyba74-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Mar 2024 07:56:53 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 25 Mar
 2024 12:56:50 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.4 via Frontend Transport; Mon, 25 Mar 2024 12:56:50 +0000
Received: from ediswws06.ad.cirrus.com (ediswws06.ad.cirrus.com [198.90.208.18])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 48FED82024D;
	Mon, 25 Mar 2024 12:56:50 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: <broonie@kernel.org>, <tiwai@suse.com>
CC: <linux-sound@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        "Richard
 Fitzgerald" <rf@opensource.cirrus.com>
Subject: [PATCH 2/3] ASoC: soc-card: Use snd_ctl_find_id_mixer() instead of open-coding
Date: Mon, 25 Mar 2024 12:56:49 +0000
Message-ID: <20240325125650.213913-3-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240325125650.213913-1-rf@opensource.cirrus.com>
References: <20240325125650.213913-1-rf@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: YKNsErgc-SVE7LA5WL0DpKQBZVrZCXeo
X-Proofpoint-GUID: YKNsErgc-SVE7LA5WL0DpKQBZVrZCXeo
X-Proofpoint-Spam-Reason: safe

Use the snd_ctl_find_id_mixer[_locked]() wrapper in
snd_soc_card_get_kcontrol[_locked]() instead of open-coding a custom
list walk of the card controls list.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 sound/soc/soc-card.c | 21 ++++-----------------
 1 file changed, 4 insertions(+), 17 deletions(-)

diff --git a/sound/soc/soc-card.c b/sound/soc/soc-card.c
index 8a2f163da6bc..0a3104d4ad23 100644
--- a/sound/soc/soc-card.c
+++ b/sound/soc/soc-card.c
@@ -32,33 +32,20 @@ static inline int _soc_card_ret(struct snd_soc_card *card,
 struct snd_kcontrol *snd_soc_card_get_kcontrol_locked(struct snd_soc_card *soc_card,
 						      const char *name)
 {
-	struct snd_card *card = soc_card->snd_card;
-	struct snd_kcontrol *kctl;
-
-	/* must be held read or write */
-	lockdep_assert_held(&card->controls_rwsem);
-
 	if (unlikely(!name))
 		return NULL;
 
-	list_for_each_entry(kctl, &card->controls, list)
-		if (!strncmp(kctl->id.name, name, sizeof(kctl->id.name)))
-			return kctl;
-	return NULL;
+	return snd_ctl_find_id_mixer_locked(soc_card->snd_card, name);
 }
 EXPORT_SYMBOL_GPL(snd_soc_card_get_kcontrol_locked);
 
 struct snd_kcontrol *snd_soc_card_get_kcontrol(struct snd_soc_card *soc_card,
 					       const char *name)
 {
-	struct snd_card *card = soc_card->snd_card;
-	struct snd_kcontrol *kctl;
-
-	down_read(&card->controls_rwsem);
-	kctl = snd_soc_card_get_kcontrol_locked(soc_card, name);
-	up_read(&card->controls_rwsem);
+	if (unlikely(!name))
+		return NULL;
 
-	return kctl;
+	return snd_ctl_find_id_mixer(soc_card->snd_card, name);
 }
 EXPORT_SYMBOL_GPL(snd_soc_card_get_kcontrol);
 
-- 
2.39.2


