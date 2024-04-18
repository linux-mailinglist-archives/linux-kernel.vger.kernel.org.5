Return-Path: <linux-kernel+bounces-149934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D78B8A9804
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 12:59:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 810401C210FA
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 10:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6903215EFD7;
	Thu, 18 Apr 2024 10:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="idgauFRn"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC4715E1EE
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 10:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713437907; cv=none; b=hXH8Oo+4PTvYrZNP98uFTOJXAPeF15NVqim+A/ONMKRbWklTsYG6zgEZ/fz6eBqPYXpM20sIUt38QxlFEUbVlbedjlBXGfH5URR5IxZL5MTov9+jPcwmm2/EgR2sVWLBUwijFO4cklwZOU+YMPNddbzDuk3+ExU+4M56hY4GPrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713437907; c=relaxed/simple;
	bh=zTOTkzFe7i6mwVPzvpuFuKg9+co3We1RwHUHZmalDAU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=az3PD3XDqLxGfwxWezSF+9IQrZgRvvky2dUVKTubVB8j/fz3h44c7Ji9jZlu65OW9g0P3s91YXsHrX0HBrPfsizdPl+L061im4KBgu4sUyIJqVV0mBpQcdys0mLLOgENR3JxKtUIMh3/Cm6oDGOCpFRPxO1bdapbYJ705dLStC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=idgauFRn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713437904;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=e3Q519Xd0bzyd5fUjD22zYGmIt9PVitnNvbYLhe3u7U=;
	b=idgauFRn7EpsaMvbQqa3oXqOQW7fDKXH6YYQBOeqUxf5tla3weyR7WD0qDEsEOk3KVlujr
	qLszFzHrRNHTwGvRcELm7Cqlcw0Mc/Hi4W2iSyw7DbKQlyp7mGVHF41kVnVs7iHoLHn0KR
	MYyQusjhMD0U9CebUH18CLqJnvkkfAk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-683-_HFv2Dv0N8qDFyI9qfdjUw-1; Thu, 18 Apr 2024 06:58:23 -0400
X-MC-Unique: _HFv2Dv0N8qDFyI9qfdjUw-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-418a673c191so3654375e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 03:58:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713437902; x=1714042702;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e3Q519Xd0bzyd5fUjD22zYGmIt9PVitnNvbYLhe3u7U=;
        b=aP8quDt544gtloAk7pl4btcngEbYsFq4ewLC75Z4fZZLdNFo0PwYsyxq67FXtHjb80
         MFVgNLn6gAb4fkJSTCNbzoa9GydvumMuF3aWEuRr5e9BlUcJ5QkphXJfXc7J1g0fFkjL
         qwAMEhIfqUnuYWTNXJidN+iLFUieXecwGyngyxpAkBOkFdWCK/c7jFP3ve7MYaAZ6szm
         qpu19hD73TRw48vTDIC23Sw605NZn1hbFAXDPZI9xzz8nGO5BkNINLIJEJ8uiLttdCDD
         PUEy8Zrsw0+cTrzgcOCVQtkyeca43TJVtnRjOsnpOc3qb3E4HTGwHx8M4VCUcYP4kKWP
         v/pg==
X-Forwarded-Encrypted: i=1; AJvYcCXDYV7Z1AHa4KBTXsi84j0J6kMDKtp49xhOQ9NEH//kJlrKVwq2+rOEYWIfrEAJ3M/62hZxXXzr6xcNXmT2XM5i+ddVIDSgbowbbSxs
X-Gm-Message-State: AOJu0Yw+2o5qaVOC2M//RL/gXoT5SFCwyZgQBCJCSFdGNjAxvR+1X/rL
	pP6jXcomiHy4w27QDFL7MzBtPiM3TCAqnnZ/A4pg3o3wJpBlU0ohxXdKr3gng+nh6v1A23VBDTf
	q4D5yzGT1KeFLdpGCS5IGSqT9/c0VQN6LiMN5wfg12fjl/nVBehTbnRhB3b+a9w==
X-Received: by 2002:a05:600c:4fc4:b0:418:a447:a2b4 with SMTP id o4-20020a05600c4fc400b00418a447a2b4mr1650259wmq.3.1713437901872;
        Thu, 18 Apr 2024 03:58:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHw4pLCbR7ff+xkBLCuoZDdCLaBRv2TsxwjXdiRLDkVpmg8putzFIUNFiohJYuquLeWZAhtFA==
X-Received: by 2002:a05:600c:4fc4:b0:418:a447:a2b4 with SMTP id o4-20020a05600c4fc400b00418a447a2b4mr1650242wmq.3.1713437901497;
        Thu, 18 Apr 2024 03:58:21 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id d15-20020a05600c34cf00b0041897c6171dsm6036966wmq.16.2024.04.18.03.58.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Apr 2024 03:58:21 -0700 (PDT)
Message-ID: <02cfd9fb-5481-4ea1-9b43-b1aa24de82d1@redhat.com>
Date: Thu, 18 Apr 2024 12:58:20 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] virtio_balloon: introduce oom-kill invocations
To: zhenwei pi <pizhenwei@bytedance.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, virtualization@lists.linux.dev
Cc: mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
 akpm@linux-foundation.org
References: <20240418062602.1291391-1-pizhenwei@bytedance.com>
 <20240418062602.1291391-2-pizhenwei@bytedance.com>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 xsFNBFXLn5EBEAC+zYvAFJxCBY9Tr1xZgcESmxVNI/0ffzE/ZQOiHJl6mGkmA1R7/uUpiCjJ
 dBrn+lhhOYjjNefFQou6478faXE6o2AhmebqT4KiQoUQFV4R7y1KMEKoSyy8hQaK1umALTdL
 QZLQMzNE74ap+GDK0wnacPQFpcG1AE9RMq3aeErY5tujekBS32jfC/7AnH7I0v1v1TbbK3Gp
 XNeiN4QroO+5qaSr0ID2sz5jtBLRb15RMre27E1ImpaIv2Jw8NJgW0k/D1RyKCwaTsgRdwuK
 Kx/Y91XuSBdz0uOyU/S8kM1+ag0wvsGlpBVxRR/xw/E8M7TEwuCZQArqqTCmkG6HGcXFT0V9
 PXFNNgV5jXMQRwU0O/ztJIQqsE5LsUomE//bLwzj9IVsaQpKDqW6TAPjcdBDPLHvriq7kGjt
 WhVhdl0qEYB8lkBEU7V2Yb+SYhmhpDrti9Fq1EsmhiHSkxJcGREoMK/63r9WLZYI3+4W2rAc
 UucZa4OT27U5ZISjNg3Ev0rxU5UH2/pT4wJCfxwocmqaRr6UYmrtZmND89X0KigoFD/XSeVv
 jwBRNjPAubK9/k5NoRrYqztM9W6sJqrH8+UWZ1Idd/DdmogJh0gNC0+N42Za9yBRURfIdKSb
 B3JfpUqcWwE7vUaYrHG1nw54pLUoPG6sAA7Mehl3nd4pZUALHwARAQABzSREYXZpZCBIaWxk
 ZW5icmFuZCA8ZGF2aWRAcmVkaGF0LmNvbT7CwZgEEwEIAEICGwMGCwkIBwMCBhUIAgkKCwQW
 AgMBAh4BAheAAhkBFiEEG9nKrXNcTDpGDfzKTd4Q9wD/g1oFAl8Ox4kFCRKpKXgACgkQTd4Q
 9wD/g1oHcA//a6Tj7SBNjFNM1iNhWUo1lxAja0lpSodSnB2g4FCZ4R61SBR4l/psBL73xktp
 rDHrx4aSpwkRP6Epu6mLvhlfjmkRG4OynJ5HG1gfv7RJJfnUdUM1z5kdS8JBrOhMJS2c/gPf
 wv1TGRq2XdMPnfY2o0CxRqpcLkx4vBODvJGl2mQyJF/gPepdDfcT8/PY9BJ7FL6Hrq1gnAo4
 3Iv9qV0JiT2wmZciNyYQhmA1V6dyTRiQ4YAc31zOo2IM+xisPzeSHgw3ONY/XhYvfZ9r7W1l
 pNQdc2G+o4Di9NPFHQQhDw3YTRR1opJaTlRDzxYxzU6ZnUUBghxt9cwUWTpfCktkMZiPSDGd
 KgQBjnweV2jw9UOTxjb4LXqDjmSNkjDdQUOU69jGMUXgihvo4zhYcMX8F5gWdRtMR7DzW/YE
 BgVcyxNkMIXoY1aYj6npHYiNQesQlqjU6azjbH70/SXKM5tNRplgW8TNprMDuntdvV9wNkFs
 9TyM02V5aWxFfI42+aivc4KEw69SE9KXwC7FSf5wXzuTot97N9Phj/Z3+jx443jo2NR34XgF
 89cct7wJMjOF7bBefo0fPPZQuIma0Zym71cP61OP/i11ahNye6HGKfxGCOcs5wW9kRQEk8P9
 M/k2wt3mt/fCQnuP/mWutNPt95w9wSsUyATLmtNrwccz63XOwU0EVcufkQEQAOfX3n0g0fZz
 Bgm/S2zF/kxQKCEKP8ID+Vz8sy2GpDvveBq4H2Y34XWsT1zLJdvqPI4af4ZSMxuerWjXbVWb
 T6d4odQIG0fKx4F8NccDqbgHeZRNajXeeJ3R7gAzvWvQNLz4piHrO/B4tf8svmRBL0ZB5P5A
 2uhdwLU3NZuK22zpNn4is87BPWF8HhY0L5fafgDMOqnf4guJVJPYNPhUFzXUbPqOKOkL8ojk
 CXxkOFHAbjstSK5Ca3fKquY3rdX3DNo+EL7FvAiw1mUtS+5GeYE+RMnDCsVFm/C7kY8c2d0G
 NWkB9pJM5+mnIoFNxy7YBcldYATVeOHoY4LyaUWNnAvFYWp08dHWfZo9WCiJMuTfgtH9tc75
 7QanMVdPt6fDK8UUXIBLQ2TWr/sQKE9xtFuEmoQGlE1l6bGaDnnMLcYu+Asp3kDT0w4zYGsx
 5r6XQVRH4+5N6eHZiaeYtFOujp5n+pjBaQK7wUUjDilPQ5QMzIuCL4YjVoylWiBNknvQWBXS
 lQCWmavOT9sttGQXdPCC5ynI+1ymZC1ORZKANLnRAb0NH/UCzcsstw2TAkFnMEbo9Zu9w7Kv
 AxBQXWeXhJI9XQssfrf4Gusdqx8nPEpfOqCtbbwJMATbHyqLt7/oz/5deGuwxgb65pWIzufa
 N7eop7uh+6bezi+rugUI+w6DABEBAAHCwXwEGAEIACYCGwwWIQQb2cqtc1xMOkYN/MpN3hD3
 AP+DWgUCXw7HsgUJEqkpoQAKCRBN3hD3AP+DWrrpD/4qS3dyVRxDcDHIlmguXjC1Q5tZTwNB
 boaBTPHSy/Nksu0eY7x6HfQJ3xajVH32Ms6t1trDQmPx2iP5+7iDsb7OKAb5eOS8h+BEBDeq
 3ecsQDv0fFJOA9ag5O3LLNk+3x3q7e0uo06XMaY7UHS341ozXUUI7wC7iKfoUTv03iO9El5f
 XpNMx/YrIMduZ2+nd9Di7o5+KIwlb2mAB9sTNHdMrXesX8eBL6T9b+MZJk+mZuPxKNVfEQMQ
 a5SxUEADIPQTPNvBewdeI80yeOCrN+Zzwy/Mrx9EPeu59Y5vSJOx/z6OUImD/GhX7Xvkt3kq
 Er5KTrJz3++B6SH9pum9PuoE/k+nntJkNMmQpR4MCBaV/J9gIOPGodDKnjdng+mXliF3Ptu6
 3oxc2RCyGzTlxyMwuc2U5Q7KtUNTdDe8T0uE+9b8BLMVQDDfJjqY0VVqSUwImzTDLX9S4g/8
 kC4HRcclk8hpyhY2jKGluZO0awwTIMgVEzmTyBphDg/Gx7dZU1Xf8HFuE+UZ5UDHDTnwgv7E
 th6RC9+WrhDNspZ9fJjKWRbveQgUFCpe1sa77LAw+XFrKmBHXp9ZVIe90RMe2tRL06BGiRZr
 jPrnvUsUUsjRoRNJjKKA/REq+sAnhkNPPZ/NNMjaZ5b8Tovi8C0tmxiCHaQYqj7G2rgnT0kt
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240418062602.1291391-2-pizhenwei@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 18.04.24 08:26, zhenwei pi wrote:
> When the guest OS runs under critical memory pressure, the guest
> starts to kill processes. A guest monitor agent may scan 'oom_kill'
> from /proc/vmstat, and reports the OOM KILL event. However, the agent
> may be killed and we will loss this critical event(and the later
> events).
> 
> For now we can also grep for magic words in guest kernel log from host
> side. Rather than this unstable way, virtio balloon reports OOM-KILL
> invocations instead.
> 
> Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


