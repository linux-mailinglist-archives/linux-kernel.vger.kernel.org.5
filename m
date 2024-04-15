Return-Path: <linux-kernel+bounces-145412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C866E8A55DF
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 17:02:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FD871F2308C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 15:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B45776044;
	Mon, 15 Apr 2024 15:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d5wajOPE"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03A211D524
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 15:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713193319; cv=none; b=fRQSsnPHoFNyYFEsG4Ib+KYCsByckLe7GeGlGoV6NrgqliJUhSAdWv1uGrudfdz0kb3E6z2UkPmz3XgMCCIMb2ZlgvlDAj/BERjSFN5tkz2C9ArX8SKvvdPqD4ScHBICeUHpuox6/AR/oKNs8zT8DkDnuUu5PgG8Ae0ndKoXKOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713193319; c=relaxed/simple;
	bh=sIiFyXwqbhaN2h69y2E+rbEJLjROIneYsPH1WX9xh84=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E6iU4c5cSd7HJ52f3rikXNosrCT0+k1k7of8W2rX5djCQ2KXiKecCUlYtPVDkWrOaRI9rZHyfLWf7LwRKieFQFqYoZxC07aWqA8gb347TZWCSfs+bx8qRM0GcvPClB2YeiWD0GX7rEjiNrdb1SLKjqqut9gamjrakP7uMln2Qkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d5wajOPE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713193317;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=zwjBbQo6C7j6xP7+cDacBB/+QuPqifcUdRYibqKmYA0=;
	b=d5wajOPEVoo6uacNunS7eMkH0GVSBfQjIgcsL3j+s/yRPu73KeCNvriGy7CHo/xXwNFlZZ
	cVRZQTnXvgq0WzpPtz4R4yxJE1SfRIvGXAdEkQREskFlrc3wMwHJUSWE8P3VvFUSmWePud
	58EWonEsEIC5+7UHADRMqrvHAwdWaAc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-680-9ymtmfl1OWC_FKI9pEuRZA-1; Mon, 15 Apr 2024 11:01:53 -0400
X-MC-Unique: 9ymtmfl1OWC_FKI9pEuRZA-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-343c6bb1f21so2271255f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 08:01:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713193312; x=1713798112;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zwjBbQo6C7j6xP7+cDacBB/+QuPqifcUdRYibqKmYA0=;
        b=uW3uRj+FDJUO/oj0K+Uzm8OvEnoX8f5OA5o+eCv+WjNbCA605HmllZihc1FCeFKUZQ
         UMAQy/hIet1JrDhFSoyoS4s2yYkTQasuOYgjeVRtM8VREertyvvFh3oXw2ebzj2bnT4J
         RywlC+SvNBRqDvz7dlu/1gE05H6zCM7tABNf79XJYj7jy2C4rrrUZ22xYYQr9RYNjwIU
         e2lZstK2N5ApCSF/sNq7IMLEv1WMnf6Yv/191mPsjWflwxisDuSM1pK/6wimm+p8GW1k
         RUbgHHBysC8v0wsQRyuNIAAEIcd0CjwJi1Y1yHrBpikZSCbp+mWuPdjXFaoF945BXCTs
         gk+A==
X-Forwarded-Encrypted: i=1; AJvYcCUEDoNz40g+GWWor6GOeZ+lMDEvjXf4WPad1KOi5f7vAcEe6YGzXPVMZSsCeF94IFTxeIDbKolI0Aaqh/WYsdhhDBPb/L8ScbwiP0rl
X-Gm-Message-State: AOJu0YxQ9kIkJSuVLv9hMLJ0EZdhkaRItERKPiN+Pow55YEYc89RQCXr
	gLH0F7dHYvsgWkgZ5r53Hu3M4gwWUO7NYOXEz7rmHreG1xBLMU/+G9YU1uGhMJAYzMonwN61syr
	8ZhGrSySoJiNzrtk2P9WGsFwYgTiUhUQE16LIIiKXZ6FCJ0T9aX8Tw8Bx0IAIYQ==
X-Received: by 2002:a5d:6749:0:b0:346:bb52:25a1 with SMTP id l9-20020a5d6749000000b00346bb5225a1mr7167267wrw.33.1713193311923;
        Mon, 15 Apr 2024 08:01:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IESay4aKO0ZgPPO7ryxLsiEvDZn+lExNAZU8G+nuJuuajPSqAAIfF3Ob1/AhUDMhrDyLw/M9A==
X-Received: by 2002:a5d:6749:0:b0:346:bb52:25a1 with SMTP id l9-20020a5d6749000000b00346bb5225a1mr7167243wrw.33.1713193311544;
        Mon, 15 Apr 2024 08:01:51 -0700 (PDT)
Received: from ?IPV6:2003:cb:c706:d800:568a:6ea7:5272:797c? (p200300cbc706d800568a6ea75272797c.dip0.t-ipconnect.de. [2003:cb:c706:d800:568a:6ea7:5272:797c])
        by smtp.gmail.com with ESMTPSA id b13-20020a5d4d8d000000b003432d61d6b7sm12232617wru.51.2024.04.15.08.01.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Apr 2024 08:01:51 -0700 (PDT)
Message-ID: <ee1ac0fb-daf7-4aea-b07e-f8879b6b860b@redhat.com>
Date: Mon, 15 Apr 2024 17:01:49 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 0/3] Improve memory statistics for virtio balloon
To: zhenwei pi <pizhenwei@bytedance.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, virtualization@lists.linux.dev
Cc: mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
 akpm@linux-foundation.org
References: <20240415084113.1203428-1-pizhenwei@bytedance.com>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240415084113.1203428-1-pizhenwei@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15.04.24 10:41, zhenwei pi wrote:
> Hi,
> 
> When the guest runs under critial memory pressure, the guest becomss
> too slow, even sshd turns D state(uninterruptible) on memory
> allocation. We can't login this VM to do any work on trouble shooting.
> 
> Guest kernel log via virtual TTY(on host side) only provides a few
> necessary log after OOM. More detail memory statistics are required,
> then we can know explicit memory events and estimate the pressure.
> 
> I'm going to introduce several VM counters for virtio balloon:
> - oom-kill
> - alloc-stall
> - scan-async
> - scan-direct
> - reclaim-async
> - reclaim-direct

IIUC, we're only exposing events that are already getting provided via 
all_vm_events(), correct?

In that case, I don't really see a major issue. Some considerations:

(1) These new events are fairly Linux specific.

PSWPIN and friends are fairly generic, but HGTLB is also already fairly 
Linux specific already. OOM-kills don't really exist on Windows, for 
example. We'll have to be careful of properly describing what the 
semantics are.

(2) How should we handle if Linux ever stops supporting a certain event 
(e.g., major reclaim rework). I assume, simply return nothing like we 
currently would for VIRTIO_BALLOON_S_HTLB_PGALLOC without 
CONFIG_HUGETLB_PAGE.

-- 
Cheers,

David / dhildenb


