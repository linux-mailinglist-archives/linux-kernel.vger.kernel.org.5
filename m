Return-Path: <linux-kernel+bounces-116654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A1FD88A837
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:05:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3DD6B4372D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D22E986AF8;
	Mon, 25 Mar 2024 10:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i1R2wcGT"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B66F86653
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 07:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711352082; cv=none; b=ivnsfdtEDumvZ188EPoJujnj8GAwBvm3TMuLkk2Nz3B1G7AA63sFjMrNPG+dbl9li6seL5i0+ekFjb7DcoqNivbMqA+kEcevDY7X7SoWFOv1XFKkHk0tG95bJ0z4jCV4z3ZakEKAXyBc3ythvu3ytUwPpE9YPH7LOex7skpD/+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711352082; c=relaxed/simple;
	bh=BDt3n+MUaCFNO4y3L2tuOOVWGjx2h2RQhyP7NCMw9HY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZQWVRYhW7hosO7chuBbqPvaTLXrt6C5PC45+2379gOil5LHda83DgtrMwHD6KefDES5ZFWKuyHIXxumY2qevBzMRoCa7RdTZ0KJR6pPU/o2LSAfpsDNkeQ0OFuOpECrf6GygU16PuQoiU4yQIk5hgdNxxD16+biNUPRnFm5WsVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i1R2wcGT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711352080;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6I4mGWtPnXl+rCWErFK37GiocqArlyDhDISrag+E6MY=;
	b=i1R2wcGTd+Y6Lm1ZGbeZRJxcbz5IFNUilNqnSvsQfwzLjoxRJJENXbZXGDNifelVVvW59g
	H7w29KRs+hd17UWlOyp3aUhpGbFrp48YHetepjmpKeGhKjI8YSKRx1ZxHy/Qz03Yhhk5vs
	P3JX6x41/Rq3gf97d1So4gccx34HqCI=
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com
 [209.85.160.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-605-4JoqTjLHOIC8LzM-EWkrhA-1; Mon, 25 Mar 2024 03:34:38 -0400
X-MC-Unique: 4JoqTjLHOIC8LzM-EWkrhA-1
Received: by mail-oa1-f71.google.com with SMTP id 586e51a60fabf-22a0191d8f0so1444959fac.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 00:34:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711352077; x=1711956877;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6I4mGWtPnXl+rCWErFK37GiocqArlyDhDISrag+E6MY=;
        b=ctNJKrYb1ks4f/gPrKCB35L+4jJ3a9R9FBgLHvDW77/GMT75SWiB+isgL+Sa6z/Mv3
         yqDNrsCzRejoo4eLTS2WJhFbFb6nhaw0YoBg3E3Waz2X1PFpIvHEQ30QBjR2FhhSMCsD
         5zHvF1JxAsJioUvMB69FPzQGIu3hPkrQGINCIlji5tXlBDxV39Ug0VQrAgt4JjzDANSI
         eE/HNo76fPrK/cch5a70md3nrog/Ki7jGe1iLgIBY8GwVAvBQIt4KR5KzMBxY5ukL/Xr
         ioxprG7OgFkt7nwcva8E1dzIJVJ0aD1vw9fzcQc25QH66GA/CujLWR4T5Sk5c/Sx7htq
         rwqg==
X-Forwarded-Encrypted: i=1; AJvYcCUXRUbRGxoOlXVzdngXm4nkAy8SrgAcmUz4EBuI+F1CYhFXs1DaZBwCA8TAOqlwSzQzMAANOSjDFZo87dM+vwMCst14jF/Ce7ZVmYhl
X-Gm-Message-State: AOJu0Yx9stKHY439TULYd5WzZrfeyJZxi0/mscrZgr+nCJGBBK91X0fK
	qm1CxCu6tKJSrs6rvdKR2zrLwBiLsWKneFOlCDt+k/yn9PVW3Y6mn4DCvsfgE14t/p1UkzTBK7v
	wLiTijiMKI/4EdD/vYOFGYqjEan4KmUd6b1O4C+bXRWhNc6oSM7GyxlXJ4hzQXA==
X-Received: by 2002:a05:6871:288e:b0:22a:2446:353f with SMTP id bq14-20020a056871288e00b0022a2446353fmr3755172oac.11.1711352077662;
        Mon, 25 Mar 2024 00:34:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFKY6GYp1/XIaWHrTUl2r4qAWkWvRiG3Ehn1RpYbN3BtHiFYE6R3jh1TKiJs6ZlTqhiC8/SJA==
X-Received: by 2002:a05:6871:288e:b0:22a:2446:353f with SMTP id bq14-20020a056871288e00b0022a2446353fmr3755157oac.11.1711352077282;
        Mon, 25 Mar 2024 00:34:37 -0700 (PDT)
Received: from [192.168.68.51] ([43.252.115.31])
        by smtp.gmail.com with ESMTPSA id c17-20020aa781d1000000b006e6bfff6085sm3766624pfn.143.2024.03.25.00.34.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Mar 2024 00:34:36 -0700 (PDT)
Message-ID: <1dcec730-ec26-46f4-ba4c-06101fcc599e@redhat.com>
Date: Mon, 25 Mar 2024 17:34:29 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] virtio_ring: Fix the stale index in available ring
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Will Deacon <will@kernel.org>, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, jasowang@redhat.com,
 xuanzhuo@linux.alibaba.com, yihyu@redhat.com, shan.gavin@gmail.com,
 linux-arm-kernel@lists.infradead.org,
 Catalin Marinas <catalin.marinas@arm.com>, mochs@nvidia.com
References: <20240314074923.426688-1-gshan@redhat.com>
 <20240318165924.GA1824@willie-the-truck>
 <35a6bcef-27cf-4626-a41d-9ec0a338fe28@redhat.com>
 <20240319182251.GB3121@willie-the-truck>
 <9500adaf-0075-4ae9-92db-7e310b6598b0@redhat.com>
 <20240319203540-mutt-send-email-mst@kernel.org>
 <3a6c8b23-af9c-47a7-8c22-8e0a78154bd3@redhat.com>
 <20240320030215-mutt-send-email-mst@kernel.org>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20240320030215-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 3/20/24 17:14, Michael S. Tsirkin wrote:
> On Wed, Mar 20, 2024 at 03:24:16PM +1000, Gavin Shan wrote:
>> On 3/20/24 10:49, Michael S. Tsirkin wrote:>
>>> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
>>> index 6f7e5010a673..79456706d0bd 100644
>>> --- a/drivers/virtio/virtio_ring.c
>>> +++ b/drivers/virtio/virtio_ring.c
>>> @@ -685,7 +685,8 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
>>>    	/* Put entry in available array (but don't update avail->idx until they
>>>    	 * do sync). */
>>>    	avail = vq->split.avail_idx_shadow & (vq->split.vring.num - 1);
>>> -	vq->split.vring.avail->ring[avail] = cpu_to_virtio16(_vq->vdev, head);
>>> +	u16 headwithflag = head | (q->split.avail_idx_shadow & ~(vq->split.vring.num - 1));
>>> +	vq->split.vring.avail->ring[avail] = cpu_to_virtio16(_vq->vdev, headwithflag);
>>>    	/* Descriptors and available array need to be set before we expose the
>>>    	 * new available array entries. */
>>>

Ok, Michael. I continued with my debugging code. It still looks like a
hardware bug on NVidia's grace-hopper. I really think NVidia needs to be
involved for the discussion, as suggested by you.

Firstly, I bind the vhost process and vCPU thread to CPU#71 and CPU#70.
Note that I have only one vCPU in my configuration.

Secondly, the debugging code is enhanced so that the available head for
(last_avail_idx - 1) is read for twice and recorded. It means the available
head for one specific available index is read for twice. I do see the
available heads are different from the consecutive reads. More details
are shared as below.

 From the guest side
===================

virtio_net virtio0: output.0:id 86 is not a head!
head to be released: 047 062 112

avail_idx:
000  49665
001  49666  <--
  :
015  49664

avail_head:
000  062
001  047  <--
  :
015  112

 From the host side
==================

avail_idx
000  49663
001  49666  <---
  :

avail_head
000  062  (062)
001  047  (047)  <---
  :
015  086  (112)          // head 086 is returned from the first read,
                          // but head 112 is returned from the second read

vhost_get_vq_desc: Inconsistent head in two read (86 -> 112) for avail_idx 49664

Thanks,
Gavin



