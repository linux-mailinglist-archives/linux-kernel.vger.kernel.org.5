Return-Path: <linux-kernel+bounces-130185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA6CF89751D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 18:23:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 184111C273C3
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 16:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47F3E15098F;
	Wed,  3 Apr 2024 16:23:25 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B02F214F13F;
	Wed,  3 Apr 2024 16:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712161404; cv=none; b=fArcrehJL+nVo8fJsW+scg9ea/7V+OpXcXKWuOPvAUOU/W6NpEJcUqzyDmq3Vm8LlCc3cUue2xB9Vt+56voUWaSN7BWUaUeu6LNiH3YWGNpaO2TIu+CJougYbo7FpbzggXYBlGsSvdLEkg/ZWLU2/uQnANfxkiPPalk2maorvis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712161404; c=relaxed/simple;
	bh=jIQIhacRFCddfDckOdUnXurj/QFyUwI3ASVH7iFw5LU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PK7u0rEn9G2G3aekVxDtTOYbO+tykZSbQkwdw0IuVfEbSeh8Hhw2/DwxoVoRRx+riDU98LOKu7PDaqKGCXRLMwHE6bwtU/GYPylNPhmfgivh+BFG5Ujl/vwFTYIb7k2fZOk2Qzt5p//zNOEbf215i3dDm287mKt0Kzfj7kpOrIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EE3731007;
	Wed,  3 Apr 2024 09:23:52 -0700 (PDT)
Received: from e129166.arm.com (unknown [10.57.72.191])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 0CD063F7B4;
	Wed,  3 Apr 2024 09:23:19 -0700 (PDT)
From: Lukasz Luba <lukasz.luba@arm.com>
To: linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Cc: lukasz.luba@arm.com,
	dietmar.eggemann@arm.com,
	linux-arm-kernel@lists.infradead.org,
	sudeep.holla@arm.com,
	cristian.marussi@arm.com,
	linux-samsung-soc@vger.kernel.org,
	rafael@kernel.org,
	viresh.kumar@linaro.org,
	quic_sibis@quicinc.com
Subject: [PATCH 0/2] Update Energy Model with perfromance limits
Date: Wed,  3 Apr 2024 17:23:13 +0100
Message-Id: <20240403162315.1458337-1-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

This patch set allows to specify in the EM the range of performance levels that
the device is allowed to operate. It will impact EAS decision, especially for
SoCs where CPUs share the voltage & frequency domain with other CPUs or devices
e.g.
- Mid CPUs + Big CPU
- Little CPU + L3 cache in DSU

The minimum allowed frequency will be taken into account while doing EAS task
placement simulation. When the min frequency is higher for the whole domain
and not driven by the CPUs in that PD utilization, than the energy for
computation in that PD will be higher. This patch helps to reflect that higher
cost.

More explanation can be found in my presentation on OSPM2023 [1].
I have shown experiments with Big CPU running high frequency and increasing
the L3 cache frequency (to reduce the latency), but that impacted Little
CPU which are in the same DVFS domain with L3 cache. It had bad impact for
total energy consumed by small tasks placed on Little CPU. The EAS was not
aware about the min frequency&voltage of the Little CPUs and energy estimation
was wrong.

Depends on:
patch 2/2:
- SCMI cpufreq performance limits notification support (w/ other
   dependency) [2]
patch 1/2:
- EM recent patches for chip binning update - to avoid conflict [3]

Therefore, the patch 1/2 could go first and patch 2/2 can wait longer.

Regards,
Lukasz Luba

[1] https://www.youtube.com/watch?v=2C-5uikSbtM&list=PL0fKordpLTjKsBOUcZqnzlHShri4YBL1H
[2] https://lore.kernel.org/lkml/20240328074131.2839871-1-quic_sibis@quicinc.com/
[3] https://lore.kernel.org/lkml/20240403154907.1420245-1-lukasz.luba@arm.com/

Lukasz Luba (2):
  PM: EM: Add min/max available performance state limits
  cpufreq: scmi: Update Energy Model with allowed performance limits

 drivers/cpufreq/scmi-cpufreq.c | 19 +++++++++++---
 include/linux/energy_model.h   | 22 +++++++++++++---
 kernel/power/energy_model.c    | 48 ++++++++++++++++++++++++++++++++++
 3 files changed, 82 insertions(+), 7 deletions(-)

-- 
2.25.1


