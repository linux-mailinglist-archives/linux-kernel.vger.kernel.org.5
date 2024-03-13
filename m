Return-Path: <linux-kernel+bounces-101296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B235687A533
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 10:50:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 107E4B20F56
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 09:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FCDA24A1F;
	Wed, 13 Mar 2024 09:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="KVilyQ2Q"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C5922C689;
	Wed, 13 Mar 2024 09:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710323405; cv=none; b=lI5bXilsPed9ZGXJMrnIHRhZis7+C5/23e+03OobIqkOLs/JxYRrrFusHF6a79uogrRLCoON6P+qtiyjv2jGG+dyrg8/k5PTkudkQ1Vkz1rWN17t0hu4MgDsfTuOnWATSBg4WzL6v4Tnqd2o7Bj58BzwSqVSk4lPAo4Rp7fKPBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710323405; c=relaxed/simple;
	bh=fhWIqSz6O6JKDHOrZiy8mAOL3NpEmfUPAA2euiBhWqc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YHvWA/bCVxkc/OFzB9Qz+37ctSBerxNnzOzBAdXJXytZ1+wZgvTl7rn1Ea+29Y4+iSrAlOgHt5BOYMiRL9za9lyvVyGTMbADMcVpCzxRe7SnwNpRLBF/JQHJUYuzVDeVvIjRFibLFwiR+3RGtVBwAQPZvT6xH+LwkPhtYQXm8Ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=KVilyQ2Q; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1710323396;
	bh=fhWIqSz6O6JKDHOrZiy8mAOL3NpEmfUPAA2euiBhWqc=;
	h=From:To:Cc:Subject:Date:From;
	b=KVilyQ2QR/MgxSloYgIHZfjUO0r8ud9BP6W3C08RCGuszfMiQzbCZqqqP6EVoHUsu
	 DnuMKGC2v0Lci7gcXgNiVVYD3NOCSRbqaO2hbWZrMSN0NJlFJk2aJeMCO609if4Ut3
	 Q5BQp34laPc0N8KN9/VTIllulKkOzOISbVwZGlaWL0pMxpAuB5haqd8npdXQW43Cbw
	 LaTLJU1CPgX/jUwm3LUDBJiDIkY/sEDIQQ/W+u6sxlt6LkOxaOj80kKj+aAudTaX6Y
	 qSGTCL2RGHS/1FQ1YiknwXvV408R/XTikGvpAw7EJWdy0DAv7htOL4BIYtWW083ExV
	 UZIQu+8z87NLg==
Received: from stla-brain-8255-1.home (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jmassot)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id D71D137813C4;
	Wed, 13 Mar 2024 09:49:55 +0000 (UTC)
From: Julien Massot <julien.massot@collabora.com>
To: linux-media@vger.kernel.org
Cc: devicetree@vger.kernel.org,
	kernel@collabora.com,
	linux-kernel@vger.kernel.org,
	mchehab@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	sakari.ailus@iki.fi,
	Julien Massot <julien.massot@collabora.com>
Subject: [PATCH v5 0/4]  Add support for MAX96714/F and MAX96717/F GMSL2 ser/des
Date: Wed, 13 Mar 2024 10:49:18 +0100
Message-ID: <20240313094922.311743-1-julien.massot@collabora.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change since v4:
 - Add support for MAX96717 and MAX96714 and use them as a fallback for MAX96717F and MAX96714F respectively
 - The drivers are now compatible with MAX96717 and MAX96714 since no change in the logic is needed
 - Reference 'i2c-gate' instead of 'i2c-controller' in the bindings

Change since v3:
- bindings
  - Renamed bindings to drop the 'f' suffix
  - Add bus type to MAX96717 and remove from MAX9674
  - Add lane-polarities to both bindings

- drivers
  - Address changes requested by Sakari in v3
  - use v4l2_subdev_s_stream_helper for MAX96714
  - do not init regmap twice in the MAX96714 driver
  - Fix compilations on 32 bits platforms

Change since v2:
- Convert drivers to use CCI helpers
- Use generic node name
- Use 'powerdown' as gpio name instead of 'enable'
- Add pattern generator support for MAX96714

These patches add support for Maxim MAX96714F deserializer and
MAX96717F serializer.

MAX96714F has one GMSL2 input port and one CSI2 4 lanes output port,
MAX96717F has one CSI2 input port and one GMSL2 output port.

The drivers support the tunnel mode where all the
CSI2 traffic coming from an imager is replicated through the deserializer
output port.

Both MAX96714F and MAX96717F are limited to a 3Gbps forward link rate
leaving a maximum of 2.6Gbps for the video payload.


Julien Massot (4):
  dt-bindings: media: add Maxim MAX96717 GMSL2 Serializer
  dt-bindings: media: add Maxim MAX96714 GMSL2 Deserializer
  media: i2c: add MAX96717 driver
  media: i2c: add MAX96714 driver

 .../bindings/media/i2c/maxim,max96714.yaml    |  176 +++
 .../bindings/media/i2c/maxim,max96717.yaml    |  165 +++
 MAINTAINERS                                   |   14 +
 drivers/media/i2c/Kconfig                     |   28 +
 drivers/media/i2c/Makefile                    |    2 +
 drivers/media/i2c/max96714.c                  | 1029 +++++++++++++++++
 drivers/media/i2c/max96717.c                  |  934 +++++++++++++++
 7 files changed, 2348 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/i2c/maxim,max96714.yaml
 create mode 100644 Documentation/devicetree/bindings/media/i2c/maxim,max96717.yaml
 create mode 100644 drivers/media/i2c/max96714.c
 create mode 100644 drivers/media/i2c/max96717.c

-- 
2.44.0


