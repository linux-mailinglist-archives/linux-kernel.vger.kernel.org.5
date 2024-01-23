Return-Path: <linux-kernel+bounces-34837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EEC4D838824
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 08:42:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 766C31F228C0
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 07:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA44C524DD;
	Tue, 23 Jan 2024 07:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="fkCZcliv"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD7F55E5F
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 07:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705995750; cv=none; b=jlkW95wTQo3rgTfSOep0Ji+4eenpIyRe4pazLULUNbcHosjT+wnqrtDUasRL0xqTSE2OnzG6Z6/J/PaOsdg9HCfQw5RvbWXeVyHlaErA+/31J4V6DApMaKTRL2DUUfSD1OvbAaYsxrCEQVA7q+WskZzLeZ6VVO5bI3b9pN19bTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705995750; c=relaxed/simple;
	bh=JWKLpEnUqbZPxWxBgUXtsoZIxn9SZGbGJYV7gU8Siew=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=RQM5qNGYWFKdbeWZTdT8XKwqGK7Co13DjUiiKFycwkOLfP919VCq8KnNKttDtgMBSTS8ycSu6bjncEbdnXBRtzpngKeGWCorXjl5xC2TP2MMKn3s6l6D3AFlBo2NOWYwFEvhdY82bnlNB9RTWa9vebG7MWNz+hJR+nrhPQfm3Hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=fkCZcliv; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1d76943baafso6715355ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 23:42:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1705995747; x=1706600547; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BK2huOGh+t33JPuoLKMJUqKIMCs44dBRDK1GJoZeQVw=;
        b=fkCZclivyEH5xMZDSd+9Qg02T8bqubD8E9GJXOZt1nh8CFcOxVQKubwjjfaa17X54X
         UgS4FImmiYBKc3SF+j/67uLczz2/R2SJGa9X2+oWJvwzNRhEFZwzZXLVGJc5d3nXosxT
         iItA//pPkV9sVdOu24pfSrxXsZ79+tJasIjiuVX3Q01zKDkGHyQ8JYuSKpLIpZg+YLQj
         JEjlNtPUJR/KetxGFn0cTnsUzztmwml0bEi2VIOLFxBf2dRryIZmRDmiVVehYDWEjAkn
         ENOiVpRJ/wxXJoIroq5UFMFBWWq5ZvP4ZxLuSgNVmzhmL5jSSRV0ascKmUq90BjBJEyi
         SQfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705995747; x=1706600547;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BK2huOGh+t33JPuoLKMJUqKIMCs44dBRDK1GJoZeQVw=;
        b=sWItOtzRf9euNALs5pdroSozq6nt9dH3JYgSUVNM8RkZyqqETW24Mg3jaUyK0YJ6K7
         6dADKhghY0cNRayMLqB0uMyFURrKrEy0AbKPBx+sQH+lsWzOaoWv5cFQ789rLBjaprUd
         +3CgDDDckNErTtclLwLedXrxapd5jQVj9pViaKGTBjrT6Qb8zShScg8QYraw7/oR8tgA
         wdnoBFmv0bTQ5lpM4Sq4EaLKSmTcja1izTkk2FIzds9/3kZoFboPJnjtgUmxTxZQ4BNI
         m5Nbqb9Ao7xUIYLfu15SUEpMyvjtfRiFEPbgxTl9E/0RQU+bqdV4UA6yw+a71eCJhBri
         f6YA==
X-Gm-Message-State: AOJu0YzGDtqm8Mk3Ufd2gU7+LakCo746RjUhFUtnmNxSTeTHcqUujqEK
	O+iGXeOivZioOLiZs409FKeAdDv7vHZsExP7wZYeYwCklIaK2/Xtt1EJUjTFOM4=
X-Google-Smtp-Source: AGHT+IHxb4Zz1UaqZF9UTqtvSFYoUuEyJgTb83dg9wT/SQjaDQYa4BnE+Ec98fgQ1hXH8yfou4pE4w==
X-Received: by 2002:a17:903:22c9:b0:1d6:f139:cc20 with SMTP id y9-20020a17090322c900b001d6f139cc20mr3893200plg.32.1705995747019;
        Mon, 22 Jan 2024 23:42:27 -0800 (PST)
Received: from [10.254.236.83] ([139.177.225.255])
        by smtp.gmail.com with ESMTPSA id h16-20020a170902ac9000b001d76ac29241sm883624plr.59.2024.01.22.23.42.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jan 2024 23:42:26 -0800 (PST)
Message-ID: <78e8ea43-9d22-46ab-82c2-c6883d545772@bytedance.com>
Date: Tue, 23 Jan 2024 15:42:20 +0800
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
From: Chengming Zhou <zhouchengming@bytedance.com>
To: Vlastimil Babka <vbabka@suse.cz>,
 "Christoph Lameter (Ampere)" <cl@linux.com>
Cc: Hyeonggon Yoo <42.hyeyoo@gmail.com>, Joonsoo Kim
 <iamjoonsoo.kim@lge.com>, Pekka Enberg <penberg@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 David Rientjes <rientjes@google.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20240117-slab-misc-v1-0-fd1c49ccbe70@bytedance.com>
 <20240117-slab-misc-v1-1-fd1c49ccbe70@bytedance.com>
 <76641777-1918-2b29-b6aa-bda9b5467aa3@gentwo.org>
 <412b8618-0941-4d9d-85df-ee480695e7f7@bytedance.com>
 <a2132c63-99a5-7fa2-9f2a-cccf6b40fe9e@linux.com>
 <e81d914b-8718-4dbb-a2d8-d5298fe66d1a@bytedance.com>
 <ac0ce290-58a7-42b2-a7e4-72e241717c63@suse.cz>
 <36964450-f45a-4f35-a187-dc493246ef59@bytedance.com>
In-Reply-To: <36964450-f45a-4f35-a187-dc493246ef59@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/1/23 10:51, Chengming Zhou wrote:
> On 2024/1/23 01:13, Vlastimil Babka wrote:
>> On 1/19/24 04:53, Chengming Zhou wrote:
>>> On 2024/1/19 06:14, Christoph Lameter (Ampere) wrote:
>>>> On Thu, 18 Jan 2024, Chengming Zhou wrote:
>>>>
>>>>> So get_freelist() has two cases to handle: cpu slab and cpu partial list slab.
>>>>> The latter is NOT frozen, so need to remove "VM_BUG_ON(!new.frozen)" from it.
>>>>
>>>> Right so keep the check if it is the former?
>>>>
>>>
>>> Ok, I get it. Maybe like this:
>>
>> I think that's just too ugly for a VM_BUG_ON(). I'd just remove the check
>> and be done with that.
> 
> Ok with me.
> 
>>
>> I have a somewhat different point. You reused get_freelist() but in fact
>> it's more like freeze_slab(), but that one uses slab_update_freelist() and
>> we are under the local_lock so we want the cheaper __slab_update_freelist(),
>> which get_freelist() has and I guess that's why you reused that one.
> 
> Right, we already have the lock_lock, so reuse get_freelist().
> 
>>
>> However get_freelist() also assumes it can return NULL if the freelist is
>> empty. If that's possible to happen on the percpu partial list, we should
>> not "goto load_freelist;" but rather create a new label above that, above
>> the "if (!freelist) {" block that handles the case.
>>
>> If that's not possible to happen (needs careful audit) and we have guarantee
> 
> Yes, it's not possible for now.
> 
>> that slabs on percpu partial list must have non-empty freelist, then we
>> probably instead want a new __freeze_slab() variant that is like
>> freeze_slab(), but uses __slab_update_freelist() and probably also has
>> VM_BUG_ON(!freelist) before returning it?
>>
> 
> Instead of introducing another new function, how about still reusing get_freelist()
> and VM_BUG_ON(!freelist) after calling it? I feel this is simpler.
> 
> Thanks!

Does this look fine?

diff --git a/mm/slub.c b/mm/slub.c
index 2ef88bbf56a3..fda402b2d649 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -3326,7 +3326,6 @@ static inline void *get_freelist(struct kmem_cache *s, struct slab *slab)
                counters = slab->counters;

                new.counters = counters;
-               VM_BUG_ON(!new.frozen);

                new.inuse = slab->objects;
                new.frozen = freelist != NULL;
@@ -3498,18 +3497,20 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,

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
+                       freelist = get_freelist(s, slab);
+                       VM_BUG_ON(!freelist);
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


