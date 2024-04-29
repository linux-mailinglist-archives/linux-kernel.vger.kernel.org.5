Return-Path: <linux-kernel+bounces-161843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 74D038B5214
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 09:18:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A9AF280FCB
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 07:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61E7013ADC;
	Mon, 29 Apr 2024 07:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e4n8I8RN"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D4AB10A25
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 07:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714375072; cv=none; b=PLGeDt8pdKPnL9Orp3e4PAjIRF/pAwSaRI2efgrWqHHI6yKVek4bTwBifXxdwTa46LyYcoF6G/Lxjt6dgrxAHcxx15G7rVCLZZZN1qLJnzbGAE5zuVBTGl0VBWm9ZN83rrnJ5Umg7Z4sNokg4KENJS4pTkuwfN5OoNrjmhDoxrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714375072; c=relaxed/simple;
	bh=piSmMd+BBT6XtjS7FO4tbQHOiKSBGV+a5Ukbh2lPdj4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eneFDBAxYf9CKL+aRZEu6PCk7+CKoeuLOtORkyQjbtqMaahXq2X7h1/yx+ESgYXi/ApNmgPUof4ld41RtQkFBIu9MQFoEL5hozcksAa2pDqGfA8mn6mW6JdVXzI2Ec/eoNpiRq8Wb4eUBU9v56mfD5z2UmwJnc2XFO8BbSfjXmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e4n8I8RN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714375069;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=8R0bYgvdXHGuOgg8Irxp1p7AoaJXBAfKNxLRI9tEUYM=;
	b=e4n8I8RNkxP4YN5SQaSQAol0RNTpp8AKpqF7vLP6kdaEom43EpqwJUJnu/CtBANBKVcmp2
	En5hu5lJfc+iISZcGQGG0+CZMWIcL3CONdL8HAAhBNH/O9u8/ThOi5K6o4Q30Xv911P3rj
	u8SKpYArozXzEmfX2sqLTeo5ijqJ6Ds=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-319-jIzNQ-2COLau9x1q5Bbl4A-1; Mon, 29 Apr 2024 03:17:47 -0400
X-MC-Unique: jIzNQ-2COLau9x1q5Bbl4A-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4190b0735d1so17977005e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 00:17:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714375066; x=1714979866;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8R0bYgvdXHGuOgg8Irxp1p7AoaJXBAfKNxLRI9tEUYM=;
        b=n04JFO4caAdY/IWyhRjiwf8e42P9Nt1Uad5WEybyaGSpUhybEX+TTMoFmsbFxnSMiU
         5Xm/qFLSRFEm3C5L05iEd9lamaQeaSzndwpLH3H8WGStZpmN9kEC/bswOxIpPcRE/IVM
         KhFNeZzqUIZSNrw0dkpnKYzJ4X/Y/RU4jHszSJSKUVpQrGv+q3mhjg2pvQ3D/LcPZYhh
         jx9fqRWXBKwA0/SpMxprUfIrQ6KvjDhPeaS3lptIJc5L627AvakecTpWb897DV0jIOQe
         Hx0QXFEmN9qUwCjXLRBdpP/jcvGgKqXZoJL0jjDniMnMCPled+8v+dNUYLx2YhnufpGG
         K6ig==
X-Forwarded-Encrypted: i=1; AJvYcCVIAPUxOxdoBf+Y9jsZ44yHmnfDNDm1HbELSJ1sW5ui4LEUrfrgjeoE5bX2l43Ls+Z6OimXsNMXOkhdPUMi+1fWBNcUSHaSV6o1qCaw
X-Gm-Message-State: AOJu0YzpzZ5N/oGrVWfhev+xU3Y+jIuUTm4IestVnf1mLztTeTtWxV7c
	krQO2Xj2P43x0DaJNqpEFsWUqzthJGcjjzse/EOo7RCwKiluu9F9kxG42yMtffnWcdHN8XPqw0D
	KsJKn0eGTmn1m5cB81j/z26Gex+T46EtWWs7YA9RIc8A06Fxr89Jr01ZK9lXjhQ==
X-Received: by 2002:a05:600c:4e0c:b0:41b:a8e8:3ff6 with SMTP id b12-20020a05600c4e0c00b0041ba8e83ff6mr5832796wmq.11.1714375066099;
        Mon, 29 Apr 2024 00:17:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGnSE2Sb8WwFtIiVRSMOLJxWMw1XCLDHHU16hLTfBU2gmhApAvB6d6mnHHq5nBCkt5asCzqIg==
X-Received: by 2002:a05:600c:4e0c:b0:41b:a8e8:3ff6 with SMTP id b12-20020a05600c4e0c00b0041ba8e83ff6mr5832774wmq.11.1714375065651;
        Mon, 29 Apr 2024 00:17:45 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f26:e700:f1c5:285b:72a5:d8c8? (p200300d82f26e700f1c5285b72a5d8c8.dip0.t-ipconnect.de. [2003:d8:2f26:e700:f1c5:285b:72a5:d8c8])
        by smtp.gmail.com with ESMTPSA id o12-20020a05600c4fcc00b00418a6d62ad0sm44285199wmq.34.2024.04.29.00.17.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Apr 2024 00:17:45 -0700 (PDT)
Message-ID: <19c5b260-fddf-478e-abc5-1c645957b562@redhat.com>
Date: Mon, 29 Apr 2024 09:17:44 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] mm/gup: Fix hugepd handling in hugetlb rework
To: Peter Xu <peterx@redhat.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Aneesh Kumar K . V" <aneesh.kumar@kernel.org>,
 Lorenzo Stoakes <lstoakes@gmail.com>, John Hubbard <jhubbard@nvidia.com>,
 linuxppc-dev@lists.ozlabs.org, Muchun Song <muchun.song@linux.dev>,
 Jason Gunthorpe <jgg@nvidia.com>
References: <20240428190151.201002-1-peterx@redhat.com>
 <20240428190151.201002-2-peterx@redhat.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240428190151.201002-2-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 28.04.24 21:01, Peter Xu wrote:
> Commit a12083d721d7 added hugepd handling for gup-slow, reusing gup-fast
> functions.  follow_hugepd() correctly took the vma pointer in, however
> didn't pass it over into the lower functions, which was overlooked.
> 
> The issue is gup_fast_hugepte() uses the vma pointer to make the correct
> decision on whether an unshare is needed for a FOLL_PIN|FOLL_LONGTERM.  Now
> without vma ponter it will constantly return "true" (needs an unshare) for
> a page cache, even though in the SHARED case it will be wrong to unshare.
> 
> The other problem is, even if an unshare is needed, it now returns 0 rather
> than -EMLINK, which will not trigger a follow up FAULT_FLAG_UNSHARE fault.
> That will need to be fixed too when the unshare is wanted.
> 
> gup_longterm test didn't expose this issue in the past because it didn't
> yet test R/O unshare in this case, another separate patch will enable that
> in future tests.
> 
> Fix it by passing vma correctly to the bottom, rename gup_fast_hugepte()
> back to gup_hugepte() as it is shared between the fast/slow paths, and also
> allow -EMLINK to be returned properly by gup_hugepte() even though gup-fast
> will take it the same as zero.
> 
> Reported-by: David Hildenbrand <david@redhat.com>
> Fixes: a12083d721d7 ("mm/gup: handle hugepd for follow_page()")
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---

LGTM

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


