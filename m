Return-Path: <linux-kernel+bounces-34650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EDA78385BC
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 03:52:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9BFD7B2378F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 02:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D57A17FE;
	Tue, 23 Jan 2024 02:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="I7RqW4u6"
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D9FF7E9
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 02:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705978287; cv=none; b=r22sgBKrywnH747Zt5pKdF7G7f2W180gvLpC2oQjypYxzECOBosblBvk9OYn1CRIVqWNERiOL3xkzCbrlpeBzHghx8oYNQa1UBi9Cj0la/dnWUDnDNe1+oK80OWl0bdLkq23l3IDplavREmdIgkOuxNnc4M3ywdFV73PRdGieVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705978287; c=relaxed/simple;
	bh=G4ko+WDn+9wTyH8zjBMD//CeTPPYFIno0epIH5KK/gk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XEbnAZ4RcRsy/BAsOIhShw//3Hl3Hnyc7g6ZFHZGxjjBLE/3zi6tKgCHpTl90l1tGyfzU97/jdpKbqDJrJ2HMZiBQ2O2pFD1qamXoiMasd6LJeuLVZiQYySyA5xPcJeS6h3XGg3FBpMw4YjdidSXxxBMS2wWmheVKAlsVBx6fwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=I7RqW4u6; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-6e0df9aa43dso3016920a34.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 18:51:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1705978284; x=1706583084; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F0ibQ4RvPFjMpe1eoTckSq1lEolGNvZR2rp4j16CDEY=;
        b=I7RqW4u6RnN/viQ631rvlC0O8291z8DKQfpBoJXrJiI+Y1CdtrO46SS5qiM1Y9nzdU
         cZOLEbjFr+mNwGxVOZpS+gX0eiZPq+IgkFr1ZnpS9n44FAfrC2YTR/ya5wXeW+TsUKFa
         Y4TWTNfraDvbdpepP+2OJJb38aGhGIY2X1B3Em4niE289BGfZ2sf5YkZM7zRP94hiFkf
         qH1OuYwOrIJFJadGCC7YWmwpRHNNYRVF/j4SnaXOIxsVgXalW5AwV6hh4ICpziUdW23c
         HMfJvUsAcLlxMaZobdefTfWBNHW2hHhqsvLa9OC8DniP9+XrHpBqGgY0Ex+kC5EPTHOC
         NKBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705978284; x=1706583084;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F0ibQ4RvPFjMpe1eoTckSq1lEolGNvZR2rp4j16CDEY=;
        b=teZ7N0eNhkP0AdrUnuKrKEKxwFCsHkhXpVqfodQraxKY50e8STaBX7WH7wf2HWjoH/
         /U8JIV+ZGubzglwQoYMYHBQR3Fb/vL7BtjxGUyOJ6pJEnxgMj5MKix6XohxZPoemy1tC
         pR8uYuXJ+VnKFUfrUftwaEOCirdRQTz7lL3lsbb3Kw0w4wwG04e30GeS+t4Qf61u5Z9N
         7yf0AEhabilf4iSv+OJ6kdq19/4hL157LVNilfKBkm+qzsCfKfPM3S99AG3CGz0G5ct0
         GkIR98hJznCLFNgvYEgCggm3RijJjhGLyynoqR084IofGX6tsabPxNgSCrtmyBHZfrJW
         ivtw==
X-Gm-Message-State: AOJu0YwePYrDSvEv8YQJ0ZX64WWtt2N2lWanwU2ovHj71hHbnfmxsuWk
	oCxLaqmYw2+xDdCIzX8oOgMQIjuUI2rwCKK0aiOU+1ah0Lt03SjSZnsc+XfCKkg=
X-Google-Smtp-Source: AGHT+IGE52Gz24GUs56VfplhYi/ooi487/aHOzJj6ZZ2QKzP2AYiHSVxocx0WD9sJCXfLB8D3QeAbg==
X-Received: by 2002:a05:6358:d3a7:b0:176:53d4:d1a4 with SMTP id mp39-20020a056358d3a700b0017653d4d1a4mr2646584rwb.3.1705978284347;
        Mon, 22 Jan 2024 18:51:24 -0800 (PST)
Received: from [10.254.227.61] ([139.177.225.243])
        by smtp.gmail.com with ESMTPSA id ph16-20020a17090b3bd000b0028e87ce1de0sm10308939pjb.51.2024.01.22.18.51.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jan 2024 18:51:23 -0800 (PST)
Message-ID: <36964450-f45a-4f35-a187-dc493246ef59@bytedance.com>
Date: Tue, 23 Jan 2024 10:51:17 +0800
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
From: Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <ac0ce290-58a7-42b2-a7e4-72e241717c63@suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/1/23 01:13, Vlastimil Babka wrote:
> On 1/19/24 04:53, Chengming Zhou wrote:
>> On 2024/1/19 06:14, Christoph Lameter (Ampere) wrote:
>>> On Thu, 18 Jan 2024, Chengming Zhou wrote:
>>>
>>>> So get_freelist() has two cases to handle: cpu slab and cpu partial list slab.
>>>> The latter is NOT frozen, so need to remove "VM_BUG_ON(!new.frozen)" from it.
>>>
>>> Right so keep the check if it is the former?
>>>
>>
>> Ok, I get it. Maybe like this:
> 
> I think that's just too ugly for a VM_BUG_ON(). I'd just remove the check
> and be done with that.

Ok with me.

> 
> I have a somewhat different point. You reused get_freelist() but in fact
> it's more like freeze_slab(), but that one uses slab_update_freelist() and
> we are under the local_lock so we want the cheaper __slab_update_freelist(),
> which get_freelist() has and I guess that's why you reused that one.

Right, we already have the lock_lock, so reuse get_freelist().

> 
> However get_freelist() also assumes it can return NULL if the freelist is
> empty. If that's possible to happen on the percpu partial list, we should
> not "goto load_freelist;" but rather create a new label above that, above
> the "if (!freelist) {" block that handles the case.
> 
> If that's not possible to happen (needs careful audit) and we have guarantee

Yes, it's not possible for now.

> that slabs on percpu partial list must have non-empty freelist, then we
> probably instead want a new __freeze_slab() variant that is like
> freeze_slab(), but uses __slab_update_freelist() and probably also has
> VM_BUG_ON(!freelist) before returning it?
> 

Instead of introducing another new function, how about still reusing get_freelist()
and VM_BUG_ON(!freelist) after calling it? I feel this is simpler.

Thanks!

