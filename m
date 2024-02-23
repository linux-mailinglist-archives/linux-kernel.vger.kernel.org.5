Return-Path: <linux-kernel+bounces-78565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD51D86151B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 16:04:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23D3F1F23CA6
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 15:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B80C481ADA;
	Fri, 23 Feb 2024 15:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GzcvTOKb"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8231E81ACA
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 15:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708700651; cv=none; b=nmoGig+VjAIJQ3NBMv6QYLiDxliInuKzX3v0r8YP5UndLFQUBrmGm4Bks9zbAgtl5fW1HfOvdHKN/9R0Qc3gWnArAVXpYG2JMgDN3CAUA8yOeRN3XBcDA2N/tZPsS4THgEpqAUjbWrJ+8Jd/sUImng6zktV0Grows0Q1oiRZhz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708700651; c=relaxed/simple;
	bh=wq5+jPqz7mqsgFt76V0LDdmgLLjnsb0mief44pHnXJw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KqMd2Awr139qETkheFJ0kWqOXdL1xzJN2VuIxG8LcftrwBkbyzPCcXyKavTOT9H3W4zDquvuraOz8A0ZcYvZAF0axsbNhus8TziwpieGdljh/9OPKd1DGoRQNKTDZNh1AsfkU3QpM1Kzxp5AF38opfwaHpvzdP64PrF3vZddlQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GzcvTOKb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708700648;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=y9H1I+iWFL0cF6l/mHkf7n+BhYbL216pzL/5LSVDVS8=;
	b=GzcvTOKbl2NtTtNlFyy/ObjmFESn10+jPLUavtnKmMLT9WNiKks4VIxzuRS8s+N7OluHXp
	invbraFi04x+byMslKM2eNXDvGqZogN4CCjzc57CRbwuEe3P693YFDcqiqtz5fNDV/hWPf
	56qvXP+mLn5JCL8YBXk/COKvT3nLS1A=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-36-IrdBhOf3MFO_uOYhZ1_F8A-1; Fri, 23 Feb 2024 10:04:05 -0500
X-MC-Unique: IrdBhOf3MFO_uOYhZ1_F8A-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-565926b897aso23434a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 07:04:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708700642; x=1709305442;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y9H1I+iWFL0cF6l/mHkf7n+BhYbL216pzL/5LSVDVS8=;
        b=oJWzspKvc1xpFH6rImr7+E19jL7HSecfzTGhvbEmOacaYqGWthO577JFLxodLnmoJi
         cABLJPYAj+9gVSFasJLBwHXPM0acAWIFLw1xnVV7yJt4l7EKjNdndwdcJc3XyhfGzO9K
         vsuBxk6vZtIjuP5/jYB5q1dPK9PeYngWJcwkU9PoDXeZ6vf+bkbFDjflT4rRk+1yF3FG
         rpmUJi0xxPJqtdAnRQMWwCrkzmcLcQNkY8mcGNuDXdgarFA0odqLWsFYadunBp53uSiE
         K/BHgLOfzKk+prr0TJWzOVdI6ZsUqYhX87jQblZ8PoJyWJOcf59YHmubdGHTY/8bfr0E
         Xpjw==
X-Gm-Message-State: AOJu0Yxajh4RuN4LiPeqkNrB0cuFblGK5Ywdw5w6PGfjMCW7cFHq+BHu
	HMPkdJzHDNrGkegaRtrhmc2x4RDT4deCSBwLG/i6zdVF7Lio+EUUM/wq2O91zEA+t1mBla6yUej
	st7Wa1aNnusFcN61Uwgti2wb0R8yhQGPvZAOrStQyvvBIuMRDXc5y4jKdsYnPtw==
X-Received: by 2002:aa7:d614:0:b0:565:4ab6:1f1f with SMTP id c20-20020aa7d614000000b005654ab61f1fmr80066edr.3.1708700642333;
        Fri, 23 Feb 2024 07:04:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IET8BTPD1aDfzm2NsBSavNUYXDvh7XdeJKYY/uxuLRf8VfYJ3/66sL3SozAZ3XW+T/KmCSyTg==
X-Received: by 2002:aa7:d614:0:b0:565:4ab6:1f1f with SMTP id c20-20020aa7d614000000b005654ab61f1fmr80055edr.3.1708700642050;
        Fri, 23 Feb 2024 07:04:02 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:9af8:e5f5:7516:fa89? ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
        by smtp.googlemail.com with ESMTPSA id e26-20020a50d4da000000b00564024b7845sm6944716edj.38.2024.02.23.07.04.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Feb 2024 07:04:01 -0800 (PST)
Message-ID: <6156f5e5-01fb-48c9-a57c-177ba941fa39@redhat.com>
Date: Fri, 23 Feb 2024 16:04:00 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/11] KVM: SEV: allow customizing VMSA features
Content-Language: en-US
To: Sean Christopherson <seanjc@google.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, michael.roth@amd.com,
 aik@amd.com
References: <20240223104009.632194-1-pbonzini@redhat.com>
 <ZdixRhEuGs9btjJa@google.com>
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
In-Reply-To: <ZdixRhEuGs9btjJa@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/23/24 15:52, Sean Christopherson wrote:
> 
> Given that this is based on kvm/next, I assume it's destined for 6.9.  So maybe
> rebase on kvm-x86/next for v3, and then I'll get my 6.9 pull requests sent for
> the conflicting branches early next week so that this can land in a topic branch
> that's based on kvm/next?

Ok, sounds good.

Paolo


