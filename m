Return-Path: <linux-kernel+bounces-117069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8B2488A6A3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:32:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 897A81F3C1A8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8600F74E3F;
	Mon, 25 Mar 2024 12:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="N7eaOxf4"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 443194AECC;
	Mon, 25 Mar 2024 12:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711371423; cv=none; b=MXWXo6kuF/xqdy0OPMwr4IvuGJXsHL+fvM36cUzWsjsnMSLOWS66cMxe9SDG4DJ8P8DKYGO5L7Has8LiizWMvhfyC4/I37LzwgnQcJ6k8dBHpADQ34b72sSjhcbTF6HDCm39j/HRBafkZ3J8fxpINLT6k8SQsNU61Z4UuXL1wGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711371423; c=relaxed/simple;
	bh=+iI5RpOodzmJXIcv8TNfNZngHxLuBoKhh3Wx6e3sdys=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DkyUfBzk+NnfyGZPFzzGuIylnG63YNURRpQEq2X1JH58kd01eOWZ+0QHYKq/Vu0rFb7QhF5jbRhWESEs2t3beQizkLYjhWU+ZNgQKDNz/59e8v/JbJSPnscSRET5u7+spDJneI0jVuRW9tJlnQWFrT7F8eLVuMH5MXhAHc5cu78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=N7eaOxf4; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42P3wbgD000927;
	Mon, 25 Mar 2024 07:56:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	PODMain02222019; bh=sQ1IUPXI8DEMkqDZPY9mFbPrpEApJsB5PFIBxvjEGNc=; b=
	N7eaOxf480SJu+PUGWS4WHBidiP8jZrGo7QufJqC2+aLovHdrlzZ08LpGetzsITh
	Ubj+nmXVlzuBwYqZIODsyCwkfNy/wblZgaMA2YGk4FYH+wmMdD/7ez7xYbzBYDto
	NGvlh8rUZOQE1T+8Kg5ezTOA4JKnlynmXQAJXRsuyd3LYhFJn61sddG7+sh9Y1KR
	fRfAfqqYTpUGXFtt4FEn6iOKa8NOizjxmG/K9rHQjBO0UtA7rXoJJKx/xrN7Ydlm
	1kNxAbpsgQz/Lmb/BZyWMFYyz7hdnVnG13jeGaa0aHCB/dpteYf9BGFMxyVbC0hy
	LD6QjQR9mVRt/pL7wHmkYg==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3x1vfyba74-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Mar 2024 07:56:54 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 25 Mar
 2024 12:56:50 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4
 via Frontend Transport; Mon, 25 Mar 2024 12:56:50 +0000
Received: from ediswws06.ad.cirrus.com (ediswws06.ad.cirrus.com [198.90.208.18])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 44560820246;
	Mon, 25 Mar 2024 12:56:50 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: <broonie@kernel.org>, <tiwai@suse.com>
CC: <linux-sound@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        "Richard
 Fitzgerald" <rf@opensource.cirrus.com>
Subject: [PATCH 1/3] ALSA: control: Introduce snd_ctl_find_id_mixer_locked()
Date: Mon, 25 Mar 2024 12:56:48 +0000
Message-ID: <20240325125650.213913-2-rf@opensource.cirrus.com>
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
X-Proofpoint-ORIG-GUID: zvRcc3bWjsKiSj91QulndMz5h0W2HEg6
X-Proofpoint-GUID: zvRcc3bWjsKiSj91QulndMz5h0W2HEg6
X-Proofpoint-Spam-Reason: safe

Adds wrapper function snd_ctl_find_id_mixer_locked(). This is
identical to snd_ctl_find_id_mixer() except that it can be called
from code that is already holding controls_rwsem.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 include/sound/control.h | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/include/sound/control.h b/include/sound/control.h
index 9a4f4f7138da..c1659036c4a7 100644
--- a/include/sound/control.h
+++ b/include/sound/control.h
@@ -167,6 +167,29 @@ snd_ctl_find_id_mixer(struct snd_card *card, const char *name)
 	return snd_ctl_find_id(card, &id);
 }
 
+/**
+ * snd_ctl_find_id_mixer_locked - find the control instance with the given name string
+ * @card: the card instance
+ * @name: the name string
+ *
+ * Finds the control instance with the given name and
+ * @SNDRV_CTL_ELEM_IFACE_MIXER. Other fields are set to zero.
+ *
+ * This is merely a wrapper to snd_ctl_find_id_locked().
+ * The caller must down card->controls_rwsem before calling this function.
+ *
+ * Return: The pointer of the instance if found, or %NULL if not.
+ */
+static inline struct snd_kcontrol *
+snd_ctl_find_id_mixer_locked(struct snd_card *card, const char *name)
+{
+	struct snd_ctl_elem_id id = {};
+
+	id.iface = SNDRV_CTL_ELEM_IFACE_MIXER;
+	strscpy(id.name, name, sizeof(id.name));
+	return snd_ctl_find_id_locked(card, &id);
+}
+
 int snd_ctl_create(struct snd_card *card);
 
 int snd_ctl_register_ioctl(snd_kctl_ioctl_func_t fcn);
-- 
2.39.2


