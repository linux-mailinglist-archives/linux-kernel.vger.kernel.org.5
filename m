Return-Path: <linux-kernel+bounces-146484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EAC0F8A65DF
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 10:15:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 773E21F245B2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 08:15:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67C76136E28;
	Tue, 16 Apr 2024 08:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JMTA03Gu"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 539281804A
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 08:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713255336; cv=none; b=PO2Fc0nwEMpP5TXWzTUpL6gothQ/gDRprTl7PfQLusFJTJLYO00RXD9sUbZnsuk9QrE8itfkYHWoavyvw6Ra0+N+BaNeCk8JzMW4YqJmz55scNeWcDX70FGUh9vHBARHgTM9+lAn8E9m5Y6Brx/7c9wuKB6schoRPRTIass9EO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713255336; c=relaxed/simple;
	bh=iG3fJOggf9QognphsNX9W7e+fMJ7agckrg+CtnfIPUc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pGURcJhiVnJpyUm73ZYGoBo0mvmb6rtjk3neDfmb4thfWA7IBhG/KXOErySvSvsHsg+e7Gdeh5y0qyCUe0E/og8WTcrvY2yNg/uCGmrpLYw/+MJuPZir/OtqwZxM5My2mMdLdfJWsZJEIXba1ln8KSitJSXEuA9wUqXGAaphVMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JMTA03Gu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713255331;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ylhsG0FsYCEnkq6Q5UDCoJfHLizW/qvS5ooCna1zLXc=;
	b=JMTA03GuXZLv1upVTSP27dYBGIhoPYPiuGYJjYljVSO+SyGXVDQA1HWJjG4yrAsepel+2W
	4JPCpugu+p6Zq8L+060E3VLsKVgE9lvPRUzhwWR9qE5li+WTOdxDAwBXI0+VS4SxHXBYS5
	2kDgXKI/Cz2ROcCQm0GPN3xY5bqgsyk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-461-dEBCo5BcMWmXje-UWki-uA-1; Tue, 16 Apr 2024 04:15:29 -0400
X-MC-Unique: dEBCo5BcMWmXje-UWki-uA-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-416542ed388so13840545e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 01:15:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713255328; x=1713860128;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ylhsG0FsYCEnkq6Q5UDCoJfHLizW/qvS5ooCna1zLXc=;
        b=UiPrlUTvgUdQV6XCJPHArEuDkVJeawNQP/1rqXZPXqqfO0aHSuhHD12pSA/KeCG0MH
         2Nt2Huawpx0EeZQUzLbTurOzKMpLVLHLAMr44v4LHU+svtHyYCmVA9b2vRypefKGktVF
         jgJ1cX0GovDpFGciDkI/e6+4udtA/y5A0G9Nc+mRAUE8VkUXZTxgAlvj64RlOyIkfb2J
         h5h1WeaN4EvrO7ApMcfON9cUA6X9+1qfnuUoh1oP5fi6S8epfqh0BJkydNNOWlEFlM5k
         KJBuhdFCYsohPTUh1+5rB6trL8K8z/fIZBm8YugaDfL+/S53BK8mS8Cj6ZAeOGa6SNtU
         O/eQ==
X-Forwarded-Encrypted: i=1; AJvYcCVJBAKsqtlqJ4KDvLgXxT7O6axQ1NaAFpx6VUaIA0sFKZrJZ3vuiQEo6lUmdMA4Qb/K9oQWcIyO+515iKNOCAkMBUs1AbQHlGeDozeH
X-Gm-Message-State: AOJu0Yw22sMq1fsAbyuNTjGKEMY+3BRCzVNTW37dYA1coXIDAffWczzO
	7C7K+LDhRdVe2rcjQLSqf4QZrMcGpyqXKCdhTywDDGnEjtF440wIHglk0QeFEqlRSBjlS4mxjEo
	g3bVkC6h6G+wzTPBXMg8Zhu+120zuvhvZmZ800N80haTGdCRscDD6uTw58bjvLQ==
X-Received: by 2002:a05:600c:3b98:b0:417:e00c:fdb8 with SMTP id n24-20020a05600c3b9800b00417e00cfdb8mr10477827wms.1.1713255328536;
        Tue, 16 Apr 2024 01:15:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF+LjH7KUuBJU1ZLhK1SGa0HSzysEXGVSsA9jEuhgqvsVikvxLZQbM1MGoDtHlXrYKzczwsoA==
X-Received: by 2002:a05:600c:3b98:b0:417:e00c:fdb8 with SMTP id n24-20020a05600c3b9800b00417e00cfdb8mr10477811wms.1.1713255328150;
        Tue, 16 Apr 2024 01:15:28 -0700 (PDT)
Received: from ?IPV6:2003:cb:c718:6400:7621:b88a:e99e:2fa8? (p200300cbc71864007621b88ae99e2fa8.dip0.t-ipconnect.de. [2003:cb:c718:6400:7621:b88a:e99e:2fa8])
        by smtp.gmail.com with ESMTPSA id x11-20020adfcc0b000000b0034658db39d7sm14166376wrh.8.2024.04.16.01.15.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Apr 2024 01:15:27 -0700 (PDT)
Message-ID: <8802bb10-6d16-48c5-a415-e7320697ceb8@redhat.com>
Date: Tue, 16 Apr 2024 10:15:26 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/4] mm: add docs for per-order mTHP counters and
 transhuge_page ABI
To: Barry Song <21cnbao@gmail.com>, akpm@linux-foundation.org,
 linux-mm@kvack.org
Cc: cerasuolodomenico@gmail.com, chrisl@kernel.org, kasong@tencent.com,
 linux-kernel@vger.kernel.org, peterx@redhat.com, ryan.roberts@arm.com,
 surenb@google.com, v-songbaohua@oppo.com, willy@infradead.org,
 yosryahmed@google.com, yuzhao@google.com, corbet@lwn.net
References: <20240412114858.407208-1-21cnbao@gmail.com>
 <20240412114858.407208-4-21cnbao@gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240412114858.407208-4-21cnbao@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12.04.24 13:48, Barry Song wrote:
> From: Barry Song <v-songbaohua@oppo.com>
> 
> This patch includes documentation for mTHP counters and an ABI file
> for sys-kernel-mm-transparent-hugepage, which appears to have been
> missing for some time.
> 
> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>
> Cc: Chris Li <chrisl@kernel.org>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Domenico Cerasuolo <cerasuolodomenico@gmail.com>
> Cc: Kairui Song <kasong@tencent.com>
> Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
> Cc: Peter Xu <peterx@redhat.com>
> Cc: Ryan Roberts <ryan.roberts@arm.com>
> Cc: Suren Baghdasaryan <surenb@google.com>
> Cc: Yosry Ahmed <yosryahmed@google.com>
> Cc: Yu Zhao <yuzhao@google.com>
> Cc: Jonathan Corbet <corbet@lwn.net>
> ---

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


