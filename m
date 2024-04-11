Return-Path: <linux-kernel+bounces-140029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C67B8A0A98
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 09:53:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A3A6B2B2BE
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 07:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA22313FD68;
	Thu, 11 Apr 2024 07:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Brid/Efv"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C369B13E889
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 07:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712821924; cv=none; b=TgK3KbmfKSPJ3D7V+EeNsFcEZh2fQiuTNZN0kkQxVfO31lxuUGozIohczcoCgOdR/foG4qPX8IauZqQhxJyj9sL3Qlo/TSU51cErh0J9oJphSoQfupuA0KDdSbycuf0ztKxRZyUo1IcvJ0so5W6FsUYSV8Ypdg/hUQLr/ObFaJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712821924; c=relaxed/simple;
	bh=uDspxJbGbVmTpe5ehFGnNxMLeJRhwfjuSWIncvjIfB8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PgQqN2R1bpR0xNucubmhJ8Q/cavf2cu8KQceoWOen/KRy+um4q3YFIcmnKXMnfMF88387To5YxySERhruRk7KpnFdH/OC+xKGcjrfBwjzHVPMXkIg6wotidpZtdnrWfKJOX+JBpiOiEHMTC7zq+0d7SQVxCMB/eEi/gxThoC/HE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Brid/Efv; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-417c5aa361cso6257015e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 00:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1712821920; x=1713426720; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sqJVN8B7lUiTu5YOxrrZVz9WRBkVSsIVZdER6/FdIc8=;
        b=Brid/EfvA+v/wztQziSVyQPTtcRsXEWcdr5N5O4BRBVrxoMiLp1PM3NFTBcGiM8KvV
         hZXyj/7Ox8Ce1NT0U/rRzVZ4J5hk8uqmTTfNdqfJFNALYLcQOoiWQnsdKTS2a8q1JuTx
         hTrf5nRn7ZBe0X6muyn//WGTEe1VMFz/GVdJN68cNr/Kp2N0II9Qjagp0kZm60E9NnBn
         zfvsvloT3aBkVVyw4VRtYipxwSVSuZXZwA5O5o1J0XM7LuuEL86EoNYZARObUuc+6UI+
         sZUYqXxFxV7puBMCBKo00wjq6uTnFOqmNl92Tisqi/in0XrDCuKBwkqiUL71FoOOzYU8
         1gHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712821920; x=1713426720;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sqJVN8B7lUiTu5YOxrrZVz9WRBkVSsIVZdER6/FdIc8=;
        b=n7NbWAL43/8+zFoXA0KYEVbUfIwycN/MDxEQjq0e4FCW8cR+urNY8MjljppdQA8os7
         zPpEmEi/nXmyot0DMjz7x8+/FA3M1Ob8aT22fGdkCV94Q9IWPiYmMsGTY0yvlRACjv7z
         J0ovislYIjEfhjExC4Q7RsWawIiN8BkWiE+5uuKsuD3VA1J6dNdviKW8sqaqhDiE8ecb
         Q31w8I5tqZMBymPhsSHcDDqiwO2IP/nZ///4FzGTTxicskqJaYYpJE4fDiPvAxAx7LQB
         BepAovkRVw4c1nkHNjRHlbbCQlgsQAYNrO3ERxXsq3JMBScI5Q4tcpoylnq93QEepEC4
         uPRw==
X-Gm-Message-State: AOJu0YyiAb9ZZ+tW9lj3iCoRO0fGxRF0CBNWrWhafn82m0T+hTrOAi9T
	XNN6glHRiuDPNALUyXABBmJRwTC9QKXfYA4GXDMZKPouzQv7i44RTYN/maSA0Jk=
X-Google-Smtp-Source: AGHT+IFf17+MMypJznF+85hUqLciVFTr5scwjdz1ej9n/0Tx2DQ/HP1qnZRk3j7qU/Ga6Oj2mOsMsA==
X-Received: by 2002:a05:600c:1911:b0:416:5d63:e651 with SMTP id j17-20020a05600c191100b004165d63e651mr3285028wmq.37.1712821920164;
        Thu, 11 Apr 2024 00:52:00 -0700 (PDT)
Received: from ?IPV6:2a10:bac0:b000:7318:7285:c2ff:fedd:7e3a? ([2a10:bac0:b000:7318:7285:c2ff:fedd:7e3a])
        by smtp.gmail.com with ESMTPSA id l23-20020a05600c1d1700b004163ee3922csm4709253wms.38.2024.04.11.00.51.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Apr 2024 00:51:59 -0700 (PDT)
Message-ID: <8263d92e-4496-4085-aef5-41c94dc39c52@suse.com>
Date: Thu, 11 Apr 2024 10:51:58 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] KVM: x86: Set BHI_NO in guest when host is not affected
 by BHI
To: Alexandre Chartre <alexandre.chartre@oracle.com>, x86@kernel.org,
 kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, daniel.sneddon@linux.intel.com,
 pawan.kumar.gupta@linux.intel.com, tglx@linutronix.de,
 konrad.wilk@oracle.com, peterz@infradead.org, gregkh@linuxfoundation.org,
 seanjc@google.com, andrew.cooper3@citrix.com, dave.hansen@linux.intel.com,
 kpsingh@kernel.org, longman@redhat.com, bp@alien8.de, pbonzini@redhat.com
References: <20240411072445.522731-1-alexandre.chartre@oracle.com>
From: Nikolay Borisov <nik.borisov@suse.com>
Content-Language: en-US
In-Reply-To: <20240411072445.522731-1-alexandre.chartre@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 11.04.24 г. 10:24 ч., Alexandre Chartre wrote:
> When a system is not affected by the BHI bug then KVM should
> configure guests with BHI_NO to ensure they won't enable any
> BHI mitigation.
> 
> Signed-off-by: Alexandre Chartre <alexandre.chartre@oracle.com>
> ---
>   arch/x86/kvm/x86.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 984ea2089efc..f43d3c15a6b7 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -1678,6 +1678,9 @@ static u64 kvm_get_arch_capabilities(void)
>   	if (!boot_cpu_has_bug(X86_BUG_GDS) || gds_ucode_mitigated())
>   		data |= ARCH_CAP_GDS_NO;
>   
> +	if (!boot_cpu_has_bug(X86_BUG_BHI))
> +		data |= ARCH_CAP_BHI_NO;
> +
>   	return data;
>   }
>   

Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>

