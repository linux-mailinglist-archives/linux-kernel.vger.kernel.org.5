Return-Path: <linux-kernel+bounces-95858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 833E587542C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 17:28:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB6F52846C9
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 16:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ABEF12FB00;
	Thu,  7 Mar 2024 16:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="fCwsGxoH"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F5412D768
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 16:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709828895; cv=none; b=u1YLSaLStM00egi/Is8M3EGiEIedraZR+hv9//uRPPFzdcbx3iQalMMtpfPl2BKTHqpK5w9mwU5ywOAHqSPvsi0pydPYBr3cAJ+cnwUXBCwOnwgQJEqrz357JkY4CbTlsc+P7xByzwvY3l+FfOBD8IRRa8FWab4QL07RLIHHNKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709828895; c=relaxed/simple;
	bh=KRwq1mlARD/+seRfzKYnP8T/xyA/FArSAfNxjEpCoE0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HMmkyNTyoWo6M4SIMrOGtOm/ftnU8RiFKhwJki9krqvBup6h2xNTjG/RXuoz8S1El0tBp/qq+f9LlAxEbptQ16fkO0eLcHu7hC3nOIiG3s9BKP0G9UMTi+3x3xVds1TxaUwXhZriodXYWxlsSkzNMqcdOVMUY4GkvxTBrGf8/EA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=fCwsGxoH; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 9739340E0174;
	Thu,  7 Mar 2024 16:28:08 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id sZAntyjfiiMV; Thu,  7 Mar 2024 16:28:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1709828885; bh=CHqAVMcOULQTqhMFiebhSZstkTF+z6uINA9dq9fvWKY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fCwsGxoH5gZt6jo7/G7GuaUmzjSBf848guaSe9nZ+elwFmeDe9KGaK2B2cdsTdBUu
	 UhfpUVaYThJqd2kfY0STVUmTaJrt0wkb3FCLHCUnZ7yqLAXiADRlbsinc1cT3qUDfP
	 3+CXd6R1xs8lBk9Rh7rXiwHL7hVM2DIgdlLjIM9b3cCXt9trBX0dvXTHguf1hHLwfx
	 JSgsNSpwUP7orArZU4m9Ahjtm28ih4k5EZuzH8tqtJxs8LeP+KN2p2GakM5Jha1jcb
	 S1rN9qJauUqCGH21XJgZ55i8YeTn4/rttGvkMDLNxRVbdzjhmF+UcRtt7DidVTqquQ
	 JCEiGCwZ4N/S4/4NFV+EAPgQiIbxKo2BaON/YxuNEPZdmdSkCEBQML0Iqu+Nlsy0mH
	 XoZOk2bnSlQ9hx0cOYu1GMblWhB/4OFv+eamdJ2zUwNW5Qwf69I16za+m02O/yorTP
	 dNnqZ9Z0wgo+dKR/V+BXE+WB8Ep+d4OxGLHPAHsHx/0k016G5+GyxlNCjjMDFaNKWs
	 Ut0Oi9kWN8aVxVN+gJv6bhnIQ1ILhCdW6TrrN3isN6pxuRcvfh/SQoMPWGUEGleGV4
	 yNFzcuMDwrbrF1L5KEtGkFCEsSem95zRgWNIiqBE0TO71QB9KAhSvOs9oK6dUrNJ4n
	 2ZOzC+4fTPrI4aQZAB0MsFC0=
Received: from zn.tnic (pd953021b.dip0.t-ipconnect.de [217.83.2.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id CEFE440E0173;
	Thu,  7 Mar 2024 16:27:57 +0000 (UTC)
Date: Thu, 7 Mar 2024 17:27:52 +0100
From: Borislav Petkov <bp@alien8.de>
To: Dave Hansen <dave.hansen@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, kirill.shutemov@linux.intel.com,
	pbonzini@redhat.com, tglx@linutronix.de, x86@kernel.org,
	jgross@suse.com
Subject: Re: [RFC][PATCH 01/34] x86/xen: Explain why calling get_cpu_cap() so
 early is a hack
Message-ID: <20240307162752.GAZenrCDqs0lMTjmu1@fat_crate.local>
References: <20240222183926.517AFCD2@davehans-spike.ostc.intel.com>
 <20240222183928.0D8942B2@davehans-spike.ostc.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240222183928.0D8942B2@davehans-spike.ostc.intel.com>

On Thu, Feb 22, 2024 at 10:39:28AM -0800, Dave Hansen wrote:
> 
> From: Dave Hansen <dave.hansen@linux.intel.com>
> 
> xen_start_kernel() some of the first C code run "Xen PV" systems.

That sentence reads weird.

> It precedes normally very early things like setup_arch() or the
> processor initialization code.
> 
> That means that 'boot_cpu_data' is garbage.  It has not even

s/is/contains/

> established the utter basics like if the CPU supports the CPUID
> instruction.  Unfortunately get_cpu_cap() requires this exact
> information.
> 
> Nevertheless xen_start_kernel() calls get_cpu_cap().  But it
> works out in practice because it's looking for the NX bit which
> comes from an extended CPUID leaf that doesn't depend on
> c->cpuid_level being set.  This also implicitly assumes that
> Xen PV guests support CPUID.
> 
> Leave the hack in place, but at least explain some of what is
> going on.
> 
> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Juergen Gross <jgross@suse.com>
> ---
> 
>  b/arch/x86/xen/enlighten_pv.c |    6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff -puN arch/x86/xen/enlighten_pv.c~xen-explain1 arch/x86/xen/enlighten_pv.c
> --- a/arch/x86/xen/enlighten_pv.c~xen-explain1	2024-02-22 10:08:48.404451146 -0800
> +++ b/arch/x86/xen/enlighten_pv.c	2024-02-22 10:08:48.404451146 -0800
> @@ -1372,7 +1372,11 @@ asmlinkage __visible void __init xen_sta
>  	/* Get mfn list */
>  	xen_build_dynamic_phys_to_machine();
>  
> -	/* Work out if we support NX */
> +	/*
> +	 * This is a hack.  'boot_cpu_data' is not filled out enough
> +	 * for get_cpu_cap() to function fully.  But it _can_ fill out
> +	 * the leaves where NX is.  Gross, but it works.
> +	 */
>  	get_cpu_cap(&boot_cpu_data);
>  	x86_configure_nx();

If all it needs is to figure out whether it supports NX, just do that by
foot here and get rid of the get_cpu_cap(&boot_cpu_data) call
completely.

It won't be a hack anymore.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

