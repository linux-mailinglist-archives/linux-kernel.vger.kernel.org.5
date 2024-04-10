Return-Path: <linux-kernel+bounces-138960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9588989FCA4
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 18:13:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E4A5287110
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 16:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1714217994E;
	Wed, 10 Apr 2024 16:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="jWq9QT2F"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE2F3179944;
	Wed, 10 Apr 2024 16:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712765605; cv=none; b=c14yt35kn/2ekPdfzSlJ90ec4FVB8B1dCmBqUlw2pc3JE8fNciXJqdLb6xevH6Q2TbirrXIEL3WGENXxt9soDRzSrCUsOZ3Hmsec2O7Kgdd1wBNXtdn/8FRX0taXdS/B3P+IYf56zUL9cdz34oz9NKv8GyJkdneYDGTovtmldrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712765605; c=relaxed/simple;
	bh=radcFVg3iOeeJnuXe+M9J3S/vIGLXH4HKrdOXck3UEE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DecIgZhAyf37zZvznoUy/KuDFuM54AVTS+/0GqpEpJencnDSuPDgRgmHbFhBwzJkS1JRakqxcbPyQJLEfehSLvudmh9tl8dQPWDKUFyXbzhVHY5FoUFFjJvOBLgHOBajUPh4qgfpwKPPZ+2u89T+Dc0KiSG/QKUWO/VgThMJfYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=jWq9QT2F; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43A7a5uI006286;
	Wed, 10 Apr 2024 11:13:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=PODMain02222019; bh=4
	wLQKrE2rPX+Nz55VubE8mQ7/UkXJmjP/U3JM/SK6X4=; b=jWq9QT2F28EMvuQvL
	wKTCDtt7695eNQceKeivMCAgZH/8jlDFWg1QpLABVkB65wtf/3yPwitOKq9zjf+/
	ArC+ho+rxXwsLB0Wu7hNN227wHgIbAI93SRG+oEd55GeCmL3ateBZUnpg4VLPL+X
	FP9xaatHioL3SJVUf94X9xybnkhAmmsEdZMpf62ONGbSU2l/bafAJQkyNJB3Cr1I
	4679s6L3gu+zP1dIuWDgQYa1XjKz/QIGe0QP7d7pBRb2aigJNdMdeDxTmo1Z51Oc
	qa8/vnRueJ4MvIswHIJz+ZAB2NrG/72d1QAm22XwwPPmcK8Nv5XlWDNqTCsKcucl
	A3S4Q==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3xb3sxn7xb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Apr 2024 11:13:16 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 10 Apr
 2024 17:13:14 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Wed, 10 Apr 2024 17:13:14 +0100
Received: from EDIN4L06LR3.ad.cirrus.com (EDIN4L06LR3.ad.cirrus.com [198.61.64.213])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 1D00182024A;
	Wed, 10 Apr 2024 16:13:14 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: <broonie@kernel.org>
CC: <alsa-devel@alsa-project.org>, <linux-sound@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        "Richard
 Fitzgerald" <rf@opensource.cirrus.com>
Subject: [PATCH] ASoC: wm_adsp: Include array_size.h
Date: Wed, 10 Apr 2024 17:13:12 +0100
Message-ID: <20240410161312.22313-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: svg_RbcpAcZNzpchFjMUujb1CX9AXgvT
X-Proofpoint-GUID: svg_RbcpAcZNzpchFjMUujb1CX9AXgvT
X-Proofpoint-Spam-Reason: safe

Explicitly #include array_size.h for the ARRAY_SIZE() macro.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 sound/soc/codecs/wm_adsp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index 7d5c096e06cd..9a89682ebc1f 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -7,6 +7,7 @@
  * Author: Mark Brown <broonie@opensource.wolfsonmicro.com>
  */
 
+#include <linux/array_size.h>
 #include <linux/ctype.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
-- 
2.39.2


