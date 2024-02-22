Return-Path: <linux-kernel+bounces-77294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17C9186036B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 21:03:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C31361F25183
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 20:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55BEA6E5EA;
	Thu, 22 Feb 2024 20:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S21aCnUn"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39EC85491B
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 20:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708632172; cv=none; b=QcuWhHlKNx8/l35JImQ5e5maJ35GbJbSOTw8LmvNJosfjqq6sTjrvWYwdGjmOlAeiJXet6Dpyp117LHFkg9tl5ANnlBSFh0FYBoItWxaIVPTzKHMqU8xy7bZk8k+ur6xTjCdmYzlweT4+NxW9r0PKB38m9ZWA7bzHOupG5fVSSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708632172; c=relaxed/simple;
	bh=aknFNqqxJry03mMtGqJFoI/wKDCcG2OQaTtQxGeRRpc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k02KehHdSFBAMbgsbL+7RTLQjyMmloA2wdd5Wo35HzKvrfM1TD9iwEYgstzpY43E4W/EA7hs5nKdYgDIJik3nuvni0Es+N7nfE2zcYyZl0QraUVo93vjxv500TN7H0c9ZZwUE8ZiN6aYiiyP4zblwuC3R7llu3tvmyxK2/JHPaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S21aCnUn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708632170;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ip/bb26cz2+ipekHalCr5lDscUM2updhLQwbQoyojpM=;
	b=S21aCnUn86z6lXnROnz6zQFhwE5wuDStvNT1sCROM2Z70fZqVSHvuHIrAyFWq/7YiVjccF
	DbAlzjUedDj3lydIfnqqEEZgYiNYBuF/fLPWms0Cc4+kRlj7OaGOL0PoLRX3Trg7IEuhLu
	DLDebTY9YWvPMDA6dbJSn9CbZmBNj/0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-608-s56VkiN_Mom4TVbT7bVcQA-1; Thu, 22 Feb 2024 15:02:48 -0500
X-MC-Unique: s56VkiN_Mom4TVbT7bVcQA-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4121ac8634aso370055e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 12:02:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708632167; x=1709236967;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ip/bb26cz2+ipekHalCr5lDscUM2updhLQwbQoyojpM=;
        b=GYYXmglAVFN8cEjTzpWKQkGUNbJG0wEwERvAcW1+5tCcttu6tQ1m+jKJHTyIZ5eyzN
         JLwJ7fgwCLjebFsDeWOFrwExD0ulM0L0jQSqpaFrEOkoKE5GSayQD1ooDOjedubzwa6V
         l8ylSDb4PMsICoxEaj9Mldxjef6QZ+8s0tcRs6dV4/oMDC8SFsH/5omtJfa4QhnCXt6P
         FVYASaOZg/alWF8A5v78SkOQAYPXllxmUoNU9ujZmG4YxdZWcwBWURWF74OAc3jr6zqF
         a2fiUqKguI1YKDyFpbx73K/qfffQ/ru1DQEy8Gz1QZfPE5U/sGrNFsJdCavMjGVXN3Xx
         CS0w==
X-Forwarded-Encrypted: i=1; AJvYcCUDwCPxCgPmHrPd9xz3x0k4nBslq9Nmqas+JjM2oO+mCRiHPZO6Jv6bq6RZnwpkIo8bNpteI3/14jARy7T3N3rNDu8YV3Va1mzoOdCy
X-Gm-Message-State: AOJu0Yz138AiDujQvSqVbRtjt1PyhmWKbAZgK/3KbchsKDIKqHruaYSS
	rDGAOr+1m4ClWdutT6s88f58/A8niZpmyxV+jQxP0lwWZbHOpiZGBhb+4l+6YWWfroL+obkjxLm
	ZFc1iOJuihClFv5WzMHzUxOxNrlcUbH82dUAkc3lAbmEoeOBSyx8nTC+smBVKog==
X-Received: by 2002:a5d:480d:0:b0:33d:9d4a:b28 with SMTP id l13-20020a5d480d000000b0033d9d4a0b28mr114027wrq.18.1708632167135;
        Thu, 22 Feb 2024 12:02:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFGY5xEB+oirt/8WYolwR+t/b3r7Lw8iYBr645QsLpjupov8MKzMLmF73APkFMsTjyAiTEk6A==
X-Received: by 2002:a5d:480d:0:b0:33d:9d4a:b28 with SMTP id l13-20020a5d480d000000b0033d9d4a0b28mr114007wrq.18.1708632166787;
        Thu, 22 Feb 2024 12:02:46 -0800 (PST)
Received: from redhat.com ([172.93.237.99])
        by smtp.gmail.com with ESMTPSA id bi21-20020a05600c3d9500b004128808db91sm3049224wmb.23.2024.02.22.12.02.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 12:02:46 -0800 (PST)
Date: Thu, 22 Feb 2024 15:02:39 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Andrew Melnychenko <andrew@daynix.com>
Cc: jasowang@redhat.com, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, yuri.benditovich@daynix.com,
	yan@daynix.com
Subject: Re: [PATCH 1/1] vhost: Added pad cleanup if vnet_hdr is not present.
Message-ID: <20240222150212-mutt-send-email-mst@kernel.org>
References: <20240115194840.1183077-1-andrew@daynix.com>
 <20240115172837-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240115172837-mutt-send-email-mst@kernel.org>

On Mon, Jan 15, 2024 at 05:32:25PM -0500, Michael S. Tsirkin wrote:
> On Mon, Jan 15, 2024 at 09:48:40PM +0200, Andrew Melnychenko wrote:
> > When the Qemu launched with vhost but without tap vnet_hdr,
> > vhost tries to copy vnet_hdr from socket iter with size 0
> > to the page that may contain some trash.
> > That trash can be interpreted as unpredictable values for
> > vnet_hdr.
> > That leads to dropping some packets and in some cases to
> > stalling vhost routine when the vhost_net tries to process
> > packets and fails in a loop.
> > 
> > Qemu options:
> >   -netdev tap,vhost=on,vnet_hdr=off,...
> > 
> > Signed-off-by: Andrew Melnychenko <andrew@daynix.com>
> > ---
> >  drivers/vhost/net.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> > index f2ed7167c848..57411ac2d08b 100644
> > --- a/drivers/vhost/net.c
> > +++ b/drivers/vhost/net.c
> > @@ -735,6 +735,9 @@ static int vhost_net_build_xdp(struct vhost_net_virtqueue *nvq,
> >  	hdr = buf;
> >  	gso = &hdr->gso;
> >  
> > +	if (!sock_hlen)
> > +		memset(buf, 0, pad);
> > +
> >  	if ((gso->flags & VIRTIO_NET_HDR_F_NEEDS_CSUM) &&
> >  	    vhost16_to_cpu(vq, gso->csum_start) +
> >  	    vhost16_to_cpu(vq, gso->csum_offset) + 2 >
> 
> 
> Hmm need to analyse it to make sure there are no cases where we leak
> some data to guest here in case where sock_hlen is set ...


Could you post this analysis pls?

> > -- 
> > 2.43.0


