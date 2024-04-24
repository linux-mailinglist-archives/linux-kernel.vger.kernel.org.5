Return-Path: <linux-kernel+bounces-156178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 418E58AFEE2
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 04:56:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 739D31C22806
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 02:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D883185274;
	Wed, 24 Apr 2024 02:56:36 +0000 (UTC)
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5436A83CD6;
	Wed, 24 Apr 2024 02:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.34.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713927396; cv=none; b=eBsuxbB3dSihpNHPpH5bbMeD0rlGZ1PK0NlgoRJRF6984SfuQxPRb0AwnGWAUhrqnQnGNp0Dl6v+wWqY3K+IeVDzhUEM7hr3EzvI8jjKRMizJRlpM9+6xiIkGf0RtjlYkSj57QvhrnZbi9OFBt/v0zxLhr1VwiW8l2X8L9bQU3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713927396; c=relaxed/simple;
	bh=N6XTfdxhJpxdxT4fVSZa/iMWuusbHZ+zYGBsuw2wehU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RcFys5OkvNooH02opqoBKl0HzMYJe84lM/RkQUzOGuNpFUPEQxeVAFFU0WxmtXeznE1YQ4qExNhCokzIA2D1wlrBsYgx1PWhfxDUbBCSDSar6xPdEfA7+XAwuQ8GrT0du3HMJE3Bj23f0lxATnlSK7u2ei5kxBVKwzjt7FP0XN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn; spf=pass smtp.mailfrom=shingroup.cn; arc=none smtp.client-ip=54.206.34.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shingroup.cn
X-QQ-mid: bizesmtp82t1713927368tef5l9jp
X-QQ-Originating-IP: vQmXng/c3dGqL6fSQ4IxNGeevQoaOnnsVqltFEHgBq4=
Received: from localhost ( [112.0.147.129])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 24 Apr 2024 10:56:06 +0800 (CST)
X-QQ-SSF: 01400000000000903000000A0000000
X-QQ-FEAT: xo0edGM1fUg8OrjGWNCZct+YyvqES/JAHSbFFKFnwFlgur39ypV4UskcVQyYP
	my9UL+zR8lm+96oqM4Iez/ISdHGwwW6dLM65UV+wSB5NDzjH5Id1DhhMi6/fPe0GxJfmQyu
	DNGqR2JeKx9TBeNMMZWlVTOlKk2B0JXCyHzvyMn/PGgFHhtCLaWVOmBArTKpzuRklSuecJZ
	O5lowNPUopa1JQUpq+mWuoSA4tfng6Oq25+HOJrHgPyIDQS0OsUaDG+Fk9LVv4xahfUi+ej
	rebCGQXKbsD1vjwF+CZgHPN02Lf09kTzmZ7QcSGdpyKDhbic9GjP/KQ0abj0H0VS2WJ5H7A
	wauoaOfWOTvz+NqKf6niy4S/RiGgIra3PnsaMtI/osZqIle5QS7XKMWC9DEWdg9P8XQDUEg
	n2cZ1D4jsNxfsWO2LHa+Uw==
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 14914195552382651279
From: Dawei Li <dawei.li@shingroup.cn>
To: davem@davemloft.net,
	andreas@gaisler.com
Cc: sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sam@ravnborg.org,
	Dawei Li <dawei.li@shingroup.cn>
Subject: [PATCH v4 2/5] sparc/irq: Remove on-stack cpumask var
Date: Wed, 24 Apr 2024 10:55:45 +0800
Message-Id: <20240424025548.3765250-3-dawei.li@shingroup.cn>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20240424025548.3765250-1-dawei.li@shingroup.cn>
References: <20240424025548.3765250-1-dawei.li@shingroup.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:shingroup.cn:qybglogicsvrgz:qybglogicsvrgz5a-1

In general it's preferable to avoid placing cpumasks on the stack, as
for large values of NR_CPUS these can consume significant amounts of
stack space and make stack overflows more likely.

- Both 2 arguments of cpumask_equal() is constant and free of change, no
  need to allocate extra cpumask variables.

- Merge cpumask_and(), cpumask_first() and cpumask_empty() into
  cpumask_first_and().

Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
Signed-off-by: Dawei Li <dawei.li@shingroup.cn>
---
 arch/sparc/kernel/irq_64.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/arch/sparc/kernel/irq_64.c b/arch/sparc/kernel/irq_64.c
index 5280e325d4d6..01ee800efde3 100644
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
+		cpuid = cpuid < nr_cpu_ids ? cpuid : map_to_cpu(irq);
 	}
 
 	return cpuid;
-- 
2.27.0


