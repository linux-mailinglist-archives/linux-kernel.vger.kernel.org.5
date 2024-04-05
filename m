Return-Path: <linux-kernel+bounces-133019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E8F06899D86
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 14:50:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5EA68B24A4A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 12:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1766C16D305;
	Fri,  5 Apr 2024 12:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="ZonYurPI"
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A67416078C
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 12:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712321410; cv=none; b=lDWKxav9W9yE6OX1e2Fg1j4ElpRjqJBoiMnlp4MAVqP7PlxmfM572RdwzdkrTLa6/TmwyKZG6q3cE4qaW0w9kCSkNkj8lt8QcET4Cq6FwVhxhaEk4LUhjLIp+xVpcAesp2oyS8urygccjJtfqX+3saNope6rAJiSmYa8lJU0h/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712321410; c=relaxed/simple;
	bh=flXaqTTYjtw8SdsQR80nuXmvQIQl7Mo0JdSwaqVM7O8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f8Xxz4wQwW8p4+Gr8P22FTfcOiJnt0DGBnAL61T5haHMjC/y9poC5Nt+ldDT6QKd9s+lvPEHHQwM8iPLLYtcO8zIx+4lPE1JSwGCcYRfa9ziPEAJUWj1mOJ4X8LE0TvxxHlYjV7/VPmBLoZY46/0JvYzxN79HEyFM/D72BKjIok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=pass smtp.mailfrom=cloud.com; dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b=ZonYurPI; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloud.com
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-6e707210ab9so1009686a34.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2024 05:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1712321407; x=1712926207; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Vc588LwOvWyQuDQ7gVUI+/fqZi3n/Nja0mBIe96HMJM=;
        b=ZonYurPI4K7toqLgUV46hc4iKxp5iy7opK9KU5PC79+GhLiuoB9X/MOnX8PqWo4KhC
         dVcJ3/lXAWk+ZCa9snbhxe1LVIWvw4zHVP89k3Ramc2EEj5cuxme53+Z2/ncEBMW4b3T
         jvCd6pO0AILNEDwTCvPnnWVnavDg1d2JIieiY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712321407; x=1712926207;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vc588LwOvWyQuDQ7gVUI+/fqZi3n/Nja0mBIe96HMJM=;
        b=NXLzpXqYFHuAFMhO6QG2HUPj12j6xbIfYSx/QCDzvgrfXMgFK77AiHR/d5P3AlhH/3
         GlshzPGUJ98lZJmi4hCTTSHMAFq51A5euLNthcphArHr9Tu5nYbXInA2KPe8Fe2JMv9C
         PZCrpF3Xt9nNaam/eIwBi4jwsjL2hGg9SS6aiyyS3MLtDOqDDjnCa/eFj7loIF6aN/Hd
         y0YrUJPFh1CR/nEsSjLeGp6Y8N4e9h0XYJx3qJqY5uzz7lbuQtZtzjqGjcMs4C/jOCdo
         rbfuM525RYHYi1XZSqIV4uLAivl1gIVhqFjEHb9hrVLmipO5tZUX4SEn4Jle8mTdFUaI
         1+xw==
X-Forwarded-Encrypted: i=1; AJvYcCXCMWOD8hsMXZsUFbpKYFxThR6v77IfDVDrFW+j6rnZfQleJ98KMNuBjyp8+Y6IMpL//KUsLST2Q0SL9W2luiIKJAot0gFsNEOBsUa9
X-Gm-Message-State: AOJu0Yx24HJv8gzf/IZJNhfbAPGTdXdvQrtAEyrT4K9sTL1NJ5FPqm5o
	9FeTscQ/ju6OPnKs+HZc6oJCwXvc5vgB08QN5j0wNGfsQv60jc2mVoFt3jgmOZ0=
X-Google-Smtp-Source: AGHT+IHrY6etqL5vHvjhx/nPlLEoAAdaXnN4cFYl7a5reAGjVR3pfVk9KPbtroU48o5I3za98ihbiA==
X-Received: by 2002:a05:6830:6b86:b0:6e4:9482:86c3 with SMTP id dd6-20020a0568306b8600b006e4948286c3mr1497907otb.10.1712321407714;
        Fri, 05 Apr 2024 05:50:07 -0700 (PDT)
Received: from [10.80.67.139] (default-46-102-197-194.interdsl.co.uk. [46.102.197.194])
        by smtp.gmail.com with ESMTPSA id du47-20020a05620a47ef00b0078bc4cad726sm594884qkb.72.2024.04.05.05.50.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Apr 2024 05:50:07 -0700 (PDT)
Message-ID: <f8fb1990-11e8-459d-a365-6dc277f34a6b@citrix.com>
Date: Fri, 5 Apr 2024 13:50:04 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] x86/xen: return a sane initial apic id when running
 as PV guest
To: Juergen Gross <jgross@suse.com>, linux-kernel@vger.kernel.org,
 x86@kernel.org
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, xen-devel@lists.xenproject.org
References: <20240405123434.24822-1-jgross@suse.com>
 <20240405123434.24822-3-jgross@suse.com>
Content-Language: en-GB
From: Andrew Cooper <andrew.cooper3@citrix.com>
Autocrypt: addr=andrew.cooper3@citrix.com; keydata=
 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
 6+ahAA==
In-Reply-To: <20240405123434.24822-3-jgross@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 05/04/2024 1:34 pm, Juergen Gross wrote:
> With recent sanity checks for topology information added, there are now
> warnings issued for APs when running as a Xen PV guest:
>
>   [Firmware Bug]: CPU   1: APIC ID mismatch. CPUID: 0x0000 APIC: 0x0001
>
> This is due to the initial APIC ID obtained via CPUID for PV guests is
> always 0.

/sigh

From Xen:

    switch ( leaf )
    {
    case 0x1:
        /* TODO: Rework topology logic. */
        res->b &= 0x00ffffffu;
        if ( is_hvm_domain(d) )
            res->b |= (v->vcpu_id * 2) << 24;


I think there's a very good chance it was random prior to Xen 4.6.  That
used to come straight out of a CPUID value, so would get the APIC ID of
whichever pCPU it was scheduled on.

> Avoid the warnings by synthesizing the CPUID data to contain the same
> initial APIC ID as xen_pv_smp_config() is using for registering the
> APIC IDs of all CPUs.
>
> Fixes: 52128a7a21f7 ("86/cpu/topology: Make the APIC mismatch warnings complete")
> Signed-off-by: Juergen Gross <jgross@suse.com>
> ---
>  arch/x86/xen/enlighten_pv.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/arch/x86/xen/enlighten_pv.c b/arch/x86/xen/enlighten_pv.c
> index ace2eb054053..965e4ca36024 100644
> --- a/arch/x86/xen/enlighten_pv.c
> +++ b/arch/x86/xen/enlighten_pv.c
> @@ -219,13 +219,20 @@ static __read_mostly unsigned int cpuid_leaf5_edx_val;
>  static void xen_cpuid(unsigned int *ax, unsigned int *bx,
>  		      unsigned int *cx, unsigned int *dx)
>  {
> -	unsigned maskebx = ~0;
> +	unsigned int maskebx = ~0;
> +	unsigned int or_ebx = 0;
>  
>  	/*
>  	 * Mask out inconvenient features, to try and disable as many
>  	 * unsupported kernel subsystems as possible.
>  	 */
>  	switch (*ax) {
> +	case 0x1:
> +		/* Replace initial APIC ID in bits 24-31 of EBX. */
> +		maskebx = 0x00ffffff;
> +		or_ebx = smp_processor_id() << 24;

I think the comment wants to cross-reference explicitly with
xen_pv_smp_config(), because what we care about here is the two sources
of information matching.

Also while you're at it, the x2APIC ID in leaf 0xb.

~Andrew

