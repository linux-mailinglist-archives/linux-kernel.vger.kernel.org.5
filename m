Return-Path: <linux-kernel+bounces-66070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8BD885563A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 23:40:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4FA59B25EE6
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 22:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB983126F3B;
	Wed, 14 Feb 2024 22:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a/kGo7mB"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F7278662D
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 22:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707950429; cv=none; b=oP1kBNbjMnLrE0RGj4PV9kDD35NmMDwgqk0QMVLpI2rH5uk9Jb+9dLmbDPcOHmwcrj0vSLOMTwF2oM7YBWGmtC7X1cQQqLk+bfMH9mZ7tvlBf4RuECb2QkIwr/5om7jdA+voSYdyZE6HA8TtbJhLmnUxGrsM16Y2bsepwXruvas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707950429; c=relaxed/simple;
	bh=upA9tJ3GC7rj0FK1TdY7IG6EAXSdXrj4LknP25+XJeo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JXWfb2cCsl0bgr9zqHI2Y52YESOusKNbO45fQ6QA1Ihay7pE0tNZMpqTtt+m/1F55O2FPdQRPbaDITrUJR2XKsPl7W1/W86xN2k1rY3YlcuU0v2YT2h+oDfwy2taoloN2WcOZyTUq6nQUxMz4YRpWoKpAORxxnp1KNbXrtZjCY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a/kGo7mB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707950427;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=WN/1wnCbyZpZRJItW2gMIOPbx328LkZgbs4KqytUNcM=;
	b=a/kGo7mBpHn2FS0aTMzD6AHQ7J3JS781U5iixLDExmR1VCDQ8/w2fL521TeiCeLqXtwoof
	1oRZK4XHa4a6zBDpZ5TN+k07rY6wA/cJOyaBLTzzg0o1p9tnluR7P7rC4H6pro7Oc9mgJi
	Pfui9BlUkTtLmcYpyLy4M6J4e5vWzpo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-695-VpMmLAWDNwyxlvbZBGbAbw-1; Wed, 14 Feb 2024 17:40:25 -0500
X-MC-Unique: VpMmLAWDNwyxlvbZBGbAbw-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4120a19da9dso1074195e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 14:40:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707950424; x=1708555224;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WN/1wnCbyZpZRJItW2gMIOPbx328LkZgbs4KqytUNcM=;
        b=bx2FlyBrCMjAd+B7uOkMLDaWuaINr4AAgbWcz/u28Q67UZIt69MrqhOhK1WS+MeBHj
         mgQDxrMgTHfcPkHUJn/qnLD/NIpBfTbRnlx1EQKhplMdmnTgxNXuKEiij2awAwjfhJ/8
         khCuxB/oqDEWjKxXSPHIgGYfQzNc2YHeCd3qa0uqlDW5m3RCCHlCdQbMCMAgw1ptS4A9
         VqJfHkFy+VeVEeQw9eAwWX8p/KB6UcSnqP/B1rnWRavn8lPFexbpURE/b1qRPcn1lciw
         lAGn5QWZqga6HrHjGG0hs/X+gdU/JNLYmS8nQ1xwUbcj5w47unqwSWuMBZmV88d3XIKW
         TRWg==
X-Gm-Message-State: AOJu0YzqvFXIlJGuxBR5TbHiwzo16nNd3kjTAAyLDHknbb5hQIp4vH+k
	HiFF3s3R4XI5RLYp4WuCxgda7uIY1v7llwFTLVciXsAx8HA324t27o2YNK0RQVEkCKf9RoZfE5a
	bDv0i2JMRaLjD78IMOb8TquayW/45Zb8hY+IWzLrUK3KKnhPqv77SNenlOJR2qfDw6RQrp/hxh4
	QfvgQuPzJ71CjiDPL3vGXEGAzHKTxuQVjd/YS7rWlyVA==
X-Received: by 2002:a05:600c:2805:b0:411:a5f9:26f5 with SMTP id m5-20020a05600c280500b00411a5f926f5mr10977wmb.38.1707950424370;
        Wed, 14 Feb 2024 14:40:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFJPxLWaIZx311unv4D5LeFL6QRVjrs/qethDlI9UQEHWlU/k8z7sxXPYEJCZWf9jK5YYpPQQ==
X-Received: by 2002:a05:600c:2805:b0:411:a5f9:26f5 with SMTP id m5-20020a05600c280500b00411a5f926f5mr10943wmb.38.1707950423914;
        Wed, 14 Feb 2024 14:40:23 -0800 (PST)
Received: from ?IPV6:2003:d8:2f3c:3f00:7177:eb0c:d3d2:4b0e? (p200300d82f3c3f007177eb0cd3d24b0e.dip0.t-ipconnect.de. [2003:d8:2f3c:3f00:7177:eb0c:d3d2:4b0e])
        by smtp.gmail.com with ESMTPSA id w12-20020a05600c474c00b00410232ffb2csm43012wmo.25.2024.02.14.14.40.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Feb 2024 14:40:23 -0800 (PST)
Message-ID: <13f296b8-e882-47fd-b939-c2141dc28717@redhat.com>
Date: Wed, 14 Feb 2024 23:40:22 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 12/15] mm/memory: pass PTE to copy_present_pte()
Content-Language: en-US
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
 Matthew Wilcox <willy@infradead.org>, Ryan Roberts <ryan.roberts@arm.com>,
 Russell King <linux@armlinux.org.uk>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Dinh Nguyen <dinguyen@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
 "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, "David S. Miller"
 <davem@davemloft.net>, linux-arm-kernel@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org, sparclinux@vger.kernel.org
References: <20240129124649.189745-1-david@redhat.com>
 <20240129124649.189745-13-david@redhat.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240129124649.189745-13-david@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 29.01.24 13:46, David Hildenbrand wrote:
> We already read it, let's just forward it.
> 
> This patch is based on work by Ryan Roberts.
> 
> Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>   mm/memory.c | 7 +++----
>   1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/memory.c b/mm/memory.c
> index a3bdb25f4c8d..41b24da5be38 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -959,10 +959,9 @@ static inline void __copy_present_pte(struct vm_area_struct *dst_vma,
>    */
>   static inline int
>   copy_present_pte(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
> -		 pte_t *dst_pte, pte_t *src_pte, unsigned long addr, int *rss,
> -		 struct folio **prealloc)
> +		 pte_t *dst_pte, pte_t *src_pte, pte_t pte, unsigned long addr,
> +		 int *rss, struct folio **prealloc)
>   {
> -	pte_t pte = ptep_get(src_pte);
>   	struct page *page;
>   	struct folio *folio;
>   
> @@ -1103,7 +1102,7 @@ copy_pte_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
>   		}
>   		/* copy_present_pte() will clear `*prealloc' if consumed */
>   		ret = copy_present_pte(dst_vma, src_vma, dst_pte, src_pte,
> -				       addr, rss, &prealloc);
> +				       ptent, addr, rss, &prealloc);
>   		/*
>   		 * If we need a pre-allocated page for this pte, drop the
>   		 * locks, allocate, and try again.

The following fixup for that device-exclusive thingy on top (fixing a hmm
selftest I just discovered to be broken).


 From 8f9e44f25087dc71890b8d9bd680375691232e85 Mon Sep 17 00:00:00 2001
From: David Hildenbrand <david@redhat.com>
Date: Wed, 14 Feb 2024 23:09:29 +0100
Subject: [PATCH] fixup: mm/memory: pass PTE to copy_present_pte()

For device-exclusive nonswp entries (is_device_exclusive_entry()),
copy_nonpresent_pte() can turn the PTEs into actual present PTEs while
holding the page table lock.

We hae to re-read the PTE after that operation, such that we won't be
working on the stale non-present PTE, assuming it would be present.

This fixes the hmm "exclusive_cow" selftest.

  ./run_vmtests.sh -t hmm
  # #  RUN           hmm.hmm_device_private.exclusive_cow ...
  # #            OK  hmm.hmm_device_private.exclusive_cow
  # ok 23 hmm.hmm_device_private.exclusive_cow

Signed-off-by: David Hildenbrand <david@redhat.com>
---
  mm/memory.c | 2 ++
  1 file changed, 2 insertions(+)

diff --git a/mm/memory.c b/mm/memory.c
index 3b8e56eb08a3..29a75f38df7c 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1208,6 +1208,8 @@ copy_pte_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
  				progress += 8;
  				continue;
  			}
+			ptent = ptep_get(src_pte);
+			VM_WARN_ON_ONCE(!pte_present(ptent));
  
  			/*
  			 * Device exclusive entry restored, continue by copying
-- 
2.43.0


-- 
Cheers,

David / dhildenb


