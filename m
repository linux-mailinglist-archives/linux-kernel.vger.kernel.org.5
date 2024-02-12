Return-Path: <linux-kernel+bounces-62147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2749A851C63
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 19:02:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 49723B2840A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 17:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F80A4645B;
	Mon, 12 Feb 2024 17:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b="NJoErLLP"
Received: from vps.xff.cz (vps.xff.cz [195.181.215.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 009D145BEA;
	Mon, 12 Feb 2024 17:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.181.215.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707760458; cv=none; b=BAtXBsdzQ88bTg4tq68HIeMkHqXER4pKInBnPA+zmoXUDyiwRqQ86Wa01vr8xJc3gNbBqdNIScFdD0fSWUbUTy5f41wSa5imZxt5Pe+tBGyWZO7Lyp6MnU+0Q+ztwr/Zf2hOMiWuNWcn5uuOhM6iXWh05ckTSEDbBrr6sZm3OY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707760458; c=relaxed/simple;
	bh=0y+fzBytQrC7l3lSui9qg6RO2qKYmzTR6TqLVAK8yGM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=P3XEQrF2BLxZo3+mucEzxzByYx5wcgFiAPsXFAVlg7zCdMX7Y35H9/+M/ZczqDjWhdJuRDh/LOVi7q1sP7KIfy2s0tbngYsBRqaoG+4zTtsZmhe98On5QRbDs21jUa4Om46rgKk7wu3lNh0pKx5GF13nC8j1x4NzvsmIYb6j8FQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz; spf=pass smtp.mailfrom=xff.cz; dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b=NJoErLLP; arc=none smtp.client-ip=195.181.215.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xff.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xff.cz; s=mail;
	t=1707760453; bh=0y+fzBytQrC7l3lSui9qg6RO2qKYmzTR6TqLVAK8yGM=;
	h=From:To:Cc:Subject:Date:From;
	b=NJoErLLPR1sloP1pv+h8rZzmIOfSiuojTgJJk49DKwFfkxNnEkmn8r5F0wIWVaWPV
	 5GOcrYi6WyYnPCQVaaYasrGu/2Q2JjFnJqlMXvqqTHgsYbbZ61O3OPWzCkZbG6KWCa
	 sZGw7aDK7HCR+dsL/iYJhnLQVGwzPhgcVQFEAi90=
From: =?UTF-8?q?Ond=C5=99ej=20Jirman?= <megi@xff.cz>
To: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrey Skvortsov <andrej.skvortzov@gmail.com>
Cc: Ondrej Jirman <megi@xff.cz>,
	Icenowy Zheng <icenowy@aosc.io>,
	Dalton Durst <dalton@ubports.com>,
	Shoji Keita <awaittrot@shjk.jp>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/4] Add support for AF8133J magnetometer
Date: Mon, 12 Feb 2024 18:53:52 +0100
Message-ID: <20240212175410.3101973-1-megi@xff.cz>
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

v2:
- move maintainers patch to the end of series
- bindings:
  - fix compatible definition in bindings file
  - require power supplies
  - fix descriptions
- driver:
  - sort includes
  - rework RPM, the driver should now work with RPM disabled
    among other improvements
    - I've tested RPM left and right doing device bind/unbind under
      various conditions, system suspend under various conditions,
      etc.
  - use scoped_guard for mutexes
  - use devm for power down and handle power down correctly with both
    RPM enabled/disabled without tracking power state in data->powered
  - fix issue with changing scale while RPM suspended
  - various code formatting issues resolved
- as for sign-offs, I've added co-developed-by for people I know for
  sure worked on the driver, and left other tags as they were when
  I picked up the patch 2 years ago to my Linux branch

Icenowy Zheng (3):
  dt-bindings: vendor-prefix: Add prefix for Voltafield
  dt-bindings: iio: magnetometer: Add Voltafield AF8133J
  iio: magnetometer: add a driver for Voltafield AF8133J magnetometer

Ondrej Jirman (1):
  MAINTAINERS: Add an entry for AF8133J driver

 .../iio/magnetometer/voltafield,af8133j.yaml  |  60 ++
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 MAINTAINERS                                   |   6 +
 drivers/iio/magnetometer/Kconfig              |  12 +
 drivers/iio/magnetometer/Makefile             |   1 +
 drivers/iio/magnetometer/af8133j.c            | 528 ++++++++++++++++++
 6 files changed, 609 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/magnetometer/voltafield,af8133j.yaml
 create mode 100644 drivers/iio/magnetometer/af8133j.c

-- 
2.43.0


