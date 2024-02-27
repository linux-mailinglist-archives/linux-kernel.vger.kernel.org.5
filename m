Return-Path: <linux-kernel+bounces-82998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 05503868CCB
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 11:01:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A59571F251FF
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 10:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59F94137C32;
	Tue, 27 Feb 2024 10:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="jjIKGiEF"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06D7E56458;
	Tue, 27 Feb 2024 10:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709028069; cv=none; b=ZwbJ84gijogkP7rcBV0QpACIfGqzoSVVJVH9GS9qnvkoy5zMcphRjHZlW2JL9b2IaOKwGQ3GkzCKx3JOOC+iCnQkwSSlAN7ZhsM1N+svPx1oEIk8Ad9pPbUUbPBONdXT8h984dxXBhR3TJmxoCAxTyA//B8az0hK6P3cynuWzKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709028069; c=relaxed/simple;
	bh=icVQbNc6Pzd3/XoMFybZxZR4XgSeB5FGoOCVNAL9xWE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GcQnhQxv3BKj5FeypssFUFvuthaUtiMitAOBJt18n3KTdXg8nGilkxfXKryqfvmne3jJIweY+KhD2cBhf/LompXhTJNxhkkkLHm1r9ZTlg9x4Akh66cqqNSgMAxs0k4YQ6KReWfuTLmAJW6c7w69VXrmxRsuBPYXubCOgZVHpnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=jjIKGiEF; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41R59Fpo012520;
	Tue, 27 Feb 2024 04:00:47 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=PODMain02222019; bh=e
	KIvLq8xXb6oflbot81eGZAizbrGvdd+1Q79YDlPBfg=; b=jjIKGiEF9iJDojLcV
	PmzfDAPYEFMmbld2KLy4GldiaePq3k9Xvew+Toj1H5E0xCM5mDEQq8XX988QuOPd
	r8owsQyxVMc8gi+bSpQxQrLYg7cWiwwrHnXWyVzzcuinM+SctHuQhSI2YIOuLPWn
	nRFbPeP2+e1sOszAyKKXJCrbjkiYbeFNtzverDy0eYae2xQQ+jfS91pjV89ilaHF
	Exp4fet7/0TeIG5w5xqh/Ltb6jzia7cZwnDYzXPocyWu/6ltE/8oeR5xtU556UU7
	aKLgEwj6nZvuwzxFzQNbvPewmQklIx39aUaZVMWBcEqYmnRofMopye2Ydzx9l9rU
	+UOZw==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3wfer2u9e5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Feb 2024 04:00:47 -0600 (CST)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 27 Feb
 2024 10:00:44 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.40 via Frontend Transport; Tue, 27 Feb 2024 10:00:44 +0000
Received: from EDIN4L06LR3.ad.cirrus.com (EDIN4L06LR3.ad.cirrus.com [198.61.65.56])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 5A600820246;
	Tue, 27 Feb 2024 10:00:44 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: <broonie@kernel.org>, <tiwai@suse.com>
CC: <alsa-devel@alsa-project.org>, <linux-sound@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        "Richard
 Fitzgerald" <rf@opensource.cirrus.com>
Subject: [PATCH] ASoC: cs35l56: Prevent bad sign extension in cs35l56_read_silicon_uid()
Date: Tue, 27 Feb 2024 10:00:42 +0000
Message-ID: <20240227100042.99-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: sVtyfHros6atG7YF84seuCbHvi2LKv4u
X-Proofpoint-ORIG-GUID: sVtyfHros6atG7YF84seuCbHvi2LKv4u
X-Proofpoint-Spam-Reason: safe

Cast u8 values to u32 when using them to build a 32-bit unsigned value
that is then stored in a u64. This avoids the possibility of a bad sign
extension where the u8 is implicitly extended to an int, thus changing it
from an unsigned to a signed value.

Whether this is a real problem is debatable, but it does no harm to
ensure that the u8 are cast to a suitable type for shifting.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Fixes: e1830f66f6c6 ("ASoC: cs35l56: Add helper functions for amp calibration")
---
 sound/soc/codecs/cs35l56-shared.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/cs35l56-shared.c b/sound/soc/codecs/cs35l56-shared.c
index 20b6dbd3fbab..f3670bf85a95 100644
--- a/sound/soc/codecs/cs35l56-shared.c
+++ b/sound/soc/codecs/cs35l56-shared.c
@@ -659,9 +659,10 @@ static int cs35l56_read_silicon_uid(struct cs35l56_base *cs35l56_base, u64 *uid)
 		return ret;
 	}
 
-	unique_id = pte.lot[2] | (pte.lot[1] << 8) | (pte.lot[0] << 16);
+	unique_id = (u32)pte.lot[2] | ((u32)pte.lot[1] << 8) | ((u32)pte.lot[0] << 16);
 	unique_id <<= 32;
-	unique_id |= pte.x | (pte.y << 8) | (pte.wafer_id << 16) | (pte.dvs << 24);
+	unique_id |= (u32)pte.x | ((u32)pte.y << 8) | ((u32)pte.wafer_id << 16) |
+		     ((u32)pte.dvs << 24);
 
 	dev_dbg(cs35l56_base->dev, "UniqueID = %#llx\n", unique_id);
 
-- 
2.39.2


