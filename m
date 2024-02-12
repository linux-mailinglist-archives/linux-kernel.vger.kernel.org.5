Return-Path: <linux-kernel+bounces-61547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 873CD851393
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 13:33:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F93C1F25EF7
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 12:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95B182EAF9;
	Mon, 12 Feb 2024 12:33:04 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 324E51E482
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 12:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707741184; cv=none; b=rf4CJCQBrrIAWVvPcPLKglQyt6KGDp4IxKSbLNza8ScG3HeeY6nrMkTC0tEfCNfmXKu1LD5iWA/zgZWs+1aN0ZD71Uby5eYLAE9QgBQCHMReu2fJi18dbKzJbvPmnIdDRpLD+byTXKz6PdkioOzp/27DprTgkhU4wHePbgFXBqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707741184; c=relaxed/simple;
	bh=lsZVN1LqvRvnK1gbO+NtoBOF2GURNE7UO+ht2iOyTSc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KOoK4sGmSQ2x9IE8oJ9S2UIGwpGHCfyKI3bmlJ006/tnL64Jk7ngg7yWWDMSFTVWPxwc8ouWJ10am7r6UMPWp2ZArd/g36/IQC6AnCr2/2+NlrDIHOT9R7Ls3hYsf0qWMRqYdS5mANh2lUvA7OvjsNz+Xsdz4IZoQO6jaqH/exQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 94BA5DA7;
	Mon, 12 Feb 2024 04:33:42 -0800 (PST)
Received: from pluto.fritz.box (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9DBEC3F7BD;
	Mon, 12 Feb 2024 04:32:59 -0800 (PST)
From: Cristian Marussi <cristian.marussi@arm.com>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: sudeep.holla@arm.com,
	vincent.guittot@linaro.org,
	peng.fan@oss.nxp.com,
	michal.simek@amd.com,
	quic_sibis@quicinc.com,
	quic_nkela@quicinc.com,
	souvik.chakravarty@arm.com,
	Cristian Marussi <cristian.marussi@arm.com>
Subject: [PATCH 00/11] Add SCMI core checks for notification support.
Date: Mon, 12 Feb 2024 12:32:22 +0000
Message-ID: <20240212123233.1230090-1-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

this small series adds a new logic into the SCMI core to implicitly check
for notification support when some SCMI driver attempts to register for
notifications.

Till now, trying to register a notifier for an unsuppported notification
returned an error and this behaviour generated unneeded message exchanges:
the only way to avoid this was to lookup in advance the specific protocol
and resources available in order to avoid registering at all any notifier
where not supported.

Anyway, not all protocols currently expose the related notification info
to lookup and, moreover, no check was performed anywhere to verify if the
specific notification enable/disable command was supported at all (almost
all of these notification enable commands are optional).

Last but not least, this kind of support checks could and should be handled
transparently by the SCMI core.

With this series each protocol can optionally provide an event_ops
callcback that will be invoked by the core to lookup if the specific
command and event/resource notification is supported on the running
platform; the SCMI core then, at initialization time, will use such
callbacks to take care to collect such info and mark unsupported
events/resources.

Later on, when an SCMI driver attempts to register a notifier for a
specific event/resources, it will fail and return an error to the caller
if the requested notification was not supported.

The end-result is that the SCMI driver user will fail to register a
notifier if the related command or resource is not supported (like before),
BUT without the need of exchanging any message NOR the need to actively
lookup if the specified notification is supported.

The last two patches in the series, instead, take care to extend the Perf
notification report to provide the pre-calculated frequencies corresponding
to the level or index carried by the specific notification report.
These latter 2 patches are indeed only slighly related to this series at
large but are provided here for ease of access.

Based on sudeep/for-next/scmi/updates on top of commit

7dd3d11f4dac ("clk: scmi: Add support for forbidden clock state controls")

Thanks,
Cristian

---

Cristian Marussi (11):
  firmware: arm_scmi: Check for notification support
  firmware: arm_scmi: Add a common helper to check if a message is
    supported
  firmware: arm_scmi: Implement Perf .is_notify_supported callback
  firmware: arm_scmi: Implement Power .is_notify_supported callback
  firmware: arm_scmi: Implement SysPower .is_notify_supported callback
  firmware: arm_scmi: Implement Clock .is_notify_supported callback
  firmware: arm_scmi: Implement Sensor .is_notify_supported callback
  firmware: arm_scmi: Implement Reset .is_notify_supported callback
  firmware: arm_scmi: Implement Powercap .is_notify_supported callback
  firmware: arm_scmi: Use opps_by_lvl to store opps
  firmware: arm_scmi: Report frequencies in Perf notifications

 drivers/firmware/arm_scmi/clock.c     |  47 ++++++++-
 drivers/firmware/arm_scmi/driver.c    |  34 ++++++
 drivers/firmware/arm_scmi/notify.c    |  17 ++-
 drivers/firmware/arm_scmi/notify.h    |   4 +
 drivers/firmware/arm_scmi/perf.c      | 144 +++++++++++++++++++++++---
 drivers/firmware/arm_scmi/power.c     |  30 +++++-
 drivers/firmware/arm_scmi/powercap.c  |  45 +++++++-
 drivers/firmware/arm_scmi/protocols.h |   4 +
 drivers/firmware/arm_scmi/reset.c     |  37 +++++--
 drivers/firmware/arm_scmi/sensors.c   |  37 ++++++-
 drivers/firmware/arm_scmi/system.c    |  16 +++
 include/linux/scmi_protocol.h         |   3 +
 12 files changed, 383 insertions(+), 35 deletions(-)

-- 
2.43.0



