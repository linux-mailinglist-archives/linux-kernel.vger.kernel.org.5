Return-Path: <linux-kernel+bounces-102915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 121DC87B852
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 08:11:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40DB01C21107
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 07:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC23E10940;
	Thu, 14 Mar 2024 07:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lexina.in header.i=@lexina.in header.b="EDV4Yyt0"
Received: from mx.msync.work (mx.msync.work [62.182.159.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C75FBF7
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 07:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.182.159.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710400259; cv=none; b=FqZgjhGkK6BglE7fIgwjCQfX7AlcEf9BrbzuXpeDEZNUlc4s/nh/RxuoYhmL43hRZKx0F+zIeRp/ltp1c9KVtRqvvNrC8xk8Tv8l2DQbFe+l585IxuswOdi6IL5Azn3M9B/ulltqFYZwwBVrMuXqh7T4QSR86885mSBJd/oOJYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710400259; c=relaxed/simple;
	bh=J5fy2QNYqbmy1GDrr9KCAuYk5FFXqkKZa/AcUOAuZ54=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I4fXFtAhR9cZmoX2Ti+0coQwKrIz/2x20WrWZVvX3DYIv120kohtPK6AmMk8X6e/4FT/HLay0kUZUeigOoJxM4pmRQqsWB2SI0mcmtDncW+Jj8PIzDCHNa3EXCjnorZowpoBh5ucyQvT4PPZqZ3KslDptYSIlQEke1JmGzAATTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=lexina.in; spf=pass smtp.mailfrom=lexina.in; dkim=pass (2048-bit key) header.d=lexina.in header.i=@lexina.in header.b=EDV4Yyt0; arc=none smtp.client-ip=62.182.159.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=lexina.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lexina.in
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3201411E7BD;
	Thu, 14 Mar 2024 07:04:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lexina.in; s=dkim;
	t=1710399885; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=oxxuQS6Ry6UcPPQ8PM8osrRnE4TBooDMROhtJ6NbQOc=;
	b=EDV4Yyt0/0NKKea2i69S38pCAK/svEvZUSezcqBBkThP4Dk+YAx73fKk6J7oDmKBwboT18
	vLwO3Z/Ckz7u9aerEg17kr7XzNqyi5RSzRZ90iVqnNRfXDdB8vO9xW6lcXy6g04Wa4J8gH
	IP2MbTzSo6jpsmqO45LR8xqXnTjZ+gy6yH3lKLl0T6UIPcci7ggscdBkaAO/wQH8Pmsr+T
	jnduqP4BaID7TvpEzTtQsLpgefhNHaLs0+yaRxBQUGQ081T+W8r0I0gnEdQ2x8GHGH48cU
	qm7xbusyDJU0GnzGena0y1YErxHT+MB1Azm/AKfg7uOXlOj9ima11mcCoPoiKQ==
From: Viacheslav Bocharov <adeep@lexina.in>
To: Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org
Cc: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: [PATCH v3 0/4] soc: amlogic: add new meson-gx-socinfo-sm driver
Date: Thu, 14 Mar 2024 09:59:50 +0300
Message-ID: <20240314070433.4151931-1-adeep@lexina.in>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

The Amlogic Meson SoC Secure Monitor implements a call to retrieve an
unique SoC ID starting from the GX Family and all new families.
But GX-family chips (e.g. GXB, GXL and newer) supports also 128-bit
chip ID. 128-bit chip ID consists 32-bit SoC version and 96-bit OTP data.

This is next attempt to publish data from the Amlogic secure monitor
chipid call. After discussions with Neil Armstrong, it was decided to
publish the chipid call results through the soc driver. Since
soc_device_match cannot wait for the soc driver to load, and the secure
monitor calls in turn depend on the sm driver, it was necessary to create
a new driver rather than expand an existing one.

In the patches, in addition to writing the driver:
- convert commonly used structures and functions of the meson-gx-socinfo
driver to a header file.
- add secure-monitor references for amlogic,meson-gx-ao-secure sections
in dts files of the a1, axg, g12, gx families.


---

Changes 
 v2 [1] -> v3:
 - rebase
 - update dependency in Kconfig for MESON_GX_SOCINFO_SM
 - add links to secure-monitor in soc driver sections for A1, AXG, GX, G12

 v1 [2] -> v2:
 - create cpu_id structure for socinfo variable
 - create meson_sm_chip_id for result of sm call
 - remove shared functions
 - move from funcs for bit operations to C bit fields

Links:
 - [1] https://lore.kernel.org/linux-arm-kernel/20240221143654.544444-1-adeep@lexina.in/
 - [2] https://lore.kernel.org/linux-arm-kernel/202311242104.RjBPI3uI-lkp@intel.com/T/


Viacheslav Bocharov (4):
  soc: amlogic: meson-gx-socinfo: move common code to header file
  soc: amlogic: meson-gx-socinfo-sm: Add Amlogic secure-monitor SoC
    Information driver
  soc: amlogic: meson-gx-socinfo: add new definition for Amlogic A113X
    package
  arm64: dts: meson: add dts links to secure-monitor for soc driver in
    a1, axg, gx, g12

 arch/arm64/boot/dts/amlogic/meson-a1.dtsi     |   1 +
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi    |   1 +
 .../boot/dts/amlogic/meson-g12-common.dtsi    |   1 +
 arch/arm64/boot/dts/amlogic/meson-gx.dtsi     |   1 +
 drivers/soc/amlogic/Kconfig                   |  10 +
 drivers/soc/amlogic/Makefile                  |   1 +
 .../soc/amlogic/meson-gx-socinfo-internal.h   | 121 +++++++++++
 drivers/soc/amlogic/meson-gx-socinfo-sm.c     | 192 ++++++++++++++++++
 drivers/soc/amlogic/meson-gx-socinfo.c        | 136 ++-----------
 9 files changed, 342 insertions(+), 122 deletions(-)
 create mode 100644 drivers/soc/amlogic/meson-gx-socinfo-internal.h
 create mode 100644 drivers/soc/amlogic/meson-gx-socinfo-sm.c


base-commit: 480e035fc4c714fb5536e64ab9db04fedc89e910
-- 
2.43.2


