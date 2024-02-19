Return-Path: <linux-kernel+bounces-71847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7902785ABAC
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 19:59:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A34AB2551E
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 18:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 296A9495DB;
	Mon, 19 Feb 2024 18:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TymjM0U4"
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC12B482FA
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 18:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708369107; cv=none; b=ePrMEKKjfefBlXVD12eAYNccFWXNRVUrS/1nqRzszoBCCrE94R85eLZheAIVmx4GpkSgzyQNTMjRTTul15HH2Knq4t7koajSg9UIeGarjRHvp2pUkPtpSa3UP9hodDrnQG6MrqLBwmQo+kmdnuBStd+dIafV/9zk+YqD2fgEzRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708369107; c=relaxed/simple;
	bh=yXY4BKwNMqksd8A/oUnvq+Iq0aUB3gr/Y3i4+5lzsvA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XEiV+Dxi6peydmR5eKuE/t/Sko1MTkGYG6mKlzR2Q3XYeY/gDQNDy63yAzdqV5nPLPoMmrFjhHtAOl9AjVvIfoZ7VtJqj4g0ooXSnNgIcOrgg6e+jP+tGm72h2WbIrnJpFJE09JgwkCu/VE11w9Z9bBS0EYNU/d7i/dC2mfkCQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TymjM0U4; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708369103;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=malznfxmTFeYI5AQuBOcx//3J2Klq63IEw4UgO+FW8I=;
	b=TymjM0U4219Zm3uEd/Lb8NxsD72R3xzRJZRLZBjvd9XHgLBu8YMPWhynBzrl8JRv3paxch
	lwj9pWCJOssGT/aTbkmYfA4DY/0hoWqJyMUQMa+NXEZkMY7B5s52UXj0Q2QgC1umO8It4y
	kkbdXBlbN4LMCE9vFrfXl6eQVykFEc8=
From: Oliver Upton <oliver.upton@linux.dev>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Marc Zyngier <maz@kernel.org>,
	Zenghui Yu <yuzenghui@huawei.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	kvmarm@lists.linux.dev,
	Jing Zhang <jingzhangos@google.com>,
	Oliver Upton <oliver.upton@linux.dev>,
	stable@vger.kernel.org,
	George Cherian <gcherian@marvell.com>
Subject: [PATCH 1/3] irqchip/gic-v3-its: Do not assume vPE tables are preallocated
Date: Mon, 19 Feb 2024 18:58:06 +0000
Message-ID: <20240219185809.286724-2-oliver.upton@linux.dev>
In-Reply-To: <20240219185809.286724-1-oliver.upton@linux.dev>
References: <20240219185809.286724-1-oliver.upton@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

We go through quite a bit of trouble to make sure we pick up any
preallocated LPI tables on the redistributors, as enabling LPIs is a
one-way switch. There is no such restriction for vLPIs, and for GICv4.1
we expect to allocate a new vPE table at boot.

This works as intended when initializing an ITS, however when setting up
a redistributor in its_cpu_init_lpis() the early return for preallocated
RD tables skips straight past GICv4 setup. This all comes to a head when
trying to kexec into a new kernel, as the new kernel silently fails to
set up GICv4, leading to a complete loss of SGIs and LPIs for KVM VMs
(ouch).

Slap a band-aid on the problem by ensuring its_cpu_init_lpis() always
initializes GICv4 on the way out, even if the other RD tables were
preallocated.

Cc: stable@vger.kernel.org
Fixes: 6479450f72c1 ("irqchip/gic-v4: Fix occasional VLPI drop")
Reported-by: George Cherian <gcherian@marvell.com>
Co-developed-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Oliver Upton <oliver.upton@linux.dev>
---

I debated a bit on the fixes tag between the blamed commit and commit
5e5168461c22 ("irqchip/gic-v4.1: VPE table (aka GICR_VPROPBASER)
allocation"), although it would appear GICv4 could be left in an unknown
state after kexec too.

 drivers/irqchip/irq-gic-v3-its.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index d097001c1e3e..0022852ce494 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -3172,6 +3172,7 @@ static void its_cpu_init_lpis(void)
 	val |= GICR_CTLR_ENABLE_LPIS;
 	writel_relaxed(val, rbase + GICR_CTLR);
 
+out:
 	if (gic_rdists->has_vlpis && !gic_rdists->has_rvpeid) {
 		void __iomem *vlpi_base = gic_data_rdist_vlpi_base();
 
@@ -3207,7 +3208,6 @@ static void its_cpu_init_lpis(void)
 
 	/* Make sure the GIC has seen the above */
 	dsb(sy);
-out:
 	gic_data_rdist()->flags |= RD_LOCAL_LPI_ENABLED;
 	pr_info("GICv3: CPU%d: using %s LPI pending table @%pa\n",
 		smp_processor_id(),
-- 
2.44.0.rc0.258.g7320e95886-goog


