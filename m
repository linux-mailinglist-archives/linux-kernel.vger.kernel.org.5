Return-Path: <linux-kernel+bounces-138953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F0B389FC82
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 18:08:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7127D1C219AB
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 16:08:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4B1117921F;
	Wed, 10 Apr 2024 16:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="WH8YFB8k"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 949F8178CF4;
	Wed, 10 Apr 2024 16:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712765332; cv=none; b=KfJaoOz7x1Z//5XG0kv6hYrfwkotuOD8htafZhzM+fm2mcEnlIc9ZGT9IVi5VuNqFAnhZfBf7fQtfDPwshJn7vfeXPBvIINcpRTZu7t5m7z/BejJ0dxBafSpYJC409PMiphz6MxgAoDpubt6nojWDwhsbKCdVvODPjmnb62QI8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712765332; c=relaxed/simple;
	bh=uIp+Ly6NhCx68e61qpQZ5cWRk4j7iTO0QltCVLYEnfY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fQ0OSBOTAWzYZyg4hr9taUnT6JEw9VgOYDFoP/RDj0RKRpMWyn5T8JA7oTAZEhmdwwf4KkZ/a+RHs40ifQyRx/eRe/GqOdLBfiK/SQl0Onpm5qhj8FBM3oVJ04GG+yksVaozvOSjZ4/D8EtnXK+6mnwM9rT8+Dvwl+a0lqLXxsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=WH8YFB8k; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43AAVPBH003230;
	Wed, 10 Apr 2024 11:08:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=PODMain02222019; bh=O
	CzWokGvgPVgqbKJreriPnsCx85RwRyagqB/QJQ8/vI=; b=WH8YFB8kpbw2FOPVK
	wqKtZfOfJwamIjjmbrH78vmjCngoOQmuH9js5Z3KcCr5tjkWdbrTYM7wbYG8TfwJ
	FngR/S+2R7ag6YQuKiJlHccKktGxSGNtZbofUgJoW+s2pLjPZW0l4D7F8Cv1j81b
	1IjP7PQzMNl7dy3mEMk+/NpIE8+/cFvOB4HgXSRuwxLBwOaBeF5QrVsJ/3gVtjf7
	2r8Ta6n/L+HDjsXJIiIgAJPGwJVpFBkNtFcj5MeFk4qvD9MuOeO/pMcXJoeF8sq2
	Nh1/Bp+8r+J4DNM0P8Pbhsp19/u9uw/qNqYimfgBDtm/SH9RgTVEttfe5Hkl+3sE
	JI95w==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3xb3sxn7k0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Apr 2024 11:08:39 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 10 Apr
 2024 17:08:37 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9
 via Frontend Transport; Wed, 10 Apr 2024 17:08:37 +0100
Received: from EDIN4L06LR3.ad.cirrus.com (EDIN4L06LR3.ad.cirrus.com [198.61.64.213])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id C104682024A;
	Wed, 10 Apr 2024 16:08:36 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: <broonie@kernel.org>
CC: <alsa-devel@alsa-project.org>, <linux-sound@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        "Richard
 Fitzgerald" <rf@opensource.cirrus.com>
Subject: [PATCH] ASoC: cs35l56: Include array_size.h
Date: Wed, 10 Apr 2024 17:08:33 +0100
Message-ID: <20240410160833.20837-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: Itkn7BXLBpQp6x6Z1s9Jn7mBqLTJXMsw
X-Proofpoint-GUID: Itkn7BXLBpQp6x6Z1s9Jn7mBqLTJXMsw
X-Proofpoint-Spam-Reason: safe

Explicitly #include array_size.h for the source files that use
ARRAY_SIZE().

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 sound/soc/codecs/cs35l56-shared.c | 1 +
 sound/soc/codecs/cs35l56.c        | 1 +
 2 files changed, 2 insertions(+)

diff --git a/sound/soc/codecs/cs35l56-shared.c b/sound/soc/codecs/cs35l56-shared.c
index ec1d95e57061..3aa39f5923eb 100644
--- a/sound/soc/codecs/cs35l56-shared.c
+++ b/sound/soc/codecs/cs35l56-shared.c
@@ -5,6 +5,7 @@
 // Copyright (C) 2023 Cirrus Logic, Inc. and
 //                    Cirrus Logic International Semiconductor Ltd.
 
+#include <linux/array_size.h>
 #include <linux/firmware/cirrus/wmfw.h>
 #include <linux/gpio/consumer.h>
 #include <linux/regmap.h>
diff --git a/sound/soc/codecs/cs35l56.c b/sound/soc/codecs/cs35l56.c
index 6331b8c6136e..dfd703d9e12f 100644
--- a/sound/soc/codecs/cs35l56.c
+++ b/sound/soc/codecs/cs35l56.c
@@ -6,6 +6,7 @@
 //                    Cirrus Logic International Semiconductor Ltd.
 
 #include <linux/acpi.h>
+#include <linux/array_size.h>
 #include <linux/completion.h>
 #include <linux/debugfs.h>
 #include <linux/delay.h>
-- 
2.39.2


