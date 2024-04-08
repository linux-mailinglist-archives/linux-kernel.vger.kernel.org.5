Return-Path: <linux-kernel+bounces-134972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A544989B977
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 09:57:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CEC81F214BA
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 07:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39DC431A66;
	Mon,  8 Apr 2024 07:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gMP4URa2"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67D0529CFB
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 07:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712562895; cv=none; b=Pb2X6iaCKIDsxmeB9dhio8RD+k/lhzOgfGYbYp0CdLkKkZLQrjaYDhRZUmYGML0NlTJ/HHXNVbSFl1whSPqp0zyYYCGXUenoRIc8XwLzYzY6qCcisBL6ktsiPqWvs4jJMwg+Bd1YJPPUVq1zvgKi9shryDvlzgJ76ioWZvkCcw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712562895; c=relaxed/simple;
	bh=W61WEdRo9ubyvu/Bh22ifFW0D1P9ojRuxqC8WMf3CBM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C9RCF11G/pkNAgiN0EVk1uQ6oCFVeCQM2KP+oHKXurPMMJv/ggnK8VROa30K1oikylME5qszq5Nbt8Y+oFQQqYR6YJRbDR0v9ew7gDpYq+PVp/fr2g76ari3TfMiFKXZ9zfRF0cG6oLLCy1hVnV9Ss0MnCYqbnywYpyGgnVexGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gMP4URa2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712562892;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Av8HC519Ys6++R/8aXXRo+XrdQoaVdZAQP9ZW7HHMyg=;
	b=gMP4URa2BAGQUvwqHAG2qf8r7bnBLGbnV0oEXQXYyBAxlksNWcIyWJlnINUDNO7QszhTLE
	fHmnX16MJIszhZhj7c9kduejpTlpS1UkPCVbwehtJ/pbQYIk2gj0dJLjFBhiOSnIdW/sQG
	AewzfO0DHsubzyS3rwECnqt04nk1nIE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-267-8xpBmH5_MiOawrK8AlUoMA-1; Mon, 08 Apr 2024 03:54:50 -0400
X-MC-Unique: 8xpBmH5_MiOawrK8AlUoMA-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-33ec4fb1a83so2072262f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2024 00:54:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712562889; x=1713167689;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Av8HC519Ys6++R/8aXXRo+XrdQoaVdZAQP9ZW7HHMyg=;
        b=BVVUsFJxilH92Onr/LJifZJcQPFdplOi1kLZrcEjWwob2lO2EagcxvsMvymF9HKBXU
         fp6//fcLOHGPt43JZphgIoBpTgU+zY+JdTqOz2QdM0CFlHeRlTSYsS+kygRTfiZFDhxA
         rtjKGhNu/RJwqueUG7/0DUluSo13cbM5rdNNXVSnlPjUUi4gNVbjKWqVOEAuTlnpy65y
         28QNoCIP9c2nldn4YO84HUDVEakaPvqnfiUSP69r34mwW0zGNFO7TcRsM17nS280Ihph
         kOKXql5YiXSYeo0HF/lxBGEOqgriW08wZNUXnbd9nnjlLhui+4cG6cGetBEWavRf6MOd
         ZTpg==
X-Forwarded-Encrypted: i=1; AJvYcCVWCB3WE2KfcdxbyLTfcUv1G2yVPz/KZcbiyUvP4wBvT3tGXKNyv9u/iEhHDxuBlelqbJ35csAUiS9Xh/1S8GumaPtbdMUnTPOdaaeW
X-Gm-Message-State: AOJu0Ywtb3mOCzL2DoNRj32TADkO5DlmIxKxulBVWyi7ajJE7b5ZlJ0m
	acHO8Zju6hpk3Kd8ZpFkz7bI5YD6li1TPHJ6b6V1Ait7ePr8AzxwXXwZgvzqCrnigmbwXUEU2Nc
	JHp8adxQu28gll0NEEcXwXQvZDLQYv/ivyw+K6leHdiYmtdVkVEf6o1Kau4JDAA==
X-Received: by 2002:a5d:5484:0:b0:343:ebd4:35a5 with SMTP id h4-20020a5d5484000000b00343ebd435a5mr4693133wrv.0.1712562889089;
        Mon, 08 Apr 2024 00:54:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHjV8FtUVJ363iRRm1Z0OLMCdZMPuD2ur+UCc8MdlaIbyDe57pyHwaYHXZoi03ijtYgaVqgyA==
X-Received: by 2002:a5d:5484:0:b0:343:ebd4:35a5 with SMTP id h4-20020a5d5484000000b00343ebd435a5mr4693123wrv.0.1712562888713;
        Mon, 08 Apr 2024 00:54:48 -0700 (PDT)
Received: from ?IPV6:2003:cb:c718:1300:9860:66a2:fe4d:c379? (p200300cbc7181300986066a2fe4dc379.dip0.t-ipconnect.de. [2003:cb:c718:1300:9860:66a2:fe4d:c379])
        by smtp.gmail.com with ESMTPSA id r4-20020a5d6944000000b00343b09729easm8346754wrw.69.2024.04.08.00.54.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Apr 2024 00:54:48 -0700 (PDT)
Message-ID: <7aec7b98-db81-4238-bdd6-afb69679f852@redhat.com>
Date: Mon, 8 Apr 2024 09:54:47 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] mm: zswap: calculate limits only when updated
To: Yosry Ahmed <yosryahmed@google.com>, Johannes Weiner <hannes@cmpxchg.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Nhat Pham <nphamcs@gmail.com>,
 Chengming Zhou <chengming.zhou@linux.dev>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20240405053510.1948982-1-yosryahmed@google.com>
 <20240405053510.1948982-3-yosryahmed@google.com>
 <20240405152619.GA866431@cmpxchg.org>
 <CAJD7tkaSCvgs-yKXeAVoW14_LhtCrL3N9hu9xA41GCvz+RvWBw@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <CAJD7tkaSCvgs-yKXeAVoW14_LhtCrL3N9hu9xA41GCvz+RvWBw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 05.04.24 20:43, Yosry Ahmed wrote:
> On Fri, Apr 5, 2024 at 8:26 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
>>
>> On Fri, Apr 05, 2024 at 05:35:07AM +0000, Yosry Ahmed wrote:
>>> Currently, we calculate the zswap global limit, and potentially the
>>> acceptance threshold in the zswap, in pages in the zswap store path.
>>> This is unnecessary because the values rarely change.
>>>
>>> Instead, precalculate the them when the module parameters are updated,
>>> which should be rare. Since we are adding custom handlers for setting
>>> the percentages now, add proper validation that they are <= 100.
>>>
>>> Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
>>> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
>>
>> Nice! Getting that stuff out of the hotpath!
>>
>> Two comments below:
>>
>>> @@ -684,6 +703,43 @@ static int zswap_enabled_param_set(const char *val,
>>>        return ret;
>>>   }
>>>
>>> +static int __zswap_percent_param_set(const char *val,
>>> +                                  const struct kernel_param *kp)
>>> +{
>>> +     unsigned int n;
>>> +     int ret;
>>> +
>>> +     ret = kstrtouint(val, 10, &n);
>>> +     if (ret || n > 100)
>>> +             return -EINVAL;
>>> +
>>> +     return param_set_uint(val, kp);
>>> +}
>>> +
>>> +static int zswap_max_pool_param_set(const char *val,
>>> +                                 const struct kernel_param *kp)
>>> +{
>>> +     int err = __zswap_percent_param_set(val, kp);
>>> +
>>> +     if (!err) {
>>> +             zswap_update_max_pages();
>>> +             zswap_update_accept_thr_pages();
>>> +     }
>>> +
>>> +     return err;
>>> +}
>>> +
>>> +static int zswap_accept_thr_param_set(const char *val,
>>> +                                   const struct kernel_param *kp)
>>> +{
>>> +     int err = __zswap_percent_param_set(val, kp);
>>> +
>>> +     if (!err)
>>> +             zswap_update_accept_thr_pages();
>>> +
>>> +     return err;
>>> +}
>>
>> I think you can keep this simple and just always update both if
>> anything changes for whatever reason. It's an extremely rare event
>> after all. That should cut it from 3 functions to 1.
> 
> Yeah we can also combine both update functions in this case.
> 
>>
>> Note that totalram_pages can also change during memory onlining and
>> offlining. For that you need a memory notifier that also calls that
>> refresh function. It's simple enough, though, check out the code
>> around register_memory_notifier() in drivers/xen/balloon.c.
> 
> Good point, I completely missed this. It seems like totalram_pages can
> actually change from contexts other than memory hotplug as well,
> specifically through adjust_managed_page_count(), and mostly through
> ballooning drivers. Do we trigger the notifiers in this case? I can't
> find such logic.

Things like virtio-balloon never online/offline memory and would never 
call it.

Things like virtio-mem sometimes will online/offline memory and would 
sometimes call it (but not always). Things like the Hyper-V balloon and 
XEN balloon never offline memory, and would only call it when onlining 
memory.

> 
> It seems like in this case the actual amount of memory does not
> change, but the drivers take it away from the system. It makes some
> sense to me that the zswap limits do not change in this case,
> especially that userspace just sets those limits as a percentage of
> total memory. I wouldn't expect userspace to take ballooning into
> account here.
> 

For virtio-mem, it does change ("actual amount of memory"). For 
virtio-balloon, it's tricky. When using virtio-balloon for VM resizing, 
it would similarly change. When using it for pure memory overcommit, it 
depends on whatever the policy in the hypervisor is ... might be that 
under memory pressure that memory is simply given back to the VM.

> However, it would be a behavioral change from today where we always
> rely on totalram_pages(). Also, if userspace happens to change the
> limit when a driver is holding a big chunk of memory away from
> totalram_pages, then the limit would be constantly underestimated.
> 
> I do not have enough familiarity with memory ballooning to know for
> sure if this is okay. How much memory can memory ballooning add/remove
> from totalram_pages(), and is it usually transient or does it stick
> around for a while?
> 
> Also CCing David here.

It can be a lot. Especially with the Hyper-V balloon (but also on 
environments where other forms of memory hotunplug are not supported), 
memory ballooning can be used to unplug memory. So that memory can be 
gone for good and it can end up being quite a lot of memory.

The clean thing to do would be to have a way for other subsystems to get 
notified on any totalram_pages() changes, so they can adjust accordingly.

-- 
Cheers,

David / dhildenb


