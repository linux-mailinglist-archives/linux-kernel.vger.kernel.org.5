Return-Path: <linux-kernel+bounces-32582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C6ED7835D80
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 10:00:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04A981C243B9
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 09:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 875E2374C1;
	Mon, 22 Jan 2024 09:00:01 +0000 (UTC)
Received: from smtpbg154.qq.com (smtpbg154.qq.com [15.184.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CBC639FD1;
	Mon, 22 Jan 2024 08:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=15.184.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705914001; cv=none; b=LGfkHPLpnBjN1JLCQPxu/oKgBx4O+ciFJ85kFL3xhz/0RHr1eec5Tf45Ycn7sFRoJLkSUQJuGMtCLsHp100Ldj2hSUZECPA243nKI9xproz+WrIFcgOSiMQD8MYZJ5C777DAQMjkg7pYOEPzE4RaFLnv8IxTRHbIL6u3LFUx6fA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705914001; c=relaxed/simple;
	bh=Z2QO+ZNbexrvCNmBOmbx82ARDt5b9Gh1U8R95xFIBzk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nOpKENIod5Liynu41q3CGz/QtfuKU+P04yLdWuzWxdz1wbDPUkGqEXSh/fG9MTrxZgXvj64wB+faOSnS4J3CbBMr03QfZsxpB00khiY2yp+g5E7dXnNNnvhshxfXYmLKo7OVPs1zAiy76dy8Ctw5aVltM0RtpFBcJGjaLVvwLk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn; spf=pass smtp.mailfrom=shingroup.cn; arc=none smtp.client-ip=15.184.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shingroup.cn
X-QQ-mid: bizesmtp69t1705913968t4x91ja8
X-QQ-Originating-IP: gUy0qjJACJmrxRTWjfX/xlWmCxQVo4qzhx3gV7F419E=
Received: from localhost ( [183.209.108.228])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 22 Jan 2024 16:59:26 +0800 (CST)
X-QQ-SSF: 01400000000000504000000A0000000
X-QQ-FEAT: IcCSTr/hHjNrGNwJGBhoO6iQm9TbZEJVmwOVI/u90M+u6dL3vPHrcIcOGVpYE
	3xnlu/yVMyOGkIJ66R4R6neq8C/BM94XzIVAWppJE1t5/EBTlH16aGVL2ZG2Cuq7ti6EHEl
	dICnf+4WHwFK2FYyeN5SAYUWxzfnnyd+Y4EdNv/RTyv4+OwaNrW5RuUvfC6oPlrh6jOAj9g
	Jjv0kMj4f2l6sbW8lZtbreylbZqv4IS/lw4sRpztsh+MVPGhtuBoaJdGFTIH8IYChJnPA+I
	Uc0R9vTKFF4jdMVoEjWkQYeAHzWOAoP2dWvlvtCtRlQFgdM62WGIZ0CiL1H/D39d3hcp37b
	2vO55zzySM78h8yB8PZ6DQ34ZuhIanlAE9x6s82ulILRUbuhe0MPtyJk47ESPwippLBb2of
	wwXoP/E3Xepk6H1MgSGFig==
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 16519766725060776921
From: Dawei Li <dawei.li@shingroup.cn>
To: tglx@linutronix.de,
	maz@kernel.org
Cc: sdonthineni@nvidia.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	dawei.li@shingroup.cn,
	set_pte_at@outlook.com,
	stable@vger.kernel.org
Subject: [PATCH v2 4/5] genirq: Initialize resend_node hlist for all irq_desc
Date: Mon, 22 Jan 2024 16:57:15 +0800
Message-Id: <20240122085716.2999875-5-dawei.li@shingroup.cn>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20240122085716.2999875-1-dawei.li@shingroup.cn>
References: <20240122085716.2999875-1-dawei.li@shingroup.cn>
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

Acked-by: Marc Zyngier <maz@kernel.org>
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


