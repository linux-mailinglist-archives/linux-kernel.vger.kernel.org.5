Return-Path: <linux-kernel+bounces-133026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C351899DA8
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 14:56:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F4EA1C22DF7
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 12:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9116316D322;
	Fri,  5 Apr 2024 12:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="hDPjxLaI"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C5B16C874
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 12:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712321782; cv=none; b=FwQq1y/xdwTYsfaiu3wJqR6KDOoUI9dGHiask1skG3PdTqRcDSdX+98hEwQfyUMV/2u+2VldpgQz3vYlMY9iFJKJW02gtFMKow4fhwqs4DXXF9Wci57ifJKPFhOWh5Jp0khW76yojIxhrMipgefjYtznZzPglDTPb2/v1DJddKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712321782; c=relaxed/simple;
	bh=/EI33afSt6LjMR1EKqW0incKysvE58Nljt8kL8YZAFA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DSzH0QAvfcJur2sbJnQfCy2LmpLDiQRqyGaR/77nvl5ui5G9J8sxRpbK9/AZoWvDr1BDWyCnGy1WLJYuOq+/rFv5RXI31xb3JA/DS4hZirQL15V0mIlQIXAurnRzWYj6zEqv+oS3Bsx+NG8E+sW2lm55KFkuaUTDZk21xZyx584=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=hDPjxLaI; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-516c403cc46so4047291e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2024 05:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1712321778; x=1712926578; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s6BeinTfkFRY511Zesj2csWGlc6XaX/bZ6aS0GxaTcE=;
        b=hDPjxLaIRckgeurQtA/AcquSmTWHcbwBcDz3aBX30xITj6s6VkPuq7dczVMguGEoC6
         Q5S1fFndJjUsz9YreYUd0A5FdsuwoH9ITaYrpAQuxELkxDRgTkBmcn22JSFwQRwgjnfT
         1nRFzvWGexBmJyvTfVbgd/JKcpjlyAP3l0bMrqWOUzzl53mv9YZOFz6vg+m2jvI+a17R
         sekRSTpHGMx5R+fk7chjh4tASD/3F+VGlAgZVtAhKP60D1t6v7fIwOO3mL2P1H4H7WN+
         H0hz3EKwARt2u9xTkguFeGTZig8pjwOCt5CSBWNuLYv9YNDGcbTbC3C1LFo58msp1i7p
         vNBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712321778; x=1712926578;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s6BeinTfkFRY511Zesj2csWGlc6XaX/bZ6aS0GxaTcE=;
        b=WZ/ByFWqAP8xsgzlxJrrDTn1AjwlR+5csHNBU4wB/6d/FV4gkARmv4rYwRNhw1gVg9
         hFq3Oh5C4EW/9n4uU6qrPllVHCK9bJzQXkkqHG7zLIRFkF9v7xnmTyAl27i/ESS78Axc
         WYsY5Lj2EApRrImxpuOP1nZfm24sM4Ysvon/B2RdNPDOY1G4J+eNxtJ6yOUidA+1Lae4
         THG12Yt2nvRE8QxIERgtc6rGs/YvDiykOMFPGJ5XiYcfRoukFtf4bc2UzB/11URqulg7
         B/Qy4VCMXLAIkM74Xy/fLNn+vQqc02hB6E5I1JYBtrJeDXwafrBwrTQJorgJ7bExWlqb
         U+3g==
X-Forwarded-Encrypted: i=1; AJvYcCW76RiLb/9RBqmKTaNZ3PNhwMlAsHas5EvHIl5vwXPgyd8tboGyWiD+nPe4Z2HWOvjU1aVjHD0fU2vSZfz59gnSVgj5iFRIIdRkLGaM
X-Gm-Message-State: AOJu0Yyg8TZXT/3z/vcf+2U7IQN1OZ5oL+sii5YvEDZpVNktBOChVUzU
	vqrLYutrZIWWRqkjVb2vFodQXlQcCiLaBnJ4iSbqbP4MTU7b1m6JQH++tKzcN0M=
X-Google-Smtp-Source: AGHT+IFpfy6C/SfFTK8IkMTuBphFt/yBIUbFgzlwGpKi0zL14YuaT4NJUKruE+ynKd8LPsEBIG0RFQ==
X-Received: by 2002:ac2:5050:0:b0:516:d1ba:ca70 with SMTP id a16-20020ac25050000000b00516d1baca70mr1353262lfm.31.1712321778108;
        Fri, 05 Apr 2024 05:56:18 -0700 (PDT)
Received: from ?IPV6:2003:e5:873a:400:704b:6dbb:e7c0:786e? (p200300e5873a0400704b6dbbe7c0786e.dip0.t-ipconnect.de. [2003:e5:873a:400:704b:6dbb:e7c0:786e])
        by smtp.gmail.com with ESMTPSA id eb16-20020a170907281000b00a51ad1c08f6sm237285ejc.71.2024.04.05.05.56.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Apr 2024 05:56:17 -0700 (PDT)
Message-ID: <b145edd1-cde8-4c05-bd70-86c7e3a48666@suse.com>
Date: Fri, 5 Apr 2024 14:56:17 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] x86/xen: return a sane initial apic id when running
 as PV guest
Content-Language: en-US
To: Andrew Cooper <andrew.cooper3@citrix.com>, linux-kernel@vger.kernel.org,
 x86@kernel.org
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, xen-devel@lists.xenproject.org
References: <20240405123434.24822-1-jgross@suse.com>
 <20240405123434.24822-3-jgross@suse.com>
 <f8fb1990-11e8-459d-a365-6dc277f34a6b@citrix.com>
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
In-Reply-To: <f8fb1990-11e8-459d-a365-6dc277f34a6b@citrix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 05.04.24 14:50, Andrew Cooper wrote:
> On 05/04/2024 1:34 pm, Juergen Gross wrote:
>> With recent sanity checks for topology information added, there are now
>> warnings issued for APs when running as a Xen PV guest:
>>
>>    [Firmware Bug]: CPU   1: APIC ID mismatch. CPUID: 0x0000 APIC: 0x0001
>>
>> This is due to the initial APIC ID obtained via CPUID for PV guests is
>> always 0.
> 
> /sigh
> 
>  From Xen:
> 
>      switch ( leaf )
>      {
>      case 0x1:
>          /* TODO: Rework topology logic. */
>          res->b &= 0x00ffffffu;
>          if ( is_hvm_domain(d) )
>              res->b |= (v->vcpu_id * 2) << 24;
> 
> 
> I think there's a very good chance it was random prior to Xen 4.6.  That
> used to come straight out of a CPUID value, so would get the APIC ID of
> whichever pCPU it was scheduled on.
> 
>> Avoid the warnings by synthesizing the CPUID data to contain the same
>> initial APIC ID as xen_pv_smp_config() is using for registering the
>> APIC IDs of all CPUs.
>>
>> Fixes: 52128a7a21f7 ("86/cpu/topology: Make the APIC mismatch warnings complete")
>> Signed-off-by: Juergen Gross <jgross@suse.com>
>> ---
>>   arch/x86/xen/enlighten_pv.c | 10 +++++++++-
>>   1 file changed, 9 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/x86/xen/enlighten_pv.c b/arch/x86/xen/enlighten_pv.c
>> index ace2eb054053..965e4ca36024 100644
>> --- a/arch/x86/xen/enlighten_pv.c
>> +++ b/arch/x86/xen/enlighten_pv.c
>> @@ -219,13 +219,20 @@ static __read_mostly unsigned int cpuid_leaf5_edx_val;
>>   static void xen_cpuid(unsigned int *ax, unsigned int *bx,
>>   		      unsigned int *cx, unsigned int *dx)
>>   {
>> -	unsigned maskebx = ~0;
>> +	unsigned int maskebx = ~0;
>> +	unsigned int or_ebx = 0;
>>   
>>   	/*
>>   	 * Mask out inconvenient features, to try and disable as many
>>   	 * unsupported kernel subsystems as possible.
>>   	 */
>>   	switch (*ax) {
>> +	case 0x1:
>> +		/* Replace initial APIC ID in bits 24-31 of EBX. */
>> +		maskebx = 0x00ffffff;
>> +		or_ebx = smp_processor_id() << 24;
> 
> I think the comment wants to cross-reference explicitly with
> xen_pv_smp_config(), because what we care about here is the two sources
> of information matching.

I can add that as a comment. OTOH I'd really hope someone changing this
code later would look into the commit message of the patch adding it. :-)

> 
> Also while you're at it, the x2APIC ID in leaf 0xb.

I'm not sure this is functionally relevant in PV guests.

Note that my patch is only meant to silence warnings during boot. It is not
needed for the system working correctly (at least I think so).


Juergen

