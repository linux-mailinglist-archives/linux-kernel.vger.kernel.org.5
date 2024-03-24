Return-Path: <linux-kernel+bounces-113508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5B658884E0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:53:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E10A28345F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01A011BB73C;
	Sun, 24 Mar 2024 22:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D5XQDGLT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C0C91BB722;
	Sun, 24 Mar 2024 22:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320310; cv=none; b=T9KwYs+B+PT1maKUi6Dhgy3I14CFU+S8QHfRZQRvKGKXRTMVokbbwXIw5ACkpw9pXRgKyr2fDm1NigYGW06r0fAxYuQ+LONuiJVzXOkkJMpXGmOb+VDF9a8xvKYWso82TGbd3D6qWLJovkzyXVYd9SsV0bUTiNtJ8gno6XgkZ7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320310; c=relaxed/simple;
	bh=w4FsLlM85Wl0SqW7LTrVCNiV7Q59gaipye9gyE/smGs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ecsq8YvViIbCR9KXibjSBxSSP3HBe0WRxZHQhMjREXaP+AEleg1ONX2iKUgSF6SEYmArA+Ea5rRFlN7eT3LBAgiBchKfOMpA2/yDDktJD6YOvzEdpiob85s38qbYFy7U/VmjJl8/MOKicJBVYdemKOvyq9Pl33ahaBrjGRyfG+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D5XQDGLT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3598C43394;
	Sun, 24 Mar 2024 22:45:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320309;
	bh=w4FsLlM85Wl0SqW7LTrVCNiV7Q59gaipye9gyE/smGs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=D5XQDGLTEFXdPRCBoUbmtxzsVmcz5cytjWqXRJkvpxDrA/ZfsXAYMz9ogq70rIkTu
	 2n+xBQhTx7NdwHEJqVT1W1UbvzcatmNZ88D0tR2C7jZCBBHDMLbZCdt1Is9uOubGcA
	 g0Fqv8n+yIbb6pozTduRIbbJ5YowiWqvd81bCyQ196LHpXo/uf4wSPJD3lsGSQUt7a
	 xtX84o1jk60rXXl5D9fhn9TGpsBnUlkTedco9urWVQ1ioP6EiuhkFMluYkS5a8KoHh
	 03IzqB86hUyjMm/gbOUkcDpdJRkkH1Z/Nm+Z707eh8BnnpBbgfTULqw+3+qlYPi0N5
	 YDCqZxYWm6NEg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Mao Jinlong <quic_jinlmao@quicinc.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 617/715] coresight: etm4x: Set skip_power_up in etm4_init_arch_data function
Date: Sun, 24 Mar 2024 18:33:16 -0400
Message-ID: <20240324223455.1342824-618-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
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
index ce1995a2827f0..2e2cabc5f50ab 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
@@ -1200,6 +1200,7 @@ static void etm4_init_arch_data(void *info)
 	struct etm4_init_arg *init_arg = info;
 	struct etmv4_drvdata *drvdata;
 	struct csdev_access *csa;
+	struct device *dev = init_arg->dev;
 	int i;
 
 	drvdata = dev_get_drvdata(init_arg->dev);
@@ -1213,6 +1214,10 @@ static void etm4_init_arch_data(void *info)
 	if (!etm4_init_csdev_access(drvdata, csa))
 		return;
 
+	if (!csa->io_mem ||
+	    fwnode_property_present(dev_fwnode(dev), "qcom,skip-power-up"))
+		drvdata->skip_power_up = true;
+
 	/* Detect the support for OS Lock before we actually use it */
 	etm_detect_os_lock(drvdata, csa);
 
@@ -2040,11 +2045,6 @@ static int etm4_add_coresight_dev(struct etm4_init_arg *init_arg)
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


