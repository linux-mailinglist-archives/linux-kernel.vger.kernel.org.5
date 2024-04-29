Return-Path: <linux-kernel+bounces-162029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E534F8B54DF
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 12:17:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 226DB1C21956
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 10:17:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A07036137;
	Mon, 29 Apr 2024 10:17:10 +0000 (UTC)
Received: from mg.richtek.com (mg.richtek.com [220.130.44.152])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F35E82C6B2;
	Mon, 29 Apr 2024 10:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.130.44.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714385830; cv=none; b=WymAzrieGwRYBm1RRZk++Mhri+vT7hguQ/EeE067B2sreBeyouZ/7YuO0flRqsZk+oqFoFhxfNGyvax/e+F6IEChGoBnTEhYI8eIvrMVrVZVvHfJDRRa00U4kk0K4Ud8zRVUf3DlZnmYUGsstqe35su4FrKniDKOjKP8uHwdP/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714385830; c=relaxed/simple;
	bh=QkxjavhXS3fwWDqbSO/S7pS5DKBKKt/YkqJI6H2GB8Q=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TnIIHv4QQ6RSgwJUnJJ960mioAQKefLl3Y7gPHbk8xSSK5F3owaybr/UARbYvlSFKqjRC9uXN7hwLz8fqbS4JJaDxyE8N193Ni8EsDIzgd+lceziW9oZpoIfYByM8wFkOAPp5HPgmqdr4Z0/wblj5erCckOqS88zD02ZAfNurPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=richtek.com; spf=pass smtp.mailfrom=richtek.com; arc=none smtp.client-ip=220.130.44.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=richtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=richtek.com
X-MailGates: (SIP:2,PASS,NONE)(compute_score:DELIVER,40,3)
Received: from 192.168.10.46
	by mg.richtek.com with MailGates ESMTPS Server V6.0(3367349:0:AUTH_RELAY)
	(envelope-from <alina_yu@richtek.com>)
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256/256); Mon, 29 Apr 2024 18:16:51 +0800 (CST)
Received: from ex3.rt.l (192.168.10.46) by ex3.rt.l (192.168.10.46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 29 Apr
 2024 18:16:51 +0800
Received: from linuxcarl2.richtek.com (192.168.10.154) by ex3.rt.l
 (192.168.10.45) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 29 Apr 2024 18:16:51 +0800
From: Alina Yu <alina_yu@richtek.com>
To: <lgirdwood@gmail.com>, <broonie@kernel.org>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<alina_yu@richtek.com>, <johnny_lai@richtek.com>, <cy_huang@richtek.com>
Subject: [PATCH 0/2] Fix rtq2208 buck ramp_delay and ldo discharge and dvs setting
Date: Mon, 29 Apr 2024 18:16:45 +0800
Message-ID: <1714385807-22393-1-git-send-email-alina_yu@richtek.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi,

This series patches is for hardware modification of RTQ2208.
ramp_delay range of bucks is changed.
The maximum ramp up and down range is shorten from 64mVstep/us tor 16mVstep/us/.
The LDO's Vout is adjustable if the haardware setting allow it, and it can be set either 1800mv or 3300mv.
Additionally, the discharge register is chaned to other position.
The discharge register has been moved to another position.
In this version, a software bug has been fixed. rtq2208_ldo_match is no longer a local variable,
which prevents invalid memory access when devm_of_regulator_put_matches is called.

Thank you,
Alina
---
Alina Yu (2):
  regulator: dt-bindings: rtq2208: Add Richtek RTQ2208 SubPMIC
  regulator: rtq2208: Add Richtek RTQ2208 SubPMIC driver

 .../bindings/regulator/richtek,rtq2208.yaml        |  10 ++
 drivers/regulator/rtq2208-regulator.c              | 169 +++++++++++++--------
 2 files changed, 119 insertions(+), 60 deletions(-)

-- 
2.7.4


