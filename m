Return-Path: <linux-kernel+bounces-23613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56BBA82AF20
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 14:05:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B5551C2128A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 13:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3707C16431;
	Thu, 11 Jan 2024 13:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="J3Q3q05Y"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C4916427;
	Thu, 11 Jan 2024 13:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1704978264;
	bh=ooZvmBo1ViU5Ji4xyGAIUWPoVDHwEIYn3pOqQSNGq4M=;
	h=From:To:Cc:Subject:Date:From;
	b=J3Q3q05YRNunbSoVpob8ozuBPFjZ79aU52V6GY2mi7B1dPGhghLMQEmGiqqysr0xs
	 MUEq67zQpKvKTR/QfooEzHNaPkDmJlD4/E7McujY20tboFJCs2CtvT4dM8C3IhIWFf
	 AcOGb/8OpX2qE5Q0cbTaU/VYR4BSx78hKNGtn9TuE10HgczK4AkvJMOR/dxXqOJx0j
	 Swax238DLsSAWHoPp3UamWXnhx4HSwKE9/rCoqj10Uh0jylK8Q5XlbFXlwrzKD/O7u
	 HHcQ/gWyM1VIzixbkQyGPvQJu0auqquQ58YG7QJA0ZHV0uEj3Pyss5cpT054RHyoVx
	 HUDE5kCIsL4nA==
Received: from stla-brain-8255-1.home (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jmassot)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 5AC543781FCD;
	Thu, 11 Jan 2024 13:04:23 +0000 (UTC)
From: Julien Massot <julien.massot@collabora.com>
To: linux-media@vger.kernel.org
Cc: kernel@collabora.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mchehab@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	Julien Massot <julien.massot@collabora.com>
Subject: [PATCH v3 0/4] Add support for MAX96714F and MAX96717F GMSL2 ser/des
Date: Thu, 11 Jan 2024 14:03:45 +0100
Message-ID: <20240111130349.2776699-1-julien.massot@collabora.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
  dt-bindings: media: add Maxim MAX96717F GMSL2 Serializer
  dt-bindings: media: add Maxim MAX96714F GMSL2 Deserializer
  media: i2c: add MAX96717 driver
  media: i2c: add MAX96714 driver

 .../bindings/media/i2c/maxim,max96714f.yaml   |  171 +++
 .../bindings/media/i2c/maxim,max96717f.yaml   |  147 +++
 MAINTAINERS                                   |   14 +
 drivers/media/i2c/Kconfig                     |   26 +
 drivers/media/i2c/Makefile                    |    2 +
 drivers/media/i2c/max96714.c                  | 1077 +++++++++++++++++
 drivers/media/i2c/max96717.c                  |  956 +++++++++++++++
 7 files changed, 2393 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/i2c/maxim,max96714f.yaml
 create mode 100644 Documentation/devicetree/bindings/media/i2c/maxim,max96717f.yaml
 create mode 100644 drivers/media/i2c/max96714.c
 create mode 100644 drivers/media/i2c/max96717.c

-- 
2.43.0


