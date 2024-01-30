Return-Path: <linux-kernel+bounces-44401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B4E2C842194
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 11:40:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3B7E1C23B0A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 10:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FCAA6772A;
	Tue, 30 Jan 2024 10:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="TZ+ywgeB"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B6767738
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 10:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706611115; cv=none; b=hizwd/hIGuMYrdzgJs38o6u13HlOshCxVZmFPWLEHI+A+wVTGxDkxfT4xGhxHaxUhniAVATuUboAz+D395E0v4bjSTptESI9fQi64mKdgYUkWU9483kUwMWTMQCMVLEGqus1lYVq6nnon50uzXYBUtPgPJ8EQkmyGyLrpg02Z70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706611115; c=relaxed/simple;
	bh=Rbz9gj7SWvKjQvNWypj1WHOC09q5BYK2I/4yT2gVIKc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tPFrMFvDZo8B5qhisMfa1qMcMZPMIjg4MirfPUjN+Hi9nRV59onhLaD8mQNEYNri+KMkrenCBRBjdm81fQEYDO34DjpHYfBqMRedqgwqqafYKYOrJvhJTY+xep7rkvSex7XJFeSvu1E4gasyfefR9cSTq/YVD1Fa5EWqvJ0bGDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=TZ+ywgeB; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a30e898db99so88509566b.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 02:38:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1706611111; x=1707215911; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=q0DpHsp78524WTcdq3ZlObN34BwE3mZw0kMPMavoOX4=;
        b=TZ+ywgeBFov0eY4lqjuWu7c8zxZvBaPNG9hGHl5zPmEZ0lqCo7KulopPY6LNnwZVnQ
         vlGBLH0rXKR6RxaB5ZAeQzQXi0Gp2a8vcNfd2knvnKTHx8RSfgcZ6Q8NoVp1H6k2Go/Z
         EY5zGz+yH8Qbf/45Cd8g5U43Yik4HtXPY6+DU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706611111; x=1707215911;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q0DpHsp78524WTcdq3ZlObN34BwE3mZw0kMPMavoOX4=;
        b=HblXaNmKAFdGkvV5MmpdrNf/4KC25+Qn/KfSUY/tAFgEzIge0kPXEP+K+b1R6VywOH
         APcpk5ZT69zRzCqAI0WuZNdnAKJQt7TdYAR5kwMDR9IsgURtmA60fIjvZyBtIgpssuWD
         db8Z2yn2xsN2WdNKXDaUCf1IWk2aQYqumR7beddIiXaa75OuDGEEryi8nzQfr1oowSz0
         EvPdAG3710/NHemnfUFKheD8FF1YOhJ+KmM35NB6HK757LfOXkthVg+sUiqBF40GPwMv
         MV3ullVE7C8FM8aJ0XuTk8SHZ5Y45tql3+Y2j6ed8y7+DnAlseE2uE76kXRF3kCICCtW
         Em0w==
X-Forwarded-Encrypted: i=0; AJvYcCWiD5evcspHuftfwkaFpzZ4zvxMUbO4DmeOaCFxo/98SCMorjn0RuYm/Sbq0JCe9/kYVAwk6MLDo2fiE31eFWF++wnTgjMB5zEDAohV
X-Gm-Message-State: AOJu0YwH/+UUFimDUJZbWF3pG3U034CYGJBbsPDvU/Ui+nkFEZ2Z33dt
	PJhAh72diFzRim+7jL6oz8VEX5KhltOIo5r6WdsQH+tmu7GxYYdxaxjUNZed+y0=
X-Google-Smtp-Source: AGHT+IGOdGiExTeKnmBCfXOvsiugsDOp4x/n9iwmfZrcr5SM95YNybe4aCyt7LzfW61YerkaMsSHkg==
X-Received: by 2002:a17:906:c0c6:b0:a34:4c5e:40db with SMTP id bn6-20020a170906c0c600b00a344c5e40dbmr6071192ejb.4.1706611111218;
        Tue, 30 Jan 2024 02:38:31 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id cx1-20020a170907168100b00a354d25da36sm3704061ejd.83.2024.01.30.02.38.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 02:38:30 -0800 (PST)
Date: Tue, 30 Jan 2024 11:38:28 +0100
From: Daniel Vetter <daniel@ffwll.ch>
To: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Cc: Paul Cercueil <paul@crapouillou.net>,
	Christian =?iso-8859-1?Q?K=F6nig?= <ckoenig.leichtzumerken@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <noname.nuno@gmail.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	linux-usb@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [Linaro-mm-sig] Re: [PATCH v5 1/6] dma-buf: Add
 dma_buf_{begin,end}_access()
Message-ID: <ZbjRpDemivdBJaSN@phenom.ffwll.local>
Mail-Followup-To: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Paul Cercueil <paul@crapouillou.net>,
	Christian =?iso-8859-1?Q?K=F6nig?= <ckoenig.leichtzumerken@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <noname.nuno@gmail.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	linux-usb@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
	Christoph Hellwig <hch@lst.de>
References: <e4620acdf24628d904cedcb0030d78b14559f337.camel@crapouillou.net>
 <85a89505-edeb-4619-86c1-157f7abdd190@amd.com>
 <0fe2755fb320027234c086bcc88fd107855234c5.camel@crapouillou.net>
 <577501f9-9d1c-4f8d-9882-7c71090e5ef3@amd.com>
 <7928c0866ac5b2bfaaa56ad3422bedc9061e0f7b.camel@crapouillou.net>
 <2ac7562c-d221-409a-bfee-1b3cfcc0f1c6@amd.com>
 <ZbKiCPhRvWaz4Icn@phenom.ffwll.local>
 <c97e38ee-b860-4990-87f1-3e59d7d9c999@amd.com>
 <Zbi6zQYtnfOZu5Wh@phenom.ffwll.local>
 <a2346244-e22b-4ff6-b6cd-1da7138725ae@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a2346244-e22b-4ff6-b6cd-1da7138725ae@amd.com>
X-Operating-System: Linux phenom 6.6.11-amd64 

On Tue, Jan 30, 2024 at 10:23:03AM +0100, Christian König wrote:
> Am 30.01.24 um 10:01 schrieb Daniel Vetter:
> > On Fri, Jan 26, 2024 at 05:42:50PM +0100, Christian König wrote:
> > > [SNIP]
> > > Well I think we should have some solution, but I'm not sure if it should be
> > > part of DMA-buf.
> > > 
> > > Essentially a DMA-buf exports the buffers as he uses it and the importer (or
> > > the DMA-buf subsystem) is then the one who says ok I can use this or I can't
> > > use this or I need to call extra functions to use this or whatever.
> > > 
> > > It's not the job of the exporter to provide the coherency for the importer,
> > > cause otherwise we would have a lot of code in the exporter which can only
> > > be tested when you have the right importer around. And I strongly think that
> > > this is a no-go for having a reliable solution.
> > The trouble is, that if you have other memory than stuff allocated by the
> > dma-api or mapped using the dma-api, then by necessity the exporter has to
> > deal with this.
> 
> Yes, I was thinking about that as well.
> 
> > Which is the exact same reason we also force the exporters to deal with
> > the cpu cache flushing - you're argument that it's not great to replicate
> > this everywhere holds there equally.
> 
> And I'm not really happy with that either.
> 
> > The other thing is that right now the exporter is the only one who
> > actually knows what kind of dma coherency rules apply for a certain piece
> > of memory. E.g. on i915-gem even if it's dma_map_sg mapped the underlying
> > i915-gem buffer might be non-coherent, and i915-gem makes it all work by
> > doing the appropriate amount of clflush.
> 
> Yeah, exactly that's the reason why I think that this stuff doesn't belong
> into exporters/drivers.
> 
> Looking at what kind of hacks and workarounds we have in both amdgpu as well
> as i915 it's pretty clear that we need to improve this design somehow.

Yeah it's been a well-known issue, and we've very slowly improved things.

> > Similar funky things happen in other cases.
> > 
> > So unless we add an interface which allows importers to figure out how
> > much flushing is needed, currently the exporter is the only one who knows
> > (because it can inspect the struct device at dma_buf_attach time).
> > 
> > We could flip this around, but it would be a rather serious depature from
> > the dma-buf design approach thus far.
> 
> Well clients already give the DMA-direction to exporters when creating the
> mapping and get an appropriate sg_table in return.
> 
> All we need to do is getting the information what flushing is needed into
> the object returned here so that the DMA API can work with it.

So the problem is that we can provide this information from exporters that
do device specific stuff. But we cannot get this information from
exporters which just use the dma-api, whether it's dma_alloc or
dma_map_sg, because the core design principle of the dma-api is to hide
the coherency rules for device dma.

The idea is that you have the same ip on different socs, where on one the
soc needs cache flushing and on the other you dont (because different
architecture, or just the ip being connected to different interconnects),
you can use the exact same driver since the dma-api hides all this.

And at least every time it was discussed in the past, dma-api maintainers
insisted that we don't break this abstraction rule. Which means for most
exporters, we simply do not have this information available. This is also
why after epic long discussions it was decided that cache coherency was
the exporter's problem, so that from an importer pov there's no difference
between an sg list optained through dma_buf_map and an sg list obtained
from dma_map_sg or memory allocated with dma_alloc - in none of these
cases does the driver have to do its own cache management.

> Christoph Hellwig pretty much nailed it when he said that the problem with
> the sg_table is that it mixes input and output parameters of the DMA-API.

Hm my take away from these discussions was that sg as a data structure is
not a clean design, but I haven't ever seen Christoph (or anyone else from
the dma-api side) say that they're ok with leaking cache coherency
management to clients.

We couldn't even get the core arch primitives exported to drivers so that
dma-buf exporters could do the right cache management for their driver
specific allocators that entirely bypass the dma-api. I think what you're
suggesting would go way beyond that.

> I would extend that and say that we need a mapping object the DMA-API can
> work with so that it can know what needs to be done when devices request
> that data is made coherent between them or the CPU.

Personally I do think it makes sense as a design and iirc we discussed it
plenty in the early dma-buf discussions. I just don't think it's a
realistic design approach to upstream.

I think best we can hope for is a new set of device2device sync functions
in the dma_sg_sync_for* family of functions, so that on platforms where
syncing for cpu access requires cache flushes, but going from one device
to the next doesn't we could avoid some unecessary flushing. Currently
there's no way to do that and we have to pessimistically flush for cpu
coherency with the dma-api. Or suffer from device2device coherency issues
on funky platforms.

> > > That's why I think the approach of having DMA-buf callbacks is most likely
> > > the wrong thing to do.
> > > 
> > > What should happen instead is that the DMA subsystem provides functionality
> > > which to devices which don't support coherency through it's connection to
> > > say I want to access this data, please make sure to flush the appropriate
> > > catches. But that's just a very very rough design idea.
> > > 
> > > This will become more with CXL at the horizon I think.
> > Yeah CXL will make this all even more fun, but we are firmly there already
> > with devices deciding per-buffer (or sometimes even per-access with
> > intel's MOCS stuff) what coherency mode to use for a buffer.
> > 
> > Also arm soc generally have both coherent and non-coherent device
> > interconnects, and I think some devices can switch with runtime flags too
> > which mode they use for a specific transition.
> > 
> > CXL just extends this to pcie devices.
> > 
> > So the mess is here, how do we deal with it?
> 
> I would say we start with the DMA-API by getting away from sg_tables to
> something cleaner and state oriented.

Imo that's a tangential distraction. Definitely would be great to untangle
that data structure, but I don't think that gets us any closer to getting
the coherency information out of the dma-api abstraction that we'd like to
have.

That part has been an extremely firm "no" every time we asked.

> > My take is that the opt-in callback addition is far from great, but it's
> > in line with how we extended dma-buf the past decade plus too. So unless
> > someone's volunteering to pour some serious time into re-engineering this
> > all (including testing all the different device/driver<->device/driver
> > interactions) I think there's only really one other option: To not support
> > these cases at all. And I don't really like that, because it means people
> > will hack together something even worse in their drivers.
> > 
> > By adding it to dma-buf it'll stare us in our faces at least :-/
> 
> Yeah, it's the way of the least resistance. But with CXL at the horizon and
> more and more drivers using it I think it's predictable that this will
> sooner or later blow up.

I know, it's kinda been blowing up already.

My prediction is that the best we can get out of the dma-api is a new
device2device sync, while all the coherency details are still 100% hidden
behind the dma-api. And even that is probably going to take years.

Cheers, Sima
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

