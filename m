Return-Path: <linux-kernel+bounces-139000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D2B6A89FD43
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 18:41:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 299A2B2A61B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 16:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FAA817BB12;
	Wed, 10 Apr 2024 16:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MzAfAzO8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459A617B506;
	Wed, 10 Apr 2024 16:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712767265; cv=none; b=Mno7W/N+ukyxhHyAPawJKXkPrm2RwcKRtGQS0HF9HJ5XqMX9cRHlVUyTkcEY2XehZL7FWm4QmHyWMO2H2kwoj7MkbcckxYasC8PfRvtC+3dYP1u1E4spm0Cxkcx/BCyX49ocYHGdS3xEpmof6noH2jbUmYWmFRyGCsEkQ1ubw64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712767265; c=relaxed/simple;
	bh=Et8ut1PTjoIL/+lEyWrUuWm3v2h4kx49J+w1J7ps3lQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SarkFvB2p/MiLYk0M1HvoSSNhUMm4Ih7AjahkCXn/Rc1UkJn5rwHfRq8W3bUs5Eg/5trJkSoGAWjT5a/YsVoBr1OPfnYNfki8AMcStvV8bgWRhlkPW5i/KBhiJpTM1ZKwJjHBv8pgsK8TSl+2Mh21pXtvC5f330SnVqAEttiygk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MzAfAzO8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28046C433F1;
	Wed, 10 Apr 2024 16:41:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712767264;
	bh=Et8ut1PTjoIL/+lEyWrUuWm3v2h4kx49J+w1J7ps3lQ=;
	h=From:To:Cc:Subject:Date:From;
	b=MzAfAzO8Cyu614oJieb5qeLwnBKUGWBTDtU+/G1DRguNnY03nqqRsMk5e5kYMqRWo
	 qnLvKRF721tQzmj1pPZiLULczjFP0oC3bE51AuZkKqmKRUf3SaLiTsZoKimxVT6kih
	 kPc+X5XPSNZzd9e6GuLmMGmIuk5naBA5VPGrzTM4TSbSPAJ3NxbWsLJyKtRPunvS6z
	 KyU6GM3Cuy73K7ZUz4WJ85tz/1K0lpwDqb6rM/6londMQJE9MYwCWYQS6yMXi3jHLJ
	 pn/s47bpUlt0sGYNU7CyqurlqScZHHh3D4Stx6Cg0r48T80336gtcUYVDEzbwDi1Ia
	 iAmVk/jwqPNsg==
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	linux-arm-msm@vger.kernel.org,
	linux-remoteproc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH] rpmsg: qcom_glink_ssr: fix module autoloading
Date: Wed, 10 Apr 2024 18:40:58 +0200
Message-Id: <20240410164058.233280-1-krzk@kernel.org>
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
 drivers/rpmsg/qcom_glink_ssr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/rpmsg/qcom_glink_ssr.c b/drivers/rpmsg/qcom_glink_ssr.c
index 39ffa384c9b1..e71d3716c55c 100644
--- a/drivers/rpmsg/qcom_glink_ssr.c
+++ b/drivers/rpmsg/qcom_glink_ssr.c
@@ -154,6 +154,7 @@ static const struct rpmsg_device_id qcom_glink_ssr_match[] = {
 	{ "glink_ssr" },
 	{}
 };
+MODULE_DEVICE_TABLE(rpmsg, qcom_glink_ssr_match);
 
 static struct rpmsg_driver qcom_glink_ssr_driver = {
 	.probe = qcom_glink_ssr_probe,
-- 
2.34.1


