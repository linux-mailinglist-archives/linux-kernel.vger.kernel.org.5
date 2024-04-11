Return-Path: <linux-kernel+bounces-139891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A73C58A08E7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 08:56:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 619DF286C64
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 06:56:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A243E13E03A;
	Thu, 11 Apr 2024 06:55:22 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C01613DDB9
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 06:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712818522; cv=none; b=Y3N0lTQwJ9pIuj0UtE5I4xhVxzEM38yD47EP2L1II06jTfdrvg3SbTFBc4SM3PH0X5K6Qasrd3wZQRQOb6xSM5azuBsrMNeBkvgpE/upUxMORjdrOARWKPzsSxMHp7DJB/xonTwzvn60rbdl9MixswtPk5XfkcvrTUMQYa+ku/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712818522; c=relaxed/simple;
	bh=GeIgU1VU+aVa6h++QNIPYcLXAwGCXlNODIbW8g+1rxw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JWKS0ePNDW0sCsED/rx96mZIQKZgNb19hyWAaN+TuBax8WwdwgePRI0kZNM++9brwPhlzaNJ3UV1RPUkYx6lJQLG8DoUM1HHD5AHsH9SCfjvGcs7JzWXGPl22vQH0Mp/2kWlar61O+ILXZLid7VhF8NfbSfRmG2UvpHjo2/FuQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4VFVkK334mz2NW77;
	Thu, 11 Apr 2024 14:52:25 +0800 (CST)
Received: from kwepemd200013.china.huawei.com (unknown [7.221.188.133])
	by mail.maildlp.com (Postfix) with ESMTPS id D39C9180063;
	Thu, 11 Apr 2024 14:55:17 +0800 (CST)
Received: from huawei.com (10.67.174.28) by kwepemd200013.china.huawei.com
 (7.221.188.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.28; Thu, 11 Apr
 2024 14:55:16 +0800
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
Subject: [PATCH v2 3/9] arm64/nmi: Add Kconfig for NMI
Date: Thu, 11 Apr 2024 06:48:52 +0000
Message-ID: <20240411064858.3232574-4-liaochang1@huawei.com>
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

From: Mark Brown <broonie@kernel.org>

Since NMI handling is in some fairly hot paths we provide a Kconfig option
which allows support to be compiled out when not needed.

Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Liao Chang <liaochang1@huawei.com>
---
 arch/arm64/Kconfig | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 7b11c98b3e84..c7d00d0cae9e 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -2095,6 +2095,23 @@ config ARM64_EPAN
 	  if the cpu does not implement the feature.
 endmenu # "ARMv8.7 architectural features"
 
+menu "ARMv8.8 architectural features"
+
+config ARM64_NMI
+	bool "Enable support for Non-maskable Interrupts (NMI)"
+	default y
+	help
+	  Non-maskable interrupts are an architecture and GIC feature
+	  which allow the system to configure some interrupts to be
+	  configured to have superpriority, allowing them to be handled
+	  before other interrupts and masked for shorter periods of time.
+
+	  The feature is detected at runtime, and will remain disabled
+	  if the cpu does not implement the feature. It will also be
+	  disabled if pseudo NMIs are enabled at runtime.
+
+endmenu # "ARMv8.8 architectural features"
+
 config ARM64_SVE
 	bool "ARM Scalable Vector Extension support"
 	default y
-- 
2.34.1


