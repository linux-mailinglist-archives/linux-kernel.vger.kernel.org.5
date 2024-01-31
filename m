Return-Path: <linux-kernel+bounces-45926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 74C2F8437E9
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 08:31:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29F6C1F27880
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 07:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 424E455C08;
	Wed, 31 Jan 2024 07:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="PVKy3cnJ"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43CBB5577C
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 07:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706686287; cv=none; b=aHKFkDWEoEMqyy4NMHN8CDYNGUIZ/x8oMESixw6L2TwM8uIIFQjwFqK7s6Grc3v83OZDEmfjyNoTGYcostj0N/LrdO5JtvEqrswvAIFoceG/+1+BemwmSHW0iRn8NTKYbNr+LlucMAb801tOQZwzu8mqXH4KdLlLSP8iQ+u1Ykw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706686287; c=relaxed/simple;
	bh=qam7HRULEOr6fNQvTRT8ZVpRJTxiJi5JDfLfsxZxk68=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b5oDgFUybyXh7oFShe2gIONv0X9Ia5xfUq7h0eVfgzbgrq7EzF5JzL9HG9CTlsYn5JPdiiYttCinRHBAeuTawR0ge+yIVzoboA0Jv+NdPOnr5QSoPp2KKPBElTwjZtG5YpIKq2WVXs05kmj2ySdfqOPkbnjRX3ghT+dJGb1HQ/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=PVKy3cnJ; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-55f0367b15fso3748182a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 23:31:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1706686283; x=1707291083; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dgLPIeASAe7o9WjBABzOsB7qU2IyoTbg5XdoUZ2fWs8=;
        b=PVKy3cnJwGEnWp5k4o/llqjKJW7LRR/8rdyCqphH34JZ8HZzVcDcZ5Z7wbtXks9oqn
         gCVMKEJfPGMlPClmALR79oguSvhZcZwrUyplmYXYGRWxy+gWnqRq4/rRchdVNGxI/T0M
         bD0w9NVr2LMkCXcZRmt3j2LsdJ+7A06cV/fHpBPpqe9pt8d+p0KZRXR7qFWxpgABUOpB
         rj+Vzw13aphrS/FpQazuYUbLLXkVqhWCm+ZnUqbz7OsuLYD9i6wm2vk2g9eqnqxECW3W
         nuksGJwpGPYvNEqfYdOI1D2NH/c1KP0BZgyD7Sfh2VrmBEJYukxGGbffTec9Nq4RspHg
         2Alw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706686283; x=1707291083;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dgLPIeASAe7o9WjBABzOsB7qU2IyoTbg5XdoUZ2fWs8=;
        b=e7pMeK1xeIIDjfTrpYr8GkdWjSoYs6s7v5LagxaZIGz62naMcNCT/XkbcgxH57NcBP
         aVdq6kMl261dTijzdEvwM0Yo2uSPBIuXIUwe4cPtkeaVEU6U7U9+WJ480m/rlnCH5Osm
         KGPbE4bz9ttPFJ85O5Fg1Fp4fCOmgMBpem7tO68m3ZqKWJ5i3w5IZZgJPFPnkze0eIsB
         j1P5qXQIRU37p7eD3Hjda02XodTqRyf0Xo0RBtI46UONgBKCfTxScjNL3jdnWZ6yc7J+
         xS/GE3kZXWVIhNl4rSQPB6K++MoKq9FxBDXwie8sAYmeH6aOw3737vRobnP3nCRZO7pK
         f4kg==
X-Gm-Message-State: AOJu0Ywd2Ksfy40je+IX0xrur7jT0rEwq2OsdZ0VReI9iSfacIrMtyfK
	N+4FS5FC2i7ueZyb4NR3qLokjuKlgFf5mzWUE4+tZoBta0/F3EIgcyL1n3Y0HSQ=
X-Google-Smtp-Source: AGHT+IGPzOcdc3+8Kb0Rxv3ybitEJMCoQK5tB6gdp4e+UqRtfJmhKXIVnjnDfIu++uawgiS1GLjYKw==
X-Received: by 2002:a05:6402:f93:b0:55e:ed35:ffce with SMTP id eh19-20020a0564020f9300b0055eed35ffcemr427085edb.37.1706686283355;
        Tue, 30 Jan 2024 23:31:23 -0800 (PST)
Received: from ?IPV6:2a10:bac0:b000:7588:aea0:a2ac:ddc1:371f? ([2a10:bac0:b000:7588:aea0:a2ac:ddc1:371f])
        by smtp.gmail.com with ESMTPSA id d32-20020a056402402000b0055f82f799dasm323865eda.66.2024.01.30.23.31.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jan 2024 23:31:23 -0800 (PST)
Message-ID: <efe20a00-9a7c-4c03-8fcc-fce265cdbf0e@suse.com>
Date: Wed, 31 Jan 2024 09:31:21 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv6 00/16] x86/tdx: Add kexec support
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
 Elena Reshetova <elena.reshetova@intel.com>,
 Jun Nakajima <jun.nakajima@intel.com>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Tom Lendacky <thomas.lendacky@amd.com>, "Kalra, Ashish"
 <ashish.kalra@amd.com>, Sean Christopherson <seanjc@google.com>,
 "Huang, Kai" <kai.huang@intel.com>, Baoquan He <bhe@redhat.com>,
 kexec@lists.infradead.org, linux-coco@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20240124125557.493675-1-kirill.shutemov@linux.intel.com>
 <3f44458f-2b4a-4464-a3df-cb791298dafc@redhat.com>
From: Nikolay Borisov <nik.borisov@suse.com>
In-Reply-To: <3f44458f-2b4a-4464-a3df-cb791298dafc@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 30.01.24 г. 15:43 ч., Paolo Bonzini wrote:
> On 1/24/24 13:55, Kirill A. Shutemov wrote:
>> The patchset adds bits and pieces to get kexec (and crashkernel) work on
>> TDX guest.
>>
>> The last patch implements CPU offlining according to the approved ACPI
>> spec change poposal[1]. It unlocks kexec with all CPUs visible in the 
>> target
>> kernel. It requires BIOS-side enabling. If it missing we fallback to 
>> booting
>> 2nd kernel with single CPU.
>>
>> Please review. I would be glad for any feedback.
> 
> Hi Kirill,
> 
> I have a very basic question: is there a reason why this series does not 
> revert commit cb8eb06d50fc, "x86/virt/tdx: Disable TDX host support when 
> kexec is enabled"?

While on the topic, Paolo do you think it's  better to have a runtime 
disable of kexec rather than at compile time:

[RFC PATCH] x86/virt/tdx: Disable KEXEC in the presence of TDX

20240118160118.1899299-1-nik.borisov@suse.com

I'm trying to get traction for this patch.


> 
> Thanks,
> 
> Paolo
> 
> 

