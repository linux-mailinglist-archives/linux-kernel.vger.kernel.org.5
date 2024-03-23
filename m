Return-Path: <linux-kernel+bounces-112200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 006498876E0
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 04:28:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 232A31C22BCD
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 03:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B6E93FC7;
	Sat, 23 Mar 2024 03:28:25 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9CD137E;
	Sat, 23 Mar 2024 03:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711164504; cv=none; b=kXAO3cdnamNp5igzw3QuFQDXGQrMMwuuxFP04q3VdkUvrGyjtSHTW6lIVgdySIqAZAs2OIK6js+8cMkDOhapWzALhpnM7XiG6aciixjzABtQ9FbTjJbcwWh5QwFk5mz/elJipS+Y9xVCeHRid928Gs926B5tGZtyv5VmmTwmHFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711164504; c=relaxed/simple;
	bh=YQxXSiO/xi5uJqLMMMhNqzp0CXbALUoAqqdNPXNm4oc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Me/9olA66meeiSnIy+vFJ4iwG4cmhElcyEail4we7UPA9EKYkV3DzQ8Agm/eKwutx4Bsn1ragCz7TppUoqYhMiJU3h0ZqYA7rr2wSDLOZtyNNFeKjwjzQM4dPGQtALQYA8L/b+CxCjGJwy5tW+OaBOpQd3V+yX3vLQ5lymaQlo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4V1l3M0NCYz1xsCy;
	Sat, 23 Mar 2024 11:26:23 +0800 (CST)
Received: from canpemm500007.china.huawei.com (unknown [7.192.104.62])
	by mail.maildlp.com (Postfix) with ESMTPS id CFE491A0172;
	Sat, 23 Mar 2024 11:28:18 +0800 (CST)
Received: from localhost (10.174.179.215) by canpemm500007.china.huawei.com
 (7.192.104.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Sat, 23 Mar
 2024 11:28:18 +0800
From: Yue Haibing <yuehaibing@huawei.com>
To: <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
	<mturquette@baylibre.com>, <sboyd@kernel.org>, <dmitry.baryshkov@linaro.org>,
	<neil.armstrong@linaro.org>
CC: <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <yuehaibing@huawei.com>
Subject: [PATCH] clk: qcom: Fix SM_GPUCC_8650 dependencies
Date: Sat, 23 Mar 2024 11:28:06 +0800
Message-ID: <20240323032806.14356-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500007.china.huawei.com (7.192.104.62)

CONFIG_SM_GCC_8650 depends on ARM64 but it is selected by
CONFIG_SM_GPUCC_8650, which can be selected on ARM, resulting in a
Kconfig warning.

WARNING: unmet direct dependencies detected for SM_GCC_8650
  Depends on [n]: COMMON_CLK [=y] && COMMON_CLK_QCOM [=y] && (ARM64 || COMPILE_TEST [=n])
  Selected by [m]:
  - SM_GPUCC_8650 [=m] && COMMON_CLK [=y] && COMMON_CLK_QCOM [=y]

Add the same dependencies to CONFIG_SM_GPUCC_8650 to resolve the warning.

Fixes: 8676fd4f3874 ("clk: qcom: add the SM8650 GPU Clock Controller driver")
Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
---
 drivers/clk/qcom/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
index 8ab08e7b5b6c..3e85df1514bd 100644
--- a/drivers/clk/qcom/Kconfig
+++ b/drivers/clk/qcom/Kconfig
@@ -1094,6 +1094,7 @@ config SM_GPUCC_8550
 
 config SM_GPUCC_8650
 	tristate "SM8650 Graphics Clock Controller"
+	depends on ARM64 || COMPILE_TEST
 	select SM_GCC_8650
 	help
 	  Support for the graphics clock controller on SM8650 devices.
-- 
2.34.1


