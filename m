Return-Path: <linux-kernel+bounces-122122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 798DA88F220
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 23:53:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 087BDB24181
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 22:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A514153BF7;
	Wed, 27 Mar 2024 22:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="caTsXPow"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04F30153BEF;
	Wed, 27 Mar 2024 22:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711579989; cv=none; b=MHa87l6ggZAN2xHDP7zmdk/yiGbpJqIUuwYmN4CasIo2nWtF0tC54vCt3kUH8Cw1soZTTanmucJr0EDo90gXrhDHaLfkolmi4tuMY0K0vZHbuV4k1IH61VDitLqhfXBWl525i5YPzgDSojXR7tTgzhciDHwieITUqpzTWC1c+ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711579989; c=relaxed/simple;
	bh=sqhN02+ZEO+ko6LtC5zADXfc7A3LE/qm9zqb38Oaq8A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KCUsicCnHZnEBP7ZNrS525JsHSg+F4RW73x70tLvETcEIzA2DDLmqk0+8plbu1ZDnA4vJsHMmHVDcPFey2P3JwQVmZrjZavotXlNXbdfo9nEDYpyXBB7iVp3n22RqDDL1bo2qJ7H14moCwJi/PqZcUk1phvDVPcsVypQTpZYRNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=caTsXPow; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1711579986;
	bh=sqhN02+ZEO+ko6LtC5zADXfc7A3LE/qm9zqb38Oaq8A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=caTsXPowXDRb4G9GIbmJvN/vTrUemSmke8KD9L2ybhniat5DqxfWRaB9xxS8PMsWF
	 9CHi3Njx7ES35Vz8Y168f5r13bkzbMQaGt7IMq+4gpCbA4o+RAgFce9ClMJ9v+LZl7
	 yXPHmQDfJ49Pxye2SubKl4jKeuOc1ZaHaEFB9viDGuNhAI4wPefPENjO/ZAOrnq90u
	 6DofX0sKa7feG7JhNW3oJHv6RpGExf65bKu9NEsd5Z4KkQosaq5ZNhwTmOLKcx/KtF
	 N2j9LPLECVUZK7xjEpq/QASY1Yv0JAx6HaGMyfjY+KB3Syrq2qMk3H8JA6kapuVNzm
	 A51xkdbtiR7Pg==
Received: from shreeya.shreeya (ec2-34-240-57-77.eu-west-1.compute.amazonaws.com [34.240.57.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: shreeya)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id BCE6B3782115;
	Wed, 27 Mar 2024 22:52:57 +0000 (UTC)
From: Shreeya Patel <shreeya.patel@collabora.com>
To: heiko@sntech.de,
	mchehab@kernel.org,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	p.zabel@pengutronix.de,
	jose.abreu@synopsys.com,
	nelson.costa@synopsys.com,
	dmitry.osipenko@collabora.com,
	sebastian.reichel@collabora.com,
	shawn.wen@rock-chips.com,
	nicolas.dufresne@collabora.com,
	hverkuil@xs4all.nl,
	hverkuil-cisco@xs4all.nl
Cc: kernel@collabora.com,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-clk@vger.kernel.org,
	linux-arm@lists.infradead.org,
	Shreeya Patel <shreeya.patel@collabora.com>
Subject: [PATCH v3 6/6] MAINTAINERS: Add entry for Synopsys DesignWare HDMI RX Driver
Date: Thu, 28 Mar 2024 04:20:57 +0530
Message-Id: <20240327225057.672304-7-shreeya.patel@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240327225057.672304-1-shreeya.patel@collabora.com>
References: <20240327225057.672304-1-shreeya.patel@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add an entry for Synopsys DesignWare HDMI Receiver Controller
Driver.

Signed-off-by: Shreeya Patel <shreeya.patel@collabora.com>
---
Changes in v3 :-
  - No change

Changes in v2 :-
  - Add a patch for MAINTAINERS file changes

 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3a534e344737..05bbb58c2a41 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21492,6 +21492,14 @@ F:	drivers/net/pcs/pcs-xpcs.c
 F:	drivers/net/pcs/pcs-xpcs.h
 F:	include/linux/pcs/pcs-xpcs.h
 
+SYNOPSYS DESIGNWARE HDMI RX CONTROLLER DRIVER
+M:	Shreeya Patel <shreeya.patel@collabora.com
+L:	linux-media@vger.kernel.org
+L:	kernel@collabora.com
+S:	Maintained
+F:	Documentation/devicetree/bindings/media/snps,dw-hdmi-rx.yaml
+F:	drivers/media/platform/synopsys/hdmirx/*
+
 SYNOPSYS DESIGNWARE I2C DRIVER
 M:	Jarkko Nikula <jarkko.nikula@linux.intel.com>
 R:	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
-- 
2.39.2


