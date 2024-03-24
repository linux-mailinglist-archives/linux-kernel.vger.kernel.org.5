Return-Path: <linux-kernel+bounces-114358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DA16888FCC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:01:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEA661C2C183
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F27626D9A2;
	Sun, 24 Mar 2024 23:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B50xETpJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 988F61EEF0A;
	Sun, 24 Mar 2024 23:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321747; cv=none; b=VQOC4RkteGb1dFYYkehDDyuU5c59sEvu4JBfGvkQKTSApgLpP3BzUafgo1m0lNI8CGMcM1Yb+VSVwjO9H14vEawWM8UODqjfvOC0FktPVqhh5cFqEzuZ0ichBGc3TuK13AZx3H7DqTATAGrXHkNyUOVyOTCdTXgOWYRejQtkUgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321747; c=relaxed/simple;
	bh=LOo3lC22VEDvJtM2gwHrvZYeaT0SOw4YiVKbCdHHZVk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q6bYlALIqwPfUIS9U2U2H02a/EjxvtZ3ZlIG9KUq8/5yrJEwA7fEaQ/vdwfcyBgu4adpLQm2Ynbftbw57tgK/K8FZNp6SY8M4n50nPOaXVXX0z+1oLxMz/Mf10bvGItHz10neOXF6uaW8ecHRRgSqDvlXnpE0M7Gkm3IVmys2J0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B50xETpJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2C43C43390;
	Sun, 24 Mar 2024 23:09:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321746;
	bh=LOo3lC22VEDvJtM2gwHrvZYeaT0SOw4YiVKbCdHHZVk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=B50xETpJ6Lwxn0kSiAV0YLyCEcIkLL/l+fXrAIRQAk/rQ7LAYolxHnoBSpH/vZ/Ki
	 rfAmugSR5modgSARjHl2I0O0XJhxa0woI1kA21OogJwEPdnHAXd8BEDrQ2TtAnzFwA
	 psTuHHJjoGlnoOsXsaFlDJ3sS/wnqnxeFQAnxg926WGJo1eJLMxInelRw1jltdqCM4
	 mWVhUH0m9bHpT1Izw4xX0rr8PoLkpZHG5mAtgeA0g7M3OHlN71AzXAtaMaDvplV9T0
	 H6hL1dvbKQ89IL4VMNBrOfvvMfL1ZEo3lC8ABbTfc2IB2H4LTB9hd06glPzp7S6uiH
	 sH5MSdj6t0GMw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kajol Jain <kjain@linux.ibm.com>,
	Akanksha J N <akanksha@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 474/638] powerpc/hv-gpci: Fix the H_GET_PERF_COUNTER_INFO hcall return value checks
Date: Sun, 24 Mar 2024 18:58:31 -0400
Message-ID: <20240324230116.1348576-475-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Kajol Jain <kjain@linux.ibm.com>

[ Upstream commit ad86d7ee43b22aa2ed60fb982ae94b285c1be671 ]

Running event hv_gpci/dispatch_timebase_by_processor_processor_time_in_timebase_cycles,phys_processor_idx=0/
in one of the system throws below error:

 ---Logs---
 # perf list | grep hv_gpci/dispatch_timebase_by_processor_processor_time_in_timebase_cycles
  hv_gpci/dispatch_timebase_by_processor_processor_time_in_timebase_cycles,phys_processor_idx=?/[Kernel PMU event]

 # perf stat -v -e hv_gpci/dispatch_timebase_by_processor_processor_time_in_timebase_cycles,phys_processor_idx=0/ sleep 2
Using CPUID 00800200
Control descriptor is not initialized
Warning:
hv_gpci/dispatch_timebase_by_processor_processor_time_in_timebase_cycles,phys_processor_idx=0/ event is not supported by the kernel.
failed to read counter hv_gpci/dispatch_timebase_by_processor_processor_time_in_timebase_cycles,phys_processor_idx=0/

 Performance counter stats for 'system wide':

   <not supported>      hv_gpci/dispatch_timebase_by_processor_processor_time_in_timebase_cycles,phys_processor_idx=0/

       2.000700771 seconds time elapsed

The above error is because of the hcall failure as required
permission "Enable Performance Information Collection" is not set.
Based on current code, single_gpci_request function did not check the
error type incase hcall fails and by default returns EINVAL. But we can
have other reasons for hcall failures like H_AUTHORITY/H_PARAMETER with
detail_rc as GEN_BUF_TOO_SMALL, for which we need to act accordingly.

Fix this issue by adding new checks in the single_gpci_request and
h_gpci_event_init functions.

Result after fix patch changes:

 # perf stat -e hv_gpci/dispatch_timebase_by_processor_processor_time_in_timebase_cycles,phys_processor_idx=0/ sleep 2
Error:
No permission to enable hv_gpci/dispatch_timebase_by_processor_processor_time_in_timebase_cycles,phys_processor_idx=0/ event.

Fixes: 220a0c609ad1 ("powerpc/perf: Add support for the hv gpci (get performance counter info) interface")
Reported-by: Akanksha J N <akanksha@linux.ibm.com>
Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://msgid.link/20240229122847.101162-1-kjain@linux.ibm.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/perf/hv-gpci.c | 29 +++++++++++++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/perf/hv-gpci.c b/arch/powerpc/perf/hv-gpci.c
index 27f18119fda17..241551d1282f8 100644
--- a/arch/powerpc/perf/hv-gpci.c
+++ b/arch/powerpc/perf/hv-gpci.c
@@ -695,6 +695,20 @@ static unsigned long single_gpci_request(u32 req, u32 starting_index,
 
 	ret = plpar_hcall_norets(H_GET_PERF_COUNTER_INFO,
 			virt_to_phys(arg), HGPCI_REQ_BUFFER_SIZE);
+
+	/*
+	 * ret value as 'H_PARAMETER' with detail_rc as 'GEN_BUF_TOO_SMALL',
+	 * specifies that the current buffer size cannot accommodate
+	 * all the information and a partial buffer returned.
+	 * Since in this function we are only accessing data for a given starting index,
+	 * we don't need to accommodate whole data and can get required count by
+	 * accessing first entry data.
+	 * Hence hcall fails only incase the ret value is other than H_SUCCESS or
+	 * H_PARAMETER with detail_rc value as GEN_BUF_TOO_SMALL(0x1B).
+	 */
+	if (ret == H_PARAMETER && be32_to_cpu(arg->params.detail_rc) == 0x1B)
+		ret = 0;
+
 	if (ret) {
 		pr_devel("hcall failed: 0x%lx\n", ret);
 		goto out;
@@ -759,6 +773,7 @@ static int h_gpci_event_init(struct perf_event *event)
 {
 	u64 count;
 	u8 length;
+	unsigned long ret;
 
 	/* Not our event */
 	if (event->attr.type != event->pmu->type)
@@ -789,13 +804,23 @@ static int h_gpci_event_init(struct perf_event *event)
 	}
 
 	/* check if the request works... */
-	if (single_gpci_request(event_get_request(event),
+	ret = single_gpci_request(event_get_request(event),
 				event_get_starting_index(event),
 				event_get_secondary_index(event),
 				event_get_counter_info_version(event),
 				event_get_offset(event),
 				length,
-				&count)) {
+				&count);
+
+	/*
+	 * ret value as H_AUTHORITY implies that partition is not permitted to retrieve
+	 * performance information, and required to set
+	 * "Enable Performance Information Collection" option.
+	 */
+	if (ret == H_AUTHORITY)
+		return -EPERM;
+
+	if (ret) {
 		pr_devel("gpci hcall failed\n");
 		return -EINVAL;
 	}
-- 
2.43.0


