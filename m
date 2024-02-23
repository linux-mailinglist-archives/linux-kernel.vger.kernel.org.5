Return-Path: <linux-kernel+bounces-78713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 036A58617B6
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 17:23:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C89B1F21CE0
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 16:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97CF5126F00;
	Fri, 23 Feb 2024 16:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jy+N5WCy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A0C128830;
	Fri, 23 Feb 2024 16:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708705295; cv=none; b=Bz5PeDWt+A9GFsaFtv4QtgO/wWf0sKXVcSHuyAeZT9qhWTkeujrXrNGr+v05kTo7754Fc4iZLOdA7HWnutOvfVt19PHz0Z35VaZr+Rn4R0mZILVHK7Z+2yT69LXXdOzW2nHHVJycHJ1aQWUnpIw5u8DrmRTcW91U/VRtj8k8ako=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708705295; c=relaxed/simple;
	bh=nkzfDe78XYu9AKubEmy4nyub2amr94i3A/PBGGoWuuY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LEa5lniTpYRMQJDAJynquESUX6Cz3YxzOJ3TJopIW/sRWD1k7w7etThx+tALCOPdwaBBX+mYoj3XS8dE/IUt5zWD4Upfmp857b0TCjaK0Xac18ikal79I0UMUyfjZaohEcJd2SvnbvTgPvKOIbh1B+tvqsQW6WWCMU0m9J/PmTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jy+N5WCy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34DF1C433F1;
	Fri, 23 Feb 2024 16:21:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708705295;
	bh=nkzfDe78XYu9AKubEmy4nyub2amr94i3A/PBGGoWuuY=;
	h=From:To:Cc:Subject:Date:From;
	b=Jy+N5WCy5cbUF0V6xACl/I+BZY99NN06Lr+wOz6lyhH2ijaGzNrOoW+hUI2Sq52k1
	 TZQiGM1Fs+x1GmRO0VDlTb35ABPmFEjJPRwq5fzzYQX3vkoCN87N3FTY8BN3rbZl9Y
	 LdP/6LVMV4VJw4RN+YHD96xKP1A6dkaaZj6P/eG1S6Q8X8r1olBtbgyvBbsMVmhHRw
	 gPXS5zfA0rrL8lY/JM7t6ngqXMfZs4laGEJRUnxPemcS10YtwX/JVaQzdS9E9kuIIV
	 hKqYP9uKP2TIemofzYXObff+Tvu9LMEwjJRtwIitNYyJi7pWnX0BW40FVvXAc9O6dv
	 xyaIBMwuPH/9w==
From: Conor Dooley <conor@kernel.org>
To: linux@roeck-us.net
Cc: conor@kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Jean Delvare <jdelvare@suse.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Zev Weiss <zev@bewilderbeest.net>,
	Patrick Rudolph <patrick.rudolph@9elements.com>,
	Peter Yin <peteryin.openbmc@gmail.com>,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/5] PMBUS Regulator cleanups
Date: Fri, 23 Feb 2024 16:21:04 +0000
Message-ID: <20240223-moonrise-feminist-de59b9e1b3ba@spud>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1959; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=PZCrvOlM9Wjhm/GDfgvQ2jQYxEfSLDyZ7QMhFoY7KhY=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDKk3jn5eMXvRng3avGynlOT5pzkwf0javHntt8PnjrdpS 6ywMJLY3lHKwiDGwSArpsiSeLuvRWr9H5cdzj1vYeawMoEMYeDiFICJ/OhjZNijsWUjY2fKS6HC HrG/kZFM8bLxE3e/E7XxCG+esW6W8B1GhsPSylEhL1bJnFWTmqDJfOq10vK9pz7LlFtMqTlepXI /gwUA
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

A v2 of Guenter's series that changed the name of regulators registered
by PBMUS. The documenation (offical, not bindings) doesn't call the
output Vout0 and there were no bindings for these devices that allowed
regulator child nodes.

Document the regular child nodes for the TI devices and allow regulator
properties for the infineon ones.

Naresh is already working on the tda38640, so there's nothing for that
here DT wise.

Cheers,
Conor.

CC: Jean Delvare <jdelvare@suse.com>
CC: Guenter Roeck <linux@roeck-us.net>
CC: Rob Herring <robh@kernel.org>
CC: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC: Conor Dooley <conor+dt@kernel.org>
CC: Liam Girdwood <lgirdwood@gmail.com>
CC: Mark Brown <broonie@kernel.org>
CC: Zev Weiss <zev@bewilderbeest.net>
CC: Patrick Rudolph <patrick.rudolph@9elements.com>
CC: Peter Yin <peteryin.openbmc@gmail.com>
CC: Alexander Stein <alexander.stein@ew.tq-group.com>
CC: linux-hwmon@vger.kernel.org
CC: devicetree@vger.kernel.org
CC: linux-kernel@vger.kernel.org

Conor Dooley (2):
  dt-bindings: hwmon/pmbus: ti,lm25066: document regulators
  regulator: dt-bindings: promote infineon buck converters to their own
    binding

Guenter Roeck (3):
  hwmon: (pmbus/tda38640) Use PMBUS_REGULATOR_ONE to declare regulator
  hwmon: (pmbus/lm25066) Use PMBUS_REGULATOR_ONE to declare regulator
  hwmon: (pmbus/ir38064) Use PMBUS_REGULATOR_ONE to declare regulator

 .../bindings/hwmon/pmbus/ti,lm25066.yaml      | 12 +++++
 .../bindings/regulator/infineon,ir38060.yaml  | 46 +++++++++++++++++++
 .../devicetree/bindings/trivial-devices.yaml  |  8 ----
 drivers/hwmon/pmbus/ir38064.c                 |  2 +-
 drivers/hwmon/pmbus/lm25066.c                 |  2 +-
 drivers/hwmon/pmbus/tda38640.c                |  2 +-
 6 files changed, 61 insertions(+), 11 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/regulator/infineon,ir38060.yaml

-- 
2.43.0


