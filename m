Return-Path: <linux-kernel+bounces-129306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DAF989685E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 10:23:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAC731C243C8
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 08:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E162131753;
	Wed,  3 Apr 2024 08:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="teWmzofe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC66130E57;
	Wed,  3 Apr 2024 08:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712131901; cv=none; b=sp5Oipb80YDszH2ZRXtc0uh2Q9G0HwK01HDPt0zsQkP4xj9IwL0FuRhrJRkfn+dWhCvQQ6WN/w/gZ1bRTQ91ET9iwGAZhM8TS9rAvkynGPDmJK6RSvWBCABWtfv7M6J6wjEjakgKOL4uEAOfssh0LXnBsWFaIKhQ07EbbXiP/5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712131901; c=relaxed/simple;
	bh=fyLsfheaYKd+miTluYtO6pZInxaScKj0VFWPZBAzIGU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=I7prl7BFknCBKZz8DbSj/F5A912jKeYR9w7A+fLuDqpOHuJehT5rlpJhHEkjGJxyIJqx5LsprpnZ1ZCuzsS5u4IX7uEAj4byv1zZyfVUF0JmBM9My1wI4vr9U4OJFoCuLQ7TuI7P/BCr1RZHXVDeaSQCIfCcgQN0A3WMPjU9KDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=teWmzofe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50F61C43394;
	Wed,  3 Apr 2024 08:11:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712131901;
	bh=fyLsfheaYKd+miTluYtO6pZInxaScKj0VFWPZBAzIGU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=teWmzofeqXsUSch/4hPcGgnIlL6++wfUzQ/aMHOB3ZobnXVoCyIFMH8yWP4rzUokd
	 xLHRM1L+/MiUYpL7DQQVPR7XkVbV9kMCMHnpy8Cj4l2xVWozoKXSLAqaTIxyEaMqVu
	 EFPVTEOgbvbzyTUoXlUtlL7C8Jvaj1izyxbLpiQj6A4yxmINwf8iKC2T2wuvry1vtP
	 nFZo0zH9L/02AafTcmX5QnfdGueRXcpp8f3zLVcl/76FdJzrZLyHvCvxC4z4AD6eqN
	 eQO7QleLc9udoJHnA8A29Y3x99qUELYditqPz05YQO00SyZKqk+Ik07N3V6+qntm+i
	 5qGlasuqMK4Hw==
From: Arnd Bergmann <arnd@kernel.org>
To: linux-kernel@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Len Brown <lenb@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Doug Smythies <dsmythies@telus.net>,
	Zhenguo Yao <yaozhenguo1@gmail.com>,
	Tero Kristo <tero.kristo@linux.intel.com>,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	linux-pm@vger.kernel.org
Subject: [PATCH 27/34] cpufreq: intel_pstate: hide unused intel_pstate_cpu_oob_ids[]
Date: Wed,  3 Apr 2024 10:06:45 +0200
Message-Id: <20240403080702.3509288-28-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240403080702.3509288-1-arnd@kernel.org>
References: <20240403080702.3509288-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

The reference to this variable is hidden in an #ifdef:

drivers/cpufreq/intel_pstate.c:2440:32: error: 'intel_pstate_cpu_oob_ids' defined but not used [-Werror=unused-const-variable=]

Use the same check around the definition.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/cpufreq/intel_pstate.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index dbbf299f4219..29ce9edc6f68 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -2437,6 +2437,7 @@ static const struct x86_cpu_id intel_pstate_cpu_ids[] = {
 };
 MODULE_DEVICE_TABLE(x86cpu, intel_pstate_cpu_ids);
 
+#ifdef CONFIG_ACPI
 static const struct x86_cpu_id intel_pstate_cpu_oob_ids[] __initconst = {
 	X86_MATCH(BROADWELL_D,		core_funcs),
 	X86_MATCH(BROADWELL_X,		core_funcs),
@@ -2445,6 +2446,7 @@ static const struct x86_cpu_id intel_pstate_cpu_oob_ids[] __initconst = {
 	X86_MATCH(SAPPHIRERAPIDS_X,	core_funcs),
 	{}
 };
+#endif
 
 static const struct x86_cpu_id intel_pstate_cpu_ee_disable_ids[] = {
 	X86_MATCH(KABYLAKE,		core_funcs),
-- 
2.39.2


