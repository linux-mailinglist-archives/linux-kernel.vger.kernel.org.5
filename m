Return-Path: <linux-kernel+bounces-80197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2321862BAA
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 17:20:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C7FDB20E22
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 16:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3FBA17BAE;
	Sun, 25 Feb 2024 16:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ci6fGVPi";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OTbLn3FO"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE8C17BA3
	for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 16:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708877997; cv=none; b=DgxM3qtCtZ5ToDdWofilzOF+xnLn89IgrHPy57XI5ypWVuCIWMpqdnr6ys+Y3PJzJLgkqVHrgqdjPfbOdTobaDUfeXMqmhr0pSckqj9jDZ4WrB83LGOSPLxAP/DPkWU/aZHpqRiIC37kqqLtbZunuw1YV/mg1FHU+f1HM207GEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708877997; c=relaxed/simple;
	bh=xj3WOVgz3/BYLzvoZp63A8tXW4n/dMlOHyItQ2nC/rc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IfYSSKzuySg33zKe69SkMJLfO4lKHFH8UQ5CEUeU71Wz1Az6kKuNqogFN2LnQVHsyz9HIQIXyImGWxEfZjqntWzA50KVXebGiEkT8rvUOgpfjifl4+zItzgzs6B9KQgkOQRwyAqm9UgErYO5Ut+k45XKQBzscemDLSZbq0vYt9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ci6fGVPi; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OTbLn3FO; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708877993;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PlSwHlYyP4A1LQLM6WxxKKT7h2/VeDpm0ciAvRcDloc=;
	b=Ci6fGVPi67dsuI+pA8wRiO25XadBUbZBt36zP0dmEbN50AKebM2LZjqtdgtn2s4HVcC1mR
	MMwPatCc0oWsi3WlxwYxsSsoj47FmlcBW/W+g92RCrbSTmkNCIWn973Bxtwp+jOT0LkcxK
	MQifHIbvnnbzOCRfvhXL+yEBgHqptfpp1Vipvw5BoYSP+n3ZlESRq6oqJzXTuiaqHg2iZg
	GN3E906V0ld40MNo8+sr8C6MGyU9vW0O/EliL6k9dhk2zTMss97TiUk1dKai91bfHqI3sz
	Q6kN5Aa6GVvR1wHCSCp2i7agqbcf0w9oC/h3Z1hzjmv5EOjuUfLWkr3qybt6WQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708877993;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PlSwHlYyP4A1LQLM6WxxKKT7h2/VeDpm0ciAvRcDloc=;
	b=OTbLn3FOnEx7pXryJfAuqowgc2oH0s2w7hymW0tm0P9Gisl4Db/QiKQv6gJqvVYOjzE595
	6AW0Tuq8RIG6EIDw==
To: Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Biju Das
 <biju.das.jz@bp.renesas.com>, x86@kernel.org
Subject: Re: [PATCH] genirq/irqdomain: Don't call ops->select for
 DOMAIN_BUS_ANY tokens
In-Reply-To: <20240220114731.1898534-1-maz@kernel.org>
References: <20240220114731.1898534-1-maz@kernel.org>
Date: Sun, 25 Feb 2024 17:19:52 +0100
Message-ID: <878r38cy8n.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Feb 20 2024 at 11:47, Marc Zyngier wrote:
> Users of the IRQCHIP_PLATFORM_DRIVER_{BEGIN,END} helpers rely
> on a fwspec containing only the fwnode (and crucially a number
> of parameters set to 0) together with a DOMAIN_BUS_ANY token
> to check whether a parent irqchip has probed and registered
> a domain.
>
> Since de1ff306dcf4 ("genirq/irqdomain: Remove the param count
> restriction from select()"), we call ops->select unconditionally,
> meaning that irqchips implementing select now need to handle
> ANY as a match.
>
> Instead of adding more esoteric checks to the individual drivers,
> add that condition to irq_find_matching_fwspec(), and let it
> handle the corner case, as per the comment in the function.
>
> This restores the functionnality of the above helpers.
>
> Reported-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Tested-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Reported-by: Biju Das <biju.das.jz@bp.renesas.com>
> Fixes: de1ff306dcf4 ("genirq/irqdomain: Remove the param count restriction from select()")
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> Link: https://lore.kernel.org/r/20240219-gic-fix-child-domain-v1-1-09f8fd2d9a8f@linaro.org

Bah. That breaks x86 because it uses DOMAIN_BUS_ANY to find the MSI
parent for a fwspec (IOAPIC and HPET) which gets either picked up by the
interrupt remapping or by the root vector domain.

Fix below.

Thanks,

        tglx
---
Subject: x86/apic/msi: Use DOMAIN_BUS_GENERIC_MSI for HPET/IO-APIC domain search
From: Thomas Gleixner <tglx@linutronix.de>
Date: Sun, 25 Feb 2024 16:56:12 +0100

The recent restriction to invoke irqdomain_ops::select() only when the
domain bus toke is DOMAIN_BUS_ANY breaks the search for the parent MSI
domain of HPET and IO-APIC. The latter causes a full boot fail.

The restriction itself makes sense to avoid adding DOMAIN_BUS_ANY matches
into the various ARM specific select() callbacks. Reverting this change
would obviously break ARM platforms again and require DOMAIN_BUS_ANY
matches added to various places.

A simpler solution is to use the DOMAIN_BUS_GENERIC_MSI token for the HPET
and IO-APIC parent domain search. This works out of the box because the
affected parent domains check only for the firmware specification content
and not for the bus token.

Fixes: 5aa3c0cf5bba ("genirq/irqdomain: Don't call ops->select for DOMAIN_BUS_ANY tokens")
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/apic/io_apic.c |    2 +-
 arch/x86/kernel/hpet.c         |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -2354,7 +2354,7 @@ static int mp_irqdomain_create(int ioapi
 	fwspec.param_count = 1;
 	fwspec.param[0] = mpc_ioapic_id(ioapic);
 
-	parent = irq_find_matching_fwspec(&fwspec, DOMAIN_BUS_ANY);
+	parent = irq_find_matching_fwspec(&fwspec, DOMAIN_BUS_GENERIC_MSI);
 	if (!parent) {
 		if (!cfg->dev)
 			irq_domain_free_fwnode(fn);
--- a/arch/x86/kernel/hpet.c
+++ b/arch/x86/kernel/hpet.c
@@ -568,7 +568,7 @@ static struct irq_domain *hpet_create_ir
 	fwspec.param_count = 1;
 	fwspec.param[0] = hpet_id;
 
-	parent = irq_find_matching_fwspec(&fwspec, DOMAIN_BUS_ANY);
+	parent = irq_find_matching_fwspec(&fwspec, DOMAIN_BUS_GENERIC_MSI);
 	if (!parent) {
 		irq_domain_free_fwnode(fn);
 		kfree(domain_info);



