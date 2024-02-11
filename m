Return-Path: <linux-kernel+bounces-60953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B099850B87
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 21:52:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E0861C21FF7
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 20:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85F665F47C;
	Sun, 11 Feb 2024 20:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b="Zp81RZnK"
Received: from vps.xff.cz (vps.xff.cz [195.181.215.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A1FD5D8E4;
	Sun, 11 Feb 2024 20:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.181.215.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707684743; cv=none; b=TDpGPjJINvoPvidjB3UFB8gTNV4PtlLP/Aq71t58SzhBUCfkUpru41Ok7qIEz9DI5l03nX0KVq6quBdRvZF3yp8sNrrDAy7+Y+Xul/b7AxbVsGKOlvNRfKHFTwdIwRNQZoy40EaILkVzQZLfGq21X7C4hQICVUhQ+RD/04xkvY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707684743; c=relaxed/simple;
	bh=isG0zDsvzsHQP9xgeeXZnasvBjiHGHeSlbDgptfOIG4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=g0zcPFj+TPxbnZmCmf7X3T4zhbib05bfXCAM8l5I+mvpBQeZMKbMyuOSvJZIHPt60uf5WBTQCTiD0vsmFDPP897dSxx9AhlbKK7oKjsw7DTN+M4EpKMX9qBSGmWLjyS0mwmNA1zmADnkJ+C7c6Oz2kdcYDBlfk8kqN97ee+7oh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz; spf=pass smtp.mailfrom=xff.cz; dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b=Zp81RZnK; arc=none smtp.client-ip=195.181.215.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xff.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xff.cz; s=mail;
	t=1707684738; bh=isG0zDsvzsHQP9xgeeXZnasvBjiHGHeSlbDgptfOIG4=;
	h=From:To:Cc:Subject:Date:From;
	b=Zp81RZnKYt2nKsOUzJECm/D0aCh7Ht9xg+E8ZPmSrjlfUvLZJV3nC9OifCRvHYLWH
	 5JgXVk0edVVZ1lGXQXiUM5TDyG6bjJKQ+M97Kd2twa8moKnWKYVjJop4wuvENhui4J
	 2KW+r/O6Shn5Chsmi5dQlQm6EE7HmHR79gXPWYV0=
From: =?UTF-8?q?Ond=C5=99ej=20Jirman?= <megi@xff.cz>
To: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrey Skvortsov <andrej.skvortzov@gmail.com>
Cc: Ondrej Jirman <megi@xff.cz>,
	Icenowy Zheng <icenowy@aosc.io>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] Add support for AF8133J magnetometer
Date: Sun, 11 Feb 2024 21:51:56 +0100
Message-ID: <20240211205211.2890931-1-megi@xff.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Ondrej Jirman <megi@xff.cz>

This series adds support for AF8133J magnetometer sensor. It's a simple
3-axis sensor with two sensitivity options and not much else to it.

This sensor is used on both Pinephone and Pinephone Pro. DT patches
adding it will come later, once this driver is merged.

Please take a look. :)

Thank you very much,
	Ondřej Jirman

Icenowy Zheng (3):
  dt-bindings: vendor-prefix: Add prefix for Voltafield
  dt-bindings: iio: magnetometer: Add DT binding for Voltafield AF8133J
  iio: magnetometer: add a driver for Voltafield AF8133J magnetometer

Ondrej Jirman (1):
  MAINTAINERS: Add an entry for AF8133J driver

 .../iio/magnetometer/voltafield,af8133j.yaml  |  58 ++
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 MAINTAINERS                                   |   6 +
 drivers/iio/magnetometer/Kconfig              |  12 +
 drivers/iio/magnetometer/Makefile             |   1 +
 drivers/iio/magnetometer/af8133j.c            | 525 ++++++++++++++++++
 6 files changed, 604 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/magnetometer/voltafield,af8133j.yaml
 create mode 100644 drivers/iio/magnetometer/af8133j.c

-- 
2.43.0


