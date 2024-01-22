Return-Path: <linux-kernel+bounces-32835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E1D378360B4
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 12:12:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9991C28948C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 11:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FA2D3FE39;
	Mon, 22 Jan 2024 11:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="BLOL7btb"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF91D3FB22;
	Mon, 22 Jan 2024 11:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705921493; cv=none; b=iQxAnw4TeKVcGBQYdxr8AHNY/yMXGQS7pZ7/DwVV2Km/+G6eNRX/ejYb9naBdiQUR1IjetRNdp5feD5GV6K8EegrDSj6QAaAeif5XGdHTR2029meyr0VIuDDTRhrBLAYwu8WuyFN/x7wdkKSkz3yagzty13faCNpu+hNNQYmANc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705921493; c=relaxed/simple;
	bh=3m1/vci+MfAYp79wBH/oi/rLtZ2m4Wx+8gZRTD02VwU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=go3fkzBGr0UDMX2MS1cMFHIwTGeoHAkTQkRkWA1mmNt3jeTJQ7N8234C8pX1PAqbvmYdVgohCrpDT/R5l/HVYBtMHtP5siJQOAmrc1O5SEsvRQ6vT7CDJJDLavWvujVWKYEglgKOBiouDpcmZNuo6neZ2eERjTwIinw0JZgV5qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=BLOL7btb; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1705921490;
	bh=3m1/vci+MfAYp79wBH/oi/rLtZ2m4Wx+8gZRTD02VwU=;
	h=From:To:Cc:Subject:Date:From;
	b=BLOL7btbWcb/npidSycVbvPsflgnOgK9uWB48Y6VSDYYZuxsD6uHl0R2DPQBFVDdf
	 wFpzEAPNWNuM+UXqTI0G0wa44q+O0Vlqd9yWaesfZptiXt+K14XraK4lil0EgSVWx1
	 TYn9Y+/esgW77UNAulq0LYWxlrpCsQPiD9AxRisEujW/C60KL85jk56iDSEkYfGjQ9
	 fzRb6e8lG52sLj99V2FWf/gRKwg9LnUC938Vqc1FI2e+QZ7ZjWG0z5bge9VUgxO7+f
	 ggQlEQ501mBDzhuKS6lmstDuWZ5Povlp4AWr4dQP7KXf/gi0/qE9LS8vykleoH0vNf
	 ojzEm3cw3vt1Q==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id F1FAB3781FDF;
	Mon, 22 Jan 2024 11:04:48 +0000 (UTC)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: gregkh@linuxfoundation.org
Cc: robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	heikki.krogerus@linux.intel.com,
	matthias.bgg@gmail.com,
	dmitry.baryshkov@linaro.org,
	neil.armstrong@linaro.org,
	andersson@kernel.org,
	nathan@kernel.org,
	luca.weiss@fairphone.com,
	tianping.fang@mediatek.com,
	linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	kernel@collabora.com,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Subject: [PATCH v3 0/2] Add ITE IT5205 Passive MUX
Date: Mon, 22 Jan 2024 12:04:44 +0100
Message-ID: <20240122110446.140226-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds a driver for the ITE IT5205/FN, found on various
MediaTek board designs, including the MT8395Genio 1200 EVB and
others following that.

Changes in v3:
 - Fixed MODULE_DEVICE_TABLE for it5205_of_table

Changes in v2:
 - Reordered headers and removed unused ones
 - Added a check for altmode in it5205_mux_set()

AngeloGioacchino Del Regno (2):
  dt-bindings: usb: Introduce ITE IT5205 Alt. Mode Passive MUX
  usb: typec: mux: Add ITE IT5205 Alternate Mode Passive MUX driver

 .../devicetree/bindings/usb/ite,it5205.yaml   |  72 +++++
 drivers/usb/typec/mux/Kconfig                 |  10 +
 drivers/usb/typec/mux/Makefile                |   1 +
 drivers/usb/typec/mux/it5205.c                | 294 ++++++++++++++++++
 4 files changed, 377 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/ite,it5205.yaml
 create mode 100644 drivers/usb/typec/mux/it5205.c

-- 
2.43.0


