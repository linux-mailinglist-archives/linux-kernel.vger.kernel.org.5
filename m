Return-Path: <linux-kernel+bounces-130128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 80A0389746B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 17:49:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A67B41C25444
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 15:49:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C15714AD2A;
	Wed,  3 Apr 2024 15:49:28 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C60EE14A0B4;
	Wed,  3 Apr 2024 15:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712159368; cv=none; b=n17Vt0m60lcVu8roovDjd7QTYBlJNP16t/V7eNCuC/rFCFgV0khX6Gr/QdFPNTw2bnwNmPanuCfj8K0JTKAlZquB0Ui5fvdaEbUHozFtPErgJWHDWygxN4IWVOVer4ngBa4+vHKcY5C0jAW8FMgeRI/bXVUbipc9ywHXFeqsO9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712159368; c=relaxed/simple;
	bh=ubUVS5S6mpXJBVwqb+wtd1l3uI9l3+kshLrYYVibeGY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tcSiwI8EY++YVd/VVscwAea3Li97OsEmI0LXqKZ8bOW+ZssjzfZg7R+YbDucsy4pE0JDXDoMlnSt6QX/RpBDUAmuN+T0o//ihqdKVhQFHXgWVLTcjV3pxwG8pkq+0A3N/7hTbtI0316yk9no8+Z2lCW8O6mYO9N5KbxeTV8XGXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CFCDC1007;
	Wed,  3 Apr 2024 08:49:55 -0700 (PDT)
Received: from e129166.arm.com (unknown [10.57.72.191])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 553313F7B4;
	Wed,  3 Apr 2024 08:49:22 -0700 (PDT)
From: Lukasz Luba <lukasz.luba@arm.com>
To: linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	rafael@kernel.org
Cc: lukasz.luba@arm.com,
	dietmar.eggemann@arm.com,
	linux-arm-kernel@lists.infradead.org,
	sboyd@kernel.org,
	nm@ti.com,
	linux-samsung-soc@vger.kernel.org,
	daniel.lezcano@linaro.org,
	viresh.kumar@linaro.org,
	krzysztof.kozlowski@linaro.org,
	alim.akhtar@samsung.com,
	m.szyprowski@samsung.com,
	mhiramat@kernel.org
Subject: [PATCH v5 0/4] Update Energy Model after chip binning adjusted voltages
Date: Wed,  3 Apr 2024 16:49:03 +0100
Message-Id: <20240403154907.1420245-1-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

This is a follow-up patch aiming to add EM modification due to chip binning.
The first RFC and the discussion can be found here [1].

It uses Exynos chip driver code as a 1st user. The EM framework has been
extended to handle this use case easily, when the voltage has been changed
after setup. On my Odroid-xu4 in some OPPs I can observe ~20% power difference.
According to that data in driver tables it could be up to ~29%.

This chip binning is applicable to a lot of SoCs, so the EM framework should
make it easy to update. It uses the existing OPP and DT information to
re-calculate the new power values.

It has dependency on Exynos SoC driver tree.

Changes:
v5:
- adjusted aligning of the function arguments in patch 1/4 (Dietmar)
- adjusted the in-code comment patch 4/4 (Dietmar)
- added Reviewed-by to all patches (Dietmar)
v4:
- added asterisk in the comment section (test robot)
- change the patch 2/4 header name and use 'Refactor'
v3:
- updated header description patch 2/4 (Dietmar)
- removed 2 sentences from comment and adjusted in patch 3/4 (Dietmar)
- patch 4/4 re-phrased code comment (Dietmar)
- collected tags (Krzysztof, Viresh)
v2:
- removed 'ret' from error message which wasn't initialized (Christian)
v1:
- exported the OPP calculation function from the OPP/OF so it can be
  used from EM fwk (Viresh)
- refactored EM updating function to re-use common code
- added new EM function which can be used by chip device drivers which
  modify the voltage in OPPs
RFC is at [1]

Regards,
Lukasz Luba

[1] https://lore.kernel.org/lkml/20231220110339.1065505-1-lukasz.luba@arm.com/

Lukasz Luba (4):
  OPP: OF: Export dev_opp_pm_calc_power() for usage from EM
  PM: EM: Refactor em_adjust_new_capacity()
  PM: EM: Add em_dev_update_chip_binning()
  soc: samsung: exynos-asv: Update Energy Model after adjusting voltage

 drivers/opp/of.c                 |  17 +++--
 drivers/soc/samsung/exynos-asv.c |  10 ++-
 include/linux/energy_model.h     |   5 ++
 include/linux/pm_opp.h           |   8 +++
 kernel/power/energy_model.c      | 106 +++++++++++++++++++++++++------
 5 files changed, 121 insertions(+), 25 deletions(-)

-- 
2.25.1


