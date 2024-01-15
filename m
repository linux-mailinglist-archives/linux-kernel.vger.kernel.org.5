Return-Path: <linux-kernel+bounces-26585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0071D82E3D9
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 00:40:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A19961F24E6C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 23:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1114022F1D;
	Mon, 15 Jan 2024 23:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qNMYPzU2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CBB91B952;
	Mon, 15 Jan 2024 23:28:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15811C433C7;
	Mon, 15 Jan 2024 23:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705361305;
	bh=nRA6/zOt2XFjcIKDedy6Jy81KL9baOfv490eNKYrqFM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qNMYPzU2ni+n2XLPMwRXlFrs7Vho/KTl28Mmp3oC7suohWiHaWoIXyVXiIhPK30ur
	 i0I2hI3pXOJUix9rACFHcV1VvLMuIeqK82VvX0iyZtOJwPWunpcyiZk0GiRZlyJ3go
	 QAi7DhIIPdzkBwN8YsXasPqMvrjcQkmDc81tpXFOhtrpK6n7e/qDZE7tAmeIKDF04d
	 N7SaWmf8US2xbothP7lmqBuoB4DrcRIoKmA+WMWriBf5IYe1sQ7X7z9GtujC3leXaQ
	 jELarg0KmV4FsPyRcdMQQmN8c0ASMHCHVmD+cksr1fi6Fg3XKTtCUh0F7TuFXju9F3
	 caxikNfLzs7Hw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>,
	Will Deacon <will@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	catalin.marinas@arm.com,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 03/10] drivers/perf: pmuv3: don't expose SW_INCR event in sysfs
Date: Mon, 15 Jan 2024 18:27:52 -0500
Message-ID: <20240115232818.210010-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240115232818.210010-1-sashal@kernel.org>
References: <20240115232818.210010-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.208
Content-Transfer-Encoding: 8bit

From: Mark Rutland <mark.rutland@arm.com>

[ Upstream commit ca6f537e459e2da4b331fe8928d1a0b0f9301f42 ]

The SW_INCR event is somewhat unusual, and depends on the specific HW
counter that it is programmed into. When programmed into PMEVCNTR<n>,
SW_INCR will count any writes to PMSWINC_EL0 with bit n set, ignoring
writes to SW_INCR with bit n clear.

Event rotation means that there's no fixed relationship between
perf_events and HW counters, so this isn't all that useful.

Further, we program PMUSERENR.{SW,EN}=={0,0}, which causes EL0 writes to
PMSWINC_EL0 to be trapped and handled as UNDEFINED, resulting in a
SIGILL to userspace.

Given that, it's not a good idea to expose SW_INCR in sysfs. Hide it as
we did for CHAIN back in commit:

  4ba2578fa7b55701 ("arm64: perf: don't expose CHAIN event in sysfs")

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Will Deacon <will@kernel.org>
Link: https://lore.kernel.org/r/20231204115847.2993026-1-mark.rutland@arm.com
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/kernel/perf_event.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
index cdb3d4549b3a..8e428f8dd108 100644
--- a/arch/arm64/kernel/perf_event.c
+++ b/arch/arm64/kernel/perf_event.c
@@ -171,7 +171,11 @@ armv8pmu_events_sysfs_show(struct device *dev,
 	}).attr.attr)
 
 static struct attribute *armv8_pmuv3_event_attrs[] = {
-	ARMV8_EVENT_ATTR(sw_incr, ARMV8_PMUV3_PERFCTR_SW_INCR),
+	/*
+	 * Don't expose the sw_incr event in /sys. It's not usable as writes to
+	 * PMSWINC_EL0 will trap as PMUSERENR.{SW,EN}=={0,0} and event rotation
+	 * means we don't have a fixed event<->counter relationship regardless.
+	 */
 	ARMV8_EVENT_ATTR(l1i_cache_refill, ARMV8_PMUV3_PERFCTR_L1I_CACHE_REFILL),
 	ARMV8_EVENT_ATTR(l1i_tlb_refill, ARMV8_PMUV3_PERFCTR_L1I_TLB_REFILL),
 	ARMV8_EVENT_ATTR(l1d_cache_refill, ARMV8_PMUV3_PERFCTR_L1D_CACHE_REFILL),
-- 
2.43.0


