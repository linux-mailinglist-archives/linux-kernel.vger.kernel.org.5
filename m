Return-Path: <linux-kernel+bounces-147842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABA6D8A7A6E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 04:18:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16CADB216E8
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 02:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 982787462;
	Wed, 17 Apr 2024 02:18:07 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD84C6FA8
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 02:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713320287; cv=none; b=HQPwky8/hWT2oWdexvXyCCshv7wffwXuorl+k3xb/BvBgDK6CHXIAUUqYadt8CzosGvOkq7s/CcA9xnuM6ZLpaHJQo8/NlT4VVESUqJoha4mkV/68mtG2Dnugx+9Jd1MsCecMEywnZxBFFarw3wajHtOgf3KS5s/VJW3qf7gRvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713320287; c=relaxed/simple;
	bh=XUaNsGATuHxrKeHapXBodzbAmy25ZcO6OiFj4IeKk8U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hDPcM404MQJH6W7cVOWkxEiyulrXw4MemB3MwHAtZ/WsjkQDo4B0UsRZ/6ni6cWHbvVTE9v7onXFTzgxSBE1v2KocJBHWlrcmuZOV31jUkJuXONusy10/b2KmBA+94mTo2ZbCKCRIUUyG7C1/0lVBJIRsW3923xvDpsUWmDVUyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DF041DA7;
	Tue, 16 Apr 2024 19:18:26 -0700 (PDT)
Received: from a077893.blr.arm.com (a077893.blr.arm.com [10.162.43.7])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 8EAB53F64C;
	Tue, 16 Apr 2024 19:17:56 -0700 (PDT)
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: linux-arm-kernel@lists.infradead.org,
	catalin.marinas@arm.com
Cc: Anshuman Khandual <anshuman.khandual@arm.com>,
	Will Deacon <will@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] arm64/sysreg: Add register fields for MDSELR_EL1
Date: Wed, 17 Apr 2024 07:47:44 +0530
Message-Id: <20240417021747.2361382-2-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240417021747.2361382-1-anshuman.khandual@arm.com>
References: <20240417021747.2361382-1-anshuman.khandual@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds register fields for MDSELR_EL1 as per the definitions based
on DDI0601 2024-03.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Mark Brown <broonie@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Reviewed-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/arm64/tools/sysreg | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/tools/sysreg b/arch/arm64/tools/sysreg
index a4c1dd4741a4..4c58fd7a70e6 100644
--- a/arch/arm64/tools/sysreg
+++ b/arch/arm64/tools/sysreg
@@ -93,6 +93,17 @@ Res0	63:32
 Field	31:0	DTRTX
 EndSysreg
 
+Sysreg	MDSELR_EL1	2	0	0	4	2
+Res0	63:6
+Enum	5:4	BANK
+	0b00	BANK_0
+	0b01	BANK_1
+	0b10	BANK_2
+	0b11	BANK_3
+EndEnum
+Res0	3:0
+EndSysreg
+
 Sysreg	OSECCR_EL1	2	0	0	6	2
 Res0	63:32
 Field	31:0	EDECCR
-- 
2.25.1


