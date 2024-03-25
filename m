Return-Path: <linux-kernel+bounces-117118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7B2B88A78A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:49:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76A90300C6F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F92416F8F9;
	Mon, 25 Mar 2024 13:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="CTXE0lYy"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0408C16D9A4;
	Mon, 25 Mar 2024 13:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711372671; cv=none; b=FgL9h1HX4aLI81pC9CTVR0VyjFVRve6+X2+rHJipI0zUt/Ulg1SFg+OnBcm0qRNQUlFHmBmMYyGuCaMg80j4wWnrubReLLPeea+LzDkgLYROTsuctU8zn+zCaV/KfOfY1th4tE/yW58z9zhG3P3Woy5EdX5vuHAq5mCv/WPTAXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711372671; c=relaxed/simple;
	bh=RhY8vSqKFCQ7SAm7bkA5ND4805DdUJ4P3j6nQoHhIY0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e/eFyB6QBhVkTwdCq+K0aktJBm8m9Xnz8VXSsS+0pSbo9rrjOpOr732SHRJ33FLKReyjAR0xWBlIWvoIVx+QlgYt09v/4cY9kkjZkBsLWjmZGfJ98ztF2e6NnddFr2JMxhbopWGlJHTCYwtkvuuwXdN2FeYgqYBkecmBU29+udA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=CTXE0lYy; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1711372668;
	bh=RhY8vSqKFCQ7SAm7bkA5ND4805DdUJ4P3j6nQoHhIY0=;
	h=From:To:Cc:Subject:Date:From;
	b=CTXE0lYy2JKszz2AAH2fGivYfackwCKkg3RO5tF7d9a2homsXDshVtg2TLadIByQ1
	 tinh9egd63adBDQitRbcQPQ+0xlB+wmat2cdZ4pDgu9byuRuPJO9vRV+e3zs+qZw4/
	 XbDo39RJWKDnMhTjXcku4uhPQcIuWyFVqSzOOUOA+MaSkz8emPfrn61+YvTYZWWb6E
	 b8QcoxP5wpusppbqGFxNqCX2BydLscOFCA3YMPAZLHPuFNGECtOIUXAPZ1lzEmHSXt
	 e4stn4lYjdW7Y6MtDNgKkxqhUd2HMWpVpNrg1fWjiOEv+TABxJ4pLBKMmGNhCGU/6I
	 5SOzpFAd+IizA==
Received: from stla-brain-8255-1.home (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jmassot)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 8E7E7378148F;
	Mon, 25 Mar 2024 13:17:47 +0000 (UTC)
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
Subject: [PATCH v6 0/4] Add support for MAX96714/F and MAX96717/F GMSL2 ser/des
Date: Mon, 25 Mar 2024 14:16:30 +0100
Message-ID: <20240325131634.165361-1-julien.massot@collabora.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change since v5:
 - Reverse fallback logic: max9671{4,7} can fallback to max9671{4,7}F
 - use const instead of enum for max9671{4,7}f compatible as suggested

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

 .../bindings/media/i2c/maxim,max96714.yaml    |  175 +++
 .../bindings/media/i2c/maxim,max96717.yaml    |  164 +++
 MAINTAINERS                                   |   14 +
 drivers/media/i2c/Kconfig                     |   28 +
 drivers/media/i2c/Makefile                    |    2 +
 drivers/media/i2c/max96714.c                  | 1029 +++++++++++++++++
 drivers/media/i2c/max96717.c                  |  934 +++++++++++++++
 7 files changed, 2346 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/i2c/maxim,max96714.yaml
 create mode 100644 Documentation/devicetree/bindings/media/i2c/maxim,max96717.yaml
 create mode 100644 drivers/media/i2c/max96714.c
 create mode 100644 drivers/media/i2c/max96717.c

-- 
2.44.0


