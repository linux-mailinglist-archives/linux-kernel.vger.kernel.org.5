Return-Path: <linux-kernel+bounces-134906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BCF5989B883
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 09:35:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10712B215D6
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 07:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CCCA2C698;
	Mon,  8 Apr 2024 07:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DhwnLmUe"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D4502BB0A
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 07:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712561730; cv=none; b=CZodg8PJHCesDR5R5YgZ0IvCB7kqt7r/2ATEs7DiXOuIJrOEY3CW2AR9k5Z7fFfNQqUeGLSWs6BJk46HEXj2OMQkZMtmiIq16q6z+EFZQW6Ac44p3IKB25cqocglNudXWYEUQFvPGEGMSehQFCnZD0D/aUaA7Z+yZXa4e1tBHPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712561730; c=relaxed/simple;
	bh=0IHLjYsCH+95NP2eqcmqensUwJwYqzk/Xe0MSj34hRw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dKXfdtr/8r2IWAeB/OD/9J5RMRr4F2ghyIAApDZP3IwLCoBOBGdSEQO+76DsIn7o178MOqtuBZfeavwsuEhAFramwfCwKzt6hdss9nDSD6SrNzw1BXOD84gZnEnMdyG0LJ0m05Mjh7Avq5d1K+rlZ/stjYVL9TYS2LWsNK7DL2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DhwnLmUe; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712561728;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=d3GySbiGeorRsqZIt9Ijfkj1iWt87wQlFpIRAmiy934=;
	b=DhwnLmUecfqCN/9hKJg7T+62QqJ8iDy0SA4ByKTHZzvYZgK6YHGhSG3Re8ubjjY/XJm2vB
	z2VfYLlJM1aO6OSc8OFEsJGiKRZXmoyaUnB6Qwnrjzz4ZPvFKqdl7j+JmSZr7Jou9N3tTa
	95ngbP0izLh1ZVGv/z52SJM4g/ncNPQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-556-MIfN8wFGNB6JNgKpvhBhNg-1; Mon, 08 Apr 2024 03:35:25 -0400
X-MC-Unique: MIfN8wFGNB6JNgKpvhBhNg-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4140225e68aso20945615e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2024 00:35:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712561724; x=1713166524;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=d3GySbiGeorRsqZIt9Ijfkj1iWt87wQlFpIRAmiy934=;
        b=fRuEOL8cnNxjbvCXGvFag+WghT9QcW8Rxxlr02ccGR8oxhZzMEZKH6aNAuvmpdxb4R
         IZC7yYWJAi6qLXbzXfWBF8c6lIHlv2IgGQhK44E0PAaYA+tv+31/iSM4+qJlRWNfvfx/
         miT44OC01GXWFZ9Ef+IAjXmBcoK6kYG7Vkf1yEnJbiU/esEsQrFIk0R6wJMbOTgf3psh
         W5VHa3MQ35Q1CdnJId1VaEc1jue8eH3DigD9LwrVlnPsNwjza7sCzoBv9JyAGtMe9nWh
         A0uOMz+CpS0KPjiiqqmr5rpvulhP7IJAVIsSO8+sRizeQOinI4cKP5Tk4zEJCd7O9oLo
         nDyQ==
X-Forwarded-Encrypted: i=1; AJvYcCXq/GCwU47pkkQT2Eb3wQ8Y6qJ7gHs5asQK5gJI9uT20uqpWY7rFwirkGpMluJ/vXRZv79C1mTK1Nc8Wa9+0fSQkEBGTjaW4Hu9BF74
X-Gm-Message-State: AOJu0YwqsmTd1qvsL27TqtmMa7jOts2Cx+Q7lEhOcpw2E3zVS/U1Nfi/
	Ltcwpe8KT8TmLQJtTQoEcyFly0ntdmliSsOQUHBzL0d+jKJHEsE24gjLq4u54rtgslQu17mx3A0
	DVUxovkqS4wbNf4dz1mf8syKXGeP0RZ1DIGPcAi92eAa+4PEj/TjPcdw81f8apw==
X-Received: by 2002:a05:600c:4ece:b0:416:3365:b9c7 with SMTP id g14-20020a05600c4ece00b004163365b9c7mr4607169wmq.13.1712561724311;
        Mon, 08 Apr 2024 00:35:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHjZ9VCYB4AUQb07oKhGHJ1GEtWztGeMgSbalcZWN1jAdx1q+6Zl+lVrclpocaKQsTfHoR1hQ==
X-Received: by 2002:a05:600c:4ece:b0:416:3365:b9c7 with SMTP id g14-20020a05600c4ece00b004163365b9c7mr4607141wmq.13.1712561723921;
        Mon, 08 Apr 2024 00:35:23 -0700 (PDT)
Received: from ?IPV6:2003:cb:c718:1300:9860:66a2:fe4d:c379? (p200300cbc7181300986066a2fe4dc379.dip0.t-ipconnect.de. [2003:cb:c718:1300:9860:66a2:fe4d:c379])
        by smtp.gmail.com with ESMTPSA id l35-20020a05600c1d2300b0041680911b0fsm1228331wms.30.2024.04.08.00.35.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Apr 2024 00:35:23 -0700 (PDT)
Message-ID: <e40ad5e2-6679-47f6-ab9f-14625627ac1e@redhat.com>
Date: Mon, 8 Apr 2024 09:35:21 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] mmu_notifier: remove the .change_pte() callback
To: Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org
Cc: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>,
 Tianrui Zhao <zhaotianrui@loongson.cn>, Bibo Mao <maobibo@loongson.cn>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Nicholas Piggin <npiggin@gmail.com>, Anup Patel <anup@brainfault.org>,
 Atish Patra <atishp@atishpatra.org>, Sean Christopherson
 <seanjc@google.com>, Andrew Morton <akpm@linux-foundation.org>,
 linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
 loongarch@lists.linux.dev, linux-mips@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, kvm-riscv@lists.infradead.org,
 linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org
References: <20240405115815.3226315-1-pbonzini@redhat.com>
 <20240405115815.3226315-4-pbonzini@redhat.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240405115815.3226315-4-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05.04.24 13:58, Paolo Bonzini wrote:
> The scope of set_pte_at_notify() has reduced more and more through the
> years.  Initially, it was meant for when the change to the PTE was
> not bracketed by mmu_notifier_invalidate_range_{start,end}().  However,
> that has not been so for over ten years.  During all this period
> the only implementation of .change_pte() was KVM and it
> had no actual functionality, because it was called after
> mmu_notifier_invalidate_range_start() zapped the secondary PTE.
> 
> Now that this (nonfunctional) user of the .change_pte() callback is
> gone, the whole callback can be removed.  For now, leave in place
> set_pte_at_notify() even though it is just a synonym for set_pte_at().
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


