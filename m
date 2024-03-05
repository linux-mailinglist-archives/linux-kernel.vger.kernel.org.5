Return-Path: <linux-kernel+bounces-92449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 21E08872049
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 14:34:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DE831C22C0E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 13:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6297785C48;
	Tue,  5 Mar 2024 13:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BHtwhx+j"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C4638592E
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 13:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709645677; cv=none; b=la6e0OMVkVBHZtZGd2UzL9HeEpAD2zh8HKBQ8pnK3asViNz9bltWPCARrh/TQpTwzdcpxoiP8szC8VroaLeAZnkJk+YJWS+BF2lD0CIpp200uxPZr7mOjnVebns2e4Ken96fxNPD5QStaquCf87huYPGIRtOVXiq2Ztfux2o5+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709645677; c=relaxed/simple;
	bh=SOkpQmUlX6bJE0MCdVCGdLOMO7UfDnzeTRQD48ZaR4g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j4yHjoBz8wiWARLg/w8zKcPTaYbrMhGoxzKrESrsg0iExsdx4cRJc46g+FNaMFU5gZHYriVn9a1ghHFVePRsy4P9tA/iRADmXFGnxWKC3y1Gxv3h3cTkVjrTkQbSPGaT4adsCVJLmap/pofPInzgf9ARqP8TA4hLBtq+K5o4Mk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BHtwhx+j; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709645675;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=pIkZSMkkRKM2ftXQepv9UGxsAg+f7oq49/YynUa9VTw=;
	b=BHtwhx+jcsjOOtuWajn+0Nmypy0VHRRdxgCTlHn75NAfoD+vvDvRe7DK0kzqV4q5y52wJY
	6ey5hVRT0iXpn33AsbrwaDcp5fwRncR7YB1+SMaCY0wLrr5z1DNkrVQi33knIIoD+1YKSl
	4ls4JcmTwXsi8+4GyJdFNNmJu/6k1ZI=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-686-9UlZZBZVM-mbYmqwJlZ4xA-1; Tue, 05 Mar 2024 08:34:33 -0500
X-MC-Unique: 9UlZZBZVM-mbYmqwJlZ4xA-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a35ef7abe08so401983566b.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 05:34:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709645672; x=1710250472;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pIkZSMkkRKM2ftXQepv9UGxsAg+f7oq49/YynUa9VTw=;
        b=ZBdbNYmADwdOq6TpBZN43aJXC3PSRP0Hi6zh/d8OXGcoPFYSy4jrsMeqeEmK/ycpQn
         bt12a8/gn+Y7FaeTbI+WIr9PldhF2f+bLPBIUGrwmOts/l6yCoLySlwbUTEvEYS/fui7
         RHPPuooDwcqn/J5Jd7jzixqiV47aJUSemNNisaIpHIu0RS/ALUPcgxujesTXm4PIL5NW
         4+4HT924RVaPh0wrCdBsR/o3ed/Qpzm+Io0SgPEKi3K1EDbKjYVAjqJ2cd537HJQkL8G
         uyXGLMIUaQ6g7Y1ZwO/9NRJ/l/uZNLwCiAOF+nuD9QqErxATeHQ0irlvJGznEHF50I0a
         qYTw==
X-Gm-Message-State: AOJu0YydCdH4MxefYxpB5AjDxXyJK2ZiBqRWn7pKZFz077+++/oXSIfY
	dQyk8Rx2rPHfwmXuZXr3S1MyCk50CzALF5zU8BYxW3psJ6Df5303VsJFTtMdvpJh/mMl1Uo6cvI
	4UHropUUKYNT/WsUPnNgUOZTGQDVyfymr3HpKQd8PcYQCIzywoSo67Bhf2oZIlA==
X-Received: by 2002:a17:906:16ca:b0:a45:62bc:6b0a with SMTP id t10-20020a17090616ca00b00a4562bc6b0amr3425495ejd.65.1709645672545;
        Tue, 05 Mar 2024 05:34:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEWiNcP7d6u1wJZDSG5O7H6b9mUti/yX/XuNrT/XDEKFvKo0tnnRASlTgz3BRM3ja5+FHmJ4g==
X-Received: by 2002:a17:906:16ca:b0:a45:62bc:6b0a with SMTP id t10-20020a17090616ca00b00a4562bc6b0amr3425481ejd.65.1709645672248;
        Tue, 05 Mar 2024 05:34:32 -0800 (PST)
Received: from [192.168.10.118] ([151.49.77.21])
        by smtp.googlemail.com with ESMTPSA id lh21-20020a170906f8d500b00a4421cb0fb3sm6026709ejb.215.2024.03.05.05.34.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Mar 2024 05:34:31 -0800 (PST)
Message-ID: <5dc760b7-b77e-4824-bab2-213d5e822c4a@redhat.com>
Date: Tue, 5 Mar 2024 14:34:25 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 13/15] KVM: SEV: define VM types for SEV and SEV-ES
Content-Language: en-US
To: Xu Yilun <yilun.xu@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, seanjc@google.com,
 michael.roth@amd.com, aik@amd.com
References: <20240226190344.787149-1-pbonzini@redhat.com>
 <20240226190344.787149-14-pbonzini@redhat.com>
 <ZeXpqf/0YoBmctw2@yilunxu-OptiPlex-7050>
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
In-Reply-To: <ZeXpqf/0YoBmctw2@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/4/24 16:32, Xu Yilun wrote:
>> @@ -247,6 +247,9 @@ static int sev_guest_init(struct kvm *kvm, struct kvm_sev_cmd *argp)
>>   	if (kvm->created_vcpus)
>>   		return -EINVAL;
>>   
>> +	if (kvm->arch.vm_type != KVM_X86_DEFAULT_VM)
>                                   ^
> 
> IIUC it should be KVM_X86_SEV_VM?

No, this is the legacy ioctl that only works with default-type VMs.

Paolo


