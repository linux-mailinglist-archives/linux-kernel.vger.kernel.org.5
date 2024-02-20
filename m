Return-Path: <linux-kernel+bounces-72602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8838B85B5D6
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 09:51:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 183C0B2232B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 08:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B77005FB93;
	Tue, 20 Feb 2024 08:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OOfiOZKh";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YA6lRw+q"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6657E5D8EA;
	Tue, 20 Feb 2024 08:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708419028; cv=none; b=f/AVkBTnflQYgKFuf/PNwnQaky2lcihjjwcC/S5u2f1MefnW6zv76RwFjYQ7xizMQJUrkJtu/sQHJ36USV7tXEytIYI7Qj12Z2R/iQsWY/InkCLOx1HjRutygZx7LxYTjj6kzDRFGGj7uAuCiLw+qz5eK9ta0ECRnYnl75v3lZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708419028; c=relaxed/simple;
	bh=lyAH928PklVqNohvkdzHA4O3OK69l5xGYIh69vxcF8I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WNLhBZGClS5/8bVIF8IP4grYe0uuxJyw7O1ishEGTd9iNL2UdP9+GQH+MW26abYmiPRwJc/N2zCPH82f/8jQc8pI2ECOo7OO5j5LjuaABbUMDTzvzxAau+XdCyDm/jeEVRmrSAUPbitCTn8SX2nYou9H1rAZ7XdcVZ8sZ1tihpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OOfiOZKh; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YA6lRw+q; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708419020;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zt6WFPspTPLISjJDNaV2xke6NbP8x70UX4LyyABHdak=;
	b=OOfiOZKhXJ/Is3rVi6vnkx4XchR0rOCqc+CsLpZgA4h7Tq5t6EBqgB2d0MbCi03VPjn53Y
	s6aAhUAs7gQl9t5j7eD4oNPYj+qgBOm98DYWkskbPTiUdZZbYhSQNLyz2k8LgW5bM/P9Z5
	mKIL4jtJsPJ+KKe8d2/JkErCF1DJ79Bwo1YNfCK6mGt2H+3fCO+7BQ3lGsxQ7VdIfWBm6K
	4FsnSNNUmgIENHVaYdE22mhG7n8uaWm4Ot+0U+sXiRGL0pBZNoJZ3NUajtweJE95Kb4eU4
	4j9/KK51jH3aEtMtzfDxEWOohgDp2sgTt3LW2EzSeQqNMkHQIxXsOTB413yXZQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708419020;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zt6WFPspTPLISjJDNaV2xke6NbP8x70UX4LyyABHdak=;
	b=YA6lRw+qPSdpDx9hcr+psBv5van3e9vSZXUswhnBc1qk+vDyoFH9Gv2DF2PfTHW9wVnuxT
	oMyiIuw/x/SYERAA==
To: Marc Zyngier <maz@kernel.org>, Biju Das <biju.das.jz@bp.renesas.com>
Cc: tip-bot2@linutronix.de, apatel@ventanamicro.com,
 linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
 geert@linux-m68k.org, linux-renesas-soc@vger.kernel.org, x86@kernel.org
Subject: Re: [tip: irq/msi] genirq/irqdomain: Remove the param count
 restriction from select()
In-Reply-To: <867cj04fcl.wl-maz@kernel.org>
References: <170802702416.398.14922976721740218856.tip-bot2@tip-bot2>
 <20240127161753.114685-3-apatel@ventanamicro.com>
 <867cj04fcl.wl-maz@kernel.org>
Date: Tue, 20 Feb 2024 09:50:19 +0100
Message-ID: <87ttm3ikok.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Feb 19 2024 at 15:56, Marc Zyngier wrote:
>> diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
>> index 0bdef4f..8fee379 100644
>> --- a/kernel/irq/irqdomain.c
>> +++ b/kernel/irq/irqdomain.c
>> @@ -448,7 +448,7 @@ struct irq_domain *irq_find_matching_fwspec(struct irq_fwspec *fwspec,
>>  	 */
>>  	mutex_lock(&irq_domain_mutex);
>>  	list_for_each_entry(h, &irq_domain_list, link) {
>> -		if (h->ops->select && fwspec->param_count)
>> +		if (h->ops->select)
>>  			rc = h->ops->select(h, fwspec, bus_token);
>>  		else if (h->ops->match)
>>  			rc = h->ops->match(h, to_of_node(fwnode), bus_token);
>> 
>> 
>
> Dmitry posted his take on this at [1], and I have suggested another
> possible fix in my reply.

Your core side DOMAIN_BUS_ANY variant makes a lot of sense. Can you
please post a proper patch for that?

Aside of this I just noticed that we need the below too.

Thanks,

        tglx
---
Subject: irqchip/imx-intmux: Handle pure domain searches correctly
From: Thomas Gleixner <tglx@linutronix.de>
Date: Tue, 20 Feb 2024 09:46:19 +0100

The removal of the paremeter count restriction in the core code to allow
pure domain token based select() decisions broke the IMX intmux select
callback as that unconditioally expects that there is a parameter.

Add the missing check for zero parameter count and the token match.

Fixes: de1ff306dcf4 ("genirq/irqdomain: Remove the param count restriction from select()")
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 drivers/irqchip/irq-imx-intmux.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/irqchip/irq-imx-intmux.c
+++ b/drivers/irqchip/irq-imx-intmux.c
@@ -166,6 +166,10 @@ static int imx_intmux_irq_select(struct
 	if (fwspec->fwnode != d->fwnode)
 		return false;
 
+	/* Handle pure domain searches */
+	if (!fwspec->param_count)
+		return d->bus_token == bus_token;
+
 	return irqchip_data->chanidx == fwspec->param[1];
 }
 

