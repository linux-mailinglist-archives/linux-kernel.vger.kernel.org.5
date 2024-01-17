Return-Path: <linux-kernel+bounces-28771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 365B08302DF
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 10:56:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB9872868F6
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 09:56:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C706714A8D;
	Wed, 17 Jan 2024 09:56:02 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2B511426F;
	Wed, 17 Jan 2024 09:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705485362; cv=none; b=WwnApGtTg6aKs1VDbHihWDlPghxOUvDuG2oDxdliQ1V7kvUiAUR8uWlLu8Z/a8tY6h27eO7luipgYNXFzrnh+JgZ9WwIueryhStJ4zaBKOMLfllNLvlnr5ILvuidA6f6fo9VanskqLapxeNIbmOuvOBgmYC7CvH1J6epfKdWOCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705485362; c=relaxed/simple;
	bh=ZayO0Ua3VzlrG2IjJFVVL4tVU8Kx3IcLSz8ZLchA0+Q=;
	h=Received:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding; b=jUcL7pS2G9odyXzr7Vb7lm86cgW4nluRTRxDNw+yUuUS56GkgwzlJzIKXGrHYkbHLs7a3I4lli3zbEH2eSUJC7FA3d3yRYZxiGzQtS8MLctdm/lLxvo2plOZO+4SGTgjbTJFls4EazmQNspESTCIt7InGMgGpXx1sTq6rqaxtRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 181AA11FB;
	Wed, 17 Jan 2024 01:56:46 -0800 (PST)
Received: from e129166.arm.com (unknown [10.57.90.139])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 3AC1C3F5A1;
	Wed, 17 Jan 2024 01:55:57 -0800 (PST)
From: Lukasz Luba <lukasz.luba@arm.com>
To: linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	rafael@kernel.org
Cc: lukasz.luba@arm.com,
	dietmar.eggemann@arm.com,
	rui.zhang@intel.com,
	amit.kucheria@verdurent.com,
	amit.kachhap@gmail.com,
	daniel.lezcano@linaro.org,
	viresh.kumar@linaro.org,
	len.brown@intel.com,
	pavel@ucw.cz,
	mhiramat@kernel.org,
	qyousef@layalina.io,
	wvw@google.com,
	xuewen.yan94@gmail.com
Subject: [PATCH v7 01/23] PM: EM: Add missing newline for the message log
Date: Wed, 17 Jan 2024 09:56:52 +0000
Message-Id: <20240117095714.1524808-2-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240117095714.1524808-1-lukasz.luba@arm.com>
References: <20240117095714.1524808-1-lukasz.luba@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix missing newline for the string long in the error code path.

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 kernel/power/energy_model.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
index 7b44f5b89fa1..8b9dd4a39f63 100644
--- a/kernel/power/energy_model.c
+++ b/kernel/power/energy_model.c
@@ -250,7 +250,7 @@ static void em_cpufreq_update_efficiencies(struct device *dev)
 
 	policy = cpufreq_cpu_get(cpumask_first(em_span_cpus(pd)));
 	if (!policy) {
-		dev_warn(dev, "EM: Access to CPUFreq policy failed");
+		dev_warn(dev, "EM: Access to CPUFreq policy failed\n");
 		return;
 	}
 
-- 
2.25.1


