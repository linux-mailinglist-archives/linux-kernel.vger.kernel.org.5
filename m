Return-Path: <linux-kernel+bounces-115555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BE64889D61
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:43:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFD6E2A5494
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:43:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9181E24D438;
	Mon, 25 Mar 2024 02:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SoiRuKQR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6918014B08B;
	Sun, 24 Mar 2024 22:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321064; cv=none; b=SM5Qq8b4pjvdYTdMB8b8YG8dmtc0THivQyukPGiumfkygmtqSle/fLVb7Ym5l2BpcevnElC8t4otXunfo7rYbQ0tvzGHFdG8ZYQot36RHvfK+LfpM+5wcXYOqwjmGwFoUj6oktBjjrFNVc3Cp3pmHdQrbkAeHVBPo4IC1QnzLpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321064; c=relaxed/simple;
	bh=EI070SEdZAysYm5J4a8toMZ9Zme6VUT+jP6dFrcVgDU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WANGi8X4seqnJu8KXdDkBs1PFaU/pYXsVk0nU5cy9ExjhzKx3bBAISi2EQCeytYqarBaupE2th+Nnprbe2E3fJwTuV7cfu7hWfDOgDDXf+GiYlZbd9S50QPOKAxYI0dDmvXmTWhFXzZvcBWSsa36ISOnuVJMT+qKAT+7hf8cBzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SoiRuKQR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0760C43399;
	Sun, 24 Mar 2024 22:57:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321064;
	bh=EI070SEdZAysYm5J4a8toMZ9Zme6VUT+jP6dFrcVgDU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SoiRuKQRghk0KF8WCYA6WEw1OjAJZA4DduXzUKzE4+uPpA1jtfE0AdraTyGvmM3XD
	 /zbtWseC0mntBDXqWHZH2AutO+1M+1HhGlk4ut3exeS0XDqP152E0lUflfZMS2aSV6
	 3rmPNHKqw7KFPn/W26OWYEkj6rOXCUi8FSowwGZsaW3q0hVv78pG2Ln4HhlorP9OdD
	 WCu47J3GLcanT6W2M3CXUbcAVmPXjg989gkSaYkPO/vsnxGMlD9cxnS0v3sMgCqqAE
	 y6Na5L9iRwsb/ll+xx+yN71r0zAmpTapSdA/I/0olEhyCPPPByS9Lj1zkQPluhEk9Q
	 yA4zG1TYkcFZA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Mao Jinlong <quic_jinlmao@quicinc.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 628/713] coresight: etm4x: Set skip_power_up in etm4_init_arch_data function
Date: Sun, 24 Mar 2024 18:45:54 -0400
Message-ID: <20240324224720.1345309-629-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Mao Jinlong <quic_jinlmao@quicinc.com>

[ Upstream commit 1bbe0a247e5d72f723daeecf41596bfa99e199f1 ]

skip_power_up is used in etm4_init_arch_data when set lpoverride. So
need to set the value of it before calling using it.

Fixes: 5214b563588e ("coresight: etm4x: Add support for sysreg only devices")
Signed-off-by: Mao Jinlong <quic_jinlmao@quicinc.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Link: https://lore.kernel.org/r/20240131105423.9519-1-quic_jinlmao@quicinc.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwtracing/coresight/coresight-etm4x-core.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
index 34aee59dd1473..18c4544f60454 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
@@ -1160,6 +1160,7 @@ static void etm4_init_arch_data(void *info)
 	struct etm4_init_arg *init_arg = info;
 	struct etmv4_drvdata *drvdata;
 	struct csdev_access *csa;
+	struct device *dev = init_arg->dev;
 	int i;
 
 	drvdata = dev_get_drvdata(init_arg->dev);
@@ -1173,6 +1174,10 @@ static void etm4_init_arch_data(void *info)
 	if (!etm4_init_csdev_access(drvdata, csa))
 		return;
 
+	if (!csa->io_mem ||
+	    fwnode_property_present(dev_fwnode(dev), "qcom,skip-power-up"))
+		drvdata->skip_power_up = true;
+
 	/* Detect the support for OS Lock before we actually use it */
 	etm_detect_os_lock(drvdata, csa);
 
@@ -1998,11 +2003,6 @@ static int etm4_add_coresight_dev(struct etm4_init_arg *init_arg)
 	if (!drvdata->arch)
 		return -EINVAL;
 
-	/* TRCPDCR is not accessible with system instructions. */
-	if (!desc.access.io_mem ||
-	    fwnode_property_present(dev_fwnode(dev), "qcom,skip-power-up"))
-		drvdata->skip_power_up = true;
-
 	major = ETM_ARCH_MAJOR_VERSION(drvdata->arch);
 	minor = ETM_ARCH_MINOR_VERSION(drvdata->arch);
 
-- 
2.43.0


