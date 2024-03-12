Return-Path: <linux-kernel+bounces-100289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7163B879516
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 14:25:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1152DB2405B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 13:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0A517A727;
	Tue, 12 Mar 2024 13:25:36 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84B3C5820A;
	Tue, 12 Mar 2024 13:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710249936; cv=none; b=neiVOsvrtwShF0AjMJ526/GRuj5YLuN2KsQF+08/yjCfV9X9+qZUAhrSrtvCZU/MX2K9CMqTe+eMHy77EpGUg+epgskxH3D56/cf+y3/traFk6dXinYYutFI6F1Yl909xtLBM54QxweKqMADRnoz3YsAeRGsSIMx+qaJnM3iuIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710249936; c=relaxed/simple;
	bh=h0F/trfAXXYdqEzqin5+0bJCK93Ym81jka9vQjFNIrs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WfvYk3huILrTFR5DxVddnerCL6dwM+tp8aLNseCs7b4hmVyaxM6Bc5s8GTTb1+Aqcb598DXKuZpNsWNHDsxJ8rtQEksXclnpgBorYXizyAuA5NQDFSrbzkoG7eaFpHzTBWkVJ7kgNN1oMA2IEjCkK3hdI5BG3F1FYNDPru5aNfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 24ADC1007;
	Tue, 12 Mar 2024 06:26:11 -0700 (PDT)
Received: from e127643.broadband (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 682773F762;
	Tue, 12 Mar 2024 06:25:31 -0700 (PDT)
From: James Clark <james.clark@arm.com>
To: linux-perf-users@vger.kernel.org
Cc: James Clark <james.clark@arm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] perf docs: arm_spe: Clarify more SPE requirements
Date: Tue, 12 Mar 2024 13:25:07 +0000
Message-Id: <20240312132508.423320-1-james.clark@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The question of exactly when KPTI needs to be disabled comes up a lot
because it doesn't always need to be done. Add the relevant kernel
function and some examples that describe the behavior.

Also describe the interrupt requirement and that no error message will
be printed if this isn't met.

Signed-off-by: James Clark <james.clark@arm.com>
---
 tools/perf/Documentation/perf-arm-spe.txt | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/tools/perf/Documentation/perf-arm-spe.txt b/tools/perf/Documentation/perf-arm-spe.txt
index bf03222e9a68..0a3eda482307 100644
--- a/tools/perf/Documentation/perf-arm-spe.txt
+++ b/tools/perf/Documentation/perf-arm-spe.txt
@@ -116,6 +116,15 @@ Depending on CPU model, the kernel may need to be booted with page table isolati
 (kpti=off). If KPTI needs to be disabled, this will fail with a console message "profiling buffer
 inaccessible. Try passing 'kpti=off' on the kernel command line".
 
+For the full criteria that determine whether KPTI needs to be forced off or not, see function
+unmap_kernel_at_el0() in the kernel sources. Common cases where it's not required
+are on the CPUs in kpti_safe_list, or on Arm v8.5+ where FEAT_E0PD is mandatory.
+
+The SPE interrupt must also be described by the firmware. If the module is loaded and KPTI is
+disabled (or isn't required to be disabled) but the SPE PMU still doesn't show in
+/sys/bus/event_source/devices/, then it's possible that the SPE interrupt isn't described by
+ACPI or DT. In this case no warning will be printed by the driver.
+
 Capturing SPE with perf command-line tools
 ------------------------------------------
 
@@ -199,7 +208,8 @@ Common errors
 
  - "Cannot find PMU `arm_spe'. Missing kernel support?"
 
-   Module not built or loaded, KPTI not disabled (see above), or running on a VM
+   Module not built or loaded, KPTI not disabled, interrupt not described by firmware,
+   or running on a VM. See 'Kernel Requirements' above.
 
  - "Arm SPE CONTEXT packets not found in the traces."
 
-- 
2.34.1


