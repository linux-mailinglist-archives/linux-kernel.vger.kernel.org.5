Return-Path: <linux-kernel+bounces-132278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23008899260
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 02:02:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45DCD1C2151B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 00:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECA49442F;
	Fri,  5 Apr 2024 00:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="mEqoB2Os"
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 798CF17F8
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 00:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712275332; cv=none; b=Pb8PAmcv2RPuuIE9cYgx2L0SBXi7ekR5hUsNYMnEJ4Za/ZhV4INu69HxC00X4I62ZJvLUFhQX9joIODRAImqbNnj/vI8jqbZQwLvQaq8MxBxdrvRVsCZ/ciQiDk+rYRrh/u8ztfkCMygfp+Bckpdpd7j6Kq9umKrnhTgqRB6y44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712275332; c=relaxed/simple;
	bh=v4LlNHfWy/P+pB9J/W/vupzaAjt0ATCjweEvEbJ9Xlo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TIOYNeEPoFZWwkAj73NkDVJOWA77LnQaJVeed96Ilum3rDgd7lUXjRhOmctjiie18f+vCyREo0nz30vs0775B13b3Ydn4nX5aW1tyOlFaFlXHLpsCL/Kz3ij04XE7hQ6+QM25KM+/XaW2XNoV3pINm6ej05ah9eklta4kDdmZ9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=pass smtp.mailfrom=cloud.com; dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b=mEqoB2Os; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloud.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-789f00aba19so104407885a.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 17:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1712275329; x=1712880129; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=v32aIy9nV1F7KP1TrMOQYVetbDspxaKLvELe397BNqc=;
        b=mEqoB2Osa5IT1Vf77iudDK0fNrZ812Y3Sf2+eI8VVq6WAzPBMo2bA/adaIFUvacbRv
         Rbi9meRIcBToTGZ6XPqdwWB7+aqV3SyeesriRcE9Iq4/st5RCzbwROemy/8NkiZVuT9u
         tYfpQBUareSs14HXFYXulYQjnfq8K95+DJPak=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712275329; x=1712880129;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v32aIy9nV1F7KP1TrMOQYVetbDspxaKLvELe397BNqc=;
        b=kfyshveGWtnIf3WRUs/QE8Z/H5eispapsOPdCqd9J/qTMd59CMrnpOAdjm0j670IGD
         FlVP6bKPjHHvw9G8HbAqKgjqGuoz7dcXJlM1pXwZcWrqrICEizABeh1rJ0YmZkyRMQCu
         xppvJrUDziVBjqlfgtXd2W1iYCxaBkwxLewXGRUns1NykIImVq4oFvVGd6ZAxfJHHft/
         blOlb9+4oLDnwuYQZWkL0UoJeOsDGiRAR5D0O2Mo/aGG+6t4hV0bSnXPggCCcTuSbNE8
         C6D0Mpgr93HZ1kYEc15bb7pB+e7HIeTSJExnwHE5b4o7RK8wOGQUQ4bfTUnE3w6cgiA4
         D0ew==
X-Forwarded-Encrypted: i=1; AJvYcCURVfxWT7DGfgz3safLflMn05QYLGT4w6SwcI/fXZgzNtu2Q3S/TnBgeE/3TD1cqx2nLffYSte5kdhbmtPNOhoGO+86ih38nJUSNQRo
X-Gm-Message-State: AOJu0YzmUViAfoi2X2cTRMSHfo4fQdDEoZzYV1jV7F/0bSvomNZ290lN
	OqKjKWRNeo8LuXj0g/KOtug+/mSvJQ6Q6XT0s08f0uLyJKDKRQdBioR81YWo+qs=
X-Google-Smtp-Source: AGHT+IE5cIu8hxDDP+sLDqO69Xjj1jCGoForlWYar6kr5+Rpzmis+TH7Li0Ol/03hHn19C5OKxjZPg==
X-Received: by 2002:a05:620a:b0c:b0:78d:4851:e34c with SMTP id t12-20020a05620a0b0c00b0078d4851e34cmr612735qkg.11.1712275329314;
        Thu, 04 Apr 2024 17:02:09 -0700 (PDT)
Received: from [192.168.1.10] (host-92-3-248-192.as13285.net. [92.3.248.192])
        by smtp.gmail.com with ESMTPSA id x9-20020a05620a14a900b0078a47c3a3f0sm194907qkj.38.2024.04.04.17.02.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Apr 2024 17:02:08 -0700 (PDT)
Message-ID: <0e3b8b42-4567-4db8-9f82-659d0ea10597@citrix.com>
Date: Fri, 5 Apr 2024 01:02:06 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] x86/mm: Don't disable INVLPG if "incomplete Global
 INVLPG flushes" is fixed by microcode
To: Sean Christopherson <seanjc@google.com>
Cc: Michael Kelley <mhklinux@outlook.com>, Xi Ruoyao <xry111@xry111.site>,
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
Content-Language: en-GB
From: Andrew Cooper <andrew.cooper3@citrix.com>
Autocrypt: addr=andrew.cooper3@citrix.com; keydata=
 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
 6+ahAA==
In-Reply-To: <Zg7jLn-lV55Yh6mH@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 04/04/2024 6:28 pm, Sean Christopherson wrote:
> On Thu, Apr 04, 2024, Andrew Cooper wrote:
>> A related example.  I wrote the patch to hide XSAVES to work around an
>> AMD erratum where XSAVEC sufficed, and the consequences were so dire for
>> some versions of Windows that there was a suggestion to simply revert
>> the workaround to make VMs run again.  Windows intentionally asserts
>> sanity (== expectations) in what it can see; I have no idea whether it
>> would object in this case but hiding PCID is definitely playing with fire.
> Yeah, KVM users got burned by that too.  d52734d00b8e ("KVM: x86: Give a hint when
> Win2016 might fail to boot due to XSAVES erratum").

Yeah what I meant was that I wrote the Linux patch, and KVM got burnt
while Xen cared not... :)

> Hmm, one crazy idea would be to carve out a hypervisor CPUID range for enumerating
> (potentially) broken features.  Dealing with the Intel/AMD (and Centaur, LOL),
> 0 / 0x8000_0000 split would be annoying, but not hard.  E.g. use 0x4{0,8,C}01_xxxx

No transmeta love then?  Or perhaps we declare it their fault for
choosing 0x8086 which is too awkward to fit into that scheme.

> to enumerate broken features, and then the guest could do:
>
> 	support = CPUID(leaf).reg & ~CPUID(to_pv_broken(leaf)).reg;
>
> It'd require a decent amount of churn for the initial support, but it would give
> hypervisors a way to inform guests that _any_ CPUID-based feature is broken,
> without requiring guest changes (after the initial code is merged) or explicit
> action from hardware vendors.
>
> And if we got Windows/Hyper-V in on the game, it would allow them to keep their
> sanity checks while (hopefully) degrading gracefully if a feature is enumerated
> as broken.

Crazy indeed, but I am curious to see if this has legs.  The exact
indices may need tweaking, because 0x4x01_xxxx might be a little too
close for comfort, but at first glance it does look like a surprisingly
neat solution to the problem.

Perhaps worth a slot at plumbers?

~Andrew

