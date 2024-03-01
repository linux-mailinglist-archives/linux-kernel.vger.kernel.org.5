Return-Path: <linux-kernel+bounces-88746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A41F86E60D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 17:48:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 080ED1F2212B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 16:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F6405C9A;
	Fri,  1 Mar 2024 16:43:01 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 660DD5231;
	Fri,  1 Mar 2024 16:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709311381; cv=none; b=eMZgRc0UUzP1OTq6MRT3HjEK79Tcyz9KAHNOFae5xSG1yDNZ9M4gLJOtsq5M/xwX55ZqTd7yYO00KKYbML/3C0/MMa81+K4N7Dns/bMycMxcfbkfw+9MIJUTGmwjWEHzFgnhJmlvyoNzlGcuEVBx2a+oW5w6RSz272bJIjLimiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709311381; c=relaxed/simple;
	bh=MSl2PxTtAMP4r+b1ezxUj0gj2cNUYpY54lAEfO3G6p4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mhUoMa41HMFnG4WvVB4B9Zbci5ilRL5yjaE5alNCf0P1LYLlg8Je1CAXGhZizWLg30hPDYBisWwBnt6UKlxdGk+rAOzm1R/5gGfviz7xShum3dnOEGql1VqI30Pid15SCM6o9IqcCMKRWzoftecfVySpKP49OsB4ETFBfrI1B30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D8F8E1FB;
	Fri,  1 Mar 2024 08:43:36 -0800 (PST)
Received: from e130802.arm.com (unknown [10.57.69.63])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C03383F73F;
	Fri,  1 Mar 2024 08:42:55 -0800 (PST)
From: abdellatif.elkhlifi@arm.com
To: Bjorn Andersson <andersson@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Rob Herring <robh+dt@kernel.org>
Cc: Liviu Dudau <liviu.dudau@arm.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Drew.Reed@arm.com,
	Adam.Johnston@arm.com,
	Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-remoteproc@vger.kernel.org
Subject: [PATCH 0/3] remoteproc: introduce Arm remoteproc support
Date: Fri,  1 Mar 2024 16:42:24 +0000
Message-Id: <20240301164227.339208-1-abdellatif.elkhlifi@arm.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>

Some Arm heterogeneous System-On-Chips feature remote processors that can
be controlled with a reset control register and a reset status register to
start or stop the processor.

This patchset adds support for these processors by providing the
following:

1) A remoteproc driver that retrieves the reset registers addresses from
the DT, register a new rproc device with the remoteproc subsystem and
provides the start and stop operations for switching on or off the remote
processor.

The start and stop operations are provided as a data config selected on DT node match.
Currently we are providing support for Corstone-1000 External System (Cortex-M3) [1]
as a remote processor. The driver can be extended to support other remote processors
by adding a data config and custom implementation of the start and stop operations.

2) DT bindings

3) Support control of multiple remote processors at the same time

[1]: https://developer.arm.com/documentation/102360/0000/Overview-of-Corstone-1000/Corstone-1000

Cheers,
Abdellatif

Abdellatif El Khlifi (3):
  remoteproc: Add Arm remoteproc driver
  arm64: dts: Add corstone1000 external system device node
  dt-bindings: remoteproc: Add Arm remoteproc

 .../bindings/remoteproc/arm,rproc.yaml        |  69 +++
 MAINTAINERS                                   |   7 +
 arch/arm64/boot/dts/arm/corstone1000.dtsi     |  10 +-
 drivers/remoteproc/Kconfig                    |  18 +
 drivers/remoteproc/Makefile                   |   1 +
 drivers/remoteproc/arm_rproc.c                | 395 ++++++++++++++++++
 6 files changed, 499 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/remoteproc/arm,rproc.yaml
 create mode 100644 drivers/remoteproc/arm_rproc.c


base-commit: 8b46dc5cfa5ffea279aed0fc05dc4b1c39a51517
-- 
2.25.1


