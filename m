Return-Path: <linux-kernel+bounces-78747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FAC4861836
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 17:42:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F24531F23EAC
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 16:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70C981292F7;
	Fri, 23 Feb 2024 16:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XYYELOJ4"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA14B186A
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 16:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708706526; cv=none; b=dVhBl3Nx5F65Myb2g9hprVe30ekASTNGf0iFiZR3Z13DaVzanlJ/ZNl8Ho2QLooFFKcoHgIEIDIbJHFAWVFFByvP1K7If+j8I0Qja6Wl61wbadwVKeRR+TgMKwxuz+bwzaNPJDrPf0lI+3QgwUZK5w4MEklAA4DaAyEhJBG7kPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708706526; c=relaxed/simple;
	bh=otsTAIPXgRIvtuyYlLjypFnwy6Q0ZSqQMyTHWHIhYXg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=apCMupLpOMcIaz+FHZKMsMo2Ke8MgIQo8Et/ak6Thh8JOhDq9dmN70EO9PdV8aH8M8W4LBmmIaSR2cd/3YKbHGN+YVBr4Bq8NUwV8fsqxy5rYRo07VjFTODr+llIhVIKFrXu2U0UZz6MHS6wakGVYdiW2wr6qfjRrj30WcAoAm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XYYELOJ4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708706523;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=+AOjHq1/u2yhMYR9A6hBnvCeHLGgnw2BouAiuMgvi/M=;
	b=XYYELOJ4EbXEAdXmKjHnlRsQ/a8JlOPtjt/dkbpB+5VlQ0yabiqwhcXeJ2bLq87FWOqGWh
	9uVOuh74aWALCbiW7USGebfT6OMLfQUlmf4FfCCQgPA061rGK7C0oj4C3qlDAWYO0Qjx3S
	3IebYytCgEWUduizJHLKJzHgC28xPJ4=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-367-AOa7w0c_OyOsevzRFvpzXA-1; Fri, 23 Feb 2024 11:42:02 -0500
X-MC-Unique: AOa7w0c_OyOsevzRFvpzXA-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-55fee28d93dso604725a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 08:42:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708706520; x=1709311320;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+AOjHq1/u2yhMYR9A6hBnvCeHLGgnw2BouAiuMgvi/M=;
        b=pup0ZpO8oSt5qMpUqAvYUvQ2CbtPYrzSnnOxXvOImpTVSZ5bIDrNn35rHp5iws7VzV
         PjVq3vvUsD4Jv17AgMt9AmVc6XRmFdJkNJY9n5MyTCDiaAE+EOpvok8aucSBnl/Ilod6
         FFns39V1TFMeI67THaxpL6OL5dzi2qfVh0dg81jRFEP0NLxRWvzymsi7AnE8FLWVu5lM
         ftMbqaMlVBmV8TjzWvsKbBl3xwzcecQnZzlTMP0yAji92Wf+35ayhTLEcKmzjEThar1a
         Huf14bbKjuKrkBxtTJH+AZ25UuYAicubXiU1N/bd4ExISipNLmCSeYK8or6uje4au2Qx
         3prg==
X-Gm-Message-State: AOJu0Yz8kDRn/yQOgUUDX4uma4nuUmpGGizRCiR/DYx9EB6dOsD5oCRR
	Rq71TreU2uE+j4BhBxEh+QOlmm1HdHCYp4g6smX9luRosSr9Dqyel3wv9PItjIq6B13TLD1Y4ZL
	wlUXlIaVB57u01DxiI8ubjYG1orGlIx+OmHm2bXZ3/x9jRgVILPIg9oFo5u8vGwsC9QIjWA==
X-Received: by 2002:a17:906:f0c9:b0:a3f:d24f:477a with SMTP id dk9-20020a170906f0c900b00a3fd24f477amr252133ejb.47.1708706520159;
        Fri, 23 Feb 2024 08:42:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG+0Hl2Rg2Lvhx43WdQlUUS9JyEoDYzSKuMun6HpzPAC7jKiMFQNEU80YmVzRWrcs3pHaiBMA==
X-Received: by 2002:a17:906:f0c9:b0:a3f:d24f:477a with SMTP id dk9-20020a170906f0c900b00a3fd24f477amr252118ejb.47.1708706519838;
        Fri, 23 Feb 2024 08:41:59 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:9af8:e5f5:7516:fa89? ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
        by smtp.googlemail.com with ESMTPSA id lu16-20020a170906fad000b00a3d5efc65e0sm5715141ejb.91.2024.02.23.08.41.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Feb 2024 08:41:59 -0800 (PST)
Message-ID: <43b9125f-35d4-4368-8783-a41799b11c21@redhat.com>
Date: Fri, 23 Feb 2024 17:41:58 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/11] KVM: SEV: publish supported VMSA features
Content-Language: en-US
To: Sean Christopherson <seanjc@google.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, michael.roth@amd.com,
 aik@amd.com
References: <20240223104009.632194-1-pbonzini@redhat.com>
 <20240223104009.632194-5-pbonzini@redhat.com> <ZdjCpX4LMCCyYev9@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Autocrypt: addr=pbonzini@redhat.com; keydata=
 xsEhBFRCcBIBDqDGsz4K0zZun3jh+U6Z9wNGLKQ0kSFyjN38gMqU1SfP+TUNQepFHb/Gc0E2
 CxXPkIBTvYY+ZPkoTh5xF9oS1jqI8iRLzouzF8yXs3QjQIZ2SfuCxSVwlV65jotcjD2FTN04
 hVopm9llFijNZpVIOGUTqzM4U55sdsCcZUluWM6x4HSOdw5F5Utxfp1wOjD/v92Lrax0hjiX
 DResHSt48q+8FrZzY+AUbkUS+Jm34qjswdrgsC5uxeVcLkBgWLmov2kMaMROT0YmFY6A3m1S
 P/kXmHDXxhe23gKb3dgwxUTpENDBGcfEzrzilWueOeUWiOcWuFOed/C3SyijBx3Av/lbCsHU
 Vx6pMycNTdzU1BuAroB+Y3mNEuW56Yd44jlInzG2UOwt9XjjdKkJZ1g0P9dwptwLEgTEd3Fo
 UdhAQyRXGYO8oROiuh+RZ1lXp6AQ4ZjoyH8WLfTLf5g1EKCTc4C1sy1vQSdzIRu3rBIjAvnC
 tGZADei1IExLqB3uzXKzZ1BZ+Z8hnt2og9hb7H0y8diYfEk2w3R7wEr+Ehk5NQsT2MPI2QBd
 wEv1/Aj1DgUHZAHzG1QN9S8wNWQ6K9DqHZTBnI1hUlkp22zCSHK/6FwUCuYp1zcAEQEAAc0j
 UGFvbG8gQm9uemluaSA8cGJvbnppbmlAcmVkaGF0LmNvbT7CwU0EEwECACMFAlRCcBICGwMH
 CwkIBwMCAQYVCAIJCgsEFgIDAQIeAQIXgAAKCRB+FRAMzTZpsbceDp9IIN6BIA0Ol7MoB15E
 11kRz/ewzryFY54tQlMnd4xxfH8MTQ/mm9I482YoSwPMdcWFAKnUX6Yo30tbLiNB8hzaHeRj
 jx12K+ptqYbg+cevgOtbLAlL9kNgLLcsGqC2829jBCUTVeMSZDrzS97ole/YEez2qFpPnTV0
 VrRWClWVfYh+JfzpXmgyhbkuwUxNFk421s4Ajp3d8nPPFUGgBG5HOxzkAm7xb1cjAuJ+oi/K
 CHfkuN+fLZl/u3E/fw7vvOESApLU5o0icVXeakfSz0LsygEnekDbxPnE5af/9FEkXJD5EoYG
 SEahaEtgNrR4qsyxyAGYgZlS70vkSSYJ+iT2rrwEiDlo31MzRo6Ba2FfHBSJ7lcYdPT7bbk9
 AO3hlNMhNdUhoQv7M5HsnqZ6unvSHOKmReNaS9egAGdRN0/GPDWr9wroyJ65ZNQsHl9nXBqE
 AukZNr5oJO5vxrYiAuuTSd6UI/xFkjtkzltG3mw5ao2bBpk/V/YuePrJsnPFHG7NhizrxttB
 nTuOSCMo45pfHQ+XYd5K1+Cv/NzZFNWscm5htJ0HznY+oOsZvHTyGz3v91pn51dkRYN0otqr
 bQ4tlFFuVjArBZcapSIe6NV8C4cEiSTOwE0EVEJx7gEIAMeHcVzuv2bp9HlWDp6+RkZe+vtl
 KwAHplb/WH59j2wyG8V6i33+6MlSSJMOFnYUCCL77bucx9uImI5nX24PIlqT+zasVEEVGSRF
 m8dgkcJDB7Tps0IkNrUi4yof3B3shR+vMY3i3Ip0e41zKx0CvlAhMOo6otaHmcxr35sWq1Jk
 tLkbn3wG+fPQCVudJJECvVQ//UAthSSEklA50QtD2sBkmQ14ZryEyTHQ+E42K3j2IUmOLriF
 dNr9NvE1QGmGyIcbw2NIVEBOK/GWxkS5+dmxM2iD4Jdaf2nSn3jlHjEXoPwpMs0KZsgdU0pP
 JQzMUMwmB1wM8JxovFlPYrhNT9MAEQEAAcLBMwQYAQIACQUCVEJx7gIbDAAKCRB+FRAMzTZp
 sadRDqCctLmYICZu4GSnie4lKXl+HqlLanpVMOoFNnWs9oRP47MbE2wv8OaYh5pNR9VVgyhD
 OG0AU7oidG36OeUlrFDTfnPYYSF/mPCxHttosyt8O5kabxnIPv2URuAxDByz+iVbL+RjKaGM
 GDph56ZTswlx75nZVtIukqzLAQ5fa8OALSGum0cFi4ptZUOhDNz1onz61klD6z3MODi0sBZN
 Aj6guB2L/+2ZwElZEeRBERRd/uommlYuToAXfNRdUwrwl9gRMiA0WSyTb190zneRRDfpSK5d
 usXnM/O+kr3Dm+Ui+UioPf6wgbn3T0o6I5BhVhs4h4hWmIW7iNhPjX1iybXfmb1gAFfjtHfL
 xRUr64svXpyfJMScIQtBAm0ihWPltXkyITA92ngCmPdHa6M1hMh4RDX+Jf1fiWubzp1voAg0
 JBrdmNZSQDz0iKmSrx8xkoXYfA3bgtFN8WJH2xgFL28XnqY4M6dLhJwV3z08tPSRqYFm4NMP
 dRsn0/7oymhneL8RthIvjDDQ5ktUjMe8LtHr70OZE/TT88qvEdhiIVUogHdo4qBrk41+gGQh
 b906Dudw5YhTJFU3nC6bbF2nrLlB4C/XSiH76ZvqzV0Z/cAMBo5NF/w=
In-Reply-To: <ZdjCpX4LMCCyYev9@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/23/24 17:07, Sean Christopherson wrote:
>> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
>> index f760106c31f8..53e958805ab9 100644
>> --- a/arch/x86/kvm/svm/sev.c
>> +++ b/arch/x86/kvm/svm/sev.c
>> @@ -59,10 +59,12 @@ module_param_named(sev_es, sev_es_enabled, bool, 0444);
>>   /* enable/disable SEV-ES DebugSwap support */
>>   static bool sev_es_debug_swap_enabled = true;
>>   module_param_named(debug_swap, sev_es_debug_swap_enabled, bool, 0444);
>> +static u64 sev_supported_vmsa_features;
>>   #else
>>   #define sev_enabled false
>>   #define sev_es_enabled false
>>   #define sev_es_debug_swap_enabled false
>> +#define sev_supported_vmsa_features 0
> 
> Ok, I've reached my breaking point.  Compiling sev.c for CONFIG_KVM_AMD_SEV=n is
> getting untenable.  Splattering #ifdefs _inside_ SEV specific functions is weird
> and confusing.

Ok, I think in some cases I prefer stubs but I'll weave your 4 patches 
in v3.

Paolo

> And unless dead code elimination isn't as effective as I think it is, we don't
> even need any stuba  since sev_guest() and sev_es_guest() are __always_inline
> specifically so that useless code can be elided.  Or if we want to avoid use of
> IS_ENABLED(), we could add four stubs, which is still well worth it.
> 
> Note, I also have a separate series that I will post today (I hope) that gives
> __svm_sev_es_vcpu_run() similar treatment (the 32-bit "support" in assembly is
> all kinds of stupid).
> 
> Attached patches are compile-tested only, though I'll try to take them for a spin
> on hardware later today.


