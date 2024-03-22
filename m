Return-Path: <linux-kernel+bounces-111297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36D41886A60
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 11:32:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E09A8285A12
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 10:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C8D33C699;
	Fri, 22 Mar 2024 10:32:37 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22EF617575;
	Fri, 22 Mar 2024 10:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711103557; cv=none; b=pPdiwm6jPehEl5xm39mA3Wl7GYa1RREtt0p5B1rDMu6HiRHtf24Tz2GX9tVNhTnENAfiFPwr1AGjz/d5WdcQI1T+TY8DxE8VxOM5+f10RvJiGG7ObjrgASRbZ9H6jtw9AQ2MbFVC5vgKuKa2TbbSoT4kuzOI1Uu28tuP81iDMsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711103557; c=relaxed/simple;
	bh=rpRBWVBaqmeYGErvSJjv0zKZWE8QSyinu2dYEyNFBDg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YTuVd0IILiS1SR0qHeV7JG1fzQSBip1OghYNgorGdns01kp3ED5okm8oyOwUlaVEVIhD2ytAit6TfP9HunoRmx2OO99qufGX9iUz1b2jyojjyma23MOXuLE7ZPbO4M7hD1EBMgRKEBf5+cCS9d3ZPVtJjIR8Nwd9HP+z0+6/YKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7207C1007;
	Fri, 22 Mar 2024 03:33:08 -0700 (PDT)
Received: from e129166.arm.com (unknown [10.57.71.57])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E61823F64C;
	Fri, 22 Mar 2024 03:32:31 -0700 (PDT)
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
Subject: [PATCH v2 0/4] Update Energy Model after chip binning adjusted voltages
Date: Fri, 22 Mar 2024 10:32:17 +0000
Message-Id: <20240322103221.47594-1-lukasz.luba@arm.com>
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


