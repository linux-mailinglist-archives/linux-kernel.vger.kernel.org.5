Return-Path: <linux-kernel+bounces-74932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 202B885E02D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 15:46:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 622FB2868BB
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 14:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7D197FBBD;
	Wed, 21 Feb 2024 14:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lexina.in header.i=@lexina.in header.b="U1ME9svf"
Received: from mx.msync.work (mx.msync.work [62.182.159.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C7881FDB
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 14:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.182.159.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708526780; cv=none; b=mdv6EFob4nK9/MnQ3lcxptcQHRxYH3CD9FbIdAUrb6mW45UkXYnpVWosn4QZWWpDzuri4Z74F+w9xGJvNKDN9e745n7oVDSfwWxgj0WJE2yb1zGN65WIjEF8LAdUCJDcaB6RE1+uynzzyreOlrpaH1i3rgoV6hoI62pJzyA1+d8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708526780; c=relaxed/simple;
	bh=N7PhYA47Cw1XbQo5+JYiIgr/qRAM4AbMyCyWIpFITFc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=EvW1UyHw/rvWSP5dMvLkSJWwMnVQH7+fgvmo9OQUynZSW99V4k2eXqcTVltYuiDl9bEEBvKcH+tf4n9n7oFuhG03gXfMick2ebKP1B17D8I6iR+JJil32u/0ttHl5o2jR8wwwbmy2DNCZAGCrtdUNSoJPVfrlQFoMl5UgJd+drU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=lexina.in; spf=pass smtp.mailfrom=lexina.in; dkim=pass (2048-bit key) header.d=lexina.in header.i=@lexina.in header.b=U1ME9svf; arc=none smtp.client-ip=62.182.159.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=lexina.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lexina.in
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2D99610D6EE;
	Wed, 21 Feb 2024 14:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lexina.in; s=dkim;
	t=1708526221; h=from:subject:date:message-id:to:mime-version:
	 content-transfer-encoding; bh=xOI+di+u1t+xx84e/LdGPQbr3Lc5cpKuos/uIxbddAE=;
	b=U1ME9svf2hGDxCabb2U4g5IaHVT6xZEAd9N2zQz2yGXyLPyiPt4W7sR5N1BZo7M+vG7yQd
	+uAB6fCO06MloQI2Ag0mc2opsItrt2b6ojehwTLTywvsQzZIHFiMH9bh7SVepliq92608+
	Je29QX+q+f4tx82ykpAQi0f1vHOVyZGLFaClzOfGDB7zTVCb+Kq446KFJ5aBnfd2w78zwQ
	pOqgMSP2yTl/m8WUjk9lMmwpt68Rl3Wy4QoEnrX4Ug4PvZb2mBBm9o4ojbIuUzS7SuEUyp
	ImliwEcc89OourAMELt9AqRkRkpK8ZVkMzUHzEtLYsI9FPqFOHPGYjQyKHvVnw==
From: Viacheslav Bocharov <adeep@lexina.in>
To: Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org
Subject: [PATCH v2 0/3] soc: amlogic: add new meson-gx-socinfo-sm driver
Date: Wed, 21 Feb 2024 17:36:13 +0300
Message-ID: <20240221143654.544444-1-adeep@lexina.in>
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

This is the third attempt to publish data from the Amlogic secure monitor
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

Changes V1 -> V2 [1]:
 - create cpu_id structure for socinfo variable
 - create meson_sm_chip_id for result of sm call
 - remove shared functions
 - move from funcs for bit operations to C bit fields

Links:
 - [1] https://lore.kernel.org/linux-arm-kernel/202311242104.RjBPI3uI-lkp@intel.com/T/


Viacheslav Bocharov (3):
  soc: amlogic: meson-gx-socinfo: move common code to header file
  soc: amlogic: meson-gx-socinfo-sm: Add Amlogic secure-monitor SoC
    Information driver
  soc: amlogic: meson-gx-socinfo: add new definition for Amlogic A113X
    package

 drivers/soc/amlogic/Kconfig                   |  10 +
 drivers/soc/amlogic/Makefile                  |   1 +
 .../soc/amlogic/meson-gx-socinfo-internal.h   | 121 +++++++++++
 drivers/soc/amlogic/meson-gx-socinfo-sm.c     | 192 ++++++++++++++++++
 drivers/soc/amlogic/meson-gx-socinfo.c        | 136 ++-----------
 5 files changed, 338 insertions(+), 122 deletions(-)
 create mode 100644 drivers/soc/amlogic/meson-gx-socinfo-internal.h
 create mode 100644 drivers/soc/amlogic/meson-gx-socinfo-sm.c


base-commit: 9fc1ccccfd8d53dc7936fe6d633f2373fc9f62e8
-- 
2.43.2


