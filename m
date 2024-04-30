Return-Path: <linux-kernel+bounces-164341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 525D68B7C8C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 18:14:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 073FC1F2206A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 16:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 803DB176FA1;
	Tue, 30 Apr 2024 16:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fwIL/r1A";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZY9IU17A"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F541175560
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 16:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714493644; cv=none; b=hJwezKqdKbrO1lCLO3H1BGCtNGTUV8oUlaIWOfLPGgbUfOdp4y0Uq9BlZY/ml+KbcUjkUfIVH2fccOmfmvblkUDS/GD2303fh/EoMVb6t7Dy0joclefGD7gNAIYestaIiCcFmVzwyApGgb+6MfdCXP30NbFs0HQDz8bGJL8gFR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714493644; c=relaxed/simple;
	bh=dPB5zK9sUqob7ONr7G14dO/AgkbaD3ijO6EnAMAwfdQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cZXb/nblKbQtqFxRDpC+sgIqNd99sOUYtJcTgIMFrx0WfzLyUkp6GGwrbOHk6GqB0GX1fterO3T91Wh83UK0JKzbBpQHE/fYR7qEGtum88b2te3FI4TcUsou1l2r+L/97RbQZQGuEIowkrqnnSaRI1nYhqMLDLoPDTw6hkQx/Mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fwIL/r1A; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZY9IU17A; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1714493641;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bIuSOLfe5ENoYZ0SjFIuAk7cE658IewkHw8ZxtoyQ3k=;
	b=fwIL/r1AP/mv/1jDCMWQS3c0pUCdABWFVFCqjv0Pg+NL7g5fLbitsC5dpYKbs4Y4irF0GR
	JbYOnoCZhSHR5cjmMFWeuSisCKmxSTTxG2pRV/dve0XS/0543ZgIgMt8naauTaNfXWe5H+
	wLRAQ9CQTvAyejmyd/JDmeQMhp69RsldMLpm1q5wZIrmgpBUon9myNwo5qHgKhKCZFzEeU
	z29FNHFk27fKkW1EzrH4zl/8njilaqp8XOffEWUqZwXjS1R0cDiMp6/OJXyxW89zJMy0JY
	/QKtDGfNgTwZbppXeh/vDW8NKpAe0p1z8XHDOWClCJkP0Z+K5Y3OmGw7/HZUIw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1714493641;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bIuSOLfe5ENoYZ0SjFIuAk7cE658IewkHw8ZxtoyQ3k=;
	b=ZY9IU17AG2BjVOALYrsbKD470mM4bBYO0IezuukNaJ7YYePLyD68y7aaRY5MXkixJyngs9
	iuHUgjA+YruhqBBw==
To: Juergen Gross <jgross@suse.com>, linux-kernel@vger.kernel.org,
 x86@kernel.org
Cc: Juergen Gross <jgross@suse.com>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 1/2] x86/cpu: fix BSP detection when running as Xen PV
 guest
In-Reply-To: <20240405123434.24822-2-jgross@suse.com>
References: <20240405123434.24822-1-jgross@suse.com>
 <20240405123434.24822-2-jgross@suse.com>
Date: Tue, 30 Apr 2024 18:13:58 +0200
Message-ID: <87ttjisu9l.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Apr 05 2024 at 14:34, Juergen Gross wrote:
> When booting as a Xen PV guest the boot processor isn't detected
> correctly and the following message is shown:
>
>   CPU topo: Boot CPU APIC ID not the first enumerated APIC ID: 0 > 1
>
> Additionally this results in one CPU being ignored.
>
> Fix that by calling the BSP detection logic when registering the boot
> CPU's APIC, too.
>
> Fixes: 5c5682b9f87a ("x86/cpu: Detect real BSP on crash kernels")
> Signed-off-by: Juergen Gross <jgross@suse.com>
> ---
>  arch/x86/kernel/cpu/topology.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/x86/kernel/cpu/topology.c b/arch/x86/kernel/cpu/topology.c
> index aaca8d235dc2..23c3db5e6396 100644
> --- a/arch/x86/kernel/cpu/topology.c
> +++ b/arch/x86/kernel/cpu/topology.c
> @@ -255,7 +255,7 @@ void __init topology_register_boot_apic(u32 apic_id)
>  	WARN_ON_ONCE(topo_info.boot_cpu_apic_id != BAD_APICID);
>  
>  	topo_info.boot_cpu_apic_id = apic_id;
> -	topo_register_apic(apic_id, CPU_ACPIID_INVALID, true);
> +	topology_register_apic(apic_id, CPU_ACPIID_INVALID, true);

No. This does not fix anything at all. It just papers over the
underlying problem.

Thanks,

        tglx
---
diff --git a/arch/x86/xen/smp_pv.c b/arch/x86/xen/smp_pv.c
index 27d1a5b7f571..ac41d83b38d3 100644
--- a/arch/x86/xen/smp_pv.c
+++ b/arch/x86/xen/smp_pv.c
@@ -154,9 +154,9 @@ static void __init xen_pv_smp_config(void)
 	u32 apicid = 0;
 	int i;
 
-	topology_register_boot_apic(apicid++);
+	topology_register_boot_apic(apicid);
 
-	for (i = 1; i < nr_cpu_ids; i++)
+	for (i = 0; i < nr_cpu_ids; i++)
 		topology_register_apic(apicid++, CPU_ACPIID_INVALID, true);
 
 	/* Pretend to be a proper enumerated system */

        


