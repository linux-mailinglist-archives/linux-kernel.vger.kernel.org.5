Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F027A81122A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 13:55:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379040AbjLMMzd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 07:55:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379054AbjLMMzN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 07:55:13 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B94C18E
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 04:55:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702472103;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=/HKVzQBbabQNbbp244Nm1fQjMKsvbXnOSOSucUClLDQ=;
        b=G/erz0pg0fwlTgcYJ4OA88kNCgDUWm+4Dx+nIDXmIZXdw9irG/hGea0H+CcK9nx61AAHpa
        zJlqROCZRp5BaQpknD+h3Jw54XME0tfwUBmRs7Pi3/ZK/qFzzY3RifUwTPIScARTP1kjk2
        xkjbgW1qtQ2zb7+j+2NU2pKzUw2FWo8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-41-dv_c7_MnMki3YGOSOkERSQ-1; Wed, 13 Dec 2023 07:55:00 -0500
X-MC-Unique: dv_c7_MnMki3YGOSOkERSQ-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-40c1d2b1559so48184795e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 04:55:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702472099; x=1703076899;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/HKVzQBbabQNbbp244Nm1fQjMKsvbXnOSOSucUClLDQ=;
        b=hsNhGsjL4Kxypv+4yu7gEZWbKYclW+tE6erXZ5Q74DJFiYXZz2khaWIxBZsBJ+x4GP
         T2C9zzuzBonk9GQSt8ndBafR4N+iYNrccz3ldmPreX5/YwGBIgfNwv2NA1L1Rz26bTkn
         d9AFcBcw6VU9xkIs7CzR2cUQN34OMCF78idLEUiCwjyUMOyIpS07hZfw/ce0PGogxiKd
         8mXUYqTY9aqKZfCsF7qQMeJ3mYaWspjHaJwtVDLGtdGQLy75/xRQ9thx+T0nDwTqc1Jl
         BCewQ/Bjw9KtLdJdVAyiFVtAMr+Tz9MJapoX3QAgy/BPTh0AN6hbnxYbbNpJtHJQC7iF
         jGPQ==
X-Gm-Message-State: AOJu0Yy/zo53tnQ5J6FWpJAXCjaYNo+H/3+lmgk6GBib8yzpIqIe//Nv
        IJsIBK2omwGDi+tIhe1JaGVeDe0qEZLid7OsQFIcjlCAavVdkQ+LfcoDsbw7anzNGSn5iuKks8b
        bzQeBFuOIyBCBZXI6p5JJnYLG
X-Received: by 2002:a7b:c4d0:0:b0:40b:5e59:c57d with SMTP id g16-20020a7bc4d0000000b0040b5e59c57dmr4246953wmk.167.1702472099276;
        Wed, 13 Dec 2023 04:54:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGQdiNlTSwr6VEc30+stkcWNjNy2tdKfNK5uWlFIpXTCn5UuzxjNo55fy45igptj58QEhafeg==
X-Received: by 2002:a7b:c4d0:0:b0:40b:5e59:c57d with SMTP id g16-20020a7bc4d0000000b0040b5e59c57dmr4246915wmk.167.1702472098919;
        Wed, 13 Dec 2023 04:54:58 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:63a7:c72e:ea0e:6045? ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
        by smtp.googlemail.com with ESMTPSA id f9-20020a05600c154900b0040c4be1af17sm8858371wmg.21.2023.12.13.04.54.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Dec 2023 04:54:58 -0800 (PST)
Message-ID: <cc97bfdf-ac46-4616-be68-d251304f81af@redhat.com>
Date:   Wed, 13 Dec 2023 13:54:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 20/50] KVM: SEV: Select CONFIG_KVM_SW_PROTECTED_VM
 when CONFIG_KVM_AMD_SEV=y
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
        pankaj.gupta@amd.com, liam.merwick@oracle.com, zhi.a.wang@intel.com
References: <20231016132819.1002933-1-michael.roth@amd.com>
 <20231016132819.1002933-21-michael.roth@amd.com>
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
In-Reply-To: <20231016132819.1002933-21-michael.roth@amd.com>
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
> SEV-SNP relies on the restricted/protected memory support to run guests,
> so make sure to enable that support with the
> CONFIG_KVM_SW_PROTECTED_VM build option.
> 
> Signed-off-by: Michael Roth<michael.roth@amd.com>
> ---

Why select KVM_SW_PROTECTED_VM and not KVM_GENERIC_PRIVATE_MEM?

Paolo

