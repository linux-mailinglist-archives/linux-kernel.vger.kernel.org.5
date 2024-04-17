Return-Path: <linux-kernel+bounces-148259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C54E18A7FF5
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 11:40:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2AC67B21379
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 09:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6384B13BC1A;
	Wed, 17 Apr 2024 09:39:06 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6DAE13B2AD
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 09:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713346746; cv=none; b=QXJt33mahXNB5FD8zy5K5DfzWztPRUqhXdip4/BjT/QSzI6GLgHilXXIAbfiKXHMLQ/SljGO7LlAhtFH/I3mJlrE3NVvaRuQGOD6qBDPoAsohORHa8UsAJ3PuI8JllSImG5OEQFzpnSGqeh3YaN0J9ZlLQjh5OFYP7M9KkgqVTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713346746; c=relaxed/simple;
	bh=rm5gnrW6WxA+AIgPz7xS8aswy3kAdWUF9mo+gESmArA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PmHrPql0qB/pcQZoEkzQvgVCKUYy+sV5B1QYqFgBrG84QQCiiwZWGJTRcG8T41MB/fPbYKpikjTu3qDHjmbTlz+y3dfNypPDuEQQI9V4Uxn2yR06xs00pi1ebadChQF3y/383jyH3pu1B8taFXU6YDJ5E7uNX/Vw1Zx7fn+dObY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3870B1477;
	Wed, 17 Apr 2024 02:39:32 -0700 (PDT)
Received: from e125905.cambridge.arm.com (e125905.cambridge.arm.com [10.1.194.73])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 808E13F64C;
	Wed, 17 Apr 2024 02:39:02 -0700 (PDT)
From: Beata Michalska <beata.michalska@arm.com>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	ionela.voinescu@arm.com,
	vanshikonda@os.amperecomputing.com
Cc: sudeep.holla@arm.com,
	will@kernel.org,
	catalin.marinas@arm.com,
	vincent.guittot@linaro.org,
	sumitg@nvidia.com,
	yang@os.amperecomputing.com,
	lihuisong@huawei.com,
	viresh.kumar@linaro.org
Subject: [PATCH v5 2/5] arm64: amu: Rule out potential use after free
Date: Wed, 17 Apr 2024 10:38:45 +0100
Message-Id: <20240417093848.1555462-3-beata.michalska@arm.com>
In-Reply-To: <20240417093848.1555462-1-beata.michalska@arm.com>
References: <20240417093848.1555462-1-beata.michalska@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For the time being, the amu_fie_cpus cpumask is being exclusively used
by the AMU-related internals of FIE support and is guaranteed to be
valid on every access currently made. Still the mask is not being
invalidated on one of the error handling code paths, which leaves
a soft spot with potential risk of uaf for CPUMASK_OFFSTACK cases.
To make things sound, set the cpumaks pointer explicitly to NULL upon
failing to register the cpufreq notifier.
Note that, due to the quirks of CPUMASK_OFFSTACK, this change needs to
be wrapped with grim ifdefing (it would be better served by
incorporating this into free_cpumask_var ...)

Signed-off-by: Beata Michalska <beata.michalska@arm.com>
---
 arch/arm64/kernel/topology.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
index 1a2c72f3e7f8..3c814a278534 100644
--- a/arch/arm64/kernel/topology.c
+++ b/arch/arm64/kernel/topology.c
@@ -244,8 +244,12 @@ static int __init init_amu_fie(void)
 
 	ret = cpufreq_register_notifier(&init_amu_fie_notifier,
 					CPUFREQ_POLICY_NOTIFIER);
-	if (ret)
+	if (ret) {
 		free_cpumask_var(amu_fie_cpus);
+#ifdef CONFIG_CPUMASK_OFFSTACK
+		amu_fie_cpus = NULL;
+#endif
+	}
 
 	return ret;
 }
-- 
2.25.1


