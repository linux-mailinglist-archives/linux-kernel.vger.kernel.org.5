Return-Path: <linux-kernel+bounces-149913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 049098A97CD
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 12:51:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 360071C20E05
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 10:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54FCD15E5B7;
	Thu, 18 Apr 2024 10:50:43 +0000 (UTC)
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A35915E1F0;
	Thu, 18 Apr 2024 10:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.194.254.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713437442; cv=none; b=kaktEsyTVWxZFg9Jt4h4NOhR1vV0eUYClPBW2oWJ5jo8QJCq0yp2CBaZO8NeesLYjGh2PonwXCpPUS4Q2dGKDOHm74c+tUlakEV52PzmjjUT8m4EUpRaf5ie4un3u39zKFymCV819Fb4lM3msH3GKeXhT3NdfGS/AL9PVT81FLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713437442; c=relaxed/simple;
	bh=v+TsHhOic2mg/W7XaFw3VXmkSiLUX6C2ryCfDoKko/M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iCcC/hzL9VpRS0Ogy7nemnSKOP5kTGPHGXR8j7MgHjKsvcewmd9fmI2Jzq/+HjflPSh2oAC+Vp6hGBEJtjkh3MlDrO6o+xAuDy2K2LmUwMcSZzQ2sAQ/bV8LMAhC1WJkNmfmJ3T3fZa3poONGp0LQlPgcjVWC3eP6Okx6L8/fh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn; spf=pass smtp.mailfrom=shingroup.cn; arc=none smtp.client-ip=18.194.254.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shingroup.cn
X-QQ-mid: bizesmtpsz8t1713437412tqw6p93
X-QQ-Originating-IP: WpIr14ItWW3kn7iY60aK0PXSNTpq8Q1puqksk+zM4H0=
Received: from localhost ( [112.0.147.129])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 18 Apr 2024 18:50:10 +0800 (CST)
X-QQ-SSF: 01400000000000903000000A0000000
X-QQ-FEAT: ILHsT53NKPgF/epwiDI/4li9pVuruvg8/g0sLIWJRf2YdA0Z9a72l36WAi2Tp
	17Mu6Tdm3hRyqu7SMKiCMfuHMMVKSImTiX0pUMsUc5uqRNlUAu7dPls0/AsxD1+5TZ0eSmF
	jtrOa8lsApsYN5w6adzLqiHt24ZghiivAVyKsHjFeczCyNY+JLri5u6LWEEwlr72Bfw/v9B
	4djHd7gQegJb0CzsKq4wR+c+SorgrlB7rngLTr2bbxi3xmGuuqjL61kuvydJHS6ASNP1h7f
	K32FJUi6aAD5+QRYwHwNRi4X4pBTxO7gmsXhEr3LN0plsNubY6hPqoLkSUosbShfJV32uAj
	QKfHsusLVt6d0hiB+LxcrL5LWN6IBjJ0NMG+NIw2Q4pTgiPtslesrh/Jnk8f4HJxcvtLHWH
	aHxSl6E4fn8mvNT5hfFRLQ==
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 3648981726944684466
From: Dawei Li <dawei.li@shingroup.cn>
To: davem@davemloft.net,
	andreas@gaisler.com
Cc: sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dawei Li <dawei.li@shingroup.cn>
Subject: [PATCH 2/5] sparc/irq: Remove on-stack cpumask var
Date: Thu, 18 Apr 2024 18:49:46 +0800
Message-Id: <20240418104949.3606645-3-dawei.li@shingroup.cn>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20240418104949.3606645-1-dawei.li@shingroup.cn>
References: <20240418104949.3606645-1-dawei.li@shingroup.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:shingroup.cn:qybglogicsvrgz:qybglogicsvrgz5a-1

In general it's preferable to avoid placing cpumasks on the stack, as
for large values of NR_CPUS these can consume significant amounts of
stack space and make stack overflows more likely.

- Both 2 arguments of cpumask_equal() is constant and free of change, no
  need to allocate extra cpumask variables.

- Merge cpumask_and(), cpumask_first() and cpumask_empty() into
  cpumask_first_and().

Signed-off-by: Dawei Li <dawei.li@shingroup.cn>
---
 arch/sparc/kernel/irq_64.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/arch/sparc/kernel/irq_64.c b/arch/sparc/kernel/irq_64.c
index 5280e325d4d6..bc96f1bcd2fc 100644
--- a/arch/sparc/kernel/irq_64.c
+++ b/arch/sparc/kernel/irq_64.c
@@ -349,17 +349,13 @@ static unsigned int sun4u_compute_tid(unsigned long imap, unsigned long cpuid)
 #ifdef CONFIG_SMP
 static int irq_choose_cpu(unsigned int irq, const struct cpumask *affinity)
 {
-	cpumask_t mask;
 	int cpuid;
 
-	cpumask_copy(&mask, affinity);
-	if (cpumask_equal(&mask, cpu_online_mask)) {
+	if (cpumask_equal(affinity, cpu_online_mask)) {
 		cpuid = map_to_cpu(irq);
 	} else {
-		cpumask_t tmp;
-
-		cpumask_and(&tmp, cpu_online_mask, &mask);
-		cpuid = cpumask_empty(&tmp) ? map_to_cpu(irq) : cpumask_first(&tmp);
+		cpuid = cpumask_first_and(affinity, cpu_online_mask);
+		cpuid = cpuid < nr_cpu_ids ? : map_to_cpu(irq);
 	}
 
 	return cpuid;
-- 
2.27.0


