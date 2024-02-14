Return-Path: <linux-kernel+bounces-65804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F22D855215
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 19:30:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55F4128B77D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 18:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DC8512BF24;
	Wed, 14 Feb 2024 18:30:35 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75CD612BF0B
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 18:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707935435; cv=none; b=qJdom3P+NmCnmh7S4ebwrBClhNluxBNqyi0qZvs5FaMmopdLwp3vLz5Qy4G2jbn+BZ6fOpFfnP25dYNr8HRT6o9n0DUb8OuyuLTpF4n0hTEPJXhNWE4wxPaGBBgbYAxomFWtGrH41ATAIOscgG+ragN4ju0HchfEOSGYP5SabhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707935435; c=relaxed/simple;
	bh=oguWnocZws5vf+j1aiEz+HdHe1tJCGNmDLJH2xJJZ04=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sK2VOX7u3Z46+Z8fXWFcpjuts+BGTD7WCncHBec4b3BEq1NabdYvbQuxAX4WrLPDwOftmbUsKgYDIqqg6QC98/55uGTcMO5ipwNYC7uMuA6gtit07kpKo9I8Ch8lamq+lAdySKWqIEkIuuQvu6DB26+B3Lk5TReb/HezaXsJklE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A8B161FB;
	Wed, 14 Feb 2024 10:31:11 -0800 (PST)
Received: from pluto.fritz.box (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 015763F7B4;
	Wed, 14 Feb 2024 10:30:28 -0800 (PST)
From: Cristian Marussi <cristian.marussi@arm.com>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: sudeep.holla@arm.com,
	james.quinlan@broadcom.com,
	f.fainelli@gmail.com,
	vincent.guittot@linaro.org,
	peng.fan@oss.nxp.com,
	michal.simek@amd.com,
	quic_sibis@quicinc.com,
	quic_nkela@quicinc.com,
	souvik.chakravarty@arm.com,
	Cristian Marussi <cristian.marussi@arm.com>
Subject: [PATCH 0/7] SCMI V3.2 Misc updates
Date: Wed, 14 Feb 2024 18:29:59 +0000
Message-ID: <20240214183006.3403207-1-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

another round of updates related to the last v3.2 SCMI spec, mostly around
Clock protocol.

Note that the series is based on sudeep/for-next/scmi/updates on top of

  7dd3d11f4dac ("clk: scmi: Add support for forbidden clock state controls")

and patch [1/7], which was included in the recently posted [1], it is
included also here just for ease of usage. (since needed also here ofc)

Having said that, [2/7] add a centralized support to the SCMI core to
handle v3.2 optional protocol version negotiation, so that at protocol
initialization time, mif the platform advertised version is newer than
supported by the kernel and protocol version negotiation is supported,
the SCMI core will attempt to negotiate an older protocol version.

Patches 3,4,5 adds the remaining last missing bits of Clock v3.2 protocol
and bumps the supported protocol version to 0x30000 (v3.2).

On top of these new SCMI additions, [6/7] reworks at first slightly how the
clk-scmi driver configures per-clock CLK ops, and then [7/7] adds support
for clock get/set duty cycle, as allowed by the last v3.2 spec additions,
but only if the related SCMI clk domain supports that specific clock
permissions.

Thanks,
Cristian

[1]: https://lore.kernel.org/linux-arm-kernel/20240212123233.1230090-3-cristian.marussi@arm.com/
---

Cristian Marussi (7):
  firmware: arm_scmi: Add a common helper to check if a message is
    supported
  firmware: arm_scmi: Add support for v3.2 NEGOTIATE_PROTOCOL_VERSION
  firmware: arm_scmi: Add Clock check for extended config support
  firmware: arm_scmi: Add standard Clock OEM definitions
  firmware: arm_scmi: Update supported Clock protocol version
  clk: scmi: Allocate CLK operations dynamically
  clk: scmi: Support get/set duty_cycle operations

 drivers/clk/clk-scmi.c                | 168 +++++++++++++++++---------
 drivers/firmware/arm_scmi/clock.c     |  67 +++++++---
 drivers/firmware/arm_scmi/driver.c    |  99 ++++++++++++++-
 drivers/firmware/arm_scmi/protocols.h |   5 +
 include/linux/scmi_protocol.h         |  15 ++-
 5 files changed, 270 insertions(+), 84 deletions(-)

-- 
2.43.0


