Return-Path: <linux-kernel+bounces-78221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2A0E86106A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 12:31:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 747CBB237C0
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 11:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7926078661;
	Fri, 23 Feb 2024 11:31:18 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B91F478667
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 11:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708687878; cv=none; b=n1tb2lpfGlLTJkmBV66f7OlVDjXBOwtWJHTacJ1KRFraF7baWN2c3TiKo7lUH4IrNS2dsN9E6b40xdzx6nVhy+mIFvGMZSgy9q/OizWQ87ZJ+cn0wR9r+6Yme4CubdNI30KYSwErZ8uyC0Dl2ezvVEk7gkENQfUdVIieptGWm6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708687878; c=relaxed/simple;
	bh=mKlrDlToVS/Maui1mRuEIRqDVpR4qfopYdpXi7rgAME=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VokkERuW7mhLNEpc3KBMWEriaYarDrf+B91GOCPAjWwh1EdyAxt4VS5Te3YuuuIbqBvQBXq0W0GSeBtMKO45gGoUWhZddYTIxYlId3BDJfzTtyUVyNgER0pQc7zFZ6uNXHCz1+cxYrD5bBfCYNqdXsRhDAv+Le4f3mKqeA9fWiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 83A6811FB;
	Fri, 23 Feb 2024 03:31:53 -0800 (PST)
Received: from a077893.arm.com (unknown [10.163.47.143])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 324713F762;
	Fri, 23 Feb 2024 03:31:11 -0800 (PST)
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: broonie@kernel.org,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] arm64/hw_breakpoint: Determine lengths from generic perf breakpoint macros
Date: Fri, 23 Feb 2024 17:01:02 +0530
Message-Id: <20240223113102.4027779-1-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
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


