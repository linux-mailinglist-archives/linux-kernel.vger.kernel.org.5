Return-Path: <linux-kernel+bounces-19007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E3E8826661
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 23:38:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0E3CB210C7
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 22:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B280712B6A;
	Sun,  7 Jan 2024 22:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r6Cd8OGW"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DBF1125A6
	for <linux-kernel@vger.kernel.org>; Sun,  7 Jan 2024 22:38:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33F1BC433C7;
	Sun,  7 Jan 2024 22:38:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704667083;
	bh=YV6MSVp8clQn6v+4HNFDuuOP5CX31oQ2WXROVoJU6sc=;
	h=From:To:Cc:Subject:Date:From;
	b=r6Cd8OGWY4qD6Nwv9+M5jblklrppyzAD5r3wvCMRC+fFH3/ikU9UlY1zyOMDQHpcn
	 fH3WUxdGc+g8PcY4Ptja1COQMDLqWtIAXIA/tBLc7WmzuZLDFb3+n0w4H1aTzp/mrw
	 MQAGc2TQzRFvqif2Q8u3w2OmroqPpeTFEn4MeH9WSCjMTinKlGbx6/bJkUuGxen2EM
	 U9oq6/k6wIB+99ItuHMBINO9H+eunEVYqSGRGfuIGDmN09j2hDXjpaWshiy88HfQnE
	 G98jEJVPVW2YxbbL+Cg9Uv+IPQrQmHqudP5CstoyxUlFfUmmV8xkaQ+hIz6/zXeUQM
	 O45p1Ql9MtrWQ==
From: Mark Brown <broonie@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] regulator updates for v6.8
Date: Sun, 07 Jan 2024 22:37:54 +0000
Message-Id: <20240107223803.33F1BC433C7@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The following changes since commit b85ea95d086471afb4ad062012a4d73cd328fa86:

  Linux 6.7-rc1 (2023-11-12 16:19:07 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-v6.8

for you to fetch changes up to 1cadc04c1a1ac5015c2eb0fadfabf4b61bbe167e:

  regulator: event: Ensure atomicity for sequence number (2024-01-04 20:02:06 +0000)

----------------------------------------------------------------
regulator: Updates for v6.8

The main updates for this release are around monitoring of regulators,
largely for error handling purposes.  We allow the stream of regulator
events to be seen by userspace as netlink events and allow system
integrators to describe individual regulators as system critical with
information on how long the system is expected to last on error.  The
system level error handling is very much about best effort problem
mitigation rather than providing something fully robust, the initial
drive was to provide a mechanism for trying to avoid initiating any new
writes to flash once we notice the power going out.

Otherwise it's very quiet, mainly several new Qualcomm devices.

 - Support for marking regulators as system critical and providing
   information on how long the system might last with those regulators
   in a failure state, hooked into the existing critical shutdown error
   handling.
 - Optional support for generating netlink events for events, there are
   use cases for system monitoring UIs and error handling.
 - A command line option to leave unused controllable regulators
   enabled, useful for debugging.  We already only disable regulators we
   were explicitly given permission to control.
 - Support for Quacomm MP5496, PM8010 and PM8937.

----------------------------------------------------------------
Andy Shevchenko (1):
      regulator: Reuse LINEAR_RANGE() in REGULATOR_LINEAR_RANGE()

Colin Ian King (1):
      regulator: palmas: remove redundant initialization of pointer pdata

Dang Huynh (4):
      regulator: qcom_spmi: Add PM8937 SPMI regulator
      dt-bindings: regulator: qcom,spmi-regulator: Document PM8937 PMIC
      regulator: qcom_smd: Add PM8937 regulators
      dt-bindings: regulator: qcom,smd-rpm-regulator: Document PM8937 IC

Fenglin Wu (3):
      regulator: qcom-rpmh: extend to support multiple linear voltage ranges
      regulator: dt-bindings: qcom,rpmh: add compatible for pm8010
      regulator: qcom-rpmh: add support for pm8010 regulators

Javier Martinez Canillas (1):
      regulator: core: Add option to prevent disabling unused regulators

Jiapeng Chong (1):
      regulator: stpmic1: Fix kernel-doc notation warnings

Johan Hovold (1):
      dt-bindings: regulator: qcom,usb-vbus-regulator: clean up example

Mark Brown (4):
      Add PM8937 PMIC support
      regulator: add under-voltage support (part 2)
      regulator: Convert to platform remove callback
      Add pm8010 RPMH regulators for sm8550 boards

Naresh Solanki (4):
      regulator: event: Add regulator netlink event support
      regulator: event: Add regulator netlink event support
      uapi: regulator: Fix typo
      regulator: event: Ensure atomicity for sequence number

Oleksij Rempel (5):
      regulator: dt-bindings: Add system-critical-regulator property
      regulator: Introduce handling for system-critical under-voltage events
      regulator: dt-bindings: Allow system-critical marking for fixed-regulator
      regulator: dt-bindings: Add 'regulator-uv-less-critical-window-ms' property
      regulator: Implement uv_survival_time for handling under-voltage events

Rui Zhang (1):
      regulator: core: Only increment use_count when enable_count changes

Uwe Kleine-König (8):
      regulator: arizona-ldo1: Convert to platform remove callback returning void
      regulator: bd9571mwv: Convert to platform remove callback returning void
      regulator: db8500-prcmu: Convert to platform remove callback returning void
      regulator: stm32-vrefbuf: Convert to platform remove callback returning void
      regulator: uniphier: Convert to platform remove callback returning void
      regulator: userspace-consumer: Convert to platform remove callback returning void
      regulator: virtual: Convert to platform remove callback returning void
      regulator: wm8350: Convert to platform remove callback returning void

Varadarajan Narayanan (1):
      regulator: qcom_smd: Add LDO5 MP5496 regulator

 Documentation/admin-guide/kernel-parameters.txt    |   7 +
 .../bindings/regulator/fixed-regulator.yaml        |   2 +
 .../bindings/regulator/qcom,rpmh-regulator.yaml    |  14 ++
 .../bindings/regulator/qcom,smd-rpm-regulator.yaml |   4 +
 .../bindings/regulator/qcom,spmi-regulator.yaml    |  19 +++
 .../regulator/qcom,usb-vbus-regulator.yaml         |   5 +-
 .../devicetree/bindings/regulator/regulator.yaml   |  13 ++
 drivers/regulator/Kconfig                          |  10 ++
 drivers/regulator/Makefile                         |   1 +
 drivers/regulator/arizona-ldo1.c                   |   8 +-
 drivers/regulator/bd9571mwv-regulator.c            |   5 +-
 drivers/regulator/core.c                           | 130 +++++++++++----
 drivers/regulator/db8500-prcmu.c                   |   6 +-
 drivers/regulator/event.c                          |  91 +++++++++++
 drivers/regulator/of_regulator.c                   |   9 ++
 drivers/regulator/palmas-regulator.c               |   2 +-
 drivers/regulator/qcom-rpmh-regulator.c            | 177 ++++++++++++++++++---
 drivers/regulator/qcom_smd-regulator.c             |  35 ++++
 drivers/regulator/qcom_spmi-regulator.c            |  34 ++++
 drivers/regulator/regnl.h                          |  13 ++
 drivers/regulator/stm32-vrefbuf.c                  |   6 +-
 drivers/regulator/stpmic1_regulator.c              |   2 +-
 drivers/regulator/uniphier-regulator.c             |   6 +-
 drivers/regulator/userspace-consumer.c             |   6 +-
 drivers/regulator/virtual.c                        |   6 +-
 drivers/regulator/wm8350-regulator.c               |   6 +-
 include/linux/regulator/consumer.h                 |  47 +-----
 include/linux/regulator/driver.h                   |   7 +-
 include/linux/regulator/machine.h                  |  18 +++
 include/uapi/regulator/regulator.h                 |  90 +++++++++++
 30 files changed, 638 insertions(+), 141 deletions(-)
 create mode 100644 drivers/regulator/event.c
 create mode 100644 drivers/regulator/regnl.h
 create mode 100644 include/uapi/regulator/regulator.h

