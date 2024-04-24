Return-Path: <linux-kernel+bounces-157714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C17A68B14FC
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 23:00:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 795922858E1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 21:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E350C156976;
	Wed, 24 Apr 2024 21:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nv10TD//"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B9D153BEC
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 21:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713992419; cv=none; b=C9zR8fT9lPme8gXKI3gJUzowsKGjLz/M9naA+d3XBMWChzEJr1UWNFN3Oz/nlFYazHdjcdAjABPsEK3NzBlZtcl+/W83KHI5VAZGh4L9OajBbaCRDcgJm1g4/jj1VhiXdNeGmD5HiVy9wlfhZkCOuMmb7/kCE1pO0WI4gM27La0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713992419; c=relaxed/simple;
	bh=3zuFRd+JHirAo1gV7T5uNaXXdJMLOQUTnRYRwOwBdiM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VtemRt8u8JWhy4cdRkzs1c+exmA7ctFPXU9pcsp4MWMvVYC9PBMed8rDn6sQwpjX5x33+wcHbFlk3ux0RroXrVAYFk28eOlkmAnsWNpvHxJfifK2beNCswR0Od6l9RM3V5TSjXwJQ2OrmssFtpJCDYpqF2+gyKlF4c7nv1Um7sI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Nv10TD//; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713992416;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=f7mxnOykJ+bcd0hDvTFMX+Ym9TYbYEsldJG732p6gvA=;
	b=Nv10TD//S5/0EECNtewotiQMlAM7E0zbsQSIqTIyiz9Sdxnqic67eqaSi5ehkbs9nqYlDQ
	uLlIrUpJYMuhziexUWDkMxTClSuNR4IkHsJKLuHqkrcQVdoZ+21bv/TbM7z9YlxuwVdTxX
	t8J1WSxbESKATzaqaqGYJcs9pKYDgRA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-1Q90vxC4MHy8dRw_anw_-w-1; Wed, 24 Apr 2024 17:00:15 -0400
X-MC-Unique: 1Q90vxC4MHy8dRw_anw_-w-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-418df23b51cso1227705e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 14:00:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713992414; x=1714597214;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=f7mxnOykJ+bcd0hDvTFMX+Ym9TYbYEsldJG732p6gvA=;
        b=qWgqmDAzVGe3Tf7qCLQGlznCCxP7L/aTpkepdRwscIA2AetkSkWFMaKZDSxTLaMwPa
         ecQ00MrnHVpe4Po6GzgbL1bzTzNrtJbHzVcis4DMcA4pOT+t+fJKcccFVEJnh73Scr7P
         GONDHMeBQdms7yTTOxGSJKTYysCV5GjkKQEg+8IpIUGDSuQK93P/X6lJvJtGMFVz01HD
         s/eNjPka/jmXun9F+CaKZCSkva0w8xsDbcKL1EJlKuCa/p/vU6ULzAKQv4Mf8XEIOzug
         Wx2V+Q6mGK6V6sW6ZmqogJAhji2p/Y2K1yYjpm/X4cv0IwDCe2Qn4RqSQRKmEKIRO0zj
         JM+A==
X-Forwarded-Encrypted: i=1; AJvYcCVcOsDCnw0KT0ya2gSMhOjMsRBZeCwuzXfdI7W8vEaYRtTZkpG7HawWb9aZ5PjTFI/0DhXYI8wUbk2WVDD9loAJ1JjLDxlkhYqpgRBE
X-Gm-Message-State: AOJu0YwVq8/U2w2O3Q7QkzojUgci8aIuXk82jL2ugGjAU0/Zorz+tjAz
	lld+9M+kZVFkP0QAgpMmt+Z98F7JqjF/SZ1kXzpIO/GNclWipw3bLM9Qn0J8kzd0KErtq43H4n8
	E00+bJfWvlYgKBvVjxePKVrPtr24XwcoxJR807/9uOX6r5jwK9i7Z3JvWlSH3MQ==
X-Received: by 2002:a05:600c:3ac6:b0:41a:c52d:e2a3 with SMTP id d6-20020a05600c3ac600b0041ac52de2a3mr2700779wms.23.1713992414021;
        Wed, 24 Apr 2024 14:00:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGVIYX76LSeJiMKLiBqYm74g+TcQzb8rUeAtAPH/sLzSxOZ0podq8mUFnVIJ60RuDQfdjZYXQ==
X-Received: by 2002:a05:600c:3ac6:b0:41a:c52d:e2a3 with SMTP id d6-20020a05600c3ac600b0041ac52de2a3mr2700762wms.23.1713992413622;
        Wed, 24 Apr 2024 14:00:13 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70d:1f00:7a4e:8f21:98db:baef? (p200300cbc70d1f007a4e8f2198dbbaef.dip0.t-ipconnect.de. [2003:cb:c70d:1f00:7a4e:8f21:98db:baef])
        by smtp.gmail.com with ESMTPSA id g9-20020a05600c310900b0041a9fc2a6b5sm8395435wmo.20.2024.04.24.14.00.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Apr 2024 14:00:13 -0700 (PDT)
Message-ID: <b1cf78f8-8480-4451-bbf8-78694ebd0438@redhat.com>
Date: Wed, 24 Apr 2024 23:00:12 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC][PATCH] uprobe: support for private hugetlb mappings
To: Guillaume Morin <guillaume@morinfr.org>
Cc: oleg@redhat.com, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, muchun.song@linux.dev
References: <ZiK50qob9yl5e0Xz@bender.morinfr.org>
 <b70a3d3a-ea8b-4b20-964b-b019c146945a@redhat.com>
 <ZiaoZlGc_8ZV3736@bender.morinfr.org>
 <22fcde31-16c4-42d0-ad99-568173ec4dd0@redhat.com>
 <ZibOQI9kwzE98n12@bender.morinfr.org>
 <8d5314ac-5afe-41d4-9d27-9512cd96d21c@redhat.com>
 <ZilvOi7ceSXmwkNq@bender.morinfr.org>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <ZilvOi7ceSXmwkNq@bender.morinfr.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24.04.24 22:44, Guillaume Morin wrote:
> On 24 Apr 22:09, David Hildenbrand wrote:
>>>> Let me try to see if we can get this done cleaner.
>>>>
>>>> One ugly part (in general here) is the custom page replacement in the
>>>> registration part.
>>>>
>>>> We are guaranteed to have a MAP_PRIVATE mapping. Instead of replacing pages
>>>> ourselves (which we likely shouldn't do ...) ... maybe we could use
>>>> FAULT_FLAG_UNSHARE faults such that we will get an anonymous folio
>>>> populated. (like KSM does nowadays)
>>>>
>>>> Punching FOLL_PIN|FOLL_LONGTERM into GUP would achieve the same thing, but
>>>> using FOLL_WRITE would not work on many file systems. So maybe we have to
>>>> trigger an unsharing fault ourselves.
>>
>> ^ realizing that we already use FOLL_FORCE, so we can just use FOLL_WRITE to
>> break COW.
> 
> It was never clear to me why uprobes was not doing FOLL_WRITE in the
> first place, I must say.

It's quite dated code ...

The use of FOLL_FORCE really is ugly here. When registering, we require 
VM_WRITE but ... when unregistering, we don't ...

> 
> One issue here is that FOLL_FORCE|FOLL_WRITE is not implemented for
> hugetlb mappings. However this was also on my TODO and I have a draft
> patch that implements it.

Yes, I documented it back then and added sanity checks in GUP code to 
fence it off. Shouldn't be too hard to implement (famous last words) and 
would be the cleaner thing to use here once I manage to switch over to 
FOLL_WRITE|FOLL_FORCE to break COW.

-- 
Cheers,

David / dhildenb


