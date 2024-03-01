Return-Path: <linux-kernel+bounces-88376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E99D86E0B7
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 12:53:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE563283EA4
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 11:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8F756CDC8;
	Fri,  1 Mar 2024 11:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QF12nm7S"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC62D6A8AE
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 11:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709293997; cv=none; b=XjU5kInlwFLBLoFPsXg8HUlXh6X86gI/NcFQms4rKE8AtT5NZAZ1ETllxWrUSJ1clkjn4c62tTjfRzyyd+2LZ2JpQ7qRCvpbcZsPqIYXy9sSWYdbXLpSEqVwIExB9xapceq2FpgBvGSWd57X1otFqNmM24TtrDqx9/YI9VIRfrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709293997; c=relaxed/simple;
	bh=WpidZeAtZ+YgQaVLdxWuklMA1DRtSXB3dUMvzxcxpvM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hTvG4COz2O/5xL9W/Akpj3vBaN3EfMdUloW+jCTfs6YIIj5SCkPnQQOl8vytTie6M+3aKFaJiVzpI9CXH5rOv29TNJyfycEibmyPkrSbjEgxKHwmuGDPZjto23X2TO25iONTVRqRCXhHKqSGX3JgQwrzvHSLAevicnDxa08hPkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QF12nm7S; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709293993;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sXYuCfdTj1urbCJSi5THRKssGZntXNDUJ+IF7YDUqaY=;
	b=QF12nm7S/cKwqW20/nXJE60YJXzcXAAho4dTRwOaN7KZfLwYh0rtusqAnwZENQ8B1Wkl95
	pR6KqGSt9e/tAW4E4SoH3orJNkLnyqtcJtSnscyPIQoBTab6LA0TtXwd9lhMm7ci273uuS
	d+mrVg3c8pgBozX1PeWKvA/lRkoN88Y=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-474-oTT08ykgO5e9_0NBCyc9hQ-1; Fri, 01 Mar 2024 06:53:12 -0500
X-MC-Unique: oTT08ykgO5e9_0NBCyc9hQ-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-558aafe9bf2so2317779a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2024 03:53:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709293991; x=1709898791;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sXYuCfdTj1urbCJSi5THRKssGZntXNDUJ+IF7YDUqaY=;
        b=R7nLeHBAI7rqWdXuU+05zWS8xbArVOm6kW3OH9D6Sr9HL9d+YhvVCVQkK1TpyDuOgA
         HQ076p96nSwmxzH3/OIPj7C9qQu8jLIQznIE7GUHoMiB64AU86ZwwCjJbPXZxo5LGE2c
         Z81u6XiC5plCtp29D3TNmIOGeIxW6WU3rjjSOJ4HJm7htMa2qig2PrMnuOMEg1ijYX8q
         VfHfNG/KpCyTcow5Psn9Td3DB/Qn0u9EnwpgYCMt/3iJlNNOp35mihzX7M1DcHQmf06D
         BLeOUfpOShf6qGYY6Z5ZBqFyameUZmphXjNbS8l95tQd9Ll+U0J1vSu8i+mkTYHn2lLL
         dhOg==
X-Forwarded-Encrypted: i=1; AJvYcCUhthGW+U0QzdhEdKNx7ftGdAw+/ogWrOvnk1A+cBD9iLO3D87NgLCxDc7F3tvvgmbizhif2L56MvMwOzveldxEYgdXOg7ZPxEYB25G
X-Gm-Message-State: AOJu0Yzqyu49LEoYDUz7XH+ELxnQdRZ/HX4y7JCcHvrfAcoHz3V0hHwU
	vTYofcgZZVjzcyX+rbvLXzdnVVDqhv00tbJFjKdEBsNqPENRdwDCAYbw/KuYvGH1Q+TwiBgf2uo
	qH2MPeK92kKtTWWziZ0NvE3NecOdDlHjgsi+IB/Wktfo2kfNKKbNSAfG4pR8fOA==
X-Received: by 2002:a50:a411:0:b0:566:47ee:b8b4 with SMTP id u17-20020a50a411000000b0056647eeb8b4mr1225108edb.17.1709293990834;
        Fri, 01 Mar 2024 03:53:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE1vmpvGelrIAwSR9YtmqYMH53YWKi9ocFIRHHKWtTOAKDOP50IotWgGwt5cBRTSNWEE/hvcg==
X-Received: by 2002:a50:a411:0:b0:566:47ee:b8b4 with SMTP id u17-20020a50a411000000b0056647eeb8b4mr1225097edb.17.1709293990541;
        Fri, 01 Mar 2024 03:53:10 -0800 (PST)
Received: from redhat.com ([2.52.158.48])
        by smtp.gmail.com with ESMTPSA id d18-20020a056402001200b00566d43ed4dasm439183edu.68.2024.03.01.03.53.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 03:53:09 -0800 (PST)
Date: Fri, 1 Mar 2024 06:53:05 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: wangyunjian <wangyunjian@huawei.com>
Cc: Paolo Abeni <pabeni@redhat.com>,
	"willemdebruijn.kernel@gmail.com" <willemdebruijn.kernel@gmail.com>,
	"jasowang@redhat.com" <jasowang@redhat.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"bjorn@kernel.org" <bjorn@kernel.org>,
	"magnus.karlsson@intel.com" <magnus.karlsson@intel.com>,
	"maciej.fijalkowski@intel.com" <maciej.fijalkowski@intel.com>,
	"jonathan.lemon@gmail.com" <jonathan.lemon@gmail.com>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	xudingke <xudingke@huawei.com>, "liwei (DT)" <liwei395@huawei.com>
Subject: Re: [PATCH net-next v2 3/3] tun: AF_XDP Tx zero-copy support
Message-ID: <20240301065141-mutt-send-email-mst@kernel.org>
References: <1709118356-133960-1-git-send-email-wangyunjian@huawei.com>
 <7d478cb842e28094f4d6102e593e3de25ab27dfe.camel@redhat.com>
 <223aeca6435342ec8a4d57c959c23303@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <223aeca6435342ec8a4d57c959c23303@huawei.com>

On Fri, Mar 01, 2024 at 11:45:52AM +0000, wangyunjian wrote:
> > -----Original Message-----
> > From: Paolo Abeni [mailto:pabeni@redhat.com]
> > Sent: Thursday, February 29, 2024 7:13 PM
> > To: wangyunjian <wangyunjian@huawei.com>; mst@redhat.com;
> > willemdebruijn.kernel@gmail.com; jasowang@redhat.com; kuba@kernel.org;
> > bjorn@kernel.org; magnus.karlsson@intel.com; maciej.fijalkowski@intel.com;
> > jonathan.lemon@gmail.com; davem@davemloft.net
> > Cc: bpf@vger.kernel.org; netdev@vger.kernel.org;
> > linux-kernel@vger.kernel.org; kvm@vger.kernel.org;
> > virtualization@lists.linux.dev; xudingke <xudingke@huawei.com>; liwei (DT)
> > <liwei395@huawei.com>
> > Subject: Re: [PATCH net-next v2 3/3] tun: AF_XDP Tx zero-copy support
> > 
> > On Wed, 2024-02-28 at 19:05 +0800, Yunjian Wang wrote:
> > > @@ -2661,6 +2776,54 @@ static int tun_ptr_peek_len(void *ptr)
> > >  	}
> > >  }
> > >
> > > +static void tun_peek_xsk(struct tun_file *tfile) {
> > > +	struct xsk_buff_pool *pool;
> > > +	u32 i, batch, budget;
> > > +	void *frame;
> > > +
> > > +	if (!ptr_ring_empty(&tfile->tx_ring))
> > > +		return;
> > > +
> > > +	spin_lock(&tfile->pool_lock);
> > > +	pool = tfile->xsk_pool;
> > > +	if (!pool) {
> > > +		spin_unlock(&tfile->pool_lock);
> > > +		return;
> > > +	}
> > > +
> > > +	if (tfile->nb_descs) {
> > > +		xsk_tx_completed(pool, tfile->nb_descs);
> > > +		if (xsk_uses_need_wakeup(pool))
> > > +			xsk_set_tx_need_wakeup(pool);
> > > +	}
> > > +
> > > +	spin_lock(&tfile->tx_ring.producer_lock);
> > > +	budget = min_t(u32, tfile->tx_ring.size, TUN_XDP_BATCH);
> > > +
> > > +	batch = xsk_tx_peek_release_desc_batch(pool, budget);
> > > +	if (!batch) {
> > 
> > This branch looks like an unneeded "optimization". The generic loop below
> > should have the same effect with no measurable perf delta - and smaller code.
> > Just remove this.
> > 
> > > +		tfile->nb_descs = 0;
> > > +		spin_unlock(&tfile->tx_ring.producer_lock);
> > > +		spin_unlock(&tfile->pool_lock);
> > > +		return;
> > > +	}
> > > +
> > > +	tfile->nb_descs = batch;
> > > +	for (i = 0; i < batch; i++) {
> > > +		/* Encode the XDP DESC flag into lowest bit for consumer to differ
> > > +		 * XDP desc from XDP buffer and sk_buff.
> > > +		 */
> > > +		frame = tun_xdp_desc_to_ptr(&pool->tx_descs[i]);
> > > +		/* The budget must be less than or equal to tx_ring.size,
> > > +		 * so enqueuing will not fail.
> > > +		 */
> > > +		__ptr_ring_produce(&tfile->tx_ring, frame);
> > > +	}
> > > +	spin_unlock(&tfile->tx_ring.producer_lock);
> > > +	spin_unlock(&tfile->pool_lock);
> > 
> > More related to the general design: it looks wrong. What if
> > get_rx_bufs() will fail (ENOBUF) after successful peeking? With no more
> > incoming packets, later peek will return 0 and it looks like that the
> > half-processed packets will stay in the ring forever???
> > 
> > I think the 'ring produce' part should be moved into tun_do_read().
> 
> Currently, the vhost-net obtains a batch descriptors/sk_buffs from the
> ptr_ring and enqueue the batch descriptors/sk_buffs to the virtqueue'queue,
> and then consumes the descriptors/sk_buffs from the virtqueue'queue in
> sequence. As a result, TUN does not know whether the batch descriptors have
> been used up, and thus does not know when to return the batch descriptors.
> 
> So, I think it's reasonable that when vhost-net checks ptr_ring is empty,
> it calls peek_len to get new xsk's descs and return the descriptors.
> 
> Thanks

What you need to think about is that if you peek, another call
in parallel can get the same value at the same time.


> > 
> > Cheers,
> > 
> > Paolo
> 


