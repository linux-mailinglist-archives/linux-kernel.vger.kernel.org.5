Return-Path: <linux-kernel+bounces-66999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B8BBD8564AB
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 14:42:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9A73B24EF6
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 13:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9463E131736;
	Thu, 15 Feb 2024 13:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DVSlmFtt"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CEDA130E40
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 13:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708004439; cv=none; b=Y3EmHwquttGOxbqFUqswk2MZeoCi5CPoxT9Av5JNikgRLXaw0Aaomgz9FD+iSCzPtKr/Y+mflvGk5HV4PD6F5eSNCxR23qDV4iy1zSw/StxP2E5YMKXCFPEx4QLWNF4Wl7+stox1K9fBH7/CSavtGCqppk7cJgzl/6uSRSYjojQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708004439; c=relaxed/simple;
	bh=fscX/PpSOaaqQeDkoGcQk6LYh/ZhYixjTW4bIRHl3fA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W6hoTOYxwKEKabOK0E+lqt+dNm4hmyngVsZdeIoJDSlsaqEMgJb9CbjHEUmp+TRuOyiqJ90VrKDQwMrfc/x8b7ILHZ1a8LoGfrmBR+fG7NsSTwP0RycGedL3A9fvy3WbVJloWsgoPJ0tLwkHMxorzYiIO1mZ9itNK0aC8kvZY5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DVSlmFtt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708004437;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=eIwfLh9HR89F90myo0zaqMi6OYqM5wGPc4kH/g9e8rk=;
	b=DVSlmFtti/orkZw4hqqk4rocPjemZbhET5EiNC4Jp0HFJc4ONmBHIAPr/2FkBuO+g4+Usn
	pY5KgP5tkwB1JlvkrqqCNJd8YI/tcVuvhcLg6Dr5ZsVoD7A7x/EMpklgVKB16Vtv+wjYtu
	GwiZP56JczSv51Uw8/qetX0CmvP2oeY=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-80-2vkQbRKTN76WZpB22RKvVg-1; Thu, 15 Feb 2024 08:40:36 -0500
X-MC-Unique: 2vkQbRKTN76WZpB22RKvVg-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a3d201e60f2so47961966b.3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 05:40:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708004435; x=1708609235;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eIwfLh9HR89F90myo0zaqMi6OYqM5wGPc4kH/g9e8rk=;
        b=R0MuyD+Kt3wdT0NetBfXbDzfc1a3mLh89CwsSFUNZ+Iq34jFuwwQPRRwGQCpTGHcBg
         k6AfQjGNCzP4EIW7vINQh8VTM7GkAH77LG12ZWN+BiRrLLm2xxA76p+C8eDMTm68U1LA
         ElUS/+Zak8jQDCgoBcDDQDADpGlNNZLfkmlkOxAe+kmuCuc9ZNIIJ9qx+iTtaRirYKZB
         V+DEzgk4ZKz4qLrestwK2OE1jJK3fJ03jCSbnqzrDu7PFdQsaVOpdCD+u43xDyvpTu3w
         eqI2jH5n0f/2BOSyvavxZFEWrVXM307c6G8cddFS0sLdlytmy60Yc0SL7tQZkd6vLbk2
         8HkQ==
X-Gm-Message-State: AOJu0Yzy28GK87Ma3zC9okU2IrCZXy+7drnr2BLLInFTYRE85htzPQIU
	PxyNvCosN3vfU6YaiDDBJ26WVP33dbz6JLGZt4TwOp6zMCt0jWN0XCtLsV1kdujEhsRIYWHmDn7
	oSaqK/qcQ+yEvKA8qNSTBhCHB7zenDvjvsUZGRxrPfNgQz9h7SidjBgllK3kUIA==
X-Received: by 2002:a17:906:2b09:b0:a3c:f4e8:ac38 with SMTP id a9-20020a1709062b0900b00a3cf4e8ac38mr1257665ejg.9.1708004434638;
        Thu, 15 Feb 2024 05:40:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHUWmFAJwlXLHnZJEODct4SHcMpo+dspmDycCVG1jShszZm+jSGZ9B2pV0bt6mzppp7yD1IfQ==
X-Received: by 2002:a17:906:2b09:b0:a3c:f4e8:ac38 with SMTP id a9-20020a1709062b0900b00a3cf4e8ac38mr1257643ejg.9.1708004433881;
        Thu, 15 Feb 2024 05:40:33 -0800 (PST)
Received: from [192.168.1.174] ([151.64.123.201])
        by smtp.googlemail.com with ESMTPSA id qo8-20020a170907874800b00a3d87bb2daasm553872ejc.48.2024.02.15.05.40.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Feb 2024 05:40:33 -0800 (PST)
Message-ID: <bb5b0d82-6bdd-41bd-bc29-42c35698b96f@redhat.com>
Date: Thu, 15 Feb 2024 14:40:32 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/10] KVM: SEV: define VM types for SEV and SEV-ES
Content-Language: en-US
To: Michael Roth <michael.roth@amd.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, seanjc@google.com,
 aik@amd.com, isaku.yamahata@intel.com
References: <20240209183743.22030-1-pbonzini@redhat.com>
 <20240209183743.22030-9-pbonzini@redhat.com>
 <20240215011957.4bidufstf4mp5jij@amd.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20240215011957.4bidufstf4mp5jij@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/15/24 02:19, Michael Roth wrote:
>>   #define KVM_X86_DEFAULT_VM	0
>>   #define KVM_X86_SW_PROTECTED_VM	(KVM_X86_DEFAULT_VM | __KVM_X86_PRIVATE_MEM_TYPE)
>> +#define KVM_X86_SEV_VM		8
> Hmm... would it make sense to decouple the VM types and their associated
> capabilities? Only bit 2 is left in the lower range after this, and using any
> bits beyond TDX's bit 4 risks overflowing check_extension ioctl's 32-bit return
> value.

Yes, the idea was to leave 0..7 for vendor independent types (with 0 and 
1 in use), 8..15 for AMD (3 of them being reserved already for 
SEV/SEV-ES/SEV-SNP), 16..23 for Intel.

> Maybe a separate lookup table instead?

The mask was nice because it can be used in relatively hot paths... 
I'll keep them but move the constants away from uapi/ headers.

Paolo


