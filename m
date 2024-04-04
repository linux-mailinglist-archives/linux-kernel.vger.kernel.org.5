Return-Path: <linux-kernel+bounces-131848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93983898C7F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 18:48:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A379287DC4
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 16:48:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 357771F94D;
	Thu,  4 Apr 2024 16:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="sapdhHG3"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 658CA1F944
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 16:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712249290; cv=none; b=tEcR315GMCliYa+bf3ZEUxJWM2cApCU8fo6c9Ba3k+AKIYSNJ1hVeyjck+iVOWQuEUbdRuszLJayz44BcK0dnKwByrlD3xJ1VMknIYM9H6yMJsb7jegOAWtRF5acjQMhe5BMO9wXtndCIuzrQItcSnZ3bEPSvrwIsLM3yMbFAFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712249290; c=relaxed/simple;
	bh=7UZUpqrnZ2tB/8ABvVgavX6FGM5clbP8oDO5cQ9jQLM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mpzf1ttWZuY8xCtuYF3rLaJvWPRAgslAPUngUfgvmUyIbSU5RuXhI1ElsgCk9vLGRsV/Ll7X7IrVUPymz6m926Xs+XOHb4oVcL6z1Wg+uwoRQPiwbWsKLZDhFt7BS47f2wYQ3nGqlzVaisrZRFyngySKGHF0lzVLv7SPrwvy52g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=pass smtp.mailfrom=cloud.com; dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b=sapdhHG3; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloud.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2d715638540so16285201fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 09:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1712249286; x=1712854086; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=iWPM39phGnWd3wtkybxStwEPc4WkoN2Lgf73jp2nIuY=;
        b=sapdhHG3CtfqN7biyc95AZyI/S2unBIWaifs52QktP7w7o9uu+zQfYIOo9+y0yEqer
         jHAuMYbH5YD7BaBk2K/QzjugMKoIb/RhQuCt9O9LXCHF1dAN39B1KUqbGmsH/QUJsj/x
         dnQQbrOB7+rNfxqaAhxB9TV4eu11Wvl2t1hkY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712249286; x=1712854086;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iWPM39phGnWd3wtkybxStwEPc4WkoN2Lgf73jp2nIuY=;
        b=DrLhpLdRMo/qlJlUUaIX3AsQkkYfAfd7zeVzqgzO3qKUCMXYNnXMe4kotmIhSdhV4w
         tJQVlrBLcUXbtLnYUxFXVqqWhKoEXeAXWGeuFrXQxSRnQcxLVtFb8n8QvhBKQ+Uz800+
         b+cICidmRjBjjMGxlI/mA6A9a2yQMxGwJ41BjyUe39dbpVYxCZI1n7tr/MkDeWyUduAW
         0g5dpL9kPqol76jA6+MRWpkkBRMWn51xutAYtsP9lZcY2IEB5b5lYQoZs2R0Ez4wTN3D
         vSfM3RA/6mNwx2EGNKz2qztcRP5m5rWxv2w8j6qnKtHUj/JxJaIdj052J/ikX1mTqEOj
         hg6Q==
X-Forwarded-Encrypted: i=1; AJvYcCU/LWUwu18d6KrezoRGrNlJGKKJc3jxkQJBkstPRmJ5St6enU9Rmc6vat/RoHIpqTrPuzkiDjCenNpjqJxu4cZTXmFuGHJT4uFPCvt/
X-Gm-Message-State: AOJu0Ywj2QeYAc6tY4a/1w7DrFrYngIl86kt/4czWG8dffc71HdgseYt
	KVGTjreix30gOvAO1w4PmeT6gR7LSsiYCOobHJmLvl/AFeALOk/ZhWIpudLKSXk=
X-Google-Smtp-Source: AGHT+IFGK6zNkcJnIWxaPcK9OztrAdtK6cwETh4yt/AYW2NjJ9np+9F3JbfJAuInIEG2El7xDdO5Xw==
X-Received: by 2002:a2e:a376:0:b0:2d8:4295:da45 with SMTP id i22-20020a2ea376000000b002d84295da45mr1960367ljn.5.1712249286489;
        Thu, 04 Apr 2024 09:48:06 -0700 (PDT)
Received: from [192.168.1.10] (host-92-3-248-192.as13285.net. [92.3.248.192])
        by smtp.gmail.com with ESMTPSA id 3-20020a05600c230300b0041497707746sm4114646wmo.0.2024.04.04.09.48.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Apr 2024 09:48:06 -0700 (PDT)
Message-ID: <d1cc1f7c-9df0-4e3c-88ae-aedcd556ba95@citrix.com>
Date: Thu, 4 Apr 2024 17:48:05 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] x86/mm: Don't disable INVLPG if "incomplete Global
 INVLPG flushes" is fixed by microcode
To: Sean Christopherson <seanjc@google.com>,
 Michael Kelley <mhklinux@outlook.com>
Cc: Xi Ruoyao <xry111@xry111.site>, Dave Hansen
 <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 "H. Peter Anvin" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Dexuan Cui <decui@microsoft.com>
References: <20240324190503.116160-1-xry111@xry111.site>
 <SN6PR02MB41576028614CB7FE9A11EBEBD4362@SN6PR02MB4157.namprd02.prod.outlook.com>
 <Zg7S5dk3J4Zc82nj@google.com>
Content-Language: en-GB
From: Andrew Cooper <andrew.cooper3@citrix.com>
Autocrypt: addr=andrew.cooper3@citrix.com; keydata=
 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
 6+ahAA==
In-Reply-To: <Zg7S5dk3J4Zc82nj@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 04/04/2024 5:18 pm, Sean Christopherson wrote:
> On Mon, Mar 25, 2024, Michael Kelley wrote:
>>>  static void setup_pcid(void)
>>>  {
>>> +	const struct x86_cpu_id *invlpg_miss_match;
>>> +
>>>  	if (!IS_ENABLED(CONFIG_X86_64))
>>>  		return;
>>>
>>>  	if (!boot_cpu_has(X86_FEATURE_PCID))
>>>  		return;
>>>
>>> -	if (x86_match_cpu(invlpg_miss_ids)) {
>>> +	invlpg_miss_match = x86_match_cpu(invlpg_miss_ids);
>>> +	if (invlpg_miss_match &&
>>> +	    invlpg_miss_match->driver_data > boot_cpu_data.microcode) {
>>>  		pr_info("Incomplete global flushes, disabling PCID");
>>>  		setup_clear_cpu_cap(X86_FEATURE_PCID);
>>>  		return;
>> As noted in similar places where microcode versions are
>> checked, hypervisors often lie to guests about microcode versions.
>> For example, see comments in bad_spectre_microcode().  I
>> know Hyper-V guests always see the microcode version as
>> 0xFFFFFFFF (max u32 value).  So in a Hyper-V guest the above
>> code will always leave PCID enabled.
> Enumerating broken PCID support to a guest is very arguably a hypervisor bug.
> Hypervisors also lie to guest about FMS.  As KVM *user* with affected hardware
> (home box), I would want the kernel to assume PCID works if X86_FEATURE_HYPERVISOR
> is present.

I have very mixed feelings about all of this.

The Gracemont INVLPG vs PCID bug was found in the field, so PCID will
have been enumerated to guests at that point.  You can't blindly drop
PCID until the VM next reboots.

A related example.  I wrote the patch to hide XSAVES to work around an
AMD erratum where XSAVEC sufficed, and the consequences were so dire for
some versions of Windows that there was a suggestion to simply revert
the workaround to make VMs run again.  Windows intentionally asserts
sanity (== expectations) in what it can see; I have no idea whether it
would object in this case but hiding PCID is definitely playing with fire.

I am frequently dismayed at how many FMS abuses there are in Linux, and
I'm this >< close to talking a leaf out of HyperV's book and poisoning
FMS to 0 or ~0 just like the microcode revision.   Any use of FMS for
anything other than diagnostic purposes under virt is live migration bug
waiting to happen.

Xen's current TLB algorithms ensure never to have both PCID and PGE
active together, so we managed to dodge this particular mess.  But as a
consequence, we've got no logic to spot it, or to consider changing PCID
visibility.  That said, for better or worse, the ucode revision is
visible (for now), and a guest which polls the revision will even spot
the hypervisor doing a late ucode load.

Sorry I don't have any better suggestions.  The only nice(ish) of fixing
this for the guest kernel is for Intel to allocate a $FOO_NO bit, and
it's horrible in every other way.

~Andrew

