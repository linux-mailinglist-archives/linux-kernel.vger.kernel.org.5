Return-Path: <linux-kernel+bounces-140191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 056218A0CA1
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 11:40:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 290231C20E76
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 09:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B4D9145357;
	Thu, 11 Apr 2024 09:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="a+CngiCa"
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC801448EF
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 09:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712828430; cv=none; b=X5bclCxm0R9HpTJ1R1cUbJBUTVpSj8rAniNHzbITqLckx5hDwqQ8kbp0RCeQld0Z6RVufx7PydyQNh12aASjZQVkF3rtbTV1mbHZqrzutffeEo551zQyAvweBEbiJ20ALxQebdBN5g0taKRAZlYBAim7mtyW0JeFAGGfxfguNC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712828430; c=relaxed/simple;
	bh=XtVgoBqvi7tRd0O01cuQB9/hEhPrLIGhPVaipVmqYoo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mHBIMWJkjEBD1GH07C4Urn4gwqCIGnD1FNfrzWP9hUUvHC/m2QN/SenLtxaTkIYj+EF5Y6wx/EYUMhs/InM+hu/1ljtRlCV5DoqTXnPuAvw+s1QEteoTsPKwm7F7L23zs0HDnX0zoQis4rkgcVAeihvxdx6snJJtDtxRMHTykPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=pass smtp.mailfrom=cloud.com; dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b=a+CngiCa; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloud.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-69b137d09e3so25566906d6.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 02:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1712828427; x=1713433227; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=XtVgoBqvi7tRd0O01cuQB9/hEhPrLIGhPVaipVmqYoo=;
        b=a+CngiCalZv7jS16aPdOv6VSmchBwbM+3E9/SMGnee6kXQMx/s1QrvSNp6eu6BH4zp
         kkP82Ccnxc75Ed0fPWCEjrylJoYr6Isu2C8WNdAGcMi9qYUt8xQQ008Hxu5k4W5g1MRn
         AdQ0sD7d1FNIMjts0r1vI63ux4OQ7GdjYIgtQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712828427; x=1713433227;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XtVgoBqvi7tRd0O01cuQB9/hEhPrLIGhPVaipVmqYoo=;
        b=RKzSJ0jIOy74x9cNuOanlbj3sbIwWmIpnSB8lZlrB9ZTmShv6wsgk9riKYxRaYEKSh
         FbAcnJmZn3rs5UyNZd62xVJc+JoeqO+3ssZa3FmtQxDkUUhwwWmZ3tkcM2y6R2UQFBQq
         3MxLwYome6ioc+ZHEVCVDpX+7VnuhWZPfFrtDs+EFhrqblTvmDGwCmsBLxWE1ocaWegt
         Gd9h7plbUBkroFXg8fGsExTRk9DHCNaN2d6s+fh2mQJRhNYh9PB9dkmnxOisN0lx4T0d
         kEcZRGbNySpceKWamRZJbKJ3ksHRiK+QtHWLbciWgfKfeUsUdwuZEsAw0o++tKluDE9+
         cqAw==
X-Forwarded-Encrypted: i=1; AJvYcCXyOC3TAMXZ9Efn6did/NmxWcmFo9pJ1FwlCxdJkjYDRzXk7aFZ6Vyo3aCFVyiejImOcRb8j6BM8eO48Y9hFoFNlIVO1voPHTU1iAv2
X-Gm-Message-State: AOJu0Yz9MV9u72hwurWWmf3ktO2bQQkWW8D1E5nP6eaPICS6uU05FUcD
	NBASyOoxus/TUPZExVegFQyAwoRHQZ4Z4QhWZ9w/swamrP77rYoNpq/vweO4Jd8=
X-Google-Smtp-Source: AGHT+IEqSlysx5Ztqrr0xQRwlY+rEbz6uhpiR7eNvMNbh5kLrrwa90+GVRP37bme9oG0C9GBDVKETw==
X-Received: by 2002:a05:6214:5096:b0:69b:9f0:aee3 with SMTP id kk22-20020a056214509600b0069b09f0aee3mr6047454qvb.2.1712828427598;
        Thu, 11 Apr 2024 02:40:27 -0700 (PDT)
Received: from [10.80.67.140] (default-46-102-197-194.interdsl.co.uk. [46.102.197.194])
        by smtp.gmail.com with ESMTPSA id d7-20020ad450a7000000b0069b26d7f061sm719821qvq.99.2024.04.11.02.40.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Apr 2024 02:40:27 -0700 (PDT)
Message-ID: <8a8845ca-1ac7-4768-a2ea-2a4f9fc5acef@citrix.com>
Date: Thu, 11 Apr 2024 10:40:24 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] x86/mm: Don't disable INVLPG if "incomplete Global
 INVLPG flushes" is fixed by microcode
To: Xi Ruoyao <xry111@xry111.site>, Sean Christopherson <seanjc@google.com>,
 Michael Kelley <mhklinux@outlook.com>
Cc: Dave Hansen <dave.hansen@intel.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski
 <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>,
 "x86@kernel.org" <x86@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Dexuan Cui <decui@microsoft.com>
References: <20240324190503.116160-1-xry111@xry111.site>
 <SN6PR02MB41576028614CB7FE9A11EBEBD4362@SN6PR02MB4157.namprd02.prod.outlook.com>
 <Zg7S5dk3J4Zc82nj@google.com>
 <d1cc1f7c-9df0-4e3c-88ae-aedcd556ba95@citrix.com>
 <Zg7jLn-lV55Yh6mH@google.com>
 <SN6PR02MB415717D76F71C023A574841ED43C2@SN6PR02MB4157.namprd02.prod.outlook.com>
 <f8df14f3-ae6a-4e08-927a-7a7c2ebe8352@intel.com>
 <SN6PR02MB4157FDA1C431A92873AA1AAED4002@SN6PR02MB4157.namprd02.prod.outlook.com>
 <ZhSdSwqUprIgLVtr@google.com>
 <d82cf14a-e949-4265-ae37-ec01685e1080@citrix.com>
 <8e12f79a8275ffa40858763acade4d54b3e96212.camel@xry111.site>
Content-Language: en-GB
From: Andrew Cooper <andrew.cooper3@citrix.com>
Autocrypt: addr=andrew.cooper3@citrix.com; keydata=
 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
 6+ahAA==
In-Reply-To: <8e12f79a8275ffa40858763acade4d54b3e96212.camel@xry111.site>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/04/2024 6:38 am, Xi Ruoyao wrote:
> On Tue, 2024-04-09 at 08:56 +0100, Andrew Cooper wrote:
>> On 09/04/2024 2:43 am, Sean Christopherson wrote:
>>> On Mon, Apr 08, 2024, Michael Kelley wrote:
>>>> From: Dave Hansen <dave.hansen@intel.com> Sent: Thursday, April 4, 2024 11:09 AM
>>>>> On 4/4/24 10:48, Michael Kelley wrote:
>>>>>> I agree one could argue that it is a hypervisor bug to present PCID to the guest
>>>>>> in this situation. It's a lot cleaner to not have a guest be checking FMS and
>>>>>> microcode versions. But whether that's practical in the real world, at least
>>>>>> for Hyper-V, I don't know. What's the real impact of running with PCID while
>>>>>> the flaw is still present? I don’t know the history here ...
>>>>> There's a chance that INVLPG will appear ineffective.
>>>>>
>>>>> The bad sequence would go something like this: The kernel does the
>>>>> INVLPG on a global mapping.  Later, when switching PCIDs, the TLB entry
>>>>> mysteriously reappears.  No PCIDs switching means no mysterious
>>>>> reappearance.
>>>> Xi Ruoyao's patch identifies these errata:  RPL042 and ADL063.  In the links
>>>> to the documents Xi provided, both of these errata have the following
>>>> statement in the Errata Details section:
>>>>
>>>>     This erratum does not apply in VMX non-root operation.  It applies only
>>>>     when PCIDs are enabled and either in VMX root operation or outside
>>>>     VMX operation.
>>>>
>>>> I don't have deep expertise on the terminology here, but this sounds
>>>> like it is saying the erratum doesn’t apply in a guest VM.  Or am I
>>>> misunderstanding?
>>> Huh.  My read of that is the same as yours.  If that's the case, then it probably
>>> makes sense to have KVM advertise support if PCID is available in hardware, even
>>> if PCID is disabled by the host kernel.
>> My reading is the same also.  Seems like VMs are fine.
> So... Should I sent a v6 with the hypervisor checking reverted [ i.e.
> always enable PCID if boot_cpu_has(X86_FEATURE_HYPERVISOR) ]?

If Linux can see a hypervisor, then yes it should be safe to use PCID.

~Andrew

