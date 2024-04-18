Return-Path: <linux-kernel+bounces-149889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40B358A976F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 12:33:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D42651F235AD
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 10:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CF891586F5;
	Thu, 18 Apr 2024 10:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="pydh4FwE"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77FE68821;
	Thu, 18 Apr 2024 10:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713436411; cv=none; b=uqH2YrTEQLg75tIZvt4bkSYLYf+2aBPHnjfoOTo8oDZccr131v7VdXsBW51ykEkeUEPoX/uNLujm/A2IU2Mh8Z72vUD2U7NVv51Muou1eLAUtQlJdmJFINLCe9UPpf/937vuNWRYCvERgOLGoC1Vtb3PM4LEJs0ufaCOOekwGaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713436411; c=relaxed/simple;
	bh=fXyGjhAm0JIkMbjnAel3FGNCVvKR94WIGzZRwngByII=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mZX/H0YJhvYVuCQ7eWfDXcAmtwJb4Waa/GiyGBkBdy6huXm+Yer3IJrYXCxpUm3Pwb60/kV7KmWoZekujxZrGwawTMCmJ4NzgHJW9L5khPjqW1YVgaf/Xif/YI1TCCc1Fc5b3foADmDPMUFXuPDGeshTLqd9DxeUHILosTCqXqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=pydh4FwE; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43I5jALP019878;
	Thu, 18 Apr 2024 05:33:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=PODMain02222019; bh=j
	z5Rie3do+TgO9XWh4Mv9YDCnGPamrE2rEo8a/X/MDM=; b=pydh4FwEJLg1Qny7B
	eNSffSk6r0c+l22PehWiFHSC4f05Fxn/c4SbOvtZ0bs/oMp0WZZ0aRSxPSyTn3P3
	/RraFWKt823nGKkzRKq7QO/c27Y/RcESVC87hVQWSle6+FdYlA2SPJ8OJjdNO18R
	nPJu6Qn2ygM2BDnJux3yM4PlR+NmWCM7LVUEYMRdl4tRHSig0JpzWqsQuFwLPhW6
	800ZQjuBXDBZxiNAeKF1mMF7KpMKyCVog5+oGf7zm/r5oAzw7pKn9sJd2LU59Jli
	+vxnw4xkDUwnJS9r8Tp2T7495SMuAC2KLn2hBuwRPJh/iKGaR0yJfjzmIgbbuQW8
	bZG5g==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3xfpfhvmqc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Apr 2024 05:33:19 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 18 Apr
 2024 11:33:17 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9
 via Frontend Transport; Thu, 18 Apr 2024 11:33:17 +0100
Received: from ediswws03.ad.cirrus.com (ediswws03.ad.cirrus.com [198.90.208.11])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 4BA24820245;
	Thu, 18 Apr 2024 10:33:17 +0000 (UTC)
From: Maciej Strozek <mstrozek@opensource.cirrus.com>
To: Mark Brown <broonie@kernel.org>
CC: <patches@opensource.cirrus.com>, <alsa-devel@alsa-project.org>,
        <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Maciej Strozek
	<mstrozek@opensource.cirrus.com>
Subject: [PATCH v2] spi: cs42l43: Correct name of ACPI property
Date: Thu, 18 Apr 2024 11:33:15 +0100
Message-ID: <20240418103315.1487267-1-mstrozek@opensource.cirrus.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: URX_4b8_yisaN-CnDypzhKTNTYFAWsep
X-Proofpoint-GUID: URX_4b8_yisaN-CnDypzhKTNTYFAWsep
X-Proofpoint-Spam-Reason: safe

Fixes: 439fbc97502a ("spi: cs42l43: Add bridged cs35l56 amplifiers")

Signed-off-by: Maciej Strozek <mstrozek@opensource.cirrus.com>
---
v2: Corrected the Fixes tag to point to right commit

 drivers/spi/spi-cs42l43.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-cs42l43.c b/drivers/spi/spi-cs42l43.c
index cdc61cd089ad..9d747ea69926 100644
--- a/drivers/spi/spi-cs42l43.c
+++ b/drivers/spi/spi-cs42l43.c
@@ -267,7 +267,7 @@ static bool cs42l43_has_sidecar(struct fwnode_handle *fwnode)
 			continue;

 		ret = fwnode_property_read_u32(ext_fwnode,
-					       "01fa-cirrus-sidecar-instances",
+					       "01fa-sidecar-instances",
 					       &val);

 		fwnode_handle_put(ext_fwnode);
--
2.34.1


