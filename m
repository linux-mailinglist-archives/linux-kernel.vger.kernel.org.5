Return-Path: <linux-kernel+bounces-131997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8286E898E5F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 20:54:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A60AB1C26AF8
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 18:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3F651332AD;
	Thu,  4 Apr 2024 18:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QrU5oBtQ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BEB71311B4
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 18:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712256745; cv=none; b=WChc7FpXVFKY/Obhb5Cv1ccj2/WLp8jX2QNPVctf5iJJcLJ7tkK9nMGA6fMzW86yUbd2LEwVnvdUO1nJVfCnVCPpEJwibod5R0hS6UF6j6t9bmHrw7cFaoznVJtAl0ji1CJtomh3a92TNK6I/LMpwdsyfyI7NPU5b5AfxmAP5Gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712256745; c=relaxed/simple;
	bh=FPZEwhXTwV9P7MPXtQTFINtpzaaPfSGiKgE4E8LQxiw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SsbOBkR9VAWlYKdIL7UuO0iXVJOUfuYsZKhnuqpBwnI4ACNK4q9OAIk3JPNXsQj7n7GqOcshsGUofietl0vE6txLjLLkY0R0Z8SoTYUnmWLz0fqhe6uQ/JjFmYxodtwReffcPlf0KAVcUX2p1mectRF5WL9H/XWEHwUu1BZVkmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QrU5oBtQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712256743;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=HsIJIqXQx5iTxCcZjMDZR7ODPrcBQoix35NVqNr4t94=;
	b=QrU5oBtQEjbzItGHz4/2bhleETrsExO0TqxQnQ1UjZT8FtHSFiZPbq222fo6nenGLZbkcZ
	9l/WwezOCImlN7Wreho+ounoN4ptdRgXEqeaMYXb/S97HNhjr1Wmtmvscd9CtpphT1fNlw
	bCTw1RX/V9YKeaiukZWNak8p/ITmhDA=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-81-CiRwJLOfOyeRdVaADh3mdg-1; Thu, 04 Apr 2024 14:52:21 -0400
X-MC-Unique: CiRwJLOfOyeRdVaADh3mdg-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-516c2460d95so1093092e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 11:52:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712256740; x=1712861540;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HsIJIqXQx5iTxCcZjMDZR7ODPrcBQoix35NVqNr4t94=;
        b=HAzpWAKf+JxAjkV6eZ8NrVQMxtBRIRka7zcY61MWx25nN5hJFxJUqxSyxksLzWlxAR
         WJJDvzaYqi9Uhj4x4selO+0yeKE2jT1y5x27L8a0+1tHbDXkN1IE83b0RFK+46nmBGOt
         tAZvBA+gE+U2vduFohVW045hojsrg4558CPjHU0xtivcSjxOlk2v837JuYUZHB5txBFj
         8aOQBiowS4U5kmUdY9y1qY8zA4DRgZI2DkVGBi7yOlS+u0J1P2thNqs+W0IhhpdnVZIU
         Vbb7En9FbEli0MeRMNtA0ioWMegjcZMa6l+WW1xvPel8bKkEx67+oEWJ4zXirnxSSm7P
         i7jA==
X-Forwarded-Encrypted: i=1; AJvYcCWWjCHUXhzs4lM+lo+twWooABElMs8QUecP9DetRf5nqzJifqmy1DE0TqHG7AajQeVR2/3O0BA8Y83okvK1H+TzDC4cyS9opQkR6bix
X-Gm-Message-State: AOJu0YybHOfazio8U7r0UgZSaIJJL1bMY/BkFE9DCRL5BcSYhuStJyCq
	3H8GY2B8L76pPc4ZHUI+GB5T9SBEhM2LNuhF7D0Ci6ZkVVfvaZWd4GuMEwqw2LcRwfZCxkeRwzh
	TWBhTUPfnRvLgCF+oak3KK4fzkAYN/XUr994a+Y/3fxrBWGPGbWMThSIkB42bVA==
X-Received: by 2002:a19:a414:0:b0:516:c099:e798 with SMTP id q20-20020a19a414000000b00516c099e798mr2117084lfc.31.1712256740144;
        Thu, 04 Apr 2024 11:52:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHj9eaR07U0JSOkFX0EzNdegg4G8sDsUMV2VQeV+soXyshxKfjfN3PMDNow+YcHghymD9JNGw==
X-Received: by 2002:a19:a414:0:b0:516:c099:e798 with SMTP id q20-20020a19a414000000b00516c099e798mr2117054lfc.31.1712256739585;
        Thu, 04 Apr 2024 11:52:19 -0700 (PDT)
Received: from ?IPV6:2003:cb:c743:de00:7030:120f:d1c9:4c3c? (p200300cbc743de007030120fd1c94c3c.dip0.t-ipconnect.de. [2003:cb:c743:de00:7030:120f:d1c9:4c3c])
        by smtp.gmail.com with ESMTPSA id wv11-20020a170907080b00b00a4503a78dd5sm9472229ejb.17.2024.04.04.11.52.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Apr 2024 11:52:19 -0700 (PDT)
Message-ID: <cce476f7-2f52-428a-8ae4-fc5dec714666@redhat.com>
Date: Thu, 4 Apr 2024 20:52:16 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/7] mm: Add a bitmap into
 mmu_notifier_{clear,test}_young
To: James Houghton <jthoughton@google.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: Yu Zhao <yuzhao@google.com>, David Matlack <dmatlack@google.com>,
 Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>,
 Sean Christopherson <seanjc@google.com>, Jonathan Corbet <corbet@lwn.net>,
 James Morse <james.morse@arm.com>, Suzuki K Poulose
 <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Shaoqin Huang <shahuang@redhat.com>, Gavin Shan <gshan@redhat.com>,
 Ricardo Koller <ricarkol@google.com>,
 Raghavendra Rao Ananta <rananta@google.com>,
 Ryan Roberts <ryan.roberts@arm.com>, David Rientjes <rientjes@google.com>,
 Axel Rasmussen <axelrasmussen@google.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
 kvm@vger.kernel.org, linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org
References: <20240401232946.1837665-1-jthoughton@google.com>
 <20240401232946.1837665-2-jthoughton@google.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240401232946.1837665-2-jthoughton@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02.04.24 01:29, James Houghton wrote:
> The bitmap is provided for secondary MMUs to use if they support it. For
> test_young(), after it returns, the bitmap represents the pages that
> were young in the interval [start, end). For clear_young, it represents
> the pages that we wish the secondary MMU to clear the accessed/young bit
> for.
> 
> If a bitmap is not provided, the mmu_notifier_{test,clear}_young() API
> should be unchanged except that if young PTEs are found and the
> architecture supports passing in a bitmap, instead of returning 1,
> MMU_NOTIFIER_YOUNG_FAST is returned.
> 
> This allows MGLRU's look-around logic to work faster, resulting in a 4%
> improvement in real workloads[1]. Also introduce MMU_NOTIFIER_YOUNG_FAST
> to indicate to main mm that doing look-around is likely to be
> beneficial.
> 
> If the secondary MMU doesn't support the bitmap, it must return
> an int that contains MMU_NOTIFIER_YOUNG_BITMAP_UNRELIABLE.
> 
> [1]: https://lore.kernel.org/all/20230609005935.42390-1-yuzhao@google.com/
> 
> Suggested-by: Yu Zhao <yuzhao@google.com>
> Signed-off-by: James Houghton <jthoughton@google.com>
> ---
>   include/linux/mmu_notifier.h | 93 +++++++++++++++++++++++++++++++++---
>   include/trace/events/kvm.h   | 13 +++--
>   mm/mmu_notifier.c            | 20 +++++---
>   virt/kvm/kvm_main.c          | 19 ++++++--
>   4 files changed, 123 insertions(+), 22 deletions(-)
> 
> diff --git a/include/linux/mmu_notifier.h b/include/linux/mmu_notifier.h
> index f349e08a9dfe..daaa9db625d3 100644
> --- a/include/linux/mmu_notifier.h
> +++ b/include/linux/mmu_notifier.h
> @@ -61,6 +61,10 @@ enum mmu_notifier_event {
>   
>   #define MMU_NOTIFIER_RANGE_BLOCKABLE (1 << 0)
>   
> +#define MMU_NOTIFIER_YOUNG			(1 << 0)
> +#define MMU_NOTIFIER_YOUNG_BITMAP_UNRELIABLE	(1 << 1)

Especially this one really deserves some documentation :)

> +#define MMU_NOTIFIER_YOUNG_FAST			(1 << 2)

And that one as well.

Likely best to briefly document all of them, and how they are
supposed to be used (return value for X).

> +
>   struct mmu_notifier_ops {
>   	/*
>   	 * Called either by mmu_notifier_unregister or when the mm is
> @@ -106,21 +110,36 @@ struct mmu_notifier_ops {
>   	 * clear_young is a lightweight version of clear_flush_young. Like the
>   	 * latter, it is supposed to test-and-clear the young/accessed bitflag
>   	 * in the secondary pte, but it may omit flushing the secondary tlb.
> +	 *
> +	 * If @bitmap is given but is not supported, return
> +	 * MMU_NOTIFIER_YOUNG_BITMAP_UNRELIABLE.
> +	 *
> +	 * If the walk is done "quickly" and there were young PTEs,
> +	 * MMU_NOTIFIER_YOUNG_FAST is returned.
>   	 */
>   	int (*clear_young)(struct mmu_notifier *subscription,
>   			   struct mm_struct *mm,
>   			   unsigned long start,
> -			   unsigned long end);
> +			   unsigned long end,
> +			   unsigned long *bitmap);
>   
>   	/*
>   	 * test_young is called to check the young/accessed bitflag in
>   	 * the secondary pte. This is used to know if the page is
>   	 * frequently used without actually clearing the flag or tearing
>   	 * down the secondary mapping on the page.
> +	 *
> +	 * If @bitmap is given but is not supported, return
> +	 * MMU_NOTIFIER_YOUNG_BITMAP_UNRELIABLE.
> +	 *
> +	 * If the walk is done "quickly" and there were young PTEs,
> +	 * MMU_NOTIFIER_YOUNG_FAST is returned.
>   	 */
>   	int (*test_young)(struct mmu_notifier *subscription,
>   			  struct mm_struct *mm,
> -			  unsigned long address);
> +			  unsigned long start,
> +			  unsigned long end,
> +			  unsigned long *bitmap);

What does "quickly" mean (why not use "fast")? What are the semantics, I 
don't find any existing usage of that in this file.

Further, what is MMU_NOTIFIER_YOUNG you introduce used for?

-- 
Cheers,

David / dhildenb


