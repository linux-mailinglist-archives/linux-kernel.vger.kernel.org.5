Return-Path: <linux-kernel+bounces-75020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D70A285E1B1
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 16:45:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C3ECB251FA
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 15:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17A47811FE;
	Wed, 21 Feb 2024 15:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="inS2MZoI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B588060B;
	Wed, 21 Feb 2024 15:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708530303; cv=none; b=oCRT9rHfZBOYqvbWgskL/dp+frsxXTRf5pFxMZXa2FEHiO3yh0s5ifLA+z7AMZkt2Amp6m/MF2aAC/N1FT5Dg2c7mYBZWpoqFZ8mnEqqXpR+KOXZEZ7ipFQpkQHrh9RJATNrBjnFgxgw/qI4BOCxZlOh+1EwD6UXHVrvPvod6yI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708530303; c=relaxed/simple;
	bh=Dx1Syz9O7J+YAvuPHu3WZWipG8gNA1k5VFmM93qyay0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=f3BNrN+R112FhM2bHye12Px2+ozZyKUPWv01RUeUoewxfbIiNrsKOUd2+vuqBrn+5XWY/LIAVyufw3MKWF9zql/k7HoPTzD5aHpXgwP59PsdmgdWM7NXsS8/3bKhOjBuw82cVYPWLNKXMiiiFMUWMpyBxsueNUrmILc/SgpHz1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=inS2MZoI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05F0EC43142;
	Wed, 21 Feb 2024 15:45:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708530302;
	bh=Dx1Syz9O7J+YAvuPHu3WZWipG8gNA1k5VFmM93qyay0=;
	h=From:To:Cc:Subject:Date:From;
	b=inS2MZoI7gFXzSn1OqaDYssIZN6F+jKDv0klzkkRDqjzr1Eid3oa1ab8ohcoq7RHl
	 Ph/53TomNjZqyH/2+MJyw6w6r+vJyEB6H1dVH61lizDeZOD0R8MPh1PDRFYbQ2ubrE
	 //Sr6E2bjoFqGp1iM5t7kSkr/lyBMOnIRtNFD1WyErTmUbx7yYiUnoCyzpH50yMYnO
	 BbUREfBcFRGeWi34XfuyED1VwAbs+m8QLHHp9INeKs4zbx+8VcVdWdHOVmuRMEItML
	 17u4UUbPksP9Q2kWvyM4XoexTdehAa1ZqL5ZKoRIVKxr9RuMpSHhJjMY/cMRSKWamG
	 VYtLGZXxJEwhw==
From: Arnd Bergmann <arnd@kernel.org>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Rob Herring <robh@kernel.org>,
	Yangtao Li <frank.li@vivo.com>,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] soc: qcom: spm: fix building with CONFIG_REGULATOR=n
Date: Wed, 21 Feb 2024 16:44:51 +0100
Message-Id: <20240221154457.2007420-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

The newly added code causes a build failure when -Werror is set:

drivers/soc/qcom/spm.c:388:12: error: 'spm_get_cpu' defined but not used [-Werror=unused-function]

Remove the #ifdef and instead use an IS_ENABLED() check that lets the
compiler perform dead code elimination instead of the preprocessor.

Fixes: 6496dba142f4 ("soc: qcom: spm: add support for voltage regulator")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/soc/qcom/spm.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/soc/qcom/spm.c b/drivers/soc/qcom/spm.c
index 5eefaec72a13..06e2c4c2a4a8 100644
--- a/drivers/soc/qcom/spm.c
+++ b/drivers/soc/qcom/spm.c
@@ -411,7 +411,6 @@ static int spm_get_cpu(struct device *dev)
 	return -EOPNOTSUPP;
 }
 
-#ifdef CONFIG_REGULATOR
 static int spm_register_regulator(struct device *dev, struct spm_driver_data *drv)
 {
 	struct regulator_config config = {
@@ -474,12 +473,6 @@ static int spm_register_regulator(struct device *dev, struct spm_driver_data *dr
 
 	return 0;
 }
-#else
-static int spm_register_regulator(struct device *dev, struct spm_driver_data *drv)
-{
-	return 0;
-}
-#endif
 
 static const struct of_device_id spm_match_table[] = {
 	{ .compatible = "qcom,sdm660-gold-saw2-v4.1-l2",
@@ -559,7 +552,10 @@ static int spm_dev_probe(struct platform_device *pdev)
 	if (drv->reg_data->reg_offset[SPM_REG_SPM_CTL])
 		spm_set_low_power_mode(drv, PM_SLEEP_MODE_STBY);
 
-	return spm_register_regulator(&pdev->dev, drv);
+	if (IS_ENABLED(CONFIG_REGULATOR))
+		return spm_register_regulator(&pdev->dev, drv);
+
+	return 0;
 }
 
 static struct platform_driver spm_driver = {
-- 
2.39.2


