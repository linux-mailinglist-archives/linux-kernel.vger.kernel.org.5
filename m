Return-Path: <linux-kernel+bounces-159242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C2798B2B58
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 23:51:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 352D91C22226
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 21:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6CC3155A47;
	Thu, 25 Apr 2024 21:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iTP04GtN"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52CCA155A2A
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 21:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714081868; cv=none; b=OnRiehoP6Sw4t/L9jaJwZsjCb1BLZWTxsCypCkPhAOsgg/IrOOrcehYeI4GfEie6L51MNXQYt53dPErKifKuszZ6ofL8HUVg7ni+mSWmU0qDGqGbpAeSW6+Lzu1WZwaqk4ixMqMtlIFutWfITrSq/rw9MT0uqyxTa74zW7S2Ew0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714081868; c=relaxed/simple;
	bh=3Nm6o5NkMzlB/jHfTxtH892aVBFo5WfUDbQsHwxXAVQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m2gu+74Upw6TTnOwm3EiJ0VclXaO73wyNjHS0xOZRvb+8+J9p0oyZ7azbSQKHM5hy289r30tVKQkh2sify8vZalnFBIK40v2Jwoz9+wl/+kjRf5x0VSzW8HYU1H3ZiVKk92pK645VV5zcl1SxC6YhOp/0N797WJa6lce+byPx7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iTP04GtN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714081866;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mZ64zo85kCJtWJwvl7vf6Q3Npfm0Ixx/GbPFgDEHD+U=;
	b=iTP04GtNJlNE4Abtah2n9OHf+KdL1EMc0GEhBKZE98qdJnG5mefcTBShhuEk1QFOPyP3e/
	HhxBkFPuIBAWHXSIGoj1HWXdcDVaYG0JCoQRW+t9HbSk+z3iaYkvkorWZv5fuE8geL+Rvf
	deNWjct+fIZcT1y+l9D5LWsyRAdP2pk=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-401-miFnAVJvPXCwWyVL5rn5PA-1; Thu, 25 Apr 2024 17:51:04 -0400
X-MC-Unique: miFnAVJvPXCwWyVL5rn5PA-1
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-61b2abd30fdso27589197b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 14:51:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714081864; x=1714686664;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mZ64zo85kCJtWJwvl7vf6Q3Npfm0Ixx/GbPFgDEHD+U=;
        b=pNHljplZTKHRdel0lkWwyIlKr0WRAR+p4j9yjyBi/Y5GGgVPJ2oJG2AnYOwGkToyoL
         2lJAWR0ZVQ6ep7euYiN3KtXBDXB+uR4TZ5oBFnjkQ9sG0QMYw4IOjpNOAnqT201zyAbU
         XWdgBRuXLB7TmIf+CUnDZKspTSXFg/eGUssRx4QVjzHV+bbWwBc2LzrMVN8RsGaz8YR3
         KjbhZpuV5TsYy723UE4JHqQJFOZjEFMGlbby3F5qyda5x4OdG69lIeCwhH3ekn6Nkm58
         OWZqb0QXMWuqcKMT2J63UqChgSQoEy6iI5tphqdRLBDKxzHVJVethdHRh3+k2NJ4xL3A
         NRxg==
X-Forwarded-Encrypted: i=1; AJvYcCXlk0zoiHyzZl1T7KVLq5T+oVqY1XPwuokQAUkNE/tp0iUkOC1CnlQygY9Mi31TgWejQRsy8O7BnTE9ShYyaTA1IM2XH34vabTyAf9k
X-Gm-Message-State: AOJu0YwV0rIBYkUpe0wOyJEJQ15cFA8twXwc2ihvd3RbLwP8b+ePOoNh
	zKA+5J26TXg8qaNvvoA92mNGZNo4yZ70meEDxbAEh4LvMgv8qhtvHPJ3CYK7s/dDmsOx9enAGgT
	ZoZfHqMPkDoLRmqNQWNyGY3eH5H9o65Ltwaz7f96eNBikF8d6QJFtMc1s7faXeg==
X-Received: by 2002:a25:8307:0:b0:dd9:4a30:8d5b with SMTP id s7-20020a258307000000b00dd94a308d5bmr868742ybk.57.1714081864053;
        Thu, 25 Apr 2024 14:51:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFYIRhYW5rlQF+BvTSNoB37adNkV2ZQoUUdMLZlCCrD98FfE2nAXbCFmByVAyFnwbE/wVdmHA==
X-Received: by 2002:a25:8307:0:b0:dd9:4a30:8d5b with SMTP id s7-20020a258307000000b00dd94a308d5bmr868728ybk.57.1714081863751;
        Thu, 25 Apr 2024 14:51:03 -0700 (PDT)
Received: from [10.26.1.93] ([66.187.232.136])
        by smtp.gmail.com with ESMTPSA id ol13-20020ac8414d000000b0043a6611f95asm363430qtb.91.2024.04.25.14.51.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Apr 2024 14:51:03 -0700 (PDT)
Message-ID: <c4aa31c3-8008-4b56-aa78-96fdc23f618d@redhat.com>
Date: Thu, 25 Apr 2024 17:51:01 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] x86: Trust initial offset in architectural TSC-adjust
 MSRs
To: Daniel J Blueman <daniel@quora.org>, Thomas Gleixner
 <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>
Cc: x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
 Steffen Persvold <sp@numascale.com>,
 James Cleverdon <james.cleverdon.external@eviden.com>,
 Dimitri Sivanich <sivanich@hpe.com>, Steve Wahl <steve.wahl@hpe.com>,
 Frank Ramsay <frank.ramsay@hpe.com>, Russ Anderson <rja@hpe.com>
References: <20240419085146.175665-1-daniel@quora.org>
Content-Language: en-US
From: Prarit Bhargava <prarit@redhat.com>
In-Reply-To: <20240419085146.175665-1-daniel@quora.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/19/24 04:51, Daniel J Blueman wrote:
> When the BIOS configures the architectural TSC-adjust MSRs on secondary
> sockets to correct a constant inter-chassis offset, after Linux brings
> the cores online, the TSC sync check later resets the core-local MSR to
> 0, triggering HPET fallback and leading to performance loss.
> 
> Fix this by unconditionally using the initial adjust values read from the
> MSRs. Trusting the initial offsets in this architectural mechanism is a
> better approach than special-casing workarounds for specific platforms.
> 
> Signed-off-by: Daniel J Blueman <daniel@quora.org>
> Reviewed-by: Steffen Persvold <sp@numascale.com>
> Reviewed-by: James Cleverdon <james.cleverdon.external@eviden.com>
> Reviewed-by: Dimitri Sivanich <sivanich@hpe.com>
> Cc: Steve Wahl <steve.wahl@hpe.com>
> Cc: Prarit Bhargava <prarit@redhat.com>
> Cc: Frank Ramsay <frank.ramsay@hpe.com>
> Cc: Russ Anderson <rja@hpe.com>
> ---
> Changes in v2:
> - Maintain comment based on feedback
> - Rebase against v6.9-rc4
> 
>   arch/x86/kernel/tsc_sync.c | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/kernel/tsc_sync.c b/arch/x86/kernel/tsc_sync.c
> index 1123ef3ccf90..4334033658ed 100644
> --- a/arch/x86/kernel/tsc_sync.c
> +++ b/arch/x86/kernel/tsc_sync.c
> @@ -193,11 +193,9 @@ bool tsc_store_and_check_tsc_adjust(bool bootcpu)
>   	cur->warned = false;
>   
>   	/*
> -	 * If a non-zero TSC value for socket 0 may be valid then the default
> -	 * adjusted value cannot assumed to be zero either.
> +	 * The default adjust value cannot be assumed to be zero on any socket.
>   	 */
> -	if (tsc_async_resets)
> -		cur->adjusted = bootval;
> +	cur->adjusted = bootval;
>   
>   	/*
>   	 * Check whether this CPU is the first in a package to come up. In

This covers the concerns raise by HPE (cc'd) on this patch.

Reviewed-by: Prarit Bhargava <prarit@redhat.com>

P.


