Return-Path: <linux-kernel+bounces-105752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BFE087E3D6
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 07:55:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55C8F1C20895
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 06:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93DAB22638;
	Mon, 18 Mar 2024 06:55:10 +0000 (UTC)
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7BF022612
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 06:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.34.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710744910; cv=none; b=irZRwEiy0RrCG0Y5ZBzFzgNKyfKG+EjxCkM2Gps4lolKKoIxxASIqQ8G13y0Ll19udZCjd39+YDZFARyotfyH/IMVbKypOHMB3VXEGwEfNs/E6hwPFAQGTaO7KIjsUsGm0JzvqPOw4e72S27/YsbGP9y9brTjoFze4owO2pxeq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710744910; c=relaxed/simple;
	bh=540CYIWp3OBkTR2JQL/pJUtoqDFk8g79k7lECsKKlW8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZuFZmAIJbw0zlRK+PQ/TTiFHuejIxbXhiOJCs2QaXXCs+YkhdCfMqZn9bQuxBlA0adGHfi7OlNprwtS1DQm8FO6OwATfBFpj1vQWoQsyt+9L3YHr86gfIjJySgb75Pr5+VaHdP5zNZnaiAcOdeNV83rmvpvOpnFdcKaA1CjrqAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn; spf=pass smtp.mailfrom=shingroup.cn; arc=none smtp.client-ip=54.206.34.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shingroup.cn
X-QQ-mid: bizesmtp67t1710744854tfxcwua3
X-QQ-Originating-IP: mrevuy/Rs539dEBlGNPPK3F3bnF1JYIlXxZ0h2VzWw0=
Received: from HX01040049.powercore.com.cn ( [116.21.68.104])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 18 Mar 2024 14:54:08 +0800 (CST)
X-QQ-SSF: 0140000000000090B000000A0000000
X-QQ-FEAT: LE7C6P2vL8S2AsPvDMxMsr7RnQBDCpTCdqZRGD02RV6WKILltgocXch7agQkR
	OKeWW5jdgoxVH661xRpnaGH9wX5ng4BBorVUtQAEhdo2EL8BWGNdwBuJ21QafppND8J98vg
	fVvjpZRwxR9yhn86JY0pLCpGWwhGiol6lBtFouRW6ilaNffNqLF737/g0DxEEYsBcMgDhQG
	5b3Wn4rBPkyp3irnHrJZLdp29vZMmz5RjPuSsFt6gPF5KHIgUa/8+dMHWnT40HIY4khlCwc
	Qte7n8jZQ4IftAuaI7wD8s+Ay66+ZM04f/5h38U0Wxbn4CgCaWYj7sDRTqVBLNjPHzERNCG
	EF9IrHjG7ZaLE9G5paFL5WCra9OC0bdspBtkE6cf+iaFOT7Zm+DPz/sDhynww==
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 15004159612326503418
From: Zhao Ke <ke.zhao@shingroup.cn>
To: paul.walmsley@sifive.com,
	aou@eecs.berkeley.edu
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	dawei.li@shingroup.cn,
	shenghui.qu@shingroup.cn,
	ke.zhao@shingroup.cn
Subject: [PATCH] Use bool value in set_cpu_online()
Date: Mon, 18 Mar 2024 14:54:04 +0800
Message-Id: <20240318065404.123668-1-ke.zhao@shingroup.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:shingroup.cn:qybglogicsvrsz:qybglogicsvrsz3a-0

The declaration of set_cpu_online() takes a bool value. So replace
int here to make it consistent with the declaration.

Signed-off-by: Zhao Ke <ke.zhao@shingroup.cn>
---
 arch/riscv/kernel/smpboot.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
index 519b6bd946e5..3f7c274653ab 100644
--- a/arch/riscv/kernel/smpboot.c
+++ b/arch/riscv/kernel/smpboot.c
@@ -229,7 +229,7 @@ asmlinkage __visible void smp_callin(void)
 	riscv_ipi_enable();
 
 	numa_add_cpu(curr_cpuid);
-	set_cpu_online(curr_cpuid, 1);
+	set_cpu_online(curr_cpuid, true);
 
 	if (has_vector()) {
 		if (riscv_v_setup_vsize())
-- 
2.34.1


