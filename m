Return-Path: <linux-kernel+bounces-154838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 767858AE1C6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 12:06:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 046321F2513C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 10:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51D28634EA;
	Tue, 23 Apr 2024 10:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a73i20ML"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B87060B9C
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 10:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713866759; cv=none; b=rcmfoLHoKBNxh09H3rMUIebfgykR1PppRzKcjgLF2E83EzJWGdqOCD39FP0gsX2+3HnnGoSXkdLqXJ8ylFeELaif4Mt1mVXDsONG4ChRRYctx56h5IOeicevxsh59o+8ZY9sL+FYDcb5aCzcI8ZAdnLnC0V+fwpBusobOV7hEPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713866759; c=relaxed/simple;
	bh=Twk/ZuJVG4hPOTPJ1d8MhOugXt8GcOxO/JPB77A/3Ro=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GsQQ7Pi/5+0zK+kvfTQzQplKUYE3v6H9iGs3ZQJG4z1dZDiI1FW3MJsbuhgUfkwRf2ff56WzNA91XVH15tlRA9qXF2z8SmqYKb3PViQikz39fXmPWWxE6Ngc+qmGfRgziF5EgQxnMiQfq48w77n46T5QG1GyQUIixUCSv06y/8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a73i20ML; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713866756;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=F+Q9aGVP3yII7x3QTr/Q0CIoNT3qXPVZy2zCGid78Zg=;
	b=a73i20ML1zlfnVp3X+4c5zq9lKt64KWKbaeWTD3fYAdXqjq0gb9P/puH8gXJNtD5+AuPsd
	HXvar5G3m7ibuvTEn016VHBQjMqGDFul379MgPGO2O2qczk6Sizu6LyH7i4wysIFUlwDbh
	q0BZaB+ofinQjRIGGTvbPTu6k3zkbVM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-591-THOn8mS0P0ux8AGryvIjVQ-1; Tue, 23 Apr 2024 06:05:54 -0400
X-MC-Unique: THOn8mS0P0ux8AGryvIjVQ-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-349e1effeb5so2932914f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 03:05:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713866754; x=1714471554;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F+Q9aGVP3yII7x3QTr/Q0CIoNT3qXPVZy2zCGid78Zg=;
        b=VLXK6tdTwD4FOFvJIvoUMLKKVCWzn99B61a+3s8zLlNFjZj6tlkwkxv39p17uBwXBj
         2ntDamyz8kOCAT2ERdnwYyjTXfjKZxL1euWGjSfU3peRICAktRjMOKmHZwNCVQO4onT3
         ZKLyu05QEtIvlyobY3vk8ewQy0qV7C7zSXF7H1taK8LAKXrv6+asjdLNiGENTNA1mFId
         jnUxSILzniDZEWSX2BGT57u2PrMjZJTp7K3s5Guwrz8zfufU7K7dYLEMMdRTOJu/vj5s
         e9oGCj1HF7NFp99TwWqBY97QUOy1mkpjHBKPu5sn0TbV6eYjN9di9qEQg8Lc6NwcYKzo
         5Cdg==
X-Forwarded-Encrypted: i=1; AJvYcCUtTFkEfSbvKICkkqfjiq7+Q4Ga4uaXbK/8sKdm1IgH60wsfO/lNeDZxYZP+fGDXXTYouIsmCSg9EIxkN0XL24VxhhvGYXX7J82d+eu
X-Gm-Message-State: AOJu0YwpY9hKXo0fCPMPJM0GYgzWKWmGtIXi8llYTdiCEYZkcZY2n1ep
	cx6NMehgbK7cXSWCx+kt/gNvEFMPEtGeNdzrRtuMomYNU1KviXUQEOWhKbxiwFla14WAlhr/hVU
	bzkMCWis7ixhygoABlkhpuvpOHsF+ltgngnhwH3E18WiLcpp5hngWtdQU98lWuw==
X-Received: by 2002:a5d:6907:0:b0:34a:4fa9:81cf with SMTP id t7-20020a5d6907000000b0034a4fa981cfmr1596246wru.9.1713866753778;
        Tue, 23 Apr 2024 03:05:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHCOiS28rfyISNYsVlnGbpsZHHQElQ+Pbxgkau4HW6WdxGzx4PhG4bzvRUiYCn0i84dGXoo+g==
X-Received: by 2002:a5d:6907:0:b0:34a:4fa9:81cf with SMTP id t7-20020a5d6907000000b0034a4fa981cfmr1596223wru.9.1713866753396;
        Tue, 23 Apr 2024 03:05:53 -0700 (PDT)
Received: from ?IPV6:2003:cb:c706:fd00:fb07:92f8:8f0c:6a08? (p200300cbc706fd00fb0792f88f0c6a08.dip0.t-ipconnect.de. [2003:cb:c706:fd00:fb07:92f8:8f0c:6a08])
        by smtp.gmail.com with ESMTPSA id e7-20020a5d65c7000000b00349eb6eae3esm14369407wrw.4.2024.04.23.03.05.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Apr 2024 03:05:52 -0700 (PDT)
Message-ID: <58388a65-5084-42c6-aa2d-a4b1c5af0ab7@redhat.com>
Date: Tue, 23 Apr 2024 12:05:52 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: manual merge of the vhost tree with the mm tree
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
 Andrew Morton <akpm@linux-foundation.org>,
 Kent Overstreet <kent.overstreet@linux.dev>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>,
 Suren Baghdasaryan <surenb@google.com>
References: <20240423145947.142171f6@canb.auug.org.au>
 <e07add5b-e772-4a8c-b71f-79f1fe74580a@redhat.com>
 <20240423053045-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240423053045-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 23.04.24 11:32, Michael S. Tsirkin wrote:
> On Tue, Apr 23, 2024 at 10:21:55AM +0200, David Hildenbrand wrote:
>> On 23.04.24 06:59, Stephen Rothwell wrote:
>>> Hi all,
>>>
>>> Today's linux-next merge of the vhost tree got a conflict in:
>>>
>>>     drivers/virtio/virtio_mem.c
>>>
>>> between commit:
>>>
>>>     c22e503ced5b ("fix missing vmalloc.h includes")
>>>
>>> from the mm-unstable branch of the mm tree and commit:
>>>
>>>     4ba509048975 ("virtio-mem: support suspend+resume")
>>>
>>> from the vhost tree.
>>>
>>> I fixed it up (see below) and can carry the fix as necessary. This
>>> is now fixed as far as linux-next is concerned, but any non trivial
>>> conflicts should be mentioned to your upstream maintainer when your tree
>>> is submitted for merging.  You may also want to consider cooperating
>>> with the maintainer of the conflicting tree to minimise any particularly
>>> complex conflicts.
>>>
>>
>> Easy header conflict. @MST, @Andrew, do we simply want to take that
>> virtio-mem patch via the MM tree to get rid of the conflict completely?
> 
> ok by me:
> 
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> 
> Andrew if you pick this let me know pls and I will drop it.

@Andrew, the relevant patch is

https://lore.kernel.org/linux-kernel/20240318120645.105664-1-david@redhat.com/

I could resend, putting you on CC. Whatever you prefer.

-- 
Cheers,

David / dhildenb


