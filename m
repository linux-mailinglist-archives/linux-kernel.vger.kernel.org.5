Return-Path: <linux-kernel+bounces-136081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB3AD89CFD5
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 03:30:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A69BB28211D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 01:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EF174EB45;
	Tue,  9 Apr 2024 01:30:06 +0000 (UTC)
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8C9935894
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 01:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712626205; cv=none; b=MTrN6t0YxqTbrsphOZyXkZRaM6a/N/4G3Oi1P5WxyfRVFj2ycJkvMj/YEoAvCJrKnyNzVhQNIHnwPqtQjD7GAWLZiC4PC4vevbYYYaYWoXDKCxGRZ7PVkYC+911psjpQ9Ybq4blb1YFrrmsjwJNHlGx3iORwIAD2BKZtWXkV3dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712626205; c=relaxed/simple;
	bh=j/XDKuUy7zqhSH3fzlV7mA/mrMxbF9db0YMik4qwT6A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wb0Dudse7tjybWoQ89BH7ESKG19OE1jeyvvyinsisar3GuTsLO6/9wZ+XQqn7cDQD18/RxY4c+J0nhO/mM+IBUINU7HSSGDJ2Me71tqcE9ll0n2vKDPN1SlICJ0wuf9FYY80JnCfc8zTwr86MNp9VGbPBmtH8/W5OqA1rslk3rQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4VD7f84Q2wz21kfl;
	Tue,  9 Apr 2024 09:29:04 +0800 (CST)
Received: from kwepemd200013.china.huawei.com (unknown [7.221.188.133])
	by mail.maildlp.com (Postfix) with ESMTPS id 6B50F140413;
	Tue,  9 Apr 2024 09:29:59 +0800 (CST)
Received: from huawei.com (10.67.174.28) by kwepemd200013.china.huawei.com
 (7.221.188.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.28; Tue, 9 Apr
 2024 09:29:58 +0800
From: Liao Chang <liaochang1@huawei.com>
To: <catalin.marinas@arm.com>, <will@kernel.org>, <maz@kernel.org>,
	<oliver.upton@linux.dev>, <james.morse@arm.com>, <suzuki.poulose@arm.com>,
	<yuzenghui@huawei.com>, <tglx@linutronix.de>, <mark.rutland@arm.com>,
	<ardb@kernel.org>, <broonie@kernel.org>, <liaochang1@huawei.com>,
	<anshuman.khandual@arm.com>, <miguel.luis@oracle.com>, <joey.gouly@arm.com>,
	<ryan.roberts@arm.com>, <jeremy.linton@arm.com>, <liwei391@huawei.com>,
	<daniel.thompson@linaro.org>, <sumit.garg@linaro.org>,
	<kristina.martsenko@arm.com>, <jpoimboe@kernel.org>, <ericchancf@google.com>,
	<robh@kernel.org>, <scott@os.amperecomputing.com>,
	<songshuaishuai@tinylab.org>, <shijie@os.amperecomputing.com>,
	<bhe@redhat.com>, <akpm@linux-foundation.org>, <thunder.leizhen@huawei.com>,
	<horms@kernel.org>, <rmk+kernel@armlinux.org.uk>, <takakura@valinux.co.jp>,
	<dianders@chromium.org>, <swboyd@chromium.org>, <frederic@kernel.org>,
	<reijiw@google.com>, <akihiko.odaki@daynix.com>, <ruanjinjie@huawei.com>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<kvmarm@lists.linux.dev>
Subject: [PATCH 3/9] arm64/nmi: Add Kconfig for NMI
Date: Tue, 9 Apr 2024 01:23:38 +0000
Message-ID: <20240409012344.3194724-4-liaochang1@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240409012344.3194724-1-liaochang1@huawei.com>
References: <20240409012344.3194724-1-liaochang1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemd200013.china.huawei.com (7.221.188.133)

From: Mark Brown <broonie@kernel.org>

Since NMI handling is in some fairly hot paths we provide a Kconfig option
which allows support to be compiled out when not needed.

Signed-off-by: Mark Brown <broonie@kernel.org>
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


