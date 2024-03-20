Return-Path: <linux-kernel+bounces-108529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D564880BCF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 08:15:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31B88281BBF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 07:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6491624A19;
	Wed, 20 Mar 2024 07:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ES0PZWAs"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB2022F07
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 07:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710918903; cv=none; b=I1aU0wMw3mbHZz7yHTcar7as11KAVX1mZ3ZlQm9IZWan7rd3panF5o4HA/BoeB2OashHAuDb3kBxtWqvLOSnNtd6EY7LdYxgisSOiUJQ9Kr9AlNPQzqGST2LHuD5SVAW61AKFlVVLfL1ndjumQhZxUQMqdWhJ6Zs46O9gVmhSsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710918903; c=relaxed/simple;
	bh=JdWtJIJrAVzoAqgk1SP0pQuB/E61e1S1atpKQ3fAHfo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hu5Cq2RYe8wgE75Os9pbxaxRpnG/RR1lfm5Qlrd4VIMIPY5Hj7MHRSt3ztFebUULJb0rWQRDl9CLCo5s1wbgi4LrTdUKv8m3Cu/WpahGsqdyqoFN1P6a4sTn5kfq2YtCtTDAj2JA3lY8USZB7QpS5QPMNPfDURR91qus4H91W80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ES0PZWAs; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710918900;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Njq0yEyKBRcrvnVgNGH/spn65v7UciN8KbaIQu5L7ZE=;
	b=ES0PZWAscFh+c/Q3F7MmCIm37XQZmxjPLeWPqW9ko1Zyu4QfmGBYBIfnB9SBPDqpce+IFZ
	N0//JLQAumXEkSmCDlfLRDBHUgFTLLkH0JEnN6xKNVpvnfllwLhhCNAjAhB3nR0dySSIpm
	pNWX9s5XgvkJmKA/nRdGwsf3ECmGcr8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-314-5AVnc72cNWSR4onqZb_C_w-1; Wed, 20 Mar 2024 03:14:58 -0400
X-MC-Unique: 5AVnc72cNWSR4onqZb_C_w-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-33eb8721b64so3439087f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 00:14:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710918897; x=1711523697;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Njq0yEyKBRcrvnVgNGH/spn65v7UciN8KbaIQu5L7ZE=;
        b=tKXD5ogFa6uhnFqPkWVQ8YNF77R8sqSdB1Dqr7OrSjpTqnnloEObHypL5FNjs1m24Z
         lrJEDZe8OZQVgdZ2EvnzHcZZavaSVK6aXA074mWHvit1KQHVkAsTsne3cI3qM5xG8/ue
         fi8uQL5XJajcMiESxPSM7VVH3bPDy1KvxdY8zjkBrA8SCRKUNZ8nxh3z4E7X58y3/2oi
         qtpkjMXKx0shzE6umZOsVRZeCKH5u96MepTcZhcjvq56ayrz+iktcL1aZe8d9pJj+sUW
         Huc3Xl1mXKvhggNScXmRTQVKIIddHuGdQLoF4cb1eXY9LWeo4z1Z2W1UfaVjG/rpoPmK
         DjKA==
X-Forwarded-Encrypted: i=1; AJvYcCULhOktQN52FdQeir0hBMYb7mvpyDtHOut0iJcaAD63nBnM2cSk9f3hxBngnaxDVK3HeGHsKkTLeiIcJbDOWf6VR7ZGvEumO1+IgU/k
X-Gm-Message-State: AOJu0Yxh7MftVgR8pTaOSl6Iw2UqhNT6nMd2gdGsYpTd+XOos72Kx8FT
	A0gWf8JwdHqZjdC4i1ytMJCyIp1XSAxl7gBCZJBhJzWl/UYzny0thJP3L5hAUNNIPRnpX8GdEwb
	Jl90Rq+wCVF6oDP9MweefCVYlAczxqfvumP+8tib0JSZ6P8ZNYSgMp1RPHUyEOA==
X-Received: by 2002:adf:f9cf:0:b0:33d:579e:f462 with SMTP id w15-20020adff9cf000000b0033d579ef462mr3333358wrr.36.1710918897559;
        Wed, 20 Mar 2024 00:14:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFujaGn+6/sZ8mCjSdKUkwZwZgH1kNHVb5niYMglJWfWBSGt1ESNUy6R4YkPD6nmkgTnBzLQg==
X-Received: by 2002:adf:f9cf:0:b0:33d:579e:f462 with SMTP id w15-20020adff9cf000000b0033d579ef462mr3333340wrr.36.1710918896915;
        Wed, 20 Mar 2024 00:14:56 -0700 (PDT)
Received: from redhat.com ([2.52.6.254])
        by smtp.gmail.com with ESMTPSA id n8-20020a5d6608000000b0033e45930f35sm14070360wru.6.2024.03.20.00.14.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Mar 2024 00:14:56 -0700 (PDT)
Date: Wed, 20 Mar 2024 03:14:52 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Gavin Shan <gshan@redhat.com>
Cc: Will Deacon <will@kernel.org>, virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org, jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com, yihyu@redhat.com, shan.gavin@gmail.com,
	linux-arm-kernel@lists.infradead.org,
	Catalin Marinas <catalin.marinas@arm.com>, mochs@nvidia.com
Subject: Re: [PATCH] virtio_ring: Fix the stale index in available ring
Message-ID: <20240320030215-mutt-send-email-mst@kernel.org>
References: <20240314074923.426688-1-gshan@redhat.com>
 <20240318165924.GA1824@willie-the-truck>
 <35a6bcef-27cf-4626-a41d-9ec0a338fe28@redhat.com>
 <20240319182251.GB3121@willie-the-truck>
 <9500adaf-0075-4ae9-92db-7e310b6598b0@redhat.com>
 <20240319203540-mutt-send-email-mst@kernel.org>
 <3a6c8b23-af9c-47a7-8c22-8e0a78154bd3@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3a6c8b23-af9c-47a7-8c22-8e0a78154bd3@redhat.com>

On Wed, Mar 20, 2024 at 03:24:16PM +1000, Gavin Shan wrote:
> On 3/20/24 10:49, Michael S. Tsirkin wrote:>
> > I think you are wasting the time with these tests. Even if it helps what
> > does this tell us? Try setting a flag as I suggested elsewhere.
> > Then check it in vhost.
> > Or here's another idea - possibly easier. Copy the high bits from index
> > into ring itself. Then vhost can check that head is synchronized with
> > index.
> > 
> > Warning: completely untested, not even compiled. But should give you
> > the idea. If this works btw we should consider making this official in
> > the spec.
> > 
> > 
> >   static inline int vhost_get_avail_flags(struct vhost_virtqueue *vq,
> > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > index 6f7e5010a673..79456706d0bd 100644
> > --- a/drivers/virtio/virtio_ring.c
> > +++ b/drivers/virtio/virtio_ring.c
> > @@ -685,7 +685,8 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
> >   	/* Put entry in available array (but don't update avail->idx until they
> >   	 * do sync). */
> >   	avail = vq->split.avail_idx_shadow & (vq->split.vring.num - 1);
> > -	vq->split.vring.avail->ring[avail] = cpu_to_virtio16(_vq->vdev, head);
> > +	u16 headwithflag = head | (q->split.avail_idx_shadow & ~(vq->split.vring.num - 1));
> > +	vq->split.vring.avail->ring[avail] = cpu_to_virtio16(_vq->vdev, headwithflag);
> >   	/* Descriptors and available array need to be set before we expose the
> >   	 * new available array entries. */
> > 
> > diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> > index 045f666b4f12..bd8f7c763caa 100644
> > --- a/drivers/vhost/vhost.c
> > +++ b/drivers/vhost/vhost.c
> > @@ -1299,8 +1299,15 @@ static inline int vhost_get_avail_idx(struct vhost_virtqueue *vq,
> >   static inline int vhost_get_avail_head(struct vhost_virtqueue *vq,
> >   				       __virtio16 *head, int idx)
> >   {
> > -	return vhost_get_avail(vq, *head,
> > +	unsigned i = idx;
> > +	unsigned flag = i & ~(vq->num - 1);
> > +	unsigned val = vhost_get_avail(vq, *head,
> >   			       &vq->avail->ring[idx & (vq->num - 1)]);
> > +	unsigned valflag = val & ~(vq->num - 1);
> > +
> > +	WARN_ON(valflag != flag);
> > +
> > +	return val & (vq->num - 1);
> >   }
> 
> Thanks, Michael. The code is already self-explanatory.

Apparently not. See below.

> Since vq->num is 256, I just
> squeezed the last_avail_idx to the high byte. Unfortunately, I'm unable to hit
> the WARN_ON(). Does it mean the low byte is stale (or corrupted) while the high
> byte is still correct and valid?


I would find this very surprising.

>         avail = vq->split.avail_idx_shadow & (vq->split.vring.num - 1);
>         vq->split.vring.avail->ring[avail] =
>                 cpu_to_virtio16(_vq->vdev, head | (avail << 8));
> 
> 
>         head = vhost16_to_cpu(vq, ring_head);
>         WARN_ON((head >> 8) != (vq->last_avail_idx % vq->num));
>         head = head & 0xff;

This code misses the point of the test.
The high value you store now is exactly the same each time you
go around the ring. E.g. at beginning of ring you now always
store 0 as high byte. So a stale value will not be detected/
The high value you store now is exactly the same each time you
go around the ring. E.g. at beginning of ring you now always
store 0 as high byte. So a stale value will not be detected.

The value you are interested in should change
each time you go around the ring a full circle.
Thus you want exactly the *high byte* of avail idx -
this is what my patch did - your patch instead
stored and compared the low byte.


The advantage of this debugging patch is that it will detect the issue immediately
not after guest detected the problem in the used ring.
For example, you can add code to re-read the value, or dump the whole
ring.

> One question: Does QEMU has any chance writing data to the available queue when
> vhost is enabled? My previous understanding is no, the queue is totally owned by
> vhost instead of QEMU.

It shouldn't do it normally.

> Before this patch was posted, I had debugging code to record last 16 transactions
> to the available and used queue from guest and host side. It did reveal the wrong
> head was fetched from the available queue.

Oh nice that's a very good hint. And is this still reproducible?

> [   11.785745] ================ virtqueue_get_buf_ctx_split ================
> [   11.786238] virtio_net virtio0: output.0:id 74 is not a head!
> [   11.786655] head to be released: 036 077
> [   11.786952]
> [   11.786952] avail_idx:
> [   11.787234] 000  63985  <--
> [   11.787237] 001  63986
> [   11.787444] 002  63987
> [   11.787632] 003  63988
> [   11.787821] 004  63989
> [   11.788006] 005  63990
> [   11.788194] 006  63991
> [   11.788381] 007  63992
> [   11.788567] 008  63993
> [   11.788772] 009  63994
> [   11.788957] 010  63995
> [   11.789141] 011  63996
> [   11.789327] 012  63997
> [   11.789515] 013  63998
> [   11.789701] 014  63999
> [   11.789886] 015  64000
> [   11.790068]
> [   11.790068] avail_head:
> [   11.790529] 000  075  <--
> [   11.790718] 001  036
> [   11.790890] 002  077
> [   11.791061] 003  129
> [   11.791231] 004  072
> [   11.791400] 005  130
> [   11.791574] 006  015
> [   11.791748] 007  074
> [   11.791918] 008  130
> [   11.792094] 009  130
> [   11.792263] 010  074
> [   11.792437] 011  015
> [   11.792617] 012  072
> [   11.792788] 013  129
> [   11.792961] 014  077    // The last two heads from guest to host: 077, 036
> [   11.793134] 015  036

Maybe dump the avail ring from guest to make sure
it matches the expected contents?

> [root@nvidia-grace-hopper-05 qemu.main]# cat /proc/vhost
> 
> avail_idx
> 000  63998
> 001  64000
> 002  63954  <---
> 003  63955
> 004  63956
> 005  63974
> 006  63981
> 007  63984
> 008  63986
> 009  63987
> 010  63988
> 011  63989
> 012  63992
> 013  63993
> 014  63995
> 015  63997
> 
> avail_head
> 000  074
> 001  015
> 002  072
> 003  129
> 004  074            // The last two heads seen by vhost is: 074, 036
> 005  036
> 006  075  <---


And is 074 the previous (stale) value in the ring?


> 007  036
> 008  077
> 009  129
> 010  072
> 011  130
> 012  015
> 013  074
> 014  130
> 015  130



> used_idx
> 000  64000
> 001  63882  <---
> 002  63889
> 003  63891
> 004  63898
> 005  63936
> 006  63942
> 007  63946
> 008  63949
> 009  63953
> 010  63957
> 011  63981
> 012  63990
> 013  63992
> 014  63993
> 015  63999
> 
> used_head
> 000  072
> 001  129
> 002  074          // The last two heads published to guest is: 074, 036
> 003  036
> 004  075  <---
> 005  036
> 006  077
> 007  129
> 008  072
> 009  130
> 010  015
> 011  074
> 012  130
> 013  130
> 014  074
> 015  015
> 
> Thanks,
> Gavin

I like this debugging patch, it might make sense to
polish it up and include in production. We'll want it in
debugfs naturally not /proc/vhost.

But all in good time.


> 
> 


