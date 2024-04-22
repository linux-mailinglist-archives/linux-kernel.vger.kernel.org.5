Return-Path: <linux-kernel+bounces-152926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A18568AC63A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 10:04:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3228CB20D2B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 08:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C39884E1CE;
	Mon, 22 Apr 2024 08:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="B4OMW+gZ"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADD864D58A
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 08:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713773050; cv=none; b=I9ugQnrZ6/iS5/AbLb9SFuQ7FCEUvB05NSzM1RRiMdN+tu3R1ofqOIICgoWRbfqIQw10+jb8os/orN/5IiPcTe6zxUgNIxhksWc5XDsL0I6zetsxkrJK1UAXOk3G1y8+j79zYNwgarnsPu8MWrXJyv03tHqnjDgH3Wd9+EIZTA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713773050; c=relaxed/simple;
	bh=Ft0UmClN6RCBfY+eiYChyiMKhrK/KxVHCaG8g5v3cME=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mFlzRe5Kj41vVx+rXZeUuQsI8AQub8U/2UXjej2hfza1cM+9t1YKl6L2kqHePEMvIumLwwkTFEGWcxDFk9erpE80yI/ZEiZKvb4IqsMoNImX6h6q0rM4H1FNtapgD5a6mxLYXXVVFdqij20oOj1h37Hranyrbg+4klzxG4Ll6q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=B4OMW+gZ; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-5c6bd3100fcso2348007a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 01:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1713773048; x=1714377848; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jxIY4mlELkDh2GdwIVzSWRDbRXxeN/G/HA7ttNCrEzA=;
        b=B4OMW+gZxaQ/dZwItGhmDzVTO3m3EqoNNUhHerHfs3/jOyLbQYtCmAr8q4Bt6caBwl
         gmK6CQe68TCPOmKbFMAXpOqJrpioIeatTOJTisbqYcT3qtRtfIhrZFLeuWBJ4nq9D9P6
         234Ak5ikaONNvos3HBeKRxwPWs+nBcGUYdhLL2BhRyZiH2CJozP/8o5i5KL7lvECI6jd
         MQ1JRJ70wYlG9jbP2mSRZsnLs6p94mdXrHW6afNjCDjjTkgjXfrUxyHym0oQK8w62oiu
         zSQfoccaUmyD6AwI/hFgjNBY18mFY7An3BMEkExFFmQn1UN/giU95zW4ydWpCoLp0WnY
         iiGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713773048; x=1714377848;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jxIY4mlELkDh2GdwIVzSWRDbRXxeN/G/HA7ttNCrEzA=;
        b=MpvtBD9JafRdacF2at+NtYZAkiAk+QfrZgI7uzC3aHqrL56FitM4DFwPk/0mtR4Zux
         hY3K5cKe0zoX0k3H2XM76HmdoKvorE76uufFpmQ5J3Gxjn7P+yYmp/O5cb3GtsBWM1U3
         82/pFeM89uqNuNAdKKK3SYOOgvL9KQ+gLof3gEn1W5SIb6sOvCEDBO2ukZPjQo4nLoMY
         ONxf/FzGrbW17LbORFjyKX7EpSXJcgs3SesiFoAGhW+Swh+ovBqq1+LTFjlQ9N0hczch
         5JNQftipoNAXfClyo7AY4p4pkhFCrGyFZ68NNtoiogf87p5FDwvQ/Sxrq7Awy9aOpNf/
         6NzA==
X-Forwarded-Encrypted: i=1; AJvYcCWa2NLJHWQXX3RmnqmeFyeg29/F/swFzCevJG+nB4rqOzDXnRArRQUuhLjPEh2Ck+sX/W64m7qvHtZDx6iy3G5Ybna/90Q9veBF3qEN
X-Gm-Message-State: AOJu0YzbgkKOjwI537AIpmy9RP7dcQdF/sRwz5zZNbAolR5cvdGT117N
	CSvx3r2xxnfaYKtbN4QiqQY68krMIVmbXkWBUxLgAR+SskOA9yxmmXE7yCKbdDQ=
X-Google-Smtp-Source: AGHT+IFL0Rf3zkoXQFjWYIOXV3r1BoXk390Ly+Mv2Fk8sW4e8qQRWGncvCiivj8SXzXosAJVSi3mow==
X-Received: by 2002:a05:6a20:96db:b0:1a9:5e63:501b with SMTP id hq27-20020a056a2096db00b001a95e63501bmr7600090pzc.44.1713773047975;
        Mon, 22 Apr 2024 01:04:07 -0700 (PDT)
Received: from [10.3.43.196] ([61.213.176.14])
        by smtp.gmail.com with ESMTPSA id t10-20020a170902e84a00b001e5a5ea5287sm7483531plg.208.2024.04.22.01.04.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Apr 2024 01:04:07 -0700 (PDT)
Message-ID: <537ac244-74b2-42ad-97a7-475ec27f2134@bytedance.com>
Date: Mon, 22 Apr 2024 16:04:03 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Re: [PATCH v2 1/4] virtio_balloon: separate vm events into a
 function
To: David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, virtualization@lists.linux.dev
Cc: mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
 akpm@linux-foundation.org
References: <20240422074254.1440457-1-pizhenwei@bytedance.com>
 <20240422074254.1440457-2-pizhenwei@bytedance.com>
 <6a182645-1f7f-4b7d-a16a-36e9b1684c58@redhat.com>
Content-Language: en-US
From: zhenwei pi <pizhenwei@bytedance.com>
In-Reply-To: <6a182645-1f7f-4b7d-a16a-36e9b1684c58@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 4/22/24 15:47, David Hildenbrand wrote:
> On 22.04.24 09:42, zhenwei pi wrote:
>> All the VM events related statistics have dependence on
>> 'CONFIG_VM_EVENT_COUNTERS', once any stack variable is required by any
>> VM events in future, we would have codes like:
>>   #ifdef CONFIG_VM_EVENT_COUNTERS
>>        unsigned long foo;
>>   #endif
>>        ...
>>   #ifdef CONFIG_VM_EVENT_COUNTERS
>>        foo = events[XXX] + events[YYY];
>>        update_stat(vb, idx++, VIRTIO_BALLOON_S_XXX, foo);
>>   #endif
>>
>> Separate vm events into a single function, also remove
> 
> Why not simply use __maybe_unused for that variable?
> 

1>
static unsigned int update_balloon_stats()
{
     unsigned __maybe_unused long foo;

     ...
#ifdef CONFIG_VM_EVENT_COUNTERS
     foo = events[XXX] + events[YYY];
     update_stat(vb, idx++, VIRTIO_BALLOON_S_XXX, foo);
#endif
}

2>
static inline unsigned int update_balloon_vm_stats()
{
#ifdef CONFIG_VM_EVENT_COUNTERS
     unsigned long foo;

     foo = events[XXX] + events[YYY];
     update_stat(vb, idx++, VIRTIO_BALLOON_S_XXX, foo);
#endif
}

 From the point of my view, I don't need to compile code in my brain 
when reading codes for case 2. :)

-- 
zhenwei pi

