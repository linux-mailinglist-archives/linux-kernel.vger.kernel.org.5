Return-Path: <linux-kernel+bounces-30748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A5FE8323E3
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 04:53:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6C711C2345A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 03:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9649E1FD8;
	Fri, 19 Jan 2024 03:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="GzUzYBd+"
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05DDA184E
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 03:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705636401; cv=none; b=BoDlxHZLJEf3kmys53hoO4NJRp0w6CeZCsx/b1BgUevyN2Df0vQh6f85ci6727JHE/9YPeJtxdaooOIOEjz49K2zXsuTnr0s4Azh9z1vhJKZrPu7i5B5DWsZX/I74W+7EhlcxqpLE2egogkHkcfIAGb2P1QX3RtoNX+/ot0n6QM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705636401; c=relaxed/simple;
	bh=aWx0wpjrgEPLkK2IWMjjp4xx+BMTHqUg034HB89LlKE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eM5kr5xi2MTuTDlsEia6C1jo9QmJYDH7Z/c+IKczVcpNt99w+vhKoZszWQRq1m82UBW6kamiQ8pmKTmfMcISm3j0lRahz3JZ/QJoLC1TEWflG8i8ZpkIurDKzt2BCQePQiRF9VDBg9idn/GRl4XFDMeENxanW+vho2FS3FBST2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=GzUzYBd+; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-59927972125so170843eaf.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 19:53:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1705636399; x=1706241199; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GxoT1U8gk6NApziuwmbCdtrtydUDrNAn08O/sRw2V60=;
        b=GzUzYBd+tVsQQff/ZyOeA5Chn98E7CBpQoSIAMY/xCRVyYUNECHXvZfURM9j/mmuX2
         CY74pj0W07T9euJ7KR5YT6HzH7F6WK/niVOhB2GDJz9lO7k6cJy/tbEKtal+rg40Wxxs
         a+SYtaAAps6n6u9map/SLmOuTcJU/R6dLnkHL4zy3q7w88M8QyxSQrpNebK54KXBHZcD
         sybYeCA4qc05N6lCo4H/s3Gznw56UjIZXlKN9PO13+PFvHnKypfI6JZT4fqDR3aqiHXr
         x3quqUfLUebWaXetU21qWDXHAjdLFADcrvzX0Dbz4yOvBBLUMlW7vc5GWyhVNk5H+Tm7
         NdkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705636399; x=1706241199;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GxoT1U8gk6NApziuwmbCdtrtydUDrNAn08O/sRw2V60=;
        b=t3NQEPIkLY0YG1vpZD/EXPlUYKl6Vx8BsahULT/2sLZm9n2X+Wa/IY5pdvsTu6qs0d
         KFvsmpOVyFY7TjlxCDzFDK5xXYo9+pcfJOrGkZtnBGZjnHIuZ53mSs2KKkYRf07xA6Ks
         UOyNsWYkPgkfzU3NSD4a2TID2EI3GJFmGUY8exzPhDei7zIsWmfcTO9eThcC/LoDY2PK
         HySMnRNJAGo9+K4o6gAC34ZiOEOFlynMPh46eQa9K46ZRRHIB8XsbkdcytWzNCSCnaVN
         ecyaT5tqKCf7IEXX+xFMjLoHTEaCQqAID+ubF4nTtsdYAMVofzWjVcvmLXOc4jSZZk6h
         z/ug==
X-Gm-Message-State: AOJu0YzG5LDUnq6A0QcYmw4LboMdQqTyNut8del+vsiZifVuXAubhEvt
	uoT+Omn0wud3vudfToSAcovSiNLYWtnnIDUXV3a+p7sQoR8pxd/ZM/iuA+piwaI=
X-Google-Smtp-Source: AGHT+IHN2GN07QZW5OBpL6BeZIde3k93KSIQdDeCP2Iuv+t5ZG/8NoyDRjDH3OU+/gccq12hDgNxcA==
X-Received: by 2002:a05:6359:b87:b0:174:c9a0:cf99 with SMTP id gf7-20020a0563590b8700b00174c9a0cf99mr1694951rwb.57.1705636398851;
        Thu, 18 Jan 2024 19:53:18 -0800 (PST)
Received: from [10.254.224.1] ([139.177.225.241])
        by smtp.gmail.com with ESMTPSA id pd5-20020a17090b1dc500b0028c5585fb41sm2705415pjb.45.2024.01.18.19.53.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jan 2024 19:53:18 -0800 (PST)
Message-ID: <e81d914b-8718-4dbb-a2d8-d5298fe66d1a@bytedance.com>
Date: Fri, 19 Jan 2024 11:53:12 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] mm/slub: directly load freelist from cpu partial slab
 in the likely case
Content-Language: en-US
To: "Christoph Lameter (Ampere)" <cl@linux.com>
Cc: Hyeonggon Yoo <42.hyeyoo@gmail.com>, Joonsoo Kim
 <iamjoonsoo.kim@lge.com>, Vlastimil Babka <vbabka@suse.cz>,
 Pekka Enberg <penberg@kernel.org>, Andrew Morton
 <akpm@linux-foundation.org>, Roman Gushchin <roman.gushchin@linux.dev>,
 David Rientjes <rientjes@google.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20240117-slab-misc-v1-0-fd1c49ccbe70@bytedance.com>
 <20240117-slab-misc-v1-1-fd1c49ccbe70@bytedance.com>
 <76641777-1918-2b29-b6aa-bda9b5467aa3@gentwo.org>
 <412b8618-0941-4d9d-85df-ee480695e7f7@bytedance.com>
 <a2132c63-99a5-7fa2-9f2a-cccf6b40fe9e@linux.com>
From: Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <a2132c63-99a5-7fa2-9f2a-cccf6b40fe9e@linux.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/1/19 06:14, Christoph Lameter (Ampere) wrote:
> On Thu, 18 Jan 2024, Chengming Zhou wrote:
> 
>> So get_freelist() has two cases to handle: cpu slab and cpu partial list slab.
>> The latter is NOT frozen, so need to remove "VM_BUG_ON(!new.frozen)" from it.
> 
> Right so keep the check if it is the former?
> 

Ok, I get it. Maybe like this:

diff --git a/mm/slub.c b/mm/slub.c
index 2ef88bbf56a3..7fa9dbc2e938 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -3313,7 +3313,7 @@ __update_cpu_freelist_fast(struct kmem_cache *s,
  *
  * If this function returns NULL then the slab has been unfrozen.
  */
-static inline void *get_freelist(struct kmem_cache *s, struct slab *slab)
+static inline void *get_freelist(struct kmem_cache *s, struct slab *slab, int frozen)
 {
        struct slab new;
        unsigned long counters;
@@ -3326,7 +3326,7 @@ static inline void *get_freelist(struct kmem_cache *s, struct slab *slab)
                counters = slab->counters;

                new.counters = counters;
-               VM_BUG_ON(!new.frozen);
+               VM_BUG_ON(frozen && !new.frozen);

                new.inuse = slab->objects;
                new.frozen = freelist != NULL;
@@ -3440,7 +3440,7 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
        if (freelist)
                goto load_freelist;

-       freelist = get_freelist(s, slab);
+       freelist = get_freelist(s, slab, 1);

        if (!freelist) {
                c->slab = NULL;
@@ -3498,18 +3498,19 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,

                slab = slub_percpu_partial(c);
                slub_set_percpu_partial(c, slab);
-               local_unlock_irqrestore(&s->cpu_slab->lock, flags);
-               stat(s, CPU_PARTIAL_ALLOC);

-               if (unlikely(!node_match(slab, node) ||
-                            !pfmemalloc_match(slab, gfpflags))) {
-                       slab->next = NULL;
-                       __put_partials(s, slab);
-                       continue;
+               if (likely(node_match(slab, node) &&
+                          pfmemalloc_match(slab, gfpflags))) {
+                       c->slab = slab;
+                       freelist = get_freelist(s, slab, 0);
+                       stat(s, CPU_PARTIAL_ALLOC);
+                       goto load_freelist;
                }

-               freelist = freeze_slab(s, slab);
-               goto retry_load_slab;
+               local_unlock_irqrestore(&s->cpu_slab->lock, flags);
+
+               slab->next = NULL;
+               __put_partials(s, slab);
        }
 #endif

