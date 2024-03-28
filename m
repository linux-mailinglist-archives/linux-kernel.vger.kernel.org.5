Return-Path: <linux-kernel+bounces-119053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A5C5F88C349
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 14:23:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A0972E2268
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 13:23:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B87A574423;
	Tue, 26 Mar 2024 13:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hkAu5fOc"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ECE86D1C1
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 13:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711459424; cv=none; b=pkSZ7RJB/I5NzTjgNjhsj+CIqi9RzO3sctlOSeiaEmCJUZjGFj5a1QLIHX9ZauBYNGW38EHq6kBkR1ASCbHOZyHFutFp+wdhAdl8apbFi9zz8AJT2/C96e9gY5qJ3dPvXcdUErxxMKD0ryV5XwqGmeIjB2JcM8zLYWg781Z8eHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711459424; c=relaxed/simple;
	bh=gzp9HtZPHmUn2IpZTAA5N4ZxIlth75V81YTf8VVwynk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cZS84jI35qnpqSPUEFVorTebiaf9uWEKOFgxLO2qlUFeS7vAYbZbtMvkdmAeaau4tLLHe/tjVm7N6Xii0f2tnrpYgTmznNo3gUuLIvlv0oUEtLsg0n/rviq8AkKNd84X5ooqMSMMtnsebQubTicGQvd0L3AjcmmBLpj/8ZFqkw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hkAu5fOc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711459422;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=l+N09hIgKxgAU9tA6LuUWkFZXIuGJhEsplZapeNz2CQ=;
	b=hkAu5fOc4EzkLnVLVJ86rs5wXhEsaC5D5BVrpcugqi91id+zMzlrzMVlcGGAQghO/+m6zC
	reM+ofnoSyTGiseU2RzXndd8u7i59fqW6nUSlGhXeJ4g8OVOxz9uOj22qAVQ0Ao2b03Y01
	4uzDGBplDQUjrMG7liTaWcNxEStQ8E8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-78-T5obnZAPOQee77Y1iDYaLA-1; Tue, 26 Mar 2024 09:23:40 -0400
X-MC-Unique: T5obnZAPOQee77Y1iDYaLA-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-33ece03ca5dso3911405f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 06:23:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711459419; x=1712064219;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l+N09hIgKxgAU9tA6LuUWkFZXIuGJhEsplZapeNz2CQ=;
        b=Cy4KLhiSJC0rvDyxOTjijGzjATj7Y7Ud7S2u4FER9WDkaFFWuNapdq0QpCvPdoFjy7
         7yMsxI0cdHfs/yShnifQs7Z5qkqlaazI29GqI+MoFzj8zvBP2YCRonXmOevc7qhboJ/n
         MgeOc0MR/Ds/Fg4ebpevRvkXlHph2LSW7U0Y9YrREUuHajfK5GAIKonvANPB299TB3Yi
         XZ578iGnc4If7AB/jZfAQcbFyWSnqcj2L6t/qqO6Ad71khHa/9HdiuUG1LtdcMQsXfTQ
         o5fGjdcdrtV+klK0oYWcFK8cH3+huIBvXXBEouQoFlntlCIWNyD+x7UI7yt3fY5a4trJ
         Qemw==
X-Gm-Message-State: AOJu0Yzb+Ha1fSV+VGW+TPyKPMJ1/n5XIz9R9mQUmsdgRoFJgpXpoMKy
	Qt7c/iCLrJWau0Qaypdckq1Xi88Xv/u4k1idIVIHVX/WqV8oxwT7KkXhzdhHPnpvQHKmx+IpIYZ
	z01rbm18+HUDJOab5Eo2IVL0Tmyp6mOU47QtFciC7BlCtZNdGTUx3PGi1nHS2Kw==
X-Received: by 2002:adf:e405:0:b0:33d:755c:30db with SMTP id g5-20020adfe405000000b0033d755c30dbmr7322434wrm.36.1711459419311;
        Tue, 26 Mar 2024 06:23:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGoCR56iaBXoWbXZUgwkU4y9u+YQ7V/iwZa+zZdgoQ4Tb6TodyARqqHsg3B+94V1uu6z3OTUw==
X-Received: by 2002:adf:e405:0:b0:33d:755c:30db with SMTP id g5-20020adfe405000000b0033d755c30dbmr7322411wrm.36.1711459418903;
        Tue, 26 Mar 2024 06:23:38 -0700 (PDT)
Received: from ?IPV6:2003:cb:c741:c700:3db9:94c9:28b0:34f2? (p200300cbc741c7003db994c928b034f2.dip0.t-ipconnect.de. [2003:cb:c741:c700:3db9:94c9:28b0:34f2])
        by smtp.gmail.com with ESMTPSA id o20-20020a5d58d4000000b0033e7503ce7esm12153734wrf.46.2024.03.26.06.23.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Mar 2024 06:23:38 -0700 (PDT)
Message-ID: <414cb2da-52c1-4f4f-9dcf-986f7aaccb0a@redhat.com>
Date: Tue, 26 Mar 2024 14:23:37 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/3] mm/secretmem: fix GUP-fast succeeding on secretmem
 folios
Content-Language: en-US
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Mike Rapoport <rppt@kernel.org>, Miklos Szeredi <mszeredi@redhat.com>,
 Lorenzo Stoakes <lstoakes@gmail.com>, xingwei lee <xrivendell7@gmail.com>,
 yue sun <samsun1006219@gmail.com>, Miklos Szeredi <miklos@szeredi.hu>,
 stable@vger.kernel.org
References: <20240325134114.257544-1-david@redhat.com>
 <20240325134114.257544-2-david@redhat.com>
 <20240325113043.4fb05ab324e5c21ec4c0c0d4@linux-foundation.org>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240325113043.4fb05ab324e5c21ec4c0c0d4@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 25.03.24 19:30, Andrew Morton wrote:
> On Mon, 25 Mar 2024 14:41:12 +0100 David Hildenbrand <david@redhat.com> wrote:
> 
>> folio_is_secretmem() states that secretmem folios cannot be LRU folios:
>> so we may only exit early if we find an LRU folio. Yet, we exit early if
>> we find a folio that is not a secretmem folio.
>>
>> ...
>>
>> Cc: <stable@vger.kernel.org>
> 
> Thanks, I split up this series.  Because this patch goes
> mm-hotfixes-unstable -> mm-hotfixes-stable -> mainline whereas the
> other two go mm-unstable -> mm-stable -> mainline at a later time.

Makes sense. I'll resend a v2 later, because there are some major 
changes (the fix was wrong/incomplete, we have to remove the LRU test 
completely).

-- 
Cheers,

David / dhildenb


