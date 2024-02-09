Return-Path: <linux-kernel+bounces-59074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5B4684F0D5
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 08:33:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 795381F2444F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 07:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 387DE657D0;
	Fri,  9 Feb 2024 07:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="OFk6vg/b"
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27C765BA4
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 07:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707464016; cv=none; b=E8ism8TRZ6XmjmrdYHkX2dj9PUGjYu5XY2Lms/XUMhEQKG2RhoQr1CgAURNjubPe06eJJHVjI05oFyBraLfjNNw+qHOMb1oTo8TmLxG/yk9NXfZ+SUN2OvrnGzPxzwSwIW7mBdmWETEYOflXl2/bzAR1Hl4d1KKSLwVFkow+7Go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707464016; c=relaxed/simple;
	bh=LZnhRecmWjEEyuhkw2UEePxVcIJYubz4dwo2XU9EvnQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hG79MIMtsyC+BR/AcPavpFGJXkOKtquE8Yqr8NSD7JzjDLcUFRIeFbgakWWPHsQpmQ9oZ18qzGAY4/z6Y/kI+9UnrJaHaMj6FQ9rDRxevJpnf1OejiNfCVbGc0h0babWXyLZRKvg3N95Y5wW4DChH5VlD/4N0e9fBUgk6ABiNY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b=OFk6vg/b; arc=none smtp.client-ip=185.136.64.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 20240209072322590697df6873cbd98b
        for <linux-kernel@vger.kernel.org>;
        Fri, 09 Feb 2024 08:23:22 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=swzmFknxPpbMNSXu2CcioHwcS14EtTfEqDfVF30rdzY=;
 b=OFk6vg/bc9luc1S2UXUwaNO/cADhXKSo5B6lqEzAtLKFtf/jR/FLOKmgrMc+GYxDBgurPu
 TMiIdq2BxZcBgX8pl9bY1MzByySMApC8ZH7IThjmjb5R9nFmP9+9GOZfrbaJ8OoZ2qv73+DJ
 UCBp9hxTDWEzsdnQUIfrvY/Z0UmDk=;
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
Subject: [PATCH v3 0/7] arm64: dts: iot2050: Add support for new SM variant
Date: Fri,  9 Feb 2024 08:23:14 +0100
Message-Id: <cover.1707463401.git.jan.kiszka@siemens.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer

Changes in v3:
 - rebased

Changes in v2:
 - LED improvements
 - factor out DP and USB3 dtsi files
 - fix subject of last patch

This bring support for yet another IOT2050 device variant, see last
patch for details. The rest is binding and refactoring to make that
happen. Plus, LED nodes are improved by adding function and color
properties.

Jan

Baocheng Su (2):
  arm64: dts: ti: iot2050: Disable R5 lockstep for all PG2 boards
  arm64: dts: ti: iot2050: Support IOT2050-SM variant

Jan Kiszka (4):
  arm64: dts: ti: iot2050: Factor out arduino connector bits
  arm64: dts: ti: iot2050: Factor out enabling of USB3 support
  arm64: dts: ti: iot2050: Factor out DP related bits
  arm64: dts: ti: iot2050: Annotate LED nodes

Su Bao Cheng (1):
  dt-bindings: arm: ti: Add binding for Siemens IOT2050 SM variant

 .../devicetree/bindings/arm/ti/k3.yaml        |   1 +
 arch/arm64/boot/dts/ti/Makefile               |   1 +
 .../ti/k3-am65-iot2050-arduino-connector.dtsi | 768 +++++++++++++++
 .../dts/ti/k3-am65-iot2050-common-pg1.dtsi    |   5 +-
 .../dts/ti/k3-am65-iot2050-common-pg2.dtsi    |  25 +-
 .../boot/dts/ti/k3-am65-iot2050-common.dtsi   | 871 +-----------------
 .../arm64/boot/dts/ti/k3-am65-iot2050-dp.dtsi |  98 ++
 .../boot/dts/ti/k3-am65-iot2050-usb3.dtsi     |  27 +
 .../ti/k3-am6528-iot2050-basic-common.dtsi    |   6 +-
 .../dts/ti/k3-am6528-iot2050-basic-pg2.dts    |   2 +
 .../boot/dts/ti/k3-am6528-iot2050-basic.dts   |   5 +
 .../dts/ti/k3-am6548-iot2050-advanced-m2.dts  |  20 +-
 .../dts/ti/k3-am6548-iot2050-advanced-pg2.dts |  10 +-
 .../dts/ti/k3-am6548-iot2050-advanced-sm.dts  | 189 ++++
 .../dts/ti/k3-am6548-iot2050-advanced.dts     |   1 +
 15 files changed, 1132 insertions(+), 897 deletions(-)
 create mode 100644 arch/arm64/boot/dts/ti/k3-am65-iot2050-arduino-connector.dtsi
 create mode 100644 arch/arm64/boot/dts/ti/k3-am65-iot2050-dp.dtsi
 create mode 100644 arch/arm64/boot/dts/ti/k3-am65-iot2050-usb3.dtsi
 create mode 100644 arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-sm.dts

-- 
2.35.3


