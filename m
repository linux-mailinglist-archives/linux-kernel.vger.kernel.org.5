Return-Path: <linux-kernel+bounces-71616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F2B385A7D8
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 16:50:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4B70B229ED
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 15:50:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 187823AC08;
	Mon, 19 Feb 2024 15:50:46 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C819638DEA;
	Mon, 19 Feb 2024 15:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708357845; cv=none; b=oi2qbWzYRSMbga4vj7Vb0EQFocUz2sd9/25GZNLSA7+VVCr5N2oPFl+szH55CsziXlwM8DuMygr4oX0YXQzuiv38M1ZLZhkTXuKtlEWkY4wXubsYPEyUG9WBMXvM5jdK8pjOBRCjJaI/uXbflllU1/MqgqNiQShUwQAOI3MGkMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708357845; c=relaxed/simple;
	bh=3gljEuQh4fhhlvTwEdHbLdMg7pIM+AmlQfvPws8ZqqY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Dc+aqwZnq0OnyJejVnUar3oX+sn52g0NdZ+F8l7jKtVWO0Mnc4YuP4WVatzUjOP9pZNuMmFIx2VoKwE408f4iJiQPcjmy6WxdbPV6dTyKlWcwgSehOYe32j7qNm9Vi0PyvVm56o5W+C+xwp8yMo+fineqqC5kCiFkSvAIlCY2CU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-IronPort-AV: E=Sophos;i="6.06,170,1705330800"; 
   d="scan'208";a="194447432"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 20 Feb 2024 00:50:41 +0900
Received: from localhost.localdomain (unknown [10.226.92.217])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 56E95400FFE9;
	Tue, 20 Feb 2024 00:50:38 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: tip-bot2@linutronix.de
Cc: apatel@ventanamicro.com,
	linux-kernel@vger.kernel.org,
	linux-tip-commits@vger.kernel.org,
	tglx@linutronix.de,
	geert@linux-m68k.org,
	maz@kernel.org,
	linux-renesas-soc@vger.kernel.org,
	x86@kernel.org
Subject: [tip: irq/msi] genirq/irqdomain: Remove the param count restriction from select()
Date: Mon, 19 Feb 2024 15:50:36 +0000
Message-Id: <170802702416.398.14922976721740218856.tip-bot2@tip-bot2> (raw)
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240127161753.114685-3-apatel@ventanamicro.com>
References: <170802702416.398.14922976721740218856.tip-bot2@tip-bot2>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Now that the GIC-v3 callback can handle invocation with a fwspec parameter
> count of 0 lift the restriction in the core code and invoke select()
> unconditionally when the domain provides it.

This patch breaks on RZ/G2L SMARC EVK as of_phandle_args_to_fwspec count()
is called after irq_find_matching_fwspec() is causing fwspec->param_count=0
and this results in boot failure as the patch removes the check.

Maybe we need to revert this patch or fix the fundamental issue.

Cheers,
Biju
---
 kernel/irq/irqdomain.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index 0bdef4f..8fee379 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -448,7 +448,7 @@ struct irq_domain *irq_find_matching_fwspec(struct irq_fwspec *fwspec,
 	 */
 	mutex_lock(&irq_domain_mutex);
 	list_for_each_entry(h, &irq_domain_list, link) {
-		if (h->ops->select && fwspec->param_count)
+		if (h->ops->select)
 			rc = h->ops->select(h, fwspec, bus_token);
 		else if (h->ops->match)
 			rc = h->ops->match(h, to_of_node(fwnode), bus_token);


