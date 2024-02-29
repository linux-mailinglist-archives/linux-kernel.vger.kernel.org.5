Return-Path: <linux-kernel+bounces-86592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 311F586C781
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 11:57:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B632928910D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 10:57:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25BAC7A711;
	Thu, 29 Feb 2024 10:57:29 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E4A6351C
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 10:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709204248; cv=none; b=LLnW+wteSHYkJm3Z+SDlsk4vOsDe36U2ZcNptn12G1ouH+IXLSXIhrfjO0TeawhEFtplTzCNJV8Yo5gMLgRGMQs5m4ugGazXUIVKUFSPDez+D1aV94elh5DPUmpJ5IZeZC7aZys3ApMFjwZ1N1bBm7ksKdDDYxnlM4cN4A2+IwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709204248; c=relaxed/simple;
	bh=mlQriLFckdSfeNQ7AaJtv9Q/udzqXN7eCK5x+5iiUfg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GZKZUWiwbnZmVK/IRqG9Alek6nLQtBI/3Z6zmPkVBJy9/wZEXF1tP7gqoIzamMZy69kg0kLB5P0VFZom3IEputl3eqmu3tXpUJXI/oZ0SH6EtquwxXUHmTd6wQRYjy1/2w9fm3SL+H4b4rkXSKEr0hJYcuc/vdq5DUmBuDWsDpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Tlp5l1mq0z2BdZj;
	Thu, 29 Feb 2024 18:55:07 +0800 (CST)
Received: from kwepemd100005.china.huawei.com (unknown [7.221.188.91])
	by mail.maildlp.com (Postfix) with ESMTPS id 1FAC5140390;
	Thu, 29 Feb 2024 18:57:23 +0800 (CST)
Received: from kwepemd200013.china.huawei.com (7.221.188.133) by
 kwepemd100005.china.huawei.com (7.221.188.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Thu, 29 Feb 2024 18:57:22 +0800
Received: from huawei.com (10.67.174.28) by kwepemd200013.china.huawei.com
 (7.221.188.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.28; Thu, 29 Feb
 2024 18:57:22 +0800
From: Liao Chang <liaochang1@huawei.com>
To: <catalin.marinas@arm.com>, <will@kernel.org>, <broonie@kernel.org>,
	<mark.rutland@arm.com>, <maz@kernel.org>, <joey.gouly@arm.com>,
	<kristina.martsenko@arm.com>, <liaochang1@huawei.com>,
	<ryan.roberts@arm.com>, <jeremy.linton@arm.com>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] arm64: cpufeatures: Clean up temporary variable to simplify code
Date: Thu, 29 Feb 2024 10:52:08 +0000
Message-ID: <20240229105208.456704-1-liaochang1@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemd200013.china.huawei.com (7.221.188.133)

Clean up one temporary variable to simplifiy code in capability
detection.

Signed-off-by: Liao Chang <liaochang1@huawei.com>
---
 arch/arm64/kernel/cpufeature.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 8d1a634a403e..0e900b23f7ab 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -3052,13 +3052,9 @@ static void __init enable_cpu_capabilities(u16 scope_mask)
 	boot_scope = !!(scope_mask & SCOPE_BOOT_CPU);
 
 	for (i = 0; i < ARM64_NCAPS; i++) {
-		unsigned int num;
-
 		caps = cpucap_ptrs[i];
-		if (!caps || !(caps->type & scope_mask))
-			continue;
-		num = caps->capability;
-		if (!cpus_have_cap(num))
+		if (!caps || !(caps->type & scope_mask) ||
+		    !cpus_have_cap(caps->capability))
 			continue;
 
 		if (boot_scope && caps->cpu_enable)
-- 
2.34.1


