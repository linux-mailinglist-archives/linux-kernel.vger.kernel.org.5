Return-Path: <linux-kernel+bounces-34023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71D9C837200
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 20:11:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A264D1C2A507
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 19:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6D7E3FE38;
	Mon, 22 Jan 2024 18:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="Dj7LG9kF"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7539A3FE26
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 18:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705949268; cv=none; b=AMSXtGuiHUgoF7zVpNu9J1wweivBuIQdYWCv4CNrRfAK8UqCQBAhpBCiOkyrUIRCtIOWRGVYPlPffL1HtfSFLViwNn9DJ2cpawLSsvJ3H5uHhztYIECeL5fW9RhzcZEcmuLXKrrvNKrACuANL95hWRQPDu3hP/q8o8Jc/2fhNpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705949268; c=relaxed/simple;
	bh=yNWjQEhqiBhpcGomz7GYxV+WTENan9gghULSm32sqlE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AgxftXA/Sl/hP0/JxsKMvVx8+IoujMVGXK1E0qXaTrwkKfoaIydWQ9LIDt59h4E/RniLPlZ7KvlA9OCnBbVXn5cL+DNOSJYrGRxufsRQF2Z9wmLXnGAEdgZnXfqTU/QAXkwDtPtIsqotEXPZky+e+dgQFxQebPUR9fyCHvUtpAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=Dj7LG9kF; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40MFaTcN005855;
	Mon, 22 Jan 2024 12:47:22 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=PODMain02222019; bh=V
	kiWtsyAhD5poWwiOG59Zhs6f5A5ZaAm657wTjx1lyY=; b=Dj7LG9kFrgE9po+vw
	9jiUUGn0N8RqeeGE+G5kEJgz6n1Qb+rntAtHIV8rx4d09VLEKhrZT3VtoDwlTZUD
	4F4tWgU217WiR1KB4Zypy0napLxBrFIGWgYqojMautgj2CuPzuX5VxCx/zcAvPWZ
	phe7LFMGwpHsgqzQrWE9vWe0HmEJWG/xVlVYSinBA2r+iv6I4UDk9ufG7aFy3utO
	81yU9ObqBwpI8W8dexTIlBOFGNIKtvSX0CCC5ci/Y0ZZ6pdrxf4Xr6rITSE6oMRV
	JsgVaiSWR2urae8GeClhB46L+/sVz0r/RgyHHVOi2WGs2N4UT+gCmTORy1FPhpIb
	NZPZg==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3vrcf32xaf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Jan 2024 12:47:21 -0600 (CST)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 22 Jan
 2024 18:47:19 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.40 via Frontend Transport; Mon, 22 Jan 2024 18:47:19 +0000
Received: from lon-bigdaddy.ad.cirrus.com (unknown [198.61.65.241])
	by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 6BFA611D3;
	Mon, 22 Jan 2024 18:47:19 +0000 (UTC)
From: Vitaly Rodionov <vitalyr@opensource.cirrus.com>
To: Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>
CC: <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>,
        Vitaly Rodionov
	<vitalyr@opensource.cirrus.com>
Subject: [PATCH] ALSA: hda/cs8409: Suppress vmaster control for Dolphin models
Date: Mon, 22 Jan 2024 18:47:10 +0000
Message-ID: <20240122184710.5802-1-vitalyr@opensource.cirrus.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: i3yZTsMWsKwhp3pCo0bEw_gT9KKii5ID
X-Proofpoint-GUID: i3yZTsMWsKwhp3pCo0bEw_gT9KKii5ID
X-Proofpoint-Spam-Reason: safe

Customer has reported an issue with specific desktop platform
where two CS42L42 codecs are connected to CS8409 HDA bridge.
If "Master Volume Control" is created then on Ubuntu OS UCM
left/right balance slider in UI audio settings has no effect.
This patch will fix this issue for a target paltform.

Signed-off-by: Vitaly Rodionov <vitalyr@opensource.cirrus.com>
---
 sound/pci/hda/patch_cs8409.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_cs8409.c b/sound/pci/hda/patch_cs8409.c
index 627899959ffe..e41316e2e983 100644
--- a/sound/pci/hda/patch_cs8409.c
+++ b/sound/pci/hda/patch_cs8409.c
@@ -1371,6 +1371,7 @@ void dolphin_fixups(struct hda_codec *codec, const struct hda_fixup *fix, int ac
 		spec->scodecs[CS8409_CODEC1] = &dolphin_cs42l42_1;
 		spec->scodecs[CS8409_CODEC1]->codec = codec;
 		spec->num_scodecs = 2;
+		spec->gen.suppress_vmaster = 1;
 
 		codec->patch_ops = cs8409_dolphin_patch_ops;
 
-- 
2.40.1


