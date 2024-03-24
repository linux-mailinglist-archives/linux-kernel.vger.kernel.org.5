Return-Path: <linux-kernel+bounces-114878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 274A98891F1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:53:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA3D41F2DAC5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EABAC1779BB;
	Mon, 25 Mar 2024 00:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KZzORWM6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F037C177ABB;
	Sun, 24 Mar 2024 23:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323530; cv=none; b=mnLgZTajPWh/qvkhUm7eE3adRuiCf6kdqnAEyuc+5amS0iHRmM4xRxoI5Qbt+PI5B4yKyZp7+c0OMhQ/Ia6E6IroY+X/VOLwGwD2JFiwOhuqYqELiCaJ/yIjrgJhT1ay6ca8NvhmEi14GN5Azxn/C2jMUR0DUHNbY6ivjKYC6gE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323530; c=relaxed/simple;
	bh=tfhiyz79ICdQeKvhnCLH9GxQyaU1564g7hI9bfQA7x4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o71Qft4jtc0fzv75nM3LpWEYPFhi65ug5PFokgfUqIwy9H1bTl8H2GXV0clGOnHoaEEguP4st/0LVMpLWcc8AdsUT5RccZpfSjgocKEW3jJMP3MzD5NeAsihyJCL9xuL428XE78IpVJ1J3FmJcIdyk5/P9lU+uooZQTf9fT2yoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KZzORWM6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21F54C433F1;
	Sun, 24 Mar 2024 23:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323528;
	bh=tfhiyz79ICdQeKvhnCLH9GxQyaU1564g7hI9bfQA7x4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KZzORWM6K87Kx5N/47GffiB/vXiXt9U9/HdXvjp30cxfx5U8NBL+T+ycz+mrVeWp/
	 dLVbrhcTLp/R0mkgVcHQKF0Vre34a1C5v949gHEzShgi3nedLU/oDWORWzXJjyAHqd
	 5gi8bvwxKs00cwSO08zc1+uj8ezQv3R+fBj3DtpMrqm3Vk5NpRD6z59HVDyR4GVzCo
	 b+1Zb37QJUl9NIeRZsMXjbhDmMy0LATPMz7wI38vxbdPFxCxQaataPU0mSQP0OtS2w
	 0LVcYZp1OBWwoEzyl69kMhQjrAqMMvjPiTtIPDchxsxausXdKhjoDuVRziDbFU0DiW
	 g/U9riL7D73Cw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kajol Jain <kjain@linux.ibm.com>,
	Akanksha J N <akanksha@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 236/317] powerpc/hv-gpci: Fix the H_GET_PERF_COUNTER_INFO hcall return value checks
Date: Sun, 24 Mar 2024 19:33:36 -0400
Message-ID: <20240324233458.1352854-237-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324233458.1352854-1-sashal@kernel.org>
References: <20240324233458.1352854-1-sashal@kernel.org>
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


