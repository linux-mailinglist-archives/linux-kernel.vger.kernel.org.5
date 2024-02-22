Return-Path: <linux-kernel+bounces-76782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 805E985FC7F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 16:35:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 349E2286753
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 15:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78C0714D43F;
	Thu, 22 Feb 2024 15:35:19 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFC97482D4;
	Thu, 22 Feb 2024 15:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708616119; cv=none; b=XTweH4rOKKUaAjwFgYAsrq+A+iGaEuPl/iulDXYR0qq9sgmyskZ40u7ks6O7pAY9tVqYdCMJsFyGecUGdbpRa/AXm5bg4Wo5UMyngpcX+DHmJxke+9i9HfVDPD7ymSSEbHIGzjCUWLcCp/7XlfqLZ9nHK49Jkht/3tnSJKbcpHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708616119; c=relaxed/simple;
	bh=bPZ0EsvB/HpMkcILAej/qoie7uL1Sv2IdnR6MjR097E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mZJz50yr1ORolvIRgvuOjGsrgm28zxL0DZvkUCbOry0cCyZs0ngtKijowKm0+Nmy7hu51px+5xAB7eL1GMWurqtkeZ3sAwVbn5gqFKx0hno1g+BMhyGdYoD+EJr4MsOKcpx1G48bJrcW164KKvG/OjzXltOjJBSQ7/EQnLq35QU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AFCCFDA7;
	Thu, 22 Feb 2024 07:35:54 -0800 (PST)
Received: from e126645.arm.com (unknown [10.57.50.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 93F4B3F762;
	Thu, 22 Feb 2024 07:35:14 -0800 (PST)
From: Pierre Gondois <pierre.gondois@arm.com>
To: linux-kernel@vger.kernel.org
Cc: Qais Yousef <qyousef@layalina.io>,
	Pierre Gondois <pierre.gondois@arm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	linux-pm@vger.kernel.org
Subject: [PATCH] cpufreq: Remove references to 10ms min sampling rate
Date: Thu, 22 Feb 2024 16:34:15 +0100
Message-Id: <20240222153415.2088039-1-pierre.gondois@arm.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A minimum sampling rate value of 10ms was introduced in:
commit cef9615a853e ("[CPUFREQ] ondemand: Uncouple minimal sampling rate from HZ in NO_HZ case")

The use of this value was removed in:
commit ed4676e25463 ("cpufreq: Replace "max_transition_latency" with "dynamic_switching"")

Remove:
- a comment referencing this value
- an unused macro associated to this value

Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
---
 drivers/cpufreq/cpufreq_ondemand.c | 1 -
 include/linux/cpufreq.h            | 4 +---
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_ondemand.c b/drivers/cpufreq/cpufreq_ondemand.c
index c52d19d67557..a7c38b8b3e78 100644
--- a/drivers/cpufreq/cpufreq_ondemand.c
+++ b/drivers/cpufreq/cpufreq_ondemand.c
@@ -22,7 +22,6 @@
 #define DEF_SAMPLING_DOWN_FACTOR		(1)
 #define MAX_SAMPLING_DOWN_FACTOR		(100000)
 #define MICRO_FREQUENCY_UP_THRESHOLD		(95)
-#define MICRO_FREQUENCY_MIN_SAMPLE_RATE		(10000)
 #define MIN_FREQUENCY_UP_THRESHOLD		(1)
 #define MAX_FREQUENCY_UP_THRESHOLD		(100)
 
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index 8b9026031a28..625949a1869d 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -568,9 +568,7 @@ static inline unsigned long cpufreq_scale(unsigned long old, u_int div,
 
 /*
  * The polling frequency depends on the capability of the processor. Default
- * polling frequency is 1000 times the transition latency of the processor. The
- * ondemand governor will work on any processor with transition latency <= 10ms,
- * using appropriate sampling rate.
+ * polling frequency is 1000 times the transition latency of the processor.
  */
 #define LATENCY_MULTIPLIER		(1000)
 
-- 
2.25.1


