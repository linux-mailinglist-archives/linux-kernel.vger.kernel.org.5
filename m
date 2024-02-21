Return-Path: <linux-kernel+bounces-74549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EAB5385D5CF
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 11:40:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A53CE282C0A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 10:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A55D53771F;
	Wed, 21 Feb 2024 10:40:40 +0000 (UTC)
Received: from TWMBX01.aspeed.com (211-20-114-70.hinet-ip.hinet.net [211.20.114.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C5E442A;
	Wed, 21 Feb 2024 10:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708512040; cv=none; b=Li5nqS8jl4wv2F5JEg7KTShS7Wc91MUQkKkXpBYY2GbtHNe7BZHv3CV8l5j1dbKws00nYAoOqR8zQRMTE5qEupqrPjkli3eaFg87WSt020WiOdCvIa4rUG5VccOCe3Psd/Nj4OJXjeDyJNkD4lfUZrz33smc37NbBojjGU6qeF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708512040; c=relaxed/simple;
	bh=ZYQUxHkonFhaXRGYDsoLklvyyCireBnJY2HZQ4MAHEw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jmqB7mpLJ9fHOJLBbP599gtVaHC0sGwliMdeKy1qnQwFbtvMuQY1Lr8uRuu8kBPuYcD6M9Pj1wdfl4kuIK3yHEdW9tQ3Cl83U1zYvJ96s/Cr2sTNfaqvfQgA+tWkx93dgj4kVl1eCWRWn4Sc7gDH40qZuZPZbv3lfad5QSoavP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=aspeedtech.com; spf=fail smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=aspeedtech.com
Received: from TWMBX02.aspeed.com (192.168.0.24) by TWMBX01.aspeed.com
 (192.168.0.124) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Wed, 21 Feb
 2024 18:41:17 +0800
Received: from twmbx02.aspeed.com (192.168.10.10) by TWMBX02.aspeed.com
 (192.168.0.24) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 21 Feb 2024 18:40:27 +0800
From: Billy Tsai <billy_tsai@aspeedtech.com>
To: <jdelvare@suse.com>, <linux@roeck-us.net>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>, <joel@jms.id.au>,
	<andrew@codeconstruct.com.au>, <corbet@lwn.net>,
	<u.kleine-koenig@pengutronix.de>, <p.zabel@pengutronix.de>,
	<billy_tsai@aspeedtech.com>, <naresh.solanki@9elements.com>,
	<linux-hwmon@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-aspeed@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-pwm@vger.kernel.org>, <BMC-SW@aspeedtech.com>, <patrick@stwcx.xyz>
Subject: [PATCH v14 0/3] Support pwm/tach driver for aspeed ast26xx
Date: Wed, 21 Feb 2024 18:40:22 +0800
Message-ID: <20240221104025.1306227-1-billy_tsai@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Unlike the old design that the register setting of the TACH should based
on the configure of the PWM. In ast26xx, the dependency between pwm and
tach controller is eliminated and becomes a separate hardware block. One
is used to provide pwm output and another is used to monitor the frequency
of the input. This driver implements them by exposing two kernel
subsystems: PWM and HWMON. The PWM subsystem can be utilized alongside
existing drivers for controlling elements such as fans (pwm-fan.c),
beepers (pwm-beeper.c) and so on. Through the HWMON subsystem, the driver
provides sysfs interfaces for fan.

Changes since v13:
Restore Rob's "Reviewed-by" for fan-common.yaml.
Remove the compatible string in the dts example in aspeed,g6-pwm-tach.yaml.
Utilize devm_add_action_or_reset() to assert the reset.
Resolve the compiler error.

Changes since v12:
Merge the pwm-fan configure information into the fan node.
Add the of_platform_populate function to the driver to treat the child
node as a platform device.

Changes since v11:
Fix the compiler error of the driver.
The owner member has to be moved to struct pwm_chip.

Changes since v10:
Add the enum for the 'fan-driving-mode' properties in the fan-common.yaml.

Changes since v9:
Change the type of fan-driving-mode to string
Fix some typos and formatting issues.

Changes since v8:
Fix the fail of fan div register setting. (FIELD_GET -> FIELD_PREP)
Change the type of tach-ch from uint32_t to uint8-array
Add additional properties and apply constraints to certain properties.

Changes since v7:
Cherry-pick the fan-common.yaml and add the following properties:
- min-rpm
- div
- mode
- tach-ch
Fix the warning which is reported by the kernel test robot.

Changes since v6:
Consolidate the PWM and TACH functionalities into a unified driver.

Changes since v5:
- pwm/tach:
  - Remove the utilization of common resources from the parent node.
  - Change the concept to 16 PWM/TACH controllers, each with one channel,
  instead of 1 PWM/TACH controller with 16 channels.
- dt-binding:
  - Eliminate the usage of simple-mfd.

Changes since v4:
- pwm:
  - Fix the return type of get_status function.
- tach:
  - read clk source once and re-use it
  - Remove the constants variables
  - Allocate tach_channel as array
  - Use dev->parent
- dt-binding:
  - Fix the order of the patches
  - Add example and description for tach child node
  - Remove pwm extension property

Changes since v3:
- pwm:
  - Remove unnecessary include header
  - Fix warning Prefer "GPL" over "GPL v2"
- tach:
  - Remove the paremeter min_rpm and max_rpm and return the tach value 
  directly without any polling or delay.
  - Fix warning Prefer "GPL" over "GPL v2"
- dt-binding:
  - Replace underscore in node names with dashes
  - Split per subsystem

Changes since v2:
- pwm:
  - Use devm_* api to simplify the error cleanup
  - Fix the multi-line alignment problem
- tach:
  - Add tach-aspeed-ast2600 to index.rst
  - Fix the multi-line alignment problem
  - Remove the tach enable/disable when read the rpm
  - Fix some coding format issue

Changes since v1:
- tach:
  - Add the document tach-aspeed-ast2600.rst
  - Use devm_* api to simplify the error cleanup.
  - Change hwmon register api to devm_hwmon_device_register_with_info

Billy Tsai (2):
  dt-bindings: hwmon: Support Aspeed g6 PWM TACH Control
  hwmon: (aspeed-g6-pwm-tacho): Support for ASPEED g6 PWM/Fan tach

Naresh Solanki (1):
  dt-bindings: hwmon: fan: Add fan binding to schema

 .../bindings/hwmon/aspeed,g6-pwm-tach.yaml    |  71 +++
 .../devicetree/bindings/hwmon/fan-common.yaml |  79 +++
 Documentation/hwmon/aspeed-g6-pwm-tach.rst    |  26 +
 Documentation/hwmon/index.rst                 |   1 +
 drivers/hwmon/Kconfig                         |  11 +
 drivers/hwmon/Makefile                        |   1 +
 drivers/hwmon/aspeed-g6-pwm-tach.c            | 549 ++++++++++++++++++
 7 files changed, 738 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/aspeed,g6-pwm-tach.yaml
 create mode 100644 Documentation/devicetree/bindings/hwmon/fan-common.yaml
 create mode 100644 Documentation/hwmon/aspeed-g6-pwm-tach.rst
 create mode 100644 drivers/hwmon/aspeed-g6-pwm-tach.c

-- 
2.25.1


