Return-Path: <linux-kernel+bounces-116780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F26B88A3CB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:12:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3947A2E0968
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C658D17106D;
	Mon, 25 Mar 2024 10:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="n0gWS2ha"
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24EB1190662;
	Mon, 25 Mar 2024 09:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711360774; cv=none; b=aqejty3mno75wRRfoIFu4q3LAJUBdczId40YJgz9JimecFvIXvFLXopvCN8KV28XGqUipL7jY6KgrBoJodvyRCCWK1KfObdF98UzsbzFYO1xqZl3nVzhOfiiU5P0pvONcgnpJluf43XQruNNJHaaoMVMLwi+1wd5kB93oG51ZxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711360774; c=relaxed/simple;
	bh=V71GOfQZeCnRv0gdv6EbVgKYTEs080nwBndJyVfUGUA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=S322nT/HNdSM977VHsAjKQBhXdTiD3iRRag2RNpi6bdwyNkziygrOCVhYzDlRGJFKpokM0vbtS/1OtldbZstdPDqxLbtNM3JPXoDKxQMUP9cCi+PQ+jmdLOKXy2JGufiH77MPQabw6GjqL1oEnAJDW5IgKPhzwcsH9dSYpxFU0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=n0gWS2ha; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42P8eGmA028115;
	Mon, 25 Mar 2024 10:44:07 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=selector1; bh=ffbGzpk
	ISaeUbR7jR83UhYzV507/spEZuEB2LJi1r+s=; b=n0gWS2ha/eKuYFCL9oX5EIw
	Bg1NzsCkqiDc38Ee7IZOEEquoBhLx1EaZb9TR8oJrEoGFxG/It5WfZz8u4gIrBIO
	zCtpuleSZQiiAGVo7tjql9EqoFb7EVWKk8eZG0vQnWWXY50LgRMo1DlPUfCzbV3u
	FZnJVzhzWgLHwvN92OKahVOhJMGsbxXgcPfLGUiq4HtPDQcdsjtk/3Bb4STstH7f
	8FNTkLl0qR9CxiphXXpbYDeCP1xRe2d0gifbzRQB9fPaV/xY86jZstEQujuWN8St
	h/unnqrnwyUHPSOHcs7VixG+EUBQjojj/2ZK1kzGZlCcHEGA5W6LjgWiREkkMqw=
	=
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3x1n3977fn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Mar 2024 10:44:07 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 6101240045;
	Mon, 25 Mar 2024 10:43:58 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 8A8F3216EF3;
	Mon, 25 Mar 2024 10:42:43 +0100 (CET)
Received: from localhost (10.201.21.128) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 25 Mar
 2024 10:42:42 +0100
From: Christophe Roullier <christophe.roullier@foss.st.com>
To: "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni
	<pabeni@redhat.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue
	<alexandre.torgue@foss.st.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Jose Abreu <joabreu@synopsys.com>, Liam Girdwood <lgirdwood@gmail.com>,
        Mark
 Brown <broonie@kernel.org>,
        Christophe Roullier
	<christophe.roullier@foss.st.com>,
        Marek Vasut <marex@denx.de>
CC: <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 0/2] Add properties in dwmac-stm32 documentation
Date: Mon, 25 Mar 2024 10:42:16 +0100
Message-ID: <20240325094218.56934-1-christophe.roullier@foss.st.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-25_07,2024-03-21_02,2023-05-22_02

Introduce 2 new properties in dwmac-stm32 documentation

 - phy-supply: to manage PHY regulator.
 - st,ext-phyclk: is present since 2020 in driver so need to explain
   it and avoid dtbs check issue : views/kernel/upstream/net-next/arch/arm/boot/dts/st/stm32mp157c-dk2.dtb: 
ethernet@5800a000: Unevaluated properties are not allowed 
('st,ext-phyclk' was unexpected)
   Furthermore this property will be use in upstream of MP13 dwmac glue. (next step)

V2: - Drop deprecated: property for st,eth-clk-sel and st,eth-ref-clk-sel
V3: - Rework commit message

Christophe Roullier (2):
  dt-bindings: net: add phy-supply property for stm32
  dt-bindings: net: dwmac: Document STM32 property st,ext-phyclk

 Documentation/devicetree/bindings/net/stm32-dwmac.yaml | 10 ++++++++++
 1 file changed, 10 insertions(+)

-- 
2.25.1


