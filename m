Return-Path: <linux-kernel+bounces-80544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC3DD866950
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 05:23:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66E44281D8D
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 04:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2C971B968;
	Mon, 26 Feb 2024 04:23:00 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A2231B94C
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 04:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708921380; cv=none; b=lH51xK0zb/QjMk7YIE2lNbpoS3kJu4pqoSNR8kjxI3PyQpcv6iBJkJ52IM3PA7Zr01CjHEvTVJSKagUp9SshroT1cqElafBsXA9nGJTRZB1CTU7BPkR4uEvo6MwWVnmf7otzlFTHG3LwHN96CtVcKoLQNhM3RxL7cjMKygGEjT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708921380; c=relaxed/simple;
	bh=mKlrDlToVS/Maui1mRuEIRqDVpR4qfopYdpXi7rgAME=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=srJ9pD7L85045Af4PYU2u+mrW5xPh2BMJhH8wjuZnjYEbICHsVVbHb5Tdt5Y9CGx0y/gukwOQAdayWVpfPKPezNJv3YKKvAbhzC5ZNgeODpb2fjdMh8P3Bzz2FKMs+n7GQkdRlIjkHH17Voji4r6QMVwgytCYePyTDYmbiDTX6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7744AC15;
	Sun, 25 Feb 2024 20:23:36 -0800 (PST)
Received: from a077893.blr.arm.com (a077893.blr.arm.com [10.162.40.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E83233F6C4;
	Sun, 25 Feb 2024 20:22:54 -0800 (PST)
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: broonie@kernel.org,
	mark.rutland@arm.com,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Will Deacon <will@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] arm64/hw_breakpoint: Determine lengths from generic perf breakpoint macros
Date: Mon, 26 Feb 2024 09:52:49 +0530
Message-Id: <20240226042249.4098185-1-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240125094119.2542332-2-anshuman.khandual@arm.com>
References: <20240125094119.2542332-2-anshuman.khandual@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Both platform i.e ARM_BREAKPOINT_LEN_X and generic i.e HW_BREAKPOINT_LEN_X
macros are used interchangeably to convert event->attr.bp_len and platform
breakpoint control arch_hw_breakpoint_ctrl->len. Let's be consistent while
deriving one from the other. This does not cause any functional changes.

Cc: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
This applies on v6.8-rc5

 arch/arm64/kernel/hw_breakpoint.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/kernel/hw_breakpoint.c b/arch/arm64/kernel/hw_breakpoint.c
index 35225632d70a..1ab9fc865ddd 100644
--- a/arch/arm64/kernel/hw_breakpoint.c
+++ b/arch/arm64/kernel/hw_breakpoint.c
@@ -301,28 +301,28 @@ static int get_hbp_len(u8 hbp_len)
 
 	switch (hbp_len) {
 	case ARM_BREAKPOINT_LEN_1:
-		len_in_bytes = 1;
+		len_in_bytes = HW_BREAKPOINT_LEN_1;
 		break;
 	case ARM_BREAKPOINT_LEN_2:
-		len_in_bytes = 2;
+		len_in_bytes = HW_BREAKPOINT_LEN_2;
 		break;
 	case ARM_BREAKPOINT_LEN_3:
-		len_in_bytes = 3;
+		len_in_bytes = HW_BREAKPOINT_LEN_3;
 		break;
 	case ARM_BREAKPOINT_LEN_4:
-		len_in_bytes = 4;
+		len_in_bytes = HW_BREAKPOINT_LEN_4;
 		break;
 	case ARM_BREAKPOINT_LEN_5:
-		len_in_bytes = 5;
+		len_in_bytes = HW_BREAKPOINT_LEN_5;
 		break;
 	case ARM_BREAKPOINT_LEN_6:
-		len_in_bytes = 6;
+		len_in_bytes = HW_BREAKPOINT_LEN_6;
 		break;
 	case ARM_BREAKPOINT_LEN_7:
-		len_in_bytes = 7;
+		len_in_bytes = HW_BREAKPOINT_LEN_7;
 		break;
 	case ARM_BREAKPOINT_LEN_8:
-		len_in_bytes = 8;
+		len_in_bytes = HW_BREAKPOINT_LEN_8;
 		break;
 	}
 
-- 
2.25.1


