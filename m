Return-Path: <linux-kernel+bounces-46447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F74E843FCC
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 13:59:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C4B3B21E18
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 12:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F49379957;
	Wed, 31 Jan 2024 12:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="KjoKJFKr"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0614579DD9
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 12:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706705918; cv=none; b=p62kVCYHDmmaz5Qw5i3XgCiGQ3skOBOoYdOvQxkpJ9EJLmR2BlFIhuj74qGUYuhEz9EPJiq0k0oMB6Y+DUAhzpY8/qiSIfaKKn1NQNG1vllkJMUeATSYCleSDPPzutzPVZXGiO7XVt2Tr9frK3nBAyZ+vcL2vgCfHRQkTkdozl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706705918; c=relaxed/simple;
	bh=Lb0a59hiN3odqPkQB6CkgCJ9VO+sdiG559p7/FCWAnI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j0sl04+SKprjY1iA3zyWY04q0uj5tHc+d7xI7CQwflh2WYJRzAF+MPjAcKxDWIC96Ex7Y/Z6xew8k0KyVNT92g1s56GVSficvvpXRdt06sUTOoqqxRbcVRwMpHAeoS+NPlPykC+DY2yaK01OfzS5sLy4TSdpw78CUA/5dXOWkCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=KjoKJFKr; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5101f2dfdadso8676137e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 04:58:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1706705913; x=1707310713; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g7ky/3M7B61YCAGNE0WXFX5+lOGZrN7occ3cCWK7ac0=;
        b=KjoKJFKr69S2f2RfBp6qn7wF9WxpoERhV5mDOTGR6KheC01ru5Nn8QPvTaFhjFTtZq
         j2mYPnshVlpqgMzflYfBEhZOQR5L1+hduhwyIwZyGN4OuU1hU90r/eLj6RmBkOqOxb/O
         BYQVduntS3Lz1rfNeYMvwJD9RcIStw+oAgnpXoTMWxBizFsAzjYZBUCyflf7jzn3Fc/H
         oa1/LNzdk8YXKKLD8hOkJJFpDzPCJwH8fgDtsUDSCRku/FfOArT2LZxwLGF9dcbRX3PP
         daguTAsQWo/0Bjtexl5wIMKIy+2bpTlutIvYXtGeLoi+tvbw6Wdh+romuakDlZRBDURt
         D1mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706705913; x=1707310713;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g7ky/3M7B61YCAGNE0WXFX5+lOGZrN7occ3cCWK7ac0=;
        b=HPMWJJnCWFze3rWX6B7vom9kYIboseSXvclXnzE+PZfr4DwvJDZSLOlGz0BNcymHIN
         JQJ1H/DLPb00GMy2UscuCxEIQ88sNm3YtKPMYHn3Lk8gZvPo1ij6758eR8Xy1o6p4Uh+
         SveIwxxFzhTYi1EtNquFRAB5DCHK9Pclu2u3VIi+WvE5dep0a47nVWLlTDJo/d4dkRCu
         I4Y0yBXswZeyf/BZWrXpXnS9lglVLWBscQD/2VtQ/hwHlkdhQlm10vh3ZMukv5C1wkjI
         8kt3sefRU2qpMpj+3/Pp2+e0r8C/+DRaKYg4/xGnSVc5kDx0zvD7bwuKXLtCZJHYs+Vt
         HuUw==
X-Gm-Message-State: AOJu0Yzi13dJNTYf36gSx2G4GhOKKQlt5E2WDZBPxKeLwUzoRg52tF9/
	HlrdGJx5fPdsgYMGlimVxVmmZAxFnko4mJ083VlJLxkDfFA+ZkdBSbLix6h2R2k=
X-Google-Smtp-Source: AGHT+IE12TytICRdsL2F3gNVkV6eKllHYKHvuShfvBQQdBABSqGov6rYd2Qc6dcxo5JCUzXwAptJzA==
X-Received: by 2002:a05:6512:344e:b0:511:2988:cf93 with SMTP id j14-20020a056512344e00b005112988cf93mr388733lfr.54.1706705913005;
        Wed, 31 Jan 2024 04:58:33 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWB/0NZYSc+xrEkVzOogX/cM/IKKcg5EJTC6B2y9F48G5yRtsyfETvhOLVWvWV0Ew2K+08tvh36yYqHe+RT8HSPxUVhQsimG7cJcNpMGMcvBbzB+kL+gZH/SS3MJEBgwaAv3ECfWjMO9wnFCnL9H/E527oxJiRgGozE1GsgxCDOoeXdhG/oIw7qcMdPymV22P26BKiCps8HsQhixsI9mglEySod4PCumklL6cfR3ZrR5jufzPgdORpTz9usdPpnwJUBSY8eDAE493bvf5NbV63BWB2Tif+sSnJS/Sw0MAVVPIvhY5b4Ar2Fl5MCexEUySgE36todwO6cqxtz4Oi9hcgQjVYP8TfUzFkNfvvEKcnWKppIXgy/KnfuohWgzn/M/L8Rpg49ZNwIkmdPW+byAUywP8jy38dxcxjBkt24TkddNLJz3E0+yhRREgBQI2NmZSG3e5HFua1OMmNyZeTXkgasaNrL/mtlkDelRpipd5nDmPwY15yI1+Hvera4u21ewnqjq28uixNF6KLPZ1pDvmGNiUtJ+leOlc73Zolm0SFMY9Ewo8R1peycNLwQ964o2XUSivhMPk3AD9QV+xzQGA4UkgW03vQDXdRHYwyKZ8Cks7XG4CosUUGmzLQLSjJdYMferXoU4vY2ypR2JQWEYZ0pJWixfCYwrOz59Q+MIaA0/Dfs3GgCU+rzt/wbZ89I97sHMALt/1625k=
Received: from ?IPV6:2a10:bac0:b000:7588:aea0:a2ac:ddc1:371f? ([2a10:bac0:b000:7588:aea0:a2ac:ddc1:371f])
        by smtp.gmail.com with ESMTPSA id bv16-20020a170906b1d000b00a35e3202d81sm2705223ejb.122.2024.01.31.04.58.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Jan 2024 04:58:32 -0800 (PST)
Message-ID: <5d91fc11-0b3b-40f0-872d-abdbb4038f76@suse.com>
Date: Wed, 31 Jan 2024 14:58:30 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv6 00/16] x86/tdx: Add kexec support
Content-Language: en-US
To: Baoquan He <bhe@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
 Elena Reshetova <elena.reshetova@intel.com>,
 Jun Nakajima <jun.nakajima@intel.com>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Tom Lendacky <thomas.lendacky@amd.com>, "Kalra, Ashish"
 <ashish.kalra@amd.com>, Sean Christopherson <seanjc@google.com>,
 "Huang, Kai" <kai.huang@intel.com>, kexec@lists.infradead.org,
 linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20240124125557.493675-1-kirill.shutemov@linux.intel.com>
 <3f44458f-2b4a-4464-a3df-cb791298dafc@redhat.com>
 <efe20a00-9a7c-4c03-8fcc-fce265cdbf0e@suse.com>
 <ZbpBbAkPxQZ6gHoE@MiWiFi-R3L-srv>
From: Nikolay Borisov <nik.borisov@suse.com>
In-Reply-To: <ZbpBbAkPxQZ6gHoE@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 31.01.24 г. 14:47 ч., Baoquan He wrote:
> On 01/31/24 at 09:31am, Nikolay Borisov wrote:
>>
>>
>> On 30.01.24 г. 15:43 ч., Paolo Bonzini wrote:
>>> On 1/24/24 13:55, Kirill A. Shutemov wrote:
>>>> The patchset adds bits and pieces to get kexec (and crashkernel) work on
>>>> TDX guest.
>>>>
>>>> The last patch implements CPU offlining according to the approved ACPI
>>>> spec change poposal[1]. It unlocks kexec with all CPUs visible in
>>>> the target
>>>> kernel. It requires BIOS-side enabling. If it missing we fallback to
>>>> booting
>>>> 2nd kernel with single CPU.
>>>>
>>>> Please review. I would be glad for any feedback.
>>>
>>> Hi Kirill,
>>>
>>> I have a very basic question: is there a reason why this series does not
>>> revert commit cb8eb06d50fc, "x86/virt/tdx: Disable TDX host support when
>>> kexec is enabled"?
>>
>> While on the topic, Paolo do you think it's  better to have a runtime
>> disable of kexec rather than at compile time:
>>
>> [RFC PATCH] x86/virt/tdx: Disable KEXEC in the presence of TDX
>>
>> 20240118160118.1899299-1-nik.borisov@suse.com
> 
> Runtime disabling kexec looks better than at cmpile time, esp for
> distros. While from above patch, making using of kexec_load_disabled to
> achive the runtime disabling may not be so good. Because we have a front
> door to enable it through:
> 
> /proc/sys/kernel/kexec_load_disabled

AFAIU it can't be enabled via this sysctl because the handler for it 
expects only 1 to be written to it:

      2                 .proc_handler   = proc_dointvec_minmax, 

      1                 .extra1         = SYSCTL_ONE, 

   994                  .extra2         = SYSCTL_ONE,

> 
> If there's a flag or status to check if TDX host is enabled, and does
> the checking in kexec_load_permitted(), that could be better. Anyway, I
> saw Huang, Kai has posted the tdx host support patchset.
> 
>>
>> I'm trying to get traction for this patch.
>>
>>
>>>
>>> Thanks,
>>>
>>> Paolo
>>>
>>>
>>
> 

