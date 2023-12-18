Return-Path: <linux-kernel+bounces-4071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 47CE981779A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 17:36:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 976AA28487C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 16:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60B694FF68;
	Mon, 18 Dec 2023 16:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="DzzdW9LL"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 615621E4AF
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 16:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 202312181636019cdf06096e87681a22
        for <linux-kernel@vger.kernel.org>;
        Mon, 18 Dec 2023 17:36:02 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=x6qk6zT/CTlRgy3SDoZ+suoxZRsQbJDeWsc3atREbyc=;
 b=DzzdW9LLPgzabt/SORLQGq6hobexSTZK59g69WS5+vD2hjVxnM6jzEUQHawZeFrx3LRixM
 8ISVkIYLmT3aRAh0vj7jrvp8zIGG9+o2tJd86b/9ESQmDuQdR4RZ3qnEbx6O2kCehelsl3sS
 jA0Rnyc8W3LBRb3KIQeJk325YLGfM=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Bao Cheng Su <baocheng.su@siemens.com>
Subject: [PATCH 0/4] arm64: dts: iot2050: Add support for new SM variant
Date: Mon, 18 Dec 2023 17:35:56 +0100
Message-Id: <cover.1702917360.git.jan.kiszka@siemens.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer

This bring support for yet another IOT2050 device variant, see last
patch for details. The rest is binding and refactoring to make that
happen.

Jan

Baocheng Su (2):
  arm64: dts: ti: iot2050: Disable R5 lockstep for all PG2 boards
  dts: iot2050: Support IOT2050-SM variant

Jan Kiszka (1):
  arm64: dts: ti: iot2050: Factor out arduino connector bits

Su Bao Cheng (1):
  dt-bindings: arm: ti: Add binding for Siemens IOT2050 SM variant

 .../devicetree/bindings/arm/ti/k3.yaml        |   1 +
 arch/arm64/boot/dts/ti/Makefile               |   1 +
 .../ti/k3-am65-iot2050-arduino-connector.dtsi | 768 ++++++++++++++++++
 .../dts/ti/k3-am65-iot2050-common-pg2.dtsi    |   7 +-
 .../boot/dts/ti/k3-am65-iot2050-common.dtsi   | 753 -----------------
 .../ti/k3-am6528-iot2050-basic-common.dtsi    |   6 +-
 .../boot/dts/ti/k3-am6528-iot2050-basic.dts   |   5 +
 .../dts/ti/k3-am6548-iot2050-advanced-m2.dts  |   6 +-
 .../dts/ti/k3-am6548-iot2050-advanced-pg2.dts |   8 +-
 .../dts/ti/k3-am6548-iot2050-advanced-sm.dts  | 210 +++++
 .../dts/ti/k3-am6548-iot2050-advanced.dts     |   1 +
 11 files changed, 996 insertions(+), 770 deletions(-)
 create mode 100644 arch/arm64/boot/dts/ti/k3-am65-iot2050-arduino-connector.dtsi
 create mode 100644 arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-sm.dts

-- 
2.35.3


