Return-Path: <linux-kernel+bounces-94243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 25B0F873BE2
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 17:16:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 577121C23C11
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 16:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BF1013BAD2;
	Wed,  6 Mar 2024 16:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="DzuFhK0x"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4177137936;
	Wed,  6 Mar 2024 16:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709741718; cv=none; b=cOPiktw/aVtfsnYz3qjt0/i1fj9f0dhk7oNDi5qmqkjEU8FtAhBzckgkJF7qyHf5Kr2cSqEk5qpQgZfuSSUaTARLv8tWMjjAOieuyeVby5MyY2r/AREr4XUTW3f2NlpB/Y4pHe978kcas8MkCDIjQ0CMiwwY9N1L+S1F8hSe0Bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709741718; c=relaxed/simple;
	bh=ioYN/9YghUj0aCB+8sxcgLE59kh3ARmKIokGHWoPN0s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LwV9wyYcTlAR6jLeop41NoSoD4MyjWOon7oQm95Pm1LQu6vb//1f1HGhCs3GNgjd7jcemiKioi7G95CPfHuSJc3Kz97t0mPSK6fjDRrxPciTBAta71HP4nPuHaPQPyLdOpfrU8Q1upbqDRmIX3/gfmMqTSakUlgsTvi96zpAKyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=DzuFhK0x; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4268m45H016753;
	Wed, 6 Mar 2024 10:15:10 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	PODMain02222019; bh=bRU53y88xZ5UTSTdeL7E9DlLRqfwscew8y4zZPeOtvw=; b=
	DzuFhK0xgLwkNfb/9rHkmebTTxtraSge9LlgHjAeC2to/86SSIItWaKJv6zboVu3
	qifYBzQ2rIQQdcWClGmXVV+FBnKLgan4HkOPWxPg3IyiR/IBPZo/1sQJqKzAMuBX
	3IJaMauPfr11MG2FuUYs2Sn9Pl7TEESesie7PIiyPQhYJiNarufIpQnGQtUZ1SoE
	OfuPDG/hQbbEBkep9FgIaa1PwmzLt1iQ9h9y60njAPJP1v04KRmqbD66GO9aif2M
	gGgMqh9fwrfSkbRW349eOP1wpYHFpp1pG1ANS8nlzYXc6xgyQr+hTT41Ppmr0MIk
	UX4PEaYkaTNIMdCXmIIiXw==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3wpn930g9n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Mar 2024 10:15:10 -0600 (CST)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 6 Mar 2024
 16:15:08 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.4 via Frontend Transport; Wed, 6 Mar 2024 16:15:08 +0000
Received: from ediswws08.ad.cirrus.com (ediswws08.ad.cirrus.com [198.90.208.13])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id BE609820243;
	Wed,  6 Mar 2024 16:15:08 +0000 (UTC)
From: Stuart Henderson <stuarth@opensource.cirrus.com>
To: <broonie@kernel.org>, <shengjiu.wang@gmail.com>, <Xiubo.Lee@gmail.com>
CC: <patches@opensource.cirrus.com>, <linux-sound@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        "Stuart
 Henderson" <stuarth@opensource.cirrus.com>
Subject: [PATCH 5/5] ASoC: wm8962: Fix up incorrect error message in wm8962_set_fll
Date: Wed, 6 Mar 2024 16:14:39 +0000
Message-ID: <20240306161439.1385643-5-stuarth@opensource.cirrus.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240306161439.1385643-1-stuarth@opensource.cirrus.com>
References: <20240306161439.1385643-1-stuarth@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: GQpgMBZCV7sidcX6J5TRZH52UMzzfD2J
X-Proofpoint-ORIG-GUID: GQpgMBZCV7sidcX6J5TRZH52UMzzfD2J
X-Proofpoint-Spam-Reason: safe

Use source instead of ret, which seems to be unrelated and will always
be zero.

Signed-off-by: Stuart Henderson <stuarth@opensource.cirrus.com>
---
 sound/soc/codecs/wm8962.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wm8962.c b/sound/soc/codecs/wm8962.c
index 24bd818c3345..5ad6850c591f 100644
--- a/sound/soc/codecs/wm8962.c
+++ b/sound/soc/codecs/wm8962.c
@@ -2941,7 +2941,7 @@ static int wm8962_set_fll(struct snd_soc_component *component, int fll_id, int s
 				    WM8962_FLL_FRC_NCO, WM8962_FLL_FRC_NCO);
 		break;
 	default:
-		dev_err(component->dev, "Unknown FLL source %d\n", ret);
+		dev_err(component->dev, "Unknown FLL source %d\n", source);
 		return -EINVAL;
 	}
 
-- 
2.39.2


