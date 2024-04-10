Return-Path: <linux-kernel+bounces-138924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AB1C89FC0D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 17:55:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7322B2847B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 15:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DDD1174ECB;
	Wed, 10 Apr 2024 15:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f6ifsRoi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 985C216F294;
	Wed, 10 Apr 2024 15:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712764441; cv=none; b=p27HLb8eVDRrx1UJGkhAk+U8aJqF0onilg83l36ON+7chrGgQNVB6wW35lnMc47AeYQja9UVJLB4tdByb796LiwePoXApPEjPcBb67wlv+Gqdo5sqpvq8lqGv2CxiqL64wJXOUcak4DGzAZoFpMUiUDSz8x2VdnsShnWqysfHbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712764441; c=relaxed/simple;
	bh=ctRr+IlVWcfFmfsjrpW+tUnJ9yE0+o172fyr+p/k0XQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sK78kpthMjOHoOvfH54m91X5F/MR6VD6V6eUgTQwIrXv+J+sOVMup5BxM48b/s6C5HKT//RBm4GUTRJbIyam1Qk5RqTQkdV01nJlvIzdh/rcXjljtkS6BRSsW3USvvEGEMTyRAl4doATy+5V7OLEBd1cFm5LG/Gbubsv0Hf5LwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f6ifsRoi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30A03C433C7;
	Wed, 10 Apr 2024 15:53:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712764441;
	bh=ctRr+IlVWcfFmfsjrpW+tUnJ9yE0+o172fyr+p/k0XQ=;
	h=From:To:Cc:Subject:Date:From;
	b=f6ifsRoiretJl1hnk7PuD5yEtHGyIBtPVzQZtT26J8HqKfBDH+TJmy6ooCcuNp4++
	 rP7+asL5C5J3h5WC1sEOzPXQ3DDdTbCqUXIt4sNdALtIS8wffHnZDU80A32tj6OQAR
	 PswUGifLmZndNaGk1w1BiQEbo+TG7b6lRZoEgd26kDnABw5402kIatCJg8CrfOqQMJ
	 V9iQOqBSn6VdrGUDXOxxwhs2VMrh6HRqFi7eAV5GyU1TZrdJiy+FXgJ9jf0GsDOBns
	 LmBt4A2wEHhg3NBj7ocmJHw3s2pbMxUEDNJxwsYigCQy3woBlmKjzl2vn6xUheGRhm
	 PIixNhmU2NVYA==
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH] clk: qcom: fix module autoloading
Date: Wed, 10 Apr 2024 17:53:56 +0200
Message-Id: <20240410155356.224098-1-krzk@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add MODULE_DEVICE_TABLE(), so modules could be properly autoloaded
based on the alias from of_device_id table.  Clocks are considered core
components, so usually they are built-in, however these can be built and
used as modules on some generic kernel.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/clk/qcom/gcc-msm8917.c | 1 +
 drivers/clk/qcom/gcc-msm8953.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/clk/qcom/gcc-msm8917.c b/drivers/clk/qcom/gcc-msm8917.c
index f2dd132e2fb1..f2b8729e4198 100644
--- a/drivers/clk/qcom/gcc-msm8917.c
+++ b/drivers/clk/qcom/gcc-msm8917.c
@@ -3278,6 +3278,7 @@ static const struct of_device_id gcc_msm8917_match_table[] = {
 	{ .compatible = "qcom,gcc-qm215", .data = &gcc_qm215_desc },
 	{},
 };
+MODULE_DEVICE_TABLE(of, gcc_msm8917_match_table);
 
 static struct platform_driver gcc_msm8917_driver = {
 	.probe = gcc_msm8917_probe,
diff --git a/drivers/clk/qcom/gcc-msm8953.c b/drivers/clk/qcom/gcc-msm8953.c
index 68359534ff25..7563bff58118 100644
--- a/drivers/clk/qcom/gcc-msm8953.c
+++ b/drivers/clk/qcom/gcc-msm8953.c
@@ -4227,6 +4227,7 @@ static const struct of_device_id gcc_msm8953_match_table[] = {
 	{ .compatible = "qcom,gcc-msm8953" },
 	{},
 };
+MODULE_DEVICE_TABLE(of, gcc_msm8953_match_table);
 
 static struct platform_driver gcc_msm8953_driver = {
 	.probe = gcc_msm8953_probe,
-- 
2.34.1


