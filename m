Return-Path: <linux-kernel+bounces-100104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D477C8791D7
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 11:24:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7350E1F22CD1
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 10:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3389579945;
	Tue, 12 Mar 2024 10:23:43 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE5E5AD53;
	Tue, 12 Mar 2024 10:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710239022; cv=none; b=EHnSvxNXJS1TmB1/NyCNHCphayeafGprGTaPWmterkmVIrbb2b8fURy7/I4uepIO9Lo9+I7OuJGFxAyM22bHZGfC/5IfQM0ctzbqFa7iUxK5nWBcD2K6sNX9oJ7vNXWRk2s1NiFeHxYdxtNLZFrbPuMDdJwiCRDfrXar6CUxnqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710239022; c=relaxed/simple;
	bh=KwfhyoWqVtNfejQX5OWX8JcdEe04vFs6xiI5GVCF60s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=obZlks42fLKRWllAhL8ASFhwGETpOIYIX1ry5Gpy3nqpm2sjyVtoxe1wEA6PHw3am3I72S/uGl8plJ0msMqCHEvyGmxxyHGpcVsMUaHHZJNKNIr3o25Onye67Wa+GadB53rgpeaHpVMR+dRIccVVcV55AqgVxfPrV9FvNj/jtIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3E6141570;
	Tue, 12 Mar 2024 03:24:17 -0700 (PDT)
Received: from a077893.arm.com (unknown [10.163.52.80])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 69E5F3F73F;
	Tue, 12 Mar 2024 03:23:34 -0700 (PDT)
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: linux-arm-kernel@lists.infradead.org,
	suzuki.poulose@arm.com
Cc: Anshuman Khandual <anshuman.khandual@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Mike Leach <mike.leach@linaro.org>,
	James Clark <james.clark@arm.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	coresight@lists.linaro.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Hanjun Guo <guohanjun@huawei.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Leo Yan <leo.yan@linaro.org>
Subject: [PATCH V6 01/11] coresight: etm4x: Fix unbalanced pm_runtime_enable()
Date: Tue, 12 Mar 2024 15:53:08 +0530
Message-Id: <20240312102318.2285165-2-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240312102318.2285165-1-anshuman.khandual@arm.com>
References: <20240312102318.2285165-1-anshuman.khandual@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is an unbalanced pm_runtime_enable() in etm4_probe_platform_dev()
when etm4_probe() fails. This problem can be observed via the coresight
etm4 module's (load -> unload -> load) sequence when etm4_probe() fails
in etm4_probe_platform_dev().

[   63.379943] coresight-etm4x 7040000.etm: Unbalanced pm_runtime_enable!
[   63.393630] coresight-etm4x 7140000.etm: Unbalanced pm_runtime_enable!
[   63.407455] coresight-etm4x 7240000.etm: Unbalanced pm_runtime_enable!
[   63.420983] coresight-etm4x 7340000.etm: Unbalanced pm_runtime_enable!
[   63.420999] coresight-etm4x 7440000.etm: Unbalanced pm_runtime_enable!
[   63.441209] coresight-etm4x 7540000.etm: Unbalanced pm_runtime_enable!
[   63.454689] coresight-etm4x 7640000.etm: Unbalanced pm_runtime_enable!
[   63.474982] coresight-etm4x 7740000.etm: Unbalanced pm_runtime_enable!

This fixes the above problem - with an explicit pm_runtime_disable() call
when etm4_probe() fails during etm4_probe_platform_dev().

Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: Hanjun Guo <guohanjun@huawei.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Mike Leach <mike.leach@linaro.org>
Cc: James Clark <james.clark@arm.com>
Cc: Leo Yan <leo.yan@linaro.org>
Cc: linux-acpi@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Cc: coresight@lists.linaro.org
Fixes: 5214b563588e ("coresight: etm4x: Add support for sysreg only devices")
Reviewed-by: James Clark <james.clark@arm.com>
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 drivers/hwtracing/coresight/coresight-etm4x-core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
index c2ca4a02dfce..06a9b94b8c13 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
@@ -2213,6 +2213,9 @@ static int etm4_probe_platform_dev(struct platform_device *pdev)
 	ret = etm4_probe(&pdev->dev);
 
 	pm_runtime_put(&pdev->dev);
+	if (ret)
+		pm_runtime_disable(&pdev->dev);
+
 	return ret;
 }
 
-- 
2.25.1


