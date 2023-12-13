Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0369811220
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 13:53:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379050AbjLMMxj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 07:53:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379034AbjLMMxS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 07:53:18 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1856F3276
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 04:52:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702471933;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=bJEv3Wgqf4ketU6WFDuIdEXMdIFFad1fKIX/8Z1IzcQ=;
        b=e1VvnWDP3Z4eFvd20X2t0dQoynVFy6dukEfrXJ50tBdhdDoqfETyUNpp1o33UjOOEFl3sR
        89pE0Oiy3qPzqoOHGoSW//DL8pS+rm7sQAs6K6cQTkOsC0ooFQVUR/KCqlaqwEbw72PZCR
        uZhD7938lT9S7oOxJVy0aWo4aLMnDzI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-53-eKOtsrRPP9iX47ntyOzzBg-1; Wed, 13 Dec 2023 07:52:11 -0500
X-MC-Unique: eKOtsrRPP9iX47ntyOzzBg-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-33335c6d495so5277396f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 04:52:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702471930; x=1703076730;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bJEv3Wgqf4ketU6WFDuIdEXMdIFFad1fKIX/8Z1IzcQ=;
        b=hFofe9Itay+68EkuIAynmrAQAHYi3YzdosBXXYUgWIb13cIfmbIrEer1Gms5VBsFhC
         93nvVK2z+bhS2aB6NzBLHv2UnAgAfV4vnHWBshanTSWJH82M+rANc0ZGcmmBggdLpjHz
         ESSoqFuC27KAuuXVJhN/J3GOCFRFQOL+5uGoBOjQKXJtj926G8CftlfbYVNj0X8FFujE
         DeKzYI/OZcxnlfugUNkGg09xDqDPTZk5Vd4dn9qYz1lSlYQ8ERNqgEOo2bRkeYs5PK1i
         liH778GoEAhh65YL3sO7mdoDTHJyzNz+Q4ghBn6lu03THhwD18tMs3SEgy7WGh8buJy/
         NVfQ==
X-Gm-Message-State: AOJu0YysAKlA5PRJBB9Z1Z9Lc+izg/ATX6ftqfrZdG6ZjaBxmf6XnwrY
        R0oQ4UbaihJU/HfkhVIY4d/BSMtLBOa++jZjELssAq58SyEEpzQLn+44Mmc3yJdQRtPea7n3Elc
        tn5CfcxkR/IyEUdddB9Gv8jJZ
X-Received: by 2002:adf:fd46:0:b0:336:975:1832 with SMTP id h6-20020adffd46000000b0033609751832mr4108901wrs.9.1702471930060;
        Wed, 13 Dec 2023 04:52:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHsiuI3U3USlVbrEOowWazssqrIJRsCiZR7plKklR2Gi3O2ESNv8XGdBBceH98jEgWRta30fA==
X-Received: by 2002:adf:fd46:0:b0:336:975:1832 with SMTP id h6-20020adffd46000000b0033609751832mr4108893wrs.9.1702471929744;
        Wed, 13 Dec 2023 04:52:09 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:63a7:c72e:ea0e:6045? ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
        by smtp.googlemail.com with ESMTPSA id h3-20020a5d4303000000b0033629538fa2sm4664964wrq.18.2023.12.13.04.52.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Dec 2023 04:52:09 -0800 (PST)
Message-ID: <addcbff6-5db9-446a-a0a2-78f3be7f33db@redhat.com>
Date:   Wed, 13 Dec 2023 13:52:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 05/50] x86/speculation: Do not enable Automatic IBRS
 if SEV SNP is enabled
Content-Language: en-US
To:     Michael Roth <michael.roth@amd.com>, kvm@vger.kernel.org
Cc:     linux-coco@lists.linux.dev, linux-mm@kvack.org,
        linux-crypto@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        jroedel@suse.de, thomas.lendacky@amd.com, hpa@zytor.com,
        ardb@kernel.org, seanjc@google.com, vkuznets@redhat.com,
        jmattson@google.com, luto@kernel.org, dave.hansen@linux.intel.com,
        slp@redhat.com, pgonda@google.com, peterz@infradead.org,
        srinivas.pandruvada@linux.intel.com, rientjes@google.com,
        dovmurik@linux.ibm.com, tobin@ibm.com, bp@alien8.de,
        vbabka@suse.cz, kirill@shutemov.name, ak@linux.intel.com,
        tony.luck@intel.com, marcorr@google.com,
        sathyanarayanan.kuppuswamy@linux.intel.com, alpergun@google.com,
        jarkko@kernel.org, ashish.kalra@amd.com, nikunj.dadhania@amd.com,
        pankaj.gupta@amd.com, liam.merwick@oracle.com,
        zhi.a.wang@intel.com, Kim Phillips <kim.phillips@amd.com>
References: <20231016132819.1002933-1-michael.roth@amd.com>
 <20231016132819.1002933-6-michael.roth@amd.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
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
In-Reply-To: <20231016132819.1002933-6-michael.roth@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/16/23 15:27, Michael Roth wrote:
> From: Kim Phillips <kim.phillips@amd.com>
> 
> Without SEV-SNP, Automatic IBRS protects only the kernel. But when
> SEV-SNP is enabled, the Automatic IBRS protection umbrella widens to all
> host-side code, including userspace. This protection comes at a cost:
> reduced userspace indirect branch performance.
> 
> To avoid this performance loss, don't use Automatic IBRS on SEV-SNP
> hosts. Fall back to retpolines instead.
> 
> Signed-off-by: Kim Phillips <kim.phillips@amd.com>
> [mdr: squash in changes from review discussion]
> Signed-off-by: Michael Roth <michael.roth@amd.com>

Queued, thanks.

Paolo

> ---
>   arch/x86/kernel/cpu/common.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
> index 382d4e6b848d..11fae89b799e 100644
> --- a/arch/x86/kernel/cpu/common.c
> +++ b/arch/x86/kernel/cpu/common.c
> @@ -1357,8 +1357,13 @@ static void __init cpu_set_bug_bits(struct cpuinfo_x86 *c)
>   	/*
>   	 * AMD's AutoIBRS is equivalent to Intel's eIBRS - use the Intel feature
>   	 * flag and protect from vendor-specific bugs via the whitelist.
> +	 *
> +	 * Don't use AutoIBRS when SNP is enabled because it degrades host
> +	 * userspace indirect branch performance.
>   	 */
> -	if ((ia32_cap & ARCH_CAP_IBRS_ALL) || cpu_has(c, X86_FEATURE_AUTOIBRS)) {
> +	if ((ia32_cap & ARCH_CAP_IBRS_ALL) ||
> +	    (cpu_has(c, X86_FEATURE_AUTOIBRS) &&
> +	     !cpu_feature_enabled(X86_FEATURE_SEV_SNP))) {
>   		setup_force_cpu_cap(X86_FEATURE_IBRS_ENHANCED);
>   		if (!cpu_matches(cpu_vuln_whitelist, NO_EIBRS_PBRSB) &&
>   		    !(ia32_cap & ARCH_CAP_PBRSB_NO))

