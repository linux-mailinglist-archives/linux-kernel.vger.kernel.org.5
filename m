Return-Path: <linux-kernel+bounces-49167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 77B428466BB
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 05:04:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BC1F1F26D02
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 04:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00E30F9C1;
	Fri,  2 Feb 2024 04:03:41 +0000 (UTC)
Received: from bg1.exmail.qq.com (bg1.exmail.qq.com [114.132.67.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36062E541
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 04:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.132.67.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706846620; cv=none; b=l2xz2iYFZ0DXxh1HPZhsFqW9lNZboyt1s0nrm+2sRcB2OjRbDGEscvRRKMPIc/Ftt1TfB5DIw/bD2cZyaaPTZUKwLn6PO6oNZPKxf4qfFw0VnEVazHMP9EfDhZtyGNTpT9Wykv+OJpL4t/EyjtMJrKEtAE3lBLHtU+hpSesr3PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706846620; c=relaxed/simple;
	bh=+Eo2dwljZcW5uV4yjXoHiFKq3QU2j3mrhDikr579ado=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bzLwBqmBONL90StqFjLc/dhbZNRwl4VXVwzHmn8yFMwHNRxeXNeG9osccmAO4lczoICfOc03jmv8yKFUguM8e7mng4E+KX28jnpzr7Fea96c1BeX0R76xwm+nr0RW+VDerXkGbuUt3mkiLPEjCtdMfADDqfcdvElpQZy3j+I5gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn; spf=pass smtp.mailfrom=shingroup.cn; arc=none smtp.client-ip=114.132.67.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shingroup.cn
X-QQ-mid: bizesmtp72t1706846544tpicfqcy
X-QQ-Originating-IP: Aby11FTS8fbag06Qy9tbwzEEl2YdZgrNCtLGverTmj8=
Received: from localhost ( [183.209.108.228])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 02 Feb 2024 12:02:22 +0800 (CST)
X-QQ-SSF: 01400000000000504000000A0000000
X-QQ-FEAT: W+onFc5Tw4OrFz6v/gvbEmaS1UMOWtNxM4tOzgs1lH0rkHYguDEySueuhAkfE
	mQFugpbemCJRHgjBaaVvk3Go474QHdo/bD5In6Cv03LAORRYTgtvxLAlygeNJ1A/bNTQhTJ
	oSQHA0+PMEEcNqJbCTq7njG7d4qU3oa3lIm21kj4t5T+f+5NtDb8Ix2E+LgRlzuvDjTEpTO
	4YV3/paMc7I6CTdfznQePEwm0jo2GbWROPnTNLm/pGg2VXYOKMSFUp7mYiIVJlBT0Ttm51j
	/2xQOohz56PBwubBE+eoBa55SsfTO2q0IuC835IITfWrZKkTZh9olgM7kbkVEYx103xlT+w
	IhiZOpqlV90I/MHBp816VkZjJrssDvQfSgQq6b1m1wSwMTw3hbCoT0gcn6jPA==
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 5419536639946482779
From: Dawei Li <dawei.li@shingroup.cn>
To: catalin.marinas@arm.com,
	will@kernel.org
Cc: mark.rutland@arm.com,
	mcgrof@kernel.org,
	jpoimboe@kernel.org,
	j.granados@samsung.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	set_pte_at@outlook.com,
	Dawei Li <dawei.li@shingroup.cn>
Subject: [PATCH] arm64: remove unneeded BUILD_BUG_ON assertion
Date: Fri,  2 Feb 2024 12:02:11 +0800
Message-Id: <20240202040211.3118918-1-dawei.li@shingroup.cn>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:shingroup.cn:qybglogicsvrgz:qybglogicsvrgz5a-1

Since commit c02433dd6de3 ("arm64: split thread_info from task stack"),
CONFIG_THREAD_INFO_IN_TASK is enabled unconditionally for arm64. So
remove this always-true assertion from arch_dup_task_struct.

Signed-off-by: Dawei Li <dawei.li@shingroup.cn>
---
 arch/arm64/kernel/process.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index 7387b68c745b..4ae31b7af6c3 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -290,9 +290,6 @@ int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src)
 		fpsimd_preserve_current_state();
 	*dst = *src;
 
-	/* We rely on the above assignment to initialize dst's thread_flags: */
-	BUILD_BUG_ON(!IS_ENABLED(CONFIG_THREAD_INFO_IN_TASK));
-
 	/*
 	 * Detach src's sve_state (if any) from dst so that it does not
 	 * get erroneously used or freed prematurely.  dst's copies
-- 
2.27.0


