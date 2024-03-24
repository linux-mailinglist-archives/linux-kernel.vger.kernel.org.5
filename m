Return-Path: <linux-kernel+bounces-114420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 74499888A63
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:17:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F79B28B695
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12F791774C2;
	Sun, 24 Mar 2024 23:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MZ4SWYRV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D62D140373;
	Sun, 24 Mar 2024 23:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321835; cv=none; b=fV8ky1sFXz4hXLiCuy3plMoCQ0aLDpLrcVSN/M1RuOCq9Hg4dQ3VUvVJoG6KZECbJPXStL/t2jwowNIEwvuPbA8i6X5432/7yk+CFedh2uo+Mv0Pja0Tz/iXxo3aHqsNAL5T8aj+lK7PB1SdLKE0C9s/NwiHcx09yO1yLCE6D70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321835; c=relaxed/simple;
	bh=EI070SEdZAysYm5J4a8toMZ9Zme6VUT+jP6dFrcVgDU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pz7hLuSTP/tPPQI3l+HtvGhrXuDN+5TYe8ZrsxUeLbJ7uAmUlbyuIns5xoEd3myUSHUbhU+FRBJ1LAVzhMm2S9bG1R/U2LrtO1MWMlsX2hEykHy71shfhNmWSxPiN8umwByxpfDpUESusvgCs0k/h9C3cySU3gkvYcDP7GuM//k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MZ4SWYRV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBA83C43609;
	Sun, 24 Mar 2024 23:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321835;
	bh=EI070SEdZAysYm5J4a8toMZ9Zme6VUT+jP6dFrcVgDU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MZ4SWYRVkduZCA//iabHVy2J1aA/ogwS6kq773KsFiFQxRFm/+lerZwgtoJMddxqc
	 acIrp1E+cK1BuNShaN0NYoIXnsbHsZ6C2BnWN8xsoINRHxnx3BXGlHg0NnMDJGNd9p
	 pQodnMdhmSTQr+M19ywId3085x+SHVJs9lR6ego6DBjnlQSL7C+C2irJVLfFOb/UJM
	 WyNCHOLcfztd4IjpXWRIM2c+bYA4JDVbQjkpduTTsiZt/V/X4HRosduKgAi6mZDPBC
	 sm96s8pEBI5o0eU/zle+9IylPrcaUAvhTL0gOfIiA/kZ0+nImQlyT4Hdj/PdPbDGnM
	 1zbUriw8Ii/UQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Mao Jinlong <quic_jinlmao@quicinc.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 564/638] coresight: etm4x: Set skip_power_up in etm4_init_arch_data function
Date: Sun, 24 Mar 2024 19:00:01 -0400
Message-ID: <20240324230116.1348576-565-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
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


