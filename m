Return-Path: <linux-kernel+bounces-76647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4512685FA73
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 14:57:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFFAC2821D7
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 13:57:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00E10136678;
	Thu, 22 Feb 2024 13:57:14 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F301C1339A4;
	Thu, 22 Feb 2024 13:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708610233; cv=none; b=rxehlp1V4Gbph9q5S1Y9oR6WJTmtJvcxGcvRRdPn0aR2vMreqXUNvQ6sf8VZNXeuXBtsJK0YvNlS3QXRUVvLDv7VZKgThUn1Jbr+MD3dHDKMdAes6n3MdnpuGTyxeeQd2K0Ge2ARXRerr5+5IRbQUkRa0YEqu0Tlvko3qyz9kP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708610233; c=relaxed/simple;
	bh=NqY+ahb3fnUa60p/yJLt+jA5NiI5wUvrrv0ehDTTdF8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HwZ0YWrqIDvUrNJPDXGP4N9lOIEQbUh16Ti1JB1x4msmgL+mM+tkNA3apEG+BUmu1Pyt4x9sduId9PrdhHDOtNke7x6z3HaOHuNeYLs/2g6IylS/npRgB5G2T/on0OIRZGPI505mLDBc9Vg1xHALoKhn+bG0L2c58yvyVvuVWTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B28C8DA7;
	Thu, 22 Feb 2024 05:57:48 -0800 (PST)
Received: from e126645.arm.com (unknown [10.57.50.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 9FA573F762;
	Thu, 22 Feb 2024 05:57:07 -0800 (PST)
From: Pierre Gondois <pierre.gondois@arm.com>
To: linux-kernel@vger.kernel.org
Cc: Cristian Marussi <cristian.marussi@arm.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Ionela Voinescu <ionela.voinescu@arm.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Pierre Gondois <pierre.gondois@arm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-pm@vger.kernel.org
Subject: [PATCH 0/3]  scmi-cpufreq: Set transition_delay_us
Date: Thu, 22 Feb 2024 14:56:58 +0100
Message-Id: <20240222135702.2005635-1-pierre.gondois@arm.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

policy's fields definitions:
`transition_delay_us`:
The minimum amount of time between two consecutive freq. requests
for one policy.
`transition_latency`:
Delta between freq. change request and effective freq. change on
the hardware.

cpufreq_policy_transition_delay_us() uses the `transition_delay_us`
value if available. Otherwise a value is induced from the policy's
`transition_latency`.

The scmi-cpufreq driver doesn't populate the `transition_delay_us`.
Values matching the definition are available through the SCMI
specification.
Add support to fetch these values and use them in the scmi-cpufreq
driver.

Pierre Gondois (3):
  firmware: arm_scmi: Populate perf commands rate_limit
  firmware: arm_scmi: Populate fast channel rate_limit
  cpufreq: scmi: Set transition_delay_us

 drivers/cpufreq/scmi-cpufreq.c        | 26 +++++++++++++
 drivers/firmware/arm_scmi/driver.c    |  5 ++-
 drivers/firmware/arm_scmi/perf.c      | 53 +++++++++++++++++++++++++--
 drivers/firmware/arm_scmi/powercap.c  | 12 ++++--
 drivers/firmware/arm_scmi/protocols.h |  4 +-
 include/linux/scmi_protocol.h         |  8 ++++
 6 files changed, 98 insertions(+), 10 deletions(-)

-- 
2.25.1


