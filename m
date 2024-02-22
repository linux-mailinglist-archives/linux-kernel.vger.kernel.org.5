Return-Path: <linux-kernel+bounces-76881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 851D985FE1A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 17:32:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59BBF1F25386
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 16:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A0B41D68C;
	Thu, 22 Feb 2024 16:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LX0k5rzP"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45212153BC6
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 16:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708619511; cv=none; b=A4nSdKpTzcDBU/A4DlPFEv4JoLbdV+dgaHn8MueRDIDWGJ3l3upPEtXz2BCXPBZclddtlP/aZe8EXlbyIIyZdDz9LPOqbYkvCvCFIOOH3VsbJcll6vfp/tJrFddxVpebOJZDjc55WJivJoMitUggEus9hdzohUnp1eL4oGtfYFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708619511; c=relaxed/simple;
	bh=l3Lxaih8QIfEvdNnlT1GxTvK8uZNbL23TlDV5nQs0fA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aqr5zN5fFNZMuTlyBPGVBs1hRQ7oc73J1Y7QFSQX0z2wAzJnfXT32tmZx59J+gFWxsAGh9p51MTrwrmTF4z0lNTNEQHdU1PHcBDPXm4f71/WAoLMXxg2PSHiIa8GcTuq1qOucvQ/y5E6oYqaEM1QYEswcFcwfZyNtOxAIb3IZjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LX0k5rzP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708619497;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=TB+h9Y4eFs4+OFe3k2AYgGN2x3TMYZr1cM9XcIH8U2o=;
	b=LX0k5rzPALVh/Qg/IZ3KrujS5LSusPBOHzPTr7h7gbGJQgX5x6pAPpHiaibz2/NCbDDJVf
	vy6JDKjMOTcljKV6z2Q3yePiBLkx/7NB272rL+j7ZFXg4BIYogLWMo7Oo3EbiDwY4iht9V
	8Lzs82PQD2TmN5uAjO6+ZBSQVhpZSPo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-618-buqJjxg1PKyGayDwAqaR_g-1; Thu, 22 Feb 2024 11:31:36 -0500
X-MC-Unique: buqJjxg1PKyGayDwAqaR_g-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-337a9795c5cso4886667f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 08:31:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708619495; x=1709224295;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TB+h9Y4eFs4+OFe3k2AYgGN2x3TMYZr1cM9XcIH8U2o=;
        b=dmpSjtXVlib/g6d1ptcRVsV2PNZKdhhqImBmmCkGmRKTkK1l+FqUheBWhCj7RzGeH9
         9yvpfU7SSeaJDwnRfcJquOBOV8e/rwySv1f8hJNlvrkvksNAVwXYRG0zhtXbwIx7GWlm
         O/d4/cCScWrz4uXlFZt27KoZXMEWSwLIzVfBWiOBIefRq8PVOCxpHfvTtR2VJOiEsPz0
         uy2xUvTf0ovBgx91xbGyeReRqli6IFfFUlLj8VDqBRXUEzi/vTPneIBF4AfLNc8MDkIU
         QjcPKmpfsl2DX67+i8pdXUxbSF83OgAmundl0rjhQPpAP6CUtU2bmKM6O5cIgaBibXQg
         R8dg==
X-Forwarded-Encrypted: i=1; AJvYcCVlYFZ0dgrgWq6FpJeGGF2qExyGUsDC9v/fiJC3WuzUVh8CvvnZFDo9QrCHWDJf6EGplx4dJKArQDl2KVURx2KUuGUkcL33ZyS5kC5s
X-Gm-Message-State: AOJu0YwlB81JGPnfqzRTS2OPQZiB+0H4u4a3KJUqXr/ti7LG7Al68Mr9
	mzre/zdtllFRJANjsS7DSQnLoi1vA8z94ZaE+mWx0KhxQwoYt/nsxk/Hd7B6a/4gAaSmSHbkpfc
	77khDLztsJmGSi7MbHZL5fXe9XCOSgOuJVNThE9GBCNVrRzvVCo+K25e4Z35Pbg==
X-Received: by 2002:a5d:6502:0:b0:33d:9c51:1776 with SMTP id x2-20020a5d6502000000b0033d9c511776mr1043961wru.10.1708619494897;
        Thu, 22 Feb 2024 08:31:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEoKDx3jiXb3rrusVpzPdxnnhBRUGcwZtr+Ib0j5hFRv2sJu+SXFU64P9IUmHTMFwaMi35C3Q==
X-Received: by 2002:a5d:6502:0:b0:33d:9c51:1776 with SMTP id x2-20020a5d6502000000b0033d9c511776mr1043946wru.10.1708619494530;
        Thu, 22 Feb 2024 08:31:34 -0800 (PST)
Received: from ?IPV6:2003:cb:c70f:8b00:ed48:6d18:2152:1cda? (p200300cbc70f8b00ed486d1821521cda.dip0.t-ipconnect.de. [2003:cb:c70f:8b00:ed48:6d18:2152:1cda])
        by smtp.gmail.com with ESMTPSA id i3-20020a05600011c300b0033cf453f2bbsm20825934wrx.35.2024.02.22.08.31.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Feb 2024 08:31:34 -0800 (PST)
Message-ID: <31bade75-316c-4f3a-9325-1e347975f93c@redhat.com>
Date: Thu, 22 Feb 2024 17:31:33 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/util.c: Added page count to __vm_enough_memory failure
 warning
Content-Language: en-US
To: Matthew Cassell <mcassell411@gmail.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20240221160235.1771-1-mcassell411@gmail.com>
 <1547a955-cee6-40e1-8231-0bd1229de0f3@redhat.com>
 <CANiscBBhk+g267yYz8DhgU23gt0Ranak4VctxeG1-_tt_KkOag@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <CANiscBBhk+g267yYz8DhgU23gt0Ranak4VctxeG1-_tt_KkOag@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 22.02.24 17:24, Matthew Cassell wrote:
> Resending due to plain-text email issue that caused mailing list to get skipped.
> 
> Thank you for the feedback. I agree with you and would prefer to use
> bytes/kbytes. Here are the 2 concerns that led to me keeping it as
> pages:
> 
> 
> 1. Reduce the impact of the patch. Here is the call trace to reach the
> failure warning:
> 
> <… usual mmap() stuff …>
> mmap_region() -> security_enough_memory_mm() -> __vm_enough_memory()
> 
> Within mmap_region(), the length variable originally passed to mmap()
> gets right-shifted to get the page count. My first thought was to add
> an additional an additional argument to security_enough_memory_mm() of
> type unsigned long to keep that variable, but saw a handful of calls
> to it that would have to conform to the change. Not that I do not
> think this debug statement does not warrant that, I felt the less
> impact, the better.
> 
> 
> 2. Concerned about losing bits. When converting back to bytes I was
> worried about the loss of precision and printing that number back to
> users:
> 
> unsigned long bytes_failed = pages << (PAGE_SHIFT);
> 

In which scenario would you imagine that we lose precision? In other 
words, how would someone be able to create a VMA that is larger than 
what we can fit into an unsigned long in bytes?

I'd simply print "pages << PAGE_SHIFT" here and not worry about that :)

-- 
Cheers,

David / dhildenb


