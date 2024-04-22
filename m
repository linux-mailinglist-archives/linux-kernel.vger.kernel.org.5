Return-Path: <linux-kernel+bounces-153097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D3A558AC912
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 11:39:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F21041C2115C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 09:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC886612D3;
	Mon, 22 Apr 2024 09:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hAQvWRDz"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8923214285
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 09:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713778781; cv=none; b=PIR7SmDhrOOzpP3mOXNBS6LfwuYnbK8K+Xtjz4ukwlnRpbzMlYsPz4XtQIRqSGtUZMkAay/LocRDAB+RUfEHyyRqy13+xI6wVQ7gNQJ+8BZL9gcuXUK+uKiWhqN+zaXYUuMNHmO3wiFeGKQYG3QTor3aHdeNvptU3LnkfoCptAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713778781; c=relaxed/simple;
	bh=mm2dJIbgo5BdfPdNtGDQ8dSg1zuqH0KHbdD07TWOtKo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=GL+u0rejb5M+Qhf5FUq2OEuUznUD5xUInX70wvQu5T8Ot1ytDB54uGRrfYoSIDsoYMmPM8yoxoEGksk7owfGIGReVc3qcBi+qY6UdwFJGa+yYVVeVr0wonVeSN8UJKX4UdL8YHcE0By7OU5aE3BDV9N4IGWBEGd5F3RvmsqwOhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hAQvWRDz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713778779;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ZiWVQN5IlmzAPqZZAGB8HW2gTI0zG/Y/lPHviSN5+f4=;
	b=hAQvWRDzUxv24hJfw+JkWa+ywf+e3LbTNrRrNddel+3/geBXtHkqLWzu3SEWUufmCZPKWi
	F4zMSiAX3CDU5YIHQdvGI8XbawKoNqwFJ2ESj55uj/pSOYcVrJolFLyEuussFULdNEvPEe
	33oRx4mUrvTum7GIvXN1LvN61fArIS0=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-556-Z78Mbz6-MYe8IihPVwQDRw-1; Mon, 22 Apr 2024 05:39:37 -0400
X-MC-Unique: Z78Mbz6-MYe8IihPVwQDRw-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2dd05014390so19382131fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 02:39:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713778776; x=1714383576;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZiWVQN5IlmzAPqZZAGB8HW2gTI0zG/Y/lPHviSN5+f4=;
        b=ZD5c3VqYo6aHupm9apcsfzeTaNBVtBdG6tWX8PpP57YwDDkklndekmtG5uHPIlZfxj
         ZJ1aWaT0Y7Ivs7xvXGOEUPVus8X8GqHhYM+9W8cna4CY8CY91r+RpqQaRxp8ydHiRXOu
         N3KDLt80lgfNR29dPMPojO1ZCVihvCAmO+LG9BtLaPbSkPMzi242gZ72GDlP3GZ1eXwL
         23JqpeG3LmVHxdY5r3bW1ng6ceFRGPQU88k3KQ62l7SdbabD90i8epe8np63f5+2YPUv
         K6fX5qqRZqci6QxROTLbk6dH9gOU7RGb36Gc9XWgYfkG1Q2GcqbJkKmd81qWPT1mw3j6
         +V3g==
X-Forwarded-Encrypted: i=1; AJvYcCWgZReFFu4qtSCZ7KCOLy4W9KF/3ubeHc1HebLn1pD++GaZIupXMawzlzJgB8M1I6ftEuUO/FIX7nKHlDqJ0juvLY3WGlDXyAYu+ZUF
X-Gm-Message-State: AOJu0Yyj6tLELrUFk6u8/A7FJpPb3tjnWlS9pAYwOspYNqb5Ajp39PD6
	cKDHr+JZKXvKW6egqBXee1NicKPPZ+Y76kH73OS9twwSAY399+5AJqVfCc9sk3KG3oclSRXPh3U
	1JZAAHvbeYmw+STIwaTY+XclRVYVwUhz6h02/PLwfsYCntF8I4ycCXctoLTMrZ+6LxJZhYw==
X-Received: by 2002:a05:6512:b9a:b0:51a:ff87:bb1 with SMTP id b26-20020a0565120b9a00b0051aff870bb1mr3936963lfv.9.1713778776385;
        Mon, 22 Apr 2024 02:39:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGBkjUOmM16GJUP4mxcnOLp8lnO247QHUbKxa57uPQDTCbUFNUDrNxPoSav4YTWku2f6cYn/g==
X-Received: by 2002:a05:6512:b9a:b0:51a:ff87:bb1 with SMTP id b26-20020a0565120b9a00b0051aff870bb1mr3936943lfv.9.1713778775894;
        Mon, 22 Apr 2024 02:39:35 -0700 (PDT)
Received: from ?IPV6:2003:cb:c739:600:d2fb:3a8a:9944:7910? (p200300cbc7390600d2fb3a8a99447910.dip0.t-ipconnect.de. [2003:cb:c739:600:d2fb:3a8a:9944:7910])
        by smtp.gmail.com with ESMTPSA id t5-20020ac25485000000b0051b4332d0e3sm224199lfk.100.2024.04.22.02.39.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Apr 2024 02:39:35 -0700 (PDT)
Message-ID: <b70a3d3a-ea8b-4b20-964b-b019c146945a@redhat.com>
Date: Mon, 22 Apr 2024 11:39:33 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC][PATCH] uprobe: support for private hugetlb mappings
To: Guillaume Morin <guillaume@morinfr.org>,
 Mike Kravetz <mike.kravetz@oracle.com>, oleg@redhat.com,
 linux-kernel@vger.kernel.org
References: <ZiK50qob9yl5e0Xz@bender.morinfr.org>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <ZiK50qob9yl5e0Xz@bender.morinfr.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19.04.24 20:37, Guillaume Morin wrote:
> libhugetlbfs, the Intel iodlr code both allow to remap .text onto a
> hugetlb private mapping. It's also pretty easy to do it manually.
> One drawback of using this functionality is the lack of support for
> uprobes (NOTE uprobe ignores shareable vmas)
> 
> This patch adds support for private hugetlb mappings.  It does require exposing
> some hugetlbfs innards and relies on copy_user_large_folio which is only
> available when CONFIG_HUGETLBFS is used so I had to use an ugly #ifdef
> 
> If there is some interest in applying this patch in some form or
> another, I am open to any refactoring suggestions (esp getting rid the
> #ifdef in uprobes.c) . I tried to limit the
> amount of branching.

All that hugetlb special casing .... oh my. What's the benefit why we 
should be interested in making that code less clean -- to phrase it in a 
nice way ;) ?

Yes, libhugetlbfs exists. But why do we have to support uprobes with it? 
Nobody cared until now, why care now?

-- 
Cheers,

David / dhildenb


