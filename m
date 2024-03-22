Return-Path: <linux-kernel+bounces-111349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57724886B05
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 12:09:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 123DC28470E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 11:09:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 303D83EA73;
	Fri, 22 Mar 2024 11:09:03 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA629224FA;
	Fri, 22 Mar 2024 11:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711105742; cv=none; b=h3VlerTE3KRp/Izi0pMogyelH2MWF8pxtQmZ37ujJVySSpfquIkhq0urphPO9JKINh8WC364ro5gF329X38oQMIPzMmJfk/b17D0XutBeoHoppeYDEO9pXs5zIDWtMMoFCgIMIUA+EBjICpQ/POWNFIGMmFeozzoyEkLt4BIwyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711105742; c=relaxed/simple;
	bh=rpRBWVBaqmeYGErvSJjv0zKZWE8QSyinu2dYEyNFBDg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RgHglW3BHw9rkWmAX8K/12+Du1Uo8Yw27jtTTjZa32juJo2Z9vIEES5h524RbwIFvtEXbXg9xa5+YkRxb1lOJwOQUjPZDrFSQLfsnfDyyzlJKpni/tH8QdTmQttN7cg6TmGZ0WQq0eRmvCnX+vJlGlc887gyBtnFPA/yd9CTHGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 231E71007;
	Fri, 22 Mar 2024 04:09:34 -0700 (PDT)
Received: from e129166.arm.com (unknown [10.57.71.57])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 93D423F64C;
	Fri, 22 Mar 2024 04:08:57 -0700 (PDT)
From: Lukasz Luba <lukasz.luba@arm.com>
To: linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Cc: lukasz.luba@arm.com,
	dietmar.eggemann@arm.com,
	linux-arm-kernel@lists.infradead.org,
	sboyd@kernel.org,
	nm@ti.com,
	linux-samsung-soc@vger.kernel.org,
	daniel.lezcano@linaro.org,
	rafael@kernel.org,
	viresh.kumar@linaro.org,
	krzysztof.kozlowski@linaro.org,
	alim.akhtar@samsung.com,
	m.szyprowski@samsung.com,
	mhiramat@kernel.org
Subject: [RESEND][PATCH v2 0/4] Update Energy Model after chip binning adjusted voltages
Date: Fri, 22 Mar 2024 11:08:46 +0000
Message-Id: <20240322110850.77086-1-lukasz.luba@arm.com>
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


Changes:
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
  PM: EM: Change the em_adjust_new_capacity() to re-use code
  PM: EM: Add em_dev_update_chip_binning()
  soc: samsung: exynos-asv: Update Energy Model after adjusting voltage

 drivers/opp/of.c                 |  17 +++--
 drivers/soc/samsung/exynos-asv.c |  11 +++-
 include/linux/energy_model.h     |   5 ++
 include/linux/pm_opp.h           |   8 +++
 kernel/power/energy_model.c      | 109 +++++++++++++++++++++++++------
 5 files changed, 125 insertions(+), 25 deletions(-)

-- 
2.25.1


