Return-Path: <linux-kernel+bounces-122607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BFF6888FA53
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 09:51:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F14A51C2C3B8
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 08:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6FE756B6E;
	Thu, 28 Mar 2024 08:51:22 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B33C164CCC;
	Thu, 28 Mar 2024 08:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711615882; cv=none; b=YQEJSyY594IobBRoUpMpOKsNv1NMkrwCR4/U6mZjIsPztR9adSazeHkjHKteJa6lBj6OwE/6QYy2cQW01z35CgscR/Di9gpuc1GcOVsp8C0oTSvw9csKrvY23bKalOp9RmgbrNxybpbI7N/DbRWe7XO9NhPfzejkSTXTBR4tpg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711615882; c=relaxed/simple;
	bh=VjTZgK/Qn0DOsZybfTiGOpl86fNw/oP4YfAinPR5uJc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GvnzxZww5oYxMeio/ZTnL+65oOHsInk29an1zEUaRhNvaW2nyxWrzQ6UPL/hR8LcN3v+4j8gy2DT3SqIwXFepys82hOG9ATc0EmuGlCtIakQN4LVSSPeU8BlCx4n0CwldnT7X3H04CnfFcDVk5ZuxVAUZ/p8OHI6wUoPHu5D1PA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F016D2F4;
	Thu, 28 Mar 2024 01:51:53 -0700 (PDT)
Received: from e129166.arm.com (unknown [10.57.73.83])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 932A03F7BD;
	Thu, 28 Mar 2024 01:51:17 -0700 (PDT)
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
Subject: [PATCH v3 0/4] Update Energy Model after chip binning adjusted voltages
Date: Thu, 28 Mar 2024 08:51:08 +0000
Message-Id: <20240328085112.3873050-1-lukasz.luba@arm.com>
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

It has dependency on Exynos SoC driver.


Changes:
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

Lukasz Luba (4):
  OPP: OF: Export dev_opp_pm_calc_power() for usage from EM
  PM: EM: Change the em_adjust_new_capacity() to re-use code
  PM: EM: Add em_dev_update_chip_binning()
  soc: samsung: exynos-asv: Update Energy Model after adjusting voltage

 drivers/opp/of.c                 |  17 +++--
 drivers/soc/samsung/exynos-asv.c |  11 +++-
 include/linux/energy_model.h     |   5 ++
 include/linux/pm_opp.h           |   8 +++
 kernel/power/energy_model.c      | 106 +++++++++++++++++++++++++------
 5 files changed, 122 insertions(+), 25 deletions(-)

-- 
2.25.1


