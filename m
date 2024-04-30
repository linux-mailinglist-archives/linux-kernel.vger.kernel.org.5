Return-Path: <linux-kernel+bounces-163751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FD6F8B6F55
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 12:13:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3BD17B21BF8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 10:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11CA0129A8E;
	Tue, 30 Apr 2024 10:13:42 +0000 (UTC)
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6262127E01;
	Tue, 30 Apr 2024 10:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714472021; cv=none; b=McUlw6Y/1whAn+7hvd7dpH5sXJQVPeBnoH7+qT4WeT5L95BstHRHfwuaCG1oCPoI/LviU+sqgQgDEgF49g1cvzoamR6NzlGbonSsbelcDNZnWFytPnGNnz/7TO+bnggphOWIN2CsiX/QMS/vs178E4yLFTzNxrxZL/KjR9ERN80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714472021; c=relaxed/simple;
	bh=2lCXfA+umKRhdNnXAPu6RvMFY/5jIpKpRctq6cIERzw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VAxng+Jbvi4danpfNP/O5gkC0fN0Tk59mNKBkS+jcpfK+yVwamj6qEBGeHUC/vwiEuD5h7SEdsP+AcqzJPZojSJSHGBHvbPjQ4ok7yw/s1tqBxW0xbyx3spnmEeX6E3AEScRZRYDLoIlNX79muClH+xcVdH6z3sCRUXfhdcto8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4VTGD3169Zz1RDTL;
	Tue, 30 Apr 2024 18:10:27 +0800 (CST)
Received: from dggpemm500018.china.huawei.com (unknown [7.185.36.111])
	by mail.maildlp.com (Postfix) with ESMTPS id 068701A016C;
	Tue, 30 Apr 2024 18:13:37 +0800 (CST)
Received: from huawei.com (10.175.103.91) by dggpemm500018.china.huawei.com
 (7.185.36.111) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 30 Apr
 2024 18:13:36 +0800
From: liwei <liwei728@huawei.com>
To: <rafael@kernel.org>, <lenb@kernel.org>, <Pierre.Gondois@arm.com>,
	<viresh.kumar@linaro.org>
CC: <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<liwei391@huawei.com>, <liwei728@huawei.com>
Subject: [PATCH] cpufreq/cppc: fix perf_to_khz conversion exception
Date: Tue, 30 Apr 2024 18:12:27 +0800
Message-ID: <20240430101227.2133288-1-liwei728@huawei.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500018.china.huawei.com (7.185.36.111)

When the nominal_freq recorded by the kernel is equal to lowest_freq and
the frequency reduction operation is triggered externally, there is a
conversion logic error in cppc_perf_to_khz(), causing the kernel to be
unable to feedback the true frequency.

Fix this by adding the branch processing logic when nominal_freq is equal
to lowest_freq.

Fixes: ec1c7ad47664 ("cpufreq: CPPC: Fix performance/frequency conversion")
Signed-off-by: liwei <liwei728@huawei.com>
---
 drivers/acpi/cppc_acpi.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index a40b6f3946ef..92aac6974e0e 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -1869,9 +1869,15 @@ unsigned int cppc_perf_to_khz(struct cppc_perf_caps *caps, unsigned int perf)
 	u64 mul, div;
 
 	if (caps->lowest_freq && caps->nominal_freq) {
-		mul = caps->nominal_freq - caps->lowest_freq;
+		/* Avoid the special case when nominal_freq is equal to lowest_freq */
+		if (caps->lowest_freq == caps->nominal_freq) {
+			mul = caps->nominal_freq;
+			div = caps->nominal_perf;
+		} else {
+			mul = caps->nominal_freq - caps->lowest_freq;
+			div = caps->nominal_perf - caps->lowest_perf;
+		}
 		mul *= KHZ_PER_MHZ;
-		div = caps->nominal_perf - caps->lowest_perf;
 		offset = caps->nominal_freq * KHZ_PER_MHZ -
 			 div64_u64(caps->nominal_perf * mul, div);
 	} else {
-- 
2.25.1


