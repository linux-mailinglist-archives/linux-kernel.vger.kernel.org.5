Return-Path: <linux-kernel+bounces-66422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E758855C86
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 09:33:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60B5328142D
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 08:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C46E912E6D;
	Thu, 15 Feb 2024 08:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lhw7ewat"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A73171A7;
	Thu, 15 Feb 2024 08:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707986009; cv=none; b=EHWJsIjUs19zMUjMpDGObuZqDvkfbnbmmeANdn7DrBfvn39EtPyzAEqrrkq+8pUjJ7yH08/l4LJ2b6URrR1rHIQ57kG3D0BaO1lvo1ZiaMpSre+flH5Ssp2FdcGigrS5Tg3+CUbkc3OLKEx/r1DYNX9GtYa9BMF5pEyIgTOET3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707986009; c=relaxed/simple;
	bh=ATjsM1v1rtS8D/Phyv7flUsDtfA5NO7irfbWAKzdNXs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=e8Xl5ZLYzht9vGiM7qfPHaSrMDZQmTr++bdHtJ3lqJxgvCAKWhOhWqgVO1828FB0IqVMKMXrzPThx4IDdx7ATLHOPmIoh1s8JxdUwU5YxSL8D4S3KCNYi+yS3mjvplxrJTWAiXmx/lmT4eBSewIfInqJyuxDz4Trjx/kaW9bhDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lhw7ewat; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30A97C433F1;
	Thu, 15 Feb 2024 08:33:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707986008;
	bh=ATjsM1v1rtS8D/Phyv7flUsDtfA5NO7irfbWAKzdNXs=;
	h=From:To:Cc:Subject:Date:From;
	b=Lhw7ewatBIg8dmBvwogTtKZnJQY2QT/5QEdoQ/yUTf7x1G2+OroRp6XUj4dhwmRrO
	 RT9pjrBxbsN3tYav+1VUtOqAWIgjZWbmfRaPIiQ32J9J1Xda5X2bwLuG92bcFcW27o
	 Js4TXZekrA49gXaYuwqlyFXx0/8E8LPaiY1ufYNuDNKzVNWQ8IMRtT0zmUPqfnYroA
	 lZdkESi/UVMm5pqf+VePcLfh9+BCl14xoXuKtxajN8jcaRxtd2KK748eSQDuW/Nn8G
	 4ACJTzjqMgaUwBEpzBvBg1ai/xDP4BDuolhh6Ar9Wk52rdhnk1N3xdRO0nSqOpRiXI
	 wXzJdxmk7Py6A==
From: Arnd Bergmann <arnd@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Xiu Jianfeng <xiujianfeng@huawei.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	Jingyu Wang <jingyuwang_vip@163.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] cpufreq: qcom-hw: add CONFIG_COMMON_CLK dependency
Date: Thu, 15 Feb 2024 09:33:14 +0100
Message-Id: <20240215083322.4002782-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

It is still possible to compile-test a kernel without CONFIG_COMMON_CLK
for some ancient ARM boards or other architectures, but this causes a
link failure in the qcom-cpufreq-hw driver:

ERROR: modpost: "devm_clk_hw_register" [drivers/cpufreq/qcom-cpufreq-hw.ko] undefined!
ERROR: modpost: "devm_of_clk_add_hw_provider" [drivers/cpufreq/qcom-cpufreq-hw.ko] undefined!
ERROR: modpost: "of_clk_hw_onecell_get" [drivers/cpufreq/qcom-cpufreq-hw.ko] undefined!

Add a Kconfig dependency here to make sure this always work. Apparently
this bug has been in the kernel for a while without me running into it
on randconfig builds as COMMON_CLK is almost always enabled.

I have cross-checked by building an allmodconfig kernel with COMMON_CLK
disabled, which showed no other driver having this problem.

Fixes: 4370232c727b ("cpufreq: qcom-hw: Add CPU clock provider support")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/cpufreq/Kconfig.arm | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
index f911606897b8..a0ebad77666e 100644
--- a/drivers/cpufreq/Kconfig.arm
+++ b/drivers/cpufreq/Kconfig.arm
@@ -173,6 +173,7 @@ config ARM_QCOM_CPUFREQ_NVMEM
 config ARM_QCOM_CPUFREQ_HW
 	tristate "QCOM CPUFreq HW driver"
 	depends on ARCH_QCOM || COMPILE_TEST
+	depends on COMMON_CLK
 	help
 	  Support for the CPUFreq HW driver.
 	  Some QCOM chipsets have a HW engine to offload the steps
-- 
2.39.2


