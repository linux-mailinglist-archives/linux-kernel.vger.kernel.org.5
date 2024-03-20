Return-Path: <linux-kernel+bounces-108443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CF7A880A9C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 06:24:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AEA18B222C1
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 05:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3544218AE8;
	Wed, 20 Mar 2024 05:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="isJ5p0AQ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB1A17BD9
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 05:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710912274; cv=none; b=CwNQt017H06S7+iGhty/foitc/90SL7zhnpjLiftQrkbM3v9TAetEXBc4+APnKmp6xWyUk+RAhZCPk2qmyDeymTFiNvZLAQq7NwhubVlXiMsrCY78cHtKpbJPuCTDBpzd3G/t+fPFpCCFtYFPTe7WdG28b8s7zrhV8NGEO2kcRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710912274; c=relaxed/simple;
	bh=caYaSpmjWLfenJmZLDNeCx4DtxlujtzRJi2hwjbOFhI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kxxYn4lDTqHCc/1MjkvkIHydb0dPU+JBZDojKviYRIWjAcmY6zINau6y3X6YCxLm7EBxMcXdpP646bnCK3R0kKXt2lmRlgL7JKGpkfv5w+fVAs3omPIuLn4vV7LrOGT1NjqR4c1/SGzbLuy0fnne5lELuy7wko5tGsOmdjN5tNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=isJ5p0AQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710912271;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=paGiGEEp9xes32fQLOmnOD45tZcdVk+dgcPS6McRIVA=;
	b=isJ5p0AQi9nlqA45CtubSl+wTaqax4RZPM0sHQf+sjCuiAHFMox6kEBRj0L03wWZq/7+TU
	r/V0LZLYOS7BSiyKFEtNNebqzjL9vQ96cTQIBFI9yuPU73mIHySGzR9oNI0fdbQ+rjRajK
	IwEC8P8YKMfla3UHW69cskgeUm5o6wA=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-369-gizPngTxMcKHMDn4ZKojhg-1; Wed, 20 Mar 2024 01:24:26 -0400
X-MC-Unique: gizPngTxMcKHMDn4ZKojhg-1
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-6e7827e1b2aso191482b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 22:24:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710912265; x=1711517065;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=paGiGEEp9xes32fQLOmnOD45tZcdVk+dgcPS6McRIVA=;
        b=YdMmQc5V9uOYroPtVxbNZzp9ROgmPuasjo8yVc0/L6/c0mFZgyT5TZ4/7qbj1xXCy5
         NFwA3SUz9y7PKv2YuGkyTXwhHoHd5yGLw+Ow/VVAdmsdTySS1fSA2r2rHqEo7Mpxcv9S
         OMrFp6tIZs9kWqVVP3UsFXFu2v7b3J8i99ccCV4KZKztn8fv+LvZE0oPN4z8Yb6qMFQ2
         2vO2wVUPLwxU7VM1utNXnEfo3WI9RswU9fNaP8S+6XTuv2ZlYY27ODh3MQpXPAWfyuS3
         3UU19Xk36BMmJTwSQLPShq1HUJOFYkeTHRIJYinVqGwndWm3kXkhGniGblakTNr7CBCH
         Wk/g==
X-Forwarded-Encrypted: i=1; AJvYcCX8tN3LsKBUE8e/HGZIlf4TXwYcOFmQzPYH8TwrxPbAAf5z637+unbj+KprwyQZRbEEJNRWi0wyOaNsveFbD8eCcTsr/RIfEIF5w1ML
X-Gm-Message-State: AOJu0YxXvoM6hS0Avvmigr+TwejV45v28QiqwVAruIRW5TMhc5VZtfgJ
	pjhH+6QfelC7NIFZchQ6VN/pNX/JMxo46JqmIVtiTVmiMa0I9PyMQdnW5kfANdEze3kOm2WX4yw
	TZXsXxysRgj0oEnu7WemY4TAIXNzPD/QlSTukM544CHLiCmhiiLZPBjOshYWtCg==
X-Received: by 2002:a05:6a20:94ca:b0:1a3:62a9:39c0 with SMTP id ht10-20020a056a2094ca00b001a362a939c0mr8664985pzb.38.1710912264996;
        Tue, 19 Mar 2024 22:24:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFHmD834wqq1B57Qja9j6q53cvP8FpzYPiHAT8lVP0F2/dYQAzwDSEQXaw57UhbilvqTXb9JA==
X-Received: by 2002:a05:6a20:94ca:b0:1a3:62a9:39c0 with SMTP id ht10-20020a056a2094ca00b001a362a939c0mr8664968pzb.38.1710912264566;
        Tue, 19 Mar 2024 22:24:24 -0700 (PDT)
Received: from [192.168.68.51] ([43.252.115.31])
        by smtp.gmail.com with ESMTPSA id c8-20020a170903234800b001dd7d00f7afsm12527037plh.18.2024.03.19.22.24.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Mar 2024 22:24:23 -0700 (PDT)
Message-ID: <3a6c8b23-af9c-47a7-8c22-8e0a78154bd3@redhat.com>
Date: Wed, 20 Mar 2024 15:24:16 +1000
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
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20240319203540-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/20/24 10:49, Michael S. Tsirkin wrote:> 
> I think you are wasting the time with these tests. Even if it helps what
> does this tell us? Try setting a flag as I suggested elsewhere.
> Then check it in vhost.
> Or here's another idea - possibly easier. Copy the high bits from index
> into ring itself. Then vhost can check that head is synchronized with
> index.
> 
> Warning: completely untested, not even compiled. But should give you
> the idea. If this works btw we should consider making this official in
> the spec.
> 
> 
>   static inline int vhost_get_avail_flags(struct vhost_virtqueue *vq,
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 6f7e5010a673..79456706d0bd 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -685,7 +685,8 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
>   	/* Put entry in available array (but don't update avail->idx until they
>   	 * do sync). */
>   	avail = vq->split.avail_idx_shadow & (vq->split.vring.num - 1);
> -	vq->split.vring.avail->ring[avail] = cpu_to_virtio16(_vq->vdev, head);
> +	u16 headwithflag = head | (q->split.avail_idx_shadow & ~(vq->split.vring.num - 1));
> +	vq->split.vring.avail->ring[avail] = cpu_to_virtio16(_vq->vdev, headwithflag);
>   
>   	/* Descriptors and available array need to be set before we expose the
>   	 * new available array entries. */
> 
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index 045f666b4f12..bd8f7c763caa 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -1299,8 +1299,15 @@ static inline int vhost_get_avail_idx(struct vhost_virtqueue *vq,
>   static inline int vhost_get_avail_head(struct vhost_virtqueue *vq,
>   				       __virtio16 *head, int idx)
>   {
> -	return vhost_get_avail(vq, *head,
> +	unsigned i = idx;
> +	unsigned flag = i & ~(vq->num - 1);
> +	unsigned val = vhost_get_avail(vq, *head,
>   			       &vq->avail->ring[idx & (vq->num - 1)]);
> +	unsigned valflag = val & ~(vq->num - 1);
> +
> +	WARN_ON(valflag != flag);
> +
> +	return val & (vq->num - 1);
>   }
>   

Thanks, Michael. The code is already self-explanatory. Since vq->num is 256, I just
squeezed the last_avail_idx to the high byte. Unfortunately, I'm unable to hit
the WARN_ON(). Does it mean the low byte is stale (or corrupted) while the high
byte is still correct and valid?

         avail = vq->split.avail_idx_shadow & (vq->split.vring.num - 1);
         vq->split.vring.avail->ring[avail] =
                 cpu_to_virtio16(_vq->vdev, head | (avail << 8));


         head = vhost16_to_cpu(vq, ring_head);
         WARN_ON((head >> 8) != (vq->last_avail_idx % vq->num));
         head = head & 0xff;

One question: Does QEMU has any chance writing data to the available queue when
vhost is enabled? My previous understanding is no, the queue is totally owned by
vhost instead of QEMU.

Before this patch was posted, I had debugging code to record last 16 transactions
to the available and used queue from guest and host side. It did reveal the wrong
head was fetched from the available queue.

[   11.785745] ================ virtqueue_get_buf_ctx_split ================
[   11.786238] virtio_net virtio0: output.0:id 74 is not a head!
[   11.786655] head to be released: 036 077
[   11.786952]
[   11.786952] avail_idx:
[   11.787234] 000  63985  <--
[   11.787237] 001  63986
[   11.787444] 002  63987
[   11.787632] 003  63988
[   11.787821] 004  63989
[   11.788006] 005  63990
[   11.788194] 006  63991
[   11.788381] 007  63992
[   11.788567] 008  63993
[   11.788772] 009  63994
[   11.788957] 010  63995
[   11.789141] 011  63996
[   11.789327] 012  63997
[   11.789515] 013  63998
[   11.789701] 014  63999
[   11.789886] 015  64000
[   11.790068]
[   11.790068] avail_head:
[   11.790529] 000  075  <--
[   11.790718] 001  036
[   11.790890] 002  077
[   11.791061] 003  129
[   11.791231] 004  072
[   11.791400] 005  130
[   11.791574] 006  015
[   11.791748] 007  074
[   11.791918] 008  130
[   11.792094] 009  130
[   11.792263] 010  074
[   11.792437] 011  015
[   11.792617] 012  072
[   11.792788] 013  129
[   11.792961] 014  077    // The last two heads from guest to host: 077, 036
[   11.793134] 015  036

[root@nvidia-grace-hopper-05 qemu.main]# cat /proc/vhost

avail_idx
000  63998
001  64000
002  63954  <---
003  63955
004  63956
005  63974
006  63981
007  63984
008  63986
009  63987
010  63988
011  63989
012  63992
013  63993
014  63995
015  63997

avail_head
000  074
001  015
002  072
003  129
004  074            // The last two heads seen by vhost is: 074, 036
005  036
006  075  <---
007  036
008  077
009  129
010  072
011  130
012  015
013  074
014  130
015  130

used_idx
000  64000
001  63882  <---
002  63889
003  63891
004  63898
005  63936
006  63942
007  63946
008  63949
009  63953
010  63957
011  63981
012  63990
013  63992
014  63993
015  63999

used_head
000  072
001  129
002  074          // The last two heads published to guest is: 074, 036
003  036
004  075  <---
005  036
006  077
007  129
008  072
009  130
010  015
011  074
012  130
013  130
014  074
015  015

Thanks,
Gavin





