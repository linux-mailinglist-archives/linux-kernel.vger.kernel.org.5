Return-Path: <linux-kernel+bounces-157827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C3CD8B16E5
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 01:12:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9858D1F25BD7
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 23:12:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9BBF16F0C3;
	Wed, 24 Apr 2024 23:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="BZoE8uoV"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 919BC156F5D
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 23:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714000347; cv=none; b=HEdkdlS4HkEGWjYSXHWZxL8ddDbldweLoi+Ot+BILOx4I9cQsEv4e/jWE5FrJOFWLGq31Dbuf578kW5Wk3Px/nLLZGvbLRCiBCd38ZHhEkcixOfkUyuqrDphLfjAc642DKWlIta3BLzL1R3Hs9n8WByuM/EMNZspt1QA4/07WG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714000347; c=relaxed/simple;
	bh=293E+UBfXCzxM2p7dFTrJ7FnHnvxjqcg1sBaHjrTnxo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aYkemPFudR6OrsI2qV8Fes94whV2lrd/glh+loelXm6N3o/2OtUoUCupMg+RmT6v6i1dnCq9UzuXo7lfBN24U96JvLQQ3VOvjfRy9+v2hwuKl1cad4SOARIFCsZGr2uxKaZgTigbUDXygA3BB8u5ppldNAgyw8ehnkzpzx8/vPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=BZoE8uoV; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6ecf05fd12fso420517b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 16:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1714000346; x=1714605146; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=hPfScfPV1IGhG5jM7PoOqja5p4JBWAzPFYxIfUHs4Sw=;
        b=BZoE8uoVsIqHulwMyXbT2POaWcTWD6QGwJtWOnR6RE5SbRD0lxsha1n0qKlHzgl9Xz
         jQOxBU9EN/U013/9PlbKrVwrgEtzKwPSSakdkWr6DLIwfw1+4QSwLZ1HA699xgjiBUv3
         qYNBM1KArw5bpXqTOs4e5OtMNaIrwAl2QPNbg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714000346; x=1714605146;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hPfScfPV1IGhG5jM7PoOqja5p4JBWAzPFYxIfUHs4Sw=;
        b=PdoALxo0TmUZU1d2Gc9jIfOaDTo8idkM5AhUEY9l+vXd93sACBct900Y2ocJpqPRG5
         +4GXYnzEn2c1zADdAJOR7YnINYt61nhFMuijRchwSc4xV2lwES4TWsoQMzdmHgL1MZiX
         P7Fcgb9eTcll73J/kectn0gF0ihyEqemQQWwm8+Aqy3Lv8qSB5crMcNUgUicykfYU54+
         IoAjz6PBxZJHfemBoCLlfzPeWZGhLY9rFoiQ02wlNSEpSsu9gAwZhZWgueCPwrUpz9yV
         ELCDjcUzjujXtBVw2MMnqyxZwAD6bRhu3qPXFNWyKoUhFvrVKKIrnKeaiA8DXFD09EOx
         I+QA==
X-Gm-Message-State: AOJu0YwiJtdGpJVD/v5v7QTxLd1bC4BZ7rD2UJlgjR/E9CI0MojKlzwT
	LkKcPIvWtkrIe29Fkq8Qg08zM1SE2fqmVA01JaNIPiYotUic4g/0+2vWAFym1w==
X-Google-Smtp-Source: AGHT+IHk2hpMcHHpMlh3mlu02TpcJMcce1tmQffz3w+3HxPX6dyAB1i0Jya+cji1Ag1eQiAuZI6iXg==
X-Received: by 2002:a05:6a21:2720:b0:1ac:3a2c:b3b with SMTP id rm32-20020a056a21272000b001ac3a2c0b3bmr3799472pzb.12.1714000345872;
        Wed, 24 Apr 2024 16:12:25 -0700 (PDT)
Received: from [10.62.14.176] ([128.177.82.146])
        by smtp.gmail.com with ESMTPSA id p23-20020a1709027ed700b001d8f111804asm12670215plb.113.2024.04.24.16.12.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Apr 2024 16:12:25 -0700 (PDT)
Message-ID: <adcbfb9a-a4e1-4a32-b786-6c204d941e9f@broadcom.com>
Date: Wed, 24 Apr 2024 16:12:22 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 1/7] x86/vmware: Move common macros to vmware.h
To: Borislav Petkov <bp@alien8.de>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
 hpa@zytor.com, dave.hansen@linux.intel.com, mingo@redhat.com,
 tglx@linutronix.de, x86@kernel.org, netdev@vger.kernel.org,
 richardcochran@gmail.com, linux-input@vger.kernel.org,
 dmitry.torokhov@gmail.com, zackr@vmware.com,
 linux-graphics-maintainer@vmware.com, pv-drivers@vmware.com,
 timothym@vmware.com, akaher@vmware.com, dri-devel@lists.freedesktop.org,
 daniel@ffwll.ch, airlied@gmail.com, tzimmermann@suse.de, mripard@kernel.org,
 maarten.lankhorst@linux.intel.com, horms@kernel.org,
 kirill.shutemov@linux.intel.com, Nadav Amit <nadav.amit@gmail.com>
References: <20240422225656.10309-1-alexey.makhalov@broadcom.com>
 <20240422225656.10309-2-alexey.makhalov@broadcom.com>
 <20240424160608.GFZikt8JLrTN4M5PG2@fat_crate.local>
Content-Language: en-US
From: Alexey Makhalov <alexey.makhalov@broadcom.com>
Autocrypt: addr=alexey.makhalov@broadcom.com; keydata=
 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 EuY0
In-Reply-To: <20240424160608.GFZikt8JLrTN4M5PG2@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/24/24 9:06 AM, Borislav Petkov wrote:
> On Mon, Apr 22, 2024 at 03:56:50PM -0700, Alexey Makhalov wrote:
>> Move VMware hypercall macros to vmware.h. This is a prerequisite for
>> the introduction of vmware_hypercall API. No functional changes besides
>> exporting vmware_hypercall_mode symbol.
> 
> Well, I see more.
> 
> So code movement patches should be done this way:
> 
> * first patch: sole code movement, no changes whatsoever
> 
> * follow-on patches: add changes and explain them
> 
> Because... (follow me down)...
> 
>> @@ -476,8 +431,8 @@ static bool __init vmware_legacy_x2apic_available(void)
>>   {
>>   	uint32_t eax, ebx, ecx, edx;
>>   	VMWARE_CMD(GETVCPU_INFO, eax, ebx, ecx, edx);
>> -	return !(eax & BIT(VMWARE_CMD_VCPU_RESERVED)) &&
>> -		(eax & BIT(VMWARE_CMD_LEGACY_X2APIC));
>> +	return !(eax & BIT(VCPU_RESERVED)) &&
>> +		(eax & BIT(VCPU_LEGACY_X2APIC));
> 
> ... what is that change for?
> 
> Those bit definitions are clearly vmware-specific. So why are you
> changing them to something generic-ish?
> 
> In any case, this patch needs to be split as outlined above.

Thanks for prompt review. The concern is valid.
I've split this patch on 2 pieces:
1. Macro renaming - to use proper prefix GETVCPU_INFO_ instead of 
incorrect VMWARE_CMD_.
2. Code movement - the original idea of the patch.

Remaining patches will remain intact.

Thanks,
--Alexey

