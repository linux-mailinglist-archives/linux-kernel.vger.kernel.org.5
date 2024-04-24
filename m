Return-Path: <linux-kernel+bounces-157342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 677B08B1015
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 18:39:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E871A288CD7
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 16:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC7D116C855;
	Wed, 24 Apr 2024 16:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="wz/QSYgQ"
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E3D3160862
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 16:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713976786; cv=none; b=WpQdnmPcLs9mc4td6XHjsacFrCDCHETJXACPhZv/GBZBzAu/agDeeB0upMKN95O/6QYEyJloUVL1R17uHBL6RvDbJ5bi0cnMUOpr7aEAmAEPSh6Qdio4Txpy1rntfSUuqIEmnKY9TgljtoDTmN1Q75TlDL2BZ3aijq/x9PJyp9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713976786; c=relaxed/simple;
	bh=cLz72/mfLLmu/T9GMaeMDoV/eY7VsWrqXcnk85OgNDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jPTbleM4friS9OwkMdjQI/x3jJLmaURK5m0AUzDByCpW2Q/0kAPFXJijc6byzXzR/eZgTMt1KtkSrSem32R2DKwkJ+bRJUfYmF+KGuQiqp4I3oPXFbWuWuL0bPb04v7jPrPEO/uAR+dpLRQ6+rW4BG+p5rGoTjkQC5DaLtrW6n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=wz/QSYgQ; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-5e4f79007ffso15864a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 09:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1713976784; x=1714581584; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PASo/dRgHX8j22tZvlPVkiBmGQk9V+5NF/jk1Eifqm8=;
        b=wz/QSYgQl5rz0XYlnApGTl42W2H7kvSKyBWnkmvVfUvtOXSQMBQ7LjEWTAo57VIY8p
         gh/jEl5YCo/3p+twLjvaP4bUSr9hZJhpAV1ACwfW8FfDR5u0Z4qxnfOlrtYzWRCNOOsV
         GUkiJ4+2kegCm6x/Uuj5E0ImX1DPOkZniqslg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713976784; x=1714581584;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PASo/dRgHX8j22tZvlPVkiBmGQk9V+5NF/jk1Eifqm8=;
        b=N/v27WMjlFxbXNQLq4yLt1oyJP6HWuWsVzIUzt7kS8JnD4j0ixHZx/9XEXLLRdxXTM
         TObUjBJtbIqx94q/dVDAMgv14uXyj4ZkHT9wcenvCXUL4qL4NwzVbXNjeLuE7Bs7ggiq
         LlPNxzD07xQw2k/1qx+RjnctEPDZ9NVZMpzjUercUok82LUBAH2IdFbLvtx5VQJGpD0g
         K0WMDrLeQm66Tj27Im4vs6WG5vUDDQiKfHpEGzdrHsApk4IcwWzdhn+J3GAzO1XGIo3Q
         ynpowimeFn8Z2w4wSZvhLkTJPnCLRLi8V9Pw9Rq1kfXxmulIu0s+1P5h/H0RJws4FiWs
         Q+DA==
X-Gm-Message-State: AOJu0Yxm1yNS5oAXQEFNo8Bf80IcqyeIrn36EwHwefBe6BgR3inQxuLF
	yg0qMBgAJ+9DgsmQRkB8FpWN96HCA+TCf3IYBN/U37lwmRGBU1JpVTBRQDbQtxU=
X-Google-Smtp-Source: AGHT+IGCDu+XcsaOpRX4x8SxgNOfdKQVN2qe3ye1vvGNrThMc4lGHjutBZN+ydvFYJcywxmFwAWP7g==
X-Received: by 2002:a05:6a21:1f27:b0:1a3:466d:d33 with SMTP id ry39-20020a056a211f2700b001a3466d0d33mr3162589pzb.9.1713976783611;
        Wed, 24 Apr 2024 09:39:43 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id ld2-20020a056a004f8200b006eaf43bbcb5sm11675694pfb.114.2024.04.24.09.39.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 09:39:43 -0700 (PDT)
Date: Wed, 24 Apr 2024 09:39:40 -0700
From: Joe Damato <jdamato@fastly.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, tariqt@nvidia.com,
	saeedm@nvidia.com, mkarsten@uwaterloo.ca, gal@nvidia.com,
	nalramli@fastly.com, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	"open list:MELLANOX MLX4 core VPI driver" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH net-next 3/3] net/mlx4: support per-queue statistics via
 netlink
Message-ID: <Zik1zCI9W9EUi13T@LQ3V64L9R2>
References: <20240423194931.97013-1-jdamato@fastly.com>
 <20240423194931.97013-4-jdamato@fastly.com>
 <Zig5RZOkzhGITL7V@LQ3V64L9R2>
 <20240423175718.4ad4dc5a@kernel.org>
 <ZiieqiuqNiy_W0mr@LQ3V64L9R2>
 <20240424072818.2c68a1ab@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240424072818.2c68a1ab@kernel.org>

On Wed, Apr 24, 2024 at 07:28:18AM -0700, Jakub Kicinski wrote:
> On Tue, 23 Apr 2024 22:54:50 -0700 Joe Damato wrote:
> > On Tue, Apr 23, 2024 at 05:57:18PM -0700, Jakub Kicinski wrote:
> > > On Tue, 23 Apr 2024 12:42:13 -1000 Joe Damato wrote:  
> > > > I realized in this case, I'll need to set the fields initialized to 0xff
> > > > above to 0 before doing the increments below.  
> > > 
> > > I don't know mlx4 very well, but glancing at the code - are you sure we
> > > need to loop over the queues is the "base" callbacks?
> > > 
> > > The base callbacks are for getting "historical" data, i.e. info which
> > > was associated with queues which are no longer present. You seem to
> > > sweep all queues, so I'd have expected "base" to just set the values 
> > > to 0. And the real values to come from the per-queue callbacks.  
> > 
> > Hmm. Sorry I must have totally misunderstood what the purpose of "base"
> > was. I've just now more closely looked at bnxt which (maybe?) is the only
> > driver that implements base and I think maybe I kind of get it now.
> > 
> > For some reason, I thought it meant "the total stats of all queues"; I didn't
> > know it was intended to provide "historical" data as you say.
> > 
> > Making it set everything to 0 makes sense to me. I suppose I could also simply
> > omit it? What do you think?
> 
> The base is used to figure out which stats are reported when we dump 
> a summary for the whole device. So you gotta set them to 0.

OK, thanks for your patience and the explanation. Will do.

> > > The init to 0xff looks quite sus.  
> > 
> > Yes the init to 0xff is wrong, too. I noticed that, as well.
> > 
> > Here's what I have listed so far in my changelog for the v2 (which I haven't
> > sent yet), but perhaps the maintainers of mlx4 can weigh in?
> > 
> > v1 -> v2:
> >  - Patch 1/3 now initializes dropped to 0.
> >  - Patch 3/3 includes several changes:
> >    - mlx4_get_queue_stats_rx and mlx4_get_queue_stats_tx check if i is
> >      valid before proceeding.
> >    - All initialization to 0xff for stats fields has been omit. The
> >      network stack does this before calling into the driver functions, so
> >      I've adjusted the driver functions to only set values if there is
> >      data to set, leaving the network stack's 0xff in place if not.
> >    - mlx4_get_base_stats sets all stats to 0 (no locking etc needed).
> 
> All the ones you report right? Not just zero the struct.
> Any day now (tm) someone will add a lot more stats to the struct
> so the init should be selective only to the stats that are actually
> supported.

Yes, not just zero the struct. Since I am reporting bytes packets for both
RX and TX and alloc_fail for RX I'll be setting those fields to 0
explicitly.

And there's also a warning about unused qtype (oops) in patch 2/3.

So, the revised v2 list (pending anything Mellanox wants) is:

  v1 -> v2:
   - Patch 1/3 now initializes dropped to 0.
   - Patch 2/3 fix use of unitialized qtype warning.
   - Patch 3/3 includes several changes:
     - mlx4_get_queue_stats_rx and mlx4_get_queue_stats_tx check if i is
       valid before proceeding.
     - All initialization to 0xff for stats fields has been omit. The
       network stack does this before calling into the driver functions, so
       I've adjusted the driver functions to only set values if there is
       data to set, leaving the network stack's 0xff in place if not.
     - mlx4_get_base_stats set all stat fields to 0 individually (no locking etc needed).

I'll hold off on sending this v2 until we hear back from Mellanox to be
sure there isn't anything else I'm missing.

> > Let me know if that sounds vaguely correct?
> > 
> > > Also what does this:
> > >   
> > > >	if (!priv->port_up || mlx4_is_master(priv->mdev->dev))  
> > > 
> > > do? 🤔️ what's a "master" in this context?  
> > 
> > I have a guess, but I'd rather let the Mellanox folks provide the official
> > answer :)
> 
> My guess is that on multi-port only one of the netdevs is "in charge"
> of the PCIe function. But these are queue stat, PCIe ownership may
> matter for refresh but not for having the stats. So my guess must be
> wrong..
>
> > > > Sorry about that; just realized that now and will fix that in the v2 (along
> > > > with any other feedback I get), probably something:
> > > > 
> > > >   if (priv->rx_ring_num) {
> > > >           rx->packets = 0;
> > > >           rx->bytes = 0;
> > > >           rx->alloc_fail = 0;
> > > >   }
> > > > 
> > > > Here for the RX side and see below for the TX side.  
> > > 
> > > FWIW I added a simple test for making sure queue stats match interface
> > > stats, it's tools/testing/selftests/drivers/net/stats.py
> > > 
> > > You have to export NETIF=$name to make it run on a real interface.
> > > 
> > > To copy the tests to a remote machine I do:
> > > 
> > > make -C tools/testing/selftests/ TARGETS="net drivers/net drivers/net/hw" install INSTALL_PATH=/tmp/ksft-net-drv
> > > rsync -ra --delete /tmp/ksft-net-drv root@${machine}:/root/
> > > 
> > > HTH  
> > 
> > Thanks, this is a great help actually.
> > 
> > I have a similar changeset for mlx5 (which is hardware I do have access to)
> > that adds the per-queue stats stuff so I'll definitely give your test a try.
> > 
> > Seeing as I made a lot of errors in this series, I'll hold off on sending the
> > mlx5 series until this mlx4 series is fixed and accepted, that way I can
> > produce a much better v1 for mlx5.
> 
> mlx5 would be awesome! But no pressure on sending ASAP. I was writing a
> test for page pool allocation failures, which depends on qstat to check
> if driver actually saw the errors (I'll send it later today), and I
> couldn't confirm it working on mlx5 :(

My hesitation with sending mlx5 changes is that I didn't want to add more
noise than I already have with my existing errors. I figured by getting
mlx4 working/accepted I'd know enough about the API to send a much better
v1 for mlx5 reducing the work for you (and everyone else) involved.

FWIW, I also attempted to implement this API for i40e (hardware I also
have):

  https://lore.kernel.org/lkml/20240410043936.206169-1-jdamato@fastly.com/

But there are some complications I haven't resolved, so I'm focusing on
mlx4 and mlx5, first, and will have to come back to i40e later.

