Return-Path: <linux-kernel+bounces-30053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70A30831875
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 12:30:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A301D1C209BC
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 11:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD2B524B3A;
	Thu, 18 Jan 2024 11:30:10 +0000 (UTC)
Received: from smtpbg154.qq.com (smtpbg154.qq.com [15.184.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E5924B37
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 11:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=15.184.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705577410; cv=none; b=X3IHwm0mPAvEN8fhHZVHdSCwyI7K7Hyj+wkxafPj2fYUSrHPqvCEDVuUDPL+1fKl2De8XKtwnks9h7wXDCo+8FBeNKmOF+LujPdLZdEOnGndN/7Si/YIeGENGmitpy7HY+50s1vHBz8MfPBA873D1Yzk3p3TAzAetUgiTUGu5cU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705577410; c=relaxed/simple;
	bh=sZRxiKPZbRZd+nZlIZp3YhXFKhPnZo9TfDEOQiXJZmg=;
	h=X-QQ-mid:X-QQ-Originating-IP:Received:X-QQ-SSF:X-QQ-FEAT:
	 X-QQ-GoodBg:X-BIZMAIL-ID:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-QQ-SENDSIZE:Feedback-ID; b=bb5sK71/BXM9d0QwgfRrr8s9u6+N/VXLvGgCuP7+ioIkgkvXeAMNln5a0GwER1Xqha+lMF+yHRici8kBafLMWqfN8+Cl5Yn02jH86aW3lGdG2jlR9nfj4NlA/Hp0+XTAXMWJM4uUL29r0PAVaxdffExoUmRz78/hoB7a8/ukmDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn; spf=pass smtp.mailfrom=shingroup.cn; arc=none smtp.client-ip=15.184.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shingroup.cn
X-QQ-mid: bizesmtp64t1705577375tqna5agw
X-QQ-Originating-IP: b06gOG+G3Lt6KugAxVb03XfVjcun9/KJ61laat0Gq3c=
Received: from localhost ( [183.209.108.228])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 18 Jan 2024 19:29:33 +0800 (CST)
X-QQ-SSF: 01400000000000504000000A0000000
X-QQ-FEAT: LE7C6P2vL8RlqSltv7bKQonFxSrBkzY45rkHE2qduRISj3gifYQW1NYxZmPvm
	jHGnf7gO9u3FjRdCcBL0zlG8ieH1YMhRfmqHS2tnadsqgbBg8VnfcyID4sbmW0oH9RtE7+n
	yIRx53YSXX/pLkKIGZ0Y/5eJy1dRzUbFy7N2/rqZKJbTE8LQqTCp+g/xyDDBKM4/TqWwFCV
	XUeAnS9rFCMSBbNjDCg64oPEhzMXL9PPVS6mVxFl4Aemhe+mvcJPFEK6ucRYxI6ddfpsr5F
	JA2i5LfP/9bw5M8Z/djr/oh3MdS2FhOX4mQGwKNl83LEDY/ftM0F5+0NHHwPLmhrUO+RhVR
	PFDVLSdG1EZHm+K+YMNj2iISep7xUzqOebY2U/mBtz9E0b7hmlC79WQhWW5rZr4DrtWb0K1
	7dFuZyjWMA4=
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 10466252816895752989
From: Dawei Li <dawei.li@shingroup.cn>
To: tglx@linutronix.de,
	maz@kernel.org
Cc: sdonthineni@nvidia.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	dawei.li@shingroup.cn,
	set_pte_at@outlook.com
Subject: [PATCH 2/4] irqchip/gic: Implement generic gic_irq() API for GIC & GIC-v3
Date: Thu, 18 Jan 2024 19:27:37 +0800
Message-Id: <20240118112739.2000497-3-dawei.li@shingroup.cn>
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

GIC & GIC-v3 share same gic_irq() implementations, unify them into a
generic API.

Signed-off-by: Dawei Li <dawei.li@shingroup.cn>
---
 drivers/irqchip/irq-gic-common.h | 5 +++++
 drivers/irqchip/irq-gic-v3.c     | 5 -----
 drivers/irqchip/irq-gic.c        | 5 -----
 3 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/irqchip/irq-gic-common.h b/drivers/irqchip/irq-gic-common.h
index f407cce9ecaa..ed18db4ab2c5 100644
--- a/drivers/irqchip/irq-gic-common.h
+++ b/drivers/irqchip/irq-gic-common.h
@@ -19,6 +19,11 @@ struct gic_quirk {
 	u32 mask;
 };
 
+static inline unsigned int gic_irq(struct irq_data *d)
+{
+	return d->hwirq;
+}
+
 int gic_configure_irq(unsigned int irq, unsigned int type,
                        void __iomem *base, void (*sync_access)(void));
 void gic_dist_config(void __iomem *base, int gic_irqs,
diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index b9d9375a3434..474a498a521e 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -181,11 +181,6 @@ static enum gic_intid_range get_intid_range(struct irq_data *d)
 	return __get_intid_range(d->hwirq);
 }
 
-static inline unsigned int gic_irq(struct irq_data *d)
-{
-	return d->hwirq;
-}
-
 static inline bool gic_irq_in_rdist(struct irq_data *d)
 {
 	switch (get_intid_range(d)) {
diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index 412196a7dad5..0d559effa172 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -162,11 +162,6 @@ static inline void __iomem *gic_cpu_base(struct irq_data *d)
 	return gic_data_cpu_base(gic_data);
 }
 
-static inline unsigned int gic_irq(struct irq_data *d)
-{
-	return d->hwirq;
-}
-
 static inline bool cascading_gic_irq(struct irq_data *d)
 {
 	void *data = irq_data_get_irq_handler_data(d);
-- 
2.27.0


