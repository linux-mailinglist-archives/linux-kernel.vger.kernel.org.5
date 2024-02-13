Return-Path: <linux-kernel+bounces-63412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E05DB852EEC
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 12:16:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75E47286546
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 11:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03BB038FAA;
	Tue, 13 Feb 2024 11:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lE5igxZ5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 433DF38DD8;
	Tue, 13 Feb 2024 11:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707822965; cv=none; b=GXw3FY7blRlqJI/+1IY6hvLh/eP5cjkhH606A+hFd4pSpiSMCqE4L8MJkDYHv2MaQMgCuvQpLdDeqmLG80JgmP3wiT5nDmuoNaSo2drYBftTU08ixnAKFtnbSsUZ0AWq86/8qJ7pl7kgz8mFshSBCu8SkAqdZypjJZc+t6X3CR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707822965; c=relaxed/simple;
	bh=8/YDPIwx8aNs6n3EAi1Qm6t3uluLFwT/JUQiL7Zhcn4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XXPnegY6oX2RpQP5xVycgxG6gBTu6Z9vIT09e2PpJjfRb3slvoKnN4d5Lf91Lv9muGePyMUaaExEn43xGix9cVht2hQZFjFHcMfFUAbNimOs1SnS8Sri9JgH337hFRTZcG4X/86f13STlCJIzcN0/5heX1bil1hZyLLdeS4Jv0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lE5igxZ5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 180F6C43390;
	Tue, 13 Feb 2024 11:16:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707822964;
	bh=8/YDPIwx8aNs6n3EAi1Qm6t3uluLFwT/JUQiL7Zhcn4=;
	h=From:To:Cc:Subject:Date:From;
	b=lE5igxZ59PtoutKDEyWlM2gMtg0IbO8TtSD+cucf5PV5XJ/S2WnpVANxS4OpOFpOf
	 gBlRPsxQSV9pBuWcAG1w5gp7IutASbSRLaEHazqx89aDCM9aPRcIjTnKN2piqzANkd
	 7hZ4e1c54qr+Plr09iFAGQA95rLzA5NqYoUzwKpV48vtWTailkand42ozc4G8HIjlX
	 ULXiYB141GFnADSDbRYkRc2zaONy1kNbWL2vmGeT9NgvN475ft8JnY41Ah4LAWTpfR
	 uu15NfDAIk44zoi3O5P6190bPYPEI/myZxucdphMfViU5ke1ERONeqSs3R7bYJmSIW
	 ykWvwC9Lyz1WQ==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: rafael@kernel.org
Cc: linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Len Brown <lenb@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	linux-pm@vger.kernel.org
Subject: [PATCH] cpufreq/intel_pstate: remove cpudata::prev_cummulative_iowait
Date: Tue, 13 Feb 2024 12:16:00 +0100
Message-ID: <20240213111600.25269-1-jirislaby@kernel.org>
X-Mailer: git-send-email 2.43.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 09c448d3c61f (cpufreq: intel_pstate: Use IOWAIT flag in Atom
algorithm) removed the last user of cpudata::prev_cummulative_iowait. So
remove the member too.

Found by https://github.com/jirislaby/clang-struct.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Len Brown <lenb@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org
---
 drivers/cpufreq/intel_pstate.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index ca94e60e705a..5ad3542c0e1e 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -201,8 +201,6 @@ struct global_params {
  * @prev_aperf:		Last APERF value read from APERF MSR
  * @prev_mperf:		Last MPERF value read from MPERF MSR
  * @prev_tsc:		Last timestamp counter (TSC) value
- * @prev_cummulative_iowait: IO Wait time difference from last and
- *			current sample
  * @sample:		Storage for storing last Sample data
  * @min_perf_ratio:	Minimum capacity in terms of PERF or HWP ratios
  * @max_perf_ratio:	Maximum capacity in terms of PERF or HWP ratios
@@ -241,7 +239,6 @@ struct cpudata {
 	u64	prev_aperf;
 	u64	prev_mperf;
 	u64	prev_tsc;
-	u64	prev_cummulative_iowait;
 	struct sample sample;
 	int32_t	min_perf_ratio;
 	int32_t	max_perf_ratio;
-- 
2.43.1


