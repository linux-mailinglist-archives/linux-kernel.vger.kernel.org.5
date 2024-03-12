Return-Path: <linux-kernel+bounces-100496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D341879894
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 17:11:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FA6A1C21696
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 16:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 892CB7D41F;
	Tue, 12 Mar 2024 16:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VUvroWiN"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B139D7D071
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 16:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710259838; cv=none; b=u2ua941LOta3hv7ip2USYQWrIiyDsoZWwV8TRWmBcC+4o2JcF5euVO5fFiZCexQtG6ZcCYsqk6sxMkYFq820MGlZ1H3Sj7e+hbTYtmnBYHZDlzVnVwIDdwZ8bLu+ld/PpXs3aFb0Gk/2t61BYRJfCFxJV71JK2vh+s+YTOHlJH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710259838; c=relaxed/simple;
	bh=Xin2BNfp+1GFjzXov7nfhyb64jGMW92ZD82o5arevvI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X19n4/akbsn8pCDZ3Vxp88+qTiB1sRcd9ReR5xHKldpHWfxGHnE66nXk5zoimVSgDx2SgBp0UfGqYRzvyWN8XtiIGtSqorou/xGdFN1faMVE6t6gnkFFEYP/GFzelRBqkx7e5zyBtNQn1F19xgFZJIFtpQ9+nBnEMlHfcl3ywGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VUvroWiN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710259835;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ImrxqmDUR8l6fpVD0DMxxCsB0mCaYWEH2Q4v2duRTKw=;
	b=VUvroWiNOYSF6Vdlt+XxrNjfF/DcoU9AkUIBF5K0MyPZP6cljYc8fedUsRYSrcqGH+w/zz
	lmJv18XRTUQLBNv2yV033ALGKqsswiU5ylFVOPGpCTzwX9SGh7ltIuHNndQnem/o7iJ/tL
	xucfCKdxSqzQi1bn6FMh9/FiNY+OkFE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-324-AlIGr721M9mUCsL4FmJnDg-1; Tue, 12 Mar 2024 12:10:33 -0400
X-MC-Unique: AlIGr721M9mUCsL4FmJnDg-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-412fb99c892so582315e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 09:10:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710259832; x=1710864632;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ImrxqmDUR8l6fpVD0DMxxCsB0mCaYWEH2Q4v2duRTKw=;
        b=SSh1ATtiLTP4pRuwwUDnm+dBiG5yQFq1o++OJYdhepHXx88c8dVGNctEfxVBfh972r
         UQHYIJDG6MT1axg3gQqnXGBgCZYGVtExBGOOZ8H8ZGQrLWR3lC+Brf+2FsjpDqp5keN0
         cgh6VN8gLZPTbCk9rmWB2ZxAJ0J2y0Y4Y8Q7z53R91I46bd28/YLNCoVUv57K6aRwxtz
         nixJVf7gIqwxgvln67eOyjHs5mizz9Vysm2U8NHRiyzsb3FMhPiB/dVK+8Dxb/9yz/LP
         bqei0bP4F5780AFkQjxq/m562BxSEYIoEh5PPgv37IBuMYzJ9d3Ju2Z8oq0ua2YDjfnX
         sB6A==
X-Forwarded-Encrypted: i=1; AJvYcCXr6jyogXybobUXM4k5hWZc7WjkuYMSS27CxHZTm1yQ0HNaEBQ/8K7fpkOrHl5dHLnWImlY+YwQiVuDBFLmblkp8tASdM7/+H1GNOl8
X-Gm-Message-State: AOJu0Yy87sAiYUpiOItFdSGhFr4DhhDCOrOPunA8HaGxf13MI4cweOm1
	kHA/TXr/T2Ri29CQi3VE/RoII+CoVwsLFWmwfqP0vYDNeRDjGGrHjXloUlylMafvJxJkSOhY/uV
	33dxPzpbOpgKz0Y6cltFUxmPomOhF1AGKo9R/2qq/9tuceWZzgiCf0taOAioLtvthEkoR0A==
X-Received: by 2002:a05:600c:b8a:b0:413:e69f:e52b with SMTP id fl10-20020a05600c0b8a00b00413e69fe52bmr39689wmb.2.1710259832676;
        Tue, 12 Mar 2024 09:10:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHBa6B5qWxK1iohynqXZubqORyNA9XAJ3s168g8XNdnEYTmjPfSj366zFNWIUNULqzFvMEZOQ==
X-Received: by 2002:a05:600c:b8a:b0:413:e69f:e52b with SMTP id fl10-20020a05600c0b8a00b00413e69fe52bmr39669wmb.2.1710259832198;
        Tue, 12 Mar 2024 09:10:32 -0700 (PDT)
Received: from [192.168.3.108] (p4ff23be3.dip0.t-ipconnect.de. [79.242.59.227])
        by smtp.gmail.com with ESMTPSA id fs20-20020a05600c3f9400b004132b1385aesm6178849wmb.15.2024.03.12.09.10.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Mar 2024 09:10:31 -0700 (PDT)
Message-ID: <58fbe42a-3051-46bf-a3f9-d59da28a9cd7@redhat.com>
Date: Tue, 12 Mar 2024 17:10:30 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/15] Fast kernel headers: split linux/mm.h
Content-Language: en-US
To: Max Kellermann <max.kellermann@ionos.com>, akpm@linux-foundation.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: willy@infradead.org, sfr@canb.auug.org.au
References: <20240312094133.2084996-1-max.kellermann@ionos.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240312094133.2084996-1-max.kellermann@ionos.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12.03.24 10:41, Max Kellermann wrote:
> This patch set aims to clean up the linux/mm.h header and reduce
> dependencies on it by moving parts out.
> 
> The goal was to eliminate dependencies on linux/mm.h from other
> popular headers such as highmem.h and dma-mapping.h, and I started by
> checking which symbols were really used and moved those declarations
> to separate slim headers.
> 

[...]

>   include/linux/mm.h                            | 583 +-----------------
>   include/linux/mm/devmap_managed.h             |  37 ++
>   include/linux/mm/folio_next.h                 |  27 +

Isn't that a bit excessive? Do we really need that many folio headers?

-- 
Cheers,

David / dhildenb


