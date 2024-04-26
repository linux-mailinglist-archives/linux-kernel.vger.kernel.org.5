Return-Path: <linux-kernel+bounces-160570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD0438B3F4D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 20:34:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57B84287A63
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 18:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B79B46A4;
	Fri, 26 Apr 2024 18:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="0rJtA+Me"
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B30FD1879
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 18:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714156434; cv=none; b=kvfNS2Qs1cy3vQ1Ckp2UHf893m2lO/5z1ZkI3QD25tl/vTqLz59KPMD0RIIW5mTasFymHf2kMSKYjGioiLB6VyTJDi/MVBupxO+Xx6kRDxI/ECUzYX5AAZU3jQ+ojv8Iz6H5/BklUdxnzjyX8BTK/dRE8oLx5pMC6C8Sg86FXpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714156434; c=relaxed/simple;
	bh=4J9aLhdY9RS4dz16vgDDwuSL36gqfcptrHLWLwoq/UA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B1O84LZwTrLVaG1u4fzymHCmGUxWIqwgPw8szpKG73cocgKVnGRNJLMe99/BVUXFvkVjtKEWNK/KdpFboDb3ABk7CSDzQjc4xNnwvEG5KBD1UNRKOzXi2i6uIZuSFQbi5avtLqU/x+iKFICmkLJI7Zy8G/9HFYlTRUTb2KjbLVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=0rJtA+Me; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43QGIvMM032369;
	Fri, 26 Apr 2024 20:33:30 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	selector1; bh=FS4GO7Vi9VtaTdij6tViDskjPgOTwQBlqZacaW2haBg=; b=0r
	JtA+MebY44tHEXh+kRjLtTAZbiesZXfi7AB16EgpTNnRdnRx2mkWowi29W1Z96cO
	e+lXQlgSGi/QNMlgQCuTs2G5FhPe/MZLSa3khho4GG9lf/nkITrLsMFGfrO8TNUx
	owkLMWbdlG3Y5S1E1zCpR8ihF/lzPryssb0uJQgH8//TGVFwhnqBOYM00CgGYx7A
	ds8ptF6DhLjENS41LXk4KVpaG3z7vKQyNT4p0FoVoY93JugqulRP/ETDSrM7FzLL
	jPWou0Cht1D9z0E5ETKHMId/cgyx1NfH0uIohNOlpzz3OzYQA1GIHzze0LusHwBh
	z9psHTLFOWgHFOxiVw0g==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3xm4kbjscs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Apr 2024 20:33:30 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 616624002D;
	Fri, 26 Apr 2024 20:33:26 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 7F01C22FA36;
	Fri, 26 Apr 2024 20:33:00 +0200 (CEST)
Received: from localhost (10.48.86.112) by SHFDAG1NODE3.st.com (10.75.129.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 26 Apr
 2024 20:33:00 +0200
From: Patrick Delaunay <patrick.delaunay@foss.st.com>
To: Alexandre TORGUE <alexandre.torgue@foss.st.com>,
        Liam Girdwood
	<lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Maxime Coquelin
	<mcoquelin.stm32@gmail.com>
CC: Patrick Delaunay <patrick.delaunay@foss.st.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: [PATCH v2 2/2] regulator: stm32-pwr: add support of STM32MP13
Date: Fri, 26 Apr 2024 20:32:51 +0200
Message-ID: <20240426203245.v2.2.I04ec53442753147c35efad1307b6ec133f53b471@changeid>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240426183253.1360098-1-patrick.delaunay@foss.st.com>
References: <20240426183253.1360098-1-patrick.delaunay@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-26_16,2024-04-26_02,2023-05-22_02

Add support of the new compatible "st,stm32mp13-pwr-reg" for STM32MP13.

Signed-off-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
---

Changes in v2:
- Add new compatible for STM32MP13 and change title after Rob remarks
  V1: "ARM: st: use a correct pwr compatible for stm32mp15"

 drivers/regulator/stm32-pwr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/regulator/stm32-pwr.c b/drivers/regulator/stm32-pwr.c
index 85b0102fb9b1..b7aeef6e09e7 100644
--- a/drivers/regulator/stm32-pwr.c
+++ b/drivers/regulator/stm32-pwr.c
@@ -166,6 +166,7 @@ static int stm32_pwr_regulator_probe(struct platform_device *pdev)
 
 static const struct of_device_id __maybe_unused stm32_pwr_of_match[] = {
 	{ .compatible = "st,stm32mp1,pwr-reg", },
+	{ .compatible = "st,stm32mp13-pwr-reg", },
 	{},
 };
 MODULE_DEVICE_TABLE(of, stm32_pwr_of_match);
-- 
2.25.1


