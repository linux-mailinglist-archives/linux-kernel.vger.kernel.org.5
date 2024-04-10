Return-Path: <linux-kernel+bounces-138997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6733489FD44
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 18:41:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 555BFB2B003
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 16:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9182417B502;
	Wed, 10 Apr 2024 16:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gjmHgrer"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D26A517B4F6;
	Wed, 10 Apr 2024 16:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712767252; cv=none; b=SfQShE0L4yQL9k96Yh1UFEekTGD6yJgeOo7mcCa2t0kvZAuZlRfjBz6WSccRh/d4FV3cnxKdgi5bu4t2u7DRaIfcSF6fMW0DzDxh8ZNEn4bGW3OtGEG1+lW0oRQ4YaQEKnxsItMvaPI7SCC9zsJQgcG7wKYOp7sHuTZuQn2XX5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712767252; c=relaxed/simple;
	bh=KOU/+cRYyRbG+aq9HbB97jsGWFQhqt9Ty44V8bZlbPk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jphrGvmKo9HuF7bUJhjpkDG9tskUcytgkONhOPeMrI+5G2y4abNpFm511poozGhhuabdkF785JSlDbSoIGGNthEwixg+QQgKQC5YwkRnNKQUgO3CRse2nPLf8s2QDN8BRIhEiqQD/EplCJFUBBMIs9IqSzdyeVVkfUvkoVOiRz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gjmHgrer; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9213C433F1;
	Wed, 10 Apr 2024 16:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712767252;
	bh=KOU/+cRYyRbG+aq9HbB97jsGWFQhqt9Ty44V8bZlbPk=;
	h=From:To:Cc:Subject:Date:From;
	b=gjmHgreryTVBZftysC0TzayF78ocY0NGgufMFF2gDd9lD0cRA6k+mWSXps4irGXIF
	 uHde2xc2CY6u2Iz2QPOLQbcntNDgOcmTf4RC+ajxXrhxHY8e/S08Anh/oaWqFeHRl0
	 WK5qmOkb6yWd7tlt6F0E3ngxh2Swe0OsWfk+hOvfjcR8RJq2y6v6haUA/Tbw4iHRqr
	 TBolvUC+o5HbR+Sw7sg6tVmvqUGNRiui/mMpmU/+jUAT6FgyNvivCmJH4w6oUAU2UW
	 5KOsZL6E1AqIcFHyu2bNlXMkUvsEedPiu1L1enLmYWj/PgINIDbtgLR/OKCFin/YVI
	 rLp4xG+rEEWfw==
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH] soc: qcom: fix module autoloading
Date: Wed, 10 Apr 2024 18:40:45 +0200
Message-Id: <20240410164045.233198-1-krzk@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add MODULE_DEVICE_TABLE(), so the module could be properly autoloaded
based on the alias from of_device_id table.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/soc/qcom/pmic_pdcharger_ulog.c | 1 +
 drivers/soc/qcom/rpm_master_stats.c    | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/soc/qcom/pmic_pdcharger_ulog.c b/drivers/soc/qcom/pmic_pdcharger_ulog.c
index 238cd38589dc..5f9ea3fe6d6d 100644
--- a/drivers/soc/qcom/pmic_pdcharger_ulog.c
+++ b/drivers/soc/qcom/pmic_pdcharger_ulog.c
@@ -150,6 +150,7 @@ static const struct rpmsg_device_id pmic_pdcharger_ulog_rpmsg_id_match[] = {
 	{ "PMIC_LOGS_ADSP_APPS" },
 	{}
 };
+MODULE_DEVICE_TABLE(rpmsg, pmic_pdcharger_ulog_rpmsg_id_match);
 
 static struct rpmsg_driver pmic_pdcharger_ulog_rpmsg_driver = {
 	.probe = pmic_pdcharger_ulog_rpmsg_probe,
diff --git a/drivers/soc/qcom/rpm_master_stats.c b/drivers/soc/qcom/rpm_master_stats.c
index 9ca13bcf67d3..c5745e20e736 100644
--- a/drivers/soc/qcom/rpm_master_stats.c
+++ b/drivers/soc/qcom/rpm_master_stats.c
@@ -148,6 +148,7 @@ static const struct of_device_id rpm_master_table[] = {
 	{ .compatible = "qcom,rpm-master-stats" },
 	{ },
 };
+MODULE_DEVICE_TABLE(of, rpm_master_table);
 
 static struct platform_driver master_stats_driver = {
 	.probe = master_stats_probe,
-- 
2.34.1


