Return-Path: <linux-kernel+bounces-30055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1179283187A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 12:31:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9236DB2394A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 11:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9720D23776;
	Thu, 18 Jan 2024 11:30:39 +0000 (UTC)
Received: from bg1.exmail.qq.com (bg1.exmail.qq.com [114.132.124.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 045B624A0C;
	Thu, 18 Jan 2024 11:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.132.124.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705577439; cv=none; b=E9ISZHOV1jHEXcylzFVd5ujefgbNqg3bt/0wAqxitmHi2IybqHCxWfCFY6Mvd1eQ+t+CwyfmtpasOaJNrAeW7n6mMIfNccoqJi7pi1WmUyIVqHTeEp34GxrkRn9/PwNrZxc2jKf50Zi47X6TE3ny9Xq74S/fWYfI4tp3nxSAogU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705577439; c=relaxed/simple;
	bh=MTfDNh/H4RzACudbIKWTS9CwPWm85VD13SywdtsfirI=;
	h=X-QQ-mid:X-QQ-Originating-IP:Received:X-QQ-SSF:X-QQ-FEAT:
	 X-QQ-GoodBg:X-BIZMAIL-ID:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-QQ-SENDSIZE:Feedback-ID; b=JdO2N9p86UrwqBO9VfkSpnPE4Rd7oLkKMr5IA1T4ADc8NpuCGP7UZXXfKd+SwHVlfAt3uHtrdMD50y+oAMY7kenTlgbPyxqd3Q++I1Gzi59NN6VV6FiyZn1XU0H3UXXKfXybFxl8xDbSD5PmA1DAIzcqDHTnumEkQR3HspfFFCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn; spf=pass smtp.mailfrom=shingroup.cn; arc=none smtp.client-ip=114.132.124.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shingroup.cn
X-QQ-mid: bizesmtp73t1705577390tkg4v9vl
X-QQ-Originating-IP: aAaUCGoHCcdq2hp9fxQg6peErxbrvoXx7bAu/R6yqng=
Received: from localhost ( [183.209.108.228])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 18 Jan 2024 19:29:48 +0800 (CST)
X-QQ-SSF: 01400000000000504000000A0000000
X-QQ-FEAT: 3M0okmaRx3ibVvpE3700jKK10kv893khAgTcIyG6+NPJ+eepQqQ0gVty3jdFg
	K/uKj5OqV0RO6mEgw4TclQmACO/shCVYvH3En/+KEyKkKNsBQXnJ/oMH3C4yO8QeB1wDS9c
	0CYh3pAxHXHVBf5jgWwgZsBWmD9zWufKb9BVmr4aw2M3cwEkVQyzjXZe5blV/GHmA4OnvOP
	P9VKVgfiG9Q16PbOuV0DONspkzna8UdleWXn3Xn+5ua/fJLimjm4WK/h5gHxnKjSZfokqkV
	3NguAy1Bp3sH/Vj4RZ+ZLO171tDHaCGOz9zBRe7o7J47vVqLyVoQoKPnL+IYuO9LsOE0FGq
	UtaSRbsNBh0CSxfxB5ioAZAsTHMYrx37Ol5zzgjr6/jclqYngv2VrLRS4eFM3Cy7ScRxMa6
	24UsMzyQaZw=
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 10002877068990544694
From: Dawei Li <dawei.li@shingroup.cn>
To: tglx@linutronix.de,
	maz@kernel.org
Cc: sdonthineni@nvidia.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	dawei.li@shingroup.cn,
	set_pte_at@outlook.com,
	stable@vger.kernel.org
Subject: [PATCH 4/4] genirq: Initialize resend_node hlist for all irq_desc
Date: Thu, 18 Jan 2024 19:27:39 +0800
Message-Id: <20240118112739.2000497-5-dawei.li@shingroup.cn>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20240118112739.2000497-1-dawei.li@shingroup.cn>
References: <20240118112739.2000497-1-dawei.li@shingroup.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:shingroup.cn:qybglogicsvrgz:qybglogicsvrgz5a-1

For !CONFIG_SPARSE_IRQ kernel, early_irq_init() is supposed to
initialize all the desc entries in system, desc->resend_node
included.

Thus, initialize desc->resend_node for all irq_desc entries, rather
than irq_desc[0] only, which is the current implementation is about.

Fixes: bc06a9e08742 ("genirq: Use hlist for managing resend handlers")
Cc: stable@vger.kernel.org

Signed-off-by: Dawei Li <dawei.li@shingroup.cn>
---
 kernel/irq/irqdesc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index 27ca1c866f29..371eb1711d34 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -600,7 +600,7 @@ int __init early_irq_init(void)
 		mutex_init(&desc[i].request_mutex);
 		init_waitqueue_head(&desc[i].wait_for_threads);
 		desc_set_defaults(i, &desc[i], node, NULL, NULL);
-		irq_resend_init(desc);
+		irq_resend_init(&desc[i]);
 	}
 	return arch_early_irq_init();
 }
-- 
2.27.0


