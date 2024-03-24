Return-Path: <linux-kernel+bounces-115024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E17B6888CC6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:30:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB7F1B2151E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:25:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2AD517CF45;
	Mon, 25 Mar 2024 00:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ydh3eR7A"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C157117C6D2;
	Sun, 24 Mar 2024 23:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323801; cv=none; b=aYtM2fXZ0dtwX23Lj7OtbLEMEl8eoBDD0JthseSOlbVU5mSWMOq8BhMcPQHWS4xhXcXEQmuidZDlMxJu6FJrzosIvuWqhh1Yu2+QhkOeLp4/FKSYYGVvtnFNB9chUrzDTnYxFkrwllQPO+SSELU8dx67IZQgiKInMtaAWC1+aog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323801; c=relaxed/simple;
	bh=tfhiyz79ICdQeKvhnCLH9GxQyaU1564g7hI9bfQA7x4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hv0WspnBwoGC2cZHbv75nJ4lPmZ0d+38o87tzTMDNtV+roVQgfI0fvMoAEWqDbF7OZ/I+jkO0mlzrsXsxujC/eV/dJC7hRly3/j8YVj42NWAXT6QyJ5HWGyccohJXIjLbYB1z0WSx67GuenNy8xnPzAw0XnISFwDVcNeLGrZX34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ydh3eR7A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA0D8C43394;
	Sun, 24 Mar 2024 23:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323800;
	bh=tfhiyz79ICdQeKvhnCLH9GxQyaU1564g7hI9bfQA7x4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ydh3eR7A4KnYNTmNgsBCUwj2ZUhy2WaCkRSugq/pwJgOD33j+yRS0Fl9RKv/Cfiyv
	 jde8JsBVGtOvrK6B6fEXkkGr8MyiBHTdyxaIFwXdR9chtohUC7E7jd7FYWbI6B1Ie5
	 dNLbOH6Pn2bnM7uz2QRzQJdpq8AwHyLUvmvuJ/pF+6dnIg+XGq9O+ko6rdtnr0j0Re
	 x1sl2QurzRn7CSyETTbnD+q0UiNMNZ9zNswIcwpMhAmYz2niAmvGgb1i+1Kfic2f5/
	 9nC+eMmc3A2h7N2aMSMXlSjaTSlRmh49wqYYVIId39OlRQl0z2eYcHqsopj02Nx9Xh
	 IbLDoYZRvmz7A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kajol Jain <kjain@linux.ibm.com>,
	Akanksha J N <akanksha@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 178/238] powerpc/hv-gpci: Fix the H_GET_PERF_COUNTER_INFO hcall return value checks
Date: Sun, 24 Mar 2024 19:39:26 -0400
Message-ID: <20240324234027.1354210-179-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234027.1354210-1-sashal@kernel.org>
References: <20240324234027.1354210-1-sashal@kernel.org>
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
index 28b770bbc10b4..2a054de80e50b 100644
--- a/arch/powerpc/perf/hv-gpci.c
+++ b/arch/powerpc/perf/hv-gpci.c
@@ -164,6 +164,20 @@ static unsigned long single_gpci_request(u32 req, u32 starting_index,
 
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
@@ -228,6 +242,7 @@ static int h_gpci_event_init(struct perf_event *event)
 {
 	u64 count;
 	u8 length;
+	unsigned long ret;
 
 	/* Not our event */
 	if (event->attr.type != event->pmu->type)
@@ -258,13 +273,23 @@ static int h_gpci_event_init(struct perf_event *event)
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


