Return-Path: <linux-kernel+bounces-135150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E84B89BBBD
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 11:32:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D9BC1F21F49
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 09:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E6A547F48;
	Mon,  8 Apr 2024 09:31:54 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E880E4597B
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 09:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712568713; cv=none; b=iH9PA/YK8sbs8pjx+X9L3CG/FbwOZGV1h0uMeOFbi4fRL4cNDqoJd702wc+XgtWf0xEgKvSN/n592rI2mEeVT60+kDL/hDQ5sV1qpzKVNmjb/VHcjNI1O+y5/fDnxaitq4lJOGe/vbbWkNPf54XuWt8rVtWMDui+N0Udr8+LfCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712568713; c=relaxed/simple;
	bh=md+DNpleLUo+YAUxcthbKUEEMOTXTMIIp7ISqbwQx3w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kQzMwfQheoVJjsbGE9xwYJo8SFSEUNNDKSl0tas9CmWjxGH2KQ7lqwLrYu1oAbnyThTdOEI7DRbH2EH/OdvuiNjcd+S4db0o2/j8l2z5gBKv0hoLSNSS9qBjUFk7HL0I5ervGmfs0MYU6i2cOFzdG0zHy6OloUlhdRejjJwfb/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6444B1007;
	Mon,  8 Apr 2024 02:32:21 -0700 (PDT)
Received: from pluto.fritz.box (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 41BAB3F766;
	Mon,  8 Apr 2024 02:31:49 -0700 (PDT)
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
	konrad.dybcio@linaro.org,
	souvik.chakravarty@arm.com,
	Cristian Marussi <cristian.marussi@arm.com>
Subject: [PATCH v2 0/2] SCMI multiple vendor protocol support
Date: Mon,  8 Apr 2024 10:30:50 +0100
Message-ID: <20240408093052.3801576-1-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

this is meant to address the possibility of having multiple vendors
implementing distinct SCMI vendor protocols with possibly the same
overlapping protocol number without the need of crafting the Kconfig
at compile time to include only wanted protos

Basic idea is simple:

- vendor protos HAS to be 'tagged' at build time with a vendor_id
- vendor protos COULD also optionally be tagged at build time with
sub_vendor_id and implementation version

- at init all the build vendor protos are registered with the SCMI core
  using a key derived from the above tags

- at SCMI probe time the platform is identified via Base protocol as
  usual and all the required vendor protos (i.e. IDs defined in the DT
  as usual) are loaded (if required) after a lookup process based on the
  following rules:

  + protocol DB is searched using the platform/Base runtime provided tags

  	<vendor> / <sub_vendor> / <impl_ver>

    using the following search logic (keys), first match:

     1. proto_id / <vendor_id> / <sub_vendor_id> / <impl_ver>

     2. proto_id / <vendor_id> / <sub_vendor_id> / 0

     3. proto_id / <vendor_id> / NULL / 0

  IOW, closest match, depending on how much fine grained is your
  protocol tuned (tagged) for the platform.

  I am still doubtful about the usage of <impl_ver>, and tempted to drop it
  since we have anyway protocol version and NEGOTIATE_PROTOCOL_VERSION
  to deal with slight difference in fw revision...

In V2 a dedicated vendors dir/Makefile/Kconfig is added: not sure if we
want to provide also a way of grouping SCMI vendor protocol headers under
include/linux...open to any suggestion/opinion.

Based on sudeep/for-next/scmi/updates on top of

   commit dccc943c8953 ("clk: scmi: Support get/set duty_cycle operations")

Any feedback welcome

Thanks,
Cristian

---
v1 -> v2
- added a dedicated vendors/ directory and Kconfig under arm_scmi/

Cristian Marussi (2):
  firmware: arm_scmi: Add support for multiple vendors custom protocols
  firmware: arm_scmi: Add dedicated vendor protocols submenu

 drivers/firmware/arm_scmi/Kconfig          |   2 +
 drivers/firmware/arm_scmi/Makefile         |   1 +
 drivers/firmware/arm_scmi/driver.c         | 165 ++++++++++++++++++---
 drivers/firmware/arm_scmi/protocols.h      |  15 ++
 drivers/firmware/arm_scmi/vendors/Kconfig  |   4 +
 drivers/firmware/arm_scmi/vendors/Makefile |   2 +
 6 files changed, 167 insertions(+), 22 deletions(-)
 create mode 100644 drivers/firmware/arm_scmi/vendors/Kconfig
 create mode 100644 drivers/firmware/arm_scmi/vendors/Makefile

-- 
2.44.0


