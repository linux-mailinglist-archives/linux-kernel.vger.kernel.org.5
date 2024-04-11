Return-Path: <linux-kernel+bounces-139892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76CE48A08E8
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 08:56:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EDA1DB23944
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 06:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50CFB13E3E6;
	Thu, 11 Apr 2024 06:55:23 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 056F813DDC4
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 06:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712818522; cv=none; b=P2ypg931Qf6dbVoPG1E+b3W+WNooLbhEBU+wDnVHXByyynMpewpcUEko1GqdIbiKJLNTGuMYZ7sqfgi8XmwBa8Przd1DMFZE5vdpQ+apRStWMNYo//QvNhHvrInEfyS79jLqCIcg6+oxUIHK4GObcyLJrT0pv1L7Gh0EfGs+D48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712818522; c=relaxed/simple;
	bh=vRaAWJBmEkfrKydlBrm0tEA+Ytbuvo+lXPgTBsQ0fvA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mLJJ9WNC70ie9QhoSWByL6zGs8vM7Ta0RBmC9sRgTUrVrQEpIY+3FY6HRKEDZO7EpYoID24N3ZEZwyFJQutWacI8i9hW0ct254KhAw586xWcT+F5RCYdziIk/e4Tx7biuFKWka8UAybmH7rCYZAX47NTkeC1SizkEA/IKrR0wCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4VFVk14F7szXlLJ;
	Thu, 11 Apr 2024 14:52:09 +0800 (CST)
Received: from kwepemd200013.china.huawei.com (unknown [7.221.188.133])
	by mail.maildlp.com (Postfix) with ESMTPS id 1A7D9140E9F;
	Thu, 11 Apr 2024 14:55:19 +0800 (CST)
Received: from huawei.com (10.67.174.28) by kwepemd200013.china.huawei.com
 (7.221.188.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.28; Thu, 11 Apr
 2024 14:55:17 +0800
From: Liao Chang <liaochang1@huawei.com>
To: <catalin.marinas@arm.com>, <will@kernel.org>, <maz@kernel.org>,
	<oliver.upton@linux.dev>, <james.morse@arm.com>, <suzuki.poulose@arm.com>,
	<yuzenghui@huawei.com>, <tglx@linutronix.de>, <mark.rutland@arm.com>,
	<ardb@kernel.org>, <broonie@kernel.org>, <liaochang1@huawei.com>,
	<anshuman.khandual@arm.com>, <miguel.luis@oracle.com>, <joey.gouly@arm.com>,
	<ryan.roberts@arm.com>, <jeremy.linton@arm.com>,
	<daniel.thompson@linaro.org>, <sumit.garg@linaro.org>, <liwei391@huawei.com>,
	<peterz@infradead.org>, <jpoimboe@kernel.org>, <ericchancf@google.com>,
	<kristina.martsenko@arm.com>, <robh@kernel.org>,
	<scott@os.amperecomputing.com>, <songshuaishuai@tinylab.org>,
	<shijie@os.amperecomputing.com>, <bhe@redhat.com>,
	<akpm@linux-foundation.org>, <horms@kernel.org>,
	<rmk+kernel@armlinux.org.uk>, <Jonathan.Cameron@huawei.com>,
	<takakura@valinux.co.jp>, <dianders@chromium.org>, <swboyd@chromium.org>,
	<frederic@kernel.org>, <reijiw@google.com>, <ruanjinjie@huawei.com>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<kvmarm@lists.linux.dev>
Subject: [PATCH v2 4/9] arm64/cpufeature: Simplify detect PE support for FEAT_NMI
Date: Thu, 11 Apr 2024 06:48:53 +0000
Message-ID: <20240411064858.3232574-5-liaochang1@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240411064858.3232574-1-liaochang1@huawei.com>
References: <20240411064858.3232574-1-liaochang1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemd200013.china.huawei.com (7.221.188.133)

From: Jinjie Ruan <ruanjinjie@huawei.com>

Simplify the Non-maskable Interrupts feature implementation with
ARM64_CPUID_FIELDS macro.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
Signed-off-by: Liao Chang <liaochang1@huawei.com>
---
 arch/arm64/kernel/cpufeature.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index fb9e52c84fda..99c3bc74008d 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -2905,24 +2905,16 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 		.desc = "Non-maskable Interrupts present",
 		.capability = ARM64_HAS_NMI,
 		.type = ARM64_CPUCAP_BOOT_CPU_FEATURE,
-		.sys_reg = SYS_ID_AA64PFR1_EL1,
-		.sign = FTR_UNSIGNED,
-		.field_pos = ID_AA64PFR1_EL1_NMI_SHIFT,
-		.field_width = 4,
-		.min_field_value = ID_AA64PFR1_EL1_NMI_IMP,
 		.matches = has_cpuid_feature,
+		ARM64_CPUID_FIELDS(ID_AA64PFR1_EL1, NMI, IMP)
 	},
 	{
 		.desc = "Non-maskable Interrupts enabled",
 		.capability = ARM64_USES_NMI,
 		.type = ARM64_CPUCAP_BOOT_CPU_FEATURE,
-		.sys_reg = SYS_ID_AA64PFR1_EL1,
-		.sign = FTR_UNSIGNED,
-		.field_pos = ID_AA64PFR1_EL1_NMI_SHIFT,
-		.field_width = 4,
-		.min_field_value = ID_AA64PFR1_EL1_NMI_IMP,
 		.matches = use_nmi,
 		.cpu_enable = nmi_enable,
+		ARM64_CPUID_FIELDS(ID_AA64PFR1_EL1, NMI, IMP)
 	},
 #endif
 	{},
-- 
2.34.1


