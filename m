Return-Path: <linux-kernel+bounces-160572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C46E8B3F56
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 20:34:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58968288434
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 18:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F13F9BA34;
	Fri, 26 Apr 2024 18:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="nSloEz6e"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B62F9B647;
	Fri, 26 Apr 2024 18:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714156439; cv=none; b=JgG9Bec41602lockqIrq8Xv1O4X50iAHScVgc1RkPOk6hW4Q90mjNqkRu+BRETut2Ju3rBacWfSUg1ZYtNmzgCKR8MK41IpxTeTki5rnYWzR7z7mEMMMk1+ctfWkn8bjAC0vcvpsceyuhqHUbkRC30a8rKYThk7lDJy2lMQwHR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714156439; c=relaxed/simple;
	bh=LoAsra1hA9i9hkLZaYnURR7KfFIun2hW6cOATiB4DqQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GXkoNTOnSTJ9ZqUMCJrGrTubF61yfA+co1+A2p9s9MEOe4eAMI6HOe/s2BHmgVO/ZPgCcAJcWUfxKU0Dbx/uTK79R54VhpQTRB9hwlKB2GRoZHOA2yu4d+nfw9i6u6gmLeJL/XhuT3AaQz2Y/Q3Qkzkc3LACdJVC2CYYoqZPbpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=nSloEz6e; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43QEke4q031592;
	Fri, 26 Apr 2024 20:33:43 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	selector1; bh=hKZXTK2FODJbQu15bxlxQQSDaW8wFVSOMjE/gPb6e+U=; b=nS
	loEz6e9A5V2zfuNgKHxraVujS54Xqpj74J3N2HOWE9V+/ie3VD71D1w2ew+A64/I
	98wKB1MYQE/NZlGvvHFGdxg15BCtkdb5v2Wb++4LAxzFd9sprWIbEZT7geQR/H05
	WD0Gj+R+4Y0kpctfVC3SXUxqw9n7IyZ3lwICTplUohlWZEV2wN+rpNwjj5d9jBKN
	hCcxgOk8BZUO22OIfPl4k3ZmldNlOzDrIl6Lam/9kKTOAsKCNs0T1xMNfwoXPfB9
	VnBXehz2K2kknIh1/LcjPefwFt0RXLxGUYLchGEFcXtIyK07hPNLhsKP4/3Wl1Yc
	AqzQj+Laf4fgLV1pHAzg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3xmq9115ca-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Apr 2024 20:33:43 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 5959440045;
	Fri, 26 Apr 2024 20:33:39 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id C51C322FA35;
	Fri, 26 Apr 2024 20:32:58 +0200 (CEST)
Received: from localhost (10.48.86.112) by SHFDAG1NODE3.st.com (10.75.129.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 26 Apr
 2024 20:32:58 +0200
From: Patrick Delaunay <patrick.delaunay@foss.st.com>
To: Alexandre TORGUE <alexandre.torgue@foss.st.com>,
        Liam Girdwood
	<lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Pascal
 Paillet <p.paillet@foss.st.com>
CC: Patrick Delaunay <patrick.delaunay@foss.st.com>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: [PATCH v2 1/2] dt-bindings: regulator: st,stm32mp1-pwr-reg: add compatible for STM32MP13
Date: Fri, 26 Apr 2024 20:32:50 +0200
Message-ID: <20240426203245.v2.1.Ia0a99d90acb512aa020a6e7a8cca8cc1b71f1759@changeid>
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

Add new compatible "st,stm32mp13-pwr-reg" for STM32MP13 SoC family.

Signed-off-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
---

Changes in v2:
- update for Rob review, only add compatible for STM32MP13 family

 .../devicetree/bindings/regulator/st,stm32mp1-pwr-reg.yaml    | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/regulator/st,stm32mp1-pwr-reg.yaml b/Documentation/devicetree/bindings/regulator/st,stm32mp1-pwr-reg.yaml
index c9586d277f41..b0c6c62a84ea 100644
--- a/Documentation/devicetree/bindings/regulator/st,stm32mp1-pwr-reg.yaml
+++ b/Documentation/devicetree/bindings/regulator/st,stm32mp1-pwr-reg.yaml
@@ -11,7 +11,9 @@ maintainers:
 
 properties:
   compatible:
-    const: st,stm32mp1,pwr-reg
+    oneOf:
+    - const: st,stm32mp1,pwr-reg
+    - const: st,stm32mp13-pwr-reg
 
   reg:
     maxItems: 1
-- 
2.25.1


