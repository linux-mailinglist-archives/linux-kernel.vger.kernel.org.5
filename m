Return-Path: <linux-kernel+bounces-100609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B2D1879AB7
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 18:36:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC15228709A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 17:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A47713B280;
	Tue, 12 Mar 2024 17:34:44 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3495F13AA38;
	Tue, 12 Mar 2024 17:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710264883; cv=none; b=lYCyDe8iZBX4TLjJsjX7jETfujluIdpW0qtakZ75nUNLs3ebDbedqCM5UZmAsn0UVr9ZPddSfGrUs+Oz9PdDEGOI6YZoUBq/js4vhaL6b4jYpo3OWNhZOurMyv5f6I58hOs3CV9RZK1ZqqktdZ6opqgkUdHz4PD1ZpyHfuOPhM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710264883; c=relaxed/simple;
	bh=d9eYuC/0QjnZWpRuO8xv/IzmP7HaTLBEEZ80UNZvfK0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=p7U/gsFAvEN9jMnTT1ZS9timStV0VGVqPSQ9QCxThpGoewcg3uLLisMWD41o8nlYJch5P19P+49ZjrYZ3fc7owzseWMaLE2NEMPmptdIIlMp5HS1LHxc454mGZEeiuy+MzelVFQVDF+fglUjLjE1jvlrg8AKAW1rY/dN2vj3AAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EEE1815BF;
	Tue, 12 Mar 2024 10:35:18 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B3A223F762;
	Tue, 12 Mar 2024 10:34:39 -0700 (PDT)
From: Robin Murphy <robin.murphy@arm.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Will Deacon <will@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	x86@kernel.org,
	linux-perf-users@vger.kernel.org,
	jialong.yang@shingroup.cn
Subject: [PATCH 07/10] perf: Define common uncore capabilities
Date: Tue, 12 Mar 2024 17:34:09 +0000
Message-Id: <8496411b6ae9306b70cb90edafa4134b113a3cfe.1710257512.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.39.2.101.g768bb238c484.dirty
In-Reply-To: <cover.1710257512.git.robin.murphy@arm.com>
References: <cover.1710257512.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Nearly all uncore/system PMUs share a common set of capbilities,
so let's wrap those up in a single macro for ease of use.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 include/linux/perf_event.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index b1fd832ed8bf..5d5db122005b 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -293,6 +293,9 @@ struct perf_event_pmu_context;
 #define PERF_PMU_CAP_EXTENDED_HW_TYPE		0x0100
 #define PERF_PMU_CAP_NO_COMMON_EVENTS		0x0200
 
+#define PERF_PMU_UNCORE_CAPS \
+(PERF_PMU_CAP_NO_SAMPLING| PERF_PMU_CAP_NO_EXCLUDE | PERF_PMU_CAP_NO_COMMON_EVENTS)
+
 struct perf_output_handle;
 
 #define PMU_NULL_DEV	((void *)(~0UL))
-- 
2.39.2.101.g768bb238c484.dirty


