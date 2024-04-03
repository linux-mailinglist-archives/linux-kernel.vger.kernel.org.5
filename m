Return-Path: <linux-kernel+bounces-129301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE14F896856
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 10:21:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78226288E31
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 08:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75EA113F42E;
	Wed,  3 Apr 2024 08:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dieCWAWH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB05413F425;
	Wed,  3 Apr 2024 08:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712131865; cv=none; b=Lknr5SAy5IBDZYaz7k3mhYeGWqBdz4uP9wTv1RKQBHYYoU1tPbN3KYY7hK9f7+RTJM6ImZp7cwOIldz2WXDmnAn2ZOkx6geyE5k8qU2AtH55HeKtrg3wPMtWDnaT6rpzVoljj8qAjWx1aluyUQKWKcYNSLCd7dYRKU3/INHwgd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712131865; c=relaxed/simple;
	bh=OaBdwzPyJFIVi5jKFEkNH3EGbx1qZe7R5hLgRTGjY10=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FwPPEnQU9zn8JWchAgJiK7yd7v995zwC5an1nO86GxoJfFCz8KpfyIfRc3A2paY5I8dYATlNvvMYynmy5bvp7TkoTqs/yNfYkPRJXZjNIrrwh+LedqtrEBRw/URa2cmsJMVgVP1cf/kVTtll42sEqC4TPQ5NIqVyO5EtPo6TCLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dieCWAWH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15AACC433C7;
	Wed,  3 Apr 2024 08:11:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712131865;
	bh=OaBdwzPyJFIVi5jKFEkNH3EGbx1qZe7R5hLgRTGjY10=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dieCWAWH/t+S3gm1titmmfw34OmJo5p9YVMk9/1Uormtij8W8tceyOmrivytapWsX
	 EWDdidDv0ySuc5gEaYhSAPgVLRs2ay5OrkdfzCCqlCb+/ozQCPOBUcyo5Gj8SmAiE+
	 v69JV3/J0lM/b/yPxxg1aL/52EHjl/ZvZjJKBR03fOfubxUAs/w38qjIVYjbCxSl7D
	 LWM6F9ubJa83zsL/POmMM5MzLOSqHbsmkub6gk323IGZdTBd0uQ+rBmBgVKUuiGidF
	 H5FfNUMRix2ROhta0ylKMDpDda+GsOGdVHaZpiJNo80zxMoscMhJlYyNSIvfAIAM6a
	 /w68aScpztvDQ==
From: Arnd Bergmann <arnd@kernel.org>
To: linux-kernel@vger.kernel.org,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Maximilian Luz <luzmaximilian@gmail.com>,
	Johan Hovold <johan+linaro@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>,
	Guru Das Srinagesh <quic_gurus@quicinc.com>,
	Robert Marko <robimarko@gmail.com>,
	linux-arm-msm@vger.kernel.org
Subject: [PATCH 23/34] firmware: qcom_scm: mark qcom_scm_qseecom_allowlist as __maybe_unused
Date: Wed,  3 Apr 2024 10:06:41 +0200
Message-Id: <20240403080702.3509288-24-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240403080702.3509288-1-arnd@kernel.org>
References: <20240403080702.3509288-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

When CONFIG_OF is disabled, there is no reference to this variable:

drivers/firmware/qcom/qcom_scm.c:1655:34: error: unused variable 'qcom_scm_qseecom_allowlist' [-Werror,-Wunused-const-variable]
static const struct of_device_id qcom_scm_qseecom_allowlist[] = {

Mark it as __maybe_unused to hide this warning.

Fixes: 00b1248606ba ("firmware: qcom_scm: Add support for Qualcomm Secure Execution Environment SCM interface")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/firmware/qcom/qcom_scm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
index 49ddbcab0680..81c15aeff934 100644
--- a/drivers/firmware/qcom/qcom_scm.c
+++ b/drivers/firmware/qcom/qcom_scm.c
@@ -1652,7 +1652,7 @@ EXPORT_SYMBOL_GPL(qcom_scm_qseecom_app_send);
  * We do not yet support re-entrant calls via the qseecom interface. To prevent
  + any potential issues with this, only allow validated machines for now.
  */
-static const struct of_device_id qcom_scm_qseecom_allowlist[] = {
+static const struct of_device_id qcom_scm_qseecom_allowlist[] __maybe_unused = {
 	{ .compatible = "lenovo,thinkpad-x13s", },
 	{ }
 };
-- 
2.39.2


