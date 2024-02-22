Return-Path: <linux-kernel+bounces-75759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E59685EE89
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 02:14:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3FC52B22C0E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 01:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CB7D17564;
	Thu, 22 Feb 2024 01:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b="IR51U6C8"
Received: from vps.xff.cz (vps.xff.cz [195.181.215.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B30CF80C;
	Thu, 22 Feb 2024 01:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.181.215.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708564436; cv=none; b=NKiDIxijUNDgFZoSnCJi3/jA89IcGlg8IaR2cAcjF4CYe5BI1v1nB+pq0zLXwiUJVslV98rghyJEQX2q+mwdBQByt0L/42qjB8joneDMOlym5k0QkfnzQ03sotyLcisntPF7DqTShlfzk1r6PRb2jlUI6EOyr1Yx1dAYl6Th63c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708564436; c=relaxed/simple;
	bh=YvwPGE6Je1yh6m1wlcMDe3waw6z0rk4FE6NC0S7WrtI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gU+UbZV0V9xP04JMArqH+ACVfn+ge3X3yrj9fJkoWNHcEuPxaMrFDqutq6Eb6OVuPluowyZhF55b//CA6XZvCLPws67iLwabigtL+FMwAYYrF/QPyKXJ1Mtx3XUMq/OcLlYMtFW7s1xZhRpYX8/HfHB/h9XsXFuXtBjFtkzYDX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz; spf=pass smtp.mailfrom=xff.cz; dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b=IR51U6C8; arc=none smtp.client-ip=195.181.215.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xff.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xff.cz; s=mail;
	t=1708564424; bh=YvwPGE6Je1yh6m1wlcMDe3waw6z0rk4FE6NC0S7WrtI=;
	h=From:To:Cc:Subject:Date:From;
	b=IR51U6C8FowjMKn6pODgTAZeYUwQ5y3+6aiQwNmO+2+6cQSvaB91QuV+fZtUtMeFC
	 XmpHIu7kbs4b9PzJbcahzmZ08UR5S5FIq8iW9fViRG7acsKD8u0/u/j+/I5kP1UXOr
	 Tu5flioRygnxaBzaGu8SFcUqTYWYYBnseahxJOWI=
From: =?UTF-8?q?Ond=C5=99ej=20Jirman?= <megi@xff.cz>
To: linux-kernel@vger.kernel.org,
	Jonathan Cameron <jic23@kernel.org>,
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
	devicetree@vger.kernel.org
Subject: [PATCH v4 0/4] Add support for AF8133J magnetometer
Date: Thu, 22 Feb 2024 02:13:34 +0100
Message-ID: <20240222011341.3232645-1-megi@xff.cz>
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

v4:
- move RPM enable in probe function before iio device registration

v3:
- collect more tags
- if (ret < 0) -> (ret) where appropriate
- scoped guard move to af8133j_set_scale()
- remove pm_runtime_disable/enable guard from af8133j_power_down_action()
- pretty much just this:
  https://megous.com/dl/tmp/0001-if-ret-0-ret-where-appropriate.patch
  https://megous.com/dl/tmp/0002-scoped-guard-move-to-af8133j_set_scale.patch
  https://megous.com/dl/tmp/0003-remove-pm_runtime_disable-enable-guard-from-af8133j_.patch

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
 drivers/iio/magnetometer/af8133j.c            | 524 ++++++++++++++++++
 6 files changed, 605 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/magnetometer/voltafield,af8133j.yaml
 create mode 100644 drivers/iio/magnetometer/af8133j.c

-- 
2.43.0


