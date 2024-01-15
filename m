Return-Path: <linux-kernel+bounces-26574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C8B3A82E3BE
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 00:37:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68E5F1F239D5
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 23:37:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AF85219F4;
	Mon, 15 Jan 2024 23:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uvaND2n0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E56E221A01;
	Mon, 15 Jan 2024 23:27:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 557ABC43399;
	Mon, 15 Jan 2024 23:27:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705361248;
	bh=/mtGC3dAeGirAxx76w0zBinixbRGMNd/NfUpbG8wlkk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uvaND2n01NQXbjcusfoOfiUXhaeN/6tjaYSFbmQe7fZhAvWX74gCml0UlfU/4TjFT
	 CXUExBJFyevFjmOTgby2p7jKv8b3mtAHiisjvNFYX/xgC8Iv/p5WVJQAMHeZ8g3bBd
	 MS2uU7PSU5EvaNUYIkMNVywFs5HwWizybohISHaJkpBnbLwRGoShN+1KI3jQrZzPVa
	 ssnuMDZO7UJy1eNvpeQWxAWv4PFASWN81bChz0b4Jnfao6WpLxjE7SNB+s5rvKduur
	 jcK7TOZeq+NIlftJQ7hDGpMSG74Hb9K785+W5kYtfHnWRe6EsVB42JgURh/Hn2sKFk
	 7UlEz315KGACQ==
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
Subject: [PATCH AUTOSEL 5.15 04/12] drivers/perf: pmuv3: don't expose SW_INCR event in sysfs
Date: Mon, 15 Jan 2024 18:26:49 -0500
Message-ID: <20240115232718.209642-4-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240115232718.209642-1-sashal@kernel.org>
References: <20240115232718.209642-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.147
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
index b4044469527e..c77b9460d63e 100644
--- a/arch/arm64/kernel/perf_event.c
+++ b/arch/arm64/kernel/perf_event.c
@@ -168,7 +168,11 @@ armv8pmu_events_sysfs_show(struct device *dev,
 	PMU_EVENT_ATTR_ID(name, armv8pmu_events_sysfs_show, config)
 
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


