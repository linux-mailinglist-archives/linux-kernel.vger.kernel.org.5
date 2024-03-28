Return-Path: <linux-kernel+bounces-122750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 374E688FC95
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 11:11:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 682B31C2BA26
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 10:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7817A7CF16;
	Thu, 28 Mar 2024 10:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D/L0wk2M"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD4E5F861
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 10:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711620670; cv=none; b=HAPUoyGxRwcf1XW088tx0kNeWK7I1ABWKV/jaXxturX4PRHGlOo5VocQGxb3OIo71xc7tmf9wuxg/PW+j7N9/IPahmw25JIFlAGYVjm2GNtu6nwmoBiOa+pZsZ6isKGcQZtVg89B7eJnrcTpm8Phd2g6TLKWjhupWwZYXgaDmL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711620670; c=relaxed/simple;
	bh=3vZt1aoKt1LYqPcuaOHefSVENxzf3J+XVhFS1S9Vayw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DRgIXNiSZnXHl8azJD+sQAqxxS/+N8vPysMNM0cBxSmm34pDgF8vm6+iUU4NScTxOUZjeVVIEm6rqUvHqS1NdgTQjrEkMfKIMe/BSgJQFA6+kRBWuL9MNcDHPwwG8ZhnzsR3GWoTQ6PBjoQoBG5HAtu7YcWECoWcRrVoBZGgHvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D/L0wk2M; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711620665;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=hLHNuBUsHivnnoXg+gTbcgdr/MWic5w5iJ85B7qcDKo=;
	b=D/L0wk2MkyB0LjwZkWIwor3H4yUh7sLFTcRUW7SpVAiAmtPhJC1cXfg4G18RvH9jYwzvlh
	7ag9A+jC3Dhz9OBCl/Pk3tdjcFOEN3CAzYy9B75l06LBuboWFkHRw76bGD6Y3z88DuBQJg
	DgDcIFhRv8jyZ53yUaXwiqwbcB1QjLA=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-44-IGuLuI7BODGYR2yg9jugXg-1; Thu, 28 Mar 2024 06:11:03 -0400
X-MC-Unique: IGuLuI7BODGYR2yg9jugXg-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-51596f968c1so673130e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 03:11:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711620662; x=1712225462;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hLHNuBUsHivnnoXg+gTbcgdr/MWic5w5iJ85B7qcDKo=;
        b=cauwZZ7jN0IC+WSq2QyA9GLxNrUjwnlRlM4Ib2GNr+w0dKc4cLtq74DT96EyStxCiX
         KNzy7sm7QJm+8feV4tZYD6lcID2dBs+rtzj3+JKxhHQ8yeJ3lIoBeuHdpzzDQ5ZPBXg+
         dd1oWYKNPf9qYvvvGzhrQPXgAKg0ncpS0gE1vyVneZIC5Kjd08TvBwCWH8I0MNX1ZBUX
         S6kjOBlGjpt2q2D8VOCL41o3V5funmvfjT4+lv9zYs8efEphzh8abVLfJ68Mst5hVY/9
         FGwSKlcCkDNWZ/BY8n1LtA+fnPEtEu2UZa9NxguK3c+S/nW6l1DXPp/urfR5v6iRdlkv
         /zqQ==
X-Forwarded-Encrypted: i=1; AJvYcCVTpZkBsxFmnGZKb6w6XZyqLYWvBde9hkoxGD9NwSUnZ+dyVajVpFy7g2oP1o0hmPhhXUejxJgpV150z6F22MAgt9gJLPmWDb9wBNl2
X-Gm-Message-State: AOJu0YyPr5XgOTC21scv2/bR57WTlqfZQ4wNH0ne+91vjzSjjFAg1dqV
	QMEqBuEJnOO3JVtXfJwN3PbW6d/G5vLdPWgZzFfY/IZB9Yx2EODC5a5yGmzOLtHRnD7n9bUFyJK
	xCRaB13YUhML+P1A+ek8JnrfpqcF9izIP2/iKHxRnCMDC5vwcF0CZyfFzbJcggw==
X-Received: by 2002:ac2:44cb:0:b0:513:a8fc:95d7 with SMTP id d11-20020ac244cb000000b00513a8fc95d7mr1360060lfm.38.1711620661946;
        Thu, 28 Mar 2024 03:11:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHHYQU8kxpYM4jVYSDvtGoR0p1IRQOO6x9SQkiA3Zc9ExgaYMDl44yGXybjHsfrkFhFyhcpwA==
X-Received: by 2002:ac2:44cb:0:b0:513:a8fc:95d7 with SMTP id d11-20020ac244cb000000b00513a8fc95d7mr1360023lfm.38.1711620661535;
        Thu, 28 Mar 2024 03:11:01 -0700 (PDT)
Received: from ?IPV6:2003:cb:c714:3600:8033:4189:6bd4:ea29? (p200300cbc7143600803341896bd4ea29.dip0.t-ipconnect.de. [2003:cb:c714:3600:8033:4189:6bd4:ea29])
        by smtp.gmail.com with ESMTPSA id i4-20020adfefc4000000b0033b6e26f0f9sm1344502wrp.42.2024.03.28.03.10.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Mar 2024 03:11:01 -0700 (PDT)
Message-ID: <372a9331-6d95-4083-9a8f-a4f714868bea@redhat.com>
Date: Thu, 28 Mar 2024 11:10:59 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 06/13] mm/gup: Drop folio_fast_pin_allowed() in hugepd
 processing
Content-Language: en-US
To: peterx@redhat.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: Yang Shi <shy828301@gmail.com>, "Kirill A . Shutemov"
 <kirill@shutemov.name>, Mike Kravetz <mike.kravetz@oracle.com>,
 John Hubbard <jhubbard@nvidia.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Andrew Jones <andrew.jones@linux.dev>, Muchun Song <muchun.song@linux.dev>,
 linux-riscv@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Andrew Morton <akpm@linux-foundation.org>,
 Christoph Hellwig <hch@infradead.org>, Lorenzo Stoakes <lstoakes@gmail.com>,
 Matthew Wilcox <willy@infradead.org>, Rik van Riel <riel@surriel.com>,
 linux-arm-kernel@lists.infradead.org, Andrea Arcangeli
 <aarcange@redhat.com>, "Aneesh Kumar K . V" <aneesh.kumar@kernel.org>,
 Vlastimil Babka <vbabka@suse.cz>, James Houghton <jthoughton@google.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Mike Rapoport <rppt@kernel.org>,
 Axel Rasmussen <axelrasmussen@google.com>
References: <20240327152332.950956-1-peterx@redhat.com>
 <20240327152332.950956-7-peterx@redhat.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240327152332.950956-7-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 27.03.24 16:23, peterx@redhat.com wrote:
> From: Peter Xu <peterx@redhat.com>
> 
> Hugepd format for GUP is only used in PowerPC with hugetlbfs.  There are
> some kernel usage of hugepd (can refer to hugepd_populate_kernel() for
> PPC_8XX), however those pages are not candidates for GUP.
> 
> Commit a6e79df92e4a ("mm/gup: disallow FOLL_LONGTERM GUP-fast writing to
> file-backed mappings") added a check to fail gup-fast if there's potential
> risk of violating GUP over writeback file systems.  That should never apply
> to hugepd.  Considering that hugepd is an old format (and even
> software-only), there's no plan to extend hugepd into other file typed
> memories that is prone to the same issue.
> 
> Drop that check, not only because it'll never be true for hugepd per any
> known plan, but also it paves way for reusing the function outside
> fast-gup.
> 
> To make sure we'll still remember this issue just in case hugepd will be
> extended to support non-hugetlbfs memories, add a rich comment above
> gup_huge_pd(), explaining the issue with proper references.
> 
> Cc: Christoph Hellwig <hch@infradead.org>
> Cc: Lorenzo Stoakes <lstoakes@gmail.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: linuxppc-dev@lists.ozlabs.org
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---

@Andrew, you properly adjusted the code to remove the 
gup_fast_folio_allowed() call instead of the folio_fast_pin_allowed() 
call, but

(1) the commit subject
(2) comment for gup_huge_pd()

Still mention folio_fast_pin_allowed().

The patch "mm/gup: handle hugepd for follow_page()" then moves that 
(outdated) comment.

-- 
Cheers,

David / dhildenb


