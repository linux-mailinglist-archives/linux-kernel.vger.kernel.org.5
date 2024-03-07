Return-Path: <linux-kernel+bounces-95380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C928874D04
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 12:09:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98BF6B21C4A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 11:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D24112838A;
	Thu,  7 Mar 2024 11:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="k2ToVRtN"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4628E5FDD5;
	Thu,  7 Mar 2024 11:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709809718; cv=none; b=OWdpx3jS2pmTd0tXQ+42qQOk7g932pMreXlLW7MtCbC1Kgzq12rLXAEIQ628mRyDoNSlKYdwdAalryVxXIvBBxUYJQUsi6Lr54x4l/CCUnoebV201UIRmCdvHsYCkmJwx0efPukene1vB6ZapJkujnwdv+eWKsCCn4FCmLzhdUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709809718; c=relaxed/simple;
	bh=wInu/EODGuk8xeB66BsBeqyzmB26nqNNQ26oD0r3iN8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DwgFTuRG7T1MhpaE7UjnWqhXz0Cs0ML5+daPDHfrWuRkQ+9khrmVFGlOQFOIqr7WqlNIgCyxmQGrlT0wNoFJL7Y2aOIJxQ/q2lntZcE4G/DcgL7hYNNPPqcxIjeZcmtezq8lXG3vfU9/bx9uFhJgyulauPkgI2pLKF8p04H69cU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=k2ToVRtN; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4276U3No025228;
	Thu, 7 Mar 2024 04:53:55 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=PODMain02222019; bh=3
	7+wHMDBsacM91GxnPaOu65ZAzpZ3qOzCgwvREEJ1O8=; b=k2ToVRtNuZBkXzhmn
	itygr2QmDRrQmHu6B8NNabyD1FTNUKVG6nB2CXDUMUQ5bwfC5wVxz1VwlpAEVb0Z
	IWQx0tLB91hCWiKjv4m/zQ/eSpPBPJ2hN0pRnfNt2aSNJAwCPntu3I/SYCqFyTzp
	zj3KqurVeDYimYnvZ7eE6v2/RFloP15XbbNI09w2MXMlpfCGiloZguw3rFsnISZ1
	1XMfemtkE6bplC8eCtBajakGiXoawK7M6C58/3h9k6TwJhLiwIn6Ga2ue3FeokD2
	8HummvLZBKIAXnrf/dRiitlfT9GwBBoT0zl3PFBp5nqg84MB3j3XXZfCUOB3MNx5
	T7odQ==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3wpn931gsn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Mar 2024 04:53:55 -0600 (CST)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 7 Mar 2024
 10:53:53 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.4 via Frontend Transport; Thu, 7 Mar 2024 10:53:53 +0000
Received: from ediswws06.ad.cirrus.com (ediswws06.ad.cirrus.com [198.90.208.18])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 95E4382024B;
	Thu,  7 Mar 2024 10:53:53 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: <broonie@kernel.org>
CC: <linux-sound@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        "Richard
 Fitzgerald" <rf@opensource.cirrus.com>
Subject: [PATCH] firmware: cirrus: cs_dsp: Initialize debugfs_root to invalid
Date: Thu, 7 Mar 2024 10:53:53 +0000
Message-ID: <20240307105353.40067-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: IHeQw5BgtaqdO9UauUPo3yllBRgkwiZo
X-Proofpoint-ORIG-GUID: IHeQw5BgtaqdO9UauUPo3yllBRgkwiZo
X-Proofpoint-Spam-Reason: safe

Initialize debugfs_root to -ENODEV so that if the client never sets a
valid debugfs root the debugfs files will not be created.

A NULL pointer passed to any of the debugfs_create_*() functions means
"create in the root of debugfs". It doesn't mean "ignore".

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 drivers/firmware/cirrus/cs_dsp.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/cirrus/cs_dsp.c b/drivers/firmware/cirrus/cs_dsp.c
index 79d4254d1f9b..9f3d665cfdcf 100644
--- a/drivers/firmware/cirrus/cs_dsp.c
+++ b/drivers/firmware/cirrus/cs_dsp.c
@@ -522,7 +522,7 @@ void cs_dsp_cleanup_debugfs(struct cs_dsp *dsp)
 {
 	cs_dsp_debugfs_clear(dsp);
 	debugfs_remove_recursive(dsp->debugfs_root);
-	dsp->debugfs_root = NULL;
+	dsp->debugfs_root = ERR_PTR(-ENODEV);
 }
 EXPORT_SYMBOL_NS_GPL(cs_dsp_cleanup_debugfs, FW_CS_DSP);
 #else
@@ -2246,6 +2246,11 @@ static int cs_dsp_common_init(struct cs_dsp *dsp)
 
 	mutex_init(&dsp->pwr_lock);
 
+#ifdef CONFIG_DEBUG_FS
+	/* Ensure this is invalid if client never provides a debugfs root */
+	dsp->debugfs_root = ERR_PTR(-ENODEV);
+#endif
+
 	return 0;
 }
 
-- 
2.30.2


