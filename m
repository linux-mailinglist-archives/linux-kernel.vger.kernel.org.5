Return-Path: <linux-kernel+bounces-136285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B00E689D23C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 08:19:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EABA1F2234E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 06:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EA0371742;
	Tue,  9 Apr 2024 06:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Buahw931"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ACB96EB72
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 06:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712643584; cv=none; b=nLcabEoJEBMJATVUncyYWo8uG+71OSfNLjHGvJTqlCW7/Iqb1b7Owm9W0KXc2BJYfdJnK0mD/7Kb84BylhxB466Yp/23HTWJVlUOfl9QR8b6pkEKDLVk582azWvC5aEMjg7x4YoIdqe4pLZCDKFZymwKKuDq4ITJXQ8ML7ZxBok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712643584; c=relaxed/simple;
	bh=fkhIHTNgQsjJ+75AHWtWhK3dV9fPw50Z6dlrmwK15EA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nsg5w4/GpH+mdV8ddpxft9L/v66RBuk2iKxiOgbdQrK2fHTdWTH6z6XeVwRgIoWCfODNYYk+lQteq9St9UxlyWd2gAPihXb1esdAU6Z7TrvL/4qfTPKIofey+I7Dgt0tU9hSHDCcpHzmFTwZJQqUXpmnbPUY6rGkobM465sFzes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Buahw931; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712643580;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Y1cvkP8+VQryWRgcJ5dN75UnPlwOjiMz8ZDJuBxlHfU=;
	b=Buahw931X7yKFWe585gkPpSUSyB/kbiMIUpxEmQnRLuk/VWw60EGyz49NJcfeDQ5m9oE4B
	wv4SIaWwDMRRp73yIluYZyyI0sozLKlLSjkQajNG5ogHS7qxrjkWcVWsICIq+n5hJ0vNd5
	oW1ao64B0NWeUJV/PJjxBjby7KLe58k=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-644-86_OEn8cO5e38N6GEm267w-1; Tue, 09 Apr 2024 02:19:38 -0400
X-MC-Unique: 86_OEn8cO5e38N6GEm267w-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-56e5309b4d6so1725041a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2024 23:19:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712643577; x=1713248377;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y1cvkP8+VQryWRgcJ5dN75UnPlwOjiMz8ZDJuBxlHfU=;
        b=RFkyvQ0IP1HZq09MeVq1C3qjW2KCCjFGtn00GR7KeFLMxi2WMUzMjjv/PgMjp2+tzK
         +BJijI7Tb8gNnFbQPaLO0Rrtbj0ome7AdCNv9zapzXHE4UOXT1V6xreHEjQNF7Gd/zL3
         VBzW8nwSeQ59s9K4WF0sVesAMP9IhKQ+XgpZuwQsHzOPezNJLI/9mzsBLSxnZNxiKaU1
         IU0nhUCZa+iw2X/lDtwndKcCHVLYN08TUZ9TskUK7K2eqo+Bm9DM7edr14EdVrrETJhe
         EFQolx2O1QAmT+PdGnaUNTGm0qVUHXoBBjvOSFNZflFGYu+yO8LbnC8z3cz9jG7bInd8
         Ew7Q==
X-Forwarded-Encrypted: i=1; AJvYcCUT4hJwXjR+sAIwnSQbEpSVGY+3RKaW9PsQS2tS0u1W+5aXAMhuHrpOOeA8Fca3JUYkMX7EDaq1krLV6uC04/ETqH5Ya/DEBwr4IJJD
X-Gm-Message-State: AOJu0YxhyImTJRMJQzDwqAYVJ/JMRYQR/BcXTwh1UE/juVZ8q46Vee3d
	jTOcUPsZKph9Md+UIFABinQfeeIelD3FO71MRXCWZ1KOGbn9jdu8BWU3VC7f5SUAII+cuAz+PO8
	cE3MX3fMqT5lHkyK9P+qRbGU0xn81TeKQWdimV4nVI/sAqygmYU2yfT+NcY8UWg==
X-Received: by 2002:a50:9f6b:0:b0:56e:dc5:e99 with SMTP id b98-20020a509f6b000000b0056e0dc50e99mr7728897edf.24.1712643577203;
        Mon, 08 Apr 2024 23:19:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHAIf7qjab0t3qaKYhj5BbpIPDCgMO0B5IeFA+M2gmA0bxyH/eBzWzin0nhgUp3McDyUeprAg==
X-Received: by 2002:a50:9f6b:0:b0:56e:dc5:e99 with SMTP id b98-20020a509f6b000000b0056e0dc50e99mr7728885edf.24.1712643576691;
        Mon, 08 Apr 2024 23:19:36 -0700 (PDT)
Received: from redhat.com ([2.52.134.26])
        by smtp.gmail.com with ESMTPSA id i33-20020a0564020f2100b0056e6e9a367fsm671421eda.19.2024.04.08.23.19.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 23:19:36 -0700 (PDT)
Date: Tue, 9 Apr 2024 02:19:33 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "ni.liqiang" <ni_liqiang@126.com>
Cc: Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	"jin . qi" <jin.qi@zte.com.cn>,
	"ni . liqiang" <ni.liqiang@zte.com.cn>,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers/virtio: delayed configuration descriptor flags
Message-ID: <20240409015712-mutt-send-email-mst@kernel.org>
References: <20240408170252.13566-1-ni_liqiang@126.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240408170252.13566-1-ni_liqiang@126.com>

On Tue, Apr 09, 2024 at 01:02:52AM +0800, ni.liqiang wrote:
> In our testing of the virtio hardware accelerator, we found that
> configuring the flags of the descriptor after addr and len,
> as implemented in DPDK, seems to be more friendly to the hardware.
> 
> In our Virtio hardware implementation tests, using the default
> open-source code, the hardware's bulk reads ensure performance
> but correctness is compromised. If we refer to the implementation code
> of DPDK, placing the flags configuration of the descriptor
> after addr and len, virtio backend can function properly based on
> our hardware accelerator.
> 
> I am somewhat puzzled by this. From a software process perspective,
> it seems that there should be no difference whether
> the flags configuration of the descriptor is before or after addr and len.
> However, this is not the case according to experimental test results.


You should be aware of the following, from the PCI Express spec.
Note especially the second paragraph, and the last paragraph:

2.4.2.
25
30
Update Ordering and Granularity Observed by a
Read Transaction
If a Requester using a single transaction reads a block of data from a Completer, and the
Completer's data buffer is concurrently being updated, the ordering of multiple updates and
granularity of each update reflected in the data returned by the read is outside the scope of this
specification. This applies both to updates performed by PCI Express write transactions and
updates performed by other mechanisms such as host CPUs updating host memory.
If a Requester using a single transaction reads a block of data from a Completer, and the
Completer's data buffer is concurrently being updated by one or more entities not on the PCI
Express fabric, the ordering of multiple updates and granularity of each update reflected in the data
returned by the read is outside the scope of this specification.




As an example of update ordering, assume that the block of data is in host memory, and a host CPU
writes first to location A and then to a different location B. A Requester reading that data block
with a single read transaction is not guaranteed to observe those updates in order. In other words,
the Requester may observe an updated value in location B and an old value in location A, regardless
of the placement of locations A and B within the data block. Unless a Completer makes its own
guarantees (outside this specification) with respect to update ordering, a Requester that relies on
update ordering must observe the update to location B via one read transaction before initiating a
subsequent read to location A to return its updated value.




As an example of update granularity, if a host CPU writes a QWORD to host memory, a Requester
reading that QWORD from host memory may observe a portion of the QWORD updated and
another portion of it containing the old value.
While not required by this specification, it is strongly recommended that host platforms guarantee
that when a host CPU writes aligned DWORDs or aligned QWORDs to host memory, the update
granularity observed by a PCI Express read will not be smaller than a DWORD.


IMPLEMENTATION NOTE
No Ordering Required Between Cachelines
15
A Root Complex serving as a Completer to a single Memory Read that requests multiple cachelines
from host memory is permitted to fetch multiple cachelines concurrently, to help facilitate multi-
cacheline completions, subject to Max_Payload_Size. No ordering relationship between these
cacheline fetches is required.





Now I suspect that what is going on is that your Root complex
reads descriptors out of order, so the second descriptor is invalid
but the 1st one is valid.




> We would like to know if such a change in the configuration order
> is reasonable and acceptable?

We need to understand the root cause and how robust the fix is
before answering this.


> Thanks.
> 
> Signed-off-by: ni.liqiang <ni_liqiang@126.com>
> Reviewed-by: jin.qi <jin.qi@zte.com.cn>
> Tested-by: jin.qi <jin.qi@zte.com.cn>
> Cc: ni.liqiang <ni.liqiang@zte.com.cn>
> ---
>  drivers/virtio/virtio_ring.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 6f7e5010a673..bea2c2fb084e 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -1472,15 +1472,16 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
>  			flags = cpu_to_le16(vq->packed.avail_used_flags |
>  				    (++c == total_sg ? 0 : VRING_DESC_F_NEXT) |
>  				    (n < out_sgs ? 0 : VRING_DESC_F_WRITE));
> -			if (i == head)
> -				head_flags = flags;
> -			else
> -				desc[i].flags = flags;
>  
>  			desc[i].addr = cpu_to_le64(addr);
>  			desc[i].len = cpu_to_le32(sg->length);
>  			desc[i].id = cpu_to_le16(id);
>  
> +			if (i == head)
> +				head_flags = flags;
> +			else
> +				desc[i].flags = flags;
> +
>  			if (unlikely(vq->use_dma_api)) {
>  				vq->packed.desc_extra[curr].addr = addr;
>  				vq->packed.desc_extra[curr].len = sg->length;
> -- 
> 2.34.1


